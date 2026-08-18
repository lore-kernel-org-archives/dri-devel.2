Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F345C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4871E10E374;
	Tue, 18 Aug 2026 03:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjZNdmdE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LIhffCF8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3549A10E374
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:55:22 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkZV83370195
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fIDHdR8mBDufcyoMeVvzq2X8Hct6JDvye32GDsuwzKU=; b=UjZNdmdEvZ3uV/Ns
 wRy3pn5KYobDO/1Je4OlC0Lgb9OwtZ+nsO95Hrosii7ZoDe8IKN9z7IQLTGtFNjl
 CJTE4clwlBtdM2FGNikYElxOBDEu9VPkDi2TJMgP30G97nnStzuBo6OZ98iPHq73
 av8rzyDqj3MYRhr8rSjeSwIwvqd50GGeLk7VgiysFm4V+1bFs0vfwCmNgH1jSTCn
 BLwBXjLHFh9giTlHpSqJ2jNR03YOIqg8kAvnDpcD29TClve1fDNyRly2qvX1IWjr
 Si8idMOYvQax3Qk1vMTbOjuL/otabTwzpJYGUHOWABc8a/Q3zIm3gnRXJG1XAx/e
 FUDFyg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xykcbvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:55:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936a796a23aso362455285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787025319; x=1787630119;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fIDHdR8mBDufcyoMeVvzq2X8Hct6JDvye32GDsuwzKU=;
 b=LIhffCF8Vwo5nzi+cR2MbytdqhuYmnm27J73M/tKFCplx/eAL4hJszW+dBD13XBOxV
 J12tZ8NAsNh4GxvGyWjtyjfIJ3FKOba3Qh2re4WJpm8CnJQcZnGcbFKbnw7zigkvPl6i
 HpqX1gBN+QwN5UHncDwHiqtgn9luNMyC3VguZs+dIdzP/ANXBh6dgWPgUL6ib0WVnCaD
 qsIoJrYiPBJIqtndfW2MeegnI+i9sW02kVQ6WmMR8x6j359XkmLhA4IXkFYeAcM4OSoj
 UElRLWNDtZx2TtM/vf615c9I/td5T8V5YRDhbuMEHpv5+/CEJmQzXuufse7B5WT2QMsD
 st5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787025319; x=1787630119;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fIDHdR8mBDufcyoMeVvzq2X8Hct6JDvye32GDsuwzKU=;
 b=iskiJer+6LS13eHIff+98MkGqqlWwVVphk+T+WtKf1PCGNO54noXmGe7Ld+IALnkSc
 FMz9r5ytwVLJwzEJQ7GN3tMU4e/1Yux4Xi3t48fd67YGIyISgF8zcdGEpe0/EtJRIEwR
 9RlgNbpKhqT2eynFwLh4S5SrPjqyuZMertyr4GRxZX7YPnJv4b7RjagyS+GLlWHNDaF7
 JedhulnpX1cuT8FW9TgvYH9VxOaGX8G0lQBD80wdapF/6FC1H3DrJP6pOTKD80jD86JX
 qRO0PzkVjAdrDJxFaOgEToxYU8u1X37tqnMyadbL5U7zJbRYzKTZEts7B/wdWIO6LNLR
 cHGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJoIG6CgewZmY2J6WROt5OOTj/mwj83Bi3D/9wtygd7ZO5xPgSu6PCzQ7omGQA3o5c7X0Nt8tiAMc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx79gfcysOHnXBbAR6vmaVPr0IptoLDsVSqcWe9os1wRNGtp1N
 fpQps+NUxKocXAjhhnVkIgPAw7aHpYjrwmBpPolUTsoP3OmvikyNvLi0PuQSEOgKpgP4hek6T14
 Ty/80cWM6RlD6vvpeBMbuOYT5KkxKhpH98oUVRgD8HrAkdvd6MUPnvnZPxc3Ua9n0Ao5mGnk=
X-Gm-Gg: AR+sD10ECwoCuRMmb3XgTVTD7fsjXoGsa58BA/3OH9oE2leFLhNB9UpKNRy7irEmv1T
 8fb76WOX8DlaozS6FmAmg+6N/tOAzpWVHW08SVa+bkJchLDx5to+28YepULW62tvcWWDtzVW8bH
 qmWi1qqzGyu8u76drPe0L8swVNqy/drWRVvFgPxdqYByDfhzT+99F8OO0Jg3TSgzJswYRHLutYA
 PWC0unlvVxWBKf4yXUQ9EwoNIIFTmkeKcQ+JOX7rZrCmg2/XcfJ277cZRiN2EaZ1SB9qOWdR04a
 qpdlAQ2NW4mcGslBWmi5uR/fGoZEU9tXp9YlIrc+Sqeaf3nvD0QXS6+3N5J7WKfNWqt+9Zphi/9
 cMYApGAQNuCYgo9NH0/tc5ubay4lQ9gdD8LyC6Vd5S9apslPFdb+57xkNJL/aepD21gJSGY1rj4
 2K8gltJnnntFLJ
X-Received: by 2002:a05:620a:668e:b0:936:befe:42a4 with SMTP id
 af79cd13be357-936d23a10c5mr2130460685a.42.1787025319435; 
 Mon, 17 Aug 2026 20:55:19 -0700 (PDT)
X-Received: by 2002:a05:620a:668e:b0:936:befe:42a4 with SMTP id
 af79cd13be357-936d23a10c5mr2130458785a.42.1787025319011; 
 Mon, 17 Aug 2026 20:55:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cf95803sm853242e87.1.2026.08.17.20.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:55:16 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:55:14 +0300
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
Subject: Re: [PATCH v2 11/15] accel/qda: Add PRIME DMA-BUF import support
Message-ID: <l7gt2mr3rrnzmkc46ntqw5e5sirdimavv5do4wmdf6jktryp7g@772ovv3qlgcv>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-11-69a02e9090d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817-qda-v2-v2-11-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-GUID: Wm_C3NgyrcT_l1aj5f-dMCru07INLbz4
X-Proofpoint-ORIG-GUID: Wm_C3NgyrcT_l1aj5f-dMCru07INLbz4
X-Authority-Analysis: v=2.4 cv=dLaWXuZb c=1 sm=1 tr=0 ts=6a83d7a9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ocRE28ydX6du2WY3eHAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNiBTYWx0ZWRfX2Yazb914xH1Y
 WKOLkrGO4docRF8s+GMN3soK3AM1rdvDBzEdmgmL5ZGFBBGGTr/lDdEKdiX01H4AYYiqLkrtzOr
 ggApjmZDTBVNRaAA5nxLonm+ut4IXJ+VOcGi7sfDe8400kgwESPn2tPGtq16s/OnBqO7oo876Tr
 KxJP3hDY0MgkRipFZ0bi0xWSBHZGtsunIda1mMK/z1ADVzccDqwuI9vC9kUyyl4+/TWiBWCGqXc
 2KqEvj9kkuppfYhnHxwGNrCv9NBS8Sczswr6G4AzT7cvxfWV3k9uncBBlJDBZrFvijwePLDK4OS
 FSgjTP0Mh1o2uYvl4nJbxA7kvdQ0dQSa19Ht1nS2qpxU1PU0Cpdbkc+GACxrVxOUwZyOxk7wuQK
 VclnW1K8w1Q0qncFM2A971nCgOoERpl9KVw9I/sWOdAdZVSoQZQgpykQOIJgI5P9v+mG8CCIkUA
 ZVX1UUIS2Sepx4Lfnbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNiBTYWx0ZWRfX+PkbDpxUDZPC
 hRjbYeisWd50PNn37vIDH/pw92w+8T25Qh7dLyjpEMHqNQGtwKnyEYqykeKb7otIchU+/w1/IK8
 v83V/H8bTTA0c9ijgosG60V5BGhNWuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180026
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

On Mon, Aug 17, 2026 at 10:17:46AM +0530, Ekansh Gupta wrote:
> Allow user-space to import DMA-BUF file descriptors from other
> subsystems (GPU, camera, video) into the QDA driver via the standard
> DRM PRIME interface.
> 
> qda_prime.c
>   Implements qda_gem_prime_import(), which is set as the driver's
>   .gem_prime_import callback. On import it:
>   1. Short-circuits self-import: if the dma_buf was exported by this
>      device and is not itself an import, the existing GEM object is
>      returned with an incremented reference count.
>   2. Attaches to the dma_buf and maps it with DMA_BIDIRECTIONAL via
>      dma_buf_map_attachment_unlocked(), obtaining an sg_table whose
>      DMA addresses are IOMMU virtual addresses in the CB device's
>      address space.
>   3. Calls qda_memory_manager_alloc() to record the mapping and encode
>      the SID in the upper bits of the DMA address, matching the
>      convention used for natively allocated buffers.
> 
>   qda_prime_fd_to_handle() wraps drm_gem_prime_fd_to_handle() under
>   qdev->import_lock, storing the calling file_priv in

Why do you need a separate lock?

>   qdev->current_import_file_priv so that qda_gem_prime_import() can
>   retrieve it (the .gem_prime_import callback does not receive
>   file_priv directly, but the context bank to attach to is per-process).
> 
> qda_gem.c
>   qda_gem_free_object() is extended to handle the imported-buffer
>   teardown path: unmap the sg_table, detach from the dma_buf, and
>   release the dma_buf reference.
>   qda_gem_mmap_obj() rejects mmap requests on imported objects, which
>   must be mapped through the exporter instead.
> 
> qda_memory_manager.c
>   The DSP is given a single base address per buffer, so only buffers
>   that are mapped as one contiguous range can be described to it.

Is there no IOMMU in front of the DSP? Can we remap the buffer to a
linear are inside the DSP map?

>   qda_memory_manager_map_imported() therefore walks the imported
>   buffer's scatterlist and rejects any buffer whose entries are not
>   contiguous; contiguous imports (for example from the CMA DMA-buf
>   heap) are accepted. Whether an exporter or IOMMU coalesces a buffer
>   into a single range is not guaranteed, so this is verified rather
>   than assumed.
>   qda_memory_manager_free() skips the DMA free path for imported
>   buffers since the memory is owned by the exporter.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Do not assume the exporter or IOMMU maps an imported buffer as a
>   single contiguous range; walk the scatterlist and cleanly reject
>   non-contiguous imports instead (Christian König)
> - Document that only contiguous imports (e.g. CMA DMA-buf heap) are
>   supported
> - Return -EBUSY rather than -ENODEV when no context bank is available
> ---
>  drivers/accel/qda/Makefile             |   1 +
>  }
>  
> +static int qda_memory_manager_map_imported(struct qda_gem_obj *gem_obj,
> +					   struct qda_iommu_device *iommu_dev)
> +{
> +	dma_addr_t dma_addr, expected_addr = 0;
> +	struct scatterlist *sg, *s;
> +	int i;
> +
> +	sg = gem_obj->sgt->sgl;
> +
> +	/*
> +	 * Verify that the imported DMA-BUF is contiguous. While some platforms

Which "some platforms"?

> +	 * or IOMMUs might map buffers as a single range, we must not silently
> +	 * assume this is always the case. We loop through the scatterlist
> +	 * entries and reject any that are non-contiguous.
> +	 */

-- 
With best wishes
Dmitry
