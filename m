Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52014606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSLqVElw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB0110E781;
	Sun,  8 Nov 2026 07:09:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D2B10E781
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:08:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10B786142E;
 Sun,  8 Nov 2026 07:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741671F0089F;
 Sun,  8 Nov 2026 07:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794121734;
 bh=4aC6Y65FawVLd18fYX+QIdDnmHDg4rv0agcFyygzLQY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nSLqVElw1Nh7iTWoJHxZpXgHTvMO4BfdTs6GvQa3SDGoUkVemlwJO83hkCV5QLgDb
 dAXQvS7ZR3e/1mBQU/81yX/c+dxhdMqlQ38yFKaT8OOECHnc+CMwF4j6auB11FC/4p
 xWgx2xOtUm2ux7JVCIxv+hOGzc6npnQ80h33xZhSykEJ6yJtltP1nsv91iWrxLy+4J
 XVsGhj3gkQhScBuo4Xj0dJXH6rBO/STCPU7SYhqyFD5CtAnqY8Oh9B4zl/9PXAHyJB
 R6RIHRFNDBwTnqrHTRhA5R4un48/HfxcQiykUMT7J5yMJqmKmRDaOF6BY2IogGXenX
 AVFt7Vnr8mdeQ==
Message-ID: <sashiko-outbox-203604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 06/16] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261108065917.135194-7-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
 <20261108065917.135194-7-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:08:53 +0000
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
- [Low] dt-bindings: npu: rockchip: unwieldy per-compatible allOf in
  rknn-core
--

commit edf78bc9ce3ec5680602d5af7f88949dc691184d
Author: Jiaxing Hu <gahing@gahingwoo.com>

dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core

This commit adds the rockchip,rk3576-rknn-core compatible string to the
RK3588 NPU core binding and defines per-SoC clock, reset, and power supply
constraints in an allOf block.

> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a4903cd1..2eb9337819e67 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> @@ -21,6 +21,7 @@ properties:
> =20
>    compatible:
>      enum:
> +      - rockchip,rk3576-rknn-core
>        - rockchip,rk3588-rknn-core
> =20
>    reg:
> @@ -33,14 +34,18 @@ properties:
>        - const: core # Main NPU core processing unit registers
> =20
>    clocks:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 6
> =20
>    clock-names:
> +    minItems: 4
>      items:
>        - const: aclk
>        - const: hclk
>        - const: npu
>        - const: pclk
> +      - const: aclk_cbuf
> +      - const: hclk_cbuf
> =20
>    interrupts:
>      maxItems: 1
> @@ -54,9 +59,11 @@ properties:
>      maxItems: 1
> =20
>    resets:
> +    minItems: 1
>      maxItems: 2
> =20
>    reset-names:
> +    minItems: 1
>      items:
>        - const: srst_a
>        - const: srst_h
> @@ -75,7 +82,36 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-rknn-core
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +        resets:
> +          minItems: 2
> +        reset-names:
> +          minItems: 2
> +      required:
> +        - sram-supply
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          minItems: 6
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          maxItems: 1
> +        sram-supply: false

[Severity: Low]
Would it be cleaner to split rockchip,rk3576-rknn-core into a separate
binding schema document?  Because RK3576 and RK3588 differ across clocks,
clock-names, resets, reset-names, and sram-supply, sharing this schema
requires loosening the top-level properties and overriding all five of them
in a per-compatible allOf block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108065917.1351=
94-1-gahing@gahingwoo.com?part=3D6
