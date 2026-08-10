Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF22C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C1310E76E;
	Mon, 10 Aug 2026 09:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PSlVp6yj";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0935010E76E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:45:31 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1330690f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786355129; x=1786959929; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EyEgdVp7O6CUMToSIq4Pkng5Jk2xx180zJ29o453drU=;
 b=PSlVp6yjgs/ha2cd30JcEpKrrZ0B0BZCZXoz0zRtQNAch2An/N5ZucXRulrw9vHFON
 mKlKl3qeYndZRC+rvhj4X3oXUHjm0kwOex5+5L6YdGRogVfv1zDScSD+YuYXTfc8HZd1
 xUSUn/hkrLvOIabpnh3QGU6ZtD7BeKZIDpXw80kgRJnHbAZqZ2dsBO6oYYvzcd4TexSd
 i9YkKQ+WimGkjgMmXoe9FOnW7okboEqT2kDF1szTgaGl+yYwZGn8PH7+3ZXHlWnrrQJ+
 ckyFTY1FJdOg6KfsIjwG6NRbdwOi4eq4WsgBNAyHOU6+ts6xQiICl93A39jmvDklRuo9
 FL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355129; x=1786959929;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EyEgdVp7O6CUMToSIq4Pkng5Jk2xx180zJ29o453drU=;
 b=aoQO4y7LCcK8o/i+SogDQgOmDzK0OFc7eZ//LOA0/614RvMxcmrdZOa81O2QBAlpqQ
 xHnr4RA3YFe1MxUFf1+kU9/Nvu88ipBc7W5CWTPQpubJhgwikBJCBMTTa90PXVD8k1Vn
 0eEAy+rISgEpkSOWk91DZ6hiPxEVtKxr1d8FOK/J82Nmm4LeHJEN9evuh7nKIpnTfK57
 5DDTVf6qFd40KjQ+IIcNZfFgNtOpfi4WXlm8CzVgzBYniR5T1AnAluteJTRMwe5G+0mT
 18TxRxN5lzQ8y7jhjfDvFHj1lLwzCp8XpXw7v5WIRJ/yFtnPPNPUAub4CZBkX15ThLfs
 2qkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGB/JPn3hxQOwU6x16+h4+RO0DA9onzsWzGU2J/jON00gM80O+qU9UN1Nk/CHzmeV0IzP6d7ByiUo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBUxCZY1oWCRz59cQFUBY8IZHbRgmcJN1O8cLP4MoMJipHIH2d
 16pV8teijvVqj+3EvjUcjdRtU0s5RbyNYDMciKcaXiZEkAA5thBZbjFaQ5D+iDzro3g=
X-Gm-Gg: AR+sD13+XKdAXU8vxknPSBidSbOQdD8CpqaLDfYEZjSuPA+7bi3N8/WYlN7dOUAFuHh
 HUMK3Ooaxmt438YRTruFtOmHLwzPbuNoh7Vc1XRWGMdXlwK2ITSbcjlODlBz6fScPB8btZWMXpd
 yGqx0HFGvccUlTXE28bzWaYIB9YetKqcVIhgzwhyVR3cwUBW0M+yNKeYpuw/oTgERpYehwwNLYz
 /MZhMyIRfjBuBSh5xcfJFU1eCbwvUzrDb/GK/mponduuwO+VZVJoHLZJ3Y2fh205cvOfucyoYIp
 Ej78q+5Mq5zZ0Kn4Qe6muBVfS6gnZNprluGbIs7hOU9s0AH+pOMG5M/UfhAG5kJmacdvbxnw8oX
 UX2Cmxm8tYEJ4VCDo5S9o5vyQU1ZIhai/+N6lxv2mMzW0CxuXgf9h6WZ2Q4+Zplr+vNaABj5iqA
 Y8L1lYTsxi0YY53nquHjbVH4Pwno72oCPbtT+LlOOnTR4Hnv5N+adQNUAwT2LoehiCgvU1eUWs+
 XSde8L+B2duaFLJd9qUQ30URTD4Diy1EZ45MW/zJu4jxp1eMXUm
X-Received: by 2002:a05:6000:4305:b0:47f:4fa9:ae42 with SMTP id
 ffacd0b85a97d-481455f8844mr733292f8f.11.1786355129252; 
 Mon, 10 Aug 2026 02:45:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32?
 ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800215078asm32050521f8f.12.2026.08.10.02.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 02:45:28 -0700 (PDT)
Message-ID: <d0c1f707-4d44-4d0c-a45b-5a78c94f286a@linaro.org>
Date: Mon, 10 Aug 2026 11:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] drm/panel: ilitek-ili9882t: Set prepare_prev_first
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 linux-arm-kernel@lists.infradead.org
Cc: Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
References: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
 <20260809200107.842945-3-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260809200107.842945-3-marek.vasut+renesas@mailbox.org>
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

On 8/9/26 21:58, Marek Vasut wrote:
> Sending DSI commands from the prepare() callback requires DSI link to be
> up at that point. For DSI hosts is guaranteed only if the panel driver
> sets the .prepare_prev_first flag. Set it to let these panels work with
> the DSI hosts which don't power on the link in their .mode_set callback.
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
>   drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> index 219d048cb883f..24e72ad0d29a1 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -808,6 +808,7 @@ static int ili9882t_add(struct ili9882t *ili)
>   
>   	ili->base.funcs = &ili9882t_funcs;
>   	ili->base.dev = &ili->dsi->dev;
> +	ili->base.prepare_prev_first = true;
>   
>   	drm_panel_add(&ili->base);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
