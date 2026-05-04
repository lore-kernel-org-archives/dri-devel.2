Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D36CD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 07:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCCC10E109;
	Mon,  4 May 2026 07:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vneemD7R";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A7710E109
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 07:00:29 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so41482665e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777878028; x=1778482828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/ig2G9MuhX/zFTO0paqrpp7sX2tVVOFfNXEQnXrmaj0=;
 b=vneemD7RIh5FT0f0B23dKprpP3zULrZkC9lQ/oKvwguvzsyyLF5HdA8Ci9dtdG/Ih9
 9BW8yrBgYKZVkR4S8Zx4Hd2n3Sztx4LyvIlJbedBVEHbjdtJA/uG1anue0BWjt8gO23w
 EZRG9d0sT1zBiePqwfSaVTSp486ploP1VaazCNonCozzT+pOEvinj3uVJW/gYc+J9WV1
 sfLXJ5/njD+wJydmVT0njqRLNbi3RrECH2ajQssWHqUigoulkzsRnVPZFqLIh5XfMm+v
 RcDNO8ZaqByJ2xBm1VP6UrqApxepFAECVCjFhIcCg5S1ckKlQBnzA4nzJreEsIoSCrfc
 /7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777878028; x=1778482828;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ig2G9MuhX/zFTO0paqrpp7sX2tVVOFfNXEQnXrmaj0=;
 b=W2Qun8oRHGcXkBmEGIhBP8gslJRbuDvUbHgv/jgTVU65q4P2N1RM2wk/yHDfw/svHD
 WKsNqAZ4JZw3/tYtdnEY94R8oF3FGtgwkon2nyTz5PPJ17adnmiaPJJGzqlSmXGVjgIg
 Xiv3xLK6wBgSdvWbdm5TWnATemHQIdLASk8vC2vcxFn3Qb23k2kRtvdLwyn3/lPSLqDu
 xQL2NVu0s73Ng3t31FJIBiPhTPHec+pbRT4wT7Pl/mOhT/bI/B8GgYK+YuoEhrlg/Bwu
 qWRHvMZiHbQ3c4R7WzMXxZUXUofft8W6vnj0AkR5qbs/RhZZZ9+HdX0royaCrFgMRBdC
 y6oQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0WU8rVwHBj+mHRg1BPH24YtT1uqw/23nVz/qNINFJVAKWaixLiGJ4BSimOCpEf32RuQXCjjKB4Kc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZABY7sethVYz4BT+un2WxnZAyfNkp7sHsVi3SWhw4Aew0ZgyG
 SMOnN7pwmPcOyo4vTvV2LvTbH7xFHkjt5UTRqZQMEICg5omLJrOkD13rZefaKTC2yqvjgHSbuXs
 JOV+wOC8=
X-Gm-Gg: AeBDietwVHsf3DnQLZ0Glos5+seh39bYMmDsxPRVBh4M/VKwPsfAPeHyZA0NQVMFUCv
 WrX6IVZKid8IlNLNK+hYKmIUqCWT5NNRlE8643myAN+RSsnZjjWhZ14rYhOxQ3d1k8R7MyXfaa3
 Kw6ogHKhQXOcbBT7BNxqsHLBercK+evTstWVfDpa6MRRvP2MCnQ3ViPMPeXv7hcvgE0Da5eTj1k
 hbSU1rOMo0WZn6zJE3+ls3oP4cjUp60p1ybXvoeAYPM1Phe5eHqNWdgTuR/hiMeaNajb4b7c7fi
 nvPLwVrBAWj3zBjBhDy210JNmPw7ojZJ3WMozt3gBjGkTlGLTzfkPdr41k8wHFFxGbl7Ur6s2mO
 yuWj0SyhWwB7K55VMH88azDJiaWNRvS/Q1fZXRbOpbEJhwP0yOnlAMY2FfFfI/rU88lQF+GhJZu
 fdZ1Q1v1oHpSCWOqG5vJOM48Lq3lL5YOuUM94BIKl3E8GDZwIPIXvbYm02XUBDU20KagbPyByY/
 Ggc+Z2UdIHfM41kCg==
X-Received: by 2002:a05:600c:620c:b0:48a:97b6:7420 with SMTP id
 5b1f17b1804b1-48a98670f8emr134808975e9.24.1777878027763; 
 Mon, 04 May 2026 00:00:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:4245:af61:1735:3752?
 ([2a01:e0a:106d:1080:4245:af61:1735:3752])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebb2fa5sm213757985e9.12.2026.05.04.00.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 00:00:27 -0700 (PDT)
Message-ID: <d673c19d-f659-4549-8c2b-d64bfb0f9acf@linaro.org>
Date: Mon, 4 May 2026 09:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: document the Renesas
 R63419 based dual-DSI video mode Display Panels
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org>
 <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-1-91ac10453d0c@linaro.org>
 <20260503-magenta-aardwark-of-order-432352@quoll>
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
In-Reply-To: <20260503-magenta-aardwark-of-order-432352@quoll>
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

On 5/3/26 14:34, Krzysztof Kozlowski wrote:
> On Thu, Apr 30, 2026 at 02:22:17PM +0200, Neil Armstrong wrote:
>> Document the Renesas R63419 based dual-DSI video mode Display Panels found
>> in the Ayaneo gaming handled devices.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/display/panel/renesas,r63419.yaml     | 93 ++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
>> new file mode 100644
>> index 000000000000..17f166db3ca3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
>> @@ -0,0 +1,93 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/renesas,r63419.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Renesas R63419 based dual-DSI video mode Display Panel
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +description:
>> +  The Renesas R63419 is a generic DDIC used to control dual-DSI LCD panels.
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ayaneo,wt0600-2k
>> +      - ayaneo,wt0630-2k
> 
> Just like for all other panels (including other Renesas) you should have
> fallback to indicate the actual panel IC, even if it is not used by the
> driver.  Some SW still could fine that fallback usable.

Ack

Thanks,
Neil

> 
> Best regards,
> Krzysztof
> 

