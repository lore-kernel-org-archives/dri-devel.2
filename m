Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B204606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPPLUWd5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F31E10E1C9;
	Tue, 10 Nov 2026 15:14:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993DB10E14A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:14:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3C25636A7;
 Tue, 10 Nov 2026 15:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252AD1F008A1;
 Tue, 10 Nov 2026 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794323642;
 bh=lhDDcg+XFL8juadnmK5nrRutOKs6R7LkB2wmeynZIlA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EPPLUWd5JT7h3t3vV/xFBpSL9MAB97x6x8A3vFz3mKyoFSPpOJq8Z2YK8aS72BU7P
 VAN0aXpya+XPZVLFwvHUNTSx3iaDLq+vGbNWHBFrEooRTpkiTyfyl/wHfOboiNyiE/
 emahqSZWmK+09JeAcQ4TLhSU84Vj/85mt/ptmQWZP+YmYNDAPxyrHJ2bVQDXktDh+h
 6psmQExmkrZjpkW5M8l5/Vxxat7gogo9godh4uaOYpF+E8r1/fFsvo6QWvFXt9oWXR
 v0TUZnXyliGoDnfRVLkSvG9+HAIZSS65G3zqIDQ7n952TjDXCmlK11nFb1rlP0UFvh
 lDUTzWfSi0FSw==
Message-ID: <sashiko-outbox-207242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/7] drm/imx: Add support for i.MX94 DCIF
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org
In-Reply-To: <20261110-dcif-upstreaming-v11-4-9e13c85ae0d8@oss.nxp.com>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
 <20261110-dcif-upstreaming-v11-4-9e13c85ae0d8@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:14:01 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/imx/dcif: unclocked MMIO access when runtime PM resume
  fails
- [Medium] drm/imx: dcif: missing vblank reference in
  dcif_crc_source_enable()
- [Medium] drm/imx/dcif: unmasked interrupt status handling in
  dcif_irq_handler()
- [Medium] drm/imx: dcif: unchecked runtime PM resume in
  dcif_hw_probe_init()
- [Medium] drm/imx: dcif: unbalanced clock disable if
  dcif_runtime_resume() fails
- [Low] drm/imx: dcif: signed overflow in dcif_crc_source_parse() ROI
  check
- [Low] drm/imx/dcif: split __free() declaration in
  dcif_crtc_query_output_bus_format()
- [Low] drm/imx: dcif: missing fb->pitches[0] bounds check in
  dcif_plane_atomic_check()
--

commit b9251fe09a901a215b6a40b8b790485d134d37e2
Author: Sandor Yu <sandor.yu@nxp.com>

drm/imx: Add support for i.MX94 DCIF

This commit adds DRM/KMS driver support for the NXP i.MX94 Display Control
Interface (DCIF), including CRTC, primary and overlay planes, and CRC
generation.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crc.c b/drivers/gpu/drm/imx/dc=
if/dcif-crc.c
> new file mode 100644
> index 0000000000000..132e40d3f3d45
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crc.c
[ ... ]
> +void dcif_crc_source_enable(struct dcif_dev *dcif, enum dcif_crc_source =
source,
> +			    struct drm_rect *roi, int ncrc)
> +{
> +	if (ncrc >=3D MAX_DCIF_CRC_NUM)
> +		return;
> +
> +	if (source =3D=3D DCIF_CRC_SRC_NONE)
> +		return;
> +
> +	if (dcif->crc_is_enabled)
> +		return;
> +
> +	dcif_crc_config(dcif, roi, ncrc);
> +
> +	regmap_set_bits(dcif->regmap, DCIF_CRC_CTRL,
> +			DCIF_CRC_CTRL_CRC_MODE | DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN |
> +			DCIF_CRC_CTRL_CRC_TRIG);
> +
> +	scoped_guard(spinlock_irqsave, &dcif->drm.event_lock)
> +		dcif->crc_is_enabled =3D true;
> +}
> +
> +void dcif_crc_source_disable(struct dcif_dev *dcif, int ncrc)
> +{
> +	if (!dcif->crc_is_enabled)
> +		return;
> +
> +	if (ncrc >=3D MAX_DCIF_CRC_NUM)
> +		return;
> +
> +	regmap_clear_bits(dcif->regmap, DCIF_CRC_CTRL, DCIF_CRC_CTRL_CRC_EN(ncr=
c));
> +
> +	scoped_guard(spinlock_irqsave, &dcif->drm.event_lock)
> +		dcif->crc_is_enabled =3D false;
> +}

[Severity: Medium]
Should dcif_crc_source_enable() and dcif_crc_source_disable() acquire and
release a vblank reference with drm_crtc_vblank_get() and
drm_crtc_vblank_put()?

dcif_irq_handler() only samples DCIF_CRC_VAL_R(0) and calls
drm_crtc_add_crc_entry() when DCIF_INT0_VS_BLANK fires, and that interrupt
is only unmasked while a vblank reference is held.  On a steady display
without continuous page flips, the vblank disable timer will mask
DCIF_INT0_VS_BLANK after the atomic commit that enables CRC finishes,
causing reads from debugfs crc/data to block indefinitely.

[ ... ]

> +		while ((opt =3D strsep(&options, ",")) !=3D NULL) {
> +			if (i > 3)
> +				return -EINVAL;
> +
> +			ret =3D kstrtouint(opt, 10, &params[i]);
> +			if (ret < 0)
> +				return ret;
> +
> +			i++;
> +		}
> +
> +		if (i !=3D 4)
> +			return -EINVAL;
> +
> +		roi->x1 =3D params[0];
> +		roi->y1 =3D params[1];
> +		roi->x2 =3D params[2];
> +		roi->y2 =3D params[3];
> +
> +		if (!drm_rect_visible(roi))
> +			return -EINVAL;

[Severity: Low]
Can unsigned values in params[] wrap to negative ints in struct drm_rect
and bypass the ROI bounds checks?

For example, "roi:10,0,2147483648,10" sets roi->x1 =3D 10 and
roi->x2 =3D INT_MIN, which wraps in drm_rect_visible() to a positive width
and then passes dcif_crtc_check_crc_roi() because roi->x1 >=3D 0 and
roi->x2 <=3D m->hdisplay, programming truncated 12-bit coordinates into
DCIF_CRC_POS_R and DCIF_CRC_SIZE_R.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crtc.c b/drivers/gpu/drm/imx/d=
cif/dcif-crtc.c
> new file mode 100644
> index 0000000000000..d5285105fa4df
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
[ ... ]
> +static int dcif_crtc_query_output_bus_format(struct drm_crtc *crtc,
> +					     struct drm_crtc_state *crtc_state)
> +{
> +	struct dcif_crtc_state *dcif_state =3D to_dcif_crtc_state(crtc_state);
> +	struct drm_bridge *bridge __free(drm_bridge_put) =3D NULL;
> +	struct drm_bridge_state *bridge_state;
> +	u32 bus_format;
> +
> +	dcif_state->bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> +	dcif_state->bus_flags =3D 0;
> +
> +	bridge =3D dcif_crtc_get_bridge(crtc, crtc_state);

[Severity: Low]
This isn't a bug, but per Cleanup API conventions, bridge should be defined
and initialized in a single statement rather than declared with
__free(drm_bridge_put) =3D NULL at the top of the function and assigned
later.

[ ... ]

> +static void dcif_crtc_atomic_enable(struct drm_crtc *crtc,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct dcif_crtc_state *dcif_crtc_state =3D to_dcif_crtc_state(crtc_sta=
te);
> +	struct drm_display_mode *adj =3D &crtc_state->adjusted_mode;
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +	struct drm_device *drm =3D crtc->dev;
> +	int ret;
> +
> +	dev_dbg(drm->dev, "mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(adj));
> +
> +	/* enable power when we start to set mode for CRTC */
> +	ret =3D pm_runtime_resume_and_get(drm->dev);
> +	if (ret < 0) {
> +		drm_err(drm, "failed to resume DCIF, ret =3D %d\n", ret);
> +		return;
> +	}
> +	dcif->crtc_pm_enabled =3D true;
[ ... ]
> +}
> +
> +static void dcif_crtc_atomic_disable(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct dcif_crtc_state *dcif_crtc_state =3D to_dcif_crtc_state(crtc_sta=
te);
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +	struct drm_device *drm =3D crtc->dev;
> +
> +	if (dcif->has_crc && dcif_crtc_state->crc.source !=3D DCIF_CRC_SRC_NONE)
> +		dcif_crc_source_disable(dcif, 0);
> +
> +	dcif_disable_controller(dcif);
> +	dcif_disable_plane_panic(dcif);
> +
> +	drm_crtc_vblank_off(crtc);
> +
> +	if (dcif->crtc_pm_enabled) {
> +		dcif->crtc_pm_enabled =3D false;
> +		pm_runtime_put_sync(drm->dev);
> +	}

[Severity: High]
If pm_runtime_resume_and_get() fails in dcif_crtc_atomic_enable(), won't
subsequent callbacks still access DCIF MMIO registers while the clocks and
power domain are off?

After dcif_crtc_atomic_enable() returns early with dcif->crtc_pm_enabled
set to false, drm_atomic_helper_commit_tail_rpm() still runs
drm_atomic_helper_commit_planes() because crtc_state->active is true,
invoking dcif_plane_atomic_update() and dcif_crtc_atomic_flush() without
checking dcif->crtc_pm_enabled.  Later, dcif_crtc_atomic_disable() also
calls dcif_crc_source_disable(), dcif_disable_controller(), and
dcif_disable_plane_panic() before checking dcif->crtc_pm_enabled, causing
unclocked MMIO accesses and an external abort on ARM64.

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
> +
> +		scoped_guard(spinlock_irqsave, &drm->event_lock) {
> +			if (dcif->crc_is_enabled) {
> +				regmap_read(dcif->regmap, DCIF_CRC_VAL_R(0), &crc);
> +				drm_crtc_add_crc_entry(&dcif->crtc, false, 0, &crc);
> +				dev_dbg(drm->dev, "crc=3D0x%x\n",  crc);
> +			}
> +		}
> +	}
> +
> +	if (stat1 & (DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1)) {
> +		u32 panic =3D stat1 & (DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1);
> +
> +		dev_dbg_ratelimited(drm->dev, "FIFO panic on %s\n",
> +				    panic =3D=3D (DCIF_INT1_FIFO_PANIC0 | DCIF_INT1_FIFO_PANIC1) ?
> +				    "layers 0 & 1" : panic =3D=3D DCIF_INT1_FIFO_PANIC0 ? "layer 0" :
> +				    "layer 1");
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Should dcif_irq_handler() mask stat0 and stat1 with DCIF_IE0(domain) and
DCIF_IE1(domain), and return IRQ_NONE when no enabled interrupt is
pending?

DCIF_IS0(domain) latches DCIF_INT0_VS_BLANK on every vertical blank even
when it is masked in DCIF_IE0(domain), which is why
dcif_crtc_enable_vblank() clears DCIF_IS0(domain) before enabling it.
Because FIFO panic interrupts remain enabled in DCIF_IE1(domain) whenever
the CRTC is active, a FIFO panic interrupt firing mid-frame while vblanks
are disabled will see the latched DCIF_INT0_VS_BLANK bit in stat0 and
spuriously call drm_crtc_handle_vblank() and drm_crtc_add_crc_entry().

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-drv.c b/drivers/gpu/drm/imx/dc=
if/dcif-drv.c
> new file mode 100644
> index 0000000000000..3b1b9dbf0c6b0
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-drv.c
[ ... ]
> +static void dcif_hw_probe_init(struct dcif_dev *dcif)
> +{
> +	struct drm_device *drm =3D &dcif->drm;
> +	u32 val, vmin, vmaj;
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(drm->dev);
> +	if (ret < 0) {
> +		drm_err(drm, "failed to resume DCIF: %d\n", ret);
> +		return;
> +	}
[ ... ]
> +static int dcif_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	dcif_hw_probe_init(dcif);
> +
> +	ret =3D dcif_kms_prepare(dcif);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_request_irq(drm->dev, dcif->irq[dcif->cpu_domain],
> +			       dcif_irq_handler, 0, drm->driver->name, drm);

[Severity: Medium]
Should dcif_hw_probe_init() return an error code so dcif_probe() can abort
when pm_runtime_resume_and_get() fails?

If runtime resume fails here, dcif_hw_probe_init() returns early without
reading DCIF_VER, masking bootloader interrupts, or stopping the
controller, and dcif_probe() continues on to request the IRQ and register
the DRM device with uninitialized hardware state.  Also, calling
dcif_hw_probe_init() before dcif_kms_prepare() powers on and disables the
hardware before devm_drm_of_get_bridge() checks for probe deferral and
before dcif_kms_link_suppliers() sets up the supplier device links.

[ ... ]

> +static int dcif_suspend(struct device *dev)
> +{
> +	struct dcif_dev *dcif =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D drm_mode_config_helper_suspend(&dcif->drm);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	return dcif_runtime_suspend(dev);
> +}
> +
> +static int dcif_resume(struct device *dev)
> +{
> +	struct dcif_dev *dcif =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!pm_runtime_suspended(dev)) {
> +		ret =3D dcif_runtime_resume(dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return drm_mode_config_helper_resume(&dcif->drm);
> +}

[Severity: Medium]
If dcif_runtime_resume() fails in dcif_resume(), won't the runtime PM core
call dcif_runtime_suspend() a second time on already disabled clocks?

When the CRTC is active before system suspend, device_prepare() increments
the runtime PM usage count so drm_mode_config_helper_suspend() ->
pm_runtime_put_sync() leaves the device RPM_ACTIVE, and dcif_suspend()
then calls dcif_runtime_suspend() directly without updating the runtime PM
status.  If dcif_runtime_resume() fails during system resume, the clocks
remain disabled while runtime_status is still RPM_ACTIVE, so
device_complete() -> pm_runtime_put() will invoke dcif_runtime_suspend() ->
clk_bulk_disable_unprepare() again.  Using pm_runtime_force_suspend() and
pm_runtime_force_resume() would keep the runtime PM state in sync with the
clocks.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-plane.c b/drivers/gpu/drm/imx/=
dcif/dcif-plane.c
> new file mode 100644
> index 0000000000000..9f54f1b2d8d17
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-plane.c
[ ... ]
> +static int dcif_plane_atomic_check(struct drm_plane *plane, struct drm_a=
tomic_commit *state)
> +{
> +	struct drm_plane_state *new_plane_state =3D drm_atomic_get_new_plane_st=
ate(state, plane);
> +	struct dcif_dev *dcif =3D plane_to_dcif_dev(plane);
> +	struct drm_framebuffer *fb =3D new_plane_state->fb;
> +	struct drm_crtc_state *crtc_state;
> +	int ret;
> +
> +	if (!fb)
> +		return 0;
[ ... ]
> +	if (new_plane_state->fb->format->has_alpha &&
> +	    new_plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_COVERAGE &&
> +	    new_plane_state->alpha !=3D DRM_BLEND_ALPHA_OPAQUE)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Severity: Low]
Should dcif_plane_atomic_check() reject framebuffers with
fb->pitches[0] > 0xffff?

DCIF_CTRLDESC3_PITCH() is a 16-bit field (GENMASK(15, 0)), so a
framebuffer stride >=3D 65536 bytes is silently truncated in
dcif_plane_atomic_update(), corrupting scanout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-dcif-upstr=
eaming-v11-0-9e13c85ae0d8@oss.nxp.com?part=3D4
