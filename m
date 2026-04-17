Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65933F43683
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5F710E9A6;
	Fri, 17 Apr 2026 09:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ypxLLPd6";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E637210E9A6
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:51:14 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so4176835e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776419473; x=1777024273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=P0uCHuAKeS6uUlnZaQ00rIBdMGYxOjfO74lX8NHxdEo=;
 b=ypxLLPd6W2gqHCdqLFYoU+WIGC9XPPQkmNy5GGibf0APJ/inrfjG9z/9F+ndEa0sie
 tvUBPiXUNWqO6r2aZIwBY82UPFLW8qXSExbi/4efX3VDaipJtF8MY9NhW2xHayvYXx3u
 BNHuio/uxm1xLrveu5Fng7rSAqlyeOsSygotHnVnuqVdXxL2n9YqVkfGyMu8WRVyhzmH
 8q5CJpSGpcl0toe47xLWKyJFJe7cwdYxuW4jXraptGpi5l7UG8jvyNBHHhv20GO0YdX7
 TDMFlXGdKbg1CnM45hLhNrA8UDlqMLD/r3ZXfzFE+3MBxSGUU2iqbQh/tK1gMefAvm9t
 0phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776419473; x=1777024273;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0uCHuAKeS6uUlnZaQ00rIBdMGYxOjfO74lX8NHxdEo=;
 b=cIjtEtfTCg9F/8JdFU+nRRqqEf3NGjPys2fOZEh5+rdMDSHnoLh+5meGeL3PZneloL
 ApnwKOsFpSpqAon/SJZ5ysGoxi36BaKe698ZbjOkM/YCNwPFU0zb4RhkFKzOImg2XYaP
 yIftDSLKUZctEXGLw3p/y5FySd2SRssGWME81Q0DdThW9mcq2B02e+ZFE0+bQC7vGu89
 rWZmuEYhSz5h1Zhf/95snftrCoj/cDjLRgTHEbG3qCZppXYIC5eNwNA73QYBi/74kaya
 tlXVPJAgcP/qaHsc8T4M5jk176nfJ0TdCWkpMBZOxDtqFvRg2C6bpphYE8FDHHNL9KuP
 tCsQ==
X-Gm-Message-State: AOJu0YzqpcBUwyAmCU76kaLzMsQPBRq3mM72uXKIRQVS1EJKXkITrCsu
 O8Kat51Jtqi8orLrsu4KvmJZc9aCiuDF0pt2KB94wB4CT0syHw5dh6jtmFph8EdUMCw=
X-Gm-Gg: AeBDiesasHmvbPeEjUJmb3TG4iVoSPjkcW7WWCcgo+9vEAAbb0P8/2MwM/UR6hy3lzK
 4mX/zBIAxbVFts+Fu+LBmGifsj9Z/l265dD/aTGRTgst1+27RWWUmBR9jT+4ez5L7Mebsf8ds2r
 N7d2v03k/CD+juS7HKQCSdG8Z3oh2yNLkXU2pC7LRiCKliwEEH+UoaQtxhraLBVf8uCGgf197gk
 GM++1VXS8oH5HF8XL8a0uz0lJNg5mPoGjFKPqZlpa9XXvFifFSIMoXW2IZ97bJ632Tmrri2Lb7v
 h++rDdfLgfdu2zsfM1DmVqfY1WbvsvfV4JfBmbBWYdHfDKyfK6/wS8kM+buoFT6Ka4qZICRtt2R
 nkqoht4naynDHQ5g7Ntafa/XDKcARCMzEbbsnj3RaeVstGj8CC1gbh4XNgP4cdypXCJs4aoNLx/
 n3LSj171TxJj+wXFrQSK+suRHL3+A4+GONLilLbLobeD9whqD0a6UUBkdIztEtsj+LdN5cXQBDg
 EDk5s6LIVDZCrQtSw==
X-Received: by 2002:a05:600c:3110:b0:487:243f:dc3e with SMTP id
 5b1f17b1804b1-488fb739cf6mr27616865e9.6.1776419473355; 
 Fri, 17 Apr 2026 02:51:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:9b0a:b8df:9ec3:b505?
 ([2a01:e0a:106d:1080:9b0a:b8df:9ec3:b505])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc14a61asm30946315e9.15.2026.04.17.02.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 02:51:13 -0700 (PDT)
Message-ID: <a8031b65-62bf-46fd-b360-54dc84c58d13@linaro.org>
Date: Fri, 17 Apr 2026 11:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/panel: visionox-rm69299: Make use of
 prepare_prev_first
To: david@ixit.cz, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
References: <20260417-axolotl-display-v2-1-8ce5341e46c2@ixit.cz>
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
In-Reply-To: <20260417-axolotl-display-v2-1-8ce5341e46c2@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/17/26 08:55, David Heidelberg via B4 Relay wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> The DSI link must be powered up to let panel driver to talk to the panel
> during prepare() callback execution. Set the prepare_prev_first flag to
> guarantee this.
> 
> Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v2:
> - Move the prepare_prev_first before drm_panel_add(). (Douglas)
> - Link to v1: https://lore.kernel.org/r/20260415-axolotl-display-v1-1-7abb2d248355@ixit.cz
> ---
>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index e5e688cf98fdc..f1430370ff942 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -371,16 +371,18 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
>   		return ret;
>   
>   	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>   	if (IS_ERR(ctx->reset_gpio)) {
>   		dev_err(dev, "cannot get reset gpio %ld\n", PTR_ERR(ctx->reset_gpio));
>   		return PTR_ERR(ctx->reset_gpio);
>   	}
>   
> +	ctx->panel.prepare_prev_first = true;
> +
>   	ctx->panel.backlight = visionox_rm69299_create_backlight(ctx);
>   	if (IS_ERR(ctx->panel.backlight))
>   		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
>   				     "Failed to create backlight\n");
>   
>   	drm_panel_add(&ctx->panel);
>   
>   	dsi->lanes = 4;
> 
> ---
> base-commit: e6efabc0afca02efa263aba533f35d90117ab283
> change-id: 20260415-axolotl-display-715ce416e5c8
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
