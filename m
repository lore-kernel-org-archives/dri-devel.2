Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B98FEA824
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955BD10E847;
	Wed, 25 Mar 2026 10:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTz5gDCt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZs1p0EX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BF210E845
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 10:00:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P4ExeB989005
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 10:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wUAfXeafFBwWr30Ieze/5KFQiGM9ADTdz912cIXW+7w=; b=iTz5gDCtgzwvyrhO
 fCItJzkDkhdWjdZ5FcpNCD5mQoQQHMFKnmoiQNLH4XnsJL40miAZWKm/iP+cxORl
 HQj7eajfp2+6jAQ77jFPSJyf8UfEFPWjU1GwZBw/tVtveKAot0d93vz95RL09LjJ
 G0XbiCN2MeQkbfq4fB/L+xuuqTUrtwRfU+LoNk5HCw5J3BfXqG1lw76Xoxmlj/wD
 ct9CQUZK0jghoBbVmONSUQr9jelCErkLW4tpiTLhKOYC0OyFh4O7NjfF1+mIwA9/
 ruCmG0zBpBiNTnXTjkoRX+bpsai6D0C8N37sD9vbXh6Nxbtb7WXp3R3RdBAUZ4Ti
 YaT6+g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m46j4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 10:00:55 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5ffeafd52e3so355221137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774432854; x=1775037654;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wUAfXeafFBwWr30Ieze/5KFQiGM9ADTdz912cIXW+7w=;
 b=UZs1p0EXL0oz6qYxbAc4+U5hTBQOQLR7iyK2wCaH27WM2/2qTjsw8faRuHRxW71D+k
 K/nil//W0LSjNrpz2J9//u1FyGdrI/EFpIBqp0FLhsgRRiYllshhlszQ58071LK1e0t3
 qitLsRrsooUfILyQ2/4+j+v5QDg1Dk80o7UpPhKrT+rs9ezYUIH04CVPFhxqr4Tmh+4i
 bHSLWubFCsINjar3I41Ld8+aCYjE48U8yqnRjyGdFVemach3B8dHG6Yrv11QBo+Wuszt
 3+LOUD2ZGfZdV38q5YjSutc19P5zF3LGwtaiGZAk15iuqhzWutjb+fmntnoruwZF0KFP
 VLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432854; x=1775037654;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wUAfXeafFBwWr30Ieze/5KFQiGM9ADTdz912cIXW+7w=;
 b=hLnarfVDUeihkLSBJK1Jb6znLG/JR8wiaNqu64zY72xyEY/eBk1rKr/CC8S5FjXbRi
 GWbicWu7XBBeTHYCcuLtFitgpnDs17yy46OgHwogp9WgrCDafUj47wBZ244uPnbGLySa
 B5zKQzKeyK65D809zWHtII+dWtNuINdq0rXqFr67iMrQR+E9v8ax0UM2etgXdangf3Lc
 HLnezfgDfI8zfOgeSvdy8nSTxJMA20hBWK8PUFnNHHCuBFM6pcm1NcJlPw1FDB4lRexm
 jHEpTs1MeezeZVgHLWB4iTr4O4oqxwY8lYWe3/del/EDZQbipuP03JibEDmH/setkFD7
 ShfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9cGZ9F+CoLDjZtzN02SudcgchJKob1QRjm/yT/auNC0bQ+EtU7d678ikFZgJH5sjyuxiSHN+lss=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5ez4xyympBaNNs/4WyQkpqgpU37o4n9VwKLpJtgulD0PuEx8V
 vdFtEJmgdgAAwxHSs2lRZq3aZNZOtiDT0RJ3yILTivfaE2e7Tdu+KpTiEWMTkjD7XaDDFSJQZrT
 W36WPOMxEr/bnHxxUo7lrkB4pEd6VxvmSoUfY4gNg2pOz5DZwSriSxN6Y6LDlmM206wpPoBs=
X-Gm-Gg: ATEYQzza+khiWi0yvDoeQED2DlAYSh6X86oLYnkIhWvqXTpow1ASzlDdXemf0eDeupS
 L3g7WdRZyGFfwL0wWbuVWGeqjYNzEx93NY+1lNyQL8ZarQz8zS17EHYbxZ+f/pXgP5HysWhLals
 vRhnscLUvMnC8+G2EmtHDTJUnxQ3rstJhlJd+38ys83zfWzLHpQRCUNBSnJ18twmT3lgTusPSpc
 VZVB6nnLLgCNCf/X85+W41xnxE+UfhI/o/JUVc7brCnovORoCH63FKu8p+bSQMTmL7ZA8IDF3hh
 VPL17L1QsYQi/Jn5cQNg+y8c9QbipWPDlivUx1ULOYPE6aoD4HeDWTmSMSRbs35gOfDUopz/HwU
 /WdHySN1p1meySl+zi+QU0b5TpLXJtknn5+3Lkq+SSdXObuPF+ZFu7jcNdrChAEpEqUAJh1BltC
 N90L8=
X-Received: by 2002:a67:e885:0:b0:602:8a0e:f872 with SMTP id
 ada2fe7eead31-6038732bfc7mr487708137.8.1774432854108; 
 Wed, 25 Mar 2026 03:00:54 -0700 (PDT)
X-Received: by 2002:a67:e885:0:b0:602:8a0e:f872 with SMTP id
 ada2fe7eead31-6038732bfc7mr487685137.8.1774432853359; 
 Wed, 25 Mar 2026 03:00:53 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98335de1e3sm772362166b.39.2026.03.25.03.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:00:51 -0700 (PDT)
Message-ID: <101aae08-efde-4d9d-8af2-613d4cc9698a@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: correct DP MST interface configuration
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Alexander Koskovich <AKoskovich@pm.me>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
References: <20260325-fix-dp-mst-interfaces-v1-1-186d1de3fa1b@oss.qualcomm.com>
 <3f33e61e-d244-4600-9ffe-218371c04541@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3f33e61e-d244-4600-9ffe-218371c04541@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c3b257 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=gZczchgc3zH-k75L218A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: urwoVA9SOwpWklCPGB73-aCI4ye-vRHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MSBTYWx0ZWRfXzwyeysEMz1HC
 mQ72qxB55++k5RvwP7YEYCk/ql8P7Yj2QOl8fxVThMmvEAUGwoqk5uVMhijwc0RAZsz89MUMRpW
 CxEHzTDU7W17ZICVv61hDiElTNF7j1PfDruuFRpqTY4a+Vwud0YycZjMJ5n17So4S1AWMKhrJg/
 2tJYBBVmHD4RaC3/3aWAUtEI3L0sEqugBr2B4dWYzdRKsdmi3sLuI4203xDu+tpRlyy/ljr8fqu
 NUhCWrCLvd3Z35QsUo+eA5yzodYo8+BGM/jnCmkioLQ9qdz9p98yEVO7p+d9kbpGdz/HowH5HWA
 Nc2QLJ9p/Lnf3Ew8St63iKUE0F+YT8y4WqJEKf7LlNavL9BIqr18Dr7ZMu8d0SlzNn/lWFZHtGJ
 xoWv/Xq+hKzEXpM36UZdr5TH1p9vjW8x6wH8Tt72NwZG7aWFFT15Ipjvm2iKRs+Jjrs2QImNxUy
 fB3x7e8/wLw+7JOYGmQ==
X-Proofpoint-GUID: urwoVA9SOwpWklCPGB73-aCI4ye-vRHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250071
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

On 3/25/26 10:57 AM, Konrad Dybcio wrote:
> On 3/25/26 6:32 AM, Dmitry Baryshkov wrote:
>> Due to historical reasons we ended up with dummy values being specified
>> for MST-related interfaces some of them had INTF_NONE, others had
>> non-existing DP controller indices. Those workarounds are no longer
>> necessary. Fix types and indices for all DP-MST related INTF instances.
>>
>> The only exception is INTF_3 on SC8180X, which has unique design. It can
>> be used either with INTF_0 / DP0 or with INTF_4 / DP1. This interface is
>> left with the dummy value until somebody implements necessary bits for
>> that platform.
>>
>> Co-developed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
> 
>>  		.name = "intf_8", .id = INTF_8,
>>  		.base = 0x3c000, .len = 0x280,
>> -		.type = INTF_NONE,
>> -		.controller_id = MSM_DP_CONTROLLER_1,
>> +		.type = INTF_DP,
>> +		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_8 for DP MST */
> 
> with intf_4

Otherwise this is all correct

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Luca/Alexander, Milos will also have INTF0+INTF_3 paired

Konrad
