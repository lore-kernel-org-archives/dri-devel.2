Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2345606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FUMrmeAt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1205110E0A8;
	Mon,  2 Nov 2026 13:43:20 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42E410E0A8
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:43:12 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so23130925e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626991; x=1794231791; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vZtW7lCUy+nRe8aQGLzw6+UgY7GQ7HugFqgCTw6Ar5M=;
 b=FUMrmeAthZT8ncTX9byQfo61GhPVpWN2YQA+DywBF55kIlREDst3nqzahr1XSViLND
 UMg8LX91wIhnzr3vTYPMYpSdXqr3FuVAKKHZY8mXJiRdLBk+Y/27NxrVdm6yFvx+In6n
 p4PQehRTR3dfkUMrOfdHrhu/wWTG+9l1Lw/cpGVczyJAQ3ulhS7svgRewMrXVYYi9ksO
 40ioOtQ4gs1kYV1gy7Jr4wvZ4F3d0PezVuiO0e69VUDVR7gqoaJmOjBCYetArb3gpriq
 UaOKX4WmiG04d52dBurVlpzOrkUttLci6+DZ/Aimzh05NHWzT31QTXLIpIDYmM/V0bW/
 b0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626991; x=1794231791;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vZtW7lCUy+nRe8aQGLzw6+UgY7GQ7HugFqgCTw6Ar5M=;
 b=ojzgMqxyGPGg1srzm4jRCJ2xlgq+3+PFnNX0D4qFb2DtyZhdeOvzEMw/efhcDK8qa+
 kHu20UBXGQxUV/T1MaAFjsRhSIh3X9hqs6ReRZ054P/smm1wKxthDjY5kT91jsjkwkEG
 V2YAQ7txE1vVaNvfs4sydOJv1EGMipCxCxtmQJ2EehR6E4epiWzfvG3Nlu0FhOsnrO16
 eSSCwkVlsvzlDOunL5dQPa+frXqSaUkNTM2RNs1GxdvZpH41MQeLkm18ce7hWHrCrh6e
 mUh17BAUAz1b4Q48/GefssAdFoGqT5BaQN3I5WLAsBMUs8btBWOOpcLu9MSIw8Fb82Rg
 s/Cg==
X-Gm-Message-State: AFq9FYLDSFRqgku61jJ2EA+X04d/PJorWZxxmpPWqGIRxzTYNm1iS+MZ
 ib/FCcjInSGdeo9UoYqvzpvZ0FJqRoe63rDSTuuFT6yO3NXHccg8NuHIbzs0f/tEVQI=
X-Gm-Gg: AYBFou3zJWTCnDTiKyYd4H+D14UfI/eqROOjVvV2fGlClHond0dWiX6crLWnPwMIXGV
 bi34BjLBv5/3yP18P9vOypFzkt+mTqjuc0lbROde3VWoYks8gtOLDHNxLYzz5rvrhTIZ3QwfaAL
 Kg5P9VVNG7onuua/U4zPdWtAFMrsOagpnj5PP9t/67ghB4u2DB919KP8m0OWasXCucYvkQb4rHJ
 /P5P2hj+IqY+N5HkUQiHYEwegTlJxeDxn+tLh+M1RAMtw834UzALwET7tJpia6Y5vzhlNvveYYj
 Wfy+j5pPnOJ1ljDZJGHXgCyegF3iarK7SiNU8TV/T58oXipHHDRrdihqR2xuYX5hoZugkFWuxnW
 DLPZrcXve8YJ3kfqo6WGJ8nT9N4tvbHMluGDQw9I7bmtE/YO3v4LKDZTSu60oAm16OXcvXMla6e
 OX2GLan7dpLYpNLIhCVizVZqz0UQAR7AL34GzYyvJvZFiJ/n0h9TuYPZ9uUUg4ai7Fr/psArXYM
 EQzWvILGbNaXH0rNgRZ49eNAYUAUI+d9RE37uAhcR0BaWYPmWgwg0sZleHRa9sADApqSedQV5zF
 SATsI4oe8BbOT7y5u1CM0jFpLxICR1htT56LG3S8O60w+1gfhatWAV3Chhvl6z+4TiG1dWNz7GX
 l29xS
X-Received: by 2002:a05:600c:3510:b0:4a1:dec1:4e1 with SMTP id
 5b1f17b1804b1-4ac1765d674mr232355375e9.22.1793626991204; 
 Mon, 02 Nov 2026 05:43:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe885d91esm201456445e9.0.2026.11.02.05.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:43:10 -0800 (PST)
Message-ID: <d5dba5be-b386-467c-8cf5-2dee30c5d0cb@linaro.org>
Date: Mon, 2 Nov 2026 14:43:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] drm/bridge: ssd2825: Fix panel enable sequence
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261025133636.253505-1-clamor95@gmail.com>
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
In-Reply-To: <20261025133636.253505-1-clamor95@gmail.com>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/25/26 14:36, Svyatoslav Ryhel wrote:
> Currently, in the case of a single bridge and a single panel, the DRM
> framework calls panel prepare() > bridge pre_enable() > bridge enable() >
> panel enable(). While this is fine for most cases, the SSD2825 requires
> the last two steps to be swapped. There is no meaningful way to achieve
> this using standard bridge chain configuration, so the bridge previously
> called panel_enable() directly at the end of its pre_enable() hook to
> gain fine-grained control over the sequence.
> 
> Commit 554d36acf5e0 ("drm/bridge: ssd2825: don't create a panel_bridge")
> removed this call, resulting in a regression where display output is
> missing because the panel enable function is now called after the bridge
> completes its configuration.
> 
> Since panels are now automatically wrapped into the bridge framework,
> invoke the next bridge's atomic enable directly, similar to how panel
> enabling was handled previously.
> 
> This restores panel support on the LG Optimus 4X HD (P880) and
> Optimus Vu (P895).
> 
> Fixes: 554d36acf5e0 ("drm/bridge: ssd2825: don't create a panel_bridge")
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/gpu/drm/bridge/ssd2825.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ssd2825.c
> index 71877699dfab6..9216cee09115f 100644
> --- a/drivers/gpu/drm/bridge/ssd2825.c
> +++ b/drivers/gpu/drm/bridge/ssd2825.c
> @@ -475,6 +475,7 @@ static void ssd2825_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   					     struct drm_atomic_commit *state)
>   {
>   	struct ssd2825_priv *priv = bridge_to_ssd2825(bridge);
> +	struct drm_bridge *next_bridge = priv->output.bridge;
>   	struct mipi_dsi_device *dsi_dev = priv->output.dev;
>   	const struct drm_crtc_state *crtc_state;
>   	const struct drm_display_mode *mode;
> @@ -569,6 +570,14 @@ static void ssd2825_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	/* Initial DSI configuration register set */
>   	ssd2825_write_reg(priv, SSD2825_CONFIGURATION_REG, config);
>   	ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0);
> +
> +	/*
> +	 * The SSD2825 requires that the next bridge be enabled first;
> +	 * otherwise, the SSD2825 cannot complete its configuration and
> +	 * there will be no output.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_enable)
> +		next_bridge->funcs->atomic_enable(next_bridge, state);
>   }
>   
>   static void ssd2825_bridge_atomic_enable(struct drm_bridge *bridge,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
