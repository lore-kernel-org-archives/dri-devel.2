Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DB7C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F83D10F02F;
	Wed, 15 Jul 2026 12:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J13QdJl6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C444E10F02C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:28:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1979F61375;
 Wed, 15 Jul 2026 12:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDAA1F000E9;
 Wed, 15 Jul 2026 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784118481;
 bh=xk1Vzn9Nu9U658eiuzTLonKB5ePvajqexK0HaMj8gIM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J13QdJl6se3vdhjMUYogCZ/9ANnEUkDdiEsMNj0OVbnKl4E977V01iaIInDdiOdoI
 LwcJc/LR6PnRGeRfFzhtPtVCD/JnA5LeJLn1EjPMxAHXifq6n+Dj8wv4l6qLC3LY14
 QMY/PNaEXwWnMAcFugiAS0fbWDm1Vxbvov2/W5FIF7q9cpC3Ov7Fm6oZYuFrNJxF0R
 ODWradkvg9N+Yaoz9BMqpOqEP+b+/YbmyxPsV7vm1bsfgXj1nrb0lpKj7d+LELB+8Q
 zPNLLWuE7E5e5XqO6y9N7LHTlf1c53dPgjd5gKDOGUGwYg/MmgGlaatmTn0SzmaTod
 HnVFiCex8J5gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/11] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260715114916.19690-12-angelogioacchino.delregno@collabora.com>
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:28:01 +0000
Message-Id: <20260715122801.7EDAA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Incorrect handling of pm_runtime_get_sync() return value leads to =
leaked usage counters and false positive warnings.
- [High] TOCTOU race condition in atomic commit leads to permanent writebac=
k job hangs.
- [High] Direct CPU writes to WDMA destination address bypass CMDQ and shad=
ow registers, causing memory corruption.
- [High] Use-After-Free of drm_writeback_connector upon component unbind.
- [High] Writeback job completions hang if CRTC vblanks are disabled.
- [High] Architectural flaw: WDMA hardware operates on uninitialized regist=
ers because its configuration logic is placed in an unreachable callback.
- [High] Unconditional drm_writeback_queue_job() in dead layer_config callb=
ack causes NULL pointer dereference.
- [High] Using input plane buffer as writeback destination in layer_config.
- [High] Incorrect V-component offset calculation for NV12/NV21 formats cor=
rupts Y-plane memory.
- [Medium] Userspace restricted to only DRM_FORMAT_RGB888 despite extensive=
 hardware support.
- [Low] Undeclared identifier `mtk_disp_wdma_remove` causes a build failure.
--

--- Patch [11]: [PATCH v5 11/11] drm/mediatek: Add Write DMA (WDMA) Engine =
for Writeback support ---
commit 44482b38c93bd94760e17536a8322d71d1649d0f
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support

This commit adds a basic driver for the Write DMA Engine and initial
compatible strings for the MediaTek MT8173 and Dimensity 1200 MT6893.
It hooks the engine up to the display controller to enable writeback for
faster display image capturing in userspace.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_wdma.c
> new file mode 100644
> index 0000000000000..650ab902f7956
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
[ ... ]
> +static const u32 mtk_wdma_wb_output_formats[] =3D {
> +	DRM_FORMAT_RGB888
> +};
> +
> +static const u32 mt6893_formats[] =3D {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_YUV420,
> +	DRM_FORMAT_YVU420,
> +	DRM_FORMAT_UYVY,
> +	DRM_FORMAT_YUYV,
> +};

[Severity: Medium]
Are we intentionally limiting userspace to only DRM_FORMAT_RGB888?

The mt6893_formats array lists 13 supported formats, but the driver passes
the single-entry mtk_wdma_wb_output_formats array down to
drm_writeback_connector_init(). This means the DRM core will reject commits
for any of the other hardware-supported formats.

[ ... ]
> +void mtk_wdma_disable_vblank(struct device *dev)
> +{
> +	wdma_update_bits(dev, DISP_REG_WDMA_INT_ENABLE, WDMA_FRAME_COMPLETE_INT=
, 0);
> +}

[Severity: High]
Does this cause writeback jobs to time out if the CRTC vblank is disabled?

The WDMA frame completion interrupt is toggled exclusively via this callbac=
k.
If userspace queues a writeback job without requesting a vblank event, the =
DRM
core might disable vblanks on the CRTC.=20

If the interrupt is disabled while the hardware captures the frame, is there
any other way the driver can receive the completion and call
drm_writeback_signal_completion()?

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
Does enabling WDMA_BYPASS_SHADOW here risk memory corruption when combined
with immediate destination address updates?

Later in mtk_wdma_wb_connector_atomic_commit(), the destination address is
updated by passing NULL for the cmdq_pkt, which bypasses the command queue
and performs an immediate CPU writel(). Without shadow registers to synchro=
nize
the update to the VBLANK boundary, altering the destination address while t=
he
hardware is actively transferring a frame could scatter image data across m=
emory.

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
Does this overwrite the source image buffer?

By extracting pending->addr from the input plane state and using it as the
DMA destination address, the writeback engine appears to be configured to
dump the captured frame directly over the memory buffer of the image being
displayed, rather than into the userspace-provided writeback job framebuffe=
r.

[ ... ]
> +	if (drm_format_info_is_yuv_planar(fmt_info)) {
> +		/* YUV420 or YVU420 */
> +		u_stride =3D ALIGN(u_stride, 16);
> +		u_size =3D u_stride * pending->height / 2;
> +		v_off =3D u_off + u_size;
> +	} else {
> +		/* NV12 or NV21 */
> +		u_size =3D u_stride * pending->height / 2;
> +		v_off =3D 0;
> +	}
> +
> +	/* Set U and V components destination addresses */
> +	mtk_wdma_ddp_write_dst_addr(cmdq_pkt, pending->addr + u_off, 1, wdma);
> +	mtk_wdma_ddp_write_dst_addr(cmdq_pkt, pending->addr + v_off, 2, wdma);

[Severity: High]
Will this corrupt the Y-plane memory for semi-planar formats?

By hardcoding v_off to 0 for NV12 and NV21, the third hardware address
register is mapped exactly over the start of the buffer. This would cause t=
he
hardware to overwrite the Luma (Y) data with Chroma data.

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

[Severity: High]
Is this function ever actually executed?

The MediaTek CRTC driver only invokes the .layer_config callback on objects
registered as input planes. Since WDMA is a writeback output connector, this
looks like unreachable dead code. If it is never called, the WDMA hardware
is never fully configured (format, size, pitch) during a commit.

[Severity: High]
Additionally, if this callback is somehow reached, could
drm_writeback_queue_job() cause a NULL pointer dereference?

If no writeback job was requested for the commit, or if it was already queu=
ed
in atomic_commit, wdma->wb_connector.base.state->writeback_job might be NUL=
L.
The drm_writeback_queue_job() function dereferences this pointer internally
when attempting to add the job to the list.

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
> +	drm_writeback_queue_job(&wdma->wb_connector, conn_state);
> +}

[Severity: High]
Could setting wdma->wb_pending to true before queuing the job create a TOCT=
OU
race condition?

If the frame completion interrupt fires in this narrow window, the IRQ hand=
ler
would see the flag, try to signal an empty queue, and then clear the flag.
When the job is queued immediately after, subsequent interrupts will ignore
the pending job because the flag is now false, permanently hanging the
writeback commit.

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
> +	if (ret)
> +		return ret;
> +
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
Does this error handling logic for pm_runtime_get_sync() leak the usage
counter and cause false positive warnings?

If the device is already active, pm_runtime_get_sync() returns 1, which
incorrectly triggers the dev_warn() since "if (ret)" evaluates to true.

Conversely, if it returns a negative error code, the "if (ret >=3D 0)" check
evaluates to false. This skips pm_runtime_put(dev) and permanently leaks the
usage counter that was unconditionally incremented inside pm_runtime_get_sy=
nc().

[Severity: High]
Can this implementation lead to a Use-After-Free of the
drm_writeback_connector upon component unbind?

The wb_connector is embedded in struct mtk_disp_wdma, which is managed by
devres via devm_kzalloc. However, drm_writeback_connector_init() registers
it with the DRM core, whose lifecycle can outlive the physical device (e.g.=
 if
userspace holds a file descriptor open). When the component unbinds, devres
frees the memory, but the DRM core will still attempt to access the connect=
or
during its own eventual teardown.

[ ... ]
> +static void mtk_disp_rdma_remove(struct platform_device *pdev)
> +{
> +	component_del(&pdev->dev, &mtk_disp_wdma_component_ops);
> +}
[ ... ]
> +struct platform_driver mtk_disp_wdma_driver =3D {
> +	.probe		=3D mtk_disp_wdma_probe,
> +	.remove		=3D mtk_disp_wdma_remove,
> +	.driver		=3D {
> +		.name	=3D "mediatek-disp-wdma",
> +		.of_match_table =3D mtk_disp_wdma_driver_dt_match,
> +	},
> +};

[Severity: Low]
Does this cause a build failure?

The platform driver references mtk_disp_wdma_remove, but the actual function
definition just above is named mtk_disp_rdma_remove.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715114916.1969=
0-1-angelogioacchino.delregno@collabora.com?part=3D11
