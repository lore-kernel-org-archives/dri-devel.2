Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0854CC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692F510F509;
	Sat, 25 Jul 2026 05:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D+xcydSL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250B610F509
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:16:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 613A360A77;
 Sat, 25 Jul 2026 05:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE261F000E9;
 Sat, 25 Jul 2026 05:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956561;
 bh=dsfFN8cXH04hkcTIIjALsxWjAmkmjQJ/dE3pMlPJGfg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D+xcydSLIKwTQzWrgvqQphh541C3wQ6TZRrOp5efvvyLoXWchYzCBg/bnxtpEM+nb
 0L9YOQE5x3JZm0C71s+gk8MYCgn+ryxyeTnuC4p09J8xEmBM1w5Y4x1M5Uj715fH9w
 OHVtEIdh1ZmjjYpb7x5zVGhvjxY6VgebRJLpmA9Wk001ED688CBZ35UEJAgMqFoofH
 fEsWKhfmDv2AJBIv/5DLheAbz+7R83MlcrxQkMUwnoaId64PtGTFXihQy5oWaj6xva
 pHwlbwuhd9tgyij0tFPwzQX2TwRQUsRFtUhKSwcI7ddyORErLuV+naKB9cMUAP9tMg
 E9JZOfmDweEDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/17] dt-bindings: soc: spacemit: allow eDP/DP PHY PLL
 pixel clocks on K3 APMU
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, devicetree@vger.kernel.org,
 olteanv@gmail.com, conor+dt@kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260724-k3-display-v1-4-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-4-f22a10a52867@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:16:00 +0000
Message-Id: <20260725051600.8EE261F000E9@smtp.kernel.org>
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
- [High] The newly added clock names in the device tree binding do not matc=
h the `fw_name` expected by the clock driver, breaking parent clock resolut=
ion.
--

--- Patch [4]: [PATCH 04/17] dt-bindings: soc: spacemit: allow eDP/DP PHY P=
LL pixel clocks on K3 APMU ---
commit 4027b4adb6d5e7a26089ca7f70a25150faf1098a
Author: Cody Kang <codykang.hk@gmail.com>

dt-bindings: soc: spacemit: allow eDP/DP PHY PLL pixel clocks on K3 APMU

The APMU's eDP pixel-clock muxes select the DP PHY PLLs as parents, so the
K3 syscon takes two clock inputs the other variants do not have.

> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-s=
yscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-sys=
con.yaml
> index d3a7c93c3c54f..b8fc6632a3928 100644
> --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.y=
aml
> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.y=
aml

[ ... ]

> @@ -31,14 +31,18 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 6
> =20
>    clock-names:
> +    minItems: 4
>      items:
>        - const: osc
>        - const: vctcxo_1m
>        - const: vctcxo_3m
>        - const: vctcxo_24m
> +      - const: edp0_pll_pxclk
> +      - const: edp1_pll_pxclk

[Severity: High]
Will this mismatch with the clock driver's expected firmware names?

Looking at edp0_pclk_parents in drivers/clk/spacemit/ccu-k3.c, the driver
hardcodes the expected device tree string as "external_clk":

drivers/clk/spacemit/ccu-k3.c:edp0_pclk_parents[] =3D {
    ...
    CCU_PARENT_NAME(external_clk),
    ...
};

Since this binding strictly mandates "edp0_pll_pxclk" and "edp1_pll_pxclk"=
=20
instead of "external_clk", the Common Clock Framework will search the=20
clock-names array for "external_clk" and fail to resolve the parent clocks=
=20
for the eDP pixel clock muxes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-k3-display=
-v1-0-f22a10a52867@gmail.com?part=3D4
