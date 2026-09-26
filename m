Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61AEC9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA17710E0E3;
	Sat, 26 Sep 2026 15:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eu56kTDw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZccJNeO+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511D810E0E3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:49:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QDeXhl501897
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=x5PdX9DxWJnyk2v9EFXGjBKujlwifuu0xz8YQXo6qPw=; b=Eu
 56kTDwUvhYxvgeCA1se3G9INk9M6Eq1BcgR5Dqc4RveIn+MKTpFhWEcQ05As+qvw
 gMzgeih+iykA1mh4fSb4UWXeP8VsGiVRI5iGEyecAsfE/a2Y3/bAVij0FaupuRQl
 flrwbxj9UDZ5pyym0iCBOKx4NNkPZwVH61aERzuZ5EH6gANv5xzSz+oCp4BVgCKE
 pc1ChxvTHIhFmv/BuKBeau7lv6mvebsnJrHkLTuVCk6PwX/KVNoYuYsE7RjpecMg
 GRjp+m/mK3nnGP1qCwz8PGCwwYpmRJSW9RpWgOLERLP0DaYN+V6gg2yfBJgxhxcs
 6JvsdSiaX8cJJVEVCGNg==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mw97y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:49:56 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-4519ef1babeso1592522fac.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 08:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790437795; cv=none;
 d=google.com; s=arc-20260327;
 b=hB9UWVO93OaSEwbXBjrPubU5h0ZcfJ8LSCNjasQ/oX+TyCjruoYtEwm4XrlMv6rhRM
 7PKDvb4on8y0ekq+v1Wk90ytQZFCGKk5sLWYZwnPBLkoyFKXqzFfz5kLpoBmMXlMez+3
 oQ2HYcYJp1Uh1kuTUNMrBS3j28P7x6I957Gu0kHKhkVwIgSUDaQDxhO8SLgdvXdAg/aR
 vo0ZCq0aSKNSHcCC36hk296+X0LEvAYirYJFUWWeaU9/wi+HrtEakq3N/R+JWeL30Mw6
 mtG6glbLWxwMRu1pvqrXuJf5H8Jhn0b/K17URHvxgD906aUsekaeuRVLueHZ30bWsnTB
 tNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=x5PdX9DxWJnyk2v9EFXGjBKujlwifuu0xz8YQXo6qPw=;
 fh=oaYBx4S49dtTaaU99CsPR6TbVUS981XzHyljVWexgHY=;
 b=do3I9dcrj9Qb61fnOiehdV7fSLfjdt1rrXtcT1ag1D5irdEDPVDbJngspzVorJuouo
 LoVSGYUHQjC8oxmNmR0b/dyYPAbgVtRysstsu4RF7FMNRakwBa45VertCrwvqHxJNdwz
 Tz19W2zgidWoiBgO32ws3KyvirQyTbiuped2RyMTKrbqloK7dlZfJVAFaI5ZJ0/UvirD
 RDqr62qMDf69ah4Y/J2AbBQn0EyIiupcMZ+5GhrephBPknbHpHUDx140dezRnHnbgGD5
 HuO+pt+gAiy2EOxHunJ6yDUfF/pm7eLEpOvgox3zOvkQHm6SJ1RX++wp1dxEa6wJ/Vk6
 3kcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790437795; x=1791042595;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x5PdX9DxWJnyk2v9EFXGjBKujlwifuu0xz8YQXo6qPw=;
 b=ZccJNeO+XDe2+HU3ph0t416PGT6gPk0JuAft1UAwMT0lHAZNS5LXUCWx+pFpG1lke+
 nSd5heMqklIPSs6ZxOKRGQV8mxervgHa2WCFo+N+Llw1+Olqu0tP9+HneIiOL6gwn1xH
 arfQliTAcnjDU6Rbp9BOehdke2nWuuUc6T++jn/VqHvsZc8PlPjiTt+0btvBbAsNoufg
 c1ijcZ/N2ff4IHBP66riKZ1Nce4049L/p/TJLOKg+wo8fyFdENGzxXIk44vn31ZXpFlr
 828HE8DxDZYttW7pfB2ED9LhDLbpaRI37THkte3Uf/Dt6c341WmWl78FlTv+vARAVIfc
 c7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790437795; x=1791042595;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x5PdX9DxWJnyk2v9EFXGjBKujlwifuu0xz8YQXo6qPw=;
 b=ekoboLEKP/Vln4eRu1RANRuML3oQ93RHOKEDmHkShJZdzaHTHsYG7KVVmQyxJvKbIw
 U4+D7lis9yHUSRH5iMNxoN4kzK4fiVfBQSLkgZXPy3lwHJS7TOsn/uVmedKFebZsi5MT
 K02hiPJUtll01kttajnOJbu15ak0hIdLlJm0TKnYpfT5zuGj3QmgoBEjjpHb296KBCSE
 dtadmBQ+y45NdWRO6FU19lgnS6spfGdQOY0szadE3tOjJpb59cl9Zi2k6v3w+Nu2Z5Xz
 aLyq/vz1rARM+mzrXBdumBWJBhM9LPPDjhRWc4IK5JKP46gEQVjE+IkVyGeV8TXXCmKg
 nLew==
X-Forwarded-Encrypted: i=1;
 AKwUvBytWr8xKehxtmvCR6NtweAvXRTmbQTZUkjAi/D7ZY28oe+0KWSk3rOnI6xCQXBnOfqLptw62KjX7Fo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++liPbR96xC8gRXb6gcYaKQ7I6GE76DZ0vXuq1h7Z2bwN1qygrGh
 8HGCfG+YQXnIAgFvK3aHMlQp6/cyMw45N3GcpYyvwUjMbKCgeWbZ5B0s5wPxUSRYwRtvV9lWmgf
 4RgfVcp8vxVi9n7xwhdNG691f6mCNm3jS1BD2G3KaZxtdXX07rWZqhND54npVkQpiH38tOWfMww
 M58fJlrqwR/ctYkvJ/VzjR6xo9yJt9Uyruc6qHWuiMHcfzCA==
X-Gm-Gg: AYBFou0MqL9+wb0PF04fHaXrki6XeooKxFLVYP7qEn3kSlx1w2fNGgRg1vYKIJERIpi
 tppULwvFczl8FII1VRrua7U+hBlxNVtTMsshoQYPVztHTncvwvBFwOToUygWzxMkk+u9ceV4umQ
 1t3kTU1AGEFAvGPO0koPPjE3pIKWjFL/+oy8fRyDullR6QWw+YKDUYtxng
X-Received: by 2002:a05:6870:178f:b0:449:bccf:bb67 with SMTP id
 586e51a60fabf-49355fb0e0fmr4957352fac.5.1790437795332; 
 Sat, 26 Sep 2026 08:49:55 -0700 (PDT)
X-Received: by 2002:a05:6870:178f:b0:449:bccf:bb67 with SMTP id
 586e51a60fabf-49355fb0e0fmr4957335fac.5.1790437794877; Sat, 26 Sep 2026
 08:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
 <20260912-fd-kms-fix-smmu-v3-1-a7ddc6fe2032@oss.qualcomm.com>
 <CACSVV00XJ4Ad8AMr9C8hv7LjnjVXmG2JrDtJxsyqx=Gz+rZ2XA@mail.gmail.com>
In-Reply-To: <CACSVV00XJ4Ad8AMr9C8hv7LjnjVXmG2JrDtJxsyqx=Gz+rZ2XA@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 08:49:43 -0700
X-Gm-Features: AclHuK-RciRtAJx994R3gG3wy_WgHDhW8e0P-gvRnH-8QYnK2N0vc2wRF8XuNhk
Message-ID: <CACSVV00SHn=f4kt-zbGsCjnB+g+aanrJ-GkzhtpkNVDiZDt8gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] drm/msm: serialise framebuffer pin state
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: W3P_cE2wcfU8bvwQivjMIBMhKqypkXKd
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab7e9a4 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=ZeSDCgH4AKyXpHf_t3sA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: W3P_cE2wcfU8bvwQivjMIBMhKqypkXKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA2MyBTYWx0ZWRfX4Sy6Lq+JIqv/
 kHLIeMhIiNgrOFVnwWNdw9Qws7KUHIhy5OG+9o1RnznIQRUyrYd5UjQfvz0T+Q99hu2tWPv6ZhV
 SXtxcu4Nkxi7zmL8AUMXmNXBYqiTLA5CUraOU1M/JvOHdn7lYREtxVxVvmduwKju7xFQXPeNXUZ
 DObNr2yg5J6Xv4jXYBfGUXS/T2vslc98umO7GhllFktFBPe0A16mIkOaaSYjSnWntgUy9d3A5mC
 jLSfOuViNjH5+HFTAV5G1+cn2N2r+0Vub7E/IqvwTcSvbHdpC/IzpINUQ8I5DF+vFHa9X0DBsNn
 i+y5l7fqiBZCgx41ywhFPxoxe1L2hdxOLA8svpPZp7ITnE6yoZ5gXS5mO3oUT2KiOHrRLpsrTw/
 lpUGOmJcQNfpSuS8UkpjMF8ToDyEtX/I3BQwWlA8H+q4vKCvQPRNGgZ9cYDnTmbB36uk78mHCIH
 zRfSGuczVC4qYUeYDtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA2MyBTYWx0ZWRfX9+8YX8FzucB+
 ddp8od9p5GI9M+idSEvcKq3Wng6PM05ks/HxMaO3fkn1IpbMpnAPMYjpgZjlZ5mf+cDhiFiJheq
 ad2gY5I8uEODT3J5fzqt60rBXwPD8EU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260063
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

On Sat, Sep 26, 2026 at 8:47=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Sat, Sep 12, 2026 at 5:48=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > prepare_count, iova[] and the pins they describe are updated locklessly=
,
> > but drm_atomic_helper_commit() prepares a new state in parallel with th=
e
> > completion of the previous one -- stall_checks() only stalls on the sec=
ond
> > previous commit.  Commit N+1's ->prepare_fb() thus runs while commit N =
is
> > in ->cleanup_fb(), and for a double-buffered flip that is the same
> > framebuffer:
> >
> >   cleanup: prepare_count 1 -> 0
> >   prepare: prepare_count 0 -> 1, pins, stores iova[]
> >   cleanup: memset(iova, 0)
> >
> > leaving the plane programmed with a NULL base address:
> >
> >   arm-smmu 15000000.iommu: Unhandled context fault: fsr=3D0x402,
> >       iova=3D0x00000100, fsynr=3D0x3e0023, cbfrsynra=3D0x1c00, cb=3D11
> >
> > The opposite order is broken too since commit 8ac37c88f991 ("drm/msm:
> > Refcount framebuffer pins"): a prepare which finds the count non-zero
> > returns at once, assuming iova[] is populated.
> >
> > Both callbacks may sleep, so a mutex will do.  drm_framebuffer_init()
> > adds the framebuffer to the object idr, from where userspace can reach =
it
> > before msm_framebuffer_init() returns, so take the private state out of
> > its way and initialise it first.
> >
> > Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_fb.c | 44 +++++++++++++++++++++++++++++++++---=
--------
> >  1 file changed, 33 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.=
c
> > index 60c108d35d2a..77415302e6d8 100644
> > --- a/drivers/gpu/drm/msm/msm_fb.c
> > +++ b/drivers/gpu/drm/msm/msm_fb.c
> > @@ -22,9 +22,12 @@ struct msm_framebuffer {
> >         /* Count of # of attached planes which need dirtyfb: */
> >         refcount_t dirtyfb;
> >
> > +       /* Protects the pin state below: */
> > +       struct mutex lock;
> > +
> >         /* Framebuffer per-plane address, if pinned, else zero: */
> >         uint64_t iova[DRM_FORMAT_MAX_PLANES];
> > -       atomic_t prepare_count;
> > +       unsigned int prepare_count;
> >  };
> >  #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, =
base)
> >
> > @@ -45,9 +48,17 @@ static int msm_framebuffer_dirtyfb(struct drm_frameb=
uffer *fb,
> >                                          clips, num_clips);
> >  }
> >
> > +static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
> > +{
> > +       struct msm_framebuffer *msm_fb =3D to_msm_framebuffer(fb);
> > +
> > +       mutex_destroy(&msm_fb->lock);
> > +       drm_gem_fb_destroy(fb);
> > +}
> > +
> >  static const struct drm_framebuffer_funcs msm_framebuffer_funcs =3D {
> >         .create_handle =3D drm_gem_fb_create_handle,
> > -       .destroy =3D drm_gem_fb_destroy,
> > +       .destroy =3D msm_framebuffer_destroy,
> >         .dirty =3D msm_framebuffer_dirtyfb,
> >  };
> >
> > @@ -76,13 +87,15 @@ int msm_framebuffer_prepare(struct drm_framebuffer =
*fb, bool needs_dirtyfb)
> >         struct msm_drm_private *priv =3D fb->dev->dev_private;
> >         struct drm_gpuvm *vm =3D priv->kms->vm;
> >         struct msm_framebuffer *msm_fb =3D to_msm_framebuffer(fb);
> > -       int ret, i, n =3D fb->format->num_planes;
> > +       int ret =3D 0, i, n =3D fb->format->num_planes;
> >
> >         if (needs_dirtyfb)
> >                 refcount_inc(&msm_fb->dirtyfb);
> >
> > -       if (atomic_inc_return(&msm_fb->prepare_count) > 1)
> > -               return 0;
> > +       mutex_lock(&msm_fb->lock);
>
> guard(mutex)(&msm_fb->lock) ??
>
> here and below that would simplify the error path

or perhaps scoped_guard() if needed for the next patch

BR,
-R


> BR,
> -R
>
> > +
> > +       if (msm_fb->prepare_count++)
> > +               goto out;
> >
> >         for (i =3D 0; i < n; i++) {
> >                 msm_gem_vma_get(fb->obj[i]);
> > @@ -90,10 +103,13 @@ int msm_framebuffer_prepare(struct drm_framebuffer=
 *fb, bool needs_dirtyfb)
> >                 drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n=
",
> >                               fb->base.id, i, msm_fb->iova[i], ret);
> >                 if (ret)
> > -                       return ret;
> > +                       break;
> >         }
> >
> > -       return 0;
> > +out:
> > +       mutex_unlock(&msm_fb->lock);
> > +
> > +       return ret;
> >  }
> >
> >  void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_d=
irtyfb)
> > @@ -106,8 +122,10 @@ void msm_framebuffer_cleanup(struct drm_framebuffe=
r *fb, bool needed_dirtyfb)
> >         if (needed_dirtyfb)
> >                 refcount_dec(&msm_fb->dirtyfb);
> >
> > -       if (atomic_dec_return(&msm_fb->prepare_count))
> > -               return;
> > +       mutex_lock(&msm_fb->lock);
> > +
> > +       if (--msm_fb->prepare_count)
> > +               goto out;
> >
> >         memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
> >
> > @@ -115,6 +133,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer=
 *fb, bool needed_dirtyfb)
> >                 msm_gem_unpin_iova(fb->obj[i], vm);
> >                 msm_gem_vma_put(fb->obj[i]);
> >         }
> > +
> > +out:
> > +       mutex_unlock(&msm_fb->lock);
> >  }
> >
> >  uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane)
> > @@ -199,14 +220,15 @@ msm_framebuffer_init(struct drm_device *dev, cons=
t struct drm_format_info *info,
> >
> >         drm_helper_mode_fill_fb_struct(dev, fb, info, mode_cmd);
> >
> > +       refcount_set(&msm_fb->dirtyfb, 1);
> > +       mutex_init(&msm_fb->lock);
> > +
> >         ret =3D drm_framebuffer_init(dev, fb, &msm_framebuffer_funcs);
> >         if (ret) {
> >                 DRM_DEV_ERROR(dev->dev, "framebuffer init failed: %d\n"=
, ret);
> >                 goto fail;
> >         }
> >
> > -       refcount_set(&msm_fb->dirtyfb, 1);
> > -
> >         drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb)=
;
> >
> >         return fb;
> >
> > --
> > 2.47.3
> >
