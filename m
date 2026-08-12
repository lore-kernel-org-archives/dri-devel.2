Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9F2C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD9910F158;
	Wed, 12 Aug 2026 23:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tu1feQhY";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D37C10E486
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:13:35 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49967f24eedso2865745e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786576414; x=1787181214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEqCe/HJ702G2+cOJ6AJfXRuzYV9ZGHajSHLyVpChGo=;
 b=Tu1feQhYvwAsDgMvzz6UgcveQYzfU7m4OPehVi862PJM/jkpnj/js4r8WITR8iAG+B
 nHvA2D7MLXPnp5fb56eU7mIkn8JGUBWsv/L7P6ptPCQngVK3LK/p3jTKVSYHH54TncxU
 ZPxjYAbRlmxRHYQNwdjsiqx9wQVM6XVzUIx36T3bxJppGn9xg0Z8XdqUpvkUrQUWeGDN
 E88swdTKY0wPy16XiGJwIACuZqfXXIi/5NCiictHWjpRvXzwY1CExQAIQSq6pbvlHoJM
 h66lViZM/1AWL0y6bz4mCX8Nv4J+IFZ2Y1tAw9db8p2XjxLCikRL6buec1CY3qMYIy0F
 emsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786576414; x=1787181214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AEqCe/HJ702G2+cOJ6AJfXRuzYV9ZGHajSHLyVpChGo=;
 b=sD7Gr0TS2g7heHDYz1XQ9ZVeCP+3RFm5EBEDelPkBstDmMC2xFUoS9A9jiZFjMjsfo
 PvssuSNsvX0WmmdW/ukN/TTtnP1aRY7GIDVqvvMlYaA532vU5wGSLcwxqfvspStdO+5w
 tyGpjFXaYL1HM9lNn5719PWLHS4YDVMcb8ASvUlCWkOSmd3OVbCq4Dq05syML4WWpv31
 o9BD1njbXNsYM45YAusyqMcbVtlpVpNJDL8jSV2PuNzAYZJcud9GebFizx5a33MZH/ll
 KOluK5Wy2xPkfZRr8Nld47eUBgVlOZJOrWtYzGQIyFTdEqqypv/yKo51Xj6gSN3/Co8F
 jDVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZZ1w6xxBIL0ykQhb5PvKf202YEYsg+EHDsP0Yb+Y5ZFV7YGxIluv0hsZlI9HIWkrKbHtOtaVE0PA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHKwr606hwPW63A9+yswMQG89H357X17qE4YCqx+WjzIul51Me
 p6RllCSyrP+bd3eM4A1SSwjxswzX/ftbWHwNPKKG+mVDIfAniMXmrfdr
X-Gm-Gg: AR+sD13prxR4nJWg0eO0qrdmovVSMwrOEkqbE6r4o0rk9Bfb7AyS822YAIHrv7bxzI3
 oaC1nbhyaTt1AjfDSiJs0e3OwhmA7ICDk5gQHBUYucEaZjrjmc14YwgZCNYqhj3rMopweuDf1LN
 5JKKmJuI9Pn6LljjZ32OWyDI/ksjHAWGYHW4mVCC2NNvjl7nvREiWFnXMdkGRjHzGakOynur5j4
 ve4hAH1X1QZylROmMNDm0fgh/XA1Wu5IXsyPiwAhU5f6gAEaqQlsmMB9cPTFdi/eEgxrNEIUJbg
 OX4mTpVsthrO732aRSBoC/2fwZDnzJGGsUW1+rGVJnBGrx6ww7LT1+s5BZyldZPuil6HFA+2ciy
 +470JHamKXMyx9KaHW56/Nu8y6SkVjLJ668WKDnhj6zxzTXoSStHYey/j8/4iBYZtZPW7aw4fko
 sZQdkoMElGVOR3oJMuXIJ2w7thZNs5jVVBz5chhhGZu2yx83z8mlTnE8M9ZNPrXyybvkKAcWG2I
 uJ/wXKCXVwk0mMa04ldf/xtf2IphsimeWePwE/ABR9TrMGvlQmnBPBMkRagi0Ax9w==
X-Received: by 2002:a05:600c:a05:b0:495:7561:a9cc with SMTP id
 5b1f17b1804b1-499821e762dmr6690785e9.4.1786576413605; 
 Wed, 12 Aug 2026 16:13:33 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm44532245e9.14.2026.08.12.16.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 16:13:33 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>
Subject: [PATCH v3 1/4] drm/nouveau: unsubscribe the channel-kill event before
 the fence context
Date: Thu, 13 Aug 2026 01:13:27 +0200
Message-ID: <20260812231330.705425-2-mczernohous@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812231330.705425-1-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
MIME-Version: 1.0
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

From: Marek Czernohous <marek@czernohous.de>

nouveau_channel_del() tears the fence context down first and only drops
the channel-kill subscription later, in the middle of the nvif object
teardown:

	if (chan->fence)
		nouveau_fence(chan->cli->drm)->context_del(chan);
	...
	nvif_object_dtor(&chan->vram);
	nvif_event_dtor(&chan->kill);

The subscribed handler is nouveau_channel_killed(), which calls
nouveau_channel_kill() and from there nouveau_fence_context_kill() on
chan->fence. A kill event delivered in that window takes fctx->lock and
walks fctx->pending on a fence context that context_del() has already
freed.

Nothing reaches this below Fermi today, because the subscription is
gated on FERMI_CHANNEL_GPFIFO and nothing kills a channel there. On
Fermi and newer the window is real but narrow, since a kill has to land
exactly while the channel is being destroyed. That is reason enough on
its own, which is why this carries a Fixes: tag. The last patch in this
series subscribes Tesla channels as well; nothing kills those today, so
it does not widen the exposure now, but it is the groundwork for a
recovery path that would, and the ordering is better fixed before that
lands than alongside it.

Drop the subscription before anything it depends on is torn down.

Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 598513f60449..f142f6310596 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -90,6 +90,14 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 {
 	struct nouveau_channel *chan = *pchan;
 	if (chan) {
+		/*
+		 * Drop the kill-event subscription first.  Its handler
+		 * dereferences chan->fence, which the fence context teardown
+		 * below frees, so leaving it armed across the teardown leaves
+		 * a window for a use-after-free.
+		 */
+		nvif_event_dtor(&chan->kill);
+
 		if (chan->fence)
 			nouveau_fence(chan->cli->drm)->context_del(chan);
 
@@ -100,7 +108,6 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		nvif_object_dtor(&chan->nvsw);
 		nvif_object_dtor(&chan->gart);
 		nvif_object_dtor(&chan->vram);
-		nvif_event_dtor(&chan->kill);
 		nvif_object_dtor(&chan->user);
 		nvif_mem_dtor(&chan->mem_userd);
 		nouveau_vma_del(&chan->sema.vma);
-- 
2.54.0

