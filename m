Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2987CD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3667B10FC83;
	Fri, 29 May 2026 10:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jGAEkQ7A";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A864710FC83
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:16:11 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso60295115e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049770; x=1780654570; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zY32vo4wGSfZ5uOAVtxfFcwmsUjSGjI2ELbc4pDk6qU=;
 b=jGAEkQ7ABiSbKhkt/1A67QrI3HMbEfYaRa25pf48hzSEFcsFFg1FEUosNYOPjNEBQ9
 JaPKKSyFglpFk1/FwCy+nTJLdKlHPr9Ex7gtP/B5a8dolGELT64KnPRnHxDpNqKdwEzi
 Ar5f/vTrQBjJJnnRMXxpHARynaA4cQPpD6ulmMqV1jNiO5XfTN39tlxv2XLSByRkEfmf
 4Xz1YsDicT/jiY1l8fO/Gea5w4t33ShLed/c2hxYEF148fqtDL4LA2kBEA/8knDmk8Op
 285O2KpWCoAOt9GXtGz4QzevcGJz0RTlyc6b+jkTQhX0oCO7DK5d2l//vxCcm7BY8HCM
 evOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049770; x=1780654570;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zY32vo4wGSfZ5uOAVtxfFcwmsUjSGjI2ELbc4pDk6qU=;
 b=T/thdAW6QW0zDFNvbn0LOs0QfQ0VNq8gqAKtEoEPudg4uZjEkM6k5w2Vro47uEhKVZ
 FogGzfRwWt7gU1UOpN325SXdwhsVrdByARd0TVebaKbb+Ekxabry0xts8AqXtBBlbO6n
 V94gYSQFKdSWmiriBnKHPo0btMA2K0BraXbt3bh7cyoZMHhZhsLUt/YoFSe/DQ+uPJnh
 Iz1scYVbVQ624Tz878NZFndPdmYAOsuxtWGivt2RRx1HOBqrpiN0eEWFnj0cgcq9WjQW
 amPD3JjUmK/ylTi4SCvfOtUAzkRZAy5+eYUfpCB0OKj1bUBNU13dTucYKW76UeReNkY4
 d+PA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KSqOgaJrPZ3Q6A9Ib+53D2OXDXcEys+9/YAFXYK1ErsvnIOVvFaZd/MGgphbel3f60LflMN/q9N8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfSxntn1rsYVvK/58Wm8kI8YlaBi5oqkTXAJ555H/2YfmwnMZC
 b9gNaA5jg1TYmdCWbPUHYJJaiAkKyelXXlBFa1H4/iZaSdF4n28BNoEouTp+IN2egi4=
X-Gm-Gg: Acq92OF/dr0GvWXkX+4K2s/Gu9t74R36zx/eFM+PGky18zs2SlJEgmotX3UE5qF/2hj
 z+e6GuiyFwLcAlWuMhXBgEL0PrG4WT3wKASMV+N7h7PPAejUHkysbIhH/S2dhlXZ3R1i3bMq6L0
 Oty7vfuALjjFbzdSnkgymDlCp3/i5+o3/e5093QzaIDA4BGLeKe7h3HatfvD9DVaJ+miFwsBr5+
 QZ3DOwXo2NVWjTDZoe9tsYkQChuu5zouUyRSNp6LBA2/gbNepockjfPS+j7otroCLisnuOe5onm
 W7gRHrjqacyNh7ATv0gQCsJoW8+dI24VhDru4piStNZxvHqSVMkP30TeQdVB659FUUeFszf9bm0
 W9+LsHKcV2piUGKGC89kmgCZwo1OZy6AXQzZEQgYl81klJC3vUNrPVBkZ+qoCB2F6OhJJEkOGpk
 rtalV54siMwXUZnVIPXLc50Hlarc2rxUGNMsulkVuyT04=
X-Received: by 2002:a05:600c:81c5:b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-4909c0a7e03mr36047785e9.18.1780049770022; 
 Fri, 29 May 2026 03:16:10 -0700 (PDT)
Received: from [172.20.10.3] ([37.167.116.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354b7edsm2332881f8f.22.2026.05.29.03.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 03:16:09 -0700 (PDT)
Message-ID: <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
Date: Fri, 29 May 2026 12:16:07 +0200
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
In-Reply-To: <ahllT_HVTAJ5MbkS@aspen.lan>
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

On 5/29/26 12:07, Daniel Thompson wrote:
> On Tue, May 19, 2026 at 10:43:38AM +0200, Neil Armstrong wrote:
>> Document the Silergy SY7758 6-channel High Efficiency LED Driver
>> used for backlight brightness control.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>> new file mode 100644
>> index 000000000000..80e978d691c2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Silergy SY7758 6-channel High Efficiency LED Driver
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +description:
>> +  Silergy SY7758 is a high efficiency 6-channels LED backlight
>> +  driver with I2C brightness control.
>> +
>> +allOf:
>> +  - $ref: common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: silergy,sy7758
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vddio-supply: true
>> +
>> +  enable-gpios:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vddio-supply
> 
> Sorry for missing this in v2 but is vddio-supply really a required
> property?
> 
> It's unusual for supplies to be mandatory (and the it is not mandatory
> in the driver implementation).

This device is a little bit special, the VDDIO regulator is used to provide
power for the I/O via the enable input, so basically the enable gpio power
level is provided by VDDIO.

This is the recommended way from the datasheet, and I assume it will be used
like that on other platforms (if it exists...)

This is why it's mandatory and enabled first before setting the enable pin.

This should probably be a comment in the code.

Neil

> 
> 
> Daniel.

