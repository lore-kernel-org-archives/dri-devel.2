Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDDCCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB3E113FE6;
	Thu,  4 Jun 2026 12:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nAOrChVy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F090B113FE5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:42:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6119A60261;
 Thu,  4 Jun 2026 12:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F8C1F00893;
 Thu,  4 Jun 2026 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780576976;
 bh=jD8qpfRVjwx0jAz7MGdrBNzskXrvc6kAcSzecnuB80U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nAOrChVyqMmG9A/O5Omi6+0F3K9Ifze4JGUYtspTFtnFIvPPyQVCFmqZEg4YXUiTh
 uqA03c5uCtUWAqKXxMq9FfmUkqiT4qvd60AvUp111y/aAg3aydH0uiYRFaASD9S92m
 oq6pd/N2skjjsBmzebkvl+VYLRSbFapF8hyRen1bI0cuELfTcNg7yWHrTj335Anlr6
 eRNz8EaT/x84OOmo3VY0JsJN1HF8hpTDjx+F8MPGw+ZMhkng7Ix2FkqogTMxjUCXgs
 0eJA/NnZKWJQzhToSGaI9blYDhVm/F/dgL23w9qx2JkGAhflxoAP9E1vH5DOIiCkYr
 CHVWejSQghSPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260604-shikra-display-v2-1-b3c1b2b67edc@oss.qualcomm.com>
References: <20260604-shikra-display-v2-1-b3c1b2b67edc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 12:42:55 +0000
Message-Id: <20260604124255.C5F8C1F00893@smtp.kernel.org>
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
- [Medium] Unresolvable DT schema contradiction for Shikra DSI compatible s=
trings.
- [Medium] Missing schema conditional constraints for Shikra DSI controller.
--

commit a65ad60044f8d36574550891df31ee37428077f9
Author: Nabige Aala <nabige.aala@oss.qualcomm.com>

dt-bindings: display: msm: qcm2290: Add Shikra MDSS

Shikra SoC uses the same MDSS/DPU/DSI hardware as QCM2290 (DPU 6.5),
sharing the same register layout, DSI controller and 14nm DSI PHY.
Add qcom,shikra-mdss to the qcm2290-mdss binding compatible enum
rather than introducing a separate binding file.

> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller=
-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-m=
ain.yaml
> index dbc0613e427ed..a2f3e91104af3 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.y=
aml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.y=
aml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sdm660-dsi-ctrl
>                - qcom,sdm670-dsi-ctrl
>                - qcom,sdm845-dsi-ctrl
> +              - qcom,shikra-dsi-ctrl

[Severity: Medium]
Should qcom,shikra-dsi-ctrl also be added to the allOf:if conditional
block that enforces clock constraints?

The QCM2290 and Shikra DSI controllers require 6 clocks and
assigned-clocks. While qcom,qcm2290-dsi-ctrl was already missing from
the clock validation block, omitting the newly added qcom,shikra-dsi-ctrl
allows incomplete device tree nodes for Shikra to silently pass validation
without providing the mandatory clocks.

>                - qcom,sm6115-dsi-ctrl
>                - qcom,sm6125-dsi-ctrl

[ ... ]

> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-m=
dss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.=
yaml
> index bb09ecd1a5b4f..7184b09a87749 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml

[ ... ]

> @@ -60,9 +79,14 @@ patternProperties:
> =20
>      properties:
>        compatible:
> -        items:
> -          - const: qcom,qcm2290-dsi-ctrl
> -          - const: qcom,mdss-dsi-ctrl
> +        oneOf:
> +          - items:
> +              - const: qcom,qcm2290-dsi-ctrl
> +              - const: qcom,mdss-dsi-ctrl
> +          - items:
> +              - const: qcom,shikra-dsi-ctrl
> +              - const: qcom,qcm2290-dsi-ctrl
> +              - const: qcom,mdss-dsi-ctrl

[Severity: Medium]
Does this create an unresolvable contradiction for Shikra device tree nodes
during schema validation?

These changes to qcom,qcm2290-mdss.yaml enforce a 3-item compatible string
array for Shikra. However, the earlier change adding qcom,shikra-dsi-ctrl to
dsi-controller-main.yaml places it in an enum block that strictly enforces
a 2-item array.

Could this mismatch prevent valid Shikra nodes from passing validation,
since any configuration valid for one schema will be rejected by the other?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-shikra-dis=
play-v2-0-b3c1b2b67edc@oss.qualcomm.com?part=3D1
