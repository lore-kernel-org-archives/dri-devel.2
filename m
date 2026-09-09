Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4437C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D580910F055;
	Wed,  9 Sep 2026 09:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AR9rHd/Q";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B29A10F055
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:32:20 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-482dbe4d247so3127211f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788946338; x=1789551138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qtG69rbhI5dj5FSdbtZU04DqnJ+za1Yd8VMlYpZeS9Q=;
 b=AR9rHd/QBMdVMgGsUQtZKF6ux5EpF92L+UD3CBLnoqmx3SomrMf2WPAMUsO5dgeJry
 TnhztM36ZMZcmJFqW/+k8t9BDdq7lsxUTWXd/T6biZ48xlXY017ut+IAX19QCjm4n+dj
 3AZqvewlPRT54kVuCNpFgx33zVNeS06KzGoLBh4TTvnhHNMZBphujsITYxvQJJ+zs3/C
 510arYwt9xpGAV0zk5IBSeHUHHdlPiKCaKcY54b9lhX0EV0QntSM77DplzvCncRSphls
 Oc5xWa+0V1mwdLva8zOrmbFPOxn4K6vv9C9dcNf6lf0iv4jZDceX7QN7u46EjDcayxFe
 C4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788946338; x=1789551138;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qtG69rbhI5dj5FSdbtZU04DqnJ+za1Yd8VMlYpZeS9Q=;
 b=bJIf/AuEhzoyJdKA/9sCfdBqwG+FCdAWvM+sjFspm45ZWmlspMcnw+1MrdEk4S+7XT
 W6JAIgPKnjS3PJYFwg2SJmauPpa9Bn6Rud/P3miaOBcXcATtiY7jUg238n3uhHUszScO
 ggkIojmdiQwmN7o6iv6oETFhcMoKLSXUAdPuYhcUw0xviEWhBOjDAFCwyuf8MV8wB8Sg
 1dApsrKEMRkE6fhdwu0D/Oht/gqt1TekSaHJr6dlnY6XxxDdUEX0WukDed5XOs0Z3R70
 WkLw+Ymu/cgWpioRdvc0ywJR53+3nYjBGjkA8TcSgTeyjwQEne3epV6K06bf+Rvv09eO
 OVdA==
X-Forwarded-Encrypted: i=1;
 AKwUvByIhE0SD9WF1MfM5hovr35O4FXFhJo0orswTsKZJ2baI/XD0fEMyFPDzvsbgiedFqUZ/CN/X5fB7rk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nzu5iK56eA8R/mSiloqQgu5KJIBOSKlh32DOP/GGr5pjfdBEdm
 lvb4s012Dr1wYpkahOx/H5rkgYB0+A5DvWH58dtNowQA6VNfImmFMbjOwL/wRgVJ9b4=
X-Gm-Gg: AYBFou3Zoe6YsB4oQ41nWF3QO9QSSsP3reN4qyjY/mVCLzBl3iSzljf5SOp3eYZ+xOV
 I8Ln9yMsCQczmrphY8C8Sq2eJJ6iqCPNHhyE+87qVFehCoM3K+W1y11ga2VVDao+nGfRhAIm66v
 X5yFxJ4G5sZTzMYGmyaCz3GwteldFImSLk/gUsA46pKW+iYrSfzgya5mDR/2JeH8dimwXu3FB/U
 tvOt7QgeuOS+RFTFwpj5ZY5Ps5kGYF2I0ivGPiFr63V5ePcKup+KvZhDK03dfqnRPbe4k1UkhQP
 lXZOZi0hHwpg8APQAw7jMwTpnjGGrLW+CJYOP5/yqTg9mLUOO7/WLgdNejWt6D13OTmSdJjB+RS
 cLdHOAwoVbXTnM6LCQtgoOzxWOqkJ5o1nQwJUxg8z/HSLUWqm9l55goSy/t+iidn69DonNfp19M
 RvdvP1w/U3oCRvxbWOz2XR4wW1m19Pi+hOC97QiZPXJ1SDDZ4nlLOwNSXZpJsx7NvLYIU0Iqg5p
 ZvDLJO7kgWWGD/wjAeA+F8X+v59EqskA54QF1/GzqimdBEzSmVEp9o2Sj02nLf+eg==
X-Received: by 2002:a05:600c:4712:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49cf8248cd3mr570725515e9.13.1788946337959; 
 Wed, 09 Sep 2026 02:32:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:14f1:e0b5:e1a0:a97c?
 ([2a01:e0a:106d:1080:14f1:e0b5:e1a0:a97c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75cd8d0sm431347165e9.2.2026.09.09.02.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 02:32:15 -0700 (PDT)
Message-ID: <5bd35343-1bd9-43c6-90f9-d57d67e6d416@linaro.org>
Date: Wed, 9 Sep 2026 11:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
 <47f0399d-bb31-48bc-b69d-4abd445727b4@oss.qualcomm.com>
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
In-Reply-To: <47f0399d-bb31-48bc-b69d-4abd445727b4@oss.qualcomm.com>
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

On 9/9/26 11:06, Konrad Dybcio wrote:
> On 9/8/26 3:24 PM, Neil Armstrong wrote:
>> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
>> register on A6xx and other A7xx GPUs, use it when running a A750 GPU.
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
> 
> KGSL apparently *writes* the system time to these registers, is that
> an idiosyncrasy regarding how the vendor userland drivers then use
> this counter?

This is a GMU counter, no sure why & how KGSL or freedreno would write anything to it...

> 
> Konrad
> 
> P.S. looks like a8xx also has this counter
> 

