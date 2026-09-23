Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F4C9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B91210E32F;
	Wed, 23 Sep 2026 22:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nfklRSc6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F0310E32F
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:52:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27AF060008;
 Wed, 23 Sep 2026 22:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92F21F000FF;
 Wed, 23 Sep 2026 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790203967;
 bh=NTBDh0Nk97KRovUD4m579HCNumLeYHqK4jcXxZfhkPo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nfklRSc6sfRN+uQBXBdUcW4rvOVHa5QUjdwMp64dvICWsZ+ITD2s64WA1/5X/Ssxt
 vKLEMC+5dyZCzwUrsMmnK+wO82yMswqZGI3jDCnb/CxstV5oVJxkj0AVk/hzg3lgBQ
 1RzjBf0NjPA71e5U7PHypfPvW4A0HEmaV48zhgptrVEFRATIUlBcaMFLWN5PyTXIJh
 ffCSvU0urUXt6nK4NtVB0n/3sJ9pB76+9DiTgvZHCTwKpnxZ0p7tQpZIzfMb1GwfsK
 qSJZhNOkZJcF6RbkxWPkjfTEpR2rMtp4AoRsvXmaARN6Pqqihp0zUe3PyDj5+5BxSi
 gTv/8bij02mpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 37/38] dyndbg: add +c flag to count pr_debug calls
 without printing
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-37-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-37-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:52:47 +0000
Message-Id: <20260923225247.B92F21F000FF@smtp.kernel.org>
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
- [High] lib: Kernel oops when modifying string literal in ddebug_exec_quer=
ies
--

commit 33851d8d7a58ba9b9a4cd975835feabf66d636db
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add +c flag to count pr_debug calls without printing

This commit introduces a new "+c" flag for dynamic debug to count pr_debug
calls without actually printing them, saving memory bandwidth. It adds a
per-CPU counter for the hits and a "reset_stats" control command to clear
the counters.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 88440c1f6abba..9b789287afe56 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -727,6 +745,11 @@ static int ddebug_exec_queries(char *query, const ch=
ar *modname)
>  		if (!query || !*query || *query =3D=3D '#')
>  			continue;
> =20
> +		if (!strcmp(strstrip(query), "reset_stats")) {

[Severity: High]
Will this cause a kernel oops when parsing module parameters?

If a user supplies the dyndbg or module.dyndbg parameter without an
explicit value, ddebug_dyndbg_param_cb() handles it by falling back to
a string literal:

    ddebug_exec_queries((val ? val : "+p"), modname);

Since strstrip() modifies the string in-place by writing a null byte at
the end of the processed string, passing the read-only literal "+p" will
attempt a write to the .rodata section and crash the kernel during boot or
module load.

> +			reset_ddebug_call_count();
> +			continue;
> +		}
> +
>  		if (modname)
>  			v2pr_info("query %d: module %s \"%s\"\n", i, modname, query);
>  		else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D37
