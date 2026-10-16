Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4D6CC6B2D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 04:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E20D10E02A;
	Fri, 16 Oct 2026 04:10:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4C510E106
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 04:10:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF6C14367C;
 Fri, 16 Oct 2026 04:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828401F000C4;
 Fri, 16 Oct 2026 04:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792123844;
 bh=bhuuAwBWOQZhz5jK7gDHYsUqz9e7hQZ6s8Ks6MOhBcA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mMbyA448T+hgYBiUhhAUvZtZN/1nygbg6uPDBTS3t9/rvFP2WIAbUzsQs4M6lZL+u
 4X3Qq1VnwnIrAIl9fX2I/zSTXOtVJmtyzA5vfTHIYuJ1J30GRfEbwh9HeR+Sz/PRow
 QKm2B8s3Omf36uFkNzlXUCAAMsWMr4dMpj+x88v7yX8gxNB/kdkY6xj8NUwWgIGSFO
 G3fif2x9XiiWOMn9JQJXsm1s3Zu6e8Rnmg+fjw/1GM1hzqFYwNeq6ddaw0Ez9Tx6WE
 95tQCkW4E9czGBwI6mrPKgVvaRZG63+CviFGN4LcP0y7qnRREVabTl0dRK8fTJ2nwO
 MI+qVI9VU4Mqg==
Message-ID: <sashiko-outbox-173733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] fbcon: Rebuild rotated font buffer on font change
To: "Yao Yiqi" <yyaqia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016034533.445862-3-yaoyiqi3@huawei.com>
References: <20261016034533.445862-1-yaoyiqi3@huawei.com>
 <20261016034533.445862-3-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:10:44 +0000
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
- [Medium] fbcon: hardware tileblitting desync on set_font error path
--

commit 4bfab26c62faf08e2aeace132c9263da4258cec4
Author: Yao Yiqi <yyaqia@gmail.com>

fbcon: Rebuild rotated font buffer on font change

Rebuilds the rotated font buffer for the visible console when the font is=20
changed, preventing an out-of-bounds read if the new font size differs.=20
Selects the console blitting state via set_blitting_type() before rotation,=
=20
and rebuilds the rotated font again on the error path if vc_resize() fails.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 01715873ea49b..1a2fe9fc1dc2a 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c

[ ... ]

> @@ -2466,6 +2477,14 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>  	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
>  		set_vc_hi_font(vc, false);
> =20
> +	/*
> +	 * The rotated font buffer was rebuilt for the new font before
> +	 * vc_resize() was attempted. Call rotate_font() again to
> +	 * overwrite par->rotated with the restored font's state.
> +	 */
> +	if (con_is_visible(vc) && par->bitops->rotate_font)
> +		par->bitops->rotate_font(info, vc);
> +

[Severity: Medium]
When vc_resize() fails, this error path successfully restores the software
font state and rotated buffer, but does this leave the hardware tileblittin=
g=20
engine out of sync?

Earlier in fbcon_do_set_font(), set_blitting_type() is called to configure
the hardware with the new font's dimensions. Since set_blitting_type() isn'=
t=20
called again here to revert the hardware state, it seems the tile engine=20
could remain programmed with the rejected font dimensions while the softwar=
e=20
console reverts to the old font. Could this lead to screen corruption or=20
hardware bounds mismatches?

>  	font_data_put(data);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016034533.4458=
62-1-yaoyiqi3@huawei.com?part=3D2
