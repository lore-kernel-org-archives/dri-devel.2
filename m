Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0488FCD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E3010E9C0;
	Wed, 27 May 2026 20:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ldz+jpSO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kXbNDVSd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793CC10E9BF
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:07:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RGbCDv2217200
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NYNjxQcCSvYU6+1FueqgSrFzwpQgaet5EeASApuehzI=; b=Ldz+jpSOyS1wu2Bc
 ueaZniAnFBvtHLlYfTZnUavp9F7iUfpZma3GFIItIaC5tWH1hGzZcyFCnk5FVM/v
 wTbvhcDtRfmC59Ed6w5sxw4onlcHcyK9qXS8xYYhQ0OG88rCmHiUyWhbjXBP6H1w
 2skDJG1miRbjPWosmBT68MDryGa+KTGDeivqN3qcm1hM+h2XwFk8VjUbqOd+vEXC
 Bjn6Gfbso4QE6+lyC3T1sWOu4k+IWtzJdHfkWUlKiNjerLYno6BkZdHaFDt+StLI
 M4tMOi9mQZ41BF8fcU6QotU73dJlojN3l2XoBV9+hyRwPJYdp4RsIm45eEsKo5E7
 1UhhtQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee49s8sbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:07:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba15e384c7so85103595ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779912437; x=1780517237;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NYNjxQcCSvYU6+1FueqgSrFzwpQgaet5EeASApuehzI=;
 b=kXbNDVSdauz5mLvgh85tUcjgxwiFxLrrw1Qqz2owEAJJRbUThw42K58toLftYNS3sK
 eNeyv8ZPVtKX1A8dQXgIs6XoL4Mdx6ztjQTx0pafqNWlFZJhbJx13PR4e9DqRSRQWhwr
 JFAh6In/M5+CN0varQchBnz5jrCEBfG8y2gt+T6PWaypmi2oPnprtkrZJqoFIO4FhBLZ
 lfZR1Tz6Z4u/g4ZJVVAmLm5Y4CSmf31gPoR4o8M+N8vqewdgN12iGpm73Lak9mNZDECv
 cMufQmSSneW8CAEG9yZoENAQSv5h8vV4Fh8m8fqjND8Lkj/SfV5MIN0hGa8o7MSoh0kx
 DcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912437; x=1780517237;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYNjxQcCSvYU6+1FueqgSrFzwpQgaet5EeASApuehzI=;
 b=OJqKnb2YODd4XXKMZOB7fm/5LMKtBGmymbb1igILLB+AV3xP8qPTSfOM4gISEQ66hb
 ncOw15M71MVKTLujJiDolfwBrP0Il+R/hxa8uIWdSH0hOCV+FoSLF404CIT2r51Cb9io
 guRH/SOxvu9idgUr6G1czsEmrhmexPnxJCWSJnkZzz9uLqbPKKm9lWuSFRPXKMaQBF9U
 uuVe8Ss3iDUyhLexC7+NZ9lFgBtSkKbQZFUMAfcajL1Ljn8aOSFAmL99znLJHaeQJJei
 X/AfCm01P1aAaZBgOo6YF0CXjpxkoVKk6nGz99vWBEnox+dh8gF4S4pm+AonKmGyfHeJ
 kpYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/khaKxsyy2nevpiQK+//BVHY3PoSVA7QdRysItOvWWaL5Ve54sBPmeQcWMMeoxHZwVAbIXP3otY4s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLpVcP9ndGL3wdne7wSOt7chYyy7EDuxbSd6XF/Iy/hbsLnZ1x
 ubdbOp9te3rFCjUGale1dA+GSSU8GF0Kh2OuoFuzlq+n7dGS26/iswAITf6e+6LZfbvmBPSRPwJ
 8gm2ibl5WEre1NBwd5WoriDNmZatOBWgm2cTY2km5eL2zNYFKNb2dXkImbEVGukY11HYg0wI=
X-Gm-Gg: Acq92OGq9n1I6FesobTh9P+dq+pkgsrPZVH0Lh81iEbW94qU2xGqE3C5f1C+RfAhtXU
 YofSOhXGE6npQTxIuhCwo5wFWSkjt+PiadIh9b0xiMlowVdoI6oyvvl50Tfc1seJC90pvqnXnu2
 dXj6Ebrt2YyA+VymODdhDd5WRYEWaztcofONYOAY6Tr9V/YPxLrHIoAfIrXEUr8MgvAQ+whb3JF
 R+6FB1rZLEDhgkUuFQwxAciZmdbsUDs/dwqdcswnAEYJopMRwjVu6wMz6kE580Eo+lfXtypTCr+
 nkBok7H0ELInCuoH58tH/P9YLD1r9maqlVOzO7rrCVmdRlxTIveEpkx/mgJv8IMgTX8VCCvCyGJ
 +FoQNfl8Ttcjz+jMgblRGK+xk61OTkJ8tI56FZ8drdRAdHieQKqXV
X-Received: by 2002:a17:903:46cb:b0:2bc:f3c5:ff0a with SMTP id
 d9443c01a7336-2beb060dda9mr261786945ad.30.1779912437392; 
 Wed, 27 May 2026 13:07:17 -0700 (PDT)
X-Received: by 2002:a17:903:46cb:b0:2bc:f3c5:ff0a with SMTP id
 d9443c01a7336-2beb060dda9mr261786325ad.30.1779912436658; 
 Wed, 27 May 2026 13:07:16 -0700 (PDT)
Received: from [192.168.1.5] ([59.94.127.41]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm158088605ad.76.2026.05.27.13.07.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 13:07:16 -0700 (PDT)
Message-ID: <25812e14-d691-4e15-8fd9-82cacc203eee@oss.qualcomm.com>
Date: Thu, 28 May 2026 01:37:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 0/7] Add support for Adreno 810 GPU
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
 <3dc009dc-8f36-4735-b849-d952fb626cf4@oss.qualcomm.com>
 <3vzdlxnee4w6mur5qiyk2rhewlugswxarhevv7l4zo47qnnqah@45oxl7rjqawv>
 <01b424f6-6617-442a-a77f-9b7a8472c447@oss.qualcomm.com>
 <191d66ef-7d36-41e0-b29f-1ddd47812b75@oss.qualcomm.com>
 <9a999b51-8131-4032-82c3-72d7eccbd222@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9a999b51-8131-4032-82c3-72d7eccbd222@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TsjWQjXh c=1 sm=1 tr=0 ts=6a174ef6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=WNRV5uGD5AkuWIfm3QAnlQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=U9EV9gB3usZ6apLK0C4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: gNs0058iBHU_DGxjE7ryLMRc1V3jszwx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIwMSBTYWx0ZWRfX/82eReyRCC7d
 OZ7WAjH3nZs0GK0ta5aPBmOBgVNJEVib20jKM+11og0W79MjGjKgNp0fMmV+dQYeSotXPzszkWf
 yj6SrUiLWPiSsmakZCbQyuTZnAxz1/YNcWDmZ1IPDiZ+JjNxfO73eyPbpYLNHmYqgylFz3rFMOb
 8J9CcNxCc/NOvBmGTOvBXEObUyN1Gi2i7HDMXHDpdpHigUSgesOYBqUaT80E52AY/ui76j4S0wu
 uu5imH7G8hqKNd6/VejDMZBkvggESOVA/2wyCykER49sT3qaRJEKDMEvimfG5qHowjmqV+OFgxX
 LW9wYu1NGUkQdIYLg6BQ44329Q3Q5GNkqLQwwpuJMBHefBTRPOhX6KM7zpCcgdLudAH5Q3KVUnx
 f6sqbZu5GFQWV+8mMdcfUXh46gXFIMBvq8smc/SWbNmPIjYBKMnFUb65jIvbdG9CBCZuC9ytdkh
 hO5VEo9IItP2Z0lUCXw==
X-Proofpoint-GUID: gNs0058iBHU_DGxjE7ryLMRc1V3jszwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270201
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

On 5/22/2026 3:11 PM, Konrad Dybcio wrote:
> On 5/22/26 11:39 AM, Konrad Dybcio wrote:
>> On 5/20/26 9:38 PM, Akhil P Oommen wrote:
>>> On 5/17/2026 11:54 PM, Dmitry Baryshkov wrote:
>>>> On Sat, May 16, 2026 at 03:52:08AM +0530, Akhil P Oommen wrote:
>>>>> On 5/15/2026 10:38 AM, Alexander Koskovich wrote:
>>>>>> Adreno 810 is present in the Milos SoC and is the first GPU to be released in
>>>>>> the A8x family.
>>>>>>
>>>>>> This series is marked as RFC because it depends on a few other in review
>>>>>> series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2], and devicetree
>>>>>> support for Glymur [3] (for a8xx RSCC offset fix and X2-185 bindings change).
>>>>>>
>>>>>> Also depends on the GXCLKCTL block for Milos [4], but this is no longer in
>>>>>> review and has been applied.
>>>>>>
>>>>>> [1]: https://lore.kernel.org/linux-arm-msm/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com
>>>>>> [2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017cc642db@pm.me
>>>>>> [3]: https://lore.kernel.org/linux-arm-msm/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com
>>>>>> [4]: https://lore.kernel.org/linux-arm-msm/20260417-milos-gxclkctl-v3-0-08f5988c43a2@fairphone.com
>>>>>>
>>>>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>>>>
>>>>> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>
>>>>> For the rest of the patches that doesn't have my R-b tag in this series.
>>>>
>>>> Unfortunately patchwork doesn't capture tags from the responses to the
>>>> cover letter. I'd kindly ask to spam the list with individual r-b's.
>>>>
>>>>
>>>
>>> There will be another rev to remove the RFC tag which will hopefully
>>> have my R-b tag. ;)
>>
>> Do we have a resolution on whether the proposed fuse values
>> are OK for this platform?
> 
> Ref:
> 
> https://lore.kernel.org/all/oka0Q911ixJLZzAbfWBx54dOmxbQAre36QqHUX4iDZoH3TE5jD-IqTAHspti6B8kfpLQ-OTnuWjFdXtsqJM-CUC8G9R3x_9vFI--LnpppiA=@pm.me/
> 
> Konrad

Yeah. this looks fine to me.

-Akhil.

