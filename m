Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BFAC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D517C10EEBE;
	Tue,  1 Sep 2026 19:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fzxPf5mO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CAC10EEBE
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:46:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE02B43CCB;
 Tue,  1 Sep 2026 19:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950791F000E9;
 Tue,  1 Sep 2026 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788291973;
 bh=AgG7q+Wpp5pk3m6aHknPSw+mMXq/O75YSIjGSxRlHdQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fzxPf5mOJQOoxWGywYcYxjtsvG1KF+OXQSLY28iIUrIA5TANw1gcFY0vxTrdYOm2L
 85f6sZcxCqG5PovJunr8wY1u2SfZnEtXc3af9HSZAL8tUBM+S2u+ALzubVTaLjj868
 t0JgGX4ADm5iAUXDq9lwwEjrmI7xZZWuSj/FH9woWVuVM5slpRys9eLsOMnFwr+HRM
 aPf3GVgF5vyGNIf8W4zBYH6fR7W2kLYRNmxNqSCQYhAou+7Hjvv30iYGaTEJOzhkEn
 bUnqop+HknVaksrFSgE/42mhpWlp0mgSp0vDYoIalK1S09m8PHEHYJfhIXG70J9sQy
 /8LoqjORChagg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 31/74] drm/rockchip: dw_hdmi_qp: Fix invalid drvdata
 access in PM ops
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-31-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-31-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:46:13 +0000
Message-Id: <20260901194613.950791F000E9@smtp.kernel.org>
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
- [High] Using `devm_*` APIs in the component `bind` callback coupled with =
a `drmm_` allocated context causes resource leaks on bind retries and use-a=
fter-free vulnerabilities.
--

commit 78a45b3c5f7568988aeb46e28d8dcd405d6b493f
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops

This commit defers publishing the driver data until the component bind
callback completes successfully, and clears it during unbind. This ensures
that the PM callbacks can rely on a single null check to avoid accessing
invalid or freed state.

Closes: https://lore.kernel.org/all/20260702151550.8E14D1F000E9@smtp.kernel=
.org/
Closes: https://lore.kernel.org/all/20260723014811.1F9F01F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c4cf68d79d50..646a4cb968309 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -683,8 +683,6 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
v, struct device *master,
>  	if (ret)
>  		return dev_err_probe(hdmi->dev, ret, "Failed to init encoder");
> =20
> -	platform_set_drvdata(pdev, hdmi);
> -

[Severity: High]
This is a pre-existing issue, but does using devm_ allocations in a compone=
nt
bind callback risk resource leaks and use-after-free bugs?

The component bind function registers resources like clocks, GPIO, PHY, and
IRQs using devm_ APIs on the component's platform device (dev). Since these
resources are tied to the platform device's lifetime, they won't be freed
when the component is unbound or when bind fails and is retried.

For example, earlier in dw_hdmi_qp_rockchip_bind():

	ret =3D devm_request_threaded_irq(dev, hdmi->hpd_irq,
					cfg->ctrl_ops->hardirq_callback,
					cfg->ctrl_ops->irq_callback,
					IRQF_NO_AUTOEN, "dw-hdmi-qp-hpd",
					hdmi);

This registers the IRQ against the platform device's lifetime, but passes
the hdmi pointer as context. The hdmi structure is allocated using
drmm_kzalloc(), which ties it to the DRM master device's lifetime.

If the DRM master is unbound or fails to probe, hdmi is freed, but the IRQ
remains registered. If an interrupt fires after the master is unbound, can
the active IRQ handler in dw_hdmi_qp_rk3588_irq() dereference the freed
hdmi pointer?

Furthermore, do error paths after IRQ registration return without canceling
the delayed work or freeing the devm_ resources, accumulating leaks on
repeated bind failures?

>  	hdmi->hdmi =3D dw_hdmi_qp_bind(pdev, encoder, &plat_data);
>  	if (IS_ERR(hdmi->hdmi))
>  		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->hdmi),

[ ... ]

> @@ -704,6 +704,8 @@ static void dw_hdmi_qp_rockchip_unbind(struct device =
*dev,
>  {
>  	struct rockchip_hdmi_qp *hdmi =3D dev_get_drvdata(dev);
> =20
> +	dev_set_drvdata(dev, NULL);
> +
>  	cancel_delayed_work_sync(&hdmi->hpd_work);
>  }

[Severity: High]
This is also a pre-existing issue, but does cleaning up the delayed work
here still leave the IRQ registered against the platform device?

Because devm_request_threaded_irq() was used, the IRQ isn't freed during
unbind. Could a subsequent interrupt trigger a use-after-free by queuing
the work embedded within the already freed hdmi struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D31
