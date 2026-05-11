Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4423CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A36A10E707;
	Mon, 11 May 2026 13:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O2SxUIsD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XlUsxmyc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A8610E714
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:18:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BDE6tp453161
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=XGR00eUHw3iiiZo0kkmFBPSZRRSazE8m98na+gRcGkQ=; b=O2
 SxUIsD3yeLYZCtuPjaR0udkFFYZPuw33Uvgfdhk7ux5UeDWajH6b8rqHHthSPRrB
 2rqWAF4DI0+qDzySC66MydSOi79qkwbl8QSMhcLTxX69Mg4JHJY2lJGzkGjbM6zz
 0a4dG4Zg4qsi6Btgip2ZxEtbTKe9eAMUFHzRLSgwM6WxpXw2+YWlnnRhcGarATlp
 oR1a773XnIOlOB80pLKBVaIxUXqKhhYuqqxGRg6siVaRObJ4CV1fQNTGb619DYC+
 iQO0G8CusG55vY630SVIn97YlFLY1ZYEYAYUpU7PtHJKdWCiu/xYVVPXPRCwDAR6
 prCTenIwAIZKqLzINF7Q==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6h8pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:18:56 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6968cf5a116so5309282eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505536; cv=none;
 d=google.com; s=arc-20240605;
 b=HNfRRXKA7kJgcKWMo6fqr/qjOOmMyXwzHXWdljz6obnabOmwVmYImeuxXKheGRTFi+
 xSqalm7VbAv40E8i6NbnBNDZPm2zvUuZoDxJDF9srkOqq11xVj3rMMYv7MRQ+4+maIB7
 ABFetkrB4snyCqEpt5Bc+Cw1XF5025OzaX2keGHD24GJT8Uy1V5exV0tynayZUQ20VqE
 mCQn4OgHQC42GTZ4wv1RkXb6GhqqU/iNLEy9cEBmMi6CpLAuXDQA41Vq6I/jPc18e2o2
 /aPsQ1P7BASQruLi2els3ofyRDmsZrR88hbHMm1PRWIQAxpF7oDDJfUmFeION33B2FqC
 LQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=XGR00eUHw3iiiZo0kkmFBPSZRRSazE8m98na+gRcGkQ=;
 fh=5qwyfGbJvkqj9Uf23UniAh/Q2NqcVHQUD8v/XnrPCto=;
 b=U8LtWHEfUnYnuSArOPmHFUCn9ffRZBSADGsxlbcfWGHiiJckPq9Ixpg+mshmr00UmZ
 BkLT3RzOYwkVDKh5SKv/YSCmUsnv7SQQulKvpHRYs+Mmt+FOwU2sPZmzDuTkIusc+mGl
 JsccvywpYWKzETtbA+ffzuxtd7lMHed9ztzknbWJAQbkW9yq3tFgWz7wGSYOY1L/QdLa
 hwkIuUS13NV+NBjhx5EgjEOnTkijdn3ruQh2xlk52yokw7+ELoVNsrkCsg/oxrGrrRj+
 yIwwwQtEejwpSqAZpaRGgLnZ/IFJYJFlcdF6lnnUN0XA0eeckRPh8F5rp3Fs5jOwkaPn
 kvMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778505536; x=1779110336;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XGR00eUHw3iiiZo0kkmFBPSZRRSazE8m98na+gRcGkQ=;
 b=XlUsxmyc3lKNiVP+zl3ezYHS+vuTi4lZfbEkZFjp6SkNlY6H6NYzlAHcGZlZ4LVrgB
 xLRWssN1mgFKKlFufDIRE+7v1IzzhhaNx+vAHCG3ojFdM3ZU3uYut+YJxPbPvHFgef2T
 6str4OU4DMkz/a6Rs6HXLP7I3SaunpUCjS60eNhZM0TWxhYVrDO8A74bCj4o7BSGN8sK
 953+sxw4NNe9UVcowfmaSss4tOeQlorItPoJUHdtoZ9q4o27JzSDap/xpclofBWZWrJp
 7wr9p9BvXCSwpLMQwqxbJ2L6HAIWMMbiMkvg0ZM0GEo5245I7/mT5fAApwxpVcb9btA4
 iDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505536; x=1779110336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGR00eUHw3iiiZo0kkmFBPSZRRSazE8m98na+gRcGkQ=;
 b=q7EpZ4HXiw8ZPsYxbZay4Bdqf73dEISL/DpuVMBO/OC6DV2G2ogMybnWgxlmIG5rE5
 hsD2ZTguji/zw4P9xlJ/L0KM7QfV/BJBp0KiV4XzCBSGeLOHH6iMdZWZ94SrtOXYSWg2
 EEjLoSCRhI8odwZDVs3ItMyOsuPoFndkRvli/nEBj5HHiVdJMUSScjkBXuTeodkD3C6E
 9k4o3klpKpqNQumkECosu8v6XFprzTmt0oJUqzX5zbsc0mKWorCJDsoo5KIqxLHtU+oa
 yuJMsEcmmfcpgnXUtt0w24hzGjc6uEkMrnMiDG+F9FFbT6JmWuNvjxInepPrupNahC8t
 GJng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iKvrw5cd5qIFz0aqvM6tVB22PZFN4KV5FX4S/BUYdVeLJq/HtSr5MRZgos36PF/ZZ1M7lfW6nkK4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNWIWaE8Jz603NMT0WL3U190EazsDtwBEosvmj6uFrHh/HPXw4
 Oj02kJ75tkk4E5uD4iUouZgvIiMR0HjwpgcbhQmp0QxjHT+6YSOuzbvv/aOLLZ3pgW+DF0hdIKm
 34YWVqbD9BVGKFlx9Y2BH21uMMCnnNUAaYqWl+kSCJ9z+pgITYG3VCia/AurvzDAeW/qMtFvVgf
 9WggBOenfBqBLldEORGVUc6dT9cwZZ1nlujVawvMrbIkl9Kg==
X-Gm-Gg: Acq92OGFmq6ihKBNilH2Zelxpp1REhhJqqj1cakgj6I4Yeew1deSpC597JhV6KknJ7k
 0yYfSbJf0tGMn8hN7CXj8jvrF2AmUw8eNYZrIGTzgfKxH5zSIDPDPQDeqTTCZfRbUri1hF0TdDv
 fOOPYBU4dfK4qGA98dSvuNX//re8z0xdrjk155XoS3pC6MZa/b/PuGjbrOFzVVG3/onotC3+JmY
 6gGZQ7eOmvHajYsWbSNjegAuFAkkV66YwV8Mg==
X-Received: by 2002:a4a:ec45:0:b0:696:282e:69b5 with SMTP id
 006d021491bc7-69998d4e557mr12635660eaf.43.1778505535740; 
 Mon, 11 May 2026 06:18:55 -0700 (PDT)
X-Received: by 2002:a4a:ec45:0:b0:696:282e:69b5 with SMTP id
 006d021491bc7-69998d4e557mr12635616eaf.43.1778505535080; Mon, 11 May 2026
 06:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
 <20260508-panthor-shrinker-fixes-v2-4-39cdb7d577c9@collabora.com>
In-Reply-To: <20260508-panthor-shrinker-fixes-v2-4-39cdb7d577c9@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:18:44 -0700
X-Gm-Features: AVHnY4K0prdKPGftchkkqRIB5rspBpP8Hqh1OIZN435xOxgl6be3r1w5HTJQjGw
Message-ID: <CACSVV00NdUKe6-05U3g0q5X3tw4zmqO_s2gk-KZxQVykpydvAA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/gem: Make the GEM LRU lock part of drm_device
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
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01d740 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=bgK60gcJP7TMu5QwpHMA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NSBTYWx0ZWRfX+AvPmq8sSbTR
 bx6zMwZkJGmk9FWamnlfSz9TCzKLc5/grpeIZe8hqKYH6DMiFOkiuW0JU0oaXI35hjfpXQzQ4as
 Y0pgA+B97SCc0ckUCK8SWXcCgIRiq+u2/NK3yyuvqgKR17grxFj4G/dgGm5bVlDABsip6uaIPpw
 SgrLKqVCz2oW97BNZSjt/scfw8nFN+BjAWaIupH/Q3zz9HenJzlhoEUTK0crg1mJ0I8mzkriuX5
 9Cjtus/G3myjmnSAT1sYUE6KW0cnMffLs8iZblyRPmYRjmBo+97UFCeMl6HKB31Y4v1Nwps8vEb
 4s+a8CLsaljaJulQ+iws3WIMHYtscJcmqbnQhjZaszfO1RguaxKKBDBsKBaRfc9sQcHR9aYHnXd
 vU9AtMPP86ANf0MQOCVA/2MgJMOy7Sje+adgqzF0OaoMh9MyYrdIziMpg4o0kReqMur4hnrnNGQ
 WmpeGblCk6jwTduT3ew==
X-Proofpoint-GUID: UFB4FC_FCksCpdJmeoxOmUGMxEWkDdTO
X-Proofpoint-ORIG-GUID: UFB4FC_FCksCpdJmeoxOmUGMxEWkDdTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110145
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

On Fri, May 8, 2026 at 3:41=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Recently, a few races have been discovered in the GEM LRU logic, all
> of them caused by the fact the LRU lock is accessed through
> gem->lru->lock, and that lock itself also protects changes to
> gem->lru, leading to situations where gem->lru needs to first be
> accessed without the lock held, to then get the lru to access the lock
> through and finally take the lock and do the expected operation.
>
> Currently, the two drivers making use of this API declare device-wide
> locks, and there's no clue that we will ever have a driver that wants
> different pools of LRUs protected by different locks under the same
> drm_device. So we're better off moving this lock to drm_device and
> always locking it through obj->dev->gem_lru_mutex, or directly through
> dev->gem_lru_mutex.
>
> If anyone ever needs more fine-grained locking, this can be revisited
> to pass some drm_gem_lru_pool object represent the pool of LRUs under
> a specific lock, but for now, the per-device lock seems to be enough.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
>  drivers/gpu/drm/drm_drv.c                |  2 ++
>  drivers/gpu/drm/drm_gem.c                | 49 ++++++++------------------=
------
>  drivers/gpu/drm/msm/msm_drv.c            | 11 ++++---
>  drivers/gpu/drm/msm/msm_drv.h            |  7 -----
>  drivers/gpu/drm/msm/msm_gem.c            | 32 ++++++++++-----------
>  drivers/gpu/drm/msm/msm_gem_shrinker.c   |  4 +--
>  drivers/gpu/drm/msm/msm_gem_submit.c     |  6 ++--
>  drivers/gpu/drm/msm/msm_gem_vma.c        | 12 ++++----
>  drivers/gpu/drm/msm/msm_ringbuffer.c     |  6 ++--
>  drivers/gpu/drm/panthor/panthor_device.h |  3 --
>  drivers/gpu/drm/panthor/panthor_gem.c    | 21 ++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu.c    | 29 ++++++++++---------
>  include/drm/drm_device.h                 |  7 +++++
>  include/drm/drm_gem.h                    | 20 ++++++-------
>  14 files changed, 88 insertions(+), 121 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 985c283cf59f..675675480da4 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -697,6 +697,7 @@ static void drm_dev_init_release(struct drm_device *d=
ev, void *res)
>         mutex_destroy(&dev->master_mutex);
>         mutex_destroy(&dev->clientlist_mutex);
>         mutex_destroy(&dev->filelist_mutex);
> +       mutex_destroy(&dev->gem_lru_mutex);
>  }
>
>  static int drm_dev_init(struct drm_device *dev,
> @@ -738,6 +739,7 @@ static int drm_dev_init(struct drm_device *dev,
>         INIT_LIST_HEAD(&dev->vblank_event_list);
>
>         spin_lock_init(&dev->event_lock);
> +       mutex_init(&dev->gem_lru_mutex);
>         mutex_init(&dev->filelist_mutex);
>         mutex_init(&dev->clientlist_mutex);
>         mutex_init(&dev->master_mutex);
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index c85a39b8b163..a0e6668e93f2 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1127,8 +1127,6 @@ drm_gem_lru_remove_locked(struct drm_gem_object *ob=
j)
>  void
>  drm_gem_object_release(struct drm_gem_object *obj)
>  {
> -       struct drm_gem_lru *lru;
> -
>         if (obj->filp)
>                 fput(obj->filp);
>
> @@ -1136,30 +1134,7 @@ drm_gem_object_release(struct drm_gem_object *obj)
>
>         drm_gem_free_mmap_offset(obj);
>
> -       /*
> -        * We do the lru !=3D NULL check without the lru->lock held, whic=
h
> -        * means we might end up with a stale lru value by the time the
> -        * lock is acquired.
> -        *
> -        * This is deemed safe because:
> -        * 1. the LRU is assumed to outlive any GEM object it was attache=
d
> -        *    (LRUs are usually bound to a drm_device). So even if obj->l=
ru
> -        *    has become NULL, it still point to a valid object that can
> -        *    safely be dereferenced to get the lock.
> -        *
> -        * 2. all LRUs a GEM object might be attached to must share the s=
ame
> -        *    lock (lock that's usually part of the driver-specific devic=
e
> -        *    object), so taking the lock on the 'old' LRU is equivalent
> -        *    to taking it on the new one (if any)
> -        */
> -       lru =3D obj->lru;
> -       if (lru) {
> -               guard(mutex)(lru->lock);
> -
> -               /* Check a second time with the lock held to make sure we=
're
> -                * not racing with the drm_gem_lru_remove_locked() call i=
n
> -                * drm_gem_lru_scan().
> -                */
> +       scoped_guard(mutex, &obj->dev->gem_lru_mutex) {
>                 if (obj->lru)
>                         drm_gem_lru_remove_locked(obj);
>         }
> @@ -1582,9 +1557,8 @@ EXPORT_SYMBOL(drm_gem_unlock_reservations);
>   * @lock: The lock protecting the LRU
>   */
>  void
> -drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock)
> +drm_gem_lru_init(struct drm_gem_lru *lru)
>  {
> -       lru->lock =3D lock;
>         lru->count =3D 0;
>         INIT_LIST_HEAD(&lru->list);
>  }
> @@ -1601,7 +1575,7 @@ EXPORT_SYMBOL(drm_gem_lru_init);
>  void
>  drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_obj=
ect *obj)
>  {
> -       lockdep_assert_held_once(lru->lock);
> +       lockdep_assert_held_once(&obj->dev->gem_lru_mutex);
>
>         if (obj->lru)
>                 drm_gem_lru_remove_locked(obj);
> @@ -1625,9 +1599,9 @@ EXPORT_SYMBOL(drm_gem_lru_move_tail_locked);
>  void
>  drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_object *ob=
j)
>  {
> -       mutex_lock(lru->lock);
> +       mutex_lock(&obj->dev->gem_lru_mutex);
>         drm_gem_lru_move_tail_locked(lru, obj);
> -       mutex_unlock(lru->lock);
> +       mutex_unlock(&obj->dev->gem_lru_mutex);
>  }
>  EXPORT_SYMBOL(drm_gem_lru_move_tail);
>
> @@ -1648,7 +1622,8 @@ EXPORT_SYMBOL(drm_gem_lru_move_tail);
>   * @ticket: Optional ww_acquire_ctx context to use for locking
>   */
>  unsigned long
> -drm_gem_lru_scan(struct drm_gem_lru *lru,
> +drm_gem_lru_scan(struct drm_device *dev,
> +                struct drm_gem_lru *lru,
>                  unsigned int nr_to_scan,
>                  unsigned long *remaining,
>                  bool (*shrink)(struct drm_gem_object *obj, struct ww_acq=
uire_ctx *ticket),
> @@ -1658,9 +1633,9 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>         struct drm_gem_object *obj;
>         unsigned freed =3D 0;
>
> -       drm_gem_lru_init(&still_in_lru, lru->lock);
> +       drm_gem_lru_init(&still_in_lru);
>
> -       mutex_lock(lru->lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>
>         while (freed < nr_to_scan) {
>                 obj =3D list_first_entry_or_null(&lru->list, typeof(*obj)=
, lru_node);
> @@ -1685,7 +1660,7 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>                  * rest of the loop body, to reduce contention with other
>                  * code paths that need the LRU lock
>                  */
> -               mutex_unlock(lru->lock);
> +               mutex_unlock(&dev->gem_lru_mutex);
>
>                 if (ticket)
>                         ww_acquire_init(ticket, &reservation_ww_class);
> @@ -1729,7 +1704,7 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>
>  tail:
>                 drm_gem_object_put(obj);
> -               mutex_lock(lru->lock);
> +               mutex_lock(&dev->gem_lru_mutex);
>         }
>
>         /*
> @@ -1741,7 +1716,7 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>         list_splice_tail(&still_in_lru.list, &lru->list);
>         lru->count +=3D still_in_lru.count;
>
> -       mutex_unlock(lru->lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>
>         return freed;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.=
c
> index 195f40e331e5..cc2bcd14b1c2 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -128,11 +128,10 @@ static int msm_drm_init(struct device *dev, const s=
truct drm_driver *drv,
>         /*
>          * Initialize the LRUs:
>          */
> -       mutex_init(&priv->lru.lock);
> -       drm_gem_lru_init(&priv->lru.unbacked, &priv->lru.lock);
> -       drm_gem_lru_init(&priv->lru.pinned,   &priv->lru.lock);
> -       drm_gem_lru_init(&priv->lru.willneed, &priv->lru.lock);
> -       drm_gem_lru_init(&priv->lru.dontneed, &priv->lru.lock);
> +       drm_gem_lru_init(&priv->lru.unbacked);
> +       drm_gem_lru_init(&priv->lru.pinned);
> +       drm_gem_lru_init(&priv->lru.willneed);
> +       drm_gem_lru_init(&priv->lru.dontneed);
>
>         /* Initialize stall-on-fault */
>         spin_lock_init(&priv->fault_stall_lock);
> @@ -140,7 +139,7 @@ static int msm_drm_init(struct device *dev, const str=
uct drm_driver *drv,
>
>         /* Teach lockdep about lock ordering wrt. shrinker: */
>         fs_reclaim_acquire(GFP_KERNEL);
> -       might_lock(&priv->lru.lock);
> +       might_lock(&ddev->gem_lru_mutex);
>         fs_reclaim_release(GFP_KERNEL);
>
>         if (priv->kms_init) {
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.=
h
> index 76ac61df0b35..c3fb3205f683 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -150,13 +150,6 @@ struct msm_drm_private {
>                  * DONTNEED state (ie. can be purged)
>                  */
>                 struct drm_gem_lru dontneed;
> -
> -               /**
> -                * lock:
> -                *
> -                * Protects manipulation of all of the LRUs.
> -                */
> -               struct mutex lock;
>         } lru;
>
>         struct notifier_block vmap_notifier;
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.=
c
> index 2cb3ab04f125..070f5fc4bc17 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -177,11 +177,11 @@ static void update_lru_locked(struct drm_gem_object=
 *obj)
>
>  static void update_lru(struct drm_gem_object *obj)
>  {
> -       struct msm_drm_private *priv =3D obj->dev->dev_private;
> +       struct drm_device *dev =3D obj->dev;
>
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>         update_lru_locked(obj);
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>  }
>
>  static struct page **get_pages(struct drm_gem_object *obj)
> @@ -292,11 +292,11 @@ void msm_gem_pin_obj_locked(struct drm_gem_object *=
obj)
>
>  static void pin_obj_locked(struct drm_gem_object *obj)
>  {
> -       struct msm_drm_private *priv =3D obj->dev->dev_private;
> +       struct drm_device *dev =3D obj->dev;
>
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>         msm_gem_pin_obj_locked(obj);
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>  }
>
>  struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
> @@ -487,16 +487,16 @@ int msm_gem_pin_vma_locked(struct drm_gem_object *o=
bj, struct drm_gpuva *vma)
>
>  void msm_gem_unpin_locked(struct drm_gem_object *obj)
>  {
> -       struct msm_drm_private *priv =3D obj->dev->dev_private;
> +       struct drm_device *dev =3D obj->dev;
>         struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
>
>         msm_gem_assert_locked(obj);
>
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>         msm_obj->pin_count--;
>         GEM_WARN_ON(msm_obj->pin_count < 0);
>         update_lru_locked(obj);
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>  }
>
>  /* Special unpin path for use in fence-signaling path, avoiding the need
> @@ -507,10 +507,10 @@ void msm_gem_unpin_locked(struct drm_gem_object *ob=
j)
>   */
>  void msm_gem_unpin_active(struct drm_gem_object *obj)
>  {
> -       struct msm_drm_private *priv =3D obj->dev->dev_private;
> +       struct drm_device *dev =3D obj->dev;
>         struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
>
> -       GEM_WARN_ON(!mutex_is_locked(&priv->lru.lock));
> +       GEM_WARN_ON(!mutex_is_locked(&dev->gem_lru_mutex));
>
>         msm_obj->pin_count--;
>         GEM_WARN_ON(msm_obj->pin_count < 0);
> @@ -797,12 +797,12 @@ void msm_gem_put_vaddr(struct drm_gem_object *obj)
>   */
>  int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
>  {
> -       struct msm_drm_private *priv =3D obj->dev->dev_private;
> +       struct drm_device *dev =3D obj->dev;
>         struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
>
>         msm_gem_lock(obj);
>
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>
>         if (msm_obj->madv !=3D __MSM_MADV_PURGED)
>                 msm_obj->madv =3D madv;
> @@ -814,7 +814,7 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsig=
ned madv)
>          */
>         update_lru_locked(obj);
>
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>
>         msm_gem_unlock(obj);
>
> @@ -839,10 +839,10 @@ void msm_gem_purge(struct drm_gem_object *obj)
>
>         put_pages(obj);
>
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>         /* A one-way transition: */
>         msm_obj->madv =3D __MSM_MADV_PURGED;
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>
>         drm_gem_free_mmap_offset(obj);
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm=
/msm_gem_shrinker.c
> index 31fa51a44f86..c07af9602fee 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -186,7 +186,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, stru=
ct shrink_control *sc)
>                 if (!stages[i].cond)
>                         continue;
>                 stages[i].freed =3D
> -                       drm_gem_lru_scan(stages[i].lru, nr,
> +                       drm_gem_lru_scan(priv->dev, stages[i].lru, nr,
>                                          &stages[i].remaining,
>                                          stages[i].shrink,
>                                          &ticket);
> @@ -255,7 +255,7 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsi=
gned long event, void *ptr)
>         unsigned long remaining =3D 0;
>
>         for (idx =3D 0; lrus[idx] && unmapped < vmap_shrink_limit; idx++)=
 {
> -               unmapped +=3D drm_gem_lru_scan(lrus[idx],
> +               unmapped +=3D drm_gem_lru_scan(priv->dev, lrus[idx],
>                                              vmap_shrink_limit - unmapped=
,
>                                              &remaining,
>                                              vmap_shrink,
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 26ea8a28be47..3c6bc90c3d48 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -352,7 +352,7 @@ static int submit_fence_sync(struct msm_gem_submit *s=
ubmit)
>
>  static int submit_pin_objects(struct msm_gem_submit *submit)
>  {
> -       struct msm_drm_private *priv =3D submit->dev->dev_private;
> +       struct drm_device *dev =3D submit->dev;
>         int i, ret =3D 0;
>
>         for (i =3D 0; i < submit->nr_bos; i++) {
> @@ -381,11 +381,11 @@ static int submit_pin_objects(struct msm_gem_submit=
 *submit)
>          * get_pages() which could trigger reclaim.. and if we held the L=
RU lock
>          * could trigger deadlock with the shrinker).
>          */
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>         for (i =3D 0; i < submit->nr_bos; i++) {
>                 msm_gem_pin_obj_locked(submit->bos[i].obj);
>         }
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>
>         submit->bos_pinned =3D true;
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 271691ae32c3..3ed05ab0eeef 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -702,7 +702,7 @@ static struct dma_fence *
>  msm_vma_job_run(struct drm_sched_job *_job)
>  {
>         struct msm_vm_bind_job *job =3D to_msm_vm_bind_job(_job);
> -       struct msm_drm_private *priv =3D job->vm->drm->dev_private;
> +       struct drm_device *dev =3D job->vm->drm;
>         struct msm_gem_vm *vm =3D to_msm_vm(job->vm);
>         struct drm_gem_object *obj;
>         int ret =3D vm->unusable ? -EINVAL : 0;
> @@ -745,13 +745,13 @@ msm_vma_job_run(struct drm_sched_job *_job)
>         if (ret)
>                 msm_gem_vm_unusable(job->vm);
>
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>
>         job_foreach_bo (obj, job) {
>                 msm_gem_unpin_active(obj);
>         }
>
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>
>         /* VM_BIND ops are synchronous, so no fence to wait on: */
>         return NULL;
> @@ -1304,7 +1304,7 @@ vm_bind_job_pin_objects(struct msm_vm_bind_job *job=
)
>                         return PTR_ERR(pages);
>         }
>
> -       struct msm_drm_private *priv =3D job->vm->drm->dev_private;
> +       struct drm_device *dev =3D job->vm->drm;
>
>         /*
>          * A second loop while holding the LRU lock (a) avoids acquiring/=
dropping
> @@ -1313,10 +1313,10 @@ vm_bind_job_pin_objects(struct msm_vm_bind_job *j=
ob)
>          * get_pages() which could trigger reclaim.. and if we held the L=
RU lock
>          * could trigger deadlock with the shrinker).
>          */
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>         job_foreach_bo (obj, job)
>                 msm_gem_pin_obj_locked(obj);
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>
>         job->bos_pinned =3D true;
>
> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/m=
sm_ringbuffer.c
> index a7dafa7ab4b1..0d14c31bd4e4 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> @@ -16,13 +16,13 @@ static struct dma_fence *msm_job_run(struct drm_sched=
_job *job)
>         struct msm_gem_submit *submit =3D to_msm_submit(job);
>         struct msm_fence_context *fctx =3D submit->ring->fctx;
>         struct msm_gpu *gpu =3D submit->gpu;
> -       struct msm_drm_private *priv =3D gpu->dev->dev_private;
> +       struct drm_device *dev =3D gpu->dev;
>         unsigned nr_cmds =3D submit->nr_cmds;
>         int i;
>
>         msm_fence_init(submit->hw_fence, fctx);
>
> -       mutex_lock(&priv->lru.lock);
> +       mutex_lock(&dev->gem_lru_mutex);
>
>         for (i =3D 0; i < submit->nr_bos; i++) {
>                 struct drm_gem_object *obj =3D submit->bos[i].obj;
> @@ -32,7 +32,7 @@ static struct dma_fence *msm_job_run(struct drm_sched_j=
ob *job)
>
>         submit->bos_pinned =3D false;
>
> -       mutex_unlock(&priv->lru.lock);
> +       mutex_unlock(&dev->gem_lru_mutex);
>
>         /* TODO move submit path over to using a per-ring lock.. */
>         mutex_lock(&gpu->lock);
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index dcdce75b683b..cc5720312fa9 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -187,9 +187,6 @@ struct panthor_device {
>                 /** @reclaim.shrinker: Shrinker instance */
>                 struct shrinker *shrinker;
>
> -               /** @reclaim.lock: Lock protecting all LRUs */
> -               struct mutex lock;
> -
>                 /**
>                  * @reclaim.unreclaimable: unreclaimable BOs
>                  *
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index 8e31740126e7..450516d55faa 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1497,13 +1497,13 @@ panthor_gem_shrinker_scan(struct shrinker *shrink=
er, struct shrink_control *sc)
>         if (!can_swap())
>                 goto out;
>
> -       freed +=3D drm_gem_lru_scan(&ptdev->reclaim.unused,
> +       freed +=3D drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.unused,
>                                   sc->nr_to_scan - freed, &remaining,
>                                   panthor_gem_try_evict_no_resv_wait, NUL=
L);
>         if (freed >=3D sc->nr_to_scan)
>                 goto out;
>
> -       freed +=3D drm_gem_lru_scan(&ptdev->reclaim.mmapped,
> +       freed +=3D drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.mmapped=
,
>                                   sc->nr_to_scan - freed, &remaining,
>                                   panthor_gem_try_evict_no_resv_wait, NUL=
L);
>         if (freed >=3D sc->nr_to_scan)
> @@ -1517,7 +1517,7 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker=
, struct shrink_control *sc)
>         if (freed >=3D sc->nr_to_scan)
>                 goto out;
>
> -       freed +=3D drm_gem_lru_scan(&ptdev->reclaim.gpu_mapped_shared,
> +       freed +=3D drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.gpu_map=
ped_shared,
>                                   sc->nr_to_scan - freed, &remaining,
>                                   panthor_gem_try_evict, NULL);
>
> @@ -1546,22 +1546,17 @@ panthor_gem_shrinker_scan(struct shrinker *shrink=
er, struct shrink_control *sc)
>  int panthor_gem_shrinker_init(struct panthor_device *ptdev)
>  {
>         struct shrinker *shrinker;
> -       int ret;
> -
> -       ret =3D drmm_mutex_init(&ptdev->base, &ptdev->reclaim.lock);
> -       if (ret)
> -               return ret;
>
>         INIT_LIST_HEAD(&ptdev->reclaim.vms);
> -       drm_gem_lru_init(&ptdev->reclaim.unreclaimable, &ptdev->reclaim.l=
ock);
> -       drm_gem_lru_init(&ptdev->reclaim.unused, &ptdev->reclaim.lock);
> -       drm_gem_lru_init(&ptdev->reclaim.mmapped, &ptdev->reclaim.lock);
> -       drm_gem_lru_init(&ptdev->reclaim.gpu_mapped_shared, &ptdev->recla=
im.lock);
> +       drm_gem_lru_init(&ptdev->reclaim.unreclaimable);
> +       drm_gem_lru_init(&ptdev->reclaim.unused);
> +       drm_gem_lru_init(&ptdev->reclaim.mmapped);
> +       drm_gem_lru_init(&ptdev->reclaim.gpu_mapped_shared);
>         ptdev->reclaim.gpu_mapped_count =3D 0;
>
>         /* Teach lockdep about lock ordering wrt. shrinker: */
>         fs_reclaim_acquire(GFP_KERNEL);
> -       might_lock(&ptdev->reclaim.lock);
> +       might_lock(&ptdev->base.gem_lru_mutex);
>         fs_reclaim_release(GFP_KERNEL);
>
>         shrinker =3D shrinker_alloc(0, "drm-panthor-gem");
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 452d0b6d4668..9d4500850561 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -715,10 +715,10 @@ int panthor_vm_active(struct panthor_vm *vm)
>          * never became active in the first place will be reclaimed last,=
 but
>          * that's an acceptable trade-off.
>          */
> -       mutex_lock(&ptdev->reclaim.lock);
> +       mutex_lock(&ptdev->base.gem_lru_mutex);
>         if (vm->reclaim.lru.count)
>                 list_move_tail(&vm->reclaim.lru_node, &ptdev->reclaim.vms=
);
> -       mutex_unlock(&ptdev->reclaim.lock);
> +       mutex_unlock(&ptdev->base.gem_lru_mutex);
>
>         /* Make sure we don't race with lock/unlock_region() calls
>          * happening around VM bind operations.
> @@ -1962,9 +1962,9 @@ static void panthor_vm_free(struct drm_gpuvm *gpuvm=
)
>         struct panthor_vm *vm =3D container_of(gpuvm, struct panthor_vm, =
base);
>         struct panthor_device *ptdev =3D vm->ptdev;
>
> -       mutex_lock(&ptdev->reclaim.lock);
> +       mutex_lock(&ptdev->base.gem_lru_mutex);
>         list_del_init(&vm->reclaim.lru_node);
> -       mutex_unlock(&ptdev->reclaim.lock);
> +       mutex_unlock(&ptdev->base.gem_lru_mutex);
>
>         mutex_lock(&vm->heaps.lock);
>         if (drm_WARN_ON(&ptdev->base, vm->heaps.pool))
> @@ -2360,11 +2360,11 @@ void panthor_vm_update_bo_reclaim_lru_locked(stru=
ct panthor_gem_object *bo)
>                 drm_WARN_ON(&ptdev->base, vm);
>                 vm =3D container_of(vm_bo->vm, struct panthor_vm, base);
>
> -               mutex_lock(&ptdev->reclaim.lock);
> +               mutex_lock(&ptdev->base.gem_lru_mutex);
>                 drm_gem_lru_move_tail_locked(&vm->reclaim.lru, &bo->base)=
;
>                 if (list_empty(&vm->reclaim.lru_node))
>                         list_move(&vm->reclaim.lru_node, &ptdev->reclaim.=
vms);
> -               mutex_unlock(&ptdev->reclaim.lock);
> +               mutex_unlock(&ptdev->base.gem_lru_mutex);
>         }
>  }
>
> @@ -2774,7 +2774,7 @@ panthor_vm_create(struct panthor_device *ptdev, boo=
l for_mcu,
>         vm->kernel_auto_va.start =3D auto_kernel_va_start;
>         vm->kernel_auto_va.end =3D vm->kernel_auto_va.start + auto_kernel=
_va_size - 1;
>
> -       drm_gem_lru_init(&vm->reclaim.lru, &ptdev->reclaim.lock);
> +       drm_gem_lru_init(&vm->reclaim.lru);
>         INIT_LIST_HEAD(&vm->reclaim.lru_node);
>         INIT_LIST_HEAD(&vm->node);
>         INIT_LIST_HEAD(&vm->as.lru_node);
> @@ -3140,7 +3140,7 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device =
*ptdev,
>         LIST_HEAD(remaining_vms);
>         LIST_HEAD(vms);
>
> -       mutex_lock(&ptdev->reclaim.lock);
> +       mutex_lock(&ptdev->base.gem_lru_mutex);
>         list_splice_init(&ptdev->reclaim.vms, &vms);
>
>         while (freed < nr_to_scan) {
> @@ -3156,12 +3156,13 @@ panthor_mmu_reclaim_priv_bos(struct panthor_devic=
e *ptdev,
>                         continue;
>                 }
>
> -               mutex_unlock(&ptdev->reclaim.lock);
> +               mutex_unlock(&ptdev->base.gem_lru_mutex);
>
> -               freed +=3D drm_gem_lru_scan(&vm->reclaim.lru, nr_to_scan =
- freed,
> +               freed +=3D drm_gem_lru_scan(&ptdev->base, &vm->reclaim.lr=
u,
> +                                         nr_to_scan - freed,
>                                           remaining, shrink, NULL);
>
> -               mutex_lock(&ptdev->reclaim.lock);
> +               mutex_lock(&ptdev->base.gem_lru_mutex);
>
>                 /* If the VM is still in the temporary list, remove it so=
 we
>                  * can proceed with the next VM.
> @@ -3177,11 +3178,11 @@ panthor_mmu_reclaim_priv_bos(struct panthor_devic=
e *ptdev,
>                                 list_add_tail(&vm->reclaim.lru_node, &rem=
aining_vms);
>                 }
>
> -               mutex_unlock(&ptdev->reclaim.lock);
> +               mutex_unlock(&ptdev->base.gem_lru_mutex);
>
>                 panthor_vm_put(vm);
>
> -               mutex_lock(&ptdev->reclaim.lock);
> +               mutex_lock(&ptdev->base.gem_lru_mutex);
>         }
>
>         /* Re-insert VMs with remaining data to reclaim at the beginning =
of
> @@ -3192,7 +3193,7 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device =
*ptdev,
>          */
>         list_splice_tail(&vms, &remaining_vms);
>         list_splice(&remaining_vms, &ptdev->reclaim.vms);
> -       mutex_unlock(&ptdev->reclaim.lock);
> +       mutex_unlock(&ptdev->base.gem_lru_mutex);
>
>         return freed;
>  }
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index bc78fb77cc27..768a8dae83c5 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -375,6 +375,13 @@ struct drm_device {
>          * Root directory for debugfs files.
>          */
>         struct dentry *debugfs_root;
> +
> +       /**
> +        * @gem_lru_mutex:
> +        *
> +        * Lock protecting movement of GEM objects between LRUs.
> +        */
> +       struct mutex gem_lru_mutex;
>  };
>
>  void drm_dev_set_dma_dev(struct drm_device *dev, struct device *dma_dev)=
;
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index d527df98d142..dd1a9cd559be 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -245,17 +245,11 @@ struct drm_gem_object_funcs {
>   * for lockless &shrinker.count_objects, and provides
>   * &drm_gem_lru_scan for driver's &shrinker.scan_objects
>   * implementation.
> + *
> + * Any access to this kind of object must be done with
> + * drm_device::gem_lru_mutex held.
>   */
>  struct drm_gem_lru {
> -       /**
> -        * @lock:
> -        *
> -        * Lock protecting movement of GEM objects between LRUs.  All
> -        * LRUs that the object can move between should be protected
> -        * by the same lock.
> -        */
> -       struct mutex *lock;
> -
>         /**
>          * @count:
>          *
> @@ -453,6 +447,9 @@ struct drm_gem_object {
>          * @lru:
>          *
>          * The current LRU list that the GEM object is on.
> +        *
> +        * Access to this field must be done with drm_device::gem_lru_mut=
ex
> +        * held.
>          */
>         struct drm_gem_lru *lru;
>  };
> @@ -610,11 +607,12 @@ void drm_gem_unlock_reservations(struct drm_gem_obj=
ect **objs, int count,
>  int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *de=
v,
>                             u32 handle, u64 *offset);
>
> -void drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock);
> +void drm_gem_lru_init(struct drm_gem_lru *lru);
>  void drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_ge=
m_object *obj);
>  void drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_objec=
t *obj);
>  unsigned long
> -drm_gem_lru_scan(struct drm_gem_lru *lru,
> +drm_gem_lru_scan(struct drm_device *dev,
> +                struct drm_gem_lru *lru,
>                  unsigned int nr_to_scan,
>                  unsigned long *remaining,
>                  bool (*shrink)(struct drm_gem_object *obj, struct ww_acq=
uire_ctx *ticket),
>
> --
> 2.54.0
>
