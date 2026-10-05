Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743D4CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4EB10E5DC;
	Mon,  5 Oct 2026 15:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YE8sU5l7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZ7rlSL3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B0910E5DC
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:00:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EPKnt2215472
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 15:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=51kUxIfyqGzRB5WXfz8/XC+10ItkLiZvc3aGWbygSrs=; b=YE
 8sU5l7IAF96xl0Nrw13i0ylLsRAFo6DRYA7ZyvdcAZHI2ryrZYG+CYCj/2vd6w5v
 UGiCLiPzpXR/fkTBNpZ7Q4BVKTs0jzrNI6M0p0CQrfVidNFV4r0Ss5qfgtLz3BAs
 tCDXO4F9eTCfKSAdic8nd4Skf3fZbrgahLWVXhtbWO3Z2C/BcKVPhGnT63OcW5AP
 UN8JyBsWIHYY97RC3PGfTlPv1x/x1ryFjHT/jz4r1tgv6jF4eFrxQ3DuuG4D21L4
 /IGSGbL4PZ+/eNNQVkvqN2xbK2fGulKgbAVNVnTRd4AGefp2ldJT+vyiDa6jGzVt
 B9X5cllJxLnhQlxy6qIw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgytqnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 15:00:20 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6e1d90fcee3so1593966eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 08:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212420; cv=none;
 d=google.com; s=arc-20260327;
 b=Y+wKLmj60JBfQ9y919R38XAnuVzskmprpYUq1PvZKEh82UBLd1vAl2DbyDvQfBSB67
 FpubTcFPw/U/ul5D2NeW/X8d3zeDQ2LBbP4fbSi4iQuBSvcvL10eqFIkkDUEZH3jxZLK
 nPWROHBiZgb+iwCGigoP9ySJ8VPviIJNe3iPlvZI71kXSlrlp3vaD0ljiqf6nzZ4+cBK
 60dsQySu7Gk1/83DqCar9PsZDqf2kkiJYbLLc5A97z6Liu8iicKFZH9ynjCdMbDHQ2L9
 dJjS9Lk0E0xLiZnn/AFD3MlnzAEvDGqvVXuNi7s3Z5eNlrKzfXtRy3JnAcM/F0LwXobK
 vIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=51kUxIfyqGzRB5WXfz8/XC+10ItkLiZvc3aGWbygSrs=;
 fh=22FEy3E3oWLfconu7YbfLME6uL+AtQiK4MdxnoUND/E=;
 b=ApsLW9kizLONW5CT4d0rDBarJK9XdGWIiunFKT3nSWR5ldOzqiKbVq9XYzQiMbC2B4
 XpKBctMNB5gj1PGj1if6T4Fciv5xCmEjWUrX2nrLKWJT+Gl/q7Rf/AKC0ltGqJlPK9zZ
 9CeIiIeSd6n+/0kPjxAnH6KfQIIEtPf/WiL/UObaUqfumelstAah3fJiu65afzM3Vgtm
 ZUzq55WApOYQlE32L9PO6W0gzL8aD81cAsZf3cRUbSrpgsnFjGMmdiJqgZ45GvGJEKSv
 EcCYYyDtIQeOvpCKvW9j9InUss94tjvtzW3NUp2jKAxwUVk09lO9D/S3l5GY3NAQGEpZ
 Ve9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791212420; x=1791817220;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=51kUxIfyqGzRB5WXfz8/XC+10ItkLiZvc3aGWbygSrs=;
 b=fZ7rlSL3ktPP6fmjXp5pzo/OgXmEZUcmFejEip1L+G+6NRg8DAuTu1Xzh6XKUqLEe0
 sxfqdI9Oy0FiaIBnWlsBZ2ZmQZWrPRA+V4MkvlQAJJFIwa0kzl4tm43VpXtqgzg7hXW2
 WffTwq45plBjt7V01IOKa6/4e7Y7tc4fWbwBP1ILquxFX26YkeLmMCnl/Kum6VaY0TBZ
 b2cqz+Q0+na+cZWf3dTF8E3+3ek8yHmClfwGWuUtg9xP0qbYXrwTWwk/Y0WVKSN/6UtG
 wUe/JD8wlch7BBKgLrATHL6vSUbfrzU6hwNiz2MG4X745wJV5SSfMiivERxUTC3UByES
 3lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212420; x=1791817220;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=51kUxIfyqGzRB5WXfz8/XC+10ItkLiZvc3aGWbygSrs=;
 b=11WbA0wUpNwGen2azueSgRY2UbFTruArgCeSrSpuJbSFMcMMWS8Q9QyXMdeaLtQFIq
 pm23XOATKBJaVR1LJha9dnuxFRLWmfhCuV6v/Hd7uGiWDVjE7/epON7BI6LC3M4R2o+n
 NxDaISHBgNBCR9c4BhACkI2JVyQ7hSSrPhaEXYU4lpa2FcH1UTb+rUSxiIeya+XAWAUO
 RafMtr7AiER4j/KACq/CqLqhJV0HwkJj5mUxfGwdloLK42jLRopY6QiOGE3nFtPSawJf
 Xricfc4nViPMc/FEpPqbxjIBO+VR0tUVYsW/EiV3HvCPmgw3p5C6WAI8U2n4RClkEyaT
 arWw==
X-Gm-Message-State: AFuF++n+q15SaCXEHDHhfuj7hEcemAFpBjJwYV0uwSqc8xG87eLyOmH6
 R/g4upNnSoCHFAdOArKxtwuxD0eInYud8a8M/ApfI3qBoxBnmOed14LAZAEhLgNd3ZSWZCGUkjI
 7MPELJpXZC9pe0+6XGvyhwbErS3pmBFamtfb3NObQ1QVz9sc2VtK+A2McSkRsq2r/iwtWBA5+8h
 fT4HLB90r05jvHb9Vwjb1m0KRq9m8Y3dcmoCHIrfNhef6ThA==
X-Gm-Gg: AYBFou1gkQaO9ck4Tk1hUcGxivkOGf/r6q7Lf1anUNDBY4c+ASed/ULVjdPdCoNwjAq
 Av96FwWLMLydH3dOuiLRDC9fLWgFbTuoH9pNOYbEFkhrA3nfr0GZA5VDvlP3x92th4qU6RLg4HL
 BFPKPqglRoNPSNRWY1k5nZv4tAcfN5p3K+FthUgL3x2YgPiCejPPXylVLb
X-Received: by 2002:a05:6820:1897:b0:6d7:a13d:fd8f with SMTP id
 006d021491bc7-6df2f9f94damr8297357eaf.9.1791212419843; 
 Mon, 05 Oct 2026 08:00:19 -0700 (PDT)
X-Received: by 2002:a05:6820:1897:b0:6d7:a13d:fd8f with SMTP id
 006d021491bc7-6df2f9f94damr8297324eaf.9.1791212419314; Mon, 05 Oct 2026
 08:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
 <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
 <20260822090757.624751F000E9@smtp.kernel.org>
In-Reply-To: <20260822090757.624751F000E9@smtp.kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 08:00:07 -0700
X-Gm-Features: AclHuK-VYGgmAV2KgLsEUw30s74ElUKdRVK2vDHdrY2Jy3Wcwh4cD4DhCwav8jM
Message-ID: <CACSVV018ggaw_V+7GxGY9ZQrfg8UEfhHfHWiS9NoVe6LJkw2Eg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on handle
 close
To: sashiko-reviews@lists.linux.dev,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7w5-b3mgYAJKFtcdOzAhDfn7VZB9_Tk2
X-Proofpoint-ORIG-GUID: 7w5-b3mgYAJKFtcdOzAhDfn7VZB9_Tk2
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac3bb84 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=q_WjrjqfJ9ZDdrt45nIA:9 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1OCBTYWx0ZWRfX1sPDUIlluahx
 AjHe0afgWXU+PgtUAvI411M6ZxnhtKXS2AvgZJI8dmWnqzDnEU3WB29ysDcBhkPKsTm2ZDcKCCQ
 T6WIBI/5im+iBkZ8BKOxs8jhNV2SjYIUhjrE0Fd8clMxCSkEC/r7CJJjpZvP6ZuUb/nOYmf8aYn
 6Dnr+pQNcpASs7XmrOAv9IGfM/rEVOtIGjWIZbH+VMN+r2a1LhHyxutP7nn0FPMRNfb/ygJepnM
 TxrFKi9FKjvEm2kEO/hkdh1UBsup6WNRWhg8K+xRAa5u1/JAZZdBNUc21tkX+e+jggvVMMN2iMY
 QzrSBHw11FmvlN6NSFIMdajYHcfZQ86lwhzR2I9MuPgWEcpyq8ZlX1DMQwm9nyhgqGfwRqhdr3b
 wl7Ij8icd9USXpeG5Wh08/+mQ7+6pSn1aYM3XMqwtQnbqYShB60bE60ysbA/dFHY7wfaeDZYH1G
 vET9dX2XHSE/b60Yz1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1OCBTYWx0ZWRfXzXzmIjUw/6xP
 qTKhuqVKQ3I2uhR3MehWK9VVdw3V1dLq1np6g5MwH9mpZwLP7I1uM2K2hn/k/6e3hwuEhZcP0LE
 oqTBJkOVbcOkvgrENeT9GxQor6fMSYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050058
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

On Sat, Aug 22, 2026 at 2:08=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Sleeping in atomic context
> - [High] Deferred teardown TOCTOU race via flink name re-opening causing =
IOVA Use-After-Free
> --
>
> --- Patch [2]: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on=
 handle close ---
> commit c4a550033efcf938dc9587175385266d18df3979
> Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> drm/msm: don't tear down shared VM mappings on handle close
>
> This patch defers the teardown of shared GPU VM mappings until the vma_re=
f
> count drops to zero. This aims to prevent pulling the buffer out from und=
er
> other files that still have it open when sharing a global VM address spac=
e
> on targets without per-process pgtables.
>
> Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
>
> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_ge=
m.c
> > index 8b979d84bb958..f17ecd97b72a3 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> [ ... ]
> > @@ -109,6 +114,12 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
> >       if (atomic_dec_return(&to_msm_bo(obj)->vma_ref))
> >               return;
> >
> > +     if (priv->gpu && priv->gpu->vm_shared) {
> > +             dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP,=
 false,
> > +                                   MAX_SCHEDULE_TIMEOUT);
> > +             put_iova_spaces(obj, priv->gpu->vm, true, "vma_put");
> > +     }
> > +
>
> [Severity: High]
> This is a pre-existing issue, but can this lockless vma_ref check lead to=
 an
> IOVA use-after-free if a GEM handle is concurrently closed and re-opened =
via
> flink?
>
> If Thread A closes the last handle, atomic_dec_return() drops vma_ref to =
0
> and it proceeds to unmap the buffer. However, the flink name remains vali=
d
> until drm_gem_object_handle_put_unlocked() runs. If Thread B calls
> DRM_IOCTL_GEM_OPEN concurrently, msm_gem_open() can increment vma_ref bac=
k to
> 1 and submit a job using the IOVA. Thread A then acquires locks in
> put_iova_spaces() and unconditionally unmaps the buffer via
> put_iova_spaces_locked() without re-verifying vma_ref:

This is already invalid, the flink name doesn't hold a ref to the obj.
The exporter must hold the obj live (by not closing the handle) of an
flink exported BO.

>
> drivers/gpu/drm/msm/msm_gem.c:put_iova_spaces_locked() {
>     ...
>     drm_gpuvm_bo_for_each_va_safe (vma, vmatmp, vm_bo) {
>         msm_gem_vma_unmap(vma, reason);
>         if (close)
>             msm_gem_vma_close(vma);
>     }
> }
>
> Will this destroy Thread B's mapping while its job is running, freeing th=
e
> IOVA for immediate reuse?
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does adding these blocking
> calls cause a scheduling while atomic panic when tearing down a writeback
> connector?
>
> The drm core function drm_writeback_connector_cleanup() holds a spinlock =
with
> IRQs disabled when tearing down pending jobs:
>
> drivers/gpu/drm/drm_writeback.c:drm_writeback_connector_cleanup() {
>     spin_lock_irqsave(&wb_connector->job_lock, flags);
>     list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry=
) {
>         list_del(&pos->list_entry);
>         drm_writeback_cleanup_job(pos);
>     }
> }

Hmm, someone should look at this.. maybe we could move to an on-stack
list under a lock, and then do cleanup outside of the lock?

BR,
-R

>
> This calls into msm_gem_vma_put() through the teardown path
> (dpu_wb_conn_cleanup_job -> dpu_encoder_cleanup_wb_job ->
> dpu_encoder_phys_wb_cleanup_wb_job -> msm_framebuffer_cleanup ->
> msm_gem_vma_put).
>
> Since dma_resv_wait_timeout() can wait indefinitely and put_iova_spaces()
> acquires ww_mutexes via drm_exec, could this result in sleeping while hol=
ding
> a spinlock with IRQs disabled?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-msm-fix-=
export-v1-0-917b3cbedd43@oss.qualcomm.com?part=3D2
