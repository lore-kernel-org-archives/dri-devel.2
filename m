Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6B6CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8F510FD3F;
	Thu,  8 Oct 2026 21:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jHEZzyka";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3773010FD3F
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:15:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2369760DA9;
 Thu,  8 Oct 2026 21:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712821F000FF;
 Thu,  8 Oct 2026 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791494135;
 bh=EUjJU4QS/nJLfIBzxcye2SlSFqIg3lZcc5WD5aB/RrM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jHEZzykaL8nevSGwEsqXYpG3n9TNIUFZEzsuCqbSTO2XQweUAFS9VEu0fsSHS4H6A
 EUMv/8G4a3bFnCTcHVVkOw1WIhVWfhMonP1IR4xSrmXf6Far8xAHjEbrY6XdVyqbZN
 5PEA7TtaX0rAj9Kd5yOQmoIVcuSsGFZa2eipD5LiPOrTwFMdXLK2+XEtgA1AQ867eB
 e3Lo+BWrWbsQX8vqlr+7S8gRXkrSDg42iaaxJUIGiEH4eBIwOC/7GK+V5Hf8VyLMp2
 n6r9x2yxikqabisrjTiuf1pSNbXFc6cj/oInzFjq2R1tDbNnrbhyJcxbN9+UQUIIFH
 wdk+oXiOKabBA==
Message-ID: <sashiko-outbox-164604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: nord: Add GPU cooling
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261009-nord-gpu1-v1-4-a06a6c57bde7@oss.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-4-a06a6c57bde7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 21:15:34 +0000
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
- [Medium] dts: missing cooling-device mappings for 4 GPU thermal zones
--

commit be1fe5e4df785d4f2fc715cc8d3e734547b71199
Author: Aastha Pandey <aastha.pandey@oss.qualcomm.com>

arm64: dts: qcom: nord: Add GPU cooling

This commit sets up GPU cooling on Nord by throttling the Adreno 753 GPU
when it reaches 105C. It labels the GPU thermal zones and their passive trip
points, maps them to the GPU as a cooling device, and adds polling delays.

> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boo=
t/dts/qcom/nord-embedded.dtsi
> index 4379092b7bf8d..23370007c9748 100644
> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi

[ ... ]

> +&gpuss_2_thermal {
> +	polling-delay-passive =3D <10>;
> +
> +	cooling-maps {
> +		map0 {
> +			trip =3D <&gpuss2_alert0>;
> +			cooling-device =3D <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};

[Severity: Medium]
Are the cooling device mappings for the gpuss_1_0_thermal, gpuss_1_1_therma=
l,
gpuss_1_2_thermal, and gpu_1_0_thermal zones intentionally omitted from this
list?

If a sustained GPU workload creates hotspots near these unmapped sensors,
localized heating will not trigger GPU throttling. This could allow the SoC
to reach unsafe temperature thresholds and trigger a hardware shutdown
before the adjacent mapped sensors become hot enough to intervene.

These zones and their trip points are explicitly labeled in the nord.dtsi
changes below, which suggests they should have cooling maps defined alongsi=
de
the other zones.

> diff --git a/arch/arm64/boot/dts/qcom/nord.dtsi b/arch/arm64/boot/dts/qco=
m/nord.dtsi
> index 147d8e595a3a3..b032d1d2ad9b6 100644
> --- a/arch/arm64/boot/dts/qcom/nord.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord.dtsi

[ ... ]

> -		gpuss-1-0-thermal {
> +		gpuss_1_0_thermal: gpuss-1-0-thermal {
>  			polling-delay-passive =3D <0>;
>  			polling-delay =3D <0>;
>  			thermal-sensors =3D <&tsens6 5>;

[ ... ]

> -		gpuss-1-1-thermal {
> +		gpuss_1_1_thermal: gpuss-1-1-thermal {
>  			polling-delay-passive =3D <0>;
>  			polling-delay =3D <0>;
>  			thermal-sensors =3D <&tsens6 6>;

[ ... ]

> -		gpuss-1-2-thermal {
> +		gpuss_1_2_thermal: gpuss-1-2-thermal {
>  			polling-delay-passive =3D <0>;
>  			polling-delay =3D <0>;
>  			thermal-sensors =3D <&tsens7 5>;

[ ... ]

> -		gpu-1-0-thermal {
> +		gpu_1_0_thermal: gpu-1-0-thermal {
>  			polling-delay-passive =3D <0>;
>  			polling-delay =3D <0>;
>  			thermal-sensors =3D <&tsens7 6>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-nord-gpu1-=
v1-0-a06a6c57bde7@oss.qualcomm.com?part=3D4
