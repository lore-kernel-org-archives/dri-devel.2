Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FB60A2606
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U8g/eqrl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D608510EDE1;
	Mon,  2 Nov 2026 13:03:39 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D269D10EDE8
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:03:33 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso30168175e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624612; x=1794229412; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LbYF2a5hv4tFMF4cLT6t7A3uyMFWmYJ7uZLjmJDUADc=;
 b=U8g/eqrl57uM5DxgpYq9eDuYf1Ukg+2LAhuZfHF4TS09EQ8AqR93iaVRcB8mFQqCvV
 IhupylHopFj1mqJBpREaYCj6Gvnip04DuwiBHOLjsjMZdqjWbJYqqiXxczvA8coawXeS
 YakO51OrSxnJX9bWBR7rQvHNWl23PFBffOY66PJlCwMVVaYWh+95+6w5ctD8Zc7GC9Fr
 HnuXsqNGYxT+WJo7PcBO/gmFHGg3iUP/aRIVhAGxPjqyZjfMmFMaJjLtsBxAoSLDc/Yv
 kSkjQGRQGr4XF2H0AZ2wCVJyDgDjTGf9oH5VcVadqTWObP4D8xZIBxWKdnwtoL965z6q
 xfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624612; x=1794229412;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LbYF2a5hv4tFMF4cLT6t7A3uyMFWmYJ7uZLjmJDUADc=;
 b=hNiJdVeV/xEaVoApVJ8btvwf3Q7V77UTTrALPN6te1zpaSQiNIcgoTLTLEYqpwrVAM
 NYpybMhXHB0D88piP4LdzewQz/Gi2wJDrJAz422VNfvjhAzWRu2LO0dAlIgYNfmuInzT
 lhguPh63vRAPqOe8dQdQxr2CT+75yAaWKpVrknKFIMoLPdG+gCoCgy4QLw/sW9JJEmGW
 S/Tinc0C3odxcJjPE6UQL2RL29hgk/JN1QO4Vqb45XPInl0kSCZMH9wPisEkHgewJyNg
 wwXtGb4qmnjxe9R0doiJLGr7LlO9lQFHstpVGMubw3HyvEpF18olGWIcVcbNAuim7vvp
 XaRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJfbri0X2mrxpn3bXSl+ds0QkOqWvbhQnCr9ZbGPo3gU84gWESUscPe0VPF7uEeOqR6Cs4uwr1zRU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBy9Y2JbMrzpNciqnJAmRz85wL6YkHPFlollYTEPlCJzfjdcnG
 5cB9s7v4cdynYUrbscXj5NAbQeaav3f1zIAKQIbHcX4YctvTI22FW1mV9fX6WF2/w5o=
X-Gm-Gg: AYBFou1oyQCuBPdBObuS53Rb2xf30x85kqtRFMgHS1X9P5V4Qv7owk1PMc7g7pIBaD5
 GwII/sMPe2KoVgt+mdI/94KjhYN9zjvC5Ltp4Y3I8+ucvNR/b9eSqMlkl6WRN1mGehpRdhaePjx
 /XgLVQQaGT5qS36anQ57ro9u2Wpj/69UV+OZdyFRo3zR7W55hPh4NbbmRTYN2WaFzIdt73esC/l
 x5svNyWhstbKOZDVkgQmX9ask1Xc+QMMlaG0jsA7zzKwlQKt6GYYo0xddwidlN6YdwWcyeGfYch
 IE5yEXuBsC0Z7Obksh5y/BWXsb6eYZOW+p2aQ+Nutq0pVJZaJCBZCmhThERAoQmkuWjh+XNJEIc
 ehWqQW40pyUhFNB37dlvSWCOCxS37ckA4oq5jfwqwFS8L4wZoNtEQoWGxcu/bXC7+y2i66z+nr9
 oW4KKtXS2vXFD5j78XB2JPxeArWaR/jiSZ9bf0cJnJc4njLwtJJ7U3KxPDM3hrbKLdBSAdbA6vy
 geMEfNnlzlWpDlVga9zzfKBPz7t5qYU7OSZdcDh/wV/XvkSCoBEa5ZgRpaDY5SalRZ79DnoGYOZ
 gOmOdPqXSDy5txq83dA7osUc0FgyhQGutGlq7Uhf0ycYg7OOpYP+5cevx1VYD2qFh/ju68zh6EO
 ivMDm27M=
X-Received: by 2002:a05:600c:a48:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4b22ec58f9emr13582095e9.10.1793624612003; 
 Mon, 02 Nov 2026 05:03:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9a3b1sm21818206f8f.44.2026.11.02.05.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:03:31 -0800 (PST)
Message-ID: <04d5e301-30d5-4e42-8b47-10d8acfcd1e0@linaro.org>
Date: Mon, 2 Nov 2026 14:03:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: visionox-r66451: Wait longer after the
 panel reset
To: Vladimir Zapolskiy <vz@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20261101212458.2431191-1-vz@kernel.org>
 <20261101212458.2431191-3-vz@kernel.org>
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
In-Reply-To: <20261101212458.2431191-3-vz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 22:24, Vladimir Zapolskiy wrote:
> The initialization sequence is sent 10ms after the panel reset is
> deasserted, however on the SM8350-HDK display card the panel does not
> answer a DCS read at that time, as a result the panel initialization
> commands are lost, and the panel does not exit sleep mode and the display
> stays black. With the first command sent about 15ms after the reset
> the panel comes up reliably, so wait 20ms after deasserting the reset.
> 
> Fixes: a6dfab2738fc ("drm/panel: Add driver for Visionox r66451 panel")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-r66451.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
> index 4f28bd3b6080..b0559e8b1cb5 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
> @@ -36,7 +36,7 @@ static void visionox_r66451_reset(struct visionox_r66451 *ctx)
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   	usleep_range(10000, 10100);
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> -	usleep_range(10000, 10100);
> +	usleep_range(20000, 21000);
>   }
>   
>   static int visionox_r66451_on(struct visionox_r66451 *ctx)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
