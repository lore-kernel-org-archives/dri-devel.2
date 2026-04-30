Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB11BFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1766D10F2C6;
	Thu, 30 Apr 2026 09:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XlChGqFM";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BFD10F2C6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:45:34 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so4300045e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777542333; x=1778147133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Xeo++QO0ZmeMqFuHcQ1s6Vo0noqXHgx6iZ0Z2tO2ftY=;
 b=XlChGqFMM7w6mE3ki/zdCaPD+kh+sHHRUKYO10h0t6ceRuQ84eOQzpzWD/VzVSerxt
 ODkOaipSlu1fH1uYWjnf6H3Jt6muT8OGo59Kv3rnlJIpi9c0T3jgNs+UHpknkJP5BI4e
 9QH/k2IdDExr9jHRyyCBiXCnZm14ZHO9KTgQKfAdHaGvzpdaZA2bnAsPxEtjQFFt7xKp
 8HgnIcCYffQrvvTajpxp0Vc5szlG9m8E6e3y+fAipmb7lI2CGzuE/h2a8lKhlITkxDxK
 /E6PbL4DHxrvVCXaXITWb0/5pC2UxPXpFV6spMvaWfu0gwJMSss2BAK7KabtBJLHkmES
 e5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542333; x=1778147133;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xeo++QO0ZmeMqFuHcQ1s6Vo0noqXHgx6iZ0Z2tO2ftY=;
 b=O3JiiG0yRAHzYmjTJrECRc2NT2LmjVoOKWSy3Vh267nwG4deEEl3/ntEnYJqR1Znj+
 9kb+vpvfDvSC6zVahIcKciwhKlPCm5nBX+3bY+cApzuREbNs8wm2wVnFDYB+lbpGrr38
 lJL3iKjJhUmBzTrvtqwPzxoOPLGY7hNL1IhKfSCUzwXe0D19Rm+STraK6BX1NCzlLzpY
 HyfMo8VaznZU8ftiiYXNe9dOtY/LCyOKdhOpI7/Pg3KJGvM/AmGEY9MdmzCb2rCNlCLS
 JiIXmaKdB6FXV99PBAi8Zof5vkQ39Qiu2sL44TQePlAnAd5QTdVqxFTr7iQat6nhEb+E
 doRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ89E8PQUBHWW8RlWvxbc7w6VHU9q3zZD17IyoJr1o/bzkL05pyD5fBSIyc3ZDX7s1cBeSV9LLbOEZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrMbFgm2lTW9pULYe2gj8Au3I5HtO3Q6AwyaazVsz8RWiAPSK0
 g9ZZaQfV3CuIjP34lmKwPl0cVNwTpgLpkY3c+MqbK4IUmu4UG8RamnZt3NECTgFGMRo=
X-Gm-Gg: AeBDies0uGdbXz1lyeQnuGaxSKrqJVj19ZSl/NeuMlXtyF4F8LxKkd95xWz/0EK7eAB
 JMYz9pQbp4oNirtVcvFbKRUlmeCOOZkjwksRawbOpkuMW4pu1ze30txFGQV1sl685IBFuisWQzq
 JuHmV9AXRdvEmOQ7tms/mfPdnx6LP0OjLn28Qr/7Mj03jXRSH8+BsTXEBbqN6yPBwN8Av/QQoCh
 jeW+31Q+WgIWRWZNNDcshO687L2DuUeI7AsUEUlq+3dEpcL7E6drbrtouHdYBeNiAluMFh++Mzb
 b/V5rylNXm0xSES3hklTMGxA4tXTjlkbD+ZhnnD1r1R1cv4v62wBylvc5d4jyMATIv7Ieu970Xc
 k/DjamlNRHDMku6u2Qco3qQec7tfitu3w1M5kYmJsjOZOA3siz3A9QEFyB+GLkZOmucLAhoWC10
 RX6o5oY/D+UKCxg1AIvZkaQzNZD2cyBQeFcjNMsD1qYF3FbZL9SH2MSES9KMmBYS44Ff02b0Gag
 PsiDNYiPtostiY6RJWqL6kMg63c
X-Received: by 2002:a05:600c:4e46:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48a85e233fcmr27659265e9.4.1777542333191; 
 Thu, 30 Apr 2026 02:45:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae?
 ([2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c324672sm37636085e9.32.2026.04.30.02.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 02:45:32 -0700 (PDT)
Message-ID: <bc921525-1577-424c-a4f7-a0436f8a0ca1@linaro.org>
Date: Thu, 30 Apr 2026 11:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel/panel-edp: Add CSOT MPP36 T9 eDP panel
To: Adam Szyma <adamszyma@wp.pl>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20260429145251.8445-1-adamszyma@wp.pl>
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
In-Reply-To: <20260429145251.8445-1-adamszyma@wp.pl>
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

On 4/29/26 16:52, Adam Szyma wrote:
> Add support for the CSOT MPP36 T9 eDP panel (manufacturer ID: CSW,
> product ID: 0x143d) used in the Dell Inspiron 14 Plus 5441 laptop.
> 
> Without this entry the kernel logs:
>    panel-simple-dp-aux: Unknown panel CSW 0x143d, using conservative timings
> 
> and brightness control is non-functional on affected devices.
> 
> Tested-by: Adam Szyma <adamszyma@wp.pl>

I think it's assumed you tested the patch, so drop this.

Neil

> Signed-off-by: Adam Szyma <adamszyma@wp.pl>
> ---
>   drivers/gpu/drm/panel/panel-edp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index f3cdaea89..0d0072f29 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2073,6 +2073,7 @@ static const struct edp_panel_entry edp_panels[] = {
>   	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
>   	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
>   	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110a, &delay_200_500_e50, "PNB601LS1-2"),
> +	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143d, &delay_200_500_e50, "MPP36 CSOT T9"),
>   	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
>   	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
>   	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),

