Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FA60A260A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5HPGoTC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AA810FE21;
	Wed, 18 Nov 2026 16:02:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCF010FDF9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:02:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56C194006B;
 Wed, 18 Nov 2026 16:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC53A1F000C7;
 Wed, 18 Nov 2026 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795017761;
 bh=QwBKZBhqRAe39+88zv0TUkAs/LK0TPgu//N+wd/gzuo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P5HPGoTCSggtGUTnsuPjPdhQaQpmAmODSCopLVRSuEkXD8eRE72t/sVaqdqPy1DRM
 bKAqY+OQ4N7OVoBca2/a6vwHMVgLvoVWR7BVL7vHU6ij7N53fgAYgGEuVDi9p0v5d/
 M4ofzvFVpUTSxm2QMjHTdrB/2Om1t+2DdsrsmZiyo6dnZzvnxPNwtr7AhvRc+Jcav/
 /tdlRUJpEwGW8q2ftJs5NWVE8tDY4/96q086R7g5rH79pOw0MQFdhXf12ll0yaOChE
 bMsuCurZpWbFikN/1TugZC0d937EqtzggGHtqaaLPM1xWajgypQL45JPNhTBJuyjKR
 uwfoPhLh1zMWw==
Message-ID: <sashiko-outbox-221406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/5] drm/imx: Add support for i.MX94 DCIF
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org
In-Reply-To: <20261118-dcif-upstreaming-v12-2-29b35e27a1cc@oss.nxp.com>
References: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
 <20261118-dcif-upstreaming-v12-2-29b35e27a1cc@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:02:40 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/imx/dcif: unclocked MMIO access when runtime PM resume
  fails
- [Medium] drm/imx: dcif: unbalanced clock disable if
  dcif_runtime_resume() fails
- [Low] drm/imx/dcif: missing shadow load and trigger clear in
  dcif_crc_source_disable()
--

commit 373caa0eccbfd7fa4334093ea8869b540640e7ab
Author: Sandor Yu <sandor.yu@nxp.com>

drm/imx: Add support for i.MX94 DCIF

This commit adds a DRM/KMS driver for the NXP i.MX94 Display Control
Interface (DCIF), supporting primary and overlay planes, YCbCr-to-RGB CSC
on layer 0, and frame/ROI CRC generation.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crc.c b/drivers/gpu/drm/imx/dc=
if/dcif-crc.c
> new file mode 100644
> index 0000000000000..ad94b458a6c59
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crc.c
[ ... ]
> +void dcif_crc_source_enable(struct dcif_dev *dcif, enum dcif_crc_source =
source,
> +			    struct drm_rect *roi, int ncrc)
> +{
> +	int ret;
> +
> +	if (ncrc >=3D MAX_DCIF_CRC_NUM)
> +		return;
> +
> +	if (source =3D=3D DCIF_CRC_SRC_NONE)
> +		return;
> +
> +	if (dcif->crc_is_enabled)
> +		return;
> +
> +	ret =3D drm_crtc_vblank_get(&dcif->crtc);
> +	if (ret) {
> +		drm_err(&dcif->drm, "Could not get vblank reference: %d\n", ret);
> +		return;
> +	}
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

[Severity: Low]
Should dcif_crc_source_disable() also clear DCIF_CRC_CTRL_CRC_TRIG and set
DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN when disabling CRC on an active CRTC?

Clearing only DCIF_CRC_CTRL_CRC_EN(ncrc) leaves the disabled state
unlatched, and if DCIF_CRC_CTRL_CRC_MODE, DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN
and DCIF_CRC_CTRL_CRC_TRIG stay set in DCIF_CRC_CTRL, a later
dcif_crc_source_enable() call via regmap_set_bits() will see no bit changes
and skip writing the register.

[ ... ]

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crtc.c b/drivers/gpu/drm/imx/d=
cif/dcif-crtc.c
> new file mode 100644
> index 0000000000000..233e149929964
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
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
> +static void dcif_crtc_atomic_disable(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +	struct drm_device *drm =3D crtc->dev;
> +
> +	if (dcif->has_crc)
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

[Severity: Medium]
Can a failure in pm_runtime_resume_and_get() lead to MMIO register accesses
while the DCIF clocks are disabled?

If pm_runtime_resume_and_get() fails in dcif_crtc_atomic_enable(),
dcif->crtc_pm_enabled remains false, but crtc_state->active is still true.
In the same commit tail, drm_atomic_helper_commit_planes() still calls
dcif_plane_atomic_update() and dcif_crtc_atomic_flush(), and a later
dcif_crtc_atomic_disable() calls dcif_crc_source_disable(),
dcif_disable_controller(), and dcif_disable_plane_panic() before checking
dcif->crtc_pm_enabled.  Accessing DCIF registers while the block is
unclocked can cause an external abort or bus hang on i.MX94.

[ ... ]

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-drv.c b/drivers/gpu/drm/imx/dc=
if/dcif-drv.c
> new file mode 100644
> index 0000000000000..80b554f1b6843
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-drv.c
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
Can a failure in dcif_runtime_resume() during system resume cause an
unbalanced clk_bulk_disable_unprepare()?

When the CRTC is active entering system suspend, the PM core's
device_prepare() holds a runtime PM reference, so the pm_runtime_put_sync()
in dcif_crtc_atomic_disable() leaves the device's runtime PM status as
RPM_ACTIVE.  dcif_suspend() then calls dcif_runtime_suspend() directly,
disabling clocks without updating runtime_status.  If dcif_runtime_resume()
fails in dcif_resume(), clocks remain disabled while runtime_status is
still RPM_ACTIVE, and device_complete() -> pm_runtime_put() will invoke
dcif_runtime_suspend() a second time.  Using pm_runtime_force_suspend() and
pm_runtime_force_resume() would keep runtime_status aligned with the clock
state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-dcif-upstr=
eaming-v12-0-29b35e27a1cc@oss.nxp.com?part=3D2
