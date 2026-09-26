Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83078C98318
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 10:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3DA10E028;
	Sat, 26 Sep 2026 10:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NofsKjwE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3233F10E028
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:33:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 544DB6020C;
 Sat, 26 Sep 2026 10:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09C51F000FF;
 Sat, 26 Sep 2026 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790418799;
 bh=a4Ygu7sOYV13Idki6jOKfdc/8IU5i0YITAD2Bhl7Bt0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NofsKjwE2yPeM9OYx9U1ty1kJGPaCR4wg9rmepa81fPZo2N+gMYwNbxzj6CRAlKLI
 /6jhH92EjaVtBhgJSJ+IaN0i25MKhocINeZdt5n1ot7mya9HdhLtk9RfMmO+9FfGM2
 t+X9p9jiIoXC9PxSFoJPXerGKOdAIxFnEwTj2hYecnYRCE8YlXP0ADR84fnPdBDGuM
 2IVqGONu4x0mCj0sWsm1ZLa1IT2Dt4Pt2XjuGi7V2VngMc2z9KULfJ13tGTJ71x4F/
 FOioxcVfhWMrObrSSQSdfukbSy6FYEJTTz4+Zit7y0EQpx/sa3KkbjtoWwCQXZQfIH
 Zfy3WpMNkZ5lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
To: erebion <erebion@erebion.eu>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260926-pdx213-upstream-3-v1-5-1609c18b5c1d@erebion.eu>
References: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
 <20260926-pdx213-upstream-3-v1-5-1609c18b5c1d@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 10:33:18 +0000
Message-Id: <20260926103318.B09C51F000FF@smtp.kernel.org>
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
- [Medium] dts: silent pinctrl override failures on UART pins due to missin=
g /delete-property/
--

commit bed8cbd842a7138947e9a27eb01373050b147335
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: Enable Bluetooth
   =20
Configure the required regulators for Bluetooth and enable it on the
Xperia 10 III.

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 146c7c5c45ea2..cb749cc121abf 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
[ ... ]
> @@ -392,6 +396,40 @@ &qupv3_id_1 {
>  	status =3D "okay";
>  };
> =20
> +/* UART1: HS UART for Bluetooth */
> +&qup_uart1_cts {
> +	/*
> +	 * Configure a bias-bus-hold on CTS to lower power
> +	 * usage when Bluetooth is turned off. Bus hold will
> +	 * maintain a low power state regardless of whether
> +	 * the Bluetooth module drives the pin in either
> +	 * direction or leaves the pin fully unpowered.
> +	 */
> +	bias-bus-hold;
> +};

[Severity: Medium]
Since device tree overlays merge boolean properties rather than replacing t=
hem,
both the new and inherited properties will be present in the node.

The generic pinctrl parser evaluates properties in a fixed order, which cau=
ses
the inherited bias-disable to be evaluated after bias-bus-hold. Does this n=
eed
an explicit /delete-property/ bias-disable; to prevent the bus-hold from
being silently ignored and causing power leakage?

> +
> +&qup_uart1_rts {
> +	/* We'll drive RTS, so no pull */
> +	drive-strength =3D <2>;
> +	bias-disable;
> +};

[Severity: Medium]
Will this silently leave the pull-down enabled?

Similar to the CTS pin above, if the base node has bias-pull-down, merging
bias-disable doesn't remove it. The parser will evaluate the inherited
bias-pull-down after bias-disable, causing the pull to remain active.=20
Should this include /delete-property/ bias-pull-down; to ensure the bias
is actually disabled?

> +
> +&qup_uart1_rx {
> +	/*
> +	 * Configure a pull-up on RX. This is needed to avoid
> +	 * garbage data when the TX pin of the Bluetooth module is
> +	 * in tri-state (module powered off or not driving the
> +	 * signal yet).
> +	 */
> +	bias-pull-up;
> +};
> +
> +&qup_uart1_tx {
> +	/* We'll drive TX, so no pull */
> +	drive-strength =3D <2>;
> +	bias-disable;
> +};

[Severity: Medium]
Does this face the same property merging issue with the inherited pull-up?

If the base node defines bias-pull-up, it will be evaluated after bias-disa=
ble,
silently overriding it. Should this include /delete-property/ bias-pull-up;
to ensure the pin bias is disabled as intended?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-pdx213-ups=
tream-3-v1-0-1609c18b5c1d@erebion.eu?part=3D5
