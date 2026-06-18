Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5320FCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A855B10EDD1;
	Thu, 18 Jun 2026 12:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="smDdV6Xr";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD26410EDD1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:30:22 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4633193af19so689591f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781785821; x=1782390621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=T87pQD65CNc83N4OFeqqd6eZRLgKX3mUIa9gwzpc18Q=;
 b=smDdV6XrQK2ayp1Wa7yR2fXG+XvxIG0VKoNUbRz9x7ePWqnnH8uG/w6QpW6JgdPCda
 JNOuFv6cKflnRQ1qO2qjLrtEBU30BW9uykRTDZzdraGidJoBkqigbbHaL9FioYfa6ivW
 GHpLuXTyj2BXz7unmIZs4TP4ohnXGqlnbrX9ypOgCAhcCFCdMiAsaSx90VDGgSPcaPgF
 mhBuzclmqBj8G/+e0oqtqgRlZHm71JqqreVhNeZJnA9XyOEfhwBr1rR954zD5eVsreny
 ZyB3lpY7h3e5kFVT5SKtonlk7ViJ1exb/FgTWEkevvBvvv2pFlhqUQExKDTmgr9l9jyz
 sgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785821; x=1782390621;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T87pQD65CNc83N4OFeqqd6eZRLgKX3mUIa9gwzpc18Q=;
 b=fqdUcvgIPc6GAYIE6WBlu+RQ4Hp9zOGpiZHJdVZh2qDANTW0VkrxZDHkjczyQ/Sr9b
 hNHDkwYouhiNE6GgL89D/LUOTzzx4Dsx52xyM3qPBQHSST0yZWKYiu/9o3TnA/k1Rfs3
 vplWtetm/GSo4M7JH3YiEQz3YohHsHqrv5+QIz7sMk7n4XkY5eYzyV8mqdBzBMCd+bQ9
 BToabIk2U99TYtDXCiW80VBDVijzqchGnkdPfEmGXAJgVrUcEeYF5tPrFJo3dyyXoZRu
 O1Qn+Yj4yquGr0vD8SxGfaMC5e3bPsudqxF6JFU613hOd/9HutIHCUHmRzoB5SF2US79
 RMjw==
X-Gm-Message-State: AOJu0Yz4kU6HWF2AyacecC/X2hHe9z7EM1XaNvVDOsSW21khJp4pVTQR
 QgEWeX3Z7f+cHYUYxSE0GyMp2nbkjdDWagomUz/ZGTfQ0zEDDNg4fgXUyBXKU7FYom8=
X-Gm-Gg: AfdE7clCAbxbdBjppqoU3cOn4HAxY1i7/gkvVI+560iwkUBpizHwAENF3/4yxSORCwk
 /q75MGL+JNKvvFg4EwSqloc6jbqhIQqlrTzA1N+tcXArrQOnQKV9OqpFqbUAIN+mkkUqg3StPUk
 UOdYMCJcyDGSZ22PCvKksd0z2Fdsti9zjwu8GAykIgU24Hj49u2jLDrzTUMHvf7M7eHkxXWnBY3
 OlW3bfzltarSLQWAmKAaS5dP1kEr5+2JIgu1wdWv6fDonkPC7cKXh2udYqqQSbKzs2o9YHtHOI3
 n2zrAU/3KRfx4xP9jafd4VJG1I+l+q8IppFq1+2fTVqe6UZGoLgmjBOrog0E3eCDvDQLDrE+SVp
 3TWHnFRAnAHsVtDbY5OA4+Py8aoAmvfxQ4aOUFGD3si9bPFRj0MpIqcV//1vJgTjWccwQcD6cAT
 S8e+Tgee2eeJv6Py9WuyC/VeK7xiyyIZoKavr70dlY6Eyc/IXxF4nnsSCgPiaPMATssi3AFisJb
 ej4
X-Received: by 2002:a05:6000:2405:b0:43f:dd91:b022 with SMTP id
 ffacd0b85a97d-4641d5554c1mr3156524f8f.35.1781785820908; 
 Thu, 18 Jun 2026 05:30:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6e1b:5a5:b2b5:b2c0?
 ([2a01:e0a:106d:1080:6e1b:5a5:b2b5:b2c0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14692642f8f.30.2026.06.18.05.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 05:30:20 -0700 (PDT)
Message-ID: <a8e62db4-716b-4d9f-abfa-4027bbe0f37b@linaro.org>
Date: Thu, 18 Jun 2026 14:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 2/2] drm: panel: add support for the Renesas R63419
 based dual-DSI video mode Display Panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 KancyJoe <kancy2333@outlook.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-0-b84b6da84293@linaro.org>
 <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-2-b84b6da84293@linaro.org>
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
In-Reply-To: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-2-b84b6da84293@linaro.org>
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

Hi Dmitry, Douglas, Jessica,

On 6/5/26 16:50, Neil Armstrong wrote:
> From: KancyJoe <kancy2333@outlook.com>
> 
> Implement support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.
> 
> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                |  12 +
>   drivers/gpu/drm/panel/Makefile               |   1 +
>   drivers/gpu/drm/panel/panel-renesas-r63419.c | 366 +++++++++++++++++++++++++++
>   3 files changed, 379 insertions(+)
> 
<snip>

Could one of you get a look on this patch so I can reduce my backlog ?

Jessica, do you still be marked as DRM Panel reviewer ?

Thanks,
Neil
