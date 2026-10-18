Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520A6CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865F210E0E4;
	Sun, 18 Oct 2026 16:09:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FE710E4C7
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 16:08:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D015443279;
 Sun, 18 Oct 2026 16:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890B91F000C4;
 Sun, 18 Oct 2026 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792339738;
 bh=0r8vbtwlfXTem3JjhBW9EI2vnrW/sgOSTEcjtiyJgas=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HyCKzJVcIvN22h5j9xvRPNGCRHPiG6MsxXtgvkNwWxYkSMGodYdaQBqNyTi6eYmxu
 4BJYFylx+W4pa/lvcbsQz9tTHqn2I0YHUBanesYGGYc9aVm8PVoHKxKFHTSzoiBOFJ
 ZzlvqQqQQcT7XBC1HAqfr9wD6w41mBzudh2e1jGWTCnsFGk8MItdjS1jf6AfIczTVN
 L7J1En5y/eLNpBWIfT3nqd3gUwal5uAPPV0PdAXQNIlF+7zIVoSyBZASizY4q+XW2q
 UwXRBKapu0wVuyU+oPVvslgoFmz16lXvPhFzaf+SgNSVGcR3y3I6plBM/aHWV1zgpa
 +P0u58j0QW5pQ==
Message-ID: <sashiko-outbox-176261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: keep vblank enabled when entering self
 refresh
To: =?utf-8?b?UmFtw7NuIEplc8O6cyBNaXJhbmRh?= <ramonjesusmiranda@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261018155423.1299629-1-ramonjesusmiranda@gmail.com>
References: <20261018155423.1299629-1-ramonjesusmiranda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:08:58 +0000
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
- [High] drm/msm/dpu: missing drm_crtc_vblank_off() in dpu_crtc_disable() f=
rom PSR
- [High] drm/msm/dpu: keeping vblank on in dpu_crtc_disable() causes uncloc=
ked MMIO
--

commit 520cd497636d4c5f54127317e7ab1594f34dcf4a
Author: Ram=C3=B3n Jes=C3=BAs Miranda <ramonjesusmiranda@gmail.com>

drm/msm/dpu: keep vblank enabled when entering self refresh

This commit skips calling drm_crtc_vblank_off() in dpu_crtc_disable() when
entering self-refresh so that vblank remains enabled and avoids the warning=
 in
drm_atomic_helper_commit_crtc_disable().

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 77a2d1f6700d0..eedcd21b936c2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1212,8 +1212,13 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>  		return;
>  	}
> =20
> -	/* Disable/save vblank irq handling */
> -	drm_crtc_vblank_off(crtc);
> +	/*
> +	 * Disable/save vblank irq handling, unless we are entering self
> +	 * refresh: the DRM core expects vblank to stay enabled then and
> +	 * warns ("driver disabled vblank in self-refresh") otherwise.
> +	 */
> +	if (!crtc->state->self_refresh_active)
> +		drm_crtc_vblank_off(crtc);

[Severity: High]
What happens if the CRTC is later disabled while it is in self-refresh mode
(for example via DPMS off, blanking, modeset, or system suspend, where
old_crtc_state->self_refresh_active is true and
new_crtc_state->self_refresh_active is false)?

Earlier in dpu_crtc_disable(), the old_crtc_state->self_refresh_active bran=
ch
detaches the encoder and returns early:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_disable()
	if (old_crtc_state->self_refresh_active) {
		drm_for_each_encoder_mask(encoder, crtc->dev,
					old_crtc_state->encoder_mask) {
			dpu_encoder_assign_crtc(encoder, NULL);
		}
		return;
	}

Because drm_crtc_vblank_off(crtc) was skipped when entering self-refresh and
the subsequent disable returns early without calling drm_crtc_vblank_off(cr=
tc)
either, won't drm_atomic_helper_commit_crtc_disable() see
drm_crtc_vblank_get(crtc) return 0 instead of -EINVAL and trigger:

	WARN_ONCE(ret !=3D -EINVAL, "driver forgot to call drm_crtc_vblank_off()\n=
");

while leaving vblank enabled on the disabled CRTC after dpu_enc->crtc has b=
een
cleared to NULL? With the encoder detached, subsequent calls to
dpu_crtc_get_vblank_counter() or dpu_crtc_get_scanout_position() will log
"no encoder found for crtc", and dpu_encoder_toggle_vblank_for_crtc() will =
no
longer match dpu_enc->crtc =3D=3D crtc to disable the vblank IRQ or drop
phys_enc->vblank_refcount.

[Severity: High]
Also, is it safe to leave DRM vblank enabled across self-refresh entry while
the DPU encoder, CRTC, and clocks are powered down?

When entering self-refresh, dpu_encoder_virt_atomic_disable() stops the tim=
ing
engine, disables encoder IRQs, and drops the encoder runtime PM reference v=
ia
_dpu_encoder_resource_disable(), and dpu_crtc_disable() drops the CRTC runt=
ime
PM reference via pm_runtime_put_sync(crtc->dev->dev).

Because dpu_kms sets dev->vblank_disable_immediate =3D true, vblank->enable=
d is
false and vblank->refcount is 0 when the idle timer enters self-refresh. Wi=
th
drm_crtc_vblank_off(crtc) skipped here, drm_atomic_helper_commit_crtc_disab=
le()
immediately calls:

	drm_crtc_vblank_get(crtc)
	  -> drm_vblank_enable()
	    -> msm_crtc_enable_vblank()
	      -> vblank_ctrl_queue_work(priv, crtc, true)
	drm_crtc_vblank_put(crtc)

Since disable_immediate is set, drm_crtc_vblank_put() leaves vblank->enabled
as true (waiting for a hardware vblank interrupt that cannot fire while the
timing generator is stopped), and vblank_ctrl_worker runs asynchronously on
priv->kms->wq without holding a runtime PM reference:

	vblank_ctrl_worker()
	  -> dpu_crtc_vblank(crtc, true)
	    -> dpu_encoder_toggle_vblank_for_crtc()
	      -> dpu_encoder_phys_vid_control_vblank_irq()
	        -> dpu_core_irq_register_callback()
	          -> dpu_hw_intr_enable_irq_locked()

Once msm_atomic_commit_tail() finishes and drops the last runtime PM refere=
nce
in dpu_kms_disable_commit(), dpu_runtime_suspend() disables the DPU clocks.
Can vblank_ctrl_worker (or userspace calling DRM_IOCTL_WAIT_VBLANK or
DRM_IOCTL_CRTC_GET_SEQUENCE while in PSR) then perform unclocked MMIO writes
in dpu_hw_intr_enable_irq_locked() and unclocked MMIO reads of INTF_LINE_CO=
UNT
in dpu_crtc_get_scanout_position() -> dpu_hw_intf_get_line_count(), while a=
lso
incrementing phys_enc->vblank_refcount on the disabled encoder?

> =20
>  	drm_for_each_encoder_mask(encoder, crtc->dev,
>  				  old_crtc_state->encoder_mask) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018155423.1299=
629-1-ramonjesusmiranda@gmail.com?part=3D1
