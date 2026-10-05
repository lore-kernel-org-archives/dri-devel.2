Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D6CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53DB10EBC8;
	Mon,  5 Oct 2026 07:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a6bX2wkZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B8610EBC8
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:30:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1192040047;
 Mon,  5 Oct 2026 07:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55801F000FF;
 Mon,  5 Oct 2026 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791185456;
 bh=B67tVQ7h6pfh19O8cSKSRT4hoyZ6AtWBqomZfcAhMmo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a6bX2wkZg1smFBjHK4WAOyYxkmGz0ph3A2FmST3qm8r5VvoWy83qeINu+3LoyYCdO
 FVKJ4exyj6pqY2xIhcLbNhrhWo62nHks88CtXHLUJTPn7yf2nsejEWLWOBdOhVZjML
 fy+d/9pWeXnEH7ll4r4o3IoYznoVUSTpnpKGS5uHlrx0uVjxtfTX9ZJm7r+l9A9gQW
 J/ciJ3tZALzf8Rp3X2RdmBKSQzi2LHqBfV5peNrGl5CLmP4kcq6+KMbPEiPDfttC+8
 1ENfCqyCZZkBkp6Cs0ygG1/VP793Y1lfDjJoW6lfNeW4zyYMuIHFUMw9XRX6t85Kmi
 zxUmTi/8N8Jgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: display/msm: dp-controller: Add Kaanapali
To: "Balaji Kalkonda" <balaji.kalkonda@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261005-kaanapali_dp-v1-1-6faeac3a6d59@oss.qualcomm.com>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-1-6faeac3a6d59@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 07:30:55 +0000
Message-Id: <20261005073056.A55801F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: display/msm: dp-controller: missing conditional constr=
aints for Kaanapali
--

commit 120c2a5db230d526e6a48bd35eae767dbf9663c7
Author: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>

dt-bindings: display/msm: dp-controller: Add Kaanapali

Add DisplayPort controller for Qualcomm Kaanapali SoC which so far looks
fully compatible with earlier SM8650 variant.

> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.=
yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb779..8bb0f6e15942f 100644
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

[Severity: Low]
Does this new compatible string cause a regression by bypassing the stricter
hardware constraints defined for the SM8650 variant?

The commit message states the Kaanapali SoC looks fully compatible with the
earlier SM8650 variant. However, qcom,kaanapali-dp is added as a standalone
enum item without being added to the existing conditional constraints.

Should qcom,kaanapali-dp also be included in the allOf conditional block for
qcom,sm8650-dp to enforce the reg property constraints:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,sm8650-dp
    then:
      properties:
        reg:
          minItems: 5

Without being added to this enum array, running make dt_binding_check on a
device tree containing qcom,kaanapali-dp with fewer than the required 5 reg
items or 6 clocks could silently pass schema validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-kaanapali_=
dp-v1-0-6faeac3a6d59@oss.qualcomm.com?part=3D1
