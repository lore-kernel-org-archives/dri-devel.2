Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57236606A332
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1+7dvHG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B642C112A43;
	Fri, 20 Nov 2026 13:16:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FFB112A4B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:16:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5236F46200;
 Fri, 20 Nov 2026 13:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD771F000F0;
 Fri, 20 Nov 2026 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180577;
 bh=rymBCJyiHy8Ghdn2DaeKiGdHuUNaTTqnH0lL1TRcJxE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U1+7dvHGJyor3CsGEGO8dR09Z+Ox5yzjvEdcIB6MttWlEAI/fgVJoRDQRaaIk6llC
 lROet6Mam2eTKNtcLjdZk7cbYDBAN7DbnRfe7Zgv53soNdKR2/OEbgfQggrd2heiqB
 /SasuUOTemJOaPvE0V43mR+gX1nohn3ZqxAsdHUs/eYRT4zRUiNYcmwXHuzXYBj1Ke
 REByfybOYxAjhpb74yzrRFhMyUW44nCFUMB5g4W3MfvJr+/Re9qxOXZ37GNG1OtzRs
 GTG5oMMTBEbvb+Dxo+gAuqmNXLgwt0s1qvax/MTrWG3D1Ik5lJcQN8pz9Sbz3aeiCP
 AtlqgJ0e7Pctg==
Message-ID: <sashiko-outbox-225210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/5] drm/imx: Add support for i.MX94 DCIF
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org
In-Reply-To: <20261120-dcif-upstreaming-v13-2-966ac248773f@oss.nxp.com>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <20261120-dcif-upstreaming-v13-2-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:16:15 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/imx/dcif: unclocked MMIO access after
  pm_runtime_resume_and_get() fails
- [Medium] drm/imx: dcif: unbalanced clock disable if
  dcif_runtime_resume() fails
--

commit aec0e23d14596f3fd993df3e2ad261bfab2bf2dd
Author: Sandor Yu <sandor.yu@nxp.com>

drm/imx: Add support for i.MX94 DCIF

This commit adds a DRM driver for the Display Control Interface (DCIF) on
NXP i.MX94 SoCs, supporting primary and overlay planes, alpha blending,
and display output CRC generation.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crtc.c b/drivers/gpu/drm/imx/d=
cif/dcif-crtc.c
> new file mode 100644
> index 0000000000000..233e149929964
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
> @@ -0,0 +1,710 @@

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
Can a failure in pm_runtime_resume_and_get() lead to unclocked MMIO
accesses and a synchronous external abort?

When pm_runtime_resume_and_get() fails in dcif_crtc_atomic_enable(),
dcif->crtc_pm_enabled stays false and the DCIF clocks remain disabled,
while crtc_state->active is still true.  In the same commit tail,
drm_atomic_helper_commit_planes() then runs dcif_plane_atomic_update() and
dcif_crtc_atomic_flush(), writing to plane and shadow-load registers
without checking dcif->crtc_pm_enabled.  Later, dcif_crtc_atomic_disable()
also accesses and polls DCIF registers in dcif_crc_source_disable(),
dcif_disable_controller(), and dcif_disable_plane_panic() before checking
dcif->crtc_pm_enabled.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-drv.c b/drivers/gpu/drm/imx/dc=
if/dcif-drv.c
> new file mode 100644
> index 0000000000000..80b554f1b6843
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-drv.c
> @@ -0,0 +1,250 @@

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

When the CRTC is active entering system suspend, the PM core holds an
extra runtime PM reference from device_prepare(), so the
pm_runtime_put_sync() in dcif_crtc_atomic_disable() leaves the device
runtime-active.  dcif_suspend() then calls dcif_runtime_suspend() directly,
disabling dcif->clks while runtime_status remains RPM_ACTIVE.

If dcif_runtime_resume() fails in dcif_resume(), the device stays
RPM_ACTIVE with its clocks already disabled, and device_complete() ->
pm_runtime_put() will invoke dcif_runtime_suspend() a second time.  Using
pm_runtime_force_suspend() and pm_runtime_force_resume() would keep the
runtime PM state in sync with the clocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dcif-upstr=
eaming-v13-0-966ac248773f@oss.nxp.com?part=3D2
