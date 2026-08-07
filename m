Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C120FC5AD2B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 23:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A5010E3E1;
	Fri,  7 Aug 2026 23:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fnEINRfI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8925510E3E1
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 23:08:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1D386001A;
 Fri,  7 Aug 2026 23:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238321F000E9;
 Fri,  7 Aug 2026 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786144105;
 bh=wQ0JD0AB/ZMckaLhyMCcytJcM09nVahiftP8BN/zRr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fnEINRfI/WLStiFHgYr/N4vDshm6MANIZ293vGjTgkzrxM9QK3Hpe/ipWqLpB8Nk2
 bW/kjk4FPdSBkuQtNkbkj8Uf5GqBo+ZqHzgzukevc1IOlnVdLNonX9i+Awx2kyBK75
 Vn7VDhMxtF6+1jS4/eDR1xCcJYmCSs66odGLe5emtBWSvtnEGuyUVI1xHc5L4Cz9pU
 MHEKjmP5IXncmal1qT1VdKixTr5Cyb9rX7KU4yLnlhFCjENjewgVIlftfdWVXHB3OG
 b3SV5BorbrpdPGg0xi/N2HjaSUa7bkr2IQ6WepaCNehV9qPEvLtkYCk0VGjZ2p/Ia8
 8FhMav+rBrC3A==
Date: Fri, 7 Aug 2026 18:08:24 -0500
From: Rob Herring <robh@kernel.org>
To: Cody Kang <codykang.hk@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 04/17] dt-bindings: soc: spacemit: allow eDP/DP
 PHY PLL pixel clocks on K3 APMU
Message-ID: <20260807230824.GA2220945-robh@kernel.org>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-4-6de34d80e86c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725-k3-display-v1-4-6de34d80e86c@gmail.com>
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

On Sat, Jul 25, 2026 at 12:51:13AM -0400, Cody Kang wrote:
> The APMU's eDP pixel-clock muxes select the DP PHY PLLs as parents, so the
> K3 syscon takes two clock inputs the other variants do not have.
> 
> Gate them behind the K3 compatible instead of widening the shared clock
> list, so a non-K3 syscon cannot silently accept clocks it has no mux for.
> 
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> ---
>  .../bindings/soc/spacemit/spacemit,k1-syscon.yaml  | 30 +++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> index d3a7c93c3c54..b8fc6632a392 100644
> --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> @@ -31,14 +31,18 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 6
>  
>    clock-names:
> +    minItems: 4
>      items:
>        - const: osc
>        - const: vctcxo_1m
>        - const: vctcxo_3m
>        - const: vctcxo_24m
> +      - const: edp0_pll_pxclk
> +      - const: edp1_pll_pxclk
>  
>    "#clock-cells":
>      const: 1
> @@ -95,6 +99,30 @@ allOf:
>          - clocks
>          - clock-names
>          - "#clock-cells"
> +  # Only the K3 APMU exposes the two eDP/DP PHY PLL pixel clocks as extra
> +  # inputs (parents of its eDP pixel-clock muxes); every other variant has
> +  # the four base oscillator inputs only.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k3-syscon-apmu
> +    then:
> +      properties:

> +        clocks:
> +          minItems: 4
> +          maxItems: 6
> +        clock-names:
> +          minItems: 4
> +          maxItems: 6
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          minItems: 4
> +          maxItems: 4

4 is already the minimum, so it can be dropped on all of these.

Rob
