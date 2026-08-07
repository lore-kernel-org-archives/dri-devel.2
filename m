Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57AEC5AD05
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 23:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670DB10E469;
	Fri,  7 Aug 2026 23:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VV/XUYcM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6072E10E469
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 23:04:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 063B543A3F;
 Fri,  7 Aug 2026 23:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB81F000E9;
 Fri,  7 Aug 2026 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786143845;
 bh=kx1UpXBKBEnflfmlkyqXJx2dZdKyL+1i3Yt8CewuoiI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VV/XUYcMh8D0sqYrzb6w4ag/Zg3apwKvX86mZCbG+yJ4BrEBzd6D/uVp6XAcfGVu9
 xK0K3U1X6w18XuHNER8n2eiovHx2ki/yt8i7e4rVnNMVLrSy45/NhT9manywxGtTq+
 OZpQGjBAa3EQOa05D0effL3x/zpXVwtZua2RfujaYDYnlAUiPoewfrtjKTwjxGbwhN
 /QeJxfZT28juQPDOxN1mkQjQ4ccmqdX5aYPAPzJfb53i6n9RqrBwGrOEp3VB8xm3XH
 80ccLuP5Q0vc1dAUkxDhwNkCnOjAuuInRU6AqpF9LSU3hKFCSwFnDBfzNJPOqrLHuZ
 HHSyV1z1pS3cw==
Date: Fri, 7 Aug 2026 18:04:04 -0500
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
Subject: Re: [PATCH RESEND 03/17] dt-bindings: display: spacemit: add K3
 Innosilicon DP/eDP controller
Message-ID: <20260807230404.GA2211679-robh@kernel.org>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-3-6de34d80e86c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725-k3-display-v1-3-6de34d80e86c@gmail.com>
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

On Sat, Jul 25, 2026 at 12:51:12AM -0400, Cody Kang wrote:
> Both K3 instances are the same IP and share one compatible; which one
> behaves as eDP is decided by what its downstream port is wired to, not by
> which register window it sits in, so the binding does not distinguish them.
> 
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> ---
>  .../display/spacemit/spacemit,k3-inno-dp.yaml      | 140 +++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml
> new file mode 100644
> index 000000000000..865ea310daaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/spacemit/spacemit,k3-inno-dp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K3 Innosilicon DisplayPort / embedded DisplayPort Controller
> +
> +maintainers:
> +  - Cody Kang <codykang.hk@gmail.com>
> +
> +description:
> +  Innosilicon DisplayPort transmit controller integrated in the SpacemiT K3
> +  SoC. The K3 has two instances of the same block sharing one compatible;
> +  each acts as embedded or external DisplayPort depending on whether its
> +  output port drives a panel or a connector.
> +
> +properties:
> +  compatible:
> +    const: spacemit,k3-inno-dp
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Link and hot-plug events.
> +
> +  clocks:
> +    items:
> +      - description: Pixel clock for the controller.
> +      - description:
> +          Pixel clock generated by the DP PHY PLL; the pixel clock above is
> +          parented onto it in use.
> +
> +  clock-names:
> +    items:
> +      - const: pxclk
> +      - const: pll
> +
> +  resets:
> +    maxItems: 1
> +    description: Controller-wide reset signal.
> +
> +  phys:
> +    maxItems: 1
> +    description: Phandle to the K3 Innosilicon DP PHY.
> +
> +  phy-names:
> +    items:
> +      - const: dp
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video input from the DPU.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output to the panel or to the DisplayPort connector.
> +
> +    required:
> +      - port@0

Shouldn't port@1 be required too?

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob
