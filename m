Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F122C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2D110F47D;
	Fri, 17 Jul 2026 07:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W7jQ2Al9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1409F10F47D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:39:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F01FA408E0;
 Fri, 17 Jul 2026 07:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C45F1F000E9;
 Fri, 17 Jul 2026 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784273950;
 bh=RxPnS/iwkFzSgZ3S0p1fqfVZE4MWCv7J9EC/jgWc1/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W7jQ2Al9mnSM0ZKeoxchrOap7l35yq+UoNC9VgF+4EPmHBQBvYPL2/nRKmgsJaHeX
 pnopEl8UlhM8Z+XvJc96jh0vVcXMXZYpyK1Ka5d7OXKMXVIpR1NweZS4xsmLF+VrCX
 MufdG2cdi1hvbjIl3d9pW/3HDDdtWCx5Zkh7h5vUKuwQhSoFQ0KgcQDXNR0L9ImzrO
 Nf/dcmxV9d2bngmB6Xwtd4KzCyQYt5ps9L0I3tzqWXFTM+FPKbYubcWeHHqvOxhngP
 iNJ4xpo7WYbM/ASJ5INJQtp8d+K4ORW5HT3cBm/db8JjeeLNE84LZCaSN/nunChyNS
 PgEFVCVnSchHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260717072323.96-4-kernel@airkyi.com>
References: <20260717072323.96-1-kernel@airkyi.com>
 <20260717072323.96-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:39:10 +0000
Message-Id: <20260717073910.7C45F1F000E9@smtp.kernel.org>
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
- [High] Double-free and reference count underflow of the `child_np` device=
 tree node reference due to conflicting ownership with `drm_aux_bridge_regi=
ster_from_node()`.
--

--- Patch [3]: [PATCH v3 3/5] phy: rockchip: phy-rockchip-typec: Add DRM AU=
X bridge ---
commit 7121c384753e095d5a040f2bd93021b7ae8110d7
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
   =20
Using the DRM_AUX_BRIDGE helper to create the transparent DRM bridge
device.

> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rock=
chip/phy-rockchip-typec.c
> index d9701b6106d55..48070b50416e5 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
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
> +		} else if (of_node_name_eq(child_np, "usb3-port"))
>  			phy =3D devm_phy_create(dev, child_np,
>  					      &rockchip_usb3_phy_ops);
>  		else
>  			continue;
> =20
> +		if (ret) {
> +			pm_runtime_disable(dev);
> +			of_node_put(child_np);

[Severity: High]
Does this cause a reference count underflow for the child_np device node?

drm_aux_bridge_register_from_node() assigns the node to an auxiliary device,
and its error and release paths in drm/bridge/aux-bridge.c unconditionally
call of_node_put() to drop the reference.

However, the for_each_available_child_of_node() iterator owns the reference
to child_np during this loop iteration. Passing it to
drm_aux_bridge_register_from_node() without acquiring an additional referen=
ce
via of_node_get() appears to hand off a reference the bridge doesn't own.

If drm_aux_bridge_register_from_node() succeeds, the loop advances and drops
the iterator's reference, leading to a double-put when the bridge is
eventually released.

If drm_aux_bridge_register_from_node() fails, it drops the reference
internally. The explicit of_node_put(child_np) here in the error block would
then cause an immediate double-put.

> +			return ret;
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717072323.96-1=
-kernel@airkyi.com?part=3D3
