Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB07C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4943A10E30E;
	Sat,  5 Sep 2026 18:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="huXoj8Ko";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79F010E30E
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:22:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE5D1601FB;
 Sat,  5 Sep 2026 18:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5921F00A3A;
 Sat,  5 Sep 2026 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632545;
 bh=46gP2RehiyNqXA7iFIMI5HmwcMbst7lRXH4J3tH9d/w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=huXoj8KoBSYKjDTPlnYANjx4KXXCp7giBFKvvea61QhAK59aYgPMZYg0kO6ud7sdE
 0OVQlRd0Mkv+4Ixa9vqxzZfflzG2w7ibGfz4c/+M9csGz9pv10NSFcS9DEbXC61YX9
 Y7S//SdGYaF/N5Y4ojWqL4V072m248qCKQBSjS3jPyIQRY9uJaeL3D6n6iQFJ/apMs
 VGSVRy9mO3/jbg/V5iml62Sww57B9Z5Q41iiPFy03F1EVkkNMoN14tZUqU5erSJqhn
 PeFA4kMxG1cegzg88MS189vuVZ/4A3Bs7WtZWORarJnxUY1dLEW1WrUYnPnPE4vXVJ
 dOJ8rfpYYB40w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/43] selftests/dyndbg: Add kselftest script to
 verify dynamic-debug
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-1-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-1-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:22:25 +0000
Message-Id: <20260905182225.7D5921F00A3A@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability due to deletin=
g and appending to securely created temporary files.
- [Medium] The test script swallows the actual command error output and pri=
nts an undefined variable.
- [Medium] Cryptographic hash verification of core kernel files makes the s=
elftest overly brittle.
- [Medium] The silent soft-pass mode (`K=3D2`) does not exit successfully a=
s documented, falling through to a failure.
- [Medium] The `LACK_DD_BUILTIN` filter in `GOLDEN_RECORDS` is broken becau=
se it queries a non-existent 4th column.
- [Low] The strict-mode environment variable `K` is used in arithmetic eval=
uations without sanitization.
- [Low] The `ifrmmod` function is identically defined twice in the script.
--

commit 21ef8019906e22cad30ff587de97850e4985eee2
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Add kselftest script to verify dynamic-debug

Adds a kselftest script to attempt full validation of dynamic-debug behavio=
r.
The script tests query grammar as documented, responses to bad input, and
proper/expected effects on both the control-file display of current state,
and on pr_debug logging behavior using a hash-based verification mechanism.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> new file mode 100755
> index 0000000000000..67b568730acc6
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> @@ -0,0 +1,770 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Standard kselftest exit codes
> +ksft_pass=3D0
> +ksft_fail=3D1
> +ksft_skip=3D4
> +
> +ESC=3D$'\033'
> +RED=3D"${ESC}[0;31m"
> +GREEN=3D"${ESC}[0;32m"
> +YELLOW=3D"${ESC}[0;33m"
> +BLUE=3D"${ESC}[0;34m"
> +MAGENTA=3D"${ESC}[0;35m"
> +CYAN=3D"${ESC}[0;36m"
> +NC=3D"${ESC}[0;0m"
> +# Environment Controls:
> +#   V=3D0,1,2 : Verbosity (0=3Dconcise summary, 1=3Dverified assertions,=
 2=3Dfull captured outputs)
> +#   K=3D0     : Strict mode (fails with exit 1 on checksum drift or stal=
e records)
> +#   K=3D1     : Soft-pass mode (prints DRIFT/STALE diffs, exits 0 with '=
fake success')
> +#   K=3D2     : Silent soft-pass mode (suppresses DRIFT/STALE diffs, exi=
ts 0 with 'fake success')
> +V=3D${V:=3D0}
> +K=3D${K:=3D0}
> +
> +# Sanitize V to ensure it is a valid integer
> +if [[ ! "$V" =3D~ ^[0-9]+$ ]]; then

[Severity: Low]
Is there a reason the K variable is not sanitized here similarly to V? If a
non-numeric string is provided for K, bash will throw an "integer expression
expected" error when it evaluates K in arithmetic conditions later in the
script.

[ ... ]

> +function ifrmmod {
> +    [ "${LACK_TMOD:-0}" -eq 1 ] && return
> +    grep -q "^$1 " /proc/modules 2>/dev/null && rmmod $1
> +}
> +
> +# Clean up any leftover loaded test modules at initialization
> +ifrmmod test_dynamic_debug_submod
> +ifrmmod test_dynamic_debug

[ ... ]

> +function ifrmmod {
> +    [ "${LACK_TMOD:-0}" -eq 1 ] && return
> +    grep -q "^$1 " /proc/modules 2>/dev/null && rmmod $1
> +}

[Severity: Low]
Does this function need to be re-declared here? It appears to be an exact
duplicate of the ifrmmod definition from earlier in the script.

[ ... ]

> +function ddcmd () {
> +    # ddcmd <query_args> [range_pattern] [pass|fail|log]
> +    local args=3D"$1"
> +    local range=3D"$2"
> +    local action=3D"${3:-pass}"
> +    local exp_exit=3D0
> +
> +    [ "$action" =3D "fail" ] && exp_exit=3D1
> +    log_ddcmd "$args"
> +
> +    # Update cumulative state-machine lineage
> +    if [[ "$args" =3D=3D *"=3D_"* ]]; then
> +        CUMULATIVE_DDCMDS=3D"$args"
> +    else
> +        CUMULATIVE_DDCMDS=3D"${CUMULATIVE_DDCMDS}; $args"
> +    fi
> +
> +    [ "$action" !=3D "pass" ] && log_start
> +    [ -n "$range" ] && capture_before "$range"
> +
> +    output=3D$( (echo "$args" > /proc/dynamic_debug/control) 2>&1 )
> +    handle_exit_code $BASH_LINENO $FUNCNAME $? $exp_exit

[ ... ]

> +function handle_exit_code() {
> +    local exp_exit_code=3D0
> +    [ $# =3D=3D 4 ] && exp_exit_code=3D$4
> +    if [ "$3" -ne $exp_exit_code ]; then
> +        echo -e "${RED}: $BASH_SOURCE:$1 $2() " \
> +            "expected to exit with code $exp_exit_code, got $3${NC}"
> +	[ "$3" =3D=3D 1 ] && echo "Error: '$error_msg'"

[Severity: Medium]
Is error_msg defined anywhere? It seems ddcmd captures the command output a=
nd
errors into the "output" variable, but handle_exit_code tries to print an
undeclared error_msg variable. This causes the script to print "Error: ''",
swallowing the actual error context needed for debugging test failures.

[ ... ]

> +function FT_basic_queries {
> +    v_echo "${GREEN}# BASIC_TESTS ${NC}"
> +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> +	echo "SKIP - test requires params, which is a builtin module"
> +	return
> +    fi
> +    ddcmd =3D_ # zero everything
> +
> +    ddcmd "module params +mf" 'kernel/params.c'
> +    ddcmd "module params +l"  'kernel/params.c'

[Severity: Medium]
Does hashing the exact output string representations of pr_debug statements=
 in
core files make the test unnecessarily brittle? Any routine upstream
modification to the format strings or logic in kernel/params.c will
unconditionally invalidate the static hash baselines here, causing CI failu=
res
even if the dynamic debug subsystem is functioning perfectly.

[ ... ]

> +function GOLDEN_RECORDS {
> +    cat << 'EOF' | {

[ ... ]

> +#K=3D de950a3e60669fdd58d0a8c2867a056d FT_basic_queries.5
> +#K=3D 2ff49f0c4d18ec99bcb1c30840fe8afc FT_basic_queries.6
> +#K=3D 9a1b13c32a15363dcf93913308edeea5 FT_basic_queries.7
> +EOF
> +        # Read the K-recs and skip those for tests that can't run
> +        while read -r line; do
> +            # Filter built-in if needed
> +            if [ "${LACK_DD_BUILTIN:-0}" -eq 1 ]; then
> +                # Extract pattern (4th field) from #K=3D line
> +                local pattern=3D$(echo "$line" | awk '{print $4}')
> +                if [[ "$pattern" =3D=3D *params* || "$pattern" =3D=3D *m=
ain* ]]; then

[Severity: Medium]
Is this correctly filtering the built-in test records? The lines mapped in
GOLDEN_RECORDS only contain 3 columns (e.g., "#K=3D <hash> <label>"). Becau=
se
there is no 4th column, the pattern variable will always be empty, causing =
the
filter to fail and allowing built-in tests to incorrectly execute on
unsupported configurations.

[ ... ]

> +# Clear any stale seen/unregistered/drifted hashes from previous runs
> +rm -f "$SEEN_HASHES_FILE" "$UNREG_HASHES_FILE" "$DRIFT_HASHES_FILE"

[Severity: High]
Could removing these temporary files introduce a local privilege escalation
or arbitrary file overwrite vulnerability?

These files are securely created by mktemp earlier, but explicitly removing
them before the test runs means that when the script appends to them later
(e.g., echo "$fingerprint" >> "$SEEN_HASHES_FILE"), bash will implicitly
recreate them without O_EXCL protection.

An attacker monitoring the temporary directory could create a symlink with
the deleted file's name before the script runs the append redirection,
allowing them to overwrite arbitrary files when the test executes as root.

[ ... ]

> +if [ -s "$DRIFT_HASHES_FILE" ]; then
> +    echo -e "${RED}\n# --- Drifted Baselines ---"
> +    cat "$DRIFT_HASHES_FILE"
> +    echo -e "# -------------------------${NC}"
> +    rm -f "$DRIFT_HASHES_FILE"
> +    failed=3D1
> +fi
> +
> +# Cleanup
> +rm -f "$UNREG_HASHES_FILE" "$DRIFT_HASHES_FILE"
> +
> +if [ $failed -eq 1 ]; then
> +    [ "$K" -eq 1 ] && echo "fake success" && exit $ksft_pass
> +    exit $ksft_fail
> +fi

[Severity: Medium]
Does this logic correctly handle the silent soft-pass mode (K=3D2)? If "fai=
led"
is 1 and K is 2, the check for K=3D1 fails and the script falls through to =
exit
with $ksft_fail. This causes the test to fail instead of returning success =
as
documented for K=3D2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D1
