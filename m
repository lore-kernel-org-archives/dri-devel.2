Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2783C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC8E510EB95;
	Tue,  8 Sep 2026 12:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HmuwxSt3";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2011410EB95
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:11:06 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so45824375e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788869464; x=1789474264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DbFI851Wc6QNNKR3nQbUG1a0fTB8uT4edMUZygEozxY=;
 b=HmuwxSt3D6pX/fiC3GLTxaevYDpeL5U0sdK+GWwGfwAn6mtkGX64mkOvgNuoXaK5cc
 oGrUdS5eNKNDwKDAXjI97w/Iqju3M7pIt0wIQVuUjqpFRfTMA0IC+VnRJp7LHkzLdg7L
 iF+IrfmRyfQtswZE7heZuTS3oeevgL4SwWk18qvBqpJg/A39VMwVtTdoVkzHBOBW6Neb
 6c1twcs25OQ7gfxDBcJmhxbJNDrbr93WYxNg//OMpRnf/dvzGShPS6OQbT4dOX/70guI
 ptszhzFNm4HIiHFkWlDSBQZs+yNB12/AT4nFQDaCcqlJuazd/DuXWSDLhKj/z7LkV9Fq
 KxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788869464; x=1789474264;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DbFI851Wc6QNNKR3nQbUG1a0fTB8uT4edMUZygEozxY=;
 b=eAfXb1Ix+RMQqaMIjnaK4BYdUAqtblO4a8kEBNM8e1HFwT6JgYf8Ab7Q5XaOubJAgt
 9CRv/3Qhj9DKjU3vtOfW29ltl0X7ifL5XYmMfXHMMosKZRmFCwN7/RdSnKLSCkB6vq2x
 LQfDp+g9wfQn/qLowBdyfcBzY53HZzPcmIZiYY+KtlHrmCe0/TmJPqGNEf17BOTV9wBE
 sbezlbsgmqP4BjKEFxx5UbdFdP0sDprkACWrRC2qr+plKVgNAfsRXglQpk3TTURQhzXu
 2A1vpzaAcKfqFKtybm1zjSL53s6mJ8LvxTdGLJppmvF3HkiHctISSMYpa7gfyxBi832V
 FqLA==
X-Gm-Message-State: AFuF++nOw3qplP+1o/5dnd9KnKXOygvjLkKY/pIEz7RkcGe0F6UaA1HT
 F1DmM3oR7G94tLb2zjb01n2Mel1gvdmKcK5qHLeoTOS3xeQ6+WEx26s+ciZnfFQnNls=
X-Gm-Gg: AYBFou1ebcrKbKcXQ13Wd4mK+gQjBMTJjLt1/Nn+tByojjZnu/OSOD6etnvvnva7ReZ
 i51hwu/0hBKU+0YqIZ6DJ9ckMXLiPAk6EWVj3OGe6njKNN+8pqLBHWtIIfZwQNN8QxDi548v26h
 XxEYQgDspfNneZgPGCQnwnAaOI/B5Pifm+S7BkQHfVGflpqBwud0sGdmx57yM1YtNcfBnjgQbFo
 LWXKXGZu/AsFCxVLPLRoQgWQdgaHYG41+XLbmrH8BR0w3ucybofP9P6jqLKcC/YtLq7MEDEvKCs
 f1vK61xkE+hqylH1GXQt0x4Bu5Tep/A2XR9Z6VnRk5WZ9lfCplbv/4+8IZstHiqt2CVj95yyFMP
 ZA+jiAo0BmXpu71y07wNq/892fc6/Mqhwyl4cxstKjrFE2sjC9pwRS4Y5+Xg9Dww8++OIxKvgyO
 gG6SsHhZvzctmZI+VAOl/LqQExqxL7rHJQS/5yERcSsaR3ApKjUa/YZwK27hT/eSoA53qndJ4hh
 XcHWfLotXdPY3WPCKF3UYCQbTy4q5+LV5dXkeuUNAOg
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be06 with SMTP id
 5b1f17b1804b1-49cfc6cc142mr239764675e9.29.1788869464167; 
 Tue, 08 Sep 2026 05:11:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ea45:883b:8b89:b4e5?
 ([2a01:e0a:106d:1080:ea45:883b:8b89:b4e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm553052685e9.13.2026.09.08.05.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 05:11:03 -0700 (PDT)
Message-ID: <4688bc5c-edc0-4f1c-8534-286364f03c78@linaro.org>
Date: Tue, 8 Sep 2026 14:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
To: david@ixit.cz, Joel Selvaraj <jo@jsfamily.in>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>,
 stable@vger.kernel.org
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
 <20260906-ebbg-ft8719-fixups-v1-1-4e846510cad1@ixit.cz>
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
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-1-4e846510cad1@ixit.cz>
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

On 9/6/26 15:19, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> This corrects the host initialisation sequence so that we can send
> DSI/DCS commands in prepare().
> 
> Cc: stable@vger.kernel.org
> Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> index fb9f9f42be4f2..1ab09c50a6306 100644
> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> @@ -193,16 +193,18 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
>   	ctx->dsi = dsi;
>   	mipi_dsi_set_drvdata(dsi, ctx);
>   
>   	dsi->lanes = 4;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>   			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
>   
> +	ctx->panel.prepare_prev_first = true;
> +
>   	ret = drm_panel_of_backlight(&ctx->panel);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get backlight\n");
>   
>   	drm_panel_add(&ctx->panel);
>   
>   	ret = mipi_dsi_attach(dsi);
>   	if (ret < 0) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
