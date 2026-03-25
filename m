Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B96109C057
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE3210E883;
	Wed, 25 Mar 2026 18:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dqi8fZhE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XuhXq1P4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8270810E883
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:56:20 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFH4Ku1258007
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=1e2MlX7Q5yGvC4wRUrIN7z7NiBV97AYd7Lbslop8jFk=; b=Dq
 i8fZhEOE4bdDjHrrgnNQW6t+IFgODulEIF3FcQPkXf2Gi60GyZMD3ujRaxwnUwXx
 Ye/p3pyIrfBeV5wNSpUH5zFawDjb6sj1B5UQZKoOPoPrYKoTWDRSdGomUwtA9BcC
 Z5Lgo2JHE46tSmZ2caJauPgZ8lt3rr0BwQ5W7mt+NHbyqCMcn3IVri6gyqVwyChk
 RBbxIlT4h6zcx9UuvOCyV1SSouBYtvIKvYLZ+Dqa8JLqRnyPwCgUrEoyulGqxAt4
 WTfn3Si56k3DW2LiS+y53RVfMwskK448oGEvC9dt/9E+X40lNOd4/WhJSf3zTDnq
 Q05Ee7O+HOTKrKx475iw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dm2syhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:56:20 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d4be1dee67so503786a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464979; cv=none;
 d=google.com; s=arc-20240605;
 b=DQohDWc1rrs91JnBJvTTi6pWaLcnJ1Jb7Inp6rFKfL35sDbOmAQZZZ8L68chMM6IQC
 keZPKyr0hq6gsR7/4hMA1+aND0gTGWxERbKd93fk9P4XfwLdNV3JHdmNcRl8EjGWLDjc
 SjCiOLoJhO1ovCLXp6j1jxQwkgWbg6wGQkpZaMkDYNwX9HuShU5dgge2u9Xl9sVr217U
 7r67TswwdothfolT3PI8UyWKbhjqUk1tms921ImlzmDn2Ql1DeA/EfqDPeKlGRdtXz4F
 Zl7Irn02X5TFqZLpT/CYPyaDTp7SDT6KiYfBnBre/ULpIji/Lf2cBaRgmZSZzoCR40mM
 Yf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=1e2MlX7Q5yGvC4wRUrIN7z7NiBV97AYd7Lbslop8jFk=;
 fh=ZD+n65FybRu4utSB3YFSNMtpc0pF8tP/4b/VE+BYTXI=;
 b=jsVslcAJON82aoXZdFxUzGU6XbXzHY8S/Brym2tkw6u5deTqlluS768xCAPNY55G1U
 9IGxSeEYUYLx16kVBnfCk/ZFt1050exeAEiMqD4dWu9U0zJqO7pGezDTzF2FUeN87zym
 i0uqDhEz2i/8rPrgx7jJK6kb5gVLZk4ZtRW31vW+G1ulJLnAqYbI4hF3KjgKRkIZ8yF3
 v6SWVTUorWEavQPqJNH98EVSQTogCsHnPg7hmMnBcA7dQNR93JJOg3AkhMHPoJKAciOc
 6lGwRSbhEYWiv3pxTJ1fBQezSH1ZJQ5EUtqf0kniagttMLgw+UW3TXp924SEN2M1rSRy
 hqPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774464979; x=1775069779;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1e2MlX7Q5yGvC4wRUrIN7z7NiBV97AYd7Lbslop8jFk=;
 b=XuhXq1P41f/zcBKcyJcfdDa+mJaVTSZ1HOnTbw2UHKCEO/54XiBf4h76p+mA/7DXv/
 bteuLJunCQpeskgTI/KRWEpzhUC68pThM5kJHkoaSWupKnE1HYojLDv+pBl6tEKeQQ0L
 a7OKClePe4VECRyx/l1+cYi/D2kmVA5Gv4xfJAVFoEhKtyQOwEDokqxWF/BWsbLk2sje
 pCSiOBTVsP7+vqdy0dWpEp5J2o48a6vTrFF4NUKKd2W8nv2b3VxZ48wtK1Xd6rNIGGu6
 zFbcgPueBR3cbDnxVgXS7UI/BeRGUfKDKYEx3YOv53SdkseDxYebxFZ5X+90Fif+JrpQ
 k28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464979; x=1775069779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1e2MlX7Q5yGvC4wRUrIN7z7NiBV97AYd7Lbslop8jFk=;
 b=Ty4jHl6kMikEC+E5isLdr+WHTa1Rlna9NBzj0sTqdV2KWX6VAgmto+Q5o9L+G5wXMF
 odsg0c2MWidUBTS/3p7oueG/Pn1jsqsrSCgSQzuMrZHS2wu6mLejRRnfOTtl18D+Td0I
 fkC4ZeX/dMiXkvmS7GcmqbohhtRhNQ4quMWKZc2ck/eXDfzO0DDRW0yzbCAakPu7Dl/x
 9El69jOOmxrKpldTHfjk9Y6cAIOp5dRYXaQxhG9u0bYKaS8ApDZN69D0zPQSHNyN22gf
 FjJycgML8wRMNXCjriHPrf6ywPMaYzdli4bHZTTLyydLdI2Ou1eZ0T7tMh37ip6KRtXE
 eg6Q==
X-Gm-Message-State: AOJu0YxjSoENgoJ62x8m2Xayw3Uzin1LapZqSoKq8qryRu50OP8VmKy1
 GI5vQ8QwC2Z4t/ULTDQZ6TLYHwOExzZCpI1YBWgKDIOR0luEhbjiiloGjq74KlAcQsiNfPOU0hp
 FRzVwvpJGtNwTHNhK0qko5DOMm3m1Zn+ha7wn89pgX4hwZgm9pZ87BxlOk8Wq4XvOlblPDmtnZG
 EY8/rNesKAoojS9A/LDERNBmPMXf/jh/wfwJNP9SpFUwdu9Q==
X-Gm-Gg: ATEYQzwSrVVVDuSjw0rv3+XwRZHOwExhAFLLpSuU4oJl6PeXCJLHXPSPzX8JY6tgpFm
 L81mxTifFEOm/ZxskjFOHqD/dEKhrmYKnhidgwfkGe5G0WX3g09CDB3pndJRQfvL4q+UsZP4Bhp
 wvGnlavfTIOgGj4ZwILbTGiYBjmbz2kbTtdmI07a5HvJwaX259IXKordeRPJtU2HnVu+Ke49oNs
 s3JF4hReKnR5TEHfR/bWbwGFeShj914wqUbxg==
X-Received: by 2002:a05:6830:498b:b0:7d7:e844:7f4e with SMTP id
 46e09a7af769-7d9d677ea27mr2451093a34.22.1774464979237; 
 Wed, 25 Mar 2026 11:56:19 -0700 (PDT)
X-Received: by 2002:a05:6830:498b:b0:7d7:e844:7f4e with SMTP id
 46e09a7af769-7d9d677ea27mr2451070a34.22.1774464978853; Wed, 25 Mar 2026
 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260324220519.1221471-1-robin.clark@oss.qualcomm.com>
 <u45hgj7ypgf4jzbqxlaxihskk7gmfy675ez7lcxnkm4mg2sxiu@skqnmucupa5m>
 <CACSVV02g3=4BqNEVx6aviR_zhe6frz8JHEvW7SgF3bbdwFkQwg@mail.gmail.com>
In-Reply-To: <CACSVV02g3=4BqNEVx6aviR_zhe6frz8JHEvW7SgF3bbdwFkQwg@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:56:07 -0700
X-Gm-Features: AQROBzAIj3aK3dp0n1ee0bOtWSWXRjR_MI1rtJw_xSIbBPYbwdgK_uvXCOkauIs
Message-ID: <CACSVV03uBvrdG0c8g3dzWbq5TeDXM6K9HGGmvSxMPORBNH+aRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: Disallow foreign mapping of _NO_SHARE
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzOCBTYWx0ZWRfXwglETfxBD10q
 k5dH2GEg++0F9z8XojHTpRPn17LnAJLqX8hV2bHOsaxSsNp7wCxdtmF1VaLC5mu1rEk/0YuTSci
 D0C+R7m8DQiqcAmXuMK4jhoWdHgcOD9bPxpQE85UsUiDdrN8PS1ICZHkR/C2tDzZ4xZqljjrl9R
 4IgmtWu8qllKN40gSUoLOjnMQ5hVUJ1jomSNoS+9q9YKcmRay9HG1BMO9jnF/OIJFUWi4A4lGMx
 0HZB3Onyu0wY11vU3Dws1VA2+WwywF7//YR7bQPB0Y+Xkar/ZF2uoc5HHZbx56UOM+Piq8I8+C3
 fJ77IhkMnwmVWSNbPyZA1srKgwu9z1XhWFqSfhWUu6bp6q5Q53aMoYAw6mu8uX868P51nsteA9O
 eiiwM1sYat2EJ2PdYEjU15Z+YEJuVbXnoTqPghQXSklWr3dXkNRoYleb4YAo3dwK6x6vbx5iIkQ
 MHxgedJX+GOxDh7VT+Q==
X-Proofpoint-GUID: YKmPWJem5CvoWvsMRol3AtD5q9duib4Z
X-Authority-Analysis: v=2.4 cv=Fo0IPmrq c=1 sm=1 tr=0 ts=69c42fd4 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=H6UpWBCqU9_EBLoxlZIA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: YKmPWJem5CvoWvsMRol3AtD5q9duib4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250138
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

On Wed, Mar 25, 2026 at 8:17=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Tue, Mar 24, 2026 at 3:20=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Mar 24, 2026 at 03:05:17PM -0700, Rob Clark wrote:
> > > This restriction applies to mapping of _NO_SHARE objs in the kms vm a=
s
> > > well as importing/exporting BOs.  Since the DPU has it's own VM, scan=
out
> > > counts as "exporting" a BO from outside of it's host VM.
> > >
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > ---
> > > v2: Fix issue with MAP_NULL
> > >
> > >  drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/=
msm_gem_vma.c
> > > index 1c6b0920c0d8..43d61e0919bd 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> > > +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> > > @@ -373,6 +373,12 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct =
drm_gem_object *obj,
> > >       struct msm_gem_vma *vma;
> > >       int ret;
> > >
> > > +     /* _NO_SHARE objs cannot be mapped outside of their "host" vm: =
*/
> > > +     if (obj && (to_msm_bo(obj)->flags & MSM_BO_NO_SHARE) &&
> > > +         GEM_WARN_ON(obj->resv !=3D drm_gpuvm_resv(gpuvm))) {
> >
> > Can this be used to spam the logs?
>
> yeah, perhaps it should use UERR() instead

So, for the case that I was concerned about, we should actually just
reject creating a drm fb from _NO_SHARE BO(s) (and report error w/
UERR()).  I'll send a patch for that.  With that, I think it is safe
to keep this WARN_ON(), since the only path to hit it should be a
driver bug.

BR,
-R

> >
> > > +             return ERR_PTR(-EINVAL);
> > > +     }
> > > +
> > >       drm_gpuvm_resv_assert_held(&vm->base);
> > >
> > >       vma =3D kzalloc(sizeof(*vma), GFP_KERNEL);
> > > --
> > > 2.53.0
> > >
> >
> > --
> > With best wishes
> > Dmitry
