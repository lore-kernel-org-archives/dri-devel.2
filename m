Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBA4C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC34110E320;
	Fri, 25 Sep 2026 17:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QCiX7juX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LC8SiWXD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ECD510FBAF
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 17:18:34 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG5L0r1759227
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 17:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=wlPheSorNXC3rOtR6BddKKv8TdJJ+ajZdWoaUxUSYcY=; b=QC
 iX7juXbh2Qhd4o2YIlA2o1bVApnsTTUkzsnv15kJAoUxv8RNuRFEx44kbww0qe7g
 NULoYGNVCFTJDkbi9DSJrvV/W5g9ebMAeZ8zq1ce02qeiGEaRKDaqPZ1nUC5JS1P
 R/Z8VS3VBCj7QOI38+eIEbJVfIpJ0FzwNnZgB7eu+OEHzp/v25pFfwg6lS4seFHh
 dlHWgFD4l7a0B7WOBkfDZX+y3GcpMMRudxC7bcuzNKiuwAttpAlWHSPpRYMKWCjL
 3VX4zSKjYdu4vvOlKp83ue7WK02cgzakMWkWeZzydIcm+X0XtbXM/GDok2eP0YSx
 jCOdpIfBZrSi5r9XciYQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwv5yr8uf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 17:18:33 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-46a5954cdfcso1343940fac.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356712; cv=none;
 d=google.com; s=arc-20260327;
 b=p8WRAWswuP+sANaz0uTeVR3dLBrQsRTAhuNATq1xJA8C7uY/li2Hy5SroMqzQtAhqx
 d6VvzGmKfEmqK+VJKR/n/FnGjbHvgI91lc6r8dohtXhBao7ni9IHpHmSXpboBFYsLx7S
 ec1pDQ3LHPSYU4d8hYq9RwneAfNkewrzHA//rs9Oxz1o+XKZT2i2mfXGycJyl0xIU6hZ
 9aDDHYu0rwh8Gk/Hlgo/FZF0ILYps7e9MPaqAV0h4B1GDi8ZiANYhagopd4cxRSIVcKc
 O0ogRgkz0JEiOiZq1KxLKc0Jr5oJDXHa3BJRMLtq6hDbPUKVH13QfnSr0345pl4wgPWe
 bbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=wlPheSorNXC3rOtR6BddKKv8TdJJ+ajZdWoaUxUSYcY=;
 fh=IUUTfBwEqfKsCsdGRsklmGKmGtSST8n1xELf8SBBAPQ=;
 b=mu6mR5N17iqj3L0Rm8HEoCJE+Rz0XZi93WbRgGt5V0sgJAbSshWDJpODzy+R+u+tkK
 vNyakk/hrSe8qD0MfMJQxMUk5v3kQgjJBKSvGQlgXYW5CK/Yk/HHXBdsy9pdUvPfTO3t
 ZSGhZXVSMYMdYSlvIvf9vRBb/qPbR/Ul/fb3tobx3i8t/Tk6C0byne8ckMzSqDbW2U5r
 0b68Qglc29TImGaZY1dk9u82JfBbOjZG54tzdr8C3bbZotHAWMqcROHjMvvHBaPZp1IO
 LFsUlnK2Qtf0uAjN1Hlyvw0SQwcfS5dkDPoo9HS3xXH9/Au9mPDVFdrGnF0/oB+QdtwT
 SSpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790356712; x=1790961512;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wlPheSorNXC3rOtR6BddKKv8TdJJ+ajZdWoaUxUSYcY=;
 b=LC8SiWXDstrOUw3m94u7XGzkVeLmVuEz0/Pn0nQUkqYi5mr4eMTikYTk5OGOs/JyD7
 N7NO03LfEFXpDPr9XPX+Uf98OtX5Isui4ImqF3ZyL7kV8IFOkUIKoldFJeF6ZIsaOxQX
 xGRthcI1e49GGN1Ww0WlPnGLMb6c2auwj1IhBQgsq62s0+F2833Zq+kuEu241Bgjbe/M
 ePXroGhA1e1FMyVP64w9AedBAPVeWJp71W78/M3ctfE8fxAtqJNvbCvHWsRbzlvxzcwQ
 +fVUvHvzJpoDsyOWvLfBtduABkXsJQE7Cvn4MxBNFyoY27Bb7ZfJdv2XOvkhn5vbmJpM
 SnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790356712; x=1790961512;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wlPheSorNXC3rOtR6BddKKv8TdJJ+ajZdWoaUxUSYcY=;
 b=V9GmVW9dbJGWndPmfh9NxBg8XM1tkRKegplZ5ZDJ5SOTYrrOYJM48YmGVdpD5z4ITk
 006Bh8+BfmINHkOWlWJDynlz8AfR9Ic9ZXsK0RcpHiJ/ZLVCMKI+Fv+IBiaafGY3OGZ1
 tKU9Y6b5YXrdYPXjaELIAvXXZEsOg0pD5KTOp2G9oiJ+/G+5X1/01ZS9332KVxPkcJo4
 5A/L9VFVsZdnhBAUVCDM3zqx/yncFPVB8gQv9IH3umUmZxqXIuETABT5FLlgJw4t+hT1
 SG8QpQ5jc1gY/PWtR9TDakpMiWwfJTHtgfwkrPl/+mbIm6K2ajY3rGvAFQcgpynCaW4q
 AduQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBztDflf2cvBCnCDIiAyEr+HXSB6Ooo4tqDGh1r6n5KIT1B6+vesWhs5kJurolS+eNnaw4Jgrfi03Yc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kGU8A4USS50UPRO1VIWDt+qIjJ9tbJJnVyLDcB/oRcQELuU2ph
 6J3/gIN1C0JjpGod4rcg5ZHZjyxm0STpQNUf5O1PDwYzBqJSdLX9GsYt/xOzhoZLf3ZboydZet0
 +Q5BdleRdULvQ3BF9z43n7KUegIt2DiLaPRzq4Y28bC6bALNOYSO+BFVLHl+W86DibOBAIfiKh4
 At27mslfsVfzQ8nSWKbpwKGbbAwScczl8ywNlQRR6v1GeYLg==
X-Gm-Gg: AYBFou18ggWyIRQmaD6VJv/F1D09iQcj0G7WBx+ua3AArbTEhlzEDZ2aN1AO+WgbWaW
 QU0f9rvoLiwGkrBQ87oEbbGBIuli810HZnrgWtzl9o/hcw//pzqhytCT4Xsw8i2WlcCHbfs6RMs
 Ze0PhhbP0GPg/+gdC/BQ6Kzrlg3pceOh5xD4D/7BfxtLdNxvV17eUzMi13
X-Received: by 2002:a05:6870:3453:b0:475:a153:2dc3 with SMTP id
 586e51a60fabf-491e9fcab5bmr6173603fac.25.1790356712386; 
 Fri, 25 Sep 2026 10:18:32 -0700 (PDT)
X-Received: by 2002:a05:6870:3453:b0:475:a153:2dc3 with SMTP id
 586e51a60fabf-491e9fcab5bmr6173571fac.25.1790356711799; Fri, 25 Sep 2026
 10:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
 <fe3a4297-f300-451d-9763-0b3016706111@amd.com>
 <CACSVV01NZROH9U5Qjd1TSDu+BPyyPLC9pFByqSfrxXrPJV+wZQ@mail.gmail.com>
 <20260924145419.47354-1-liujianfeng1994@gmail.com>
 <CACSVV00tYa18fijNfSSwzE8tgYVqHK5yp4zohwdTgvyNK8SREQ@mail.gmail.com>
In-Reply-To: <CACSVV00tYa18fijNfSSwzE8tgYVqHK5yp4zohwdTgvyNK8SREQ@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 10:18:20 -0700
X-Gm-Features: AclHuK9fSyAIzoBNFWcWUoZ2puEB8-AtVFFp1mUdAjt1DjbWKFPGlOaH2m00xXw
Message-ID: <CACSVV01wPhaVPUtYCwHyQ8M_Egy2O_P6gPhGkoS04S2+FABSrw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] dma-buf: keep DMABUF_DEBUG off by default
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Bryan O'Donoghue" <bod.linux@nxsw.ie>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfX/7wfImKHyhhv
 2DOy3h/t0vbzRzdCCQIIqBTQRvJ9Tqrup5jHOPIEoLjPLSp3Qmyr4zzbXGa5m6h/NIpH2T8vc+P
 1jQVmEWEgjJ7LhTBGL87jvhczYDd836bjl2Rv7UNLclFL8RPqu/E4/rt5KnZRV/aWinhS1JpDg+
 uj1Tq3v91duYbN4c6DnBC1frc21e08lQe0/Om1TnQfKDXjuCCLehyGNnnXSmA8sk00SN7xRF36B
 Ydsp4Fm9YkQBNxEVzQSQaZ/nDv0aSuYZ3iODrdoGA+F4X0mTdWR+5i/vjA5YBD90jFGiE7soH+z
 oXejZZU6X8Scl9nOrjKJ55dG+1A9yaGRo9ZwPTIwVp9AeSzmc2sif8IA6KQuZ1OJ+QJLeYNfF+A
 PP6oJqzmygtL5ZYEomi0CTucMCCp/5vo+iMHlL00jKahIoM4Tyo4ym2R/W/vZxk725RPzkllMjL
 ryA6At2p0Cm4ecMUtiw==
X-Proofpoint-ORIG-GUID: NDabkwMAD-yw9JpOxZ35ZEdV_5sQScY6
X-Authority-Analysis: v=2.4 cv=EoRHPicA c=1 sm=1 tr=0 ts=6ab6ace9 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=qnjczsnmBfoytaMDzuAA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfX8VgISpj3VOfr
 uzO2G+GWdTRbhod8+jwndcoBSW5N0ujv9lfuH3Gumkn6hLG/QuA4+EOfdayiCuUOz6tN14z1hMi
 PKjTCosivW927Z4qlKgCjNFc2HWMEow=
X-Proofpoint-GUID: NDabkwMAD-yw9JpOxZ35ZEdV_5sQScY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250068
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

On Thu, Sep 24, 2026 at 8:23=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Thu, Sep 24, 2026 at 7:54=E2=80=AFAM Jianfeng Liu <liujianfeng1994@gma=
il.com> wrote:
> >
> > Hi Rob,
> >
> > On Thu, Sep 24, 2026 at 7:01 AM Rob Clark wrote:
> > > So the assessment of what is going wrong looks pretty wrong..  VM_BIN=
D
> > > should never lead to iommu_map_sgtable() (which is never used for gpu
> > > per-process pgtables), for example.. but is used for mapping for
> > > scanout.  And pages are never used for mapping in either path.
> > >
> > > However there are a few places where sg->length is used (in iommu cod=
e
> > > and msm).. AFAICT dma_buf_wrap_sg_table() zeroing out sg->length is
> > > what the actual problem here is, rather than any use of struct page.
> >
> > Thanks for the correction - you're right, I mis-traced the GPU path.
> > The per-process pgtable mapping goes through
> > msm_iommu_pagetable_map(), which walks the sg_table with sg->length
> > and sg_phys(). With the wrapper zeroing sg->length it iterates the
> > entries, maps nothing at all and still returns 0 - which explains
> > the UCHE translation faults without any error anywhere, and is a
> > nastier failure mode than the async-bind-failure story I wrote in
> > the commit log.
> >
> > With that corrected picture, DMABUF_DEBUG=3Dy breaks msm in the map
> > paths themselves: msm_iommu_pagetable_map() for the GPU and
> > iommu_map_sg() for scanout both consume sg->length, and
> > dma_buf_wrap_sg_table() zeroes it, so every mapping of a
> > page-stripped sg_table silently maps nothing. On top of that msm
> > also uses sg_phys() in those paths and
> > drm_prime_sg_to_page_array() for the page array, so even with
> > sg->length preserved, page-less entries would map garbage
> > physical addresses instead of failing loudly.
>
> oh, ugg.. I overlooked that sg_phys() uses the pages under the hood..
> I think using sg_dma_len()/sg_dma_address() instead should be fine in
> msm.
>
> Otherwise, (other than the fault path) obj->pages is mostly a proxy
> for "is backing storage allocated".. we could just use obj->sgt for
> that instead.
>
> > So it looks like this needs work on both sides:
> >
> >  - dma-buf: preserve sg->length in the debug wrapper, so
> >    sg->length consumers at least fail loudly instead of silently
> >    mapping nothing. I think that is what both Christian's "we
> >    should probably change that" and your "zeroing out sg->length
> >    is what the actual problem is" are pointing at.
> >
> >  - msm: stop consuming struct page and sg->length of imported
> >    sg_tables, i.e. build the GPU and scanout mappings from the DMA
> >    addresses, plus the drm_prime_sg_to_page_array() cleanup.
> >
> > Is that the right split, and is there a preferred direction for
> > the msm side?
>
> On the msm side, I think we should be using
> sg_dma_len()/sg_dma_address() for the immediate issue.

Hmm, so sg_dma_len()/sg_dma_address() are zero for page backed sgt, so
it isn't quite so simple as I imagined.  In theory, it needs
dma_map_sgtable() but not really sure that is going to dtrt with the
way iommu is used on our platform.  And I'm probably not going to have
time to dig into this until after next week.

Please send a revert for commit 143755bdabaa9 ("dma-buf: Make
DMABUF_DEBUG default to y on
DEBUG_KERNEL kernels") for v7.3

BR,
-R

> Maybe we can just do the same on the iommu side, but not sure what
> various sharp edges might exist with other iommu users.  We could also
> just stop using iommu_map_sgtable() and inline our own iommu_map_sg()?
>  It looks like there are a few other drm drivers that use
> iommu_map_sgtable() so it might be worth at least trying to fix this
> in iommu.  Presumably if there are issues with that approach an iommu
> maintainer would speak up.
>
> For the longer term cleanup, I think we should use msm_obj->sgt
> instead of msm_obj->pages for "is there backing storage", and allow
> msm_obj->pages to be NULL for imported dma_buf's
>
> Given the late stage for v7.3, the immediate thing we should do is
> revert the CONFIG_DMABUF_DEBUG change IMHO, and try again once we have
> sorted out what to do about the iommu_map_sgtable() path.
>
> BR,
> -R
>
> > > (And yeah, I should get rid of use of drm_prime_sg_to_page_array()..
> > > but that cleanup that I haven't found time for shouldn't be the
> > > problem here.)
> >
> > Agreed on it not being what produced the faults - but it is part
> > of the same contract problem, see below.
> >
> > Also answering Bryan's review of patch 2, which is in a different
> > branch of this thread:
> >
> > On Thu, Sep 24, 2026 at 10:36 AM Bryan O'Donoghue wrote:
> > > Why is the fix Adreno specific ?
> > >
> > > Shouldn't this function be ammended with
> > >
> > >  > +    if (filled !=3D npages)
> > >
> > > instead ?
> >
> > It isn't meant to be - msm_gem_import() is the shared GPU/DPU
> > import path. And putting the fill-count check into
> > drm_prime_sg_to_page_array() itself would indeed be the better
> > generic version of that guard; I checked the other callers
> > (etnaviv, omapdrm, vmwgfx, xen) and none of them expects a
> > partial fill either. But with the corrected analysis above, the
> > page array isn't what produced the GPU faults, so neither variant
> > is a real fix. I'm not asking for either patch to be merged - the
> > series is a bug report with code attached, sent to get exactly
> > this discussion going, which is also why it carries the RFC
> > prefix.
> >
> > > This very much looks like an LLM generated patch - the commit log, th=
e
> > > large comment in the code and TBH the solution too.
> >
> > Sorry about that - the patches were drafted with LLM assistance
> > and I should have declared that up front. Any later version will
> > carry a proper declaration.
> >
> > Thanks all!
> > Jianfeng
