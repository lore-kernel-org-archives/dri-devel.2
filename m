Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6CBC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C12810E144;
	Wed, 16 Sep 2026 11:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WgyTme1w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED54010E144
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:22:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71E0A60234;
 Wed, 16 Sep 2026 11:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B9C1F000FF;
 Wed, 16 Sep 2026 11:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789557760;
 bh=cfxIJv6+UzUxbGZzi8Q1TfOa38tFQUhbgVKB3vsTcS8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WgyTme1w+hPpo0y31Vb4pQoLGgoLFI2FmYmyaTv8QG+zgTfRd1DgCrwcOzBXt5LUo
 UwltHpG+mAXpQb6ieuVWLSqFwWJ/oU81lmVmUgUbEWIfzcPB3uvKs0oqXEnwXGTr07
 npR7RPq5rMKvzbPkaKy2TPQEukeE73vj2WkOq0wxR+fs+4E/p/NZcLpOXNNMA0N0+Q
 S/WvytD4dq/IAHdHdj9l9tFA9t+RyQ22cFHObXeL2SCkonY955uGV/uzHgloY3yV1s
 7MPryApVzBVsvjjicAIxn/VbnaneN0+t9J6H13ssSEJEO+S4ROrjixlz0QSVwsXit1
 MKdw7kNcavCrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/13] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260916110825.102631-14-angelogioacchino.delregno@collabora.com>
References: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
 <20260916110825.102631-14-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:22:39 +0000
Message-Id: <20260916112239.D8B9C1F000FF@smtp.kernel.org>
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
- [Critical] drm/writeback: double queuing of writeback jobs causes NULL po=
inter dereference
- [High] pm: PM runtime usage count leak on pm_runtime_get_sync() failure
- [High] drm/writeback: TOCTOU race condition in wb_pending flag causes mis=
sed completions and hangs
- [High] drm/writeback: devm_kzalloc of embedded DRM object causes Use-Afte=
r-Free
- [High] drm/mediatek: direct CPU MMIO writes bypass shadow registers, caus=
ing frame corruption
- [High] drm/mediatek: WDMA destination address overwritten by source plane=
 address
- [Medium] drm/mediatek: incorrect Color Transform (CT) matrix configuratio=
n for YUV outputs
- [Medium] drm/mediatek: TOCTOU race condition in VBLANK callback execution
--

commit a1732e4697d3071263a9ef778e8d3ea32f401bc7
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support

This patch adds a basic driver for the Write DMA (WDMA) engine, enabling
writeback support on MediaTek MT8173 and Dimensity 1200 MT6893 platforms. It
hooks the new component into the mtk_ddp_comp and mtk_drm_drv layers to all=
ow
for faster display image capturing to userspace.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_wdma.c
> new file mode 100644
> index 0000000000000..0575fade92c6b
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
> @@ -0,0 +1,628 @@

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

[Severity: Medium]
Could there be a race condition here if mtk_wdma_unregister_vblank_cb is
called concurrently? If the unregister function nullifies the pointer after
this check but before execution, it might lead to a NULL pointer dereferenc=
e.

> +
> +	/* TODO: Move completion signaling to CMDQ interrupt callback */
> +	if (wdma->wb_pending) {
> +		drm_writeback_signal_completion(&wdma->wb_connector, 0);
> +		wdma->wb_pending =3D false;
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[ ... ]

> +void mtk_wdma_unregister_vblank_cb(struct device *dev)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +
> +	wdma->vblank_cb =3D NULL;
> +	wdma->vblank_cb_data =3D NULL;
> +}

[Severity: Medium]
As mentioned above, since these pointers are cleared without holding any
locks, does this risk a race with the IRQ handler reading them?

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
Does this direct writel bypassing the command queue and shadow registers
break hardware synchronization? Forcing an immediate CPU MMIO update while
the engine is actively scanning out could lead to frame corruption or
tearing.

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

[Severity: High]
Does this overwrite the writeback job's correct destination address with the
source plane's address? The writeback destination is programmed earlier in
the atomic commit, but writing pending->addr (the source plane) here might
cause the hardware to DMA captured screen content directly into the active
source buffer, corrupting memory.

> +
> +	if (!fmt_info->is_yuv) {
> +		/* Disable color transform matrix and data compression */
> +		mtk_ddp_write_mask(cmdq_pkt, 0, &wdma->cmdq_reg, wdma->regs,
> +				   DISP_REG_WDMA_CFG,
> +				   WDMA_UFO_DCP_ENABLE | WDMA_CT_EN);
> +		return;
> +	}
> +
> +	/* Additional format config required only for 420 sampling */
> +	if (!drm_format_info_is_yuv_sampling_420(fmt_info))
> +		return;

[Severity: Medium]
By returning early for non-4:2:0 packed YUV formats (like UYVY), doesn't
this fail to enable the color transform matrix entirely for those formats?

[ ... ]

> +	mtk_ddp_write(cmdq_pkt, FIELD_PREP(WDMA_UV_DST_W_IN_BYTE, u_stride),
> +		      &wdma->cmdq_reg, wdma->regs, DISP_REG_WDMA_DST_UV_PITCH);
> +
> +	/* Color transform coefficient selection */
> +	val =3D FIELD_PREP_CONST(WDMA_INT_MTX_SEL, WDMA_CT_COEF_JPEG_TO_RGB);

[Severity: Medium]
When capturing RGB screen content into a YUV writeback buffer, shouldn't the
conversion direction be RGB-to-YUV? WDMA_CT_COEF_JPEG_TO_RGB appears to
select YUV-to-RGB, which could result in corrupted color data.

[ ... ]

> +void mtk_wdma_layer_config(struct device *dev, unsigned int idx,
> +			   struct mtk_plane_state *state,
> +			   struct cmdq_pkt *cmdq_pkt)
> +{

[ ... ]

> +	mtk_ddp_write(cmdq_pkt, con, &wdma->cmdq_reg, wdma->regs,
> +		      DISP_REG_WDMA_CFG);
> +	mtk_ddp_write(cmdq_pkt, pitch, &wdma->cmdq_reg, wdma->regs,
> +		      DISP_REG_WDMA_DST_W_IN_BYTE);
> +
> +	mtk_wdma_format_config(wdma, pending, fmt_info, cmdq_pkt);
> +
> +	drm_writeback_queue_job(&wdma->wb_connector, wdma->wb_connector.base.st=
ate);
> +}

[Severity: Critical]
Can this unconditional call to drm_writeback_queue_job cause a NULL
pointer dereference? If the writeback job was already queued by the atomic
commit function (which sets conn_state->writeback_job to NULL), this
redundant call would pass a NULL job pointer to the queue list.

[ ... ]

> +static void mtk_wdma_wb_connector_atomic_commit(struct drm_connector *co=
nnector,
> +						struct drm_atomic_commit *state)
> +{
> +	struct drm_connector_state *conn_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct mtk_disp_wdma *wdma =3D connector_to_wdma(connector);
> +	struct drm_framebuffer *fb;
> +	struct drm_gem_object *gem;
> +	struct drm_gem_dma_object *dma_obj;
> +	dma_addr_t addr;
> +
> +	if (WARN_ON(!conn_state->writeback_job))
> +		return;
> +
> +	fb =3D conn_state->writeback_job->fb;
> +	if (!fb)
> +		return;
> +
> +	gem =3D fb->obj[0];
> +	dma_obj =3D to_drm_gem_dma_obj(gem);
> +	addr =3D dma_obj->dma_addr;
> +
> +	/* Store writeback pending state before queuing the job */
> +	wdma->wb_pending =3D true;

[Severity: High]
Is there a race condition between setting wdma->wb_pending here and the
VBLANK interrupt? If the interrupt fires before the job is safely added to
the queue below, the IRQ handler will see wb_pending as true, attempt to
signal a non-existent job, and clear the flag. Subsequent interrupts would
then see wb_pending as false, permanently hanging userspace.

> +
> +	mtk_wdma_ddp_write_dst_addr(NULL, addr, 0, wdma);

[Severity: High]
By passing NULL for the cmdq_pkt, doesn't this force an immediate,
unsynchronized CPU MMIO write of the destination address while the engine
might still be scanning out?

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
If pm_runtime_get_sync fails and returns a negative error code, does
skipping pm_runtime_put here leak the PM runtime usage counter? Since
pm_runtime_get_sync always increments the usage counter even on failure,
this skip might permanently prevent the device and its power domain from
suspending.

> +
> +	enable_irq(wdma->irq);
> +	return 0;
> +}
> +
> +static void mtk_disp_wdma_unbind(struct device *dev, struct device *mast=
er,
> +				 void *data)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +
> +	disable_irq(wdma->irq);
> +}

[Severity: High]
Since the writeback connector isn't cleaned up here before devm frees the
memory allocated during probe, won't closing the DRM file descriptor later
cause a use-after-free? When the DRM device outlives the platform device,
drm_mode_config_cleanup will iterate over the freed connector.

[ ... ]

> +static int mtk_disp_wdma_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct mtk_disp_wdma *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);

[Severity: High]
Does tying the allocation of the embedded struct drm_writeback_connector to
the platform device lifecycle via devm_kzalloc create a use-after-free
risk when the platform device unbinds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916110825.1026=
31-1-angelogioacchino.delregno@collabora.com?part=3D13
