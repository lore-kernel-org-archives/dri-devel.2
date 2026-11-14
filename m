Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8741606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSMgIfIm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5A010ED42;
	Sat, 14 Nov 2026 05:29:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5093910ED42
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:29:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3BAC36112C;
 Sat, 14 Nov 2026 05:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C61F000C4;
 Sat, 14 Nov 2026 05:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794634141;
 bh=auABPaom4rilh+GHLkAfmnNjj1XppDNBxPN7xHXigAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RSMgIfImRFkmXVHvtcOoOEcUdDzvNZ+YFuZY/bbqQdQLEWrsgZ+muqZ1EA4nxUfw8
 WI78s6llb2LAcThL/XDGopTtp4DiGI9QjQq939CMAYZXRAj/Vo2TlBnPEeUp0SNh7w
 ma/ZiVx6UWrKCyx5oBwt8yHT7AwIMwzXrDZZAVYm3aVwDLlXDIcXM/AtlkDKsEqwqF
 e+fQwm1zTNrmV2VL8Ku72VtLeefkhGCW0fcHCJHsxcOgOL8keU8yy9ub8Hv43/owpQ
 NsXXW14xypkcs4dziwcSjd5K8QmsniYrM4I3yxZXeWwd7ZDw/nbex9o7GVPSpH/yez
 y5tdaiJ5rpkMQ==
Message-ID: <sashiko-outbox-214176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 15/23] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-15-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
 <20261114-synopsys-dw-dp-improvements-v12-15-d42d3dc5bdd4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:29:01 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/rockchip: dw_dp: unguarded phy_power_on() in
  dw_dp_bridge_edid_read()
--

commit 7986dcc1b84b1f1885c1e7812534566eeb9a1c10
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support

This commit enables runtime PM with a 500ms autosuspend delay and wires up
runtime suspend and resume callbacks for the Rockchip DesignWare DisplayPort
driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 1cc6cfad41042..99d948a7c51f9 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -229,6 +230,7 @@ static int dw_dp_rockchip_probe(struct platform_devic=
e *pdev)
>  	if (IS_ERR(dp->vo_grf))
>  		return PTR_ERR(dp->vo_grf);
> =20
> +	plat_data->autosuspend_delay =3D 500;
>  	plat_data->max_link_rate =3D plat_data_const->max_link_rate;
>  	plat_data->pixel_mode =3D plat_data_const->pixel_mode;
>  	plat_data->hpd_sw_sel =3D dw_dp_rockchip_hpd_sw_sel;
> @@ -251,6 +253,24 @@ static void dw_dp_rockchip_remove(struct platform_de=
vice *pdev)
>  	component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
>  }
> =20
> +static int dw_dp_rockchip_runtime_suspend(struct device *dev)
> +{
> +	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +
> +	return dw_dp_runtime_suspend(dp->base);
> +}
> +
> +static int dw_dp_rockchip_runtime_resume(struct device *dev)
> +{
> +	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +
> +	return dw_dp_runtime_resume(dp->base);
> +}
> +
> +static const struct dev_pm_ops dw_dp_pm_ops =3D {
> +	RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend, dw_dp_rockchip_runtime_r=
esume, NULL)
> +};

[Severity: Medium]
Does enabling runtime PM with autosuspend allow dw_dp_bridge_edid_read() to
call phy_power_on(dp->phy) while dp->dev and its VO power domain are
suspended?

Unlike dw_dp_bridge_detect() and dw_dp_bridge_atomic_enable(),
dw_dp_bridge_edid_read() powers on the PHY without first acquiring a runtime
PM reference on dp->dev, which is only resumed later inside
drm_edid_read_ddc() -> dw_dp_aux_transfer():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_edid_read() {
	...
	ret =3D phy_power_on(dp->phy);
	if (ret)
		return NULL;

	edid =3D drm_edid_read_ddc(connector, &dp->aux.ddc);
	...
}

In USB-C mode, dp->dev autosuspends when idle.  If dw_dp_bridge_edid_read()=
 is
reached while dp->dev is suspended (for example, when the connector is forc=
ed
on so drm_helper_probe_detect() is skipped, or if autosuspend expires before
the EDID read starts), phy_power_on(dp->phy) on RK3576 and RK3588 calls
rk_udphy_dp_phy_power_on() -> rk_udphy_dp_lane_select(), which writes to
udphy->vogrf while the VO power domain is off and triggers an SError crash.
Even without the fault, resuming dp->dev later in dw_dp_aux_transfer() powe=
rs
on the VO domain and resets vo_grf, wiping out the lane mux settings written
by rk_udphy_dp_lane_select().

Should dw_dp_bridge_edid_read() acquire a runtime PM reference on dp->dev
before calling phy_power_on(dp->phy)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-synopsys-d=
w-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com?part=3D15
