Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD66C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150F110E3D5;
	Fri, 11 Sep 2026 15:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kuL64Pzy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6F810E2EB
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:48:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7537960202;
 Fri, 11 Sep 2026 15:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5BC1F000FF;
 Fri, 11 Sep 2026 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789141682;
 bh=29OprxAPqi5wkQdmCwOPfHZCMWnAwiooD7Yj6cqzeLg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kuL64PzyQOhfjeyezsUmcH6IbvRMFPwATuvG3P31zI/l3c0nPO4f59yuJ/2NwvU/W
 OnwJY1mu/xY3ohQeoN/KHbQKe7Z+08uxQwmPB1icFTlyaS1VKJeTzalXlZ5XVnulDa
 kUbe0utMqcVxlg2gUEzBsl0OINE5QFfbyP2793r/hGcCa1/5HzeQxoMKnAQTwwcOSZ
 7xYaw2NmTlOo3xJNWgf/fOtd/oQpjIlv2sl7YalwpvMoVUu7e8Rq+i7paYSMsgmMc/
 /ieOdOVDS5gnDZULosHgqAFC4VA7m18Hei41pZHDH0nt1r6gtNDKmycLN0ByMxBuZL
 KOo0bXsrRCnxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/17] dt-bindings: phy: qcom,edp-phy: Document Nord eDP
 PHY
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260911-nord-drv-dt-v1-1-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-1-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:48:01 +0000
Message-Id: <20260911154801.7D5BC1F000FF@smtp.kernel.org>
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
- [Medium] The new compatible string 'qcom,nord-dp-phy' is omitted from the=
 'allOf' conditional block that enforces the 3-clock constraint, causing it=
 to fall back to the incorrect 2-clock constraint.
--

commit 325c210ca82765c8807b8dc10d9ca6c4f986b06b
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

dt-bindings: phy: qcom,edp-phy: Document Nord eDP PHY

This commit adds the compatible string for the eDP PHY found on the
Qualcomm Nord SoC.

> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Do=
cumentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index 0bf8bf4f66acf..91d7a5c8e19af 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -19,6 +19,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,glymur-dp-phy
> +          - qcom,nord-dp-phy

[Severity: Medium]
Will this compatible string incorrectly fall back to the 2-clock constraint?

Looking at the allOf block later in this file, recent hardware generations
requiring 3 clocks are explicitly enumerated:

allOf:
  - if:
      properties:
        compatible:
          enum:
            - qcom,glymur-dp-phy
            - qcom,sa8775p-edp-phy
            - qcom,x1e80100-dp-phy
    then:
      properties:
        clocks:
          minItems: 3
          maxItems: 3
    else:
      properties:
        clocks:
          minItems: 2
          maxItems: 2

Since the Nord PHY utilizes a 38.4 MHz CXO reference clock, should
qcom,nord-dp-phy be added to the enum in the allOf conditional block?

Without it, device trees providing the necessary 3 clocks (aux, cfg_ahb, re=
f)
might fail schema validation, while incomplete ones providing only 2 clocks
could silently pass via the else fallback.

>            - qcom,sa8775p-edp-phy
>            - qcom,sc7280-edp-phy
>            - qcom,sc8180x-edp-phy

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-nord-drv-d=
t-v1-0-e25c073cf1b6@oss.qualcomm.com?part=3D1
