Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D1606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVHC2qqQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2194410E081;
	Sun, 15 Nov 2026 05:01:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED59B10E081
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 05:01:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CB0C4119A;
 Sun, 15 Nov 2026 05:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571A91F000C4;
 Sun, 15 Nov 2026 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794718862;
 bh=Mn9n+Gt2ieGqU/Af8AYDgl2gcl8L9zCf6qtdoXP8HI8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AVHC2qqQumcPPvG38OJVyh8Lpy1KycFnucJnzP9qrRbx8sBXjNHpBckU2xC3iUn6g
 53uKwPHml2Jp3RkYUbwM1hAccl5pcAf7CvUt8So+M87bVJEJrpFT/POVxJgZH+gzmw
 oL9r+2gT3uPJD8i4AwL4RfuRKYCUbI1wdcDGr8FhLzTSMxYixQxT8UB7SALMrbpIV8
 lP4P9RFCaY+62WA+6VhE/j0opfTXdLh3QGVS6ATWV/CmgdjGaDi01NaNNDZ8CowpRG
 RBnkIRm1pOAyDaHA4Wd4O9DSrex8+aTLjkqLrrzrv3lpPzdNBiH7DnOAZE326u5Dy6
 WOUwDCo8u/A/g==
Message-ID: <sashiko-outbox-215231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/bridge: analogix_dp: use devm_phy_optional_get()
 for the DP PHY
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261115044755.395888-1-jerrysteve1101@gmail.com>
References: <20261115044755.395888-1-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 05:01:01 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/bridge: analogix_dp: inaccurate RK3288 PHY comment in
  analogix_dp_probe()
--

commit 720fa3eab5052c038874ca588f7e1541886e6915
Author: Jun Yan <jerrysteve1101@gmail.com>

drm/bridge: analogix_dp: use devm_phy_optional_get() for the DP PHY

This commit replaces devm_phy_get() and its open-coded error handling with
devm_phy_optional_get() in analogix_dp_probe() when acquiring the optional
DP PHY.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8bb4c48aa3b48..09171c6605d0b 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1427,21 +1427,13 @@ analogix_dp_probe(struct device *dev, struct anal=
ogix_dp_plat_data *plat_data)
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> -	dp->phy =3D devm_phy_get(dp->dev, "dp");
> -	if (IS_ERR(dp->phy)) {
> -		dev_err(dp->dev, "no DP phy configured\n");
> -		ret =3D PTR_ERR(dp->phy);
> -		if (ret) {
> -			/*
> -			 * phy itself is not enabled, so we can move forward
> -			 * assigning NULL to phy pointer.
> -			 */
> -			if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV)
> -				dp->phy =3D NULL;
> -			else
> -				return ERR_PTR(ret);
> -		}
> -	}
> +	/*
> +	 * RK3288/RK3399 use Analogix DP controller built-in PHY,
> +	 * no extra PHY configuration is required.
> +	 */
> +	dp->phy =3D devm_phy_optional_get(dp->dev, "dp");
> +	if (IS_ERR(dp->phy))
> +		return ERR_CAST(dp->phy);

[Severity: Low]
Are this comment and the commit message accurate about RK3288?

In arch/arm/boot/dts/rockchip/rk3288.dtsi and
Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yam=
l,
the RK3288 eDP node defines phys =3D <&edp_phy> and phy-names =3D "dp" for =
its
rockchip,rk3288-dp-phy device, which drivers/phy/rockchip/phy-rockchip-dp.c
programs via GRF_SOC_CON12 when phy_power_on() and phy_power_off() are
called on dp->phy.

RK3399 and RK3568 are the variants that omit the phys property and configure
the built-in PHY directly through the controller MMIO registers rather than
through a separate PHY device or GRF.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115044755.3958=
88-1-jerrysteve1101@gmail.com?part=3D1
