Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CDBC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2001710E5CA;
	Tue, 15 Sep 2026 09:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kSujiUsR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6ADA10E5CA
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:36:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A17F6416B9;
 Tue, 15 Sep 2026 09:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380F81F000FF;
 Tue, 15 Sep 2026 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789465014;
 bh=Dyo5Lc1AOpB/dSDhID1emqrb50oYcSN1kaZpw8kGh2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kSujiUsRfj7NfjOWvaSnfIrScJPFlw9cHx066vI+Dtnn1fookrZhuYn7lJ49LcNP/
 WhXlsFJ0bsn9iP5R+3ePNSOS3342cOyddORuvCVJLj4SZQOttHJ7vtJyiZw+IreWR/
 6GEta2RKC3r9wcnG0u6fTzbrbjKzjVSh22bw3FLZbHPyC57tMaz5YHmN6VODs/OX26
 5PxIrrVApK7VJOyDSFRogYfmQUZR0meSfuWWxl9KduX/OpwaAPQzikF3nPacmF26aZ
 R5WQ6E/7GJotokgEuxmg9Cu9FfLMk7f6uqkdZr2ajBhqAj7xJ1Dnqu2GOUEl7Hvr8n
 1yacrchuinGUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 09:36:53 +0000
Message-Id: <20260915093654.380F81F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: missing INT2 power domain in Kaanapali MDSS example
--

commit fc3449e10374106de27dd1a562563cdee9c4085f
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

dt-bindings: display: msm: Add INT2 GDSC to Kaanapali DPU

Kaanapali (SM8850) has an additional INT2 GDSC that powers a subset
of the DPU source pipes (VIG2/VIG3/DMA5), on top of the CORE_GDSC
that powers the rest of the MDSS hardware. This commit describes INT2 GDSC
as an additional power domain of the DPU device rather than of the whole
MDSS and restricts the schema change to the Kaanapali DPU compatible.

> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dp=
u.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> index aa0cf0ec5b93f..88aa71d2b9120 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
[ ... ]
> @@ -61,6 +61,29 @@ required:
>    - clocks
>    - clock-names
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kaanapali-dpu
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: MMCX power domain
> +            - description: INT2 GDSC power domain
> +
> +        power-domain-names:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - const: mmcx
> +            - const: int2
> +
> +      required:
> +        - power-domain-names

[Severity: Low]
Does this new requirement break the example in the qcom,kaanapali-mdss
binding?

The example in=20
Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
defines a display-controller node with compatible =3D "qcom,kaanapali-dpu"
but only provides one power domain:

        display-controller@9801000 {
            compatible =3D "qcom,kaanapali-dpu";
            ...
            power-domains =3D <&rpmhpd RPMHPD_MMCX>;

Since the new constraints require two power domains and power-domain-names
for this compatible string, should the example be updated to avoid failing
the make dt_binding_check validation?

>  unevaluatedProperties: false
> =20
>  examples:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-msm_gdsc2-=
v2-0-9157237b8382@oss.qualcomm.com?part=3D1
