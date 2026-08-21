Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B794C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F418310F307;
	Fri, 21 Aug 2026 15:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z/y22Gub";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F0B10E30D
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:23:09 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c15b51ba80dso10835866b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787325788; x=1787930588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:cc:to:subject:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YGnVjNNQSxXEhjGwV8/5Y2JvucgSZxjVxoUzS+hSzcQ=;
 b=Z/y22Gub4YgjAxwD5wHrDelj+d7iCI5pbMLgW1kpp2J5Fw2pFLHdzchlp1V4YhGfmQ
 7uNSYgdUc/7jP/4fUmn0ECXdq6qMzhZv0t52bVU/CT5GupGn/t0IrMs087xZhO6OqeIz
 VYXxLBx84UqD901tFleqiUq0Se8OTDBFYN7xs4gibTh153gUcozHW16A03S7Up49tyRk
 P+HjBWry5hH8uSDQXYV2Y5tBc0VRs+XKiIrtCwhg8LG0BhsCE1JeJgKTFSv+x0hN+7lc
 vuHQgpjXz8SA8jEYvJQ8dikxfECjIf/D3hrekU5k174wmhk6cMeXGpXE6z3m/wN3Fy+9
 hKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787325788; x=1787930588;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:cc:to:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YGnVjNNQSxXEhjGwV8/5Y2JvucgSZxjVxoUzS+hSzcQ=;
 b=KcWn1NOfUgvt9MLrgzPHCMc1Ce1YR3C7sGqFlJ4tQFEKfeZ6Cm8UyxngEgF64LCj3f
 A97U5JnBrQ/UK8H/PRwr/HJ60NAtdBHZ25erAhOlrgl+xTPdFeWG+56C54DRYstZLor2
 +G9VD2WGfJZHARaN3krPkEvLOvqSwBezFJ1btRrTq/jOZLKNKfJQnkqOSrXxGyVmveFm
 FCLgkibwdW7Ika48ZZ8eAdOAHRJhhWcHPfr8NNq+PBNoqIEGFXS0ZQsr0LOX0I9Haghl
 n912Kr/dQjNqeXGYaLfBO1V1cBLKkfSS27uYQv/BPcY+BnUStkcSeK4MOtozZOnVAM7o
 Qecg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsD/vipFqykY5hOyAA8Y1xguJkxzWJEW/XOV8Jd89JrFQuVv2BkxozAvVvUGdKmz2YdbnuHD9lYVA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nICSFi8v9F9dwTjfc2KSLD2gwV7Up4KA6ulR3YZOtuWm0QOD01
 qL83IUSAey/dsvtE8HEE4JtRSGaLUY6MwG9NgOtFNa98Hvqmwypy+C/3
X-Gm-Gg: AR+sD10Hywd2rlnWs9WO7unYU0NjTWR+ZVOfIN0PmkBz3Ib/hRo+Beh0o3QMg0AX9md
 oL1UWCtPRvQ7v5i9zyyaC3mzH9mWfYWBpdePMHwloueAs7n+L0MpXTwpeNHN8E3eKaGdgDa7Jya
 aXWqGyBdtlnzm1bBJSCPZRT+fNF+YekVqUBptQnESWJvEy/BvKWfUXOEeVZcoal+MWtC4wQjh4O
 eOmCevnWBQd8oU6Q1ncwcy9/VtLokGCPQYVxwVs58oZCoLKmLZg7eBhQhuO5zOnH/NgwsTZJ6vh
 sBfrOAPYYEHYhxZD24ZLlufghkOy+hA8Mw+74MMsgqJlfhZkW3vpoFsKJ1rUUoRSTXe1HTzi4fG
 La8CkqVfY3saTapG0HyQGZn5k4R7blFiLH3EmmScOl59XF/wz6DCFW8v8cMJFJtQunR51T5JPgv
 aKGHcR2zSsyS1FGyH+rjDnIWtvbZEjOuhncCFeXNNE77V5eo4UbqReNAVv169XCJLdpZjOcIt7L
 +QlWtHaJqn6JyfSt9TofMUzHnlyvZz5cAmTTaKKiA==
X-Received: by 2002:a17:907:6d20:b0:c15:9f0c:8d31 with SMTP id
 a640c23a62f3a-c246a5f67f3mr391862066b.2.1787325787404; 
 Fri, 21 Aug 2026 08:23:07 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591dc662sm506198566b.42.2026.08.21.08.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:23:06 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
Date: Fri, 21 Aug 2026 17:23:01 +0200
Subject: [PATCH v4 1/3] drm/nouveau: unsubscribe the channel-kill event before
 the fence context
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>
Message-ID: <178732578167.167481.14789825868710929167@gmail.com>
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
Reviewed-by: Lyude Paul <lyude@redhat.com>
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


