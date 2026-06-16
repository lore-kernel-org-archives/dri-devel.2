Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F75CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D0810ECE2;
	Tue, 16 Jun 2026 18:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="mMXCNUNW";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVsXPiOA";
	dkim-atps=neutral
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1796210ECE2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:28:07 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D51697A0178;
 Tue, 16 Jun 2026 14:28:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 16 Jun 2026 14:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781634485;
 x=1781720885; bh=VC7DCe11ZyrzA2G7vkYOQT1GcSliXObtOSZKwBmMzRo=; b=
 mMXCNUNWUNg65wsus5Oisk4uOqeWdq87vg0PeR9Xz2Fn4JjPraVN1PFC+aGrNxDS
 BBmiaOvXAl+ILHZng+aRU/XnPR2DJQde5J1zN9fet7S0If4HnH68XXkzTSlBYXw9
 2hFUAJffe3nL0Hld/Vm8erzHgcExKPUjLp0xokmd0eOhENfNacCAzWQPLhr5J+2c
 jOoDOozEJAfF/oLdVepx7V/Uf3axTCJps25FnL1FapYhdKHJGoDVicZuiCAyJ2dN
 1zsEhsOJ8OxCOdLiH+vCQoRsd3tWuXQyavnifdh4G921DbRNmHcB5KvQrpaoAdat
 J33fusBM+G9kXLlri87GKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1781634485; x=1781720885; bh=V
 C7DCe11ZyrzA2G7vkYOQT1GcSliXObtOSZKwBmMzRo=; b=VVsXPiOAWff6HReYo
 7U+j2lc3tJeL9fb0eflW8kxp5Dvqez2Q1UgrGMDACP57morRDwXXMvKy4SF4qzr+
 x/NrBvThFgDo8eC8tDyELb5KEn1JVRTe6uydpy/eP7u6uwPbtYGbI7dVhiv7sEFw
 VAIEqBG8tTgFGg4KcD3g/GEfM3s4Gmin38q8DG33I++zgcoEwjLd9sOd1DjY259j
 QLGBBVvkichLTXCLcC9YYjQzBv/IpCOghGNud/MjzML3iQVn6AqMMpzwc+1CJ5jY
 d8+1YpDFuLIFR9yVI7u0X8rMXIkcBugEiZlsrJU8a0yMhW+I6j5QUAbNsZZeugxE
 +ZpDg==
X-ME-Sender: <xms:tJUxajtoRbiRmW1poiSDMiZC1UlZY2lixfA34fldFqhN1uRegCHOiA>
 <xme:tJUxai-hHPEnPbxyCqUm9UQRNxyOAeYQL0kxc5mVNyNh8_XQTpVbrlSTx8U4MOQY-
 m5b3SwULEnMENtoWnHJB_KDRd7zybyZuwtt-h545d8MorTbIBcR2g>
X-ME-Received: <xmr:tJUxatn2UDE9O17qYGRdNPUibemkUX04LFE8Hv5Z_fpX-XRCkGR9RMdMvNfRdGJqCA9E5t_QN4zcjorSbs-8H57iFb5Y>
X-ME-Proxy-Cause: dmFkZTGrC5DYJP9mSxqJd1fDXc0Oh1AGx3JLF0BRoNGPbCwDKFsaw0D49sQCZTbacGELJP
 NPTNfLWvLgiPPk8vfyWDXR9pvW4cjmDKY+4hStnqjC00ax5yRqzEy7s74FV3Hst0oRau05
 +ZOMSZTUF108LlkZ2bYRXRXyXUJeSS8XHpZ+B6zsfyqUVuJYZ+5HIS98pyiXjS3nRQlNe+
 ZjHbBYR5RgivqZj4ZTUGyl3488WbqeP2qTbAGbkO61UP/cMkWZvsgOuuB9JTEbsBXmiGDy
 dOAAnO+9yWExe3+wxZw7oKyr7SKFr6rnJQISOhv7KbwSDOJwPFjdu7d/V6aiFdPml6XCrS
 R3JqRpkUv/4qoe+0fvmTytcOSlFdsKxpKg58u6aYZ1z2A3fSQCnTWefZ7HjiUwuE8hQC4p
 G/S2m8yrTFEuKFnGlmbqljvKuVc4mAf+rhAiyDy+56MoV2x5W9ScAn+N3UFkqMBOEWuWKs
 s1KiXcknlIA1fYSBCXyT82MmaoJeODLfHNnAA4C4Aj66F/UzmJot110c9VuWCAPk8gIFqc
 39cazJKohx853+MZmwELfMmd4I63YViLryT7pYGNiJ6oxH3RsuFHnRYhsgQ80XhvZG0bun
 OdKWBXU4jTx2h2XZ8ZkIrmuHQC/plGNTA6FFsJ8tesDFJ7uRuYAjilFy+eIQ
X-ME-Proxy: <xmx:tJUxaiNcskzLMEK9Oa4ndBu1OwgYuJIrLUAIiDoo4HCVgda1wh4MZw>
 <xmx:tJUxasLq-wBc_WmQiFYIfvkEeQiO87MJrIWsIEZjY-nXrCiG2P2ldw>
 <xmx:tJUxatG-PaNMzX79RsuzDlf73S5K2776QWiJy45vAH0PPrkYrX_WEg>
 <xmx:tJUxatAKEwAlT0SKZCJlMNWm-i3LYQHDuShGmKhdGhq2Qkyt58ha3A>
 <xmx:tZUxaoXRy8ZHUNEoYu_jK99k0OMhk0rJEh0xohBXEX_-uKrw9VAdShL7>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 14:28:03 -0400 (EDT)
Date: Tue, 16 Jun 2026 20:28:02 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: img,powervr-rogue: Document
 GE8300 GPU in Renesas R-Car D3
Message-ID: <20260616182802.GB1662668@fsdn.se>
References: <20260616175835.2109336-1-niklas.soderlund+renesas@ragnatech.se>
 <20260616175835.2109336-2-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616175835.2109336-2-niklas.soderlund+renesas@ragnatech.se>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 2026-06-16 19:58:34 +0200, Niklas Söderlund wrote:
> Document Imagination Technologies PowerVR Rogue GE8300 BNVC 22.67.54.30
> present in Renesas R-Car R8A77995 D3 SoCs.
> 
> Compared to other R-Car Gen3 SoCs the D3 only have one power domain and
> it is always on. Extend the list of special cases for this to also cover
> R8A77995 and update the description of it.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> * Changes since v1
> - Sort img,img-ge8300 after img,img-ge7800.
> - Fold special case for power domain into an existing one and update the
>   description.
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index a1f54dbae3f3..b93f49f1fa0a 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -25,6 +25,11 @@ properties:
>                - renesas,r8a779a0-gpu
>            - const: img,img-ge7800
>            - const: img,img-rogue
> +      - items:
> +          - enum:
> +              - renesas,r8a77995-gpu
> +          - const: img,img-ge8300
> +          - const: img,img-rogue
>        - items:
>            - enum:
>                - ti,am62-gpu
> @@ -114,6 +119,7 @@ allOf:
>            contains:
>              enum:
>                - img,img-ge7800
> +              - img,img-ge8300
>                - img,img-gx6250
>                - thead,th1520-gpu
>      then:
> @@ -159,14 +165,14 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          contains:

The 'contains' node should have been kept, my bad. I wonder why 'make 
dt_binding_check' or `make dtbs_check' did not catch it. Sorry for the 
noise.

> -            const: thead,th1520-gpu
> +          enum:
> +            - renesas,r8a77995-gpu
> +            - thead,th1520-gpu
>      then:
>        properties:
>          power-domains:
>            items:
> -            - description: The single, unified power domain for the GPU on the
> -                TH1520 SoC, integrating all internal IP power domains.
> +            - description: The single, unified power domain for the GPU.
>          power-domain-names: false
>        required:
>          - power-domains
> -- 
> 2.54.0
> 

-- 
Kind Regards,
Niklas Söderlund
