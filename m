Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB63C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203FB10E4EC;
	Tue, 18 Aug 2026 05:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMcr0RWQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HykQyVVN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637A410E4EC
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:52:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I33vaC3298706
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9MGPW6/DK7pn6fKMqjuLg89wJJuJK8oCiXQggTwY6zk=; b=DMcr0RWQv+aJkxOq
 gUbCjFe3NzYI3OjesOMkpzJTRXBjrRxwtH6VVpZBWH95TK5T4AdoohWTSaY/Pe+J
 7tE2qg49EPqjakmV9X+lzItNlEm7Ty55bS8kqEOEnwYgmz+Q+l/A0UzCX8B3sPM9
 sDLkI41D8h8nuCTY9rYTbpOgu6mrJUSjA2Qvflpzd0evQ7B++9d1DY/3qUvCF6bu
 zrx997uDw6q4U81ym76aIR6FRJo8UnMBeBbxrACpSQDKGrchomzeg+g28RME5jk8
 9ksRJuowsPPRozywktrveZAJuq887VPVTCAA2SLmyqcwqlWkg94kKRxXskHAGgDH
 aayzoQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5prmyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:52:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so4528893b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787032326; x=1787637126;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9MGPW6/DK7pn6fKMqjuLg89wJJuJK8oCiXQggTwY6zk=;
 b=HykQyVVNycDic3grU7sz1qxfFzWPUhxJwtNYiYT8F9qknAH1PM+A9YSJUiqhulJZbe
 WFopxEhKiI9SeBzCO2zf6w6nRhPORQN+kGtay6IuWIECzdK6Spp8wRFf31tr248IPst3
 d0NzCeX/18ZYNSAUJ/E1xpxib6P6c364tJlZWSW7gG3BoiJPc1pSWkcNIDPbz/KRVlxg
 chFzbdM/PyHS01ffZaltro3cXW+1hY/Zy6MGHvVE/DxSI/ATtcXoK1h1sQKGqH6aGQSY
 xE4HzkZdPSeJre/XoCuYCSXU2lC2ZI7ergkMpisAemtATdTnTNPpnl4iR4Mpt7vuaB7T
 xZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787032326; x=1787637126;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9MGPW6/DK7pn6fKMqjuLg89wJJuJK8oCiXQggTwY6zk=;
 b=FI9m1vCIMu7juGm2qx4p6dQaZWaej+4NqYOkGGAMgWqDAiu9fEecK2ewKeXtsBKF2/
 IXPYcRuiaTmGTRBYW+Ufjp/Sp+mzETB7YoILreenoPg7GBpiw+S0o/OnPNN7DNMCuBfb
 UZPA7IkjC91U7+VBOFzrl9FyDWt07AsxfzIQdGP4tK6aDBRaWJubeQQmCzsJM5Y0ZtKT
 4afxVHa83eEyrmHLyuK7BsBGAasJPntQ34D+Jqn0nwue/uM9r9wsE0V3LxiPuleF2201
 0WVoowhQDVWkJYxR21lp91ShmQ29l3EqJyde46fcZIVcj8RCuAP8Lz0RLjGVSEckbQZd
 HVqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqF7c7H2e22ESpfTw41ntafPZnXlqaZDfDM2oFwS1aFxKbe2H6MxVOcXTlmwBKf0xpKvYvzJa0/gLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPvCnO0hCMMo8Upcgivn9WvKQgfR5nzP4W9gjEMhSmEBtV+rGl
 coUq3N/unIAJ61u5DDt9lBPj79z3y0CwPtxs47XALNhCHJSl5ZUuc5UOzWWn+9qnBSq0ExhhgDq
 MP0fzqnbZfob1GBkAkKZu455ffs4M/PVb3iVc0HzA2Q7Z+isOK2t3XYvpcjQaRH+0/3uHXD0=
X-Gm-Gg: AR+sD10vJnSal2RfY14X7zXHLudIFBgsovpOwtQOot1AblBii4zaiAT6kWiTR0xCHwt
 QsrcBz9PHVFf2AidfrRxr7OQ7Z2rH95aOyVd2/jtomDoij3wlAWr7lMB3bPXLItQ83ZBMPBt0JB
 0GzAceZZzR8TCoV4Y4HU+4h011i1bkM+YHycLN+nh3P+vJfw6Of3OXfRLzEAF/DNfLbpMVDPG+B
 lyVogaBcObUdZbJMHES1e9vxc75BTVJTgyWV2d3xE+NE/Zep4HXYVvEjHmgHs0nw+x/ii5va42f
 +gYd319RsFab7VZSkPck6bUYOanqSTr9kLl+R0rwWNL6uojek2E4OrOtboBDnQ5S0x3ERALgX+d
 DSE7G5SMWbIUUIjteoVwLoR4rHXEFhw==
X-Received: by 2002:a05:6a00:4395:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-84fde14ffecmr33705032b3a.7.1787032325958; 
 Mon, 17 Aug 2026 22:52:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4395:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-84fde14ffecmr33704931b3a.7.1787032325493; 
 Mon, 17 Aug 2026 22:52:05 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b4072c39sm1284034b3a.26.2026.08.17.22.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:52:04 -0700 (PDT)
Message-ID: <2d092339-a691-4539-8419-c9606ea35f68@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:21:55 +0530
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
 <g3dkltejtlzrrelv77kjteqbkny6vhedyuet7d6b2p7yfix3ys@sop7vjvpdvzb>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <g3dkltejtlzrrelv77kjteqbkny6vhedyuet7d6b2p7yfix3ys@sop7vjvpdvzb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a83f306 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=U_ymhupkC0DnaqHl0NQA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: YHHtzjtkTC9l83wUbmvDJ7M_2gkrMXjJ
X-Proofpoint-ORIG-GUID: YHHtzjtkTC9l83wUbmvDJ7M_2gkrMXjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX5XtBhtytBO7H
 oiXHuGoTeMpIWRAO7P9yoC4tRxQ3TUGZ35E7ifcUXt7MACLxCVX7N9XvNS+ECHA+tD0eBw2aWRL
 12/HV45m7HdJRkF3w0lHly6hnscWe5Ve0td6rvr8DprnRib3Nt2OvmScDokokpIdS4XAnM9FMnu
 s7kk4QibSqjiXS+V8CUbfsCQQ3dAPPWpMAR81r20CJiF6g8gRGXZSRL9PgsYfPGS+b5Xipjz/fp
 T74MLK4RaL2bPIE92MbzlzmCF4wXX/B0wlub7LAdEEDq+iOw/qc56Xo+Wny1ru8lFXwNYFCrk7N
 U0XLIQgWKOgubqfh8KUidWnuZKBfIyhNjp++2P4C20KsCA8sVnAoaQnvIdOzPQ/u4p6gI5OUcFP
 OycSNPcuX2ng0/wdqgwFCJU/wLrZgaUeNfnmNI+hCZMYgDpXXkjabtBs7SrTzStNmkfbfAJuHGV
 A8Q4tAYM6Pfros/xIxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX2uaZd/N1X0jL
 zV7YpS9zZUZs6nbzOxeHFO1t29K4PHJ8Cn188c0On8HkXZaHT2nYBli+QdtaMHocy/J7WjcKf65
 XVV1L2YUbQPaKkzalAndxnK0FWuS62w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
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

On 18-08-2026 09:12, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:44AM +0530, Ekansh Gupta wrote:
>> Introduce DMA-coherent buffer management for the QDA driver, wiring
>> together the GEM subsystem, the IOMMU memory manager, and a DMA
>> allocation backend.
>>
>> qda_gem.c / qda_gem.h
>>   Implements the GEM object lifecycle for QDA buffers. Each buffer is
>>   represented by a qda_gem_obj which embeds a drm_gem_object and
>>   carries the kernel virtual address, DMA address, and a pointer to
>>   the IOMMU device that performed the allocation. The .free callback
>>   delegates to the memory manager, and the .mmap callback uses
>>   dma_mmap_coherent() via the DMA backend.
>>
>> qda_memory_dma.c / qda_memory_dma.h
>>   DMA coherent allocation backend. qda_dma_alloc() calls
>>   dma_alloc_coherent() on the CB device and encodes the stream ID
>>   (SID) in the upper 32 bits of the returned DMA address, following
>>   the Qualcomm FastRPC convention for IOMMU address space tagging.
>>   qda_dma_free() strips the SID prefix before calling
>>   dma_free_coherent().
>>
>> qda_memory_manager.c
>>   Adds process-to-device assignment: each DRM file (process) is
>>   assigned one IOMMU context bank device for the lifetime of the
>>   session. qda_memory_manager_assign_device() first checks whether
>>   the process already has a device (reusing it with a refcount
>>   increment), then falls back to claiming an unassigned device.
>>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
>>   to the DMA backend after resolving the correct CB device for the
>>   calling process.
>>
>> qda_drv.c / qda_drv.h
>>   qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
>>   The .postclose callback decrements the IOMMU device refcount and
>>   clears the process assignment when the last reference is dropped.
> 
> This provides a nice summary of the patch, which is pretty useless.
I'll fix this for all patches.> Please teach your AI instead to describe
the reasons and the design
> decisions instead of just assessing what the code does. Why do you need
> memory manager? Why can't you use existing GEM helpers?
I'll add more details for this in commit message:
The DSP requires each buffer's DMA address to carry the stream ID of the
context bank that owns it (SID << 32 | IOVA). The memory manager tracks
which CB is assigned to which process and ensures all allocations for a
process go through that device.

`drm_gem_dma_create()` and friends allocate from `dev`, the DRM device
itself. QDA needs to allocate from one of N child CB devices (each with
its own IOMMU domain), selected per-process. There's no existing GEM
helper that takes a per-allocation device argument.

//Ekansh
> 
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Adapt to the dynamically-sized device array introduced in patch 07
>>   (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
>> - Protect register/unregister with the process_assignment_lock mutex so
>>   the device-assignment and device-registration paths are serialised
>> - No functional changes requested by reviewers on this patch
>> ---
>>  drivers/accel/qda/Makefile             |   2 +
>>  drivers/accel/qda/qda_drv.c            |   4 +
>>  drivers/accel/qda/qda_drv.h            |   4 +
>>  drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
>>  drivers/accel/qda/qda_gem.h            |  52 +++++++
>>  drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
>>  drivers/accel/qda/qda_memory_dma.h     |  17 +++
>>  drivers/accel/qda/qda_memory_manager.c | 239 ++++++++++++++++++++++++++++++++-
>>  drivers/accel/qda/qda_memory_manager.h |  30 +++++
>>  9 files changed, 559 insertions(+), 5 deletions(-)
>>
> 

