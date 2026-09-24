Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A649C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68D310F53A;
	Thu, 24 Sep 2026 13:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L0FCqFIN";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A169710F53A
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:16:51 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so1301584f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790255810; x=1790860610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e72LlFud0CCI0EsfmN7tiOkPcKOczfDlT5tJOUrL9HM=;
 b=L0FCqFINfktJ/WhyXDxCG1YcpeNaKZTtoskCoaAyZ3BHr1awMijcVTU/PNxohbRDbv
 qwaNlaNsyT/w9Ykre8hqqrfy2ceRJOOkooEY7q34+X85Z6QEXmKpl1UdHaHyAxoqe3Bx
 OvnPmZ8cEUcGnFvmeVSL3b0Wlmm5/gOwEv0n3jpfjeyctb8VHtVx2uM33JQxWGgyj/h6
 0bxKgcwGn8KoILyieEjpijmM0wUBjOUrtf3B4yL0rDG9uLiyUufe0EthZZzx5NYBW0gp
 J3UkFhc+3EKwEZPX2VrGbuaYw9QShdCWHSpXISJj11AaFcp91DH7ERrk0ur2fEAdObxv
 9tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790255810; x=1790860610;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e72LlFud0CCI0EsfmN7tiOkPcKOczfDlT5tJOUrL9HM=;
 b=yhzbavSDKCgM+KrsFbikh1RIlnoXTf/+hXU6OBgzHxGmL6iE3ndSIbugKBXV40KH6v
 bc+vsReRNeZxEmXJnqlS/z0qkkrHEdMC4LnWUwIw+uJARFwqiY6b7XBVn4WEHhbyYxOP
 dMRrGoUW3IYunMtw5dit0Rw/GSvgCRnDQykOBWOqpFn5MhJnXX9kWY9oNBx5/8Zh7smN
 s96TikPqnF/j1+l044j2Aa3hUY9ISCmoaHivcvFEZAFU11pY7JHRtMN2FLHawa3jf1SE
 FHOSaBivr6RADcSUQ1ERrNVWcYa7iTl9jRNW/PQtUilmcMqYTcxaFhzzgt/7Oo/9ngHv
 MO+Q==
X-Gm-Message-State: AFuF++mimwvE263IeZjQHjgDCDSdsnF4Lc/zPrbivGVt9yPO7u/PTd9J
 HyFIWf7iiappTTSjWqxzUsN41Pm7Q0SlrCAiHPuaOQauZ5QSm2l/wPq8ESMZLx40uAc=
X-Gm-Gg: AYBFou3pTIcTLkraF7HLvl/9VUmJnJXFhDvdKJHwkj3LrHmXzNpf2I0x/LGZeX52geC
 FxQs6QhCCvaiqVJp1TRwWZhI0Jzp3to4Q6vma7FpmWsx0wSLsbSl/Kd0IXn5n22urgticx+b4EX
 sOi1bCPKklAOpDjfmH30i5iGNXQ01fyKIYyKvbFtxFMF2fO71/sFoYD4McuVLu6GLd1uwGK0Syb
 Wcf4tpBjGPGMBNMqzayr82cMwWG1PzWpVGBsMvr+Md/EK/U61hP+YjojWPeZAo33Aw0/+MWM4oh
 ISr3WUeTWD2cvy/rueRTfObbUjoDRBsM0xdGZXW35fyTOLU99z7SpPLL6A9ek8PR59b0GH7TlLF
 ShJizUSOJAJrgqGYDuthmdHfDvvvt74nDTotrIdcQReQdmSuLl0XCZglPEg313jVuZKnzd0JVv2
 BgClt+UTrDOEkdLwxCZLNp5K3EWIPymbSQtFrgITgGhOmr71ksgQQ3cEGvkm84NEWpEJ52nzWR6
 jAaImclyIP4ruMNCQ3BfQHUHgShuUG5oB4is4twv4VdtoccQJ6jYfjH1cUuMd+S
X-Received: by 2002:a05:6000:1863:b0:487:342:d142 with SMTP id
 ffacd0b85a97d-4887175ae72mr4705434f8f.44.1790255809815; 
 Thu, 24 Sep 2026 06:16:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684863d9sm14842399f8f.12.2026.09.24.06.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:16:49 -0700 (PDT)
Message-ID: <78aa5e0b-b3ab-4e33-a17e-a353d65d86bc@linaro.org>
Date: Thu, 24 Sep 2026 15:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/3] drm/panel: ebbg-ft8719: Split initialization into
 enable/disable fn
To: david@ixit.cz, Joel Selvaraj <foss@joelselvaraj.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
 <20260908-ebbg-ft8719-fixups-v2-3-5454ae1f5581@ixit.cz>
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
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-3-5454ae1f5581@ixit.cz>
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

On 9/8/26 14:45, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Move the MIPI commands into enable/disable callbacks since they
> are called between prepare/unprepare callbacks.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> index 14982263a94f1..1652de70900f1 100644
> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> @@ -49,74 +49,69 @@ static void ebbg_ft8719_reset(struct ebbg_ft8719 *ctx)
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>   	usleep_range(4000, 5000);
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   	usleep_range(1000, 2000);
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>   	usleep_range(15000, 16000);
>   }
>   
> -static int ebbg_ft8719_on(struct ebbg_ft8719 *ctx)
> +static int ebbg_ft8719_enable(struct drm_panel *panel)
>   {
> +	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>   	struct mipi_dsi_device *dsi = ctx->dsi;
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
>   	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>   
>   	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
>   
>   	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>   	mipi_dsi_msleep(&dsi_ctx, 90);
>   	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>   
>   	return dsi_ctx.accum_err;
>   }
>   
> -static int ebbg_ft8719_off(struct ebbg_ft8719 *ctx)
> +static int ebbg_ft8719_disable(struct drm_panel *panel)
>   {
> +	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>   	struct mipi_dsi_device *dsi = ctx->dsi;
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   	mipi_dsi_msleep(&dsi_ctx, 90);
>   
> -	return dsi_ctx.accum_err;
> +	return 0;
>   }
>   
>   static int ebbg_ft8719_prepare(struct drm_panel *panel)
>   {
>   	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>   	int ret;
>   
>   	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>   	if (ret < 0)
>   		return ret;
>   
>   	ebbg_ft8719_reset(ctx);
>   
> -	ret = ebbg_ft8719_on(ctx);
> -	if (ret < 0) {
> -		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   
>   static int ebbg_ft8719_unprepare(struct drm_panel *panel)
>   {
>   	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>   
> -	ebbg_ft8719_off(ctx);
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>   
>   	return 0;
>   }
>   
>   static const struct drm_display_mode ebbg_ft8719_mode = {
>   	.clock = (1080 + 28 + 4 + 16) * (2246 + 120 + 4 + 12) * 60 / 1000,
> @@ -148,16 +143,18 @@ static int ebbg_ft8719_get_modes(struct drm_panel *panel,
>   	connector->display_info.height_mm = mode->height_mm;
>   	drm_mode_probed_add(connector, mode);
>   
>   	return 1;
>   }
>   
>   static const struct drm_panel_funcs ebbg_ft8719_panel_funcs = {
>   	.prepare = ebbg_ft8719_prepare,
> +	.enable = ebbg_ft8719_enable,
> +	.disable = ebbg_ft8719_disable,
>   	.unprepare = ebbg_ft8719_unprepare,
>   	.get_modes = ebbg_ft8719_get_modes,
>   };
>   
>   static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
>   	struct ebbg_ft8719 *ctx;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
