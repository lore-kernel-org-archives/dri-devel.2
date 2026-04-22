Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563FAF9EDD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A9610E9B9;
	Wed, 22 Apr 2026 14:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RSncKpUF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HzQLZe3O";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4732B10E0B7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:20:22 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MBLf6c727986
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=OKOSdDLSZ2i+7JWxoJ8CJ7tIXKTkfw3JnQ/LRRVa3Us=; b=RS
 ncKpUFNPaT1hhx03WuBvOQWAQxyvvI405U5hngETePwB/7mtBqmu2EA5eSDOWbpo
 DHLh/x9kMY7mCzJAY7qnWPA38O6OGVh3Oz9r0gfCOCSv/dKbc7jRaa4SE2+fFjOR
 aikVXrsGAaqSSReNvOqniG80O1pw+7cBypWTu5xaq+ajtNHoX9VODUiL/K0s+a81
 Tm0iOM6fsZomBBGhzTXKZD8UNSjgDX1PV/uyMId3dFowFHkEuGomengnFB4SoWki
 wQv72o98NdMFCPqMAewjeq4aavHNhEJyR1hkT1Ir9bfhBX794No+HxZMZOuBI72i
 iJyTs+fzMi8nwCLrtDwg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenhbpwv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:20:21 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6949f514496so1334063eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776867620; cv=none;
 d=google.com; s=arc-20240605;
 b=PlwgRjP1Lc60s6w56rpwyzGRKNP9jHrIsRjoe/3PNpQJBFMuHMABbRwyoZA3sSY3vp
 ggGdJxHlxDjG2hEAsiJBoXrOrn86V3XhYgcrjtlujAuVO2zqTShq3GLos3V+SpQt9Lyo
 +arAhM4XOudSSbmAE7clzN7c3uBxDX/ON171dn3uhiAHHju9gnRfnw1Zh3/eo2Q4axcd
 G+o0kG2wFO5Uf5hWfbyEC+GaWDOHrSOekmeDrniwmd1Grt9gLIn3Zv8ZzwclqYn5cMNX
 L0u69KVTu42GCgYOTOgaP+wyh2RHYtDnM2NqC+j2grLdF9JYIMvLaP5PqHRHppNByOdH
 qL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=OKOSdDLSZ2i+7JWxoJ8CJ7tIXKTkfw3JnQ/LRRVa3Us=;
 fh=d+9hoYeNS2q4dfdiR2y4uAqeWscssPPc3SWIv83YvTw=;
 b=BBHTzSgNOzyZ2Df8Z0NNXzs47kcD+GTT/ZdCvQMV1B2QelRxeo+qt5NXDhWW9th29H
 SDIci38iahd1414R8cRalbXBeHAGYzaHPwLdApDbGrO4tMGUcsOfG4jTOWC5huI9P/1P
 VyH8Ty+tyjM2fdPpryAusbTHyg7NKFQWJEPdvrqpJAVW/B2aNInXdaOgA+IR6SYOgTOF
 lcGAVZF0fvp2tGEsuA7cvAe0ga6jbZKJUpA6XqPmEbhJcsDa1VoIggxad5732NNLhUDB
 U0nYPIMcyvQQZuq4ao5VJHBbbWkbrqa3uT05vPxdfV1+0bAq8bsjZyY1ydAZVee83X4W
 qQig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776867620; x=1777472420;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OKOSdDLSZ2i+7JWxoJ8CJ7tIXKTkfw3JnQ/LRRVa3Us=;
 b=HzQLZe3O3DoO5qDxw/QwOwIbJHeKbJwPyLlq9TNbt29txtLwAAoqa8qYbJoziCPOgO
 LeIX0DEYPtLwwSggDzIxrrhZgyVp1RkdToFibYBk7KjFDUUGi7EOp7bnLJm7JLE+qsJK
 HgoU3QUVmWg6lrBXg7ROy3Ai3HQGS5eHcV/Pm3q9xuuvLpqWCGG/TLtiSEVkd3EIljp/
 Fv/CpNFVeH33tVDcUsB0YCmTnc6rp7G2kDJF7ZAEHGCPD0QUe+z7iDNZqcI498Tt+Vy3
 wEQBcyEiGtIUQUFBx8EPbsc3VKfi5fT+3tBn58pUjt37dVFKpaZKLrWEerqDWUp5tGY0
 ei8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776867620; x=1777472420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKOSdDLSZ2i+7JWxoJ8CJ7tIXKTkfw3JnQ/LRRVa3Us=;
 b=EdTEIj7nEzPMTyCFysIqyX5zvyoa08I33bk4Qd2hz36dOx+n9UjhzIx/fVsWIWyGdQ
 Jz6UYFsRK8dKc+FRxdAUELucb7ljbN7nkwns0kymt/JPxULeWZ+WRZgCcA7V+uWPaSgP
 KaIJT/HKLYz6Ht79PiLSIuSfJ9jO36NG30s8UTt1Xh/LxyRVKkFEvF3qQM9J9JuOjwYC
 dQ1lD0XvqeXgWNDAqOAjOI3gxZgW0goDFF3VD4Po0fiDcXA+fJjZvBUpl54MDyIoPkWK
 bSbnrGE/V8RAxqHMmzq7kpUvhSrt16ySgEJKTQl09sFO9Nj5lBRPTzNJ4WEyDDR+RwYa
 uQJA==
X-Gm-Message-State: AOJu0YwMoshBwXfEcD94Dq7+0l9Uc6Aatr6t/wdnYdVXloETEs3ehEG2
 CEmHuhTWDV18pxYmsYFcRJjBBVMosqIBj+sxoKhDKz2B8IE1PJpNjaYjJkDeDxc6HL7mwqW/Gpk
 8iCVOImNA6U2N4eC5Al9BcZnaaxi2l7+BI0g8AmnN1qWn+ly3AMjR/3bs+Knka3w3C1PF9u0aEG
 0fJ05dZAIMQWVgcFjJtKWobNOGZAqPzuyUdAsV7ujdVTxIAA==
X-Gm-Gg: AeBDiet8AJox4okKDLH8kl8guPP7KjIXPYaN+6tSatgKqOsG3NWBOnA+tzhBsUZwt7H
 xw4A6wQ/zJs8jqycOXy6noE3HgAFaNggsctxB42nc9bupU4MOdd6fZvqVtvT7lxyp6vSDU+zJWS
 /oXteO1BIkeley9QIlIhK75dZ6jIFcX65ycnR3hQpaGDsjps+G69VBA/LYWSZMsVTnCYAq7KlI2
 4PD3rQ/tgdeZXdX2NaTMwkaPzt6NbY28uE5HuTGMJ6tPIyE
X-Received: by 2002:a05:6820:4de3:b0:67e:21c9:ab55 with SMTP id
 006d021491bc7-69462e16702mr12186104eaf.3.1776867620580; 
 Wed, 22 Apr 2026 07:20:20 -0700 (PDT)
X-Received: by 2002:a05:6820:4de3:b0:67e:21c9:ab55 with SMTP id
 006d021491bc7-69462e16702mr12186075eaf.3.1776867620173; Wed, 22 Apr 2026
 07:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-14-robin.clark@oss.qualcomm.com>
 <a3nvz2coifdazaoyssm7xtxmyiusvofxu5f2p44kvrgvpa7hbc@jmj6gyttetcr>
In-Reply-To: <a3nvz2coifdazaoyssm7xtxmyiusvofxu5f2p44kvrgvpa7hbc@jmj6gyttetcr>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 07:20:09 -0700
X-Gm-Features: AQROBzCZ07nuyFpPgTQpdOSrlOKgniqgnA3n71Gpw9w2xyS4h0hWal8wB6s-rLI
Message-ID: <CACSVV03+aZUnLWfGjMLAJmvHm7LxnugJDQ=_ZZFV00-UWeZ98g@mail.gmail.com>
Subject: Re: [PATCH 13/13] drm/msm: Add PERFCNTR_CONFIG ioctl
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=HdUkiCE8 c=1 sm=1 tr=0 ts=69e8d925 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=JrfraD0a6nxK02t0JjQA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOCBTYWx0ZWRfX298ldC2oKs35
 Ca4vvZz0ISyhpydvCjP9h0IZB7hM0iC1Z+hbuAFy4lKYQMIXGmhUALxExrm2BbnLhBQxHLNGyG4
 XLVYRkoBq1Pe4KVcoNeR5A8lKQ/b1bWAEZ2lFpZi6EhkDvpsRQIYwlM0MPPPlanBLqDPGccu4aA
 v7qnz3tfS76v4ck+UgjN8sl427JkOats/yICFqB0FNis10Me6bQCp+UDGInpsTGR2pgMJ0ctkv6
 Kr7EhD1ju4i/mjd3JDbjm6oOQCcT6SnRKKe3UMRmiZzlHQ7KNZ1//MsN7MOwoH3sIGi+17LsY9/
 NN6sfawp2Bs/fPu4+q+9xtXzRn0sZIlLV38QGx+BLneuQV9yINHUK1SgtfLALUYlMUKMc9VtTSi
 8INPHPb/HbcJ/zO0LE5LkCN5LwYhs6HT5KI/WqTzWOivsopN37YJUPbrWV44FHGM36paYgpWMlH
 oEC8BpER+jq4XvkblaA==
X-Proofpoint-ORIG-GUID: ntiRavAElShebVuudi-BUdacOvWllpTt
X-Proofpoint-GUID: ntiRavAElShebVuudi-BUdacOvWllpTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220138
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

On Tue, Apr 21, 2026 at 8:41=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Apr 20, 2026 at 03:25:35PM -0700, Rob Clark wrote:
> > Add new UABI and implementation of PERFCNTR_CONFIG ioctl.
> >
> > A bit more work is required to configure the pwrup_reglist for the GMU
> > to restore SELect regs on exist of IFPC, before we can stop disabling
> > IFPC while global counter collection.  This will follow in a later
> > commit, but will be transparent to userspace.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c      |   1 +
> >  drivers/gpu/drm/msm/msm_drv.h      |   2 +
> >  drivers/gpu/drm/msm/msm_perfcntr.c | 489 +++++++++++++++++++++++++++++
> >  drivers/gpu/drm/msm/msm_perfcntr.h |  54 ++++
> >  include/uapi/drm/msm_drm.h         |  41 +++
> >  5 files changed, 587 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_dr=
v.c
> > index 3066547f319b..0a7fc06113e0 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -801,6 +801,7 @@ static const struct drm_ioctl_desc msm_ioctls[] =3D=
 {
> >       DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_CLOSE, msm_ioctl_submitqueue_cl=
ose, DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_qu=
ery, DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(MSM_VM_BIND,      msm_ioctl_vm_bind,      DRM_R=
ENDER_ALLOW),
> > +     DRM_IOCTL_DEF_DRV(MSM_PERFCNTR_CONFIG,   msm_ioctl_perfcntr_confi=
g,    DRM_RENDER_ALLOW),
> >  };
> >
> >  static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *fi=
le)
>
>
> Should we also increase MSM_VERSION_MINOR?

Generally I only bump minor for a change that can't
otherwise/reasonably be probed for.  In this case, userspace can try
the new ioctl to see if it succeeds.  And since it is only supported
on gens w/ perfcntr support, userspace would still need to probe even
if we bumped minor.

BR,
-R

> --
> With best wishes
> Dmitry
