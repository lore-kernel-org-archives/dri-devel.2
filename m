Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF6606A338
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZJOy1fw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394C110E230;
	Tue,  3 Nov 2026 06:54:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A845610E230
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:53:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 483BC407B5;
 Tue,  3 Nov 2026 06:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF6D1F000C1;
 Tue,  3 Nov 2026 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793688833;
 bh=eNVA6uUa5l1vHwP6H2nnBnGA5vjq/AXUnUHfxocMenw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OZJOy1fwQMba+htFgTluXt510XkhuoochQD09CXpL0d9kABoNXA661ne5Y7Wm31it
 /JQ6nhEglRu6PTs3HfDQM6i0+PJerY8y/rIlla47GOKZqxbATOabD4AJo+0LuoksFz
 /14BSeKpblOjAa9mtoaf/pHP0ofdfw7xjPgm41jhIQoLIvREivqwsxUIqWrcjL6B47
 6s1ZrLX+m/BRVkkKYu7d+k3d0aiba8naDcWo9da+xEc9MfgW01CJV50Ep8eypxaelg
 VFXyHpneUpB6HDYHW7s+yLqLI5auqaOcoLEZ6CeAcbkhxTW3Yk/uC3u+BoA7lKwWtw
 B0LPMyBflzVkw==
Message-ID: <sashiko-outbox-194676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/16] drm/imx: dc: Add DPR channel support
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-imx8-dc-prefetch-v9-9-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
 <20261103-imx8-dc-prefetch-v9-9-3b985e7636e2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:53:52 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/imx: dc-dprc: invalid wait context calling dc_prg_shadow_enabl=
e() in IRQ
- [High] drm/imx: dc-dprc: runtime PM race and leak in dc_dprc_wrap_irq_han=
dler()
- [Medium] drm/imx: dc-dprc: RPM reference leak and PRG imbalance in dc_dpr=
c_configure()
- [Medium] drm/imx: dc-dprc: error IRQs left masked on restart before runti=
me suspend
--

commit cd34e5bff983d01a81bde212b10cde47c6bbe04b
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Add DPR channel support

This commit adds a platform driver for the Display Prefetch Resolve Channel
(DPRC) in the i.MX8 Display Controller and links it with the PRG driver.

[Severity: High]
As reported by Sashiko on v8 [1], in drivers/gpu/drm/imx/dc/dc-dprc.c at
line 243, can dc_dprc_configure() leak a runtime PM reference and leave PRG
runtime PM unbalanced when given an unsupported format or when PRG runtime
resume fails?

When dc_dprc_configure() is called with start set to true, it calls
pm_runtime_resume_and_get(dev) at line 207 and writes hardware registers
before checking format->format in the switch statement at line 230. If the
format hits the default branch at line 243, the function logs an error and
returns early without calling pm_runtime_put(dev) and before calling
dc_prg_configure(). That leaks the runtime PM reference on dprc->dev and
leaves dprc->prg->dev without a matching reference if dc_dprc_disable() is
later called.

Similarly, at line 259, dc_dprc_configure() calls dc_prg_configure(). In
drivers/gpu/drm/imx/dc/dc-prg.c at line 137, if start is true and
pm_runtime_resume_and_get() fails on prg->dev, dc_prg_configure() returns
void without reporting the error. dc_dprc_configure() then unconditionally
calls dc_dprc_enable() at line 262 and dc_dprc_reg_update() at line 264,
which write to prg->reg while PRG clocks are still disabled.

Could format validation be done before pm_runtime_resume_and_get(), and
could dc_prg_configure() return an error code so dc_dprc_configure() can
unwind the dprc->dev runtime PM reference on failure?

[Severity: Medium]
In drivers/gpu/drm/imx/dc/dc-dprc.c at line 276, does
dc_dprc_disable_repeat_en() leave the hardware error interrupts masked if
the channel is restarted before runtime suspend runs?

In dc_dprc_runtime_resume() at line 507, the driver resets the hardware with
dc_dprc_reset() and writes IRQ_CTRL_MASK to IRQ_MASK at line 511, which
masks the three control interrupts while unmasking the five error interrupt=
s.

When stopping the channel, dc_dprc_disable_repeat_en() at line 276 sets
IRQ_ALL_MASK in IRQ_MASK, masking both the control and error interrupts.
Then dc_dprc_disable() at line 292 calls pm_runtime_put(dprc->dev), which
schedules an asynchronous suspend on pm_wq.

If dc_dprc_configure() is called again with start set to true before the
asynchronous runtime suspend callback executes, pm_runtime_resume_and_get()
at line 207 sees the device is already active and returns immediately
without running dc_dprc_runtime_resume(). Because dc_dprc_configure() only
unmasks IRQ_DPR_CRTL_DONE via dc_dprc_enable_ctrl_done_irq() at line 190,
won't the five error interrupts remain masked and dc_dprc_reset() be skipped
for the new stream?

[Severity: High]
As reported by Sashiko on v8 [2], in drivers/gpu/drm/imx/dc/dc-dprc.c at
line 310, does calling dc_prg_shadow_enable() from
dc_dprc_wrap_irq_handler() trigger an invalid wait context on PREEMPT_RT or
lockdep?

In dc_dprc_probe() at line 463, devm_request_irq() requests wrap_irq with
IRQF_SHARED | IRQF_NO_THREAD, so dc_dprc_wrap_irq_handler() always runs in
hardirq context. When IRQ_DPR_CRTL_DONE is handled at line 362, the call
chain dc_dprc_wrap_irq_handler() -> dc_dprc_ctrl_done_handle() ->
dc_prg_shadow_enable() writes to prg->reg using regmap_write().

Unlike dc_dprc_regmap_config, dc_prg_regmap_config in
drivers/gpu/drm/imx/dc/dc-prg.c at line 71 sets fast_io to true but does not
set use_raw_spinlock to true. As a result, prg->reg uses a standard
spinlock_t, which becomes a sleepable lock on PREEMPT_RT and violates
lockdep's raw lock nesting rules when acquired from an IRQF_NO_THREAD hardi=
rq
handler (as well as from dc_dprc_configure() when called with local IRQs and
preemption disabled). Should dc_prg_regmap_config also set use_raw_spinlock
to true?

[Severity: High]
As reported by Sashiko on v8 [3], in drivers/gpu/drm/imx/dc/dc-dprc.c at
line 322, can the runtime PM handling in dc_dprc_wrap_irq_handler() race
with dc_dprc_disable() and dc_dprc_runtime_suspend()?

Because wrap_irq is requested with IRQF_SHARED at line 463, another DPR
channel sharing the interrupt line can invoke dc_dprc_wrap_irq_handler() at
any time, even after this channel has masked its own interrupts in
dc_dprc_disable_repeat_en(). This creates three issues with the
pm_runtime_get_noresume() / pm_runtime_active() / pm_runtime_put_noidle()
pattern at lines 322 and 366:

1. If a shared interrupt runs dc_dprc_wrap_irq_handler() and increments
usage_count via pm_runtime_get_noresume() at line 322 while
dc_dprc_disable() at line 292 calls pm_runtime_put() (or while the async
runtime suspend worker is checking usage_count), the runtime PM core sees
usage_count > 0 and aborts the idle/suspend transition. When the IRQ handler
then drops its reference with pm_runtime_put_noidle() at line 366, no new
idle or suspend request is queued, leaving dprc->dev active with its clocks
enabled indefinitely.

2. In rpm_suspend(), usage_count is checked before the status changes from
RPM_ACTIVE to RPM_SUSPENDING and before dc_dprc_runtime_suspend() is called
at line 487. If a shared interrupt fires on another CPU after the
usage_count check passes, pm_runtime_get_noresume() does not stop the
ongoing suspend and pm_runtime_active() still returns true until the status
is updated, allowing the handler to read IRQ_MASK and IRQ_MASK_STATUS while
dc_dprc_runtime_suspend() is disabling dprc->clks.

3. pm_runtime_active(dev) returns true whenever dev->power.disable_depth is
non-zero, even if the device is runtime-suspended with its clocks off (for
example, during system suspend after __device_suspend_late() disables
runtime PM and before noirq suspend disables interrupts). A shared interrupt
during that window will see pm_runtime_active(dev) as true and read
dprc->reg while clocks are disabled.

Could the driver track whether clocks are enabled under dprc->lock in the
runtime PM callbacks instead of relying on pm_runtime_get_noresume() and
pm_runtime_active() in the hardirq handler?

[1] https://lore.kernel.org/r/20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@n=
xp.com
[2] https://lore.kernel.org/r/20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@n=
xp.com
[3] https://lore.kernel.org/r/20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@n=
xp.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-imx8-dc-pr=
efetch-v9-0-3b985e7636e2@nxp.com?part=3D9
