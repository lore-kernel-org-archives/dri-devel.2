Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636E3CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9E410EBA4;
	Thu, 15 Oct 2026 10:04:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F646112283
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:04:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 937A643D0E;
 Thu, 15 Oct 2026 10:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC71F000C4;
 Thu, 15 Oct 2026 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792058669;
 bh=9wBXPiPpsM5S4pDhacY+LOYtxoybPRSvF4O1rUoMmq0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JigtQVFXI6oHkI5XLlRg8ckwbmqwONSAf5cN+gItEecNdVNr/bXsBiEtyvgoO/W96
 rDleTN1J7ahuS5Sjqj//TAK+vlcPg2sskLglBSh8ajo06iMCoa7pqA6Xyskx11e3oY
 71svCeR5s1scXbK7u0qXniNpVIr62TvC6I9mfR3vHqbJvG2j54G7cXdARF/55SDRoe
 dJJH3TuN2Cd2BYdw+l4EUMhUYassFH/xZR5kguiSD9OzySblcjTZd7fdVTsIxhSFK0
 U4UFX1HLOOJ6FsDrE6KglCGYkBHvI6XHjDh9qLcNYt/kP3iCbcFybpBsM2sBAzeRaj
 p3jFQIvADB2fg==
Message-ID: <sashiko-outbox-172624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display/msm: dp-controller:
 Document Kaanapali
To: "Balaji Kalkonda" <balaji.kalkonda@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261015-kaanapali_dp-v2-1-c15cb83d9140@oss.qualcomm.com>
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
 <20261015-kaanapali_dp-v2-1-c15cb83d9140@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 10:04:28 +0000
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
- [Medium] dt-bindings: qcom,kaanapali-dp omitted from existing conditional=
 blocks
- [Medium] dt-bindings: missing additionalProperties in patternProperties
--

commit 98068de5d2fca0abb41ef1fecd6b1707d8f24f5d
Author: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>

dt-bindings: display/msm: dp-controller: Document Kaanapali

This commit adds device tree binding documentation for the DisplayPort
controller on Qualcomm Kaanapali. It introduces a new compatible string
and adds constraints for its five register ranges and six clocks.

> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.=
yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb779..0240e3c1a6d9d 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -19,6 +19,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,glymur-dp
> +          - qcom,kaanapali-dp
>            - qcom,sa8775p-dp
>            - qcom,sc7180-dp
>            - qcom,sc7280-dp

[Severity: Medium]
Does this inadvertently restrict Kaanapali from declaring an aux-bus?

Because qcom,kaanapali-dp is omitted from the existing aux-bus conditional
block, it falls into the else clause which forces aux-bus: false:

      if:
        properties:
          compatible:
            contains:
              enum:
                - qcom,glymur-dp
                - qcom,sa8775p-dp
                - qcom,x1e80100-dp
      then:
        $ref: /schemas/sound/dai-common.yaml#
        oneOf:
          - required:
              - aux-bus
          - required:
              - "#sound-dai-cells"
      else:
        $ref: /schemas/sound/dai-common.yaml#
        properties:
          aux-bus: false

This incorrectly restricts valid device trees that declare an aux-bus.

[ ... ]

> @@ -290,6 +291,24 @@ allOf:
>            minItems: 6
>            maxItems: 6
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,kaanapali-dp
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +          maxItems: 5
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +        clock-names:
> +          minItems: 6
> +          maxItems: 6
> +

[Severity: Medium]
Could this conditional block be merged with the existing block that has
identical constraints?

The constraints specified here (5 reg items, 6 clocks) exactly match the
existing block for 2-stream MST platforms (qcom,sc8180x-dp, qcom,sdm845-dp,
qcom,sm8350-dp). Reusing the existing block would avoid duplicating schema
constraints.

> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali=
-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-m=
dss.yaml
> index 9f935defd6b12..83e3596ba0ed9 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.y=
aml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.y=
aml
> @@ -48,6 +48,12 @@ patternProperties:
>        compatible:
>          const: qcom,kaanapali-dpu
> =20
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: qcom,kaanapali-dp
> +

[Severity: Medium]
Does this object definition need additionalProperties: true or
unevaluatedProperties: false?

The dtschema meta-schema requires one of these properties for object nodes
to dictate how unlisted properties are handled. Without it, make
dt_binding_check reports a meta-schema validation error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-kaanapali_=
dp-v2-0-c15cb83d9140@oss.qualcomm.com?part=3D1
