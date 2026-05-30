Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B029CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 08:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC7010E5E9;
	Sat, 30 May 2026 08:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YDhpt0SY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980CE10E5E9
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 08:58:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B3FF44775;
 Sat, 30 May 2026 08:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8924D1F00893;
 Sat, 30 May 2026 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780131521;
 bh=ayHHk4ZOOr5w+O/PeNuUnAMZ4J8wsxunRTe/vkmvyG8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YDhpt0SYHo9S+jdUx8pLtkH/ygPg2Y5vBAXhc/kIgMbDqclzrhIPo5PtQdlFhfHKv
 j8q70TsdwYVghsf9v0dggNSFxMnVKEU+CAlwNt5AoBBeveiIYHmhovlEuv3Rdwtq6q
 QOF8THxNchBkkD/ZkkycslTkcfz0t2QpFxM8rc/A85VC1lRpl6UMFZMDjGpgFy/zf3
 wTHlpw8l7iKVwBJtKhfLJvl7jPCIcWkfwwAd9jSIhLEIkaMMBu73LEcyPpoo2WIQX7
 NVBZ3lZUQv8wqsDrIkWUL3oy7WQNKcc224nUanT4TyLxO6BcR+4PJPIlYHvax4A3hH
 iIzHV2suEZlzg==
Date: Sat, 30 May 2026 10:58:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 04/15] dt-bindings: display: ti,am65x-dss: Add
 ti,dpi-io-ctrl
Message-ID: <20260530-slim-private-dachshund-e869cd@quoll>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-4-7fefdc5d1adf@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-beagley-ai-display-v3-4-7fefdc5d1adf@ideasonboard.com>
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

On Fri, May 29, 2026 at 11:45:34AM +0300, Tomi Valkeinen wrote:
> The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
> which produces the in-SoC parallel video signal, and a DPI block which
> adjusts the signal to the external MIPI DPI output.
> 
> The DSS IP has registers to configure whether the data and sync signals
> are driven on rising or falling clock edge, and on some SoCs these are
> automatically conveyed to the DPI block which needs that configuration
> to properly output the MIPI DPI signal.
> 
> However, on some SoCs the DPI block configuration has to be done
> manually, using an extra register outside the DSS, DPI0_CLK_CTRL in
> MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior.

Why don't you constrain this properyy per SoC in such case? Why is it
applicable to each SoC, even though you said it is done via DSS IP
registers?

> 
> Currently the DPI0_CLK_CTRL is never written, so it's always 0, meaning
> the data and sync are always driven on a rising clock edge regardless of
> the DSS configuration.
> 
> Add 'ti,dpi-io-ctrl' property, which contains phandle to the
> MAIN_CTRL_MMR_CFG0 block and the offset to the DPI0_CLK_CTRL register,
> so that the DSS driver can configure the data and sync signals
> correctly.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../devicetree/bindings/display/ti/ti,am65x-dss.yaml          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 588d72d4ec0d..902ae2122d86 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -113,6 +113,17 @@ properties:
>        and OLDI_CLK_IO_CTRL registers. This property is needed for OLDI
>        interface to work.
>  
> +  ti,dpi-io-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      phandle to a syscon device node containing the DPI0_CLK_CTRL register,
> +      with the offset to DPI0_CLK_CTRL as an argument.
> +    maxItems: 1

Drop

> +    items:
> +      items:

missing '-'. See other examples of phandle-array, for example one of
the first search results: qcom,ssc-block-bus.yaml

Best regards,
Krzysztof

