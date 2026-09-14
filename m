Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1A4C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6820410E152;
	Mon, 14 Sep 2026 10:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u/Seb1jG";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C0810E152
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:01:58 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so9926875e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789380116; x=1789984916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKBsXKDFOhQRkCfFndxrrlYoWPTZMOH1+ZJPOFn32ME=;
 b=u/Seb1jGJvKZNmNuvV9REfTJE7h1gKz/FXfA2lFTbDzjOHNj0EodQw4PseICjWdD1p
 vsy4Weq+H7eZ2s46LqKqMLRe9V9dFz6SCm6HOV+mRytlRTQcZgFBY23bxdVN+Lr6yrgm
 Y1F6u/xM5AXJu1JJV8rfWMp0tKptr6dKY3w92pMI60hnocADW6G5BVKv2bBGXIbrF9JV
 bBC8UmW/sxbpp0HfLWi3fU8Fh4dYD5KBc7WVrFMGQp6RCJLBVHXCIrm5stlwf6iUDTnf
 5Xa4r4CSfyhUZ3wxIeSipf7UTuDcr0i1SQeJt+smEBLUmPT5SXYel6QgV7TSdhkFtVjc
 9BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789380116; x=1789984916;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKBsXKDFOhQRkCfFndxrrlYoWPTZMOH1+ZJPOFn32ME=;
 b=KABGhLucCCE5DTbcXDcCYEgcKnSne1KN2jionYAdViLgpNzAzphNA+3KXveGVGgYJu
 nDQG2dX3QM7VuSCcwvCt8f9aTzASEbDbp4y3t4EwqrKx9Z/kquLVXa2662hwVMHQp5Je
 wb4Ay1jzJ2LRD07z5ZDC/FP+kGC0TIkC1oT232mKWqdivEFi1lipMCzugkA3RMNnBCey
 MtMouGM7zh9UKUStAVQojnO3MpF19xodYBeGIRN0Dw8yQ4v+wm8GNXD979fZHrZzdIQg
 XmPQKADpw12C5CK6TxnGjAtgzX9Ljj81tG277rRc9ABEapdJD7hZYbFPgtTAiJfsLTLc
 u3VQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLKjWSLrYe74w3l2e6upCCkUGSirtB6lBatUl+i9zV9biAQ79icpwzJsm/FblF6b23Zl8Jm61ToRQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nv2R2eRm1AwbxM13jNfP27teVvbMg0XjticwRBuFw9rm6m6Lus
 WXUcjMh9jwY15Y8oBH8VLrMvOil9vx/Yu61527lgVpslm2ZWAr8yOnxroIQ/i9lQkvFS9mS1YjY
 SRkbo
X-Gm-Gg: AYBFou25QbUMvcCk3PU5irq4QyByIjOxS8+6ujTzs2HKge0Wpp5gXTCJ9Lkmp/G6Zqt
 9YPDII8MENy011q9Bokjq+2337bHIek0xmOM8cpS+2lDVG+Uatk2D86qhfl4JXosSdYqsmj5TNg
 0NZXtlOazSfcIPYzGhy7Opufaz0ClCYt08rzMLGH9xHdVuGDmqGSIL2xCZ1AabrY+qdmV40ngv2
 XTCxfHU9aiYFzcHuPO3i+uX83k3HPkQd5DmA7l2J3nk0j57vK+0I5Szpofc4XrDAzEWf6egJfN5
 QBFwacox0rwCl/k3ek+JsDG33106SRMsIG2ZQwsv/6jjrqafMh6Vlath6JvRVCzEDbEzqO71IXz
 YZRyaEJxrY29RCZxcOaTgLUFgKDHE98QUfHoWSLNL+NWVUW7vYjBcUyyu5w/wcsTE9r9Iaf+G/T
 4op4oMoMgdq9qKMt8YKLu6kiE3KY7+I3o90BM4cqmIqKSj/2UkCWugrEZizVEegL4pM7KpKtm2x
 zxNLF5rjMeRiYQR7MY87Qu1UwMBw4/kTGWtQAmmXzxffq80Wf2b
X-Received: by 2002:a05:600c:1c1b:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-49e7a692563mr24010095e9.26.1789380116235; 
 Mon, 14 Sep 2026 03:01:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6e39:32ce:833b:47a?
 ([2a01:e0a:106d:1080:6e39:32ce:833b:47a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm209445435e9.7.2026.09.14.03.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 03:01:55 -0700 (PDT)
Message-ID: <f485c3d8-9551-49c7-88af-1c4389d4d66b@linaro.org>
Date: Mon, 14 Sep 2026 12:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable
 delay
To: Fabio Estevam <festevam@gmail.com>
Cc: jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org,
 Fabio Estevam <festevam@nabladev.com>, stable@vger.kernel.org
References: <20260909201346.937343-1-festevam@gmail.com>
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
In-Reply-To: <20260909201346.937343-1-festevam@gmail.com>
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

On 9/9/26 22:13, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The RFF500F-AWH-DNN datasheet requires a minimum delay of 250 ms
> between display signal output and backlight power-on.
> 
> Without this delay, the backlight can expose unsettled panel contents
> during display startup, resulting in a brief bright flash.
> 
> Set the panel enable delay to the datasheet-specified minimum.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1b2a9ec82099 ("drm/panel: simple: Add Raystar RFF500F-AWH-DNN panel entry")
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c95964ba25a9..70e37ff12c9e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4354,6 +4354,9 @@ static const struct panel_desc raystar_rff500f_awh_dnn = {
>   		.width = 108,
>   		.height = 65,
>   	},
> +	.delay = {
> +		.enable = 250,
> +	},
>   	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
