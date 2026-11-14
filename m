Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FA606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5XdN+Gc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0672110EB9B;
	Sat, 14 Nov 2026 03:14:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E5E10E5E4
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:13:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDC836111F;
 Sat, 14 Nov 2026 03:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371001F000C4;
 Sat, 14 Nov 2026 03:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794626033;
 bh=7ejxccbTIVAN32pUGdmV2s8mVSG6ykLKTT51aF4MtYM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B5XdN+Gc7FOPBmPY3s1hUDnAx3lslyv54apNlEEQpCwjBQCLQprW7dfYj5d2UWUAa
 k17WzNqZLv705ysGFigglApkm98+pdgT/exiEZnZmWVTPiyYzP2LB3M5o+0EguD9BP
 TVL3t5hUV12mLM5aZwEDOGPoanr+sv0RCa5y2SuV4vkqKf2CNvBz7jQM5QGGrMnmdI
 r7PiZX4QuayRHi4Vj1jcg7ohHpNeSL2yEvp0GZ00Fy3AStaF0FCM85bMXC9C4j8b50
 edsSywQO7x28MSrdj4V7Z4XQENeip7RwCEzdgfDg1PBgqvbp8CJolH8WcJ7tDGwtyb
 aJoDzXtyxERcQ==
Message-ID: <sashiko-outbox-214086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/12] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <381d2bc99486ca312e1d02f482eccd37def29831.1794615323.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <381d2bc99486ca312e1d02f482eccd37def29831.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:13:52 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: npu: rockchip: unwieldy per-compatible allOf in
  rknn-core
--

commit a0f34734ea2ccc04a47837d4a01f9cdb7cf55a23
Author: Jiaxing Hu <gahing@gahingwoo.com>

dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core

This commit adds the rockchip,rk3576-rknn-core compatible string to the
Rockchip RKNN core binding and defines per-SoC clock, reset, and regulator
constraints in an allOf conditional block.

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
> =20
>  additionalProperties: false

[Severity: Low]
This isn't a bug, but since rockchip,rk3576-rknn-core and
rockchip,rk3588-rknn-core differ across clocks, clock-names, resets,
reset-names, and sram-supply, would it be cleaner to split
rockchip,rk3576-rknn-core into its own schema document rather than
loosening the top-level properties and overriding all of them in allOf?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794615324.gi=
t.gahing@gahingwoo.com?part=3D6
