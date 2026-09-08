Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888FFC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 23:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B273E10E53B;
	Tue,  8 Sep 2026 23:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hmzqmxQ4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vzvrs7vX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E4010E53B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 23:05:24 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Mgbqe3697408
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 23:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /GhhHa8OWdtOiPSMUGlb1pW6jJlr+86zcpdLSW1zB4c=; b=hmzqmxQ42BEaEeVT
 IvNKp7PG5jp6hEdrg0XvJzRNv5f6ND/AmKEpWuGd/N5xmhEiJASv/TWngbjQAqzh
 7gCMVK4IQCk3Z8PBOM9Xh6ZkGqqHV+2j+WW8hmFsyWuexQbLjafy+z73SG47xBcX
 vAuyJtWjOgbFifUvlCB9tSXi3R81jy9c33TvL6BpYJg1M5iS8RVvdpjCRTLvPoGl
 UTPT/0dCwtgWp67I0l7aZZViLCVvM+LgN6AZrRF27MyKSN3vxxEiJYL0VbzAGnSO
 R/yKHeK5QEM8WyHi7a0gvAdRlAo/n68JhMLAeMoDRwTKEdMroGjl9mbWdW5fYszH
 KQoBtQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvujngp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 23:05:20 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-78481f4ba52so4680381137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788908720; x=1789513520;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/GhhHa8OWdtOiPSMUGlb1pW6jJlr+86zcpdLSW1zB4c=;
 b=Vzvrs7vXKPq7Ws1w8GiltxGcsOfHDG35/S7+kybOA2FLAs/kAChoA+rB7YDy+aW11k
 TKM7EgrgcEhx20wG462coBLhIaAUqltutiG2FFsqjkfOAaV43UOIq1zBxb4BYCoo/e1A
 yBiWcKPUcsNWcG4m9EIoXNVQ7a+4c/Pr9ShXTKUEv7Y0yUvTdsXXDyEuTX3LfXc5PCxP
 hBNnXrrnY1qV6W+uiFhGt3424DcQ+NpN8sbl60uFygIDC9KgiFmEBECmWxWomptwRu4c
 k078+/IHHHbpZLLjipsu3w40Ma/jyc2QMRGvYNLYe7gaSd6Pp+r6m6CSJlvb6cjgXFm6
 +x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788908720; x=1789513520;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/GhhHa8OWdtOiPSMUGlb1pW6jJlr+86zcpdLSW1zB4c=;
 b=ZyO4omC0U8dJFWOihwowEC0bEIPTCjiWlE3h3os1wqMTkLjdzhi6NNROAYODPtlpo3
 vsmpDjg990y6qawcf2hyybG0kOXZlsYoPC9rHodc93cTVOn1GvZ+82x5dtljwCkKULp7
 BTsxSEorjsVzQp7Tb4DYunk/5IvTNPIDETycRJYDrGEDCA5dsopam+7K149/s/w9vknx
 ySh31vQesCq4yKHPrTWdM4Q/MyGOo2tI3mCInE3MAZ52hWKiX5Enr0sSVYOo4chtFmKM
 8koMrZkMaZVLQFIMAQjILXIEoDoXaBYmtP5E9fh/j1XwpMp+13P/yCLrGzutcDVIzDBo
 sW5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnAug8d/FSM2g4QqUPJCsa/xxx7n7tDDo6QR5Y3l/p45vH3/jLHZWC2Ei03Cw7NnkUUs5EgUt6qEg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLv++4gd16qrMqH3XkI5oglTKxxgVbATCh9X9R4XjK4x0/Lu1M
 6efHWfbyJI8S0hwyy0zrE5Of7B9gM4HQQiZZzItE6kWTOkJuaOXip6EDEOBEAXKOSvTObcJ4bXv
 BUyP1pl97aenccGM4y5FcRVoEm2PJ05R1RcNb/q19jAHzs9aEjELlXwxAca9TS1elphv08D8=
X-Gm-Gg: AYBFou0BDf/gSfdyB+DuB9AtQ8eKYFav3adIts7GSyZ0y2DnDHu9NC7SVXt7drm/9hZ
 hXljM6uOsAQneRBPQaAySx2mInCdXLlqX5KS40YIZqjF0LxjGyPh863pWbSUx8CnjLS0kia87dN
 fG+kUrbzmGNyxlGM9yK8ae4cRrgCn4q7iUdw/yEY63dou6JbSbXb641bJi9PfxBQjaPyAxiAgxN
 S6UXNTUi/QLqbDt+Sgm3Ss6g4XnL7wYgk5OvsWx4K4wyKBguWTTdJUILfmiDvGRlVn+DX03svZU
 mnWaA+6GOt30M8iWa+5IbMERCH63jqgI2fHDd69Qw+CBAe25ZLM9QesRpma5+zE47XyAN43ZyAe
 e36fTVfW0kH8EuHsErriS4V+tOrXkcvPstMwTYgtERirOShnTOZIDf7bx5tRj5u5Dm86voza3G5
 iRmpbpQ8v/ls1s
X-Received: by 2002:a05:6102:e0d:b0:778:5bbb:b2d2 with SMTP id
 ada2fe7eead31-78a4a97bda0mr14097724137.11.1788908720207; 
 Tue, 08 Sep 2026 16:05:20 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:778:5bbb:b2d2 with SMTP id
 ada2fe7eead31-78a4a97bda0mr14097683137.11.1788908719796; 
 Tue, 08 Sep 2026 16:05:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a37058669fsm36735161fa.17.2026.09.08.16.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 16:05:18 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:05:16 +0300
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
Message-ID: <d4ykcbhd2bqisv47s6hutrpdtlox2aid3j6pkgif6tptivaqkn@tko3tts7hzcn>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-11-69a02e9090d4@oss.qualcomm.com>
 <l7gt2mr3rrnzmkc46ntqw5e5sirdimavv5do4wmdf6jktryp7g@772ovv3qlgcv>
 <c1da4243-36d1-4b65-a5da-f660ab8c63b3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1da4243-36d1-4b65-a5da-f660ab8c63b3@oss.qualcomm.com>
X-Proofpoint-GUID: DNYQszKtyhQzLMJi8yHV0niJssWmB_4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDI1MSBTYWx0ZWRfX+LfTkQQ1LW3j
 nKbV/JL+IH+/J6vSx5HVrE6Gsurnr8KwMVyRcpwptY6EHKVK2ocP3RI3PY9o0kWHxN4E1MUp8YF
 hbV+kxjSOX2obVdaypQ5nevubWLgQ16Att8qLfsT3JFZcRqr/OlGAM5RQ98EBM6LWYbBJ8/wQ8G
 79gDFB34JYXuFEBm3+yyCvPJMk7KxDLSFCGHmJmoDVgAaDSRchTYRk82rRcED+iYBGMMVeQdiPo
 JY2v0yHUS4D0Vi481F6YjN2m7qC2U9I9n+2q6ZaWZF0TX8Ojg4pqLuzCiWhAK3VEYiip1GeAiFi
 2nmpXP9XbUTGAuRVntUsJmlLLVb0A9wau7+d/vItogkfz3ppbPD4E5sHB1evjBdZj/qbjf9/6Ls
 SM2Ho+TVzLunmpHxHPaJk2EN08vxgjzVhIlfYNujHwQVpa5nQh/mwEiPoGcGZ1v7vaqx/9KMp/w
 c92BI1sXlZ6+UsSK1ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDI1MSBTYWx0ZWRfX0A8etIyaqohK
 IsGUt4ZeuzblSwv7qJNRVZpre08T3V6Tbn8GhZ7a53ztO8LpUA65e4EzACkPBjZeLt9Rv94fuYS
 DGaGER49hjWJyTtsbWFqzS04uomBUlg=
X-Proofpoint-ORIG-GUID: DNYQszKtyhQzLMJi8yHV0niJssWmB_4Q
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa094b2 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pwSLSVGh1Xxsrx2JAEcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080251
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

On Tue, Aug 18, 2026 at 11:55:50AM +0530, Ekansh Gupta wrote:
> On 18-08-2026 09:25, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:46AM +0530, Ekansh Gupta wrote:
> >> Allow user-space to import DMA-BUF file descriptors from other
> >> subsystems (GPU, camera, video) into the QDA driver via the standard
> >> DRM PRIME interface.
> >>
> >> qda_prime.c
> >>   Implements qda_gem_prime_import(), which is set as the driver's
> >>   .gem_prime_import callback. On import it:
> >>   1. Short-circuits self-import: if the dma_buf was exported by this
> >>      device and is not itself an import, the existing GEM object is
> >>      returned with an incremented reference count.
> >>   2. Attaches to the dma_buf and maps it with DMA_BIDIRECTIONAL via
> >>      dma_buf_map_attachment_unlocked(), obtaining an sg_table whose
> >>      DMA addresses are IOMMU virtual addresses in the CB device's
> >>      address space.
> >>   3. Calls qda_memory_manager_alloc() to record the mapping and encode
> >>      the SID in the upper bits of the DMA address, matching the
> >>      convention used for natively allocated buffers.
> >>
> >>   qda_prime_fd_to_handle() wraps drm_gem_prime_fd_to_handle() under
> >>   qdev->import_lock, storing the calling file_priv in
> > 
> > Why do you need a separate lock?
> Will add details in commit message,
> The lock serialises the `fd_to_handle → gem_prime_import` call so that
> `current_import_file_priv` is valid for the duration of the import.
> Without it, two concurrent imports could race and each see the other's
> `file_priv`.

What is different from other DRM drivers which can use
drm_gem_prime_fd_to_handle() directly?

> > 
> >>   qdev->current_import_file_priv so that qda_gem_prime_import() can
> >>   retrieve it (the .gem_prime_import callback does not receive
> >>   file_priv directly, but the context bank to attach to is per-process).
> >>
> >> qda_gem.c
> >>   qda_gem_free_object() is extended to handle the imported-buffer
> >>   teardown path: unmap the sg_table, detach from the dma_buf, and
> >>   release the dma_buf reference.
> >>   qda_gem_mmap_obj() rejects mmap requests on imported objects, which
> >>   must be mapped through the exporter instead.
> >>
> >> qda_memory_manager.c
> >>   The DSP is given a single base address per buffer, so only buffers
> >>   that are mapped as one contiguous range can be described to it.
> > 
> > Is there no IOMMU in front of the DSP? Can we remap the buffer to a
> > linear are inside the DSP map?
> The DSP firmware's buffer descriptor format carries a single
> {base_address, size} pair per buffer and it does not support
> scatter-gather or multi-entry page tables on its side. This is a
> firmware interface constraint that we cannot change from the kernel. So
> imported buffers must present as one contiguous IOVA range, and
> non-contiguous ones are rejected.

I think the main part of the question ended up being ignored. Can we use
_IOMMU_ in front of the DSP to make buffer scattered through the
multiple pages to look linear? Or maybe I'm misunderstanding what you
wrote. If I have a buffer spanning three non-contiguous pages PA, PB and
PC, can we still use that buffer with the DSP?

> 
> Will add this information in commit message and during the check.>

-- 
With best wishes
Dmitry
