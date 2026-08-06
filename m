Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBE5C5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9B410F279;
	Thu,  6 Aug 2026 17:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gmjT6ABk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0F010F279
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:37:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EE2360AB1;
 Thu,  6 Aug 2026 17:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E821F00A3E;
 Thu,  6 Aug 2026 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786037829;
 bh=/AmSBg+bSlHudXnKp0obu5ljE24U7DbCHe6qNShJI7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gmjT6ABkxnj7zPhlY3vOj5BNCmR5bBeuToPnh9lV16fv5n9fwHWzoIWwbjckMTrSA
 mjC+TiNnDuzrdK7uhfXTaoa4/YvBXluHHvCPFUlH9TUAT1al5uqTtufRgMpEO6jJeZ
 60CvSEO7lf7JeTUBcfKmsz29mJvWkfrkCaiCt5LNku+pq6mI4V6rN/HE7PVICBe/nI
 dMYhUIspY8a3VMCTYPAGrz+CaR6HXHtIEw27O3+8yrMXbyZQP32981oDPxAs901rZ/
 pKANyj2DpN1EB5VMISA1RwbZze+jtq9n1oZVMoF3krPX1XVa0w+q8n2i1JQI6cTSp0
 HMCI5Jh/Kkv2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/21] drm/bridge: synopsys: dw-dp: Register DP AUX
 on bridge attach
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-1-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-1-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:37:07 +0000
Message-Id: <20260806173708.71E821F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Moving `drm_dp_aux_unregister()` to the `.detach` bridge hook intr=
oduces a use-after-free vulnerability during driver unbind.

Pre-existing issues:
- [High] Using `devm_` APIs inside the component `bind` callback causes res=
ource leaks and permanent probe failures if the aggregate device defers pro=
bing.
- [High] Missing `reinit_completion()` in `dw_dp_aux_transfer()` leads to p=
ermanent completion desynchronization after an initial timeout.
- [High] Missing cancellation of `dp->hpd_work` during unbind/remove leads =
to a Use-After-Free if a hotplug interrupt arrives just before the module i=
s unloaded.
--

--- Patch [1]: [PATCH v11 01/21] drm/bridge: synopsys: dw-dp: Register DP A=
UX on bridge attach ---
commit c6879b7a6958b5129284c9fb809eb29af0d93f7c
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Register DP AUX on bridge attach
   =20
This commit delays the registration of the DP AUX device until the bridge
is attached, and unregisters it in the detach hook. This helps ensure that
it is only accessed when the DRM device is ready.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 8b8529e1723c8..60feb3d1e14bb 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1813,7 +1813,36 @@ static struct drm_bridge_state *dw_dp_bridge_atomi=
c_duplicate_state(struct drm_b
>  	return &state->base;
>  }
> =20
> +static int dw_dp_bridge_attach(struct drm_bridge *bridge,
> +			       struct drm_encoder *encoder,
> +			       enum drm_bridge_attach_flags flags)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +	struct device *dev =3D dp->dev;
> +	int ret;
> +
> +	dp->aux.dev =3D dev;
> +	dp->aux.drm_dev =3D encoder->dev;
> +	dp->aux.name =3D dev_name(dev);
> +	dp->aux.transfer =3D dw_dp_aux_transfer;

[Severity: High]
This is a pre-existing issue, but does dw_dp_aux_transfer() permanently
desynchronize after a single timeout?

If an AUX transaction times out, wait_for_completion_timeout() returns
and dp->complete.done remains 0. When the late hardware interrupt
eventually arrives, dw_dp_irq() calls complete(), setting done to 1.

Since dw_dp_aux_transfer() lacks a preceding call to reinit_completion(),
the very next AUX transfer will immediately succeed the wait without actual=
ly
waiting for the hardware, leading to premature reads of DW_DP_AUX_STATUS.

> +
> +	ret =3D drm_dp_aux_register(&dp->aux);
> +	if (ret)
> +		dev_err(dev, "Aux register failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void dw_dp_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	drm_dp_aux_unregister(&dp->aux);

[Severity: High]
Will moving drm_dp_aux_unregister() to the bridge detach hook cause a
use-after-free if userspace keeps the DRM device open?

If a process holds an open file descriptor for the DRM device while the
driver is unbound, the DRM device's refcount prevents the bridge's detach
hook from running immediately.

The component's memory (like the dp structure) will be freed by the driver
core during unbind, but the AUX char device remains registered. If userspace
then reads or writes to the AUX device, dw_dp_aux_transfer() will
dereference the freed memory.

> +}
> +

[ ... ]

> @@ -2064,37 +2083,33 @@ struct dw_dp *dw_dp_bind(struct device *dev, stru=
ct drm_encoder *encoder,
>  	ret =3D phy_init(dp->phy);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "phy init failed\n");
> -		goto unregister_aux;
> +		return ERR_PTR(ret);
>  	}
> =20
>  	ret =3D devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
>  	if (ret)
> -		goto unregister_aux;
> +		return ERR_PTR(ret);
> =20
>  	dp->irq =3D platform_get_irq(pdev, 0);

[Severity: High]
This isn't a bug introduced by this patch, but can using devm_ APIs inside
the component bind callback cause resource leaks?

If the aggregate DRM device defers probing, the component framework undoes
the bind, but it does not release the devm_ resources because the component
device itself remains bound to its platform driver.

When the aggregate device retries probing, dw_dp_bind() allocates them
again. The calls to devm_request_threaded_irq() or
devm_platform_ioremap_resource() will fail with -EBUSY, permanently
preventing the pipeline from probing.

>  	if (dp->irq < 0) {
>  		ret =3D dp->irq;
> -		goto unregister_aux;
> +		return ERR_PTR(ret);
>  	}
> =20
>  	ret =3D devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,

[ ... ]

> @@ -2101,8 +2112,8 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
> =20
>  void dw_dp_unbind(struct dw_dp *dp)
>  {
> -	drm_dp_aux_unregister(&dp->aux);
> +	/* nothing to do */
>  }

[Severity: High]
This is a pre-existing issue, but is it possible for an HPD interrupt to
race with module unload?

If an HPD interrupt triggers and schedules dp->hpd_work just before the
driver is unbound, the global workqueue may execute dw_dp_hpd_work() after
the devm_ cleanup path frees the dp structure.

Does dw_dp_unbind() need a call to cancel_work_sync(&dp->hpd_work) to
prevent a use-after-free?

>  EXPORT_SYMBOL_GPL(dw_dp_unbind);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D1
