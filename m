Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEF606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpYUNvkn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770F910E7A2;
	Tue,  3 Nov 2026 06:38:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C3B10E7A2
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:38:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39D39433FB;
 Tue,  3 Nov 2026 06:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74DE1F000C1;
 Tue,  3 Nov 2026 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793687905;
 bh=aaWCfGlD/ElpPzhqwGaseutr4BAEcSt9Xfs6Ov5LsBc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZpYUNvkn5Vw0LjhsklvsD0oN3SIAaEcU/WL/P+hJSpop/t/Ag4VgW3q5t0aQy2/im
 5+OYfRPxHlu8fvwFCB7Ug18k1AcuYOeKoeEZdJN5dMPTrzibYdNVe+ql/LexOBZrMW
 H3fTtEdq/37tFudzArAslIlAaOUEYIgff4SZ25FJT7WBh/kg3IiymESOiWU8sxvxY/
 1hozewicvn9D+uad1sj8N1sFuKnrU3CTEK/91HslcAcDZWwu5d3ULpzF55WVmErORI
 rdyE5rZPZB2arB7Z54mMUuuvjz5gZ/vN+ibX/qLrpCOIkxAWm5eUnYDSIuYLA2lwHr
 Vrh4gwvJQLL5w==
Message-ID: <sashiko-outbox-194648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/16] drm/imx: dc-crtc: Disable at boot
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-imx8-dc-prefetch-v9-7-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
 <20261103-imx8-dc-prefetch-v9-7-3b985e7636e2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:38:24 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/imx: dc-crtc: premature clk_axi disable in dc_crtc_disable_a=
t_boot()
--

commit 8bca21cfc221adc6d10d2019ff78d5b2dc5c6e91
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc-crtc: Disable at boot

This commit adds a dc_crtc_disable_at_boot() helper and calls it for each
CRTC during driver bind to disable any running CRTCs and balance display
and AXI clock usage counts before registering the DRM device.

> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index 0d64186a99018..5bc952d6883e1 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c

[ ... ]

> @@ -331,6 +341,48 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct=
 drm_atomic_commit *state)
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  }
> =20
> +int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> +{
> +	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
> +	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dc_crtc->de->dev);
> +	if (ret < 0) {
> +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
> +			    ret);
> +		goto out1;
> +	}
> +
> +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
> +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> +		goto out2;
> +	}
> +
> +	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
> +	__dc_crtc_disable_fg(crtc);
> +
> +	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
> +		goto out2;
> +
> +	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
> +
> +	dc_fg_disable_clock(dc_crtc->fg);
> +
> +	dc_drm->pe_clk_axi_needs_disable =3D true;
> +
> +	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
> +
> +out2:
> +	pm_runtime_put(dc_crtc->de->dev);
> +out1:
> +	/* Let CRTC(with index =3D=3D 1) disablement path disable AXI clock. */
> +	if (dc_drm->pe_clk_axi_needs_disable && drm_crtc_index(crtc) =3D=3D 1)
> +		clk_disable_unprepare(dc_drm->pe->clk_axi);
> +
> +	return ret;
> +}

[Severity: Medium]
As reported by Sashiko on v8 [1], can dc_crtc_disable_at_boot() in
drivers/gpu/drm/imx/dc/dc-crtc.c prematurely disable dc_drm->pe->clk_axi
when disabling CRTC 1 fails?

In dc_drm_bind(), drm_for_each_crtc() invokes dc_crtc_disable_at_boot()
for CRTC 0 and then CRTC 1. When CRTC 0 was active at boot, its call sets
dc_drm->pe_clk_axi_needs_disable =3D true and clears CRTC_ENABLED(0).

When dc_crtc_disable_at_boot() then runs for CRTC 1, if
pm_runtime_resume_and_get(dc_crtc->de->dev) fails and jumps to out1,
CRTC 1's FrameGen has not been stopped and CRTC_ENABLED(1) has not been
cleared. However, at out1, dc_drm->pe_clk_axi_needs_disable is already
true from CRTC 0 and drm_crtc_index(crtc) =3D=3D 1, so
clk_disable_unprepare(dc_drm->pe->clk_axi) is called unconditionally.

If CRTC 1 was also active at boot, wouldn't this gate the Pixel Engine
AXI clock while CRTC 1 is still scanning out from the Pixel Engine, and
leave CRTC_ENABLED(1) set in the general purpose register so that a
subsequent bind retry disables dc_drm->pe->clk_axi a second time?

[1] https://lore.kernel.org/r/20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@n=
xp.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-imx8-dc-pr=
efetch-v9-0-3b985e7636e2@nxp.com?part=3D7
