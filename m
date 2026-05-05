Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A161FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4EB10E450;
	Tue,  5 May 2026 14:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SY0gxa/4";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9864810E450
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:11:17 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488b0046078so45978275e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990276; x=1778595076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sOzo5FIH+z+xgBcDFCcgeO0PNVBFl/6WTgvdlY46+YA=;
 b=SY0gxa/41ISCdQx3XJeZgPtdRGViBj7mVwS4mfEdNxGnVNf2pGplbsiC+kRrhdvtHo
 JL9NEwC9h+vDihVDfV4Kai9CwTg/6gHCUu9lgj2EOQKR6ea+YL3Pqyr3SRmwh5ffERU7
 2As8NeEDyQGTR9dmMsXrEK5gvvGRdM0CqStf9rTH2M4TsxSdE9hfH3NWUnns6sco5rQI
 WbKQU3DnUetRJjXnpBSv7XX02ejDcAJJsv62+TxqKk52aXN2j9f9XhApS5730LveT4E/
 Sf8KIDpjhOvRFqLRWK2tfuvjvhEricIZB22BlfxQUXiwvlPuSzWthUwsp9OkNlivjtTy
 z5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990276; x=1778595076;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOzo5FIH+z+xgBcDFCcgeO0PNVBFl/6WTgvdlY46+YA=;
 b=FQ6qWaUql1OH9ggM1HSR38RVhr8xHSkpb+HVTcKewaqKL7fY0kFeSzHaHQRbqL3J4D
 x07LHyQz8hd1djxdwGS+yj2+GPlf9VLpciZa1XckIJxfYt3Mvxcuou935EtdN3w7GuFO
 s/6+4HxRwX4B2WK0jJUUm/F2/YTQxZH1bK86GuMJbsLkr+nCWlfKkpeiorLO97oK55nr
 EmrrOumzG5y9BqrJuzdPNVuiUnT+rkDCfAGpkpyWmaPCqFvXnKZGRCrzcyXa8IwDtazO
 GDwx0f+jRnSNtV36sjrURY0roqA88x8se6BRaOjc7USEGcSf1n3G88xPzbAD2D1GwWkR
 qExg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qTkhCTXlapLKCtX9SVvxcV+LcBht6a1q82FfdAH4y6qiNjvLQW+wrnw9QbpJLDTwOEcDqc2UYIhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTFRFFRigj1OQmTtMg08XfqrQuRNSXRJeRB3JTaj6OXSBSuFZT
 mnZGou68GLSquvBUQeRVNcZfw/1fPc6YmyKRV6WDrXe1MGOPTASlU5k/hKX8ek0eTCM=
X-Gm-Gg: AeBDieudgeAPuvbmwR6QPNJ581l2AlsDO+7PZAT5Q18w5taPAcT2O7tSzzZS3sOGlH1
 Z76YnjePXoKENtU70MrzlbRpfDBEz4eaWLD9ADf4LF6/0Xb726SpInxKSpHoYHeEb7sILrjUG8u
 GeBIOCibpKfvCKi8AKgps2vit/RXfvzVZRnhQ0c+F9v2cyabZkz21NePY0oTrzj58W7bWVuWo4A
 6NZrdx8OFPIU9+Il4Yr46P7Dkst1y9Tblm6KUEZaQcgDtqNdGyAh+4h8APclADqKr2rcJMOSB7f
 +6RkxBQYioVtj8QVlQRq4ONFdpjwAybMbGH3jBHCO0zIN1ZmGLBcFjiGteju8I8+aCE9/IJjHI9
 Q0jzUQrzRH59Tbmskp/9wgkNuOxZt59DTXBDpUA1IaCiCWvPtyuJlPbyPO2IZyKtn+GzXYlTyWE
 0TpMTQ8jZdgSpHunePsW9hu1KMqjb28OxQaLhbZaAplHbIcvPnxs9NJKlGfEfJIQRutZoKhns4D
 M/4n++XoVXOjeYOlw==
X-Received: by 2002:a05:600c:859a:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-48a9865e76bmr169457185e9.15.1777990274806; 
 Tue, 05 May 2026 07:11:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:19a4:dd04:854d:9f82?
 ([2a01:e0a:106d:1080:19a4:dd04:854d:9f82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d14786affsm32297195e9.0.2026.05.05.07.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 07:11:14 -0700 (PDT)
Message-ID: <63278517-8df1-4cd0-ac59-6f7cd3ab1e42@linaro.org>
Date: Tue, 5 May 2026 16:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 0/4] drm/panel: Small Kconfig cleanup
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Heidelberg <david@ixit.cz>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260505-panel-clean-up-kconfig-dep-v2-0-9cc31d6e6919@ixit.cz>
 <177799022301.801510.9046759541579593814.b4-ty@b4>
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
In-Reply-To: <177799022301.801510.9046759541579593814.b4-ty@b4>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 5/5/26 16:10, Neil Armstrong wrote:
> Hi,
> 
> On Tue, 05 May 2026 15:53:39 +0200, David Heidelberg wrote:
>> Inspired by looking at Marijn patch. Since Marijn patch is not merged yet,
>> appending patch to my series.
> 
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
> 
> [4/4] drm/panel: Enable GPIOLIB for panels which uses functions from it
>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ae3aa8cf5fd5ccb428a814e7eb38ae33ad1cfa34
> 

I had to fix patch 4 to apply, but I applied the 4 of them on drm-misc-next

Neil
