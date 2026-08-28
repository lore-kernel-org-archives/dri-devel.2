Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7E7C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127EE10F3DB;
	Fri, 28 Aug 2026 14:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MTlgD2uc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B9910F3DB
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:10:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6874A40496;
 Fri, 28 Aug 2026 14:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3071F000E9;
 Fri, 28 Aug 2026 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787926232;
 bh=kN/aO+fEV+5N9m7w1YSrShQLZqxSBlJh3DH/IOCjG6M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MTlgD2ucg9538IPQCaIqu+jzGJiJf3pPRHEl0J4hYYqWpdaTIzAEKRWMP1OpsHSAk
 a4QoWvLrz4jJWFLMU3E9hfNH5yj8XJk1byyzvK1++hwliVUdgj05opE2mNr1CCRRqV
 u+ptIUJ2sgd602am15eLKHt9uZuJvUdUlA0RSBl3bnxMfoMJVH5dPsSy7BYS/86dv8
 dRIS9eLC+gfik4ZUd2smLI/b0IgME6RTRfPaYW/VO5cOUgbL5p33I5hR85WGqlIcsi
 EzU5fBz1Q30GYYir3BzpwaM+qGzVEbT7aY7ts/92DAoxfhw7+6icnzVG3UyedecRv8
 Fmi7kMLfE+NMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC/DO NOT MERGE 06/12] dt-bindings: display/msm:
 eliza-hdmi-phy: Add Eliza HDMI PHY
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: robh@kernel.org, vkoul@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, olteanv@gmail.com, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, linux-phy@lists.infradead.org
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-6-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-6-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:10:31 +0000
Message-Id: <20260828141031.CF3071F000E9@smtp.kernel.org>
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
- [Low] Devicetree unit address mismatch in schema example.
--

commit 2063c7e805b5b72143440af38f64d666c647dad5
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

dt-bindings: display/msm: eliza-hdmi-phy: Add Eliza HDMI PHY

This commit adds the device tree binding for the Synopsys HDMI PHY found on
the Qualcomm Eliza SoC. It documents the required properties and provides an
example device node.

> diff --git a/Documentation/devicetree/bindings/phy/qcom,eliza-hdmi-phy.ya=
ml b/Documentation/devicetree/bindings/phy/qcom,eliza-hdmi-phy.yaml
> new file mode 100644
> index 0000000000000..764fec0ef29bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,eliza-hdmi-phy.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,eliza-dispcc.h>
> +    #include <dt-bindings/clock/qcom,eliza-tcsr.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +
> +    hdmi-phy@9a0600 {
> +        compatible =3D "qcom,eliza-hdmi-phy";
> +        reg =3D <0x0aea1000 0x1000>;

[Severity: Low]
Does this unit address in the node name mismatch the first address in the
reg property?

Running make dt_binding_check will likely trigger a unit_address_vs_reg
warning regression because the node is named hdmi-phy@9a0600 but its reg
property sets the base address to 0x0aea1000.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-drm-msm-hd=
mi-eliza-v1-0-67843277de17@oss.qualcomm.com?part=3D6
