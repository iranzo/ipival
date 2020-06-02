#!/bin/bash
# Copyright (C) 2020 Pablo Iranzo Gómez <Pablo.Iranzo@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# long_name: Checks if cache is enabled or not defined in inventory file
# description: Checks for required parameters
# priority: 900
# bugzilla:

# Load common functions
[[ -f "${CITELLUS_BASE}/common-functions.sh" ]] && . "${CITELLUS_BASE}/common-functions.sh"

FILE="${CITELLUS_ROOT}/inventory"
is_mandatory_file ${FILE}

for config in cache_enabled; do
    if ! is_lineinfile "^${config}" ${FILE}; then
        echo "It's recommended to set cache_enabled = True to improve performance" >&2
        exit ${RC_INFO}
    fi
    if is_lineinfile "^${config}" ${FILE}; then
        VALUE=$(grep ^${config} ${FILE} | cut -d "=" -f 2- | tr -d " " | tr [:upper:] [:lower:])
        if [[ ${VALUE} == 'false' ]]; then
            echo "It's recommended to set cache_enabled = True to improve performance" >&2
            exit ${RC_INFO}
        fi
    fi
done

exit ${RC_OKAY}
