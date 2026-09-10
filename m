Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D49C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4142410E5C7;
	Thu, 10 Sep 2026 08:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b9s1ipUC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2795010E5C7
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:34:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DB5060211;
 Thu, 10 Sep 2026 08:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796031F000FF;
 Thu, 10 Sep 2026 08:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789029244;
 bh=9cw27fkaVmFB07acOvjOiu/8R7jib31Qg3vHM/XgxEQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b9s1ipUCTutUg3na3zZBHZQc5r2mdwVOcONaKO06zkEKqTkLW+kiDNwVX1dkP2zwO
 8c6CCO2Q96WjZAdir5ORsqg+oV/wrpQDmWVlKU6LTJ9r82SPpQThyTClZP08sMcThu
 EK17j6hrYQpXMIlLcGCbFuMB9Q+WYwN5jfKsUfnjw9paJ5CyWiobrBkXb/fe/IMdyA
 l2UuJhKNlnv3AFgbtnnh298AUh49QnPF4o03bjUEnxavGXL3OCMvtdjXrBk8kEEcHV
 G4fOgSLIRc2WBHxmPbvBBmbi+9ROBDqd7F5jWb5ORexKQY32BY9m9ZXgXLZj/rKDPR
 3/vg3L4Hm84eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH/RFC 1/3] dt-bindings: gpu: img,powervr-rogue: Document
 R-Car V4H and V4M support
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org
In-Reply-To: <1c2771f8882cde0fde694b9f5aae50c02a2ae4cb.1789028076.git.geert+renesas@glider.be>
References: <cover.1789028076.git.geert+renesas@glider.be>
 <1c2771f8882cde0fde694b9f5aae50c02a2ae4cb.1789028076.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 08:34:04 +0000
Message-Id: <20260910083404.796031F000FF@smtp.kernel.org>
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
- [Medium] The newly added compatible string `img,img-axm-8-256` is omitted=
 from the `power-domains` conditional block, allowing incomplete device tre=
e nodes to silently pass validation.
--

commit 2124d2433f8e144a72392a5dd4a2382c06e9682a
Author: Geert Uytterhoeven <geert+renesas@glider.be>

dt-bindings: gpu: img,powervr-rogue: Document R-Car V4H and V4M support
   =20
The Renesas R-Car V4H SoC integrates an Imagination Technologies IMG
AXM-8-256 GPU, while R-Car V4M integrates an Imagination Technologies
IMG BXS-4-64 GPU.  Both variants can generate 8 interrupts.

> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index e9218e0f363d1..9bea037602c13 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -35,6 +35,11 @@ properties:
>            # work with newer dts.
>            - const: img,img-axe
>            - const: img,img-rogue
> +      - items:
> +          - enum:
> +              - renesas,r8a779g0-gpu
> +          - const: img,img-axm-8-256
> +          - const: img,img-rogue

[Severity: Medium]
Does the newly added img,img-axm-8-256 compatible string need to be included
in the power-domains conditional block?

Looking at the allOf/power-domains constraints further down in
Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml, the existing
block requires two power domains for similar hardware:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - img,img-bxs-4-64
              - img,img-ge7800
              - img,img-gx6250
    then:
      properties:
        power-domains:
          minItems: 2
        power-domain-names:
          minItems: 2
      required:
        - power-domains
        - power-domain-names

If a developer compiles a device tree using renesas,r8a779g0-gpu without
providing the required two power domains, will the dtbs_check tool process
the device tree without flagging the omission?

Should this enum list be updated to include img,img-axm-8-256 to correctly
enforce the two power domains requirement for the R-Car V4H hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789028076.gi=
t.geert+renesas@glider.be?part=3D1
