Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BFAC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4192D10F161;
	Thu, 20 Aug 2026 17:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CGGD9DK6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC28510E1EE
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787248542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXmR5qR3jtx7kOIrq38SuTT1/+e+DpvoYM+cnNboWbk=;
 b=CGGD9DK6EnHHjzPbtUpnjrqQa9oZ70Sf9uf0DsrSxD8EwZoen4Z8Y302zC63fGo72FKoV8
 MYMrhYZlAuJ6l5ss/RQs7OGeAeVfh40dg1ri9Qbm4WKImlMdBTU6T8bKOsxuUIsHH+j2kq
 ijHvpduRZaPbSlBgqhDJKVJq7dN8rS0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-0Wa-pBxOMoufs8UPRI7RmA-1; Thu, 20 Aug 2026 13:55:38 -0400
X-MC-Unique: 0Wa-pBxOMoufs8UPRI7RmA-1
X-Mimecast-MFC-AGG-ID: 0Wa-pBxOMoufs8UPRI7RmA_1787248538
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so1024981cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787248538; x=1787853338;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VTFvT4h0Q0q3RfixbzGb3rOg5NcbDH7/Ar2/bb9HET4=;
 b=To8JTmir2fboKZuCtmZnovZhd7d+qXr+y5Fh1YgjOYQ7/p4Wn/t0T/NratvXZqR491
 vUzb4P6AAAfbfLxrvZqRNYh+sJzbWbrV8JCviUZ9sjmNjRbc9y4SCqt1d202Z0eSjE0N
 bCK71RPAaetutFIxRQfFCqJ38WZECa966VdozSgGKuxJYoB2gWR0zFR5ny2xhOHAFM8n
 /nvCt5G0upbiiCqCEw163a1mfXZ5S40kE7j6LqKm9f8YYDb5CgBQc/OcVCI31uLanc1Y
 7aH33sLho2jDYA3IJwHjALv4dJl2eaY5z3m7LbZ26+XRn9MxYq5pGLir3+pSiinuIIKP
 iFjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1boIYB1i114i1xwq1OMv3TV3kB9RMYxCMd2a5OkjAGoFXaBBtRPHXv4xXnFjklunVmtre00BhnbM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdNrRods6zzaNMKxheI8AYn38J49Z3XhIhfxk8vq4NtvuKCaPm
 54gAzU8JhsjSnxMmBqSgJo91OKLcAbF72bCBcKAS5W6ME6I55imdBXmlI1C9/76I7Doo2qG0FJ3
 12WTH9MX6WSygfm8+/TxuVeEn7AnuzCP6+hgCEQJY+611d3wl/SUkprcGlpi5fTSmxRLY+Q==
X-Gm-Gg: AR+sD13aP0JTOdIcVfY2A1HyAldHlv7Kf/M50auXRUWyiFzI7Vp8pWBehum60qp7YCY
 GBJj30lfIIIHNwh20o0rdpE5M71hHzFOt3XnRKa7xb7wxHwJMgp44mVY6P6LiX+pjAt6wJ2aD1j
 iAYuTkRMLDCZfvzfFfUqsLP3VhfDMvqgbdosMWpmgsAgXd+7KPG6qRErWtKq89H/NKmT2/VZTA2
 oi+IeOaqAqBHXzHZ2GdenacH0iy5bjf0Yu2lYtgJtb+GzxRH7gfh7Ls03TYKS3XgpJm+nL0Zwwa
 BO5DQVr5PFbvP+kTIurTjy4u8Wb/Dt8furCzUdo6g6QP/yiPvfR867K0R2i8IETtEh0ZikSe
X-Received: by 2002:a05:622a:5591:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-52df5637a7dmr1713071cf.3.1787248537860; 
 Thu, 20 Aug 2026 10:55:37 -0700 (PDT)
X-Received: by 2002:a05:622a:5591:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-52df5637a7dmr1712551cf.3.1787248537384; 
 Thu, 20 Aug 2026 10:55:37 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f29065bsm43058966d6.24.2026.08.20.10.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 10:55:36 -0700 (PDT)
Message-ID: <89da2f2c2cd6223e6973b1adb8aebd7a9cd9bce8.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: disable the fence uevent work instead
 of just cancelling it
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Thu, 20 Aug 2026 13:55:35 -0400
In-Reply-To: <178688513268.513871.3468844663561639695@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.12779628082366287968@gmail.com>
 <178688513268.513871.3468844663561639695@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ldnoqydG99M_-vRrK-W8dUhYkZJ-OnbIJ1PcNVoCKys_1787248538
X-Mimecast-Originator: redhat.com
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

This makes sense to me.

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next-fixes in just a moment

On Sun, 2026-08-16 at 14:58 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> nouveau_fence_context_del() drains the uevent work while the event
> that
> feeds it is still armed:
>=20
> =09cancel_work_sync(&fctx->uevent_work);
> =09nouveau_fence_context_kill(fctx, 0);
> =09nvif_event_dtor(&fctx->event);
>=20
> nouveau_fence_wait_uevent_handler() queues the work unconditionally:
>=20
> =09schedule_work(&fctx->uevent_work);
> =09return NVIF_EVENT_KEEP;
>=20
> so a non-stall interrupt arriving after cancel_work_sync() has
> returned
> re-arms the work that was just drained.=C2=A0 The window closes in two
> steps,
> neither of which is the drain.=C2=A0 The kill blocks the event when the
> last
> fence holding a notify_ref is signalled, which reaches
> atomic_xchg(&ntfy->allowed, 0) (nvkm/core/event.c:104), and
> nvkm_event_ntfy() skips a ntfy that is not allowed (:183).=C2=A0 That
> stops
> further handlers from starting, but not one that is already inside
> nvkm_event_ntfy(): the event is created with wait =3D false
> (nouveau_fence.c:201), so nvkm_event_ntfy_block_() leaves it on the
> list
> and never takes event->list_lock.=C2=A0 Only nvif_event_dtor() waits that
> one
> out: nvkm_event_ntfy_del() (:141) goes through
> nvkm_event_ntfy_remove(),
> which takes write_lock_irq() on that same list_lock (:84).
>=20
> Either way the re-arm happens after the drain, and the caller drops
> its
> reference immediately afterwards, for example
> nv84_fence_context_del():
>=20
> =09nouveau_fence_context_del(&fctx->base);
> =09chan->fence =3D NULL;
> =09nouveau_fence_context_free(&fctx->base);
>=20
> That is a kref_put() on fctx->fence_ref, so the context outlives the
> teardown only while emitted fences still hold a reference of their
> own.
> That is no safety net: whenever none do, the count reaches zero right
> there and nouveau_fence_context_put() kfree()s fctx while the work is
> still queued.=C2=A0 &fctx->uevent_work is embedded in that allocation, so
> the
> workqueue already dereferences freed memory when it picks the item
> up,
> and nouveau_fence_uevent_work() can then take fctx->lock on it.=C2=A0 Wit=
h
> CONFIG_DEBUG_OBJECTS_WORK and CONFIG_DEBUG_OBJECTS_FREE, kfree() of a
> still-queued work item is reported as the free of an active object.
>=20
> On live memory the re-armed work has nothing left to do:
> nouveau_fence_context_kill() empties fctx->pending and sets fctx-
> >killed
> under fctx->lock, nouveau_fence_emit() then returns -ENODEV rather
> than
> queueing anything new, and nouveau_fence_update() only reaches
> nvif_event_block() if it signalled something off that list.=C2=A0 The
> defect
> is the access to freed memory, not what the work would have found.
>=20
> Only chips from G84 on can reach this at all:
> nouveau_fence_context_new()
> returns before nvif_event_ctor() when priv->uevent is clear, and
> nv84_fence_create() is the only place that sets it.
> nv84_fence_context_del() is the context_del for all of those, because
> nvc0_fence_create() and gv100_fence_create() build on
> nv84_fence_create()
> and override only context_new.
>=20
> Use disable_work_sync() instead.=C2=A0 It drains the work exactly like
> cancel_work_sync() does, and additionally increments the work item's
> disable count, after which "any attempt to queue @work will fail and
> return %false" (kernel/workqueue.c, disable_work()).=C2=A0 The handler's
> schedule_work() then has nothing to re-arm, and the teardown order
> stays
> as it is.
>=20
> Draining a second time after nvif_event_dtor() would close the window
> as
> well, and without the newer API: once nvkm_event_ntfy_remove() has
> returned, no handler can start or still be running, so nothing re-
> arms
> the work past that point.=C2=A0 disable_work_sync() is preferred here
> because
> it needs one synchronisation point instead of two, it keeps the work
> from being queued at all rather than cleaning up after it, and it is
> what drm has settled on for this (drm/xe, drm/panthor, drm_pagemap).
> Blocking the event rather than the work is not an option: fctx->event
> is
> created with wait =3D false, so a handler already inside
> nvkm_event_ntfy()
> can still queue the work.
>=20
> Note for backports: disable_work_sync() arrived in v6.10 with
> commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> (delayed)
> work items"), while the fix being corrected here reached 6.6.18 and
> 6.7.6.=C2=A0 linux-6.6.y therefore carries this bug without the API, and
> this
> patch would apply there and then fail to build.=C2=A0 A 6.6.y backport
> wants
> the second drain described above instead, as its own patch.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes:
> https://lore.kernel.org/nouveau/20260812231330.705425-1-mczernohous@gmail=
.com/
> Fixes: 39126abc5e20 ("nouveau: offload fence uevents work to
> workqueue")
> Cc: <stable@vger.kernel.org> # 6.10.x
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
>=20
> Changes in v2:
> =C2=A0- Do not reorder the teardown.=C2=A0 v1 moved nvif_event_dtor() ahe=
ad of
> =C2=A0=C2=A0 nouveau_fence_context_kill(); with the fences still unsignal=
led
> that
> =C2=A0=C2=A0 leaves nouveau_fence_enable_signaling() reachable, and
> =C2=A0=C2=A0 nvif_event_constructed() is a plain unlocked read of object-
> >client,
> =C2=A0=C2=A0 so the dtor could race an nvif_event_allow() already past th=
at
> check.
> =C2=A0=C2=A0 Reported as [Critical] by the bot, and withdrawn:
> =C2=A0=C2=A0
> https://lore.kernel.org/all/20260815200914.8A1131F000E9@smtp.kernel.org/
> =C2=A0- Change cancel_work_sync() to disable_work_sync() instead, which
> leaves
> =C2=A0=C2=A0 every ordering alone.
> =C2=A0- Pin the damage down.=C2=A0 Both versions call it a use-after-free=
; this
> one
> =C2=A0=C2=A0 adds that &fctx->uevent_work is embedded in the freed alloca=
tion,
> and
> =C2=A0=C2=A0 that the re-armed work has nothing left to do on a live cont=
ext,
> so
> =C2=A0=C2=A0 the access to freed memory is the whole of it.
> =C2=A0- Correct the backport note.=C2=A0 v1 claimed no longterm tree sat =
in the
> gap
> =C2=A0=C2=A0 between the bug and disable_work_sync(); 6.6.y does.=C2=A0 T=
he stable
> tag is
> =C2=A0=C2=A0 annotated accordingly.
>=20
> This replaces 1/3 of
> https://lore.kernel.org/all/178682366002.3748010.12779628082366287968@gma=
il.com/
> 2/3 and 3/3 of that series are unaffected and still stand.
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c
> b/drivers/gpu/drm/nouveau/nouveau_fence.c
> index edbe9e08ba0f..11e95c37ce50 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -96,7 +96,7 @@ nouveau_fence_context_kill(struct
> nouveau_fence_chan *fctx, int error)
> =C2=A0void
> =C2=A0nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
> =C2=A0{
> -=09cancel_work_sync(&fctx->uevent_work);
> +=09disable_work_sync(&fctx->uevent_work);
> =C2=A0=09nouveau_fence_context_kill(fctx, 0);
> =C2=A0=09nvif_event_dtor(&fctx->event);
> =C2=A0=09fctx->dead =3D 1;
>=20
> base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86

