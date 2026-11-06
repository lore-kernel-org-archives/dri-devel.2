Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE81606EE93
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYmnnTbS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE4F10E2D3;
	Fri,  6 Nov 2026 10:54:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFECF10E2D3
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 10:54:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 610F640AF7;
 Fri,  6 Nov 2026 10:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3B41F008BC;
 Fri,  6 Nov 2026 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793962476;
 bh=kt2KfflUu9wnbC5ZymY+sDmDdUTHvXazydKZivviUMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nYmnnTbSCpbpDQoPABcq/UjShHDTiAIr+ewgMop+rnrvl/G2CWCu61lP+4Uq8STTl
 SetSlU/dwRvx5wXyLxx0aQiCJHwKuvVx0BJX3heU9Ts+m76AwU/C41Vgx9CasjOlfx
 LMe7xVSfl8I6nWDSJfTNtJc9Kn2K/8dNaH7qVHIsQ1xtw6TyhQF69R6z0BwUYcu4tk
 dM1WKdc9xRcz8qDT3nrZiOhNdrwufPgiy3oUaEky4qcv8P1CPesUWtsnFLqef33jZg
 ScfqCoQv9enVrSGa/NHbVBuWBDF/yeg0fzARPq/EtHTxd7ZguxReXZTPGLjeokqotc
 Dad+MIlAeOv5A==
Message-ID: <sashiko-outbox-201244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: gpu: Add CIX Sky1 Mali support
To: "Cunyuan Liu" <cunyuan.liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106104735.1651267-2-cunyuan.liu@cixtech.com>
References: <20261106104735.1651267-1-cunyuan.liu@cixtech.com>
 <20261106104735.1651267-2-cunyuan.liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:54:35 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: gpu: arm,mali-valhall-csf: unwieldy per-compatible
  conditionals
--

commit f3e7a046ab621a6ec3308f5290d9455780be0bec
Author: Cunyuan Liu <cunyuan.liu@cixtech.com>

dt-bindings: gpu: Add CIX Sky1 Mali support

This commit adds the CIX Sky1 Mali compatible string, resource constraints,
and a Device Tree example to the Arm Mali Valhall CSF GPU binding schema.

> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.y=
aml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index 8eccd4338a2b2..a93acc6d91ec8 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -18,6 +18,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - cix,sky1-mali
>                - mediatek,mt8196-mali
>                - nxp,imx95-mali            # G310
>                - rockchip,rk3588-mali
> @@ -51,6 +52,9 @@ properties:
>            - stacks
>        - const: stacks
> =20
> +  resets:
> +    maxItems: 1
> +
>    nvmem-cells:
>      items:
>        - description: bitmask of functional shader cores
> @@ -146,6 +150,34 @@ allOf:
>          - nvmem-cells
>          - nvmem-cell-names
>          - power-domains
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: cix,sky1-mali
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: stacks
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names: false
> +        mali-supply: false
> +        sram-supply: false
> +        nvmem-cells: false
> +        nvmem-cell-names: false
> +      required:
> +        - clock-names
> +        - resets
> +        - power-domains
> +    else:
> +      properties:
> +        resets: false

[Severity: Low]
With each variant adding another per-compatible if-then-else block to
disable properties used only by other SoCs (and setting resets: false for
all other variants), the conditionals in arm,mali-valhall-csf.yaml are
becoming unwieldy.  Should this binding be split into separate schema
documents rather than piling on more variant-specific conditionals here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106104735.1651=
267-1-cunyuan.liu@cixtech.com?part=3D1
