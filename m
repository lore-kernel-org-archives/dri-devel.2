Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EABCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 21:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B017F10E5C2;
	Thu,  7 May 2026 21:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kA853WPi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="clAEhnqi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F58410E043
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 21:38:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647I7Ykp1971630
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 21:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=3YwU5KFss6owZTextGQfE/Tb475sC/CVvKPS35tpqLA=; b=kA
 853WPiT8RHBmH++QTnSBXrYih+OPboZGDdGFicOe+aDQxojVslgqvOIu0XhUFpMT
 rAwdWLZHGG4Bq9f96WZrBTigfuOacXTgBlNNYRgBWcMgrnEmCFcRrEClA5H2WViV
 y2Y98sWE8G5JRwmqZlGBL9b+pap1zHlwYxVcbBcsZD9vmXmUZh7KhbCnQ4byk0EU
 Jhy0ucVLVTiCHPM1YG0T+02DrJprlIGW3tbSlIB9J+1d4tq8haxQL8mds46GMCFz
 /tgTAcnAzOOdFqZIEp6ORTSzKig3IrxQknNMKaX9lB/N3b/LNwtAciF9YEJWtxa1
 V2vkZxkEhEFKCBVBhTbQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0teja6j4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 21:38:35 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7de442b3402so3319008a34.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778189915; cv=none;
 d=google.com; s=arc-20240605;
 b=HSw5RgTz6YhNAijjFPX4oQJ+ayFN1yYuuITH61Qi4uR48jErc5O2Frj/ROggCZOTwO
 V0PBtkCDIWXJXdSbAMYY6zyjkCr0pU8Qatsll46EXBJ1Mhey+jyZXowuDvvWDBZCLsOZ
 yZpWwh4qPXLJgLgjCQ7rEP3oWopH28NbdQhXGEQ4wq+lEsgg58+KVw+DIr27rVCGeaQj
 Dgm//CuJS+yvxr3Jc+zY5IKV614Crh/eAYaj6vdyltrtpKDe9RNTu1lOLrSOfeqK41VL
 EF/WVl9qIZxuI9xVOaJsjXZX4sdy3E6mtsHDqN25p+WujiiNJrGG7/HgLyfJJoIlJ1iq
 Sxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=3YwU5KFss6owZTextGQfE/Tb475sC/CVvKPS35tpqLA=;
 fh=nC0t+hG/cmUtmu6wOBNdeMXZANXtUTNML4GtD23ou/E=;
 b=XZYOf/RnAHgvo5CQCFmBdyTxGsf1kWG840F9BFkTdrsKR9zo8I33l/CVewQI0C04QM
 VTDzZ9ZbEeOeFT9zNs+XAmwahPjcKLN5R5pa9bmOYPbj8Re+164sZeh/o/UDebMw70a2
 Gf/vUo9UHBA2Kb9jqGE1C2XTHnWwL0r4Us+m9qUS9xtArDhAnxImlqs53FNv5ZiSTg93
 D90colo9V5CbDZt5E9JJcF/aXC/Vn0O1PfGGp6iGGEHgoRNX2G40X9E8O9PygQqAq2ys
 sjMqoWMcbICiHDsKV0NXrfFYyHLC6J72dtXInmyqx9OTjtgOL34ATChuyYuaqo07MqQu
 PPog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778189915; x=1778794715;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3YwU5KFss6owZTextGQfE/Tb475sC/CVvKPS35tpqLA=;
 b=clAEhnqiYbHVWJ3H56OaRe1qSdmSAs1weYjX7Z7HZrgPJ7TUcjfGGw3J/RKvpn9mmh
 CMyBdK6GUCf453ll/7wX4E1WCK3l7hKk5RAdCzh8cfBjDvqdcRtJjGPiD3LdCIHl9WPp
 9qKpyYleApxU+RXTjspy+L1LeRcbjLy3liLk4yskqtCIB8/Dw5qvOj5HiOsjg/ykQl4l
 PmNKWgQbnpo/ZUqiVBNeeNzHKlCTLdxET++nbUM4ZDhiJVSdwhrRZMHk+N1GCDu/1JRi
 QzTopTzwICpaIZaipX/XRKbpt9YBjA7/F2WaDAPzkx1MxNN0ELNaXoHpNO9mNwhQqO4E
 FUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778189915; x=1778794715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3YwU5KFss6owZTextGQfE/Tb475sC/CVvKPS35tpqLA=;
 b=XoNATynyNZPXkJLPj1powe2kTInDaENVfOYz/zSuJI1BA7kAaPG1TQSi/0BRyyqJxH
 sGJgYv3xrI8r2az2GUN2U9FwAFSisDjdnZqFgtVqT3jL2jxkUj4oKpQdhb41cKLlwxwx
 jApY52jusDPwaOQJLmlYEJYLRX3BAzEY0LfODNc481kTJXbRcTFyOBFREB8As6K2IMhn
 TYT3m/VfiPZjb9CFjb1c0/y6Ioc9mv6l65IyZwmJdUZ0FIgt3pCvVki0Nj8c6gIIskHP
 upYKSpZDvTlyOlj56fOOhUMOTHAqdw3m6AdyRwKjPeabrnPn+5cAk6m3NdQQmoxzkrzA
 Phkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/KvwV54+3vqcgW3KwiMUBNWHp3wLZ94i3pTmK9hbeO7e0wFSGl7JqKYN+z2XLdsagRUvuRy5nL0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzqFc03LSAFasJLIoRKtBw3i1Jj80VcRXodaF/+648HSNBhKKK
 LYXDMUciq++S8MUwuJQyYzDsxJgz4VQHQRLkOI6CpQey6xNs8QBCqAka7hzvpSWZBF+jMEW15Qk
 s1WlJfEnjAPAe6WomFZDf55FQ/vZxH7DARNymXPULHL0u3wNOJ9w/rxwlOLCWJ3PLg0fPOtGCSt
 GjKkIKEnMW700atK8Q1Nkc4SmUc3p0enww61vQpGGkZxW2Jw==
X-Gm-Gg: AeBDieuXVk4PlLpaNN4N4c7BixwhZOLTv3URETfwqHqgxNsSO6hwU6n6cdjrVSKD8G0
 wfdjpBGVp3yzwlGU/ApIuMbTFBRqDsrGlJ3jw7xMJ30VeGaMSSVCBmNM8qOkgSuCuatKiw4OipV
 s/QBgqPutZR+yCXTpCT8q4iVRLk9yEeNPTjBzuECjRKXCA99TmsV1kLE+GjdMaFf1X3rR1ImGT2
 /zmFZ3x4DHJoWA+6hzaVTioNdc0Y/BrJpOE60w7ygc4V+Tt
X-Received: by 2002:a4a:e918:0:b0:67e:3f0d:4235 with SMTP id
 006d021491bc7-69998c9f74emr5764596eaf.11.1778189914669; 
 Thu, 07 May 2026 14:38:34 -0700 (PDT)
X-Received: by 2002:a4a:e918:0:b0:67e:3f0d:4235 with SMTP id
 006d021491bc7-69998c9f74emr5764575eaf.11.1778189914197; Thu, 07 May 2026
 14:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
 <20260507144639.68bd699f@fedora>
In-Reply-To: <20260507144639.68bd699f@fedora>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 7 May 2026 14:38:23 -0700
X-Gm-Features: AVHnY4LVtQidNe4HWkr8vd5IMleFeEOibs3s_XykwrIcXt17q4yGV3Ac0kURMcQ
Message-ID: <CACSVV01zGLN8FV3Fpw1BnW+zSokE7n2XJ2dBmDw8-n=MXBmDnw@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIxOSBTYWx0ZWRfX/dAUMlTaRit7
 r89ybMSf5vEe2L7RYFr4HptJTLAfoJEGEbixeGYvpyHGnGtolrfLootHPNdsTUJ7hQoJtwNJ6RF
 waZ1kshBudbZCtAZaKFH2gkFx7Hq8v8yUYr7+J80/ouXKelzMuGEtQV6nZ4DW7HPFauEKnjTl4D
 u97Vbg4ktXl3qugYrGroxO0whlYm/tcGaM56EG2udgUSI+bFwPAs3Tz5YuqGqMx0iYHjOI9ubZ1
 Jjj3fZsEu6m8zD4o/Y+zHsN/RZrRydB7mDAreSqsWbQ6FOi8dCKxjj8myWrKDj39BmDy0j14Ie7
 LV00ndHeMVV1KLKYV8leEJ+SKzKaYItGZZCvjtfb/6rOcL4KwL31UsdE+l2IKLDfJdM+H87eiR1
 A1QUUXCPVGE4/AgVD4XQU7gXqqLxcFHiqyoWHxlTTGGBsws8KbAwH+OU720/Hm9ImMlXpPxmFhu
 Qe1zTEjxJy6yb3XByWw==
X-Proofpoint-GUID: nhGtOWHH5rQUEHg3g23O2uiU3_ahvQ-H
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fd065b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=pGLkceISAAAA:8
 a=czZHwOyEVCbUn-AFlY8A:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: nhGtOWHH5rQUEHg3g23O2uiU3_ahvQ-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070219
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

On Thu, May 7, 2026 at 5:46=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed, 06 May 2026 14:16:27 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>
> > The following race can currently happen:
> >
> > | Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem_o=
bject_release` |
> > | -                                            | -                     =
               |
> > | move obj1 with refcount=3D=3D0 to `still_in_lru` |                   =
                   |
> > | move obj2 with refcount!=3D0 to `still_in_lru` |                     =
                 |
> > | mutex_unlock                                 |                       =
               |
> > | shrink obj2                                  |                       =
               |
> > |                                              | lru =3D obj1->lru; // =
`still_in_lru`   |
> > | mutex_lock                                   |                       =
               |
> > | move obj1 back to the original lru           |                       =
               |
> > | mutex_unlock                                 |                       =
               |
> > | return                                       |                       =
               |
> > |                                              | dereference `still_in_=
lru`           |
> >
> > Move the drm_gem_lru_move_tail_locked() after the
> > kref_get_unless_zero() check so that we don't end up with a
> > vanishing LRU when we hit drm_gem_object_release(). We also need to
> > remove the skipped object from its LRU, otherwise we'll keep hitting
> > it on subsequent loop iterations until it's actually removed from the
> > list in the drm_gem_release().
> >
> > Fixes: e7c2af13f811 ("drm/gem: Add LRU/shrinker helper")
> > Reported-by: Chia-I Wu <olvaffe@gmail.com>
> > Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_gem.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index fca42949eb2b..97cf63de0112 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1660,15 +1660,19 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
> >               if (!obj)
> >                       break;
> >
> > -             drm_gem_lru_move_tail_locked(&still_in_lru, obj);
> > -
> >               /*
> >                * If it's in the process of being freed, gem_object->fre=
e()
> > -              * may be blocked on lock waiting to remove it.  So just
> > -              * skip it.
> > +              * may be blocked on lock waiting to remove it.  So just =
remove
> > +              * it from its current LRU and skip it.
> >                */
> > -             if (!kref_get_unless_zero(&obj->refcount))
> > +             if (!kref_get_unless_zero(&obj->refcount)) {
> > +                     if (obj->lru)
> > +                             drm_gem_lru_remove_locked(obj);
> > +
>
> Actually, this thing is still racy, because obj->lru is dereferenced
> without the lru->lock held in drm_gem_object_release(). At this point
> I'm wondering if we should expose a drm_gem_lru_remove() taking the LRU
> lock as an argument as suggested by Steve, and delegate the
> responsibility to call drm_gem_lru_remove() to the driver. Either that,
> or we make it so the LRU lock is attached to the drm_device instead of
> the GEM (both MSM and panthor assume a device-wide lock for LRU
> manipulation).
>
> Rob, what's your take on this matter?

I don't think there is a race, because of the kref_get_unless_zero().
Other than lru_scan, there shouldn't be cases where someone is moving
an obj between LRUs racing with drm_gem_object_release(), because that
means they don't own a reference on the obj they are manipulating.

That said, I can't really think of a sensible thing to do with more
than a single LRU lock per device.  And it does make things easier to
reason about.

BR,
-R
