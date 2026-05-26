Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050EECD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6358310E4EC;
	Tue, 26 May 2026 07:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tSVpOZBQ";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789DF10E4EC
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:16:34 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so26657345e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779779793; x=1780384593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6qT/bMdEBMK/k6bRtXEjwywoU6w4KQoZt190nLYNxOs=;
 b=tSVpOZBQy+CkosInyWUaPU0xBUUzGXdfHXuyRQNLOTH0cCklzRjthXAaC9hubTuELt
 S0SJ2mJPYtDlNzvlhXUtcHxAec0TiElfZ8hm41putQlqbPZnYa/r4QlK7vXApPgVRf9F
 Dc6fsCYULXcOD8vf5Ul2lU4gY0+Y1PS8jIDqUPvUMY6X/YPFSZgptP6JCZTAUl9Vmj9P
 ADR9Ya9yWi/OBFsEVlhWHW1XAHPOt9kDx4aNzCpPYiKxup5w38ADxvFAgjS76RTH68qy
 uQ5orgbB/Q83z58NCvA8mn6ZpkARlOhEVJ/wFjMmc12A/tezEKLP174Nvrl2JiOJa8OD
 m5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779793; x=1780384593;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qT/bMdEBMK/k6bRtXEjwywoU6w4KQoZt190nLYNxOs=;
 b=SryHVTmJfJxlSrsxpigvtaQbnN8DmQZi9WyQGUjP42BRcvzltRSzeBBWUlDExa/kz2
 RsTkig2UsSzrT28vawiKgNarJfOCINKpuEHXWBI35EUAPBTESIlN5/ugD+I8APkt0PRW
 ZCP3yjWtxXN5RHJ0vhhuP9RefbEbaYJOgoS5oWzZJDGv7r3MC+ZAG39jrkZbKoi75x8N
 Nf2cmWg5X20D/jIh08XVi9dm/NRvOzaTlVJpFqYH9Nvnn+7LZYeXihjRDfy07waDNqPb
 LAS4ElkypPY2IYwmDGePBe8uqowyvXgD8hSNONLDMNA10orX/IBiMEe1nLnS7gM3HtmB
 lHfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IxpLJ+29xx38rssknm9pMSp7MsPYgc+ttyaUkHGgzCKyG02t2jPIenSvBj5j1AdGzNa+buanK1nk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZXQxWH8+B9qg+pDGzfPAzOzcmlKlncbtYZZByoesYi7jHeY+P
 YvaZSJuVleqaaMqZppL7bg4o6KBL8dQ9c7tlpma/BKabdTR2JJraKLZqTnb0sLI7TOo=
X-Gm-Gg: Acq92OEoQBxx+/aUFww8vUUIzR5ViFdw6uts14g5guQx7jjIZV6jhejSsTFK+sgKekL
 PcSj9IFDEdRO9cG20Y8AOkCq/CbK6tkJdsXE5kyrOkzIvaM+SjVXcoEtQ2nEXMDc2H7utpot1yW
 Q1QVxScusJOiWHRLH3XNZ2ga5sKTD3wYZINwO7BJrzcbhfmIyMphAiCqL6gFJh1RveftIKotXC/
 inj1LcBlc7/yYb3jS/F5ynBiKfgU9l9PyzWfGeNCLw2k4SwrdkKOtByr4lh+dwi0Z/9bkfl2hHt
 NW2AS98cNWPT/Y8+GSxQgjWuwd3V1XcCYehileuf/YWh4MYaO76CFxuY656pE8YwnC+fnnzhAHr
 /p3ZcbvU/fr1FwXD1zxZU5BYRXqOE2AlANvQf+84+DmCqUoWxZVeJFz6qGdtQ0vuHQ9Oi1L+jCM
 sCruVmuF22LXIZtDYwyvPw7waDtLwtnG2RhrpFfODWrkFgiOoLfSXYEGD6CcnBaPCTuZYGC/jgh
 GRG8wB1ycgzp2pi+A==
X-Received: by 2002:a05:600c:4591:b0:490:6869:46c6 with SMTP id
 5b1f17b1804b1-490686947a8mr90737495e9.31.1779779792774; 
 Tue, 26 May 2026 00:16:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526ca21sm299610585e9.3.2026.05.26.00.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:16:32 -0700 (PDT)
Message-ID: <147bb128-a77c-49e4-897d-ba6ee1b1449d@linaro.org>
Date: Tue, 26 May 2026 09:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/meson: clean up KMS polling on register failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260524160657.17802-1-mhun512@gmail.com>
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
In-Reply-To: <20260524160657.17802-1-mhun512@gmail.com>
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

On 5/24/26 18:01, Myeonghun Pak wrote:
> meson_drv_bind_master() starts the KMS polling helper before registering
> the DRM device. If drm_dev_register() fails, probe unwinds the IRQ and
> DRM device without stopping the polling helper.
> 
> Call drm_kms_helper_poll_fini() on that failure path before freeing the
> IRQ.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/gpu/drm/meson/meson_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 49ff9f1f16..e49de5df73 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -352,12 +352,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>   
>   	ret = drm_dev_register(drm, 0);
>   	if (ret)
> -		goto uninstall_irq;
> +		goto uninstall_poll;
>   
>   	drm_client_setup(drm, NULL);
>   
>   	return 0;
>   
> +uninstall_poll:
> +	drm_kms_helper_poll_fini(drm);
>   uninstall_irq:
>   	free_irq(priv->vsync_irq, drm);
>   exit_afbcd:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
