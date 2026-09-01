Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE52C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1290510EEDD;
	Tue,  1 Sep 2026 19:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ue9n8YQO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AA910EEDD
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:52:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39B0060237;
 Tue,  1 Sep 2026 19:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0B41F000E9;
 Tue,  1 Sep 2026 19:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788292332;
 bh=iaYJDbXi4I4S7jT5zCYYzd19qIHJSVpYpgv1VwePJHs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ue9n8YQO5CN/6QehGHh3wvczV9u1SOOMvPE4uzad1XbP1F9rvAv4qER78j1zpCqJ7
 fBYMB0KRKYaEsF8n1XKO15ryHcC1Diorb1BGLROPIbOMeAjfQomkuZKbnhxebYjOpj
 IQYHt0N7SHmwbjno2fPhIcmHw6nmyB8YzxP4XbOSN/+Y15S2c0DTm5TuLYLr/vwMFB
 bd7SBuQsjghCaxvT/sAb/VTOSYAltav6uUh5RQaioBfrr3bibooKIKHD2ob5yfq51r
 13W5xFj230dEoSGEBJ7GxUjBqw/uNa98MT4zxAulxmj4qu4DTfEQVfLr/uqaC97U0t
 +kyCssKh0Oo4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 33/74] drm/rockchip: dw_hdmi_qp: Add missing
 newlines in dev_err_probe() messages
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-33-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-33-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:52:12 +0000
Message-Id: <20260901195212.AD0B41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Component bind callback incorrectly uses devm_* allocations tied t=
o the platform device, leading to resource leaks and -EBUSY errors on re-bi=
nd.
--

commit a9c58c506cb77b47eb22437fb1825e8599bab1dc
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages

This commit adds missing trailing newlines to a couple of dev_err_probe()
calls in dw_hdmi_qp_rockchip_bind().

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 42f2627e1a052..df0e2bb1eedc6 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -681,12 +681,12 @@ static int dw_hdmi_qp_rockchip_bind(struct device *=
dev, struct device *master,
>  	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_fun=
cs);
>  	ret =3D drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_TMDS, NU=
LL);
>  	if (ret)
> -		return dev_err_probe(hdmi->dev, ret, "Failed to init encoder");
> +		return dev_err_probe(hdmi->dev, ret, "Failed to init encoder\n");
> =20
>  	hdmi->hdmi =3D dw_hdmi_qp_bind(pdev, encoder, &plat_data);
>  	if (IS_ERR(hdmi->hdmi))
>  		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->hdmi),
> -				     "Failed to bind dw-hdmi-qp");
> +				     "Failed to bind dw-hdmi-qp\n");
> =20
>  	connector =3D drm_bridge_connector_init(drm, encoder);
>  	if (IS_ERR(connector))

[Severity: High]
This is a pre-existing issue, but looking at dw_hdmi_qp_rockchip_bind(),
several resource allocations are made against the component's platform
device (dev or hdmi->dev) rather than the DRM aggregate device (master):

    ret =3D devm_clk_bulk_get_all_enabled(dev, &clks);
    ...
    hdmi->frl_enable_gpio =3D devm_gpiod_get_optional(dev, "frl-enable", ..=
.);
    ...
    ret =3D devm_request_threaded_irq(dev, hdmi->hpd_irq, ...);

If dw_hdmi_qp_bind() or drm_bridge_connector_init() fails and returns an
error (such as -EPROBE_DEFER), the component framework aborts the bind.
Because these devm_ allocations are tied to the platform device and not the
DRM aggregate device, they are not cleaned up upon bind failure.

When the master DRM device later retries binding, will
devm_request_threaded_irq() fail with -EBUSY since the IRQ and other
resources remain claimed from the previous attempt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D33
