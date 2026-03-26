Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF50C10AB80C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DD110EC16;
	Thu, 26 Mar 2026 19:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CFHNKyqk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzTy0Kl+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B6110EAEF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:13:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9gf82451413
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I8pRdQFOK7i3p0sQMgJhiV+GCt2MC+4BNvCTFNypBOI=; b=CFHNKyqkP/dNZD0J
 g50OFbVBMt06oP5e//g9SbH6Vfo22br8uvtblaB/5B2w0bd9VVekMJVWCv7N77r4
 dKUkY0bCdCb0zBLaAMgo8tIv+dCgukMe+Je8px6HWxakvTOEhb4spkJnAxCC/FkE
 LJG05GorAHChuNiKWzpW+9AwpFVna6WprFnwhLj4sDRfGrxTAb5mzc2vU9R24EJe
 y1l7ImFgY+aTPdgoyVTtDYxEyU/391qnfF1XLEpBE0dG0zt38r1loX8x3FleQGkB
 X4N8yvd04sJo2z9wVVMmmV1DrtNg7zWxwO5wpaL2SxnJZ7ECCObJ25Xwk2NAjkex
 5hikMg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q1t48bq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:13:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a90510a6d1so13195115ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774552428; x=1775157228;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I8pRdQFOK7i3p0sQMgJhiV+GCt2MC+4BNvCTFNypBOI=;
 b=bzTy0Kl+MRM1968wtXJYQ1tiaHJ1DHiWfQb5m32ijyBNJCqWeHAO/V28pibQlVI8ty
 ld2E4nybxtI9KrNVuG8m/2qZDXae8VBeZMAX8xVPc3YZEx73SYxzxRPkuL7tdF7lqRC1
 w4+fseYZFO+lXqCib7cPUt5xJfQ0mSN+TQ1MO5BxhV/HOe6dGiZ2RAP4AonyHn+TS09I
 RnV4SbRTJHI4I+SQJ4N/mOaSyl4RBerTY/b6/dFLR6x29ig5NUPUArErj92EiBC7OGye
 fp5PA3XIe1K+B5brE5DJJjceWSahKcK6iu9aNdzyHzdfDoHTFdmzvb1lJqn6bM6xE/c5
 uT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774552428; x=1775157228;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I8pRdQFOK7i3p0sQMgJhiV+GCt2MC+4BNvCTFNypBOI=;
 b=D7fqkEoht5KxO9U+ljMu7sQWEXu6S8lODQKBMDFKFI9xARq/T0YLADvd7KLN606ymy
 fAOfg96Jv7+tXIClYXbq3KXhi5boNSQE9fmizwH1uLw8+sJfuB9HZm4hkc8mCHcudBbG
 3E9FWE4gFjKIEtWv9ig9uo/EejrbLanZ13Jt/r8Meiyxab1rYrxjNNUhNtz2XN3FZ8tb
 7W57bjDUy0dDuTc7tHGOkgVwKDKmZ/dxrDEETVecVHXwU93b+0dakpRrwav9xBjWh1sb
 gRYqy0qZMqBTu/j6u+sRxbSH7Ud/V3kLo0oiQ9LWRMVJ16CYuu6nSMqR65MzTJuN8n9P
 VtDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8zxUEsjUIFZqUTiggjhkQZVb3wYTN39fbzHSOxr+DDjPRzzT+p84dgPoHZBujMx8bUfzunV2r7Q0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVd5FkQAQO1zbS9J622ZvRj45V7tYNVVeZxfglCNdZxo7uK8/L
 3VramX1+DiFlu1mm4ggrbdQk4ejc28y8K76in/TuXdSGwZ1VAIk0LjND52lse1JtOY6CoQ2nJrL
 gzPuf60ChiE5mpwYpEcMTMN61CRTf5S6m7xQeeeD1UzsQvatOV+nkb3BcMiC2O5IX9y33ZNY=
X-Gm-Gg: ATEYQzxcF456veY63GVPFfvs3jAAIk+RQXUK90aVpf6tyggghBvRh1Zx+NvlXu3P379
 1s5xT6SW7cSx+2c2yxmxEczC/DlB8tsCz0iJ87RA+1R4oEEPi8NQcLnproPGxdDXPcLSN+EXNds
 ASahCjBAMOldz8w3ehuZ2hiBY+w2nAEh6+2hyIR8+iYe6qa89QTe66RLge4ngdgkO2null2ZXuz
 o2IbgA2wySEhbMpO1yheN+/nquNg0ZWSl+uWEZQQnQdHpprCfCvUkWkab163T9GQ57TwPGypCuF
 K1eD2Kn+BIT0/TiWfXziWegMvaZX7YjEiBDio7FlxK9E5dOY8hL0VYiX6NOaHcZAmekxyYY7+De
 uy+lkwVPPERq7AChrxYE7/nrfIkYd/ARbRySMOOMsDlhT
X-Received: by 2002:a17:902:e94c:b0:2b0:5a4c:726f with SMTP id
 d9443c01a7336-2b0c48e9a76mr28339855ad.15.1774552427556; 
 Thu, 26 Mar 2026 12:13:47 -0700 (PDT)
X-Received: by 2002:a17:902:e94c:b0:2b0:5a4c:726f with SMTP id
 d9443c01a7336-2b0c48e9a76mr28339615ad.15.1774552427007; 
 Thu, 26 Mar 2026 12:13:47 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc8f3b98sm34857235ad.70.2026.03.26.12.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 12:13:46 -0700 (PDT)
Message-ID: <281e5ea3-ae44-4939-b800-face97ac2d6e@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 00:43:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] drm/msm/a6xx: Add SKU detection support for X2-85
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
 <x6b2miikgofuhfnrgnuf47mrrcbz2fkvht25dilo33teafcsax@v5f5j2g2wuxp>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <x6b2miikgofuhfnrgnuf47mrrcbz2fkvht25dilo33teafcsax@v5f5j2g2wuxp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e7cLiKp/ c=1 sm=1 tr=0 ts=69c5856c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pFeaMtMCVmKtNNfMW7wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: pju54EZoBV3IT6M5leRbfxuEjurTHgjV
X-Proofpoint-ORIG-GUID: pju54EZoBV3IT6M5leRbfxuEjurTHgjV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzOCBTYWx0ZWRfX1E5QfxzelWPr
 MwiavbTmqHCTZIkZAOEBJa8454zJr/DFKjN5EWtqpGPPVW2P3ofRTJyeyhOgramuObthIYf3Zjg
 A+xkqiK5mmBPjJh0emiF/zxYHCyoDTm1pYt2bD4/wFxV4n6QvPboXcVkH69PIo8l7eXedpEy1Xk
 zWftGcrGpoVlXoCJJsYf87KwyAAk5YZg17BCV1F+pGl0ISrlIrtCxAAXOvaD3YZjhJkU0OdRznX
 gDXqEgpGqE4ZdzBeb4u8hejhMIO96C0NHw7e24MTWNrcl2IzKL/CRxyFdVxzs7++lYxVQTrom5o
 BlKksnpC1J2DyL/QgOCmwjKE24T0wMlcVjZ8ZVe6vOy6RiaUY+kDLxzDJdfpxQYA91GPFMCwmej
 5fVP5Urr5Iznt0MgyANyP7asS1Li7JidNa558t40LgFaSZpdTx9CB8wK4zoYjA7VvWmZrmy1UvI
 SdeWCaJDzB5N7Et8rug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260138
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

On 3/24/2026 3:04 AM, Dmitry Baryshkov wrote:
> On Tue, Mar 24, 2026 at 01:42:24AM +0530, Akhil P Oommen wrote:
>> Adreno X2-85 series present in Glymur chipset supports a new mechanism
>> for SKU detection. A new CX_MISC register exposes the combined (or
>> final) speedbin value from both HW fuse register and the Soft Fuse
>> register.
>>
>> Implement this new SKU detection along with a new quirk to identify the
>> GPUs that has SOFT SKU support. Also, enable this quirk for Adreno X2-85
> 
> SOFT SKU -> Soft fuse?
> 
>> and add its SKU table to the catalog.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  6 ++++
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  9 +++++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 41 ++++++++++++++++++++++-----
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ----
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  1 +
>>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  4 +++
>>  6 files changed, 53 insertions(+), 13 deletions(-)
>>
>> @@ -1213,10 +1212,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>  			devm_pm_opp_set_clkname(dev, "core");
>>  	}
>>  
>> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
>> -		speedbin = 0xffff;
>> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
>> -
> 
> You have removed this from the generic code and then added it to a5xx
> and a6xx+. Wouldn't this cause a change on a2xx - a4xx?

In the the devicetree, only a5x and a6x chipsets are users of the
speed_bin cells. Also, I believe Mesa handles speedbin=0 correctly for
A4x and older chipsets. So we can ignore those.

-Akhil.

> 
>>  	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
>>  			ADRENO_CHIPID_ARGS(config->chip_id));
>>  	if (!gpu_name)
> 

