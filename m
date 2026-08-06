Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D907DC55174
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BB310E241;
	Thu,  6 Aug 2026 01:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLsQ1j4U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3ED10E241
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 01:01:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC2BB419D5;
 Thu,  6 Aug 2026 01:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA8D1F00A3A;
 Thu,  6 Aug 2026 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785978080;
 bh=IjBN3iOFpNc8kQ+BJ1fX+0GUN4myNzTd1ODuuHJkUes=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NLsQ1j4UmPjSgXhL1dxEISSF8OBr1rls6IMszivhKRERH/igCK4yXT03/p4Q9MDEP
 Szx5uZ8PrnV5Ybpj/94Ji06T0gQijzbqZCwMozia/QUvMXwLGKbJGdHSqd3iBwcIeV
 7yCOhFAFbcKNpvrW7kpDi0A693U+jlj4PoiykW4rq0fXQ2O2YHIgaLoPHeVyuJmunP
 4lp/PGxWhZdc7wtn55rzluQ1kuz4m8W0cSbiW3gaVslxLDYm7MUNWn1kBoGIv+kp3r
 3ZGhudzvbi18SaTxly8TGNu22g7qhwGkR4w8YmjVzToFpbS7RBZO/fJjqIPainR2h/
 6bwM5u6K8zNMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/21] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-10-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-10-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 01:01:19 +0000
Message-Id: <20260806010120.4BA8D1F00A3A@smtp.kernel.org>
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
- [High] Incorrect teardown sequence in bridge detach and attach error path=
s allows use-after-unregister of the DP AUX channel.
- [Medium] Downstream bridge lookup occurs in `attach` rather than `probe`,=
 causing `-EPROBE_DEFER` log spam and preventing native panel support.
--

--- Patch [10]: [PATCH v10 10/21] drm/bridge: synopsys: dw-dp: Add follow-u=
p bridge support ---
commit 57506c503f9891e787cc8982280fc0136a4fc611
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add follow-up bridge support

Add support to use USB-C connectors with the DP altmode helper code on
devicetree based platforms. To get this working there must be a DRM
bridge chain from the DisplayPort controller to the USB-C connector.

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1893,8 +1895,28 @@ static int dw_dp_bridge_attach(struct drm_bridge *=
bridge,
>  		goto err_disable_irq;
>  	}
> =20
> +	dp->next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
> +	if (IS_ERR(dp->next_bridge)) {
> +		ret =3D PTR_ERR(dp->next_bridge);
> +		dev_err(dev, "failed to get follow-up bridge: %d\n", ret);

[Severity: Medium]
Should this bridge lookup be moved to the probe function instead of being
done in the attach callback?=20

Since this is in the attach path, if the downstream bridge is not yet probe=
d,
this returns -EPROBE_DEFER and logs an unconditional error on every retry
since dev_err() is used instead of dev_err_probe().

Also, does using of_drm_get_bridge_by_endpoint() prevent native panel
support here? Moving this to the probe function would allow using
devm_drm_of_get_bridge(), which handles panels automatically and safely
manages allocations without leaking during component unbind/rebind.

> +		goto err_unregister_dp_aux;
> +	}
> +
> +	ret =3D drm_bridge_attach(encoder, dp->next_bridge, bridge,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +	if (ret) {
> +		dev_err(dev, "Failed to attach next bridge: %d\n", ret);
> +		goto err_put_next_bridge;
> +	}
> +
>  	return 0;
> =20
> +err_put_next_bridge:
> +	drm_bridge_put(dp->next_bridge);
> +
> +err_unregister_dp_aux:
> +	drm_dp_aux_unregister(&dp->aux);
> +
>  err_disable_irq:
>  	disable_irq(dp->irq);
>  	cancel_work_sync(&dp->hpd_work);

[Severity: High]
Can this sequence cause a use-after-unregister of the DP AUX channel?

If we unregister the AUX device before disabling the IRQ and cancelling the
HPD worker, hardware events could still trigger interrupts and queue up=20
the work. The worker could run concurrently while the AUX device is being=20
unregistered, potentially leading to undefined behavior.

Should the IRQ be disabled and the work cancelled synchronously before
unregistering the AUX device?

> @@ -1905,6 +1927,7 @@ static void dw_dp_bridge_detach(struct drm_bridge *=
bridge)
>  {
>  	struct dw_dp *dp =3D bridge_to_dp(bridge);
> =20
> +	drm_bridge_put(dp->next_bridge);
>  	drm_dp_aux_unregister(&dp->aux);
>  	disable_irq(dp->irq);
>  	cancel_work_sync(&dp->hpd_work);

[Severity: High]
Similarly, does this detach path need the teardown order reversed?

If drm_dp_aux_unregister() runs before disabling the IRQ and cancelling the
work, the same race condition could occur during standard module unbind.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D10
