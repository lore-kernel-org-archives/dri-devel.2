Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951C606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgbALNzD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3488410E67C;
	Wed, 28 Oct 2026 20:25:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FC610E103
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:25:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93F5440C4E;
 Wed, 28 Oct 2026 20:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009691F01825;
 Wed, 28 Oct 2026 20:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793219111;
 bh=X8aM/+q4ttnDqMjxK4uqoHXh+l7bqTKFX/qauRNTst8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BgbALNzDlp4YeIp3hhEbkg+zaIHvap8iL4KJZC9knFF7UKdLNGqWiKyNxotG2FKW1
 SF77oG0uMrhwSy6uh0xUVjF6HL4JAUal9Ano6A/eRZjN1JekW6Wj8kUOTI8bTxhpFG
 L/agS3nt6S1n+kWP0vhF11yRyq6ZNi/S/nZ7RjcnKTnwJFX9EYOpluDUsmkD/EWuYo
 8lyHYAZ7uLCuWPp3yTdo7658RGciL4Co9QwWdbORDDAFFK2sDl8/pgDvqZJbKqTH76
 A/57GTADZmUNiy7EgF4ZzK2IcTScDJnxpGp4tAv2dv0CSxVWOz/xntvvdNXNKRblMR
 HOfTnbNvSM7+w==
Message-ID: <sashiko-outbox-188377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/39] selftests/dyndbg: Add kselftest script to
 verify dynamic-debug
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Shuah
 Khan" <shuah@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Jonathan Corbet" <corbet@net.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "John
 Ogness" <john.ogness@linutronix.de>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>, 
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "Jason Baron" <jbaron@redhat.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-1-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-1-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/dyndbg: stale record check in audit_golden_records() n=
ever fails
- [Medium] selftests/dyndbg: broken LACK_DD_BUILTIN fallback and missing ro=
ot check
--

commit d24db61e852431796c45358b620c1c921638c8b3
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Add kselftest script to verify dynamic-debug

This commit introduces a kselftest script and a syslog/control-file hash
validation helper library to test dynamic_debug grammar and query execution
against a database of golden MD5 fingerprints.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> new file mode 100755
> index 0000000000000..c1475c7555429
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
[ ... ]
> +[ -e /proc/dynamic_debug/control ] || {
> +    echo -e "${RED}: this test requires CONFIG_DYNAMIC_DEBUG=3Dy ${NC}"
> +    exit $ksft_skip # nothing to test here, no good reason to fail.
> +}
> +
> +lsmod >/dev/null 2>&1 || {
> +    echo -e "${RED}: lsmod requires /proc/modules ${NC}"
> +    # exit $ksft_skip # maybe later we can do more
> +}
> +
> +# need info to avoid failures due to untestable configs
> +
> +[ -f "$KCONFIG_CONFIG" ] || KCONFIG_CONFIG=3D".config"
> +if [ -f "$KCONFIG_CONFIG" ]; then
> +    v_echo "# consulting KCONFIG_CONFIG: $KCONFIG_CONFIG"
> +    grep -q "CONFIG_DYNAMIC_DEBUG=3Dy" $KCONFIG_CONFIG ; LACK_DD_BUILTIN=
=3D$?
> +    grep -q "CONFIG_TEST_DYNAMIC_DEBUG=3Dm" $KCONFIG_CONFIG ; LACK_TMOD=
=3D$?
> +else
> +    # if no config, try runtime probes
> +    modprobe -n test_dynamic_debug 2>/dev/null ; LACK_TMOD=3D$?
> +    # assume builtin dyndbg if control exists (checked above)
> +    LACK_DD_BUILTIN=3D0
> +fi

[Severity: Medium]
When kselftest runs dyndbg_selftest.sh via runner.sh, it first changes the
working directory into tools/testing/selftests/dynamic_debug/ (or the
installed selftest directory), where .config is not present unless
KCONFIG_CONFIG is set to an absolute path.

In that case, the fallback branch unconditionally sets LACK_DD_BUILTIN=3D0.
However, on a kernel built with CONFIG_DYNAMIC_DEBUG_CORE=3Dy and
CONFIG_DYNAMIC_DEBUG=3Dn, /proc/dynamic_debug/control still exists, while
built-in files such as kernel/params.c have no dynamic debug descriptors.
Will FT_basic_queries() then fail to skip and report false DRIFTED failures
on empty diffs? Could the runtime fallback instead probe
/proc/dynamic_debug/control for ^kernel/params.c: to set LACK_DD_BUILTIN?

Also, /proc/dynamic_debug/control is created with mode 0644, so the
[ -e /proc/dynamic_debug/control ] check succeeds for unprivileged users,
causing the script to fail with $ksft_fail on the first write in ddcmd()
or /dev/kmsg instead of skipping. Should this check for write permission
(-w /proc/dynamic_debug/control) or root privileges before running the
tests?

[ ... ]
> +audit_golden_records
> +
> +# Output consolidated blocks of unregistered and drifted fingerprints
> +failed=3D0
> +
> +if [ -s "$UNREG_HASHES_FILE" ]; then
> +    if [ "$K" -ne 2 ]; then
> +        echo -e "${YELLOW}\n# --- Unregistered Baselines ---"
> +        cat "$UNREG_HASHES_FILE"
> +        echo -e "# ------------------------------${NC}"
> +    fi
> +    : > "$UNREG_HASHES_FILE"
> +    failed=3D1
> +fi
> +
> +if [ -s "$DRIFT_HASHES_FILE" ]; then
> +    if [ "$K" -ne 2 ]; then
> +        echo -e "${RED}\n# --- Drifted Baselines ---"
> +        cat "$DRIFT_HASHES_FILE"
> +        echo -e "# -------------------------${NC}"
> +    fi
> +    : > "$DRIFT_HASHES_FILE"
> +    failed=3D1
> +fi
> +
> +if [ $failed -eq 1 ]; then
> +    [ "$K" -eq 1 ] && echo "fake success" && exit $ksft_pass
> +    [ "$K" -eq 2 ] && exit $ksft_pass
> +    exit $ksft_fail
> +fi
> +
> +exit $ksft_pass
> +
> diff --git a/tools/testing/selftests/dynamic_debug/syslog_hash_validation=
.sh b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
> new file mode 100644
> index 0000000000000..8c6e91f5d9c27
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
[ ... ]
> +    # Strictly verify that the computed fingerprint matches any
> +    # expected hash for this label
> +    if [ -n "$expected_hash_field" ] && [ $matched -eq 1 ]; then
> +        local short_hash=3D"${fingerprint:0:12}"
> +        [ "$V" -ge 1 ] && echo -e "${GREEN}=E2=9C=94 Verified '${label}'=
 " \
> +            "(${short_hash}) [via: '${DDCMD_LOG}']${NC}"
> +
> +        if [ "$V" -ge 2 ]; then
> +            echo -e "${CYAN}--- Captured Invariant ${capture_desc} Outpu=
t ($label) ---"
> +	    printf "#K=3D %-32s %-24s\n" "${fingerprint}" "${label}"
> +            echo "$raw_capture"
> +            echo -e "-----------------------------------${NC}"
> +        fi
> +        echo "$fingerprint" >> "$SEEN_HASHES_FILE"
> +    else
[ ... ]
> +function audit_golden_records {
> +    local seen_file=3D"$SEEN_HASHES_FILE"
> +
> +    if [ ! -f "$seen_file" ]; then
> +        return
> +    fi
> +
> +    # Require GOLDEN_RECORDS to be defined in the caller script
> +    if ! declare -f GOLDEN_RECORDS >/dev/null; then
> +        return
> +    fi
> +
> +    [ "${V:-0}" -ge 1 ] && echo -e "${YELLOW}# --- GOLDEN_RECORDS Audit =
---${NC}"
> +    local stale_found=3D0
> +    local total_records=3D$(GOLDEN_RECORDS | grep -c "^#K=3D")
> +
> +    # Read each active record line from GOLDEN_RECORDS
> +    while read -r line; do
> +        # Extract the hash/hashes (second word) from the #K=3D line
> +        local hash_field=3D$(echo "$line" | awk '{print $2}')
> +
> +        # Check if at least one of the comma-separated hashes was seen
> +        local hash_seen=3D0
> +        local h
> +        local OLD_IFS=3D"$IFS"
> +        IFS=3D","
> +        for h in $hash_field; do
> +            if grep -q "$h" "$seen_file" 2>/dev/null; then
> +                hash_seen=3D1
> +                break
> +            fi
> +        done
> +        IFS=3D"$OLD_IFS"
> +
> +        # Check if this hash field was seen during the run
> +        if [ $hash_seen -eq 0 ]; then
> +            if [ "${K:-0}" -ne 2 ]; then
> +                if [ $stale_found -eq 0 ]; then
> +                    # On first failure, print header if not already prin=
ted
> +                    [ "${V:-0}" -eq 0 ] && \
> +                        echo -e "${YELLOW}# --- GOLDEN_RECORDS Audit ---=
${NC}"
> +                    echo -e "${YELLOW}# The following GOLDEN_RECORDS ent=
ries " \
> +                        "were never hit and may be stale:${NC}"
> +                fi
> +                echo -e "${YELLOW}#K_STALE=3D $line${NC}"
> +            fi
> +            stale_found=3D1
> +        fi
> +    done < <(GOLDEN_RECORDS | grep "^#K=3D" | grep -v "<md5_hash>")
> +
> +    if [ $stale_found -eq 0 ] && [ "${V:-0}" -ge 1 ]; then
> +        echo -e "${GREEN}# All $total_records GOLDEN_RECORDS entries " \
> +            "were successfully hit!${NC}"
> +    fi
> +
> +    # Detect duplicate labels in the database
> +    local dupes=3D$(GOLDEN_RECORDS | grep "^#K=3D" | awk '{print $3}' | =
sort | uniq -d)
> +    if [ -n "$dupes" ]; then
> +        echo -e "\n${RED}# WARNING: Duplicate labels detected in GOLDEN_=
RECORDS():${NC}"
> +        echo "$dupes" | sed 's/^/#   /'
> +    fi
> +
> +    # Clean up
> +    rm -f "$seen_file"
> +}

[Severity: Medium]
The header comment in dyndbg_selftest.sh documents that K=3D0 fails with ex=
it 1
on checksum drift or stale records, and K=3D1 exits 0 with "fake success".

In audit_golden_records(), stale_found and dupes are local variables and the
function ends with rm -f "$seen_file", returning 0 without propagating the
failure to the caller in dyndbg_selftest.sh (which only sets failed=3D1 when
UNREG_HASHES_FILE or DRIFT_HASHES_FILE is non-empty). Doesn't this mean sta=
le
records or duplicate labels in GOLDEN_RECORDS() will never cause K=3D0 to e=
xit
with $ksft_fail or K=3D1 to report "fake success"?

In addition, verify_fingerprint() writes only "$fingerprint" to
SEEN_HASHES_FILE without the test label, and audit_golden_records() checks
only whether the hash appears in "$seen_file". When multiple test cases in
GOLDEN_RECORDS() share the same MD5 hash (for example, FT_grammar_errs.21 a=
nd
FT_grammar_errs.41 both have 94cdf3b32afa4f12a00a704208aa2e53, and
FT_grammar_errs.25 and FT_grammar_errs.45 both have
644b81753949ac1285e38ac995eeba46), won't running just one of those tests ma=
rk
the hash as seen for all of them and hide unexecuted labels? Should
SEEN_HASHES_FILE record both the fingerprint and label (and be truncated wi=
th
: > "$seen_file" instead of removed with rm -f)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D1
