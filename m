Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B63ECD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9730B10ED37;
	Wed, 13 May 2026 08:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="M79WqQKP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9302710ED37
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778659746;
 bh=1HD83A4OZRnR0jOU/ml8g6QMXp0hWi547eD8+Be+NSw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=M79WqQKPFH8pZWRRgFKieZqcob8DU2T9+KP/WE9s/p3FcN8s1KKHQw5UIJnJ2Wc/f
 +FH2JZM3nwQn31eMbUp7r8y+NmNK5hmJagR2b8+56uOIfoidVMADJE+8QT3uNrpwJN
 rqcbFe7T6lvSZdEXdbshGXL8/mxT3tIAK6G9fliVO5dB01nSlafVuHMdLFFwttU1HG
 2kGNOQA9FZ3Bb6IH6rdRA6Yq/gjzXBBarOGyRkisCdtzi9dYHGbaSByLwNrzO+OyEN
 kAY+B5mS0yUbY3x3vHrumr30ZLs9QsWF9YN9z6SgqDLCbdEMwe5vcKoTVnq0F/aCYA
 d28UIllc/KX8g==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D76FC17E0411;
 Wed, 13 May 2026 10:09:05 +0200 (CEST)
Date: Wed, 13 May 2026 10:09:01 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] drm/panthor: Extend the IRQ logic to allow
 fast/hard IRQ handlers
Message-ID: <20260513100901.7b497929@fedora>
In-Reply-To: <CAPaKu7R56gakVRPrzXAu94Kk-AL+Ac=uFrikTyXsj8QtWKM29w@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-4-95c614a739cb@collabora.com>
 <CAPaKu7R56gakVRPrzXAu94Kk-AL+Ac=uFrikTyXsj8QtWKM29w@mail.gmail.com>
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

On Tue, 12 May 2026 12:11:08 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > All drivers except panthor signal their fences from their interrupt
> > handler to minimize latency. We could do the same from the threaded
> > handler, but the latency is still quite high in that case, so let's
> > allow components to choose the context they want their IRQ handler
> > to run in by exposing support for custom hard handlers.
> >
> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_device.h | 11 ++++++++---
> >  drivers/gpu/drm/panthor/panthor_fw.c     |  1 +
> >  drivers/gpu/drm/panthor/panthor_gpu.c    |  1 +
> >  drivers/gpu/drm/panthor/panthor_mmu.c    |  1 +
> >  drivers/gpu/drm/panthor/panthor_pwr.c    |  1 +
> >  5 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm=
/panthor/panthor_device.h
> > index 393fcda73d88..1aaf06df875b 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > @@ -672,6 +672,7 @@ static inline void panthor_irq_disable_events(struc=
t panthor_irq *pirq, u32 mask
> >  static inline int
> >  panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *=
pirq,
> >                     int irq, u32 mask, void __iomem *iomem, const char =
*name,
> > +                   irqreturn_t (*raw_handler)(int, void *data),
> >                     irqreturn_t (*threaded_handler)(int, void *data))
> >  {
> >         const char *full_name;
> > @@ -687,9 +688,13 @@ panthor_irq_request(struct panthor_device *ptdev, =
struct panthor_irq *pirq,
> >                 return -ENOMEM;
> >
> >         panthor_irq_resume(pirq);
> > -       return devm_request_threaded_irq(ptdev->base.dev, irq,
> > -                                        panthor_irq_default_raw_handle=
r,
> > -                                        threaded_handler,
> > +
> > +       if (!threaded_handler) {
> > +               return devm_request_irq(ptdev->base.dev, irq, raw_handl=
er,
> > +                                       IRQF_SHARED, full_name, pirq);
> > +       } =20
> devm_request_irq expands to devm_request_threaded_irq plus
> IRQF_COND_ONESHOT. This appears redundant.

I considered going for devm_request_threaded_irq(COND_ONESHOT), but I
thought it was easier to reason about with a regular devm_request_irq()
and an extra conditional since request_irq() is what people tend
to use when they just have a hard handler (see [1], there's just one
driver using it, and it's not even needed, because it's calling
devm_request_irq() which adds this flag already)

[1]https://elixir.bootlin.com/linux/v7.1-rc3/A/ident/IRQF_COND_ONESHOT
