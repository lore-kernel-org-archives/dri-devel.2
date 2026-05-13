Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2FECD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296BE10ED48;
	Wed, 13 May 2026 08:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oC5xwTBI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78DE10ED57
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778662462;
 bh=jCvfeCKBbFkSjTC664fGlyvJy+ifZgVjm5ush7U8RwQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oC5xwTBIDfkO0Z7C7eflO7OxqESJJtv97p61snjxVRo9qa89v6Md2Ar7vZaMWgZQ+
 rW46gYpmYxrfy0yKBZ4op9bO71aaOKXFHKt/Dyc7H9erOsQbBH0B7rV5Z4mG0jfmd2
 SC3lRdOdk7rvCFfZS+k4p8j8F5msaD0MRUVEklCkjQ3C0DCY35/D5ZyuBja8d/zMCs
 AHGWAkZHvKaMpWfyafuu7+7Nzp5H4CeBZ/ugQRUgFMlgKztJM72wuxEJhTfcZxZk+h
 SooCwcpF7c8QLXuPjCy+qaOj5wC6BKSGI8JbWrsojHlUwlcGHQ2pBigyug6HK7QtW9
 HGaxEuRRIblEQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BF16517E05FC;
 Wed, 13 May 2026 10:54:21 +0200 (CEST)
Date: Wed, 13 May 2026 10:54:18 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] drm/panthor: Process GPU events in IRQ context
Message-ID: <20260513105418.6e59142a@fedora>
In-Reply-To: <CAPaKu7Qk+aYY-O+HFLbg5D+cc4KZrU1dt23kATc7mpWPEP2gOg@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-11-95c614a739cb@collabora.com>
 <20260512135041.7801aa88@fedora>
 <CAPaKu7Qk+aYY-O+HFLbg5D+cc4KZrU1dt23kATc7mpWPEP2gOg@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 12 May 2026 15:40:41 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 12, 2026 at 5:09=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Tue, 12 May 2026 13:37:41 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > =20
> > > The current panthor_gpu_irq_handler() logic is already IRQ-safe
> > > (no sleep or sleeping locks, spinlocks taken with irqsave in other
> > > contexts, etc), so let's toggle the switch and make it an hard IRQ
> > > handler.
> > >
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_gpu.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/=
panthor/panthor_gpu.c
> > > index b9c51f8a051d..04c8f23baf3f 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> > > @@ -86,10 +86,15 @@ static void panthor_gpu_l2_config_set(struct pant=
hor_device *ptdev)
> > >       gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
> > >  }
> > >
> > > -static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 st=
atus)
> > > +static irqreturn_t panthor_gpu_irq_raw_handler(int irq, void *data)
> > >  {
> > > +     struct panthor_irq *pirq =3D data;
> > >       struct panthor_device *ptdev =3D pirq->ptdev;
> > >       struct panthor_gpu *gpu =3D ptdev->gpu;
> > > +     u32 status =3D gpu_read(gpu->irq.iomem, INT_STAT);
> > > +
> > > +     if (!status)
> > > +             return IRQ_NONE;
> > > =20
> >
> > Forgot to add the pirq state transition here:
> >
> >        scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> >                if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)
> >                        return IRQ_NONE;
> >
> >                pirq->state =3D PANTHOR_IRQ_STATE_PROCESSING;
> >        }
> > =20
> > >       gpu_write(gpu->irq.iomem, INT_CLEAR, status);
> > >
> > > @@ -115,11 +120,8 @@ static void panthor_gpu_irq_handler(struct panth=
or_irq *pirq, u32 status)
> > >               ptdev->gpu->pending_reqs &=3D ~status;
> > >               wake_up_all(&ptdev->gpu->reqs_acked);
> > >       }
> > > -}
> > >
> > > -static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *d=
ata)
> > > -{
> > > -     return panthor_irq_default_threaded_handler(data, panthor_gpu_i=
rq_handler); =20
> >
> > and restore it here:
> >
> >        scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> >                if (pirq->state =3D=3D PANTHOR_IRQ_STATE_PROCESSING)
> >                        pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;
> >        }
> > =20
> It looks like we can get rid of state transitions if
> panthor_irq_{enable,disable}_events updates INT_MASK directly when the
> handler is not threaded.

Hm, this would add some conditionals to
panthor_irq_{enable,disable}_events() and it makes the whole thing even
harder to reason about, because now it's different depending on whether
this is a threaded handler or not.

> Hm, we can even make pirq->state atomic again
> to get rid of locking.

I'd say, if we really want to optimize that, we do it in a follow-up
series. And I'd rather have an attempt at turning the MMU handler into a
hard handler (which implies selecting what we process immediately and
what we defer) than adding conditionals to irq_enabled/disable_events.
