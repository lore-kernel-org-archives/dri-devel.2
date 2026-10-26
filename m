Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA53606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NfivEqFy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC23A10E02E;
	Mon, 26 Oct 2026 22:24:55 +0000 (UTC)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1889610E02E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:24:49 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso3967356d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793053488; cv=none;
 d=google.com; s=arc-20260327;
 b=RkUidSO7/cHW15GmVbLf7UFVh6vTNCTo+rugLIB6Fvrmr13I2+U1AdKgrGiHXp31oL
 mj2qRe3uswEqTB7Cxb4yyO7wSnZ5sKXRMh9ey0BRhDSe7nrZPGP8mf6O/CBaNt0wiE1P
 fp7iO/p2aS+gBFUnXxnNUy4juldR2V7M6u7aVMtpJ+k4+puHuDjjRzHtuymLgKuHcpZd
 33L5Imh8GDDV4gOzNeoxfn4hvzUSImVKTKWTHGkggQ3rWx9gkWgEzXgMJrrCKnQNTuEA
 YQbQg5SO7EvRax4/VI6HM10JaKoFKI/cJlxT/ieZYeawGcF7Q1wuP6GoQdvdEco9hD41
 G0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iVjafvKaFWiL8zTdM57JrvEcpVYGEcYrmsTnFX/+S2w=;
 fh=HCrxylzByx0tYVHFWwjTw9dQwkmsZKGaupOH6m6vOvY=;
 b=p2UGUFGvdk856jsTQQAEB+dDepHg/HzNJ8lORtxU/523nsf76HBU2adWNvWR0GHl7S
 GG4AwxgzBpPLq9JKKlDLKE+jQs+ZUx7M9HnoybCQQk9kQcJyZE59+MPSPeRVYhWihsy8
 w73uFnzqAj8xvTc6MN8EBevR4qq/Gz/nJkNjMUvLIgyYkdjmFJN9/5H+PM8kNWUr9+M1
 xmz4HsSsvEtEOmwyRiMa5nOz4Eo0PERjWCMhaXDVJnxg7ihI+kAONi9gPSErIkcbR9bi
 6Bf38lB+JNyqWWDitXuWivjgvjIlZUcxFxUG+HTc5eIES2yCSDaW8+UCQmEZPp6Kqcfh
 feiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793053488; x=1793658288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iVjafvKaFWiL8zTdM57JrvEcpVYGEcYrmsTnFX/+S2w=;
 b=NfivEqFylQCldj43NT7DNI8iNAWPq9BRU3sdA5YJfyyP4LKqshH1/CqsPZLK/yRDdM
 OLLMjQC+kLDhbn/S2H/UkzrwKHb3GJ8TkW3F0WwbeVO3nS9iWNRU722vMgLDKMYn8F62
 4m026jDiR3ZH7HpX8mO29V/fg6Y9rRAT6o6V6QNx6JUY2QduoamjyLjSUaAz3aDi6vMb
 bhg2s4c1XrfdbfPEW0HsnKCu4B7orNMZcMm8TSlfp1TjZq13wKXGkzgQAvuP7uul6mhR
 7/oW7kXcdPf4P4IaCuaInsmigYnVmtjWGjWPOmzs1LSJafqvzZnZSOwG3IV1tblDMNRe
 kO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793053488; x=1793658288;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVjafvKaFWiL8zTdM57JrvEcpVYGEcYrmsTnFX/+S2w=;
 b=TkgxSqYhO5Ck7GQxWtMYDK3F1fdNf5HN57k0pyWwoTT8KDRjSKFfJJNXK6rgYKWRfI
 n4pBN+ILFhz1ckJYAEQABEvX1mLmWrK6zj2RIhkkqbIeXMEJY0U7dnN4dCZJL6k4P1AI
 XBGdtGegLw6fE6062HHHnusp+1bxAfwKF8oMCmVeJPfSK8S+c2FzaupqhFWOh53vs6Bt
 CxchXDv4vEMGbS3b5dfiRi+t/EvHljCaLlfl1fWfHeO119+NLSmRh0UxsNgVp9W1vNxl
 BWj4nSmc8FCuRG7jCHV+MEx8MN9qftOcRwHm67jqOX0wMKmzh7AL1MhYYFw9sE/qsW6d
 gqAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsivlnTnZu3gzbbjsYUJ4rdIysAyH02Gug+GX4LZ90D7wPHX2Bj9YUSTyZVweNnmFENZsnw2CoXlg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKL9yFxNalmKPdvWxwtW9Npwbeh3r77kAViw2zLDyg1MPvd1HpQ
 2iBLe6i8E2NTSh4qO36i7Fc7bPziFBZ334jW5oss1mbPXi9BgBwA+fTWwpH0n+grEDeIBPPQMdi
 bk+IvgJnlHyuTNk/KOpxCB8yQJYe2+A1hmw==
X-Gm-Gg: AYBFou1hDSWue4oUO1MUCTkiop98Q15fmN0GaCc5nzsz3zl0iZxDvBYdm1rdvSAXsqF
 /aq80fJhPw/RPWJANv5f0n67/f/a+oDPWsfcZ89VegZbxeY4+QdRs3sIxT4RT8tVoAyCWOqB6Wm
 XC+gSvbFot9A03lNuK1aK8PmZgEa9Bop7kUCoDEg/EIqYt2MMJ7nshase3MLRTMn8DXmdhbqLHd
 s2KZ3Q8ufF99x5OfT4JV8CvjXMZnyhAWSDPEGi4hzJ/TOkrWpiyvSFWwSkI7mGcCpVoNTt6HCiH
 RmhBNl95R/eh7B5yui4YCP3HbcRHuc3l/YIj9gzA5tmdtrA9mr3e8yOEWjwUxYbqOgPkUmKUILl
 pVVGkCY/U77PDkw82MTHVduvLubsK71vibmi+0ozUjmoXJLsRdNUkhHvz1h67kCAJdLdEIWLobv
 jIp5MN4iOZmeyfuMzeczQh9LwGpHr772TmZgTy
X-Received: by 2002:a05:690e:dc5:b0:677:cbe8:4fce with SMTP id
 956f58d0204a3-67a45500fcemr5471600d50.79.1793053487746; Mon, 26 Oct 2026
 15:24:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-1-3c8cc5725def@gmail.com>
 <sashiko-outbox-170708@kernel.org>
In-Reply-To: <sashiko-outbox-170708@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:24:20 -0600
X-Gm-Features: AclHuK8NnuLVLON4lfx7cNxK26K-bWlrdBylLKsqpFu-v1Gz5G-bY8ivxELQPKw
Message-ID: <CAJfuBxzw4jWufuQhgstnYFtkC=+VyV9nNLi9R3xTuJEVsWbuNQ@mail.gmail.com>
Subject: Re: [PATCH v12 01/40] selftests/dyndbg: Add kselftest script to
 verify dynamic-debug
To: sashiko-reviews@lists.linux.dev
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
 linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 8:36=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] selftests: test flakiness from unfiltered dmesg temporal slici=
ng
> - [Medium] selftests: test failure coupled to unrelated kernel/params.c p=
r_debug churn
> --
>
> commit 56bb89808ed29ee403a2b674106329de27cb9b06
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Add kselftest script to verify dynamic-debug
>
> This commit introduces a dynamic-debug selftest script and a reusable hel=
per
> library for baseline-change-verify testing. It uses spatial control-file
> slicing and temporal syslog slicing to verify valid syntax, error handlin=
g,
> and basic queries against the built-in kernel/params.c file.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b=
/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > new file mode 100755
> > index 0000000000000..c1475c7555429
> > --- /dev/null
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
>
> [ ... ]
>
> > +function FT_basic_queries {
> > +    v_echo "${GREEN}# BASIC_TESTS ${NC}"
> > +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> > +     echo "SKIP - test requires dynamic_debug built into kernel"
> > +     return
> > +    fi
> > +    local f=3D'kernel/params.c'
> > +    ddcmd =3D_ # zero everything
> > +
> > +    ddcmd "file $f +mf" "$f"
>
> [Severity: Medium]
> By strictly validating the exact state of kernel/params.c and hashing the
> normalized text, won't this test break if an unrelated upstream commit
> legitimately adds or removes a pr_debug() in kernel/params.c? Does this
> inadvertently couple the selftest to unrelated core kernel changes?
>

Yes, there is a certain amount of dependency / brittleness
IF kernel/params.c is changed in certain ways.

That said
1. kernel/params.c is one of the most stable / unchanging parts of the kern=
el
2. tests that change flags and verify the changes are needed for
adequate coverage
3. tests against builtin pr_debugs work even when test-modules are not buil=
t
4. line numbers are excluded from the verification, eliminating that
source of breakage




> > +    ddcmd "file $f +l"  "$f"
> > +    ddcmd "file $f -m"  "$f"
> > +    ddcmd "file $f =3D_"  "$f"
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/dynamic_debug/syslog_hash_validati=
on.sh b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
> > new file mode 100644
> > index 0000000000000..8c6e91f5d9c27
> > --- /dev/null
> > +++ b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
>
> [ ... ]
>
> > +function verify_dmesg_slice {
> > +    # Slices dmesg, computes its hash, and verifies it against the dat=
abase.
> > +    # $1 - unique test key (e.g. normal_513)
> > +    # $2 - optional start marker (defaults to ${APP}_START_${label})
> > +    # $3 - optional end marker (defaults to ${APP}_END_${label})
> > +
> > +    local label=3D"$1"
> > +    local app=3D"${APP:-DYNDBG}"
> > +    local start_marker=3D"${2:-${app}_START_${label}_$$}"
> > +    local end_marker=3D"${3:-${app}_END_${label}_$$}"
> > +
> > +    # 1. Capture the log slice (exactly once!)
> > +    local log_slice=3D$(dmesg | sed -n "/$start_marker/,/$end_marker/p=
" | \
> > +     grep -E -v "$start_marker|$end_marker" | \
> > +        sed -E -e 's/^(\[[^]]*\][[:space:]]*)+//' )
>
> [Severity: Medium]
> Since verify_dmesg_slice captures all kernel logs between test markers an=
d
> hashes the entire block without filtering for test-specific messages, cou=
ld
> concurrent unrelated kernel subsystems (like networking or RCU) emit prin=
tk
> logs that alter the MD5 hash and cause false positive test failures?
>

All my testing has been done on VMs, they are well isolated from
unrelated subsystems.
ISTM most CI-CD testing is done that way.
If needed, we could easily add grep filtering later to select only
relevant messages,
but it adds its own maintenance burden; it doesn't seem like a blocker to m=
e.

> > +
> > +    # 2. Compute its fingerprint
> > +    local fingerprint=3D$(echo "$log_slice" | tr -d '\r' | md5sum | cu=
t -d' ' -f1)
> > +
> > +    # 3. Verify
> > +    verify_fingerprint "$label" "$fingerprint" "Dmesg Log" "$log_slice=
"
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D1
