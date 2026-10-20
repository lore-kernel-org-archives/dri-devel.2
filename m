Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640C606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ky9w8apS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDFA10E594;
	Tue, 20 Oct 2026 08:44:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FF610E594
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:44:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C07F8418F1;
 Tue, 20 Oct 2026 08:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EEB1F000C6;
 Tue, 20 Oct 2026 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792485863;
 bh=mc6RRGX7gYyCjJfiAy6dDp+mQsnToMDdgMCPXd3lI3U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ky9w8apSzr4M+3oAGvcpPErFMxxrcKqrFpjNcNBK6A+U0yjbd8FP+aQqglUBRqwTu
 3zta5ryqgtXlGcPk3PsO6eZY0wEM9VChgoJiFWTNBil1Mi9Q4SsxBmID00dJyYEPmo
 bSke/Az0+yQzXs7JioAhrW1RZ/RVueQ5tjx01L4V6uGFzegiixHDJ2kyvgOR5ReqAH
 qboC7p2jzZTqaISvFe0CWNOwfupZgqSv6Mgq24ArWKTgSZQd2ZO9/dMvhhAwnhPe3R
 H8KKZrHPLuT4cjrRYQe4jQH/AFsc856nP/oRSbCevuzppKANq+UjsulA+IgjQ6ZybT
 TXSkfr87ifzMg==
Message-ID: <sashiko-outbox-178604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/7] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261020072816.180-6-kernel@airkyi.com>
References: <20261020072816.180-1-kernel@airkyi.com>
 <20261020072816.180-6-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:44:22 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] phy: rockchip: typec: unbalanced of_node_put() in rockchip_typec_p=
hy_probe()
--

commit 5dd2a89486cce6e81a7e0bfa3f39b495d7254541
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge

This commit registers a transparent DRM AUX bridge device for the dp-port
child node in the Rockchip Type-C PHY driver using
drm_aux_bridge_register_from_node().

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

[Severity: High]
Does passing child_np directly to drm_aux_bridge_register_from_node() here
cause an OF node reference count underflow on child_np?

In rockchip_typec_phy_probe(), for_each_available_child_of_node() holds a
reference on child_np only for the current loop iteration and drops it when
advancing to the next child (or via of_node_put(child_np) on early return).

However, in drivers/gpu/drm/bridge/aux-bridge.c,
drm_aux_bridge_register_from_node() assigns adev->dev.of_node via
device_set_node() without taking a reference with of_node_get(), while both
its error path and drm_aux_bridge_release() drop a reference:

drivers/gpu/drm/bridge/aux-bridge.c:drm_aux_bridge_register_from_node() {
	if (np)
		device_set_node(&adev->dev, of_fwnode_handle(np));
	else
		device_set_of_node_from_dev(&adev->dev, parent);

	ret =3D auxiliary_device_init(adev);
	if (ret) {
		of_node_put(adev->dev.of_node);
		ida_free(&drm_aux_bridge_ida, adev->id);
		kfree(adev);
		return ret;
	}
}

drivers/gpu/drm/bridge/aux-bridge.c:drm_aux_bridge_release() {
	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);

	of_node_put(dev->of_node);
	ida_free(&drm_aux_bridge_ida, adev->id);

	kfree(adev);
}

If drm_aux_bridge_register_from_node() fails at or after
auxiliary_device_init(), it calls of_node_put(child_np) internally, and then
the error path in rockchip_typec_phy_probe() calls of_node_put(child_np) a
second time.

Similarly, if drm_aux_bridge_register_from_node() succeeds, the loop drops
its reference on child_np when advancing to the next child node, and
drm_aux_bridge_release() will later call of_node_put(dev->of_node) when the
auxiliary device is released without owning a reference.

>  		if (IS_ERR(phy)) {
>  			dev_err(dev, "failed to create phy: %pOFn\n",
>  				child_np);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020072816.180-=
1-kernel@airkyi.com?part=3D5
