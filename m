Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C529EF94CD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280A910F1FE;
	Wed, 22 Apr 2026 07:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J/AEkkMu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bYNDRJDt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005DB10F1E6
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:01:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M51hqf3083125
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eBGSKr8Uva+BtfeptfpzAP+Zxx4G12UZSHcTVG1Bx4Q=; b=J/AEkkMuXJ4aKR0j
 Q0xfteGZyYNm6QcnqJv2Fyk97Wgj5mZPewxb/aFhHsGhLq6l47ynlhFs21fkqq5D
 5Z7aTz2VsSu3Fu8CuTDMI0BIelyo1kLA8epiLnxRybG80m/AnW/Eh/0xXfKIIIWk
 x/rhjoUt9lsQ1thunmJzMgFfN5OyTKDhBRdhkTBrqeGrK0B1roDrE1f7sZ48CTbV
 7SagRQwG3suU1UaoOOEQI0yZTKEQ1VC1aTcGoS+Dpc5gAJu7sHCd7u3sV77mLtNV
 YoLsMHzYU7uWQ1RmA7Pj4gnz8UDoeeFqqO0h0YTI6O38AZWjH+FPWGutQl5SIEPG
 I7jucA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmj5ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:01:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82cf8dcd079so3365217b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776841288; x=1777446088;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eBGSKr8Uva+BtfeptfpzAP+Zxx4G12UZSHcTVG1Bx4Q=;
 b=bYNDRJDtNdKS4VZ5Lwav9lMdtw9cTJRQcri+2zx9dzIceLZHu9rpvHMLkEnCjAJh9q
 aej3fT2VWrb5iPQEVjQJwpHZaPBpLQAg7n+bLfYiSYJWGVUUp+0sU1kgYJzQPjkVSZbi
 IhY03g3XWk8ZxbS/mrbX//H7dJFpPT+/Lqb2reTmSRu8IYciYeNfinW62GsXpt62WqPd
 fg+AerljrSl7Ik3BxEteFoopWNirWAzoN3F2ojIE3LYx9gvvhXCm7rCMsAC78hd7koOF
 r4mC5XbdCmKQ6ChOo/s0NcWvQBGrSCh6VXzJs+6iMfqGmgSbxHtKeYe/h+80ger8tQ0X
 AjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776841288; x=1777446088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eBGSKr8Uva+BtfeptfpzAP+Zxx4G12UZSHcTVG1Bx4Q=;
 b=OVOrrBIIkXqnGS6Msq2Hg8ZR0aJbMuozA6W6Q/8k9gTNqz8zk42IdCfVZmTerUt09f
 r+yB0LomF1R2uNEq3KuOsZrQmUtZLiFGaTsGHJkTW22b2TL8OVaj8gGIBt+Fxcwz2dpd
 BMsevIdDP6T1S4LAUjyxLfHLqJO4kY3mTcqkC8Td3rwc5EZavFM72ckxKbH/sZSbyfpz
 T30OtC4xqMxhTs1qudyQ1Pwb6trcV7XauneADJKfdaSSN/tXBEcCT3ODXuewJxDEpllU
 Y8D1C89216uCCtibF5bvx9UpVBo5I9h41f5MkRHl2cHfHTrTzrqktaNTro2NgABeLckc
 Lq0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bvt19BQyQMSRQLJBDnhleOWCCv0mDnnk8pXG2QzCyj6lZkQoca2399skJ0gdBAQELMd2ijm7HK5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yym/TgF/vooYWNmTJN2jZbSRY8M6EaxowJ6WSnuaRpsbYbEm6vj
 Y+94vwC59ZyFYxN/mxLn2Dhnz8ELIchSIHZCzh42/ovxtmon4nkiv/o1xlEltw2NGEp64deacM3
 gV28FrQQ94wWUzYKitErhsyH6pCCRK/2WGxywnawQB9a+5fvCvS5hbMLj15U7MRgFybWlP9M=
X-Gm-Gg: AeBDietJwBFR1GA8wXwuqTJzDsqsTtBPXYdoZFURw2I2wU3LJ7OJo04QqmASMnJKrEp
 MDQeCVViAZjiCnGOhJ95+/3XX3P4A3i+XI1ZH8un0lh1iBTIlQbZr2gtx0aWeQRKvp1eNbXPuav
 Wg4zdOBSGHsQ40w9vMaum9KLct20Orei4YAdUWwBnzVTpwNRHuV2lHM/ZRPQb4YPtU4FdrIFAFg
 kGQBWK+UkTz21uxSBdkM10gOySr/jF6AqFtvpUzvuIfuU2ln7Vd8Dnt0gIEaSXikEJycZe2W6Ls
 BqJoipz/KLvyYaSCT7Yr9xpe1QoHnyvwnL1kUhj+5/Pji1po0u/d2o6PF0v7NfYJDaDNis/WVAV
 j1icomKM0660Eum8nOnzzlMcEXICnRpfJl5mR9+WFvLUzMNra1ale6A/2ieeQ+ySE
X-Received: by 2002:a05:6a00:22c5:b0:82c:e670:7691 with SMTP id
 d2e1a72fcca58-82f8c9300ebmr22580065b3a.48.1776841287521; 
 Wed, 22 Apr 2026 00:01:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:22c5:b0:82c:e670:7691 with SMTP id
 d2e1a72fcca58-82f8c9300ebmr22580003b3a.48.1776841286814; 
 Wed, 22 Apr 2026 00:01:26 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981d00sm15665619b3a.5.2026.04.22.00.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 00:01:26 -0700 (PDT)
Message-ID: <077a99c2-c954-c5e6-3699-cd0360e8b9f6@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 12:31:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] misc: fastrpc: Use context device bus for compute
 banks
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
 <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
 <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FcLlbBC3OKythvguz45dJuOB1TQu8nCF
X-Proofpoint-ORIG-GUID: FcLlbBC3OKythvguz45dJuOB1TQu8nCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA2NSBTYWx0ZWRfXzXBf6sKVUSZD
 7l3Qa2RpSrGWOyILWgUb3KlLvIDkVCB3pjvFhN729W7qdugiJvGOQhg/ryLXKeWrwADUYhvjvKY
 aKNFhBkHNH1nM/PGB7lFxSg8zAS1WG7Gsgl2w5pnqNwN+vWaBiQMgXPxTrAWYYdGycpui8xuhEI
 8wEHtta5UUmdmeYH1tZOw+5cbQTbY4QDfJl4QkQ5P9RaClaWigHWwgLjY26xQj2TPWcpah3uqgm
 KCcryjzo8z9geAQW0N9/rxbKvwP41vD4GERMDgzGluppG6Mgmj7ZRWlgcc27BvA+YWbs0pREXoy
 /IPXHdZMbCjJAKCmVC+ULkzuVn/ZRnKnTE8U7t1sbUycGzGRlHziR943TTHd0Yzfi+03nd622s3
 EawLfT/tGpq6HwCydunBBhVR+7KQ71ZrfOqZNqW/nx/1Tn57F2I4qVfHmtrPoj/Hr2IeJlxnyR2
 I/a3B+tIu4fGqrT4RAA==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e87248 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N8QG227OEIr4kTigVUgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220065
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


On 4/19/2026 5:46 AM, Dmitry Baryshkov wrote:
> On Wed, Apr 15, 2026 at 09:35:47PM +0530, Vishnu Reddy wrote:
>>
>> On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
>>> Replace the platform driver approach for compute bank (CB) devices
>>> with the generic context_device_bus_type. Compute bank devices are
>>> synthetic IOMMU context banks, not real platform devices, so using
>>> the context device bus provides a more accurate representation in
>>> the device model.
>>>
>>> Currently, fastrpc used of_platform_populate() to create platform
>>> devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
>>> driver (fastrpc_cb_driver) to handle probe/remove. This approach
>>> had a race condition: device nodes were created before channel
>>> resources (like spin_lock) were initialized, and probe was async,
>>> so applications could open the device before sessions were available.
>>>
>>> This patch addresses the race by manually creating and configuring
>>> CB devices synchronously during fastrpc_rpmsg_probe(), after all
>>> channel resources are initialized. The approach follows the pattern
>>> used in host1x_memory_context_list_init().
>>>
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>> ---
>>>   drivers/misc/Kconfig   |   1 +
>>>   drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
>>>   2 files changed, 125 insertions(+), 56 deletions(-)
>>>
>>>   	}
>>>   	dma_bits = cctx->soc_data->dma_addr_bits_default;
>>> +	if (cctx->domain_id == CDSP_DOMAIN_ID)
>>> +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
>>> +
>>>   	sess = &cctx->session[cctx->sesscount++];
>>>   	sess->used = false;
>>>   	sess->valid = true;
>>> -	sess->dev = dev;
>>> -	dev_set_drvdata(dev, sess);
>>> +	sess->sid = sid;
>>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>> -	if (cctx->domain_id == CDSP_DOMAIN_ID)
>>> -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
>>> +	cb_dev = kzalloc_obj(*cb_dev);
>>> +	if (!cb_dev)
>>> +		return -ENOMEM;
>>> -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>>> -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>>> +	cb_dev->sess = sess;
>>> -	if (sessions > 0) {
>>> -		struct fastrpc_session_ctx *dup_sess;
>>> +	device_initialize(&cb_dev->dev);
>>> +	cb_dev->dev.parent = parent;
>>> +	cb_dev->dev.bus = &context_device_bus_type;
>>> +	cb_dev->dev.release = fastrpc_cb_dev_release;
>>> +	cb_dev->dev.of_node = of_node_get(cb_node);
>>> +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
>>> +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>> +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
>>> +	rc = device_add(&cb_dev->dev);
>> device_initialize() and device_add() can be replaced with single
>> device_register() call. You can refer the below patch,
> Keep in mind that for several arches device_initialize() sets the
> coherent_dma_mask. So one should set coherent_dma_mask (as it's done
> here) after calling device_initialize().

I can see that device_initialize() sets dma_coherent flag for several arches,
not the coherent_dma_mask. The final dma_coherent flag value is updated later
in of_dma_configure_id() based on the dt dma-coherent property.

Setting the coherent_dma_mask here and calling device_register() which will
call the device_initialize() won't change the coherent_dma_mask value.
Please correct me if I'm wrong?

>> https://lore.kernel.org/all/20260313-kaanapali-iris-v3-4-9c0d1a67af4b@oss.qualcomm.com/
>>
