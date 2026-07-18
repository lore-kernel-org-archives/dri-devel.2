Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184F2C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 05:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B78D10E537;
	Sat, 18 Jul 2026 05:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TuAMKhqI";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A3C10E537
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 05:58:06 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-80dc4a68e4aso69279837b3.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 22:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784354285; cv=none;
 d=google.com; s=arc-20260327;
 b=dbItJ7qtxkoxB75Pe66WREiSRUpeV+SNOGa98jRN+tRnQNy27W2HSzmk7UOvksFKUe
 xffcgJkiBdg7TKhZ0ZaotqnZDdIcxZX3xLxj6zWlvQ9UiiMC9ucqhtLejNM/2gkGSY+X
 Oww/4JbDmHlI4q8p+NRYVqXrlQFuy3/oUwJm2I8jyli6Ag5PVl22WrbRntlTItX9iT0W
 M2Z4+dBr8Q50LKynmZ75wuKIlVQd2w9/gCaNGUn0gfEFiQqx4rmU/iAdaBh221pyk825
 3i7K6krVrXPLiiZoD3IgdLdXnSPv4lN1CynDjam7WjWB2D4QzWeASa5aQ5ZNF096qRll
 D/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4fTSbd1hQzwSiKsFWedqRNWkzxWybiWf8eD0dZAiX2c=;
 fh=OF4/T1bLG0usyy/6DD2sZEshjeB8g6PCQ2PEgMkcTfI=;
 b=foS6eOzzNZ6B3JF2wQyfWb19HVo+tEx7HfcNKkS9yhKKIOmxBKcCXjo87HJXVchOj8
 Yx6CRqYE44BnHh0XZGXy/UhEZNoDckHegjOCxPOAkXUshy05HeTJ4vJ2Fi6j5DHyVSvR
 ZLT+FSL6g0t6z9fgpu3cP5m4PFewMt9mE96PpyrblpnmokDxzThS2xIDKFiQVcYs3P6F
 DLpJTvlkoIiCiHi645CST98hLlQeWyu+Zht0MrBVAb+cFRG8jm3Zdc/GvBH10R7QhG4x
 AezPLUuJKAU5uxUshhHmGw5InDHmmet+8Yg8KANZCSZ0ni7nlyTeSTWu1/ZkNfNq+dSs
 77xA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784354285; x=1784959085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4fTSbd1hQzwSiKsFWedqRNWkzxWybiWf8eD0dZAiX2c=;
 b=TuAMKhqIeqCmy03U4jzvAO5xxq4xrsrbg7/6SgYBYKmo0fCl+QzNIwC/T++w+vH0km
 voNOZG0mtIF3/EWXMArF/i+f2Lyw2sot9kiOwOBm0a50uSVfdWntCh4Q+2l+OQhmC0Qj
 n+TCv5abT2PqAyOo3Tpyj4T7k3oZO+VoY5Ytu1koZ8b4zOO/tTdA9jCD0A/GbZyPvjLx
 KGlAAZ0i1ju+4CHPCpp48SWm4TeOBTyeY/uC1hmWMES5zv9w2QG4mM3A1ogBgT3uHy6F
 8tVKlVbl/eZ6hY87pKHGRMAABEnQaNHpYTwtRNHKzp7kmNNI6IrTu7q//wGMsHhSg7zD
 08cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784354285; x=1784959085;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4fTSbd1hQzwSiKsFWedqRNWkzxWybiWf8eD0dZAiX2c=;
 b=HXCMwDmMyRBi5eX4sLVR5uT18qMu0zDs1atsyp06icSIs8FbrW5uSr7UedJbbbsm7U
 qrdbwxhLp9ZviR4GdfgMkjRsaLkfLTLyUYxuqaov4s8hHhbiY9APad7Xzut7vEB2Mdin
 h1PjHNfg0VyqHGS4iYtsRf49abPsvbq8iikrrI7/zHkamj7Yt2Lxtom7ASij4LjLv+sB
 wHyhH3vJf8M+c39hpy3O8VZ1xxZshNoPglJPeyjVwzbBJOqvaJ6uEhKgpkjfOD7UVTzP
 b5bU3gWsTRb21xDEa3bvYBEsdzSOVTwA1jQSMvyzLPXqM61p50HbKirJfgOqA/hHBfvI
 MOFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpHt2jTbLF+Ms4p73iVQL+4LK9vMhlsFoKceape2i9C4ro3123G0m4Fdn7Ql32tgQXAaRDXEh1Ruw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWx3x7VnI3nHEV15wpKht3Ta+Z+gAG9FFEmVth0e4m8eYWgB5x
 43LzVzSt0Lor1kFcbjHYJeS7jX0OfekxwHZ52LFb+0/A4CoxYKuNVARwjCGc79zQGcs34TQ7ngt
 xaO+LRUtg3gbDfdeUDCT6qVhbxzoCAE0=
X-Gm-Gg: AfdE7cl29jBywQjtSHysuy9Ad0AnTnuzKjUXwzTWxxWf9zH/+UdIjIYXGfLbWWmNLEG
 5ZzcF2F++B4CdXFJU5jtBIu+4+ZSh6BaKbJ5/f67oWYkE1n3i20IR8x9LuxCqM9dQzE8zKgVaCx
 3w79b7ToOnhO4FCrPEl2A3Aow80Wg8tbAdJ7FWPrhNNeldaNLvYMP94mwnHm/4Jgwh7IxKysW/z
 isD1e1ZSwtYrt54T4XgULMwk3zHUrhhr/QiJ6Fko8mC4vswsMq4AH0AIRGskU7/
X-Received: by 2002:a05:690c:c4cd:b0:81d:2537:1e76 with SMTP id
 00721157ae682-81ef2662199mr20418937b3.53.1784354285107; Fri, 17 Jul 2026
 22:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260713160630.1362131-1-lgs201920130244@gmail.com>
 <9e5ff763-b51c-4161-b56d-8e3575daea77@igalia.com>
In-Reply-To: <9e5ff763-b51c-4161-b56d-8e3575daea77@igalia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 18 Jul 2026 13:57:53 +0800
X-Gm-Features: AUfX_mwlejmZV2urG6HirUinPfQVMz1V0GQFM2BeydczlyOcQ51A78CCtszAK5c
Message-ID: <CANUHTR-i9UvFgR68SQ9qR_KKD8o3PsJZianH873NUa4DhW-Yiw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/v3d: release CPU job resources on pre-init failures
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org, 
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

Hi Ma=C3=ADra,

On Wed, 15 Jul 2026 at 21:37, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> Hi Guangshuo,
>
> On 13/07/26 13:05, Guangshuo Li wrote:
> > The changes referenced by the Fixes tags moved CPU job resource cleanup
> > to v3d_cpu_job_free(), the CPU job kref destructor.
> >
> > However, CPU job extensions are parsed before v3d_job_init() has
> > successfully installed that destructor. Timestamp and performance query
> > arrays, their syncobj references, and the indirect CSD GEM reference ca=
n
> > therefore be acquired before the CPU job is managed by the kref cleanup
> > path.
> >
> > If a later pre-init validation fails, or if v3d_job_init() itself fails=
,
> > the CPU job can be cleaned up or deallocated without running
> > v3d_cpu_job_free(). Those extension resources are then leaked.
> >
> > Move the CPU-job-owned resource release into a helper and call it both
> > from the normal CPU job destructor and from the pre-init error paths.
> >
> > Fixes: b0fe80c0b925 ("drm/v3d: Fix use-after-free of CPU job query arra=
ys on error path")
> > Fixes: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CP=
U job free")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v2:
> >    - Rebase onto drm-misc-fixes.
> >    - Fold the indirect CSD GEM pre-init failure fix into this patch.
> >    - Drop unnecessary pointer and count resets after releasing resource=
s,
> >      as suggested by Ma=C3=ADra Canal.
> >
> >   drivers/gpu/drm/v3d/v3d_submit.c | 17 +++++++++++++----
> >   1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d=
_submit.c
> > index 7682b24f13ec..2b1dc92d4709 100644
> > --- a/drivers/gpu/drm/v3d/v3d_submit.c
> > +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> > @@ -127,11 +127,8 @@ v3d_render_job_free(struct kref *ref)
> >   }
> >
> >   static void
> > -v3d_cpu_job_free(struct kref *ref)
> > +v3d_cpu_job_free_resources(struct v3d_cpu_job *job)
> >   {
> > -     struct v3d_cpu_job *job =3D container_of(ref, struct v3d_cpu_job,
> > -                                            base.refcount);
> > -
> >       v3d_timestamp_query_info_free(&job->timestamp_query,
> >                                     job->timestamp_query.count);
> >
> > @@ -140,7 +137,15 @@ v3d_cpu_job_free(struct kref *ref)
> >
> >       if (job->indirect_csd.indirect)
> >               drm_gem_object_put(job->indirect_csd.indirect);
> > +}
> > +
> > +static void
> > +v3d_cpu_job_free(struct kref *ref)
> > +{
> > +     struct v3d_cpu_job *job =3D container_of(ref, struct v3d_cpu_job,
> > +                                            base.refcount);
> >
> > +     v3d_cpu_job_free_resources(job);
> >       v3d_job_free(ref);
> >   }
> >
> > @@ -1313,6 +1318,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void=
 *data,
> >               ret =3D v3d_get_extensions(file_priv, args->extensions, &=
se, cpu_job);
> >               if (ret) {
> >                       drm_dbg(dev, "Failed to get extensions.\n");
> > +                     v3d_cpu_job_free_resources(cpu_job);
>
> You shouldn't call v3d_cpu_job_free_resources() if v3d_get_extensions()
> failed, as it handles the cleaning path internally.
>
> Best regards,
> - Ma=C3=ADra

Thank you for the review. You are right that v3d_get_extensions() already
handles the cleanup internally. I will remove the extra
v3d_cpu_job_free_resources() call and send a v3.

Best regards,
Guangshuo
