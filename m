Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18220CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3694410FEA7;
	Wed,  3 Jun 2026 13:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Er4kZMjk";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD52810FEA2
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:58:33 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so3766973f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780495112; x=1781099912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uRGP5npAnw6bhYXF7IBZn80+XY3pb3wy/EBvJAjC4Ew=;
 b=Er4kZMjkP2bg13KHyB8Ya+8Hu0y+YnieDLh6DY+y/8eqzzsHL3jW+yFUHOpIVKZiuo
 D9LaR2tF4xnw9vSmYIgSahtpl3qzboNBHVd9hXqre6XLNobz+jMpkL57tQYohulK69mA
 dhP5mPPtLlbIgIMkTBdvy6G5fYz14bMeO8fW7IJEIF47qF/D6D62hLix6K07IF+FtL+9
 tCIOjxY7Ragh4F7IgIhO5cUKPwQ1P8P3vI2yM995YbAs2LUBfIjMAJz0xGPhQ9xf9WIA
 JPzcmoylWC7e7LdeeWKI1hqSfoG4yVyFnkIIMT/BHuSZq2aKZHesHdDeaJ0nbpDnnTJ9
 jGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780495112; x=1781099912;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRGP5npAnw6bhYXF7IBZn80+XY3pb3wy/EBvJAjC4Ew=;
 b=RGmL9PKfDhBmdhWIOVIJirI1kBhC+D6bT1Ec0LsgAAouRJ0RIFKYCsPuf3WbCeq2EB
 O3u1T67p96z1eGittm1J8JrIJBjrWUVf/6XT9zjbgpUZILJfMgWX8cvOGfNEJa7LjsF3
 mSmq5djJH9ux94wluwy0D80npgoPJQnmE07A66QgagPCzcCRO6UJHLhd+UGh+I7N7ZJd
 Z0YRGpct1uQWAvRTvbftayhio9lZ5UxFt9mu3Wc1+Tef1N/wDKXl9R7OF/Xlv2ZdxmCa
 3aPq1Q9IPpOWj9hPVKL2CRJZUwBWR3Z0qgHHjhu42YqTluiXROAqdXspnsEYYl+xtepH
 /mSA==
X-Gm-Message-State: AOJu0YzhmIrq0BZHBpyPcQ5cj31DRiXG/0I7xNQE03J45Om+VWlJcXyp
 QzOFLXjBuQdT6icJQ3a+kM5ydE3r8dLmqkculWpYVyCKahqnmVTBsAlL45zAoQNeLVs=
X-Gm-Gg: Acq92OH3lT3hgVMF7BVybc1ZnLGkInpxXNcgpxJRRgJbjL3BIsI8lw8fUtmju6Oyjgn
 HPotz42gcVGnf05t8M5alQKEqPnJsvmzroNA2j9Mw72DoZPVcTRfTiwF0aZFGietTwn0rFyeVlg
 N6vNgLmPapmr8GarQOPfyI20Ea71mVcE1mJLlUko7m9BdX3RpEkaBdXwaCZASAAQ/bjx/E35VbA
 Yt5KVQRmQQLmlcvEIBRWRh7Ezdp9/X1s9Dmd6HXvtfWHJVbopTtmPhmmTHt+Wxn4etU1q9+T8hr
 /P1QkRW0cqwfHAKkvVJDDgK+MOgIa+uiIBNhFWZ5IuxSv7QUgHpjEQLJ660z05pYPLmePpF4yfN
 vpfCtsLYQ9zWU5HBzPNWnYwogG4wCidRlfj7qbUhSrMJOn8cyqXBnEfiyda5CNWW4gtVW34pmd+
 /3VJnUOvYPN+KTHrw7jzs2ryhAliolCNv/4Disz/Wl6hyeuqaSFtwEwp/ID1QFsqlZ3pa/jJaIH
 w+MYmtS5U2O7z4=
X-Received: by 2002:a05:600c:1392:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-490b5e8cb8amr55769715e9.10.1780495112132; 
 Wed, 03 Jun 2026 06:58:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e304:c6d:bb75:4f69?
 ([2a01:e0a:106d:1080:e304:c6d:bb75:4f69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344558sm8093399f8f.18.2026.06.03.06.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 06:58:31 -0700 (PDT)
Message-ID: <4a7c19a3-bb00-4a68-beea-146ef65f9e5c@linaro.org>
Date: Wed, 3 Jun 2026 15:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Document BOE BF068MWM-TD0
To: Alexander Koskovich <akoskovich@pm.me>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
 <20260603-asteroids-panel-support-v1-1-109c6ac81c8f@pm.me>
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
In-Reply-To: <20260603-asteroids-panel-support-v1-1-109c6ac81c8f@pm.me>
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

On 6/3/26 15:03, Alexander Koskovich wrote:
> Document the BOE BF068MWM-TD0 6.77" 1080x2392 AMOLED display panel used
> in the Nothing Phone (3a).
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>   .../bindings/display/panel/boe,bf068mwm-td0.yaml   | 77 ++++++++++++++++++++++
>   MAINTAINERS                                        |  5 ++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.yaml b/Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.yaml
> new file mode 100644
> index 000000000000..840ddff709ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/boe,bf068mwm-td0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BOE BF068MWM-TD0 6.77" 1080x2392 AMOLED Panel
> +
> +maintainers:
> +  - Alexander Koskovich <akoskovich@pm.me>
> +
> +description:
> +  This is a 6.77" AMOLED video mode display panel on a MIPI-DSI 4-lane
> +  interface.
> +
> +  The panel also requires ELVDD/ELVSS/ELAVDD rails but these are
> +  internally managed by the panel via EL_ON1 (ELAVDD) and EL_ON2
> +  (ELVDD/ELVSS) control signals, they are not managed by the platform.
> +
> +  The driver IC for this panel assembly is an RM69220.

If you know the DDIC, please switch to bindings & driver around the RM69220 DDIC
instead.

Thanks,
Neil

> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: boe,bf068mwm-td0
> +
> +  reg:
> +    maxItems: 1
> +
> +  dvdd-supply:
> +    description: Digital voltage rail
> +
> +  vci-supply:
> +    description: Analog voltage rail
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - dvdd-supply
> +  - vci-supply
> +  - vddio-supply
> +  - port
> +
> +unevaluatedProperties: false
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
> +            compatible = "boe,bf068mwm-td0";
> +            reg = <0>;
> +
> +            reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
> +            dvdd-supply = <&vreg_oled_dvdd_1p8>;
> +            vci-supply = <&vreg_l19b>;
> +            vddio-supply = <&vreg_l9b>;
> +
> +            port {
> +                panel_in_0: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9f2780b2d31..63d0224bba3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8000,6 +8000,11 @@ S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/tiny/bochs.c
>   
> +DRM DRIVER FOR BOE BF068MWM-TD0 PANELS
> +M:	Alexander Koskovich <akoskovich@pm.me>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.yaml
> +
>   DRM DRIVER FOR BOE HIMAX8279D PANELS
>   M:	Jerry Han <hanxu5@huaqin.corp-partner.google.com>
>   S:	Maintained
> 

