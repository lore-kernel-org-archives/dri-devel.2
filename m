Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DD4C88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE7F10E1A8;
	Mon, 14 Sep 2026 12:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D67ezFZZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4377410E1A8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:31:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB132601E4;
 Mon, 14 Sep 2026 12:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA671F00893;
 Mon, 14 Sep 2026 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789389087;
 bh=7GJ0hmqm2wYU9Cj0CXv/fEzS/E6qw/c7RxMyhw4VYoU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D67ezFZZhXw/EV3UhJSvvlAGq9RdVEZRAbUGHYDIS2Y9j0mpinfqT56D61mDMgWpE
 QvThnzsONiyiemd2vwj2Bh9kRCbV71d4VloL+fomUUDgTseaTxazYPUy2ex1RJh0aE
 YgktUIWzSGf8W6cl1k64mNU+OA6TGVx9oZ3+F2r+itgXkqegnZX1OhTviv6fMqdszi
 20ap8SrNXq6jOKgo46dCo2TmVOZCIfGbeZvgod7FhYKNnW1p+UqEUJHgVrrdVdE/LU
 Gwx/7zNmvmqjztYNQ+O0cy6m+5AJl3eKYbc6K4+JhvqF6klN/bwmjIJhOoeTVt0d1A
 5hn6nz3W62Wuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/13] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260914115812.22751-14-angelogioacchino.delregno@collabora.com>
References: <20260914115812.22751-1-angelogioacchino.delregno@collabora.com>
 <20260914115812.22751-14-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:31:26 +0000
Message-Id: <20260914123127.2DA671F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Unconditional NULL pointer dereference due to double-queuing o=
f writeback job.
- [Critical] Hardware Use-After-Free and continuous memory corruption due t=
o missing one-shot WDMA disable.
- [Critical] WDMA destination address is erroneously programmed with the in=
put plane's source buffer.
- [High] Direct CPU MMIO writes bypass the CMDQ and VBLANK synchronization,=
 risking tearing.
- [High] PM Runtime usage counter leak on failure.
--

commit 755cfd13f385380e700d97174dac89e1c3a5c181
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support

This commit adds a basic driver for the Write DMA Engine (WDMA) on the
MediaTek MT8173 and Dimensity 1200 MT6893 platforms. It enables the
writeback engine used for display image capturing.

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
> +
> +	/* TODO: Move completion signaling to CMDQ interrupt callback */
> +	if (wdma->wb_pending) {
> +		drm_writeback_signal_completion(&wdma->wb_connector, 0);
> +		wdma->wb_pending =3D false;
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Critical]
Is it possible this leaves the hardware engine running continuously?

DRM writeback operations are typically one-shot per queued job, and when
this interrupt handler signals completion, buffer ownership returns to
userspace. However, it appears WDMA_ENGINE_EN is never cleared here.

Because the underlying display pipeline stays active, could the hardware
continue capturing frames and silently overwrite the completed buffer on
subsequent vblanks if userspace reuses or frees it?

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
Does bypassing the shadow registers here break vblank synchronization?

Since atomic commits execute asynchronously, forcing an immediate shadow
register commit with a direct CPU writel() might race with the active
hardware engine mid-frame and cause display tearing. The pipeline usually
relies on the command engine via cmdq_pkt to serialize updates
synchronously at vblank.

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
Could this accidentally overwrite the active display's source memory buffer?

mtk_wdma_layer_config() operates on the input plane being scanned out and
passes its pending state into this function. Writing pending->addr (the DMA
address of the source input plane) into the WDMA destination registers means
the hardware might capture the display output and dump it straight back into
the source buffer, corrupting it.

[ ... ]
> +void mtk_wdma_layer_config(struct device *dev, unsigned int idx,
> +			   struct mtk_plane_state *state,
> +			   struct cmdq_pkt *cmdq_pkt)
> +{
[ ... ]
> +	mtk_wdma_format_config(wdma, pending, fmt_info, cmdq_pkt);
> +
> +	drm_writeback_queue_job(&wdma->wb_connector, wdma->wb_connector.base.st=
ate);
> +}

[Severity: Critical]
Will this trigger a null pointer dereference?

mtk_wdma_wb_connector_atomic_commit() correctly consumes the writeback job
by queuing it, setting conn_state->writeback_job to NULL.

Later in the pipeline, this secondary call passes the connector state where
the job pointer is now NULL (or was already NULL if no job was requested),
which drm_writeback_queue_job() will immediately try to dereference when
adding to the job queue.

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
> +
> +	mtk_wdma_ddp_write_dst_addr(NULL, addr, 0, wdma);

[Severity: High]
Similar to the shadow register bypass above, does passing NULL for the
cmdq_pkt here risk tearing?

This forces an immediate, unsynchronized writel() of the destination address
during the atomic commit setup, rather than queuing it for the command engi=
ne
to apply synchronously at vblank.

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
Does this leak the PM runtime usage counter on failure?

pm_runtime_get_sync() increments the usage counter unconditionally. By
skipping the put when ret < 0, the device and its power domain might
never be able to suspend.

Also, pm_runtime_get_sync() returns 1 if the device is already active. This
would be treated as an error by the preceding if (ret) check and emit a
spurious warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914115812.2275=
1-1-angelogioacchino.delregno@collabora.com?part=3D13
