Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE47CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58F010F2DC;
	Thu, 30 Apr 2026 09:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bi7W1P5N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F9110F2D6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:40:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 24D7042D94;
 Thu, 30 Apr 2026 09:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF26C2BCC4;
 Thu, 30 Apr 2026 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777542035;
 bh=Tj7K1qp7clDNye0BbLNXPFP5MofQdFJ7SeapubT7TdM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bi7W1P5NJgq5JgaZXIam/iHdqEEAlfiLj7Mcclo9abxMfE34smq9+J23v+F0BA5o0
 2IL+vhwg4/+gBP6RaTxNJnUsP0zOrKn6G3RCVDpsG2dYr02CNH540qDfSeXxOcQdBp
 5u4y/gjsUb3TUUP1LdLm4wq7vm3nQdPLBGZVy19Bap5vYgbttxRlgWogIX+y2jGdQc
 3kZpOL/nh+GeUL1Qbs/Z/A0tjaUqcpi0tHot2hfV3vQc0BoJNg1j2hPXBeaAT8B4nM
 B9wJhzgPhxoTRLEB/lMaaz0Itu25mOemAeMXV0AKC30/EujE8GJdqq0IWERpWwALp4
 bGCuSSYKNrH4w==
Date: Thu, 30 Apr 2026 11:40:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 KancyJoe <kancy2333@outlook.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <20260430-interesting-pink-salmon-082def@quoll>
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
 <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-1-0caade5fdb32@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-1-0caade5fdb32@linaro.org>
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

On Tue, Apr 28, 2026 at 03:59:11PM +0200, Neil Armstrong wrote:
> Document the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

subject - not a regulator prefix

> diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> new file mode 100644
> index 000000000000..dc44b3b502e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silergy SY7758 6-channel High Efficiency LED Driver
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description: |

Drop |

With these two fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

