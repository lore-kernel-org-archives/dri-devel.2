Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C39C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330AA10F308;
	Thu, 10 Sep 2026 06:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fxKabyFn";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF97110F309
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 06:57:42 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso4448168f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789023461; x=1789628261; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AcmCJbwx/4qEbhmcq6QO09FkYuh+y7eiZNBz/riiUA0=;
 b=fxKabyFnPJ6dyf/TkdkHi4m5QrJVf+wHHzDonOG1fzcijpECd08aI3IoGWlY+MEYZX
 KavsSdS8rFZHKr8gldhkdtOwIEg4FJBVEjirCWuKVwouS3bSFJhrgyI1Od0TKBQmLxvl
 R68dzBejmmjLRzXPnzs5Od7PhquKNFwfaph5254Re+efqprkR5feiEHDOKlYvF+LvZaR
 Z/l7jKc5rk2Lz5N4Tsayamxkv+nJLYzaQtWRoE3RIADQBsWGHS+eh4EyR/0sp/YNbfqZ
 7y/Xfzd28WYrA9DhgUvTpbrleg6MiLaLDP50+DtrqH3W20fis7lap+AcidOHeGuS2/b8
 0XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789023461; x=1789628261;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AcmCJbwx/4qEbhmcq6QO09FkYuh+y7eiZNBz/riiUA0=;
 b=G16T9mG0kLHf5zPJk6mUErenPdjENFrzLj29dN1r3umlxw/Bh0L6WFJPgU4vh35W7W
 J4HeY5U7Y7eregiDxvAC4wttIgizU7dIhZwfal59vwWlhVxdr7AEFDa98H3mH4FzJMTu
 g/qKe32mxp300fyyAdSqzsmzgtjDwLFtwhfAdk02j8H3oKLDZOp0MJpLjaGA74II5iVt
 2KYoWSS+x/3aweRRO8YorxN0Ph3MhhzrBFZKSMwzTKsa+Qs+l4CS5iNC1vsqvmG5dKP7
 zpv+QLrLpJSkCI66t85ZJODSAyMQ/1/5hnSXw2vGe+YaqymoV38pQG3LfrKg8OxyvO67
 CNCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0JTaopoJ8PjlQ9LrfEMywTva5b9pq8WMMaCSRVOd26deYxe8FiGFfEAM0Y8gEAhpk5NJjxNCshGg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgPt9XSfM6MnIYKfCs5WzfLqbrfcUVA0IE9hfFK7ztaAs3H1t2
 0nTIw6h5ZlqSJfirR4sX7SNps5/nB9RFhzhpyEqLavRV5+QwYik0sifiKc70n77jCKp7YnQHBnX
 v2A5g
X-Gm-Gg: AYBFou1NAnXry+D/y+Zrb+vWSBwHIXMqJlcwNeU8X8Wxr38GNGjnpACE2wrTYtKsbhP
 yIWn7CBbNw6YV5wg6Y9kfPBptSaMvby8QtZwe8EenxZRGzXAqqtwrQOvuE872DVAp/XeO3DT0IS
 5D4D1NFDlw0bq3+1p4tf9XE82rp+vB6ABYgQj5oRPa/6nE6mTsyrZmvYkNJE32sS4GeiQ/BAziE
 4sOKKBL/Fk8LO75t9EvadocqObOdBo2cKdp66LONTRZQQ94dv/7emn1rh1m8/zWgze/PwRG/NRH
 8lHDKM+DmaLwrJYw7WmNngvZ02qhMY+lLHoWvXPB2V+h3Xg6ZKTfn0tCU1WVLXdqtrs4XJVZpX4
 JijPvRpdQ6+UHfwFiIO5yTY00+R8z7eaICaXrst3PCUCiKwSLAP0bYzuzo+dbGPdiIJZKJjU7N+
 pFVUTkqohkWwtwNsQN506TMmUyGeLrH1Rfxh/q8TUa32uvxfG492cUMtSp5mKlnkptM8wD0st6b
 fh67z1toZOvQVMyaGXgoUT4sTdgzx4Y+geNYHMFsPeiMQ8yr9awYg==
X-Received: by 2002:a05:6000:2307:b0:485:ac96:724b with SMTP id
 ffacd0b85a97d-485ac967324mr11008750f8f.7.1789023461206; 
 Wed, 09 Sep 2026 23:57:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3caf:d840:c911:29a9?
 ([2a01:e0a:106d:1080:3caf:d840:c911:29a9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883acd33sm49605447f8f.18.2026.09.09.23.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 23:57:38 -0700 (PDT)
Message-ID: <67ba8a92-beb2-4b72-a7fd-4ad88723dd4e@linaro.org>
Date: Thu, 10 Sep 2026 08:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
 <33be46a9-207d-4f0d-b3e8-18adb8197a57@oss.qualcomm.com>
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
In-Reply-To: <33be46a9-207d-4f0d-b3e8-18adb8197a57@oss.qualcomm.com>
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

On 9/9/26 20:31, Akhil P Oommen wrote:
> 
> 
> On 9/8/2026 6:54 PM, Neil Armstrong wrote:
>> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
>> register on A6xx and other A7xx GPUs, use it when running a A750 GPU.
> 
> Do you see any difference in behavior? Both counters are synchronized.

GMU_ALWAYS_ON_COUNTER_H/L returns 0 on SM8650

Neil

> 
> -Akhil.
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index f9de9329dee3..081e79ea4652 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
>>   	u64 count_hi, count_lo, temp;
>>   
>>   	do {
>> -		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
>> -		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
>> -		temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
>> +		if (adreno_is_a750_family(adreno_gpu)) {
>> +			count_hi = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
>> +			count_lo = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_L);
>> +			temp = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
>> +		} else {
>> +			count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
>> +			count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
>> +			temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
>> +		}
>>   	} while (unlikely(count_hi != temp));
>>   
>>   	return (count_hi << 32) | count_lo;
>>
> 

