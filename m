Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6B6C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02DA10E567;
	Thu, 30 Jul 2026 01:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JRj2t/7l";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C7D10E567
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:47:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 826DE600AA;
 Thu, 30 Jul 2026 01:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B111F00A3A;
 Thu, 30 Jul 2026 01:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785376072;
 bh=N7Yvn9+reA8QYVlCW6lFEthvljrGfTEQ0DYcSNmBmdY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JRj2t/7lbLGEMN2qc72nOJLLkyvhaeDUj0Gle+b4cL7lXImFPz86aapiJL5IwTJGN
 N2+ByMRbsb48nukkVady/1h2E1ffl8Z+S0z5Hs8BXDvAeKUqV1DivaK2Q5QOtF7LZH
 IKFYnGSWwZuMNFwbbscqOf2yr5b38isWPu41V6ZyOpHKVu1d4Ah78f2+FylzelRkuL
 aFPH3h0AhfddxwzLE0jhwQIXMIvt6Pp4wBfykAFT0Y2+h/qDnmicNT4UDNxqd8dSTy
 0qifAfxDiyGI8+EMKHjSmty8bS8B11tVksR9h3LdNz8U1SRlF7tovzIhJntGafyRxV
 zK+UNCNkjz+vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20260730013349.51-5-kernel@airkyi.com>
References: <20260730013349.51-1-kernel@airkyi.com>
 <20260730013349.51-5-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:47:51 +0000
Message-Id: <20260730014751.D5B111F00A3A@smtp.kernel.org>
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
- [High] Double-free of OF node reference resulting from borrowed node assi=
gnment
- [Medium] Improper Error Handling: Unconditional execution of bridge regis=
tration shadows PHY creation errors
--

--- Patch [4]: [PATCH v5 4/6] phy: rockchip: phy-rockchip-typec: Add DRM AU=
X bridge ---
commit c26cb3c5d012dc638272484e672dcad955d4a455
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
If devm_phy_create() fails and returns an error pointer, the code still
unconditionally calls drm_aux_bridge_register_from_node().

If the bridge registration fails, its error code will be stored in ret
and returned below, which completely shadows the original error from
devm_phy_create() (such as -EPROBE_DEFER).

Should devm_phy_create()'s return value be checked before attempting to
register the bridge?


[Severity: High]
Does this cause a double-free of the child_np node reference?

The for_each_available_child_of_node() loop automatically holds a reference
to child_np. When child_np is passed to drm_aux_bridge_register_from_node(),
the bridge takes ownership of the node reference without the caller acquiri=
ng
an additional reference via of_node_get().

If registration succeeds, the bridge will eventually call of_node_put() in
its drm_aux_bridge_release() handler. Meanwhile, the iterator loop also
automatically calls of_node_put() when advancing to the next node, leading
to a double-free on the success path.

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
If drm_aux_bridge_register_from_node() fails, it calls of_node_put()
internally. Because this error path explicitly calls of_node_put(child_np)
again, would this result in an immediate double-free?

Would it be better to call of_node_get(child_np) before passing it to
drm_aux_bridge_register_from_node() to ensure the bridge has its own
reference?

>  		if (IS_ERR(phy)) {
>  			dev_err(dev, "failed to create phy: %pOFn\n",
>  				child_np);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730013349.51-1=
-kernel@airkyi.com?part=3D4
