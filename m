Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA3C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366F610E781;
	Mon, 10 Aug 2026 09:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OhJuvjwH";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38EC10E77C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:57:09 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so23887855e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786355828; x=1786960628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PB1WbMtOAFwpvE/F5EFj3Q/h9ZfB4E8+CQnZduBE9Aw=;
 b=OhJuvjwHK+CUTOvxT3f2DKOdoLUJoxX68moDfPMtgc97MJSuw+v5svmYBmm9+8lo+v
 VqmKELsyrLemQvmdzhf0rVdzTkrdlnFQhQ5nhCBxVyr0Vopx070v9Xb4aMvjZ/oq5vSU
 n6P8HQgsDWDlCoaLQdz4/rCkaPupTu8QZIOry10VN8b+XVYA0/TsQ59/gvpMTk0rq2O2
 k4teuJ9B5UGqu9bUc2OlzAeVFIrTRB/LxvygABPMe3P90jrG/ytilBFyV1lZrPGYGLrr
 DXwBSmHNHrnugHUjaGsAoIHJ27nttyeJdNKEZ8JHKjJDETgXfsO0IHFmnZ6rSAy0tncS
 pMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355828; x=1786960628;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PB1WbMtOAFwpvE/F5EFj3Q/h9ZfB4E8+CQnZduBE9Aw=;
 b=rkWOi+4Dxb2xSSHi4f1MG67oUOlv0f7dw1ohqSCCM/WHC9g3dOeASiN4Cx1HBzCUXY
 gtBPRLSd2rFU3KZVZcUyrSztjMtqCUu/y5Y2bqS3yHg9W3+GCI06ybz239sfm+pP4GOS
 YAhsXWM99kHbCobJsa4Kvd5da64STKY5RoRm7oCIJ7XToEshTF0Atry96Yx1k8ZqTXCS
 5szLSpxH+lMfYCnavZqIxzZHH+wRdN5SLxt33sh8vEY47SXUKLsWcGjRBTTfH88moY4g
 1zG675WAsKsA0ak97O+1VLgHMHCuw/p+9i83beU7LaGs8cojxrvA+awJI4o9hsJr0ldM
 RMag==
X-Gm-Message-State: AOJu0YziE45tlTON6hmyogbblVqgVlhLLp3ooF6bVW0QdRkT7M8vUHha
 BLfDJdlq7ZUb1kNLe14E6+OjwL9l91cF3Au0KkAkESqPVDQJLvUMjkgGn2wWIlivP7w=
X-Gm-Gg: AR+sD118iNY+9Pyl+IkdQLixPwiLzdrbVglZGTTFoyex5bobNvwXhnis2AWt9/4Rleo
 I9zY+pSy26TNHqDH0+xe2V5mKCkl4zIfmDgK/AdGCE0MJI7lhekea+I84CaOFl7GSH2IP1t8rMT
 6cVTJUqsuGC6lyu0vxnajzBCjY+OXefXSYZLFxVnudrFFtJmN8l50S7aoRchtG8+IXfmExcsArn
 +SYAwW7oQV88urXo2Ruye9/5i53c52Um6mcH8q6jhmdZ9xLaIC5F6D+CJAUBWrQuHhPDAfrMoSM
 2kag+f4AXs2Re19zXtN2X/ejCAflMgW41UChbPMQ4caDW1vMC0AMerit9ZhplsHcZy3yGxYxTuk
 lxV47wzwwS03Aih+isuLd5OFouAXQlvXoJKKrfkfcAF8O2jZzSEMYVOrEss3NV2JARKAmAyYe2f
 /Ytc8zYG1kWxSVKn8G9Jd7Rt2Hb7TiQd1NDBgxz/5NwGH4LycbC7qVQd8XkYaCNmbNToGXEf4pI
 wXfHnC6683aP6RUt/bWj4Lh2CWTGfUJTlFDjQBUcu0=
X-Received: by 2002:a05:600c:e557:10b0:496:c06b:9fb4 with SMTP id
 5b1f17b1804b1-4994e7cbbd0mr444021445e9.14.1786355827717; 
 Mon, 10 Aug 2026 02:57:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32?
 ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420bd1csm412152735e9.3.2026.08.10.02.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 02:57:07 -0700 (PDT)
Message-ID: <3aaca93e-ea45-4a57-9532-7fb95f23c4fa@linaro.org>
Date: Mon, 10 Aug 2026 11:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi(); fix
 minor bugs
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>,
 Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260807-mipi-dsi-s6d16d0-multi-v1-1-c6179f6f3c98@gmail.com>
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
In-Reply-To: <20260807-mipi-dsi-s6d16d0-multi-v1-1-c6179f6f3c98@gmail.com>
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

On 8/8/26 00:55, Akash Sukhavasi wrote:
> The mipi_dsi_dcs_*() functions used by this driver are deprecated
> in favour of their _multi() counterparts, as noted in
> Documentation/gpu/todo.rst. The _multi() variants record the
> first error in a context structure and skip subsequent calls once
> an error is set, removing the need to check the return value
> after each command. They also log failures internally, making the
> per-call dev_err() calls redundant.
> 
> Convert prepare(), enable(), disable(), and unprepare() to use
> mipi_dsi_dcs_*_multi().
> 
> unprepare() previously returned an error if
> mipi_dsi_dcs_enter_sleep_mode() failed, skipping RESET assertion
> and regulator_disable(). Because drm_panel_unprepare() does not
> clear panel->prepared when the callback returns an error,
> drm_panel_prepare() would then return early on the next call,
> leaving the panel powered and unable to be re-initialised. The
> converted code always asserts RESET, disables the regulator, and
> returns 0.
> 
> Also fix a typo in a comment ("Enabe" -> "Enable").
> 
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> Compile tested only, no hardware available. checkpatch and a W=1
> build are clean.
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 56 ++++++++-------------------
>   1 file changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> index 54a65abf7e89..85b4515f443d 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -47,15 +47,10 @@ static inline struct s6d16d0 *panel_to_s6d16d0(struct drm_panel *panel)
>   static int s6d16d0_unprepare(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };

Ok why not keeping the original:

	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };


It's much easier to read, for me at least, but I won't block it...

>   
>   	/* Enter sleep mode */
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to enter sleep mode (%d)\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);

Add a comment you ignore the the dsi_ctx.accum_err and it's fine

>   
>   	/* Assert RESET */
>   	gpiod_set_value_cansleep(s6->reset_gpio, 1);
> @@ -67,7 +62,7 @@ static int s6d16d0_unprepare(struct drm_panel *panel)
>   static int s6d16d0_prepare(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };

Ditto

>   	int ret;
>   
>   	ret = regulator_enable(s6->supply);
> @@ -83,57 +78,38 @@ static int s6d16d0_prepare(struct drm_panel *panel)
>   	gpiod_set_value_cansleep(s6->reset_gpio, 0);
>   	msleep(120);
>   
> -	/* Enabe tearing mode: send TE (tearing effect) at VBLANK */
> -	ret = mipi_dsi_dcs_set_tear_on(dsi,
> +	/* Enable tearing mode: send TE (tearing effect) at VBLANK */
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx,
>   				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
> -		goto err_power_off;
> -	}
>   	/* Exit sleep mode and power on */
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
> -		goto err_power_off;
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err) {
> +		gpiod_set_value_cansleep(s6->reset_gpio, 1);
> +		regulator_disable(s6->supply);
> +		return dsi_ctx.accum_err;
>   	}
>   
>   	return 0;

You could write:

	if (dsi_ctx.accum_err) {
		gpiod_set_value_cansleep(s6->reset_gpio, 1);
		regulator_disable(s6->supply);
	}

	return dsi_ctx.accum_err;

> -
> -err_power_off:
> -	gpiod_set_value_cansleep(s6->reset_gpio, 1);
> -	regulator_disable(s6->supply);
> -
> -	return ret;
>   }
>   
>   static int s6d16d0_enable(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };

Ditto

>   
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to turn display on (%d)\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int s6d16d0_disable(struct drm_panel *panel)
>   {
>   	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };

Ditto

>   
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret) {
> -		dev_err(s6->dev, "failed to turn display off (%d)\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int s6d16d0_get_modes(struct drm_panel *panel,
> 
> ---
> base-commit: dc2f9f7fed1a8ea5290f9f60c6310d497e85e666
> change-id: 20260807-mipi-dsi-s6d16d0-multi-167e236e9666
> 
> Best regards,

Thanks,
Neil
