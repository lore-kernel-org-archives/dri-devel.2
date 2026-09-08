Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B7BC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4204810EBED;
	Tue,  8 Sep 2026 13:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zAGjqqLd";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEE010EBF9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:39:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49d0b98d6d0so26632515e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788874777; x=1789479577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4c1OWqnqeFMUI7UCBm5h3sA/LSJxl6dx6ljBFoOkX0o=;
 b=zAGjqqLdKw/6b/8fbMbqPlsy+RPTOmyygMRmhnZrAiWlEcUcz1ULDxa/l/0T+Kq/hM
 vb0sMYdcAmswtjtKiu4d+qHMuExD0tGkCxXYWza9x6ABW2PtjbxD4EaXRzJITr20sRbg
 +O0HEax7Y+259blUaTDm7LTAb/wYC4SunDIIrk8EwSU1Ui+ucsotkIsuNG+0Uwmx14HC
 2HBodbJKH0212EAb+71mI3QyMi/nyV75kxPHre//OLNJcBKb5P8VuckbIupWAhmIaUzS
 NIvgy5kAiDhFdinj9xdQj9nXSCO0TGjN6f1a29sNVyQZtqPJhtee3ci1s47faqfg8JGJ
 2EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788874777; x=1789479577;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4c1OWqnqeFMUI7UCBm5h3sA/LSJxl6dx6ljBFoOkX0o=;
 b=Un4lvRi0ERwL7IcgjY5/tNvMqTQ9Wqyia8S/Edkw57I3LN6yD0ilr3w0WoQURj1Z/O
 lnlVKwAhO/QQC/DTz7/MZ4bYX7srLjAOjJiJJx8sT2AbzZ2BgUQ+8DOLbDIJgqYkH7UD
 GYt9QljBMEfPnuV223ZdNZdNL5wf7CpzHyg1snpZKeVxtJ06Sal1L0aebJlm2KeyqrjS
 GUOaHX2mEaxCzDttQaFdgB/pamWgNt5xFsqGgx4rdvOKkwHNrn7jXWCAvLc6Bf9Z4fmc
 k7QmWeWbntUMiLAagaZrhD/JpSDIWJrqHKwAygquVHg2j73MjtYy7Z/MHhFkcm45Uqg/
 yxyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7L+XlZZ2bQbR1gOCUtL2x0AV3dH2pplsEUHj5iM8JT26fQMByLvl0Z+RGU7Q47wWZyeY/5S8GBw8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQPRvAj7EI0kyJkE+zKRMQiL5Uig0hKrrJIxonsOsaYCkjQXzY
 k6qnMy5b8GDRofIX5R/b4N5fuOG54ZGW9nkQfV9nYJRLQ0wu+q+3jYKR1xLsLeoRl4Y=
X-Gm-Gg: AYBFou3x4q+/GJPAej8KX6aWawofzhR45pCD9qSGSakh56kgEs1KqJiQU1flQBZQjMU
 veIAYgVaLwt7T0RGW5DG44qZUn3nMGVCRUKcAAIuMpXLMHjyrgfC3uoD6mJP7xtLyXDJLzk+R2K
 zEbDJ+pT7PWAZsX1RiaXUaRakv8GvKjCnkbLULa7qll+Uyg3OHJ0K3WJqoPTr9Ia03XrIZ/7uoQ
 aH3S07wOGeH33xKvbF2kv2/v0vvgoMtRXOahnzuL0vf1smk1Cfo5+Qa82jHLvbIHZfKP4+Meno8
 KyxtanT1BaEOflw0hltMe+2dv4vGR8HkV7fX/IJeQ0z+auVJ8iQchJrzcdqLJxvSnNdQbKquLOq
 LySiiSYXQ6g5hSDiL84u+xWQxSOc95nUrWq8o7hQEqOeeML81vKG3TPsthsBr4kTpi3nzubO7To
 seINiZrUJneCGvVNntxLB5boh4uKVGiOth9+b8l+HH4AnermBs2ZgrJxgW6F8RY4RqCID/B8/Ah
 QWZL4FXfZoKn0g2wU6R8NWNJ7QPmFhynN3UAbsKX0OdjoLWT1UbLMU=
X-Received: by 2002:a05:600c:358a:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49cf82070famr289134495e9.2.1788874776647; 
 Tue, 08 Sep 2026 06:39:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:967d:afba:15af:27a2?
 ([2a01:e0a:106d:1080:967d:afba:15af:27a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm559730545e9.13.2026.09.08.06.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 06:39:36 -0700 (PDT)
Message-ID: <6cb0a7eb-469c-4cbc-8592-8365d1514c2c@linaro.org>
Date: Tue, 8 Sep 2026 15:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] drm/msm/a6xx: Add CX AO Counter registers used for
 a750 GPUs
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-1-284880d6e68b@linaro.org>
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
In-Reply-To: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-1-284880d6e68b@linaro.org>
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

On 9/8/26 15:24, Neil Armstrong wrote:
> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
> register on A6xx and other A7xx GPUs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> index 33404eb18fd0..3fe7bc3ea93d 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> @@ -141,6 +141,8 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
>   	<reg32 offset="0x1f9f0" name="GMU_BOOT_KMD_LM_HANDSHAKE"/>
>   	<reg32 offset="0x1f957" name="GMU_LLM_GLM_SLEEP_CTRL"/>
>   	<reg32 offset="0x1f958" name="GMU_LLM_GLM_SLEEP_STATUS"/>
> +	<reg32 offset="0x1f880" name="GMU_CX_AO_COUNTER_H" variants="A7XX"/>
> +	<reg32 offset="0x1f881" name="GMU_CX_AO_COUNTER_L" variants="A7XX"/>

It's swapped.... please ignore this patchset I'll send a v2 with the proper offsets

>   	<reg32 offset="0x1f888" name="GMU_ALWAYS_ON_COUNTER_L" variants="A6XX-A7XX"/>
>   	<reg32 offset="0x1f840" name="GMU_ALWAYS_ON_COUNTER_L" variants="A8XX-"/>
>   	<reg32 offset="0x1f889" name="GMU_ALWAYS_ON_COUNTER_H" variants="A6XX-A7XX"/>
> 

Neil

