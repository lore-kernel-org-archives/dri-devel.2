Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD331061B20
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C290710E788;
	Mon, 30 Mar 2026 20:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aysNMnhq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ESj7Sfss";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB08D10E788
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:58:21 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UIZdgp2458373
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 chPx8cXnciym/K6h9a7scU1acS2Wxk7ww2bj8KuF2bg=; b=aysNMnhqeWZvoOBg
 iwxl73FVEJML7ywueCuW9ztNAGF6flWtv1goO9l6nSBvBE0VqOPm6skT3Oxizpp3
 EDPZ1f+gSaSVMPtP3jTX/npZbBBw0AgFk7/aUBiT2fOsOLA9+Ir5bqSKkC/HyI4/
 kXYM6dhQ0wAyOPvuuPPMidPiqtOyI2VGYV3u9gAxyohmk9C7xhuLYXzd3zu3mZHo
 D5C8J/Ld2QNbLNrBo9IomQk3XQ/xBc0kQVhKfDFWF6lIOHX/z7pGwmIdnjX/KMSm
 R7KkVQWsbhAp97MU1iHSWhztfvUTIIF0s+d/XjIdGwQApwdEItevRI/aFaedqR5O
 WFKYQQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmu0ay-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:58:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b242062308so78755505ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774904301; x=1775509101;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=chPx8cXnciym/K6h9a7scU1acS2Wxk7ww2bj8KuF2bg=;
 b=ESj7Sfss0IYqetEjMlGokvtqu0X7LSmpp43y4N4au3q8G1A0wbzXhMMy2I64TvJYsM
 rmuu16wOxbIT+ehydEi1+DQq0KhyWOtT/2yL/3o0/l6CiZYZkOtS50lVdQhkRfXEOYeP
 Z7vPe9wNNfazAKZ0eg7OWRL61bvAHFrKvaNPNALWjTg5/y0724pR+gRxpT9+G4eRUgrF
 ias9wU8d3DYVrVqcpMcGAlHDIb0oIWUm/DnPnkMmVepA+1iXWwRy2ayDa0A6Dj8iEtB2
 JWswfzEDtF0LXVX5M5gbqwdHTUFqmSVjwAlKLwsXa4nHVe5A7Dg5CUqoptTklxp1lxH4
 Bnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774904301; x=1775509101;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chPx8cXnciym/K6h9a7scU1acS2Wxk7ww2bj8KuF2bg=;
 b=rAATDKQwDIOhnbLYTO4o2SzYwIOV57sBXGs8y45+/NIwG9t9OtQovkJsq28gGv279L
 TuBNowTRiuSc6p2hMyxTyc3cdqh+aMf9/d1S0kODM2rlheaEF3zLYRDfvP8+ZbV38IdD
 DNMJcLlkZv8OOMKXj/8thkCQdd6TUMAEPr4DAqqgss+1ONLZ28M6AUVpDLn9t/42jP0V
 tPNLWXO5Zo24t8O14ZNf46zm5EciSxppLqCsdHHcJmgKMYyy3py0lmKsIOYwX9Tqn06P
 PFGxCgk0tSDdLa4p6X/tRJoCD8/zUulKdxn7JRWLV7MWwIQs5Gqn9HYKDcsUzyYnRxPc
 022A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+o9XNURn8kCqoQVtqzN4JcVsfpEpZ87SqSw24dcMS6B7Jm0bQQnrlyfUWUIGLmAo2njiwEH8owzw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK60XRj8LW6om16Yy9LMl+LdWXthS4biwxVlb7Gx/4AhBSysjH
 qf8mT09HXrcQ+ZTgZNIniL7/rMoC50xzmB/rrzACnV4vjJ9CZVmNHyxlL1tGNbHngZ7VuW0Lkr+
 +D7SoDRuNKObZP8+81iMvqnUvQNTL/oqgoMImmuzDI0nGqpjfoApsG2Lo2h76O0Nan2M575c=
X-Gm-Gg: ATEYQzzM79WHa2rE35WpswfRgJRAHLFIk/yS681yF2SGHHZMv77T8jmWjWmkYqlAycE
 sTvizdNcY2K+9Y1XWx4uSdImQJCIarewtH/zVCMOXbDxTOhVZUllOZsSIL8ef8iJ7f/iT/M4rg3
 WWjAiOjT+TswPbvFoZD4WV+fRskeLv3kF26gUoKBBlTvXrMbfVpa8a7InQOblM1YWEs6bwBMPf5
 PeltuTJvknX+pqXqxooiS86PH//Id3qhJyTDgZkcvpp7+NRfAZMkC9c4F3GMinV0BJK9MEvn8Eu
 D5xT3X8iGj70GaDyBL+dHnrJBGgMCgJwL+6r5cyn3S5+dVKzBt6vInFmz5VU7SWpow1cD2Syrq7
 WQffi3qwauR/L0/xa6I2nrS7Yu46aKMRL94/AMvZWh1aA
X-Received: by 2002:a17:903:230b:b0:2b2:5091:1c0a with SMTP id
 d9443c01a7336-2b2509122d8mr60116955ad.41.1774904300679; 
 Mon, 30 Mar 2026 13:58:20 -0700 (PDT)
X-Received: by 2002:a17:903:230b:b0:2b2:5091:1c0a with SMTP id
 d9443c01a7336-2b2509122d8mr60116645ad.41.1774904300188; 
 Mon, 30 Mar 2026 13:58:20 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242765b93sm97317885ad.51.2026.03.30.13.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:58:19 -0700 (PDT)
Message-ID: <d1122bb6-da47-4089-96d8-9a3e7673fa0e@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:28:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] drm/msm/a8xx: Fix the ticks used in submit traces
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
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-2-2b53c38d2101@oss.qualcomm.com>
 <438fd5f0-8a03-4d86-bc5a-6fd32c7a6480@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <438fd5f0-8a03-4d86-bc5a-6fd32c7a6480@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NyBTYWx0ZWRfX5Ic3RkgcB4uo
 LlOYhuttQi2s1NoYXqCUUss00wUa4enWiWHucYDUp8LcEJ9VOxmvJ+FH3otkuubTZR5DhbvsSxc
 X54+jDr9uilUW/nwATW9QINs5zzvn7kSJNIArgL7KOXtj1MBQIM/cpLpS2PKGMHj5OOxuc4L6aS
 HCy6rApazhkfk4Z6/m40jjjXmIvKGvkrLdvTFujmZEubpEurWki7lb/DfazLspxmbi81QrI6Zep
 6AkldNYEWiqCUjkyHfG/bR/rLUJOZETXt6NxhAzYA5/fCvjqbT3Gmj2mjabZZEQdcR8iUk9OCt3
 4jMiTDYCpbBIZS9adxXy4ZFXeUSB64Zel7fGemkfAmvIekovtx7+rrYgeahNIgytrEUxK+BHroK
 XRH9VIV6uqSYWqaAUTsUxew1DNn1NQgyiTpQGr9qnNtFLoDD+FRWE2StwCKZWN/13617UWB/DFb
 B419WRZVDVTf3LariFQ==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69cae3ed cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gMX6-vXHZE0qzWHLqhUA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: OvBq9dnEZOYKtkbSuYI9PjPiHpdxsRHJ
X-Proofpoint-ORIG-GUID: OvBq9dnEZOYKtkbSuYI9PjPiHpdxsRHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300177
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

On 3/27/2026 5:07 PM, Konrad Dybcio wrote:
> On 3/27/26 1:13 AM, Akhil P Oommen wrote:
>> GMU_ALWAYS_ON_COUNTER_* registers got moved in A8x, but currently, A6x
>> register offsets are used in the submit traces instead of A8x offsets.
>> To fix this, refactor a bit and use adreno_gpu->funcs->get_timestamp()
>> everywhere.
>>
>> While we are at it, update a8xx_gmu_get_timestamp() to use the GMU AO
>> counter.
> 
> Which I assume does not need the GMU to be in any particular state, just
> have its clocks enabled?

On A750+, there is a cx timer calibration during gmu resume to match the
GPU AO counters with the CPU counter. That should be complete before we
read this.

-Akhil.

> 
> Konrad

