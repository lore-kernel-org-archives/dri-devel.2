Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07A4C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0264910E729;
	Wed, 29 Jul 2026 05:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lUBO2tU6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D829B10E729
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:40:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D437860A5E;
 Wed, 29 Jul 2026 05:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC711F000E9;
 Wed, 29 Jul 2026 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785303624;
 bh=5mikqCSqFByrvVQTw08oH9Smp10sCCwArTBx6u+syL0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lUBO2tU6ApQA0aTBJc+AdTvMO1F6aLffaMt1h1ijT1d1MxASM9By9gbQnQYVfM5Ao
 ONCUh/n1SrQFw7zCVUzjQlgwtLaeZQr6SP2iYzGGdiIUzTEqR3XqO39kkv4w5xnXvz
 vqtr+xVHGZqq5WHdax7AmPI+Ah3JQTV/XsqAhpM2Srt+HWeBauCnhhV/4mAah/DO+J
 WBshaa6WPIX8ajdoOiQ2u2G+THxlC0I+YzLrgKbX5/H5CZq4ICtmekffrTh6Z3m2hW
 JKR1raQzL4LQGF2lCBP8fNMHQ4bdG+tpNuhtjk5ny7wmQljgzP9pxnN1HZ8/0PewNI
 cX9ZZWRVETvgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/ssd130x: Add per-family update backlight logic
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729053054.29374-3-amit.barzilai22@gmail.com>
References: <20260729053054.29374-1-amit.barzilai22@gmail.com>
 <20260729053054.29374-3-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:40:23 +0000
Message-Id: <20260729054024.5DC711F000E9@smtp.kernel.org>
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
- [High] Multi-byte hardware command sequences can interleave during concur=
rent display and backlight updates, corrupting the panel state.
--

--- Patch [2]: [PATCH 2/2] drm/ssd130x: Add per-family update backlight log=
ic ---
commit 3c6fc209e783670f32fed55dedcfe0a2a66ad662
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Add per-family update backlight logic
   =20
This commit adds per-family backlight update logic to support SSD133x panel=
s,
which require a three-channel contrast update sequence instead of a single
global contrast command.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index f49e5245b2160..0b0fc6fe3df23 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -1711,8 +1711,25 @@ static int ssd130x_update_bl(struct backlight_devi=
ce *bdev)
>  	return 0;
>  }
> =20
> -static const struct backlight_ops ssd130xfb_bl_ops =3D {
> -	.update_status	=3D ssd130x_update_bl,
> +static int ssd133x_update_bl(struct backlight_device *bdev)
> +{
> +	struct ssd130x_device *ssd130x =3D bl_get_data(bdev);
> +
> +	ssd130x->contrast =3D backlight_get_brightness(bdev);
> +
> +	return ssd133x_set_contrast(ssd130x, ssd130x->contrast);
> +}

[Severity: High]
This is a pre-existing issue, but does this newly added function exacerbate=
 a
race condition with concurrent DRM atomic plane updates?

When a backlight sysfs brightness update runs concurrently with a DRM atomic
plane update, both paths invoke regmap_write() repeatedly to send multi-byte
sequences. Since regmap_write() only locks internally for a single byte, th=
ere
appears to be no driver-level mutex to serialize the entire command sequenc=
e.

The newly added ssd133x_update_bl() sends a 7-command multi-byte sequence v=
ia
ssd133x_set_contrast() and ssd130x_run_cmd_seq() without driver-level locks.
Similarly, the existing ssd130x_update_bl() function splits a 2-byte command
across two separate ssd130x_write_cmd() calls.

Could these multi-byte hardware command sequences interleave during concurr=
ent
display and backlight updates, and potentially corrupt the panel's hardware
state machine?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729053054.2937=
4-1-amit.barzilai22@gmail.com?part=3D2
