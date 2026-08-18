Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C449CC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3912D10E299;
	Tue, 18 Aug 2026 08:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LK7Mjtiq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F3910E299
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:24:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E01A4601DE;
 Tue, 18 Aug 2026 08:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9311F000E9;
 Tue, 18 Aug 2026 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787041448;
 bh=xsxgb6Tfefw0GelnJsKe5SAhIdG3g4QgqPwDdniHK/U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LK7Mjtiq4jQfEHYpA5M2FBtW6Me00pZqGxTCH9l2JrjX1PlVfTriUsqgM2MjjKCeV
 MkjBLx7pFEMq1+PxO5b82weiUi8EAuwToY1vl2SjnsWsyquir6AbRjYi6v3eyHn4Fj
 TO7da3zbaoeehjc7Et2+Qn/MQUNHGxOIST0LoMpHWkNXrdrPs475VvT7oM6hqfIZOm
 rFevZIgPj4m3B8rYoHIbBJ8SlAYeDlBDZ2Pn40H1z2+di52EoQj83HzfD4uN34mXyN
 ia4Rb6lLsHeLyNa2JrjroQQ3KMFMJiHzvtlQMyHfV+x5VywbwaQ/cTc0lQPglauiTT
 NXAYdzx2tuAkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260818080626.30430-7-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-7-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 08:24:07 +0000
Message-Id: <20260818082408.4E9311F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `ssd133x_primary_plane_atomic_check` fails to call `drm_format_con=
v_state_reserve()`, forcing the subsequent atomic update phase to perform d=
ynamic memory allocation with `GFP_KERNEL` in an atomic context.
- [High] Sleeping functions (e.g., mutexes, slow bus I/O) are called from P=
lane and Encoder atomic callbacks, violating DRM atomic context requirement=
s.
- [High] Concurrent execution of sysfs backlight updates and DRM plane upda=
tes causes command stream corruption.
--

--- Patch [6]: [PATCH v4 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 s=
upport ---
commit 0d606a373153c3406138083714dbc3321e2a839d
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support

This commit introduces support for the Solomon SSD1351 RGB OLED controller
by adding a new SSD135X_FAMILY. It provides family-specific callbacks for
plane updates, disable paths, encoder enable paths, and backlight
management while accommodating the SSD1351's unique init sequence and
Write RAM command protocol.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index 61187a630a0d5..af1f8e21f159a 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

[ ... ]

> @@ -863,6 +968,44 @@ static int ssd133x_update_rect(struct ssd130x_device=
 *ssd130x,
>  	return ret;
>  }
> =20
> +static int ssd135x_update_rect(struct ssd130x_device *ssd130x,
> +			       struct drm_rect *rect, u8 *data_array,
> +			       unsigned int pitch)
> +{
> +	unsigned int x =3D rect->x1;
> +	unsigned int y =3D rect->y1;
> +	unsigned int columns =3D drm_rect_width(rect);
> +	unsigned int rows =3D drm_rect_height(rect);
> +	int ret;
> +
> +	/*
> +	 * The pixel layout is the same as for the ssd133x family: one 65k
> +	 * color (RGB565) pixel per Segment, sent Segment by Segment when the
> +	 * (default) horizontal address increment mode is used.
> +	 *
> +	 * But unlike the ssd133x family, which starts accepting pixel data as
> +	 * soon as the address window has been programmed, the ssd135x family
> +	 * needs an explicit Write RAM command before the data is written.
> +	 */
> +
> +	/* Set column start and end */
> +	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD135X_SET_COL_RANGE, x, x + col=
umns - 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set row start and end */
> +	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD135X_SET_ROW_RANGE, y, y + row=
s - 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ssd130x_write_cmd(ssd130x, 1, SSD135X_WRITE_RAM);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Write out update in one go since horizontal addressing mode is used =
*/
> +	return ssd130x_write_data(ssd130x, data_array, pitch * rows);
> +}

[Severity: High]
This is a pre-existing issue, but is this command sequence vulnerable to
concurrent access?

In ssd135x_update_rect(), a multi-step hardware programming sequence is
sent (column range, row range, Write RAM) followed by a bulk pixel data
transfer. There appears to be no driver-level lock synchronizing this
sequence.

If an unprivileged user concurrently writes to the sysfs backlight node, it
triggers ssd135x_update_bl(), sending a contrast command over the same bus.
If the contrast command interleaves after SSD135X_WRITE_RAM but before the
pixel data, could the OLED controller abort Write RAM mode and corrupt the
display output?

[ ... ]

> @@ -1245,6 +1427,45 @@ static void ssd133x_primary_plane_atomic_update(st=
ruct drm_plane *plane,
>  	drm_dev_exit(idx);
>  }
> =20
> +static void ssd135x_primary_plane_atomic_update(struct drm_plane *plane,
> +						struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, plane_state->crtc);
> +	struct ssd130x_crtc_state *ssd130x_crtc_state =3D  to_ssd130x_crtc_stat=
e(crtc_state);
> +	struct drm_framebuffer *fb =3D plane_state->fb;
> +	struct drm_atomic_helper_damage_iter iter;
> +	struct drm_device *drm =3D plane->dev;
> +	struct drm_rect dst_clip;
> +	struct drm_rect damage;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm, &idx))
> +		return;
> +
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
> +		goto out_drm_dev_exit;

[Severity: High]
This is a pre-existing issue, but does this code sleep in an atomic
context?

The DRM subsystem guidelines specify that plane atomic update callbacks
execute in an atomic context where sleeping is forbidden. However,
ssd135x_primary_plane_atomic_update() calls drm_gem_fb_begin_cpu_access(),
which acquires a sleeping dma_resv ww_mutex lock.

Can this lead to kernel warnings or system hangs during display updates?

> +
> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
> +		dst_clip =3D plane_state->dst;
> +
> +		if (!drm_rect_intersect(&dst_clip, &damage))
> +			continue;
> +
> +		ssd135x_fb_blit_rect(fb, &shadow_plane_state->data[0], &dst_clip,
> +				     ssd130x_crtc_state->data_array,
> +				     &shadow_plane_state->fmtcnv_state);
> +	}

[Severity: High]
This is a pre-existing issue, but does this format conversion trigger a
GFP_KERNEL allocation in an atomic context?

Since ssd133x_primary_plane_atomic_check() (which is reused for this family)
does not call drm_format_conv_state_reserve() to pre-allocate memory, the
format conversion state is unallocated. When ssd135x_fb_blit_rect() is call=
ed
during the atomic update phase:

ssd135x_fb_blit_rect()
  drm_fb_xrgb8888_to_rgb565be()
    drm_fb_xfrm()

The underlying drm_fb_xfrm() function sees an unallocated state buffer and
dynamically allocates it using the GFP_KERNEL flag.

Could this cause sleeping in an atomic context and trigger kernel panics?

[ ... ]

> @@ -1626,6 +1881,31 @@ static void ssd133x_encoder_atomic_enable(struct d=
rm_encoder *encoder,
>  	ssd130x_power_off(ssd130x);
>  }
> =20
> +static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
> +					  struct drm_atomic_commit *state)
> +{
> +	struct drm_device *drm =3D encoder->dev;
> +	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(drm);
> +	int ret;
> +
> +	ret =3D ssd130x_power_on(ssd130x);

[Severity: High]
This is a pre-existing issue, but does this power-on sequence sleep during
an atomic enable callback?

Similar to the plane update callback, encoder atomic enable callbacks
execute in an atomic context. However, ssd135x_encoder_atomic_enable()
calls ssd130x_power_on(), which takes a mutex via regulator_enable(). It
also calls backlight_enable() which takes the backlight update_lock mutex,
and performs slow bus writes via ssd135x_init().

Are these sleeping operations safe here, or could they cause system
instability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818080626.3043=
0-1-amit.barzilai22@gmail.com?part=3D6
