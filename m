Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6E8C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4F610E486;
	Fri, 28 Aug 2026 09:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P6oxDYde";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F62510E486
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:01:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59000601F5;
 Fri, 28 Aug 2026 09:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F35D1F00A3D;
 Fri, 28 Aug 2026 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787907684;
 bh=XbE359DwSELqfI3yT2dHdzl46VZ+IXaA7Gqd++mBeZ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P6oxDYde0QltU65ihNuPH9lwEb2AiAknJnbb37RPO3oyCi/k0MmB1KpkUYqUD68a2
 ogiN7mvjeSl2x9AfeLHVZoS9WSj1m6J34aqsPbBDSxz4ghVwBfVKVenMjM+OgA5Ogt
 PUQskm6eXsMLTH5DFQHtyFKyqp9QAg3THDTVDE9Omyje0ypCmxJ1LlJUUUK80+Sb5j
 +IoubVcZNP1r1ulz44A3Gs5f1Mju0iTWRx0UJGVpOgQd5LCdnNacqIpwAkeC0hgA1H
 Lxo71qiYinNPM6cxAdQHfzU74fz1wR5/gUYTg8laGg2YOYNVRcyTH+R4SAwXBACCnr
 MpJ3+7wdHGk4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/7] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20260828084737.565-6-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
 <20260828084737.565-6-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:01:22 +0000
Message-Id: <20260828090123.5F35D1F00A3D@smtp.kernel.org>
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
- [High] Double-free and Use-After-Free of OF Node Reference
- [Medium] Initialization Ordering and Error Masking
--

commit 0733fab98743300c9bca39a083f1a901d4ff8cda
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge

Using the DRM_AUX_BRIDGE helper to create the transparent DRM bridge device.

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

[Severity: High]
Does this code cause a double-free of the OF node reference?

Since child_np is the loop iterator in for_each_available_child_of_node(),
its reference is automatically dropped when advancing to the next iteration.
However, drm_aux_bridge_register_from_node() assigns the OF node to the
auxiliary device without incrementing the reference count, and drops a
reference in its error paths and release function.=20

Will this lead to a use-after-free when the loop iterator automatically dro=
ps
the reference, leaving the registered bridge pointing to a freed device nod=
e?

[Severity: Medium]
Also, does this sequence mask errors from devm_phy_create()?

The result of devm_phy_create() is not checked before calling
drm_aux_bridge_register_from_node(). If devm_phy_create() returns an error
pointer (such as -EPROBE_DEFER) and drm_aux_bridge_register_from_node()
fails, the original error will be permanently lost when returning 'ret'
below.

Additionally, if devm_phy_create() fails but bridge registration succeeds,
an auxiliary device is registered only to be immediately unregistered via
devres when returning PTR_ERR(phy) shortly after. Could this be avoided
by checking IS_ERR(phy) before registering the bridge?

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
Since drm_aux_bridge_register_from_node() already dropped the OF node
reference on its internal failure path, will calling of_node_put() here
cause an immediate double-free?

> +			return ret;
> +		}
> +
>  		if (IS_ERR(phy)) {
>  			dev_err(dev, "failed to create phy: %pOFn\n",
>  				child_np);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828084737.565-=
1-kernel@airkyi.com?part=3D5
