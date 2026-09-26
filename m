Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D25C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 10:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3CE10E096;
	Sat, 26 Sep 2026 10:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iYGjxLr3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEAB10E096
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47AAA6053B;
 Sat, 26 Sep 2026 10:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD8A1F000FF;
 Sat, 26 Sep 2026 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790418622;
 bh=xjVMkw8nqD5MrYP7pxYV+ZJ5fBIUR/d0GIbV9Mhqw+I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iYGjxLr3fgcu314Dn5G4dh8HvQFgD8knmJZtO7owi4GxGkC7WwJjOw55D3yoK9GPa
 Lr1dMoefYYy09H2EcXdK3zcuJrM/JE+7QBSIX4tL0oYGJuPQMp9u/VAEdVS/VOOBkN
 mEoGJBlPA1neoPbmyTXO6IByhuh6Atddho59VnwnxDxTuR2M+4DXNPhega7j+ZJtLp
 r411ZlazbzDtFlKEpMuhBzJI9jiDek6IWKosqLfchNggKLnHXwtlvPuVBhj+TsKefw
 IgiHBNpyI4+8oOFQjDGKyva4eJ9dUJf973T4Ui5xbMCswT+N48ocr/WM8kW/pYcadm
 SkxUx90Pnw2dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sm6350-lena: Enable PMK8350
To: erebion <erebion@erebion.eu>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260926-pdx213-upstream-3-v1-8-1609c18b5c1d@erebion.eu>
References: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
 <20260926-pdx213-upstream-3-v1-8-1609c18b5c1d@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 10:30:21 +0000
Message-Id: <20260926103021.ABD8A1F000FF@smtp.kernel.org>
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
- [Low] dts: unit address vs reg mismatch in pmk8350_vadc channel
--

commit 5d60ecb2f51ba076b9f89e76eff7eec7d8346935
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: Enable PMK8350

Configure and enable nodes for PMK8350 on the Xperia 10 III.

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 265400aa945ba..ddca3caf4a4e5 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts

[ ... ]

> @@ -436,6 +441,31 @@ &pm7250b_vbus {

[ ... ]

> +&pmk8350_vadc {
> +	channel@3100 {
> +		reg =3D <PMK8350_ADC7_AMUX_THM1_100K_PU>;

[Severity: Low]
The node name uses the unit address 3100, but because PMK8350_SID is 6
and ADC7_AMUX_THM1_100K_PU is 0x44, the reg expression (6 << 8 | 0x44)
evaluates to 0x644.

This mismatch triggers a unit_address_vs_reg warning from the device tree
compiler during the build.

Could the unit address in the pmk8350_vadc node name be updated to 644 to
match the evaluated register address?

> +		qcom,ratiometric;
> +		qcom,hw-settle-time =3D <200>;
> +		qcom,pre-scaling =3D <1 1>;
> +		label =3D "xo_therm";
> +	};
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-pdx213-ups=
tream-3-v1-0-1609c18b5c1d@erebion.eu?part=3D8
