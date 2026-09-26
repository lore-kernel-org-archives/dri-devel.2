Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F27C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 14:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C91410E009;
	Sat, 26 Sep 2026 14:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZaRyGWS4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E86110E009
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:11:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E87B6020C;
 Sat, 26 Sep 2026 14:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47171F000FF;
 Sat, 26 Sep 2026 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790431891;
 bh=KUQkDfe1dlQHuc+TjtZoa9JN6JTUsbLT3hL59Pkv+W8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZaRyGWS4+aJ3lTxB3S5F6tBFaT0PD/6o0FWNF67z9Udhs334vR60x1rPdvxcQF7eV
 K++FY7T/ZP6unOdtw84sKprNswDEnY1aLVhRQR3uMMDv2m1kdL/VkpLwrWi1Dj6FHR
 BphH5CMUOj6DTTxAZGIpbBELAQZCY39oXkEW6S5ikk9xEErrlMODE+Y/ou2J/ojOxr
 ClUov2UVfVfGiFRle5RTtEbpExyghGk/SNlsHv22DLrv8wzeYeFHGFGjZCZdksN76i
 jVu353EuFnzYq6pX7O+ElKE83Q/U37gCXVOOR3lybLx3OEIX+sajhIaxUCesuMVP0T
 07FYHiXmDDWoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
To: erebion <erebion@erebion.eu>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260926-pdx213-upstream-3-v2-5-b4612e3eb536@erebion.eu>
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-5-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:11:30 +0000
Message-Id: <20260926141130.A47171F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: missing swctrl-gpios schema definition causes dtbs_che=
ck failure
--

commit 2895c104a8a87260afe61b3db500946505dbefb6
Author: erebion <erebion@erebion.eu>
Subject: arm64: dts: qcom: sm6350-lena: Enable Bluetooth

Configure the required regulators for Bluetooth and enable it on the
Xperia 10 III.

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index f3ed6445c7d35..9be0e7ceccb55 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts

[ ... ]

> @@ -424,6 +466,73 @@ ts_int_default: ts-int-default-state {

[ ... ]

> +&uart1 {
> +	/delete-property/ interrupts;
> +	interrupts-extended =3D <&intc GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
> +			     <&tlmm 64 IRQ_TYPE_EDGE_FALLING>;
> +
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-1 =3D <&qup_uart1_sleep_cts>, <&qup_uart1_sleep_rts>, <&qup_uar=
t1_sleep_tx>, <&qup_uart1_sleep_rx>;
> +
> +	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "qcom,wcn3991-bt";
> +		vddio-supply =3D <&pm6350_l11>;
> +		vddxo-supply =3D <&pm6350_l7>;
> +		vddrf-supply =3D <&pm6150l_l2>;
> +		vddch0-supply =3D <&pm6150l_l10>;
> +		swctrl-gpios =3D <&tlmm 69 GPIO_ACTIVE_HIGH>;

[Severity: Low]
Does this property need to be added to the dt-bindings?

When running make dtbs_check, the swctrl-gpios property here fails validati=
on
because it isn't documented in the qcom,wcn3990-bt.yaml schema. Since the
schema enforces unevaluatedProperties: false, the build generates a warning.

The hci_qca driver parses this property correctly at runtime, so there
isn't a functional issue, but should the binding schema be updated to avoid
the validation warning?

> +		firmware-name =3D "crnv32u.bin";
> +	};
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-pdx213-ups=
tream-3-v2-0-b4612e3eb536@erebion.eu?part=3D5
