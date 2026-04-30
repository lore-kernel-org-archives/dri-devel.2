Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B61FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5301B10E132;
	Thu, 30 Apr 2026 09:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bnhQw9bX";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E5910E132
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:44:53 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso187310f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777542292; x=1778147092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=r0PGE3BNlb0IaXgkxdiLNH6Iyh0Z4cLUYLiEdgTxCoE=;
 b=bnhQw9bXSRtAq7kHeF7ogO1ofW2pD+LFi1+KJ5EDW2yABAYkCbOo6lGR8W5E9efb+2
 jhhV2eeN5FKDcQfEqrSy24yNEF/C5euKa8cEIHYsAvm4gm+DTOoGjCOAk1U7qvXkpobw
 KisEMWAh24/qsqBqOMfEYFsFvUbDZNdOugJJg6ZUges6yfhmEMBODlnwCkULg/ga2HBJ
 /cqEb1tfE2zo7r33qRJCSHhY8w8rJ1wluAknQBMaTCZvX+h/SKuQywvWMMjC8W2ntiSc
 uBJG9mZxi+wPZwCw4/AJPgdBmfjkroQBvVkVRQ7MoBDSCmPhGf6qb/qCCdw/jU3XAHgi
 ChRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542292; x=1778147092;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0PGE3BNlb0IaXgkxdiLNH6Iyh0Z4cLUYLiEdgTxCoE=;
 b=LpWvFeliUDJ7D9qTVoMdN4iFEbupCJYew3UxE5i+FIWt1L+/L6apjIu5Raa7a62JTm
 ZNoLUGdcVrX45YP8yLBCwpuCqRZiLUUkioq9bMTEM/ZYx7wT3sMqIrtB9a8gqfqD6ZUt
 A9RSYl6xiLBmuXQ3TqJXxQ2V8tPmxx5Z3YYcBR1xL3/Q6R/xBOcjJCbGDTPNq/sJtjN6
 iIuzvvzH3L3F85kzKbqZSMJdyjKJjyAafPuUTBoja/KExdMFcfyXSllilVGMKlA1RY7i
 d4sSxOJdtbT1xHndJNh1RQlrNN6SQF+cJeKF3nMf9c9nZ4YQxYNSBzFNo1cnOSe4C/+z
 X8yQ==
X-Gm-Message-State: AOJu0YxGRorPMpystZNbxrb7jo4NCTLfpZT6lI+8wmZe2olQiqbNCSLu
 p89Jd+qP+9L6w+Vefq8nq7FILDcT/yEom440fKiHipDsOvMXXLodUYK3RqckdwSfH1M=
X-Gm-Gg: AeBDieudsP7KZgDZ2hqx6Fk+BMkzkjMuf37rJkgxZAJTbYAXNMghOupgvSey0nLVPrr
 jKeF9aYMLP8CHQRbLe6ETTp7zWGiMwglLthwBUHcN8poIiWUkjrOeDR/iA6u19esDCRuZIxT1fV
 PX7jFE6nJX24NoaO+lcfFsjO5QX0cdoi9m3cIqIyWfD9b90hxxgOm25dPx8uUnoGT+Qsq7fCfK6
 d7deXTX0YJQhUBA2SfQhCOrS4qVaRm0+5w/zcLejiCphiUoPGVywVLgLmz8ozTh0DLhqUnffEIB
 j2aWojNCiIeG7hadVA4PtFTh5kZB90n5QXDzRp4OFSlkuOgER+kJiEZcbkcjMNs71+lnhSRcUBa
 KaRFfxXJDH/Idio/+/tYfuB1oDU3UMUr/NNQPa1ddirDki6v2RRatHu8qfc+5WLkLvC3JofTTaQ
 ipHeKU5vUNzjY0bAxaY7Fzq5hrnWIUmfm1PA/c2wZX5qPc8uSGWox5Gb8v4yMGa0kIQS25ejUDm
 fkWX+n7pUgr+CbewA==
X-Received: by 2002:a05:6000:178b:b0:441:36b7:7262 with SMTP id
 ffacd0b85a97d-4493ded56e1mr3441957f8f.13.1777542291653; 
 Thu, 30 Apr 2026 02:44:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae?
 ([2a01:e0a:106d:1080:6dcc:3980:fe87:c6ae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d482d3sm11536834f8f.1.2026.04.30.02.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 02:44:51 -0700 (PDT)
Message-ID: <5d0c4fc6-5d50-45e8-b323-23015fa52021@linaro.org>
Date: Thu, 30 Apr 2026 11:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add Team Source Display
 TST070WSBE-196C panel
To: William Bright <william.bright@imd-tec.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
 <20260428-imdt-dsi-display-v2-2-cf7294b5d7d6@imd-tec.com>
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
In-Reply-To: <20260428-imdt-dsi-display-v2-2-cf7294b5d7d6@imd-tec.com>
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

On 4/28/26 17:17, William Bright wrote:
> Add a dedicated panel driver for the Team Source Display
> TST070WSBE-196C, a 7" 1024x600 MIPI-DSI TFT LCD panel
> using an EK79007AD controller.
> 
> The DSI timings were calculated using
> "linux-mdss-dsi-panel-driver-generator" [1], reading the downstream
> file "dsi-panel-imdt-tst070wsbe165c-video.dtsi" [2].
> 
> [1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> [2] https://raw.githubusercontent.com/imd-tec/meta-imdt-qcom/refs/heads/kirkstone/recipes-display/displaydevicetree/displaydevicetree/0001-Initial-bringup-of-IMDT-Display-3.patch
> 
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 236bd56208cc..0010bb3db484 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5936,6 +5936,39 @@ static const struct panel_desc_dsi osd101t2045_53ts = {
>   	.lanes = 4,
>   };
>   
> +static const struct drm_display_mode tsd_tst070wsbe_196c_mode = {
> +	.clock = 52477,
> +	.hdisplay = 1024,
> +	.hsync_start = 1024 + 160,
> +	.hsync_end = 1024 + 160 + 12,
> +	.htotal = 1024 + 160 + 160 + 12,
> +	.vdisplay = 600,
> +	.vsync_start = 600 + 12,
> +	.vsync_end = 600 + 12 + 10,
> +	.vtotal = 600 + 12 + 10 + 23,
> +};
> +
> +static const struct panel_desc_dsi tsd_tst070wsbe_196c = {
> +	.desc = {
> +		.modes = &tsd_tst070wsbe_196c_mode,
> +		.num_modes = 1,
> +		.bpc = 8,
> +		.size = {
> +			.width = 190,
> +			.height = 121,
> +		},
> +		.delay = {
> +			.prepare = 20,
> +		},
> +		.connector_type = DRM_MODE_CONNECTOR_DSI,
> +	},
> +	.flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM |
> +		 MIPI_DSI_MODE_VIDEO_BURST |
> +		 MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +};
> +
>   static const struct of_device_id dsi_of_match[] = {
>   	{
>   		.compatible = "auo,b080uan01",
> @@ -5955,6 +5988,9 @@ static const struct of_device_id dsi_of_match[] = {
>   	}, {
>   		.compatible = "osddisplays,osd101t2045-53ts",
>   		.data = &osd101t2045_53ts
> +	}, {
> +		.compatible = "team-source-display,tst070wsbe-196c",
> +		.data = &tsd_tst070wsbe_196c
>   	}, {
>   		/* sentinel */
>   	}
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
