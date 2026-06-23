Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483BFCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F25F10ECA4;
	Tue, 23 Jun 2026 20:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y+i0J6Eh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCEE10ECA4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:40:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5408860008;
 Tue, 23 Jun 2026 20:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B921F000E9;
 Tue, 23 Jun 2026 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247244;
 bh=J+gk5L5yw4PN+kPDrLzlGnj7v2zg2XZU/CjzwFcHYk0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y+i0J6Ehno69SWmN3U/JA4xqv8o8I7/en979cShv2OBxFISZ55Ns8JDJrWCsNrkXF
 zX8zgqiIyOI48tI4X1gf5A/b34FTOO30D2C7jf9EWiEsnNFOvfGdTD1Z41tr7YGZ5U
 3bOaHm1EPt85G2ScWl+E+XyjLmAChTKmG2J4iN8LkpcaayepFDOVHSyn3RBuxtUh54
 AgrYuKZBk9XigSl1Qvjqctw8mb8HjihdsH28LOMFwz4JcmTUpPFoHlMC0LCLzXUDT3
 eaCKiksrLeFaZILrghUHFATQMGEorXc6iZH3DozcXg+r1P2UChW694bJGIf32V0vqi
 vRZ5hd9TP+LDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-8-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-8-dc61e6352508@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:40:43 +0000
Message-Id: <20260623204043.C6B921F000E9@smtp.kernel.org>
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
- [High] Runtime PM initialized without matching active hardware state, cau=
sing clocks to remain permanently enabled.
- [High] Using devm_pm_runtime_enable() in a component bind callback ties P=
M lifecycle incorrectly, causing Use-After-Free and devres leaks.
--

commit 77c03b774daaa80f329daaa791a8229e9e24ad9e
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support
   =20
Add support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 9c53f1d2c29ab..1f53228e56d9f 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -213,6 +218,12 @@ static int dw_dp_rockchip_bind(struct device *dev, s=
truct device *master, void *
>  	if (IS_ERR(dp->base))
>  		return PTR_ERR(dp->base);
> =20
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);

[Severity: High]
Since dw_dp_bind() enables the clocks (via devm_clk_get_enabled() when
setting up the base dw_dp struct), shouldn't we call
pm_runtime_set_active() before enabling runtime PM here?

Without it, the PM core assumes the device starts in RPM_SUSPENDED state.
When the device resumes, dw_dp_runtime_resume() will enable the clocks
again (incrementing the enable count to 2). When autosuspend fires,
dw_dp_runtime_suspend() will disable them (decrementing the count back to
1), meaning the hardware clocks are never physically disabled.

> +	ret =3D devm_pm_runtime_enable(dev);

[Severity: High]
Does using devm_pm_runtime_enable() here tie the PM lifecycle to the
component platform device instead of the DRM master?

The rockchip_dw_dp structure is allocated using drmm_kzalloc() earlier in
this function, which binds its lifetime to the DRM master device. However,
devm_pm_runtime_enable() attaches the devres action to the component device,
whose lifetime spans the full probe/remove cycle.

If the DRM master is unbound, dw_dp_rockchip_unbind() will execute but it
does not disable PM runtime or flush the autosuspend timer. The DRM core
will then free the drmm-managed memory.

Could an autosuspend timer firing after unbind cause a use-after-free
regression in dw_dp_rockchip_runtime_suspend() when it tries to access the
freed dp pointer? Repeated bind/unbind cycles might also endlessly leak
devres actions on the platform device.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable runtime PM\n");
> +
>  	connector =3D drm_bridge_connector_init(drm_dev, encoder);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-synopsys-d=
w-dp-improvements-v3-0-dc61e6352508@collabora.com?part=3D8
