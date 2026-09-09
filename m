Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06628C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA5E10E1C9;
	Wed,  9 Sep 2026 14:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UUYZ4a3G";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE78610E1C9
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 14:29:48 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so47370375e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788964187; x=1789568987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C32jr23wKiKZjOBE83+EG34E/MZNvRUFhr+gw4T8scA=;
 b=UUYZ4a3GeINaO0G8a5k7Czl8/PwGymHM9eEFEEpCnk2Gu/ffMCIksACyq/6VfQnP+H
 tSd/7uMnuYPu5FK0ssj9mdUAK84lCS4HwpLwD4WWuHyUJL29ZT1O8ROmyg+OV4pyQOFv
 mB5oliUVZHFyh70/9Jwn8q/ftsRNb5Ft3o7xkqeHUFxYdm0KPC/9EDbovoQuV+/WO6i7
 NjtJ82C3S3XDEgoMvrTdIFzDK94Td30xkOspR0sfAJAWavCwUv3/QiuKEwMaQg5N+Umy
 ipoTlMbER7ZIoa+PwkVn1zuqvCHn7iS1UP/WzudV6K5IGCq3oOOOcgtOhgSY0n9AizVc
 GmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788964187; x=1789568987;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C32jr23wKiKZjOBE83+EG34E/MZNvRUFhr+gw4T8scA=;
 b=gU2hlyHIOfzxm7sf0IDYEgynNMWnOeGaSB4H598UeqOFjNDwzqNd7H4JEMiuDyZstY
 QMus2HwnompEkyGe8ew+D80rnh4GyOKe0xD2hBZkflE5iDd2bL2+gQYOg8o40ANNpgj7
 xnw1ugv2+njCKJHQSXDo2XKpagTClHMUUObYovQknRPuxPzLQ6wUvYAl9vRXN5ZVN2/0
 +6ohMoXWKkzJQUSr0ivUHHZpSx+s4M3dVfopB5pwz063kqsF6jXZDmx/KQqcnK50U06x
 MOzAqHxF3FrXKTqz0IrHgf/XoF12uYiQnSMczTBK1GO/Vh7mgMEKDYfrhhqzU3BtwhNn
 Jf0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPgQhjGrXT7JgiWJ5oTbb5pC7UyQFgMRyzNhqdesiWJQ1gqsNDeVsV0ldzOsy28sCzWzcf8jd952I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lChkWp9r9koY4EsWeDN/qTu78JONjqlTLLKWU3fWvN+UQ1ExL+
 SSoGpKgW0afFsMeywRi6sSbURsTmfUQwylrP10BkX8KgN+WssdMtoIH+Nu5ZWFLIXTM=
X-Gm-Gg: AYBFou0fQHjuocbtKdTan4/kNfbBuYBlsuKZyH47TG20qmJ8zgmzXdMI6pwWvCV9XmK
 dp7vhtnNaliWWy9dXENRCfSYsrnMbPJCa4egtixejmhP1YIyZZI3Lwzyl1LYEmbE09471tpnelU
 h3gJJEbXTeShG6gQ0sB6aZz5AulV0A2F7nmYgoPvQaLQZvzX2sLazYBks+K32GCBAi7ffvPR/n4
 9wAG/cHoUxMcuzi4JLutFK6jIMxXvBVV23KedJKNF1tZySSHT10TRRobTJz7CeVTG1CpcCBt63K
 DBcuAOmWof9GmkWQrEqSrdQp05ow2RopGdDOpSKNm5wqWE6DqT1vcxdHB4p4X7h/LtWoXGpVyQO
 nIpKMsH7XaV1CUwFk5k8MU+fPAEApb/yBTp4fq6mleIfMzlvp73B3jPWf+yVVKU3zHJ4h8Drajp
 OiFVqDzBhNxQmonHrPi4pajwnu/9NBYGW36fEDeagaZaWF0nBZqN+qrrStp+c0W0MzvIF4scGsK
 ydcnjYq1gnfGtL6LRuL1pKZd1rdkZQMyZmAgVZfJ/i/DDg4K7r3cg==
X-Received: by 2002:a05:600d:640e:20b0:49c:fc6e:a3e1 with SMTP id
 5b1f17b1804b1-49cfc6ea77dmr239864175e9.32.1788964186838; 
 Wed, 09 Sep 2026 07:29:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:14f1:e0b5:e1a0:a97c?
 ([2a01:e0a:106d:1080:14f1:e0b5:e1a0:a97c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm481191115e9.0.2026.09.09.07.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 07:29:46 -0700 (PDT)
Message-ID: <6763c530-ffb6-4480-9a56-2594bfe8a010@linaro.org>
Date: Wed, 9 Sep 2026 16:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
 <47f0399d-bb31-48bc-b69d-4abd445727b4@oss.qualcomm.com>
 <5bd35343-1bd9-43c6-90f9-d57d67e6d416@linaro.org>
 <CACu1E7Fs-=sKJ07Pcb_7BCTFaXLCMVGEu=yQ6+hfG3Vjc2Y_RQ@mail.gmail.com>
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
In-Reply-To: <CACu1E7Fs-=sKJ07Pcb_7BCTFaXLCMVGEu=yQ6+hfG3Vjc2Y_RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/9/26 15:24, Connor Abbott wrote:
> On Wed, Sep 9, 2026 at 5:32 AM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 9/9/26 11:06, Konrad Dybcio wrote:
>>> On 9/8/26 3:24 PM, Neil Armstrong wrote:
>>>> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
>>>> register on A6xx and other A7xx GPUs, use it when running a A750 GPU.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> index f9de9329dee3..081e79ea4652 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
>>>>       u64 count_hi, count_lo, temp;
>>>>
>>>>       do {
>>>> -            count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
>>>> -            count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
>>>> -            temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
>>>> +            if (adreno_is_a750_family(adreno_gpu)) {
>>>> +                    count_hi = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
>>>> +                    count_lo = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_L);
>>>> +                    temp = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
>>>
>>> KGSL apparently *writes* the system time to these registers, is that
>>> an idiosyncrasy regarding how the vendor userland drivers then use
>>> this counter?
>>
>> This is a GMU counter, no sure why & how KGSL or freedreno would write anything to it...
> 
> It is writeable. This is part of implementing
> VK_KHR_calibrated_timestamps. The idea is that when the GPU suspends
> and resumes, we keep track of how many ticks it would've taken and
> then pretend to advance the counter by writing the CX counter (after
> powering on CX but before powering on GX which initializes the normal
> GMU counter).
> 
> Note that VK_KHR_calibrated_timestamps worked initially on turnip but
> the tests started failing with v6.19. I haven't bisected yet but my
> guess is CX was never actually collapsing for whatever reason and we
> made it collapse hence breaking the tests. So we probably do need
> this.

OK thanks for the detail! Today it's only used for perfetto, but still
on A750 a different register is used for this purpose.

Neil

> 
> Connor
> 
>>
>>>
>>> Konrad
>>>
>>> P.S. looks like a8xx also has this counter
>>>
>>

