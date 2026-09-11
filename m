Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D37C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0662D10F69A;
	Fri, 11 Sep 2026 15:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XQEn/dcr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE5C10F69A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:44:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 569E260202;
 Fri, 11 Sep 2026 15:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6801F000FF;
 Fri, 11 Sep 2026 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789141480;
 bh=auBFuP4M1oTbSDSlKFPaujKZbtuFWziwFPRp58Cg8ZA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XQEn/dcrmZ3An+tqxMC8DqhuKY2jGKE9L5QoL6/jRDfqq+UTb6z6b9OV0W7eB0Tiv
 7Zhk/QfoanUUzsgyMNOxUR+4/flvcUmTof4AEuoyTvC634m96TvR+++piqFCljSyp/
 qH2xU0oq+wL6rMSBj+lvI8WlveZ5VajE7PQWdXBtOgPzpydIuunvmGxzx1G9pCFJbs
 DjI6Q6GICcZWotONY90XCNhdvaKj30wGvC0m+MpZAv3UBfD4NfDmL/jt/gL4zmquJG
 QRKNrfSuTnJ1Yb2P7GMiJIXE/DHLVAPLZT49aM2hNFhzusw1vioXC5HDpqD1bZdCtM
 r3GUNdpq00gmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/17] dt-bindings: display/msm: dp-controller: Document
 Nord DP
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, conor+dt@kernel.org
In-Reply-To: <20260911-nord-drv-dt-v1-2-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-2-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:44:39 +0000
Message-Id: <20260911154439.8E6801F000FF@smtp.kernel.org>
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
- [Medium] Incomplete schema validation due to missing compatible string in=
 conditional blocks
--

commit f7216936b411ed638371618630b9bc9b852888e7
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

dt-bindings: display/msm: dp-controller: Document Nord DP

This commit adds the compatible string for the DisplayPort controller found
on the Qualcomm Nord SoC to the device tree bindings.

> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.=
yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb779..8d980acb1a163 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -19,6 +19,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,glymur-dp
> +          - qcom,nord-dp

[Severity: Medium]
Will this omission cause incomplete schema validation?

When qcom,nord-dp is declared here in properties:compatible, it falls back =
to
the weak top-level minimal constraints because it is entirely omitted from =
the
validation logic in the allOf section.

The allOf block further down the file defines the conditional logic that
strictly validates the register and clock layouts. Shouldn't qcom,nord-dp be
categorized into one of these hardware capability blocks to enforce correct
constraints during dt_binding_check? Without it, incorrect device tree
configurations like incorrect register or clock counts could silently pass
validation.

>            - qcom,sa8775p-dp
>            - qcom,sc7180-dp
>            - qcom,sc7280-dp

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-nord-drv-d=
t-v1-0-e25c073cf1b6@oss.qualcomm.com?part=3D2
