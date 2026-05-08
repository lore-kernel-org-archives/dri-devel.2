Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDAECD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C39F10E5DF;
	Fri,  8 May 2026 13:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfuhB0fA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/N4AyB3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA6D10E5DF
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:49:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648D40sj1062036
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 13:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=zRan7H5xQtbdOyipQRzsY4GuveNwNe4KOpnPprVLo7s=; b=df
 uhB0fAMttga3/lzBF4XcE9AIBmSRC5wMY3EKATQKM+Ywnf83zMpTFjqP6rfnBhST
 G/FDwh5DGWOBwM2UyUwGOo7I3jvSM5V+VV049tITy8jNv3Jnd6gzgPQdP0EaGRvi
 IDBrQrSkQvtoXrLq+iB5UlYfkwsoU3pniErzmOT1oIFHS6rAAdJpYTRQmo6neX91
 ofSZ/W3DkD9c5JBV1Q6D/dr1FnfYfBnlVeOLH8Cn0n/8+3pwdKN9S5vN0k7xeHXx
 EHtT4GLH0XgVQVKvK44eNqGF3bsmuVxr+d0Xi6W3cUii1bWRnEWlPmE1ZCir7zSh
 LO2dIqOLlHySqpcEatZg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1b3fhjbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 13:49:56 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-467e8ec004dso2611678b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 06:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778248195; cv=none;
 d=google.com; s=arc-20240605;
 b=g/Np8O1vGBD8gwr7rP2a/Xc3FmNBevbZkNxOhxe/lssFAoHKFWHoFlbluBLP0DJA2d
 IRiSHI15g1gHQIkOXaOcyxK7qfXD9Pwz8sZ0/WIfbQ4Op2ATZvEsL5CiGCSJIhb2/Jkm
 e3dJ8TsnpZIVMk3/dVd+1UMxjbeZm08smwZ4RafWM9DOavIktyWUZ29gLOIp9rAgVv9V
 iKmV1M1v/qrL2Qtey2GWw7Q7PTfXUBdM6DukecWs8QPB/sG3nFerIbHO86qCc5KoY+zi
 aJ7OXe7BXsuANeo/uZMuQruCfJkwnIhWuQpdJF0Hwm+j0dV/UpNHbgWfvOAP7xkRBZ6n
 FUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=zRan7H5xQtbdOyipQRzsY4GuveNwNe4KOpnPprVLo7s=;
 fh=x+x9x2z50UbntCKD15bNmxQTUL94rL31e1c9XlI1cDY=;
 b=kAD9GoAdCn8HR0wei8VIcpuuEZPh23/zIyheLCWNG7lFKZ2szviQIzhOU6C5AIDs3d
 sxnyOQEbaDKwA4SI/e+IHGCZkW0W37w5+7JqXaqmfGTGmcVtyL1IC6SWpYR5nldYbRBs
 jnlfmTEs06YDgGD+7m9MFE+qm6OBMVPcaG4+chqr8Jn91fWV2nVtLSyFh+ITkCkvrx2S
 vOdlB3FlqXbd9t3zPN5YqvvnS88vUllbDwlbbM4JxGCedqNTdVEtGxegY49igW6kouO0
 u27jsn5WIz174lTMjW0jk3uLAkG72tDwQu+WP0LXC4+0aoQFompjF7QbgwCZgy/9Kx8f
 PGvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778248195; x=1778852995;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zRan7H5xQtbdOyipQRzsY4GuveNwNe4KOpnPprVLo7s=;
 b=A/N4AyB3Vm3ivaADfKrW/9X5LSDmx2xbZQwaPEmBL1A8cQxSGSJVwRqFbzVILU3XDl
 K6Y0hyhMUZvJbiP5oLrpGOzUhqNV1BNw0dqwLxModF3oN3M/N9SN9DSKX16EjtHeidFx
 AZ3k15fHc0zcW8tFPguWt5pi4R06v0EWyDs4PewRgMdY/FJ4NZblq6iwJlwtl+cxd7aI
 FR7MhaYejH+rljYfJzOVS8cXK8fgRPNNmxlAMfMjP9XBBgDmR/7hqD9fZ/MNTnPiRT18
 isQnHWDRxKttrFzqli5cMTgqC4ShW1lzXXlOABldJLLxXUgQ2ZncF1U9H81/Sdos4YV6
 INCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778248195; x=1778852995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zRan7H5xQtbdOyipQRzsY4GuveNwNe4KOpnPprVLo7s=;
 b=i2PxIumhO5bH/DyHCrO5D4/zvfSzK3uGWq6+1EHDzw/l6ueuUKADcqEX/p8Af1uXL3
 pKeQ/REdXlcvAt3UBN1pWCvY7crQWYdSi42+HSfj7sAvr5ELmKAFKOsShhdAzV5ZidMg
 ao+kxxG09SLZof9pRIM+ICF1/ciW5ayd61QFwnfUi7YZQXmoJWK5ZOn2hofKQq3y6Zt3
 UfLu8SU0v1gqXu1ISpYTjFx3kDstD+CFvE5UhNbtG2bfnIGQ2wOZ7FtL8FNHh9vaKDXO
 lsGjuwc6/OLRi3achEHD6VzE6SMQFsb7vV5mooU7pxIFIQxwr+8MLETGIj+I95LrTJTe
 N3pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+okolbWNtx0SAzLZT0/cebd/SQnCkug/kGNi+Esxhr92Xtt59o9WbsTASEZfeCE1ot33YdaHV98rY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZcZrCoi1/+fGS5FVzzAgTzFLX0B/4Z9MBc9ldO5koqIJjSEak
 ACQ9R0lq92H2n5Z4WL/PxLIc1sG839ILcwHgBR2kppfOSzz3sc/2JwKxJzxzREhy1JYPA5lW8K3
 JmcUHKwdlJ5PEqP8yLK3Mz6M2cJpnWPIeVp7vgI6t+WmlbOg7RIF1g/W+FXtKAjaIjthcPERr30
 8emw4ba1K6cQnaNnyFqkE52zso1EDalIxCT5J4DYki35bC0A==
X-Gm-Gg: AeBDietpOjSi8Vj1+nIvsQiMxLAZ5aPzLUBCbZAM2Cybf6dIOpTgu7eiY7p3xAJ+1WE
 YP2wn7N/Y9c9Oig7OYVWvwTy6/yDM50nKOWz3Jgy/ThyaeHDbqP4TwNglWCQsPZQ7y22r0Mh1yo
 VA3JFRBr9IKU1lusOYk/GvQOse/U9yb9auU+iNVWcyTyji15ElosvabBfurItRm8xaXRiFtiIiR
 UbpQH3ZuOgzaonzp6CMBSzT8jTosDBEEyN8rA==
X-Received: by 2002:a05:6808:1717:b0:47c:3793:c589 with SMTP id
 5614622812f47-4804249a98cmr7370870b6e.26.1778248195344; 
 Fri, 08 May 2026 06:49:55 -0700 (PDT)
X-Received: by 2002:a05:6808:1717:b0:47c:3793:c589 with SMTP id
 5614622812f47-4804249a98cmr7370830b6e.26.1778248194806; Fri, 08 May 2026
 06:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
 <20260507144639.68bd699f@fedora>
 <CACSVV01zGLN8FV3Fpw1BnW+zSokE7n2XJ2dBmDw8-n=MXBmDnw@mail.gmail.com>
 <20260508104107.055223e5@fedora>
In-Reply-To: <20260508104107.055223e5@fedora>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 8 May 2026 06:49:43 -0700
X-Gm-Features: AVHnY4Ik2X6E8TO3p7rvOwpC3pbJfU5jLPapHjI6e4e12QW7f5c0IkRLuB7h6cA
Message-ID: <CACSVV03MYBb5h3cm2qrxp8vGWdSfdkFvUs4ekqhhuCFZKvv=VQ@mail.gmail.com>
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
X-Proofpoint-GUID: 4SUuFoLQEOkkiQy3a2egqnDAKQXC37EG
X-Authority-Analysis: v=2.4 cv=YMOvDxGx c=1 sm=1 tr=0 ts=69fdea04 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=bfSRTEewp7xfJmCQdakA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: 4SUuFoLQEOkkiQy3a2egqnDAKQXC37EG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0MSBTYWx0ZWRfX+HxFWbtgj+R5
 CbyfAeyVA+D3aOAY7vC5Y+N7bJHk+QCiMk/Q0H51Xlod+JGFiFzBB1RMEfR6i0A8ho+Mnjvd8AS
 RLGCLEoVZoeqtMiA7uluCpfAs+d+lfZp9tD1ETkCAGdgpH9Lxecf/M6SJFNLVcwU9GBwBkDOsvQ
 SaFh2FmViS9hkgtNag/apP9ssqte48YMPZ3I7ikSmKEQJPyV55jHdhrkbR4RJ3x4wdO9gVfTJJH
 thO6pEOm0MzrZxqXZ5D5za8Cfsi6/HBkN99vrC8d3HQZKyisFU4yROBHq/k33L8oxqZBUxttUz0
 K1QUIR44X8ISYeeoAyZh9Qa4z2semxIwTQKMRPpR3bOk0+jAynaprA2cTYkk5/3B/aYjsR2ejCd
 2NBUcxGEJ/7hY3zThIyqeXFOrLdoqGh47kjAsnXFd/skaEMdxDAX4bQUcQ14gk8luqIpowg5kBO
 G0GBVonFjwQ8Ut1BhBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080141
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

On Fri, May 8, 2026 at 1:41=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 7 May 2026 14:38:23 -0700
> Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> > On Thu, May 7, 2026 at 5:46=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > On Wed, 06 May 2026 14:16:27 +0200
> > > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > >
> > > > The following race can currently happen:
> > > >
> > > > | Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_g=
em_object_release` |
> > > > | -                                            | -                 =
                   |
> > > > | move obj1 with refcount=3D=3D0 to `still_in_lru` |               =
                       |
> > > > | move obj2 with refcount!=3D0 to `still_in_lru` |                 =
                     |
> > > > | mutex_unlock                                 |                   =
                   |
> > > > | shrink obj2                                  |                   =
                   |
> > > > |                                              | lru =3D obj1->lru;=
 // `still_in_lru`   |
> > > > | mutex_lock                                   |                   =
                   |
> > > > | move obj1 back to the original lru           |                   =
                   |
> > > > | mutex_unlock                                 |                   =
                   |
> > > > | return                                       |                   =
                   |
> > > > |                                              | dereference `still=
_in_lru`           |
> > > >
> > > > Move the drm_gem_lru_move_tail_locked() after the
> > > > kref_get_unless_zero() check so that we don't end up with a
> > > > vanishing LRU when we hit drm_gem_object_release(). We also need to
> > > > remove the skipped object from its LRU, otherwise we'll keep hittin=
g
> > > > it on subsequent loop iterations until it's actually removed from t=
he
> > > > list in the drm_gem_release().
> > > >
> > > > Fixes: e7c2af13f811 ("drm/gem: Add LRU/shrinker helper")
> > > > Reported-by: Chia-I Wu <olvaffe@gmail.com>
> > > > Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/=
86
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_gem.c | 14 +++++++++-----
> > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > > > index fca42949eb2b..97cf63de0112 100644
> > > > --- a/drivers/gpu/drm/drm_gem.c
> > > > +++ b/drivers/gpu/drm/drm_gem.c
> > > > @@ -1660,15 +1660,19 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
> > > >               if (!obj)
> > > >                       break;
> > > >
> > > > -             drm_gem_lru_move_tail_locked(&still_in_lru, obj);
> > > > -
> > > >               /*
> > > >                * If it's in the process of being freed, gem_object-=
>free()
> > > > -              * may be blocked on lock waiting to remove it.  So j=
ust
> > > > -              * skip it.
> > > > +              * may be blocked on lock waiting to remove it.  So j=
ust remove
> > > > +              * it from its current LRU and skip it.
> > > >                */
> > > > -             if (!kref_get_unless_zero(&obj->refcount))
> > > > +             if (!kref_get_unless_zero(&obj->refcount)) {
> > > > +                     if (obj->lru)
> > > > +                             drm_gem_lru_remove_locked(obj);
> > > > +
> > >
> > > Actually, this thing is still racy, because obj->lru is dereferenced
> > > without the lru->lock held in drm_gem_object_release(). At this point
> > > I'm wondering if we should expose a drm_gem_lru_remove() taking the L=
RU
> > > lock as an argument as suggested by Steve, and delegate the
> > > responsibility to call drm_gem_lru_remove() to the driver. Either tha=
t,
> > > or we make it so the LRU lock is attached to the drm_device instead o=
f
> > > the GEM (both MSM and panthor assume a device-wide lock for LRU
> > > manipulation).
> > >
> > > Rob, what's your take on this matter?
> >
> > I don't think there is a race, because of the kref_get_unless_zero().
> > Other than lru_scan, there shouldn't be cases where someone is moving
> > an obj between LRUs racing with drm_gem_object_release(), because that
> > means they don't own a reference on the obj they are manipulating.
>
> Yeah, but the race I'm talking about is drm_gem_object_release()
> vs drm_gem_lru_scan(), so at this point refcount is zero, and this
> patch only moves the needle, but doesn't fix the problem entirely:
>
>
> | Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem_obj=
ect_release` |
> | -                                            | -                       =
             |
> |                                              | drm_gem_lru_remove()    =
             |
> |                                              |    lru =3D obj->lru     =
               |
> |                                              |    if (!lru) return;    =
             |
> | lock(still_in_lru.lock)                      |                         =
             |
> |    if (refcount =3D=3D 0)                        |                     =
                 |
> |       drm_gem_lru_remove_locked(obj)         |                         =
             |
> |         obj->lru =3D NULL                      |                       =
               |
> |    .....                                     |                         =
             |
> | unlock(still_in_lru.lock)                    |                         =
             |
> |                                              |    lock(lru->lock)      =
             |
> |                                              |       drm_gem_lru_remove=
_locked(obj) |
> |                                              |         obj->lru=3D=3DNU=
LL =3D> NULL deref |
> |                                              |    unlock(lru->lock)    =
             |
>
> We can of course add an extra
>
>         if (!obj->lru) return;
>
> in drm_gem_lru_remove_locked() to cover for this race, and add a
> READ_ONCE in drm_gem_lru_remove() to make sure the compiler doesn't
> do crazy things like dereferencing obj->lru twice instead of having
> the LRU pointer stored in a register. That still assumes that the lru
> we assigned to our local variable is valid even after the
> drm_gem_lru_remove_locked(obj) call, which is true at least for MSM and
> and panthor because they have their LRUs attached to the drm_device,
> which outlives any GEMs attached to it. But it's not something the API
> enforce or document as a requirement.

Ahh, right.. yeah drm_gem_lru_remove() should READ_ONCE(), and check
obj->lru after acquiring the lock.

And yeah, that is assuming there aren't lifetime issues with the lock itsel=
f

> >
> > That said, I can't really think of a sensible thing to do with more
> > than a single LRU lock per device.  And it does make things easier to
> > reason about.
>
> Okay, I'll give it a try then.

sounds good

BR,
-R
