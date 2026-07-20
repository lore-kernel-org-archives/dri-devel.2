Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CC7C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B5B10E7F7;
	Mon, 20 Jul 2026 08:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XHLmP9Wa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCCC10E7F7
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:54:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F50140DF3;
 Mon, 20 Jul 2026 08:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF11F000E9;
 Mon, 20 Jul 2026 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784537661;
 bh=quVci2ZBy1nQdJekMgUBPhrmXSTEgfl9sAwvLwmRGdE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XHLmP9WaxUuk9geVPZ92L77WT2ThOwgAvHLlsoYMpfmlK0VimRoXRQVa2ZVHkdpYU
 QoPmXo1dQsnH01AOMHR4wzG6MrsNUPT2cJUe8E63ZI2SExQNTkhHvgonBPxjaEg5/e
 uLJYvDRKwZnfUP5tTKRxu+VrkbYfiuOx34y3shD484fteuM7NZqTxls9rK8BoypE+g
 qxlrUkuiVftSA4GFKu8DpCQXUEtEjrEsB+yvYgB+AWdVIgocT99dWLSu4M66Yqip0y
 xo7e2BFOZmADV2L4yu2DlRfDgfUxJNS0o3vNVKOtYcHGZzvbZJuZNC9BnLIKqHYHq2
 THwlKJkAQcD1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:54:20 +0000
Message-Id: <20260720085420.E0CF11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Relaxing the global maximum number of `power-domains` in `mdss-c=
ommon.yaml` without restricting legacy schemas allows invalid device trees =
to pass validation.
- [Medium] Missing `power-domain-names` in the `required` list allows incom=
plete device trees to pass validation.
- [Medium] Adding an items array to `power-domains` implicitly sets `minIte=
ms: 2`, breaking backward compatibility for existing device trees.
--

--- Patch [1]: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power =
domains ---
commit 3afe59087bba460fdef9d8666ba4cb4a97273b44
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

dt-bindings: display: msm: Allow two MDSS power domains

Kaanapali (SM8750) and Glymur use two display power domains.
CORE_GDSC powers the main display hardware while INT2_GDSC
powers a subset of SSPP blocks.

Allow the MDSS bindings to describe both power domains and
their corresponding power-domain-names values.

> diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.ya=
ml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> index c6305a6e03346..c0b650ffd9ef8 100644
> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> @@ -31,7 +31,8 @@ properties:
>      const: mdss
> =20
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

[Severity: Medium]
When we relax the global maximum number of power-domains here, does this al=
low
invalid device trees to pass validation for legacy platforms?

For example, schemas like qcom,sm8550-mdss.yaml include this common schema
but only have 1 hardware power domain. Without explicitly overriding
maxItems to 1 in those legacy schemas, they might silently accept invalid
device trees with 2 power domains.

> =20
>    clocks:
>      minItems: 2
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,glymur-md=
ss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.ya=
ml
> index 64dde43373ac7..685bedb26a124 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
[ ... ]
> @@ -38,6 +38,16 @@ properties:
>        - const: mdp0-mem
>        - const: cpu-cfg
> =20
> +  power-domains:
> +    items:
> +      - description: MDSS core GDSC power domain
> +      - description: MDSS INT2 GDSC power domain

[Severity: Medium]
Does adding this items array implicitly set minItems to 2 during dt-schema
evaluation?

If so, this might break backward compatibility for older device trees that
only specify a single power domain. Should minItems: 1 be explicitly
specified here?

> +
> +  power-domain-names:
> +    items:
> +      - const: core
> +      - const: int2

[Severity: Medium]
If a device tree specifies 2 power domains but omits power-domain-names,
will it pass schema validation?

The driver might fail to probe at runtime when attempting to attach power
domains by name. Should power-domain-names be conditionally required in the
required list (using an if-then block) when multiple power domains are
provided?

> +
>  patternProperties:
>    "^display-controller@[0-9a-f]+$":
>      type: object
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali=
-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-m=
dss.yaml
> index 9f935defd6b12..088010f464c3d 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.y=
aml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.y=
aml
[ ... ]
> @@ -40,6 +40,16 @@ properties:
>        - const: mdp0-mem
>        - const: cpu-cfg
> =20
> +  power-domains:
> +    items:
> +      - description: MDSS core GDSC power domain
> +      - description: MDSS INT2 GDSC power domain

[Severity: Medium]
Similar to the glymur binding, does this items array implicitly set minItems
to 2 and break backward compatibility?

> +
> +  power-domain-names:
> +    items:
> +      - const: core
> +      - const: int2

[Severity: Medium]
Also similar to the glymur binding, should power-domain-names be conditiona=
lly
required to ensure device trees with two power domains provide the necessary
names for the driver?

> +
>  patternProperties:
>    "^display-controller@[0-9a-f]+$":
>      type: object

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-msm_gdsc2-=
v1-0-4687866d6cb0@oss.qualcomm.com?part=3D1
