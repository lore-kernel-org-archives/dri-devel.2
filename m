Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F64DC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABD810E3CF;
	Mon, 17 Aug 2026 07:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D/dr3avs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F3610E3CF
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:42:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2AC3601FB;
 Mon, 17 Aug 2026 07:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B381F000E9;
 Mon, 17 Aug 2026 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786952558;
 bh=qT2yF0faTkPR5ST2LgRX7fG1uocE5gd79N8AzmJ0fhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D/dr3avspgTLyOXH3DNYNYYFRTZr97wbzFT0314TKUmqNdoNFX+chhYdkqg/htvqA
 nJrSYrw4l9oFPX2ukSJrUct+yQMCKOBgDFr65Eck2EbBvMT989WTl7aZrl50D2P6jW
 QXmF5f0f2BdsVdf0XaqpHqLcahBJPgcO034wM63bqQBt5dwxBKInHjnNCtCeilGPbs
 eqaa3PIBq1U+LH11E+328Q3+kBARwanGIrqipuTi4nXsVyCjJzHYIfC8yrqhd3/cvp
 Dn8wzfxHp19mTWNYTT2TqzlavbHxUMfU55YDVOtm3ql0wwmiCg317jLor3tHpVIvQi
 iTMLAytSmj0NQ==
Date: Mon, 17 Aug 2026 09:42:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: Document 10" Raspberry
 Pi Touch Display 2
Message-ID: <20260817-whimsical-fictional-dove-89b3d6@quoll>
References: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
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

On Sun, Aug 09, 2026 at 09:58:50PM +0200, Marek Vasut wrote:
> Document the 10" Raspberry Pi Touch Display 2 MIPI-DSI TFT LCD panel.
> The panel is based on the Ilitek ILI79600A controller.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  .../display/panel/ilitek,ili79600a.yaml       | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili79600a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili79600a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili79600a.yaml
> new file mode 100644
> index 0000000000000..0a3baffef293e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili79600a.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/ilitek,ili79600a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek ILI79600A based MIPI-DSI panels
> +
> +maintainers:
> +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - raspberrypi,dsi-10inch
> +      - const: ilitek,ili79600a

Binding looks exactly like boe,tv101wum-nl6, so either properties are
copy-pasted without checking in datasheet or this does not need new
binding file.


Best regards,
Krzysztof

