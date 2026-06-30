Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364E1C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D7410EB38;
	Tue, 30 Jun 2026 07:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E0XbB2vM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB79D10E192
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 07:46:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF47760008;
 Tue, 30 Jun 2026 07:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A841F000E9;
 Tue, 30 Jun 2026 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782805567;
 bh=BneXgfQjYcjalGELmnWGSOHtMIAn4pI8vNVZoFuYMac=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=E0XbB2vMT67FaNuvfrF3TI6s7eh4nu9otGcu80RlRxMIj5hmqAPn/pjHud7sbH3Rd
 woiN624m2UrpjkfctseTbXMjQR9uBtTTWEkp+sHi8A26UusHtrGHXc00GyUbXPgCSo
 Y+DKIgD+pTHwSXXpDZUSyDZciteQhMmu+l3xmTYqJNHMVNJfWO56O+8GWgbMkXcBwZ
 x+GeDtGdM0yCWx3gqGnTOQMyJ/Xsyl7yS1ltMuvO0A+OYkNciRkfGboGq0Rg0+L8CV
 J/N1YOozIJeRTpYvsVYzlhwLIeBFWwdfc1lRVVo5c9kDQW0RRJIl+SRykGX5b18OgH
 CbDk3RNeRLjBQ==
Date: Tue, 30 Jun 2026 09:46:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36536
Message-ID: <20260630-tanuki-of-extreme-grandeur-ef1cb4@quoll>
References: <20260630023439.248861-1-mitltlatltl@gmail.com>
 <20260630023439.248861-2-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630023439.248861-2-mitltlatltl@gmail.com>
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

On Tue, Jun 30, 2026 at 10:34:38AM +0800, Pengyu Luo wrote:
> NT36536 is a driver IC used to drive MIPI-DSI panels. It is found in
> LENOVO Legion Y700 Gen4 with a 10-bit CSOT panel.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  .../display/panel/novatek,nt36536.yaml        | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
> new file mode 100644
> index 000000000000..f854fc99ba81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36536.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT36536 based DSI display Panels
> +
> +maintainers:
> +  - Pengyu Luo <mitltlatltl@gmail.com>
> +
> +description:
> +  The Novatek NT36536 is a generic DSI Panel IC used to drive dsi
> +  panels. Support video mode panels from China Star Optoelectronics
> +  Technology (CSOT).
> +
> +allOf:
> +  - $ref: panel-common-dual.yaml#

Nothing in commit msg or description explains why is this a dual-link?

Judging by example this was intentional, so it should be mentioned
somewhere.

With this improved:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

