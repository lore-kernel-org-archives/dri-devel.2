Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FB2C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F6D10E30D;
	Fri, 21 Aug 2026 15:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MkE4Lcu2";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E954910F31C
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:23:12 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c1676497000so12243266b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787325791; x=1787930591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:cc:to:subject:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vYeEFSz/we+8LtDsD3eJWBaG2LH+3C5IKZLmMvYVchk=;
 b=MkE4Lcu20P3nbKBTVvbv+P+o+lO0ADxQZfj2cQejOubfdG+80HZFM2R0XYZuZtVYo1
 0OINcrTeYAkmMwniuH3eni/Kgrv3pgVzFPNqNpCBsifb4OvooOG2+Msemph+cNO7+cgk
 RYCIqXvJWpRE83VszBska0P/GJCIBGdEBbplxrlKBmPLITrCpIeKkXNxjBzS9XuK79ph
 FLT+E7UtSQq9bpoXDmf1FtsdqlPyW+t7LSfs78Hfztw9GLjd6QeeEu+Rqx/EtTodXT9Z
 o3T5gYLwnITE2b2/gOApy/EoQYTEPORLEjoUrF8ns1h8vZrh5/RWTY1/g/p8hcR3Nm1r
 2u1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787325791; x=1787930591;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:cc:to:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vYeEFSz/we+8LtDsD3eJWBaG2LH+3C5IKZLmMvYVchk=;
 b=rbFtp7w9s3KVGWWe97wKGODTBn1xJzF8TDViDzhIvB1EPzYiWl5G8Wouc14ChUNfPP
 f3AQtgwTbArXucoIc1CHanvXkXtbHfnWUknKSwmtgZ9w/I2L7jrglEEgPgysC26EMbXZ
 zOTIJcbajkwb8Xqc2MHLk2wWiH1khCaBU597PAE6iJU0wUC+RIvSSMHGvdnfvuV6Y6Vt
 Dp41gHnZIynBRTp+PuSpzB5dZBjbSAr/1E2JwWrQIuu+wxPgX/fit91UXuubgUUbIynH
 ylbinGj/yJJjVn02c+ezdyg46EJZit41H2v0mC32aEmn8LN8+7MADaSO07sJ8rZsn3DS
 /oTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhSlSIw+EHlU8ryo8407er/tCBXrMTgXg8RX7FyJWKtxnoHnAx7HKFYgvCkUD6BFplOS+VB1/CeQU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mSG3D3a5ANqEgzuKQVVNCNPxY1adza/qrArxyZgCoUX+44Dt02
 GvtvSgv31LdRS7YS620A5QFKZeMLIZ4+yPPHUn/anmc+r4f6QUuMn87AbG6uLTtu
X-Gm-Gg: AR+sD12R+KGLHpMsrx4Acb2T1EH2CZkwzlnqwX1RqntcJ1yLtFEBsaKl2wRTwufePmh
 c0x8mlRHCVQEPVlm4JrRJs4sWH2s4AUIGwz0VpfR86q91YNG7WVLYlS6htKwSrquRZO9PsFAGDN
 DU8li96fuXgNPYfPwVAe4UlCxUWBL7InzKgH2lfPaXpwHFV4Wx51zn9C/05Jz+qImWBy0ift6cX
 hUJE/i/KgouwXyIc7LUfKaCoX087Bi4812ivdSh5JFXqS3uTcuosDAu7V4WzqumVPYOlNu1zQ2/
 Xur8aSdN7xJZY3qthGDAApRrdpCfxou3fkfhYE05XqRe4NV08IhalLBHh4Eiw2IeBMmUf2iJPIr
 NEZIx8zCJnUNCNUDaCygGADKjI2Prm1GKTlyGINOD2iQOoBc6xws6mTrizJOLSDpSFmTLE7PVFQ
 LubFDE3vMXfoWQ8EWiROifV1ubSkN3nh5LnsvdNKWO9n3OQy6YJ4vPAj3ewruaozZiCEv6CwQc5
 18ZHDgzyjMANTXlsR8aqk+JHqGD1yJtuQlQemuKeQ==
X-Received: by 2002:a17:907:84e:b0:c20:7897:bc67 with SMTP id
 a640c23a62f3a-c246a6a8e0bmr384314166b.3.1787325791134; 
 Fri, 21 Aug 2026 08:23:11 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591dc662sm506198566b.42.2026.08.21.08.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:23:10 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
Date: Fri, 21 Aug 2026 17:23:01 +0200
Subject: [PATCH v4 2/3] drm/nouveau: don't kill a fence context that is not
 ready yet
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>
Message-ID: <178732578167.167481.4590474568281802870@gmail.com>
In-Reply-To: <178732578167.167481.5619512544301226563@gmail.com>
References: <178732578167.167481.5619512544301226563@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

nouveau_channel_init() arms the channel-kill subscription early, right
after mapping userd, and only creates the fence context at the very end
of the same function. The handler it installs, nouveau_channel_killed(),
reaches nouveau_fence_context_kill(chan->fence).

The NULL check in nouveau_channel_kill() does not cover the window in
between. Every backend that can reach it publishes the pointer before the
context is usable:

	fctx = chan->fence = kzalloc_obj(*fctx);
	if (!fctx)
		return -ENOMEM;

	nouveau_fence_context_new(chan, &fctx->base);

and nouveau_fence_context_new() is what runs spin_lock_init(&fctx->lock)
and INIT_LIST_HEAD(&fctx->pending). An event arriving after the
assignment but before that call finds chan->fence non-NULL and unusable:
nouveau_fence_context_kill() takes a lock that was never initialised and
walks a list head whose next pointer is still the NULL left by kzalloc().

Give the fence context a ->ready flag and hand the kill over through it.
nouveau_fence_context_arm() sets the flag once nouveau_channel_init()
has finished building the context, and nouveau_channel_kill() leaves the
context alone until it is set. A kill arriving while the context is
still being built is no longer lost either: it is recorded in
chan->killed, and nouveau_fence_context_arm() acts on it as soon as
there is a context to kill.

The two sides hand over rather than exclude each other, because the kill
side must not touch fctx->lock at all before the context is built, which
is the very bug being fixed. Each stores its own flag before it loads
the other's, so at least one of them observes the other. Both observing
it is harmless: nouveau_fence_context_kill() then walks a list the first
caller has already emptied.

This does not close the other window. A kill delivered before
nouveau_channel_init() subscribes is still not observed at all, and
nvkm_uchan_init() makes the channel schedulable before that point.
Closing that one means subscribing before the channel becomes
schedulable, which is a larger change than this fix.

The approach is Lyude Paul's suggestion. It is implemented with two
differences from the sketch, both following from the same detail.

The sketch checks chan->killed before setting ->ready. Both sides have
to store their own flag before loading the other's, or the interleaving
loses the kill: arm() reads killed == 0, kill() sets killed and reads
ready == false, arm() then sets ready, and neither calls
nouveau_fence_context_kill(). That outcome is reachable under sequential
consistency, so no barrier can forbid it and the two accesses have to be
the other way round in program order. Swapped, and with the smp_mb() on
each side, this is the store-buffering pattern of
tools/memory-model/litmus-tests/SB+fencembonceonces.litmus.

The sketch also holds fctx->lock across the handover. The kill side
cannot join it, because reaching fctx->lock is exactly what has to be
avoided until the context is built: on those backends chan->fence is
published by the allocation, before nouveau_fence_context_new() calls
spin_lock_init().
So ->ready is read outside the lock. That answers the open question in
the sketch as well: it does not have to be atomic_t, but it does have to
be published with release and read with acquire, so that a caller that
sees it set also sees the initialised lock and list.

Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Cc: stable@vger.kernel.org
Suggested-by: Lyude Paul <lyude@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c  | 19 ++++++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 19 +++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fence.h |  8 ++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index f142f6310596..605ce74c0d15 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -43,9 +43,17 @@ module_param_named(vram_pushbuf, nouveau_vram_pushbuf, int, 0400);
 void
 nouveau_channel_kill(struct nouveau_channel *chan)
 {
+	struct nouveau_fence_chan *fctx;
+
 	atomic_set(&chan->killed, 1);
-	if (chan->fence)
-		nouveau_fence_context_kill(chan->fence, -ENODEV);
+
+	/* Pairs with the smp_mb() in nouveau_fence_context_arm(). */
+	smp_mb();
+
+	fctx = READ_ONCE(chan->fence);
+	/* Pairs with the smp_store_release() there. */
+	if (fctx && smp_load_acquire(&fctx->ready))
+		nouveau_fence_context_kill(fctx, -ENODEV);
 }
 
 static int
@@ -494,7 +502,12 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 	}
 
 	/* initialise synchronisation */
-	return nouveau_fence(drm)->context_new(chan);
+	ret = nouveau_fence(drm)->context_new(chan);
+	if (ret)
+		return ret;
+
+	nouveau_fence_context_arm(chan);
+	return 0;
 }
 
 int
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08ba0f..2fed631d44ba 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -93,6 +93,25 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 	spin_unlock_irqrestore(&fctx->lock, flags);
 }
 
+/*
+ * Declare a finished fence context killable.  A kill can arrive while the
+ * caller is still building the context, so this and nouveau_channel_kill()
+ * hand over through fctx->ready and chan->killed.
+ */
+void
+nouveau_fence_context_arm(struct nouveau_channel *chan)
+{
+	struct nouveau_fence_chan *fctx = chan->fence;
+
+	/* Pairs with the smp_load_acquire() in nouveau_channel_kill(). */
+	smp_store_release(&fctx->ready, true);
+	/* Pairs with the smp_mb() there: store-buffering, one side always sees the other. */
+	smp_mb();
+
+	if (atomic_read(&chan->killed))
+		nouveau_fence_context_kill(fctx, -ENODEV);
+}
+
 void
 nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
 {
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.h b/drivers/gpu/drm/nouveau/nouveau_fence.h
index 183dd43ecfff..d9fede5dcba6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.h
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.h
@@ -53,6 +53,13 @@ struct nouveau_fence_chan {
 	struct work_struct uevent_work;
 	struct nvif_event event;
 	int notify_ref, dead, killed;
+
+	/*
+	 * Set by nouveau_fence_context_arm() once the context is complete.
+	 * Read without fctx->lock, which nouveau_channel_kill() may not
+	 * touch until it is set.
+	 */
+	bool ready;
 };
 
 struct nouveau_fence_priv {
@@ -71,6 +78,7 @@ void nouveau_fence_context_new(struct nouveau_channel *, struct nouveau_fence_ch
 void nouveau_fence_context_del(struct nouveau_fence_chan *);
 void nouveau_fence_context_free(struct nouveau_fence_chan *);
 void nouveau_fence_context_kill(struct nouveau_fence_chan *, int error);
+void nouveau_fence_context_arm(struct nouveau_channel *chan);
 
 int nv04_fence_create(struct nouveau_drm *);
 int nv04_fence_mthd(struct nouveau_channel *, u32, u32, u32);
-- 
2.54.0


