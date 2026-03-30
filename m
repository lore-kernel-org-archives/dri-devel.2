Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794C11061B1F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7C010E7F7;
	Mon, 30 Mar 2026 20:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRs6zXdV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e1J8w+8p";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AE510E7F4
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:34:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UIKks9703491
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GGvHmo/XuIHKu6RSmajSbZfGYuTsJcvqIRS6kB5ctsw=; b=YRs6zXdVjv4lA3Vb
 4ZSgQmNHGhNNi1t/Hcu8pBkwxkhBjx5QGgAiMlD7EEQ3ooSVV/98KWcJ0DL505f5
 ynQGDMBwWu5eMso83EOU1AzqwQmpKZfhJj7pLeX4RYMlPlvfWEzZ62kbw3BwdzGM
 Yus3vr11v4lJIWG/I6P1m9kV6iCz1DLyidaUyynFuwszY3JIOmXGud4JSmjPuq6Y
 hqRrmeQcQarCnDnHCFRAQW71EsBgCuO6NupRhVpAa9K3er95fpzk56S6fcNUNIlv
 q+mydM2aFAFiho8Ni04BD29VyfVycK/tLuhU2fYWYLqwyuDqwmF+nTCrn1y/qnqC
 4em6AA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7sansutx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:34:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35dacc40f92so1284715a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774902857; x=1775507657;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GGvHmo/XuIHKu6RSmajSbZfGYuTsJcvqIRS6kB5ctsw=;
 b=e1J8w+8pdEqaQUnNviWn+A+y/nn0WWQPbn71ksTUt9Y2BylO9+vPGmkEhea3lWIf8s
 R6Iqj+LVxrwNgivJH4vrwxmr3f3Oo8ietqHW6lnvrmj0vlFQepDLIuXULq7h31Y7gjnZ
 27j9oqLIoPgfrbJlELnpGdua2R8z/gj+Vr30qcFpXWpOWj4O3INSKJPDEZlOBw3gw2SZ
 mTXF6+RsuwYoubod15gXeUuQg3Vu+E+p1Hdl3BZBNzx2rhFfJ8aG7LkYuw466PqwH8Lz
 xBtks+zDFra+AgqFMYGj0pkt2zvTxNHAZ+pFmY+ceIGHYfl/8qeLYRXg4yS55n1b5BAV
 lp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774902857; x=1775507657;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGvHmo/XuIHKu6RSmajSbZfGYuTsJcvqIRS6kB5ctsw=;
 b=sVw159paGNKKxTyBOw2ticN1N48fOokdK2SW/vEnaf3py88NBTZx+frGl4k/MO2kQ9
 HgzlOqSxIXZZnhTa8o0TwTdatv0e/KPmGBEaSIZwqq8OBLusJxK1enZi/EKujl7qxdiw
 PPsSaBOKZwAr9EWIvOpHcBrB3CqX98ZdglXk2zUx7pVGjbqX9MpJ4Hyx+pHfUKeq79IE
 /f0XMe04uB+e1DF8alg4j9QktlWsDTkP1lpJStE3uk7kcgwHU5q9jt4WRdFqwvwUyblL
 8q8aNEzY8lMOTWbhNKJysJkWmiaPcgmGIbG636yOuufeskyfdX5mm8hTIOj6VNBFGNrE
 85eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJNnCQow7OivE6x4V/066SyECprJHjYioj7hj7J2wnYP7LP4k925vwGcV/NFrKBaTEX0U6PIdnsj0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxx+G6g/l1N3WbH6m9Vfpp5LAmxBvSc69abv13/hwti8TGhINmF
 3hGiM6PEV1WAQolDNcEFbBSr0RCZJ6cWpRlcMPM17M+LrRWRYTDRmegBE/cM8xPPYUqnGhbRNLJ
 GkGSHQxNi+KgrY8IlXkVD8gopXStu6tLjLMsfHKe0/945I5u9Cd57OiqKB4kipHQyM+1InfM=
X-Gm-Gg: ATEYQzy0QoH0fuAgohHe3yBP3cN82YsVXtCm6UZ5j0je2ajp+k9OHRVzKoazt6J8eiB
 8EC33rSt3fU3idJ6yFMV/xLd4biy7bQUKtu9gNDHDGzQ1XgvYUtE49oc32AgRMqE7EBWg6GGf6x
 FNnfnQi8ri9SWHlY285vnVw+x2zt4QrXvcPpSM5mHau2UsUA5PZXGIQQSoNGnX+QBppzfa1nt6j
 xqiSdYGfeHeCwf3SxhKK/+9eA8mxDpZPKHf77siGJkp8RN5Yo+eJxo0jLEDGERlNUvMjd5nFKt6
 /pifIkZqenA//8U5WIJ/djrJ6GHtx9Wl2f+nEjoQUsm4XUuiO5t0Pzanbb23FF3whjvdS22u0UB
 tx48WC3I1st5Le8U1Xn3wGty3A851rTbTOMIH0mfVvof4
X-Received: by 2002:a17:90b:1d11:b0:35c:a8f:5c5f with SMTP id
 98e67ed59e1d1-35c2ff6afecmr12444983a91.8.1774902856888; 
 Mon, 30 Mar 2026 13:34:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1d11:b0:35c:a8f:5c5f with SMTP id
 98e67ed59e1d1-35c2ff6afecmr12444951a91.8.1774902856401; 
 Mon, 30 Mar 2026 13:34:16 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35daaf2a70dsm3488317a91.11.2026.03.30.13.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:34:15 -0700 (PDT)
Message-ID: <1aa49c9c-279d-421e-879f-d0d93728841b@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:04:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/17] drm/msm/a8xx: Implement IFPC support for A840
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
 <20260327-a8xx-gpu-batch2-v2-14-2b53c38d2101@oss.qualcomm.com>
 <b9f8d016-e22c-45ed-a50e-51e18f5d6e6d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b9f8d016-e22c-45ed-a50e-51e18f5d6e6d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DoBzkHSNuczwZnskC0wDcxeM2rk5gIP7
X-Proofpoint-ORIG-GUID: DoBzkHSNuczwZnskC0wDcxeM2rk5gIP7
X-Authority-Analysis: v=2.4 cv=NofcssdJ c=1 sm=1 tr=0 ts=69cade4a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=khfaMGtS6DP7kCttXrYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3MiBTYWx0ZWRfX/yZUqCtb/W5L
 mEnu8hj+RD3XL70EwbAsLiMbD7m3K6HyjF5LGzfxb0qVYOZyd8ZsBFQTFxszI4gSv1dCmRSs4mX
 cZ210ZH2QyakVQ+tT53yDlhGBlMXUgSmzWAate8zW+hynq0CZk+OZuiOd2U9ynqkCLzZKIXMwUk
 1uq/ryNQKZIi5Bh4UUBtEXRfdBWFqZNXrcMPQSFHdypALolRmTdWNE1wFxh0jDfE8gkl+sP1ica
 BgaCC9F4LtrkriHEcGeQOM7uHoqsi9329VvRVxseDLq2Kyd8CLUb/ds6BNZyZPkCyhIDKZPEuqr
 kTotR+PYlIQNLxZIKH5WjlDtUBTWGiGQHauynYW8NcGVMdrwCAUuR9YUjexD9REBS8HAG5MMEIo
 1w2Ji1pAwL+yP/M3tfSy+N0eAkfmYXS1hGTjRAVy4j0xANgDB/WLbUw1sKnk2vkAvKGY6I2eLe6
 qj/kjPTEXAP+I0HSMCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300172
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

On 3/27/2026 4:37 PM, Konrad Dybcio wrote:
> On 3/27/26 1:14 AM, Akhil P Oommen wrote:
>> Implement pwrup reglist support and add the necessary register
>> configurations to enable IFPC support on A840
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	REG_A8XX_CP_PROTECT_GLOBAL(51),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(52),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(53),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(54),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(55),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(56),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(57),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(58),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(59),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(60),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(61),
>> +	REG_A8XX_CP_PROTECT_GLOBAL(62),
> 
> 53..62 aren't listed by kgsl, but I suppose this is more robust
> 
> Similarly for:
> 
> SP_CHICKEN_BITS_4
> RBBM_PERFCTR_CNTL

I can see SP_CHICKEN_BITS_4 in the recent kgsl code. RBBM_PERFCTR_CNTL
is required as we don't handle perfcounter management in this driver yet.

> 
> The other reglists look OK
> 
> [...]
> 
>> +	for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_DDE_BV; pipe_id++) {
>> +		for (i = 0; i < dyn_pwrup_reglist->count; i++) {
>> +			if (!(dyn_pwrup_reglist->regs[i].pipe & BIT(pipe_id)))
>> +				continue;
>> +			*dest++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe_id);
>> +			*dest++ = dyn_pwrup_reglist->regs[i].offset;
>> +			*dest++ = a8xx_read_pipe_slice(gpu,
>> +						       pipe_id,
>> +						       a8xx_get_first_slice(a6xx_gpu),
> 
> IDK if the compiler is smart enough to pick it up itself, but
> you could do const u32 first_slice = a8xx.. beforehand to save a
> couple cycles

This code is not called frequent enough to worry about micro optimizations.

> 
> [...]
> 
>> +	if (!a6xx_gpu->pwrup_reglist_emitted) {
>> +		a8xx_patch_pwrup_reglist(gpu);
>> +		a6xx_gpu->pwrup_reglist_emitted = true;
> 
> Would this flag be better set in the function above?

Agree, but we should update a6xx_gpu.c too. Lets do that separately.

-Akhil.

> 
> Konrad

