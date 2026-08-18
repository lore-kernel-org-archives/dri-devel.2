Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93494C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4CD10EAB5;
	Tue, 18 Aug 2026 10:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JzBOM1zw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TjfujY3t";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E032010E4B7
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:40:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IABYJD068527
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AnH+0QXrWlD6vyCJWXlr8r1LgxYaD69L2S6S9TrvEN8=; b=JzBOM1zwrfzILJEl
 xiCIDFHgpfHTv2BBYBURZs8BkOGG+iRDla0mPTLH4XPTybkmJtVPRk22Ep2+RIVa
 Ujc0ktiaFRJGLa/LOVFaCsZdWjTmUUnjSug93/xufxgJKS6StaR1eIMHs9qCVIpQ
 LbD6jUCEGRdgtFP4SrCe9UtW+IJY2vXGVr2XQ2XwZI/d5VoUnyrFPVj18M/MVJ9w
 l0AxGI0AdLDcASENkRVPK9u0foU/mKrCp18n614L+2oDF6gNv5WJJGx/UCwfIMFO
 dnmP3+VoMd1tlalk0Yllb2/PLzkOd6chGtZY2IyMGhGDgV9addMzlsmeabFZV8Wm
 VnsU4Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5psrnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:40:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930bd2bfc45so123072085a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787049633; x=1787654433;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AnH+0QXrWlD6vyCJWXlr8r1LgxYaD69L2S6S9TrvEN8=;
 b=TjfujY3t3NMk2BAmlDONMogYGPKnylyfLoGfRIwAiC5snJZOGPVBuJNiQgEuiAe/8c
 bBGdjJ3OEvbs+03wuhmkrZpHMifWjefu2o4AEY5sPbyBBSmChGC2fDxHZmLjBGxAsb7j
 XKGrmJbpGxgRm+Tph6WwSr5pbNMMVFcajlDKi1v2IMoSEsm2C3i3bFi8ln5kIhlEzmfB
 u3rg7SHPaARI4DvVjNHjmlwdstqZtc6A+i4VDOxI7cNR4piKT4BvHRdxRnu9H+gH6fKS
 5tKO479yJRvuGQ66fBWqd1SQ2mNFGJMxFOx4Iu7r4umyajKTsNEAzuBdg1Rar+yjb2v7
 dJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787049633; x=1787654433;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AnH+0QXrWlD6vyCJWXlr8r1LgxYaD69L2S6S9TrvEN8=;
 b=s8x4RS+8p1C1gJbWGHTPN48uFTmawOku5g+6zMpQFzNIPi719h0rn9xorzuklJ6uR6
 WDPmXPbOv5lxbLK4WLYn4vLhhP7JNczd/VsFQBCthsoAjCTXNztOaqXERdgQYsXPClCt
 uo6ZqjbU20obg2DDt2oueKUoaOym+uw5LhFsc1l9AHxesEfhm7ZbumnYm4AJsux8laou
 4KYaC80XyhScctwxX9Ophuav5X47uXgHdzhSpyF2yK7+b9e5Wx8p4WoTTq7v1mkgJ9pV
 4La37+csmcTP6TK9gSxsCGxFVjOwrtiqgXL0feppAcwnEHXMMnpgXAXOqj3Teyqxbdp7
 H1wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqALw4mCKt6w+14gGyQ2/VWHlSKCns5wK0f0csa2pbp54g3x5cvtVY3SMTeFr671wydeScJJz7fJfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHJy+xtXM5B3SBN8Vw8QDaSYR3FDn3Franllyh2jf0qjGam6s0
 DSmoj3pFia2irHxTwTbsoTITae0/J6md+JEmmovRaJ3T621+xtxGVFMGEot514wDQfc1y0nBVKm
 LIiiJSHcVKgvpzhImQI7MBQkG90leZ55HCRH4eiKCQDuTB16phs63yZVxynQzLV+pcgPIwC4=
X-Gm-Gg: AR+sD11hXq/9mjV0khig6qyhAVZdczEDQANtt6OTL6hyV+fGRFUGKwIURbELTXewKO6
 pYdt0wgJQV+nC4ECgFpeCsin5EOhVncP1mGhRx4f5wErLuZlaNBeZLS8Cb1AHWv8K/mZDaaLFhp
 k+wVoEb/hlftiI1BXYvTmwAQIPuOmskbNf5GmqkznrprgoButfnYKf6g0YIiUxxQp/3aw8gfwSI
 y0iZTTOWYzSEOSB/ReOxpWUBgCYM0KduWlUPR18h87+83qvMwrGTUeF1SXmpUlAzLr6CQoSViY1
 wpNXgGVz+c5r2aGUFny580X2K/Qw9zQlxFfJtfXAKaKKLLIqwYj3V/Ml5pVFG6wGPe+OthaTjaK
 VZFn9fuyl883NGbQSOKTme3Cy
X-Received: by 2002:a05:620a:1a04:b0:92e:6485:f640 with SMTP id
 af79cd13be357-936d261aab1mr2297577185a.4.1787049633283; 
 Tue, 18 Aug 2026 03:40:33 -0700 (PDT)
X-Received: by 2002:a05:620a:1a04:b0:92e:6485:f640 with SMTP id
 af79cd13be357-936d261aab1mr2297575285a.4.1787049632914; 
 Tue, 18 Aug 2026 03:40:32 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3d85886bcsm1765658a12.16.2026.08.18.03.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 03:40:31 -0700 (PDT)
Message-ID: <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 12:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260808131624.2854412-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260808131624.2854412-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a8436a2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Sp1j9OMB0jjwDDl5ZD4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: nYVQHhjfirhNmptj0XT2QhScTtY_OZNW
X-Proofpoint-ORIG-GUID: nYVQHhjfirhNmptj0XT2QhScTtY_OZNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfXwhyWeIg7YGdf
 36M0kXZTcL1frS16Sj3hbACLmlwnaqZxBs1Nyef1/+mZ43aJXZVB9iWXCfIAsR1N4FQm4YX79BB
 uhmcyfkXGknQQWQJYPovIRjGI60NEAFNN40agdAMw+LdHyuKBoHIp0kwlp9tvgbDntBdMPg8O5B
 lcOCknK1bBOKXm6pSTZ+P25s5PKbZMpQMtAup3GDNdKQ4m1zGz90viCGA4lIo7ZLQP+PEI9WWk5
 mQgLVpeNzR/P7k8Pyc1i4BfQNX5FHLTXfWXSnKPLVsAWMA6lqKvaw0VNW8I8Av76/CMm0qRa7eW
 rsxq45QFKQkxinR0wrHGS1qthtLmLgpMZsRBJo4oWKOKvAxQzjDR9ZFMOxdlCpKamCBeNOts/ve
 RZxQrwGBUweoONdhJEq+ajN8DVIOippERiqAIeno9Xoo+oOu0SBhMoCN+/cLjc0gg20ogoVYomw
 V5NMRtFGAGfzFc5Jx0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfX4lYZg2UIF0qM
 MJiUBL+w+m/7kDRYRgR15Rj3xKFiXqVwjBm62G1VmvYmOzi7whc49u6u6ueEYu7LM88DzBVKWgN
 RNkhdYjROy+cWmeiFWfZMyZ8dFV9gyo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180078
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

On 8/8/26 3:16 PM, Guangshuo Li wrote:
> adreno_gpu_init() calls pm_runtime_use_autosuspend(), but
> adreno_gpu_cleanup() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to
> adreno_gpu_cleanup().
> 
> This issue was found by manual code inspection.
> 
> Fixes: eeb754746b14 ("drm/msm/gpu: use pm-runtime")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

I think we can use devm_pm_runtime_enable() instead, which will take
care of cleaning up both the autosuspend and runpm halves

Konrad
