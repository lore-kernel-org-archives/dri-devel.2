Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3702606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEfNRyaR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C42310E863;
	Fri, 30 Oct 2026 07:56:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FEE10E866
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:56:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3437340A6D;
 Fri, 30 Oct 2026 07:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26EA1F000C1;
 Fri, 30 Oct 2026 07:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793346977;
 bh=Abu3ddKTTXe/ixDDRA5g4+pU1RtH142rNVRWCRepPwc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QEfNRyaR8fP3AjKw+JEmThGfCKimiacSMhzPGd1NV+DT5DYwP+OzHJY55t4y/AA3h
 AtShlgfE6WFNrI6yE4L+fCvli7Wq0Yn9RSMRqIuBbo86u8h5Pv2Bh8/8fetk5GMJ3s
 L3BPMWeO7PYxhFIyCJupdUlK44Qi8hhCJeTfBcyPu70RpJStufsiw2GdPTRmkug0qJ
 pB7BnTE9dB7B3b5+bjRoXIjvFSPbJKTe/jqLCUxHfGjIpNPONu59CnNMLDYUrTDOw2
 CpuD4EB6GGPtlQFfwA3cwVp+EBWIsI/U8PodThyEqNC+Sj9CuInIO2H8BbmLLORelf
 JIcEd5xvjrqLw==
Message-ID: <sashiko-outbox-190668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/bridge: dw-mipi-dsi: add PHY write function
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261030-th1520-dw-mipi-dsi-v1-2-753f34fd304f@iscas.ac.cn>
References: <20261030-th1520-dw-mipi-dsi-v1-0-753f34fd304f@iscas.ac.cn>
 <20261030-th1520-dw-mipi-dsi-v1-2-753f34fd304f@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 07:56:16 +0000
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
- [High] drm/rockchip: dsi: uninitialized dsi->dmd in dw_mipi_dsi_dphy_powe=
r_on()
--

commit bdfb343509e10a4a68b931e1345f0a0c640cfd6f
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/bridge: dw-mipi-dsi: add PHY write function

This commit moves dw_mipi_dsi_phy_write() from the Rockchip glue driver
to the common dw-mipi-dsi bridge code and updates the Rockchip DSI driver
to call the shared helper using its struct dw_mipi_dsi pointer.

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 268d4993a04fd..469123620f302 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c

[ ... ]

> @@ -1224,6 +1203,7 @@ static int dw_mipi_dsi_dphy_configure(struct phy *p=
hy, union phy_configure_opts
>  static int dw_mipi_dsi_dphy_power_on(struct phy *phy)
>  {
>  	struct dw_mipi_dsi_rockchip *dsi =3D phy_get_drvdata(phy);
> +	struct dw_mipi_dsi *dmd =3D dsi->dmd;
>  	int i, ret;
> =20
>  	DRM_DEV_DEBUG(dsi->dev, "lanes %d - data_rate_mbps %u\n",
> @@ -1273,15 +1253,15 @@ static int dw_mipi_dsi_dphy_power_on(struct phy *=
phy)
>  	 * Configure hsfreqrange according to frequency values
>  	 * Set clock lane and hsfreqrange by lane0(test code 0x44)
>  	 */
> -	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_CLK, 0);
> -	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_0,
> +	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_CLK, 0);
> +	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_0,
>  			      HSFREQRANGE_SEL(dppa_map[i].hsfreqrange));
> -	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_1, 0);
> -	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_2, 0);
> -	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_3, 0);
> +	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_1, 0);
> +	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_2, 0);
> +	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_3, 0);
> =20
>  	/* Normal operation */
> -	dw_mipi_dsi_phy_write(dsi, 0x0, 0);
> +	dw_mipi_dsi_phy_write(dmd, 0x0, 0);

[Severity: High]
Can dsi->dmd be NULL or an ERR_PTR when dw_mipi_dsi_dphy_power_on() is
called?

In dw_mipi_dsi_rockchip_probe(), the PHY provider is registered before
dsi->dmd is initialized:

drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:dw_mipi_dsi_rockchip_probe(=
) {
	...
	phy_set_drvdata(dsi->dphy, dsi);
	phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
	if (IS_ERR(phy_provider))
		return PTR_ERR(phy_provider);

	dsi->dmd =3D dw_mipi_dsi_probe(pdev, &dsi->pdata);
	if (IS_ERR(dsi->dmd)) {
	...
}

Previously, dw_mipi_dsi_dphy_power_on() wrote through dsi->base, which is
already mapped before devm_of_phy_provider_register(). With this change,
dw_mipi_dsi_dphy_power_on() passes dsi->dmd to dw_mipi_dsi_phy_write(),
which dereferences dmd->base.

If a PHY consumer (such as rkisp1 on RK3399) acquires the PHY and calls
phy_power_on() -> dw_mipi_dsi_dphy_power_on() while dw_mipi_dsi_probe() is
still running, or after dw_mipi_dsi_probe() fails and before devm unwinds
the PHY provider registration, wouldn't dw_mipi_dsi_phy_write() dereference
a NULL or ERR_PTR dmd?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-th1520-dw-=
mipi-dsi-v1-0-753f34fd304f@iscas.ac.cn?part=3D2
