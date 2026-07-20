Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE8DC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E64B10E8FC;
	Mon, 20 Jul 2026 12:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WU/sdQfh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1961A10E8FC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:41:01 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso8462815e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551259; x=1785156059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9RLppTCvwfs6eki4J5o77QyN9i8+Bne6Cqvn0sJNVGI=;
 b=WU/sdQfh/eAtPUvLElMBM1qvOe+d+/vmykf7eZoP7uDoaWDF4EZRMmhwcR37su/bYc
 WQdig3Ne0uinoR79plDrS/eApy0ojZs6ViOFFro2pqNtmm5C3xEYo0qs6FuMQo1LSwFP
 623a9dVXDS86WLLXEDLXJ+k28G1ptxGFHHm2oeKSQK1QizzIb4neVyOAUcDGPVd6WCya
 B0elP8J9E1EoIyn8lDykwjCWd6mJ1t6NnOrlAE0QbVduKUAHQLMWFCDj3T+gvRxxFucQ
 PpjAc6oB0K/I6jA73B/tjchqKn6ro5P+rs8AuB4VUhxogHSJBZo3Yqq9Qt4dc6cr2Xbf
 mO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551259; x=1785156059;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9RLppTCvwfs6eki4J5o77QyN9i8+Bne6Cqvn0sJNVGI=;
 b=iBiTT3GQNJmq0iaCyAqQT9+5aoF/kTuH1cIHtqpevml68qgOUdSS82dzOO9seCk81E
 9Umkg3A56sFLTkSFeW1jmFV/63aoquVPh4tO3WmO5MUxwFKS5Vj0E8K1yFZAIl2If6wY
 27GX1lM2tqIuFM0pC9FttrbyzvN3W5fdUEZulN/mIBYofjoiJgEClH5fkVCgmZxoSPRs
 I639zvPDp64f59Tipi5mqCo7I2JQE6YHW3DAfMFzlkW/UGhJ1KMyKVtaxn+HvGkbp+2e
 aj8fa7XOpghVBedP7A/VcH9X8izLLIdZ6HhKx9GYSTIr6ONJOSCQbt17yXElXYhiQu10
 nKgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RolMz6npKjxR9QE7LaP0fOJgMIr2Dx5W/BRTKNadns40OnLlFSRLeBfbafTQRjZqcEYXo6edNkk2AI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD6O7rS+B7Q1coowbnMXMQMCEKHcDdiCWSyVtL0SBRUEM6mfLx
 XoMZqUZDji0kXW6/Cu1cYk94wUCw91r9idlf+Gn8fCcCXhK1UrynvtOGxwOTqOP7dTE=
X-Gm-Gg: AfdE7cmei3vTgG2R88FbWT7vr3Ag4GE12UjxiNaHsTz7pqgZnBOZwwWghybAhFx7i4e
 U8GFP1vqcPuSnC4RiQx6zpZ5WGOh0t5guhQW/U9miVkdNL4chBJELmmJKNqIoG/u1NiAe+NKnc4
 p1cyGArh3cK7uelHbstM6WG6AM19YJ8Q2QUovarS3if64Tnn4PJU9M0J0aQDapyIGFG9AybjEyA
 67dxIF1aq68CLVvlPX3RBs5AZHPfq8EiSOgO1Q3ZXmkrJEz2nbKDU7esYjLLjmpaYIJfgvePHRU
 iBqalxxCeFGra/PWU6XFxnpsRAPmx6ZnT4gSMc/qDGJgVMXndw8zvjYNXHY+p3hDbPxrusXIWTV
 Rjjj/xWLqIp9GJqwHMVkD4K033Yn05BHKLTu+rNMdxXAbXffn/F75QKKUmCJ+vFS3Sa9Azpdw2j
 lbQVh7FWJ0dP+ueaZ0b1oLfHbqX6SpknT3VjBsX/iPvnPRqa7QHHoEfFEzcw==
X-Received: by 2002:a05:600c:b8a:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-4954a33dc55mr148751995e9.16.1784551259402; 
 Mon, 20 Jul 2026 05:40:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499a5847sm201100115e9.2.2026.07.20.05.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:40:59 -0700 (PDT)
Message-ID: <39c805d0-0435-4c27-980b-97a7c2850b87@linaro.org>
Date: Mon, 20 Jul 2026 14:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/5] drm: panel: jd9365da: Enable LPM mode
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 Jagan Teki <jagan@edgeble.ai>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
References: <20260708213500.1867092-1-marc-olivier.champagne@savoirfairelinux.com>
 <20260708213500.1867092-2-marc-olivier.champagne@savoirfairelinux.com>
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
In-Reply-To: <20260708213500.1867092-2-marc-olivier.champagne@savoirfairelinux.com>
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

On 7/8/26 23:34, Marc-Olivier Champagne wrote:
> The JD9365DA-H3 uses DSI LPM for command transmissions, make sure
> this is configured correctly in the DSI mode flags.
> 
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index f6b04de1182e..1ef0c937863a 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -2950,7 +2950,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   	else
>   		dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>   				  MIPI_DSI_MODE_VIDEO_BURST |
> -				  MIPI_DSI_MODE_NO_EOT_PACKET;
> +				  MIPI_DSI_MODE_NO_EOT_PACKET |
> +				  MIPI_DSI_MODE_LPM;
>   
>   	dsi->format = desc->format;
>   	dsi->lanes = desc->lanes;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
