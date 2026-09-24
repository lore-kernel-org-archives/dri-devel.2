Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA49C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0751D10F7AB;
	Thu, 24 Sep 2026 21:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I1od0Oux";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31EF10F7AB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:22:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F6AD600D4;
 Thu, 24 Sep 2026 21:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B251F000FF;
 Thu, 24 Sep 2026 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790284942;
 bh=/0Q9sDDp9EI9fPGTLUTQtBjm1cZvnFBpCKuPvTLtsgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I1od0OuxdzyhNvK6OgE1hpWppJSzv67HRNjgc7fzO3Ev0lpVDEzaUbspry3kJXu0/
 Shx1OR+WqarBrfDhikTuAujPw0NENGY5JcVBD1Oej4SnQMBIjUKEvh9pUzYLZDI3hX
 9aYNI8bWwkLzZ7hOX38aAeD9EwohxU1f1KxQw6EumQNhZKMDR1LabZooR+5nVd7eQB
 f2lBIr/PfS9RJvZpWlLVlBeP55lF0ykxxazqdtmLImahAuVE6EyAFGbBrvIzMrHE7j
 jyDnAULKXi3I1DPgfh7SSq64BmreMVqCeCwFlSxn3t/cr5EeZwVD0B+622LbRPZrlN
 JfTod8jVucTcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: display/msm: gpu: Document Mahua GPU/GMU
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260925-mahua-gpu-v1-4-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-4-0fa0bfd8d315@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 21:22:22 +0000
Message-Id: <20260924212222.76B251F000FF@smtp.kernel.org>
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
- [Medium] dt-bindings: display/msm/gpu: missing compatible string in reg c=
onstraints block
--

commit 31fba47631141728d25d3c820a8da841bf562a70
Author: Jie Zhang <jie.zhang@oss.qualcomm.com>

dt-bindings: display/msm: gpu: Document Mahua GPU/GMU

Adreno X2-85 GPU found in mahua SoC belongs to the A8x family and
is a smaller variant of X2-90 with fewer slices and smaller internal
memories. Update the dt bindings documentation to describe this GPU
along with it's GMU.

> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Doc=
umentation/devicetree/bindings/display/msm/gpu.yaml
> index e5efe2d35ddcc..8a103f998dd87 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -452,6 +452,7 @@ allOf:
>                - qcom,adreno-43051401
>                - qcom,adreno-44010000
>                - qcom,adreno-44050a01
> +              - qcom,adreno-44060000

[Severity: Medium]
Does the new compatible string qcom,adreno-44060000 also need to be added
to the earlier conditional block for the A8x GPU family?

Documentation/devicetree/bindings/display/msm/gpu.yaml:allOf.if
  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,adreno-44010000
              - qcom,adreno-44050a01
              - qcom,adreno-44070001
    then:
      properties:
        reg:
          minItems: 2
          maxItems: 2

Without it, the device tree schema will fail to enforce the correct register
count of exactly 2 regions for the new Adreno X2-85 GPU variant when a devi=
ce
tree node is added with an incorrect number of reg regions. This allows
invalid nodes to silently pass validation.

>                - qcom,adreno-44070001
> =20
>      then: # Starting with A6xx, the clocks are usually defined in the GM=
U node

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-mahua-gpu-=
v1-0-0fa0bfd8d315@oss.qualcomm.com?part=3D4
