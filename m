Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97550C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31AC10F582;
	Thu, 24 Sep 2026 13:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e69f5b56";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763CA10F582
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:36:12 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843378fb37so1216885f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256971; x=1790861771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7kq1rlVWGiV1pqhG3Dazdv4aEIgD6fu2O0iHNrxpq1g=;
 b=e69f5b56rQ0yvE74xAf+Hs0n1C6Ojjrn6kbdmqUl6IdsaUf8xtwIWVfF+f5/zocNXQ
 sW0XemEklLEezByCC0hIJ4bK6vtRSQtqJtv0T783N41brzLo2xdyxNZVBxgFls8eN2bf
 0MEQ9HuY9SqMkoTg2zVHhyK/QY7auTjXLG6B622rzd9pmcHSxc781Fk7gwvEbjasj3E2
 gqvcbiM01Gk2vOSn09VTlUY9WfX7eAvkp+/SeGoN9+ObPFsmhx01qn058HtOP/tP+vlF
 Amr5p4hCMK53UxBfVT+5uxM5Y/6Mo7fBB6V12g8Y3oYd36jgx9g7/u8xyaXdkes4jwMV
 vA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256971; x=1790861771;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7kq1rlVWGiV1pqhG3Dazdv4aEIgD6fu2O0iHNrxpq1g=;
 b=yq6cpZJdCoqkdydv1gYIC0mb+6lW9w5Z6yOAStgwh60asB+fNLl/UZ97BpLa5SjEsC
 phNMpZecqYHuD6mzX6NS8puabRBW8qrVlDjAYox1cRRyNZMC5cMh9rYRLNTvHXRhZYCf
 rhR4DAfZH/XWzghkJmaSi0qlVQw52e1/ymQRO5gw2XGljv85W5je1dF8ccMcucq82KE7
 IP4I47SaUO5DF0lTaagyOw0flnHc/pdZFGCvuwYGYTcf3bHf2zzWdXe7iPPQi/FegZbb
 SUXHeisY+EZxJ1EnUWdQ0oexc0v3j6O6pPs+B5xGRC2vOzJNKAWX7OBc9fJFMogtC3M+
 /P1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOFKI/XhElFQ8zVk7wBFnrISx9NNUAD1JOIMh/JqBmvwVWITW6Rhe5gERbvG9jN4/oAN5HtPuOJwo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljassQ5b8KgoGG7giNsXQiM7IJ7j0hvtXRmZwAGNU2k4exIwCM
 4nMzofVe7dsg+LCy1XYU6NpGU5f7PghA5Lwmud1f+qgDRav2D13pi8EeVXoHzOH0so1nxUd4EsD
 vNcmH3C4=
X-Gm-Gg: AYBFou1/FYtWWxy3P2W54BmM5+4L2rpHEMcQ3VJRbnVo0jZ8Y6xBqWTA0tvamajqmA3
 zkltk85Y0Njgl9qiOl9Zvn+zCNvZxBxiDnpzG27NRRfyEwewoY0WBmDn/tcM286czbO+DDkun+M
 1e3kyL4XurIu4u5e6aIORr1ZlQD+UuKQjmnlcTNZduG5fc/bQuqjA0qLPsGuXna0mb/Y2V2FBWN
 L+qxuT35bc6loyP2emqY1GuFEk1DDMrtL6aZDVtt7zTZJ97UEVFbg0BnQDVNRabHVA9DdfldzIi
 JcdhZB/3Ox3ma01scsMOxtOXP3dEygb3PfoUNqzKOc2qHHMJhd31Tna9pQzFih94nhbm3/Q+y6p
 iFy2ByjsdehPqPrb0tgcH9klMd8pB8ik+A6b6zvj957ciIbkQf3lFXCLQK1aZmORPi3pa7DVY4r
 G6crPMitVyAq8ww9GZJ+WJSzfhb1gL5wPXj23zDiD3IqxSkAJJQA1i1oK/IjXC5o+O9e63MYQYG
 xbjuiOK7LhqbWQxtenevoEThU9QaWQ7czrVAIv7Qf0ptZdEbZoRSQ==
X-Received: by 2002:a05:6000:2885:b0:487:1572:e8c6 with SMTP id
 ffacd0b85a97d-488716b22c7mr4810267f8f.53.1790256970626; 
 Thu, 24 Sep 2026 06:36:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c027sm16399749f8f.17.2026.09.24.06.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:36:10 -0700 (PDT)
Message-ID: <62d21c0e-8b67-4a50-bdf4-f13d7fae349c@linaro.org>
Date: Thu, 24 Sep 2026 15:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 7/9] drm/panel: novatek-nt36672a: Add Tianma panel for
 Xiaomi Mi A2
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>,
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 phone-devel@vger.kernel.org
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
 <20260917-nt36672a-panels-v2-7-f8de8be5b86f@minlexx.ru>
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
In-Reply-To: <20260917-nt36672a-panels-v2-7-f8de8be5b86f@minlexx.ru>
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

On 9/17/26 18:43, Alexey Minnekhanov wrote:
> Add support for Tianma TL060FVXS16-00 video mode panel based on
> Novatek NT36672A, used in Xiaomi Mi A2 smartphone (xiaomi-jasmine).
> It shares some code with already supported panel in this driver
> for xiaomi-lavender, so we can reuse the same panel deinit function.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> ---
> v2: use mipi_dsi_usleep_range() instead of usleep_range()
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 57 ++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index d356348d39608..48dff2279b0e9 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -441,6 +441,29 @@ static void lavender_tulip_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>   	mipi_dsi_msleep(dsi_ctx, 120);
>   }
>   
> +static void tianma_jasmine_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	dsi_ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PARTIAL_ROWS, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PARTIAL_COLUMNS, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x32, 0x2f);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 70);
> +
> +	mipi_dsi_dcs_set_display_brightness_multi(dsi_ctx, 0x00ff);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x68, 0x03, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x2c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
> +
> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
> +	mipi_dsi_usleep_range(dsi_ctx, 5000, 6000);
> +}
> +
>   static const struct drm_display_mode tianma_fhd_video_panel_default_mode = {
>   	.clock		= 161331,
>   
> @@ -552,6 +575,39 @@ static const struct nt36672a_panel_desc tianmaplus_e7t_tulip_panel_desc = {
>   	.send_deinit_cmds = lavender_tulip_deinit_cmds,
>   };
>   
> +static const struct drm_display_mode tianma_jasmine_panel_default_mode = {
> +	.clock		= (1080 + 96 + 4 + 56) * (2160 + 4 + 2 + 33) * 60 / 1000,
> +
> +	.hdisplay	= 1080,
> +	.hsync_start	= 1080 + 96,
> +	.hsync_end	= 1080 + 96 + 4,
> +	.htotal		= 1080 + 96 + 4 + 56,
> +
> +	.vdisplay	= 2160,
> +	.vsync_start	= 2160 + 4,
> +	.vsync_end	= 2160 + 4 + 2,
> +	.vtotal		= 2160 + 4 + 2 + 33,
> +
> +	.width_mm = 68,
> +	.height_mm = 136,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct nt36672a_panel_desc tianma_jasmine_panel_desc = {
> +	.display_mode = &tianma_jasmine_panel_default_mode,
> +
> +	.width_mm = 68,
> +	.height_mm = 136,
> +
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +	.send_init_cmds = tianma_jasmine_init_cmds,
> +	/* jasmine panel uses the same deinit sequence as lavender/tulip */
> +	.send_deinit_cmds = lavender_tulip_deinit_cmds,
> +};
> +
>   static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
>   {
>   	struct device *dev = &pinfo->link->dev;
> @@ -630,6 +686,7 @@ static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
>   static const struct of_device_id panel_nt36672a_match[] = {
>   	{ .compatible = "shenchao,fhdplus-video", .data = &shenchao_lavender_panel_desc },
>   	{ .compatible = "tianma,fhd-video", .data = &tianma_fhd_video_panel_desc },
> +	{ .compatible = "tianma,tl060fvxs16-00", .data = &tianma_jasmine_panel_desc },
>   	{ .compatible = "tianma,tl063fvmc43-02", .data = &tianmaplus_e7t_tulip_panel_desc },
>   	{ .compatible = "tianma,tl063fvmca01-00", .data = &tianma_lavender_panel_desc },
>   	{ },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
