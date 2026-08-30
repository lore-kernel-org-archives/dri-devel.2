Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC26C61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 13:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305D210E1C5;
	Sun, 30 Aug 2026 13:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q4XsDNcX";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C21410E1BD
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 13:01:05 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so19467735e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788094864; x=1788699664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJWD3o3HQBZZ/WZYdRYAGX1zvKwfbjT6qB/Y+mCi/aU=;
 b=Q4XsDNcXDKxf0VFAELLFYnNkb0EX6nT7oxKjm3qrK2In3u6RYqzF2k5+ENFICgfbv7
 G3oXMZYoPx8Kwsl+nnS8SS1wPc/vazfBijU+Z6p3Wy1DEtOnSbx642WCI+36w9RTRPlz
 sGyBm9dI7cn76ARIHoQPtLqQG4RPHo/nUX72tFOch38Xb9kKpJ3y51Otrnit/1f3qz4f
 QvMLGMHpSVZvxxs3T0f6ACQzp7nW14Y5NoA8cTAqpeCLpcz1ej5ZFZjujqXviL+J5yic
 1ZCxLKbfQlmH2cVgxQ9oY0nwV5kWEggZ1wa/0Ab7pt20r/GyARaOQrBgeeBX+VInWSx3
 BxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788094864; x=1788699664;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sJWD3o3HQBZZ/WZYdRYAGX1zvKwfbjT6qB/Y+mCi/aU=;
 b=MX0Q5BrFVfX9Ep7CwWaSMmut6zgU5Pcc2bU2dhpAxpzFDUHl6oR26a9nkpyX9QNace
 tjiL9gf9Nf7ihCLcI36kGy31/G0uNJsRHuKLhy+pmI2TUNfejGaMnQmJLMegJ8psPyVp
 dHXTH+oyc7o44w+zs2F+j/q7ayjMWUJnveAxUc+kVZxc8XW+cPsRu1838zZS3jeoA5AG
 aBeJu2227Bl+kV3rS/4RhmCRwXKtgjmKh2BRvkl8M3fSrukpTyb1Wv+uX2PDggCOPoBh
 vLswUx9suZdBFhnp71KSzXqSVYiovIpMb0y9kh0GxZpIfwZiB0mp5415ymdpAF9JH3Jm
 ZWiQ==
X-Gm-Message-State: AFuF++mcZ158NzkqRL6jI/yDoh2gxUf6kZcSOTtr/7vZ+d7et4ZllASL
 ma4MYk8I0CeCTobODhocljZ6NGsz7WaSDWhM8qBiP3q0EXBQBd5yKS1x2CqpbIBLPQQ=
X-Gm-Gg: AR+sD121qhXO3XRmtjjIsbJpVWuOBnvq1y0mCTDE0a5vNZJx+9DPMyML/xDEFQxub+/
 gxJoS3RGsZ4pu3R7N8PusrvQnt7DNXwGjY9IjiLjkAbTid/SElPLxsOZI9TSAof/Rds8ZH5iPJa
 c356CgoCnoRxYedm8w9H1cfANRh4Yd6tGvwLNLndOYW1epZMmrH3HI5xVsP1iGOE9CB2gFulvCH
 IEPTNO22Mt7R8DQRpX/LkMTXcEMcypy+dOhuwOqW2XOzAmq0yhwDjUudl0+lojqTq62H2B+yyXF
 HFO9OqadZ399CKoOHJRk9oxfONEfaESHGe6LYNeKl3EevBUkcw4H2T0lG3arjdHLxTIiI8rC0gz
 p6Ro4F0huaawLP63D1396c/v+QnHbPm6QgBlliTRrVShFcBVcqOl6IUF+W70ZRlrCWOzw5MdFCl
 gOAMVUsTiZHMuLzxHN9YTY/MKsunxhJlmFkruHOGYRSGLr3UnEeLmovFqKFVXMO1NZx5I6FvM4c
 2NYlUQ/DQ==
X-Received: by 2002:a05:600c:3155:b0:49b:910c:7703 with SMTP id
 5b1f17b1804b1-49b91c3dcb4mr278278415e9.9.1788094863617; 
 Sun, 30 Aug 2026 06:01:03 -0700 (PDT)
Received: from [192.168.1.36] ([83.214.235.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccea87e1asm81979695e9.2.2026.08.30.06.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 06:01:03 -0700 (PDT)
Message-ID: <08cf135f-7fef-4dae-88d5-2ee0a080853d@linaro.org>
Date: Sun, 30 Aug 2026 14:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 1/2] dt-bindings: display: panel: Add bindings for
 Novatek NT51021
To: Nickolay Goppen <setotau@mainlining.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
 <20260829-qcom-novatek-nt51021-panels-v1-1-cc1ca61bd261@mainlining.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260829-qcom-novatek-nt51021-panels-v1-1-cc1ca61bd261@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/29/26 22:09, Nickolay Goppen wrote:
> Novatek NT51021 is a display driver IC that can drive DSI panel. It
> is also present in the BOE TV101WUM-NX0 video mode panel, which is a WUXGA
> panel with a resolution of 1200x1920 and 10.1 inches size. It is found in
> Xiaomi Mi Pad 4 Plus.
> 
> This patch adds the bindings for display driver for the IC, with support
> added for this BOE TV101WUM-NX0 WUXGA video mode panel.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>   .../bindings/display/panel/novatek,nt51021.yaml    | 93 ++++++++++++++++++++++
>   MAINTAINERS                                        |  5 ++
>   2 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
> new file mode 100644
> index 000000000000..a3e4ed10e645
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt51021.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT51021 based DSI display Panels
> +
> +maintainers:
> +  - Nickolay Goppen <setotau@mainlining.org>
> +
> +description: |
> +  The NT51021 IC from Novatek is a generic DSI Panel IC used to drive dsi
> +  panels.
> +  Right now, support is added only for a BOE WUXGA LCD display panels with a
> +  resolution of 1200x1920. They are video mode DSI panels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - boe,tv101wum-nx0
> +          - boe,tv080wum-nx2
> +      - const: novatek,nt51021
> +    description: This indicates the panel manufacturer of the panel that is
> +      in turn using the NT51021 panel driver. This compatible string
> +      determines how the NT51021 panel driver is configured for the indicated
> +      panel. The novatek,nt51021 compatible shall always be provided as a fallback.
> +

You can drop the description entirely here.


> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: phandle of gpio for reset line - This should be 8mA, gpio
> +      can be configured using mux, pinctrl, pinctrl-names (active high)
> +
> +  vdd-supply:
> +    description: phandle of the regulator that provides the supply voltage
> +      for digital circuits
> +
> +  avdd-supply:
> +    description: phandle of the regulator that provides the supply voltage
> +      for analog circuits
> +
> +  havdd-supply:
> +    description: phandle of the regulator that provides the supply voltage
> +      for analog circuits
> +
> +  port: true
> +  backlight: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - avdd-supply
> +  - havdd-supply
> +  - reset-gpios
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "boe,tv101wum-nx0", "novatek,nt51021";
> +            reg = <0>;
> +            vdd-supply = <&lcd_pwr>;
> +            avdd-supply = <&lcd_pwr>;
> +            havdd-supply = <&lcd_pwr>;
> +
> +            backlight = <&i2c_backlight>;
> +            reset-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7291238bc09f..6cbf9ee3fa9b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8354,6 +8354,11 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
>   F:	drivers/gpu/drm/panel/panel-novatek-nt37801.c
>   
> +DRM DRIVER FOR NOVATEK NT51021 PANELS
> +M:	Nickolay Goppen <setotau@mainlining.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
> +
>   DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
>   M:	Lyude Paul <lyude@redhat.com>
>   M:	Danilo Krummrich <dakr@kernel.org>
> 

Move the MAINTAINERS change in a separate commit.

Neil
