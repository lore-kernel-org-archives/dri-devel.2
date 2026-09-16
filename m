Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF460C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBC610E3D0;
	Wed, 16 Sep 2026 15:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jVGw9rEs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FE810E3D0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:41:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7224D43925;
 Wed, 16 Sep 2026 15:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BD91F00893;
 Wed, 16 Sep 2026 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789573295;
 bh=a02D6i1RP1n3mdxSE+c5Jvz3yEutDKEehkXVrrZZ4Z4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jVGw9rEsNVKiUfJ/nYUDrt6FTttUIfGYKchPLtfAgmfN4V1jttIE+K7XQ0h/Hr++6
 BjkY/NGZu8xS0IfdatdtrBO05s8j1wtSYaBobRF4lYYAtwUiLr411BIYu6/jp2A6xm
 E4EqZgvOlvf5ZrcBLmSyL4t2kIqRmdiPV3GkibEweT4grzw6O+hUxIJYP3/LTmUDoU
 sdU6PywP892UYKEenexqjeNzgGCpdL5G8dZ/nOClM14exqIq5ONRwr+3K51pFiVrgL
 VZ2ZoRCO+LQLm1k4uZWfD4X57W0Le9gUEsgbdDLiELZSMwbPQ1DMfxa3Xsmbo9E2B+
 KTGyo6j4trwGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/38] selftests/dyndbg: Add kselftest script to
 verify dynamic-debug
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-1-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-1-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:41:34 +0000
Message-Id: <20260916154135.28BD91F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/dyndbg: dead write-only variable CUMULATIVE_DDCMDS
--

commit baf1eba97598bc14d4dc1aac7aa207aedefbdfac
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Add kselftest script to verify dynamic-debug

This commit introduces a new kselftest script and helper library to verify
dynamic debug functionality. It uses spatial control-file slicing and
temporal syslog slicing to validate expected outcomes against an embedded
database of golden records.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> new file mode 100755
> index 0000000000000..73c2a4b07bd32
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

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

[Severity: Low]
Is this variable used anywhere? It appears CUMULATIVE_DDCMDS is written to
here in ddcmd() but is never read or evaluated in this script or subsequent
patches in the series.

> +
> +    [ "$action" !=3D "pass" ] && log_start
> +    [ -n "$range" ] && capture_before "$range"
> +
> +    output=3D$( (echo "$args" > /proc/dynamic_debug/control) 2>&1 )
> +    handle_exit_code $BASH_LINENO $FUNCNAME $? $exp_exit
> +
> +    [ "$action" !=3D "pass" ] && log_stop
> +    [ -n "$range" ] && verify_after_change
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D1
