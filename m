Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF0FCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A16910E6E1;
	Mon, 18 May 2026 07:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBAzpmoi";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2F210E2D5
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 04:07:54 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8c92737a8d3so10606266d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779077273; cv=none;
 d=google.com; s=arc-20240605;
 b=HTMaFatJYiYleJuUYIAU0sm2Gil6FjGRsJU1ej4X6Pn+KCvyZdISUYr4hksZpp4PHx
 hTsPCYT3D/ekF8U0qtGPzqpUoLzMZdTVRr1Ey+PgJj9RwNFSN2wNbonmDd718rRyGaBl
 L1qJA5fglQ8GKfgleIVJJWoyIQcaPFDnxKD8K7nRS9fQEyYnlFldb7KzD5kMhOp1FXlK
 km38+y32yyiQR6thlRYIheclTryfxOmgXldB6Qgk4PjO9ivnK3QxkwHcRVuFyt6JWlvJ
 TZ4PjpnyOSezh9LVPwiUPiWApr6Ux98n9b/0F1CddZhlDChFzlhyiy5RHotaJY1ikUSx
 Fc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/lm9utADhfaJThj5ggR91uhdD8fBhbx0/a865Q9NPYo=;
 fh=BdHDvHBqJkkzzgK3JHIG2temx7JTEONvSdLF0AcJDPk=;
 b=YQfvjlSpv227/IfGZ+kCkNZUTDDD9YGWsVa7oKZ9meOGWqXa91EQQsVY3BapPGKyPz
 8H/sCuiTj4zTSWneqU8KF1lnIJJ951CMeCAH36jjHA4tVihur5k7Uim8Jb8LZpvwR4/q
 zgWGViEmcZyx/leMk/oYkxFHZcGn+RH2sjSySoLUIcAhmltCu7fEeFe5550165uGs/B5
 9AJ+xeqVJQ6wCW++Z0UaQUl6EoHOLxa+4jtIqppEiKzGiWVC73D8nscFgPRLWq08KmPh
 qlWRsXvxPtbg/mbszefUe7rz6esXkDWbS6qOb1mw+kIL80YWe5jtaKnzLZwaZRP0+a+H
 ZS6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779077273; x=1779682073; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/lm9utADhfaJThj5ggR91uhdD8fBhbx0/a865Q9NPYo=;
 b=UBAzpmoiqGptapp71ilGuy28oUNOe7k6Ek6UJt9efkbeiJlFZ3hmHgtmyOxayOoxm4
 R1KW1YO8kVmm/SXvpXlpTrHU4nhovDL3j/cKwF5EnvqNuUY5hmZvACxjdnkXv0CK3gQQ
 0FyyJP6UMkP8WF52aDE8pDfsqZrLo4RqZk8sWq/OMktF2ZVIAMsJoY+bA94wJuXzCDwF
 XuKnW+1E7huqeq3NHhewHH9Fsu/Fwkc7LvbWZO7U0BpFFJkr7fAAkzbeTuN1pvLSk9GV
 0KRyGJIfh7MgP5zCNXlODUMQTpffJ16/VWD49xuIHIZYhPS9vGHFr/xvZPyJarewawIZ
 XmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779077273; x=1779682073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lm9utADhfaJThj5ggR91uhdD8fBhbx0/a865Q9NPYo=;
 b=mwgFGVeGw0j6eJrqB0AXpt6QP3NowntXB/NlIjYo8rn7M70Mbt1D9CB6LP5JdsZZtK
 ihHeJCsBvK7Njn1TF33BYMButvit6o1ymJqXl/I4Ut08TJKBdbxSyQUj6VisO05GSpoG
 xhOHbp6Z/5KyA/0uYlZi0x6B2HsNZfJEqE3KL60k7M2frpnyledXp2QbVPXVOtci36Tu
 JfFIukPfXa0C/h1RjZnsx/9s2ttxA0Ofe7ErBt9oWTH89tyM1l0aTzrnvWRmveaJHwYD
 HaBBnAku95by61+q/WvNk1RchFkUM+B4/4/NFqdtASUZaVCscDi0pTTwfqYfsjXrWxrj
 I7kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rqx725pmwXdyYNnu2pw6dCBLkfCJGZHUpwTczHOLceHrspOqBm1oKocK3cVsTvBaUhIE9CE89/rM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxihTkIbKgfA48PF4du7NTe0GE9EdO4T0yW6dOrowaAlWvnk4Tk
 +24l+zemF+r+/omqdk7fpc8KU0hW/LEiajPK3Gi76wJ0n0rNnTdEX0gxcZxHuKP6eYkSXezeF3Q
 oDxER7cDEcwQglyNrpWUOxFky2WkZQPk=
X-Gm-Gg: Acq92OGmTBl0hbY3oUy0Sh/GXiSfcSoo07nWazc2xZZ1CR9UwORQFXqPCbeG4vVory+
 Om9YfTCY5n4wQF5tXx+4NipUYi72Fm7kG2kcM7wzEYnZuoHna80xixrP5xLphe/4BvR1lF9dJBR
 otNO9Ub3uabmrq3aBXKczi3GEtX6zVsQNcHZcyKfbIfc8utsO/tQPXvr8lv0eSKlDcVS78Aqvqy
 mo9MYIBJPq3udN1zwNi7d0E0lFpnnh5BTVWOqEJ4qAqOC7KJIQkjl5Xa84pOnJvFGGwxi5s5amU
 BfKXWZh3kn0WVD/vLg==
X-Received: by 2002:a05:622a:8584:b0:50d:83d7:686c with SMTP id
 d75a77b69052e-5165a1dbf16mr148505201cf.31.1779077272783; Sun, 17 May 2026
 21:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260501000043.2483678-1-dmitry.osipenko@collabora.com>
 <1efb8795-3345-46ae-8195-1b391159b90b@collabora.com>
In-Reply-To: <1efb8795-3345-46ae-8195-1b391159b90b@collabora.com>
From: nagapuri ramesh <ram.nagapuri@gmail.com>
Date: Mon, 18 May 2026 09:37:41 +0530
X-Gm-Features: AVHnY4JQ__xTln0-8RpsIIsZ_gI171EuO2uT6s6JlKttYXLrr9l8I8vfB1X7IxI
Message-ID: <CAOca=FS6G+d-mAkPrNoP3=nSjnE5g1J-G=SKuEGh_-9jG6-J2A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Extend blob UAPI with deferred-mapping
 hinting
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Clark <robdclark@gmail.com>, 
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: multipart/alternative; boundary="000000000000df4e8406520fb42d"
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

--000000000000df4e8406520fb42d
Content-Type: text/plain; charset="UTF-8"

Thank you very much for the support

Thanks & Regards,
Ramesh

On Thu, May 14, 2026, 3:41 AM Dmitry Osipenko <dmitry.osipenko@collabora.com>
wrote:

> On 5/1/26 03:00, Dmitry Osipenko wrote:
> > If userspace never maps GEM object, then BO wastes hostmem space
> > because VirtIO-GPU driver maps VRAM BO at the BO's creating time.
> >
> > Make mappings on-demand by adding new RESOURCE_CREATE_BLOB IOCTL/UAPI
> > hinting flag telling that host mapping should be deferred until first
> > mapping is made when the flag is set by userspace.
> >
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Reviewed-by: Rob Clark <robdclark@gmail.com>
> > ---
> >
> > Changelog:
> >
> > v2: Rebased on recent kernel. Intel i915 native ctx landed to Mesa, lets
> to
> >     proceed with merging the mapping hint as a first user of the feature.
> >
> >  drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  1 +
> >  drivers/gpu/drm/virtio/virtgpu_vram.c  | 30 +++++++++++++++++++++-----
> >  include/uapi/drm/virtgpu_drm.h         |  4 ++++
> >  4 files changed, 32 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h
> b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index f17660a71a3e..6f49213e23f8 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -84,6 +84,7 @@ struct virtio_gpu_object_params {
> >       uint32_t blob_mem;
> >       uint32_t blob_flags;
> >       uint64_t blob_id;
> > +     uint32_t blob_hints;
> >  };
> >
> >  struct virtio_gpu_object {
> > @@ -507,6 +508,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struct
> virtio_gpu_object *bo,
> >  void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir);
> > +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
> >
> >  /* virtgpu_submit.c */
> >  int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index c33c057365f8..01daa72b1310 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -489,6 +489,7 @@ static int verify_blob(struct virtio_gpu_device
> *vgdev,
> >       params->size = rc_blob->size;
> >       params->blob = true;
> >       params->blob_flags = rc_blob->blob_flags;
> > +     params->blob_hints = rc_blob->blob_hints;
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c
> b/drivers/gpu/drm/virtio/virtgpu_vram.c
> > index 084e80227433..4ae3cbc35dd3 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> > @@ -3,6 +3,8 @@
> >
> >  #include <linux/dma-mapping.h>
> >
> > +static DEFINE_MUTEX(map_lock);
> > +
> >  static void virtio_gpu_vram_free(struct drm_gem_object *obj)
> >  {
> >       struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > @@ -42,6 +44,11 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object
> *obj,
> >       if (!(bo->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
> >               return -EINVAL;
> >
> > +     virtio_gpu_vram_map_deferred(vram);
> > +
> > +     if (vram->map_state == STATE_INITIALIZING)
> > +             virtio_gpu_notify(vgdev);
> > +
> >       wait_event(vgdev->resp_wq, vram->map_state != STATE_INITIALIZING);
> >       if (vram->map_state != STATE_OK)
> >               return -EINVAL;
> > @@ -218,14 +225,27 @@ int virtio_gpu_vram_create(struct
> virtio_gpu_device *vgdev,
> >
> >       virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params,
> NULL,
> >                                           0);
> > -     if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
> > -             ret = virtio_gpu_vram_map(&vram->base);
> > -             if (ret) {
> > -                     virtio_gpu_vram_free(obj);
> > -                     return ret;
> > +     if (!(params->blob_hints &
> DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING)) {
> > +             if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
> > +                     ret = virtio_gpu_vram_map(&vram->base);
> > +                     if (ret) {
> > +                             virtio_gpu_vram_free(obj);
> > +                             return ret;
> > +                     }
> >               }
> >       }
> >
> >       *bo_ptr = &vram->base;
> >       return 0;
> >  }
> > +
> > +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
> > +{
> > +     if (!(vram->base.blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
> > +             return;
> > +
> > +     mutex_lock(&map_lock);
> > +     if (!drm_mm_node_allocated(&vram->vram_node))
> > +             virtio_gpu_vram_map(&vram->base);
> > +     mutex_unlock(&map_lock);
> > +}
> > diff --git a/include/uapi/drm/virtgpu_drm.h
> b/include/uapi/drm/virtgpu_drm.h
> > index 9debb320c34b..ba09a4ee3e77 100644
> > --- a/include/uapi/drm/virtgpu_drm.h
> > +++ b/include/uapi/drm/virtgpu_drm.h
> > @@ -200,6 +200,10 @@ struct drm_virtgpu_resource_create_blob {
> >       __u32 cmd_size;
> >       __u64 cmd;
> >       __u64 blob_id;
> > +
> > +#define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
> > +     __u32 blob_hints;
> > +     __u32 pad2;
> >  };
> >
> >  #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
>
> Applied patch to misc-next
>
> --
> Best regards,
> Dmitry
>

--000000000000df4e8406520fb42d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you very much for the support=C2=A0<div dir=3D"auto=
"><br></div><div dir=3D"auto">Thanks=C2=A0&amp; Regards,</div><div dir=3D"a=
uto">Ramesh</div></div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 14, 2026, 3:41 AM Dmitry=
 Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com">dmitry.osipe=
nko@collabora.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 5/1/26 03:00, Dmitry Osipenko wrote:<br>
&gt; If userspace never maps GEM object, then BO wastes hostmem space<br>
&gt; because VirtIO-GPU driver maps VRAM BO at the BO&#39;s creating time.<=
br>
&gt; <br>
&gt; Make mappings on-demand by adding new RESOURCE_CREATE_BLOB IOCTL/UAPI<=
br>
&gt; hinting flag telling that host mapping should be deferred until first<=
br>
&gt; mapping is made when the flag is set by userspace.<br>
&gt; <br>
&gt; Signed-off-by: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@c=
ollabora.com" target=3D"_blank" rel=3D"noreferrer">dmitry.osipenko@collabor=
a.com</a>&gt;<br>
&gt; Reviewed-by: Rob Clark &lt;<a href=3D"mailto:robdclark@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">robdclark@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Changelog:<br>
&gt; <br>
&gt; v2: Rebased on recent kernel. Intel i915 native ctx landed to Mesa, le=
ts to<br>
&gt;=C2=A0 =C2=A0 =C2=A0proceed with merging the mapping hint as a first us=
er of the feature.<br>
&gt; <br>
&gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_drv.h=C2=A0 =C2=A0|=C2=A0 2 ++<br=
>
&gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_ioctl.c |=C2=A0 1 +<br>
&gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_vram.c=C2=A0 | 30 +++++++++++++++=
++++++-----<br>
&gt;=C2=A0 include/uapi/drm/virtgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 4 ++++<br>
&gt;=C2=A0 4 files changed, 32 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/vi=
rtio/virtgpu_drv.h<br>
&gt; index f17660a71a3e..6f49213e23f8 100644<br>
&gt; --- a/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
&gt; +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
&gt; @@ -84,6 +84,7 @@ struct virtio_gpu_object_params {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t blob_mem;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t blob_flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t blob_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t blob_hints;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct virtio_gpu_object {<br>
&gt; @@ -507,6 +508,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struc=
t virtio_gpu_object *bo,<br>
&gt;=C2=A0 void virtio_gpu_vram_unmap_dma_buf(struct device *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sg_table *sgt,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum dma_data_direction di=
r);<br>
&gt; +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram=
);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* virtgpu_submit.c */<br>
&gt;=C2=A0 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *da=
ta,<br>
&gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/=
virtio/virtgpu_ioctl.c<br>
&gt; index c33c057365f8..01daa72b1310 100644<br>
&gt; --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
&gt; +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
&gt; @@ -489,6 +489,7 @@ static int verify_blob(struct virtio_gpu_device *v=
gdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;size =3D rc_blob-&gt;size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;blob =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;blob_flags =3D rc_blob-&gt;blob_f=
lags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0params-&gt;blob_hints =3D rc_blob-&gt;blob_hints;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/v=
irtio/virtgpu_vram.c<br>
&gt; index 084e80227433..4ae3cbc35dd3 100644<br>
&gt; --- a/drivers/gpu/drm/virtio/virtgpu_vram.c<br>
&gt; +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c<br>
&gt; @@ -3,6 +3,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &lt;linux/dma-mapping.h&gt;<br>
&gt;=C2=A0 <br>
&gt; +static DEFINE_MUTEX(map_lock);<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_gpu_vram_free(struct drm_gem_object *obj)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_object *bo =3D gem_to_virt=
io_gpu_obj(obj);<br>
&gt; @@ -42,6 +44,11 @@ static int virtio_gpu_vram_mmap(struct drm_gem_obje=
ct *obj,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(bo-&gt;blob_flags &amp; VIRTGPU_BLOB_F=
LAG_USE_MAPPABLE))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0virtio_gpu_vram_map_deferred(vram);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vram-&gt;map_state =3D=3D STATE_INITIALIZING)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_notify(vgd=
ev);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wait_event(vgdev-&gt;resp_wq, vram-&gt;map_s=
tate !=3D STATE_INITIALIZING);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vram-&gt;map_state !=3D STATE_OK)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt; @@ -218,14 +225,27 @@ int virtio_gpu_vram_create(struct virtio_gpu_dev=
ice *vgdev,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_cmd_resource_create_blob(vgdev, &=
amp;vram-&gt;base, params, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (params-&gt;blob_flags &amp; VIRTGPU_BLOB_FLAG=
_USE_MAPPABLE) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D virtio_gpu_vr=
am_map(&amp;vram-&gt;base);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0virtio_gpu_vram_free(obj);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!(params-&gt;blob_hints &amp; DRM_VIRTGPU_BLO=
B_FLAG_HINT_DEFER_MAPPING)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;blob_f=
lags &amp; VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D virtio_gpu_vram_map(&amp;vram-&gt;base);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_vram_free(obj);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*bo_ptr =3D &amp;vram-&gt;base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!(vram-&gt;base.blob_flags &amp; VIRTGPU_BLOB=
_FLAG_USE_MAPPABLE))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;map_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!drm_mm_node_allocated(&amp;vram-&gt;vram_nod=
e))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_vram_map(&=
amp;vram-&gt;base);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;map_lock);<br>
&gt; +}<br>
&gt; diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu=
_drm.h<br>
&gt; index 9debb320c34b..ba09a4ee3e77 100644<br>
&gt; --- a/include/uapi/drm/virtgpu_drm.h<br>
&gt; +++ b/include/uapi/drm/virtgpu_drm.h<br>
&gt; @@ -200,6 +200,10 @@ struct drm_virtgpu_resource_create_blob {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 cmd_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 cmd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 blob_id;<br>
&gt; +<br>
&gt; +#define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x0001<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 blob_hints;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 pad2;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0001<br>
<br>
Applied patch to misc-next<br>
<br>
-- <br>
Best regards,<br>
Dmitry<br>
</blockquote></div>

--000000000000df4e8406520fb42d--
