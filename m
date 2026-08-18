Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD5C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A60C10E4F5;
	Tue, 18 Aug 2026 05:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SldZMb+Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T9TBBQRR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FA210E4F5
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:52:22 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I3iocU1173036
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xjYcnSrjSmgMzkRMxQam0GLR8tuJBIbwpiu16ja4GG4=; b=SldZMb+Zwc0l7/OG
 VMJ5pOsnhgpR2d8vJWDIFpUgn9RmdHDUlNOxDuTQ1jPuhIfd4zNWZYhwBkQFtXZU
 5t1uSxLpO5uIbAg0oUQUantoiZCuNBdpwDUOyooVOivP5ujX91pf1tqA3E138In5
 p7ajf20i/n1Guk9Z1wfhuh9dTFdvf2p9jtX1wzQbuUPCgYJGvER9q8h2oSjIkE9K
 LlwMujYMfVLZw34PIqC86VEgA9pOAfYQ158AwCI1rw6qtMtjl+djaoaM6T7XHt3j
 BPLnCBbUkt+apwC0A+IZxEpDEpCRhoPz+IV7DJLbJvrljST7LqCm1DiXASw6AtAz
 9CGDYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmrh4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:52:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so87780315ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787032341; x=1787637141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xjYcnSrjSmgMzkRMxQam0GLR8tuJBIbwpiu16ja4GG4=;
 b=T9TBBQRRfQkUd0SxQgltTvr1GaR1XbAf+7yz6gY+tFMpVuf6lMs51H0kpnIG0xuuBD
 c/xUI7tpkglvPOLw1ZIPJ44EmQjhEkezCqaZH/qtKSq+QX8k+jSHuDsutAQV3zUeR8+2
 FR/LA0dEyamnGHPVB6xf2ryGX9yheObYjcizQMjDt9+p/EsX3dGUPgRAtvsLYgCNkBT4
 SCrHB1khYdlOVLnH41BKkO83UtTEF0RAn3t3fxlDZOYzxOlcjKiJhwbDGR1GUhUfCBAJ
 AiaSfHEzzI9E7MjmPU/uoJg3T9XhDETqGZqDSQswx8u0c7MQ5NE5NVtcl8zhoaBuzHmZ
 jy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787032341; x=1787637141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xjYcnSrjSmgMzkRMxQam0GLR8tuJBIbwpiu16ja4GG4=;
 b=Sl92dPeBv7HZ7Aq8KmTO2zHLNaq5hyFlmAuY6weS8R6YEflCQgr3gqHG+oFUQigDs8
 jD+Wltjajmi+XjZd1ZykzV8lSi5VukS3s3YlVygNINrQlpdyFkpckFMQOJWtBMzG2B2e
 0bMOrZ7Qp+tpf2DSSqc62pp6XTN8UGufJAugOv2Fd+uq36rdPuoKgusXaCCQeHXmVqFW
 S2UwzLYql2p+NFAkF3Rp2d6yBNG64imb10L5OFU2slwE7NzZoa2iJhPYqSjGCfuXVdub
 ChVLfOJ49w+TJUg9wZG82COYPV8FAYMTLCOFDe7EhOfgBdUfOS/qSRSqRMRqjZXyhM1M
 Sa+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzoeNFBHDpxJxC4rAEXrcAc7WcQm4jGQq5TORwPgtXLbmKo3YKTXRoPRSK+Zg2fWTGySXD8eVRw5k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJjGciiy4tlFzxllGLmZMFj1IIXUplblDRseu7arS5RX7IdPIT
 c3xs9lnqAVuiN8Gy7FXd1KPPvNUG7+iSvXBeei+9X6XuJjTMT7AqWpiErPy1pCowrl11HqIxviX
 EGXbMdurP/aYOunshkxUW9GZ1fB8gjlsfGGleNC8tWBvftiLImqgaZLItIvqhk2EZ6y4hEOM=
X-Gm-Gg: AR+sD13Qpsv3FcDydmD+u33m8Pay/RDJAgeCuRxSZoU4PX3SJvCGblFdZ2QsXI/pznW
 d3wF8OngqrAJFlwgnfHnE9JdaOzq96EHIkhfJLdAyKrnS1MPmHCmWPG+6dLvbcrY7JbE2n1WW2E
 UcqYEqD566ybAgxPcUOgC8yIvEgPgk7Se7Gg+WDEQ0KMFqEN2ndOiXnuiHveTLB8k8KdDTICe56
 89LF+vOS6rOr2p1LsoNkatEUGCdia8XpuZLxm6Lre2HsE3VsSAzJu27kRs5o+0YnH1gqZUc8LZ7
 d1TuPF5THJhRpKVhhF6SeYw9GuYM9Ysq30lfYndIyDEE+NTczcxOBXbc6fKEv4NuwzpoDChGEXL
 TRWD7dnCXCftMEsBJR17uxJ0V/SSjVA==
X-Received: by 2002:a17:902:f543:b0:2ca:6eca:492f with SMTP id
 d9443c01a7336-2d5c5381b3fmr57275065ad.14.1787032341116; 
 Mon, 17 Aug 2026 22:52:21 -0700 (PDT)
X-Received: by 2002:a17:902:f543:b0:2ca:6eca:492f with SMTP id
 d9443c01a7336-2d5c5381b3fmr57274255ad.14.1787032340674; 
 Mon, 17 Aug 2026 22:52:20 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1ef0147sm10197055ad.77.2026.08.17.22.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:52:20 -0700 (PDT)
Message-ID: <50b067ad-0ccf-4b9b-9116-c95f40105140@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:22:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <pm5yr7fovkav4cuat5zqn3ngf2fxzrqutsgyaobwp5djv4xkuv@in7n4o3x3x6y>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <pm5yr7fovkav4cuat5zqn3ngf2fxzrqutsgyaobwp5djv4xkuv@in7n4o3x3x6y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX/UqW6mgq61b+
 wY7Eg7SJMOnqCoAhtW2kSCqn+HckAqGqQ+a3JsWp3Dscl4hxEUip3VctmrweR6ktEix/bJW2Rhg
 DfQTxnd1GFg60Tase8gwfBKGlpWQxpjjXpFLGCjoxang7qCVIOHJ8dkZ7uBixit/0fNOBZGX2TR
 cGB7dsPByQO4cdtatc+IaHX7q0mNec8O6mWAq12bSrWp87IsGfn/dtyrXBlIQxRH79bTECr7IxY
 Y/KrI9/D8jXPcqvoGuLCbYVTnuelX4QijPBgyLA7Kdbbml7ZlUtSkOswnbiIlNHTTm4ZEv4R3qR
 mvp01wU95er+VFn0snEMffWvigeiF1URM4RoBtBFZWQfK9zTqed4tyoBZ8/9NwsUaXarY7E/ijY
 NaQdvdKzW4Bz25jSayHnCQ+ahKFtkctJOWYF8QQC59ObZhLPAvvSu470ZHvysY92FooVCF1bMel
 JImvrTkjUv2ufbBLZaw==
X-Proofpoint-GUID: Cgm-6ySmTmOjQ84m0kbFVlT2YeSM62Op
X-Proofpoint-ORIG-GUID: Cgm-6ySmTmOjQ84m0kbFVlT2YeSM62Op
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a83f315 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=5LPJMhapKY6Lgul3swkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX0ZSemhaxHuTD
 k+O3aGy2vVl/+YYMzMsItK+oJV826BS7Q7mDi69b3vulvH8FwX9f+eJHxqScSGfK598cuZlD1Nb
 IjrhYXn0jUPRwq2Tl1NEV4k54fjCgqM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180042
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

On 18-08-2026 09:18, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:44AM +0530, Ekansh Gupta wrote:
>> Introduce DMA-coherent buffer management for the QDA driver, wiring
>> together the GEM subsystem, the IOMMU memory manager, and a DMA
>> allocation backend.
>>
>> +
>> +/*
>> + * The DSP identifies the IOMMU context bank from the upper bits of the address,
>> + * so the stream ID is folded into every address handed to it. The DMA API only
>> + * ever sees the plain 32-bit address, which is why the context bank devices are
>> + * created with a 32-bit DMA mask.
>> + */
>> +static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)
> 
> Let me propose a very simple rule for you. Unless you know what you are
> doing, all function, struct and macro names should start with qda_. The
> to_qda_foo(), I think, is the only example up to now where you don't need
> to have the prefix.
ack>
>> +{
>> +	return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
>> +}
>> +
>> +static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
>> +			     dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
>> +{
>> +	gem_obj->virt = virt;
>> +	gem_obj->dma_addr = dma_addr;
>> +	gem_obj->iommu_dev = iommu_dev;
>> +}
>> +
>> +static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
>> +{
>> +	gem_obj->virt = NULL;
>> +	gem_obj->dma_addr = 0;
>> +	gem_obj->iommu_dev = NULL;
>> +}
> 
> These functions are called only once. Inline them.
ack>
>> +
> 

