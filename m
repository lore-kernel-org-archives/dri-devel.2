Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C88EC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8620810E433;
	Tue,  8 Sep 2026 16:49:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ECxUWokQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZxsYW9rO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C83010E433
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 16:49:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Fdjhm2194951
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 16:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=jjyprxG2XG9NzXWNyzeCiXKjoh+WUs0B5koQZJEUIKA=; b=EC
 xUWokQuaOhKpZOpEBztQE0iKKXzBE40PJmeIAlWwXAPkCPpGL2n+9UUExBR6wFuY
 hknpXVJj1v2xNOK6U5IAvt/CLg5/logktIfRrnvelZhbKD07kOrPBqw/MSYMfpjL
 Efvhx7mq8RJLuUUoJh83X9tQGhHVsdb9dmgkWMjRMsnSXlyZJsBkXKJPsq2L2VWX
 yOtPMObXR234BFr308/LkD3SOPL/4gINIwS7/jHbS63BiYNjs17weuLHaci/luC2
 dID3qatDjIaXW5SvTKZI4cU8h09EHBJzKD1X3QXzrBvxjRJHovqTF5ofwc5wlWhP
 6UQ5SZ3gHKk3uAE7N2kA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjkshrvcn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 16:49:52 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6bdbda8d453so373334eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 09:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886192; cv=none;
 d=google.com; s=arc-20260327;
 b=MCIh41qsdALcF4lnQay+b5LKTn0BRQJSl75g35ogOhDjPs/fRW/y+2Mh0b2cSMlIYK
 F+PAzysyXXiBhUTyxmxPNnOTxIlzhAltS82pVSpo2t9MkJwEL2RXRH7p0wQW7vzDUYZC
 CVJOUr+cF4bHBN9Bxaz/6DMbLPMPxDciFucE6bKwSQ6xUmJYTgVbOYbbdLfB9OrzsZWX
 Lf1drjhZWkVRxiRwRm0Yhsrzzh2AN2el/r65PW3fILq3iK2c7tPVY9xnkssygzz/FKZq
 Yuzg47BFXuBSB+2jzT6eX0/foZeA8phIF1Mh9xwlwBw3I/cet41iVhc85eD72tcbEyV5
 fg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jjyprxG2XG9NzXWNyzeCiXKjoh+WUs0B5koQZJEUIKA=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=rpjfRybVMoq7YawAJqBMx0lk6UgZ89TKHSrfdX3nxemZs3EZ/+z+OvjqZU16mbMKRZ
 CNEnB8ouyESjs7w0THQrJZyGmdVEU88EtSTtbREdXwMYNNB5T5/YvFHFu6k/KXTpaw+H
 LUp0RpaJSe/yZWoUeUxMBOiC8yzgKBq4wwhhZNcTh40Z6UeGmr2vAKcG69RfX6aR7lkJ
 qDgNThHioK2hN7c8Hw4z1HKMqCxu32d5dx3kblyhyA3H1wHscNpCSEGh4DWpalg0zHeh
 CPaTyRSBRTj241Nq3WOyW/0wAIcpPyT3U9TsEIVbatSUy15qYmgkIj7edZCf9RhFAhft
 9uug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788886192; x=1789490992;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jjyprxG2XG9NzXWNyzeCiXKjoh+WUs0B5koQZJEUIKA=;
 b=ZxsYW9rOY01Wsts+Yg/O7ecJR0hWmN/07AvUBZEyF6TMVXnKrDaR0DTZrZJIUPcnpC
 e3shJOzHsO6wa+Yaj4cl+oMLpzFgQue9q6j0p41yMr0OMUXj6TCSV5VFnd1TgBrfvnyz
 1nwKAeRN3HB5uEZdXcdsfo7uC5x71oGe07HRB2xTHq1Ejrz8S/k0RvSguZc/M+AslQ1I
 y2BGS1SmWhojremmj4pnkekBQKcmxEAFcJoaoJ+FfwsBA/DMgo1GINtH1SY4zYwwknLU
 RxxN7NA3Wd+dDMPHeogTZhwi3QlAOASHlFkus/L4Tb6FaxU45PJGyQ1shxu6mG3tuVm8
 uCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788886192; x=1789490992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jjyprxG2XG9NzXWNyzeCiXKjoh+WUs0B5koQZJEUIKA=;
 b=WY0n1z+G0TewpyXYFiBhbHtdDolwqrwY5vbwBHt07H02RgvzS8iPhEqpQSsbtivU4H
 dctXapY8bS5RmOoT4CP6w7jZR4h0kxMMBy3fboqmZQvpsNPQrAUgg9JlveE9UtKpTVZh
 zc9F5ICbkxl4JNzz+0pHEW2u9qSA+s/pzDnOXJwW3/97m7dZ/YoJp0XfRxDaJUvm4xpO
 JSMVfFdoap5Iic9fdaepV68lYFOuVZufRyOFaxVsLKUzsfEsr/cQ4WVdmThqteb+Pe0M
 vY1dNlgyO4r2CWXeQCLvS8i580XKk8Qt3r3yaZeuWOm/Rn/QUnHlMe61Q1ob8qt+BuUX
 lJKA==
X-Gm-Message-State: AFuF++nfxzw3frmIlmhGl5ej3nv2Xlaa1qmJoOpFOWkTxsiRbNWzAjzA
 eUNzFt0GRRDPYW5HyVwQATaULg2tSo9ZFKW0JoKOjUuAR1+F88BAdyABM9uuIQNNsBUlWZJ5F9y
 AqcOR4rlLhaxI1QNhlXGRCla0E4W9TI+Rn8G6nKAy2Ufs+TzKtmLgj39Rq4KDVmw107h/23m51Z
 1WZz9yowvW9SetBfdYn0QJBgR6A5vAlFqpOx8MIAIoG7C9vw==
X-Gm-Gg: AYBFou0pjlVEoMmAxU7CntZ5gVxW79qbKhBZJFy0XpmJ1ZQKrSdsq0xf3mBy0/gczFa
 dUwwf6flS25KpBw6UGrxmfGquPn4SblGsOzztxdeXIP/FUUQd9Ejwipbd0zz+NoWdSvDIxppIDK
 pBzOI9Qov/SoRjADC3ltnuwikLZaCta8QurqcUJ+mOB12U5PrlkoSig6VU
X-Received: by 2002:a05:6820:3102:b0:6b2:f445:af17 with SMTP id
 006d021491bc7-6b6fc7d2b9cmr18109460eaf.26.1788886191694; 
 Tue, 08 Sep 2026 09:49:51 -0700 (PDT)
X-Received: by 2002:a05:6820:3102:b0:6b2:f445:af17 with SMTP id
 006d021491bc7-6b6fc7d2b9cmr18109434eaf.26.1788886191179; Tue, 08 Sep 2026
 09:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260903183725.15835-1-robin.clark@oss.qualcomm.com>
 <20260903184814.3BC6C1F000E9@smtp.kernel.org>
In-Reply-To: <20260903184814.3BC6C1F000E9@smtp.kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 09:49:39 -0700
X-Gm-Features: AcwNN1UsRKccp7EY1AAbXGvXSAW2NF0xgbz05s1mOXzHH6oBlCBvY7XVvB_WUuI
Message-ID: <CACSVV03gOMau27mbyG+29DGv9RjfWrd0YzwvmUnaDGe+u17nkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: Enable THP for GEM buffers
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4MSBTYWx0ZWRfX5gpAJVG/zWkV
 ath4YLZlF4WFyE/ynVSTlFjrjqXKH1AqHG0rXlFTTXkW2Rx19LuIui8hdQqN7GWrmoCQ5Q2JyxS
 cFqx7tIqGVcYx3qobjfUycasRU0WXbM=
X-Proofpoint-ORIG-GUID: iw-k1R1T-N1a1JLFM11JpGxywQvskuAC
X-Authority-Analysis: v=2.4 cv=TammcxQh c=1 sm=1 tr=0 ts=6aa03cb0 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=qmBQeO1blzqszIYDDTQA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: iw-k1R1T-N1a1JLFM11JpGxywQvskuAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4MSBTYWx0ZWRfX48AmNXOMAs95
 COPdDBkCwTb/cishdZu9yCQXL0rtnMcupPWpeS6lv3jZj0Q8CgQUIpnnH6k2Pb7DV+4ed3zmCZF
 4VIA1IJdQFrMbMEEGKapirg6pSm68wTcXJrjqBiSna3AnSPc2GjSs6MTOjT2tRF4pZynGmfpT0D
 rsNuyajPsZjLynPlhBxfxHmV/8B+L64/tdCc1c7ge5UuY0HlX9xdYKjMKCyJAxWhgrF2gDY4Fg/
 8XF89iILdycAar+iTL7JhwT7x+ChJwDtN9mp1ssetqKF5gC+bVTHcEFZ5Tt/RXdhT39Cjx627qh
 gNpQde1H2BQmhF7OtgbBd4FJ5K17Ce42n7NQzLnZ06V8J+9QwDJNyfrfGArQhk+jbITUA/CuO6B
 XSftnUjxQny485BDwY+QTASBp+kSo1AlQc9JxxuVUyS/eLxvdQ8DuvfD6li21S5Migbz7RcbZdR
 K4KmlVsOBzSQftiysyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080181
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

On Thu, Sep 3, 2026 at 11:48=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] THP initialization (`msm_gem_thp_init`) occurs after the DRM dev=
ice is exposed to userspace via `drm_dev_register`, creating a data race an=
d allowing premature access.
> - [Low] The module parameter `transparent_hugepage` is defined inside an =
`#ifdef CONFIG_TRANSPARENT_HUGEPAGE` block but accessed unconditionally in =
`msm_gem_thp_init()`, causing a compilation error when the config is disabl=
ed.
> --
>
> commit 46b2b6fe3a31a0213c502585828f1edd5794c935
> Author: Rob Clark <robin.clark@oss.qualcomm.com>
>
> drm/msm: Enable THP for GEM buffers
>
> This commit introduces a dedicated tmpfs mount point for Transparent
> Hugepage support in MSM GEM buffers to improve page allocation performanc=
e.
>
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_dr=
v.c
> > index db1b655dd055b..33b9f495af020 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> [ ... ]
> > @@ -58,9 +58,29 @@ static bool separate_gpu_kms;
> >  MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GP=
U (0=3Dsingle DRM device for both GPU and display (default), 1=3Dtwo DRM de=
vices)");
> >  module_param(separate_gpu_kms, bool, 0400);
> >
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +static bool transparent_hugepage =3D true;
> > +module_param(transparent_hugepage, bool, 0400);
> > +MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount po=
int with Transparent Hugepage enabled (true =3D default)");
> > +#endif
> > +
> >  DECLARE_FAULT_ATTR(fail_gem_alloc);
> >  DECLARE_FAULT_ATTR(fail_gem_iova);
> >
> > +static void msm_gem_thp_init(struct drm_device *dev)
> > +{
> > +     int err;
> > +
> > +     if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !transparent_hugep=
age)
>
> [Severity: Low]
> Will this cause a build failure when CONFIG_TRANSPARENT_HUGEPAGE is disab=
led?
> The transparent_hugepage module parameter is only defined inside the ifde=
f block
> just above, but the C compiler will still evaluate it unconditionally her=
e in
> msm_gem_thp_init(), resulting in an undeclared identifier error.

I was a bit curious how this even works on panfrost/panthor, which do
something similar.  But looks like they declare the variable as extern
in a header, and doesn't throw a link error because the reference gets
optimized out.

BR,
-R

> > +             return;
> > +
> > +     err =3D drm_gem_huge_mnt_create(dev, "within_size");
> > +     if (drm_gem_get_huge_mnt(dev))
> > +             drm_info(dev, "Using Transparent Hugepage\n");
> > +     else if (err)
> > +             drm_warn(dev, "Can't use Transparent Hugepage (%d)\n", er=
r);
> > +}
> [ ... ]
> > @@ -178,6 +198,8 @@ static int msm_drm_init(struct device *dev, const s=
truct drm_driver *drv,
> >       if (priv->kms_init)
> >               msm_drm_kms_post_init(dev);
> >
> > +     msm_gem_thp_init(ddev);
>
> [Severity: High]
> Is it safe to initialize the THP mount point here?
>
> Looking earlier in msm_drm_init(), drm_dev_register(ddev, 0) is called be=
fore
> this point. Because the device node is already exposed to userspace, a pr=
ocess
> could open it immediately after registration.
>
> If userspace starts allocating GEM objects before msm_gem_thp_init() comp=
letes,
> could this race condition cause the allocations to silently fall back to =
non-THP
> shmem, or potentially lead to a crash if a partially written pointer is r=
ead?
>
> > +
> >       return 0;
> >
> >  err_msm_uninit:
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903183725.15=
835-1-robin.clark@oss.qualcomm.com?part=3D1
