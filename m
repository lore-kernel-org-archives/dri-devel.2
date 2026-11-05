Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4D6082BFD
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GU5ROgXT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD6B10E087;
	Thu,  5 Nov 2026 15:47:26 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0AC10E087
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:47:20 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1115453f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793893639; x=1794498439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEFthDeOw857Vl1Txv+y9bOC3ebCcB7q3/QmLSqJflg=;
 b=GU5ROgXTc3a5nCczYR9/9nS5oEUfBLd1wIkK9mD6CyIIyUZK2W2nxFSb4BLvfWHBHr
 YNlzz8H3/3qsceeNI8t/pSfhaO6yBE7/f4jFRawWRNp+iQ6fz2cOspwIDOSIq486RWJ7
 99BcXZ/QH6Wnkv3nodxWdX541jQa1g9y2cgKwgr9l2VOkASsB4zXThodSwAwl6kt0sCp
 B1xb9A6QnFhkO20gtl8s32oTTRSAv6d6+7qfiBF8OaQDX9GvFNLxKNidUT4B4mvzkTKy
 /ucMOpbU7e7AbLCmVOoAy2zgCIE9ad1r/JmC9bGNiNbbuTW02QJOm37Wb7VosOeLf5V0
 RHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793893639; x=1794498439;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jEFthDeOw857Vl1Txv+y9bOC3ebCcB7q3/QmLSqJflg=;
 b=AGvpc/zDCAvu4c0nXCpPSi2Tt4Yb+HmWDm9ykOMKAvRIKzfJOLDi9W5BnOXqlT4n4j
 FlehzFse7BGZtdvVDXn4XiyshnLLQvl7HryU+oR+t8Zxw49oHhTBIG/7X0Cp0QvXhAIA
 Bz9w3nxbbDNLlUcnYg/Mwmrxr0a5li8iz9AsJuPBAcr/+VZXX8fQbgV36TtOMisp/lPn
 ioDPHZLXVmlNnNWLdH99TPiICqhRqo8yoZTCKK1dqpyeL8404Muj7Z1YplmWuSnG8k9F
 RUSvGzJcdJz9rBcrifwUgx0PhakklbnC/hm5crn5pQ0CxfmaaFbQ7GefujAf0VXhR+7Q
 gDaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2srb+EN6yOkcMHF/slPw1QjWk4q4TVJ2LOWD5fx2202RcMzOw5g/LW5iR2m7oDdS+VsZ4w6oOdlU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8yUNDJQOLCtPyJoVxpRiv4z4EiMhrib2xuGnLad/vAweNBl/lI
 WCJH406hPnDaS5hdxJ7TNF5PF7PaghxPvVmf3ZGJS+woOAJAWmTUhuCwO14HelUasBY=
X-Gm-Gg: AYBFou3JEFg+klyX/VZw98P9LWka863HLHwI++QDbLYrTT1cvKqotl1J/O+UU+bmnyA
 ehCBJp/q+1+31jLoKSgVOlrYeK7rkMcJwmlPWZeCa7WiQPYd42EG5ElzNn3p7UsgvoDrnGoHEMK
 Wbwq7wKKv9T4yfpG8ef24jD0ZsvBHdCnSvfmO9NCFkZJXpKTnE7t3cNoXij8QiJMppDrfnEHrEf
 URDt1KaET8DhV8NKRaEtnhQI1mkO19WCfsUf5C3XITKtiWCFBBqI3W/pgmeFJ83lwc8LWGUnJkL
 jjpBewBiEKVrZxoN/fxcqR2q8hNSAdP0wwEHb23ReMclpETULGXV3ZWl/EqrxfBGk7X1qdHUiLo
 je5SmwrsRb1ZQzLJvRe1okg9HKfS4rY93MAOk7O472BW/b+8FkXzZQmCasSI3obBJc2OsZ3E4Z3
 wdmEIN5IWZhgP/7Qz607qp9x1nP1hGEWbizXUzD5Q86MvXJaJfpeb9e3sv+w0c21ZjJbDpQpYHW
 HhrHD0+w/0vM73vUPk13fFBC7lPsga0mmruC3jEzsK9x97jdAL5/00cDG8vBDO85N7LKxBQL1n8
 wfStBPOzD9TWjlkw4c59/+2giUtyBrM/saqiDr+3wB+kRSxp+tISHjmblB+tyM6vfTxxAsr2ge2
 GF2RD1WH1
X-Received: by 2002:a05:6000:41d1:b0:48d:f4ea:49c9 with SMTP id
 ffacd0b85a97d-48e6e5196ffmr44933021f8f.54.1793893638733; 
 Thu, 05 Nov 2026 07:47:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea181085sm10757871f8f.1.2026.11.05.07.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 07:47:18 -0800 (PST)
Message-ID: <62271e1c-7a4d-4fe2-a68e-41066e7849af@linaro.org>
Date: Thu, 5 Nov 2026 16:47:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/meson: plane: add pixel blend mode property
To: Jose Nieto <jnieto.alaber@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261104155119.284708-1-jnieto.alaber@gmail.com>
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
In-Reply-To: <20261104155119.284708-1-jnieto.alaber@gmail.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 16:51, Jose Nieto wrote:
> The primary plane exposes ARGB8888, a format with alpha, but never set up
> the pixel blend mode property. This makes the DRM core warn at boot:
> 
>    [PLANE:...:meson_primary_plane] pixel format with alpha exposed but
>    blend mode not setup. Please fix.
> 
> Advertise PIXEL_NONE and COVERAGE and derive OSD_REPLACE_EN from the
> requested blend mode. Formats without alpha (e.g. XRGB8888) keep the
> previous opaque behaviour.
> 
> Signed-off-by: Jose Nieto <jnieto.alaber@gmail.com>
> ---
>   drivers/gpu/drm/meson/meson_plane.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index cf8c90158fcf..115849a0b0c8 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -233,18 +233,13 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>   		}
>   	}
>   
> -	switch (fb->format->format) {
> -	case DRM_FORMAT_XRGB8888:
> -	case DRM_FORMAT_XBGR8888:
> -		/* For XRGB, replace the pixel's alpha by 0xFF */
> +	if (!fb->format->has_alpha ||
> +	    new_state->pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
> +		/* Ignore the pixel's alpha */
>   		priv->viu.osd1_ctrl_stat2 |= OSD_REPLACE_EN;
> -		break;
> -	case DRM_FORMAT_ARGB8888:
> -	case DRM_FORMAT_ABGR8888:
> -		/* For ARGB, use the pixel's alpha */
> +	else
> +		/* Use the pixel's alpha */
>   		priv->viu.osd1_ctrl_stat2 &= ~OSD_REPLACE_EN;
> -		break;
> -	}
>   
>   	/* Default scaler parameters */
>   	vsc_bot_rcv_num = 0;
> @@ -536,6 +531,7 @@ int meson_plane_create(struct meson_drm *priv)
>   	struct drm_plane *plane;
>   	const uint64_t *format_modifiers = format_modifiers_default;
>   	int ret;
> +	unsigned int blend_modes = BIT(DRM_MODE_BLEND_PIXEL_NONE) | BIT(DRM_MODE_BLEND_COVERAGE);
>   
>   	meson_plane = devm_kzalloc(priv->drm->dev, sizeof(*meson_plane),
>   				   GFP_KERNEL);
> @@ -566,6 +562,10 @@ int meson_plane_create(struct meson_drm *priv)
>   	/* For now, OSD Primary plane is always on the front */
>   	drm_plane_create_zpos_immutable_property(plane, 1);
>   
> +	ret = drm_plane_create_blend_mode_property(plane, blend_modes);
> +	if (ret)
> +		return ret;
> +
>   	priv->primary_plane = plane;
>   
>   	return 0;

Sounds good, thanks !


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
