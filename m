Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FD606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBKfXyZs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2D210E0FB;
	Fri, 30 Oct 2026 10:17:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEB710E0FB
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:17:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62D1041430;
 Fri, 30 Oct 2026 10:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E752A1F000C1;
 Fri, 30 Oct 2026 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793355466;
 bh=Xt99qhXmHcYgZJZPXoeAanVBQP2/tUhVYuVGBuL6NY4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mBKfXyZsIIjr+qfR/Lnm8Va06KFfjZI8rA7kPJvyrpZi2p1T5IjPXWT17iEfsCUkv
 6n3LL0P6Fleem5q1GHLbZMJSxcvvqkSmRvV24+F7cqmcm6NWx8+ZqOCqIJg+Kruzvu
 JxbnjXX9Cw07CMEJVlOEQgewlFI1MfQErxqEI/XzFuE+lfOZVxDI9lBGlDsILXSivi
 uL4hPAFBMsFctXQUQ1Q6co3MfCA7rCgsw8wXyWD1FAGvAOZy/nMv4zBladLolMt4SD
 bNJM3JvIBp37wqOQeU/hgRShP4Y6x/BgTjBhw+A/lz2Y8aQK02xhL7voY2doHNbuaD
 0rZqgHSb5XdVg==
Message-ID: <sashiko-outbox-190821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/15] drm/imx: dc: Add DPR channel support
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-8-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:17:45 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/imx: dc-dprc: deadlock and invalid lock type in dc_dprc_disabl=
e_repeat_en()
- [High] drm/imx: dc-dprc: runtime PM race and leak in dc_dprc_wrap_irq_han=
dler()
- [Medium] drm/imx: dc-dprc: RPM reference leak and PRG imbalance in dc_dpr=
c_configure()
--

commit 0da98ec378c5f86195b2badbfc2867b3e806cb34
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Add DPR channel support

This commit adds a platform driver for the Display Prefetch Resolve
Channel (DPRC), which fetches display data, transforms it to linear
format, and stores it in RTRAM alongside its associated PRG.

> diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.c b/drivers/gpu/drm/imx/dc/dc=
-dprc.c
> new file mode 100644
> index 0000000000000..29188fa72a327
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-dprc.c
[ ... ]
> +void dc_dprc_configure(struct dc_dprc *dprc, unsigned int stream_id,
> +		       unsigned int width, unsigned int height,
> +		       unsigned int stride,
> +		       const struct drm_format_info *format,
> +		       dma_addr_t baddr, bool start)
> +{
> +	unsigned int prg_stride =3D width * format->cpp[0];
> +	unsigned int bpp =3D format->cpp[0] * 8;
> +	struct device *dev =3D dprc->dev;
> +	unsigned int p1_w, p1_h;
> +	u32 val;
> +	int ret;
> +
> +	if (start) {
> +		ret =3D pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get RPM: %d\n", ret);
> +			return;
> +		}
> +
> +		dc_dprc_set_stream_id(dprc, stream_id);
> +	}
> +
> +	p1_w =3D round_up(width, format->cpp[0] =3D=3D 2 ? 32 : 16);
> +	p1_h =3D round_up(height, 4);
> +
> +	regmap_write(dprc->reg, FRAME_CTRL0, PITCH(stride));
> +	regmap_write(dprc->reg, FRAME_1P_CTRL0, BYTE_1K);
> +	regmap_write(dprc->reg, FRAME_1P_PIX_X_CTRL, NUM_X_PIX_WIDE(p1_w));
> +	regmap_write(dprc->reg, FRAME_1P_PIX_Y_CTRL, NUM_Y_PIX_HIGH(p1_h));
> +	regmap_write(dprc->reg, FRAME_1P_BASE_ADDR_CTRL0, baddr);
> +	regmap_write(dprc->reg, FRAME_PIX_X_ULC_CTRL, CROP_ULC_X(0));
> +	regmap_write(dprc->reg, FRAME_PIX_Y_ULC_CTRL, CROP_ULC_Y(0));
> +
> +	regmap_write(dprc->reg, RTRAM_CTRL0, THRES_LOW(3) | THRES_HIGH(7));
> +
> +	val =3D LINE4 | BUF2;
> +	switch (format->format) {
> +	case DRM_FORMAT_XRGB8888:
> +		/*
> +		 * It turns out pixel components are mapped directly
> +		 * without position change via DPR processing with
> +		 * the following color component configurations.
> +		 * Leave the pixel format to be handled by the
> +		 * display controllers.
> +		 */
> +		val |=3D A_COMP_SEL(3) | R_COMP_SEL(2) |
> +		       G_COMP_SEL(1) | B_COMP_SEL(0);
> +		val |=3D PIX_SIZE_32BIT;
> +		break;
> +	default:
> +		dev_err(dev, "unsupported format 0x%08x\n", format->format);
> +		return;
> +	}
> +	regmap_write(dprc->reg, MODE_CTRL0, val);
> +
> +	if (start) {
> +		/* software shadow load for the first frame */
> +		val =3D SW_SHADOW_LOAD_SEL | SHADOW_LOAD_EN;
> +		regmap_write(dprc->reg, SYSTEM_CTRL0, val);
> +
> +		/* and then, run... */
> +		val |=3D RUN_EN | REPEAT_EN;
> +		regmap_write(dprc->reg, SYSTEM_CTRL0, val);
> +	}
> +
> +	dc_prg_configure(dprc->prg, width, height, prg_stride, bpp, baddr, star=
t);
> +
> +	if (start)
> +		dc_dprc_enable(dprc);
> +
> +	dc_dprc_reg_update(dprc);

[Severity: Medium]
As reported by Sashiko on v7 [1], can dc_dprc_configure() leak the runtime
PM reference on dprc->dev and leave dprc->prg->dev unbalanced or unclocked
when start is true?

In dc_dprc_configure(), pm_runtime_resume_and_get(dev) is called when start
is true before checking format->format. If format->format hits the default
case, the function returns early without calling pm_runtime_put(dev) and
before calling dc_prg_configure(). That leaks the runtime PM reference on
dprc->dev and leaves dprc->prg->dev runtime-suspended; a subsequent call to
dc_dprc_disable() -> dc_prg_disable() will then write to prg->reg while
unclocked and underflow prg->dev's runtime PM usage count.

Similarly, when dc_dprc_configure() calls dc_prg_configure() with start
set to true:

drivers/gpu/drm/imx/dc/dc-prg.c:dc_prg_configure() {
	if (start) {
		ret =3D pm_runtime_resume_and_get(dev);
		if (ret < 0) {
			dev_err(dev, "failed to get RPM: %d\n", ret);
			return;
		}
	}
}

Because dc_prg_configure() returns void on pm_runtime_resume_and_get()
failure, dc_dprc_configure() proceeds unconditionally to dc_dprc_enable()
-> dc_prg_enable() and dc_dprc_reg_update() -> dc_prg_reg_update(), writing
to prg->reg while prg->clks are disabled and leaving the runtime PM
references between dprc->dev and prg->dev unbalanced.

> +
> +	if (start)
> +		dc_dprc_enable_ctrl_done_irq(dprc);
> +
> +	dev_dbg(dev, "w: %u, h: %u, s: %u, fmt: 0x%08x\n",
> +		width, height, stride, format->format);
> +}
> +
> +void dc_dprc_disable_repeat_en(struct dc_dprc *dprc)
> +{
> +	guard(spinlock)(&dprc->lock);
> +	regmap_write(dprc->reg, IRQ_MASK + SET, IRQ_DPR_CRTL_DONE);
> +
> +	synchronize_hardirq(dprc->wrap_irq);
> +
> +	regmap_write(dprc->reg, SYSTEM_CTRL0 + CLR, REPEAT_EN);
> +	dev_dbg(dprc->dev, "disable REPEAT_EN\n");
> +}

[Severity: High]
As reported by Sashiko on v7 [1], won't holding dprc->lock across
synchronize_hardirq(dprc->wrap_irq) in dc_dprc_disable_repeat_en()
deadlock if dc_dprc_wrap_irq_handler() is concurrently running?

In dc_dprc_disable_repeat_en(), guard(spinlock)(&dprc->lock) holds
dprc->lock for the entire function scope, including while waiting in
synchronize_hardirq(dprc->wrap_irq). If wrap_irq fires on another CPU (eith=
er
from DPRC before IRQ_MASK + SET takes effect, or from another device sharing
the IRQF_SHARED interrupt line) and enters dc_dprc_wrap_irq_handler(),
IRQD_IRQ_INPROGRESS is set before dc_dprc_wrap_irq_handler() attempts to
acquire dprc->lock:

CPU 0                                  CPU 1 (hardirq wrap_irq)
dc_dprc_disable_repeat_en()            handle_irq_event()
  guard(spinlock)(&dprc->lock)           /* sets IRQD_IRQ_INPROGRESS */
  ...                                    dc_dprc_wrap_irq_handler()
  synchronize_hardirq(dprc->wrap_irq)      scoped_guard(spinlock, &dprc->lo=
ck)
    /* waits for IRQD_IRQ_INPROGRESS */      /* spins waiting for dprc->loc=
k */

Also, if dc_dprc_disable_repeat_en() is ever called with local IRQs enabled,
guard(spinlock) does not disable local interrupts, so wrap_irq on the same
CPU can preempt and self-deadlock on dprc->lock.

In addition, as noted in the comment on dc_dprc_regmap_config,
dc_dprc_disable_repeat_en() is called with local IRQs and preemption
disabled. However, dprc->lock is declared as spinlock_t rather than
raw_spinlock_t, and dc_dprc_wrap_irq_handler() -> dc_dprc_ctrl_done_handle()
-> dc_prg_shadow_enable() writes to prg->reg (whose dc_prg_regmap_config
does not set use_raw_spinlock =3D true) from hardirq context. On PREEMPT_RT=
 or
with CONFIG_PROVE_RAW_LOCK_NESTING enabled, acquiring a non-raw spinlock_t
in hardirq context or with local IRQs/preemption disabled triggers an
invalid wait-context splat.

Finally, because devm_request_irq() is called without IRQF_NO_THREAD,
dc_dprc_wrap_irq_handler() is force-threaded under PREEMPT_RT or threadirqs.
In that configuration, synchronize_hardirq() does not wait for the IRQ
thread to complete, so dc_dprc_ctrl_done_handle() can still run concurrently
and write REPEAT_EN back to SYSTEM_CTRL0 and SHADOW_EN to prg->reg after
dc_dprc_disable_repeat_en() and dc_dprc_disable().

> +
> +/*
> + * dc_dprc_disable_repeat_en() must be called beforehand to mask
> + * IRQ_DPR_CRTL_DONE and synchronize wrap_irq.
> + */
> +void dc_dprc_disable(struct dc_dprc *dprc)
> +{
> +	dc_prg_disable(dprc->prg);
> +
> +	pm_runtime_put(dprc->dev);
> +
> +	dev_dbg(dprc->dev, "disable\n");
> +}
[ ... ]
> +static irqreturn_t dc_dprc_wrap_irq_handler(int irq, void *data)
> +{
> +	struct dc_dprc *dprc =3D data;
> +	struct device *dev =3D dprc->dev;
> +	u32 mask =3D 0, status =3D 0;
> +	irqreturn_t result;
> +
> +	pm_runtime_get_noresume(dev);
> +	if (!pm_runtime_active(dev)) {
> +		result =3D IRQ_NONE;
> +		goto out;
> +	}
> +
> +	scoped_guard(spinlock, &dprc->lock) {
> +		/* cache valid IRQ status */
> +		regmap_read(dprc->reg, IRQ_MASK, &mask);
> +		regmap_read(dprc->reg, IRQ_MASK_STATUS, &status);
> +		status &=3D ~mask;
> +
> +		/* mask the IRQ(s) being handled */
> +		regmap_write(dprc->reg, IRQ_MASK + SET, status);
> +
> +		/* clear status register */
> +		regmap_write(dprc->reg, IRQ_MASK_STATUS, status);
> +	}
> +
> +	if (status =3D=3D 0) {
> +		result =3D IRQ_NONE;
> +		goto out;
> +	}
> +
> +	if (status & DPR2RTR_FIFO_LOAD_BUF_RDY_UV_ERROR)
> +		dev_err(dev, "DPR to RTRAM FIFO load UV buffer ready error\n");
> +
> +	if (status & DPR2RTR_FIFO_LOAD_BUF_RDY_YRGB_ERROR)
> +		dev_err(dev, "DPR to RTRAM FIFO load YRGB buffer ready error\n");
> +
> +	if (status & DPR2RTR_UV_FIFO_OVFL)
> +		dev_err(dev, "DPR to RTRAM FIFO UV FIFO overflow\n");
> +
> +	if (status & DPR2RTR_YRGB_FIFO_OVFL)
> +		dev_err(dev, "DPR to RTRAM FIFO YRGB FIFO overflow\n");
> +
> +	if (status & IRQ_AXI_READ_ERROR)
> +		dev_err(dev, "AXI read error\n");
> +
> +	if (status & IRQ_DPR_CRTL_DONE)
> +		dc_dprc_ctrl_done_handle(dprc);
> +
> +	result =3D IRQ_HANDLED;
> +out:
> +	pm_runtime_put_noidle(dev);
> +	return result;
> +}

[Severity: High]
As reported by Sashiko on v7 [1], can dc_dprc_wrap_irq_handler() still race
with runtime suspend or leak the active runtime PM state when wrap_irq is
shared?

Because wrap_irq is requested with IRQF_SHARED, another DPRC instance can
trigger dc_dprc_wrap_irq_handler() at any time:

1. In rpm_suspend(), after rpm_check_suspend_allowed() verifies usage_count
   is 0, it sets runtime_status to RPM_SUSPENDING and drops dev->power.lock
   to invoke dc_dprc_runtime_suspend(), which disables dprc->clks. Because
   pm_runtime_get_noresume(dev) and pm_runtime_active(dev) in
   dc_dprc_wrap_irq_handler() do not synchronize with dev->power.lock or
   in-flight suspend, if dc_dprc_wrap_irq_handler() runs right before
   RPM_SUSPENDING is set, it passes the pm_runtime_active(dev) check and
   reads IRQ_MASK and IRQ_MASK_STATUS from dprc->reg while
   dc_dprc_runtime_suspend() concurrently disables dprc->clks.

2. pm_runtime_active(dev) returns true whenever dev->power.disable_depth > =
0,
   even if the device is runtime-suspended with its clocks off (for example,
   during late system suspend after __device_suspend_late() disables runtime
   PM, during devres teardown on unbind, or when CONFIG_PM is disabled). Any
   shared IRQ during those windows will read dprc->reg with clocks disabled.

3. If dc_dprc_wrap_irq_handler() increments usage_count from 1 to 2 via
   pm_runtime_get_noresume(dev) while dc_dprc_disable() concurrently calls
   pm_runtime_put(dprc->dev), dc_dprc_disable() drops usage_count from 2 to
   1 without scheduling idle/suspend. When dc_dprc_wrap_irq_handler() then
   calls pm_runtime_put_noidle(dev), usage_count drops from 1 to 0 without
   triggering rpm_idle() or rpm_suspend(), leaving dprc->dev permanently
   active with its clocks enabled.

[1] https://lore.kernel.org/r/20261026-imx8-dc-prefetch-v7-8-a0b50cc4fc65@n=
xp.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-imx8-dc-pr=
efetch-v8-0-c4f81afd4533@nxp.com?part=3D8
