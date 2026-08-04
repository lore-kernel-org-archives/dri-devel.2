Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6190C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3A510E656;
	Tue,  4 Aug 2026 07:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fTs0q75C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454AA10E656
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:32:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E76B60A6B;
 Tue,  4 Aug 2026 07:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD3F1F00A3A;
 Tue,  4 Aug 2026 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785828729;
 bh=tlgSfQXHOULHBdJhxAmVT6LrpphatOIWdmSljqGdoPU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fTs0q75C4ANOI358ZYN8RM+Z+H9GLbhr+w8rpFjlC/ZC7z/P2xTzqrxw4UB7RZrSZ
 p9oBfEx/WnS15NKc277r/CDH+5Cf1ZUBTBn05q2JBCjFJzhPIYwOXnRCyjUoiXgdOf
 cvYTXfFV7S8PctJRpgXJQItUnKzn1GisUo6bUrFVfFewiAdQpTwZ+XLSq1jhM7C4ZJ
 nHjI4rPnWC92OzZx5cziYoAL6VKiAwKJDUHw71Aw3rhDCx5ZIfYy9Tq11MGahw4PSu
 x9jlx9lkpFqSxuYPK1wzHIzMIsgEZs+hkpg/kqY053dHdyZb2i1OjXam6myJMYVPdR
 1Dmj2QU8o2MbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, olteanv@gmail.com, vkoul@kernel.org
In-Reply-To: <20260804070730.68-6-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-6-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:32:07 +0000
Message-Id: <20260804073208.9BD3F1F00A3A@smtp.kernel.org>
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
- [High] Passing `child_np` to `drm_aux_bridge_register_from_node()` withou=
t acquiring an additional reference leads to a refcount underflow and poten=
tial double-free.
- [Medium] The result of `devm_phy_create()` is not checked immediately, le=
ading to potential error shadowing and broken probe deferral.
--

--- Patch [5]: [PATCH v6 5/7] phy: rockchip: phy-rockchip-typec: Add DRM AU=
X bridge ---
commit ed030870fca01a8999b3193c38becaaeb4276a91
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge

Using the DRM_AUX_BRIDGE helper to create the transparent DRM bridge
device.

> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rock=
chip/phy-rockchip-typec.c
> index d9701b6106d55..48070b50416e5 100644
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

[Severity: Medium]
Should we check if devm_phy_create() failed before registering the bridge?

If devm_phy_create() fails with an error like -EPROBE_DEFER, but
drm_aux_bridge_register_from_node() also fails, the code below checks 'ret'
first and returns that error. This could shadow the -EPROBE_DEFER from the
PHY creation and prevent the driver from properly probing again.

[Severity: High]
Does this code need to call of_node_get() on child_np before passing it her=
e?

The for_each_available_child_of_node() loop only holds a reference to child=
_np
during the current iteration, dropping it when advancing to the next node.
However, drm_aux_bridge_register_from_node() assigns the node to the bridge
device without incrementing the reference count, and later calls of_node_pu=
t()
in its release callback.

Will this lead to a refcount underflow and use-after-free of the node memory
once the loop advances?

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
If drm_aux_bridge_register_from_node() fails, does this cause a double-free
of the OF node?

Because the loop reference was passed directly to the bridge registration
without incrementing the reference count, and the bridge already calls
of_node_put() on its own internal error path, calling of_node_put() here
again will drop the reference count a second time.

> +			return ret;
> +		}
> +
>  		if (IS_ERR(phy)) {
>  			dev_err(dev, "failed to create phy: %pOFn\n",
>  				child_np);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804070730.68-1=
-kernel@airkyi.com?part=3D5
