Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22591CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C2D10EEE1;
	Wed, 20 May 2026 13:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qItHrOLE";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC48410E14F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:33:07 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488d2079582so47314665e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779283986; x=1779888786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+BbUsY922weMR93UyHTzY/cK/43gwBu0eJe2gDDiTIU=;
 b=qItHrOLEelVtTEwV9BA17+/0kWpbHZPggXHNoC1QyVoSlEQoTAot1ZqtWOpCeaDDAY
 dc666ge/thUY7RmSi/k+W8aTeRo8u5f8BCcwakma27aDt5lMUM13t3W8iWQ+QM3H85is
 yrBY8j2Z1mb8M5SYgcjB8YKFd36zrbHE2kIZPpBOpnpWwBw7Ee+Efne26DzE+Lxa/Irb
 NXsI/gQdkrgBBkFcousfH5HM5jZZxS6LTCdZp9kWjm7FHpJKDlO+TttZadOxNHr68f9P
 QRYFVREXoee2Dfmp84cKEHWOeyeY5LXHtDCNwsdUfmCIFg5T6arumUskmjnBCfDhuzaw
 VuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779283986; x=1779888786;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BbUsY922weMR93UyHTzY/cK/43gwBu0eJe2gDDiTIU=;
 b=Fxup+r3/RuSC18MBzJu+Xtxq1AndecxjGW4pHtssedxMS2FAkcNngWF2duYK4C+waV
 gSC4eIllmdhormUu8NW4OJ0LSy1vD+0kjCqxjLZE9KhwBVWpYtxZ0Iw6AvkzefsBcPTy
 2FC4dVOhFWXRdCXE3Hf8MhLO39L+GbNs4kG+2BPzO2TAT58hTBTpEsBalupjZTdfiJAK
 kTfTsrnrv8pUs5f/HTo6ukQDWohbS3Uwvv9hhoYi6t3pgZYOC6QCie0n7NCXZ458Cy/K
 rS1wreruQpqqQxittKCHXj5SE+xS1kFKbzZbq7B5k5uCGSQ6I8WV1fR7UiC8FaNgbW6M
 BNpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9toi3dsvpg4rgc3/HYJNOSZzQ8g+tSE+IbrSiOBql9k1AULIZ7QhZmGT1nOMlRX3Csc7790GWJLbw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIUK+jPipDQ4Alv+Afvb6i986ae5wxytbheEOwdnX1aRmAbMLu
 URbPOClL4QfLQaKo8xVUY3/ox4Foze97IBkakDGBligsdF8qrIdGLBhkfKpuK27hHgI=
X-Gm-Gg: Acq92OGGGTlHdXWd7UEHSnDtFkHmcsjNILsFZUl4tKu/geoN+2W3ORHbrsxaIqPFsFv
 M3Av/Sce0r9+G04xacgOEGAmkw93l9pEPIuXUc0t9vfo/wZwDNx2upBNfK5WJ7NCqMO9W/K7YHB
 u7MjgiP3fk2M5IqAebHGpOB5mHYgTfWbaPNivWaNanYz12zWNNAjWB+JqaB2GFdTS3wuaSFmfkF
 SwDufbqWs43vl7iwrUEeARVEnaFs77DQz/OILGVevZqs9fzkVP2HMwRQeGNbzHzi2AhzOSwCXW/
 qBD8rKg9wnN4vv9xAMyuOzOsVSe/ke6vTHB/B8fEuTMQQPudis0/LPWF3LogiPWrtU7mbf6bayn
 QnJf9Pdr2Eme12YBs33KPfdc37DrHi+Ip0pvrNBGZmbvFJcCP59oLTX81qX4rWKvLKplRQHcFht
 WUTnuJyC7aSsVfWBdhomqW7bPf60+IXRimjeYMpRWqrnwuZ+lHvIz6GLk4e32+eNzRX6Ixe4A74
 j3FSFY1aSm8
X-Received: by 2002:a05:600c:34c3:b0:48f:d0f7:78f1 with SMTP id
 5b1f17b1804b1-48fe60e4e27mr391117575e9.4.1779283986137; 
 Wed, 20 May 2026 06:33:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dec9:6d:b572:fe67?
 ([2a01:e0a:106d:1080:dec9:6d:b572:fe67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490225bf8d6sm91045615e9.13.2026.05.20.06.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 06:33:05 -0700 (PDT)
Message-ID: <7e80eeb5-68d4-435b-ac65-c9f4e00ad6dc@linaro.org>
Date: Wed, 20 May 2026 15:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/8] drm/bridge: dw-hdmi-qp: Use the common TMDS char rate
 constant
To: Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Andy Yan <andy.yan@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniels@collabora.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-4-javierm@redhat.com>
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
In-Reply-To: <20260519144712.1418302-4-javierm@redhat.com>
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
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index 0dbb12743609..37d8292b6f7f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -38,8 +38,6 @@
>   #define DDC_CI_ADDR		0x37
>   #define DDC_SEGMENT_ADDR	0x30
>   
> -#define HDMI14_MAX_TMDSCLK	340000000
> -
>   #define SCRAMB_POLL_DELAY_MS	3000
>   
>   /*
> @@ -835,9 +833,9 @@ dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
>   	/*
>   	 * TODO: when hdmi->no_hpd is 1 we must not support modes that
>   	 * require scrambling, including every mode with a clock above
> -	 * HDMI14_MAX_TMDSCLK.
> +	 * DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3.
>   	 */
> -	if (rate > HDMI14_MAX_TMDSCLK) {
> +	if (rate > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3) {
>   		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
>   		return MODE_CLOCK_HIGH;
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
