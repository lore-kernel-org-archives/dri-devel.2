Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D517FCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376F210ECEC;
	Tue, 29 Sep 2026 06:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LwYs8JCV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0AD10ECEC
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:20:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11EF740457;
 Tue, 29 Sep 2026 06:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C640B1F000FF;
 Tue, 29 Sep 2026 06:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790662842;
 bh=jBpFt6oF1ZbkrhU897fzUy4nbvzlRhqdlHCAyllp5rE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LwYs8JCV886qDfBaPd5/Q48muGz5EAtT2ZXXSz44FrTy+WOEQECAU9YA96W9J82Vg
 8HE2gfIgOUA/sVIigSLdTqHR28+6SC9dr1JW4DkSmoUG2y+O85QgnnY/pJp+LQh+B1
 LBPu5kreadCunFBUmayoDEeGUrQb+EhayMADDuiAyhF2WMeLJUhyuZGUxKFV6AFdnY
 mBd9wF1tM21xNKH79mURf4vHBOJo84ZTlNLYf7spzwSbhiI/uz45MtpPvcLg791KJ6
 8mbTnHZSe2it1tWwn927rlvSjhhsGo3Kw7JcJUKvDF6I/NTW8kAyI0VF1frHqlEr0P
 Ottt9SsCnM8ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] atafb: avoid cast when assigning buffer address pointer
To: "Helge Deller" <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929061223.55435-1-deller@gmx.de>
References: <20260929061223.55435-1-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:20:42 +0000
Message-Id: <20260929062042.C640B1F000FF@smtp.kernel.org>
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
- [Low] fbdev: incorrect sparse warning suppression via union alias
--

commit d3053bb9def82e951de5b1b68d5beb85bd502468
Author: Helge Deller <deller@gmx.de>

atafb: avoid cast when assigning buffer address pointer

This commit attempts to resolve a sparse warning about an __iomem address
space cast by switching to the screen_buffer alias from the fb_info union.

Closes: https://lore.kernel.org/oe-kbuild-all/202609261313.kgFtkz2t-lkp@int=
el.com/

> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> index 5c3e5861543a2..c32576cb17202 100644
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -2454,7 +2454,7 @@ static void svblit_fillrect(struct fb_info *info,
>  		((u32 *)info->pseudo_palette)[rect->color] : rect->color;
> =20
>  	/* draw the first line with the CPU ... */
> -	line =3D (u8 *)info->screen_base + rect->dy * pitch +
> +	line =3D info->screen_buffer + rect->dy * pitch +
>  	       rect->dx * bytespp;

[Severity: Low]
This isn't a runtime bug, but does this improperly suppress the sparse warn=
ing
by type-punning through the union alias?

By switching to screen_buffer in svblit_fillrect(), the code bypasses the
__iomem static analysis checks without making the memory access structurally
correct.=20

Shouldn't this use an explicit (__force) cast or proper I/O accessors rather
than hiding the access through a non-__iomem union member?

>  	switch (bytespp) {
>  	case 1:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061223.5543=
5-1-deller@gmx.de?part=3D1
