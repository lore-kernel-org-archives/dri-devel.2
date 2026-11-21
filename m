Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96945606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYticIY2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA0210E39A;
	Sat, 21 Nov 2026 08:06:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3539610E39A
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 08:06:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E4CB60E07;
 Sat, 21 Nov 2026 08:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27621F000C4;
 Sat, 21 Nov 2026 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795248394;
 bh=jgE/AwLMjN9DPCZRytHYmoB968E//35pNXj9glDKVeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KYticIY22KKsHKl6pA2C8GfgzzWFpNSCO38hPLf8b9Gzr4raAG5DwurfTUdCEVuDd
 cV00DIZGzOSBuChVbKVkqG32jtG0uPtoaCOHI41hQD9X3GYcwqk350WDYKdIN6sfGZ
 DH1GejuVXx9pljE5Y7eZLYn5JmNXU+l9rLjBn0sfvbUoqH6AQKDugeYRmzA8fa6hGJ
 bhgc6as6oKiJ5NsDwlEKCagzAqorFWeNpG77/uzrOL4DVIe0Q0DmUvkKP/UNhHVWop
 8U03POeveXhOhEGjjvilV52qdtktPwxPb241PZuKggWJdM+Butp16JF/h85wCE16h4
 k8Uvw0vbff6Cg==
Message-ID: <sashiko-outbox-226819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/17] drm/spacemit: add Saturn DPU KMS pipeline
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com
In-Reply-To: <20261121-k3-display-v3-10-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-10-ec419e8e96b8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 08:06:33 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/spacemit: premature event send in
  spacemit_crtc_atomic_disable()
- [High] drm/spacemit: premature event arming in
  spacemit_crtc_atomic_flush() and ISR
- [High] drm/spacemit: stale INT_VSYNC not cleared in
  spacemit_crtc_enable_vblank()
- [Medium] drm/spacemit: unbind before poll_fini in
  spacemit_drm_master_bind()
- [Medium] drm/spacemit: composer dst_w and dst_h left at 0 when no
  plane is visible
- [Medium] drm/spacemit: vblank not reset due to drm_vblank_init()
  ordering
--

commit c4c8906d170c5bfb4e5c852ca468ddf4805b4d47
Author: Cody Kang <codykang@vsit.ai>

drm/spacemit: add Saturn DPU KMS pipeline

This commit adds the atomic KMS CRTC and primary plane implementation,
runtime PM hooks, and component master bind/unbind logic for the Saturn
DPU.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/s=
pacemit/spacemit_crtc.c
> new file mode 100644
> index 0000000000000..c1257444dd150
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c
> @@ -0,0 +1,589 @@

[ ... ]

> +static void spacemit_crtc_atomic_disable(struct drm_crtc *crtc,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state =3D
> +			drm_atomic_get_new_crtc_state(state, crtc);
> +	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
> +	struct drm_device *drm =3D a_crtc->crtc.dev;
> +	struct spacemit_drm_private *priv =3D drm->dev_private;
> +	int idx;
> +
> +	if (drm_dev_enter(drm, &idx)) {
> +		spacemit_dpu_uninit(a_crtc);
> +		drm_dev_exit(idx);
> +	}
> +
> +	drm_crtc_vblank_off(&a_crtc->crtc);
> +
> +	/* A commit may still be waiting for CFG_RDY: stop its watchdog. */
> +	timer_delete_sync(&a_crtc->cfg_rdy_timer);
> +
> +	pm_runtime_put_sync(priv->dev);
> +
> +	/* No further vblank will come; complete the disable event here. */
> +	spacemit_dpu_complete_event(a_crtc);
> +	spin_lock_irq(&drm->event_lock);
> +	if (crtc_state->event) {
> +		drm_crtc_send_vblank_event(crtc, crtc_state->event);
> +		crtc_state->event =3D NULL;
> +	}
> +	spin_unlock_irq(&drm->event_lock);
> +}

[Severity: High]
Does sending crtc_state->event without checking !crtc_state->active
complete the vblank event prematurely during an active-to-active modeset?

When changing modes on an active CRTC, drm_atomic_helper_commit_modeset_dis=
ables()
calls spacemit_crtc_atomic_disable() before spacemit_crtc_atomic_enable()
and spacemit_crtc_atomic_flush() run.  Consuming crtc_state->event here
delivers the event and signals commit->flip_done before the new mode is
programmed, allowing a subsequent non-blocking commit to overwrite the
2-slot command-list ring before the engine takes the modeset lists.

[ ... ]

> +static void spacemit_crtc_atomic_flush(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state =3D
> +			drm_atomic_get_new_crtc_state(state, crtc);
> +	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
> +	struct spacemit_drm_private *priv =3D crtc->dev->dev_private;
> +	int idx;
> +
> +	/*
> +	 * The event releases the next commit, which rewrites the other
> +	 * command list and points the engine at it. Hold the event until
> +	 * CFG_RDY says the engine has taken this commit's lists; the
> +	 * interrupt then arms it for the following vblank.
> +	 */
> +	spin_lock_irq(&crtc->dev->event_lock);
> +	if (crtc_state->event) {
> +		if (drm_crtc_vblank_get(crtc) =3D=3D 0)
> +			a_crtc->event =3D crtc_state->event;
> +		else
> +			drm_crtc_send_vblank_event(crtc, crtc_state->event);
> +		crtc_state->event =3D NULL;
> +	}
> +	spin_unlock_irq(&crtc->dev->event_lock);
> +
> +	/* clocks_on is false here only after a failed power-up. */
> +	if (priv->clocks_on && drm_dev_enter(crtc->dev, &idx)) {
> +		spacemit_dpu_run(crtc, state);
> +		drm_dev_exit(idx);
> +	} else {
> +		spacemit_dpu_complete_event(a_crtc);
> +	}
> +}

[Severity: High]
Can a_crtc->event be armed and delivered before the hardware takes the new
command lists?

spacemit_crtc_atomic_flush()
  spin_lock_irq(&crtc->dev->event_lock)
  drm_crtc_vblank_get(crtc)
  a_crtc->event =3D crtc_state->event
  spin_unlock_irq(&crtc->dev->event_lock)
  <hardirq>
    spacemit_dpu_online_isr()
      if (irq_raw & INT_CFG_RDY)
        drm_crtc_arm_vblank_event(..., a_crtc->event)  <-- armed early
      if (irq_raw & INT_VSYNC)
        drm_crtc_handle_vblank(...)                    <-- sent early
  spacemit_dpu_run()
    saturn_hee_conf_dpuctrl()
    saturn_hee_clr_int_sts(..., INT_CFG_RDY)
    saturn_hee_cfg_ready()

spacemit_dpu_online_isr() inspects the unmasked DPU_ONLINE_IRQ_STS
register.  If an enabled interrupt (such as INT_VSYNC) fires after
event_lock is dropped and before spacemit_dpu_run() clears a leftover
INT_CFG_RDY status bit and raises both_cfg_rdy, the ISR sees INT_CFG_RDY
and arms a_crtc->event before the CRTC command list is even submitted.

In addition, because spacemit_dpu_online_isr() handles INT_CFG_RDY before
INT_VSYNC and there is no get_vblank_counter hook, when both bits are set
in irq_raw, drm_crtc_arm_vblank_event() arms the event for vblank->count + 1
and the immediately following drm_crtc_handle_vblank() increments
vblank->count and delivers it in the same interrupt instead of at the next
vblank, releasing flip_done while the command list is still in use.

> +
> +static int spacemit_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	saturn_hee_enable_irq(to_spacemit_crtc(crtc), INT_VSYNC, true);
> +
> +	return 0;
> +}

[Severity: High]
Does unmasking INT_VSYNC without clearing DPU_ONLINE_IRQ_STS first fire a
spurious mid-frame vblank interrupt?

As noted in saturn_hee_irq_enable(), DPU_ONLINE_IRQ_STS latches status
bits while masked and fires as soon as the mask opens, but
saturn_hee_irq_enable() only clears INT_UNDERRUN | INT_CFG_RDY:

drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c:saturn_hee_irq_enable() {
	mask =3D saturn_hee_get_irq_bit(INT_UNDERRUN) |
	       saturn_hee_get_irq_bit(INT_CFG_RDY);
	if (enable) {
		...
		regmap_write(priv->hwdev->regmap,
			     DPU_INT_BASE_ADDR + DPU_ONLINE_IRQ_STS, mask);
	}
}

Whenever vblank has been disabled while the CRTC is running, the next
frame latches INT_VSYNC in DPU_ONLINE_IRQ_STS.  Re-enabling vblank then
immediately raises an interrupt mid-frame, incrementing the software
vblank counter with a mid-frame timestamp or completing an event armed by
INT_CFG_RDY in the same ISR call before the actual vblank.

[ ... ]

> +	drm_mode_config_reset(drm);
> +
> +	ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to initialize vblank\n");
> +		goto err_unbind_all;
> +	}
> +
> +	drmm_kms_helper_poll_init(drm);
> +	drm_helper_hpd_irq_event(drm);
> +
> +	enable_irq(priv->irq_online);
> +
> +	ret =3D drm_dev_register(drm, 0);
> +	if (ret < 0)
> +		goto err_disable_irq;
> +	drm_client_setup(drm, NULL);
> +
> +	return 0;
> +
> +err_disable_irq:
> +	disable_irq(priv->irq_online);
> +
> +err_unbind_all:
> +	component_unbind_all(dev, drm);
> +err_dc:
> +	/*
> +	 * .shutdown tests priv->ddev; never leave it on a half-initialised
> +	 * device.
> +	 */
> +	priv->ddev =3D NULL;
> +	priv->a_crtc =3D NULL;
> +	drm_dev_put(drm);
> +	return ret;
> +}

[Severity: Medium]
Does calling drm_mode_config_reset() before drm_vblank_init() leave
vblank->inmodeset unset while the CRTC is initially disabled?

drm_mode_config_crtc_create_state() only calls drm_crtc_vblank_reset()
when drm_dev_has_vblank() is true, which requires dev->num_crtcs to have
been set by drm_vblank_init().  With the current order, drm_vblank_get()
on the disabled CRTC succeeds instead of returning -EINVAL and enables
vblank while the DPU is powered off.  Calling drm_vblank_init() before
drm_mode_config_reset() avoids this.

[Severity: Medium]
If drm_dev_register() fails, does err_disable_irq unbind the components
while output polling is still active?

drmm_kms_helper_poll_init() and drm_helper_hpd_irq_event() start output
polling before drm_dev_register(), but the error path runs
component_unbind_all() before drm_dev_put() invokes the drmm poll release
action, unlike spacemit_drm_master_unbind() which calls
drm_kms_helper_poll_fini() before component_unbind_all().

[ ... ]

> diff --git a/drivers/gpu/drm/spacemit/spacemit_planes.c b/drivers/gpu/drm=
/spacemit/spacemit_planes.c
> new file mode 100644
> index 0000000000000..c49a2e1572771
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_planes.c
> @@ -0,0 +1,332 @@

[ ... ]

> +static void spacemit_plane_atomic_update(struct drm_plane *plane,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_state =3D
> +			drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *crtc_state =3D
> +			drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +	struct spacemit_drm_private *priv =3D plane->dev->dev_private;
> +	int idx;
> +
> +	if (priv->clocks_on && drm_dev_enter(plane->dev, &idx)) {
> +		/* A plane moved off the screen has no rectangle to program. */
> +		if (new_state->visible)
> +			spacemit_plane_program(plane, new_state,
> +					       &crtc_state->adjusted_mode);
> +		else
> +			spacemit_plane_off(plane, new_state->crtc);
> +		drm_dev_exit(idx);
> +	}
> +}

[Severity: Medium]
When a CRTC is enabled with no visible plane (disabled or clipped
off-screen), do the composer output dimensions CMPS_X_REG dst_w and dst_h
remain at 0?

saturn_init_regs() enables CMPS_X_REG (module_enable =3D 1) and
saturn_hee_conf_dpuctrl() sets POSTPIPE_REG m_inwidth and m_inheight to
mode->hdisplay and mode->vdisplay, but CMPS_X_REG dst_w and dst_h are only
written in saturn_hee_plane_update_hw_channel():

drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c:saturn_hee_plane_update_hw_ch=
annel() {
	...
	base =3D CMP1_BASE_ADDR;
	dpu_write(hwdev, CMPS_X_REG, base, dst_w, mode->hdisplay, cl_cmp);
	dpu_write(hwdev, CMPS_X_REG, base, dst_h, mode->vdisplay, cl_cmp);
	...
}

Skipping spacemit_plane_program() when new_state->visible is false leaves
the composer configured for a 0x0 output feeding a full-mode postpipe and
timing generator, causing a pipeline dimension mismatch and display
underrun.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-k3-display=
-v3-0-ec419e8e96b8@gmail.com?part=3D10
