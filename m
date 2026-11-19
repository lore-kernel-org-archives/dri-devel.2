Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A360A260F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUuOxIuH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8AAE10EC39;
	Thu, 19 Nov 2026 15:57:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCB810EC39
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:56:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 561126271B;
 Thu, 19 Nov 2026 15:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F61F000C4;
 Thu, 19 Nov 2026 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795103813;
 bh=DXGhe34KpguMzqiQASaXF8G5x9sL6gxPTr8z8Z/2zbo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dUuOxIuH+uEPuDhxlvbSxE2D/LEp78wLaneZ3KRyLxD8SJAYd5HlrPREFI0V5cC8c
 oFSmMLFiuDa27QPoM43reJGI1K61JKHNSSjN9oKm6RJHMwffEXQHdQljH+t3Tu+BrI
 uYOmaXoQMQZ3zL3dbOdtU7vNggHliJM1zYTXIUTr0Bcs+8oseIEVLJsE24ju9jakfS
 p6oEQL4mSVi60SNBsPe5ffewMVOxX4qPHt50r9sUHH8QaI+G4OM6cPxWfqIezklhGB
 gUNzw87982E5Q6eFNaAqZ/RPFBrg8lhLM6sEEo5gLJts/imW+vojOhdGlXpI8WZdc2
 sQkQVkxc2NQAw==
Message-ID: <sashiko-outbox-223445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: document TH1520
 MIPI DSI controller
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261119-th1520-dw-mipi-dsi-v2-1-9ab5f9808f87@iscas.ac.cn>
References: <20261119-th1520-dw-mipi-dsi-v2-0-9ab5f9808f87@iscas.ac.cn>
 <20261119-th1520-dw-mipi-dsi-v2-1-9ab5f9808f87@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:56:52 +0000
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
- [Medium] dt-bindings: display: thead,th1520-dw-mipi-dsi example uses
  syscon property
--

commit d819a2c2851c2350a4e59d7f97fa2750cf5e7ffc
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

dt-bindings: display: bridge: document TH1520 MIPI DSI controller

This commit adds a Device Tree binding schema for the Synopsys DesignWare
MIPI DSI host controller on the T-Head TH1520 SoC.

> diff --git a/Documentation/devicetree/bindings/display/bridge/thead,th152=
0-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/thead=
,th1520-dw-mipi-dsi.yaml
> new file mode 100644
> index 0000000000000..4d6452a027348
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-mi=
pi-dsi.yaml
> @@ -0,0 +1,102 @@

[ ... ]

> +  thead,vo-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the VO_SUBSYS system controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - interrupts
> +  - thead,vo-syscon
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/reset/thead,th1520-reset.h>
> +
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      dsi0: dsi@ffef500000 {
> +        compatible =3D "thead,th1520-dw-mipi-dsi";
> +        reg =3D <0xff 0xef500000 0x0 0x1000>;
> +        interrupts =3D <119 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&clk_vo CLK_MIPI_DSI0_PCLK>,
> +                 <&clk_vo CLK_MIPI_DSI0_CFG>,
> +                 <&clk_vo CLK_MIPI_DSI0_REFCLK>,
> +                 <&clk_vo CLK_MIPIDSI0_PIXCLK>;
> +        clock-names =3D "pclk", "phy_cfg", "ref", "pixel";
> +        resets =3D <&rst TH1520_RESET_ID_DSI0_APB>;
> +        reset-names =3D "apb";
> +        syscon =3D <&syscon_vo>;

[Severity: Medium]
As reported by Krzysztof Kozlowski on v1 [1], should the example use
thead,vo-syscon instead of syscon?  Because thead,vo-syscon is required
and unevaluatedProperties is false, dt_binding_check fails on the example.
In addition, the thead,vo-syscon description still does not explain what
the DSI controller uses the VO_SUBSYS system controller for.

[1] https://lore.kernel.org/r/20261102-spry-snobbish-hound-384cae@quoll

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-th1520-dw-=
mipi-dsi-v2-0-9ab5f9808f87@iscas.ac.cn?part=3D1
