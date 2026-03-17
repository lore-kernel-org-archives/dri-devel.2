Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF14FD7075
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E11310E5CB;
	Tue, 17 Mar 2026 10:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vcq0OXS4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A288210E5CB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:58:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 087B640D8E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC83AC19425
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773745098;
 bh=joGJmAWA0eGhDv45V0acMmM+Twim6ySRxLxTwCpiu+k=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=Vcq0OXS4/9IQg2M5dxJl7EE40YHP+sa5Quusaa7NcUXeIZHsy9OU3B4LlPbSzb/6M
 PplQb/wJk+GZHMROhoyDg7CStesC6ChMNojmpUMLNge0i4D8gpPJuA7yKGrz3fMJeL
 3f8Xc8cUUxhO15Zr+mHTCO5taLtU5HpuyO3xWC3TWCtn3JBL8BRx9TNgA2ZdPsO4Y+
 DJqG/hm6TVDsER3nvAurL5CH4vuCx38/Jc1lceL9zthu2GXl/Cd8YTE0TXnqoEOF57
 v/fLmMPUBsHXaKFzkqMMZzurtYi73f5nJdIv9Spv5edj9E/O78m3i0/e62AlQjtnp1
 m9EkVlWM1N8QA==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-38ad12fb595so4784111fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 03:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWs7P28/nrHpytmPbzyopIgm8tuWYYuW+8vJJgQV2BiGlDccTPrqkLF/HLoXLDPf/3NYy7IEZflxQk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyO/Ito3jXFMQJElIsAspekumfNNJUY2b9AwJB7LmGJfXgduoR
 zG04tuEK4rXPF4jhpONsAqNSIqmjgyZ2k1YCDMbj4kv1H6WEhaoc0aMGDshuOUCcEwkFY9QFgOG
 zrtdLKwb0lGUydOCuO49Bu6UDXsVyjc0=
X-Received: by 2002:a05:651c:f04:b0:387:b72:816a with SMTP id
 38308e7fff4ca-38ace817266mr9712241fa.3.1773745097248; Tue, 17 Mar 2026
 03:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260317064049.696795-1-wenst@chromium.org>
 <20260317064049.696795-3-wenst@chromium.org>
 <607daaca-79ed-45b2-941e-1680a17618e8@suse.de>
In-Reply-To: <607daaca-79ed-45b2-941e-1680a17618e8@suse.de>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 17 Mar 2026 18:58:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v66D3=s9c8oJyYEAK90A4SekW6FjLUpWBGRHnJwtfMvUeg@mail.gmail.com>
X-Gm-Features: AaiRm51eS0mRfq2Cbo6u_Rt7Bxck_f3oX14wByjZaXlGaiH47T5oEGbz3iu-Y5Y
Message-ID: <CAGb2v66D3=s9c8oJyYEAK90A4SekW6FjLUpWBGRHnJwtfMvUeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 asahi@lists.linux.dev
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2026 at 4:12=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 17.03.26 um 07:40 schrieb Chen-Yu Tsai:
> > From: Rob Herring <robh@kernel.org>
> >
> > Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
> > drm_mode_create_dumb. This flag is for internal kernel use to indicate
> > if dumb buffer allocation needs a kernel mapping. This is needed only f=
or
> > CMA where creating a kernel mapping or not has to be decided at allocat=
ion
> > time because creating a mapping on demand (with vmap()) is not guarante=
ed
> > to work. Several drivers are using CMA, but not the CMA helpers because
> > they distinguish between kernel and userspace allocations to create a
> > kernel mapping or not.
>
> Any dumb allocation might require vmap. This is not limited to internal
> buffers.  Because if the dumb buffer is shared with another driver, that
> driver might require the vmap for displaying the buffer content. There
> are enough of such drivers.

By sharing, do you mean exported via PRIME then imported by another device?
Or just passing around GEM objects within the kernel?

And could you provide an example?

> > Update the callers of drm_mode_dumb_create() to set
> > drm_mode_dumb_create.flags to appropriate defaults. Currently, flags ca=
n
> > be set to anything by userspace, but is unused within the kernel. Let's
> > force flags to zero (no kernel mapping) for userspace callers by defaul=
t.
> > For in kernel clients, set DRM_MODE_DUMB_KERNEL_MAP by default. Drivers
> > can override this as needed.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > [wenst@chromium.org: Emit warning if args->flags is not zero]
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - Emit warning if args->flags is not zero
> > ---
> >   drivers/gpu/drm/drm_client.c       | 1 +
> >   drivers/gpu/drm/drm_dumb_buffers.c | 4 ++++
> >   include/uapi/drm/drm_mode.h        | 2 ++
> >   3 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.=
c
> > index 46c465bce98c..1a57e7eadc0f 100644
> > --- a/drivers/gpu/drm/drm_client.c
> > +++ b/drivers/gpu/drm/drm_client.c
> > @@ -404,6 +404,7 @@ drm_client_buffer_create_dumb(struct drm_client_dev=
 *client, u32 width, u32 heig
> >       dumb_args.width =3D width;
> >       dumb_args.height =3D height;
> >       dumb_args.bpp =3D drm_format_info_bpp(info, 0);
> > +     dumb_args.flags =3D DRM_MODE_DUMB_KERNEL_MAP;
> >       ret =3D drm_mode_create_dumb(dev, &dumb_args, client->file);
> >       if (ret)
> >               return ERR_PTR(ret);
> > diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_d=
umb_buffers.c
> > index e2b62e5fb891..ccdcc401d4dc 100644
> > --- a/drivers/gpu/drm/drm_dumb_buffers.c
> > +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> > @@ -233,6 +233,10 @@ int drm_mode_create_dumb_ioctl(struct drm_device *=
dev,
> >       struct drm_mode_create_dumb *args =3D data;
> >       int err;
> >
> > +     if (args->flags)
> > +             drm_warn(dev, "drm_mode_create_dumb.flags is not zero.\n"=
);
>
> At most use drm_warn_once() to not let this spam the kernel log.

Sure.

> > +     args->flags =3D 0;
> > +
> >       err =3D drm_mode_create_dumb(dev, args, file_priv);
> >       if (err) {
> >               args->handle =3D 0;
> > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > index 3693d82b5279..7d5f50e4af70 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -1272,6 +1272,8 @@ struct drm_mode_create_dumb {
> >       __u64 size;
> >   };
> >
> > +#define DRM_MODE_DUMB_KERNEL_MAP     (1<<0)  /* For internal kernel us=
e */
> > +
>
> If this is an internal flag, it should not live in the UAPI header.
> include/drm/drm_dumb_buffers.h would be a good place.

Makes sense.


Thanks
ChenYu

> Best regards
> Thomas
>
> >   /* set up for mmap of a dumb scanout buffer */
> >   struct drm_mode_map_dumb {
> >       /** Handle for the object being mapped. */
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>
