Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F28606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J8AYbnud
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187C110EDE4;
	Mon,  2 Nov 2026 13:05:39 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C2410EDE4
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:05:32 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so25880195e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624731; x=1794229531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5rD9BNrHJtprRbYX+SX8+i7FI9j+GQ5LEWGqtZnMthU=;
 b=J8AYbnud+jyFHC+I1kGHzITfSg39gy2ZxmCWFCxOFUiOQkS8YKjtl3KRHEvrxqd9iT
 51aHNK6n3MaAecUCeptM8KFl4ShsK7qyd/lRB0kdCBIywtJ7liJadtFpNta/BME9s5vF
 O9SIdCpt37IcydMOxHz9OgLchwkwEvQkjoOz1nLZYT9TfjHU/3P0cPgGgWAu7GGRx2O2
 3u/9T3WpF7zqRqheBtK6iQVJeAppp8ZF+DTfy1YG8psHIMDVupCFbK/LOeEZe7Vp9dt0
 fa+D4QVPkeqiOdoVyf7AoHeBoU94xPOH26Ga90zBMNJGPslRkGHhewhMB2Yso8QIDMhl
 6ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624731; x=1794229531;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5rD9BNrHJtprRbYX+SX8+i7FI9j+GQ5LEWGqtZnMthU=;
 b=hsqndjkvrSlXKbVtmWY8+QfoQ+lbte+JOujZ+vfhxq/ucP5f2e5nZav8BnrKBDFRdL
 JA1OXMG3dXLXXThS1G4Xi1awEGdo72SFAWnJ05m+ZCtmPT36Ow8ZBoorApNVkP7qnxNo
 OvKeKBbzuUXu+Zlk54NBc5sSGx7fjD6YNjs6GHRaSgGvlbeBJmmJgPEG7h1e++jvkCDA
 9vqW7x+aUDRT4A/My9OTbmajx5L5ssPIOFS/efMOhrgpHYrhCwBIzR1VQo/E9aBJFp9/
 i053pJ/agda70SdA3FRKX6H5tCgNXxbXyt4p0TMIZ5FGrzcqa2ibya1RfhFqNWXsQXod
 gYzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwN9dZX0EPMyNvAzs8k6KRVwSBkjxraB1vViqysKnsm5/NRMkihW5o3PfAC2UocBzt4uOJMjkRrTKk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJoj2rfwjf3U6LBDPseYmN9N1d9kVO7tlq68pRVRcSx1jJofl7U
 t4Cw8m5uQV2E8kNq2BUG1aQgsBfXSPz0urzVsEtC8v+nh3RjwGzwaDC2c0ygntGXjos=
X-Gm-Gg: AYBFou1rabHCty2nOqA6h5OdMnUhgHgH96a+tmb16SRj8MkNoz2fIbgVkd/YRN+vp5G
 dacd/8fH8744VSC/nL68RvvDrJhROJL6Dx8cXNKA+UdnDMyWQnqdk++9cpOj/WYtRDK2RUZ4nlc
 hXF4cPFBOJBaZeVLDTNNdpcDEnD51xu+Uxdh1QYhLTbfMKMCetJ5YfJifalDGt2GeYtzhEvlwc7
 j6cgwmkPz7Kbfx3S+wWnTdvfPfYf7PtGKCvxmoBuOeYOzVVL7+JlMnqMXGYW2omDjujqxhrPQaJ
 Z1cnNyivu5P9uCJoKiAd48Ry/R5zKlMXba9Y7E9LpPTC3NqPT8G3Krybf8v/OfveqbvfezrTN7i
 FzItQIBreIbaaIJG+R/6Vh0nRPrx+BZABexpXKoesNg6B+WiUBwQLRyB/dMkYHJoTJ8vvKaZPCO
 lJ3Eae1EFcnRHaT7iJvKKmilalW8jjE3To75sMbQ2sxhLJGgchdNSAXCtKDaA/O7dipaV5YYaOr
 /chVDfbZN/KBRQPKtAatzynbRHJig9xd05JwMOr1FrLYpgV1RLvKtrTH45i7qAm6zaF8U+95FiY
 W9ta2uIygqFhG351qZjbVww6UqbdjWUq4zcMkIF3KFNvr69Qt9EWwZqtL2RAWHFCV32QxM7PhPI
 9fYTNb4/M6PZ/0G8qb0xf6XpbuiM=
X-Received: by 2002:a05:600c:3556:b0:4a7:6bc7:f778 with SMTP id
 5b1f17b1804b1-4ac1932a355mr213026365e9.30.1793624730926; 
 Mon, 02 Nov 2026 05:05:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf67aa704sm257347215e9.8.2026.11.02.05.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:05:30 -0800 (PST)
Message-ID: <297c5be1-4d62-404c-a035-313e7c8c72f1@linaro.org>
Date: Mon, 2 Nov 2026 14:05:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: ltk050h3146w: convert mipi_dsi_attach error
 message to dev_err_probe
To: Heiko Stuebner <heiko@sntech.de>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20261030115844.3661099-1-heiko@sntech.de>
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
In-Reply-To: <20261030115844.3661099-1-heiko@sntech.de>
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

On 10/30/26 12:58, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The panel will happily report every defer during probe with an error
> message.
> 
> Silence that to actual errors.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> index 0856df5a6ee2..459d8a1ceab4 100644
> --- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> +++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> @@ -587,7 +587,7 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
>   
>   	ret = mipi_dsi_attach(dsi);
>   	if (ret < 0) {
> -		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
> +		dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
>   		drm_panel_remove(&ctx->panel);
>   		return ret;
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
