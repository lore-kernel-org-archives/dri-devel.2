Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E53C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A48E10E5B2;
	Tue, 15 Sep 2026 08:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nQZOrNSF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A1310E264
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:59:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26FF16025F;
 Tue, 15 Sep 2026 08:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29D71F00899;
 Tue, 15 Sep 2026 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789462756;
 bh=P/lfWRLpEYaDoKcRNDs/8/gTNhBzaNJFpBJRYvuLsb8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nQZOrNSFM1mftyOfyt8cyVx+BjLx05MFyImMapEvNrHNsmxrl0WDxNm9d674Rjxpi
 D9XQiPtetsJfF4zuDNkqOrUXLJNCUfRC6qkD4q95lVHom7MnR/qxveJzz/dbfEM4PZ
 1q4ETI2wQped1kD6iYDUBP16lPzl350DYvyEhUJ4BN8ZQE6zMXKLAV3cOlaIZngNjd
 iIl0CbAY1PamflfkWbCGg5A4zLwPi0Ms+By1x23HHhNQEbjiAjvFEqRinH7Ph/uvgB
 9auqF3d862udmyOCc7LHLMckMq1BJDCgUH81wTmnWRYkeM7x2t58Y90GIHseWjp5vf
 YCFWBqpSaR8ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/13] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260915084148.11385-14-angelogioacchino.delregno@collabora.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-14-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:59:16 +0000
Message-Id: <20260915085916.A29D71F00899@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] drm/mediatek: WDMA layer_config overwrites source buffer and c=
auses NULL pointer dereference
- [High] pm: resource leak on pm_runtime_get_sync() failure
- [High] drm/mediatek: lockless wb_pending access causes lost completions a=
nd WARN_ON
- [High] drm/mediatek: TOCTOU race in vblank callback execution
- [Medium] drm/mediatek: direct CPU MMIO writes to WDMA bypass CMDQ synchro=
nization
- [Medium] drm/mediatek: incorrect color transform matrix for YUV writeback
- [Medium] drm/mediatek: mtk_wdma_stop incorrectly signals success for abor=
ted writeback job
--

commit 5040ee161768b3e9eb8d9ed33a9148cd22b10b67
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support

This commit adds a basic driver for the Write DMA Engine for the MediaTek
MT8173 and Dimensity 1200 MT6893 platforms. It wires the component into
mtk_ddp_comp and mtk_drm_drv to enable userspace writeback features.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_wdma.c
> new file mode 100644
> index 0000000000000..0575fade92c6b
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
[ ... ]
> +static irqreturn_t mtk_disp_wdma_irq_handler(int irq, void *dev_id)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_id;
> +
> +	/* Clear frame completion interrupt */
> +	writel(0x0, wdma->regs + DISP_REG_WDMA_INT_STATUS);
> +
> +	if (wdma->vblank_cb)
> +		wdma->vblank_cb(wdma->vblank_cb_data);

[Severity: High]
Could this race with mtk_wdma_unregister_vblank_cb() if it is called
concurrently from process context? If unregistration clears wdma->vblank_cb
exactly between this check and the call, it looks like it could result in a
NULL pointer dereference.

> +
> +	/* TODO: Move completion signaling to CMDQ interrupt callback */
> +	if (wdma->wb_pending) {
> +		drm_writeback_signal_completion(&wdma->wb_connector, 0);
> +		wdma->wb_pending =3D false;
> +	}

[Severity: High]
Is it safe to check and clear wdma->wb_pending locklessly here? If this
interrupt fires right after the flag is set to true in
mtk_wdma_wb_connector_atomic_commit() but before the job is queued, it
appears it would signal an empty queue (triggering a WARN_ON(!job)) and the
job would never be signaled once actually queued.

> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> +void mtk_wdma_stop(struct device *dev)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +
> +	if (wdma->wb_pending) {
> +		drm_writeback_signal_completion(&wdma->wb_connector, 0);
> +		wdma->wb_pending =3D false;
> +	}

[Severity: Medium]
Since stopping the engine aborts any pending writeback job leaving the buff=
er
incomplete, shouldn't this signal an error status (such as -ECANCELED) rath=
er
than 0 (success)? Userspace might consume a corrupted or partial buffer
otherwise.

> +
> +	wdma_update_bits(dev, DISP_REG_WDMA_EN, WDMA_ENGINE_EN, 0);
> +}
> +
> +void mtk_wdma_config(struct device *dev, unsigned int width,
> +		     unsigned int height, unsigned int vrefresh,
> +		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +
> +	writel(WDMA_FORCE_COMMIT | WDMA_BYPASS_SHADOW,
> +	       wdma->regs + DISP_REG_WDMA_SHADOW_CTRL);
> +}

[Severity: Medium]
Does this direct CPU MMIO write bypass the CMDQ synchronization? Since this
is forced outside of the VBLANK synchronized CMDQ execution sequence, it
might cause tearing or memory corruption if the hardware is actively writin=
g.

[ ... ]
> +static void mtk_wdma_format_config(struct mtk_disp_wdma *wdma,
> +				   struct mtk_plane_pending_state *pending,
> +				   const struct drm_format_info *fmt_info,
> +				   struct cmdq_pkt *cmdq_pkt)
> +{
[ ... ]
> +	/* Color transform coefficient selection */
> +	val =3D FIELD_PREP_CONST(WDMA_INT_MTX_SEL, WDMA_CT_COEF_JPEG_TO_RGB);
> +	mtk_ddp_write_mask(cmdq_pkt, val, &wdma->cmdq_reg, wdma->regs,
> +			   DISP_REG_WDMA_CFG, WDMA_INT_MTX_SEL);

[Severity: Medium]
Are we programming the correct color transform matrix for a writeback pipel=
ine?
WDMA_CT_COEF_JPEG_TO_RGB converts YUV to RGB, but converting the internal R=
GB
pipeline output to a YUV writeback format requires RGB to YUV.

[ ... ]
> +void mtk_wdma_layer_config(struct device *dev, unsigned int idx,
> +			   struct mtk_plane_state *state,
> +			   struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +	struct mtk_plane_pending_state *pending =3D &state->pending;
[ ... ]
> +	mtk_wdma_format_config(wdma, pending, fmt_info, cmdq_pkt);

[Severity: Critical]
Is the writeback engine incorrectly programmed to overwrite the source plan=
e's
buffer? WDMA is an output component, but exposing layer_config makes the CR=
TC
treat it as a source plane. Passing pending into mtk_wdma_format_config()
sets the WDMA destination address to the source plane's address
(pending->addr), which would actively corrupt the framebuffer being scanned
out.

> +
> +	drm_writeback_queue_job(&wdma->wb_connector, wdma->wb_connector.base.st=
ate);
> +}

[Severity: Critical]
Will this unconditionally dereference a NULL job pointer? By passing
wdma->wb_connector.base.state to drm_writeback_queue_job(), it uses a
connector state where the writeback_job might have already been consumed
(or is NULL), which will cause a kernel panic during list_add_tail().

[ ... ]
> +static void mtk_wdma_wb_connector_atomic_commit(struct drm_connector *co=
nnector,
> +						struct drm_atomic_commit *state)
> +{
[ ... ]
> +	/* Store writeback pending state before queuing the job */
> +	wdma->wb_pending =3D true;
> +
> +	mtk_wdma_ddp_write_dst_addr(NULL, addr, 0, wdma);

[Severity: Medium]
As with the WDMA_SHADOW_CTRL write, does this direct unsynchronized CPU MMIO
write for the destination address bypass CMDQ? Changing the destination
address asynchronously to VBLANK risks memory corruption in the writeback
buffer.

> +	drm_writeback_queue_job(&wdma->wb_connector, conn_state);
> +}
[ ... ]
> +static int mtk_disp_wdma_bind(struct device *dev, struct device *master,
> +			      void *data)
> +{
[ ... ]
> +	ret =3D pm_runtime_get_sync(dev);
> +	if (ret)
> +		dev_warn(dev, "Could not get PM Runtime!\n");

[Severity: High]
Does this incorrectly treat a return value of 1 as an error?
pm_runtime_get_sync() returns 1 if the device was already active, which is a
success case, not a failure.

> +
> +	/*
> +	 * Disable and clear pending interrupts - write unconditionally as no
> +	 * crash (SError, etc) will happen as if unpowered/unclocked this is
> +	 * simply going to be ignored (and the registers will be 0 at reset).
> +	 */
> +	writel(0x0, wdma->regs + DISP_REG_WDMA_INT_ENABLE);
> +	writel(0x0, wdma->regs + DISP_REG_WDMA_INT_STATUS);
> +
> +	/* Put RPM only if refcount was incremented before to avoid unbalancing=
 */
> +	if (ret >=3D 0)
> +		pm_runtime_put(dev);

[Severity: High]
Can this leak the runtime PM usage counter on failure? pm_runtime_get_sync()
increments the usage counter even when returning a negative error code.
By skipping pm_runtime_put(dev) when ret < 0, the usage counter is
permanently leaked.

> +
> +	enable_irq(wdma->irq);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915084148.1138=
5-1-angelogioacchino.delregno@collabora.com?part=3D13
