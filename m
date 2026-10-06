Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F274CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5E310E18E;
	Tue,  6 Oct 2026 12:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EGvWYJma";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2509E10E38C
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:39:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 472316022C;
 Tue,  6 Oct 2026 12:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3D01F000FF;
 Tue,  6 Oct 2026 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791290347;
 bh=Yq6OiSx3FxPuTsvTlsCDDPOyEIntIosfuEfu0U4SWeM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EGvWYJmav2Ur2h0tYlZSCOtexebXgZimXCswJmf97f7z9mZ/IjejJ5KI+m2/p8CHt
 rdOxNeUPLu/3CmgVSBLcSvejq74eBhZFWhBOyY4vcbdt+EjD+miisnse7jVUahT59v
 YAH4fRLMLIL82peLDwifAzhHSLBO/L++IJMiNbBTGuQU97mF8CwUx5CNpHMtmMN3RV
 BApzi5/F5gz5ys9k4q3eU2OqMdOfyvQesMaVDUGwwllxkDoOq/E3RZFHD+K8btzsTf
 Sjjt3Q7ygGKlZ9L+8UuAIvJ1VP51iyC7KpdKjUtbKATh6sr4dN+t5hAMS+l1+2v0ae
 f6hBFUMErDlwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/9] drm/imx: Add support for i.MX94 DCIF
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261006-dcif-upstreaming-v10-5-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-5-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 12:39:06 +0000
Message-Id: <20261006123906.AA3D01F000FF@smtp.kernel.org>
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
- [High] drm/imx/dcif: unpowered MMIO access crash if PM resume fails in at=
omic_enable
- [High] drm/imx/dcif: vblank refcount underflow and memory leak via manual=
 event caching
- [High] drm/imx/dcif: NULL pointer dereference in IRQ handler during probe
- [Medium] drm/imx/dcif: premature vblank event delivery exposes race with =
plane updates
- [Medium] drm/imx/dcif: back-to-back software reset may cause incomplete h=
ardware reset
--

commit 5b82f4222050053f161ded1c655289268046892b
Author: Sandor Yu <sandor.yu@nxp.com>

drm/imx: Add support for i.MX94 DCIF

The i.MX94 Display Control Interface features:
 * Up to maximum 3 layers of alpha blending:
    - 1 background layer(Layer 0);
    - 1 foreground layer(Layer 1);
    - A programmable constant color behind the background layer;
 * Each layer supports:
    - programmable plane size;
    - programmable background color;
    - embedded alpha and global alpha;
 * Data output with CRC checksum for 4 programmable regions;

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crtc.c b/drivers/gpu/drm/imx/d=
cif/dcif-crtc.c
> index 0000000000000..07016b5fc700d 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
> @@ -0,0 +1,763 @@

[ ... ]

> +static void dcif_reset_block(struct dcif_dev *dcif)
> +{
> +	regmap_set_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_SW_RST);
> +
> +	regmap_clear_bits(dcif->regmap, DCIF_DISP_CTRL, DCIF_DISP_CTRL_SW_RST);

[Severity: Medium]
Will this 1-cycle reset pulse be sufficient for full pipeline resets across
all clock domains? Since this toggles the bit via back-to-back regmap
writes without any delay or status polling, the hardware might remain in an
indeterminate state.

> +}

[ ... ]

> +static void dcif_crtc_queue_state_event(struct drm_crtc *crtc)
> +{
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +
> +	scoped_guard(spinlock_irq, &crtc->dev->event_lock) {
> +		if (crtc->state->event) {
> +			WARN_ON(drm_crtc_vblank_get(crtc));
> +			WARN_ON(dcif->event);
> +			dcif->event =3D crtc->state->event;
> +			crtc->state->event =3D NULL;

[Severity: High]
Does this code leak the vblank event and underflow the refcount if
drm_crtc_vblank_get() fails? Even if the WARN_ON triggers, the event is
manually cached and the loop continues. Later, dcif_irq_handler() will
blindly call drm_crtc_vblank_put(), underflowing the refcount.=20

If the hardware times out and no VSYNC fires, the event is leaked when
overwritten or ignored during disable. Could this use
drm_crtc_arm_vblank_event() instead of manual caching?

> +		}
> +	}
> +}

[ ... ]

> +static void dcif_crtc_atomic_enable(struct drm_crtc *crtc,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, crtc->primary);
> +	struct dcif_crtc_state *dcif_crtc_state =3D to_dcif_crtc_state(crtc_sta=
te);
> +	struct drm_display_mode *adj =3D &crtc_state->adjusted_mode;
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +	struct drm_device *drm =3D crtc->dev;
> +	dma_addr_t baseaddr;
> +	int ret;
> +
> +	dev_dbg(drm->dev, "mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(adj));
> +
> +	/* enable power when we start to set mode for CRTC */
> +	ret =3D pm_runtime_resume_and_get(drm->dev);
> +	if (ret < 0) {
> +		drm_err(drm, "failed to resume DCIF, ret =3D %d\n", ret);
> +
> +		/* Don't leave the commit waiting for a flip done that never comes. */
> +		scoped_guard(spinlock_irq, &drm->event_lock) {
> +			if (crtc->state->event) {
> +				drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +				crtc->state->event =3D NULL;
> +			}
> +		}
> +		return;

[Severity: High]
If this returns early, will the DRM atomic helpers proceed to call
dcif_plane_atomic_update() anyway? Since the helpers ignore this void
return, plane updates will write to unpowered registers (e.g.,
DCIF_CTRLDESC1) and the subsequent dcif_crtc_atomic_disable() will call
dcif_disable_controller() which also accesses registers, causing a kernel
panic from unpowered MMIO access.

> +	}
> +	dcif->crtc_pm_enabled =3D true;
> +
> +	dcif_crtc_mode_set_nofb(crtc_state, plane_state);
> +
> +	drm_crtc_vblank_on(crtc);
> +
> +	baseaddr =3D drm_fb_dma_get_gem_addr(plane_state->fb, plane_state, 0);
> +	if (baseaddr)
> +		regmap_write(dcif->regmap, DCIF_CTRLDESC4(0), baseaddr);
> +
> +	dcif_enable_plane_panic(dcif);
> +	dcif_enable_controller(dcif);
> +
> +	dcif_crtc_queue_state_event(crtc);

[Severity: Medium]
Since the controller is already enabled at this point, could a VSYNC
interrupt fire and deliver the event to userspace prematurely? Userspace
might receive the completion event before drm_atomic_helper_commit_planes()
finishes calling atomic_update on overlay planes, potentially causing
framebuffers to be released too early.

> +
> +	if (dcif->has_crc && dcif_crtc_state->crc.source !=3D DCIF_CRC_SRC_NONE=
) {
> +		struct drm_rect roi;
> +
> +		dcif_crtc_get_crc_roi(crtc_state, &roi);
> +		dcif_crc_source_enable(dcif, dcif_crtc_state->crc.source, &roi, 0);
> +	}
> +}

[ ... ]

> +irqreturn_t dcif_irq_handler(int irq, void *data)
> +{
> +	struct drm_device *drm =3D data;
> +	struct dcif_dev *dcif =3D to_dcif_dev(drm);
> +	int domain =3D dcif->cpu_domain;
> +	u32 stat0, stat1, crc;
> +
> +	regmap_read(dcif->regmap, DCIF_IS0(domain), &stat0);
> +	regmap_read(dcif->regmap, DCIF_IS1(domain), &stat1);
> +	regmap_write(dcif->regmap, DCIF_IS0(domain), stat0);
> +	regmap_write(dcif->regmap, DCIF_IS1(domain), stat1);
> +
> +	if (stat0 & DCIF_INT0_VS_BLANK) {
> +		drm_crtc_handle_vblank(&dcif->crtc);

[Severity: High]
Could this dereference a NULL crtc->dev? In dcif_probe(),
devm_request_irq() is called before the CRTC is initialized by
dcif_kms_prepare(). If the bootloader left the display active, a pending
VSYNC interrupt could fire immediately, passing the uninitialized CRTC to
drm_crtc_handle_vblank().

> +
> +		scoped_guard(spinlock_irqsave, &drm->event_lock) {
> +			if (dcif->event) {

[ ... ]

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-drv.c b/drivers/gpu/drm/imx/dc=
if/dcif-drv.c
> index 0000000000000..ddc2614656a79 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-drv.c
> @@ -0,0 +1,238 @@

[ ... ]

> +static int dcif_probe(struct platform_device *pdev)
> +{
> +	struct dcif_dev *dcif;
> +	struct drm_device *drm;
> +	int ret;
> +	int i;

[ ... ]

> +	ret =3D devm_request_irq(drm->dev, dcif->irq[dcif->cpu_domain],
> +			       dcif_irq_handler, 0, drm->driver->name, drm);
> +	if (ret < 0)
> +		return dev_err_probe(drm->dev, ret, "failed to install IRQ handler\n");
> +
> +	dcif_read_chip_info(dcif);
> +
> +	ret =3D dcif_kms_prepare(dcif);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-dcif-upstr=
eaming-v10-0-bcfb28de0aae@oss.nxp.com?part=3D5
