Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E8C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3E010E19D;
	Thu, 24 Sep 2026 13:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hHqklh3a";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C3810E19D
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:15:51 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so440400f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790255749; x=1790860549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CtFgILpoGN9oew1GWkpWJvU0DfUxofN2O/h63lGOutA=;
 b=hHqklh3ayQWlrabWN1aa3QmLrx+3ubzpZZeoA8qtA5h1LZMHp554jgquCJqCtLGSRi
 KUGa+TRDtJr/HM7LKJrVIVvkfimYPOLSJ8xJPmQS1rgDDxFlhfZOLlE1w3KwbKJCQWVV
 Op397q8alw7PxjkF5wjQ2KDPIUY4sniBatS0nnmp+Z2+MVCtXOM6NsOMB+uB1z7X91Yj
 mGpYmjigiFltufFFDKB4MxC/F02VA70uNHKnOqsMxyjeV24EiNtBhq9KAaQ9IL2ZvBy7
 kevKfTAimkvPfD+8dw6sVX9+Jq7p9xGEub5dluoJHnSkuXELidMghR2Fef9NMnQszniv
 qyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790255749; x=1790860549;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CtFgILpoGN9oew1GWkpWJvU0DfUxofN2O/h63lGOutA=;
 b=ju7wvsBiY4jI+Po7CebQ7Fyxgp3s6xNOpwtGcRjKKgb3Qj4V1WCQdKaTLHnJwB3xZq
 H4vEB1bhnb8Rc1VkTn5OQXr+iRkaWC+qBZqCXPuQtZQLI8sDzjwSTiPT+keeEohGzsDB
 LvWXTQ1VCYvHlHImi9yEll4KIjsJOsHZnSyiYnD6WLcWUuc1APZqXRkIT/9rYiZHhwo1
 ftfap/WGdLiNjZYl/ovXqze5ZJu5zJ5ROjnZqyIKU+T2xJyGRrAxBBzV0fj7WNAuWyhf
 CcLRGZ6VqwAV3V2eCmchvvOfFLz/m+GvY8jUjEnvM3EtaEsIwQ2Za7Ieo9hgwy04dyxg
 /BLw==
X-Forwarded-Encrypted: i=1;
 AKwUvByTo0Ufwh8VEHJTpM2QAirTbmeptYuNchEzj7w9ls3chNQMzI+FMjH+nLS1oot4k+y5Q5Gox3MVKm8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nd8l3X1vbfR1ZpPdWQ1CYx0Z6I0B/ETvGdRFzoONjst/EmX5YR
 Mr13E3Bbh2lruIPkJnx0fY0SyCWR139buKA4fO/x7gIKum0YyXjXeZ0NYhpmXexIa0Q=
X-Gm-Gg: AYBFou1dJPNFuMa0rJiQ7oNV3mQ3+M6MTCtR74yz/GMb3V0dgY3RFM+uVI5KXpiBpPf
 qQxfzGkKTKIlN9HBWGbV3QriERG5SwVhxuisAvxn3mQOFI8SovPA0HkhCsWoXAbdIphrG+X/ZPe
 Tg1/RQPdIOqlMyk61EaA3A9C36wqY/lObJT1SXfW1B7BW7WvNU9zJrDFqGbq1eK0cwaJvlDHkZ7
 4FPiHbBHyEAiUJZcRhCYQjxC+TA/6Z8eRPds54r6Wm2XlFT4L3G/QwB9g8v/OtM3Wfnxkn4vDa5
 EAIYiQyDgZhy0qcE00zO/klA3KHzmudaPBG1PecuTYCtmCehm8AnPWDxXeVlbZ7ARt6svNorlZM
 kNgHo3GT31fQtI6HyBy9mAgFL4um19JDo655teTK0LhiIzGMMzMrGDK5TSWG/zjGAeG0ddo2L2/
 4JHfO4UOuMpAQqzWcEQT+lE23mE88BMuV+2VTtm0ravjWs3NH6euAu/vj5RtVWox2yx/jfVPr2C
 YTAXblA0ViTRD3J9pU8jREYPUsE8F+aBP4NLKKzhJXtP5N4Ek8EAQ==
X-Received: by 2002:a05:6000:25fb:b0:487:25:71c7 with SMTP id
 ffacd0b85a97d-488716b96cemr4930011f8f.12.1790255749477; 
 Thu, 24 Sep 2026 06:15:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868886e45sm14944343f8f.31.2026.09.24.06.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:15:47 -0700 (PDT)
Message-ID: <bb71b2d6-2462-4351-b6e8-ae8785a24c11@linaro.org>
Date: Thu, 24 Sep 2026 15:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/4] drm/panel: ilitek-ili9882t: Make enable GPIO
 optional
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 dri-devel@lists.freedesktop.org
Cc: Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260910181918.31551-1-marek.vasut+renesas@mailbox.org>
 <20260910181918.31551-2-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260910181918.31551-2-marek.vasut+renesas@mailbox.org>
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

On 9/10/26 20:18, Marek Vasut wrote:
> The enable GPIO may not be accessible on the panel, make it optional.
> This is the case on 10" Raspberry Pi Touch Display 2.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: No change
> V3: No change
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> index d4b383138488a..69f6427bb4ffb 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -787,7 +787,7 @@ static int ili9882t_add(struct ili9882t *ili)
>   	if (IS_ERR(ili->pp1800))
>   		return PTR_ERR(ili->pp1800);
>   
> -	ili->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	ili->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
>   	if (IS_ERR(ili->enable_gpio)) {
>   		dev_err(dev, "cannot get enable-gpios %ld\n",
>   			PTR_ERR(ili->enable_gpio));

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
