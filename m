Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F09CD5BB1
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B3D10E06E;
	Thu, 21 May 2026 13:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fVDCpB1J";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2742D10E06E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:05:52 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso3552164f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779368751; x=1779973551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NWQMRwkKuvkZ+8E1NAhhl6J7aua5KNzmctBCLHdZOyU=;
 b=fVDCpB1Jkx9w6VVvdJUvV8vTOJvy9XYHSEve3nGiwFULyV2Oa/g+wF7lMP/5VJiA5o
 pjy/f2qrd3ptvTfvIokvaKcsoeLhW/lebFr79gHc7fOcV+nehMAUJrUe7sM0mDu0RrNX
 3ZgJnZl8jyCkhu/yO5HfVlEM68QQH+v+XXJw2hUDK7dZbcklcIwiYQZJOPVk6rESHkTW
 4Gp215sVKa18nbcCBhi5EM0D4txKWa5PbSWENydI9284Sd/w65rhXhCIb4flZH1wFeHh
 oAH8SdUpWvsvr3776dK4LLUcKRS1ETcrFbelS0P+m+GVGaA/1rqyioaX+iWXj7VuPEjI
 Zvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779368751; x=1779973551;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWQMRwkKuvkZ+8E1NAhhl6J7aua5KNzmctBCLHdZOyU=;
 b=pjrBHgP+acGBHb2pXJHO56FZSSNwfrd/qUXqE0H0aZXafNA5VLOvRjEmrYw2iubbbR
 xs94Bv2almpJNx7kYW4QTd+Obl/qCEVVFLMkV+EsNMRKOXR2+anAP3xvsXEF93Z16au0
 p3OgHpVd0/1ogKHmWnc10jfW4JNacBkuV7W+7I3GAAyUn3cNA15WysJTZNDAjN17DFKA
 BvQAbqsOlNaeJCKMcyJtDgafHmG/vzgCKp+rd3vN9BsBUmj4b+pBscfKyRcLzoOXFpYH
 uHJ2MUAw1zNvN2BY9kaL5l4+I4ci/IDnb6jYwRdBQcrHj8Gm8woX2UVrsbXxLJ/q2Ewe
 i9rg==
X-Gm-Message-State: AOJu0YxBPh528Zoo+0hmrkmS3ENsxB6OHiVtzeiWkqhaLc/0SJRBMXOb
 NFKwr3P+DVqrtO/6s397ngmEkmsIdeepUVxCeQRZsYD/Oa4DzdPkoR2fTPCbfovUbO8=
X-Gm-Gg: Acq92OGIbJJCN7B1qzOhgfx73eVNwxjM1lnnCXFkG/1hesq9ObK9HjO/lervJTrJroj
 KMwXd5KWruI8aelIWFqTt4WjGqc7n+Q7nEVyHdXA6E3TQqilpoFHtTeE/TuvotbjOZZx1F8Dur+
 0dgXSmYeaAlYrtckCT6uaM0armcvvEXf4YcgH+2Pxwik205jBPkrMgCCmiYWRIge6eUGmiC/aFw
 SVcFSUksNUkX6DtrsGXTuvgJmDDyPfwaf940Cxgud3Zbd79JNs0mmA0EW+2KTAdepHIqe1nyNmo
 j5HBCfQNtEZZKk+UIz+9FPrf3odo/9jJQwP4P4MgfbBbE7mb+rEjzlyIyyXMhGQ9z7/Jgyf5Sx6
 KHuMLlJOX/03L33LL6/W5gAnceNhhF3s5Ew5HiRGZBLUlnmWCkP/j4CYTj0a8+SwVmvvZUdxhpa
 XJ+7W1IEzIrWLT21TpO9medqirHKmce4qo0L0SodA+6Dyz2YbrTg370qPC0sK/xr1Bx1kbKaS3g
 tpwwAA=
X-Received: by 2002:a05:600c:8592:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4903605d40emr32501135e9.14.1779368750434; 
 Thu, 21 May 2026 06:05:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7e6c:bb76:ade5:7e8b?
 ([2a01:e0a:106d:1080:7e6c:bb76:ade5:7e8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d34fd4sm66540715e9.2.2026.05.21.06.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:05:50 -0700 (PDT)
Message-ID: <88c5e061-ebad-4f97-be93-a2b6bca75041@linaro.org>
Date: Thu, 21 May 2026 15:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: fix kernel-doc warning for devm_drm_panel_add()
To: Dongyang Jin <jindongyang@kylinos.cn>, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20260521094545.3039207-1-jindongyang@kylinos.cn>
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
In-Reply-To: <20260521094545.3039207-1-jindongyang@kylinos.cn>
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

On 5/21/26 11:45, Dongyang Jin wrote:
> Use the correct kernel-doc notation for struct members to eliminate
> kernel-doc warnings:
> 
> Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev'
>   not described in 'devm_drm_panel_add'
> Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev'
>   not described in 'devm_drm_panel_add'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605210648.RI4ufD66-lkp@intel.com/
> Signed-off-by: Dongyang Jin <jindongyang@kylinos.cn>
> ---
>   drivers/gpu/drm/drm_panel.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 04f4a31ed27a..2c5649e433df 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -108,6 +108,7 @@ static void drm_panel_add_release(void *data)
>   
>   /**
>    * devm_drm_panel_add - add a panel to the global registry using devres
> + * @dev: device to which the panel is attached
>    * @panel: panel to add
>    *
>    * Add a panel to the global registry so that it can be looked

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
