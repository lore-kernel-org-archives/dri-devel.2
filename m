Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F6AC5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3A610E23B;
	Thu, 20 Aug 2026 20:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GnZ+BXFv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D1F10EC59
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJKPICihK9XYAlei4GXUvaTGSn4DbGwdgj148h871wM=;
 b=GnZ+BXFvZn51TavMArAi8UqJKrdEL3H6sBKOXs/O0wNhjFotSj4w+J1ckD5kD05YBTLHGR
 CRA1hf+UDC2ZVgm9+KcFYcxJQP8H9C1s+LwJI5Q4jC9+Y2ZoBkyn22hp4MqnvuS+ZvvsW4
 qnM0oFFXxW2E+GHmL4uNUffwO/Mzf4I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-TUQ_kCwzN6aQUTGA9Q5rKA-1; Thu, 20 Aug 2026 16:01:33 -0400
X-MC-Unique: TUQ_kCwzN6aQUTGA9Q5rKA-1
X-Mimecast-MFC-AGG-ID: TUQ_kCwzN6aQUTGA9Q5rKA_1787256093
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9087f2fe592so1866126d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256093; x=1787860893;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yJKPICihK9XYAlei4GXUvaTGSn4DbGwdgj148h871wM=;
 b=JUygVwLra78A6McQCKlULNfAQzz7KYpm4NafwxG5nFEd1Q+X6Sv9rK31OuDGKICWdB
 6Dm0WlObkq+j1wiCDffba+jf0zvUuuyp/LLoLWtXZ9Nu71b1bh8NsF1lGVsBZxJvXEFO
 7r0rvwmHuGvWSCxAOR4olnnaiefP3gyEcjlq95YTmbbAy5pgiZqju57+7BUABtIldh3+
 wUXcHp7j4GBKRSSyMNRkHnBp6/UGVQSCYk70gU0VYN/h8U1sU+SbgyMOB2nO2bHxHmIU
 A9dYolU8FHO4W3PfMsGhGlAp5q7D2pT1fML4tMTt2kfumesES+B6nAUZ3E1GxIhie3uf
 3K1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfxiqaP4nmGlEuww53esNFoAtZnIcV/8lAF8+NYzdIBkdztSZ9xdlO+OERhmZTgbX09wV0Xqauhg8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJbGGGsoPSom8dqavRduR9PF4RTui7NI8DhLrwk9EjB17qn0DK
 Z5/XvUCpyHn5uDJZrVwOnMUSuJPuZkXzQ12LyARwnx/z+YVg+orPaoxkp9PmX3Wb2LK5C45E1cB
 fKzxjgviJbqJlnrqk2k9u7MbYEjKcAJ9UC5t7fuuTz11Yv4mQh6UeLmHuabRfTA85/hGYwA==
X-Gm-Gg: AR+sD11zJ6jhXUY7OL4QvI2omO2kV/9FY+GIwi7rGrZhVQfS0uE+cqKjzCStqxUWmfb
 fifCzosBtsb/wZTFY6xAYTRX8+mt2uOV1X24BC+iuZ7vSK+jQ1Cu76r7GvmSkJx+Znf8NItN9ez
 rKQL9dhSNivvU5NO6uZOGaLbp3+8jnLnWyDS9pfV4K7gErvWv1nh9Yy3YuqvxkCt+gSySEVeHNN
 jwoTa6P5bUY/Q50roiWtHlF+1lO+Jy5W9OJSj1wJ4oiUK0DQNsKkLlYgpL8On0CWZjgtZOAeIGn
 CaAjj5Rd1emIO4cf7rr248L5KEaCytu36WS61O5PSHFba3aLSykyS/eYUJ8FNnXstFDE9oBV
X-Received: by 2002:a05:6214:4113:b0:90a:74d4:e4ac with SMTP id
 6a1803df08f44-90c80c5b401mr6881826d6.16.1787256092623; 
 Thu, 20 Aug 2026 13:01:32 -0700 (PDT)
X-Received: by 2002:a05:6214:4113:b0:90a:74d4:e4ac with SMTP id
 6a1803df08f44-90c80c5b401mr6880856d6.16.1787256092024; 
 Thu, 20 Aug 2026 13:01:32 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2a1139sm45835516d6.34.2026.08.20.13.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:01:30 -0700 (PDT)
Message-ID: <4ae8c1b945b83dfeafe4c89d59ec03c994242fd9.camel@redhat.com>
Subject: Re: [PATCH v3 2/4] drm/nouveau: subscribe to the channel-kill event
 after the fence context
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@nvidia.com>
Date: Thu, 20 Aug 2026 16:01:29 -0400
In-Reply-To: <20260812231330.705425-3-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
 <20260812231330.705425-3-mczernohous@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fSGdKdM0s7INqjUZUIUEQ4rvBcXGACZ0sJTmAZdW6kY_1787256093
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

On Thu, 2026-08-13 at 01:13 +0200, Marek Czernohous wrote:
>=20
> Move the subscription behind context_new() so the handler cannot
> observe
> a half-built fence context. The failure path is unchanged in effect:
> the
> caller drops the channel with nouveau_channel_del() either way, which
> since the previous patch unsubscribes before freeing the context.
>=20
> One behavioural change worth naming, and it is not free: a kill
> delivered while the channel is still initialising is no longer
> observed,
> because the subscription is not armed yet. That window does not close
> here, it moves, and on Fermi and newer it grows by the span between
> the
> old subscription point and context_new(). What changes is what the
> window costs. Before, a kill landing in it reached a half-built fence
> context; now it is missed, and the channel is left blocked with
> chan->killed still 0, so nouveau_channel_idle() and the checks in
> nouveau_gem_ioctl_pushbuf() and nouveau_exec_ioctl_exec() keep
> treating
> it as alive. The missed-kill window is not introduced by this patch
> either:
> nvkm_uchan_init() already calls nvkm_chan_allow() and
> nvkm_chan_insert(),
> so the channel is schedulable before nouveau_channel_init()
> subscribes at
> all. Closing it properly means subscribing before the channel becomes
> schedulable, which is a bigger change than this fix.

I don't think this would be a big change, actually. If I understand
this code properly, we don't need to move around the channel event init
at all. Maybe:

 * Add another atomic to `nouveau_fence` to indicate if the fence is
   ready
 * Have `nouveau_channel_kill()` check this atomic after setting the
   killed bit, and only call `nouveau_fence_context_kill()` in the
   event the atomic is set.
 * Back in `nouveau_channel_init()`, after we initialize the rest of
   the channel (we still haven't set the atomic yet) grab the fence
   context lock to delay, but not block, any incoming kills.
 * Check the killed atomic to see if a kill event came in the window
   before the fence was ready.
 * Set the atomic indicating that the fence is ready.
 * Drop the lock.
 * If we found that the killed atomic had been set while holding the
   lock, call nouveau_fence_context_kill() manually (or queue up a call
   to it if that works better with a workqueue perhaps?).

Hopefully I didn't miss anything that would make my idea not make
sense. And consider trying to write the respin without using claude!
You will learn more, the work I've done is the only reason I was able
to think of a solution like that only a few minutes after reading the
code here.

Also - it might not need to be an atomic, I'd have to look a bit more
closely to know though.

>=20
> As with the previous patch this is unreachable below Fermi today, and
> the last patch in this series lowers the gate to NV50.
>=20
> Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel
> has been killed")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_chan.c | 55 +++++++++++++++--------=
-
> --
> =C2=A01 file changed, 33 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c
> b/drivers/gpu/drm/nouveau/nouveau_chan.c
> index f142f6310596..07b0bd1bc519 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -370,27 +370,6 @@ nouveau_channel_init(struct nouveau_channel
> *chan, u32 vram, u32 gart)
> =C2=A0 if (ret)
> =C2=A0 return ret;
> =C2=A0
> - if (chan->user.oclass >=3D FERMI_CHANNEL_GPFIFO) {
> - DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
> - sizeof(struct nvif_chan_event_v0));
> - struct nvif_chan_event_v0 *host =3D
> - (struct nvif_chan_event_v0 *)args->data;
> -
> - host->version =3D 0;
> - host->type =3D NVIF_CHAN_EVENT_V0_KILLED;
> -
> - ret =3D nvif_event_ctor(&chan->user, "abi16ChanKilled", chan->chid,
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nouveau_channel_killed, false,
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args, __struct_size(args), &chan->kill);
> - if (ret =3D=3D 0)
> - ret =3D nvif_event_allow(&chan->kill);
> - if (ret) {
> - NV_ERROR(drm, "Failed to request channel kill "
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "notification: %d\n", ret);
> - return ret;
> - }
> - }
> -
> =C2=A0 /* allocate dma objects to cover all allowed vram, and gart */
> =C2=A0 if (device->info.family < NV_DEVICE_INFO_V0_FERMI) {
> =C2=A0 if (device->info.family >=3D NV_DEVICE_INFO_V0_TESLA) {
> @@ -494,7 +473,39 @@ nouveau_channel_init(struct nouveau_channel
> *chan, u32 vram, u32 gart)
> =C2=A0 }
> =C2=A0
> =C2=A0 /* initialise synchronisation */
> - return nouveau_fence(drm)->context_new(chan);
> + ret =3D nouveau_fence(drm)->context_new(chan);
> + if (ret)
> + return ret;
> +
> + /*
> + * Subscribe to the channel-kill event last.=C2=A0 The handler
> + * dereferences chan->fence, and the fence context is only complete
> + * once context_new() has returned: the backends assign chan->fence
> + * from kzalloc() before nouveau_fence_context_new() initialises the
> + * lock and the pending list, so an event arriving in between would
> + * find a non-NULL but unusable context and walk a NULL list head.
> + */
> + if (chan->user.oclass >=3D FERMI_CHANNEL_GPFIFO) {
> + DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
> + sizeof(struct nvif_chan_event_v0));
> + struct nvif_chan_event_v0 *host =3D
> + (struct nvif_chan_event_v0 *)args->data;
> +
> + host->version =3D 0;
> + host->type =3D NVIF_CHAN_EVENT_V0_KILLED;
> +
> + ret =3D nvif_event_ctor(&chan->user, "abi16ChanKilled", chan->chid,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nouveau_channel_killed, false,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args, __struct_size(args), &chan->kill);
> + if (ret =3D=3D 0)
> + ret =3D nvif_event_allow(&chan->kill);
> + if (ret) {
> + NV_ERROR(drm, "Failed to request channel kill notification: %d\n",
> ret);
> + return ret;
> + }
> + }
> +
> + return 0;
> =C2=A0}
> =C2=A0
> =C2=A0int

