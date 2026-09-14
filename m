Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFFAC88E6A
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200ED10E172;
	Mon, 14 Sep 2026 09:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GNHRYfUJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B0410E189
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:14:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5782343923;
 Mon, 14 Sep 2026 09:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023141F000FF;
 Mon, 14 Sep 2026 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789377283;
 bh=LrutReZ5R9lj/02OwAOFdnsGfMcThHjIY3yuMYn4ORw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GNHRYfUJUdoVjjWXzh++r4dV8YS5TozSqVqmo2Uv65sWYEd8pz20DEP8NFaPz/4mI
 kR/pe1ucZ5IlMoIV6bzklQn2rttLaZX/Oia3ZFz4660+7wlAgM0M/9JHU6yoVcqYWB
 nZ1HqJlZPUOSD7wwOWMoybF7EREtzRIivnGieuvRy9tyvfUHU0SyQwhyZd10kCJ7tW
 ehxUQyK1pY+Lsx36+jadIAFrY5xOK6Bs0H5JPllPWnsU2UUOwZMyOfkT/6nrtdloqZ
 RHfFyVi6cA2Mv5nxIw+VnyBeeSuAMW9cokP9Uyg0uaYZq+0/qaLaRLLgJ3ylGPkBR3
 CWH3gLY+zUZDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] drm/ssd130x: Change SSD133X color format to
 RGB565 from RGB332
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260914085931.66857-3-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
 <20260914085931.66857-3-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:14:42 +0000
Message-Id: <20260914091443.023141F000FF@smtp.kernel.org>
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
- [High] Missing `fmtcnv_state` buffer reservation in `ssd133x_primary_plan=
e_atomic_check` causes a `GFP_KERNEL` allocation in atomic context.
--

commit 58733b43936278b0113cbbd363c279ece2464617
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Change SSD133X color format to RGB565 from RGB332

SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
Switch the SSD133X data path to RGB565.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index feec4933e3e6b..cbf77a74c4fa0 100644
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
This is a pre-existing issue, but does this code cause a GFP_KERNEL allocat=
ion
in atomic context?

When the screen is updated, ssd133x_primary_plane_atomic_update() (which ru=
ns
in atomic context) calls ssd133x_fb_blit_rect() which in turn calls
drm_fb_xrgb8888_to_rgb565be().

This internally calls __drm_fb_xfrm(), which attempts a GFP_KERNEL allocati=
on
if the conversion buffer was not previously reserved:

drivers/gpu/drm/drm_format_helper.c:__drm_fb_xfrm() {
	if (!vaddr_cached_hint) {
		stmp =3D drm_format_conv_state_reserve(state, sbuf_len, GFP_KERNEL);
		if (!stmp)
			return -ENOMEM;
	}
}

Because ssd133x_primary_plane_atomic_check() omits the
drm_format_conv_state_reserve() call (unlike its ssd130x and ssd132x varian=
ts):

drivers/gpu/drm/solomon/ssd130x.c:ssd133x_primary_plane_atomic_check() {
	...
	else if (!plane_state->visible)
		return 0;

	return 0;
}

Will this cause the allocation to be unconditionally executed in atomic con=
text
on the first frame update?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914085931.6685=
7-1-amit.barzilai22@gmail.com?part=3D2
