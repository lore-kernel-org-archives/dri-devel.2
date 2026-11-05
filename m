Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA6606D83B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vH3geCxN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622C710E94D;
	Thu,  5 Nov 2026 15:52:39 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9382E10E94D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:52:32 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so9066995e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 07:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793893951; x=1794498751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GWCoEkBHP605pI0Qmm4NU4T3DG8OFJsvFq5xEzMuhw4=;
 b=vH3geCxNzAOF+C215bmuVbQqeWsNuEX3fKHjbn8Yi9Vvvrh0giMEmfRiaK/aB33DZ3
 WUvka1HDxBKV53A9UN6Mk/olH69cFyuYK6eG2P/Xeq4mEC43oHciFBOd2QhET4DKFjGX
 uqINeFetv/QwFyJLDQaOrsccVPn2IdkTH90TD4a7J+/3Sj3rs4VovV9xOG/G7Xye5Z1s
 R6oYxA+J0v1EJloqyJ8vhZNyCmsfuoKJZdfiFnW7JIl3fvzY2pXgyXp6laPYyl4bNsyh
 RiSKjkOWn38Bw+NR3xjZFS0dA9mG2OfxtauXow6kwAMq5qv/PDhtZQ/yFm4Hc24SXY3O
 RsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793893951; x=1794498751;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GWCoEkBHP605pI0Qmm4NU4T3DG8OFJsvFq5xEzMuhw4=;
 b=0Vn7ndHobh9bNbDuOt473U3eTFfMVwTjG/m15wnNOZw+ix1v3FVAXLhx6I/l6szvRF
 WTJYxIfNTcZ0i/A5bfa1sdYQWQhXpftfn7UMND9beOVoc88Ka+ZJvObM//UjZcu+nGcL
 qIqeFcdcHIEAuXdGgWldcM+gnWCFtkirahaPuSDRzerWd0glZoZuaQueYTWLvDwUjvL+
 sYqiFheQu6uvlaKiOTg6sFgiRWcDMXtc4ByZYecyHGT4rfFgTXIp5517Sv0hw6Z4/hNA
 razR+88QKzNfJFOjr7G2bzJ7WuUgv+9RBkjxF6EHXpbRb0fLvfJBXfN5GPHQ2ZnVnmWb
 Y6Ag==
X-Gm-Message-State: APuU4Z99QoKuyTO35HA5k+zFbGoK+SNWGC5zPzt3KVWUs29PhHFz9Xn4
 uRSHZ7JRBWba82iegCy1T5TUF2YfwMWTdHY6OMuL0I/S10/6+A/G/AJBLeMMa66j4R4=
X-Gm-Gg: AYBFou09SFu8dVy2KCTJ6aO9MUU54LXKAYCavrrY7zDLkpIH2xfLK4Uz02Kr+kL5m4o
 VwYdFZXhN1Jp2B1/Y9HJze0Mkfaapkp2JGtJmjsms1W+0FqfFOeze1+27zSvIILKuamis6QBt1B
 izHSFE+6GC7WxMSAhakYB3ydHjVqPyGM+UWZ+HmT8xG7n1yPGR4plegAsBkPiB9EKtZx8Blmppk
 FnaSx4XRj5vQMfGFRpQvfPCzlVZSsvysXDcZ/5PH+kN+rJWfZwg5EPav7jMgbKjwyrfEsN2bM1A
 o5FdWEn6oSZFT1CxW/fwwtTSi8Sfo+kgtYS9+N89jrH5Z1gAKoXQpxEoGCOsH8XcEkKp/xInN4q
 spTtDY1JIAgQcLEovRX8ESbANin3m0RJDlFYNfZ0kpMCFXY5kOVKyGVtb1vGc9e43gQROtxJXqz
 RzXK7balKDAIfEjjnwU8Edw+haFPj44cl8tMBwlfYylpCekXohFhRwUj/7KPFjq31ogv2uqhmht
 D5oLPeTEDRmJFi2LxO2gCxapxQCg4Fqs4nNG7vyX/726jBTIpeDMJ4FCzq6NJMRp4+qHD6WjQzn
 Jn/QQKbTlUabKHGlMdNrGP8A9AxRF1bZ4zBAPAQtify3HE26csMfBaGJBJ2ISPqTS1Fb1OmZUNo
 MpBlTgYGQmkquDP3jlKhs6UGWzU0S
X-Received: by 2002:a05:600c:46cf:b0:4b0:b9ff:1e7c with SMTP id
 5b1f17b1804b1-4b55e07e569mr58728955e9.15.1793893950764; 
 Thu, 05 Nov 2026 07:52:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56fca22e1sm87441305e9.14.2026.11.05.07.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 07:52:30 -0800 (PST)
Message-ID: <bfbb4d7d-49a0-412d-b3a6-1ea226748b16@linaro.org>
Date: Thu, 5 Nov 2026 16:52:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND 26/83] drm/meson: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Jerome Brunet <jbrunet@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-26-1f58d1e33380@kernel.org>
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
In-Reply-To: <20261105-drm-no-more-config-reset-v1-26-1f58d1e33380@kernel.org>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 16:29, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
> 
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
> 
> Switch to drm_mode_config_create_initial_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-amlogic@lists.infradead.org
> ---
>   drivers/gpu/drm/meson/meson_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 49ff9f1f16d3..dda2dc2d5b00 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -345,5 +345,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>   		goto exit_afbcd;
>   
> -	drm_mode_config_reset(drm);
> +	ret = drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		goto uninstall_irq;
>   
>   	drm_kms_helper_poll_init(drm);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
