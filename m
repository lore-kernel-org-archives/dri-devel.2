Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589B8CC6B33
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE1010E320;
	Thu,  2 Apr 2026 08:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jG2HH9sW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3051A10E320
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 08:33:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F10EB40AD1;
 Thu,  2 Apr 2026 08:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C090C116C6;
 Thu,  2 Apr 2026 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775118789;
 bh=INDKtHgHQ0n50wacZnSNn0khdkNH2PNx0jlzaSDgQvM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jG2HH9sWgGhhlsIVu7Z62OXVTDcrhA0kUh0hYkaB3f1ANXB+rx1hzqNYZTbp6usVK
 lCDeGGOgrTNLmWk2jiqR8i6H8zs7+szNGVg/5BgNSJLMbqSBwR6HgXmc/mvIbaArLX
 21RugLGvr79SGkknRZ1nC0m1AbOVhIAmkDMvKtmNZJtCVnmlZX5i0wAs6nyDU0x05J
 QkYzLnS0ABsxHRbGeG1tNmwubIPFtIS9YHphyYh6WMhGR7KYbEZ02goOFIAbJZt+MS
 N9UY5V2Y0iFUAfLzX7NO87/VzXltWztZavZ5IGcdgTZSl9cfkCsXQevY9/0EO3EqKv
 xsHksarCY8p1g==
Date: Thu, 2 Apr 2026 10:33:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 04/19] dt-bindings: display/panel: ilitek,ili9881c:
 describe Waveshare panel
Message-ID: <20260402-divergent-active-mantis-95bd18@quoll>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-4-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-waveshare-dsi-touch-v1-4-5e9119b5a014@oss.qualcomm.com>
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

On Wed, Apr 01, 2026 at 10:26:23AM +0300, Dmitry Baryshkov wrote:
> Describe Waveshare 7" DSI panel which uses ILI9881 as a panel
> controller. This panel requires two voltags supplies, so add separate

typo, voltage supplies

> iovcc supply.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> index d979701a00a8..42e35986fbf6 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> @@ -24,6 +24,7 @@ properties:
>            - raspberrypi,dsi-7inch
>            - startek,kd050hdfia020
>            - tdo,tl050hdv35
> +          - waveshare,7.0-dsi-touch-a
>            - wanchanglong,w552946aaa
>            - wanchanglong,w552946aba
>        - const: ilitek,ili9881c
> @@ -34,6 +35,7 @@ properties:
>    backlight: true
>    port: true
>    power-supply: true
> +  iovcc-supply: true
>    reset-gpios: true
>    rotation: true

Move the allOf to place before additional/unevaluatedProps and disallow
it for other variants.

Unless you assume that all other devices also could have iovcc, but then
please mention it in the commit msg.

Best regards,
Krzysztof

