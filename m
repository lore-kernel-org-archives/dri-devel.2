Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E8606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpRCI/vP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BFF10F04D;
	Tue, 24 Nov 2026 08:02:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D22E10F04D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:02:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2BE2611D5;
 Tue, 24 Nov 2026 08:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECA11F000CA;
 Tue, 24 Nov 2026 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795507346;
 bh=Cf7qaTF+ZFNZ0uUXBkGQGmF1NTP352oIto3M9Zk0l4w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SpRCI/vP6cWq4OdSQwe9MVpk/eWFRY0mjv8MlDngLGmmWVyyF8nZo7FU397GcH4Vs
 2NYdL/vdv/mEXQo4mSHVr2dkJCLVl0eBXvEOBRngSu67hAAWWhq/Fc8vER5/4sWZYX
 uh4/uBNqyAX5OHIpPj+Htq+aVDQVmDds4Rrr5fhB3j53k6M0l9y7eeXPlEGq9BRf+r
 gD/rI9Opp1hbv+VZnIl1EyJnpIuNcT11a0NcgvXvbqgH5cdaEWOrF0+3LegPpJHv+o
 Wwc2tuW9HdE3wikIwcfvDV81QWbOp2W3AUyWPNSy3u9MFsIvMLvbXhlYaBQXQaydDj
 26h7ck74rDshA==
Message-ID: <sashiko-outbox-230698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: document TH1520
 MIPI DSI controller
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124-th1520-dw-mipi-dsi-v3-1-ffcf2d87971b@iscas.ac.cn>
References: <20261124-th1520-dw-mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn>
 <20261124-th1520-dw-mipi-dsi-v3-1-ffcf2d87971b@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:02:26 +0000
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
- [Low] dt-bindings: display: bridge: interrupts listed before clocks in
  TH1520 DSI
--

commit 3703a20fdf6db19e70c1372e62282477db065d09
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

dt-bindings: display: bridge: document TH1520 MIPI DSI controller

This commit adds a Device Tree binding schema for the DesignWare MIPI DSI
host controllers on the T-Head TH1520 SoC.

> diff --git a/Documentation/devicetree/bindings/display/bridge/thead,th152=
0-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/thead=
,th1520-dw-mipi-dsi.yaml
> new file mode 100644
> index 0000000000000..c12afde5fc26b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-mi=
pi-dsi.yaml
> @@ -0,0 +1,103 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: thead,th1520-dw-mipi-dsi
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: DSI controller APB clock
> +      - description: PHY configuration clock
> +      - description: PHY reference clock
> +      - description: DSI controller input pixel clock gate
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: phy_cfg
> +      - const: ref
> +      - const: pixel

[ ... ]

> +      dsi0: dsi@ffef500000 {
> +        compatible =3D "thead,th1520-dw-mipi-dsi";
> +        reg =3D <0xff 0xef500000 0x0 0x1000>;
> +        interrupts =3D <119 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&clk_vo CLK_MIPI_DSI0_PCLK>,
> +                 <&clk_vo CLK_MIPI_DSI0_CFG>,
> +                 <&clk_vo CLK_MIPI_DSI0_REFCLK>,
> +                 <&clk_vo CLK_MIPIDSI0_PIXCLK>;
> +        clock-names =3D "pclk", "phy_cfg", "ref", "pixel";

[Severity: Low]
This isn't a bug, but in both the properties block and the example node,
interrupts is listed before clocks and clock-names.  Could interrupts be
moved after clock-names to match the standard DT property ordering (and the
order already used in the required list)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-th1520-dw-=
mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn?part=3D1
