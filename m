Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8944BCD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF93610E29C;
	Wed, 13 May 2026 08:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="j7IzMQzs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600E010E29C
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778661895;
 bh=wiDCBOwq5enTpnnegMkeburnpNjYmEPN9NiWi9ZR5wk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=j7IzMQzsabo6iAV/yLVY76emBHSQwiKdj1TZG7+Cr05nD6aR1H0zv1RHC9JqW4Nav
 x1T1vZNDysZtQyeFZClImxxCAJ6/0/YsYjjfjXwbufqEqmvCE9pRI7MYD8h06TVjkK
 cJ5Ca5fkQve8SR/31eAonaKT/4of/6YvIJT/Yr1yx0Zw5KJo2Exxj/U3CGNV1/huAK
 DUbf01+EDfPQCDCaTinYzqtjcV4RUmLpxDBS6eDCZT3BGlpXgHacqBIPUMPxrr6nuE
 3itJgYtrdhD7ZoEYahAekYxesEK1pTg1dtXyI5rIDfNafeJ0PQsg1S4lBrenKV9ezp
 82s8mbEOM37tw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EFFF17E0443;
 Wed, 13 May 2026 10:44:54 +0200 (CEST)
Date: Wed, 13 May 2026 10:44:51 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] drm/panthor: Process FW events in IRQ context
Message-ID: <20260513104451.28c65c9b@fedora>
In-Reply-To: <CAPaKu7S=Cq=nASYBRRa_y2Zj4X7sX3+RY6tc4C=Vqq3-5-nqqg@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-9-95c614a739cb@collabora.com>
 <CAPaKu7SHcS=KaeLvSrxcopgL_aKQm2vVeRmGHGWW+E2YgGOM0Q@mail.gmail.com>
 <CAPaKu7S=Cq=nASYBRRa_y2Zj4X7sX3+RY6tc4C=Vqq3-5-nqqg@mail.gmail.com>
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

On Tue, 12 May 2026 15:09:47 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 12, 2026 at 3:05=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wro=
te:
> >
> > On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote: =20
> > >
> > > Now that everything is set to allow processing FW events in IRQ conte=
xt,
> > > go for it. This should reduce the dma_fence signaling latency.
> > >
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_fw.c | 27 +++++++++++++++++++++++----
> > >  1 file changed, 23 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/p=
anthor/panthor_fw.c
> > > index f5e0ceca4130..8cfebf180de7 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > > @@ -1087,9 +1087,29 @@ static void panthor_job_irq_handler(struct pan=
thor_irq *pirq, u32 status)
> > >         }
> > >  }
> > >
> > > -static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *d=
ata)
> > > +static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
> > >  {
> > > -       return panthor_irq_default_threaded_handler(data, panthor_job=
_irq_handler);
> > > +       struct panthor_irq *pirq =3D data;
> > > +
> > > +       if (!gpu_read(pirq->iomem, INT_STAT))
> > > +               return IRQ_NONE;
> > > +
> > > +       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> > > +               if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)
> > > +                       return IRQ_NONE;
> > > +
> > > +               pirq->state =3D PANTHOR_IRQ_STATE_PROCESSING;
> > > +       }
> > > +
> > > +       /* We can use INT_STAT here, because we didn't mask the IRQs.=
 */
> > > +       panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_STAT)=
); =20
> > We should loop here until INT_STAT is cleared. =20
> Perhaps not. This is hardirq.

Yep, the absence of loop is intentional here. We process it one at a
time, and give other interrupt handlers a chance to do their stuff
before we get called again.

>=20
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > > +
> > > +       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> > > +               if (pirq->state =3D=3D PANTHOR_IRQ_STATE_PROCESSING)
> > > +                       pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;
> > > +       }
> > > +
> > > +       return IRQ_HANDLED;
> > >  }
> > >
> > >  static int panthor_fw_start(struct panthor_device *ptdev)
> > > @@ -1489,8 +1509,7 @@ int panthor_fw_init(struct panthor_device *ptde=
v)
> > >
> > >         ret =3D panthor_irq_request(ptdev, &fw->irq, irq, 0,
> > >                                   ptdev->iomem + JOB_INT_BASE, "job",
> > > -                                 panthor_irq_default_raw_handler,
> > > -                                 panthor_job_irq_threaded_handler);
> > > +                                 panthor_job_irq_raw_handler, NULL);
> > >         if (ret) {
> > >                 drm_err(&ptdev->base, "failed to request job irq");
> > >                 return ret;
> > >
> > > --
> > > 2.54.0
> > > =20

