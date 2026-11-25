Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5294606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpYjqAbm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241A310FEF7;
	Wed, 25 Nov 2026 18:20:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E218C10FEF7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:20:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98EE0407BD;
 Wed, 25 Nov 2026 18:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478F71F000C0;
 Wed, 25 Nov 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630811;
 bh=v58QMw0yjvceZo/hZz9U551vX4wCUdNK8yu0lcIAhxc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QpYjqAbmPNE5gtJUI0Lv4+dgXhQkrAgvb1bUmZsxgAflE2tSWJmrrGBnIhMiFy7/m
 Bb2vyCBzkcnHbcpOvWC9+dUW5JNAZqAqDa90IF96bcymuXcxndAWmhtvfeRHUA8wuA
 f7+h8SUGTxdTJLbj5dWTJh5tMFwshVa9CDpRL6In9vpuCFfyQ6NR5B/IS6qFbdWiG6
 E9QBgoDrPHmccL0KEjH5vS8g1mNhulAq9XiputtCy9WXbcLjJwd5oDTlUNuRtvo75t
 y5eVAcOgz9E7gCbiSDy3P6MfmVVtOoZ9JGmg3VoJ3eZAdjk2WGAc6qPzwmP5EtMi1K
 9DJqvk15PwRDQ==
Message-ID: <sashiko-outbox-233966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] arm64: dts: qcom: sdm845-samsung-starqltechn:
 Update panel compatible
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125-crosshatch-panel-v4-8-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-8-120adc58e737@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:20:10 +0000
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
- [High] arm64: dts: qcom: incompatible panel@0 compatible and
  reset-gpios change
--

commit fd433e980a7d2d9c4e491b9e6c72d47eb49cfd5c
Author: David Heidelberg <david@ixit.cz>

arm64: dts: qcom: sdm845-samsung-starqltechn: Update panel compatible

This commit replaces the panel@0 compatible string with
"samsung,s6e3ha8-amb577px01" and changes its reset-gpios polarity to
GPIO_ACTIVE_LOW on Samsung Galaxy S9 (starqltechn).

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/ar=
ch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index bd59f1dcd96dc..c156ed3733b4e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -267,13 +267,13 @@ &mdss_dsi0 {
>  	status =3D "okay";
> =20
>  	panel@0 {
> -		compatible =3D "samsung,s6e3ha8";
> +		compatible =3D "samsung,s6e3ha8-amb577px01";
>  		reg =3D <0>;
>  		vci-supply =3D <&s2dos05_ldo4>;
>  		vddr-supply =3D <&s2dos05_buck>;
>  		vdd3-supply =3D <&s2dos05_ldo1>;
>  		te-gpios =3D <&tlmm 10 GPIO_ACTIVE_HIGH>;
> -		reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_LOW>;
>  		pinctrl-0 =3D <&dsi_default &dsi_te>;
>  		pinctrl-1 =3D <&dsi_suspend &dsi_te>;
>  		pinctrl-names =3D "default", "suspend";

[Severity: High]
As reported by Krzysztof Kozlowski on v2 [1], does replacing the
"samsung,s6e3ha8" compatible string without a fallback and inverting
reset-gpios to GPIO_ACTIVE_LOW break DTB compatibility for existing
kernels and DTB consumers?

Any kernel or consumer that only matches "samsung,s6e3ha8" and expects
GPIO_ACTIVE_HIGH (established in 70005c18c9f7 ("arm64: dts: qcom:
sdm845-starqltechn: add graphics support")) will fail to bind or reset the
panel when booted with this DTB.  Earlier patches in this series already
handle the legacy "samsung,s6e3ha8" compatible and inverted reset polarity
in drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c via
broken_reset_polarity.

[1] https://lore.kernel.org/r/20260929-spirited-umber-hedgehog-300ebd@quoll

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-crosshatch=
-panel-v4-0-120adc58e737@ixit.cz?part=3D8
