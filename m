Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE52C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEF310F24D;
	Thu, 16 Jul 2026 09:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H+sbOEka";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C5B10F253
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:15:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B93840F47;
 Thu, 16 Jul 2026 09:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6691F000E9;
 Thu, 16 Jul 2026 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784193333;
 bh=plMFoY+CiPGxtsDGv04mebo0eiH0ehL7s82NqCiUi9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H+sbOEka0hRhtzZ/SWOzfDCKdW4AXiKTkCaP74EuSf7XVs0g5Z1jtmXFQ4CZRtCFP
 EFvyWybJwhCfEw/MIhB6l9Sp9STOVvcpZuDNULGxYkgkUIzQ1eprinODB04OPzILhm
 PEcDTl8Ht4h5g77f98FXpjvIyyQKa9rhX4C6lLaRjx9+qQr9DOHU6RkyQ6RvYLwvXn
 OJDuuwMU03Ucv9Atof8P8e1ZrhXvPU22/lL5fgCExS8TU7zk1qhFFA4QNtvdeUdYQt
 S3y5imq18xnIHCk6lPNI2YnfMNknWBKkCZusowtyDY+LPOpKZf2KdqwiDN9sP861uf
 n9YCLzkI1rotQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] drm/arcpgu: replace struct
 drm_simple_display_pipe with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260716-drm-simple-kms-removal-v2-1-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-1-1133a8fc3785@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:15:32 +0000
Message-Id: <20260716091533.1C6691F000E9@smtp.kernel.org>
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
- [High] Use-After-Free in debugfs when reading CRTC state without a lock
- [High] Unchecked `encoder_node` passed to `of_drm_find_and_get_bridge()`
- [Medium] Dynamic pixel format changes will not be programmed into the har=
dware
--

--- Patch [1]: [PATCH v2 1/8] drm/arcpgu: replace struct drm_simple_display=
_pipe with regular atomic helpers ---
commit 053328e64a955beacd393bc82052adf8a231ec8a
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic help=
ers
   =20
This replaces the deprecated simple-KMS display pipe interface with regular
atomic helpers. It instantiates the plane, CRTC, and encoder directly.

> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb75..e0cce4798f3ed 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
> [ ... ]
> @@ -218,35 +223,95 @@ static void arc_pgu_disable(struct drm_simple_displ=
ay_pipe *pipe)
> [ ... ]
> +static int arcpgu_plane_helper_atomic_check(struct drm_plane *plane,
> +					    struct drm_atomic_commit *commit)
> +{
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
commit, plane);
> +	struct drm_crtc *crtc =3D plane_state->crtc;
> +	struct drm_crtc_state *crtc_state =3D NULL;
> +
> +	if (crtc)
> +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, crtc);
> +
> +	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, false);
> +}

[Severity: Medium]
Will dynamic pixel format changes be programmed into the hardware with this
check?

When a DRM client issues an atomic commit that only changes the framebuffer=
's
pixel format without changing the display mode, this function delegates to
drm_atomic_helper_check_plane_state() but doesn't check if fb->format
changed.

Because crtc_state->mode_changed isn't set to true on format changes, and
the hardware's pixel format register is only updated in arc_pgu_mode_set()
during atomic_enable(), does this mean the hardware might continue using the
old format and cause display corruption? The previous simple-kms helper
handled this by forcing a modeset when the format changed.

> [ ... ]
> @@ -285,6 +353,30 @@ static int arcpgu_load(struct arcpgu_drm_private *ar=
cpgu)
> [ ... ]
>  	/*
>  	 * There is only one output port inside each device. It is linked with
>  	 * encoder endpoint.
> @@ -293,29 +385,24 @@ static int arcpgu_load(struct arcpgu_drm_private *a=
rcpgu)
>  	if (endpoint_node) {
>  		encoder_node =3D of_graph_get_remote_port_parent(endpoint_node);
>  		of_node_put(endpoint_node);
> -	} else {
> -		connector =3D &arcpgu->sim_conn;
> -		dev_info(drm->dev, "no encoder found. Assumed virtual LCD on simulatio=
n platform\n");
> -		ret =3D arcpgu_drm_sim_init(drm, connector);
> -		if (ret < 0)
> -			return ret;
> -	}
> =20
> -	ret =3D drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe_=
funcs,
> -					   arc_pgu_supported_formats,
> -					   ARRAY_SIZE(arc_pgu_supported_formats),
> -					   NULL, connector);
> -	if (ret)
> -		return ret;
> -
> -	if (encoder_node) {
>  		/* Locate drm bridge from the hdmi encoder DT node */
>  		struct drm_bridge *bridge __free(drm_bridge_put) =3D
>  			of_drm_find_and_get_bridge(encoder_node);

[Severity: High]
Could this lead to attaching an unrelated bridge or indefinitely deferring
the probe?

In arcpgu_load(), if endpoint_node has no remote parent, encoder_node will
be NULL. In the previous code, the bridge lookup was guarded by an explicit
if (encoder_node) check. Now, of_drm_find_and_get_bridge(NULL) is called
unconditionally.

If a NULL node is passed, the bridge lookup iterates through registered
bridges and might return the first bridge with a NULL of_node, incorrectly
attaching it. If none are found, it fails with -EPROBE_DEFER, which might
leave the system without a working display. Should this retain the
encoder_node check?

>  		if (!bridge)
>  			return -EPROBE_DEFER;

> [ ... ]
> @@ -342,7 +429,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, v=
oid *arg)
>  	struct drm_device *drm =3D node->minor->dev;
>  	struct arcpgu_drm_private *arcpgu =3D dev_to_arcpgu(drm);
>  	unsigned long clkrate =3D clk_get_rate(arcpgu->clk);
> -	unsigned long mode_clock =3D arcpgu->pipe.crtc.mode.crtc_clock * 1000;
> +	unsigned long mode_clock =3D arcpgu->crtc.state->mode.crtc_clock * 1000;

[Severity: High]
Does this introduce a use-after-free risk when reading the CRTC state?
   =20
In arcpgu_show_pxlclock(), the new code accesses arcpgu->crtc.state without
holding the crtc->mutex lock.

If a user reads the pxlclock debugfs file concurrently with a display mode
setting operation completing, drm_atomic_helper_swap_state() might swap out
the old CRTC state and free it asynchronously. Dereferencing this dynamical=
ly
allocated state pointer without synchronization could lead to a kernel oops.

The previous simple-KMS code avoided this by reading pipe.crtc.mode, which
is embedded in the CRTC struct itself and updated safely for legacy access.

>  	seq_printf(m, "hw  : %lu\n", clkrate);
>  	seq_printf(m, "mode: %lu\n", mode_clock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-drm-simple=
-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com?part=3D1
