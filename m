Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A12C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B547D10E9BC;
	Mon, 13 Jul 2026 13:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCCXyO/E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4D010E9C1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:18:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4735D43230;
 Mon, 13 Jul 2026 13:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4161F00A3A;
 Mon, 13 Jul 2026 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783948701;
 bh=Xeh10DUpKQxnw8sNjYWzYY43S0jl9qhNFzywHoGXP2c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UCCXyO/ERrJhGKEMxY2MIisLQGqEyuXPcMmcm3yrhYL+9gFtv1wSwBj8/f/whwD8x
 DubdC6QMZH3oqdVLZaFWbU45KrUSg7IgjXOeRS7YYboY8Hsa8s/ou7jH+Kx+AqugwS
 EjGLNxr7ZmaTvuUrDPFDax9E//IoGHYGGWqBc+QU79SFjBNIQql+4Rc9kDLQivw3Iw
 3EJRoQH/TJF8sG+zge7c3oXkFqMh5log6lDfoE76lHfQH2hoBHC/AaUJO8/OicHuYO
 8f1Mmg4KnXtOHI4BR1UwyxX54JLyMGkc5SWugPUj98uCOuuQljGsC6HlXhzJ72xnEL
 sjVgYyugOVHFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260713130103.34654-11-angelogioacchino.delregno@collabora.com>
References: <20260713130103.34654-1-angelogioacchino.delregno@collabora.com>
 <20260713130103.34654-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:18:20 +0000
Message-Id: <20260713131820.CE4161F00A3A@smtp.kernel.org>
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
- [Critical] Missing framebuffer validation in writeback atomic check allow=
s userspace to trigger a NULL pointer dereference.
- [High] Critical hardware configuration is isolated in dead code, leaving =
the writeback engine unconfigured for standard captures.
- [High] Lockless access and flawed lifecycle of `wb_pending` flag lead to =
race conditions and premature writeback signaling.
- [High] Direct CPU writes bypass shadow registers and CMDQ, breaking atomi=
c vsync synchronization.
- [High] devm-allocated connector memory leads to Use-After-Free when the D=
RM device outlives the component.
- [High] Double `pm_runtime_disable` depth increment permanently breaks run=
time PM on unbind/rebind cycles.
- [High] Ignored `pm_runtime_get_sync` return value leads to MMIO access on=
 unpowered hardware.
- [Medium] The writeback connector is initialized with a hardcoded single-f=
ormat array instead of the device-specific formats array.
--

--- Patch [10]: [PATCH v3 10/10] drm/mediatek: Add Write DMA (WDMA) Engine =
for Writeback support ---
commit 874066d332ab58f5d45490f0a9d84a9c2abb2d3f
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support
   =20
This patch adds a basic driver for the Write DMA Engine for MediaTek MT8173
and MT6893. It hooks it up to the display controller to enable the writeback
engine that can be used for faster display image capturing in the userspace.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_wdma.c
> new file mode 100644
> index 0000000000000..057fbe298de1e
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
> +
> +	/* TODO: Move completion signaling to CMDQ interrupt callback */
> +	if (wdma->wb_pending) {

[Severity: High]
Is it safe to check and modify the wb_pending flag in hardirq context
without a lock?

In mtk_wdma_wb_connector_atomic_commit(), this flag is set to true
synchronously before the hardware update is actually processed via the CMDQ.
If an interrupt from a previous frame fires, could it observe the new
wb_pending state and prematurely signal the new writeback job?

> +		drm_writeback_signal_completion(&wdma->wb_connector, 0);
> +		wdma->wb_pending =3D false;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> +void mtk_wdma_config(struct device *dev, unsigned int width,
> +		     unsigned int height, unsigned int vrefresh,
> +		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +
> +	writel(WDMA_FORCE_COMMIT | WDMA_BYPASS_SHADOW,
> +	       wdma->regs + DISP_REG_WDMA_SHADOW_CTRL);

[Severity: High]
Does forcing shadow bypass here break the pipeline's vsync synchronization?

Combined with mtk_wdma_wb_connector_atomic_commit() passing a NULL
cmdq_pkt to mtk_wdma_ddp_write_dst_addr(), this causes direct CPU MMIO
writes that instantly update the hardware registers mid-frame, rather than
synchronizing with the vsync boundary via the command queue.

> +}
[ ... ]
> +void mtk_wdma_layer_config(struct device *dev, unsigned int idx,
> +			   struct mtk_plane_state *state,
> +			   struct cmdq_pkt *cmdq_pkt)
> +{

[Severity: High]
Is this configuration reachable for a writeback engine?

The writeback engine is typically not treated as an input plane by the
core CRTC logic, meaning mtk_wdma_layer_config() might never be called.

Meanwhile, the active commit path in mtk_wdma_wb_connector_atomic_commit()
only sets the destination address but fails to configure the rest of the
hardware (WDMA_SRC_SIZE, WDMA_CLIP_SIZE, WDMA_CFG). Could this result in
the writeback engine remaining unconfigured for standard captures?

> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +	struct mtk_plane_pending_state *pending =3D &state->pending;
[ ... ]
> +static int mtk_wdma_wb_atomic_check(struct drm_encoder *encoder,
> +				    struct drm_crtc_state *crtc_state,
> +				    struct drm_connector_state *conn_state)
> +{
> +	const struct drm_display_mode *mode =3D &crtc_state->mode;
> +	struct drm_framebuffer *fb;
> +	int i;
> +
> +	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> +		return 0;

[Severity: Critical]
If the atomic commit sets a writeback out fence but omits the framebuffer,
this check returns 0 (success) instead of -EINVAL.

Later in mtk_wdma_wb_connector_atomic_commit(), the code unconditionally
dereferences fb:

fb =3D conn_state->writeback_job->fb;
gem =3D fb->obj[0];

Could this lead to a NULL pointer dereference if userspace omits the
writeback framebuffer?

> +
> +	fb =3D conn_state->writeback_job->fb;
> +	if (fb->width !=3D mode->hdisplay || fb->height !=3D mode->vdisplay)
> +		return -EINVAL;
[ ... ]
> +static int mtk_disp_wdma_bind(struct device *dev, struct device *master,
> +			      void *data)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +	struct drm_device *drm_dev =3D data;
> +	int crtcs, ret;
> +
> +	crtcs =3D mtk_find_possible_crtcs(drm_dev, wdma->dev);
> +	if (crtcs < 0)
> +		return crtcs;
> +
> +	drm_connector_helper_add(&wdma->wb_connector.base,
> +				 &mtk_wdma_wb_connector_helper_funcs);
> +
> +	ret =3D drm_writeback_connector_init(drm_dev, &wdma->wb_connector,
> +					   &mtk_wdma_wb_connector_funcs,
> +					   &mtk_wdma_wb_encoder_helper_funcs,
> +					   mtk_wdma_wb_output_formats,
> +					   ARRAY_SIZE(mtk_wdma_wb_output_formats),

[Severity: Medium]
Is it intended to use the hardcoded mtk_wdma_wb_output_formats array here?

The driver sets up wdma->data->formats with 13 different formats (including
YUV variants), but this initialization restricts the connector to a single
RGB888 format, making the YUV conversion code unreachable.

> +					   crtcs);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable and clear pending interrupts */
> +	pm_runtime_get_sync(dev);
> +	writel(0x0, wdma->regs + DISP_REG_WDMA_INT_ENABLE);

[Severity: High]
What happens if the power domain or clock fails to enable?

Since the return value of pm_runtime_get_sync() is unchecked, a failure
could lead to accessing unclocked or unpowered MMIO registers in the
following writel() calls, potentially causing a bus fault.

> +	writel(0x0, wdma->regs + DISP_REG_WDMA_INT_STATUS);
> +	pm_runtime_put(dev);
> +
> +	enable_irq(wdma->irq);
> +	return 0;
> +}
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
Is it safe to allocate the DRM connector using devres here?

When the driver is unbound, devres will free this memory. However,
mtk_disp_wdma_unbind() does not call drm_connector_cleanup(). If a
userspace application still holds a reference to the DRM device, could
this lead to a use-after-free when the DRM subsystem later iterates over
its connector list?

> +	if (!priv)
> +		return -ENOMEM;
[ ... ]
> +static void mtk_disp_wdma_remove(struct platform_device *pdev)
> +{
> +	component_del(&pdev->dev, &mtk_disp_wdma_component_ops);
> +
> +	pm_runtime_disable(&pdev->dev);

[Severity: High]
Could this double the pm_runtime disable depth?

The probe function uses devm_pm_runtime_enable(), which automatically
registers a cleanup action to disable pm_runtime. Explicitly calling
pm_runtime_disable() in remove will increment the disable depth twice,
which might permanently disable the device on unbind/rebind cycles.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713130103.3465=
4-1-angelogioacchino.delregno@collabora.com?part=3D10
