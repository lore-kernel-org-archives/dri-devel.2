Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4F2CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFBD10EE0A;
	Mon,  8 Jun 2026 07:13:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kvtSB+ND";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED93910EE0A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:13:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D73B740C0B;
 Mon,  8 Jun 2026 07:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A2E1F00893;
 Mon,  8 Jun 2026 07:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780902806;
 bh=Vet+Yt7W8IpTw3HV2qBEOyNlQqmzaMdonxzrFHRYbdA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kvtSB+NDkTd2a5IsCyMZk0z9OdMYP4rzW5P7bXQUNeI0CxTQAtGVZKuWoJA6m/8v/
 hzyHMWyTEuxHckBPAdTWR02u2ruG35A+sIEYkPiRV4IVe4Bo0oNuAbNyke9Mk9Q5Sb
 HPhLeT2mBJF6VV/ehE5Z/XwmMERzOSbKODtFf6NBgMr6X5hn0zdbEIXGPW+Eh1DEym
 FpDC6srFtqMN2CFnwDFXhpVoqGHl0vqzajvdPZnd2SaL6cYNq20cF+NO77IzJN55rh
 ZpNDBVTPJKClQTaibNHYk/SA6BDXzPigNnAk+gjMACcCAKfiYLmQssnark9J/h+HcC
 q7MWIZBsN/ZwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
References: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:13:26 +0000
Message-Id: <20260608071326.70A2E1F00893@smtp.kernel.org>
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
- [Medium] The compatible string `qcom,qcm2290-dsi-ctrl` (and the newly add=
ed `qcom,shikra-dsi-ctrl` fallback) is missing from the conditional `if-the=
n` constraint blocks in `dsi-controller-main.yaml`, preventing strict valid=
ation.
--

commit 605ca9e1f594a8d64bb53c70c6ef6319fc95eeed
Author: Nabige Aala <nabige.aala@oss.qualcomm.com>

dt-bindings: display: msm: qcm2290: Add Shikra MDSS

Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
the existing qcm2290 bindings to cover Shikra by adding fallback
compatible chains for MDSS, DPU and DSI controller nodes rather
than introducing a separate binding file.

> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller=
-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-m=
ain.yaml
> index a24fcb9144181..08a6668d3ca78 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.y=
aml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.y=
aml
> @@ -46,6 +46,10 @@ properties:
>                - qcom,sm8650-dsi-ctrl
>                - qcom,sm8750-dsi-ctrl
>            - const: qcom,mdss-dsi-ctrl
> +      - items:
> +          - const: qcom,shikra-dsi-ctrl
> +          - const: qcom,qcm2290-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl

[Severity: Medium]
Should qcom,shikra-dsi-ctrl and qcom,qcm2290-dsi-ctrl be added to the
conditional constraint blocks lower down in this file?

Because they are omitted from the conditional blocks governing 6-clock setu=
ps,
the schema falls back to permissive defaults (3 to 12 clocks). This allows
incomplete or invalid device tree nodes for Shikra to silently pass validat=
ion.

While the missing qcom,qcm2290-dsi-ctrl constraint was a pre-existing issue,
adding the new qcom,shikra-dsi-ctrl compatible without ensuring it has stri=
ct
validation introduces this permissive validation bug for the new platform.

The block enforcing these strict limits starts like this:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,msm8998-dsi-ctrl
              - qcom,sa8775p-dsi-ctrl
              - qcom,sar2130p-dsi-ctrl

>        - items:
>            - enum:
>                - qcom,qcs8300-dsi-ctrl

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-shikra-dis=
play-v4-0-88a846afdd5d@oss.qualcomm.com?part=3D1
