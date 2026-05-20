Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A95CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB5110E131;
	Wed, 20 May 2026 13:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ox5AMezY";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9D910E131
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:32:58 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso27560875e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779283977; x=1779888777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NyR0lUExHVdJdV8G0OFN7AbJBHhKInSpK/sXFoV8qMM=;
 b=Ox5AMezYClbv72Oq/zuInwTg+nAIkpt8igzSuipvCzzuH7lEq88SnM5/JsY7+D0YK6
 We9Rqpo1DDX4CJurmw6hokp0MMY4tTTWO4lXg1bUseRpVrqv+Hk50Ene4yhP9uUU0C9a
 QuRDa2tAHA7XISm1zEA2OXs+LZFRoFLdD5SCWLPU35gOAqpjRK4k6PHtdD9QMCgKh+US
 bfbnVSOs43QjOrBSQKAMZNF8OJOW6dPXCmY/s0qYXfbcS2PKkAU/Zc4xAHeKwf9mM8KF
 FHZJYrfbLe/OxyynCEq6UK3/AScUSytOjZvGKRwaey+h/mft0kzcegq2U6CC502wTfqv
 Umcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779283977; x=1779888777;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyR0lUExHVdJdV8G0OFN7AbJBHhKInSpK/sXFoV8qMM=;
 b=LQq3EmDGrRbVUUoFBeKnK3EhfWYAJ4qGoFDVlQnS7p62fTwX2Sy3hM+INeXJdEZmI5
 Bc9ZF8L9pH+u2iV4wFa1x7++TtrUzzn+qkjq2beAx/yELz1P9LTsKbG8JnnP5TYDBAmU
 mgkM/x5If+DlizZP8gpHQsbWMPae/SaifOPzOwzClY0/tZNkad2RxS0BmjdRccLwRNJx
 ZR+9kmry/OlbHBceKUijZM9YfZJeLlZHjJ9xX+6t/+GExvuC5Q0i2EH3CM616R9t2f7H
 EzMdTWrJAIuRgcWj+p+Nqq3HzuDQdViT/JUMGknwRyBb7ao1rktxOYckK8Uytar1B32V
 E63w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AzxCoVL0GTYBlLXQ62uubX5PyGsWRxvzzy1n3/Oh79/NUnGjkxZQVJASeDYwLD1ZqjoTs+A8oRO0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNQMz2a0bUTYhdhQ2XWsgmYgBQVOYSMLiUnm5jcC9BmlJVWUj8
 pITIOrZMaUoOqndx6rPfMF5Pczza+mmyULzHHCQB3dY598+uEjpj5ZmARJCL4hU8LZU=
X-Gm-Gg: Acq92OGuFuDr6D5KWjJQs/xOtNlMs2hhycRV/SgZM8EfGSqaXXqJJRfvtMAjdjQ/bwH
 HgqxYCxRUhcUMPnm4iaJ9fSAxVsX2rdzSSUiqa4zRINQdr2QDTzBHSqiNV3BrAYnWgMswQdaa0W
 7OKHeKsjmhcy+nsrJUe2ZVkRhldUpbm4dZFm4jI24OHnZnWbQYD0VQClxeBC09ebIx+1ZJ5HTaK
 IAYLG7eA3YsvQoG+gkZaxc1csKPZqrX2KWPQCYq84RZIYHzp2mtMFt1TRn7vermbFLuMlaC/x+h
 Y716Cw1JtwGxOQ8y6Z3lrjSNrSxwFm09ypw10jhDXivkgVBQ2obxpEtUacTJrFoSAEUUoKE1uVO
 6Gbig800CALzODtqxMhUTWJqTVJacPhH3bgS2eXDowMSXOyZSLumQr+MlwN99i5+puZ0zoVhtdG
 WQGaE36woa+k4BvUKTUIzJNtO70xqj75CjvHkC/WwfbtB6LVZDoGz/YKulhwLY2kxn1ipc5MkjE
 Q==
X-Received: by 2002:a05:600c:5296:b0:48a:65ad:1881 with SMTP id
 5b1f17b1804b1-48fe60ed846mr375637585e9.13.1779283976713; 
 Wed, 20 May 2026 06:32:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dec9:6d:b572:fe67?
 ([2a01:e0a:106d:1080:dec9:6d:b572:fe67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed30110sm58585852f8f.13.2026.05.20.06.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 06:32:56 -0700 (PDT)
Message-ID: <aa72f08c-1540-471f-8464-c4fa3db62e1a@linaro.org>
Date: Wed, 20 May 2026 15:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/8] drm/bridge: dw-hdmi: Use the common TMDS char rate
 constant
To: Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Andy Yan <andy.yan@rock-chips.com>,
 David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Robert Foss <rfoss@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-3-javierm@redhat.com>
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
In-Reply-To: <20260519144712.1418302-3-javierm@redhat.com>
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

On 5/19/26 16:46, Javier Martinez Canillas wrote:
> Replace the driver local HDMI14_MAX_TMDSCLK define with the shared
> constant defined in the <drm/display/drm_hdmi_helper.h> header.
> 
> The local define incorrectly referenced HDMI 1.4, but the 340 MHz
> maximum TMDS character rate was actually introduced in HDMI 1.3.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 41b3a9cfa2f5..d7c0a599aa42 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -51,8 +51,6 @@
>   /* DW-HDMI Controller >= 0x200a are at least compliant with SCDC version 1 */
>   #define SCDC_MIN_SOURCE_VERSION	0x1
>   
> -#define HDMI14_MAX_TMDSCLK	340000000
> -
>   static const u16 csc_coeff_default[3][4] = {
>   	{ 0x2000, 0x0000, 0x0000, 0x0000 },
>   	{ 0x0000, 0x2000, 0x0000, 0x0000 },
> @@ -1426,7 +1424,7 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi,
>   
>   	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
>   	if (dw_hdmi_support_scdc(hdmi, display)) {
> -		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
> +		if (mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3)
>   			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 1);
>   		else
>   			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 0);
> @@ -1671,7 +1669,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi,
>   	}
>   
>   	/* Wait for resuming transmission of TMDS clock and data */
> -	if (mtmdsclock > HDMI14_MAX_TMDSCLK)
> +	if (mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3)
>   		msleep(100);
>   
>   	return dw_hdmi_phy_power_on(hdmi);
> @@ -2032,7 +2030,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>   	/* Set up HDMI_FC_INVIDCONF */
>   	inv_val = (hdmi->hdmi_data.hdcp_enable ||
>   		   (dw_hdmi_support_scdc(hdmi, display) &&
> -		    (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> +		    (vmode->mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3 ||
>   		     hdmi_info->scdc.scrambling.low_rates)) ?
>   		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>   		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
> @@ -2100,7 +2098,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>   
>   	/* Scrambling Control */
>   	if (dw_hdmi_support_scdc(hdmi, display)) {
> -		if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> +		if (vmode->mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3 ||
>   		    hdmi_info->scdc.scrambling.low_rates) {
>   			/*
>   			 * HDMI2.0 Specifies the following procedure:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
