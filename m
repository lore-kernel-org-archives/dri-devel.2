Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D5C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB1710F69D;
	Fri, 11 Sep 2026 15:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wd3F/Da6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aTbf2XX4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7527B10F69D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:46:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BElxdV269258
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FMETwDp/3YlyYwhOs1PhYLsbVwlSu+GFV+6efISo44w=; b=Wd3F/Da6OWHvXlJs
 5MGUI8D4JBwW1f0djoIFga8S2//zfxRJ9VJp7d2UUsFiyojhZXncLnxKw+VzKLg3
 /mC04DOfa3dgnSN/ATVUe71pxrk9tk/ndiE+9OwvftI0QiSmvD4MD1UIatdcm9od
 ovNC7kaK6CX4zMTSbtTvi8kVtFFSjp8R51lRvvKxWyHBlM6Jcu0YTZjKbwBjMUOp
 t/tPPXb7c4lMp8j7YWF2UQ6HeIRJiEftgejKs/B+RzuiY59o77ErqTKhr3BfyahC
 nKrsfLdXLQe3x1JfE3uspr/sfVBfnzb+CTiY4HAQNrgGDBMmAm2VtdUqlbLAi/iH
 YW8k5Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd52jsk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:45:59 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c82f9e26ebso35880e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141559; x=1789746359;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FMETwDp/3YlyYwhOs1PhYLsbVwlSu+GFV+6efISo44w=;
 b=aTbf2XX4Kzi9DfPFMTLiF5di3Z5UFtYDSc0j7u5vSB60MkL/WZKUu4hxXoKvA7/THr
 x1JFhIGLK7hj3xOhvSixCvSpMzEq0GbpOK/2Zh6t+SAOuPLu0/YFQ7TgzazljDHnX9b0
 cP4zTeEZyA06b8XuUjSufDuKP/LqueU9zRwRzoHu+VywZP+Ueq5M3vXr0/iRuPvy3PT1
 rFslN/a+zILhFrVczkOhuH5veUIO0DT57M8W/B35BwPZ0vVkIGK6D0Fc4HIYuhgcdUdF
 117p/cMZSC8YGx0ZbM4gu2pQsvGs2U8MJ4coAzPYFhIlf/QWVcaqYWsYnYXhdZjZzI/k
 R8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141559; x=1789746359;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FMETwDp/3YlyYwhOs1PhYLsbVwlSu+GFV+6efISo44w=;
 b=CPogMqjfxoGHqjOfYPPf6rczww7rICLToqVNp+6GaXaT0iYs16zwBziY7jy73ywSCf
 y+Y4GAkFIe8/AWlI4cBClDpcmxz4LCFd+eD8aowUmKNBYU5kAOtRatdQAbQg61UupjjA
 9iea2PVUW7WIP8DdllBgQH0xpgju65jNHrR9wO7PxL0TBHbdI675QyJvagL5T4c4x8xd
 nyWOaNrWvFTiHbCOfSaEVLnhgXVT1Vfgv3+skmOhcYuY0RFNH/bhZsailFmO+riYJ5Bo
 oAZzgGC3SXbMzheLLEF4LuidPDEPggRm/nXyVpsgiGdsF6aTbtzZYeoY55XHJ7c7PbDK
 3/JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwm4fauUM5r3TO0LJjNDNY17Rwa/888ojrPXBSNCVawwCyGo93ChQguf4SuJUp3aiyZutvuob3X+1g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXVgB2370gNVb1DoGPHXGOB3mJaLsyXmplylU3w9uRHuxzGkO8
 ajefGDdVck9zIiwR8hr2vdOo7BZsMi+niION+5vEeJRgHRYrkAatgy2fF4PbsRTW7hOA4t7f+OV
 6Pc/9/faCrJ+nH6f044yTAFYjXLtxwx4+5Ugi0OvyXLbFQVRKE6NLhOcfTVaQnURNaJDn9WQ=
X-Gm-Gg: AYBFou1PYs6YSu95Fd5AUh0EVA4LZFFQurnloBPGfaM8hqnd7auklZAIAI9IolL4Q5E
 LMMxd6ZoyW2DnR4HKC98ZDzr1otoS7jhPKRR4RSP87HnwtAdSOT2Lf7gVI1rTjck1WP4BXIMdJ2
 WAHqibdNBXCnqEiava5zO00oOfW4I6Q4c1bBHs0h6DV6J8qVlZRlE2ep+7z4Ju8ecCKMSkeMwl1
 glkKTSpHYkoH9Q2TGfSkXgy1DI5ne6qDsgnMgWRw44PWHAXs7cabqVax/GdLTOSIVRKswhqbiNb
 3++diodFU7Rm/6q07Nw5aAL6GBWfEm6KD1d5aYVtQ6H6TP0Ors62sBrXMXWHzJ4cMS3vY/GC96/
 jTT/tEcyyAb+kTL7kBKfbaw==
X-Received: by 2002:a05:6122:6d08:b0:575:dcec:efc1 with SMTP id
 71dfb90a1353d-5c845d9f78cmr2224901e0c.0.1789141558838; 
 Fri, 11 Sep 2026 08:45:58 -0700 (PDT)
X-Received: by 2002:a05:6122:6d08:b0:575:dcec:efc1 with SMTP id
 71dfb90a1353d-5c845d9f78cmr2224838e0c.0.1789141558370; 
 Fri, 11 Sep 2026 08:45:58 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047b678sm723077e87.78.2026.09.11.08.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 08:45:57 -0700 (PDT)
Message-ID: <ff5806a8-ed97-4023-849e-6cbd9b88efdd@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] drm/msm: Properly handle msm_ioremap() without name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-5-87bdb9f1987f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-5-87bdb9f1987f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1GCRBmXxQCoSRAPv0dz0gG97OJfWaAMM
X-Proofpoint-ORIG-GUID: 1GCRBmXxQCoSRAPv0dz0gG97OJfWaAMM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOSBTYWx0ZWRfX8dKjxiV4rsam
 GhQ2bQNF2yn7Th0mnb7vldFog9DWgZYNdz7xb6CgqPz0hOSPZFcJNLOCZiY4fc2qhiT7k6b2DT8
 h7ykzuQ2+7YAE1A/HSRi/47MEf6Gtas=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOSBTYWx0ZWRfXx3TeOlE5kmnH
 +abhD0LqYDMS0r12OXqTJizH0kF5CNQLZB4mU06nMrlkrQAiUkjkpqq8KwCAvjjJbGiztS+CJ/b
 LQ9LL8ZsaUWxHfSk8AzhqXYZ828XTV8XbFsWfaD7oUHOmkONT0NpLuIJwrZ7tS5PR/Kp7YNSead
 uEDW04DrpuYOhw8bxnjbWEifUM4DwaGlcgyKno4db5BrUgDtxy/TN7ErAAMwqZ/uMtYzEOaQWvl
 1i/jpBClNR2UotUPTkm0PNZZP1Z7Hrl3HOMO+rMQfX3NhK2mA6Jw/nU9u+Ii8hB14/CusM3Pv22
 cvSGcasZfy3999702XIPLGCYmfmbDjtq7N8IPwAv2K8Cez5WfNj7eXooqWonGLvWAq3x0l6UTqN
 +X/ORw8IFXjWORqqD3HHeUefwab9pyK3hPQ1WlhJig1S/5mayllUvWC+jY7hR1VTR9gIf2KCnmW
 Soag2yZ1pOCtKAOMOrw==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa42237 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pPDQwCEtd_d-j3aiaSMA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110219
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

On 9/11/26 12:29 PM, Krzysztof Kozlowski wrote:
> msm_ioremap() accepts being called without name of the region to map and
> in such case maps by index 0.  However error paths still use the name in
> error message.
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
