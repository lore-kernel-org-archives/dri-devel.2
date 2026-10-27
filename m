Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76986606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WGeU6VH+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kltzb/ow
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C15F10F3CA;
	Tue, 27 Oct 2026 11:06:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331EA10F3CA
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:06:09 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAdv7J2523902
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wIT2c8ssR3PQ2F/Yil9tuvb8L0yquFHB256Wm1sk66s=; b=WGeU6VH+oHYBNPf7
 0Ij+Cxgo2XNvYPf+VLXcpOpPN2fUSuGYLGKC7jjXf9ujHoTB0J7pTH1b2l9AK+h2
 ymZTBqCAy60wzTmwLuzyaKLKMBu0rEJfAnJV4igTynzjEFS+iHcrrcYq2xiJS2im
 AukZyKxr6fiszdE28FPrBCqOtWOEWogV1vvRNA+GL23aHgJEgkTiwwnKkM9tjUvS
 Ei8Ev0bhF+dpQ89uxH5yNw+ZC5TKGx9xdeUhObayvni3oFD8EeIUKU3B5l9FS5hC
 IsEJCKh1AtDF49KEoKKv86QJceB5ZnKumMn1n60KyNeoRh2w6zCAdx0NoE34l/Wz
 nVcs1A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw20rf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:06:07 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf3a0a498fso768503137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793099167; x=1793703967;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wIT2c8ssR3PQ2F/Yil9tuvb8L0yquFHB256Wm1sk66s=;
 b=kltzb/owfItot0fhllzhKeJKktVdBaP0RJCr2tTxz7c5XL5Vxk7rhvYiiXVzJ14J7K
 /Lx2RjnJMfQOtYUFhF6WT/HkjgH+k/kfIOu0bCLPXEPElvwdhJKwPiegWbT06m90YhLN
 eF5CZm1YczpgmqBn4gMPsRhaqpTwq658OJStJ/AOUuEJEBAJ627U+S8zrwhCdyt027VN
 oRtVgSgllU+uGtYIoe4altAQjG4Cnp9usTs14TJGaGrvxDu7m9JQ5Hcsnbjkwds0+/Og
 aYQYDVA8oqBkH8eecmm63opqyRj8ZE23FqAln8ae5oI/8k7IEnUsSnKOLCN5iX0KoolH
 RgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099167; x=1793703967;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wIT2c8ssR3PQ2F/Yil9tuvb8L0yquFHB256Wm1sk66s=;
 b=HPB6jrYHCXykNOB9CHGyCY6ytLPns61PhP+5BNcVHKBTs33zYWxyIUShQyZsxugB/z
 rly34MTx1yO+bY3lfHE379bFd8kic3Z+U3u/JvMZabusLs/ne0UZugR5rHlaSyIGgNyn
 vs1fu1Puv7OqH8UQioH8c2ArYhR522yiVQbZK2jUODS8MdQXTgM+uaU+GV77u7w3vRAH
 0T3sh+lIqXoTTww4uWDpCh0KeWd0a/dzwAut0Vq7J3G14KDAsgMZc/O2scjIwO+hD0sz
 J3ZBalmKkww8fAjOCot5e8CyUQ8kSaDEU44zGeVFpJ2mUUKrHLlKUR8EbGQRPTMl6cVG
 R3WQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBycJQZBgUXowgUuxLA17tn93VDBN32KrMghXckw7wRdLbCHlkcSzi0sOtmr6fHXTxHV6YwVZeXM3UQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKIPg95EC4m/5v/+3ugJgcefQp2LhVgGn94+Lm8spLSB2ehs3cc
 ImQMpubgtIkc8z5vOOJrDq0twyKmCBLB0mS7p5G/kWWPcA/78Vcp7WBCzrc+u8izE7OPYCN7VEG
 2lIjDWWmKnX3/eILkuhjhtcT9PbaOvS5rVp6jxJlZZXQK0Au5iR5BZBM3Ih8USCMFjXgKC8I=
X-Gm-Gg: AYBFou36qR+UHwj7Y1eDpfdY5UjT9Rv8PaU7Ofj79FrEkIkxhoFpVj3MLxu5P/kQGiz
 Gw0B/NM1x9Sq7I1x/1B8OgpT1d9/H1dFErgn6YcrwmsW9WnI4hFN3lz5q+Xo4ni+x6iEKDgbcvr
 6t8B41eYgEIGesQbyjeVerxjDF3RDbbovojbR4c+Rm9iTgOV4oDWw/4GSWQLdXEkOGOcs+j3EcZ
 8nnQoU0BYHTxwrcRONMRk0a2TeQwx0b4z+VwDaQIKbcYL2haHvOhwJyOkNmG3tiS9bZSytIhrdG
 kBplSr1Avp5DNUgucArjIvmNg1fClLO1YCOWgSsGLmAaUB3dSbAWmMQWx2xldRYYdtP6aDZ2tEa
 YJtDmQq2qEkw43sg88Du7LalGOMybXgJOT7jlLcSyfXOazS2MOvnnDJ/wRtFuexnEWLm19p6nJO
 Jp/RTsX1ldKfFc
X-Received: by 2002:a05:6102:2910:b0:78a:4dff:7b3e with SMTP id
 ada2fe7eead31-7cea1474628mr693720137.15.1793099167083; 
 Tue, 27 Oct 2026 04:06:07 -0700 (PDT)
X-Received: by 2002:a05:6102:2910:b0:78a:4dff:7b3e with SMTP id
 ada2fe7eead31-7cea1474628mr693707137.15.1793099166585; 
 Tue, 27 Oct 2026 04:06:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm2034967e87.81.2026.10.27.04.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:06:05 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:06:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on
 handle close
Message-ID: <xa6erwmfju7xmrsmg3vsafwhdhwvyqqwjsgq35hb4ecoiwffau@r2fb6ft223vl>
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
 <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
 <CACSVV00sJmmRqpTJUD4AfB5-LJRCtzdWDTKVCQwH+y-uYYYMbg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV00sJmmRqpTJUD4AfB5-LJRCtzdWDTKVCQwH+y-uYYYMbg@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX0I4d4TriO7yu
 y5hxova50XXm3s/jnrP4evCu/mFD9Ea0gmdAqHsXyr7SlsbVh2E6y8Qjsi5hSkapfi9oh22ltKo
 GxoDq0fd2GEHVD4DWaFCm9c6IaaCC2Fbw4DFURNfhPqMwwZlbR2LgN5HCJEhYlFf4gxpnppqPn7
 LZkJg1FHxXeEPGTNIhpN27v8MX2oQUERSb2XYs44l56LKaMQMn2fapIazsnAtkDKyvzO65kjZlB
 YsYhUWrqigtOfE4gPSxQX2Iks0ix9F8bIvwlt/z5pWLOYX8/CtnuWSRJcEdgSo0bXt6XFSoVfgr
 w0yqE570J3idkshplSjhPBu2A2WEkh5e099xswMZeGHjAn3fUxelE7NVl4oO1b1cxT+nNISfnxs
 QYWdOWevK7dg4u2zuT8+E0q0CWntGCgRIafjOV0pMjYLHGzqPP4WaKcN9WeceJY6YIKthZhISvb
 f+qEsg+AnaT0me7StDQ==
X-Proofpoint-GUID: -gdGkzc5ALNj8M7ue9l5xvKxraLCETQj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX2TlRVbKGBwaK
 zemNJFjmbsDamd0ki8l0uPriAWpi1bFa6e8W8LqJactUge45Us26jhuFkGUI6x9DNL7V5pJmx4k
 rDLE36dhdhXMhvaopHTr3L+pQW0fcXg=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0859f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=g5l33MZIfMJ3XeZK2UMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: -gdGkzc5ALNj8M7ue9l5xvKxraLCETQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270044
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 07:54:32AM -0700, Rob Clark wrote:
> On Sat, Aug 22, 2026 at 1:49 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On targets (like A530 / MSM8996) without per-process pgtables
> > msm_gpu_create_private_vm() uses the global VM, so all DRM files share
> > one GPU address space.  msm_gem_close() unmaps the object from ctx->vm,
> > which on those targets pulls the buffer out from under every other file
> > that still has it open, and frees the iova for immediate reuse.
> >
> > A dma-buf imported into a second file hits this as soon as the exporter
> > closes its handle: the importer's texture keeps sampling the old
> > address, which the next allocation has taken over.  On a530 this is
> > every ext_image_dma_buf_import sampling test, reading back all zeros.
> >
> > The VMA teardown a shared VM needs is the one already used for kms->vm
> > -- defer it to the @vma_ref drop, when the last handle and dma_buf
> > reference are gone.  That restores the pre-drm_gpuvm lifetime without
> > reintroducing the reference loop, since a BO with a live vma_ref is held
> > by userspace anyway.
> >
> > Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gem.c | 13 ++++++++++++-
> >  drivers/gpu/drm/msm/msm_gpu.c |  4 +++-
> >  drivers/gpu/drm/msm/msm_gpu.h |  3 +++
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index d27d54bdb7a7..7722776e9129 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -223,6 +223,9 @@ struct msm_gpu {
> >
> >         struct drm_gpuvm *vm;
> >
> > +       /** @vm_shared: Has @vm been handed out as a context VM? */
> > +       bool vm_shared;
> 
> nit, this seems unnecessary, just check if vm == gpu->vm

msm_gem_close() already checks if ctx->vm == priv->gpu->vm, but most
msm_gem_vma_put() callers have no ctx: the last put often comes from
msm_gem_dmabuf_release() or the fb cleanup. The teardown can't be
skipped there either, as the VMA would keep the BO alive. The extra bool
looks like the easist way to determine if the driver used a per-context
VM or if there was a fallback to gpu->vm.


-- 
With best wishes
Dmitry
