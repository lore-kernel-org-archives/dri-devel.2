Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ED3FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FA310E33B;
	Tue, 28 Apr 2026 18:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KxCGskXX";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7806D10E33B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 18:31:31 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso89532185e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777401090; x=1778005890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vEQVGIrIBH0Yz8YaiGUBUBvBwiXNHUR5MrPKG8s+11g=;
 b=KxCGskXX7qP9FBm6DO+sVb+I+teKNBesWZvGV1EK3kKot1bFZ8X7TZGWGCc45gDivS
 qd3DJDcZtuwirLDM27oBH0F9dH84Io0w02KfxFjXka7SN1bjq1JuYMqf5xqcQcH390k+
 tny24OCcvBjYlJ5RWEb+XOpkPRpGJiX4f0QEtBd3gsmwtvG2LM1i3hBQ+twtci0hB30/
 5bs0T+hNKb/NSnzVsWH7C73UbK8KZZE+00EFwciOmmFhpIYdcJMt4f5Q9bpCAZuEHTlw
 6ygmClcJunSmAwCxL3jaaDb7Y6pMbLY0FLZrh66J1EQlUk3Nd/MK0N2wLP/dCyzyPTeT
 PDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777401090; x=1778005890;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEQVGIrIBH0Yz8YaiGUBUBvBwiXNHUR5MrPKG8s+11g=;
 b=KVGpUAvtU/3BAWVusEqhuaS3mBCkTxGfa5s+4/QgOkO5+wLZoluwRmtAM3uqDoT/7e
 hsqXwN1GN/ohPiOK57JtxCAtDS9KHPdoycdeslYqw9m2esvy3jdqaGkeKwwMq2QM3IKX
 tJ+qwsFuu2Tkf/3tTi61gOlS1U6GrDWhexXf50XsRm95jchMZhoa55YjcUfI5+vEhPgw
 t2rKNk4oyQY3k1/y7kxEMH4fzjLe20sIOkrBXigxqaMTucJW+XurFdCfKQLy7GRKKTQw
 j+yVj3SpJIzEcml3rUxuqGPlQDc1ptbt5f61DM4ROwqqYRgP6SjS0bshNr9JDiZWNO20
 H7oQ==
X-Gm-Message-State: AOJu0YyqfCpkrAW8IpM5C/aaMlzX8vKQHGdEq55l5lx8qAUn9P/JZNe2
 IUqBJnWsVgY3AWTnfezZG3Rk1zZ8+voEEuY0Ike+Spmpbe59RLXm+I8yJMQ5b4QOHRY=
X-Gm-Gg: AeBDies8eT+/0U0TfmlbiWXzbcLxh/FrQkLBz2Kn4rNbUijDxs0l1tw/432MG5auy45
 b7zjb/HNggZumfKYgeG37LofmyTBYCbA8vf+PzCUsFJBsuD6QBgT/lloZ1No2Z+VzIml6GMiB7u
 BvpUA2X1E5OG048yoWeSlI29bBU6SwogFqyjVtI14TXmtVVNTsRyXfK3EVpr4VSNiNDb399Ftvo
 yU2CIAf6YKpUNCgPunlF79bPsG+jT+tfJIC+TPhHQM/X2uNuPsK1GPJOzFK1rLagRa7Ots9qUDl
 V3bZRrxtzBkjMdtAdCrwH28KXowtl+FQhyJm0/XeL1yiNAK041omSmL27RDtI3zmI0y5uBxwzPV
 XyEUNua1rzeYMKUgbfMGvfXbuhcgkcQpKG11lnWuDrA6oInSrJ8oXFLF+QnlKvm6Y/YGgh9z9/0
 2CwDqryNUs5gZPGLmLQfTGoprGWOfURSDp5k9mpI6sK+GcbivRlkyULYlIVUzZp+LTW9YT/wt1L
 98WAnrXFDiceCnaqg==
X-Received: by 2002:a05:600c:3541:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48a77b19c77mr68824085e9.14.1777401089712; 
 Tue, 28 Apr 2026 11:31:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:48b8:3c11:f42e:f0c3?
 ([2a01:e0a:106d:1080:48b8:3c11:f42e:f0c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463fa890a6sm7481259f8f.30.2026.04.28.11.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 11:31:29 -0700 (PDT)
Message-ID: <efd6dd15-ab9a-45a3-8f53-2a5516284830@linaro.org>
Date: Tue, 28 Apr 2026 20:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: document the R63419 based
 dual-DSI video mode Display Panels
To: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-0-981eb5ab5a51@linaro.org>
 <20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-1-981eb5ab5a51@linaro.org>
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
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-1-981eb5ab5a51@linaro.org>
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

On 4/28/26 16:05, Neil Armstrong wrote:
> Document the Reneasa 63419 based dual-DSI video mode Display Panels found
> in the Ayaneo gaming handled devices.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   .../bindings/display/panel/renesas,r63419.yaml     | 92 ++++++++++++++++++++++
>   1 file changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
> new file mode 100644
> index 000000000000..5777930aac78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/renesas,r63419.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R63419 based dual-DSI video mode Display Panel
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description:
> +  The Renesas R63419 is a generic DDIC used to control dual-DSI LCD panels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ayaneo,wt0600-2k
> +      - ayaneo,wt0630-2k
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +  vsp-supply: true
> +  vsn-supply: true
> +  vci-supply: true
> +
> +  backlight: true
> +  reset-gpios: true
> +  ports: true

Please ignore this patch, I forgot the rotation property.

Neil

> +
> +required:
> +  - compatible
> +  - vdd-supply
> +  - vddio-supply
> +  - vsp-supply
> +  - vsn-supply
> +  - vci-supply
> +  - backlight
> +  - reset-gpios
> +  - ports
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
> +            compatible = "ayaneo,wt0600-2k";
> +            reg = <0>;
> +
> +            reset-gpios = <&gpio 176 GPIO_ACTIVE_LOW>;
> +
> +            vdd-supply = <&vdd_3v0_lcd>;
> +            vddio-supply = <&vdd_1v8_io>;
> +            vsn-supply = <&vdd_5v0_pos>;
> +            vsp-supply = <&vdd_5v0_neg>;
> +            vci-supply = <&vdd_3v0_vci>;
> +
> +            backlight = <&backlight>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    panel_in0: endpoint {
> +                        remote-endpoint = <&dsi0_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    panel_in1: endpoint {
> +                        remote-endpoint = <&dsi1_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> 

