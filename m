Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03516606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmduxRyR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006D510E376;
	Sat, 21 Nov 2026 07:44:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2598410E376
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 07:44:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52F92602D4;
 Sat, 21 Nov 2026 07:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B101F000C6;
 Sat, 21 Nov 2026 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795247056;
 bh=3LF0iozCK3be5qNzdN7kLidOplRMQaHvoxhaWrqnzAI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YmduxRyRHHMU4wilmiUFb7isWnCLOvZCruN73/lYgyJt8FQqqHl3t+Umft53F4czP
 SumCCjfuZosaF+sd37vxCJvyXMtoY1w2UC/swHhxny8Ah5XhrPNN5/MongFecKgwF0
 M77dafo8ii0RR0oYFozc1SlYyDjd/SyJ5hTdvaPRKT6XihqDUiB6KinIeXiv3Quqat
 3gpdPL0o6zQhw1crSbReraxhRItX34hsO5mC8JIccEj14tLfYGD5Au90Ru9do67dtX
 Bt6g3sTv8s1tHWWETx1n5uYphwJGM/llO1PmMxBYk0eCTbf4Wj5rdr5hMRdvjMGB9g
 ZTer37M8kxqEw==
Message-ID: <sashiko-outbox-226790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/17] dt-bindings: display: spacemit: add K3 Saturn
 DPU controller
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com
In-Reply-To: <20261121-k3-display-v3-1-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-1-ec419e8e96b8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:44:15 +0000
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
- [Low] dt-bindings: display: spacemit: interrupts ordered before clocks
  in K3 DPU
--

commit 5cacd6c3de4c42a0a1e84fc0f0f6938c6990b78e
Author: Cody Kang <codykang@vsit.ai>

dt-bindings: display: spacemit: add K3 Saturn DPU controller

This commit adds the Device Tree binding schema for the Saturn display
processing unit found on the SpacemiT K3 SoC.

> diff --git a/Documentation/devicetree/bindings/display/spacemit/spacemit,=
k3-saturn-dpu.yaml b/Documentation/devicetree/bindings/display/spacemit/spa=
cemit,k3-saturn-dpu.yaml
> new file mode 100644
> index 0000000000000..97ea9da4b68e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-satu=
rn-dpu.yaml
> @@ -0,0 +1,132 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: spacemit,k3-saturn-dpu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Online (live display) compose path.
> +      - description: Offline (writeback) compose path.
> +
> +  interrupt-names:
> +    items:
> +      - const: online
> +      - const: offline
> +
> +  clocks:
> +    items:
> +      - description: Pixel clock.
> +      - description: Memory clock for the compose pipeline.
> +      - description: AXI bus clock.
> +      - description: DSI escape clock.
> +      - description: DSC clock.
> +
> +  clock-names:
> +    items:
> +      - const: pxclk
> +      - const: mclk
> +      - const: aclk
> +      - const: escclk
> +      - const: dscclk

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - ports

[ ... ]

> +        dpu@c0340000 {
> +            compatible =3D "spacemit,k3-saturn-dpu";
> +            reg =3D <0x0 0xc0340000 0x0 0x54000>;
> +            interrupts =3D <90 IRQ_TYPE_LEVEL_HIGH>,
> +                         <89 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "online", "offline";
> +            clocks =3D <&syscon_apmu CLK_APMU_LCD_PXCLK>,
> +                     <&syscon_apmu CLK_APMU_LCD_MCLK>,
> +                     <&syscon_apmu CLK_APMU_DPU_ACLK>,
> +                     <&syscon_apmu CLK_APMU_DSI_ESC>,
> +                     <&syscon_apmu CLK_APMU_LCD_DSC>;
> +            clock-names =3D "pxclk", "mclk", "aclk", "escclk", "dscclk";

[Severity: Low]
This isn't a bug, but in Device Tree binding schemas, clocks and clock-names
should be listed before interrupts and interrupt-names in the properties,
required, and examples sections to follow the canonical property order
(compatible, reg, clocks, clock-names, interrupts, interrupt-names).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-k3-display=
-v3-0-ec419e8e96b8@gmail.com?part=3D1
