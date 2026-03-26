Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB5910AB81D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 20:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE06310E2CC;
	Thu, 26 Mar 2026 20:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E47JHlGl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrkO1gVU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E899810E2BC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:12:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9kv53850024
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fXRlhBV1u+N2Q2EAkpUy5Y7mrQx6fLfQQhyX/geIzcU=; b=E47JHlGlcwGJgZmZ
 ewOwhKuCXPRAM5U/J6TTPPSiUXhRSt0+WV1Ql7gsLcpOsUNYN42WdbaHlisoXqQZ
 qnX1dUsvdVRp1P2RJGBq8hqdgqVWmD2y6gFid8NlgFirTOvvVX2xFWhwqWN2akMf
 yjEtcYGG1qo8AxhOPjdBh/B34veXLpMTxc3eCGtYtRHCWgrQUvrFh/oQb9ZTvFdX
 MtabLkGZ193Jyy1GsxVVXQfrLeP41NyYiJg1W42DSMVKVBmN92pKau+6PHVJtKqZ
 w85p4JfswQGiUOw6WEQKLoPFbfAX8sFqDL6UZPqsykzhPsTWkKfXmoMlN/8R7ku9
 1R6kSA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q76vem1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:12:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35bea322389so1625849a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774555963; x=1775160763;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fXRlhBV1u+N2Q2EAkpUy5Y7mrQx6fLfQQhyX/geIzcU=;
 b=FrkO1gVUsK5XtEz+oQ+VQESeqGbQa5Uug58f0RGaG4BB7seNyxzFsSiPADp14VryLO
 E4NuxokOs6rJ2s+yZ9P0ceZpWyhJQUCBS6snJguZx23jyo2hNAzP39ACahDplDmXaKb8
 L1sViR5thwwM+fxlARyzf3MUHJU46N3+nHKIiAPQjsy7hXhRV3TeQBeccYU7Q17vu8El
 wzDtCeP2jfVGtpIQpuktcjnPSfbMLwayeiGnPMRJZsQkbJZ4nd+RyzklKueQbrarZeDN
 VIaePzEFGFKeipf3/z6E0lXsgTRMpTM40B1UsAz00Su7imwv/JurbboCvcewhbZElFuK
 3hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774555963; x=1775160763;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fXRlhBV1u+N2Q2EAkpUy5Y7mrQx6fLfQQhyX/geIzcU=;
 b=LuY5KbowjIFOnOkRtX7FcLKUhR//jaE/wO8k7kdHFIatxTeSBxPjvHdMUNxw/DFEQs
 88C4sCr7mkdfD0QHJu8LBdVq+4UauZR3of2rme08xm7qEJ2/weezPl6UiIHjGNZX391b
 maWyz51Ucgez1Ha6dyGt1Kpsdc0hmsF6MIL9B3jATZsouzKpoo3HaQp2t/J1reLUfEGa
 P+1tI1utEwv1UM1U2RqMEiTIORjggpy3rkWrnWqxer9ek1OnuIttO5FBaZlevSgftV4t
 yGxQlg+Hcyv7ekN+fR5x2EeRZX0qRvCovxurww4mqWMlPc6BEt8xjVT2SKkDTTuWzslb
 AZ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1S8Sk+1MwwvRTEuSHRBGZ+IHxNvj8OUBBX2pF/1JzPu245IXf8CZjxG6NGieI+7py23AOoPOR5ts=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzd0VPllHexv+rxJ/b8PsPFgjvBECe+hq+xWw7PEOrfOijjUihb
 mXIMCS4z2cmEObOpIyQu3ErzXdmWbjm3em+zpiiWYnEuLAYkzGsVFboXcm2DvThpsje6Y83epFu
 Qh8fK2OGqHSFqk8cNteqbm3ixcCPBqCHowbZmckFfHEMpodHk5Cm4jBlRSszDsslX+wQzYOg=
X-Gm-Gg: ATEYQzzRExvRF2P89o6NPUph3wAP/+Hh4IGvWsvYBJlTYdU1M6EAgUnkUbcHUTMrfhV
 Iah1aH/uRWzcvgBCwjWAQTmn0i8IhL0ZJMmNUqAV4jOty3CcQJ2ZUb/dTpX74lYGMCXkaqedzBF
 rA1M6Ea27bQPi/JeRCB9brWQxsxpKmhiR6t0/TOtxS/PQPIiwZt/xkWkASVmpeVBkLEuaI+0M++
 LRu0FY5sxNC9LrtJ+FPU/titI2Oj2BukMGPFHceMqCD2kDmClbGKsUw1bLxo7YVwA0M2jvTAawE
 pj+CTRb2qoblA6uvGP1+4gEQMAs+kgn5zxDSphrhdsYTHwUrCuGqf2RxbLKJEBjbzxJEEa+zGvl
 +JXJ5KYzCF0sCZH35ivmSL1wOQo+pbt7IQjTRvLEMOgwG
X-Received: by 2002:a17:90b:3906:b0:35b:e4d7:53f0 with SMTP id
 98e67ed59e1d1-35c0ddc19e1mr7943946a91.32.1774555962541; 
 Thu, 26 Mar 2026 13:12:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3906:b0:35b:e4d7:53f0 with SMTP id
 98e67ed59e1d1-35c0ddc19e1mr7943935a91.32.1774555962069; 
 Thu, 26 Mar 2026 13:12:42 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ebe2c98sm44495a91.6.2026.03.26.13.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 13:12:41 -0700 (PDT)
Message-ID: <92acb4e9-91ba-4a91-9007-17cfaa1c6097@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 01:42:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] drm/msm/a8xx: Preemption support for A840
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <20260324-a8xx-gpu-batch2-v1-14-fc95b8d9c017@oss.qualcomm.com>
 <3a71adbc-b06c-4c04-b539-abb56e4b1c6d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3a71adbc-b06c-4c04-b539-abb56e4b1c6d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NOPYOk6g c=1 sm=1 tr=0 ts=69c5933b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=vQjnIgnGPh3RF3IfkbUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: RNlh1FEGWDyvzEE12W3Q3XznGRbzpZ8E
X-Proofpoint-GUID: RNlh1FEGWDyvzEE12W3Q3XznGRbzpZ8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0NSBTYWx0ZWRfX+rafCaJq+Km3
 272Lz0WawB2Sl5UeaVZeTzMgpJlHhtbIrc6+eJovmeGj6QDFbX+4DoV9Cn/JDivgO4hN+2E73kI
 2mcWUeF3ruSlntdyHn4VmeeH3w4dMw9FmMMWl7Bnj33G8tC6AeIbsI1+CPZo6q35GaUmVpqQChV
 5uyMS7zSR+a11Au4xRoeA6XfBHClpSzLwjrVnfcLqbEsDMQrU7tm6HzqFCOUUUfoy8zu02Ea+C8
 0he+vElLNpQmdvcij+5DzE83eFabkgoCmtVK7Vwga6x7DkjwFaAKvxzB5vXg4Od5OsokqQwz2Qv
 Ya3GTIymr6YO3c2AUGY35Kb4KIVKzfSKnVheMJea3GX2eIzblWVkNGzWnR9PgpQyHtixFqj40Xh
 D8/964wknuCVkme3wP1Ql38Uljcf/NfBte8Y3Ka1tw7qVgkUxLiJEO/Rv93e+3YezqCnR6y5242
 1qkuUjU0I6ODTfQaaQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260145
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

On 3/24/2026 3:48 PM, Konrad Dybcio wrote:
> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>> The programing sequence related to preemption is unchanged from A7x. But
>> there is some code churn due to register shuffling in A8x. So, split out
>> the common code into a header file for code sharing and add/update
>> additional changes required to support preemption feature on A8x GPUs.
>>
>> Finally, enable the preemption quirk in A840's catalog to enable this
>> feature.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	/* ... and after*/
> 
> ultra nit: space before comment end marker, please
> 
> [...]
> 
>> +static int a8xx_preempt_start(struct msm_gpu *gpu)
>> +{
>> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>> +	struct msm_ringbuffer *ring = gpu->rb[0];
>> +
>> +	if (gpu->nr_rings <= 1)
> 
> Can this ever be < 1?

This is just copy-paste from a7xx_preempt_start().

> 
> 
>> +static void a8xx_preempt_keepalive_vote(struct msm_gpu *gpu, bool on)
>> +{
>> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>> +
>> +	if (adreno_has_gmu_wrapper(adreno_gpu))
>> +		return;
> 
> Are we going to have any a8xx+gmuwrapper?

We can remove that check.

-Akhil.
> 
> Konrad

