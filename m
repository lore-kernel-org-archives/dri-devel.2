Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF535C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2759610F341;
	Fri, 14 Aug 2026 07:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OW2UT+ez";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591D010F341
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:24:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B04543B7B;
 Fri, 14 Aug 2026 07:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CFB1F000E9;
 Fri, 14 Aug 2026 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786692247;
 bh=GconpR1MA/GTVdeRlXQuN3B3FW4f1/Edi66aRXMV/js=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OW2UT+ezX/SXADFrkSMBWH0MqfiiBO2hMH387sHpi5iyuWtskdx1+aT9ftnn2CuBn
 4lvmd7GV3lErJX1ONGq6X92PfwexHdjS1MvjBBYcnhteFynBJULmQpzGf6wUQRf4x5
 KYgVdaqNi97cp/Y8VGLHdsaN4sor0FnTp/bh2K0GRGCovZDoCt8/Bpm+FAsEO2Ytsr
 /cAEY2pmYnnf87wXTDykVvybhpOJUhU8e3j9FCDH/OaxyGXFW3RYZUNKVsIH8i2auU
 pnKvzOuDmFwAKVtUE9ih9mOVHDUl5MdSGWXEYb7K7CJxTWyA8dW8ncL9wJ6+XZB5cD
 G30hHC4c5xmgg==
Date: Fri, 14 Aug 2026 09:23:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: lcdif: Add endpoint bus-width property
Message-ID: <20260814-astute-polite-binturong-1abfe9@quoll>
References: <20260813092836.38367-1-francesco@dolcini.it>
 <20260813092836.38367-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813092836.38367-2-francesco@dolcini.it>
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

On Thu, Aug 13, 2026 at 11:28:31AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The DPI output of the LCD interface can be configured with a bus width
> of 16, 18, or 24 bits. Introduce a bus-width property to the output
> endpoint, specifying the number of parallel RGB bits connected.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v4: use /schemas/graph.yaml#/$defs/port-base
> v3: use video-interfaces.yaml
> v2: use the common bus-width property instead of the legacy interface-pix-fmt
> ---
>  .../devicetree/bindings/display/fsl,lcdif.yaml       | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

