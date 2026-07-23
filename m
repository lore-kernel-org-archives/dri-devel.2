Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CEEC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E582910F248;
	Thu, 23 Jul 2026 22:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XoUhRFaP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B6C10F248
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:40:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5F01600AA;
 Thu, 23 Jul 2026 22:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF201F000E9;
 Thu, 23 Jul 2026 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784846458;
 bh=i6pV7+GVDLekMLhc7UA9twwTX48mGetKM0g8Bw5klQM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XoUhRFaPBzK8xQ3+NSt+sJJoFGvCDsiD8i+soDaCKvWDgyTiADAbF18djNGEm6xqv
 G01vOw9EFZPZ6a2wXa4WdvD89Ln1W/7MF+uwEH60cmzZ0irQQYgDmHVdKQh3Iolb/I
 UYvF0mf2sOOPAchuDOyz9pShKT+PSyAPRVS4fP3vUdGFOV/uv/vRkbAXhEA6Ga4deS
 tQP1m647bhWGiWhTHzyV5xS8DHqc0sz5x8UsujskJxB4k+RF/UBybM/jGILhLoUvl5
 n7B93ELVdAE7Wljl8XLqnt8NglCzQlxD+emxVbqjp2CbUg2QwWFHvlqBJrFUnb0JBB
 wRtm4z7aCk3fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/15] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-11-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v5-11-9445c2e87441@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:40:57 +0000
Message-Id: <20260723224058.0EF201F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect teardown sequence in dw_dp_rockchip_unbind() causes inva=
lid hardware access.
- [Medium] Missing PM runtime cleanup when dw_dp_bind() fails.
--

--- Patch [11]: [PATCH v5 11/15] drm/rockchip: dw_dp: Add runtime PM suppor=
t ---
commit b12de6118be77a7ac8babe1d82f46a8db5857b90
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support
   =20
Add support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 0ecbad24dd4e8..b1a69d8821a2c 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c

[ ... ]

> @@ -165,18 +178,32 @@ static int dw_dp_rockchip_bind(struct device *dev, =
struct device *master, void *
>  		return ret;
>  	drm_encoder_helper_add(encoder, &dw_dp_encoder_helper_funcs);
> =20
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
>  	ret =3D dw_dp_bind(dp->base, encoder);
>  	if (ret)
>  		return ret;

[Severity: Medium]
If dw_dp_bind() returns an error, does this early return bypass the PM runt=
ime
cleanup sequence?

This leaves the device's PM state enabled and unbalanced. Should this jump =
to
the error path to properly disable PM runtime on failure?

> =20
>  	connector =3D drm_bridge_connector_init(drm_dev, encoder);
>  	if (IS_ERR(connector)) {
> -		dw_dp_unbind(dp->base);
> -		return dev_err_probe(dev, PTR_ERR(connector),
> -				     "Failed to init bridge connector\n");
> +		ret =3D PTR_ERR(connector);
> +		dev_err_probe(dev, ret, "Failed to init bridge connector\n");
> +		goto error;
>  	}
> =20
> +	pm_request_idle(dev);
> +
>  	return 0;
> +
> +error:
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_resume(dev);
> +	pm_runtime_disable(dev);
> +	dw_dp_unbind(dp->base);
> +	return ret;
>  }
> =20
>  static void dw_dp_rockchip_unbind(struct device *dev, struct device *mas=
ter,
> @@ -185,6 +212,9 @@ static void dw_dp_rockchip_unbind(struct device *dev,=
 struct device *master,
>  	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> =20
>  	dw_dp_unbind(dp->base);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_resume(dev);
> +	pm_runtime_disable(dev);
>  }

[Severity: High]
Does this sequence cause invalid hardware access if the device is suspended?

dw_dp_unbind() is called before disabling PM runtime. dw_dp_unbind() calls
phy_exit(), shutting down the PHY. If the device was suspended prior to unb=
ind,
pm_runtime_resume() forces a wake-up, which calls dw_dp_runtime_resume() th=
en
dw_dp_init_hw().

This would perform hardware register writes on a device whose PHY has alrea=
dy
been exited. Should PM runtime be disabled before calling dw_dp_unbind()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v5-0-9445c2e87441@collabora.com?part=3D11
