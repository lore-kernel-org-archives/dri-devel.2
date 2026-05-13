Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D67ACD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84CA410E2D7;
	Wed, 13 May 2026 08:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qWiNDU5g";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE3E10E2D7
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778661750;
 bh=BknAMhAVq8EiQCjsOx5ehbbkhdCnxVThiaBVd7cx7qY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qWiNDU5gl6Ee5EHcBpkseGP3RPyTaaxmpaj3MIYjOPMCUYJtlp9Qdjui9RlYNYciW
 skcaIp+iKFrV1fPGYP3UBBBafI7N7FmqUCV0CBJ8shS6zHgdzUvc3aMKNqsoCJQq7P
 CUXn07/2bCOfn3pgsgVnlc6NwIEY7islPQJbjKdouJpVA13r/Q59fyIfuTtT86sZXK
 LYVBGGiOB2dY7KcAXgFhlQVwoNvVjHHjeS5MCAaT8fgGZCBRBAYSMZF71n/VsCb+Zq
 cWFFvLQjMFuqEMF4uZl1slbjBz0BPgct6EgPp5kYjhimOqZBznyg33DNDNFUAtuA8y
 vzBi6lN58e+hg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D1E317E0411;
 Wed, 13 May 2026 10:42:30 +0200 (CEST)
Date: Wed, 13 May 2026 10:42:25 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] drm/panthor: Automatically enable interrupts
 in panthor_fw_wait_acks()
Message-ID: <20260513104225.0c0992d5@fedora>
In-Reply-To: <CAPaKu7Sx85JpFFJ_4w3mZ6_OPkCHDqp68Uo+RbeYx=5v03vdww@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
 <CAPaKu7Sx85JpFFJ_4w3mZ6_OPkCHDqp68Uo+RbeYx=5v03vdww@mail.gmail.com>
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

On Tue, 12 May 2026 14:55:30 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Rather than assuming an interrupt is always expected for request
> > acks, temporarily enable the relevant interrupts when the polling-wait
> > failed. This should hopefully reduce the number of interrupts the CPU
> > has to process.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com> =20
> WIth minor comments below, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c    | 34 +++++++++++++++++++------=
--------
> >  drivers/gpu/drm/panthor/panthor_sched.c |  5 +++--
> >  2 files changed, 23 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/pan=
thor/panthor_fw.c
> > index 8239a6951569..f5e0ceca4130 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -1039,16 +1039,10 @@ static void panthor_fw_init_global_iface(struct=
 panthor_device *ptdev)
> >         glb_iface->input->progress_timer =3D PROGRESS_TIMEOUT_CYCLES >>=
 PROGRESS_TIMEOUT_SCALE_SHIFT;
> >         glb_iface->input->idle_timer =3D panthor_fw_conv_timeout(ptdev,=
 IDLE_HYSTERESIS_US);
> >
> > -       /* Enable interrupts we care about. */
> > -       glb_iface->input->ack_irq_mask =3D GLB_CFG_ALLOC_EN |
> > -                                        GLB_PING |
> > -                                        GLB_CFG_PROGRESS_TIMER |
> > -                                        GLB_CFG_POWEROFF_TIMER |
> > -                                        GLB_IDLE_EN |
> > -                                        GLB_IDLE;
> > -
> > -       if (panthor_fw_has_glb_state(ptdev))
> > -               glb_iface->input->ack_irq_mask |=3D GLB_STATE_MASK;
> > +       /* Enable interrupts for asynchronous events that are not
> > +        * triggered by request acks.
> > +        */
> > +       glb_iface->input->ack_irq_mask =3D GLB_IDLE; =20
> We should static_assert or & with GLB_EVT_MASK. Same for CSG and CS.

Yep, good idea, I'll add a static_assert() in all places where
->ack_irq_mask is set.

>=20
> >
> >         panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN | GLB_COUNTE=
R_EN,
> >                                GLB_IDLE_EN | GLB_COUNTER_EN);
> > @@ -1318,8 +1312,8 @@ void panthor_fw_unplug(struct panthor_device *ptd=
ev)
> >   * Return: 0 on success, -ETIMEDOUT otherwise.
> >   */
> >  static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_ptr,
> > -                               wait_queue_head_t *wq,
> > -                               u32 req_mask, u32 *acked,
> > +                               u32 *ack_irq_mask_ptr, spinlock_t *lock,
> > +                               wait_queue_head_t *wq, u32 req_mask, u3=
2 *acked,
> >                                 u32 timeout_ms)
> >  {
> >         u32 ack, req =3D READ_ONCE(*req_ptr) & req_mask;
> > @@ -1334,8 +1328,16 @@ static int panthor_fw_wait_acks(const u32 *req_p=
tr, const u32 *ack_ptr,
> >         if (!ret)
> >                 return 0;
> >
> > -       if (wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) =
=3D=3D req,
> > -                              msecs_to_jiffies(timeout_ms)))
> > +       scoped_guard(spinlock_irqsave, lock)
> > +               *ack_irq_mask_ptr |=3D req_mask;
> > +
> > +       ret =3D wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask=
) =3D=3D req,
> > +                                msecs_to_jiffies(timeout_ms));
> > +
> > +       scoped_guard(spinlock_irqsave, lock)
> > +               *ack_irq_mask_ptr &=3D ~req_mask; =20
> We should add a comment saying that this is safe because
> {GLB,CSG,CS}_REQ_MASK and {GLB,CSG,CS}_EVT_MASK are disjoint, and thus
> req_mask and ack_irq_mask are disjoint.

You mean the ack_irq_mask set at init time? Because
xxx_iface->input->ack_irq_mask is moving target now.

Well, if we expand on safety matters, I'd say none of this is safe
since it relies on the caller knowing what it does and passing a valid
req_mask. But I'll add a comment mentioning that the original
ack_irq_mask shouldn't intersect with any of the bits that might be set
in req_mask (that's basically the static_assert() you suggested).
