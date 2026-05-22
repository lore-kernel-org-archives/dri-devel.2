Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0132ECD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D2B10F392;
	Fri, 22 May 2026 06:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hFzc0JZP";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDD010E245
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:32:30 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso4678477f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779431549; x=1780036349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=cu9DBbAXcmIE6VMEm/Kiq9S+AfKSqe00wCUS0ELv6nc=;
 b=hFzc0JZP6ejF8nyWYDr6LZHkRdA1e7mM9ATjNaXou+SDqLdh+V82Vu+CCJ8Wv5a8JE
 XjvBWqROVCgiXEc7axkx08Uv58MmG2cBtYb8D4VZHmrJSKrTLPQMBsRl2ADLzeiDzYU1
 FeTebAkwShjhsJVWGky0poXJtS7xy9ycmK+r88gqmkeHKN3S4rl+PAA0x2ZRzI+30f1d
 pJb2urOl6q50az60qQ9nMo9Tm4ikbDNqRgoBb+QF2AZKli6weTw7g8oLLJrP72geVqS4
 hkX4DSVyVBP0V/4U718r4j5d0NTBtObYSlXYnXVbtd+AH/jvSvL3AA4wkE5AmVisQMeu
 6z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779431549; x=1780036349;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cu9DBbAXcmIE6VMEm/Kiq9S+AfKSqe00wCUS0ELv6nc=;
 b=Z2e5sPwUckGHFBEjR6AJrAh0MVMWetnvScFFodArM9OaznpZHqXKel5yH4Zz71XToQ
 vMEfW16G+ghHZPOaHpSjq3BDOleWFeZG5srRpjF0psGllBUPzUyGG12sgxgvYOVFg9Hc
 G+VV8BvGwd+7bjZRwJjA8B4kiJzkX/BGXCqoYc1SDjuQs3GrOvE0FSpulCwErkzFDvUf
 4iKXt+a0yYtM6JT9LSL9vvfAhEdMdhGeWtlTmZG3FOKIJw+MuW0OEXNNTCrMbwGI7Q7O
 9ceXijldq2QxIbIsgxk72MotDt2SSqbBICdFrqsh7SDtzA3iVslqlWeqEtqC8rZZYdhv
 ehwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KSnLqqrf8UOeUlIL8LgWz57amTQylPI1ypNUp/GxjvY0KoIHJIgAKPuKFqI/DDUgECrEgLZChwG8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPIb3gU4rT8uzjfEurQkZR4hb/ScW0/jiPZdlazpLkKvm4Bc95
 KjuNYfYEXcbXtAnWRGhIYf8ECIQgRH0M48+tj9GxVebfGr/8mvG2hHJ595OWSvoUXb0=
X-Gm-Gg: Acq92OF4AFByRqyX+/GFjhqrd6aQcYp8UP212biL8Uti2xsrDMg0fYPJ+GerfV/txMq
 3feC53EoFj2/tBs6jU55NK6HWo4KXTxgaANUtq2vlcZKeQqxZbMwNQv+YHZLSHyiAF7I4/svj6Q
 yzhq+4AgPdRKpiqLLSvDhsWKsJkh/NNjmKdvBUvF/n9D5TsRD3HAHiLQI0eLy7o97gEHbtwHNE9
 mQXyV1C+jkeLON9ZR2lguVHjCNiCBtS79dorkuMZy2znkX7+nkGgs7Ow/nrvwlKdMJKpfpLRsr3
 hWuW+nYEK/o/BvJBuuhfGqx0TNvOKRePpP7vAPU4mEzrY6ngwEAdl0cItjJoNtafUzDvrmBu/QZ
 wZcO2zP9ZHrHjqe/byjkFnDTcgvpn+9mFclNFqK/cCEggrs5n+I2lPpmi8m8Bc3gJWGDjKbO2Lm
 gGVRO6G/ZK612PlREOsohLaRV7NmkxMff6LCBzYncQRGiXclphIPyWALz45FTqiySZztJOs64ZG
 Fdll4Y=
X-Received: by 2002:a05:600c:a410:b0:48e:8741:fd3d with SMTP id
 5b1f17b1804b1-490426ab78dmr22498335e9.14.1779431548511; 
 Thu, 21 May 2026 23:32:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:192b:8d21:b456:cb51?
 ([2a01:e0a:106d:1080:192b:8d21:b456:cb51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904174a145sm14887925e9.0.2026.05.21.23.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 23:32:28 -0700 (PDT)
Message-ID: <e0713238-886e-4ae9-b8b0-52e355e51edd@linaro.org>
Date: Fri, 22 May 2026 08:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: display: Add Synaptics R63455 panel
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
 <20260521-sm8650-7-1-bonded-dsi-v4-4-a4dd5e0850f1@linaro.org>
 <2w6cpuzwxht2dv7a3xj57ukuzqa2b77ba2syl2ewdmq5bprczb@g3rm2k7e4l4h>
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
In-Reply-To: <2w6cpuzwxht2dv7a3xj57ukuzqa2b77ba2syl2ewdmq5bprczb@g3rm2k7e4l4h>
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

On 5/21/26 22:24, Dmitry Baryshkov wrote:
> On Thu, May 21, 2026 at 10:46:06PM +0800, Jun Nie wrote:
>> Add support for the dual-panel system found in the virtual reality device.
>> This system consists of two physical 2160x2160 panels, each connected via
>> a MIPI DSI interface. The backlight is managed through DSI link.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> ---
>>   .../bindings/display/panel/synaptics,r63455.yaml   | 125 +++++++++++++++++++++
>>   1 file changed, 125 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
>> new file mode 100644
>> index 0000000000000..a94b355ed9557
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
>> @@ -0,0 +1,125 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/synaptics,r63455.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synaptics R63455 based dual 2160x2160 MIPI-DSI Panel
>> +
>> +maintainers:
>> +  - Jun Nie <jun.nie@linaro.org>
>> +
>> +description:
>> +  Synaptics R63455 is a Virtual Reality Display Driver and VR Bridge, used in
>> +  pair in Headset devices. The Virtual Reality Display complex is composed of
>> +  two strictly identical display panels, each driven by its own DSI interface
>> +  but forms a single virtual display for the human eye perception and thus
>> +  requires a strict synchronization of the two display panel content update.
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +        - sharp,ls026b3sa06
>> +        - boe,vs026c4m-n52-6000
>> +      - const: synaptics,r63455
>> +
>> +  reset-gpios:
>> +    maxItems: 2
>> +    description: 2 reset pins for 2 physical panels
>> +
>> +  left-pos-supply:
>> +    description: Positive 5.7V supply for left panel
> 
> So, is the R63455 driving both panels or are there two panels, each
> having R63455 controller? What if somebody gets a single Sharp panel and
> wants to use it in their device? How will it match these bindings?

It's highly improbable, those are very specialized panels that are designed
for xr usage in pair. Yes a hobbyist could try to use a single panel
but it's only usable when placed close to an eye, and barely useless if you
don't have both eyes.

Let's skip highly improbable use-cases and focus on the main use case of the
hardware device.

> 
>> +
>> +  right-pos-supply:
>> +    description: Positive 5.7V supply for right panel
>> +
>> +  left-neg-supply:
>> +    description: Negative 5.7V supply for left panel
>> +
>> +  right-neg-supply:
>> +    description: Negative 5.7V supply for right panel
>> +
>> +  left-backlight-supply:
>> +    description: Backlight 21V supply for left panel
>> +
>> +  right-backlight-supply:
>> +    description: Backlight 21V supply for right panel
>> +
>> +  vdda-supply:
>> +    description: core 1.8V supply for panels
>> +
>> +  ports: $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +required:
>> +  - compatible
>> +  - reset-gpios
>> +  - left-pos-supply
>> +  - left-neg-supply
>> +  - right-pos-supply
>> +  - right-neg-supply
>> +  - left-backlight-supply
>> +  - right-backlight-supply
>> +  - vdda-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    &mdss_dsi0 {
> 
> Please drop the MDSS specifics, there should be one (or two) DSI busses,
> driving your panels. The rests are details which are not necessary for
> the example.
> 
>> +        vdda-supply = <&vreg_l3i_1p2>;
>> +        status = "okay";
>> +
>> +        qcom,dual-dsi-mode;
>> +        qcom,master-dsi;
>> +
>> +        panel: panel@0 {
>> +            compatible = "sharp,ls026b3sa06", "synaptics,r63455";
>> +            reg = <0>;
>> +
>> +            reset-gpios = <&pm8550_gpios 3 GPIO_ACTIVE_HIGH>,
>> +                          <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
>> +
>> +            left-pos-supply = <&vpos_left>;
>> +            left-neg-supply = <&vneg_left>;
>> +            right-pos-supply = <&vpos_right>;
>> +            right-neg-supply = <&vneg_right>;
>> +            left-backlight-supply = <&backlight_left>;
>> +            right-backlight-supply = <&backlight_right>;
>> +
>> +            vdda-supply = <&vreg_l12b_1p8>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                port@0 {
>> +                    reg = <0>;
>> +                    panel0_in: endpoint {
>> +                        remote-endpoint = <&mdss_dsi0_out>;
> 
> What is mdss_dsi0_out?
> 
>> +                    };
>> +                };
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    panel1_in: endpoint {
>> +                        remote-endpoint = <&mdss_dsi1_out>;
>> +                    };
>> +                };
>> +            };
>> +    };
>> +
>> +    &mdss_dsi0_out {
>> +            remote-endpoint = <&panel0_in>;
>> +            data-lanes = <0 1 2>;
>> +    };
>> +
>> +    &mdss_dsi1_out {
>> +            remote-endpoint = <&panel1_in>;
>> +            data-lanes = <0 1 2>;
>> +    };
>> +...
>>
>> -- 
>> 2.43.0
>>
> 

