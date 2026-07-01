Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC15C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D8810E382;
	Wed,  1 Jul 2026 12:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k+QFUUL9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1FE10E382
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:27:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7611041458;
 Wed,  1 Jul 2026 12:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D031B1F000E9;
 Wed,  1 Jul 2026 12:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782908876;
 bh=dpF9Ah1JqyA2hm8UXbH4GPZaMqGAhXDZ4O8SylEiMng=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k+QFUUL9JXDqsqKPuAfY73B6jmndK1V70+CX+wbbOx/fnUG2a3kMHKi0/YVgv3lGc
 kykBN5IdWMHa7DZa4vTFxUovhg82L7M8HlumInPcJJIf1AM5asCAW2UcpuP0fDr5Bp
 prZMHpOzVi1ZrADzGutugmmu9uJTLb9HnGbfvpdhUxcaIslsyLUO8/8atK/ri18mZ8
 AmtzHIJ1iyQGaxaeoFRJuAGmo/ZdrhFm8sDKkG6gBh12Kgj/UQRtUqQgmLex7ZYnfq
 3YN88/QiP/Q5ar7IV7hXqqRlElX+HNXFVRi/7f5ss6UUELHgl42sN7Vug11iAgEpOW
 UAN2HiMu9kHfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: phy: Document MT8195 and MT8196
 DisplayPort PHYs
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20260701122008.19509-2-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:27:55 +0000
Message-Id: <20260701122755.D031B1F000E9@smtp.kernel.org>
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
- [Low] The device tree example will fail `make dt_binding_check` validatio=
n due to a 64-bit `reg` property at the root level without `#address-cells =
=3D <2>` and `#size-cells =3D <2>`.
--

commit c7b476cde050e045aaa56bae9dd7ecc7b3d34ced
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
dt-bindings: phy: Document MT8195 and MT8196 DisplayPort PHYs

This adds bindings for the DisplayPort and Embedded DisplayPort PHYs found =
in
the MediaTek MT8195 and MT8196 SoCs. The PHY supports varying impedance
calibrations for the signals to reach an optimal EYE signal pattern.

> diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy=
.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
> new file mode 100644
> index 0000000000000..5847963a7085e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml

[ ... ]

> +examples:
> +  - |
> +    phy@1c500000 {
> +        compatible =3D "mediatek,mt8195-dp-phy";
> +        reg =3D <0 0x1c500000 0 0x2000>;

[Severity: Low]
Looking at the examples section in mediatek,mt8195-dp-phy.yaml, will this
example pass make dt_binding_check validation? The reg property contains 4
cells, but since the example node is at the root level without a parent node
explicitly defining #address-cells =3D <2> and #size-cells =3D <2>, the dum=
my
root node defaults to 1 for both. This causes the 4 cells to be parsed as 2
separate items, which violates the schema's maxItems: 1 constraint.

> +        #phy-cells =3D <0>;
> +        nvmem-cells =3D <&edp_glb_bias_trim>, <&edp_clktx_impsel>,
> +                      <&edp_imp_ln0_pmos>, <&edp_imp_ln0_nmos>,
> +                      <&edp_imp_ln1_pmos>, <&edp_imp_ln1_nmos>,
> +                      <&edp_imp_ln2_pmos>, <&edp_imp_ln2_nmos>,
> +                      <&edp_imp_ln3_pmos>, <&edp_imp_ln3_nmos>;
> +        nvmem-cell-names =3D "rbias-trim", "impedance-txclk",
> +                           "impedance-lane0p", "impedance-lane0n",
> +                           "impedance-lane1p", "impedance-lane1n",
> +                           "impedance-lane2p", "impedance-lane2n",
> +                           "impedance-lane3p", "impedance-lane3n";
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D1
