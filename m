Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59C1C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2088710FA9B;
	Tue, 15 Sep 2026 08:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NcWcMhwV";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF3510FA9F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:04:55 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4858303de5dso4213834f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789459494; x=1790064294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2kATBR0QOSU9fXXjvSA3WJqKNnMFONEMjfJxwyv31kI=;
 b=NcWcMhwV1vN+ZYioISUelYULWMPCrfjtXcMBd0mqt4dcnycU5IMhazBx7uibbKHadV
 ZcnkBzYKdlrx1f426qsw6SHguuPCSt9POI0l18zHEPpXp/h+6nW46SoYCSDL2VRA9vxo
 aF7SS9b9gtVWASLg87uYoaf4VQuWrx573yIDG0nTFzu46JLLlEOTBTbjrTzoKjAUch6B
 v/qCUJ2Sc6jvECdXhHoyOXbCZPcubQNQ50E12tsiEVV9NrSE1FeeHwqMoEprvTw7yIsh
 81LoxDh6Xg9K+yY8HxEsQMZFrro74stafK5L4xtHCbMXuzGVT+I+2EwQGenljB+o9I7K
 XRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459494; x=1790064294;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2kATBR0QOSU9fXXjvSA3WJqKNnMFONEMjfJxwyv31kI=;
 b=UTlmcSBlBACD9UiWqWSTO5CkiVMFzdoqJ25C2wvIxEHSvHyftrMtgOCOpIxb/clhOT
 oqI3+m8OSAfHCgbX2HOR5BOl6+ZnyDCYBKaTH9WyQZSz1ceB+w+ezmufQijEWSj1h6xS
 f8cxcAnsnmBuzTWjbvtWvs4Xkdp7fwL32+VufVLO4p6yAcMw2TyX6yxuaMWBSYRVZYup
 nXGT71CGRlXQg4QH8pTrSEGaXABCO7+maGtaMFY5fnj3ZWY7O/qUkv7urzRnj1r34Tp2
 NFBL+vyhcRhgPMjbi/eED/NL/o0zVFKbBqS3+fIyf/AeRMGjjYtSgFMG9+rAadQZbdvR
 ulgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc6AW7KfskETQZ3imT3caGj7HEudfrRJZtsu/mMBBSrqJpHqX8GmY2M8ZXjFRbFOjjgYU/jrdLD3s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kguCXLeRma/wAb2he0iyMIgrPntz1iP9C20ZU6RmsVvKMS6JvI
 vyEjS9ZnJW5B/7pjPW4YeK/Rkv5eNSxCxY4g5viEQvjry30RwWhSwpItd1iVg9FUyos=
X-Gm-Gg: AYBFou2XFk1UJDj9XxvqWMl9HhoV6wnLIE1tT8ljsB+O7+Xb6mQe8HnFH3CFaUs9A9Q
 CdZqAwbwofyMkCvitRsEcRGRWnVvUzJp93zZjI2MDfnet95ZfTqRG6LR41ZChU1NXCbEVWXHNTc
 I7w4MfrpPnqD/VZAqCpM//C13n+/WyaSEN5SRuVbyo+IOte744g9B5OPCOTM536ORpYoz+vJEw7
 n1lWZoxLQQCIj8fADR5SrY+9+x1lEgbc4re6yBgyp/mpaUNKvBGe3Ii3dKunWWaUIE5CLl7QTqC
 whiQPR0qgbsHwOPSi9Yo4v7zoRDEnPIVeln0SveXSW9WDMgco1weA3ucA0Jvh3h+yyJ8+2G7iQG
 ZZ7U6XWmPwJQMkzEwu5T30aUG/YE8X75kLBR+7YDKd2SiyTZxueQRklqQBcfgf5BOw++3GN9aGA
 jk0aJW1hEacOzsCHJhW41P3z9W+rHyPAEVD3x9Z/aFY7vo6pl+PDxxQAE/SdTh28L5SHCSDezMv
 iyg6lZ392b9PeXacw6x14VyDQmpchOrthBF/MoJQvBiuQhuEsY=
X-Received: by 2002:a05:6000:2c0b:b0:486:e77c:ba4 with SMTP id
 ffacd0b85a97d-48702b00eddmr6889231f8f.22.1789459493717; 
 Tue, 15 Sep 2026 01:04:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ff86:16e:fede:9407?
 ([2a01:e0a:106d:1080:ff86:16e:fede:9407])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm32961569f8f.20.2026.09.15.01.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 01:04:53 -0700 (PDT)
Message-ID: <ad089a64-5708-4ad9-ae82-924cecb23f85@linaro.org>
Date: Tue, 15 Sep 2026 10:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/2] drm/msm/a6xx: use correct timestamp counter on
 A750 GPU
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
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
In-Reply-To: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
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

Hi Rob, Akhil,

On 9/9/26 15:07, Neil Armstrong wrote:
> The A750 uses a different counter register as used on the downstream
> driver:
> 
> static u64 gen7_9_0_read_alwayson(struct adreno_device *adreno_dev)
> {
> ...
> 	/* Always use the GMU AO counter when doing a AHB read */
> 	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_HI, &hi);
> 	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_LO, &lo);
> ...
> }
> 
> gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_LO		0x1f880
> gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_HI		0x1f881
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Fix swapped H/L registers in XML
> - Link to v1: https://patch.msgid.link/20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org

Gentle ping for review

Thanks,
Neil

> 
> ---
> Neil Armstrong (2):
>        drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
>        drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs
> 
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 12 +++++++++---
>   drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  2 ++
>   2 files changed, 11 insertions(+), 3 deletions(-)
> ---
> base-commit: df2908090cda368b01ff43709f51890076c56157
> change-id: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d
> 
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
> 

