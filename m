Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99215C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9C010E80A;
	Mon,  6 Jul 2026 08:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhXwqs2Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U7fbNtMC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9040D10E81C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:22:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641dNm3623954
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 08:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H7kgDUzxypUi9Hv5ERYiztltz8pc1iThxnESL38uqQ0=; b=HhXwqs2Y0ZsHrIij
 AaX2/c5hNOoJABzdK+vgCCvIRziXAvqlKp+HfEApATvvzOlO9sVSrJzcIZ0gLubE
 xqBeUJ0Ot4r44/oeqRtbFiGUFOsXcI+24UltpPC8iakeix4jwSEjHg8KAnEkv6q0
 ozKG0icp+Jc/2I2XUZE/dzB6e16ku1SYwiAYd0gXoUToBKhts5fkNiuRxdirmiz/
 QNZRC3Kl0sJ3Flfz8XAYdQzqc7irlqPYhDO69z5CHlRaOpMjJSVOtugLSl1SguJC
 JU+WCl1umXijhDcuJFyUpO3C8cubO1nyzL1Mk/Ng7Vsc/y6irFVChjR2wthlmyKx
 O74cjA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4swd00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:22:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8479c6c6cbeso2575282b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783326150; x=1783930950;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H7kgDUzxypUi9Hv5ERYiztltz8pc1iThxnESL38uqQ0=;
 b=U7fbNtMClQALzN5R2MOiBOO6oBW7pv0AaLdcq5Eap0Wj5R3QYf2+mQS5c8416kYCkJ
 +9W2U/G505hwpCvWVK6hBK5khfcJn6s64a4qeUHp5y4r66kqt9eHH9JEyhp/eAe1ZN/D
 t9eh7RHu8uox31BU2t3oU/RmwTm9Cr9THetzh56kif5NT+gGUMPkr0WMDVkjvxACvj2Z
 kKjhUbDyVmWuRcxSaRPKjK93918nztdBmdJk4K8EJUifmZ95WwwSZXJSwDt6lbhEzU8F
 XhV9C+4PwsCDHq6STM0q6tFuB85iok4pZ3sebobMSbLxDVGCOun4xq+t15fb5U0BHe6x
 juyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783326150; x=1783930950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7kgDUzxypUi9Hv5ERYiztltz8pc1iThxnESL38uqQ0=;
 b=QtC/M0/NSbEBxOVUbaHkL7nEcsoPyg3UR4/+JPhgwLfhF/tzBa3rqJ5v2zmMIZpPcH
 95DeQgqZAPP89iwrh90GenTp8dla35PIAqgCIUSYMRV3ffxa/AAVcg+C+TXe2HHPNEho
 yY4nAmGgjXDrKMt12rFZMLjas5aa+Ukn6UBN5gbYIFVb7krTFr5TgUSUgqbezELHgh/O
 oTv27Y31m9ARf2/7FqpSr1l1WUZLm6v4dfPA2HZuqpJq0RgTdKIh72/d42Km9sSDWK/V
 5Ie6YnZ6r77i0UNnlcWavGVId8bqCfQL+gyIdE3Tfo1qMKwn5XSqlWpib4dqGRoCxtTv
 vs7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPMuT3vraiTtc1Vn1HLTAv7DbiTuJawnruTF1xM4AUSzA5y2ngF4BvfoKiXoveGnbnEWIYfu8khYA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3vgtRhV6IF69en8mEIl0r8zDi9PeTnaCDwm2gwsZF8GFeXlwh
 IH1gxDCTnnveFLHprrCtH/A2Owl0jLvwRDLazLipvM6d0Y5+ez4FXJ+hkXvBMKb/SosCt1wweQB
 /hs+j9p+neF1Krf+pe3snJSc+ZnCUDeVBwIbIPT2cupN0ZLiEVrJvLZQCEs26tvsidLStAXs=
X-Gm-Gg: AfdE7clSeDIgYygmGNGGKw31Y4OORjm7x90anU9TAD+nMp3kFn11w3dgiJM/IL2unjT
 XysUsE6MMh+8XEbY5UymK+NylqY2YeVv8NTYywcMkpNLOZXYUfDGRu48iaVrbgmB1seOvJldkxZ
 Ct0TpSbDJqLPqrWCkc95GL2gHaxLOqiIqTwtKjaJV9bbkBNVrbshJ8grYveQZ+4Bm+0RLqxsjWV
 kUuZA4a2IyC41+ToDpbCdGE7LzoFX/umiSV7/1GpJmSjlWbmGiTsJF9e6TZIkn2xQ5bo+CNgcUs
 rbEE6F4gCiRJvI1WH5Fo5uo8ExrwVSGomkW11X8SXlmhvKNGLX45rK+cYg5UlALszqAS4McUypI
 lOwcLLkx39peS5xNqH4iy/yuZ40JBd78IsLyi6U7f63/tLeQ0XA==
X-Received: by 2002:a05:6a00:1254:b0:847:833c:6451 with SMTP id
 d2e1a72fcca58-847f6fda4f9mr8656677b3a.57.1783326149436; 
 Mon, 06 Jul 2026 01:22:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:1254:b0:847:833c:6451 with SMTP id
 d2e1a72fcca58-847f6fda4f9mr8656641b3a.57.1783326148965; 
 Mon, 06 Jul 2026 01:22:28 -0700 (PDT)
Received: from [192.168.31.103] ([152.56.16.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d4986bsm3304973b3a.29.2026.07.06.01.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:22:28 -0700 (PDT)
Message-ID: <b1299875-9fda-4477-b533-f491f19e8a2a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:52:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Krzysztof Kozlowski <krzk@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260705134619.4030745-1-aniket.randive@oss.qualcomm.com>
 <1edb643c-1d09-4ad8-97df-66c86e6123c5@kernel.org>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <1edb643c-1d09-4ad8-97df-66c86e6123c5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX4eWNK82ptviB
 kHEMx5o9d3OUo5nmgWYPUnjoQixnT67h4xn1py1wuz8uR4tSJTO6rzyBDxhliUyJ5344qo+JXTE
 eBRCQqRlenjJnMY9Ajb3j/FcnGzd8nQ=
X-Proofpoint-ORIG-GUID: gZRngQ4I36anxaKVRqAipPhiYxRyw-dt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfXxo3/d3cTPx4d
 sA109rNf4S8Cxnjp72mUdOFtUPL2cIjOjJ1qCLxXRMJ9BwXIw7Ql9v7HHcazHvbYk8k/aTFvuGP
 YCrgRqHuvOWtVFqJIVKGO7ywd3SmXYx4QUHgs9ofpr5UoLcw2bWW9/HvJXcEo9slpgxLQzCJ/ui
 tl5PFJByA+BJR9dh74Cv8npFKv5D94Cf0zdVXr9KPJUVHhxTXW5ORC1pVWpbStRsL/vCLGasFun
 MOoiu5BvEMwbuMfiO1yzPVvkaxxpgRnUFuZ+ATxHNaZ+G8v7CH9izDHCD8PKap/7duuWuQYTd2h
 kGQP4fWBCxhSOAuJr3DYdoaHIpliL1OTQdQ1oyf6kJaHfFofaA+Rx+0X2PI3ygY4BFwJ7iOKcZ1
 Jkb2PnmxT0gtbjRmY9s76peaWA8URuFotdIR/2RXMKGroGGPg1AncbtTMH5Mw77qa5WZJVug1zJ
 1gqFhxU2AzLkMxGbh9A==
X-Proofpoint-GUID: gZRngQ4I36anxaKVRqAipPhiYxRyw-dt
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b65c7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=hhhz2GjkF5S+8y/bMxhNDA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=CKx7tiaC2mrULMmJUrMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082
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



On 7/6/2026 11:28 AM, Krzysztof Kozlowski wrote:
> On 05/07/2026 15:46, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time and a 300ms
>> floor. For GPI multi-descriptor transfers, use the maximum message
>> length across all queued messages as the per-completion timeout.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>>   arch/arm64/configs/defconfig       | 54 +++---------------------------
>>   drivers/i2c/busses/i2c-qcom-geni.c | 37 +++++++++++++++-----
>>   2 files changed, 33 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index faf146441f97..841108ae2d01 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -32,7 +32,6 @@ CONFIG_KALLSYMS_ALL=y
>>   CONFIG_PROFILING=y
>>   CONFIG_KEXEC=y
>>   CONFIG_KEXEC_FILE=y
>> -CONFIG_CRASH_DUMP=y
> 
> 
> Irrelevant patch change. And not really correct - you base this on some
> old tree.
> 
> Best regards,
> Krzysztof

Please check latest [PATCH v2] i2c: qcom-geni: Add dynamic transfer 
timeout based on transfer length and frequency.
- Aniket

