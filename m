Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3826C79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A57210EE36;
	Wed,  9 Sep 2026 01:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J4jAu56u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2681D10EE36
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:06:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58720601FB;
 Wed,  9 Sep 2026 01:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE71F00A3A;
 Wed,  9 Sep 2026 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788915988;
 bh=N/vI5mKTc4jUTJ/ro7fDJfk3hUknoVNVpuIfUrFEy7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J4jAu56uSsFXb/GO9s2GgTLaVPdUATm8rfIvrgHruN5lhMEp3sbZcZoDj4RkDb04/
 xg6+lQSZacWOKy1Ng09m6uM/sLktwPsD5LXs22YgdEk0j2bpDP/2eGsuC0lWFhmJUV
 2NOHrluV87DzATNro3y+UbZwNDC/FMfxJ02+mjSpx/T1uw6qJARKhhSjHDzK22jddi
 Mzdk1uVbnpcMvlkhmupUm4FKSDsaRpjtx4ZAB7+NVoBuCOQO/69EbQJX2OFCSRH0uj
 KlrXeFqw5DDH19xQvoUiHzSAwglV9C0YqN426iItpIZLz2FkK3fz4/Gw/64yyXmkvH
 toN4xQGCXD+MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 32/39] dyndbg: split multi-query strings with @
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-32-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-32-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:06:27 +0000
Message-Id: <20260909010627.E7CE71F00A3A@smtp.kernel.org>
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
- [High] Adding '@' as a naive multi-query delimiter unconditionally breaks=
 dynamic debug queries for format strings or file paths containing '@'.
--

commit 14701392fec803b263b7d4600e1eddc32de76b94
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: split multi-query strings with @

This patch adds '@' to the existing ';' and '\n' multi-command separators
for dynamic debug. This is intended to be more shell-friendly and avoid
quoting and escaping hassles when passing commands.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index d28858acdc8f9..e6f5a524d63b6 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -631,7 +631,7 @@ static int ddebug_exec_queries(char *query, const cha=
r *modname)
>  	int i, errs =3D 0, exitcode =3D 0, rc, nfound =3D 0;
> =20
>  	for (i =3D 0; query; query =3D split) {
> -		split =3D strpbrk(query, ";\n");
> +		split =3D strpbrk(query, "@;\n");

[Severity: High]
Does this unconditionally split queries on '@' before they undergo
quote-aware tokenization in ddebug_tokenize()?

If a user tries to filter debug prints using a format string or file path
that legitimately contains an '@' character, such as matching a device tree
node like: format "node@1234", it appears this will destructively split the
string.

Since there is no escaping mechanism in strpbrk(), could this introduce a
regression for existing valid queries containing hardware addresses or
device tree nodes?

>  		if (split)
>  			*split++ =3D '\0';
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D32
