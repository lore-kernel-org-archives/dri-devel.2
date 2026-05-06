Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2120CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA8F10E023;
	Wed,  6 May 2026 13:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pX5hEFks";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAOQrmx2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEA010E1BD
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:21:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6469xtpA1985549
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 13:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=Vqd/BKSaw8MiEHlZMSqKjEqhHIpkwgJT4q9tI6/8NPk=; b=pX
 5hEFksQefNbV3ibdPFGwC7dq4oNlfdUjEsLggusBYU8JZZfFR47FKfVXUlqDNdwc
 1MLFLkIdXriAPxEzHktv3LSkOSRXg6oGds5U7uBMgbJ5ybBWmT9Z3vZ41Ca2FXpE
 x6TMkA47KoWDf8Jv8xmfrHNOtr8gk+DRLtdRCLBarmeNSsI0pFyfVOXx1YeOguC4
 oIrO7LSk7JWzYqtnsgFXFCaCDP8VAEOEkngI05UY0TPHV/6yUBelJskCfawlXb7v
 G5WcgpnH6yX5ZsgjucqJGJa72qcFpbmmbzUyQjYkEXK2CXdJyRjeQzHHMnZKii+D
 RCu5f2LJZba1Yj0Ob2XQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03gp0m2k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 13:21:55 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-433cbb6a2d9so10717010fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 06:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778073714; cv=none;
 d=google.com; s=arc-20240605;
 b=UnbdlLwfZRWQxyr6zq1wSKdv5RFgrLz0XTqlNitYqz/Ve+e5MZzoKzRsc7Y+Jn9zK0
 vU1qdhf5UmHYu6bbCkTBTBNc+SN/tio/99cDFsytikDd+ckSemDmjHR7lpFj5ikhccBi
 1SSnqZE73MSmh20DqABas7RQoa/rqfPgoci4fFiKrRpzwE80k9vOqNg5Fo2kO5ks+yCj
 kBm/w0FMr3+H8H2Z5VLFJLzHOTKOSpykGG4tZ3ufzW3z+ePNgv40iMEVJ7hiEFmisb3S
 Y7F4ZP8r/BXm+6T6JDNTwwBAEnreuFY4wY94jxr78pV9YGWGmDacUX/27us8ucFyN0+V
 HLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Vqd/BKSaw8MiEHlZMSqKjEqhHIpkwgJT4q9tI6/8NPk=;
 fh=iczeTTWS54EtK+Y47xS1sXlazQgnPXcqkjLx9QJQ2qk=;
 b=BXJLN+5pMMlvAgQKTL4TbcYYx0fn/Ye/tFF0GO1FGAvY2xu8RB0bTA1N1QGDfHMr9t
 1rbBs7u7UI6IkfjFDWivLCWbXQKW7bipSb/YirD31ZJg/KnQAT4DS83+RF4RMj+UAs0l
 oiHBXlVm8aLT006zl+x53RY54yv00DLROOET+ne14q6+g/xJX3tRO/GfBZXLmb0etZe3
 vy/yoJPu/w44ij/yZAXs2LUrL68oVsGRliLIxnZBdoZKW6smoD/Fndw/q8WL4GEb6IbH
 KbZXK3QXgSLhry7YAAYeDpTCDw2y973gHry6lUe0fTDKQqenLjfknnqcBQIXZZgmPP6V
 4qEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778073714; x=1778678514;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Vqd/BKSaw8MiEHlZMSqKjEqhHIpkwgJT4q9tI6/8NPk=;
 b=EAOQrmx2K6N06UxqivH9tdQF0ENnwBKVWTHWZZ5iWEwKfZmTVnKc7SqOJdDjUrFYS7
 PaOsBXSUGxElsGY2R8WdfipVCY+c66+aL+T1v8Zzc1Ge6TjeHbJm7MrgJg8obtUrjntH
 AzlMR7VlOyVDc8d5TOTklvIfLK/5Nwi9Bbd6rKv0BaecYaXrM5Z8zSstfu+JMZ7SgqSF
 4bMaE7uNaTgRtuUjUTna2hAadYS5IZ4S30btAScA5nsgGaf7miP84f2e0wmU7ujIp6PC
 58AsLeIVPexi49jv1xWq182yMAtHe7LUxNr03/tJ3gJzJMBUupI/2ktBntKCv+qfIrY5
 JR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778073714; x=1778678514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vqd/BKSaw8MiEHlZMSqKjEqhHIpkwgJT4q9tI6/8NPk=;
 b=pPzAFVxPIFXHF4Ty9GJ6jOKMCP4OGaYhs+tHWfgo+JqWqLtQaOLSrCgZmCXhJfechi
 K0jM+7DGdrmo3D09hDuGylAIxa56f24CdpQZbzJjRdo3vfTH6+HMjs1oIZsoEvp9CWoc
 785ckOuKEykM0svXAZmEaL7SmJ87h0h+TS4NS7TIfI/11LKBtyiqtIV9FMhVyRN5mF7Q
 oUAIFEllAoFlgiPtRfX6lt+cQyx/Etnzxyl+MXioc9/a3t/rSIQS65J0uEycVsxK+Zf+
 27QNTdwwvfyyDebdiFn8Tip5Gnx+eNIaqFP7lNKQBGiRMb2Qvdk4nHsKLW5uIsbQxOfu
 2iSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9d5vU0xCmmxehfkqpwPCh3YsP6DwG5V0YhoN2f5w3pj1zqEq48EXShk+skpeppOF7LCrdbzXX4t2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4+wX4/SIA+gbBWosao5IM6Rjqhu8IhmtYEbZhYfoUxsYYcg38
 uWj1IxnyMSY+cqtoL6H47vXaZUQC3yRqkwKsOHjbzNnuzOfeFFbIyJCMyMXjEAVeeRtXMpW5pbs
 iGuD4Tv0+De4xWYpdlgrsCpEirLg1stiue9Fu5MwmMkDoy24owVTIgYKfJai0sP4xfPIP+O7K4W
 Fxi2+LkAvr+wbeIP5n57/21CcDN0oBeXx0MbFvyX1VnTKZMQ==
X-Gm-Gg: AeBDieuMms0tVEjeongpqMFq7R+0vSrQSsJYl12UX1hkpFCQMW31vvbyxovZZ42yOlx
 0yzYRysHNDFOnu6lkskjJYhJZ9cQjSozGAIyNnWwdEftjsDVkacvs2H2GtGzdDKF0I0ni0Dp+vG
 uy4AgYolwjakj68KRDCXbHCrZLY++LeQbIxlNq3ZInTHCmxLleiHuderfkYXU6+08dd24xiDnTq
 AR4m8qfUXkyZHDj7FcLCzU/C0FmEKIKUZPURNcalAIejXV8
X-Received: by 2002:a05:6820:160c:b0:694:9764:a6b3 with SMTP id
 006d021491bc7-69998cbb277mr1578179eaf.10.1778073714444; 
 Wed, 06 May 2026 06:21:54 -0700 (PDT)
X-Received: by 2002:a05:6820:160c:b0:694:9764:a6b3 with SMTP id
 006d021491bc7-69998cbb277mr1578144eaf.10.1778073713972; Wed, 06 May 2026
 06:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
In-Reply-To: <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 6 May 2026 06:21:42 -0700
X-Gm-Features: AVHnY4JUvyhzpBHu1ej8gCozNDNlYSWGiMVcqIl7s5jMhHt25V2Q_ufOWv6QTJM
Message-ID: <CACSVV01sJqXCK8Lx5+bSPqzbNv7ALAbcA3P2RiJEOPOX_4Jmxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/gem: Fix a race between drm_gem_lru_scan() and
 drm_gem_object_release()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzMSBTYWx0ZWRfX/qYBAe4gNroh
 aanBnfdmf79Er3CQ8EwOaij3d3DrALAThwdKgZASk3yDlvoS+fy5EF/7l+WrhnLwBnbUa1lG8I+
 RB84AxHqBk50p4+9PqqgHg0YJGhGUZlVf723aFRpRa5Jk3wBn8EasJYWIZbU61DG/ZKJSiLc78S
 zOxG/svi3PHhx30uNI9vMS+2xSLCYNIakjTzzFWCR8K7U7XkHe9qv4LBI5hTjawGdLxSko4vb7N
 rQS+OwrRFtws43FDloThQ3dIGAhU5HIMQSVKr2hxXmLLHVfNIoQKDZxOVW7kKqa9HcPtkX784GE
 IcWk9igL4gVwfE3/2PavnHrXZTIzvUyJvSOWe+kimrJcrBgB9oTDRGcL5W17aGPTSzJrqeCnag7
 Z0Hq3KV3beHg5jiieyFrzNYM/4X1IvLncHYamfwbjzrnoREpeM5+EzJkoxycskJ7EW+6pBsre4S
 sG56USIGVIhCtM1243g==
X-Proofpoint-ORIG-GUID: Q0DFni8IMUlZ73v0HTHrou48OcYWTm-a
X-Proofpoint-GUID: Q0DFni8IMUlZ73v0HTHrou48OcYWTm-a
X-Authority-Analysis: v=2.4 cv=W8wIkxWk c=1 sm=1 tr=0 ts=69fb4073 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=pGLkceISAAAA:8
 a=MjbirWAG49z9sCQywfsA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060131
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

On Wed, May 6, 2026 at 5:16=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> The following race can currently happen:
>
> | Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem_obj=
ect_release` |
> | -                                            | -                       =
             |
> | move obj1 with refcount=3D=3D0 to `still_in_lru` |                     =
                 |
> | move obj2 with refcount!=3D0 to `still_in_lru` |                       =
               |
> | mutex_unlock                                 |                         =
             |
> | shrink obj2                                  |                         =
             |
> |                                              | lru =3D obj1->lru; // `s=
till_in_lru`   |
> | mutex_lock                                   |                         =
             |
> | move obj1 back to the original lru           |                         =
             |
> | mutex_unlock                                 |                         =
             |
> | return                                       |                         =
             |
> |                                              | dereference `still_in_lr=
u`           |
>
> Move the drm_gem_lru_move_tail_locked() after the
> kref_get_unless_zero() check so that we don't end up with a
> vanishing LRU when we hit drm_gem_object_release(). We also need to
> remove the skipped object from its LRU, otherwise we'll keep hitting
> it on subsequent loop iterations until it's actually removed from the
> list in the drm_gem_release().
>
> Fixes: e7c2af13f811 ("drm/gem: Add LRU/shrinker helper")
> Reported-by: Chia-I Wu <olvaffe@gmail.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index fca42949eb2b..97cf63de0112 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1660,15 +1660,19 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>                 if (!obj)
>                         break;
>
> -               drm_gem_lru_move_tail_locked(&still_in_lru, obj);
> -
>                 /*
>                  * If it's in the process of being freed, gem_object->fre=
e()
> -                * may be blocked on lock waiting to remove it.  So just
> -                * skip it.
> +                * may be blocked on lock waiting to remove it.  So just =
remove
> +                * it from its current LRU and skip it.
>                  */
> -               if (!kref_get_unless_zero(&obj->refcount))
> +               if (!kref_get_unless_zero(&obj->refcount)) {
> +                       if (obj->lru)
> +                               drm_gem_lru_remove_locked(obj);

if we are iterating a LRU.. and lru->lock is held, shouldn't obj->lru
always be non-null?

BR,
-R

> +
>                         continue;
> +               }
> +
> +               drm_gem_lru_move_tail_locked(&still_in_lru, obj);
>
>                 /*
>                  * Now that we own a reference, we can drop the lock for =
the
>
> --
> 2.54.0
>
