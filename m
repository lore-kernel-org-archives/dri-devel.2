Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2066FC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516A610EB85;
	Mon, 14 Sep 2026 13:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RlOYK6no";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEztACbt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3D810EB85
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:11:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0Xf51025811
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=1djMLQt6LA5WJSyvM29qjmQzAT+wH5w6KqZ8nP1adXU=; b=Rl
 OYK6nomNLUYUtxkEBUgGm9alaMEh2kShikXrceQC75dRTTpHSf61ufnfShaoM6Bm
 IefB4HCE/4GyQ3Dl4zxOBKquwDzdnNFSlIA5HNJcRvr+fAk/EivHGDLhINeMbJHR
 M4IY5srTnn1+9kSDAjjRzwqVpZD4J7YwM7YJQZKe5cmyvgYrUI8yqugxXd1PXu36
 0v0nGHh3OCmfxfP7u9vFI/Av+XWEHPqPINkxtAZAtdg1RPApSA3GvCWrSrYwgI3P
 kGZaar+6q+nWOhSrkDFhwSzrbxZYoicm0hirw+bAuwuP5kF5Soz97awS/BbAdR1A
 N1sPAshK9dRvuO0vQAbg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5s1xq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:11:42 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4a41f46d629so5652616b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789391501; cv=none;
 d=google.com; s=arc-20260327;
 b=lVudcXso6HuNu+iJa0xwHVRTsKXfeL7WXUKzUrMbCu7CPgmUr3M1XEaPgVXlTQYOS9
 x6EZz7og+9cuyLEkjwQ+6OtoWKM+ayVbTo3UV2iQM0GhE0AdgER0POHGrNZCWlT7OoSa
 /2KXh7EMfFI41UTzLETfCnapi8SKf6w5c091gNRLltK9lyiparhoa/bcEYk29Nqy/T2c
 Ycr/fdkQA4L6FA0Trz1QUrfcnPQEB2qUvMPSUp6CeGeJvpt01K8nwsoOl1lJP+s8qyry
 8D/hLGVzHkhycyk4dNTa0SUZZy6C5nUcl19UqlpL/Gbm6AeuLrWAL2Zrj+Ishnoe3CUE
 XkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=1djMLQt6LA5WJSyvM29qjmQzAT+wH5w6KqZ8nP1adXU=;
 fh=psAS2w+TIke4KZpvXvxpEr9wbaVJD8eD57O3K/fMyjg=;
 b=o8KwpK+3jewUp721LFfvVtADpxIknCwCOvOO4gkNE+i05YlirtFbg49i2v3YMKwGVb
 6yk4ngR0Q8SPX2nwRvvUV1ls4lrcl8h/1qjbv5cSLefJWJVWCm6rTn2K7VO8gqyGrCdd
 Infi5glWuCRAlXNw1/nkdsd0nZV2vtowOh5whJYO9DB07qL0rDRXK5iDxJBoSjGWCguV
 H2J9ROXVZwKpPyEQlB/XIMvn0EBrfEbLUlV08ftIsIcYKW1l+xsPtK7Zqh5Q2EX5ZlZy
 4Hg/Vqp439kHRmhTIZlbQLOLE+WAKXUCaBdwjJ629ajTci4553CsvVD15Crq2z56AbHp
 /40A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789391501; x=1789996301;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1djMLQt6LA5WJSyvM29qjmQzAT+wH5w6KqZ8nP1adXU=;
 b=VEztACbtSL85KEcnCjSCIrBXeC+g7/kuZxTApcHlFmoktxti+NNaJ2XVBdy/bxdtgZ
 29oDHbzhrOrLjBWKMfF+rVfSwIJEdV6sHh5zNxrVQKoQcwCyoEkNIDa3hB9/YmI07YcP
 9E9WrWYqbc8fcvLbTO/1tFHseGUsWKsfEA4tmyvHT8P2TQGtD1VLwHWY0d+M30002eRu
 xrf07EeVtVB+w8+ncFwPqjYkS0x644stZcPq68xnzlbGMR/NrJ7u9YW9ZKC+uTWBCmsE
 qJHs0RBoOcPhyTyBaYJauekarN6Q4PXpoaJHdrT6Y1YsP4u5Q9FBoQ5xntZ60wfdMpsS
 lv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789391501; x=1789996301;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1djMLQt6LA5WJSyvM29qjmQzAT+wH5w6KqZ8nP1adXU=;
 b=pI7rPy8cmWQdwx7PMpyiJ33eYvMT6rfGLfQSAg4m8QBYxMWN0q7Wh1n5rBHqZUQRNO
 bZlxf6FhhnCUBiKCNoUPu9H6i+ig/i9lGG5zmX06Jsmu4b6LJvnVuyu1c8s/BuCiN82L
 08iVvhq6lP4+IhKUsZkTiYfPTrg3Ep9JXXhW2mTMZF0nKSqhsSLPXtAt/eMC5HaBqq0/
 iaQIGU0ExsC9Kjx8snzuWiyJq8H+ktNbkYH79yR1yVQWnFLM0er20F762SSsa/INcM0J
 hvy6n1prYDutaY4HE9LD6m6J6At0AXrgMO4lidRWldaO2EY/kSq/S5mz5qwDdpIdBdao
 ir/Q==
X-Gm-Message-State: AFuF++mxFVTS5b3Dr6sfu/EFmvWHYfzt+aolfolL0VQur/rwpWHZf9Vb
 LuNp0me5ZFZeu/7B673vkbLEv2DTO909nq70SKBbp4eKTf4V6SJDFyIC4kgpGEz9R7z0KfT4d5V
 YJs2C6NxUMcYwAPZTvvoEVw3Tofz41LLjrAX6o0IEMGIPM4w8U71E6KGprcuPfTx0TQHFR2v0YP
 DrPU5U3SY3xyzW/wra4h2i9N17tw8i3oxTpel3CLqH4Vs8uA==
X-Gm-Gg: AYBFou3/A/Zyu3CRPB+LEN3j78ZATU3ZweVdDgINrYk0Bx03IuPVU+wd8QL7jSkp+Af
 eOFZC3Xlpcnmp+Wl8NqjgHd4hRNmVzMjpnpsoztveiM6qxUD/R8bND9/QOptsn8lJ8JS8k+Of0R
 LIFMCdrYp4q8Z+XkzVQgexlzDLT8ZtSQHTovpbS7Ja4lb1OGBfRWZ+GH0V
X-Received: by 2002:a05:6808:6801:b0:4b5:5bfd:518e with SMTP id
 5614622812f47-4c7b42c5fe2mr1784229b6e.20.1789391501524; 
 Mon, 14 Sep 2026 06:11:41 -0700 (PDT)
X-Received: by 2002:a05:6808:6801:b0:4b5:5bfd:518e with SMTP id
 5614622812f47-4c7b42c5fe2mr1784191b6e.20.1789391501098; Mon, 14 Sep 2026
 06:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
 <20260912145922.24115-2-robin.clark@oss.qualcomm.com>
 <12b7dc43-b9c6-4cd5-bfaf-fac8bddd7352@oss.qualcomm.com>
In-Reply-To: <12b7dc43-b9c6-4cd5-bfaf-fac8bddd7352@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 06:11:29 -0700
X-Gm-Features: AcwNN1WXFzG55PRo053-QCuRiZb99AXL7fZ42PtjLhwj0qFmTajOFG4rVvx1MtY
Message-ID: <CACSVV039xdc2+VAAm0-m_LaYM+uwGWFm2Qc0oZ0oSSQ-GJvWGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm/gem: Add modparam to disable shrinker
 blocking
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE4OCBTYWx0ZWRfX9x9lrjVIVBFV
 PabaqQNCQPF/4dxxid+W9pFfHkLug6rWEvnC31N+nRhEnLiCeElUydroo1BCp8hAJ9yOoos2FcK
 jCa6Mj5nSWQ5/G6JF4HRtMomdhxC9Ro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE4OCBTYWx0ZWRfX+8ik3RxoytNv
 uHgbNuvHWGrPr1HepqsUw9Px81vFFfwADf3i+RP9fSWULGHRuPslcBeS6MpR6MyFm9phHgEmnSk
 /+fUNoYriVixfqUhBy7KeRndxnFOd/SkUeuhjGkFBMYi7fyDUMVpDWmCSDGaxAy91NOD2YqoUok
 nHTB3iCg2QW2MEWKq6uK+M9fHHDfuV4yrDCHQeVAIhOx+CwfiU7y/TAD3am5R3klEEUJ3oBnFue
 H+WhQBWlU6jjvxYnQLNywajGZjLjAuCXmzuStjvbijIAeNstYbrQXIYb26mvRGv1OyTdrrfE6XU
 +p5YAfTNG7R7NTiO01N1dgv8/eTB7RIqEmC9kqPLZjxWmYIMitht7Zxz68nnX9Oghwcx4T7A3cu
 yS+daf41YwGvQ65MBHiDPSzRQBTSFTromxvlD8uYgcPmCht2BW51czOov4rzK7pRgkGV76pJm90
 PeQ1vU7A50DR5vYwFzA==
X-Proofpoint-GUID: sRthYgdZTdAk1vzN1sYoNSXwLy22KsKM
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa7f28e cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=e9D9l_ksrzWtAqLwVioA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: sRthYgdZTdAk1vzN1sYoNSXwLy22KsKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140188
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

On Mon, Sep 14, 2026 at 12:56=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/12/26 4:59 PM, Rob Clark wrote:
> > Normally if we are under enough memory pressure, the shrinker will
> > eventually start waiting for BOs to become idle.  In some very latency
> > sensitive use-cases this is undesirable.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gem_shrinker.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/m=
sm/msm_gem_shrinker.c
> > index 3514d5c84989..83ee032cb21d 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> > @@ -19,6 +19,10 @@ static bool enable_eviction =3D true;
> >  MODULE_PARM_DESC(enable_eviction, "Enable swappable GEM buffers");
> >  module_param(enable_eviction, bool, 0600);
> >
> > +static bool eviction_can_block =3D true;
> > +MODULE_PARM_DESC(eviction_can_block, "Enable blocking for GEM buffer t=
o become idle for eviction");
> > +module_param(eviction_can_block, bool, 0600);
> > +
> >  static bool can_swap(void)
> >  {
> >       return enable_eviction && get_nr_swap_pages() > 0;
> > @@ -26,6 +30,8 @@ static bool can_swap(void)
> >
> >  static bool can_block(struct shrink_control *sc)
> >  {
> > +     if (!eviction_can_block)
> > +             return false;
> >       return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
> >              (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLA=
IM));
> >  }
>
> This is just a guess, but can we always keep both and jump out
> of msm_gem_shrinker_scan() early if we can satistfy nr_to_scan
> without locking?

We do this already.  But a pure vulkan/VM_BIND userspace that happens
to have realtime compositor requirements (vr) has a hard time under
heavy memory pressure.  Without BO tracking the kernel ends up quickly
looking for anything to evict and not necessarily making good choices.
I have some half baked ideas.. tracking LRU vm might help, etc.

BR,
-R
