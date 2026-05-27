Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F6FCD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDCA10E9FE;
	Wed, 27 May 2026 20:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fengZZNl";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F0A10E9FE
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:50:28 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8367df48711so5309427b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779915028; x=1780519828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZgmT2PCf8Y8jhcdcmTfOPLMXO+NaMPZbn+px8TLtHg8=;
 b=fengZZNltL6WGjWH7rYpGffaAB4m8cztezf/CfmzUf7ZiHv3wY9ILH1SX9eORBCvTa
 c/0+unrEQj3q3LBx3qPCUHQeRKliMxEUQ8qcXCCsSuJTeMk+oKDjipM2EVY5WxsD0zkU
 FskgC7UtjmAPDVjQKMBcMl4ihpDfKz15dWrEIa4x27Y8/05RDHn54hlXPw+RiGSz0n2n
 SbRUhXM+i0K6fq2pANKqXL6cixpllTxCSwRMUy8PTvfP0rBRN402v0FPAxSrcfhwPzX8
 n00QUwXVsFPgmkllLjXDjgM1nh/szKRrCakInM72NxrsYLXJxgRvP+bKYI1d2iG7d3q0
 u8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779915028; x=1780519828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZgmT2PCf8Y8jhcdcmTfOPLMXO+NaMPZbn+px8TLtHg8=;
 b=ovacwuPc40C3TWSvcBJ1Oip4qFQXcu8dFCmHyafip7SmgQUClpar28lrRbqUEilwEn
 IgIcKPu4YTDqZuNgZYcCx/SYtqAo9qfJEFeCvmS80x50SXwKIEaMGBWgxiB8oOy2GZCr
 QrhokBYDsDOFXgsui6ZdlUAcpqwGtLBQsN1MqUEVrVCCBIephomgwQnqkH274UWS5yb8
 wx6+xN//tUsM0cfSbLtp+4gWcNM/f7o+Jy4dAp0t1+xG01GcLBXflja9ofSL/uqMX+zu
 hUBZH/PqS+fl5F1M5Ny3pdIXhv5gKUKJphrjN2ifHTC3iU0RuO2rA649bk0bar0eNY3k
 Zkqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MkZGXgXUC3vVBZQwBaQFIl3IEj897h8Cf/HjOupA/lFPMUjCYiG0OBGOQvd8WdAEC4zh7NaJTAyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1ar57R7IrEA3m/nENMTEVp5+tY4ORHJDDMsFZArWR2jAWRC4l
 Avqa5VWBohvf5d9zDgUFkv+7UD9j0+dyzwOMURgZGNKa2EuIhoa4sMtt
X-Gm-Gg: Acq92OHFiTKcmR/rXpmabOpt4aQKGPJSgDCIOTg+Dfp+3qDj0ct9lGSJ/Rb7LMQQFHg
 hkezXJpGqIpI3xbA/i8Bv5sbHzyVYebe3plExhjdGVdacIbZWKjEk1+OXE+xECxhUdzdwwM1BE7
 aLk0hUluU1KQCM8gBUHOSP7G8BMVRqLxKSg85QtedfP1gYxdMQIrHE2AEkItOIMLw5ypMIfFco+
 //wscU3FJFmb44mipvhk4CTEb0EpTqbq8+O4Mhc9rEDGgX2ViAKdoQun25M3kn6RYGGuTvB8xDR
 malEOQQ5s8RoMgEcySkq21W/kafBtFSRaQ3HSFY/l5D06NaFbbq3oF6KwCUeo5RYBNOjhSGt/gN
 tDRC/Zpj8CM4kndHTIEroyfeWIN9qeIaZiqctjZa/GwBe0tWbfNyyNgoo104JRcvE0dSZgkUwal
 d2kNfdIgpayObocC27Hk3wGeTXm/f0L62QUf/ULAqnno0Sn3o=
X-Received: by 2002:a05:6a00:f03:b0:82a:6f69:7f72 with SMTP id
 d2e1a72fcca58-8415f588372mr23987407b3a.47.1779915028339; 
 Wed, 27 May 2026 13:50:28 -0700 (PDT)
Received: from [172.18.227.108] ([219.88.198.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d6eae464sm4078935b3a.20.2026.05.27.13.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 13:50:27 -0700 (PDT)
Message-ID: <a727e1e9-777d-4372-a087-85a721f174ba@gmail.com>
Date: Thu, 28 May 2026 08:50:20 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/msm/dp: Limit voltage swing level to 2 for RA620
 bridge
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-4-graham.oconnor@gmail.com>
 <7e435e8c-ba0e-453a-b95c-450446dfc0ff@oss.qualcomm.com>
Content-Language: en-GB, en-US
From: Gekko <graham.oconnor@gmail.com>
In-Reply-To: <7e435e8c-ba0e-453a-b95c-450446dfc0ff@oss.qualcomm.com>
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

Hi Konrad

I completely agree.

This patch is a temporary hardware workaround for RA620 bridge support 
and should not have been submitted. Please disregard.

Graham

On 22/05/2026 21:28, Konrad Dybcio wrote:
> On 5/22/26 8:06 AM, Graham O'Connor wrote:
>> The RA620 DP-to-HDMI bridge used on the Radxa Dragon Q6A does not
>> acknowledge DP link training at voltage swing level 3. The bridge
>> requests maximum voltage swing but never completes link training
>> when the driver attempts level 3, causing HDMI output to fail.
>>
>> Cap DP_TRAIN_LEVEL_MAX at 2 to match the behaviour of the vendor
>> kernel, where link training completes successfully at level 2.
>> This allows the RA620 bridge to establish a stable HDMI connection.
>>
>> Tested on Radxa Dragon Q6A (QCS6490) with RA620 DP-to-HDMI bridge
>>
>> Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_link.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
>> index 76125e9c0..ff0d8e99d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_link.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_link.h
>> @@ -24,7 +24,7 @@ struct msm_dp_link_info {
>>   	unsigned long capabilities;
>>   };
>>   
>> -#define DP_TRAIN_LEVEL_MAX	3
>> +#define DP_TRAIN_LEVEL_MAX	2
> 
> You're limiting this value for *all* devices featuring a Qualcomm
> SoC with a DP controller. Instead, if this is really an issue that
> results from the bridge's capabilities (which could potentially only
> be a symptom, not the cause), this should be somehow limited to the
> specific bridge itself
> 
> Konrad

