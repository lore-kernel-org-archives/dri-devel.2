Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2950C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D501110E6BD;
	Sat, 12 Sep 2026 08:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+5J5pXe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D058810E6BD
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:56:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACF6143D2C;
 Sat, 12 Sep 2026 08:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE591F00893;
 Sat, 12 Sep 2026 08:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789203369;
 bh=9q2aZ1+K9YHhNIWLNw810aF7IDJ53PRTJ7r+2hMbXUQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R+5J5pXeNF6eeXUYniLykE2k7KCrfCqlxTz+ftkHK5SVkGCHNbtRltva4RmbMlqyI
 8oPyDrKozCQrkmoPAd6xBcb/vizR1AA8s94CXlI4HOzqUa7cX1QxkRTvN0Xf1PLauw
 bwpa3NE/gf0KMgK13E50pzdBGGbbEvZNg3/ZxNyL/XxgOQ30y8munxXGF7cob5iPjt
 WV4YxGIzsGdLYui2q3h3j2A3B9hgxI0L8eaXnAXQdp/qXwnmdgT+d/yI/cH65R0Dj1
 nJnDihorE+lIYLHEW0oM3EY0Lr9GlBMVkYUII9Ch9ZPC5oXKpGOY0QJI3ZNNhW1Uv1
 3hfs08N8qim3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 18/20] arm64: dts: qcom: Add initial support for
 MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org,
 linux-clk@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org,
 mfd@lists.linux.dev
In-Reply-To: <20260912-msm8952-initial-support-v1-18-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-18-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:56:08 +0000
Message-Id: <20260912085609.0BE591F00893@smtp.kernel.org>
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
- [High] MPM pin map contains GIC INTIDs instead of GIC SPI numbers, breaki=
ng wakeup interrupt routing.
- [High] Passive CPU cooling devices are bound to 'hot' trip points, comple=
tely disabling thermal throttling.
--

commit 316713382c786eea1b0593b2d6ec702dcfda18de
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>
arm64: dts: qcom: Add initial support for MSM8952

This commit adds device tree support for the Qualcomm MSM8952 SoC, enabling
peripherals like the MDSS, USB, RPM, and other basic features.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> index 0000000000000..8b7fa84e7986a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi
[ ... ]
> +		mpm: interrupt-controller {
> +			compatible =3D "qcom,mpm";
> +			qcom,rpm-msg-ram =3D <&apss_mpm>;
> +			interrupts =3D <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
> +			mboxes =3D <&apcs1 1>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			#power-domain-cells =3D <0>;
> +			interrupt-parent =3D <&intc>;
> +			qcom,mpm-pin-count =3D <64>;
> +			qcom,mpm-pin-map =3D <2 216>, /* TSENS UPLOW */
> +				<49 172>, /* USB ASYNC */
> +				<53 104>, /* MDSS */
> +				<58 166>, /* USB */
> +				<62 222>; /* SPMI */
> +		};

[Severity: High]
Does this mpm-pin-map define GIC INTIDs (SPI + 32) instead of the expected
raw GIC SPI numbers?

When providing INTIDs instead of raw SPI numbers, system wakeup interrupts =
for
peripherals like TSENS, USB, and MDSS will be misrouted. When the SoC wakes=
 up,
the MPM driver will re-trigger the wrong parent SPI (for example, requesting
SPI 216 instead of 184 for TSENS).

This can cause the peripheral driver to miss the interrupt and potentially =
leave
the system in a stuck state.

[ ... ]
> +		cpu4-thermal {
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <1000>;
> +			thermal-sensors =3D <&tsens 5>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu4_alert1>;
> +					cooling-device =3D <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu4_alert0: trip-point0 {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu4_alert1: trip-point1 {
> +					temperature =3D <85000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};

[Severity: High]
Will the cpu4 cooling device ever be engaged?

The cooling map in cpu4-thermal binds the passive CPU cooling device to the
cpu4_alert1 trip point, but this trip point is defined as type "hot".

The thermal core and default passive cooling governors (such as step_wise or
power_allocator) explicitly ignore "hot" trip points. Because of this, the
bound cooling device will not be triggered to reduce the CPU frequency when=
 the
85C threshold is reached, leading to thermal runaway and an uncontrolled
shutdown when the critical trip is hit.

This pattern appears to also be present in the cpu5-thermal, cpu6-thermal,
cpu7-thermal, and cpu0-3-thermal blocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D18
