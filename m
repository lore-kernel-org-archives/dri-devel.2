Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0077C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA5E610E9C7;
	Tue, 18 Aug 2026 03:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jrJR1hkk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HgxpbEav";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B6B10E9C7
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:48:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I34D3H3299176
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bXRS5rh9jAJP3tYbTw91AwAt
 64eiYAnV5pL1NFBS+kw=; b=jrJR1hkkjxicDvKwYQNE2jU5RTmV0lIIVKelab3P
 UfYbP+Y4otWMjtQPr2NntdzTvuK8Z0twLgKCUklVQZiblZ87nW7yLziXFSAyg1Mc
 SB7i/7uF9kKZC9CeCbbGn50T+BC8BqHuNHiQzEpnFvI/TFbdhP5S84SutqyeQKrq
 qOtTeOZF2GsTpUVy5MH15pluhblIgj2phoVDZypSKrgUgq3FOXSznXWMTgeD/uhR
 T8+JqIt31HrqiPF47XL99in9izUGbiJhINLMAdWJ2X18ysQof9b9HHqpMnsKFdBm
 kmdIBexMbo64W9BhFfWxjX93EwR0BNWYKcOWbN2hjF9kHw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5pr4cp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:48:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa3d9dfbso390499085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787024906; x=1787629706;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bXRS5rh9jAJP3tYbTw91AwAt64eiYAnV5pL1NFBS+kw=;
 b=HgxpbEavwmdOGgYCug7DSnTDeIaycOQdStHle66uEhEKIEmmEJF46TyppJx3p+QbfE
 0wLR5u/UId5vQhmNFkS0MUHEOCE73WHL3Et3swUxibSw8xtWI01XHNZagWfzDDQFGHwc
 RkIFAB3NXgupkmhAYatG6CC/GLIw0KAvBVAfyDe9C26BBBwQsAFGif3vHljF4/nevzPX
 T7scdDuoiGMivn3ORFd/sXItOgBVPUleqUYYfebqsVyUk7N2NU+OK76mfMWy+6cmxOJu
 9rLvIa8/VdqQxmAGPYTtZsfWYidbJyD07MAttr1ktouufpOJSEMKHEK15M4Rhit5AvWs
 NZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787024906; x=1787629706;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXRS5rh9jAJP3tYbTw91AwAt64eiYAnV5pL1NFBS+kw=;
 b=jyOUib1CsTpMTkeILUaRPQAeaae0nJbA16FjXifDJFgq95gcNrG3ycDZeeR4Fm/nT6
 i2yxsU4gTjvbzCALQVUsQ4yw1RTuwyOlcLihhw5E6wB66zt/zi94PvYpFom1XODfJ4BN
 64Ojnj5GcNXHmSFGE86qYKxYxjn7NyGZLHpRZ4wkGrkPb/IKL6tzwrklxbkUAeFKHzmG
 C1P6Enx3UeomvYuRPCMLSJCoyhJvPcf8PCHorxlG8lAe+DfZ8E4ZVt+jY5g8yagLgXpa
 D5IGryNmroJ3YliO8SlxWXso/v6jywKS0+38Xl451yTRX+6mEAa8kB56sN2CIKkAA7ob
 G5kQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIz644DXHz8gY9zMjG5ULJCYcOO64oGR3eAPLiUsk9futKYImUVEriM4D/9CexHo567nM69ZlklNw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoycKgavj8vEPqKMVHWr+Xrzq2HHq4ZO54qjELt2arXgo7qcsx
 Y/6pdg5J2SgVM4CTPCLtzBKg7G7xKxvzb+SyyOcBp24PWatq2AerGOw4BfmgiV3nCaica6ZPMDh
 lq55QGFwqgyqXSyKJAv6AZFywVewSHdWSLxNNnc3jOThR/8So7NKPiERtewLTHrSLTzoGk/s=
X-Gm-Gg: AR+sD11z/8QK4NClAlb1w89dMSHMnrFK6pyS2yE4JUicM1n4I+UF+tj5sakcOVc62Vc
 nkHDPvxYDz+FbUQp2ETMtjtlD1Bo+L3elaMrQTwWsGCATUdOFjB7f9D3efnyTtmfsqdkcK4/15a
 ZnYz9o+Gi49uG7BLiwzGg3PfsnUeqBGsKWamETBBZKY5gTKvx2V29vrT4/i7VWRc9Dhodfuf+eV
 acjTnWgv0kjbRxzA3Oa+ohKkj+msdRoin76fy4MEg1jq41HpzigcxezZ1abBFQMggcbE/FP/1ZC
 5nhvRiWJM4tJABlsfRuyxfufng5MLCze2bkIE9NloI3lCLNvDtIQpSqHSrHD2A+mEFugG0fFQYm
 TQTMGIiCmWTwdyiKAo37KU9M4/VBWwT+fUZZ6viPLJ7KkmnA8rRbkT5DiuR4cpRLN+tXwa/u89h
 hVrm6qWu3qSYEz
X-Received: by 2002:a05:620a:4153:b0:930:fad2:fd with SMTP id
 af79cd13be357-93704b523fbmr526537585a.17.1787024906254; 
 Mon, 17 Aug 2026 20:48:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:930:fad2:fd with SMTP id
 af79cd13be357-93704b523fbmr526535185a.17.1787024905805; 
 Mon, 17 Aug 2026 20:48:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cfa0e5esm861092e87.25.2026.08.17.20.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:48:23 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:48:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and
 memory manager integration
Message-ID: <pm5yr7fovkav4cuat5zqn3ngf2fxzrqutsgyaobwp5djv4xkuv@in7n4o3x3x6y>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a83d60b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=biWI9kQzUyu7Ho-RK_UA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: dbVYCGUjG_Hr3X1GpTuu7FEP3-MYwhaX
X-Proofpoint-ORIG-GUID: dbVYCGUjG_Hr3X1GpTuu7FEP3-MYwhaX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNSBTYWx0ZWRfXwEnkskKcsrsN
 oR8YoMPXLIld/lACi+u+VIziK3mCb5t1Px6eRZRtFWtNj2blogs7mDs6QyltkAkfJt6B6O9sX4q
 TcEBziw+Cr5PAZQQygX1jnReaF/ttxY5BmAxSBNp0KJFlCef9oRV6t1OUFZ8Ms2LwGgxHERyHhN
 d3TzKpj2wOTTG062dYeTG9YwSgpytSz90VLhsjWUdlnrfKCXdGqLyhkFBr8dmIyg/EyisNJKlLU
 th8OKUdDWlk1jOlgRpNe3PuhCD5DqZgAkoXbPv2Jg6e3pAmPgMh2Pc1GOYCK+eEYT4YhKgeRDsq
 0O9lqhQaoubSjTc6LekcJXCU888XLhEicGYvhTLwue/QeMNhSi58Znbl7WLXrS8djhoiw10fdNZ
 53+slcLUi+/7vpAfVzl8g+TqbxeqjMAXdPkGN8VzwFcDXjG6pgCrVuOQL/wFPVBjMH0z2ojnGtU
 xsbFVO8pOekg17tzc4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNSBTYWx0ZWRfX91sxwAnuvO1s
 2Gr9TwgsGhsVVcLoOOQIdRTR0YPu2LqhRfrqfKLXpnFlYKhNP1c+e1PRjBAAAMtrud51KU66z0D
 302/FaLyADHxy7dXd1vF05Hw4j2Xy3c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180025
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

On Mon, Aug 17, 2026 at 10:17:44AM +0530, Ekansh Gupta wrote:
> Introduce DMA-coherent buffer management for the QDA driver, wiring
> together the GEM subsystem, the IOMMU memory manager, and a DMA
> allocation backend.
> 
> +
> +/*
> + * The DSP identifies the IOMMU context bank from the upper bits of the address,
> + * so the stream ID is folded into every address handed to it. The DMA API only
> + * ever sees the plain 32-bit address, which is why the context bank devices are
> + * created with a 32-bit DMA mask.
> + */
> +static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)

Let me propose a very simple rule for you. Unless you know what you are
doing, all function, struct and macro names should start with qda_. The
to_qda_foo(), I think, is the only example up to now where you don't need
to have the prefix.

> +{
> +	return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
> +}
> +
> +static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
> +			     dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
> +{
> +	gem_obj->virt = virt;
> +	gem_obj->dma_addr = dma_addr;
> +	gem_obj->iommu_dev = iommu_dev;
> +}
> +
> +static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
> +{
> +	gem_obj->virt = NULL;
> +	gem_obj->dma_addr = 0;
> +	gem_obj->iommu_dev = NULL;
> +}

These functions are called only once. Inline them.

> +

-- 
With best wishes
Dmitry
