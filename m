Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE783CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DC710F586;
	Thu,  1 Oct 2026 06:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hhANQ7SV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C41E10F586
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:55:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 280BE601F6;
 Thu,  1 Oct 2026 06:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CD01F000FF;
 Thu,  1 Oct 2026 06:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790837752;
 bh=p4Ts2/n0F4w6WOA2qsy7F0lIPhEi3nzuiwcrYnsLlSQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hhANQ7SVoq0le0p9KfJ3llwvejnoX2UI4LZBbxtgz7Ur+VNrdHTzE6AGlMBQH8E6O
 +Exw8YX9KaS0OurzuUIU7huBrw7o+NhnsVzqk5CKPjqJXk2K2l3KV8GG50nD/SCnpj
 Iq/KhikYuRPceOvfqv32nVK1NEcymcJBEMNN/v/FwIoQnL+tUBPi+v8N4IPYlpeWah
 i89FmLeo/JxUzWQZXc8liLJDHUGEHu1M9k5fC07PJTaTvAWFCrcbKKVB6SxHSK9J5o
 BmqF1nbAR1jE64OEhn4rFr427PYJecyX4uKj2JUNbrGP5+0F6lFlJ260kEGNjM+zUU
 R0ObaT7Ina3uw==
Date: Thu, 1 Oct 2026 08:55:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 devicetree@vger.kernel.org, rajeevny@qti.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add optional wled-supply
Message-ID: <20261001-private-wooden-chachalaca-51aa57@quoll>
References: <20260929-wled-supply-series-v1-0-75d0a83b4b00@oss.qualcomm.com>
 <20260929-wled-supply-series-v1-1-75d0a83b4b00@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-wled-supply-series-v1-1-75d0a83b4b00@oss.qualcomm.com>
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

On Tue, Sep 29, 2026 at 06:42:20PM +0530, Arpit Saini wrote:
> Some boards drive the ILI7807S panel's backlight from an external
> WLED driver whose enable input is wired to a GPIO, typically modeled
> as a fixed regulator (e.g. vreg_wled).

You describe something else. What's fixed regulator should not matter
here. Which pin is it in ILI7807S?

It seems you just want to represent GPIO with a regulator. This is just
confusing and typical downstream workaround.

> 
> Document the optional wled-supply property for the ILI7807S panel
> binding. When present, the supply can be used to control the enable
> input of the external WLED driver.
> 
> Platforms without an external WLED enable supply can omit this
> property and continue to use the existing backlight handling.
> 
> Fixes: 447a76a99e24 ("dt-bindings: display: panel: add Ilitek ILI7807S panel controller")
> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili7807s.yaml   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> index ba8c5bbf8ffc..8d56b74a962a 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> @@ -34,6 +34,10 @@ properties:
>      description: Negative LCD bias supply (AVEE), typically -5.5V
>        (range -6.3V to -4.5V)
>  
> +  wled-supply:
> +    description: Optional Supply for the WLED driver that provides the
> +      panel backlight
> +
>  required:
>    - compatible
>    - reg
> @@ -49,6 +53,13 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>  
> +    vreg_wled: regulator-wled {
> +        compatible = "regulator-fixed";
> +        regulator-name = "vreg_wled";
> +        gpio = <&tlmm 91 GPIO_ACTIVE_HIGH>;
> +        enable-active-high;
> +    };

Irrelevant here

Best regards,
Krzysztof

