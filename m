Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08007C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C30110EAE1;
	Mon,  6 Jul 2026 21:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSlxawR/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gB3b7brH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D738810E908
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:56:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE5xm1428845
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DVdlz/AoF+GYHSUtVQ5knwxf7V9QHtqCyB2a5fsaD8Q=; b=aSlxawR/BBrrsLrp
 S3V4J3GgdBLFVH5XsOppLOymMo59D1CcyK+MsnVve7Xg8I93VdIAqy/Rb+2vPqjr
 qo4uc1b5gPUwyAagrMaFTdRWnCjyA8JXRU+Ip7WGUxq8dXhqxZ8ljDUCSvgRBZHc
 v3HN1fyYz/aBTB9jd9QYwx229j5YIT9hrUHTIniakWSL5de1l5DDGqjbFPPB0Usy
 ctjuHWEBvMsAIi3PIFQrGdnIRUWKEPo82upPFGkhkapz+jPJK/YB7Mutu7vmLS2J
 uXtkmaiJcgYuLaMCiV4VSNSLtKM1svV0ILMYxrVktt+/zD+eGP7+rwJulfaj8iG+
 vbvbfg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxupsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:56:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3840994b0d2so37633a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374982; x=1783979782;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DVdlz/AoF+GYHSUtVQ5knwxf7V9QHtqCyB2a5fsaD8Q=;
 b=gB3b7brH1Y63CcHatyl4cyEWL4EhSPUSJrItTlZrGMYcMM4l52DJlct4yeZg3Q0n/m
 aclEbjhiBTPY0jkazoF4kr6EialAH4By5+ERqgfN0Dz+r7/HrjZOknax+XXVy6Gt7DRR
 phQgP0VykHF+O14hUkgzYyVkKW31naI2TMuEgCw1muNVCv6ddhR/AX+KnwjUgH6nIcAg
 yMNVFgVFeELoGTzyndhnOgGTgfHTuMVUlVMlAa2oYqOPiWTtWOQtzALBN54wX5MKTxWC
 sZEDQFP7UTNSSSu46Cxbi05Rq6W6YFvaQWl/Rruuq8oemfeifRTwhCGp8Pa38uWHyo7I
 cQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374982; x=1783979782;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DVdlz/AoF+GYHSUtVQ5knwxf7V9QHtqCyB2a5fsaD8Q=;
 b=jpQK6TKecwDslqcnTUwjRgxsRBdhndey9GUVWJQU+7/TehL/NwyZBARJd9XOBs3Vyv
 trgD7Jill7xsGH8rTbfq0+NV7ivkVjE+jgtkXGDplIe2b7tJR3mCaCRXrriw5FDPyrTm
 bLuYaQMa361m6rHYc+U4BpKqu+5PehsCOYj9DjCbUcOvGGHzZr+Q41OFQvzvI9BaIF3m
 FveQnKdI4l0dJHY1/LxqOTCIiy9O6ID5LOZ8aY0eaPuFW4rZ8yBaruYQ0q1zXnrgiXJs
 OEZYo51qofR5ZRBxzLBSRMGTJtjWnmB4OmpiDlIp6zQfv4rjb8mC9cJRgi3p7f5xzwqT
 TsoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSxIpC5UYKtAlbads0eCEKIxuKp/PLPekeVCgF9szrsTZwRsKDg3R3DJudgJQAokRdBFQfuK1X6RM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXvH0h6gR//NdDVcFmxxkGPkd207HRFH+q12HiA7bDmG6QBSzZ
 2hGqecSawuvF1/Rs29mhw/FBYfrWknb8qyyzc83brop7uIwwOkIAQ6XiTXrupHu1brX/usSD8/y
 cMrND3w+wVAIxKrWAeOY/Ds58KS3ENdCwtgRfCBs7adgTLLZvfg84K87LL5PyzmyGKAkWUrY=
X-Gm-Gg: AfdE7cn9GCx7V58idoh1uY3dqlypGgM0QCthsmXhtNEsfLV2TIlZGcFTub+gh1Q2jqk
 ijW/qhVKnW1qDAcG9X473OcoTzvI6VKSOtekFFexXCfu+9/lgdXVIh4EcFngyh4lK5F3qxmvLqS
 4ILYH8GBrYgMUV4VAZUOUX0K9uxYu8Gk6rUe/BMgIyRjqNZjyjvFGPotzJxF/opl6ivuJjKkyeR
 +5BFuHVNGsWzOu/K7zl3xPUblBtam9L4aqWM6ltQEa9+VHQTchV9CxlvZKAZ5L6jWwuxS0p+ljl
 yTd0A5V5VRhNvWe6JNZQr4czfoX8y7Rp61mnO03/rWoQIb59X80EHinU6jvQu3RE4L9Z2cpnASl
 +nxVVr+7FgMtHB5JIsmqOQyNEIhGnU0UQkT0=
X-Received: by 2002:a17:90b:3a48:b0:37f:ee3a:12a with SMTP id
 98e67ed59e1d1-387d6b978a7mr102077a91.2.1783374982393; 
 Mon, 06 Jul 2026 14:56:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3a48:b0:37f:ee3a:12a with SMTP id
 98e67ed59e1d1-387d6b978a7mr102043a91.2.1783374981910; 
 Mon, 06 Jul 2026 14:56:21 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311748394acsm762251eec.8.2026.07.06.14.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 14:56:21 -0700 (PDT)
Message-ID: <2a556ca0-d276-4c56-a44e-9d8b92a3af6b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 03:26:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
 <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
 <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: av9W9wIupfp0ImNibWFSAdeCvPjwNJ2k
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c2487 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=mx_oZ8J27MAni7-wUjsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyMSBTYWx0ZWRfXwV3bDkU/qh4X
 AWB2hRoZkPeVIxGu6+HN9li7H9LDKqev6CjSh1OCGeSHNQCbjTuviRMXFHL6mD7YFovddwt15/h
 j/TL/wuFep12vQbbo0u6OzXcKIfpXqo=
X-Proofpoint-GUID: av9W9wIupfp0ImNibWFSAdeCvPjwNJ2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyMSBTYWx0ZWRfX4J8vREw2SoWM
 KAjuOT41luDuy3cQITEoictICpOHCpgk/UmGA5CSZVK68lzeKX1yue0N57JJdv4KV3dqxFy8WfI
 ZBHeoJi6akFT02RtygXmsDfpNxVSQo1WaTCWYMJSBoLnzRYBO9N40jjkw7zVzPYyWEwC+cLhaXP
 IWwSq8xEXrJjiDz/jf33L+ebOyfPBCp4qC556qnhrlloohFJgWuCDHIwJtNNFiEjPQwo155sH/0
 ESnlpPDl4ijblzaZ/vsvbz9OGru+jKjao0jqlmJFrJPUvMY/ORqkSAMDRGGDQf+7hKXmOnOL7fY
 cUtr1N6aXf34Ntu9TRbmURRumjKP/ll6fDomXV8v5H+QZVMdqBiNM1i6AgS0rDliXZwufiaf032
 2lnygfrZhWiV5ONda+5QEDo1ghduDTKXjiqq8nQ0pN7gI/5D6pq1ysDqcXJZkqJIuuaM3ROqDQy
 O1BeM5oHqHxoGPkxoxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060221
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

On 7/6/2026 4:37 PM, Anna Maniscalco wrote:
> On 7/6/26 10:44 AM, Konrad Dybcio wrote:
>> On 7/5/26 9:13 PM, Anna Maniscalco wrote:
>>> Program all the register needed to start up LPAC and send initialization
>>> sequence.
>>>
>>> Additionally, now that the LPAC ring is live, make the code aware of it.
>>>
>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>> ---
>> I believe some/all of these writes need to be guarded by if (has_lpac),
>> as many GPUs lack these registers and there may be side effects on
>> others
> 
> That's correct yeah. I'm not sure what has_lpac should be though.
> 
> Something we add to catalog? Or checking if it is a gen that has LPAC?

We can introduce a new QUIRK (ADRENO_QUIRK_LPAC?).

> 
>>
>>
>> [...]
>>
>>>           a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>>> -                              sizeof(u32) * gpu->nr_rings,
>>> +                              sizeof(u32) * (gpu->nr_rings + !!gpu-
>>> >lpac_rb),
>> Should we rename nr_rings to something like nr_XXX_rings
>> where XXX is some uarch-generic (i.e. not SQE because we also
>> support pre-a6xx) name for the main number cruncher?
> Qualcom calls it GC so nr_gc_rings perhaps?

How about nr_gfx_rings as those rings can handle graphics workload?

-Akhil.

>>
>> Konrad
> 
> 
> Best regards,

