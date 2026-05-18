Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF78CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 11:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD1B10E2FD;
	Mon, 18 May 2026 11:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jZ25LSGU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF97E10E2FD
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779105282;
 bh=HGqdgWiWDU8xyepNhRXq5ZZ7kaRkxkzyM5rlbdTR9ao=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jZ25LSGUxaYGkD4KXJs2pAS0suX29Q3b5OHkacmcfM+BCUVETc2S/1kjDIIeCGBuo
 XyfpAhIHUsKkdLrH3LZpn/YjrhxkqgOxchDnhy4mYMZh6HrVZWDqpVX5fROTTzNlh6
 h4CdbDDNNg3ZKz6UpOX6S5iwTXpk/caii6hS6h32eqepcYfXBvxI8tKYW+hC5plVCg
 T2JMyXFok+5XjKHSa0vbMJXzcVl1eZQWNQHwvTxrA4S8c+RSrPf8cp22mVzvoOnaeK
 bLKezWMb4l4lrJkr5KnZn7f4npoaQNgkmn8h+tBjriQxIo+UbuHKOZpUZWb/kM76LZ
 UFuJLDF+jb9sg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 378A817E05E5;
 Mon, 18 May 2026 13:54:42 +0200 (CEST)
Date: Mon, 18 May 2026 13:54:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] drm/panthor: Extend the IRQ logic to allow
 fast/hard IRQ handlers
Message-ID: <20260518135438.31b70f52@fedora>
In-Reply-To: <CAPaKu7ShbEAGC5xx6XgJzVkuBF--RT-g0vgQ9kL5vvw5Q2kUhQ@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-4-95c614a739cb@collabora.com>
 <CAPaKu7R56gakVRPrzXAu94Kk-AL+Ac=uFrikTyXsj8QtWKM29w@mail.gmail.com>
 <20260513100901.7b497929@fedora>
 <CAPaKu7TN4+PRYZWMRWFuEP6a9NL6sP_x1_zZrAbkVXsht-yQnw@mail.gmail.com>
 <20260513193011.4c7d30fc@fedora>
 <CAPaKu7ShbEAGC5xx6XgJzVkuBF--RT-g0vgQ9kL5vvw5Q2kUhQ@mail.gmail.com>
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

On Wed, 13 May 2026 11:17:26 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Wed, May 13, 2026 at 10:30=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Wed, 13 May 2026 10:06:14 -0700
> > Chia-I Wu <olvaffe@gmail.com> wrote:
> > =20
> > > On Wed, May 13, 2026 at 1:09=E2=80=AFAM Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote: =20
> > > >
> > > > On Tue, 12 May 2026 12:11:08 -0700
> > > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > > > =20
> > > > > On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> > > > > <boris.brezillon@collabora.com> wrote: =20
> > > > > >
> > > > > > All drivers except panthor signal their fences from their inter=
rupt
> > > > > > handler to minimize latency. We could do the same from the thre=
aded
> > > > > > handler, but the latency is still quite high in that case, so l=
et's
> > > > > > allow components to choose the context they want their IRQ hand=
ler
> > > > > > to run in by exposing support for custom hard handlers.
> > > > > >
> > > > > > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > > > > > Reviewed-by: Steven Price <steven.price@arm.com>
> > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/panthor/panthor_device.h | 11 ++++++++---
> > > > > >  drivers/gpu/drm/panthor/panthor_fw.c     |  1 +
> > > > > >  drivers/gpu/drm/panthor/panthor_gpu.c    |  1 +
> > > > > >  drivers/gpu/drm/panthor/panthor_mmu.c    |  1 +
> > > > > >  drivers/gpu/drm/panthor/panthor_pwr.c    |  1 +
> > > > > >  5 files changed, 12 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers=
/gpu/drm/panthor/panthor_device.h
> > > > > > index 393fcda73d88..1aaf06df875b 100644
> > > > > > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > > > > > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > > > > > @@ -672,6 +672,7 @@ static inline void panthor_irq_disable_even=
ts(struct panthor_irq *pirq, u32 mask
> > > > > >  static inline int
> > > > > >  panthor_irq_request(struct panthor_device *ptdev, struct panth=
or_irq *pirq,
> > > > > >                     int irq, u32 mask, void __iomem *iomem, con=
st char *name,
> > > > > > +                   irqreturn_t (*raw_handler)(int, void *data),
> > > > > >                     irqreturn_t (*threaded_handler)(int, void *=
data))
> > > > > >  {
> > > > > >         const char *full_name;
> > > > > > @@ -687,9 +688,13 @@ panthor_irq_request(struct panthor_device =
*ptdev, struct panthor_irq *pirq,
> > > > > >                 return -ENOMEM;
> > > > > >
> > > > > >         panthor_irq_resume(pirq);
> > > > > > -       return devm_request_threaded_irq(ptdev->base.dev, irq,
> > > > > > -                                        panthor_irq_default_ra=
w_handler,
> > > > > > -                                        threaded_handler,
> > > > > > +
> > > > > > +       if (!threaded_handler) {
> > > > > > +               return devm_request_irq(ptdev->base.dev, irq, r=
aw_handler,
> > > > > > +                                       IRQF_SHARED, full_name,=
 pirq);
> > > > > > +       } =20
> > > > > devm_request_irq expands to devm_request_threaded_irq plus
> > > > > IRQF_COND_ONESHOT. This appears redundant. =20
> > > >
> > > > I considered going for devm_request_threaded_irq(COND_ONESHOT), but=
 I
> > > > thought it was easier to reason about with a regular devm_request_i=
rq()
> > > > and an extra conditional since request_irq() is what people tend
> > > > to use when they just have a hard handler (see [1], there's just one
> > > > driver using it, and it's not even needed, because it's calling
> > > > devm_request_irq() which adds this flag already) =20
> > > It is unclear to me why the current version wants IRQF_COND_ONESHOT in
> > > one case but not in another. Can't we call devm_request_threaded_irq
> > > without IRQF_COND_ONESHOT for both cases? =20
> >
> > Hm, I thought this had to do with the automatic hard -> threaded
> > downgrade happening when RT is enabled, but I fail to see why it
> > matters, since all irqaction end up with IRQF_ONESHOT in that case
> > anyway. Honestly, I'm tempted to stay on the safe side, and have
> > devm_request_irq() called when we just have a hard handler, because I'm
> > sure there's a reason for this COND_ONESHOT flag. =20
> Sounds good. Feel free to add Reviewed-by: Chia-I Wu <olvaffe@gmail.com>.
>=20
> FWIW, I think this commit explains the motivation
>=20
>   commit c37927a203fa283950f6045602b9f71328ad786c
>   Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   Date:   Thu Jul 11 12:20:04 2024 +0200
>=20
>       genirq: Set IRQF_COND_ONESHOT in request_irq()
>=20
>       The callers of request_irq() don't care about IRQF_ONESHOT because =
they
>       don't provide threaded handlers, but if they happen to share the IR=
Q with
>       the ACPI SCI, which has a threaded handler and sets IRQF_ONESHOT,
>       request_irq() will fail for them due to a flags mismatch.
>=20
> For panthor, my takeaway is we either care about flag mismatch (then
> we should set IRQF_COND_ONESHOT for the threaded case) or we don't
> (then we don't need to use devm_request_irq).

Fair enough. I'll use devm_request_threaded_irq() without
IRQF_COND_ONESHOT since I don't think we ever had an SoC where the IRQ
line was shared with other non-GPU blocks, and we set the same flags
for all GPU irqs.
