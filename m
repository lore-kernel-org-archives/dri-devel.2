Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBD8C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFB810E659;
	Mon, 10 Aug 2026 06:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n6DR63i0";
	dkim-atps=neutral
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF3010E03E
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:59:41 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2ccb0e85312so4694825ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 17:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786237180; x=1786841980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CSGZDRV/MDgKNpbTE7r5kq+GmjODNqDTFUKIisa3q98=;
 b=n6DR63i017D5bDTUlZ0bUEzLPlljPZpZE90nNeJJJsVT+R+qQU4MDZgDT6TyFc0iAp
 Dq0y3+zh9kazPts9mAFTXsceT/zazPaAm5yPpVHbbfXyIpWf9Y/OpJ3kr68E3s4MleZo
 d/KZypxqer+HyEo2LHS6VYZklNi9/wkocsu/OqbCqBNmZL6BbF7GgM3qwMn2RozLPnLn
 yLbDj1P0ly2OI0nDaQYl35h/nN0oA2bm4F0BqfA66vl8cLXTYW7fAopThtvr1okb120k
 acoiGIRIIerJnG0wnGFUaEHc5Uwve6SDxo0oAnBXlPk8HfzKYop20j64PvtYAeqmjThw
 7gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786237180; x=1786841980;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CSGZDRV/MDgKNpbTE7r5kq+GmjODNqDTFUKIisa3q98=;
 b=Ee8EfU67XpxYf8hi/kFxOjMby0GAHW62Pwm8Gn6H8UgdUFCp4ywr663NTrJDEnNyKe
 STVdYaAos0rPDgdoEukJjn3kaLFVimfDT95lrjS7cw6jmroETpIlBBKI40WgS+d8BSYG
 GPW+OWAlIma0gWdcBlr+YyfhR/fW8n1OuZxQH2Znx1UMjkb6AShwUSF3n6q6RkVL+Fkw
 24aIMaWx2BAmeATtzAYZuHRVwDSuIA7gpRWkYy3dYpnBsteDnbHhwo2aHZsxATNa54jf
 k+gZdC1yAeVZD22bltIHL5J/jrRGCXcKzw3ckdN5FcuKM6Pg9HWxypWCoxzqTlX5rT1O
 knrg==
X-Gm-Message-State: AOJu0YwMyjldGBXkiNxMd7Q0B3hXevDV2GzFaudR7W36RvMwuupKVfIQ
 5cYDb6DyHIZz9w2blIdiTHgJXuoqNPqShxxHjgygp5wXGk2qcknKfNJe
X-Gm-Gg: AR+sD128eRTSmxLANSgHSyamnlhMYCUX7J1RPTcNvaBTyc2xt26RLzy0fY9kuz5BDFq
 iWX90sOujXtuf+80z1ufPKBuFvrd7tEkChBa7Q6vhHrgFyHDf/+5Pi5k2HEQnDj1t42bnf8kiYr
 tKAzm9/d+rx9XSulq0muJDVlH2RGo1yGUf6jfSYBts5QaDltm2XqkoytMuQY1Pw2rKU52zWBuVo
 qMOX/Tu4wPo8s2yji5Y+BE66CShIhJUe0iORsELie+JSQuk8WJJmovDYqnOnz3i+C+1GjmqYgim
 Qlz9iM/QsAx4yxOYqk8OKddjnQtdZ+l+0MrV5WbaOOEhKxCz3CW8FW9M9RaTGp+50N3w8gPpfNj
 rvBsuInoKOq8tllUyITKSCaNbAd91pU4fBXhLBqWNnxepEuFzoYLnIBvzPCCq/gEo7l5yroULYQ
 cyShOIt5Q6Gvkwxpe4ew6WtlMoxG/rSAwcGv6H+k8=
X-Received: by 2002:a17:902:e5c1:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2d2a845758amr103103385ad.2.1786237180433; 
 Sat, 08 Aug 2026 17:59:40 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14d959132sm21199675ad.34.2026.08.08.17.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 17:59:40 -0700 (PDT)
Date: Sun, 09 Aug 2026 08:59:34 +0800
Message-ID: <242adca6fe63a63e0f637da9603cde06.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, conor+dt@kernel.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, devicetree@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 10/17] drm/spacemit: add Saturn DPU KMS pipeline
In-Reply-To: <20260725050427.33AE91F000E9@smtp.kernel.org>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-10-6de34d80e86c@gmail.com>
 <20260725050427.33AE91F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, 25 Jul 2026 05:04:26 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
> - [High] Sleeping functions are called from CRTC atomic enable and disable callbacks, which execute in atomic context.
> - [High] TOCTOU race when updating the `clocks_on` flag and gating hardware clocks leads to MMIO stalls.
> - [High] Calling `devm_drm_dev_alloc` inside a component `bind` callback leaks the DRM device on rebinds.
> - [High] Enabling the DPU interrupt before hardware is initialized leads to an unhandled IRQ storm.
> - [High] `spacemit_plane_reset` bypasses the custom state destructor, leaking DMA coherent memory.
> - [High] `disable_irq()` is called before `drm_atomic_helper_shutdown()` during driver unbind, causing shutdown to hang.
> - [High] `spacemit_plane_atomic_check()` assigns RDMA channels based on unvalidated `zpos`, leading to channel collisions.
> - [High] Unconditional `spin_unlock_irq` used in atomic context improperly re-enables interrupts.
> - [Medium] Leaking DRM property blob references in `spacemit_crtc_duplicate_state` on error.
> - [Medium] Missing NULL check on `plane->state` in `spacemit_plane_atomic_duplicate_state` causes a crash if the state is missing.
> --
>
> --- Patch [10]: [PATCH RESEND 10/17] drm/spacemit: add Saturn DPU KMS pipeline ---
> commit cf6665928c2c5fcf07a88c5cd2141feb18245e17
> Author: Cody Kang <codykang.hk@gmail.com>
> Subject: drm/spacemit: add Saturn DPU KMS pipeline
>
> Add the atomic KMS implementation on top of the hardware backend: one
> CRTC and one primary plane per DPU instance. atomic_check validates
> the plane rectangle 1:1 against the mode and sizes the per-channel FBC
> line buffer.
>
> > diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/spacemit/spacemit_crtc.c
> > new file mode 100644
> > index 0000000000000..b75ff63205011
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c
>
> [ ... ]
>
> > @@ -91,7 +91,7 @@ static void spacemit_crtc_atomic_enable(struct drm_crtc *crtc,
> >  		dpu_reset_assert(a_crtc->dev, "lcd", a_crtc->lcd_reset);
> >  		dpu_reset_assert(a_crtc->dev, "esc", a_crtc->esc_reset);
> >  		dpu_reset_assert(a_crtc->dev, "mclk", a_crtc->mclk_reset);
> >  		dpu_reset_assert(a_crtc->dev, "aclk", a_crtc->aclk_reset);
> >  		dpu_reset_assert(a_crtc->dev, "dsc", a_crtc->dsc_reset);
> >  		usleep_range(10000, 20000);
>
> [Severity: High]
> Does this sleep in an atomic context? The spacemit_crtc_atomic_enable
> callback is executed during a non-blocking DRM atomic commit, which runs
> in an atomic context. Calling usleep_range() here might violate atomic
> context rules and lead to scheduling-while-atomic warnings.

atomic_enable runs from the commit tail worker, which is process
context; sleeping is allowed.

> [ ... ]
>
> > @@ -145,13 +145,13 @@ static void spacemit_crtc_atomic_disable(struct drm_crtc *crtc,
> >  	 * must finish its status reads before dpu_pm_suspend() gates the
> >  	 * clocks.
> >  	 */
> >  	if (a_crtc->irq_online > 0)
> >  		synchronize_irq(a_crtc->irq_online);
>
> [Severity: High]
> Can synchronize_irq() safely execute here? This callback runs in an atomic
> context, but synchronize_irq() blocks waiting for executing handlers.

atomic_disable also runs in the commit tail (process context);
synchronize_irq() is legal there.

> [Severity: High]
> Does this code leave a race window before the flags are updated? An interrupt
> could fire immediately after synchronize_irq() returns but before clocks_on
> is toggled to false, leading the ISR to access MMIO while dpu_pm_suspend()
> is shutting down the clocks.

The DPU cannot raise its interrupt while its own clocks are off, so
the window is not exploitable; still, will move the flag update
after dpu_pm_resume() in v2.

> >
> >  	/*
> >  	 * Nothing else cancels the watchdog; it would fire against freed state.
> >  	 */
> >  	timer_delete_sync(&a_crtc->cfg_rdy_timer);
> >
> >  	/* Close the ISR's MMIO gate before the clocks actually stop. */
> >  	a_crtc->clocks_on = false;
> >  	dpu_pm_suspend(a_crtc->dev);
>
> [Severity: High]
> Does dpu_pm_suspend() sleep in this atomic context? It calls usleep_range()
> which could trigger kernel warnings and deadlocks when reached via
> spacemit_crtc_atomic_disable().

Process context, as above.

> >
> >  	spin_lock_irq(&drm->event_lock);
> >  	if (crtc->state->event) {
> >  		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> >  		crtc->state->event = NULL;
> >  	}
> >  	spin_unlock_irq(&drm->event_lock);
>
> [Severity: High]
> Is it safe to use unconditional spin_unlock_irq() here? Since this callback
> executes in an atomic context (e.g. from drm_atomic_helper_commit_tail),
> unconditionally re-enabling interrupts breaks the caller's atomic assumptions.
> Should this use spin_lock_irqsave() and spin_unlock_irqrestore() instead?

The callback is not entered with interrupts disabled (commit tail);
the event_lock pattern here matches the drm helpers' own usage.

> [ ... ]
>
> > @@ -231,6 +231,5 @@ static struct drm_crtc_state *
> >  	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
> >
> >  	n_rdma = hwdev->rdma_nums;
> >  	state->rdmas = kzalloc_objs(*state->rdmas, n_rdma);
> >  	if (!state->rdmas) {
> >  		kfree(state);
> >  		return NULL;
> >  	}
>
> [Severity: Medium]
> Does this error path leak DRM property blob references?
> __drm_atomic_helper_crtc_duplicate_state() increments references on blobs
> like mode_blob, ctm, and gamma_lut. Returning NULL here without releasing
> them could leak those references.

Real; will fix in v2 with __drm_atomic_helper_crtc_destroy_state()
on that error path.

> [ ... ]
>
> > @@ -418,6 +418,5 @@ static irqreturn_t spacemit_dpu_isr(int irq, void *data)
> >  	/* Reading a clock-gated DPU's status registers stalls the bus. */
> >  	if (unlikely(!a_crtc->clocks_on)) {
> >  		drm_dev_exit(idx);
> >  		return IRQ_NONE;
> >  	}
>
> [Severity: High]
> Does this code cause an IRQ storm? By returning IRQ_NONE without clearing
> the hardware interrupt status when clocks_on is false, the interrupt
> controller might continuously re-trigger the ISR if the bootloader left the
> interrupt asserted.

Only reachable in the unbind window where the line is being torn
down; otherwise the ISR acks all status it observes.

> [ ... ]
>
> > @@ -496,6 +496,5 @@ static int spacemit_drm_master_bind(struct device *dev)
> >  	}
> >
> >  	kms = devm_drm_dev_alloc(dev, &spacemit_drm_drv,
> >  				 struct spacemit_kms, drm);
> >  	if (IS_ERR(kms))
>
> [Severity: High]
> Will this leak the DRM device on rebind? devm_drm_dev_alloc ties the
> allocation lifetime to the platform device's probe/remove cycle. If the
> component unbinds and rebinds, new DRM devices are allocated but the old
> ones are never freed.

A known trade-off of devm on the component master: the device is
unregistered at unbind and the memory is bounded by the platform
device lifetime.

> [ ... ]
>
> > @@ -573,6 +573,5 @@ static int spacemit_drm_master_bind(struct device *dev)
> >  	drm_mode_config_reset(drm);
> >  	drmm_kms_helper_poll_init(drm);
> >  	drm_helper_hpd_irq_event(drm);
> >
> >  	enable_irq(priv->irq_online);
>
> [Severity: High]
> Is it safe to enable the IRQ before the hardware state is fully initialized?
> If the bootloader left the display hardware active, the ISR might fire
> immediately while a_crtc->clocks_on is still false, leading to the IRQ storm
> mentioned above.

The ISR is gated on clocks_on and drm_dev_enter, and every board
cycle boots through this path; no storm has been observed.

> [ ... ]
>
> > @@ -594,6 +594,5 @@ static void spacemit_drm_master_unbind(struct device *dev)
> >
> >  	disable_irq(priv->irq_online);
> >
> >  	drm_dev_unregister(drm);
> >  	drm_atomic_helper_shutdown(drm);
> >  	component_unbind_all(dev, drm);
>
> [Severity: High]
> Will calling drm_atomic_helper_shutdown() hang if the IRQ is already
> disabled? The shutdown helper flushes pending atomic commits and disables
> CRTCs, which requires the hardware vblank interrupt to signal completion.
> Without it, the commit wait could time out.

Confirmed on hardware: the fbdev-restore commit arms the CFG_RDY
handshake after the line is dead, and every unload rode two watchdog
timeouts. Will reorder in v2: unregister and shutdown before
disable_irq().

> > diff --git a/drivers/gpu/drm/spacemit/spacemit_planes.c b/drivers/gpu/drm/spacemit/spacemit_planes.c
> > new file mode 100644
> > index 0000000000000..3442013b0c37f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/spacemit_planes.c
>
> [ ... ]
>
> > @@ -98,6 +98,5 @@ static int spacemit_plane_atomic_check(struct drm_plane *plane,
> >  	if (src_w == 0 && src_h == 0)
> >  		cur_rdma_id = RDMA_INVALID_ID;	/* constant-fill layer, no RDMA */
> >  	else if (cur_rdma_id == RDMA_INVALID_ID)
> >  		cur_rdma_id = state->zpos;	/* first commit: bind channel by zpos */
> >  	cur_state->rdma_id = cur_rdma_id;
>
> [Severity: High]
> Does this code assign RDMA channels based on unvalidated zpos? Userspace
> could submit a configuration with duplicate zpos values across multiple
> planes, resulting in channel collisions where planes overwrite each other's
> hardware registers during spacemit_plane_atomic_update().

There is a single primary plane per CRTC, so no collision is
possible; rdma_id is also bounds-checked in atomic_check.

> [ ... ]
>
> > @@ -193,7 +193,6 @@ static void spacemit_plane_reset(struct drm_plane *plane)
> >  	if (plane->state) {
> >  		s = to_spacemit_plane_state(plane->state);
> >  		__drm_atomic_helper_plane_destroy_state(plane->state);
> >  		kfree(s);
> >  		plane->state = NULL;
> >  	}
>
> [Severity: High]
> Does freeing the state directly bypass the driver's custom destructor?
> Calling kfree(s) directly in spacemit_plane_reset() skips
> spacemit_plane_atomic_destroy_state(), which means the DMA coherent buffers
> for mmu_tbl.va and cl.va could be permanently leaked when a plane is reset.

Real; will route .reset through the custom destroy in v2, the same
way the CRTC side already does.

> [ ... ]
>
> > @@ -211,6 +211,5 @@ static struct drm_plane_state *
> >  spacemit_plane_atomic_duplicate_state(struct drm_plane *plane)
> >  {
> >  	struct spacemit_plane_state *s;
> >  	struct spacemit_plane_state *old_state =
> >  			to_spacemit_plane_state(plane->state);
> >  	struct spacemit_crtc *a_crtc = NULL;
>
> [Severity: Medium]
> Will this crash if plane->state is NULL? The to_spacemit_plane_state()
> macro uses container_of, which will produce a negative pointer if
> plane->state is NULL. Dereferencing old_state->rdma_id later would trigger
> a fault.

The core only calls duplicate_state with an existing state; this is
the same contract the helpers themselves rely on.

Cody
