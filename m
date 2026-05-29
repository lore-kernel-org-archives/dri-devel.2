Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC6ECD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A43F10FEA6;
	Fri, 29 May 2026 12:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UX8fUbkK";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F3310FEA6
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:50:46 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so522312f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780059045; x=1780663845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=gsdtKyBNIze1lqIATJulyFXg8jvRauNrlgVPkVHHWJU=;
 b=UX8fUbkKbgwkjbZfWozv57x4nyDnsoKsfv02ilMd/gzY2j6W+r1JhfUHpmMjvQfYDC
 mlfBM0BkuUyNIecI4HVT6VMS9X2ts9X+pO/GwhQjPE/6VZcDfgvJ6VeZW5yMY1nonlpL
 8329LByo32LYMfrqtOj+DcaoAzxHRkbK8khjmL+2syxzXh3mvSDmForkjHvnEiu+bhfY
 DvcoZelIkYwPPNNN5EK8OwgaKXMYbuU9w4OsvumQQoM7k++eHoCzDLh0sVH+enpd+HAG
 VtgmNmaCas9FhXeCALE4OhRUYccUyQNrR4lljHmALYO6bZwb2myktRqhMAlCFGGcuQK+
 flpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780059045; x=1780663845;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gsdtKyBNIze1lqIATJulyFXg8jvRauNrlgVPkVHHWJU=;
 b=AQ7zPWI2DxvyWDS3s5AHO1vQv2DguKGTWWPUX9W6QH07ewtxmRNyjRxZ/P+9adf1SN
 dz6xzwJ35OHteLstmH5b0QC81yHR7s57UDtyyArgPpKuNmsit+GHz1MSJV0f1qW6+M7p
 B7YKmCWlmUPlqLGpGJMNyqY8wOf4HD7/GkVTZkEoUtSDJPIK0ePgOa2aGmydaNeG9vYd
 XOjfDUsvE9E2U+2ZRbWkAgBtpqm7EEjqGtBboCKc9eOPxMp96DaBZ3Tg24WMtfUXq6kN
 YABm4CLhTeHapSXUHL4/nAzBb2KLIc6xnZPAjuVHuzSCO228koENWvL8OFL2Dguo0E1V
 ANTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZtbB0rXQ9Y8pV2VOk94Vh7Gw6Bpw7oeRfEvQYQ7s00ybcL8w/wdfORrT+201woCFArcw8xVxaA0g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw35ZAsJYAOUctIkQfNwWPv5aS8H70NbyQupS5wt2mUFqPkPFO/
 3liRmGcskYhpYIK6W76yknhstpKz9GliMrMD02MXM/eLB8LqzgjOhLHkyupMnwJOZPE=
X-Gm-Gg: Acq92OE5Oq3I4YCXjjWKonZv3ZIT+7iJkxc74ZfKVEH6y2FOnEgtJDGAiqMhygPlGWB
 YBiQIg236CJK/fDrlOvMgePOxhA8TtmEkgApBhoRwK3iWRfdi3UP3zbF/18hHtkbYowSPiWfXnb
 C2HWC4oghkeJ339CWL2VZrhUNkj3dhU9TVP0J8J80RNIdtU2XlnMHsI74VE1O7WA7Addjyjq5l/
 MMYkeMyh2sM1m3qIQYoY7vv7b8QftHytLL0TeYNj035BeYUt0ktOZTHOoiEjNwAeYkGldM9FbSz
 xZo6ycb2mU/Xla2m0bQoCSNlYsJDblvULmrswhqKNhioX4LTdlPF+D79gclCYZS4ZHJeHM1jiWl
 AuZ3VLeODHdmloc33Hf5oNiTwcNe+XEyWtH2m6+ZVoZXWqVIRbuQbBHpuB++npjUV6WBEYeyzVJ
 Vp4oxDcEPZEoQpk4K2dn2bxW9QfBO/viIDOnQV3TJKz4c6A8UBXdSzewh/Tx8Nqe4tD5YNc6sr1
 6tzBXbZXu6j/jFrg9iTqt3LgDR4
X-Received: by 2002:a5d:5d0c:0:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-45ef1403b76mr5200312f8f.15.1780059044315; 
 Fri, 29 May 2026 05:50:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b6d0:a628:be51:f552?
 ([2a01:e0a:106d:1080:b6d0:a628:be51:f552])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354b5bdsm3169110f8f.21.2026.05.29.05.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 05:50:43 -0700 (PDT)
Message-ID: <4001cf6a-b7de-4933-96bc-c9b4ccb53e4d@linaro.org>
Date: Fri, 29 May 2026 14:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
 <ahllT_HVTAJ5MbkS@aspen.lan>
 <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
 <ahlr5PnX5O0tEd6G@aspen.lan>
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
In-Reply-To: <ahlr5PnX5O0tEd6G@aspen.lan>
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

On 5/29/26 12:35, Daniel Thompson wrote:
> On Fri, May 29, 2026 at 12:16:07PM +0200, Neil Armstrong wrote:
>> On 5/29/26 12:07, Daniel Thompson wrote:
>>> On Tue, May 19, 2026 at 10:43:38AM +0200, Neil Armstrong wrote:
>>>> Document the Silergy SY7758 6-channel High Efficiency LED Driver
>>>> used for backlight brightness control.
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
>>>>    1 file changed, 53 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>>>> new file mode 100644
>>>> index 000000000000..80e978d691c2
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>>>> @@ -0,0 +1,53 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Silergy SY7758 6-channel High Efficiency LED Driver
>>>> +
>>>> +maintainers:
>>>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>>>> +
>>>> +description:
>>>> +  Silergy SY7758 is a high efficiency 6-channels LED backlight
>>>> +  driver with I2C brightness control.
>>>> +
>>>> +allOf:
>>>> +  - $ref: common.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: silergy,sy7758
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  vddio-supply: true
>>>> +
>>>> +  enable-gpios:
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - vddio-supply
>>>
>>> Sorry for missing this in v2 but is vddio-supply really a required
>>> property?
>>>
>>> It's unusual for supplies to be mandatory (and the it is not mandatory
>>> in the driver implementation).
>>
>> This device is a little bit special, the VDDIO regulator is used to provide
>> power for the I/O via the enable input, so basically the enable gpio power
>> level is provided by VDDIO.
> 
> I don't follow. The EN pin acts as both VDDIO and as an enable but it's
> still effectively a power rail isn't it (albeit one with very low current
> draw).

Here's the datasheet description:
```
Dual-purpose pin serving both as a chip enable and as a power supply
reference for PWM, SDA, and SCL inputs.
```

The VDD input is directly provided by the panel, so Linux has no control
of it so I haven't added it.

> 
> It looked to me like the correct way to model to two power rails
> going into the chip is vdd-supply (main power supply) and vddio-supply
> (EN/VDDIO) I don't understand why a single pin needs both a regulator
> *and* a GPIO in the DT bindings?

I don't have a the schematics of the board, but as I understood one gpio is
actually enabling an regulator which provides power to the IC (vddio) and
a second gpio will either drive the EN signal to GND or VDDIO to provide a
clean rising edge on the EN pin.

So it's not really 2 regulators, and having regulators means the enable
signal can be shared and would have regulator characteristics which it hasn't.

> 
>> This is the recommended way from the datasheet, and I assume it will be used
>> like that on other platforms (if it exists...)
>>
>> This is why it's mandatory and enabled first before setting the enable pin.
> 
> It's not mandatory for the C implementation. devm_regulator_get_enable()
> will provide a dummy regulator if the property is omitted.

So yeah if you prefer I'll re-spin with the vddio regulator as optional
because between both, the VDDIO is the only which could be shared with
other devices or always-on.

Neil

> 
> 
> Daniel.

