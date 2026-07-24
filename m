Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98722C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72D388130;
	Fri, 24 Jul 2026 00:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V6sgWkML";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3135688130
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:54:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE52341447;
 Fri, 24 Jul 2026 00:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F621F000E9;
 Fri, 24 Jul 2026 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784854463;
 bh=cHJEDt5OOVKsXJhVeL5fwziSeplzB7IrUzt9Tj7MA68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V6sgWkMLxDy5IWbbS94zjoulGzfpFYrfwKK7bLofYdZgtrSTdO9CueYIzZSus9gQc
 xyDA2KLuRHRuJGFojmcRRcW5OOH2P/ipZVHUx3eM40+9xfphKvMYphBDbWWv4VtQJ6
 TWH6gK3l+DSvcKHUlRSMtPXQktq3y0Vs/jKsGIKn+aJ9Dj+hhtYfowuSFkuR8AlxtB
 dsjjy7t6K6Ulfq54EigjkIDUZjK1IGINco0BUjSwPVbKSlLIaC2yftfpw+p4U5YceR
 +U8fcfWlb8A03ZCKsdu5hv88yjeIKl13sX24SyIydBsp273Hv1r7ZmUBip986S76VQ
 Iwtsa+40s21Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] video: fbdev: kyro: Validate overlay viewport coordinates
To: "Danila Chernetsov" <listdansp@mail.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724004245.86764-1-listdansp@mail.ru>
References: <20260724004245.86764-1-listdansp@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:54:23 +0000
Message-Id: <20260724005423.86F621F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing validation for ulHeight =3D=3D 1 causes a division by zero=
 panic in SetOverlayViewPort.
--

--- Patch [1]: [PATCH] video: fbdev: kyro: Validate overlay viewport coordi=
nates ---
commit eccd0fc9ac01567bf3583eb92ff9c8b899a5e6b3
Author: Danila Chernetsov <listdansp@mail.ru>

video: fbdev: kyro: Validate overlay viewport coordinates

This commit adds coordinate validation in kyro_dev_overlay_viewport_set to
prevent 32-bit wraparound before passing the values to SetOverlayViewPort.
It explicitly checks for overflows when adding dimensions and restricts the
adjusted coordinates to fit into 16-bit register fields.

> diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/=
fbdev.c
> --- a/drivers/video/fbdev/kyro/fbdev.c
> +++ b/drivers/video/fbdev/kyro/fbdev.c

[ ... ]

> @@ -378,11 +381,30 @@ static int kyro_dev_overlay_viewport_set(u32 x, u32=
 y, u32 ulWidth, u32 ulHeight
>  	    (x < 2 && ulWidth + 2 =3D=3D 0))
>  		return -EINVAL;
> =20
> +	/*
> +	 * SetOverlayViewPort() adjusts X coordinates by +2 (left) and +1
> +	 * (right) before packing them into 16-bit register fields.
> +	 */
> +	if (x > U16_MAX - 2 || y > U16_MAX)
> +		return -EINVAL;
> +
> +	right =3D x + ulWidth;
> +	bottom =3D y + ulHeight;
> +
> +	if (right < x || bottom < y)
> +		return -EINVAL;
> +
> +	right--;
> +	bottom--;
> +
> +	if (right > U16_MAX - 1 || bottom > U16_MAX)
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does this validation block still allow a
divide-by-zero panic if ulHeight is 1?

If a user passes ySize =3D 1 via the KYRO_IOCTL_OVERLAY_VIEWPORT_SET ioctl,
ulHeight will be 1. The code calculates bottom =3D y + ulHeight, then=20
bottom--, which results in bottom =3D=3D y.

When these values are passed to SetOverlayViewPort(), it calculates ulDest
as the difference between the y coordinates (bottom - top). Since they are
equal, ulDest evaluates to 0:

drivers/video/fbdev/kyro/STG4000OverlayDevice.c:SetOverlayViewPort() {
    ...
    ulDest =3D srcDest.lDstY2 - srcDest.lDstY1;
    ...
    ulFxScale =3D (ulDest << 11) / ulSrc;
    ...
    ulSrcBottom =3D ulSrcBottom - (ulFxOffset / ulFxScale);
    ...
}

Because ulDest is 0, ulFxScale evaluates to 0. The subsequent division by
ulFxScale then causes a kernel panic.

Should ulHeight =3D=3D 1 be rejected alongside the ulHeight =3D=3D 0 check =
earlier
in kyro_dev_overlay_viewport_set()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724004245.8676=
4-1-listdansp@mail.ru?part=3D1
