Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FBCC55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC5410E232;
	Fri, 31 Jul 2026 15:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h+NWym1e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EE710E232
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:03:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BAF84402B;
 Fri, 31 Jul 2026 15:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6651F000E9;
 Fri, 31 Jul 2026 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785510214;
 bh=0C4zxZnDLWhYd9A1bVehato/vJ05L8AhfglFm/ZN/1w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h+NWym1egfVnf+U+SiGwhgZ8c/vtbqH0liY7F33Uv7oUvQfDkQXDPPwdoBq4QW44b
 Z8xChBbLGsKVg83J7co0oeX7uFuPuqUbtsmlFiWJRqSX+Kd4ZyL8yvLhAr4PJ9v+CZ
 fC+S27Rlhd3sFcdR8rKWgZNyLaZxhII2yoA0CmQKqKSdxmC55FmqQh33u2/qba9lQx
 78cGFZUDB53QTrGVeTxpNWH73GyfPfMse1ECR99t3NwM6V1GgJ4Lo4wNSTkNBuj4fa
 yfQXGYScsy7ORv3QZdw5abKJoRUjTds3lFb5Ie0EOUFPx8LzlpSkdmOh8EK/oz/aSr
 USIJdQgpE2Esg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/21] drm/bridge: synopsys: dw-dp: Register DP AUX
 on bridge attach
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-1-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-1-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:03:33 +0000
Message-Id: <20260731150334.1B6651F000E9@smtp.kernel.org>
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

New issues:
- [High] Moving `drm_dp_aux_unregister()` to `dw_dp_bridge_detach()` decoup=
les the AUX device lifecycle from the component device's `devm_` resources,=
 causing a Use-After-Free vulnerability on unbind or error paths.

Pre-existing issues:
- [High] The AUX transfer function does not reinitialize the completion obj=
ect before waiting, leading to state corruption on timeout.
--

--- Patch [1]: [PATCH v8 01/21] drm/bridge: synopsys: dw-dp: Register DP AU=
X on bridge attach ---
commit 356b23a8a66946521d5979525583ffc3eb67acf6
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Register DP AUX on bridge attach

This commit moves the DP AUX device registration from the bind/unbind
callbacks into the bridge attach/detach callbacks. This is intended to
ensure the AUX device is only accessible when the DRM device is ready
and the bridge is powered.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 3445c82e6f50e..112a499113095 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1813,7 +1813,36 @@ static struct drm_bridge_state *dw_dp_bridge_atomi=
c_duplicate_state(struct drm_b
>  	return &state->base;
>  }
> =20
> +static int dw_dp_bridge_attach(struct drm_bridge *bridge,
> +			       struct drm_encoder *encoder,
> +			       enum drm_bridge_attach_flags flags)
> +{

[ ... ]

> +static void dw_dp_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	drm_dp_aux_unregister(&dp->aux);
> +}

[Severity: High]
Does moving the unregistration here decouple the AUX device lifecycle
from the component device's devres resources?

If a user unbinds the component device via sysfs while the DRM master
device is held open by userspace, the component unbinds and its devres
group frees dp and dp->regmap.

However, the DRM bridge remains attached until the DRM device is fully
closed, delaying dw_dp_bridge_detach(). The AUX char device
/dev/drm_dp_auxN would remain registered and accessible, backed by freed
memory.=20

A subsequent AUX transfer could dereference the freed dp->regmap, and
when the DRM device is finally closed, drm_encoder_cleanup() would call
dw_dp_bridge_detach(), which calls drm_dp_aux_unregister() on the freed
dp memory.

[ ... ]

> @@ -2065,37 +2084,33 @@ struct dw_dp *dw_dp_bind(struct device *dev, stru=
ct drm_encoder *encoder,
>  	ret =3D phy_init(dp->phy);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "phy init failed\n");
> -		goto unregister_aux;
> +		return ERR_PTR(ret);
>  	}

[Severity: High]
Can returning directly on these error paths without unregistering the AUX
device or detaching the bridge cause a use-after-free regression?

The dw_dp_bind() function allocates dp and dp->regmap using devm_ APIs.
Since the synchronous drm_dp_aux_unregister() was removed from the error
paths, the AUX device remains registered. When bind fails, the devres
group will free dp, leaving a dangling pointer.

[ ... ]

>  void dw_dp_unbind(struct dw_dp *dp)
>  {
> -	drm_dp_aux_unregister(&dp->aux);
> +	/* nothing to do */
>  }

[Severity: High]
By removing the synchronous AUX unregistration here, could the char device
outlive the component and lead to the use-after-free described above?

[Severity: High]
This is a pre-existing issue, but does dw_dp_aux_transfer() fail to
reinitialize the completion object before waiting?

Looking at dw_dp_aux_transfer() in drivers/gpu/drm/bridge/synopsys/dw-dp.c:

	regmap_write(dp->regmap, DW_DP_AUX_CMD, value);

	status =3D wait_for_completion_timeout(&dp->complete, timeout);

If a transfer times out, it returns without decrementing the completion's
internal counter. When the hardware eventually completes the delayed
transfer, the IRQ handler calls complete(&dp->complete).

On the next AUX transfer, wait_for_completion_timeout() will immediately
return success by consuming the stray completion instead of waiting for
the new transfer. The driver would then read DW_DP_AUX_STATUS containing
in-progress or stale data.

Should reinit_completion(&dp->complete) be called before initiating the
hardware transfer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D1
