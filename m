Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AA5CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5397710EABF;
	Tue, 19 May 2026 07:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vran/ARE";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1EE710E364
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:23:18 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso42767905e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779175397; x=1779780197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sfKsH9xwm+tQ3snlH8Sxro/uZ5qaHdIhEycOMeeCONk=;
 b=vran/AREgwkRwiNw8PFKwzvv7KTdFbrCsSDd8PTwvai1lAsGFbpzAykJnt+8nWK5lS
 Z9inXw3caqHCIh4NprIjCZPeqKl89LUrOcJeyFdRyQIyVbs7c2nkH9VEunsPsOvwEOW/
 CYrC/5h9EaQYZZBR0L7aeeY9Z6glso2Z2iveniFtxcAWyAJSpz/mgTxmqioB7XO5AH7T
 P1KWgnt/rt9Yo8+xxtLAaI4lPxVRiM3aRIOV9ZNHUWCotEIQ1nn9byZTFr3p61Ekk8zj
 ksV4lxfDrqJRvQsptOLVXhA8DSZs3GQ+oCX6vT2Pj+QEUBZD5RCnDnpAsJIy4Umi9l1a
 xTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175397; x=1779780197;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfKsH9xwm+tQ3snlH8Sxro/uZ5qaHdIhEycOMeeCONk=;
 b=mehPs8kYB/smwoiC5y09bkfM8CfW65hNz5MZtH3+wC/EZDo68GPvHfpGVT9ycs3a+s
 xclSeRGy8wmFT+bvkYOMzUtS4PckWi4/MLOI+vz7hD+gJRV2TIyAA2NMhNiILWyxRXNi
 1/hH7lAu9OhDH9ArBRvfbEbVa0EkelneBqQtydG7/aBcssirRc5lh0HH+tw5rFz5Kil8
 j79dLZpGslIWm/vkfMWx4ZJ221CPSwXLSxV8cB7bQ5YCXZYYoU8OnvyGpvz75t5lJeuF
 b7+qjnGZJAPTazsgvDxvrCky3KQMm/7AAV5kAuw8kISTGxg0oDi7PlLRHvEUea97XJ3p
 ObOw==
X-Gm-Message-State: AOJu0Yzfpbe68o1l7DqxuZ43A9eei1YyR9ammEF/gh8FyDNevyhdphjD
 +k4pij0XpuSLf7u3XaBLiXxgRDhIWoaBFAL8rWtJYWq1eNiJIcZuuXUExXMjy+q/eGs=
X-Gm-Gg: Acq92OEqyMi2jCCe3vXCCJ95ZZSLu8hb83ECydXYe8Y/HN0KTnVVe7tq0K/lwJSFEC2
 c4N/o8JI+wVSwKStFuyWNlcIepIXBTkvFJTixB/04bSNzqxjpRcaJ97It8ZhS97aD/Af4Vsnt70
 SkKYZW9o5+h2jmxPxccs0F1+yOnklD7VXbbheBp2NPOyq2qoQdQDBkMvY41MNzJyvTuqG+xBOVg
 a6sveVcr0kguHwwbGge9Dax7pYdBa8JR1R19i1o8aWIRYsD+3/GnrGJBeLtMDZRptT+hjChUZLV
 nwzx1XXeqkuMEdqCS1lHW3aeNWIqvGZNr0t44tjjvc/FKQimNoD7qLEj4XSzkjuOVYmgbz32pML
 8WL1DLt7v6RqUTZiJw7p7ep6ULeQl+nng23YWiCs5Cp/eujT1ig1KpJds1YRvNttOmXm/mq9xtP
 KTqZR953mzbOxNFaajZ2MGIcleuAorvIvoi3l0rsx3O1CntVAT+JdqZ6+02YngJywUpUjswCfO+
 QMrae5lbNVPtaPlx1wPbKJ86A==
X-Received: by 2002:a05:600c:4fc9:b0:48f:d612:3c40 with SMTP id
 5b1f17b1804b1-48fe60e47bfmr256329325e9.7.1779175396985; 
 Tue, 19 May 2026 00:23:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6449sm43240799f8f.37.2026.05.19.00.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:23:16 -0700 (PDT)
Message-ID: <77cff8e2-11a6-4fd0-ac02-7468441f7476@linaro.org>
Date: Tue, 19 May 2026 09:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 01/13] drm/meson: dw-hdmi: Report connector status based
 on HPD bit
To: Jonas Karlman <jonas@kwiboo.se>, Kevin Hilman <khilman@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20260518194744.2483580-1-jonas@kwiboo.se>
 <20260518194744.2483580-2-jonas@kwiboo.se>
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
In-Reply-To: <20260518194744.2483580-2-jonas@kwiboo.se>
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

On 5/18/26 21:47, Jonas Karlman wrote:
> G12A added support for RX-SENSE, status for both HPD and RX-SENSE is
> reported in the TOP_STAT0 register.
> 
> Limit read_hpd() phy ops to only report connected status based on the
> HPD status bit in TOP_STAT0, to help ensure that EDID can be read from
> the sink in the connector detect() func.
> 
> Fixes: 3b7c1237a72a ("drm/meson: Add G12A support for the DW-HDMI Glue")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 6 ++++--
>   drivers/gpu/drm/meson/meson_dw_hdmi.h | 3 +++
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 2a8756da569b..993f6d5d4b29 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -457,9 +457,11 @@ static enum drm_connector_status dw_hdmi_read_hpd(struct dw_hdmi *hdmi,
>   			     void *data)
>   {
>   	struct meson_dw_hdmi *dw_hdmi = (struct meson_dw_hdmi *)data;
> +	unsigned int stat;
>   
> -	return !!dw_hdmi->data->top_read(dw_hdmi, HDMITX_TOP_STAT0) ?
> -		connector_status_connected : connector_status_disconnected;
> +	stat = dw_hdmi->data->top_read(dw_hdmi, HDMITX_TOP_STAT0);
> +	return stat & HDMITX_TOP_STAT0_HPD ? connector_status_connected :
> +					     connector_status_disconnected;
>   }
>   
>   static void dw_hdmi_setup_hpd(struct dw_hdmi *hdmi,
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.h b/drivers/gpu/drm/meson/meson_dw_hdmi.h
> index 08e1c14e4ea0..cb4616daf667 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.h
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.h
> @@ -157,4 +157,7 @@
>    */
>   #define HDMITX_TOP_STAT0                        (0x00E)
>   
> +#define HDMITX_TOP_STAT0_HPD		BIT(0)
> +#define HDMITX_TOP_STAT0_RXSENSE	BIT(1)
> +
>   #endif /* __MESON_DW_HDMI_H */

Thanks, pretty sure the RXSENSE needs some setup in the PHY to work
and Amlogic never enabled it, but this version is clearly better.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
