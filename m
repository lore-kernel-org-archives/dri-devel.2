Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211C606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbGHJXMc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9C410E8FA;
	Thu,  5 Nov 2026 01:21:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122DD10E8FA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:20:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1E69416CE;
 Thu,  5 Nov 2026 01:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF741F00919;
 Thu,  5 Nov 2026 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793841655;
 bh=67/DhddsOxWP9zsaLstwYj171Xr65+ZA+kn2PoKaIY8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fbGHJXMcRM1bcTie6CEDgJTyK5VoPudNeMzRVAC9NOOg8x2X6IJ4RCpZYFgptP0xX
 Wv3VTloIAVyI4HosEPc0sH6r8dGMxYnjb7AuubHIHlMB4m84lpBxE11Tq2xIcc8dSJ
 k++ZZ2VQ9nf3o2EtXrjRRQ8o7+UtpqAV5hytwGl08Lj50FWpmaXlHNzciPfuTnKSLE
 B6MEzOh4d564Tj38IYSYxGe+yip2XnICGitZ0Mo1jWAXPdWnXh+aCx56ybc7EXYuqd
 B9mGBSL6Ay0/LyXgZZmX3PoVkP9BIW8ngQj+x8R8K0nzzWZkPH8FbWLuVT3vlN6P20
 Pdz7IkcOwtX/w==
Message-ID: <sashiko-outbox-198401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/15] drm/rockchip: vop2: Reset AXI and DCLK to
 improve robustness
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-7-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-7-1bb63ef5766e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 01:20:55 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/rockchip: vop2: missing of_node_put() on error in vop2_creat=
e_crtcs()
- [Medium] drm/rockchip: vop2: axi_rst pulsed in vop2_bind() without enabli=
ng aclk or PM
--

commit 7b3ce842063d5aafe025d15a4339ddc7bddb6893
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Reset AXI and DCLK to improve robustness

This commit adds optional AXI and VP DCLK reset controls to the Rockchip VO=
P2
driver, pulsing the AXI reset during bind and CRTC disable and the VP DCLK
reset during CRTC enable to leave the hardware in a clean state.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index b85cd94d1e9d9..98430587a7abe 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -2585,6 +2610,12 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk),
>  					     "failed to get %s\n", dclk_name);
> =20
> +		vp->dclk_rst =3D devm_reset_control_get_optional_exclusive(vop2->dev,
> +									 dclk_name);
> +		if (IS_ERR(vp->dclk_rst))
> +			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk_rst),
> +					     "failed to get %s reset\n", dclk_name);

[Severity: Medium]
Does returning directly here leak the port device_node references acquired =
in
earlier iterations of this loop?

In vop2_create_crtcs(), each iteration for a connected video port acquires a
port reference at the end of the loop body:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_create_crtcs() {
	for (i =3D 0; i < vop2_data->nr_vps; i++) {
		...
		port =3D of_graph_get_port_by_id(dev->of_node, i);
		if (!port)
			return dev_err_probe(drm->dev, -ENOENT,
					     "no port node found for video_port%d\n", i);
		vp->crtc.port =3D port;
		nvps++;
	}
}

If devm_reset_control_get_optional_exclusive() fails on a subsequent iterat=
ion
(i > 0), vop2_create_crtcs() returns immediately to vop2_bind(), which also
returns the error without calling of_node_put() on vop2->vps[0 .. i - 1].cr=
tc.port
(a pre-existing issue also shared with the other early returns in
vop2_create_crtcs()).

> @@ -2944,6 +2975,13 @@ static int vop2_bind(struct device *dev, struct de=
vice *master, void *data)
>  		return dev_err_probe(drm->dev, PTR_ERR(vop2->pll_hdmiphy1),
>  				     "failed to get pll_hdmiphy1\n");
> =20
> +	vop2->axi_rst =3D devm_reset_control_get_optional_exclusive(vop2->dev, =
"axi");
> +	if (IS_ERR(vop2->axi_rst))
> +		return dev_err_probe(drm->dev, PTR_ERR(vop2->axi_rst),
> +				     "failed to get axi reset\n");
> +
> +	vop2_reset_assert_deassert(vop2, vop2->axi_rst);

[Severity: Medium]
As reported by Sashiko on v5 [1], can pulsing vop2->axi_rst here in
vop2_bind() take effect if the VOP2 power domain is powered down or
vop2->aclk is gated?

In vop2_bind(), vop2_reset_assert_deassert() is called before
pm_runtime_enable(&pdev->dev) and without resuming runtime PM or enabling
vop2->aclk. After vop2_probe() completes, genpd_dev_pm_sync() schedules
power-off for the RK3588_PD_VOP domain (which uses GENPD_FLAG_PM_CLK |
GENPD_FLAG_NO_STAY_ON), and the core clocks are only prepared and enabled
later in vop2_enable():

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_enable() {
	ret =3D pm_runtime_resume_and_get(vop2->dev);
	if (ret < 0) {
		drm_err(vop2->drm, "failed to get pm runtime: %d\n", ret);
		return ret;
	}

	ret =3D vop2_core_clks_prepare_enable(vop2);
	if (ret)
		goto err_put_pm;
}

By contrast, vop2_disable() pulses vop2->axi_rst while runtime PM and the c=
ore
clocks are still active, and vop_initial() in rockchip_drm_vop.c resumes
runtime PM and enables hclk and aclk before pulsing resets. Should this res=
et
be performed while the power domain and aclk are enabled?

[1] https://lore.kernel.org/r/20261014-dw-hdmi-qp-yuv-v5-7-6fab0fe43a9b@col=
labora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-dw-hdmi-qp=
-yuv-v6-0-1bb63ef5766e@collabora.com?part=3D7
