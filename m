Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC7CC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 603C310F65A;
	Thu, 24 Sep 2026 15:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BKFiGTAa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JGz386te";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A81710F65A
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:24:08 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4tZb803928
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=iSJGEOaWnOQsAtOO7cFRQJIYsioL8PCNRmlmGKoYK+c=; b=BK
 FiGTAaK7AiaGU4i0w/nY558Yucoas9ghxuei1filSjCk6bNgn7VSxk2s8K2gH58H
 Fezr0EOweVAJviAX0+Oo6RBjjBi6R/0jnght5FEMDJRgS9jappmj4c1ienF9LAHg
 ofSOb2yngGblENDPZ9o7j9yEaxR7MloOVi5BbEZ+Lw7Xvaf++2RL4coYqyHhqL4L
 KOMcjg5UGz893ArL05LZcEQB+UxlDd6PbnWDcxAXjF9vyxTiyutrIbQc8sAcBASe
 4Jhr40/h/G8dCvkTw8sUe9vOjzMkT9X7I3KZxGiXooob8zZO8cFfXO63QwL9hc5G
 bafdE1KzaSgKLiBOyEzA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1sc9bd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:24:07 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-48296f34f1dso2710030fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790263447; cv=none;
 d=google.com; s=arc-20260327;
 b=JSaIuWpSwLSRfvhlQWDgTfnFiEea9nJJ2py71sLxp2D74axX4Yb7Jzrsdn1zC3lvTA
 KQpKo85X5tZFQnSKHfj/psdE3JBS0QCtioNngqTiLGlU/WTSq/tK0JiWSvIdj4fCC1R+
 IRqFGSG5oEyvkgTqIr+xeFhvKiM4ZDw7wSguVhwPbVJy7XXzTnA/TBf3DVAJvh6yENKA
 BoHO6mUUZqKqX+BNZMGqWpMdOTzpy5B/L2MDebtP7LJEbk/FWljE3E+hHnaJsq2Flc4a
 rdipaGsNUW06WVK14ozp1oLmyOrhhw4thAx6mUg4REheXnTcTAAyhy0RYBDb8fDtntjG
 9xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=iSJGEOaWnOQsAtOO7cFRQJIYsioL8PCNRmlmGKoYK+c=;
 fh=w8i8GUNIJimx5TLebsJC14KH0pi8rdDxcisemxaC2Vg=;
 b=lOeE7h+hdaeMRN6Q6H5nYcZLOVn1gldf295asavzr0ZUgwFY2kfU8t+6UVTRBMRli5
 +oITNRjcP1QPDA1S66EPsIY448wsbDK7Z8qNE/C+8qgqBm4YLyEARB2GvirV0wz/csZF
 kCGSGUkw1iRcsYCVS/jRM7NHN8mhtBKlpsnMOGao80ZuuPlbpf+IME4RB4+pgBYu9/MC
 p8hWG8RDAk/crES6IZAEcA5Ccwk+7adKwdYWB7oXojeUmjFqilmB0iCW7LzlRx2C034W
 HfE8O0sXXAsuPiBiKYjaBMe9sZqahlDPkIIwavcpYoT9m+XMBGvsDSOoVOlhRo+70xDZ
 jUrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263447; x=1790868247;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iSJGEOaWnOQsAtOO7cFRQJIYsioL8PCNRmlmGKoYK+c=;
 b=JGz386teZQ/utDdCFf03Dlo2osu8iZq2ut4PPfQy1AoITM4ksND/hlvrXl+3q6YEIW
 yBBE5o7oQQr4clLiB+ulxrTXt+iceb9al27oo6bl5WfQAdcFfBhp+cbxAnrFHQ9NPUea
 lCmRfa8seOSoqa0c8nCGb/XamVAtkpItmVTqU+8AXgpmAvJpQxbljiiimeP5aByI8vX5
 QgoJL/M/C3Ar/JRjG2u4pUO+c7QaKeRPkOonh+zjgHcAiLOVLR2WYF2Mq2ijmfY53jx5
 UnoHuevj/ngxaCDAdTDrwGEf9trDiHExzF1I/wfymqHrumBYUrWrjGkR9sw5w/XhD188
 /4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263447; x=1790868247;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iSJGEOaWnOQsAtOO7cFRQJIYsioL8PCNRmlmGKoYK+c=;
 b=t9vylLGLLWx9Hk/0ReDeocXjuUILySkZ1hzBEZ8Jm91qYcce7DldaFAdOYGcbDbSPA
 YUuNOboILrpRRl8/BfMekk/nWH3j1HEy4RZSC06aZmqcbVyX096LFbVTEFZ6W6fnxCgU
 JlyWzKkU3eW7T7cbGl/KxTQsHubU/mOjnXMd3ZTn5idhJI3d0XqBOOWHFSO1EgzcxZzT
 iYEWk034ytdm9yP0Z/B12aa4KpZ4qmRg41GvTyUIqFWdMM7ry21vpWdm3FYfQxYO0xGS
 370x/hErhgJid+OOY5BBgXX72FJ5pEW8pA2IZdc5F7t31RyNAUrbl/czpXSUUNMiWf1/
 JtLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEJfb426fJT6DraEz6Ywk+MHSgesxNqYozfAOXUtHrcuOkArlcUKgw2X1TQaBnMf3Yzf3ksb6tMBE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNgoexvXiazxFiATTR8zshIzaf9gv26a8JjowMqLCucwUncCLL
 pa8xawf9vNLqji1991ShqJxZ5CCcVJXKImcvrcHOPfWm3MDjpmNUjpYhKmNaJX8gkGDEyyIowZB
 Wf2SfS3BfjykH9Zl4cQ5DEhs9eIgw8JDtnX0Pp+bIGrNy0Zl/9f/OT1UAnIwNH3guVGTmvKSxJX
 999ZjW5Huz1otdYdn0Lnzvv1CQ3lTTnmTXjN5JCqfmleSkeA==
X-Gm-Gg: AYBFou3EHi55fmyTherHXd8whKv9JikO1MxxBlXY4z+3/dkYkHDNFt4d4W3CvOC+lEO
 WjiccHFf1+wu8XKUyoemFf+DKw+kz3DuTa0Ut8NHR2vcjC4BPdiA7P9URsXnIZm4zEJTMtGQ32O
 ghnqTOnciamkavM0hh5OPUnxW1rmuGG6rfUKyGbSAz2rbzuK6IfgKhCOC7
X-Received: by 2002:a05:6871:7c04:b0:475:e235:8ff with SMTP id
 586e51a60fabf-491e6ded9a1mr2702872fac.29.1790263446559; 
 Thu, 24 Sep 2026 08:24:06 -0700 (PDT)
X-Received: by 2002:a05:6871:7c04:b0:475:e235:8ff with SMTP id
 586e51a60fabf-491e6ded9a1mr2702840fac.29.1790263445947; Thu, 24 Sep 2026
 08:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
 <fe3a4297-f300-451d-9763-0b3016706111@amd.com>
 <CACSVV01NZROH9U5Qjd1TSDu+BPyyPLC9pFByqSfrxXrPJV+wZQ@mail.gmail.com>
 <20260924145419.47354-1-liujianfeng1994@gmail.com>
In-Reply-To: <20260924145419.47354-1-liujianfeng1994@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:23:53 -0700
X-Gm-Features: AclHuK_WRAYAvS2UWB0hTgewsu2euKPCpECh3qJVYbGPrKE7NCVbxLwrzOLrmGk
Message-ID: <CACSVV00tYa18fijNfSSwzE8tgYVqHK5yp4zohwdTgvyNK8SREQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] dma-buf: keep DMABUF_DEBUG off by default
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Bryan O'Donoghue" <bod.linux@nxsw.ie>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Ye3UKtRmHK6OrOqNsChp7SKNYfc6rXFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXxSD+RJen+O9L
 OLrQUxwfarrT/+ziigrIZJHfHmO7cG/DkABoX8nReQineT0HFCCbJFmQ5jX3C4UvIo8JkfZtcZh
 7Y6LmIk+eU7msHK+3SfOSGFRt32pwuheUOj7o9EH6l/iRTXJ1valwfVQXj2vDI05h25VTaLlL8e
 vJ4976lLYGnuweU0RF6op+QQdzCyu09ITod4m39ehaJ2km7f/nFt0zCu6fkFbFBIbV1aZQCP29A
 Vz3IgC68az2HWlik9yu9HSn0elQHyvGvQPb361V1ZmAG+AcJeA8/ztgQpXiGKTAkgOYF7ghAi1u
 SE5dDB1nO1XdIsSnz/PkTQqk/PvnSD9QLQ7k+1G8hPuTNtVBGatfS9qanTk+Dpx+Y157lSQ7WLE
 sDwo8X2UPLPHOUETstCbJbt8iYHZMhdiqVAGqyeZPSUX6BvQD1yt03ypnDacnmkkfBSdpEqLjS1
 2137SZaVRzohwnZoMQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX4vrnl/2ZnJHC
 N4AtGxa5nzn5hYC0Dfib6j9npSikiXRkdundnEec+glMWyMY8m9RKDkq6Jjkp+Df+FyuLJ4tDSA
 A66Z8eDOs6WnnWpjUqiif3vksxPB4VU=
X-Proofpoint-ORIG-GUID: Ye3UKtRmHK6OrOqNsChp7SKNYfc6rXFJ
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab54097 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=ntJSuBRzbTKlmYc5m18A:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Sep 24, 2026 at 7:54=E2=80=AFAM Jianfeng Liu <liujianfeng1994@gmail=
.com> wrote:
>
> Hi Rob,
>
> On Thu, Sep 24, 2026 at 7:01 AM Rob Clark wrote:
> > So the assessment of what is going wrong looks pretty wrong..  VM_BIND
> > should never lead to iommu_map_sgtable() (which is never used for gpu
> > per-process pgtables), for example.. but is used for mapping for
> > scanout.  And pages are never used for mapping in either path.
> >
> > However there are a few places where sg->length is used (in iommu code
> > and msm).. AFAICT dma_buf_wrap_sg_table() zeroing out sg->length is
> > what the actual problem here is, rather than any use of struct page.
>
> Thanks for the correction - you're right, I mis-traced the GPU path.
> The per-process pgtable mapping goes through
> msm_iommu_pagetable_map(), which walks the sg_table with sg->length
> and sg_phys(). With the wrapper zeroing sg->length it iterates the
> entries, maps nothing at all and still returns 0 - which explains
> the UCHE translation faults without any error anywhere, and is a
> nastier failure mode than the async-bind-failure story I wrote in
> the commit log.
>
> With that corrected picture, DMABUF_DEBUG=3Dy breaks msm in the map
> paths themselves: msm_iommu_pagetable_map() for the GPU and
> iommu_map_sg() for scanout both consume sg->length, and
> dma_buf_wrap_sg_table() zeroes it, so every mapping of a
> page-stripped sg_table silently maps nothing. On top of that msm
> also uses sg_phys() in those paths and
> drm_prime_sg_to_page_array() for the page array, so even with
> sg->length preserved, page-less entries would map garbage
> physical addresses instead of failing loudly.

oh, ugg.. I overlooked that sg_phys() uses the pages under the hood..
I think using sg_dma_len()/sg_dma_address() instead should be fine in
msm.

Otherwise, (other than the fault path) obj->pages is mostly a proxy
for "is backing storage allocated".. we could just use obj->sgt for
that instead.

> So it looks like this needs work on both sides:
>
>  - dma-buf: preserve sg->length in the debug wrapper, so
>    sg->length consumers at least fail loudly instead of silently
>    mapping nothing. I think that is what both Christian's "we
>    should probably change that" and your "zeroing out sg->length
>    is what the actual problem is" are pointing at.
>
>  - msm: stop consuming struct page and sg->length of imported
>    sg_tables, i.e. build the GPU and scanout mappings from the DMA
>    addresses, plus the drm_prime_sg_to_page_array() cleanup.
>
> Is that the right split, and is there a preferred direction for
> the msm side?

On the msm side, I think we should be using
sg_dma_len()/sg_dma_address() for the immediate issue.

Maybe we can just do the same on the iommu side, but not sure what
various sharp edges might exist with other iommu users.  We could also
just stop using iommu_map_sgtable() and inline our own iommu_map_sg()?
 It looks like there are a few other drm drivers that use
iommu_map_sgtable() so it might be worth at least trying to fix this
in iommu.  Presumably if there are issues with that approach an iommu
maintainer would speak up.

For the longer term cleanup, I think we should use msm_obj->sgt
instead of msm_obj->pages for "is there backing storage", and allow
msm_obj->pages to be NULL for imported dma_buf's

Given the late stage for v7.3, the immediate thing we should do is
revert the CONFIG_DMABUF_DEBUG change IMHO, and try again once we have
sorted out what to do about the iommu_map_sgtable() path.

BR,
-R

> > (And yeah, I should get rid of use of drm_prime_sg_to_page_array()..
> > but that cleanup that I haven't found time for shouldn't be the
> > problem here.)
>
> Agreed on it not being what produced the faults - but it is part
> of the same contract problem, see below.
>
> Also answering Bryan's review of patch 2, which is in a different
> branch of this thread:
>
> On Thu, Sep 24, 2026 at 10:36 AM Bryan O'Donoghue wrote:
> > Why is the fix Adreno specific ?
> >
> > Shouldn't this function be ammended with
> >
> >  > +    if (filled !=3D npages)
> >
> > instead ?
>
> It isn't meant to be - msm_gem_import() is the shared GPU/DPU
> import path. And putting the fill-count check into
> drm_prime_sg_to_page_array() itself would indeed be the better
> generic version of that guard; I checked the other callers
> (etnaviv, omapdrm, vmwgfx, xen) and none of them expects a
> partial fill either. But with the corrected analysis above, the
> page array isn't what produced the GPU faults, so neither variant
> is a real fix. I'm not asking for either patch to be merged - the
> series is a bug report with code attached, sent to get exactly
> this discussion going, which is also why it carries the RFC
> prefix.
>
> > This very much looks like an LLM generated patch - the commit log, the
> > large comment in the code and TBH the solution too.
>
> Sorry about that - the patches were drafted with LLM assistance
> and I should have declared that up front. Any later version will
> carry a proper declaration.
>
> Thanks all!
> Jianfeng
