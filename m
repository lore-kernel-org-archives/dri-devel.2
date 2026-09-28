Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22AFC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FE310E964;
	Mon, 28 Sep 2026 10:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UEKMa3ws";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TjMlZ/B7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A2110E975
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:36:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MGiM954482
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=5r3bF3DAcBScXo0yMOsFEJMrNwU9r04sHzpC0amVEsQ=; b=UE
 KMa3ws2snyhkw/6ZrN6eFwze15N5bLPP+jLQo2iuE3sWa2PaR9WXWTk/4iWFZ/1T
 t7kxob5iPGt93hQyAEiD3QR37tn/nTs3eEuNESGwev3eEBmdy0I0+kC0baYEPoMn
 sWQi7Y/scF8Eh7bJxV775bljLnWIzXJaJZfK5nVyx3HedurVRSUisYcToZpOvQDj
 /bnToE4XqGDiXuCyyuz8ppoizsytQt+IDuvzpBMvQNDuj76F/Lv5SrB3CZi5t/is
 aXATBeJi8XPsnEAGTOWXxNkuO2l+iucmddi2oD2BHTBTVasfVyxClbv7VW8wojhQ
 R7hlCBi04bPw5lNbB2aw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc0agr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:36:27 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-4574f1cac98so4858866fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 03:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790591787; cv=none;
 d=google.com; s=arc-20260327;
 b=sybiN6vVgOfY2VT5OCEW/G/dxys0NhD5xcJoexKS5w8EtMxM6hIV+DjXFqxJqWJcaE
 DV52jMw23dsDr6v95YARhnzZb/D3IQoMDbpiCYL/OXaU7XwJ6+MxGvzieX0kyZiH0X82
 JESlTisulSQ5na012RB/qbgwTB2ssnd3Btl53moVDH2/6DS5fEqsGW2GnWsmT7pL3ug7
 dYptv+zekNvmhc3vGxbrf6LTVtdXweG4vDzPh5PAJU/C7FdFA78rTcDbLxMRiG22jfUC
 AqcU5zRr3jiNkQrmWeYfGR8U+ius19KJVczZ9V4WWnPQKxQ6EUsyGvDJg/wD6HD5ZzHW
 nGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=5r3bF3DAcBScXo0yMOsFEJMrNwU9r04sHzpC0amVEsQ=;
 fh=7tVVPQYKfMH+t/zWhMnxAwpLnjb5lvMEJf1O7w4FmDc=;
 b=areA/BL+joRceV5x7iXyphkX2Lr9R0ieb3zcPM0Vb2MyW777sn0gcCEMwOHUWEgq+I
 NmwzBzw7ERKCuCyB3xgS+/qHtS6fyPkqLpiEhwvQSCkJfRCLn341nWWSTncPQrqNHghW
 +mTdWDIQSuQRRqGI2DTzDht/ZoetR/0mTHDV5fbNVL0dF6iGW8NSrMEY1Ph3ICalb/Sn
 x4YVhQ2kVVka3kmQQ1J+fjbb2sI9soiEO+sTJ5Q1bMfARhZqn6uA0TdhQ+8SbUsY+CZb
 qOJxpSjYwK2dqfpi5HZ9j4ulu9qHqM84N4VgnZH56HL+FdTgWqBXcmdZ9LdABboORWGk
 UWAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790591787; x=1791196587;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5r3bF3DAcBScXo0yMOsFEJMrNwU9r04sHzpC0amVEsQ=;
 b=TjMlZ/B7XP0HGm+TVKDFJ81FqqjaS10m/cUmiC2BBwlgkTzcpMZDnyrkp/ZzwrVib9
 m2Dt+3bJER4nGeCnu2/HeaXHVObdjccx9L6P9dqIiH4o5PvfZ9bLqSh84JzK1h4yQCf8
 y0AYPhDLRqX8fmHzNKeRkGiEoYpiLJr9xD3AKoVojLzZwwLuQtRWEkSPj/xCP1lKX8RF
 Q5oblWZcPzvEbBwHMcTWUwUQSkQAD0ho9U4RPKs3Z9jYCUGUWrGqjZa/+MKjhc56UDti
 gmHPP/F/ocuax6aIZbwTlS/3COiqtknjX2t3Ju/XK+9NM192al9NsmvC4P5u0dMIO/Bo
 jU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790591787; x=1791196587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5r3bF3DAcBScXo0yMOsFEJMrNwU9r04sHzpC0amVEsQ=;
 b=xNH2lhwT/dvfQPSmZnRs2RJgF2TvEPn0ZTLQ9+HMSBVFaQLm8j0Ri+QbkcD6nuauMC
 kwu1gMjubK7Q35rC9XLMw7p487kBtM4m+Jpzx+9rY5S3fElV/uAQ29Chv1I62ETaWOMP
 K1ZLU8rmFZis138TWEDy9upJCRF5DnbRlp7NTeOCUWLTUVm9Bg49QKB8nnTmhSwZuBwf
 UkuXbZdVDwuKzr4DgvQNQGNbto8G3Q4/SgSH9LIijIvTjl6+wkcOa/n5oxu6yGdZp8wz
 FSFigNPUE36/kh4OCo/KrzM1R7IYlZccpIP4ieXx1C3TDVScX+Byjvo8Mw7BQZAnSuGq
 IhhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9KKIy6itrZM6bJT8g8NL5ten1iwyZismO7F2aDoFZATYZUsSfyR4cQLpwYtyCBLoqCs/5gNd2lcQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLbi0KmAKVFM05riZ20JJ8hC2VWpq1V575gr0bYIIqlvL4MT+TK
 2INkQ+Qturt0+Y04cDOuFJNtD5F032880aJ7UhVjR5+sBDzqPW66jri1Jp1wCoBwhcA5fxvBNaJ
 aT+d/PkEI67XblPrHtUAmJwK1QXEQ2kbJwFVvg9G/S714RgjdPuAt7kf4PJv1YX1/KVNX+BIzNN
 368BYOvLXi4+aGfjChAxv6bNJULCCsCaXIWUsKTWAfM8uCkg==
X-Gm-Gg: AYBFou3NRQRUD1DRYmRaSUF9+9n9NmRDudNR535kRtfkZnl7hpfIZvmABVYjI94XpC4
 q9dePCmc025Y4o0yrlpeo5CPsBbsc6PlLUUSMQNJWgnuIgL2UctrLPH3XuLKOfoLmrJVatgzgTA
 SJXVXK1ydXHHM/urPiaogfsHbpUC15I1yEh+bXybO0M/VwdMBlpZieeGWD
X-Received: by 2002:a05:6870:4191:b0:459:2c03:6302 with SMTP id
 586e51a60fabf-491e7c8558dmr10994511fac.11.1790591786885; 
 Mon, 28 Sep 2026 03:36:26 -0700 (PDT)
X-Received: by 2002:a05:6870:4191:b0:459:2c03:6302 with SMTP id
 586e51a60fabf-491e7c8558dmr10994490fac.11.1790591786402; Mon, 28 Sep 2026
 03:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260926022026.10539-1-liujianfeng1994@gmail.com>
 <17bf71c6-2442-4eaa-847d-29ef625870bd@amd.com>
In-Reply-To: <17bf71c6-2442-4eaa-847d-29ef625870bd@amd.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 03:36:15 -0700
X-Gm-Features: AclHuK9OFDOKbtyMdVZk9UcNKkIrCoCtIosFdiGWTbBmrYE1uul2FMwD-M7M8cs
Message-ID: <CACSVV02WCQwQy9BpUUqziQTtKV7QyJruiM+iTiLE_SEVKtpVNQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "dma-buf: Make DMABUF_DEBUG default to y on
 DEBUG_KERNEL kernels"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "Bryan O'Donoghue" <bod.linux@nxsw.ie>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba432b cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=yt45555V-HXmRlmp1V0A:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EoKuqHLHcLVH11FsZgBRL94nyxrFwVzP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX+byP8Qm6ZEqI
 6pSktRfpc4/2wObrsrZgS3bUaioy47BAMU2vcPBdXcnO+I2lbfAgzmv+PbYWdWYlVNwEOTi6qGP
 G6yaloqw2oABgI/LVF+5ZA7OR+q70q9oNnJyr9BTDyTMzxzPCBBq/eKUIUI3349ftMKukh/VSZU
 mmBT89QcPjGOe8Pi4eTmT89Q7Xzfghd+SmgucxVfDV0tn9XD92Wj5+Q3kk+r84+OPJ+4fj4F72r
 5hUOrkr923Mr8Z4Z/nCjH9QARnIBe+ULTXw48n3dfSe8PnxCWQcMpQfPO4/GcqZYJW2qpPE2/6/
 iMgRv6Cn84prcrNAW2thjAzHX0thRRqiXxoUOmafhufTPPGAzfKnDkdTcLdRj3aSLk0XELWqjv2
 Lj664Gu/tggs19xLbCgaJpy1VUn8vAjtP58JZE6dkkqQuB/6+QxRlbuT88HPahQ5axJnDOUGq9H
 nAyGk+GzW0m44X+vMpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX3rtwqJql5pCr
 QoUHTYBe/h+nIxHPq9PfuUqDNfY0XSd7HulzZoFya5AYi5kGd1kv8UZlLOLJoLBbm+bX+meNcad
 XF4B9XekmRuIAyPpSqlpiScrIlXfGmc=
X-Proofpoint-ORIG-GUID: EoKuqHLHcLVH11FsZgBRL94nyxrFwVzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280042
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

On Mon, Sep 28, 2026 at 1:19=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/26/26 04:20, Jianfeng Liu wrote:
> > That commit fixed a dangling reference in the DMABUF_DEBUG default
> > and thereby enabled the option - and with it the page-stripping
> > sg_table wrapper that dma_buf_map_attachment() hands to importers -
> > on every kernel with DEBUG_KERNEL=3Dy, i.e. virtually every distro
> > kernel.
> >
> > drm/msm is broken by the wrapper.  Both of msm's map paths consume
> > sg->length and sg_phys() of the attachment sg_table:
> > msm_iommu_pagetable_map() for the per-process GPU pagetables, and
> > iommu_map_sg() (via iommu_map_sgtable()) for scanout.  The wrapper
> > zeroes sg->length and strips the page pointers, so mappings of
> > imported dma-bufs silently map nothing, and userspace observes
> > arm-smmu translation faults from UCHE, e.g. during hardware video
> > decode (clapper, chromium) on Adreno systems:
> >
> >   gpu fault: ttbr0=3D000000088a889000 iova=3D000000010741c000 dir=3DREA=
D
> >   type=3DTRANSLATION source=3DUCHE
> >
> > Bisected on a Snapdragon X1E78100 laptop as v7.3-rc3 good,
> > v7.3-rc4 bad, culprit 143755bdabaa9.
> >
> > Switching msm to sg_dma_address()/sg_dma_len() is not a trivial fix
> > either: those fields are only valid for sg_tables that msm has
> > dma-mapped itself, which native non-MSM_BO_WC objects' sg_tables
> > are not, so the conversion needs more work.  The msm maintainer has
> > therefore requested restoring the previous default for v7.3, to be
> > revisited once msm no longer consumes struct page and sg->length of
> > imported sg_tables.
>
> Yeah as I said before the problematic part is MSM here. We have enforced =
correct driver behavior for over 5 years now when that option is enabled.

The problem is bigger than MSM here

> What we can do is to mark MSM as broken and/or give a warning in MSM when=
 DMABUF_DEBUG is enabled and you try to import a DMA-buf.

sorry, no, we can't mark MSM as broken.. we can mark DMABUF_DEBUG as BROKEN

BR,
-R

> But making the check not default to enable on debug kernels is not an opt=
ion. This check here is exactly to point out broken drivers and you can man=
ually disable it.
>
> Regards,
> Christian.
>
> >
> > Link: https://lore.kernel.org/linux-arm-msm/20260923074256.9357-1-liuji=
anfeng1994@gmail.com/
> > Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Karl Mehltretter <kmehltretter@gmail.com>
> >
> > Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> > ---
> >
> >  drivers/dma-buf/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> > index e4f078a326a41..7efc0f0d07126 100644
> > --- a/drivers/dma-buf/Kconfig
> > +++ b/drivers/dma-buf/Kconfig
> > @@ -43,7 +43,7 @@ config UDMABUF
> >  config DMABUF_DEBUG
> >       bool "DMA-BUF debug checks"
> >       depends on DMA_SHARED_BUFFER
> > -     default y if DEBUG_KERNEL
> > +     default y if DEBUG
> >       help
> >         This option enables additional checks for DMA-BUF importers and
> >         exporters. Specifically it validates that importers do not peek=
 at the
> > ---
> > base-commit: 93f51579e7df248780214094418f205253383cc5
> > branch: revert-dmabuf-debug-for-7.3
> >
>
