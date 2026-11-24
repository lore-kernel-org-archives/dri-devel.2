Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74C606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vuni9J1x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33B610E5FC;
	Tue, 24 Nov 2026 16:27:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAF710E5FC
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:26:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7260F44D2C;
 Tue, 24 Nov 2026 16:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034921F000C4;
 Tue, 24 Nov 2026 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537615;
 bh=i49qnlqz0zXgF28dxkTVJ61k0bJxWhQuZY0QF8cqeEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vuni9J1xAT4mRWJWnqAORmy8xE2SywaIkxOeIdp6TMfrnIS3yWIit33pEz/WfVvby
 S7fjwg3fxsvWPocu5SQDs6s0q2qrwLhMP/7KzW7QXaRR+HqHm8+iBF7Bh7LiWXZrDw
 gcvzxWT52TQHqt8SXfLFkT+hzcAF5vNbINsDREqNxeQCIK4iDqzNmXKjfYYginIOWK
 c/m6/KPRXdD+uK6FiiHtSenwlmpaTL9xmZuEMzpIB82Z8OdEZ3dc8s7A23GuvihJDm
 ObSqW8JJf9D0s3erM60gnCRQn6+x4dcsl2AWFZW37HfD8sK6IwAhFepW/zReIH1/vU
 x9rWRJzbShfWw==
Message-ID: <sashiko-outbox-231557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen
 AM schema
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124161952.1053586-9-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
 <20261124161952.1053586-9-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:26:54 +0000
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
- [Low] dt-bindings: gpu: arm,mali-gen5-am: interrupts listed before
  clocks
--

commit 8146e86e1cef7b5ce16835f2b37c463e5fa71384
Author: Karunika Choo <karunika.choo@arm.com>

dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM schema

This commit adds a Device Tree binding schema for ARM Mali 5th-Gen AM GPUs
and updates MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml =
b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
> new file mode 100644
> index 0000000000000..d955476c99774
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
> @@ -0,0 +1,63 @@

[ ... ]

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Job interrupt
> +      - description: MMU interrupt
> +      - description: GPU interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: job
> +      - const: mmu
> +      - const: gpu
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpu@100000 {
> +        compatible =3D "arm,zena-css-mali", "arm,mali-gen5-am";
> +        reg =3D <0x100000 0x480000>;
> +        interrupts =3D <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "job", "mmu", "gpu";
> +        clocks =3D <&gpu_clk>;
> +    };

[Severity: Low]
This isn't a bug, but in Device Tree binding schemas and example nodes the
canonical property order places clocks before interrupts and
interrupt-names (after reg), in properties, required, and the gpu@100000
example node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124161952.1053=
586-1-karunika.choo@arm.com?part=3D8
