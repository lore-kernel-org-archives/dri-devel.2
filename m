Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF183C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622E810EA0D;
	Mon, 13 Jul 2026 14:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ntjjsl8t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D52110EA0D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:47:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C86240A42;
 Mon, 13 Jul 2026 14:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A991F000E9;
 Mon, 13 Jul 2026 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783954043;
 bh=voPI4eOGXrsz2i5rRxY98Dpb4AUV20NIjyVJr5qKRMI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ntjjsl8t1fhQfb5LgQn6EKdLK8eAX23miMm1fFasUzdWDFsUdH2b4VpzGr+kbkyCs
 V7yBBTMvwkglMUKIzC3BPXgKYvrQAGDR0dpirSwIHrapQ1jGjJaOoUxcIb2RVUXbBN
 auA80XJqo1jEuXrePfnGzHPdA8Tv4PSQIy6Or9b8Tggw5kEeYTOODEqv6UzNBVp4df
 ZVvYHAp05DiYlMN+qOywPFuiaQqT98p/yjXwnDtGSNk2EnmQgPPzU4PGbE5PcCChg1
 eLhTCRpwlI8RWce6gEH9/zdtXo311q0YavtzJjPZgBC7tRpDD48uEBLnm4VFPFosX/
 JWK7/jO/pr3Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260713142746.40259-11-angelogioacchino.delregno@collabora.com>
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:47:22 +0000
Message-Id: <20260713144722.C0A991F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [High] WDMA hardware configuration is misplaced in a plane callback, leav=
ing hardware registers uninitialized.
- [High] Bypass of CMDQ synchronization via raw CPU MMIO writes causes pipe=
line tearing.
- [High] Unprotected TOCTOU race condition on `wb_pending` can permanently =
hang the writeback connector or trigger warnings.
- [High] The writeback destination DMA address calculation ignores the fram=
ebuffer's plane offset.
- [High] WDMA writeback destination address is incorrectly assigned the sou=
rce plane address.
- [High] Writeback jobs hang forever because the WDMA frame completion inte=
rrupt is never enabled.
- [High] Atomic check breaks standard display updates when no writeback job=
 is queued.
- [High] Missing `.remove` callback in platform driver leads to leaked comp=
onent and Use-After-Free.
- [High] Unprotected check of `wdma->vblank_cb` can lead to a NULL pointer =
dereference.
- [Medium] Improper handling of pm_runtime_get_sync() return values leads t=
o a PM usage counter leak.
- [Medium] WDMA writeback format is artificially restricted to RGB888 despi=
te robust hardware support.
- [Medium] `mtk_wdma_stop()` falsely signals pending writeback jobs with su=
ccess (0) instead of an error code.
--

--- Patch [10]: [PATCH v4 10/10] drm/mediatek: Add Write DMA (WDMA) Engine =
for Writeback support ---
commit 5da1257f7edfc5dd259de5b087094d68961d4d72
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support

Add a basic driver for the Write DMA Engine and initial compatible for the
MediaTek MT8173 and MediaTek Dimensity 1200 MT6893. This hooks the engine up
to the mtk_ddp_comp and mtk_drm_drv to enable writeback for capturing displ=
ay
images to userspace.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_wdma.c
> new file mode 100644
> index 0000000000000..7c3df4c1445d0
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
Can this unprotected check of wdma->vblank_cb result in a NULL pointer
dereference?

If mtk_wdma_unregister_vblank_cb() sets these pointers to NULL in process
context concurrently with this interrupt handler, the compiler might reload
the pointer between the check and execution without locking or memory
barriers.

> +
> +	/* TODO: Move completion signaling to CMDQ interrupt callback */
> +	if (wdma->wb_pending) {
> +		drm_writeback_signal_completion(&wdma->wb_connector, 0);
> +		wdma->wb_pending =3D false;
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Can this race condition between the atomic commit and the IRQ handler hang
the writeback connector?

In mtk_wdma_wb_connector_atomic_commit(), wdma->wb_pending is set to true
before the job is actually queued to the list. If an interrupt fires in that
window, this IRQ handler could see the flag, call signal completion with no
job present, and clear the flag. The job would subsequently be queued but
never signaled.

[ ... ]
> +void mtk_wdma_enable_vblank(struct device *dev)
> +{
> +	wdma_update_bits(dev, DISP_REG_WDMA_INT_ENABLE, WDMA_FRAME_COMPLETE_INT,
> +			 WDMA_FRAME_COMPLETE_INT);
> +}

[Severity: High]
Are the WDMA frame completion interrupts ever enabled?

The mtk_crtc_enable_vblank() function exclusively invokes the enable_vblank
hook for the first component in the display path (comp[0]). Because WDMA is
at the end of the pipeline, it seems this hook is never called, which would
leave writeback jobs hanging indefinitely waiting for completion.

[ ... ]
> +void mtk_wdma_stop(struct device *dev)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);
> +
> +	if (wdma->wb_pending) {
> +		drm_writeback_signal_completion(&wdma->wb_connector, 0);
> +		wdma->wb_pending =3D false;
> +	}
> +
> +	wdma_update_bits(dev, DISP_REG_WDMA_EN, WDMA_ENGINE_EN, 0);
> +}

[Severity: Medium]
Should an aborted writeback job signal an error code here instead of 0?

Passing 0 (success) on abort could mislead userspace into processing
incomplete, stale, or uninitialized data from the writeback buffer. Signali=
ng
an error like -ECANCELED would properly inform userspace of the aborted
capture.

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
Does this assign the source plane address to the writeback destination
address register?

Using pending->addr sets the destination address to the source image being
read by the CRTC plane. This appears to cause the WDMA engine to overwrite
the active framebuffer instead of the intended writeback destination buffer.

[ ... ]
> +void mtk_wdma_layer_config(struct device *dev, unsigned int idx,
> +			   struct mtk_plane_state *state,
> +			   struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_disp_wdma *wdma =3D dev_get_drvdata(dev);

[Severity: High]
Is this configuration callback ever executed?

Since WDMA is at the end of the display pipeline, mtk_crtc_num_comp_planes()
evaluates to 0 for it. Consequently, mtk_ddp_comp_for_plane() never
associates a plane with the WDMA component, and this layer_config callback
is never reached. This would leave the WDMA engine capturing garbage with
uninitialized hardware registers.

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
> +		return -EINVAL;

[Severity: High]
Does returning -EINVAL here prevent standard screen updates that do not
include a writeback job?

Userspace frequently performs atomic display updates on the CRTC without
queueing a writeback job on every frame. Returning an error rather than 0
in the absence of a writeback job breaks normal DRM display operations.

> +
> +	fb =3D conn_state->writeback_job->fb;
> +	if (fb->width !=3D mode->hdisplay || fb->height !=3D mode->vdisplay)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mtk_wdma_wb_output_formats); i++) {
> +		if (fb->format->format =3D=3D mtk_wdma_wb_output_formats[i])
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}

[Severity: Medium]
Is the writeback format intentionally restricted to just RGB888?

The mtk_wdma_wb_output_formats array contains exactly one element. The driv=
er
also contains the mt6893_formats array with 13 different supported formats =
and
a full wdma_fmt_convert() switch statement, which are rendered dead code by
this restriction.

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

[Severity: High]
Should the destination DMA address calculation account for the framebuffer's
plane offset?

Ignoring fb->offsets[0] here causes captured image data to be written to the
wrong location within the GEM buffer whenever userspace specifies a non-zero
offset during framebuffer creation.

> +
> +	/* Store writeback pending state before queuing the job */
> +	wdma->wb_pending =3D true;
> +
> +	mtk_wdma_ddp_write_dst_addr(NULL, addr, 0, wdma);

[Severity: High]
Could passing NULL for cmdq_pkt bypass the CMDQ synchronization and cause
hardware tearing during active scanout?

Explicitly passing a NULL cmdq_pkt to mtk_wdma_ddp_write_dst_addr() forces
a synchronous CPU writel() to the hardware state immediately in process
context, rather than synchronizing the write with VBLANK via the CMDQ.

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
> +	if (ret =3D=3D 0)
> +		pm_runtime_put(dev);

[Severity: Medium]
Does this evaluation of pm_runtime_get_sync() leak the PM usage counter?

The pm_runtime_get_sync() function returns 1 if the device was already
active, and a negative error code on failure. In both cases, the PM core
still increments the usage counter. Checking for exactly 0 means the
pm_runtime_put(dev) is skipped for ret =3D=3D 1 or ret < 0, resulting in a
permanent usage counter leak that prevents the device from suspending.

[ ... ]
> +struct platform_driver mtk_disp_wdma_driver =3D {
> +	.probe		=3D mtk_disp_wdma_probe,
> +	.driver		=3D {
> +		.name	=3D "mediatek-disp-wdma",
> +		.of_match_table =3D mtk_disp_wdma_driver_dt_match,
> +	},
> +};

[Severity: High]
Could the missing .remove callback lead to a component leak and
use-after-free when the device is unbound?

The mtk_disp_wdma_probe() function uses component_add(), but the driver
lacks a corresponding .remove callback to invoke component_del(). If the
module is unloaded or the device is unbound, the component framework retains
a dangling pointer to the removed component and its ops.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713142746.4025=
9-1-angelogioacchino.delregno@collabora.com?part=3D10
