Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CDEC5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F2A10E9E5;
	Tue, 18 Aug 2026 04:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZmsGspu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWjGlxbG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95F910E9E5
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:40:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkn5q3532522
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NrzWHA3rSEs1ygei9S1vAZxJ/Pn8mnrI8++ukqsmDEA=; b=bZmsGspu7FTgZAHE
 gRBd0rBWRXtpP7UkhP9KoRFyc1yMqLpm1m7xHGcmM01K9ftPJHOXw0rweGqkv2Bp
 KZlNiULXfhiKK/ax3kHG7QDANYBAsOW+Ex5hiTRGux7/qwXwfsPb6uaj9QisHiLg
 ZIlc+4m8fRZ2wrXVEeZV6qNF1t+KRQKjhLB9T5IFbPdxmOo+cMtR4XJIrPXwyVq5
 gVwLx8g0XNw14LqnvOiGtFAhAF7kdz5GmS0DztvUapAM1PYaiGtI+mtKgqyZsEp9
 CMqva/aoq+bPOzCZrbZ0ZX3NfYqG2H1L+ecxx88lH0gjmEfPXwOU5VbH/PSJc5/J
 Gczyyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615jfr5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:40:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so627819a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787028027; x=1787632827;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NrzWHA3rSEs1ygei9S1vAZxJ/Pn8mnrI8++ukqsmDEA=;
 b=SWjGlxbGa5GX68Bc6BXuu3CHQKBVJjVahKpnbWPiMtl4Wm7Spegz4jSRG0Q77/QPoe
 Xwww5a732+m4nT7ixHpA0KP0cv1LQhDCo/B3mg45+/gZLWV07eqsvsquWxYxNvTYcvoO
 oyweKfbxHqiK7CJgdxiT5PmcLwR8pi4SNhZKChlgoJldsmY/Fc54mJ1m4E60faDY68Kf
 PD1+c3dJSW6uEug0SB8apWmSj7mwm3HAZ9odUwhTQPh6NM+G9QtKs7GuiizOA9bwEJa2
 xRov0dorz9TXiWp+XYOH/H0sLSm4Xd14i/VRNJjrk81sMX0cvBRQ/JBUGmJ5X79TbW68
 pxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787028027; x=1787632827;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NrzWHA3rSEs1ygei9S1vAZxJ/Pn8mnrI8++ukqsmDEA=;
 b=c++LXVl8Tbmc9E175y+qQLspPMuZywrmSObmiyaOnPHouENWc08O0bmNc+XnCKJiVH
 JEw5J92Opk5mSsUU84R6Pup3syaC2l614m8xRuUipwoJsZ4vP+aVeOiYjPxDpMS4INpr
 APHQUst7HLUi3+q5PPXmAku1BqVElXe0NyGPheBlMQ22TtI9E6QtPFiNOkKFoOYrXRqG
 1owC6oKaKtcPII75KiqkK2ViDxaqE/aXzCPwMBg1OZ8XzJcBXUitqOtt1pUbD/Doiegb
 EToNHElULDzu1NOyH22UC/Djsg01akGLn/fPJn7K/TAsA1A+VPSSoooql8x9n7zvENH4
 JwMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RogucyWdvKG1QhYSOu+MzQ7ugi6oRsMZmIGlASxVUazn/daN35tze9vHs12v8AJ+zE+RPpCqJw1pe4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1NQDe6CRvri+pGpDcHqos+RKonAmBHWxxamHcoOh0fb4bLHoA
 evdQsmFYYcS4D0vskNs/Viv0+LTS8N4s1VjtbSYiarj8M5BMd3VLaUnPBPLcp8YpbgfcmEVRRJ8
 J16LfUXj1fVpdkNwdxdyDnXx0WyhjOT30TcOA8zf08ibjacKitzB/K6fN6GY7qsFQDQkVVOE=
X-Gm-Gg: AR+sD118XJvwK/HHZzL9B+ZsP6YA5y6nBF54c4BEo/EB9XEqhyfOoIQPD+k3YXCoC+9
 jzCkLPQwZxacTWo7hsIlfxG7Z40tWyjZuEFyQ3N40HCEDZuB3uATfyqWQnJmXfDyVMfymePkjyM
 CEoittzJydZLghKr8DIRZG0CRAubnB61RoUEVOhZyzbqrJMw0Cl9I/TM8Tb1T28SwGATODQjaAa
 s5DDAglfZT2eVkSBeVljtGkFIUJa4c91O8D1xVNp4a5quPPgIyEtwvjDaHLb1kZH6sDozgIIfvN
 OWVsX0QDIj4JwXAlZhk9YGJBmYC4WQ2wjU1WqIyhWSBqyUm3I+mbSOB0ZF/790WmRfIYRqwgNhA
 6CdZqyGfeee8DLzRHaML4P3I576KJFQ==
X-Received: by 2002:a17:90b:518c:b0:38f:cab0:9aa9 with SMTP id
 98e67ed59e1d1-3955f17c702mr3916854a91.13.1787028027479; 
 Mon, 17 Aug 2026 21:40:27 -0700 (PDT)
X-Received: by 2002:a17:90b:518c:b0:38f:cab0:9aa9 with SMTP id
 98e67ed59e1d1-3955f17c702mr3916824a91.13.1787028026993; 
 Mon, 17 Aug 2026 21:40:26 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267be8e35bsm11880079eec.14.2026.08.17.21.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 21:40:26 -0700 (PDT)
Message-ID: <c54f5212-809e-4517-beda-f86b375c086f@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:10:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
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
 <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
 <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rfU2IKkZS4ApLXvqMdMNKepGKVr3vP8O
X-Proofpoint-ORIG-GUID: rfU2IKkZS4ApLXvqMdMNKepGKVr3vP8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX1LYESVcaEOpQ
 lWgtBcx/HElWLmihD68+xRtC2NDwyHQp9Heqd5XAM6Yob65KqlqJ5trV3/IY/nXo2B9VIolCMSz
 GxAhtOiQ5XLZd47KLvlWDOHfvoF8ovobzzNgT5WyNGdF7S3F8Zm3LrygiNtn1TiL5KMRWWXJCqv
 YPu3NLP6L5ufBzY6HpXLXUTcte2xbzQRN0f/OHy/ab/Uzq2CllYKHwGR7ME3CP0R6M0n+z6bCTW
 aQzS8eIH7Dejhzj2aQvJR+c6V5txLIhG0UuN3RpWEGQfRq2mRGw4p3Orp94kvG7z0vW/LsGOBK5
 QpSDxgqHMNVhd/cxb4FaRky+DpF5d6ukgzeewLio1m+2hK6WlbpfR7hobvElNGrVVar5tBSLcE6
 e2SY6i7U/u04h33OooklaeARD0FAc0PgAG+hszgp29vz2bStGzp/wl/tL+yuaB3Wy0GYxMW0m80
 NcCNu3G53Kh0dxjRt0g==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a83e23c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=GCkxi1q0J_mCzIEPFfUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX9KNBkvaoDrFw
 WRHTwvtnIrccgbmgQSBxytN+8ZBgiFvAvsP75h+fEFbiapDA0X1OjwU4UL+OOkFR3yF2ZAn34i+
 EBmzwkRC+qObK64yrurNGaLK48zhEYQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180032
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

On 17-08-2026 12:28, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:43AM +0530, Ekansh Gupta wrote:
>> Introduce DRM_IOCTL_QDA_QUERY, a query IOCTL that lets user-space
>> retrieve information about the DSP a given /dev/accel/accel* node
>> represents.
>>
>> The IOCTL takes a query_type selector as input, so it can be extended
>> to return additional parameters (capabilities, attributes) in the
>> future without adding new IOCTLs: drm_ioctl() zero-extends the argument
>> structure, so new fields can be appended to struct drm_qda_query as
>> long as they go at the end. The first supported query,
>> QDA_QUERY_DSP_NAME, returns the DSP domain name (e.g. "cdsp", "adsp").
>>
>> The UAPI header include/uapi/drm/qda_accel.h defines the command number,
>> the DRM_IOWR IOCTL definition, the query_type values, and struct
>> drm_qda_query. It follows the standard DRM UAPI conventions: fixed-width
>> types, a C++ extern "C" guard, and GPL-2.0-only WITH Linux-syscall-note
>> licensing.
>>
>> qda_ioctl_query() validates the reserved pad field, dispatches on
>> query_type, and copies the DSP name from qda_dev.dsp_name into the
>> user-supplied buffer with strscpy(). Unknown query types are rejected
>> with -EINVAL.
>>
>> qda_drv.c registers the qda_ioctls[] table with the drm_driver so the
>> DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
> 
> Please tell your AI agent to stop describing patch contents. Ask it to
> describe the reasons for the change.
ack>
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Add a query_type input selector so the IOCTL can return different
>>   parameters in future, and switch DRM_IOR -> DRM_IOWR so the input
>>   reaches the kernel (Dmitry Baryshkov)
>> - Reject unknown query types and a non-zero pad with -EINVAL
> 
>> +
>> +/*
>> + * QDA IOCTL command numbers
>> + *
>> + * These define the command numbers for QDA-specific IOCTLs.
>> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
>> + */
>> +#define DRM_QDA_QUERY		0x00
>> +
>> +/*
>> + * QDA IOCTL definitions
>> + *
>> + * These macros define the actual IOCTL numbers used by userspace applications.
>> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
>> + * data structure and direction (read/write) for each IOCTL.
> 
> Is it not obvious?
will fix this.>
>> + */
>> +#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
>> +					 struct drm_qda_query)
>> +
>> +/* Query type definitions for drm_qda_query */
>> +#define QDA_QUERY_DSP_NAME	1
> 
> Why is it necessary for the userspace?
Currently the requirement is that on systems with multiple DSP domains,
each is exposed as a separate /dev/accel/accelN node, the library must
query the domain name to select the correct DSP to offload to and use
other dependencies like shell etc.
> 
>> +
>> +/**
>> + * struct drm_qda_query - Device information query structure
>> + * @query_type: Type of query (input)
>> + * @pad: Padding for 64-bit alignment (must be zero)
>> + * @dsp_name: Null-terminated name of the DSP (returned when query_type is QDA_QUERY_DSP_NAME)
>> + *
>> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
>> + * based on @query_type.
>> + */
>> +struct drm_qda_query {
>> +	__u32 query_type;
>> +	__u32 pad;
> 
> What for? If you have u8 array afterwards, you don't need the padding.
I'll remove this from here and bring it later if we extend this ioctl to
support other options.>
>> +	__u8 dsp_name[16];
>> +};
>> +
>> +#if defined(__cplusplus)
>> +}
>> +#endif
>> +
>> +#endif /* __QDA_ACCEL_H__ */
>>
>> -- 
>> 2.34.1
>>
> 

