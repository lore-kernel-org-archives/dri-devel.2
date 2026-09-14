Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F573C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4900C10E146;
	Mon, 14 Sep 2026 09:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GhrfIwCx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF1510E146
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:28:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98CFD60008;
 Mon, 14 Sep 2026 09:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BFE1F000FF;
 Mon, 14 Sep 2026 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789378079;
 bh=KYESfg63gjpRbgWZixWJGeMAWRHYqoxx1w+21M9gsSg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GhrfIwCxcnz+b0rZj4XFT31QmrAofJU7QbAyXIrCvQcC/DEnVXoG/2KQyBM35wqq8
 lSACGAWGhtf+N14K8uvTNWealacWL7sTsqqYAffTFs1PItby2F+FKmFoa3CRMPvC0W
 Fb6gqiO9NsDRMMNptz7VGcFz+mvwycNYMP0M5gz3BZ+LK8nCWYmAGDlvuPMdrV1XQT
 0aVdCO0hA0Cvb0gp0qaUD+MVMqspNE7SizakrX2uWN+rdFha5KFfYT+17xuGjnMGlY
 VzUY6RA7DfDzVGt3NC0SmN5sUvENL5d084fT1E7y6vr+toYXI1OTL4+GF0TM4aR1t4
 gFRBfoVc9STZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260914085931.66857-7-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
 <20260914085931.66857-7-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:27:58 +0000
Message-Id: <20260914092759.22BFE1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Lack of locking between backlight sysfs updates and DRM plane upda=
tes causes non-atomic display command sequences and hardware state corrupti=
on.
- [High] Plane atomic update callback calls sleeping functions (DMA-buf acc=
ess and regmap I2C/SPI transfers) in atomic context.
- [Medium] Plane atomic_disable callback uses new plane state to fetch CRTC=
, failing to clear screen when the plane is unassigned.

Pre-existing issues:
- [High] Missing format conversion buffer preallocation leads to a GFP_KERN=
EL allocation inside the atomic_update callback.
--

commit ab4ccb74bbc041abd3279239df7704ec6c09b2b7
Author: Amit Barzilai <amit.barzilai22@gmail.com>
Subject: drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support

Adds support for the Solomon SSD1351 128x128 RGB OLED controller as a new
SSD135X_FAMILY. Reuses the ssd130x plane, CRTC, and encoder infrastructure
but introduces custom primary plane update, disable, initialization, and
backlight callbacks to accommodate differences in command protocols.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index fd13250ef56a9..324467ae9309f 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
[ ... ]
> @@ -271,6 +310,18 @@ static int ssd130x_write_cmds(struct ssd130x_device =
*ssd130x, const u8 *cmd,
>  	unsigned int i;
>  	int ret;
> =20
> +	if (!len)
> +		return 0;
> +
> +	if (ssd130x->device_info->cmd_params_are_data) {
> +		ret =3D regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
> +		/* A command with no parameters is complete after its opcode. */
> +		if (ret || len =3D=3D 1)
> +			return ret;
> +
> +		return ssd130x_write_data(ssd130x, cmd + 1, len - 1);
> +	}
> +

[Severity: High]
Is it possible for a concurrent sysfs backlight update to interleave its
commands here?

Since the regmap API drops its internal lock between the regmap_write call
for the opcode and the ssd130x_write_data call for the parameters, a
concurrent ssd135x_update_bl call (which lacks driver-level locks) could
inject its own opcode into the hardware.

This interleaving could cause the hardware to misinterpret the backlight
opcode as a parameter, potentially corrupting the state machine and causing
display artifacts or permanent link failure until device reset. Does this
sequence require a driver-level lock to remain atomic?

[ ... ]
> @@ -1247,6 +1432,45 @@ static void ssd133x_primary_plane_atomic_update(st=
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
Does this function run in atomic context during non-blocking commits?

Calling drm_gem_fb_begin_cpu_access here might block on dma-buf
reservations or fences. Since DRM guidelines specify that plane atomic
updates must not sleep, this could lead to system instability or deadlocks.

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

[Severity: High]
This is a pre-existing issue, but does this path trigger a sleeping
allocation in atomic context?

The ssd133x_primary_plane_atomic_check function (reused by this family)
can return without calling drm_format_conv_state_reserve. During the
subsequent non-blocking commit, this blit call ultimately invokes
drm_fb_xfrm, which will dynamically allocate the conversion buffer using
krealloc with GFP_KERNEL if it wasn't preallocated.

[Severity: High]
Does this blit operation also trigger sleeping hardware writes?

The ssd135x_fb_blit_rect function sends data using regmap bulk writes over
an SPI or I2C bus. Since bus transfers are typically sleeping operations,
calling them from an atomic update callback might crash the system or
cause a deadlock.

> +	}
> +
> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +
> +out_drm_dev_exit:
> +	drm_dev_exit(idx);
> +}
> +
[ ... ]
> @@ -1319,6 +1543,31 @@ static void ssd133x_primary_plane_atomic_disable(s=
truct drm_plane *plane,
>  	drm_dev_exit(idx);
>  }
> =20
> +static void ssd135x_primary_plane_atomic_disable(struct drm_plane *plane,
> +						 struct drm_atomic_commit *state)
> +{
> +	struct drm_device *drm =3D plane->dev;
> +	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(drm);
> +	struct drm_plane_state *plane_state;
> +	struct drm_crtc_state *crtc_state;
> +	struct ssd130x_crtc_state *ssd130x_crtc_state;
> +	int idx;
> +
> +	plane_state =3D drm_atomic_get_new_plane_state(state, plane);
> +	if (!plane_state->crtc)
> +		return;

[Severity: Medium]
Will this skip clearing the screen when a plane is disabled?

When a plane is detached from a CRTC during a mode set or plane disable
operation, the DRM core sets the new plane state crtc field to NULL.

Checking the new plane state for a valid crtc here will cause an early
return, leaving stale pixel data frozen on the screen indefinitely. Should
this function check the old plane state crtc field instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914085931.6685=
7-1-amit.barzilai22@gmail.com?part=3D6
