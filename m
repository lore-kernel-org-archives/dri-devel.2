Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C285F10F92FC
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 20:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4657310EB94;
	Tue, 31 Mar 2026 20:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ExGjnv4c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kap40kjn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3419C10EB8F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VIH8t53081565
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=; b=Ex
 Gjnv4cRYbBcnoWP5H/dLR6n48B9J1sTVKiTQZXxU0BoU8dxXO5dscAbXvvlfVA+v
 DfkwTOrt6dpnY3yIncxH84L5furMm99iMKrhdzRnV5xr8saPU8IOM5gS5QlsD+e9
 nFb9a2lDjTfpOqkcAzksxKv8TKDxBKsOdLIA3rovkWPJ/kNM0cHMWErKb+8p8syC
 oIvs/CxxpCUG3jbbg6faWy3shnAjzSBREbHqKuHfwxqd2VdGLHZoAM0k+4EDHLDp
 WleH3Pt4VXAiXjU3G9IJeubOyhEDlNHVZp+hHLFrlTZ6xAhXhC8b5T5fklNC7RKb
 4jeZ7ijjIqr+FdvB+I/w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kdkrk4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:39:24 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d7f23bd25bso2201005a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774989564; cv=none;
 d=google.com; s=arc-20240605;
 b=OQDP8SNlpwZ94w7i9HpQUc2erS1Ki8atbCtdjJ/VvxarNHGFEgmZJ/Odi0o7oTSivw
 Q5KZDmr+zyJ9Mugj+qF/9XOxWzCWXw7n0u7VBtSx4PDDa54BxzbedMbOPxohZG7t2vvL
 T8V4zjElYrvPNgPtbWix9xEcj8izK8genAdIQYreshFXmwwuySTfCrGlBetHdWPyvic8
 I7Ab2g7G3Vk/Vpnv2sROB9LdFcs+qEXbk6ElMTv+tSSFv32f8PXb/koJa8Rn+34unafK
 4TjxIvXcFfoSWjdt20CjzENNaSd81Un3HJX4LmMSrNLGtxpDS4QYiFWZLPNxz4tjUf6w
 ALoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=;
 fh=x61/At3kfU16uU3IwEBOtMg2reUYEjIT7HG1UefpOhU=;
 b=jowJ+CNlslyl29f6eisU4SU2AidgZB67fC4lUWdMvIDKeVsZm05fWG7WAhDhyyZ6O4
 wDWMfl1C83ArH/ly7OzIxTBl4zKUaBJYxK0ajOxjb7X6R1dbelR1tlk/wCLpcjm6fbnS
 Zl8p2Ts9En+tEJPuMgdhnsbmN70fXbdjJQxSo47sUlPjnI37IEQ6niIlazhNeX/877Nf
 Vgb+84hMNU9jHA+Ykcs/rCoUiT0zVKZUuTDkF77H9n1UXNO6iKGKmUyz4Yq3DJz7AK7s
 iNojiI5A35Ga0Ke54BvvICber/WtGb8jwoUO+y0s7WBS8mCZfcDvvbIDdLkbGvLA0BAn
 nRcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774989564; x=1775594364;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=;
 b=Kap40kjnfGuefZvypHJvNk+lNhBmjP4DCtqWCCS0HsXQDyene0U37FrQezebiktJcH
 X7aY7iYbEY+kkkqSuZ3TrRvJ4yK/X3XJjMG03CPm11+Qd1veQrd8B49lBOHrYS/7s3h7
 eP3XaVgDqj2pNrqCWjEmVb+cuf9w6eC/7Ky7s7BRmafRLhgDOSqqB5SBO6iP5dsDIHKn
 j17+vKKIZrYxJY9Qc0zDcCF4ncD2xqV7RqhmhY15zTkCF0b5xGClmF0Zl+UyFQ3hExem
 8SwHxYePtCaTYlgeJ3tF/byKKqgHVzWZuWzXBkuglD978OZecT83mEJ6ES/RCUuIrMXb
 Y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774989564; x=1775594364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2x6RwIuLxR3MCzlHPNU6MwPlfd8sBS5fLS/Xz7Q11o=;
 b=MvQ84FNdEFbJdzN8DhB9HTTEYNnGXTuJZk8qECay/fZEiuJrSuqjUIZu6e80iUYR0S
 7rCF1IdBXS25oymfo43Q6BvefWEHousB5G+QbCopMaf0tqRYvox9objg0ravNZh3gEsb
 /PLEFZUZbYzzyEljUIofoqZZhq7uKmVy64TM9zLPXA7zQKXK5H0jjJsva/fQHkgUePCC
 E3tmUKlD6WA43mKltWinu4lqy0PlYrDAiyk6UjJv0pX1zfWZ8q2a5QYEl43G5hArJsGd
 U+z2NcPyiG2ORqa2djlJF9HqkYJkHSyE3NOUGIs20KdhUx1lVXhrkH5GMvtJmUqr+vCP
 aeQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVrVMwHrBAYAtILjgKY8MEf74yceiESPmFS+I3TxBaU1u+LyNLgRslwaW1rCmsEiCGrIC7d1bZfaM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxP1MXn9jsGAVQNqC5xFJcjzJM4jBQu5YmkNioAjsaLdA66k7dF
 JZ3iZR2k6+FrCpsHmvLYu31/KrpyREa3CsX6W9xi5D75ytbpVkGPm8K8dki/OzBwYV3DZw1VZFU
 jQsfiHsAxUPQKd0Q2S3d64hgW7q/LZYhYfuadaGkuu3WX4pBI41M0GdEtq0b/Yw/ZZd0ElddZQx
 tV5qcaEB7/RL++WlvG4vRtd9RkARgvkOYX3uL63xrXid5j9Q==
X-Gm-Gg: ATEYQzzMtJ+DtTimEaAK+x68RRyXomAD2t9BhNEP3nbLsa/TSU6VCCXxA1NfU8rJEjb
 sH7AMoqfv3EJRx4mVtyEKbaEfCXklLBKTni9QCrARaW8tR+CK8tAc3edg87rDObLiDNPLRfX7us
 /nbhffYyzd5QH0xoHQtppPkbqvrzfS82RV9XZJs3t7feBlh81/nD3+rTWovtm9mF+FGO1bbgpA9
 v1lhhpxuDdFy5oR0f2Fdhibn99sa7Y+AeYmJQ==
X-Received: by 2002:a05:6830:1bda:b0:7d7:c79a:cb69 with SMTP id
 46e09a7af769-7da3775aa76mr2018792a34.18.1774989563890; 
 Tue, 31 Mar 2026 13:39:23 -0700 (PDT)
X-Received: by 2002:a05:6830:1bda:b0:7d7:c79a:cb69 with SMTP id
 46e09a7af769-7da3775aa76mr2018781a34.18.1774989563512; Tue, 31 Mar 2026
 13:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
 <CACSVV03FFvi0c4XMEShmH5ou4OKKZcvvni2j=0DBoYnuT55ecQ@mail.gmail.com>
 <bd45632be1a5bcd2ce34834b45a35254e23f7679.camel@linux.intel.com>
In-Reply-To: <bd45632be1a5bcd2ce34834b45a35254e23f7679.camel@linux.intel.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 13:39:11 -0700
X-Gm-Features: AQROBzA8VsO3mMQtD1h3R-Aco6tohePIO4VrDwi1_DI8AqCbRSrROyb9UzFEmww
Message-ID: <CACSVV01XKYegc3B-WAdDCCPYX1M8As1k42kT75JVjKeY+7QAWA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/msm: Remove abuse of drm_exec internals
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE5NyBTYWx0ZWRfXzx8hqMDd+8IK
 3UzShxKhVScdM2uMixB1x86Z8b8dFdPm0ATMzwQYMG2naC4yYm4QQCGfMnqMZVwxWaKr+9Of5Ff
 mVEUXDZg+yI4aHwXcduTl+kw3cEw9k+VQ0D72omNSu1x0OfBNGm/ndS05Av5IIiYVSHMDQQ7xw1
 X+O5JR/Ue1eRvHbqCU/EnC0EQv/uQMSLpYWT6Eq5FqRmN7DZsh8ZU5khEnh+P94x7kKD/bBxIlq
 QScBFFWQStk5QUjpKHG+U1Tnmc+qDzSnhRVqtOP5LWdM23pfW2uLOn01opnFf30otpgJNsPbqZ1
 /dfDjQVdtfuGLje6zCSBz8oDpne0hd5cthdx+2fwvfECzh4qRPtTgyRLZCSZZ971QYt9s+7jPRK
 GRR7neY7lcApxKOBW/gbayIYw+rUD722BQ34Jma+LpHhlW9b+54UV0lUJyFNnsMFKsGtO5meLdJ
 5UQhsCGY+I1UeVOTOUQ==
X-Proofpoint-GUID: M2U1jY_CFFkZPTGbx-8OAUR2xi-8QN3E
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=69cc30fc cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=e5mUnYsNAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=pqXIF9v9MgCKvzB1QCwA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: M2U1jY_CFFkZPTGbx-8OAUR2xi-8QN3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310197
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

On Tue, Mar 31, 2026 at 12:52=E2=80=AFPM Thomas Hellstr=C3=B6m
<thomas.hellstrom@linux.intel.com> wrote:
>
> On Tue, 2026-03-31 at 12:08 -0700, Rob Clark wrote:
> > On Tue, Mar 31, 2026 at 2:21=E2=80=AFAM Thomas Hellstr=C3=B6m
> > <thomas.hellstrom@linux.intel.com> wrote:
> > >
> > > The code was reading drm_exec internal state to determine whether
> > > the drm_exec structure had been initialized or not, and therefore
> > > needed cleaning up, relying on undocumented behaviour.
> > >
> > > Instead add a bool to struct msm_gem_submit to indicate whether
> > > drm_exec cleaning up is needed.
> > >
> > > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.co=
m>
> >
> > Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
> >
> > This is pretty stand-alone, so I can pick it up for v7.1.  Or ack for
> > landing it via drm-misc with the rest of the series if that is easier
> > for you.  It shouldn't conflict with anything in flight.
>
> Thanks Rob. Please pick it up and I'll exclude it from the next
> iteration of the series.

Will do, I have it queued up:
https://gitlab.freedesktop.org/drm/msm/-/merge_requests/227

BR,
-R

> Thanks,
> Thomas
>
> >
> > BR,
> > -R
> >
> > > ---
> > >  drivers/gpu/drm/msm/msm_gem.h        | 1 +
> > >  drivers/gpu/drm/msm/msm_gem_submit.c | 4 +++-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gem.h
> > > b/drivers/gpu/drm/msm/msm_gem.h
> > > index cb32093fda47..762e546d25ef 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem.h
> > > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > > @@ -452,6 +452,7 @@ struct msm_gem_submit {
> > >         bool bos_pinned : 1;
> > >         bool fault_dumped:1;/* Limit devcoredump dumping to one per
> > > submit */
> > >         bool in_rb : 1;     /* "sudo" mode, copy cmds into RB */
> > > +       bool has_exec : 1;  /* @exec is initialized. */
> > >         struct msm_ringbuffer *ring;
> > >         unsigned int nr_cmds;
> > >         unsigned int nr_bos;
> > > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c
> > > b/drivers/gpu/drm/msm/msm_gem_submit.c
> > > index 75d9f3574370..26ea8a28be47 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > > @@ -278,6 +278,7 @@ static int submit_lock_objects_vmbind(struct
> > > msm_gem_submit *submit)
> > >         int ret =3D 0;
> > >
> > >         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> > > +       submit->has_exec =3D true;
> > >
> > >         drm_exec_until_all_locked (&submit->exec) {
> > >                 ret =3D drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> > > @@ -304,6 +305,7 @@ static int submit_lock_objects(struct
> > > msm_gem_submit *submit)
> > >                 return submit_lock_objects_vmbind(submit);
> > >
> > >         drm_exec_init(&submit->exec, flags, submit->nr_bos);
> > > +       submit->has_exec =3D true;
> > >
> > >         drm_exec_until_all_locked (&submit->exec) {
> > >                 ret =3D drm_exec_lock_obj(&submit->exec,
> > > @@ -523,7 +525,7 @@ static void submit_cleanup(struct
> > > msm_gem_submit *submit, bool error)
> > >         if (error)
> > >                 submit_unpin_objects(submit);
> > >
> > > -       if (submit->exec.objects)
> > > +       if (submit->has_exec)
> > >                 drm_exec_fini(&submit->exec);
> > >
> > >         /* if job wasn't enqueued to scheduler, early retirement:
> > > */
> > > --
> > > 2.53.0
> > >
