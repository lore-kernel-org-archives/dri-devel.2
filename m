Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6D1C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD1710E029;
	Mon, 21 Sep 2026 09:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ui84T7/r";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5357E10E029
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:53:27 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso2166771f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789984406; x=1790589206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HGGQwgupkqrpkHOpj6oDdQyUFG/UOtLeaAkYO1fiXP8=;
 b=Ui84T7/rXaWZ5hT1b4nnYsPHWgWSNsP7J2a4zILKZLkOmKW2az0frbal4HnDNym9Ul
 JcGLQseQ4iyGWAPhN5oeoeFpQnvAVdm5jxlH+T4QvQfcgO2K9rHuEgxcdWwBawsXeq8V
 YUjTi674CKt6pv/eoH3cuGEdXC3fCqa/CKYopRl1PnhzssosqDLkReMp7OwgnZP5Ba0i
 QD4hq6TJZ1LSqy+3ytHWTQp2PCDN/n/WP1S8Y6x7xM5FZLr7R4cD/8A9kya8N9Te730S
 ZpT7Xdvb4OIaRSsJCG4LwkY3+0ydhePW/H1c8U6z0HufIjl7tIMJ2VUGrBiQwMitTWKC
 349w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789984406; x=1790589206;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HGGQwgupkqrpkHOpj6oDdQyUFG/UOtLeaAkYO1fiXP8=;
 b=00of++2G5MDxdfECW/03k8BAc2VV4nOtv5Rm5YM5Rf4wuMvGNorvQPXSoIexCIcq5b
 77bVnMd1uGTCm5NT//5fDJ4nsqw86VejXgF5u5nEVMQ71rzXAoxXCnOXZVBxtcrxhaEy
 C/w8tcNat1wP9YzVLyVNBXl7Ga7qn18ojDyHXQeb4Qvmo2J5RILrHhoDirDalEJD8wAQ
 IRIcOOuRgT4m0C9m9a7UmW+mSWjea11fSYacaKn66yDH19Uq5FQibzEefYzlCVs4oIOJ
 hYOlROVYVAUM0CLcn53TLijmVOGsdm244wfC6sOGl+hZXx377WIwrtlHZ3dw6S8RPezV
 lB4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNwHu/64b2v3iE/k9Ddyjd24iFIdPxB7YMEqzIPnjhn+rBjINXEECq5TdTt9MJ4RbhGAG32PhKiKM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++khAbFKPq9VNBhOXiyayNJGMGOsY/DILv/f+aZgIZG17YEJT9nj
 682KWv0vQpj7n2LcZem+pTLDowGmjuX/lNLWuZnmTAuzsr1rNG9lgttXJmWkuEaoeHY=
X-Gm-Gg: AYBFou0/dKm13+07wo5vE8zNoqi3H4BdeFP/rcthcBz3KG1jthbIO920v1diUa6pKmY
 B3fq3CjVB/gV9Qtc1Oa2yt8Wtzl+2VI1hatm0hB7u6KhrqRmyklqjStLokhLMxjSUO6rFldRMvk
 dnkfuXZMpzL2SlY0pz/BM9ss5Ke5QlT9TDs1b06G8MGixqHbzA3YUiXeTAmDpcVTLX2uEVj55ro
 joVbzrpHUny6ad8Aj1lsCw/0h60nqY3QJD7GvbUCbRE/aFXpcN7EHJUmgz5cqW9BnitPO/n9fHf
 glS4jgfkN6iulD3fNsazNtg36Ox+A+1QYZ/ojIIPCDN9zyZcrNb3gBF3cyW9aYBxIbzB4kczTwm
 uEMdQ6GSHr216FvYY7rmKmUmzcfgRe4GfrqHybs3+XyTLzqpihIb3KvIlcAvM5Kd4dY9PZ1ijpd
 S6VyuIF4Inf7JfeI4o8hBTg1B/Q5KME1g85BEaQGuqE9vPXZ/x6DsAswLB7bj91A74D8uiMS2wA
 2rYSMuA9wI4wXaqVw+tuIo6If7ZAujl1eflXQED1ud7IZy+sP7ABS6On8CG/wa8
X-Received: by 2002:a05:6000:18a9:b0:486:fe41:804d with SMTP id
 ffacd0b85a97d-4871e3b6a68mr14522308f8f.47.1789984405602; 
 Mon, 21 Sep 2026 02:53:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ddd5:3880:40aa:e4f9?
 ([2a01:e0a:106d:1080:ddd5:3880:40aa:e4f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872459a5d2sm19600201f8f.31.2026.09.21.02.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:53:25 -0700 (PDT)
Message-ID: <5ce1688b-e903-4503-85a7-cc0432aa6103@linaro.org>
Date: Mon, 21 Sep 2026 11:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/2] drm/msm/a6xx: use correct timestamp counter on
 A750 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
 <7128505e-c8c9-4d00-96f9-2576ea2a0fda@oss.qualcomm.com>
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
In-Reply-To: <7128505e-c8c9-4d00-96f9-2576ea2a0fda@oss.qualcomm.com>
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

On 9/15/26 23:20, Akhil P Oommen wrote:
> 
> 
> On 9/9/2026 6:37 PM, Neil Armstrong wrote:
>> The A750 uses a different counter register as used on the downstream
>> driver:
>>
>> static u64 gen7_9_0_read_alwayson(struct adreno_device *adreno_dev)
>> {
>> ...
>> 	/* Always use the GMU AO counter when doing a AHB read */
>> 	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_HI, &hi);
>> 	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_LO, &lo);
>> ...
>> }
>>
>> gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_LO		0x1f880
>> gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_HI		0x1f881
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> This is correct. There was a register shuffling in the gmu_cx block in a750 and another shuffling later in gen8 family.
> 
> It is a good idea to review other GMU_CX* register offsets with KGSL. Also, please consider including a fixes tag.

OK thanks,
Neil

> 
> -Akhil.
> 
> 
>> ---
>> Changes in v2:
>> - Fix swapped H/L registers in XML
>> - Link to v1: https://patch.msgid.link/20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org
>>
>> ---
>> Neil Armstrong (2):
>>        drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
>>        drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs
>>
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 12 +++++++++---
>>   drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  2 ++
>>   2 files changed, 11 insertions(+), 3 deletions(-)
>> ---
>> base-commit: df2908090cda368b01ff43709f51890076c56157
>> change-id: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d
>>
>> Best regards,
>> --
>> Neil Armstrong <neil.armstrong@linaro.org>
> 

