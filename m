Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF8AC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F2710E00C;
	Sun, 23 Aug 2026 11:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OGLot8Fp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539B710E00C
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:36:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A62260008;
 Sun, 23 Aug 2026 11:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C499A1F000E9;
 Sun, 23 Aug 2026 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787484994;
 bh=5t6+8MRReuwEWWtWz590EOauv6OUxUupfcdl9H/F+q4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OGLot8Fp/K7oAlwnKRbJvnLVn0Kgz1ozM5vvhxPnrR6/CmyDe+2X7vvb+mW/0JUgw
 OUUKqPoxARKfx5quv8N99qiz3OuBNc3z2uU/0gcKJ4hB0sarmAoMZ+5XcjD6kJ1l9x
 mHsOM3hK5oXknM8X/1jZwSFtpUBO6jb+LkEQWlehoH6vRvug/j7U86JZMIxMjfrgWO
 LLcDTdgnRSulhgq3Zcdlpm8huYXKfPFwmlFwSgrbVewiOGqrfOeXrXRpd0s0242pBr
 qcuXh9Hdi+8ygYbOqMRQwWum4mEgf8Ks5VDdSfgaxGcRi72gn9VxA1vZR+1wRkuKQh
 wAFxySMPJtt9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] drm/ssd130x: Change SSD133X color format to
 RGB565 from RGB332
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260823111959.17029-3-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-3-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:36:33 +0000
Message-Id: <20260823113633.C499A1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing drm_format_conv_state_reserve() pre-allocation forces unsa=
fe GFP_KERNEL allocation in atomic context.
- [High] Sleeping functions called from plane atomic update callback.
--

--- Patch [2]: [PATCH v5 2/6] drm/ssd130x: Change SSD133X color format to R=
GB565 from RGB332 ---
commit e1ae8460e953e75a280fd3111fa7957d70e68fcc
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Change SSD133X color format to RGB565 from RGB332
   =20
SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
Switch the SSD133X data path to RGB565.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index 0b0fc6fe3df23..8cf1e9c84a810 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

[ ... ]

> @@ -978,17 +990,18 @@ static int ssd133x_fb_blit_rect(struct drm_framebuf=
fer *fb,
>  				struct drm_format_conv_state *fmtcnv_state)
>  {
>  	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(fb->dev);
> -	const struct drm_format_info *fi =3D drm_format_info(DRM_FORMAT_RGB332);
> +	const struct drm_format_info *fi;
>  	unsigned int dst_pitch;
>  	struct iosys_map dst;
> =20
> +	fi =3D drm_format_info(DRM_FORMAT_RGB565);
>  	if (!fi)
>  		return -EINVAL;
> =20
>  	dst_pitch =3D drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
> =20
>  	iosys_map_set_vaddr(&dst, data_array);
> -	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_stat=
e);
> +	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_st=
ate);

[Severity: High]
This is a pre-existing issue, but does this conversion allocate memory with
GFP_KERNEL in an atomic context?

Because ssd133x_primary_plane_atomic_check() does not pre-allocate the form=
at
conversion state using drm_format_conv_state_reserve(), this call to
drm_fb_xrgb8888_to_rgb565be() can fall back to a dynamic GFP_KERNEL allocat=
ion
within __drm_fb_xfrm(). This leads to might_sleep() warnings since it execu=
tes
during the plane's atomic_update callback.

> =20
>  	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);

[Severity: High]
This isn't a bug introduced by this patch, but does this function sequence
perform sleeping operations from an atomic context?

The ssd133x_primary_plane_atomic_update() callback runs in an atomic context
where sleeping is forbidden. However, it calls drm_gem_fb_begin_cpu_access()
(which waits on dma_resv and can sleep) and then calls into this function,
which reaches ssd133x_update_rect(). The update function performs hardware
writes using regmap_bulk_write() on sleepable I2C/SPI buses.

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823111959.1702=
9-1-amit.barzilai22@gmail.com?part=3D2
