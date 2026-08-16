Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47665C5DF6E
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 12:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB9710E2BE;
	Sun, 16 Aug 2026 12:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r9Ar92Ar";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF9810E2BE
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 12:58:56 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495773ee3edso2290725e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786885135; x=1787489935; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jTmygf1/JyUF8FN6We5SdcT/ctQ4+SGdYMt719yqvrw=;
 b=r9Ar92ArOUFm7uFSAEXjQdHE6a8jPY4UetDLXBPRs0ykhjgw5Mxgp1AuWYEN3LlDj1
 0CeWqHMFr08MOmYGNtMiZ+e0pFF9z5dBq+W8VnAkuQpvCHwG7ag52hJ+zmqgS7POPoqP
 1I+sLUhwM2zQUdPkgUunZ4H5SyCsyJn+avRvCfiOxBypeYfaCBmYTVVO4y6UmiIVRkkT
 cdwpI+hNESumvXzTqOiYt8YzRihZx9/jGO80EGnIaSuMpfX4xWdRmZs63Y8W0v4QK7/u
 LcN9mjZhx1GZfmY/semiTevh1pitdsCHPdcibjDQ+EH5gKw+n0CJXPiSFltYJr/CT2wL
 jRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786885135; x=1787489935;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jTmygf1/JyUF8FN6We5SdcT/ctQ4+SGdYMt719yqvrw=;
 b=GQZkYOP3ilqjbX6EfDJn8jUF0W0OMNyXARw5AX3hBYzLT7HakSFQeOaseWhtKDUUIf
 j2d7EUvoBvgcXggW8uUCCVMPOwaO1MJ+gpAoPfDgnsHuRdPVaT+9UuY6Xp+FKQ3j8e0J
 t+aQ0EAA5mAbOPqiay83z6D2g7TnZQTItihx13GvRfeUaojsMWFphZ3PDowBJDvtRGS5
 WLQaNo1/slks/XXy5YRzHpw1QkXLemrqnlfzQVwwXH5uA5CeHQaD086+/0Qeq7+wW2kE
 NF7LD5/V23xs07Z6737BMsQiVn2oR17ZYcapcgXO3Gul08Lt+oFn6h+OVCMAQpm0ySFg
 hXqw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqpo2OZS3mLlBqAblF/5kzIGWxn3jUBbEgBeMzaJw5toJzj+zGhItkut8nwb3sNJQi2peHCpfSYbwU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/Qq9LlXU4in5MbEGutlqMpnDD1eyCLU2tmF6x+oysVjhuhktI
 Omh3fDLkCBpC8xEHHBwxW+N6XbE15bxU8oxfieSqdXBPWtFHAkDsldW/
X-Gm-Gg: AR+sD12vBBy+1+8Hx2bfWuTHBg284X3cwRni8RsHn/a+SFncXrAMVuApB5Dq8NjBx2r
 TqxyLNMpW55FdPynH2EWJfIIkqfGmc478SaomPUt5euY0xuzJfbzjV6s1F9yXejzmuWruHAIaEv
 7ZRYzW2ovNB7JX66BOiDjdrL7pYg+FbyzKpbaBiNVbUpF7DDPcjPl7F1PTc/n6ujgykCbyvRClw
 aC5QJ6rNSP0R/0Wiabe0a2msBIzFdNNJdn0kftfkcfS7S8BIodrrJuRDpLmcz+XxP1oNF6CaNFJ
 Vhw/DMCLBS/WbYfXvYcgbiyuV4BbBAeX+qQOXArF1+JClpzj6Bi3HoDk3sBxsFC6v2bf7uyJ4FZ
 1OTNqX5vaw6pGlw+puChL8ll9IoowDDo4qXTotang7Ax5Yj2UrIYPvn60ojGykaGZbK9tIAP+Mj
 MWsVxaDc1kPwT3ENhP2ByDEf0dV0LNVfk9zkTlx1ljwO4GaAA2eia4zPOFRc2V4JxWk9nSfBDeu
 LIAfNZU+VywBjQOK67ChaasucfWEQZIrz8A4U4cgQw=
X-Received: by 2002:a05:600c:358d:b0:493:bea7:6b67 with SMTP id
 5b1f17b1804b1-49987960f4bmr160582535e9.3.1786885134413; 
 Sun, 16 Aug 2026 05:58:54 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm108278675e9.13.2026.08.16.05.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 05:58:53 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/nouveau: disable the fence uevent work instead of just
 cancelling it
Date: Sun, 16 Aug 2026 14:58:52 +0200
Message-ID: <178688513268.513871.3468844663561639695@gmail.com>
In-Reply-To: <178682366002.3748010.12779628082366287968@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.12779628082366287968@gmail.com>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

From: Marek Czernohous <marek@czernohous.de>

nouveau_fence_context_del() drains the uevent work while the event that
feeds it is still armed:

	cancel_work_sync(&fctx->uevent_work);
	nouveau_fence_context_kill(fctx, 0);
	nvif_event_dtor(&fctx->event);

nouveau_fence_wait_uevent_handler() queues the work unconditionally:

	schedule_work(&fctx->uevent_work);
	return NVIF_EVENT_KEEP;

so a non-stall interrupt arriving after cancel_work_sync() has returned
re-arms the work that was just drained.  The window closes in two steps,
neither of which is the drain.  The kill blocks the event when the last
fence holding a notify_ref is signalled, which reaches
atomic_xchg(&ntfy->allowed, 0) (nvkm/core/event.c:104), and
nvkm_event_ntfy() skips a ntfy that is not allowed (:183).  That stops
further handlers from starting, but not one that is already inside
nvkm_event_ntfy(): the event is created with wait = false
(nouveau_fence.c:201), so nvkm_event_ntfy_block_() leaves it on the list
and never takes event->list_lock.  Only nvif_event_dtor() waits that one
out: nvkm_event_ntfy_del() (:141) goes through nvkm_event_ntfy_remove(),
which takes write_lock_irq() on that same list_lock (:84).

Either way the re-arm happens after the drain, and the caller drops its
reference immediately afterwards, for example nv84_fence_context_del():

	nouveau_fence_context_del(&fctx->base);
	chan->fence = NULL;
	nouveau_fence_context_free(&fctx->base);

That is a kref_put() on fctx->fence_ref, so the context outlives the
teardown only while emitted fences still hold a reference of their own.
That is no safety net: whenever none do, the count reaches zero right
there and nouveau_fence_context_put() kfree()s fctx while the work is
still queued.  &fctx->uevent_work is embedded in that allocation, so the
workqueue already dereferences freed memory when it picks the item up,
and nouveau_fence_uevent_work() can then take fctx->lock on it.  With
CONFIG_DEBUG_OBJECTS_WORK and CONFIG_DEBUG_OBJECTS_FREE, kfree() of a
still-queued work item is reported as the free of an active object.

On live memory the re-armed work has nothing left to do:
nouveau_fence_context_kill() empties fctx->pending and sets fctx->killed
under fctx->lock, nouveau_fence_emit() then returns -ENODEV rather than
queueing anything new, and nouveau_fence_update() only reaches
nvif_event_block() if it signalled something off that list.  The defect
is the access to freed memory, not what the work would have found.

Only chips from G84 on can reach this at all: nouveau_fence_context_new()
returns before nvif_event_ctor() when priv->uevent is clear, and
nv84_fence_create() is the only place that sets it.
nv84_fence_context_del() is the context_del for all of those, because
nvc0_fence_create() and gv100_fence_create() build on nv84_fence_create()
and override only context_new.

Use disable_work_sync() instead.  It drains the work exactly like
cancel_work_sync() does, and additionally increments the work item's
disable count, after which "any attempt to queue @work will fail and
return %false" (kernel/workqueue.c, disable_work()).  The handler's
schedule_work() then has nothing to re-arm, and the teardown order stays
as it is.

Draining a second time after nvif_event_dtor() would close the window as
well, and without the newer API: once nvkm_event_ntfy_remove() has
returned, no handler can start or still be running, so nothing re-arms
the work past that point.  disable_work_sync() is preferred here because
it needs one synchronisation point instead of two, it keeps the work
from being queued at all rather than cleaning up after it, and it is
what drm has settled on for this (drm/xe, drm/panthor, drm_pagemap).
Blocking the event rather than the work is not an option: fctx->event is
created with wait = false, so a handler already inside nvkm_event_ntfy()
can still queue the work.

Note for backports: disable_work_sync() arrived in v6.10 with
commit 86898fa6b8cd ("workqueue: Implement disable/enable for (delayed)
work items"), while the fix being corrected here reached 6.6.18 and
6.7.6.  linux-6.6.y therefore carries this bug without the API, and this
patch would apply there and then fail to build.  A 6.6.y backport wants
the second drain described above instead, as its own patch.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/nouveau/20260812231330.705425-1-mczernohous@gmail.com/
Fixes: 39126abc5e20 ("nouveau: offload fence uevents work to workqueue")
Cc: <stable@vger.kernel.org> # 6.10.x
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---

Changes in v2:
 - Do not reorder the teardown.  v1 moved nvif_event_dtor() ahead of
   nouveau_fence_context_kill(); with the fences still unsignalled that
   leaves nouveau_fence_enable_signaling() reachable, and
   nvif_event_constructed() is a plain unlocked read of object->client,
   so the dtor could race an nvif_event_allow() already past that check.
   Reported as [Critical] by the bot, and withdrawn:
   https://lore.kernel.org/all/20260815200914.8A1131F000E9@smtp.kernel.org/
 - Change cancel_work_sync() to disable_work_sync() instead, which leaves
   every ordering alone.
 - Pin the damage down.  Both versions call it a use-after-free; this one
   adds that &fctx->uevent_work is embedded in the freed allocation, and
   that the re-armed work has nothing left to do on a live context, so
   the access to freed memory is the whole of it.
 - Correct the backport note.  v1 claimed no longterm tree sat in the gap
   between the bug and disable_work_sync(); 6.6.y does.  The stable tag is
   annotated accordingly.

This replaces 1/3 of
https://lore.kernel.org/all/178682366002.3748010.12779628082366287968@gmail.com/
2/3 and 3/3 of that series are unaffected and still stand.

 drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08ba0f..11e95c37ce50 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -96,7 +96,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 void
 nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
 {
-	cancel_work_sync(&fctx->uevent_work);
+	disable_work_sync(&fctx->uevent_work);
 	nouveau_fence_context_kill(fctx, 0);
 	nvif_event_dtor(&fctx->event);
 	fctx->dead = 1;

base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.54.0

