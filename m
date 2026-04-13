Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9607FEBFD0F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F2210E364;
	Mon, 13 Apr 2026 08:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vgQjmN4M";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CD810E368
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:07:00 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488b150559bso32174925e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776067619; x=1776672419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=UdgIACL9N5s62AI/UD+N+ywu/reA3cigk1RK/jHdjGA=;
 b=vgQjmN4MayQd9EFUNWH6Bbvoc2KUyweilZQ4uEMV5dldIBLFNgu5J7tF1Tc8xlRRSf
 jC23JStPY3EwO50Lsa0lMC26uzv+Rckhcdg5j+OyFfCaxXZEFbo6r3+0E6tX9q551Of+
 XH0oOMa9MKWfa9pPWLyghasktffq1jPsUaIUkCr9VPJmmMAyGkpG7QTC//aHaNCcV8hk
 RJdX3U8eYzNZxdxdIPm5HN4ZX13QBATTRES9j8oLWu8W/sQkAdcftnYnoOteZ8xFQnbj
 YygWPhMv8ZFZBHTAUA5YL7cQv2TIb0a2nq9YiB8L+GJqgHTgH47rY3WQfLJS60l5Iptp
 GIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776067619; x=1776672419;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdgIACL9N5s62AI/UD+N+ywu/reA3cigk1RK/jHdjGA=;
 b=Rr4ON5dCYdTVVa923JqaRgFnhYh6pdWbZZhYpuNeMPvtvjCQXkMNj/n+aasMTOAQij
 +dI2M+jLmn/dLU9LxldBugNtpgXnI9AWD9fbrSkQpURnhe4POya8MQYIJ3d7CAO3urNj
 GCyIiiyLMiu9JSHfddeS6fm6O8E2thyfJvJ1OnJS2RKC/VsevB44gtcqd8MGwMdgf5AG
 N1NIxSFIUAHQmq7zpXGn6EGr8aY+vIkYWRdmfNoQdKVAGkhkz/qtR8QCLzK0DxGtbtjz
 y/nP4iAH5wbu1TSCcqa/nJAlYR3jvOjQY95Wu5VSCyhbnlMv6IhV7JLIBZJNftDRIfVe
 yvuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7M5PNbmzkgR8NdXnx+9iy0yXMrUozYNpGv7rPfMs3wbKviiF3jJ3kRu4lUx2MhkIKRIY7KlIfQng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx279KEiOaXEBnFmu3wULQTtNL25RCxbeJtKSX/Xm62Mxvcb1zs
 PBbk/zAmWQve5ZmZ39+VXpoK4UVr1f3MoU7qSQaOSeEcg5zqUrMqZqtPy7k2EIUVrQQ=
X-Gm-Gg: AeBDievlr0f2mgbjR1Eg6yRQ3wpCLtaFwd9rNVOFFf9yTN+SmY23GnZIUTPHFqtWD0k
 R9ZHDPezYmYN/7G15MiVVdkHeCUkODT3JVnquhaAPCrThAre3lOQ9bwu2fBAzr0ORrNSgeAn00f
 voo3EAMxii0cttnYuMgkh/MvpN/9qETpRIT1HHXfgVpeShU3hPCiIKQDaho9++U2kqm7ED087Yk
 LdxwTt2VZ8hm4qo4Qh1Iqpr8ilN8kApxi+NNjDe9HxHbZNFyjmG9W4bAO7hmLEOdv1xfGxouoIu
 O6CLWlAXouW4w7PHTKN66OCVzoA8NLCrYrJ1lZ09pnLd/vo+0EzduE76+J8LBHXPvzR3ZqasmR8
 ioeYPCKTviJFE9RPQimmRjudP5uK/xIvmpGhif0SWiPy+kFhTeXPG8Yh9Qin3lBvGIfh2I7Eg8L
 NWhqicrenhEPxF+E8OynTRL7lfCgZ9OlP8fvs1PwqgYrlNoDm4+wrOb00dudI1J/vshxtKEfy+Q
 wj8HxM=
X-Received: by 2002:a05:600c:528f:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488d689d0b8mr166171385e9.26.1776067619103; 
 Mon, 13 Apr 2026 01:06:59 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25?
 ([2a01:cb1c:fcf:4600:4cfb:7427:8a08:9d25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d683c902sm93012965e9.22.2026.04.13.01.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:06:58 -0700 (PDT)
Message-ID: <b7a8a27d-e61d-492b-a5e3-a0a21436045b@linaro.org>
Date: Mon, 13 Apr 2026 10:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
To: Avinal Kumar <avinal.xlvii@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
References: <20260113091440.43735-1-avinal.xlvii@gmail.com>
 <20260113091440.43735-3-avinal.xlvii@gmail.com>
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
In-Reply-To: <20260113091440.43735-3-avinal.xlvii@gmail.com>
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

On 1/13/26 10:14, Avinal Kumar wrote:
> Changes the panasonic-vvx10f034n00 panel to multi
> style functions for improved error handling.
> 
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>   .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> index 3c3308fc55df..73c5827a15a4 100644
> --- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> +++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> @@ -44,14 +44,24 @@ static inline struct wuxga_nt_panel *to_wuxga_nt_panel(struct drm_panel *panel)
>   
>   static int wuxga_nt_panel_on(struct wuxga_nt_panel *wuxga_nt)
>   {
> -	return mipi_dsi_turn_on_peripheral(wuxga_nt->dsi);
> +	struct mipi_dsi_multi_context dsi_ctx = {
> +		.dsi = wuxga_nt->dsi
> +	};
> +
> +	mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int wuxga_nt_panel_disable(struct drm_panel *panel)
>   {
>   	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
>   
> -	return mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
> +	struct mipi_dsi_multi_context dsi_ctx = {
> +		.dsi = wuxga_nt->dsi
> +	};
> +
> +	mipi_dsi_shutdown_peripheral_multi(&dsi_ctx);
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int wuxga_nt_panel_unprepare(struct drm_panel *panel)

So yeah we want to use multi functions but in this case I don't think it's appropriate
when a since dsi function is called in a callback.

Dmitry ? Doug ?

Neil
