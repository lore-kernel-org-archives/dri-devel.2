Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEA5C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E5ED10E35D;
	Wed, 12 Aug 2026 23:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zzh2eTsI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E450610E35D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:25:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0301C600AD;
 Wed, 12 Aug 2026 23:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BEA1F000E9;
 Wed, 12 Aug 2026 23:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786577139;
 bh=qLz3oSSruVt+aMIr5fsGRqxGKBKdmo8NGQTntvzjE5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zzh2eTsIwn6VFTsXvEH0JtlE7uls9eZAYPvjZ0eJ0eADHp99bwf3yXmWOJ63g/lpZ
 nkLXSpP2Iy9yA5osZKDaCz6u2JeZqYVykL79/XreIcJKInGFlntnA3LNwSc0lTv0pl
 DaJ5nXYzoh+GSuAlgL+3x7Ud8z6xnmXuDP7J41Di+7uuptX5Jb+9uJ6zs/JMqf9h4D
 6o3bZGl3htoCCxjO2BvEwb0WpgFp9lmSfUk1w+ot1+mCQgc6mXjBZH0gM/cp02hRMV
 1JPqPnbpHKaaUA4V2rmM3I/O8gbedclB8kl2tKE1wJjXmHZBHHRxUr+eS7f0h15dJI
 MQWY/Uv0AtrbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] drm/nouveau: subscribe to the channel-kill event
 after the fence context
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812231330.705425-3-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
 <20260812231330.705425-3-mczernohous@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:25:39 +0000
Message-Id: <20260812232539.83BEA1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Teardown symmetry bug in `nouveau_fence_context_del` can lead to U=
AF of `fctx` via a rescheduled work item.
--

--- Patch [2]: [PATCH v3 2/4] drm/nouveau: subscribe to the channel-kill ev=
ent after the fence context ---
commit 0d333033075f8f241623e82cf6a4863bcbfcda8f
Author: Marek Czernohous <marek@czernohous.de>

drm/nouveau: subscribe to the channel-kill event after the fence context

nouveau_channel_init() arms the channel-kill subscription early, right
after mapping userd, and only creates the fence context at the very end
of the same function. The handler it installs, nouveau_channel_killed(),
reaches nouveau_fence_context_kill(chan->fence).

> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nou=
veau/nouveau_chan.c
> index f142f63105966..07b0bd1bc519f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
[ ... ]

While reviewing this, I noticed a pre-existing issue in the fence teardown
sequence:

drivers/gpu/drm/nouveau/nouveau_fence.c:nouveau_fence_context_del() {
	cancel_work_sync(&fctx->uevent_work);
	nouveau_fence_context_kill(fctx, 0);
	nvif_event_dtor(&fctx->event);
	fctx->dead =3D 1;
...
}

[Severity: High]
This is a pre-existing issue, but does this teardown order create a
use-after-free risk for fctx?

If userspace emits a fence with signaling enabled and then immediately clos=
es
the channel, nouveau_fence_context_del() is called. It executes
cancel_work_sync(&fctx->uevent_work) before stopping the event source.

If a hardware interrupt for the fence fires immediately after
cancel_work_sync() returns but before nouveau_fence_context_kill() blocks t=
he
event, the interrupt handler nouveau_fence_wait_uevent_handler() will execu=
te
and call schedule_work(&fctx->uevent_work).

The teardown sequence then continues, freeing the fctx memory via
nouveau_fence_context_free(). When the asynchronously scheduled work execut=
es
later, nouveau_fence_uevent_work() accesses the freed fctx, resulting in a
use-after-free.

Should the event source be blocked or destroyed before synchronizing the wo=
rk
cancellation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812231330.7054=
25-1-mczernohous@gmail.com?part=3D2
