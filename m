Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3968FC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A40610E8F0;
	Mon, 20 Jul 2026 12:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ubp7/ADg";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD07510E8F0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:37:06 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso11986105e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551025; x=1785155825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQr+EMaeosf3EJse+8a7BrVBolL0lk1sXGCzF/fOxS8=;
 b=Ubp7/ADgtvF6oZOPcJKJF1QuzVS6vr4b+HJkX8eSLcHlRtnNs5RDgr9JUCYGXo/Fbs
 FIiNw0fWXwKRRbAxMqLYXNvhfCQJMfowaav+JIZdiB6+7lgNP+oYa+6ioEYm3LQVQtoA
 SLsJpGCknCP5rK+OAuVxkl6mycZ+Y2EgtBSvZz6o+wjl4ZdgqDZlUKcurcnMY0YC4uzC
 7y7d+bxyRPNsregvUmCElLItiSD43HXp8h3fplSVd+hhS2MpyqAG6FAvxC0up/5vOG5T
 mgLQlGKTCt0r1ZzRGSa4O5o/ReXHFaPrr1GXv4KD6C9cZoP4jVeF2TLdP8sqtvZY1T0J
 hfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551025; x=1785155825;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQr+EMaeosf3EJse+8a7BrVBolL0lk1sXGCzF/fOxS8=;
 b=slf3T1XTOpix9sXtbNA5VYX3VlJ2tbu7PMvojez/MlHI0E+VIx6u+Li5e6lEPGYNGw
 CGvzYOPILK7LFOVopNdmXx2HyFhZQlzVjpWfbBjfTsa+Lu+iNSae27jF+ky3GuKXf5FI
 1XXFsnrF60NR1PMaifnpm9+APVOvvdipfK+5HnZ5gs1bQHrj2jYKZ97k9iEhcyar7X4X
 uTBO/gHXeAoArV8GIFqLltBoGlAKZ3CFpK0DzD2NqrUiGVY6i+TylGNdC+lt+iI835m7
 9QFZsZlu7ynoVtZ6lKy5+s1kCApNr6PE2WkpAHFxcC9rw94202IntRJLhYaQx2FOlS6D
 T4NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RobzG2sAZpi+w4SZsl0ekjQWaqOZCQ3Iujej3bXP+kaHhp5TUKThy8oQgQPU+JrW8MVSmM97tuEZLw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxx2CgpDmnWHPCZHi0KHZrMTWVdoP+MouGXpZ/tuWy9aPhFSitD
 VipgUqFMtyxF9JwWV9Bh9tE8c1KV7oy33qBYrZ0qxA5LR3hIp7B//9Sdvr+mGDSwvu8=
X-Gm-Gg: AfdE7cntlZF+3CfyFF7xPBbaQV8mpkq/v1A1KIbHXUhW2SbAqG+GXLTwG2lCDYfB4h0
 g8QeFyPLj3elMQ+/epWf6unQyjjlhfGGmd6LmZ34THNzKQgQVsYRz5BE3sTDVVIICScyWb42Bg8
 161piMssIIcW1K1bvgXMmo/67d+Hjm2cZEQF9HyBBjebbVe2ArvRKcZ3umYWI7RwxLgn//CPcEC
 BiB2xUAbmRk4lpF5DtlCAbOlOl5dUnXCK20O1ymoHn24NPZKWrjyeB6XpoalF44m7FBBsgTe1E4
 Vb3SnDqteHN+abtB4klew4rGbb7xx5CK7tUd2hKAlmYvHlUrqr70XSMn7PuSo+0ZqpTJMgmzH93
 Ft8gFm9DG/JBvED0T54mN7n7sLREnY2TlBwe2YQ9mwIw6/ZGcNxrYdSCIgcx/+eUwJBZarpUwba
 60LcXpPQ5bVqd3ltd0SGZ5hruq6Ll0UqiEqn1TPPMEgCRHRNIRJOPewmjgNQ==
X-Received: by 2002:a05:600c:45d5:b0:495:4056:9473 with SMTP id
 5b1f17b1804b1-4954a40d0c3mr153014455e9.28.1784551024982; 
 Mon, 20 Jul 2026 05:37:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954c841a0dsm236624065e9.5.2026.07.20.05.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:37:04 -0700 (PDT)
Message-ID: <605ac9fd-d9af-4de1-9f5d-4f1a30a5a1ed@linaro.org>
Date: Mon, 20 Jul 2026 14:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: osd101t2587: migrate to newer mipi_dsi*
 functions
To: Robert-Andrei Mercea <robertandreimercea@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260720115126.666363-1-robertandreimercea@gmail.com>
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
In-Reply-To: <20260720115126.666363-1-robertandreimercea@gmail.com>
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

On 7/20/26 13:51, Robert-Andrei Mercea wrote:
> Migrate osd101t2587-53ts panel driver from deprecated mipi_dsi*
> functions to their *_multi variants for improved error handling, as
> specified in the GPU subsystem TODO list.
> 
> Link: https://docs.kernel.org/gpu/todo.html#transition-away-from-using-deprecated-mipi-dsi-functions
> 
> Signed-off-by: Robert-Andrei Mercea <robertandreimercea@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> index 2334b77f348c..63ae9dc5712f 100644
> --- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> +++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> @@ -32,11 +32,11 @@ static inline struct osd101t2587_panel *ti_osd_panel(struct drm_panel *panel)
>   static int osd101t2587_panel_disable(struct drm_panel *panel)
>   {
>   	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
> -	int ret;
> +	struct mipi_dsi_multi_context ctx = { .dsi = osd101t2587->dsi };
>   
> -	ret = mipi_dsi_shutdown_peripheral(osd101t2587->dsi);
> +	mipi_dsi_shutdown_peripheral_multi(&ctx);
>   
> -	return ret;
> +	return ctx.accum_err;
>   }
>   
>   static int osd101t2587_panel_unprepare(struct drm_panel *panel)
> @@ -58,13 +58,11 @@ static int osd101t2587_panel_prepare(struct drm_panel *panel)
>   static int osd101t2587_panel_enable(struct drm_panel *panel)
>   {
>   	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
> -	int ret;
> +	struct mipi_dsi_multi_context ctx = { .dsi = osd101t2587->dsi };
>   
> -	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
> -	if (ret)
> -		return ret;
> +	mipi_dsi_turn_on_peripheral_multi(&ctx);
>   
> -	return ret;
> +	return ctx.accum_err;
>   }
>   
>   static const struct drm_display_mode default_mode_osd101t2587 = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
