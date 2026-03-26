Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE7E10AB80C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D7910E0D4;
	Thu, 26 Mar 2026 19:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEpVVlGq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frtGgJmk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B26610E1E5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:33:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9eY71666548
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P6zDneLAI+dFgFezoOZsrgNyIkV7FoVpzC9Yw1wzYoU=; b=CEpVVlGqlQv+naoL
 50X31IgRBH97q4IuXtxL6pQu01uS3bRCKnRw5IO4tN56vBSwf+D+FHDn1+zjlw+0
 Qa94UPjoLxh4aANcYtTiXB+3aPnSstCjLofDMlzbfYCDGO51dYCRaDiozP8xmLc9
 K3HOUOQB9eQLqWU9G3shYKuTt5/7ocDqWm2NKiDg1xi/M8K3BumMQPblqCh/meZC
 JaPTqzUo4cE9Ek5rlL0zhnSy4n2VFzN9UO6PtEAlBCcephkTSQdr2EKJt1yqq/3a
 jHmpJ+2+qgeCwynMEcEazkKNB1lhk8oP1dyf3jiHPRN4e2B6DO5sqY50KfWcwdmt
 i0LZUA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4tjakp6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:33:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82c649dc145so905814b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774553586; x=1775158386;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P6zDneLAI+dFgFezoOZsrgNyIkV7FoVpzC9Yw1wzYoU=;
 b=frtGgJmk1KRmX5Y8SC2wvCFB8ZaPp7CXHCYJPQpFKNrmYWDYX6RjPgPGVaunf3V0lu
 6BF7gbOxFNhjzTGlZP80va6HhKh9+DemLtNC0ih49/q2oaixjStYkIcFSxIz6kso0b0+
 2Qke8rtN0BvQGYVyHCmgcboZLwYZnIAgz9/qVdTg9+i4SW6KjxzNkLvNozl6ND5QidSl
 NweKR15E1ukbhORRDcuIbqerFW5R+mczlDi8hjTkLdacgp+PL3LDzQz5O09Z7RWCMUcJ
 JiB/BjqSMJaiJs6XT3/TZT630DegpuYEYZSQRddzg857oEZNs/10yKl02IfpbBR90dBc
 ZZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774553586; x=1775158386;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P6zDneLAI+dFgFezoOZsrgNyIkV7FoVpzC9Yw1wzYoU=;
 b=GyAxhhWUCr7AhVTLlSPzQnaIza2QSBoWuyT8i+kYeHpRg1yWM3VmKR1PlGH/miiNLe
 OoqhkIgbJ93iQ8OprASOky8UYWf60iRvOZDLR974EOiDT17KzAWiiEKum6hgTK10JIly
 qENtJgtzRYTXehBzw7WfdBmAPylIFfwKpbl9fRKE3O7LBSP2KJylQkOOY51ua7XkwGAE
 OniVOiyi80Rka36dEjssf/yskOAoats73rPrdNYOgnESvygHds9lKf07N0bj6rwoTqpL
 SnfGbb9+81B5O861yfoz1b7ktc3BDZKu4Rq0McHenzeeNf1YbxEMLmiWgOqc4jBPOlr+
 bLCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD9srpdPXLUmvzuDh31Crt48AngfvkokRLypNn9wgd926O+PRSX7134A9ChH1+v5Drb6AdfqIblsU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwekB8xzWhp79exd8fKsCReuP7dQ0kQzCdO6MHnXbTKYu16Rx6/
 58wixjvbYRVEfo5iIcSEQRpiaXIDVzeVzqv/7ERLHCUoz+bNo3LOnrQ6kuPoJYXL2eu2HU8MXUt
 GBzAbzGYGhqEIux5sYhHucwJxDUzIPczJHMq4lDeecpwYnAjxbUHB9+75sKF3YiJQOHTpSrU=
X-Gm-Gg: ATEYQzwet4FE/GHyKifzGkFjsuKVc3sZCfvvuxfM1B2skQvY7TkGFU9cVDuBbMd5PM3
 GWnkbQ1zIj23U5M00jvL/PTYRYtrttqoekeDnvG2WL+YJy/Abu334aFL8GuAqFGHLH5gLkPa+PJ
 mKRrS1dhIhd/qygFYKf60ZxEnl3k5emrmGI2fK3o4oWIBPKRHEpagGT7Zs2iA2NDB62PRiIvzcE
 sV4idZXHetkpi11AtiXjwvm98DJ/DANKM0uxq6ughcFC48cWSPDP/Q6oq3lsyNkY+ihFQ33mSDD
 +qxhHbmJLScLCEFUOtStuC20iVXnJ9dju23xhn8vAKpuWhOKg9h1bpD8alwLfPtADPvwjaM41fH
 Lw5kYIemFWT56KJzoqUoU5V2tvz/H9ra8/f1D/32uSwCy
X-Received: by 2002:a05:6a00:194b:b0:82a:190b:2225 with SMTP id
 d2e1a72fcca58-82c6df6202fmr8356397b3a.31.1774553585487; 
 Thu, 26 Mar 2026 12:33:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:194b:b0:82a:190b:2225 with SMTP id
 d2e1a72fcca58-82c6df6202fmr8356344b3a.31.1774553584960; 
 Thu, 26 Mar 2026 12:33:04 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d1e6439sm3444265b3a.11.2026.03.26.12.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 12:33:04 -0700 (PDT)
Message-ID: <3127ae70-f9d8-4881-ae66-5231833e61e4@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 01:02:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] drm/msm/a8xx: Implement IFPC support for A840
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
 <20260324-a8xx-gpu-batch2-v1-13-fc95b8d9c017@oss.qualcomm.com>
 <54b03221-d21b-4582-b0b9-d2384480356b@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <54b03221-d21b-4582-b0b9-d2384480356b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: o4wkoIP8JOEWahlaDttx-sfxH84jN3rJ
X-Authority-Analysis: v=2.4 cv=Nr3cssdJ c=1 sm=1 tr=0 ts=69c589f2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rL-UvztjHAg8Z-035zcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: o4wkoIP8JOEWahlaDttx-sfxH84jN3rJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MCBTYWx0ZWRfX85WWd/FyPc2E
 e7LF0JW0hqr/uMr38lNyPpm8KhBGp5eM26pVqKnfUPvmSrcCyjaufMdp3MExKpXJ00y11EPL+bU
 +90EizLeVVNWXnG9kr0XvNUkoqEffwP3AoZWgwuM5bgPK1/v0gO25+kjdtk6pL8j4Bolaz86TI3
 hLTRWg20R3tCzTBbI00gbLTmYW+v8Hy8E/pG5ZIk4GzXQopTnF8dyTeO22xPfzvihzdg1rQSpjm
 27SeWUhzl0XQH9PuoxFG7DTqwHwNePkyn1xKaAY4NBq0h1r/KjP6LR3nbdrH40gQB3fytOUp60l
 59pnaVR0d8SGFv2SRr2wvO78Byz++TUYYGWKZLZB1tumBzg09ZuaIMmptEHk2q2xrGy1HixlDIy
 9/MRomOkAE4Vyx2MCTvyTtnyI72VsZ9Q1dOa64W4+otCWtyU43f/NZRmyAEc32LtPQpov+y9Uwy
 5S39J5lRqmBeNgSKmRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260140
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

On 3/24/2026 3:43 PM, Konrad Dybcio wrote:
> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>> Implement pwrup reglist support and add the necessary register
>> configurations to enable IFPC support on A840
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_DDE_BV; pipe_id++) {
>> +		for (i = 0; i < dyn_pwrup_reglist->count; i++) {
>> +			if ((dyn_pwrup_reglist->regs[i].pipe & BIT(pipe_id)) == 0)
> 
> that's a nitty pet peeve, but I'd check for if (!(...)) instead
> 
> [...]
> 
>> +				continue;
>> +			*dest++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe_id);
>> +			*dest++ = dyn_pwrup_reglist->regs[i].offset;
>> +			*dest++ = a8xx_read_pipe_slice(gpu,
>> +						       pipe_id,
>> +						       a8xx_get_first_slice(a6xx_gpu),
> 
> Only the first slice?

Yeah. I think we just need to pass a valid slice id and
a8xx_get_first_slice() will always return a valid one.

> 
> [...]
> 
>> +	/* Lo address */
>> +	OUT_RING(ring, lower_32_bits(a6xx_gpu->pwrup_reglist_iova));
>> +	/* Hi address */
>> +	OUT_RING(ring, upper_32_bits(a6xx_gpu->pwrup_reglist_iova));
>> +
>> +	/* Enable dyn pwrup list with triplets (offset, value, pipe) */
>> +	OUT_RING(ring, BIT(31));
> 
> I believe you need to patch OUT_PKT7() with the updated cmd count

Thanks. Fixed. I guess the mask was probably helping when I tested.

-Akhil.

> 
> Konrad

