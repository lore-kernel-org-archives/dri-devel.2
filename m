Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31561C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DEA10E543;
	Fri,  4 Sep 2026 10:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GNYa6vsG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02AD610E543
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:27:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40F806020A;
 Fri,  4 Sep 2026 10:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8EA1F00A3D;
 Fri,  4 Sep 2026 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788517659;
 bh=6n6vqVUZrDjCn8JE2ATtZBBME4e4M15mHvd59767g8U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GNYa6vsG1tDtL98AqgfOmytU3O/AHuUqAJN4TcOXYEb9vcqAAnwT6BsBu9a0c7PpI
 +ZVq7U91siaqQuxu2bKk7dkH2qGBg7aAzLQMEZktBdjh/qer2Yu+efmS8IQRf/eVG2
 KI/5y2+aRbOy96zhYfWINRpdOlOz5GQogw+7tryUPnJBCbWzml7QoNu//XxzDluS0q
 fJ2oXLos78qHm0EueudibU3/mXo8Tc85EkowvQ4kLPjNtZ+86R6nGtXE+TrLWLJTtw
 Fv9kRYQtC2K2vG97OtQbglZElaBKjU0h02i4PvyRnenDokPp1xk09+y16g3ZsHHEX3
 woeM7wCemDR1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
To: "Johan Jonker" <jbx6244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-drm-v3-1-5b36532a3b72@gmail.com>
References: <20260904-drm-v3-1-5b36532a3b72@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:27:38 +0000
Message-Id: <20260904102738.BD8EA1F00A3D@smtp.kernel.org>
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
- [High] Lifecycle mismatch: devm_* APIs used in component bind callback ca=
use severe resource leaks, re-bind failures, and system hangs on unbind.
--

commit 55f99b0dc1074955624c3dfcd17a773dd54e5b91
Author: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
Subject: drm/rockchip: rk3066_hdmi: convert to devm_drm_bridge_alloc() API

This commit converts the rk3066_hdmi driver to use the devm_drm_bridge_allo=
c()
API. This aligns the driver with the new standard for allocating DRM bridges
that was introduced during the initial bridge API conversion.

> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> index f28d6a883e099..05dbbcc6f7b03 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
[ ... ]
> @@ -747,9 +745,10 @@ static int rk3066_hdmi_bind(struct device *dev, stru=
ct device *master,
>  	int irq;
>  	int ret;
> =20
> -	hdmi =3D devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> -	if (!hdmi)
> -		return -ENOMEM;
> +	hdmi =3D devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
> +				     &rk3066_hdmi_bridge_funcs);
> +	if (IS_ERR(hdmi))
> +		return PTR_ERR(hdmi);

[Severity: High]
This is a pre-existing issue, but is it safe to use device-managed APIs
like devm_drm_bridge_alloc() inside a component bind callback like
rk3066_hdmi_bind()?

Device-managed resources are tied to the platform device's probe and remove
lifecycle, not the component bind and unbind lifecycle. When
rk3066_hdmi_unbind() is called (e.g., during master deferred probe or driver
unload), the platform device isn't removed, so the devm allocations are not
released.

If the component is bound again, allocations will fail. For example,
devm_platform_ioremap_resource() will return -EBUSY because the memory
region is already claimed, completely breaking deferred probing.

Could this also cause a system hang on unbind? Since rk3066_hdmi_unbind()
calls clk_disable_unprepare() but the interrupt remains active via
devm_request_threaded_irq(), an HDMI hotplug event occurring after unbind
triggers rk3066_hdmi_hardirq(). Accessing unclocked registers there will
synchronously hang the system.

> =20
>  	hdmi->dev =3D dev;
>  	hdmi->drm_dev =3D drm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-drm-v3-1-5=
b36532a3b72@gmail.com?part=3D1
