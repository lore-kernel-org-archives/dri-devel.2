Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD4FC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD2810E1DB;
	Wed, 15 Jul 2026 15:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l8FJ896j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A3510E1DB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 15:24:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 803F8417F3;
 Wed, 15 Jul 2026 15:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124171F000E9;
 Wed, 15 Jul 2026 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784129050;
 bh=gYgSyR8nTRyM99KrY7R+rwPBlkpAWvF/svtLFCwcz8I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l8FJ896jGFGq0Esb5e90nkPrBQsEnfVufzO9PwKt6zfQcXQOM/jc16AKER4l5LYUS
 9DOrcE3cPnKeISYlSsdUxtbwa68LCTPcwDkMVPwv9Wbx7/SwQL+rUufFfGilHRG+6L
 97JvWYor5VtqwsJ0UeMtAQll0PCuYakhH9tcHgmBWGr/5VxygI3fi1dggwjXnB7kAK
 YAQ3klB1V/6hQaxDHDV0s13H2eBjLoGErbYJ/WNp/BmTPGtp+P++bcNll7Af2kXTBe
 Z/7W+/nljV7AeXd/IoLhH8BuqfCjdS6KVxkwR/bn7inIzYY/U14NGjbtH89427bJYh
 O1pzUesgD5ZcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/11] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260715135703.46540-12-angelogioacchino.delregno@collabora.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:24:09 +0000
Message-Id: <20260715152410.124171F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] WDMA corrupts input framebuffers by treating plane state as ou=
tput destination.
- [High] WDMA configuration code is unreachable, leaving hardware unprogram=
med.
- [High] Kernel Panic from unconditional `drm_writeback_queue_job()` in pla=
ne config.
- [High] Direct MMIO writes bypass CMDQ synchronization, causing hardware s=
tate corruption.
- [High] Race condition between atomic_commit and IRQ handler stalls writeb=
ack jobs.
- [High] Unclocked MMIO access during bind causes system hang.
- [Medium] pm_runtime_get_sync() misuse leaks PM usage counter and causes s=
purious warnings.
- [Medium] WDMA writeback connector artificially restricted to single outpu=
t format.
--

--- Patch [11]: [PATCH v6 11/11] drm/mediatek: Add Write DMA (WDMA) Engine =
for Writeback support ---
commit 785dafc39cd5707f8b31637d57cc1e1d14518c1b
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support

This commit adds a basic driver for the Write DMA Engine (WDMA) on MediaTek
MT8173 and Dimensity 1200 MT6893. It hooks the engine into the display
pipeline to enable writeback support for display image capturing.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_wdma.c
> new file mode 100644
> index 0000000000000..0575fade92c6b
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c

[ ... ]

> +void mtk_wdma_config(struct device *dev, unsigned int width,
> +		     unsigned int height, unsigned int vrefresh,
> +		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +
> +	writel(WDMA_FORCE_COMMIT | WDMA_BYPASS_SHADOW,
> +	       wdma->regs + DISP_REG_WDMA_SHADOW_CTRL);
> +}

[Severity: High]
Does setting WDMA_BYPASS_SHADOW break the hardware's ability to atomically
apply updates at the VBLANK boundary?

[ ... ]

> +static void mtk_wdma_format_config(struct mtk_disp_wdma *wdma,
> +				   struct mtk_plane_pending_state *pending,
> +				   const struct drm_format_info *fmt_info,
> +				   struct cmdq_pkt *cmdq_pkt)
> +{
> +	unsigned int u_off, u_stride, u_size, v_off;
> +	u32 val;
> +
> +	/*
> +	 * For RGB formats, this sets the image destination address;
> +	 * For YUV formats, this sets the Y component destination address.
> +	 */
> +	mtk_wdma_ddp_write_dst_addr(cmdq_pkt, pending->addr, 0, wdma);

[Severity: Critical]
Could this corrupt the input framebuffer memory?

By passing pending->addr (the source framebuffer) to
mtk_wdma_ddp_write_dst_addr(), it looks like the writeback hardware is
programmed to write the captured display data directly over the active input
framebuffer, rather than the writeback job's destination address.

[ ... ]

> +void mtk_wdma_layer_config(struct device *dev, unsigned int idx,
> +			   struct mtk_plane_state *state,
> +			   struct cmdq_pkt *cmdq_pkt)
> +{

[Severity: High]
Is this configuration code reachable during normal operation?

WDMA is a writeback engine located at the end of the display pipeline (index
greater than 1). Since mtk_crtc_num_comp_planes() returns 0 for any compone=
nt
index greater than 1, it appears WDMA never receives plane allocations.

This would prevent mtk_ddp_comp_for_plane() from matching it, leaving the
hardware unprogrammed.

[ ... ]

> +	mtk_wdma_format_config(wdma, pending, fmt_info, cmdq_pkt);
> +
> +	drm_writeback_queue_job(&wdma->wb_connector, wdma->wb_connector.base.st=
ate);
> +}

[Severity: High]
Can this cause a NULL pointer dereference?

If mtk_wdma_layer_config() is executed, it unconditionally calls
drm_writeback_queue_job() with the generic conn_state.

However, mtk_wdma_wb_connector_atomic_commit() already consumes the job and
sets conn_state->writeback_job to NULL earlier in the commit sequence.

[ ... ]

> +static void mtk_wdma_wb_connector_atomic_commit(struct drm_connector *co=
nnector,
> +						struct drm_atomic_commit *state)
> +{

[ ... ]

> +	/* Store writeback pending state before queuing the job */
> +	wdma->wb_pending =3D true;

[Severity: High]
Does setting the wb_pending flag before the lock-protected
drm_writeback_queue_job() call introduce a race condition?

If a previous frame's completion interrupt fires in this window,
mtk_disp_wdma_irq_handler() could observe the flag, fail to find the job in
the queue, and clear wb_pending.

The new job would then be queued but never signaled because wb_pending is
now false.

> +
> +	mtk_wdma_ddp_write_dst_addr(NULL, addr, 0, wdma);

[Severity: High]
Could passing NULL for cmdq_pkt cause hardware state corruption?

This forces an immediate, unsynchronized CPU writel() to the hardware
destination registers, bypassing the GCE CMDQ.

Modifying the destination address mid-frame while an active DMA transfer is
occurring might redirect the transfer prematurely.

> +	drm_writeback_queue_job(&wdma->wb_connector, conn_state);
> +}

[ ... ]

> +static int mtk_disp_wdma_bind(struct device *dev, struct device *master,
> +			      void *data)
> +{

[ ... ]

> +	ret =3D drm_writeback_connector_init(drm_dev, &wdma->wb_connector,
> +					   &mtk_wdma_wb_connector_funcs,
> +					   &mtk_wdma_wb_encoder_helper_funcs,
> +					   mtk_wdma_wb_output_formats,
> +					   ARRAY_SIZE(mtk_wdma_wb_output_formats),
> +					   crtcs);

[Severity: Medium]
Is it intentional to hardcode mtk_wdma_wb_output_formats here (which only
contains DRM_FORMAT_RGB888)?

This ignores the wdma->data->formats array that supports 13 formats, making
the format conversion logic in wdma_fmt_convert() unused and restricting
userspace capabilities.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_get_sync(dev);
> +	if (ret)
> +		dev_warn(dev, "Could not get PM Runtime!\n");

[Severity: Medium]
Could this lead to spurious warnings?

pm_runtime_get_sync() returns 1 when the device is already active. Checking
if (ret) evaluates to true on success, which would incorrectly print this
warning.

> +
> +	/*
> +	 * Disable and clear pending interrupts - write unconditionally as no
> +	 * crash (SError, etc) will happen as if unpowered/unclocked this is
> +	 * simply going to be ignored (and the registers will be 0 at reset).
> +	 */
> +	writel(0x0, wdma->regs + DISP_REG_WDMA_INT_ENABLE);
> +	writel(0x0, wdma->regs + DISP_REG_WDMA_INT_STATUS);

[Severity: High]
Are we sure this will not crash on an unclocked device?

On MediaTek SoCs, writing to unclocked MMSYS registers can result in an
immediate bus hang.

Since the driver lacks dev_pm_ops to link runtime PM to clock management,
pm_runtime_get_sync() does not implicitly enable the clock. Should
clk_prepare_enable() be called explicitly before these writes?

> +
> +	/* Put RPM only if refcount was incremented before to avoid unbalancing=
 */
> +	if (ret >=3D 0)
> +		pm_runtime_put(dev);

[Severity: Medium]
Does this logic leak the PM usage counter on actual errors?

By calling pm_runtime_put(dev) only when ret >=3D 0, the usage counter
reference acquired by pm_runtime_get_sync() is never dropped if an error
(ret < 0) occurs.

> +
> +	enable_irq(wdma->irq);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715135703.4654=
0-1-angelogioacchino.delregno@collabora.com?part=3D11
