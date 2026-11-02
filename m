Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC7606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f4E1Szdx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6286810EDD7;
	Mon,  2 Nov 2026 13:03:28 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5CE10EDD7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:03:22 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so31540365e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624601; x=1794229401; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=89Y/HCm6tRbXlpb938dXfX1sf1dCEpdg6pFysdRtIzY=;
 b=f4E1SzdxcPPkX6U4VwixwuYSCMrAEKN2F9D/LB8C6VzvL4zvaFFsZQuz2Voiy2zywi
 n4UB9CtKXMoswuWuJfVsfEf8RkgLrEiObAntZPor+f+ny95JRoEENtD6WUYyYxkjw8Tt
 9IQ1/8tcIphoa9IYeg3u3qre9fquTkbEgAHKchkUB0ZRlRb2vwo32QA304DFm2pO/ePP
 GvEFCaMGhm4I9tUdG61ZWtDjPd8y6rFOnVHrqwnJBgG/EnkohdVbkrpm2/AUh06MVzIh
 FZKz9eEV1gJijpF+EOQJ3BMYTXYPxfPJ6QLzmsUjL6vtWS4NIk4yGoo46iQ13yhFLuht
 xLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624601; x=1794229401;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=89Y/HCm6tRbXlpb938dXfX1sf1dCEpdg6pFysdRtIzY=;
 b=qvtCZd9C54eqJiO7V58AkFfhzTXTSbFSM8SaxpAFN5oMFfMqfzGB9MbrOz6jKIvhHH
 80rz0IFzbvbDCxY2PeoSJWia1lXhNNTdP8zzm/bQt5gjgdH4Rc9u1aJhYvN+UmKoF1sV
 UfFJoVNYbQIYiPW06eEmcJZDCEM8/eKOp91Lba3LsnMLhBjGNtkiRcE75Vr9q5hcEBvy
 cXDudmXUgU4U+i2piae3IvBV9RmJw7irYlh0uU/Fo6mxJNvDknCffjovdliyoEZWWNzg
 7QmkAntZTNAKjk0N2gzsL2GHd06zyF6/xplwsZVVfJi6iKl6QL61sOVjZnSTGYpZ2ZCn
 +72Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuTjGB5W7r45dCap9G3ZHEbwoNS6a5MtShf7/TeUQ0ZDiCa2/3x+XtGa0i7Fxg65/Zh/pJKHs8ndY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUGWxouiNFytZvh87aAYZiBNCccWHiihTcnE8U9uX/D/vnVDEV
 y1PNd6FVaFOQgpKqjkowpkX1ozPJE2/OamWoehT+KGTbyTkhLBY+6NLA1ro+2BS/F7A=
X-Gm-Gg: AYBFou1CdxTrF7RzOfyVpr2DiyE42NLF5oLV3hZIxyoW3i0aZOJF+8wVtPU/RBjlJbl
 DBLuF2io5hmwrwA89aasB5hpR9X3JRqTS5KcxnZDwaScHWMA14sBg0hxRo3mD7PC5gZw948hjqV
 3RuhkgJl6r8dYkQk5J2+CDyYJY2GXtPzbQNbqE8U6m6uU9xk6mv855wjXA2ng+HX/g5z6fpcAlf
 F/lddAmvmC1c5lUfutuH+lxxRdNXAeLfoHCbrqmdMa8ioGrC3LitCsO1hjKt9N6rrA43RLNwhC2
 LTwqgMcqDVfhsU3E3sP1LezBTYwpFz7GvPCNhkS7ILH8WYtSvPOPvOGo+9plkEjLXgwb1x7QooH
 GhKZjWJS7G12aOCiu5QQQII+6CBdU4TPlBYABXv13T8dHET9i4bmAVpZUTkQbEtMFR4+PPuJ5u5
 /sQYNy4lkhzMEkM4q/xghqojQngJim3Xk6PmnXd9tLy+VUbagmfR33G/70i0Mmi/79wYogs9yYI
 3gFKp1iDrsxDcwh4JpIkqUuqJqwPU106tJ0Dv6rLAUtT7kVjVjq0RcsEYPiDeDHFZlJTz2cfJzQ
 MDA7YHoJrrehJ3Iwk6zT8+ZCk+bI8TuQzDQemSJwPsbYY+NshJC1pkU8PATjq9wX9MIN8vzpMIU
 yv49Nap4=
X-Received: by 2002:a05:600c:c48e:b0:4a1:f7f4:7cf1 with SMTP id
 5b1f17b1804b1-4ac16bc47f8mr231647195e9.11.1793624600748; 
 Mon, 02 Nov 2026 05:03:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm330988375e9.2.2026.11.02.05.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:03:20 -0800 (PST)
Message-ID: <a7c2688e-3f7d-4ea3-91ec-9f7fbbb05d60@linaro.org>
Date: Mon, 2 Nov 2026 14:03:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] drm/panel: visionox-r66451: Send the brightness value
 MSB first
To: Vladimir Zapolskiy <vz@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20261101212458.2431191-1-vz@kernel.org>
 <20261101212458.2431191-2-vz@kernel.org>
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
In-Reply-To: <20261101212458.2431191-2-vz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 22:24, Vladimir Zapolskiy wrote:
> The panel expects to get two bytes of the DCS Set Display Brightness
> command with the most significant byte first, and it uses the lower
> 12 bits of the value, use mipi_dsi_dcs_set_display_brightness_large()
> to correct the programmed brightness values.
> 
> Tested on the SM8350-HDK display card, the display brightness increases
> gradually with:
> 
>    for v in $(seq 16 16 4095); do sleep 0.1; \
>      echo $v > /sys/class/backlight/ae94000.dsi.0/brightness; \
>    done
> 
> while without the change the display is dark during all writes.
> 
> Fixes: a6dfab2738fc ("drm/panel: Add driver for Visionox r66451 panel")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-r66451.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
> index 1efb139bb711..4f28bd3b6080 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
> @@ -227,7 +227,7 @@ static int visionox_r66451_bl_update_status(struct backlight_device *bl)
>   	struct mipi_dsi_device *dsi = bl_get_data(bl);
>   	u16 brightness = backlight_get_brightness(bl);
>   
> -	return mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>   }
>   
>   static const struct backlight_ops visionox_r66451_bl_ops = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
