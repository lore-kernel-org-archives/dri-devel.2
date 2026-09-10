Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FF0C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF9910E181;
	Thu, 10 Sep 2026 07:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l3M8BPu5";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA7010E181
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:23:52 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so855201f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 00:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789025031; x=1789629831; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wMpBVc24Sz11F3KFnL8+840MzJ31UofYHjzEvyoJR1s=;
 b=l3M8BPu50PJlOFRTd1WuP2uuA4m4lWpvQbGGBrDQx6exTsffzQ29MWSE8pf1uuU5ly
 nRpLeSo4UD0+pEaytGEqALGFCUUSJA69CD4ImXlF6aidpKR2GC3fKAxoqBo3PCqV91rj
 wHl7ZkBPaL9q4WxzEG5jTXZM3wAmAVW/t/LNXFnT3IrUi28JQxFxDvMCM0X/AoY57W4D
 4OTMsFM20q4VFiMHeIZ9zrFivFgC3EiL2TrUYiKIVw5Nk3/Mbw4dqXxutnywAiuCqpHY
 yfb3Yst4ouNIQ4w3QwcRxg0+572fOCIHA/hs1DWJ1EiQY/FdiilOp0dXqOKSPAl2dG3f
 RQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789025031; x=1789629831;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wMpBVc24Sz11F3KFnL8+840MzJ31UofYHjzEvyoJR1s=;
 b=Fi+5QHMJEJQTMW7SZxbPqKfOeRbIvAiDot5LQG3A1jLYQEI74TMr+KVhXhqnPolQu1
 R9SzH2oZY4W69I9LJThyZ9kdCWn+hVaA3YqGvbIjdYZ5oozExLc8EfPEdWobmhszXTWy
 CT85O+fFhJVv47Gm6mezTbs5ZyD8oGe5brgDIpDAJfDcG9jqDosiNF64HBdf041douLp
 AXWgdf19MvMALFcMsQs0L8UV0H0agdDuxjyHRtWfcPiMcKgPa61Z4C5/rhS+65Q9u49M
 Yc0klz7xutAPps9UYpWw5gWWX8B0JVWBpJutPfs+9DMsSkbDioNqnTlxl4SSmGdNmsBx
 sA+g==
X-Gm-Message-State: AFuF++kEHHAhnYUDjL5UAiZwZspxJ62zRRTscgL+md7Z1TTiceEbBqI8
 Byl16Kjeiwyys3GSWwuxOYzz2Z6KNHG+4zVnLMz8DzBn8F8dKqsAZ3bBwtCxjYzqei8=
X-Gm-Gg: AYBFou2chvnMqDVqtz+t9Rayu7J9C9p2zCJzQ8uPolNW18b5BfmdtPjUaD0wG9wtwEQ
 eMJLJVsYHNwKiAd/d4QugzRlBmHechUcGFFjNwBqNpAqA/V6vdJAbSSqyi4wweM3NImTaclqb+q
 nSXJJIKh0qBH/X9qpPCjhbs6Sn69yP3Bz4WOAE6+twVnyo9sks5dCrH0fkKL0bu/LiVjhh9S2+P
 Qq0iXQVKqRiYomrM/7qU1hIVQPCpX+BVx8dzOqQSMGPUEU2dlzoYGgovvTQ2YrcPrlgsxS+bj2A
 G6kHDtsP0v5jQoJaX9mzayxudy7pzjL31b4J5LiuhKZl5KTBc1TUbNB9YmfzV7p4aYJmHI7lgxD
 iw2oS+n1txj6oPSPxiM7BmH6oZLw0tKOvyyQUr3DFevVLx1J4Lg3/0e0bvEoqgeugimMsY11Srq
 NUlW9MUuzRSdsDQWO2izCRx5SdXLjQxbAb0vFF4oPr2l2vALLlbvaf7XLIFRHvnjGTvtisDn33W
 gruFUVsZXHeXS/uyIBYIU3dqXEf5Zt3i18Uzu6psQTFckJLkG8/42wMqG9Pj9dn
X-Received: by 2002:a05:6000:2dc5:b0:485:afd8:3e42 with SMTP id
 ffacd0b85a97d-485c23ec07cmr11470084f8f.22.1789025030483; 
 Thu, 10 Sep 2026 00:23:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3caf:d840:c911:29a9?
 ([2a01:e0a:106d:1080:3caf:d840:c911:29a9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bbb51sm51488978f8f.30.2026.09.10.00.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 00:23:41 -0700 (PDT)
Message-ID: <ca31e73c-09be-43fe-8904-8a813152c3ca@linaro.org>
Date: Thu, 10 Sep 2026 09:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/meson: fix device_node leak in
 meson_encoder_dsi_probe()
To: mileskrause5200@gmail.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Nicolas Belin <nbelin@baylibre.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260906-meson-dsi-of-node-leak-v1-1-9d183560279d@gmail.com>
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
In-Reply-To: <20260906-meson-dsi-of-node-leak-v1-1-9d183560279d@gmail.com>
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

On 9/6/26 21:43, Miles Krause via B4 Relay wrote:
> From: Miles Krause <mileskrause5200@gmail.com>
> 
> meson_encoder_dsi_probe() looks up the DSI transceiver's device node
> with of_graph_get_remote_node() and hands it to
> of_drm_find_and_get_bridge(), but never drops the reference that the
> lookup returned.
> 
> of_graph_get_remote_node() returns the node with its refcount
> incremented, and of_drm_find_and_get_bridge() takes its own reference
> on the bridge it finds, so 'remote' is leaked on every path once the
> lookup succeeds: on the -EPROBE_DEFER return taken when no bridge is
> found, and on a fully successful probe alike.
> 
> The two sibling encoders in this driver already handle this correctly.
> meson_encoder_cvbs_probe() calls of_node_put(remote) immediately after
> of_drm_find_and_get_bridge(), and meson_encoder_hdmi_probe() releases
> the node both on its error path and after of_find_device_by_node().
> 
> Release the reference in the same place meson_encoder_cvbs_probe()
> does, which covers both the error and the success path.
> 
> Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
> Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
> ---
>   drivers/gpu/drm/meson/meson_encoder_dsi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> index 3e422b612f74..3fe604496294 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -120,6 +120,7 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
>   	}
>   
>   	meson_encoder_dsi->bridge.next_bridge = of_drm_find_and_get_bridge(remote);
> +	of_node_put(remote);
>   	if (!meson_encoder_dsi->bridge.next_bridge)
>   		return dev_err_probe(priv->dev, -EPROBE_DEFER,
>   				     "Failed to find DSI transceiver bridge\n");
> 
> ---
> base-commit: 88405f0ad1d5c680afe3ea0ce9345fa9e1deaac8
> change-id: 20260906-meson-dsi-of-node-leak-744899da5712
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
