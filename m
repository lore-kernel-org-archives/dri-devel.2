Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F119606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItyfWi21
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A1A10E4D4;
	Mon, 26 Oct 2026 07:22:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A8310E4D4
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:21:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E75740049;
 Mon, 26 Oct 2026 07:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FC01F01825;
 Mon, 26 Oct 2026 07:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792999317;
 bh=A9EGVBKkrkz1X1MPL0NIUMm6e0BXOgjEpTvvw/7s/20=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ItyfWi21wEo1RismX/BZZZ3L9JrNV7K+fx+vGxsiR+zLmr0JARZEaElYMbMcP7aJl
 aJaYmW92PibTGdZBxibriScjNFjREcQ/mRi/cix/KRPniU+nh2wrGRXvIwwfuL9SH6
 Rop9dnzO6ed1qE/Mfdk4vrm5RRNCZnROUHxZAeoswFo1GAoYHQcRlXXIX2SNRatail
 ASAaDlf2B01L6mxDViCLvW+I8ir8AFwGHejlwDuhU6/Igypr+zoUNSp5eEVFtOX0Vd
 mp+zg/zF4xxjj5Iz8fP3OSR5Fw7k2uEcNNhi4P571v3Nk72eHd5SD7cvNg1nNt/MkS
 CIWdlY+FGxn0Q==
Date: Mon, 26 Oct 2026 08:21:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lars Rask <lars.rask@axis.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 2/2] dt-bindings: display: sitronix,st75156: add example
 for SPI
Message-ID: <20261026-judicious-exotic-beetle-a5d7ff@quoll>
References: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
 <20261022-add_st75156_support-v1-2-582525a39a39@axis.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022-add_st75156_support-v1-2-582525a39a39@axis.com>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 05:31:06PM +0200, Lars Rask wrote:
> From: Lars Rask <lars.rask@axis.com>
> 
> Add example for using st75156 with SPI.

Your patch does not add example but entire binding. Please describe your
patches appropriately.

> 
> Signed-off-by: Lars Rask <lars.rask@axis.com>
> ---
>  .../bindings/display/sitronix,st75156.yaml         | 67 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 68 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sitronix,st75156.yaml b/Documentation/devicetree/bindings/display/sitronix,st75156.yaml
> new file mode 100644
> index 000000000000..a3897ddc5e38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sitronix,st75156.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sitronix,st75156.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sitronix ST75156 Display Controller
> +
> +maintainers:
> +  - Marcus Folkesson <marcus.folkesson@gmail.com>
> +
> +description:
> +  Sitronix ST75156 is a monochrome dot matrix LCD panel used in SPI 4-wire mode.
> +
> +allOf:
> +  - $ref: panel/panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: sitronix,st75156
> +

Everything looks the same as sitronix,st7571, so why this cannot be
added there?

Best regards,
Krzysztof

