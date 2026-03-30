Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C271061B1E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC6410E7FC;
	Mon, 30 Mar 2026 20:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFQtz7Wk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lf/kA+Sh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33CF10E814
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:35:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UFUJFB3176217
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 guwChP2JB35bD8Tpnpli7YeuFlRkULCvUEGMKOMKsVA=; b=KFQtz7WkbEiQU/8S
 LtbpQRQGaQlm2GEgzn2tD7D9xZ5IhSLgzMKJVxZdenO198h2NFV0cVzSMYG4CaHK
 RfCbUaBNyIrH2y8KW330mSnQyM4koj7wp4hjEvY5WlO2Z06/tkt82ysym7qouNbT
 AtI6SSsaDfFd4a80TItFaus+sZnQzR1NDabwZmgPZ9bQYjno6aLCBmHb9gBJmc4i
 JomMviOOp29Y16GMX2hqSz04EcFhaW7fzd6E3xePz8nPVdsGOv7FjIsfZWbdjm1G
 G4L6O4u5urXbJ47qgNm3IFMXqFfDuccJH+e2g9bwPWFvgcu0J4rL/zY8umgdE71b
 ipPcgA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h2bwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:35:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d9f68d00fso6295829a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774902921; x=1775507721;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=guwChP2JB35bD8Tpnpli7YeuFlRkULCvUEGMKOMKsVA=;
 b=Lf/kA+ShlRI++KMQWJR8VBY4+UyLkUDkgOXC0PQpO9d/AwcfjMSYX2FAs1MLS3lw7Q
 iMZa3xpkGA7M7n3vLNVHiN7mDFO1hlhUzrPzxdsnZkKbDC0AxaqglNAnVQ9fz67Ui1zx
 T1NCK+tvm8iC1qwD8uUSzMxzLotDhjjFm6Df6ZSpBwF+vyG3UDhOBgcLJE9OI89UyY47
 osxsF/rwuhchVxg9UrKL2uL52TdOnexbm+dliKX6NMa6ugudoD2yXKuhoZ/bRcaDpd/5
 Yk2NReuJSiN5FzjscID0vAnROC82acFsmmviiQ86LCezv81U3bdxoCrwY9w+PW/E+OWq
 58yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774902921; x=1775507721;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=guwChP2JB35bD8Tpnpli7YeuFlRkULCvUEGMKOMKsVA=;
 b=tN/wGQPOp0UyEyqaSPRmHqSzPzS9xKDa5u4Cw8wxXf46oQuwk6yht3vkcLKkA4rmSL
 gA46BiS9uuWq4BhOX1A9vBDNvsCFkhSHz7+w5QOSPgMTb18g3Pfyo9aHarES40oyS07I
 xZNA7nOaKNoq6s1fJquC8O3qllAA5O/j20PFWpQMN0gOmHXJIfTvQq5lRzMqRFj0JGVr
 dzXzQmj2PpkjZ+io8PiYhfozlHrot2xQTn5QsVw9OLhi1IJfc8yRwrTb8BpeIyf70LkR
 PJyUPM0bVXmAk4MCaQEa7oGo8iU2wsjYNiT9cmWP9PudwiPJKqdFa0P7g3vHtITdgj4p
 Dowg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4IQpHtl3EMd3fWmIlilMsgebJTOChairuDt38UYwEv+I7iMbBOsqvf6Gz2QY800QQxBvb31k8YJM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj4uBVjfLyb5Wo4HUDs1yEk+KuEgVoOE8D4zYlsdOc/A+OkK4i
 ySVfVk9iTjXU0zFV2iIGzdibN1qcYSXp6bk1dbrG7Z8e/9NQGk21sz3+hZEZB1uj078coy8PGm3
 nO9eAh4JIBi/g4j3kgOrMEzg3pAn+3Y5V2dt+N7KgODnJojUE+A4bsEyraHiy0kaPWWBYd3Y=
X-Gm-Gg: ATEYQzwjNi4tjmD/ajtsseGqRGmOTdpU+5yUc3N69SPrAeBAWfaNze313rW6L8zEJ6K
 gDlIvuwG/wPZChaZLDoYJDr3Dikbi/J5vK/nDR/W25q4ZfQqERKUpcCkouxMzwW4QWi45cI+d1N
 FDpsldCzjaETDaVrHE36LuMO1hx/bwaGoR/W5A4AJt43waH+OGH2wl1KcItdj76ifqMqro4RrXh
 F2KItrVx46U556PJB4kLoCTAEqKxuawsOtdWHnOk578Rbmnqqalpx/J+35lfJ6dIljxw/3a4I76
 rS5BYCB3Cm4WWx80dqg7ZjWIA+At1ib7CZTcdntBpD43ddtZtkZoM0Ov0Optm2t3+kxjrAHW+A5
 MrlNI59EBfVSE3b7DPEfRdbuXpJk36mSlIIXriSQde/se
X-Received: by 2002:a17:90b:1c0c:b0:35d:a90d:580e with SMTP id
 98e67ed59e1d1-35da90d5e92mr4756123a91.23.1774902921622; 
 Mon, 30 Mar 2026 13:35:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1c0c:b0:35d:a90d:580e with SMTP id
 98e67ed59e1d1-35da90d5e92mr4756071a91.23.1774902920918; 
 Mon, 30 Mar 2026 13:35:20 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35d94d289f5sm11589377a91.5.2026.03.30.13.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:35:20 -0700 (PDT)
Message-ID: <141b1d82-2377-41f7-89cb-3e8d9eec340a@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:05:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/17] drm/msm/a8xx: Add SKU table for A840
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
 <20260327-a8xx-gpu-batch2-v2-11-2b53c38d2101@oss.qualcomm.com>
 <0c26faa2-f5f8-4d77-a69e-5e18dc5b6e80@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0c26faa2-f5f8-4d77-a69e-5e18dc5b6e80@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3MiBTYWx0ZWRfX54zAsENrrXB6
 BSQqrIU2EyUklKyJNcKLxjrsspkdlgcwKjfvEZoEh3bfXp2S73k+sEnzYTi2qWAPFCryO/3fdAi
 lJaQPW7eYxIbF8nAly7t0Ast/YrXe1coSH71Ov3l9f3pFfRyN9XIPr1BD7yMRE5uWTstizlp3Lg
 5Ap3ZSfAX2ltblrKW0gBrwVx68vr1IqLPHghiS7ReNKeUQkREXrDPrmSbTtjp0zCiVl4Mjm+zbU
 zR9BaLu6mccH9EtF0RRp2p/DtJyRS4K6YKTkXlTzVfo3XAH6nzwuSTKDlZMwrusJp0UjeuoaTmc
 fMMvgglQ+ZjeykpVG3RotQaN2lBbsOEvIN4bK6WWlqysEzUdur8K9D8K8NshBkdBAMrc05uNIzn
 Vft45nSslIBLpIUovqp3ILGUTxiMwOetNy4orDXiax+l4l5MCW+iKjyI7zSvvG6WdBBYJaVzj1m
 E+oz3TNx/pgJanXFJzQ==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69cade8a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=40SSLCJdwG_cxfYP5poA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: EWUr2JloqxTw4rbiBRt3ihH-Y7-MFUPW
X-Proofpoint-ORIG-GUID: EWUr2JloqxTw4rbiBRt3ihH-Y7-MFUPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300172
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

On 3/27/2026 4:44 PM, Konrad Dybcio wrote:
> On 3/27/26 1:14 AM, Akhil P Oommen wrote:
>> Add the SKU table in the catalog for A840 GPU. This data helps to pick
>> the correct bin from the OPP table based on the speed_bin fuse value.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 38561f26837e..f6b9792531a6 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1954,6 +1954,12 @@ static const struct adreno_info a8xx_gpus[] = {
>>  			},
>>  		},
>>  		.preempt_record_size = 19708 * SZ_1K,
>> +		.speedbins = ADRENO_SPEEDBINS(
>> +			{ 0,   0 },
>> +			{ 273, 1 },
>> +			{ 252, 2 },
>> +			{ 221, 3 },
> 
> FWIW downstream maps it like this
> 
> 221 -> 0
> 252 -> 1
> 273 -> 2
> default -> 3
> 
> although it's of course just between the kernel and the DT

Right. It doesn't matter as long as the DT is aligned with this mapping.

-Akhil.


> 
> Konrad

