Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115D6CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F17B10EE32;
	Mon,  8 Jun 2026 07:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MpmeJxzK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016F810EE26
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:24:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6AB916001D;
 Mon,  8 Jun 2026 07:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65F61F00893;
 Mon,  8 Jun 2026 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780903489;
 bh=wTdREXOe6KftoM5aRL0DAAx/CeBU/II+OQDB3vdmgW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MpmeJxzKb67NN36hQhDGuNkChToafl1q1+7DYmdeTzgc+rvTW22Lysyljq0M1x9uQ
 tkIcAbSP9L4WuVTIqQstT8pss0oFoH9ipOGzsC0N5iytVq+VORzLPv01aPDiEVYJbZ
 n4y3I6AsUnaM/hL56e0JafBYMeojVWcPLi/aWmkjI8MoDIrv2qIPRCJAMC5+Xc/FoN
 D/Ct99FhjWKC8oNPB7jXYbnN+QmkiUqUYFqP5X2v2Deuj/1mVHSg+zggeGSsmBH/gx
 7nDt8N97qy0M24vGs8nwCf7q62IlID6nyrX+jV6GqrEgJko9DYt9Ht5EV+68rx8QX1
 VOg6ApnkigGCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20260608070805.88-4-kernel@airkyi.com>
References: <20260608070805.88-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:24:48 +0000
Message-Id: <20260608072448.C65F61F00893@smtp.kernel.org>
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
- [High] Double-free of device node `child_np` due to missing `of_node_get(=
)`
- [Medium] Logic error and potential error masking due to incorrect check o=
rdering
--

commit 35100033d8cc196dcdf5880de55b8c3780fffd11
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge

This commit updates the Rockchip Type-C PHY driver to use the DRM_AUX_BRIDGE
helper. It registers a transparent DRM bridge device for the DP port defined
in the device tree.

> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rock=
chip/phy-rockchip-typec.c
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
[ ... ]
> @@ -1162,16 +1163,24 @@ static int rockchip_typec_phy_probe(struct platfo=
rm_device *pdev)
> =20
>  	for_each_available_child_of_node(np, child_np) {
>  		struct phy *phy;
> +		ret =3D 0;
> =20
> -		if (of_node_name_eq(child_np, "dp-port"))
> +		if (of_node_name_eq(child_np, "dp-port")) {
>  			phy =3D devm_phy_create(dev, child_np,
>  					      &rockchip_dp_phy_ops);
> -		else if (of_node_name_eq(child_np, "usb3-port"))
> +			ret =3D drm_aux_bridge_register_from_node(dev, child_np);

[Severity: High]
Does this cause a double-free of the child_np device node?

The loop macro for_each_available_child_of_node() provides a temporary
reference to child_np that is automatically released when the loop advances.

However, drm_aux_bridge_register_from_node() passes this node to
device_set_node() which assigns the node without incrementing its reference
count.

When the auxiliary bridge is later unregistered, drm_aux_bridge_release()
unconditionally calls of_node_put() on this node:

drivers/gpu/drm/bridge/aux-bridge.c:drm_aux_bridge_release() {
	...
	of_node_put(dev->of_node);
	...
}

Because an additional reference was never acquired, this can cause a refere=
nce
count underflow and a use-after-free of the device node structure.

Should we call of_node_get(child_np) before passing it to
drm_aux_bridge_register_from_node()?

> +		} else if (of_node_name_eq(child_np, "usb3-port"))
>  			phy =3D devm_phy_create(dev, child_np,
>  					      &rockchip_usb3_phy_ops);
>  		else
>  			continue;
> =20
> +		if (ret) {
> +			pm_runtime_disable(dev);
> +			of_node_put(child_np);
> +			return ret;
> +		}
> +

[Severity: Medium]
If devm_phy_create() fails, will this error be masked if
drm_aux_bridge_register_from_node() also fails?

If devm_phy_create() returns an ERR_PTR, but drm_aux_bridge_register_from_n=
ode()
fails and returns a non-zero value, the error check here captures
the bridge error instead of the PHY error.

This would return an incorrect error code and skip the "failed to create ph=
y"
debug log entirely. Also, if the PHY fails but the bridge succeeds, the code
registers an unnecessary auxiliary device only for devres to immediately te=
ar
it down.

Would it be better to check IS_ERR(phy) immediately after devm_phy_create()
and before registering the bridge?

>  		if (IS_ERR(phy)) {
>  			dev_err(dev, "failed to create phy: %pOFn\n",
>  				child_np);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608070805.88-1=
-kernel@airkyi.com?part=3D3
