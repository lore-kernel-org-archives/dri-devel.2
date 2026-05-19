Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A795CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE45110EAD4;
	Tue, 19 May 2026 07:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z1h2Gu2m";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC42D10EAD4
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:27:48 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so37761585e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779175667; x=1779780467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3zpUdooh7j5y1dGwvoNb/vpfm79eAZcPY2dZ8iHzeV8=;
 b=Z1h2Gu2mGpgaSsDw8QKl74idrQcwRjIeoy4ahHoR+K2UNkGERDC53pPAHdf9TKngwe
 +AwMsI9vgYuCVcleA7C/yrHwIj4moT0mORMqHaY1xVPNoo++f+Ik8iIQ9dl4N9EtyGKO
 pp/CF2CvyePHruUHZc3vPWhbb0Z+4/T8jJ8FjgYc/uIbBNnB/kgm/mqQMYsCMLK/cIYn
 cHk1HDHVcmgmTyAwl52mRCxlPVwusshjGoDzjoyRnwSmf9k2UQgDYnix7+CPesEfu/bv
 niz/+LSqAfXjuemRi7a7UAb1J1IgPLqT2/hiNpU4TDAvZE42TVHqcdSsttB5KFzjXdrr
 d/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175667; x=1779780467;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zpUdooh7j5y1dGwvoNb/vpfm79eAZcPY2dZ8iHzeV8=;
 b=Qx0vAyUnOLLyopCWjLJ0/dJvp/b/8RqC2G3wdvZwZzcA15A8LALQaAlhYdbtpJkbEW
 PWw0zPX39GxjyFRMt/0KUcGNIDCmSjvPUQpK00rAv7Sxa5S74wWGouOWw1D9EIJx7+jh
 8O7ObJAc6PF0OK77jj32JFQY7nWM6n10y5f0JybphYPm+m8PPGS6qHqXk+jTTlZord+V
 dxNfEGmYaoOMfk+QtYHAXq8urivrmNGPkgK9fKaWUpRL1IAmoexfB+jL1CYJT0DOWs10
 RQw1+MHxeqojIYCCFq5LyQrbwD8925gEtwnYXqOhJoU+bmoHZIqqYdrtNxnc5QFA4U/7
 yY7g==
X-Gm-Message-State: AOJu0YxQJQPrnzUF/zdKN5TfzUXLTK0qx5yoBBoUahywdati3gmxmfT1
 lPLbRNVzja2FlGGNgc98A2QuyokHGhtbRGDFjCTCwilpOk0qbR5mJni0YzpzL83Tkkw=
X-Gm-Gg: Acq92OEELkgPlh0i4LOEWFgPfXGZOa1m59lZZonfL/hcEL7FtcTYYmqQlXqDKjSs9YK
 toY5OIgJ6VAw4nYIv9cr6LCpZpC2c2sMFXr5k2ax3gxWO79EGTQlVzo2bWXn6yqueusNns8qLrD
 C18wI8aThk+HWz8j7TVBc3jK7jgvxq3+D9L0/9oyyprPRMsNpFDdLTEUqv7DqoLLzrd4qBtdGrE
 bXHKiKRu7UOzEReR8CzpZYF+Uf+Hy6pohvyYKmfyVKm+rt04RIX04MbHG/EPlL0ku+UcAmz4INK
 LQNWLg7gX7l29XYW/M8GFsw/CKpvXzTrKeHyOl9OnQcgMe/jjVuov7N4CCAwhFt3fOw3XJEV4oR
 BZxlCNl+cWQrgKJsI0Y2U6dUp1cxJ0FuswFnI3EYdelD96562vXOaYyQj8iKZPY1ZXHCL45t6V1
 IpYH5Uq8BWgU/QS5KVZppVUR8FpQ1sx1MK+hGvZbpD7i5wYiuB1GTUZIm1H6rK0UTgUdnM0xptz
 AnY
X-Received: by 2002:a05:600c:a406:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48fe63297b9mr233398525e9.25.1779175663120; 
 Tue, 19 May 2026 00:27:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm299805555e9.4.2026.05.19.00.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:27:42 -0700 (PDT)
Message-ID: <21609bd9-7a94-41cc-bbe2-2478278b0497@linaro.org>
Date: Tue, 19 May 2026 09:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/13] drm/meson: encoder_hdmi: Use CEC phys addr from
 display_info
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
 <20260518194744.2483580-6-jonas@kwiboo.se>
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
In-Reply-To: <20260518194744.2483580-6-jonas@kwiboo.se>
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
> The dw-hdmi bridge detect() func now updates EDID for the connector.
> Something that ensures that display_info.source_physical_address has an
> updated CEC phys addr when the hpd_notify() func is called.
> 
> Change to use display_info source_physical_address directly instead of
> re-reading EDID to set the CEC phys addr at HPD interrupt.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 26 ++++------------------
>   1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 55c0601df3c6..1b9a1d9ed3d3 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -330,28 +330,10 @@ static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
>   	if (!encoder_hdmi->cec_notifier)
>   		return;
>   
> -	if (status == connector_status_connected) {
> -		const struct drm_edid *drm_edid;
> -		const struct edid *edid;
> -
> -		drm_edid = drm_bridge_edid_read(encoder_hdmi->bridge.next_bridge,
> -						encoder_hdmi->connector);
> -		if (!drm_edid)
> -			return;
> -
> -		/*
> -		 * FIXME: The CEC physical address should be set using
> -		 * cec_notifier_set_phys_addr(encoder_hdmi->cec_notifier,
> -		 * connector->display_info.source_physical_address) from a path
> -		 * that has read the EDID and called
> -		 * drm_edid_connector_update().
> -		 */
> -		edid = drm_edid_raw(drm_edid);
> -
> -		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
> -
> -		drm_edid_free(drm_edid);
> -	} else
> +	if (status == connector_status_connected)
> +		cec_notifier_set_phys_addr(encoder_hdmi->cec_notifier,
> +					   connector->display_info.source_physical_address);
> +	else
>   		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
>   }
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
