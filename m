Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A03606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvNOL0Qz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B57910EE83;
	Tue, 10 Nov 2026 08:12:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA8310EE83
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:11:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA32D4022D;
 Tue, 10 Nov 2026 08:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3E71F008A5;
 Tue, 10 Nov 2026 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794298315;
 bh=LMRGxyiVzeg4rLe/xhj8gf6Vz3TI7nO8vgFSeQqW4sA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cvNOL0QzCL2Yzx7arJPqFHzkNddaV4JXTSICUlgnO/dEU4VQlPi7AkVMJxRxo6Tkr
 1KFDVZJYLOh2LKuuDfia9q/FlJAiZOzs3riOau7vou+Ie3c3cJn5MJ9BdR//ofzUb3
 ZX+9+2uDTVln6x3cFYeUzBff7T/9d4BMqo6DDETTJWe+hSIrEDdMapDVOlzZXKark0
 cIWPSSdTwQwfi9P0AKFpZuo8aStvNjw/9VaQGp48O5awcFN61/e023o3K1vBerGB5b
 gvy/PH3+Ggl5wjZhW8gjErP7HIGIkOzA1R0i+eklwzliySSduhTcTDUGPrF+JKvHsE
 MZhACMZeACiTw==
Message-ID: <sashiko-outbox-206573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] drm/rockchip: vop2: Report POST_BUF_EMPTY at most
 once per frame
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vop2-fixes-v1-5-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
 <20261110-vop2-fixes-v1-5-d336e9dd90d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:11:52 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] drm/rockchip: vop2: stale FS status in
  vop2_crtc_handle_post_buf_empty()
- [Medium] drm/rockchip: vop2: VP_INT_FS_FIELD left enabled across CRTC
  disable
- [Low] drm/rockchip: vop2: vop2_crtc_enable_vblank() clears pending FS
  irq
- [Low] drm/rockchip: vop2: missing Fixes trailer for POST_BUF_EMPTY irq
  storm
--

commit 225fca8d582460d4af5df41d587daa2368d818f1
Author: Arun Iyengar <aiyengar1990@gmail.com>

> drm/rockchip: vop2: Report POST_BUF_EMPTY at most once per frame
>
> POST_BUF_EMPTY is raised for every line on which the post processing
> stage of a video port finds no data. The interrupt handler only
> rate-limits the error message and leaves the interrupt enabled, so an
> underflowing video port keeps the CPU in the interrupt handler 50000 to
> 300000 times per second, for as long as the configuration that causes
> the underflow stays in place (e.g. 120000 interrupts per second for
> 3840x2160@120 with two full screen layers on one AXI port).
>
> Mask POST_BUF_EMPTY when it fires and unmask it at the next frame start.
> The frame start (FS) interrupt is enabled for that frame even when
> vblank reporting is off, and disabled again once POST_BUF_EMPTY is
> re-armed. A new per video port lock serialises the interrupt enable
> bookkeeping between the interrupt handler and the vblank callbacks.
> The error is still reported, now at most once per frame and video port.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

[Severity: Low]
This fixes a per-line interrupt storm on underflowing video ports.  Should
this include:

  Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 9aeb90c6aa4b1..3323e50224c55 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -841,6 +841,48 @@ static void vop2_crtc_disable_irq(struct vop2_video_=
port *vp, u32 irq)
>  	vop2_writel(vop2, RK3568_VP_INT_EN(vp->id), irq << 16);
>  }
> =20
> +/*
> + * POST_BUF_EMPTY is raised for every line the post processing stage fin=
ds
> + * no data for, so an underflowing video port can raise it 100000 times =
per
> + * second. Report it at most once per frame: mask it when it fires and
> + * unmask it at the next frame start, using the FS interrupt even when
> + * vblank reporting is off.
> + */
> +static void vop2_crtc_enable_post_buf_empty_irq(struct vop2_video_port *=
vp)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vp->irq_lock, flags);
> +	vp->post_buf_empty_masked =3D false;
> +	vop2_crtc_enable_irq(vp, VP_INT_POST_BUF_EMPTY);
> +	spin_unlock_irqrestore(&vp->irq_lock, flags);
> +}

[Severity: Medium]
Can VP_INT_FS_FIELD stay enabled permanently after a CRTC disable and
re-enable cycle?

If VP_INT_POST_BUF_EMPTY fires during the last frame of a video port
(either before drm_crtc_vblank_off() or while vop2_crtc_atomic_disable()
waits on vp->dsp_hold_completion), vop2_crtc_handle_post_buf_empty() sets
vp->post_buf_empty_masked =3D true and enables VP_INT_FS_FIELD.
drm_crtc_vblank_off() -> vop2_crtc_disable_vblank() then sees
vp->post_buf_empty_masked =3D=3D true and leaves VP_INT_FS_FIELD enabled in
RK3568_VP_INT_EN(vp->id) when the video port enters standby.

When the CRTC is later re-enabled (while another active video port kept
VOP2 powered on), vop2_crtc_enable_post_buf_empty_irq() resets
vp->post_buf_empty_masked =3D false without disabling VP_INT_FS_FIELD.  Once
vblank turns off, the video port runs with both vp->vblank_enabled and
vp->post_buf_empty_masked false while VP_INT_FS_FIELD fires an unhandled
interrupt on every frame.  In addition, vop2_crtc_atomic_disable() and the
err_put_enable_count error paths in vop2_crtc_atomic_enable() never disable
VP_INT_POST_BUF_EMPTY.

> +
> +static void vop2_crtc_handle_post_buf_empty(struct vop2_video_port *vp)
> +{
> +	struct vop2 *vop2 =3D vp->vop2;
> +
> +	spin_lock(&vp->irq_lock);
> +	vop2_crtc_disable_irq(vp, VP_INT_POST_BUF_EMPTY);
> +	vp->post_buf_empty_masked =3D true;
> +	/* don't clear a pending FS, it may carry a vblank event */
> +	vop2_writel(vop2, RK3568_VP_INT_EN(vp->id),
> +		    VP_INT_FS_FIELD << 16 | VP_INT_FS_FIELD);
> +	spin_unlock(&vp->irq_lock);
> +}

[Severity: Medium]
When vp->vblank_enabled is false, does unmasking VP_INT_FS_FIELD without
clearing RK3568_VP_INT_CLR(vp->id) immediately trigger a spurious mid-frame
FS interrupt?

VOP2 latches raw interrupt status even while an interrupt is masked, and
vop2_isr() / rk3576_vp_isr() only clear bits returned by the masked status
register RK3568_VP_INT_STATUS(vp->id).  While vblank reporting is disabled,
the raw VP_INT_FS_FIELD bit latched at the start of the current frame stays
set during active scanout.  Writing RK3568_VP_INT_EN(vp->id) here without
clearing RK3568_VP_INT_CLR(vp->id) causes VP_INT_FS_FIELD to fire
immediately on that stale status and call vop2_crtc_rearm_post_buf_empty()
mid-frame, allowing VP_INT_POST_BUF_EMPTY to fire a second time in the same
frame.

When vp->vblank_enabled is true, VP_INT_FS_FIELD is already enabled; when
!vp->vblank_enabled, calling vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD) will
clear the stale raw status before enabling it.

[ ... ]

> @@ -1668,8 +1710,12 @@ static const struct drm_plane_funcs vop2_plane_fun=
cs =3D {
>  static int vop2_crtc_enable_vblank(struct drm_crtc *crtc)
>  {
>  	struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&vp->irq_lock, flags);
> +	vp->vblank_enabled =3D true;
>  	vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD);
> +	spin_unlock_irqrestore(&vp->irq_lock, flags);
> =20
>  	return 0;
>  }

[Severity: Low]
Can vop2_crtc_enable_vblank() clear a pending VP_INT_FS_FIELD interrupt if
vp->post_buf_empty_masked is already true?

When vp->post_buf_empty_masked is true, VP_INT_FS_FIELD is already enabled
in hardware.  Calling vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD)
unconditionally writes RK3568_VP_INT_CLR(vp->id), which can drop a pending
frame-start interrupt that raced with vop2_crtc_enable_vblank() and delay
both vblank handling and vop2_crtc_rearm_post_buf_empty() by a frame.
Guard the vop2_crtc_enable_irq() call with if (!vp->post_buf_empty_masked),
matching vop2_crtc_disable_vblank().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vop2-fixes=
-v1-0-d336e9dd90d3@gmail.com?part=3D5
