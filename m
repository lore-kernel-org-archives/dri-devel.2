Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBEF606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYv75wa8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204F310E33D;
	Sun, 22 Nov 2026 17:11:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80B510E33D
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:11:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F7904486C;
 Sun, 22 Nov 2026 17:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A451F000CA;
 Sun, 22 Nov 2026 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795367485;
 bh=BB8oN2iaLLoL+rbrvv3ATfk1pljEVJJN/maFdOLVyjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mYv75wa8UXIiy3dYmbes57GcUNjxeD+EvILIZQ5bnH5mPCIuNk1DoMbQgwbgTMXZe
 XCvC0Z8/AceWI3SEnH9gKOXXQwslW6cLOP3thwv1nWmtP+TaE8T2rSqE0tkusqfSDe
 LJAiHy2c5nB5rf2S75RcBV3TfhQ38h2uvba7dAnCMJjJCjgYQsWpjdbqp6L9w05PCo
 0J+hIN9sKTW4BPScQrSId+CYoAtf8mPZVa0qrVZTpbdxO7rcgI81V6yLrzG0pLHMSE
 6G0xAjbLItpHr0xt5resZcYWMrsO1MNiTlRKl1ykVLo5u47z8hgwZbKvXXNXanA3DT
 ESofIA7Ccu0Hg==
Date: Sun, 22 Nov 2026 18:11:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add Ilitek ILI97680A
Message-ID: <20261122-talented-reliable-beaver-fb09ee@quoll>
References: <20261120-vantage-panel-v3-0-00b306146240@yahoo.com>
 <20261120-vantage-panel-v3-1-00b306146240@yahoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120-vantage-panel-v3-1-00b306146240@yahoo.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 09:23:12PM +0530, Venkat Yadlapati wrote:
> +required:
> +  - compatible
> +  - reg
> +  - vci-supply
> +  - vdd-supply
> +  - vddio-supply
> +  - port

Drop port here

> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "motorola,vantage-boe-ili97680a", "ilitek,ili97680a";
> +            reg = <0>;
> +
> +            vci-supply = <&vreg_l13b_3p1>;
> +            vdd-supply = <&vreg_l11b_1p2>;
> +            vddio-supply = <&vreg_l10b_1p8>;
> +
> +            reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> +
> +            port {
> +                endpoint {
> +                    remote-endpoint = <&mdss_dsi1_out>;
> +                };
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c4f4e48774d0..e2a8093c328a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13040,6 +13040,12 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
>  S:	Maintained
>  F:	drivers/usb/atm/ueagle-atm.c
>  
> +ILITEK ILI97680A PANEL DRIVER
> +M:	Venkat Yadlapati <venkat.yadlapati@yahoo.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
> +F:	drivers/gpu/drm/panel/panel-ilitek-ili97680a.c

There is no such file. Drop.

With these two fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

