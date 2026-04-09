Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726AAEA3C59
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BED10E7ED;
	Thu,  9 Apr 2026 12:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OJD+mbnP";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CF710E7ED
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 12:59:00 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48374014a77so11643265e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775739539; x=1776344339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=x4+d359KX46hXwxtaE9R0Hy4plQuOMKkNrAfPPDGlPA=;
 b=OJD+mbnPjkK1VabvJABl/CpLnHnZrGNdoWXeXl2juheGMh6QBTgMclTNpkEdmqDWzO
 4C1t+8kLEfry4LUTnGtE7BydNttwGbuQJj6iPIrBFq7NwI7XC5I1bIWE85A6SFfwgSOP
 1vUHPHVUGch3GCjOfWJDgl88brnWT6Hjup4ZkuAVR6tTG4lJ6GI9yGJpeXqJrgK62Prj
 czvvCnL4w6tyNcrjY2q+Z1oh9IZhWuZR6fV3lu6CLcy8WAlCdIUkEez8pcpHf92B/2Xy
 +ueXv/Jn6L/E0gt5Q6zRZhjeWUc3TuNFJThrRGUg2wsWapVShpW9ZIWCwmtl/U3Z6NzR
 ePIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775739539; x=1776344339;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4+d359KX46hXwxtaE9R0Hy4plQuOMKkNrAfPPDGlPA=;
 b=DlIXo5aMmHag1Fo/81yF79gokTbMZ6+b5Qfx5VKfIs3LhbcJAq9BAVwgL6Fkhxp4Sv
 immdzGuQKmC/sNfmzeNADAomMUaeLOP4ulq7UzERKHI4/VYJycSTdXoryNvlyw12t2Wk
 dJQVTpioYj5XvLgcF5v+w02SRAyI9XV+P3s4o3dmDw3yP95HSVOxOF8Wpd7WiaGVpflP
 CduezZL3VpIVq5uDRtL2Sm/lz7K2h5XhSGZyzUl0nYXjvnAiBR0mdNu3n9FUsiJgc6gP
 4AHK6AgjUdTt/7UsNuvKxDuMOPFpeGmBLzAKRZW0iUCjOXw78a5VPYf3pwcGTjORboE5
 fV7Q==
X-Gm-Message-State: AOJu0YyhbMsktPbb+xb0EAeDEZu3UQ5bfrqjpNkUNQgfw3vWp67cWwAl
 a9nNcOfR5KK4GpxOaEEzDMjwWRY+d0MbkEo5wUK8nrV5jmg+9xVACQ9MVzStdQ4nvs4=
X-Gm-Gg: AeBDieuTKyRj8GZCMzRL3ZBqJn22vwfNvMfv/PDTHHxjtPNYZCUYX1PapnXym/YZdjn
 0BBjFRHmLi/KgvFlWsrY1eu0Fn/Xn3NB120loZxsWPK4UeIzVOg9SvqNWgUDmk0hpawKE/4AzrA
 TCvU82M8uR7xIpSVZuFHVbsnAseh+v3kf99TC/wZvnGKqP4bAfLqhadtxEPaM6LihgvSiBkpiVY
 e2eeijBaqPLz/ZUpfnv6/7oH30SnbHgllsYXWtRuzGFjqbVpdlMPeB6r3X0VrGjOEYzk1Q/fwAr
 Cgc9CasDldyEbMJz0mCIG6IlmKZcMyYq3eZHDxgNtboYr7B3TNXeoGP92q6npyZGcn9WCXfzEwT
 TLgNugPG7AvpHet7TNqScmNOhM8ix8J226PtNYU68nBWu+POhWnnh4hxRi6mzp2C4vVAqxzMch1
 PYObZ9eWshZmKJN3rw7pBBzllmKzVG0CAb5jWaAytLXOKhXojggalO7suKzoT7ku+adQZwdjRUQ
 TtC
X-Received: by 2002:a05:600c:6305:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-4889978da75mr343672015e9.17.1775739538882; 
 Thu, 09 Apr 2026 05:58:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:47c:bef1:62cf:54fb?
 ([2a01:e0a:106d:1080:47c:bef1:62cf:54fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a720dsm68106981f8f.4.2026.04.09.05.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 05:58:58 -0700 (PDT)
Message-ID: <dfb14fb7-7013-4946-b151-a9db4478c0cd@linaro.org>
Date: Thu, 9 Apr 2026 14:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] drm/panel: simple: add Waveshare LCD panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
 <20260330-ws-lcd-v1-4-309834a435c0@oss.qualcomm.com>
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
In-Reply-To: <20260330-ws-lcd-v1-4-309834a435c0@oss.qualcomm.com>
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

On 3/30/26 15:25, Dmitry Baryshkov wrote:
> Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
> being attached to the DSI2DPI or DSI2LVDS bridge. The commit
> 46be11b678e0 ("drm/panel: simple: Add Waveshare 13.3" panel support")
> added definitions for one of those panels, describe the rest of them.
> 
> Note, since the panels are hidden behind the bridges which are not being
> programmed by the kernel, I could not confirm the pixel format for the
> panels.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 381 +++++++++++++++++++++++++++++++++++
>   1 file changed, 381 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 236bd56208cc..b2708a1fe464 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5061,6 +5061,342 @@ static const struct panel_desc vl050_8048nt_c01 = {
>   	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
>   };
>   
> +static const struct drm_display_mode waveshare_28_lcd_mode = {
> +	.clock = 50000,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 150,
> +	.hsync_end = 480 + 150 + 50,
> +	.htotal = 480 + 150 + 50 + 150,
> +	.vdisplay = 640,
> +	.vsync_start = 640 + 150,
> +	.vsync_end = 640 + 150 + 50,
> +	.vtotal = 640 + 150 + 50 + 150,
> +	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
> +};
> +
> +static const struct panel_desc waveshare_28_lcd_panel = {
> +	.modes = &waveshare_28_lcd_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 44,
> +		.height = 58,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
> +};
> +
> +static const struct drm_display_mode waveshare_34_lcd_c_mode = {
> +	.clock = 50000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 32,
> +	.hsync_end = 800 + 32 + 6,
> +	.htotal = 800 + 32 + 6 + 120,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 8,
> +	.vsync_end = 800 + 8 + 4,
> +	.vtotal = 800 + 8 + 4 + 16,
> +};
> +
> +static const struct panel_desc waveshare_34_lcd_c_panel = {
> +	.modes = &waveshare_34_lcd_c_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 88,
> +		.height = 88,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_40_lcd_mode = {
> +	.clock = 50000,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 150,
> +	.hsync_end = 480 + 150 + 100,
> +	.htotal = 480 + 150 + 100 + 150,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 20,
> +	.vsync_end = 800 + 20 + 100,
> +	.vtotal = 800 + 20 + 100 + 20,
> +	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
> +};
> +
> +static const struct panel_desc waveshare_40_lcd_panel = {
> +	.modes = &waveshare_40_lcd_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 52,
> +		.height = 87,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
> +};
> +
> +static const struct drm_display_mode waveshare_40_lcd_c_mode = {
> +	.clock = 50000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 32,
> +	.hsync_end = 720 + 32 + 200,
> +	.htotal = 720 + 32 + 200 + 120,
> +	.vdisplay = 720,
> +	.vsync_start = 720 + 8,
> +	.vsync_end = 720 + 8 + 4,
> +	.vtotal = 720 + 8 + 4 + 16,
> +};
> +
> +static const struct panel_desc waveshare_40_lcd_c_panel = {
> +	.modes = &waveshare_40_lcd_c_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 102,
> +		.height = 102,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_50_lcd_c_mode = {
> +	.clock = 50000,
> +	.hdisplay = 1024,
> +	.hsync_start = 1024 + 100,
> +	.hsync_end = 1024 + 100 + 100,
> +	.htotal = 1024 + 100 + 100 + 100,
> +	.vdisplay = 600,
> +	.vsync_start = 600 + 10,
> +	.vsync_end = 600 + 10 + 10,
> +	.vtotal = 600 + 10 + 10 + 10,
> +	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
> +};
> +
> +static const struct panel_desc waveshare_50_lcd_c_panel = {
> +	.modes = &waveshare_50_lcd_c_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 109,
> +		.height = 66,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
> +};
> +
> +static const struct drm_display_mode waveshare_50_lcd_d_mode = {
> +	.clock = 83333,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 100,
> +	.hsync_end = 720 + 100 + 80,
> +	.htotal = 720 + 100 + 80 + 100,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 20,
> +	.vsync_end = 1280 + 20 + 20,
> +	.vtotal = 1280 + 20 + 20 + 20,
> +};
> +
> +static const struct panel_desc waveshare_50_lcd_d_panel = {
> +	.modes = &waveshare_50_lcd_d_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 62,
> +		.height = 110,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_625_lcd_mode = {
> +	.clock = 83333,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 50,
> +	.hsync_end = 720 + 50 + 50,
> +	.htotal = 720 + 50 + 50 + 50,
> +	.vdisplay = 1560,
> +	.vsync_start = 1560 + 20,
> +	.vsync_end = 1560 + 20 + 20,
> +	.vtotal = 1560 + 20 + 20 + 20,
> +};
> +
> +static const struct panel_desc waveshare_625_lcd_panel = {
> +	.modes = &waveshare_625_lcd_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 66,
> +		.height = 144,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct panel_desc waveshare_70_lcd_c_panel = {
> +	.modes = &waveshare_50_lcd_c_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 155,
> +		.height = 87,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
> +};
> +
> +static const struct drm_display_mode waveshare_80_lcd_c_mode;
> +static const struct panel_desc waveshare_70_lcd_e_panel = {
> +	.modes = &waveshare_80_lcd_c_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 152,
> +		.height = 95,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_70_lcd_h_mode = {
> +	.clock = 83333,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 64,
> +	.hsync_end = 1280 + 64 + 64,
> +	.htotal = 1280 + 64 + 64 + 64,
> +	.vdisplay = 720,
> +	.vsync_start = 720 + 64,
> +	.vsync_end = 720 + 64 + 64,
> +	.vtotal = 720 + 64 + 64 + 64,
> +};
> +
> +static const struct panel_desc waveshare_70_lcd_h_panel = {
> +	.modes = &waveshare_70_lcd_h_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 155,
> +		.height = 88,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_79_lcd_mode = {
> +	.clock = 50000,
> +	.hdisplay = 400,
> +	.hsync_start = 400 + 40,
> +	.hsync_end = 400 + 40 + 30,
> +	.htotal = 400 + 40 + 30 + 40,
> +	.vdisplay = 1280,
> +	.vsync_start = 1280 + 20,
> +	.vsync_end = 1280 + 20 + 10,
> +	.vtotal = 1280 + 20 + 10 + 20,
> +};
> +
> +static const struct panel_desc waveshare_79_lcd_panel = {
> +	.modes = &waveshare_79_lcd_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 60,
> +		.height = 191,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_80_lcd_c_mode = {
> +	.clock = 83333,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 156,
> +	.hsync_end = 1280 + 156 + 20,
> +	.htotal = 1280 + 156 + 20 + 40,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 40,
> +	.vsync_end = 800 + 40 + 48,
> +	.vtotal = 800 + 40 + 48 + 40,
> +};
> +
> +static const struct panel_desc waveshare_80_lcd_c_panel = {
> +	.modes = &waveshare_80_lcd_c_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 173,
> +		.height = 108,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_88_lcd_mode = {
> +	.clock = 83333,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 50,
> +	.hsync_end = 480 + 50 + 50,
> +	.htotal = 480 + 50 + 50 + 50,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 20,
> +	.vsync_end = 1920 + 20 + 20,
> +	.vtotal = 1920 + 20 + 20 + 20,
> +};
> +
> +static const struct panel_desc waveshare_88_lcd_panel = {
> +	.modes = &waveshare_88_lcd_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 56,
> +		.height = 220,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct panel_desc waveshare_101_lcd_c_panel = {
> +	.modes = &waveshare_80_lcd_c_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 217,
> +		.height = 136,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
> +static const struct drm_display_mode waveshare_119_lcd_mode = {
> +	.clock = 50000,
> +	.hdisplay = 320,
> +	.hsync_start = 320 + 60,
> +	.hsync_end = 320 + 60 + 60,
> +	.htotal = 320 + 60 + 60 + 60,
> +	.vdisplay = 1480,
> +	.vsync_start = 1480 + 60,
> +	.vsync_end = 1480 + 60 + 60,
> +	.vtotal = 1480 + 60 + 60 + 60,
> +};
> +
> +static const struct panel_desc waveshare_119_lcd_panel = {
> +	.modes = &waveshare_119_lcd_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 58,
> +		.height = 268,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct drm_display_mode waveshare_133inch_mode = {
>   	.clock = 148500,
>   	.hdisplay = 1920,
> @@ -5697,6 +6033,51 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "vxt,vl050-8048nt-c01",
>   		.data = &vl050_8048nt_c01,
> +	}, {
> +		.compatible = "waveshare,2.8inch-panel",
> +		.data = &waveshare_28_lcd_panel
> +	}, {
> +		.compatible = "waveshare,3.4inch-c-panel",
> +		.data = &waveshare_34_lcd_c_panel
> +	}, {
> +		.compatible = "waveshare,4.0inch-panel",
> +		.data = &waveshare_40_lcd_panel
> +	}, {
> +		.compatible = "waveshare,4.0inch-c-panel",
> +		.data = &waveshare_40_lcd_c_panel
> +	}, {
> +		.compatible = "waveshare,5.0inch-c-panel",
> +		.data = &waveshare_50_lcd_c_panel
> +	}, {
> +		.compatible = "waveshare,5.0inch-d-panel",
> +		.data = &waveshare_50_lcd_d_panel
> +	}, {
> +		.compatible = "waveshare,6.25inch-panel",
> +		.data = &waveshare_625_lcd_panel
> +	}, {
> +		.compatible = "waveshare,7.0inch-c-panel",
> +		.data = &waveshare_70_lcd_c_panel
> +	}, {
> +		.compatible = "waveshare,7.0inch-e-panel",
> +		.data = &waveshare_70_lcd_e_panel
> +	}, {
> +		.compatible = "waveshare,7.0inch-h-panel",
> +		.data = &waveshare_70_lcd_h_panel
> +	}, {
> +		.compatible = "waveshare,7.9inch-panel",
> +		.data = &waveshare_79_lcd_panel
> +	}, {
> +		.compatible = "waveshare,8.0inch-c-panel",
> +		.data = &waveshare_80_lcd_c_panel
> +	}, {
> +		.compatible = "waveshare,8.8inch-panel",
> +		.data = &waveshare_88_lcd_panel
> +	}, {
> +		.compatible = "waveshare,10.1inch-c-panel",
> +		.data = &waveshare_101_lcd_c_panel
> +	}, {
> +		.compatible = "waveshare,11.9inch-panel",
> +		.data = &waveshare_119_lcd_panel
>   	}, {
>   		.compatible = "waveshare,13.3inch-panel",
>   		.data = &waveshare_133inch,
> 

LGTM, panel-simple for panels that autoconfigures themselves from a flash

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
