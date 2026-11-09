Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C9606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rnm2OZ43
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3141210F2C0;
	Mon,  9 Nov 2026 13:21:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3AF10E8A1
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 13:21:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F687411A8;
 Mon,  9 Nov 2026 13:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF331F0089F;
 Mon,  9 Nov 2026 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794230483;
 bh=dSDOttOUZlbRzOTWEjKBcPBDk84wy77ID43rCwcUDVI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Rnm2OZ43+sNN2aJJ52eRSZhb+eqAhS0A4vIyS9o1EgF2JmB9rRXJJMj6l3lgx4wJg
 AlxTQ5BR40MI2Hn9bUmUvgh1JoU7OMTQWgJY68SwtXc4y0UXSJDS3FsdS6LMCYbsNE
 ptwUXL4uVBXJ60moWUQZClLUvLZAT6jg6TGMa62lc+OIndtPBAMfabo6Z1PLer2hva
 s7Fl6mbCkFosCu+JvZ2k59W24/GVlgJkPB2y7lZrk/5eqfLsc/+VLPXvhIoNc/8PvL
 qEK5U+ELNg52phl2lFHfIFr2YMT+6wvczJuVGV/pArLaL48EuEO6F5tutar1rpipAG
 a5c6KfPcxQvjQ==
Date: Mon, 9 Nov 2026 14:21:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi,
 andreas@kemnade.info, 
 khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com, jmkrzyszt@gmail.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Message-ID: <20261109-psychedelic-kudu-of-tenacity-b06ada@quoll>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
 <20261105200556.34240-3-apokusinski01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105200556.34240-3-apokusinski01@gmail.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 09:05:52PM +0100, Antoni Pokusinski wrote:
> Document the TX and RX DMA request channels featured
> by the OMAP I2C controller.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
> index 58d32ceeacfc..ff946fdfaad3 100644
> --- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
> @@ -37,6 +37,16 @@ properties:
>    clock-names:
>      const: fck
>  
> +  dmas:
> +    items:
> +      - description: TX DMA channel phandle
> +      - description: RX DMA channel phandle
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

