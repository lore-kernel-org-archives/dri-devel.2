Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8059110ED65C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8E310ED8F;
	Fri, 27 Mar 2026 11:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NETvdQfy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YYrDEPoa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481E410ED87
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:23:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6vonE3715959
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3w2ktYkEZdHcxeWiM/YwaRWS3HtqT2nSX/T7SXyb4qo=; b=NETvdQfyuCGPcouJ
 H0byEs5stHDvAV+ALpQ6mtv9aVZquPL7CbJrIkQqfbDolKrp1f5F4OyzTk98aWxg
 4IjtkoIdBRB1YWcQLbRjKMlCxaaGgVahJtkZYVT0SOCjov8pMHg5aVipfqT13kcb
 q8N4VBn6bHs492y6qXp3JzeRbkHOi9UF3CfoYBbbK1KUSgR3mLRYxr4XpCVLpBo2
 ahrORFU8J7iZX0R0niTBKWHJH8f7/Rzv7ozbuySeWAp/nYNPCcITBWkYObPhKwQc
 BpvQ6djcr9dQNfeV782fkJeyDhU4GnIxPzO/MR95hav4tiiLmGido1DbEdU/+AjG
 xIiyZg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6jhbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:23:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfbd336c3eso66132485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774610585; x=1775215385;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3w2ktYkEZdHcxeWiM/YwaRWS3HtqT2nSX/T7SXyb4qo=;
 b=YYrDEPoa/mgxoqAcOi7uSkSSzYDXwNLmjVvCy1jewyrVnxpoBq8ZvcMod6Fra0Yoiu
 UAJqJmJjC7imJoyA9FvtGtiHp0xDKk+pihOjc6Mzn42tzHlLQh/Gb0tTckOdNmRdZuxI
 0AJTU+MKq75/2nwTL/ybVEfDhh+/EipoKNNxSTb4nWuROe1cZHcb4qZZ8hwCB6FwfpiT
 eAsWmSId3ggv4Zh/MA5j+/QZIAqpMES0v2iNwFdbsltpZI1Amv7VHwpnrArnM0xneeZL
 G3gF5wOVtumdDPDBQOXrOTjTxV7K3kQ78vQuyZv4QxjMGO4t6dblwCXYUfntaVeiBDwg
 t4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610585; x=1775215385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3w2ktYkEZdHcxeWiM/YwaRWS3HtqT2nSX/T7SXyb4qo=;
 b=ImVn/8k5b21+T+ovffAqYtdhMzlEoqRaPA03Zysl0b7YTdbBF21aoEc2fwwJnMZuWD
 ptNIGJ90lb1J8DElhmCRsX5uviHEJmXIQn0+cP1+izbtSpHOxNNJQSmuPMdKp6Ia3s/d
 4W5t5c9q6px3ffsapO3pcdF5ZdZCSLSBtTN0oPshwMsByx9LX/JXgg//b8PZPuIfP30u
 pSW8XrstLRrdnNZ/pz+pYYbyHYr8p9m9hqA93KLaDR8bcZX3PlETvcH9IOLBneOtAiJH
 mhyvCDmpAcI0MYY/ONLHKpWIkJtWrscLtk1OCSGEEC9oOTZ5nU7lM5XhvIhN8R15fJIF
 gpsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg9nkytaD4fqFWgwo5QK1fSm5uIPhC/ivOc6Pr7+HhBqWVJjhA7Qtl1+uVWPlX0siOcfoW+qUoqY4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsZW8ngfkWE4ZAq6IJzO78daX9edUdXlcVUhENpXBGJRzEXFET
 F/fr54N042hPKTUeJKBpgQ3YKkloviWsZ7R8ABQlM61Zm3rNgEI2mES8t6V/TeRGev6opzSUZm0
 0esRK/6gjvpLz8vtKa0PSiwM4MLBrPGrWV6N/ZqY3JvOEWIzV183E8gX4HYXaS2kGxdgrRj0=
X-Gm-Gg: ATEYQzzb4rNsG53fqYDyUV+fuYWbOi2aib45YyJtlk+4u8AHS8AhNZskkCrqaRAKRez
 xSGCCliuNqhkPqH7zbVdxB/Nys13sCjgURRurpHJPvzd8bSExCu9lm+yxje8rKBxbVTzrQwu1L0
 Inm9yfN1BfUhO/hP3g1Y1VjSE5O3TvDfapAWS04CyCiJC2CDlkf8jQ3CTl8ythPKOQgZYRgfNBQ
 o2ApiroXlAc3RScpMBbSeIH2ZsM3JjJBC6xigrbP/h2TRRa+5zr6K3dC4GMjJUIcnPztItEt+xR
 zcMuBjWVL35uEq5flbkpEekRQMWK9quWESwPlm23pQt7W9RPAw/2gZLnid+zT613QVsybGiQnby
 YQiNty7tl/DdUg3IlNky7ksTanD+JlRd09CpUOB8V2HNP9i/LVI3+8drtzbDmNW9jx8Je5kMjpj
 GAZqE=
X-Received: by 2002:a05:620a:4686:b0:8cf:d5ca:adde with SMTP id
 af79cd13be357-8d01c849700mr182386085a.8.1774610585540; 
 Fri, 27 Mar 2026 04:23:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4686:b0:8cf:d5ca:adde with SMTP id
 af79cd13be357-8d01c849700mr182381085a.8.1774610585035; 
 Fri, 27 Mar 2026 04:23:05 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad60361c6sm2214131a12.7.2026.03.27.04.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:23:04 -0700 (PDT)
Message-ID: <4522e20c-70ab-48ef-8b0b-59f2548ebe64@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:23:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] drm/msm/a6xx: Fix gpu init from secure world
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-10-fc95b8d9c017@oss.qualcomm.com>
 <e44e776c-df8f-4555-a487-9a7a6fe032dd@oss.qualcomm.com>
 <7d223573-438c-4e93-b4b4-64975c4da93f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7d223573-438c-4e93-b4b4-64975c4da93f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c6689a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JAnykeg7oUmYEFbxpzMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 90RlzN4KMWghDP6f7aXH2iUbcsgZhZeg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3OSBTYWx0ZWRfX/AVwnoydCKr/
 /TCzDIg81eCHsHEx26rRiVa4M9WrHiUgPZeQ/foB5hZkQ53qMTnQmHOYGcYoigRe9qdnXKtlIjl
 L2sqpNhIA8XVAIaBKrPtNO/JAmLqU3TTWSo5aKohvk4igJNFOGjUGSl3KXe1RKnqpQXbdPeEYLU
 xko4vlar4LYDbqryoinyFL9+YFRs33GX3WENXFoHSpQXSwaJ/ws1DPGic8TpUwcPwrjDaJdXmyZ
 4xAU635YnQ4ycLVI9ykENoQvoRBYU8bZyJ9XxdXPOe/600s3EZJ4eXKH6J40yQJ7GpYWRSetHu0
 ZbcggGMFbw+Xa5R3HTm0oF67YzlNx8s23JB9FrPkIYM5+Vcv0HHLgWrkmpDFVsW5WYIvydbsWSq
 Xf+wQcOYubf1hUSOWKGKqu/mj/KrW1cEt4lpM++QCWslO11M3dgDIzD3SDgZPQBsXfygWJI4EG3
 ohtpId3pEXGbEUvq0oQ==
X-Proofpoint-ORIG-GUID: 90RlzN4KMWghDP6f7aXH2iUbcsgZhZeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270079
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

On 3/26/26 9:12 PM, Akhil P Oommen wrote:
> On 3/24/2026 3:37 PM, Konrad Dybcio wrote:
>> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>>> A7XX_GEN2 and newer GPUs requires initialization of few configurations
>>> related to features/power from secure world. The SCM call to do this
>>> should be triggered after GDSC and clocks are enabled. So, keep this
>>> sequence to a6xx_gmu_resume instead of the probe.
>>>
>>> Fixes: 14b27d5df3ea ("drm/msm/a7xx: Initialize a750 "software fuse"")
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> This now makes this happen on *every GMU resume*, which sounds
>> undesirable (kgsl does this in gen7_gmu_first_boot)
> 
> I had this in my TODO list, but forgot to update. Will fix.
> 
>>
>> Similarly, we call a8xx_gpu_get_slice_info() on *every resume*
> 
> No. We check then slice_mask and return early.

Right, but we still branch into it

I think the best solution would be to add something like
gmu_first_boot_setup() which would be tracked by something like that
bit you added in v2, where similar things could be moved

That said, this is just an optimization

Konrad
