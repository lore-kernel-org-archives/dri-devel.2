Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03B8C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0544810E597;
	Mon,  3 Aug 2026 10:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="maiJofX8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DA010E597
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 10:00:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF9AC60A84;
 Mon,  3 Aug 2026 10:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139691F000E9;
 Mon,  3 Aug 2026 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785751235;
 bh=vhIiPuKdiD99XKyI/KBKLbn1uwcu23QsuHv1LIMGDFg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=maiJofX8yRBwhKcCJUfu8VGSPiEZnZtQI676esJUgDVBS/H/KYNXPotUshMueL/4q
 oPpGDD+/YteRveNmnTM7r43xtQS7S2KOqF/HWFge8tEKPvkqoCfBFxSQkN8yOgWmGx
 jXcGfaADwUJf1ltHf5/kuD0dJJZsVqXzSjX01YxCGVlOnKLQJK4SV5rfRLuZqdRX2j
 ep4cSDlzlax0LaWtchss08x6mm8ZjeTgc/rv50UTbOrh2yQ1/Y5JyDmfe+NQccxF7X
 BHofYFK8BX9An5B9gweamLdNMscIrfsV5DhsH2gHTi8Ti6SjTZIep+DnL2TiFpy1ob
 5juCnDe+RF0Pw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 6/6] arm64: dts: rockchip: rk3576-rock-4d: enable
 NPU
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260803094125.3285895-7-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
 <20260803094125.3285895-7-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:00:34 +0000
Message-Id: <20260803100035.139691F000E9@smtp.kernel.org>
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
- [Medium] The `vdd_npu_s0` regulator is forcibly kept `regulator-always-on=
`, defeating runtime dynamic power management for the NPU.
- [Medium] The patch only enables the first NPU core (`rknn_core_0`), leavi=
ng the second symmetric NPU core (`rknn_core_1`) disabled.
--

--- Patch [6]: [RFC PATCH v4 6/6] arm64: dts: rockchip: rk3576-rock-4d: ena=
ble NPU ---
commit 2ef1c8164923c68f245bae8c6ee995f5fd70d4d3
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576-rock-4d: enable NPU

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D and supply the
core from vdd_npu_s0.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64=
/boot/dts/rockchip/rk3576-rock-4d.dts
> index 272af1012ab03..965e0906bd07e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts

[ ... ]

> @@ -442,6 +442,7 @@ regulator-state-mem {
>  			};
> =20
>  			vdd_npu_s0: dcdc-reg2 {
> +				regulator-always-on;

[Severity: Medium]
Does keeping this regulator always-on defeat runtime dynamic power manageme=
nt
for the NPU?

The regulator will remain permanently powered, leading to unnecessary power
drain when the NPU is idle. Could we remove regulator-always-on and instead
assign this as the domain-supply for the NPU power domain so the generic
power domain framework can dynamically toggle the voltage?

>  				regulator-boot-on;
>  				regulator-enable-ramp-delay =3D <400>;
>  				regulator-min-microvolt =3D <550000>;

[ ... ]

> @@ -869,3 +870,12 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>  		remote-endpoint =3D <&hdmi_in_vp0>;
>  	};
>  };
> +
> +&rknn_core_0 {
> +	npu-supply =3D <&vdd_npu_s0>;
> +	status =3D "okay";
> +};
> +
> +&rknn_mmu_0 {
> +	status =3D "okay";
> +};

[Severity: Medium]
Is there a reason to only enable the first NPU core (rknn_core_0) and leave
the second symmetric core (rknn_core_1) disabled?

Since both cores share the same voltage supply and power domains, leaving
rknn_core_1 and rknn_mmu_1 disabled limits the board to half of its
physical AI compute capacity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803094125.3285=
895-1-gahing@gahingwoo.com?part=3D6
