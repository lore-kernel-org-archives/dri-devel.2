Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BDDCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B4310FED5;
	Fri,  9 Oct 2026 07:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kvroz54Q";
	dkim-atps=neutral
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11DE10FECE
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:04:15 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-6b1afdf5196so1388240eaf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 00:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529455; cv=none;
 d=google.com; s=arc-20260327;
 b=eeivmAp/gqCy18jYTBNzugAWsxMSEW7u7Wodu2U/DDPemvswi923g4KlOQ40ejE5uM
 2UNnRoQSkbHLwlpgQ3sUEQvht19T1r0J9zjxOUjs6eUkD1Q1r4wvLrICg1fXuCLCrrIl
 e41n1cQ/VHCWpmADfQo6LPa+jFg9ZxTzVtIXgcULRvN8R1m1lixDvV/I/EREF3pp4e1U
 xHhD+ZgPuyAkip/iT+e7cLoDZQD4/shJoGOcdct/FRjmyEjqTuCpfcTX/PbPkMKnka5O
 nXAtbqR7hdBI1eyodi9GGhUsK/KfLUUipYOzpIlhQoNZz0G83d87d1GTLKtgknbuD/G8
 NCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EwBvxaKSezPcmRHXV7EoTDUsrgLVXKX7pSoghw0IZJM=;
 fh=bXuvn0t5pgLUUPK62ZCb7CMZ01ZsP+QdgHpJ0SVyzcs=;
 b=BEbuybUyvAmICHNo8Kt+6mEUbiEYfd/7M4My97gP/SN3OQR7hDgas/gI7WQanS2IMP
 a/jaz8LgzMcawaFHHSwQSJAAivutJPfMoSrMk92VztifU1CXNtTTnfT4dNCrrN6dRtyl
 HXkYUALTIIHcgJxd1N+oa+VnI7u3N9OIdu9q7cI4L3fRcR5s2TveD4KjF23ub56eF/LB
 6O50X4lO5WbBTu9cK4JRHu+Bb0mGO9ddlZHiLKd/SDwznbRCNcfKAd/9cSqrRMZP+V3h
 BRd6TeI0+MK+og4TAzORW4PyNW7/7WJsC2a9ye0SiFXUOaSPuIE7iZBUX+3nZcLXtA+W
 SUxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791529455; x=1792134255; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EwBvxaKSezPcmRHXV7EoTDUsrgLVXKX7pSoghw0IZJM=;
 b=Kvroz54Qt4iOd44AGu3eNNPU0tGBAgiv44D83OInuq8QBD5zOuUHm2bnA7rJqAKW52
 TmPiYbFoBaJF2zmEHeN5XmGYnDL4xwpiecHTZUrmNGNU1daD8Aed2bGc/AnJx8K339Fg
 XEuCzSKO+quW4jsAJ1KqO2EhdqPpWsp/FmVwfCuZUfTXL8yQV8e26gyIxgN6l7aelqP5
 yPXkGDPXYdk7EXfqkx/lCh+TjK3NsCcPvKwm02Ct3rh0G9opu8+7se35/ZD3mNyG/zgA
 /gOYZUP2l4n8zJNn7srlu4s15FjLmKCpZY2x5+Teuj89N6ia7C4OTVnkttTg431ZUSUy
 k51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529455; x=1792134255;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EwBvxaKSezPcmRHXV7EoTDUsrgLVXKX7pSoghw0IZJM=;
 b=OynUnEDEm7W8pHPIi8JAtsMZT4de8wGbYDseDHXVx2NGDCsoMW28g4dg8a4ZAGaLHH
 aya8AnDUD2IY2TNJtJAvh0onYumXfODYGul/ErShFDm+SdN/tZvLOuvad3SqL2dCLitl
 g37/VUyrJgf2EzaykL/+6aMjaJLSfoJS3SuH+NXX15M43DH3Oa7ygRQpmyJpCd8W+ANL
 zrpjJDR9O/g7J7uujuFrx/1H8QCqSrEoPBESYlJO7eIveI1jOHZtw75TQNXZ0E8apRpP
 ynmonWZYuSQRMAavKtx6z5CeXiPgsZeVjAvXa/4x/sJ+9oJWd5tRY7Cppu3I+xgKtlIs
 d8hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxB7utsx0xVjuLvhO0s6iw2GKnfcggXM2gabqMOr3H1xVssWmEgybz5Vf0nLsdmY1HjJJdmiS///us=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDCm0H/XqlsA9JuNdgHry9P8KDNWXddysg0bX1zVx34yvvQi7B
 dEn0pooSBq/RFU3p6Iz/v/ho9uG2cUL6No/Scn6G0S7Y5aP0Caoa93IPMye2Oxs0efQawKFAZGD
 kY//eWnrU9zTHpqk+RqdzJjcWc+EuvAU=
X-Gm-Gg: AYBFou3aHdKPf50B8b5pbd/lYjUWtIPAZcszf172SEMi7KcojoDQzI8Po76i+xGV47E
 XtNJdDr7DPwFXYRLNPOyu/Kg7uMEBzW2/oZ1YJTbTN8Sr8MSCrCC8NsjAQxLcGze48CKk6nYlBb
 Z7TeOGuG7xhmw+Gw2vbQfkQYpgNiUjuTYqVyS3wi7JIHxPNd/e5mIIIC1Xm9q2yKiMKmLyl1GJK
 3FDxFEiIeLrzxAb+5WHgv5Mpsa3KgLlnHxqjj1CdkzwdAcnmAxlqJqDAxUJGtwaYzaDiWkEKfJZ
 JqpG9VwrgDydCx5fxl/GE8eCst2G4wZwj/Kz/WZmwzFrxXJLjphd8aHe
X-Received: by 2002:a05:6820:618:b0:6e1:817e:e348 with SMTP id
 006d021491bc7-6ef0ead8a70mr755983eaf.36.1791529454847; Fri, 09 Oct 2026
 00:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261003093837.545278-1-yaojiale02@163.com>
In-Reply-To: <20261003093837.545278-1-yaojiale02@163.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Fri, 9 Oct 2026 15:04:03 +0800
X-Gm-Features: AclHuK89n94QP4eXCNQI20RI3FhQZ5iF1cD68FNJB3GcRZKG4SgaqZ70DtaTsAM
Message-ID: <CAKGbVbsK-mxJskJGYG5b2B7NOcAw3fRyJqAjX6Zf+AdH__1f5g@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Drain fence callbacks before destroying slab
To: Jiale Yao <yaojiale02@163.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Eric Anholt <eric@anholt.net>, Heiko Stuebner <heiko@sntech.de>,
 Andreas Baierl <ichgeh@imkreisrum.de>, 
 Simon Shields <simon@lineageos.org>, Erico Nunes <nunes.erico@gmail.com>, 
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Sat, Oct 3, 2026 at 5:39=E2=80=AFPM Jiale Yao <yaojiale02@163.com> wrote=
:
>
> lima_fence_release() defers freeing fences from lima_fence_slab to an
> RCU callback. The last lima_sched_slab_fini() can destroy the slab and
> clear its pointer while a release callback is still queued. Module remova=
l
> can also free lima_fence_release_rcu() before that callback runs.
>
> Drain outstanding callbacks before destroying the last fence slab.
>
> Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index 9a1e6b9ecbe5..9c5ff1929d3e 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -44,6 +44,7 @@ int lima_sched_slab_init(void)
>  void lima_sched_slab_fini(void)
>  {
>         if (!--lima_fence_slab_refcnt) {
> +               rcu_barrier();
>                 kmem_cache_destroy(lima_fence_slab);
>                 lima_fence_slab =3D NULL;
>         }
> --
> 2.34.1
>
