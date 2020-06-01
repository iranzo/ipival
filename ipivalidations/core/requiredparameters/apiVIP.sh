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

# long_name: Checks provisioningNetworkInterface defined in inventory file
# description: Checks for required parameters
# priority: 900
# bugzilla:

# Load common functions
[[ -f "${CITELLUS_BASE}/common-functions.sh" ]] && . "${CITELLUS_BASE}/common-functions.sh"

FILE="${CITELLUS_ROOT}/inventory"
is_mandatory_file ${FILE}

for config in apiVIP; do
    if ! is_lineinfile "^${config}" ${FILE}; then
        echo "Missing option ${config} for ${FILE}" >&2
        flagboot=1
    fi
done

for check in flagboot; do
    if [[ $(set | grep ^${check} | cut -d "=" -f2) != "0" ]]; then
        exit ${RC_FAILED}
    fi
done

exit ${RC_OKAY}
