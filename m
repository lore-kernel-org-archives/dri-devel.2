Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE0EC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C3010E47C;
	Tue, 18 Aug 2026 03:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1GwYAHq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJduqSPK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E2310E47C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:42:24 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkP6Y398584
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MaABp0/faTANtVcerTDacDQd
 lb7pXZWcETU4q2gt11c=; b=R1GwYAHqL8EDVwyhfRXBq4LeLrPDpen8Be1zsRaX
 XWcXJhOYiY3/auiFO2HbPN7yF4/QJ1KCGEOCw2iLndJ8FVKA+nADhGeo6qst9tCw
 P3bFDv8C6VafbPcV0gPjV9IFpHGN3JqVvHk9x+IhhVNlqKzMiJIBVw+35KXmZDnc
 /Wx9GiURAGiOU2T/DDfWSEXxjbRe/D0ZLTE7nOlkauAXfJpsBi0ykiRwhQ94ayEF
 2sh/eLmcHZLqo1qTPNCjzDlHIoNoiHOgAFOVi/ywV0oMHnIaeQnoNg1nOZr/gTEb
 NLwXlJSaHoGkw7VVmcznRBUBZ1IazoywpwY9OO42hEllTg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y7kv6aa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:42:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso5636511cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787024543; x=1787629343;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MaABp0/faTANtVcerTDacDQdlb7pXZWcETU4q2gt11c=;
 b=aJduqSPK1PH1+YkAIG4ZyCdmZ2DP4h2denSaNoSGWtYf2jl+AVMaZQfUK2QNX7Cs0Y
 nZ97FZO+ZWOJopZJS8Cx1b6T1BtqQkm3LTukdw1IxII79rx1Kiawejhkj/o36YV84OCk
 kvKkK/BNh6ks67Bwn7LtPkTVE8y5JRvvsodbxg7Ewzt6qnHfeQr6TaxLnuaG9k5OY67o
 8tKXOJAWDRswuzcHpqssQhi6DpREDGwps339v6knlBqd3qHvtqWcTxUn3Woj6JFdBAOC
 N7+DX5M/OkA15lvMRwmJSMaZPkRP/L6iNXADzfENgoGMBm3fumsXEYey23/LIJQjUn9C
 mYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787024543; x=1787629343;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MaABp0/faTANtVcerTDacDQdlb7pXZWcETU4q2gt11c=;
 b=lhxgrw/TKFAk3GDPXW2gNUObjB8Tj2BCa7AQ5DE3vNpOZ73naUydBU+FJQVLLjZX27
 +zA8+8Ycg9rVui2DZktId9QKjWPFyddsEqkx3ZPX/tdSDJ0tvrivSN8qycHhOzq1GEu7
 2PDtpO7nXYncol1stN2a8Fy7DIuPdXUv4pp4PV6+SgBp92aiskw3Ijj0A6e1cxaItKzK
 j2cC/wk+gCLusFArFd9D7eczV793OAFeD2iSm1t8lSV24m0/kRtMPmazeERuSj1zhKvH
 vrxvC+gq/Wy6/ZOJo2kj4VLd5toi1vCUZ/b/Svnw0XN8AVDrrXacJ74CIAkgOz1Mo2qJ
 sJyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEYjnnX1Etib7AHlxg0+M24gcQ/61PTzGRKjm68y0oBzUFVr9W4mN3QSwB/p49WL1lrJA6B2N/hFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8aX3MugepDeIHFWrb4TEr6otGCOxQkLctdsIG4k9GKWErb33M
 EsVxtaveM9sQjQPd2VVRcI4OxkNOkwqfGaDHZWPymss1e93tHgB+9dCFvEoQhWfkSemkblgGU3G
 LQmHv+0tFvOsuo3p1mITF6xilyZZ1ccK087DYQWvhbiShrmWOh6IkNAYV3Da9HI8G9qcuVRc=
X-Gm-Gg: AR+sD12PgOBQFU4gfhh/bcBf0THvGhff0Q2lBiQkaxN8Kl3tPFqfwL8RukJFANfCV2o
 SBaFuc4t5hhA/iphJgQ9PFL8M8ijFaXQ0xitFOG/GfIOUMeT3jO1+QmpX3ZeXpH34swMIQJHIqM
 uL22TEo7Q1kHBrITJyCJod1M1mantVtkLdOIQl90NTlhqFxxoZkQ5WvJDYw9o+N1oOBSF3i5ZLt
 UHoNqZZ6G5D3fbMfsYYp/JYUXaFqyoygRrGSsHZ90VFPHybA8rdmuOmiy97inrwIEQM9j4sYDD+
 9GzDkYnTyqqTafsW2+K6rGP7C1nnvI+OuAyIyzjx4w7W8dyUvom+Vj4JkdzdV+0/x3rkXtkI6OO
 WkGftrfHqgw6NCR5eKHV93ZZD67ECASWngDO27O+e9zQ121jxLnOqIBiYLkHdt0npk0t1hGlBcL
 GYslbLYEAG3JeL
X-Received: by 2002:a05:622a:5592:b0:528:ce0:e9f8 with SMTP id
 d75a77b69052e-52dbecc2fbcmr42318781cf.3.1787024543125; 
 Mon, 17 Aug 2026 20:42:23 -0700 (PDT)
X-Received: by 2002:a05:622a:5592:b0:528:ce0:e9f8 with SMTP id
 d75a77b69052e-52dbecc2fbcmr42318371cf.3.1787024542626; 
 Mon, 17 Aug 2026 20:42:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cfa1811sm866041e87.30.2026.08.17.20.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:42:21 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:42:19 +0300
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
Message-ID: <g3dkltejtlzrrelv77kjteqbkny6vhedyuet7d6b2p7yfix3ys@sop7vjvpdvzb>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-GUID: rLhqqKQFWFXNvNyy7Nr-XEuG6EM7kzN8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX7JPT/wF0iXer
 gOmMxpeBmtMFbe8DqphkTKT7i2YiP8EzsFTSNIIg5KB/wZL2qgLugpckwjtGSKMBShMiHZbJApy
 ZXrzVjdzxIMEl+waJ4q1VhBtrYbxqrk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX5nSzWGcznAlj
 yrc0Xz8+SJs4/F2ImY75dM4jFf13FXg4U8NKkve+/ZuB8ngrScOWVlePrBtnkPLBkT19YuHGn1a
 hcVXGIwZasEzpGZDy27fmuPlqRbWiNz8kMs92xJyy2qcfQdUZ2RajzmrVxYZxGEYIlQiOW8fqYb
 Kah5xHyW2/alij9i494EooFuemccHMrZ1tlw7xDBgPWeVdWjeRrpRiF7tvrwKmn+Qge2ZJisxfD
 0BDPVCxpt5ROt6cZedcl38XJ0uPtC4S+SyHt289ev0tm9rkQs7ApFgWvEMiNfRJ1NF9PYUFlug1
 M/SUCoEIZpYELbyHedkETa46JAqX5CV2Mc2fqlA0HAaM7iZILScyp9+eGZC6jzzTRrmxQZXAOz1
 E6t0XwCx06vXbfRkoaZVVtkVHHq+QE5MiXSrEthag/AteGNEtQTUy6bv2dOZHUXaNNnjMeIXvyC
 niHCtlDkL7FPWsEMb0Q==
X-Authority-Analysis: v=2.4 cv=HYEkiCE8 c=1 sm=1 tr=0 ts=6a83d4a0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=BBVwHIhhcn0rA1_HgMAA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: rLhqqKQFWFXNvNyy7Nr-XEuG6EM7kzN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180024
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
> qda_gem.c / qda_gem.h
>   Implements the GEM object lifecycle for QDA buffers. Each buffer is
>   represented by a qda_gem_obj which embeds a drm_gem_object and
>   carries the kernel virtual address, DMA address, and a pointer to
>   the IOMMU device that performed the allocation. The .free callback
>   delegates to the memory manager, and the .mmap callback uses
>   dma_mmap_coherent() via the DMA backend.
> 
> qda_memory_dma.c / qda_memory_dma.h
>   DMA coherent allocation backend. qda_dma_alloc() calls
>   dma_alloc_coherent() on the CB device and encodes the stream ID
>   (SID) in the upper 32 bits of the returned DMA address, following
>   the Qualcomm FastRPC convention for IOMMU address space tagging.
>   qda_dma_free() strips the SID prefix before calling
>   dma_free_coherent().
> 
> qda_memory_manager.c
>   Adds process-to-device assignment: each DRM file (process) is
>   assigned one IOMMU context bank device for the lifetime of the
>   session. qda_memory_manager_assign_device() first checks whether
>   the process already has a device (reusing it with a refcount
>   increment), then falls back to claiming an unassigned device.
>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
>   to the DMA backend after resolving the correct CB device for the
>   calling process.
> 
> qda_drv.c / qda_drv.h
>   qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
>   The .postclose callback decrements the IOMMU device refcount and
>   clears the process assignment when the last reference is dropped.

This provides a nice summary of the patch, which is pretty useless.
Please teach your AI instead to describe the reasons and the design
decisions instead of just assessing what the code does. Why do you need
memory manager? Why can't you use existing GEM helpers?

> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Adapt to the dynamically-sized device array introduced in patch 07
>   (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
> - Protect register/unregister with the process_assignment_lock mutex so
>   the device-assignment and device-registration paths are serialised
> - No functional changes requested by reviewers on this patch
> ---
>  drivers/accel/qda/Makefile             |   2 +
>  drivers/accel/qda/qda_drv.c            |   4 +
>  drivers/accel/qda/qda_drv.h            |   4 +
>  drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
>  drivers/accel/qda/qda_gem.h            |  52 +++++++
>  drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
>  drivers/accel/qda/qda_memory_dma.h     |  17 +++
>  drivers/accel/qda/qda_memory_manager.c | 239 ++++++++++++++++++++++++++++++++-
>  drivers/accel/qda/qda_memory_manager.h |  30 +++++
>  9 files changed, 559 insertions(+), 5 deletions(-)
> 

-- 
With best wishes
Dmitry
