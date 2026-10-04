Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B183CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD7110E0DE;
	Sun,  4 Oct 2026 15:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y5JgpfHs";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A8810E037
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:31:08 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48b03f23305so911965f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791127867; x=1791732667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A8UQiiW/gzilrgvSzhDTIjzX+BX5W1JZdipDo+7xtF0=;
 b=Y5JgpfHsjQmYaM5+3gR7L8L+XNgxxYEGSKOMqCECOWnswBYLRp6Ador2dD9jAWKyhA
 wKAx+agabZW6RTyYrrd7tt8Ab/9V7RXusVUYzoIUq8T8tXWcERWCSADUdvGx/3i/uob3
 0BMzyMjbiB3RbOobRZrczOaBLMXLbkShnAtzjc5vOID42qSt5A1EZ0oWFxLuiRf48Qde
 07ogBWTIfLwkgDTrAA3AaL5OahxbY1z2qv5fICVMXvj+8/fzeFNktjU819PTUBjgi99/
 2cqNr0fl8XJNgLETBhv+M9GYsXNYtylJVuykC05485xCq6SYBcGkSDoifno5QsbNlO2z
 vtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791127867; x=1791732667;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A8UQiiW/gzilrgvSzhDTIjzX+BX5W1JZdipDo+7xtF0=;
 b=zyBV7Q5UpcZdSmYSgoqcXlczPpfrhI5VsyfAMFo7es5PAw0wr3kSt8RVH4jwAgI26B
 3KVI9YQkG+lHAUoLYLIiElwopqKhHvMQxBNucxGZyE5daGWZzSJKAHhETa9F1sAmjai3
 4C+NscfLEH9TlnakJFyI+GnNmCo4hU/QVr7RMOqKimdCP7mpR7bjXf83kCrlVRE8XurR
 Ak1vIk9sO8+jlu6OFme2vtLynFbNf6KNQGaasuLlmlJJWXcuz/lBchcIx7IFaROVLSYt
 XPEw+t/36LzuoAHTbLXVFjViPDVdrE9EJmSxt1Vg4YQIgG7BVkISLN/vAQ1gMAkzCUr5
 zPcQ==
X-Gm-Message-State: AFuF++l5WAKeO7jLK7NoR/UtXoDQC8B5kKuKJY+qh1yR6jpfRGzIWpe2
 9HIQveX2Cdngt6kX4gFAtOaEfyipI3JqY3cV0wcEnSO2oFMUAdlA/eT80y5O8rLmPM8=
X-Gm-Gg: AYBFou29TeUhT/S5SpPW6eIoKMlyAMDrmYsRkuqUrL66i6m1iaR0EpKX6rBwvywUbCd
 9M+NQtqeG0KN0Dtoece0HYU+oU693+DdjBC0Wvk5mnEs//HpX5UVojgzrjhWB8z3Y4BFvefQ2c/
 ZI2a0JqyqOEyFYgKpLGhA6qSJLO/EO9CIbiEV2YXmFNrsxIezdGo7wzXb8Ru8sKFKRAI47YRPYL
 FHZp7/DFab2sy4I0dWh1FsXy6s0B+rbbfFg18HN7UwkVWbXSrGuvTXkK4ZiWeiKFzDO2uPCeyhh
 EBmE7RzQmBHUNtRpJirwaQLVWJPOci4MJXKEOTYtHyFXLEzUml+ZE2bW2kl4jCcubS/InUJqpwo
 XqFwtxKgkl0kS82XHZC+vsux3jyhldnGNFCU9MZ/ttIzxRAd0g6QMjxLReILzlsA+vk0JGAKiVQ
 oaxoffUewbf0dlXO5O8PHU9l8Mh0jViG6HUChtCYgkYRaYsUC7jPzUULTl9caq+dmgeYUcelA85
 zXf78Gx
X-Received: by 2002:a05:600c:3103:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a1680fd804mr74504535e9.30.1791127866831; 
 Sun, 04 Oct 2026 08:31:06 -0700 (PDT)
Received: from [172.20.10.3] ([37.169.53.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027741586sm262949745e9.14.2026.10.04.08.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2026 08:31:05 -0700 (PDT)
Message-ID: <022f5372-7963-41b1-ba76-2d89c51aa8c6@linaro.org>
Date: Sun, 4 Oct 2026 17:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/meson: encoder_dsi: load ENCL gamma table while ENCL
 is disabled
To: y-asai.0816@docomonet.jp,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Nicolas Belin <nbelin@baylibre.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, John Williams <porschemad911@gmail.com>
References: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
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
In-Reply-To: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
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

On 10/4/26 16:50, Shigeaki Asai via B4 Relay wrote:
> From: Shigeaki Asai <y-asai.0816@docomonet.jp>
> 
> meson_encoder_dsi_atomic_enable() programmed the ENCL gamma LUT right
> after meson_venc_mipi_dsi_mode_set(), i.e. while the ENCL timing
> generator was already running (ENCL_VIDEO_EN=1). Writing the LUT
> during active video stalls the hardware: L_GAMMA_CNTL_PORT
> WR_RDY/ADR_RDY deassert and the ENCL line counter (ENCL_INFO_READ)
> freezes, so every remaining write times out (~8s total at boot) and
> the panel ends up with a corrupted gamma table (wrong colors).
> 
> Instrumented boots on the ODROID-GO Ultra (S922X) show:
> 
>    failing:  start: VIDEO_EN=1 INFO 0000001a->002d0000 GAMMA_CNTL=00000030
>              stall: INFO 002d0000->002d0000 GAMMA_CNTL=00000000
>              (VID_CLK_CNTL2 / VIID_CLK_CNTL / VIID_CLK_DIV unchanged,
>               i.e. the ENCL clock is still running)
>    fixed:    start: VIDEO_EN=0 INFO 00000000->00000000 GAMMA_CNTL=00000030
>              no stall, no timeout
> 
> Whether it failed depended only on timing, which is why enabling
> lock debugging (LOCKDEP etc.) appeared to "fix" it most of the time.
> It happens regardless of the bootloader (mainline or Hardkernel vendor
> U-Boot).
> 
> The function already writes ENCL_VIDEO_EN=0 right afterwards before
> re-enabling the encoder, so simply move meson_encl_load_gamma() after
> that write. This matches the order used by the vendor U-Boot's own LCD
> driver, which never times out.
> 
> Tested on the ODROID-GO Ultra with mainline U-Boot: 5 cold boots +
> 3 warm reboots, no timeouts, correct colors, LOCKDEP disabled.
> 
> Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
> Cc: stable@vger.kernel.org
> Tested-by: John Williams <porschemad911@gmail.com>
> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
> ---
> This was found on the ODROID-GO Ultra while bringing it up on
> Lakka / ROCKNIX. Happy to test any alternative approach.
> ---
>   drivers/gpu/drm/meson/meson_encoder_dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> index faa309cb97a6..912cd676bbe2 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -65,9 +65,9 @@ static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
>   	/* ENCL clock setup is handled by CCF */
>   
>   	meson_venc_mipi_dsi_mode_set(priv, &crtc_state->adjusted_mode);
> -	meson_encl_load_gamma(priv);
>   
>   	writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
> +	meson_encl_load_gamma(priv);
>   
>   	writel_bits_relaxed(ENCL_VIDEO_MODE_ADV_VFIFO_EN, ENCL_VIDEO_MODE_ADV_VFIFO_EN,
>   			    priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
> 
> ---
> base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
> change-id: 20261004-meson-gamma-3306257c0d28
> 
> Best regards,
> --
> Shigeaki Asai <y-asai.0816@docomonet.jp>

Thanks for figuring this out !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
