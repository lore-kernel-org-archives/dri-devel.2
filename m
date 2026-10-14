Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C5DCC6B1F
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B663710FA86;
	Wed, 14 Oct 2026 02:37:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35AF10FA85
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:36:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF0E144003;
 Wed, 14 Oct 2026 02:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB7C1F00893;
 Wed, 14 Oct 2026 02:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791945415;
 bh=WY4xhORG1iGiMkgZO+2fclzPuh36JIZZLK8hPc+lEV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KYIENPkq2Umuxpg8ZAYC5lec3SOt1St5eARcv5U7ASIvYVmkscnfJrkWndo7tVZYl
 mUWiGuih6GNbnBPR1vsva/CT7nhjL8tJplK2F8rXxWWxw9kCSzVT6qKA7HLW48XlWe
 VSMW/cEt3j1/nFiDEtoL5Q4vdBtR7NJxrsSrW0hyPXn4+PI88jJpIWfbRh9y1MXDAZ
 Wsm3s4YfWG0/7ZqB/n75FbOh57PqUDh0XShA1xxYFRASOysYZfXBDdcfYnxrkkwdKB
 SUhrCujkzUZCD9qO2AEmzvJLyeTYYPotZIEfjETFHWUTzlnzKINgXX5+9Hy63rlZK1
 +1WCaGbxrYR8Q==
Message-ID: <sashiko-outbox-170708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/40] selftests/dyndbg: Add kselftest script to
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
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-1-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-1-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:36:53 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: test flakiness from unfiltered dmesg temporal slicing
- [Medium] selftests: test failure coupled to unrelated kernel/params.c pr_=
debug churn
--

commit 56bb89808ed29ee403a2b674106329de27cb9b06
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Add kselftest script to verify dynamic-debug

This commit introduces a dynamic-debug selftest script and a reusable helper
library for baseline-change-verify testing. It uses spatial control-file
slicing and temporal syslog slicing to verify valid syntax, error handling,
and basic queries against the built-in kernel/params.c file.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> new file mode 100755
> index 0000000000000..c1475c7555429
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

[ ... ]

> +function FT_basic_queries {
> +    v_echo "${GREEN}# BASIC_TESTS ${NC}"
> +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> +	echo "SKIP - test requires dynamic_debug built into kernel"
> +	return
> +    fi
> +    local f=3D'kernel/params.c'
> +    ddcmd =3D_ # zero everything
> +
> +    ddcmd "file $f +mf" "$f"

[Severity: Medium]
By strictly validating the exact state of kernel/params.c and hashing the
normalized text, won't this test break if an unrelated upstream commit
legitimately adds or removes a pr_debug() in kernel/params.c? Does this
inadvertently couple the selftest to unrelated core kernel changes?

> +    ddcmd "file $f +l"  "$f"
> +    ddcmd "file $f -m"  "$f"
> +    ddcmd "file $f =3D_"  "$f"

[ ... ]

> diff --git a/tools/testing/selftests/dynamic_debug/syslog_hash_validation=
.sh b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
> new file mode 100644
> index 0000000000000..8c6e91f5d9c27
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh

[ ... ]

> +function verify_dmesg_slice {
> +    # Slices dmesg, computes its hash, and verifies it against the datab=
ase.
> +    # $1 - unique test key (e.g. normal_513)
> +    # $2 - optional start marker (defaults to ${APP}_START_${label})
> +    # $3 - optional end marker (defaults to ${APP}_END_${label})
> +
> +    local label=3D"$1"
> +    local app=3D"${APP:-DYNDBG}"
> +    local start_marker=3D"${2:-${app}_START_${label}_$$}"
> +    local end_marker=3D"${3:-${app}_END_${label}_$$}"
> +
> +    # 1. Capture the log slice (exactly once!)
> +    local log_slice=3D$(dmesg | sed -n "/$start_marker/,/$end_marker/p" =
| \
> +	grep -E -v "$start_marker|$end_marker" | \
> +        sed -E -e 's/^(\[[^]]*\][[:space:]]*)+//' )

[Severity: Medium]
Since verify_dmesg_slice captures all kernel logs between test markers and
hashes the entire block without filtering for test-specific messages, could
concurrent unrelated kernel subsystems (like networking or RCU) emit printk
logs that alter the MD5 hash and cause false positive test failures?

> +
> +    # 2. Compute its fingerprint
> +    local fingerprint=3D$(echo "$log_slice" | tr -d '\r' | md5sum | cut =
-d' ' -f1)
> +
> +    # 3. Verify
> +    verify_fingerprint "$label" "$fingerprint" "Dmesg Log" "$log_slice"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D1
