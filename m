Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E808C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9AA10EF64;
	Wed, 12 Aug 2026 11:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w/7U++a4";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EC210EF64
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 11:50:34 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso8261395e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786535432; x=1787140232; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chiiEuqdm3rLXI4bL+ILzzFBPrfb/qRhs+Zf8F1BEQA=;
 b=w/7U++a4RTP1KnrZeiXaz8A9Rcfb2ZGaX1KnCuATEO8X6rDmgBgIUyhlKsIoc/oSjA
 TTyCYK7Fnk9XUxtPm95rACwZVluEpTxMPdnkffeouOAmiBk9Oobuu1uHOayz9as7SXW4
 yKld/EY5UgmUK/PAXYsF3AT3sWWhIOCQDoeeo9Owi7TVz3HKXSI5/meCRsFH2G9Qxbgb
 KXjpye5CE3bz7XmWHzCInAskzLCdunWpLbUpCkkb+VJ97Ua8AJ/kS8bwZi5JyUmhr7+n
 lNh4WZARwWKzSC2DXDFbdyGWX4ssmkSnYeo1hx/J+6lX8nml/4B7UmiZH9yqzVo1Q1Aw
 8E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786535432; x=1787140232;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=chiiEuqdm3rLXI4bL+ILzzFBPrfb/qRhs+Zf8F1BEQA=;
 b=NCCic7HEt739OiW4tEasqtzfuheJo3uRu5Rjapil0SOXBL8b4QxX92kaTauR3gfrZ4
 1HcTV+OHZb0j6Bm3hkRCUTHIq78jFWt8tITG6HCnFcmRHYjUxzUCLmc5d7QeLavVN6Xx
 nQIkrve/7k4/Mr60+HRDggvdnky4nldZqdCXLrewGNsIE89ZCRnSlZtXUBRfrTta6NkX
 B6hu/Y0yozOLQkcqeeYgtFaiqqn2eHMPSZEv2RY2yhCw3FM/nIeztYNxKwGh4Z7TmbsC
 IUDlk9YIQhYLgqLEkw5c48BIwZEaVkolgO18OeUmidk67+3HVojKgiPTxZOcC7S17zlC
 qxVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RprsUEJL9W393zbTI3JKDpOR9+kLY8wHicJjru4dsqPBWlmHxHXPraLBhdI8w2YmNRDQLmFqconjEA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxx1tgR4o4qx02PxRWUfudBsw5giBiQFSshdYuwF9T0nzLFlnAy
 fTkD/tHX4MYisTbR7OE+IY3pSSfkUkh/1HpCmGVxcWMuSK1NlLZSrvEuRfrQ5qZpWy0=
X-Gm-Gg: AR+sD118FPn4NR++dr8IVHC4fcMHOoJQaGEtR32hNBOIhXFC4mQGwO/m/dsDIF365gY
 opHAQTOaYAVtRwt0SHWWLLjIyoKLXiP/i3b4heB1F6R0Sn0g02hZFHZcCQHoJR/mRAsfWrtNGrI
 22Gn7jrVo8oJszjiMzESsJ7nlf+A4go+N/gHXjpdoh/SHTCq0Jo5eI/TPSRL90b7/+Hcwb8wt7F
 NBYGXFscRnjWLmM6JWNj9YyZ150Cu3Jfpu1MeXyot5fhpahIDF5DexSUF+cEXDyphBq5oLXugJg
 6Najl1qW7A2fr5+358fOW0OAlvwDY0o+nP+67M185AApjy+injF/lL1yIe4grOTmZ/YbLkeIqqX
 DvUA4JOFkAbA3XVeBDLoJ7xjfeuoVkgiHX2EDgdHLmc+1ww3yhLvHjk+fy1Bvah8LLdu6O1nmrB
 cvZORmA9p9oQDbrPRGU+BDVnU0RXGXBHH5nD5De67VNFfiIwKYSoIaMJE9URL22LIjkPRy4ufWy
 ptow5d3Qhnn06VTcjMaI+MIvrDwKjPV50NBylQUObbyZJ91oQ==
X-Received: by 2002:a05:600c:a213:b0:499:737c:8a8b with SMTP id
 5b1f17b1804b1-4997c12c7e8mr38151595e9.12.1786535432234; 
 Wed, 12 Aug 2026 04:50:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:405d:735d:801e:de34?
 ([2a01:e0a:106d:1080:405d:735d:801e:de34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997d2ba6e5sm18736205e9.1.2026.08.12.04.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 04:50:31 -0700 (PDT)
Message-ID: <0510ced7-7c91-4b00-bc7f-773a9b6517eb@linaro.org>
Date: Wed, 12 Aug 2026 13:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
To: Osama Abdelkader <osama.abdelkader@gmail.com>, luca.ceresoli@bootlin.com, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260811165037.12437-1-osama.abdelkader@gmail.com>
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
In-Reply-To: <20260811165037.12437-1-osama.abdelkader@gmail.com>
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

Hi,

On 8/11/26 18:50, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
> corresponding manual detach calls from remove paths.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> v2:
> - break long description lines.
> - add Signed-off-by tag

Please move the changelog after the ---, or use a tool like b4 to handle that
automatically.

> ---
>   drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c       | 8 +-------
>   drivers/gpu/drm/panel/panel-boe-himax8279d.c         | 8 +-------
>   drivers/gpu/drm/panel/panel-boe-td4320.c             | 8 +-------
>   drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 4 +---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c       | 8 +-------
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 7 +------
>   6 files changed, 6 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> index 84c21c62a43e..6a74523a6614 100644
> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> @@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
>   
>   	drm_panel_add(&boe->panel);
>   
> -	ret = mipi_dsi_attach(dsi);
> +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>   		return ret;
> @@ -371,12 +371,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
>   static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
>   {
>   	struct boe_bf060y8m_aj0 *boe = mipi_dsi_get_drvdata(dsi);
> -	int ret;
> -
> -	ret = mipi_dsi_detach(dsi);
> -	if (ret < 0)
> -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> -
>   	drm_panel_remove(&boe->panel);
>   }
>   
> diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> index 4a8560b4b899..ffcb63f65b75 100644
> --- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> +++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> @@ -881,7 +881,7 @@ static int panel_probe(struct mipi_dsi_device *dsi)
>   	if (err < 0)
>   		return err;
>   
> -	err = mipi_dsi_attach(dsi);
> +	err = devm_mipi_dsi_attach(&dsi->dev, dsi);
>   	if (err < 0)
>   		drm_panel_remove(&pinfo->base);
>   
> @@ -891,12 +891,6 @@ static int panel_probe(struct mipi_dsi_device *dsi)
>   static void panel_remove(struct mipi_dsi_device *dsi)
>   {
>   	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
> -	int err;
> -
> -	err = mipi_dsi_detach(dsi);
> -	if (err < 0)
> -		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
> -
>   	drm_panel_remove(&pinfo->base);
>   }
>   
> diff --git a/drivers/gpu/drm/panel/panel-boe-td4320.c b/drivers/gpu/drm/panel/panel-boe-td4320.c
> index 23558a76dd72..704d5a9c13e7 100644
> --- a/drivers/gpu/drm/panel/panel-boe-td4320.c
> +++ b/drivers/gpu/drm/panel/panel-boe-td4320.c
> @@ -204,7 +204,7 @@ static int boe_td4320_probe(struct mipi_dsi_device *dsi)
>   
>   	drm_panel_add(&ctx->panel);
>   
> -	ret = mipi_dsi_attach(dsi);
> +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
>   	if (ret < 0) {
>   		drm_panel_remove(&ctx->panel);
>   		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> @@ -216,12 +216,6 @@ static int boe_td4320_probe(struct mipi_dsi_device *dsi)
>   static void boe_td4320_remove(struct mipi_dsi_device *dsi)
>   {
>   	struct boe_td4320 *ctx = mipi_dsi_get_drvdata(dsi);
> -	int ret;
> -
> -	ret = mipi_dsi_detach(dsi);
> -	if (ret < 0)
> -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> -
>   	drm_panel_remove(&ctx->panel);
>   }
>   
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index a70a2e58f88c..94cc675973e6 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -393,7 +393,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
>   
>   	drm_panel_add(&ctx->panel);
>   
> -	ret = mipi_dsi_attach(dsi);
> +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
>   	if (ret < 0) {
>   		dev_err_probe(&dsi->dev, ret,
>   			      "Failed to attach panel to DSI host\n");
> @@ -407,8 +407,6 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
>   static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
>   {
>   	struct boe_th101mb31ig002 *ctx = mipi_dsi_get_drvdata(dsi);
> -
> -	mipi_dsi_detach(dsi);
>   	drm_panel_remove(&ctx->panel);
>   }
>   
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
> index 20b6e11a7d84..2ab7764d4094 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
> @@ -200,7 +200,7 @@ static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
>   
>   	drm_panel_add(&ctx->panel);
>   
> -	ret = mipi_dsi_attach(dsi);
> +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
>   	if (ret < 0) {
>   		drm_panel_remove(&ctx->panel);
>   		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
> @@ -212,12 +212,6 @@ static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
>   static void boe_tv101wum_ll2_remove(struct mipi_dsi_device *dsi)
>   {
>   	struct boe_tv101wum_ll2 *ctx = mipi_dsi_get_drvdata(dsi);
> -	int ret;
> -
> -	ret = mipi_dsi_detach(dsi);
> -	if (ret < 0)
> -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> -
>   	drm_panel_remove(&ctx->panel);
>   }
>   
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 150dff3ab6c3..7d2672578dd8 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1765,7 +1765,7 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
>   
>   	mipi_dsi_set_drvdata(dsi, boe);
>   
> -	ret = mipi_dsi_attach(dsi);
> +	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
>   	if (ret)
>   		drm_panel_remove(&boe->base);
>   
> @@ -1775,11 +1775,6 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
>   static void boe_panel_remove(struct mipi_dsi_device *dsi)
>   {
>   	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> -	int ret;
> -
> -	ret = mipi_dsi_detach(dsi);
> -	if (ret < 0)
> -		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
>   
>   	if (boe->base.dev)
>   		drm_panel_remove(&boe->base);

Otherwise looks good.

Thanks,
Neil
