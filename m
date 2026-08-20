Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28F5C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E1C10F1B1;
	Thu, 20 Aug 2026 21:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="baI25ULD";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B6110F1B1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787262993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJNhFXppokjOp9Um282YuDdOK7JlZ3LGM60w1T1FT9E=;
 b=baI25ULDkPYPJIe5C7qkNexcHNaLl24FuFKYk3zEWzmpK+j0suLftcES1kp++IxqjXpbwq
 AXPMHc+WAUjmloFxpyoDgpXdUSff5jmTM35KTjSfaAPloiun8X1aHLSqdro9nC4jp4cs2v
 ylK92m9PrEQqkG34pHxeaxlrenoJ9Ao=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-P3MKd2n1N5GTlNbwS2cSmA-1; Thu, 20 Aug 2026 17:56:25 -0400
X-MC-Unique: P3MKd2n1N5GTlNbwS2cSmA-1
X-Mimecast-MFC-AGG-ID: P3MKd2n1N5GTlNbwS2cSmA_1787262984
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so34175685a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787262984; x=1787867784;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lzTaBAeZXEpNdEF6mCBk0yTwt9Zf1jS1qQHVYWMdOMI=;
 b=Z7n55c9U+7hPa8H1nZ3f3Gh3eKhY0cSw6nGNk1Gnz9boGEpUPu2bfHfX7Q8/D1WSkh
 98U8qyqIfC/fybINvqX1TApTx2gt82fY8Vi6Dw+kH1VQBmCRC0jcjFEN68o7CKuswpC3
 r3pJyBtMACv6qp+j6Bnj6Kb8CPtP5EjY/oq4fUHPkLw2LJ/QogbUVNxttXqfa5Kf6uas
 fV6u0DxwkF1mjgIINaapj1d+U2Mnr+LweDwwDUiDIuRO8+REr/lwlBko5g7IBw7sOKVR
 XPc2ez4S/u3Cb/kinINyA8XT0l79/qS1hzXOH3Dxni6Y5RUzjzs+4iXpuelBMYCjXB0L
 CVTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpj87+uaWyhRqvc6nKN1VDDjvsnJ1NgZyCMP4s7O1l4oTaWNoMrXebSENBWknYRzw+1TNcKU8otfUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxl8ZiMmHB7WH47IAy12hWm9Ef1VfwXijr2g1zS2+kZ+HF+mSYa
 r/tpUIFsNrlWZITHXtLAN3wZZ5IUd/tXHVYKIRyfIVGFGeg6jdlCWLgdRPLxmIPS/LXqrUcxoIi
 sE4PFJf/ydfTcSUABAi3MYgYuQ9Dqs1yHyoRM4D8AFPLokcVSyFiZbewaUt30IxbY2DwLug==
X-Gm-Gg: AR+sD12GCrlqswUlMLw9odgIWdHHCWe7Iw8XFgnJl1VB7wiug+vJx+o3NI+nDaajOHa
 2KyQZ4HB6SVDnJRwSOmMn70ciZ1Ay2Ewe9YyJoUKRdvmd1yl0y87HhK/xItYA51xmxCW7fxTIrQ
 TDfkS66D2Bo4pfgQp4U51/hrDjsEViAwhhVkhbozWL9BbdUIMAvSqv2mWD1tlWawCyBAeBRq93c
 Kqa+66YaUopZC6ZYD/pl4z80dAtHnD4CBfd0gDjP1pvyUIpwIXNf3HA85c45iiXeWKzMcpzmDZr
 p0o/1rOJp2T03Jswug6dHS3qlXYKVs7Ki5FC131CwbI32ko7FfrY7iat0rEfDgLLid25dCSJ
X-Received: by 2002:a05:620a:1132:b0:937:36c0:bf6 with SMTP id
 af79cd13be357-9373958fcdamr105262285a.16.1787262984426; 
 Thu, 20 Aug 2026 14:56:24 -0700 (PDT)
X-Received: by 2002:a05:620a:1132:b0:937:36c0:bf6 with SMTP id
 af79cd13be357-9373958fcdamr105260085a.16.1787262983921; 
 Thu, 20 Aug 2026 14:56:23 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937204aa8a6sm461514385a.11.2026.08.20.14.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 14:56:22 -0700 (PDT)
Message-ID: <9414b8d122b9489056d72ee1605787ee038e62b7.camel@redhat.com>
Subject: Re: [PATCH v3 4/4] drm/nouveau: subscribe to channel-kill events on
 NV50 and newer
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@nvidia.com>
Date: Thu, 20 Aug 2026 17:56:21 -0400
In-Reply-To: <20260812231330.705425-5-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
 <20260812231330.705425-5-mczernohous@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6xWdYHFjcbiMDCIpJyrhnruPxD69-nVNoikw-Mp_dag_1787262984
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

This one is going to need some input from others I believe, mostly in
that I'd want to really make sure we know what the implications of
enabling an event like this on Tesla are and what kind of testing we
would need to know this isn't going to break things.

If it was a slightly newer generation I wouldn't be as worried. What
kind of testing have you done with this so far in terms of workload in
addition to what you mentioned on the cover letter? Tried running any
games, anything graphics intensive, etc.?

On Thu, 2026-08-13 at 01:13 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> nouveau_channel_init() only subscribes to the channel-killed event
> for
> FERMI_CHANNEL_GPFIFO and newer. On NV50/Tesla the subscription
> therefore
> never happens, and nvkm_chan_error()'s NVKM_CHAN_EVENT_ERRORED is
> delivered into an empty notifier list.
>=20
> Today that is harmless, because nothing kills a channel on Tesla: the
> only nvkm_chan_error() callers are the Fermi and newer recovery
> paths.
> So this patch changes no observable behaviour on its own, and that is
> deliberate: it removes a latent trap before anything can fall into
> it.
> I am carrying a Tesla recovery path that does add such a caller and
> will
> send it separately once it is ready. Without a subscriber in place
> the
> consequences there are severe: nouveau_channel_killed() never runs,
> so
> nouveau_fence_context_kill() never runs either, and the pending
> fences
> of the killed channel are never signalled. Everything waiting on them
> waits forever: drm_atomic_helper_wait_for_fences() in the display
> commit
> tail waits uninterruptibly and without a timeout, and the TTM delayed
> delete workers wait in TASK_UNINTERRUPTIBLE. The user sees a frozen
> desktop on a machine that is otherwise alive, and nothing in the
> kernel
> ends that state: both waits pass MAX_SCHEDULE_TIMEOUT, so the fences
> cannot time out. They are signalled only when the fence context is
> torn
> down, that is when the DRM client owning the channel closes its fd
> and
> nouveau_fence_context_del() runs. Killing the client, or rebooting,
> clears it; waiting does not.
> That is also a dma-fence contract violation: a fence must always be
> signalled, with an error if necessary.
>=20
> Lower the class gate to NV50_CHANNEL_GPFIFO. The nvkm side is already
> class neutral: the KILLED case hangs the notifier on runl->chid-
> >event,
> which every fifo owns since the runlist rework, and
> nvkm_uchan_uevent()
> does not discriminate by class. Pre-NV50 chips keep the old
> behaviour,
> so NV04 to NV40 are unaffected.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_chan.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c
> b/drivers/gpu/drm/nouveau/nouveau_chan.c
> index 07b0bd1bc519..5c2f4b9342b7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -485,7 +485,7 @@ nouveau_channel_init(struct nouveau_channel
> *chan, u32 vram, u32 gart)
> =C2=A0=09 * lock and the pending list, so an event arriving in
> between would
> =C2=A0=09 * find a non-NULL but unusable context and walk a NULL list
> head.
> =C2=A0=09 */
> -=09if (chan->user.oclass >=3D FERMI_CHANNEL_GPFIFO) {
> +=09if (chan->user.oclass >=3D NV50_CHANNEL_GPFIFO) {
> =C2=A0=09=09DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
> =C2=A0=09=09=09=09sizeof(struct nvif_chan_event_v0));
> =C2=A0=09=09struct nvif_chan_event_v0 *host =3D

