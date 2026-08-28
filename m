Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07028C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6891610F3C8;
	Fri, 28 Aug 2026 14:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z95+DI1k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AD010F3C3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:12:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEE9D60200;
 Fri, 28 Aug 2026 14:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF821F000E9;
 Fri, 28 Aug 2026 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787926343;
 bh=ewEW/PbNGvzn1mLO4IM8foHLLqLhEziZuJ945iu1y9o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z95+DI1kY1t1hEizLC77OsvXF2Y2MZ7xNPwX96xPqJZsokkQKDSoicQqhVRv+5uAr
 39N8h5wKR7kAHr9y2b6TLyf4w2RuqBJVGDPJcco6zBG5joE5+cdIAsRNWjxsgxJfwo
 SdSZIxisppc7eBGDehEe20RZQ4jzvV5Zblxj7bFsgRy1/cPlqyhiFNpuh0Dl6MOabS
 Pe9lT4u5GAlQXdPbEMwhpemfbjzQr29oO2DHol4Ecc6n6tB57ljpYK6BP2RhfcDnUO
 CmxK4520PxhL0/ydcXRj82Gxu2zh6tnkUOuDLkf1xBVPFInnWC3cG6OKr8gvqgcVdX
 TT4c/NToXeTbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC/DO NOT MERGE 05/12] dt-bindings: display/msm: hdmi:
 Add Eliza HDMI TX
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: olteanv@gmail.com, robh@kernel.org, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, vkoul@kernel.org
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-5-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-5-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:12:22 +0000
Message-Id: <20260828141223.1BF821F000E9@smtp.kernel.org>
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
- [Medium] The conditional `if` block for the new Eliza HDMI TX device uses=
 an incorrect compatible string with a duplicated vendor prefix ('qcom,qcom=
,eliza-hdmi-tx'), preventing the schema constraints from being applied.
--

commit 95836f68df5245b7dc121437b6c3df3442b5e4f8
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

dt-bindings: display/msm: hdmi: Add Eliza HDMI TX

Qualcomm Eliza SoC comes with HDMI IP block, built on top of one
previously present in MSM8998.  There are just a few differences in
hardware, mostly about handling clock reparenting, but more notable the
old binding looked incomplete, thus devices could not be considered
compatible.

> diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Do=
cumentation/devicetree/bindings/display/msm/hdmi.yaml
> index 02d27ccad0247..6adaa095b7473 100644
> --- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
[ ... ]
> @@ -159,6 +180,44 @@ allOf:
>              - const: bus
>              - const: mnoc
>              - const: iface_mmss
> +        reg-names:
> +          minItems: 1
> +          items:
> +            - const: core_physical
> +            - const: qfprom_physical
> +            - const: hdcp_physical
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcom,eliza-hdmi-tx

[Severity: Medium]
Does this compatible string contain a duplicated "qcom," vendor prefix?

It appears that this should be "qcom,eliza-hdmi-tx" to match the compatible
string defined in the properties section and the example. With the duplicat=
ed
prefix, this conditional block will not match, causing the constraints for =
the
clocks, reg, and required properties defined in the "then" block to be
bypassed during dtbs schema validation.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +          maxItems: 6

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-drm-msm-hd=
mi-eliza-v1-0-67843277de17@oss.qualcomm.com?part=3D5
