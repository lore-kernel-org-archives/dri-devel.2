Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EE6C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F25110E5A9;
	Sat, 15 Aug 2026 19:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="moa2rCJo";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA8A10E5A9
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 19:54:26 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4955c545a94so2594075e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786823665; x=1787428465; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FxobjEeJRawVMzSAB2ltdXyzVXZZsToR6chxQbXYXeo=;
 b=moa2rCJo+WIptiTWUHkZHQ9A0olY8ROLj7OEch7IAUYFwvenbu6a+qUcopNGZpNMDO
 PE6L8Micmv3kuLDTU0pqjlYRJ3/uUwDojz3PMsRXJ6cqYliVoN2LuLTiAMb9AVw7powe
 wcFHGpPHTtGdj1Ed6KOiyHELrQbJhKsS5rsJ4vQxTdu6pfbdNI3rdWQHK9TgH6FJCwYm
 YyE2x6O/yijTbZl/IHpFTgZEIXFveiNCfzOy5PEkxZ8wclx9tG2wH8v4cZ0zgYGb1GhC
 qaju6OTyYHR2IOKM3UFyK3j+VbVhcGsiV+pbzMdy93K1ySYeugCwvGPaqbQwb7agJpYz
 Gjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823665; x=1787428465;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxobjEeJRawVMzSAB2ltdXyzVXZZsToR6chxQbXYXeo=;
 b=EWMqEGTQlrEIfIVVcyHrEa7KWhPadRz8Ek80J3fZGGPP0/OaVnfEK0tRt6dmKW7yB3
 NTPm/iRUfamuA9L6TetkgMIINB3G1rORCJfc+7pCLcslJjzFmJsrAiFrbJFf43/HxPzJ
 3JeRcl7Trp21+WG/dYotQe9vPr4/vOG36Rz61qOgHo3299b6+fH9wxBJTFs1dTDB47SN
 wsC+n66bndexpTNPQspjJxIVDGf/0507XQ696bJWwk++37J4NHWrH07EZmeAtEwtCOpm
 ITb5pay8+i3KwF+BmyGJeEIfwKoYPUfLSgv+BA9Ssu7dUoA3mJO4K1qNV6VjsPJUWN8z
 FINA==
X-Forwarded-Encrypted: i=1;
 AHgh+RopSsUQ2EglqHhKsLK9wR9nqeEgwENaTXcqe6eUvSn44JFjRa/WssvetmJvOeEFtIFkVB9QL1H8kWU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya0yTasZIUgr5q95XT69zhMh7MfSklMXg8+e6coPcF9toW4GG0
 BbYweB2vH6SR2GBGJxvEF650fWzqKSE0Yg4mHydZLMTN2BlEnuhYNwFy
X-Gm-Gg: AR+sD13OKvxavv5KbybNN/+CddeoZbZUaTEfV8jZLHAs8YrPTfIMdPnIZhU0kNgJmHI
 Lkho5Kg+MUGw9l7ejfoXJpdlYas64/LTWcLpa07p7rKzyy1vdDy/YodIE444FWAZUsgX+4sxu0K
 1pRHqey9lbS1UVFczIo1nw5sRVWbCjqh8WBGpV3Tqad8OQOnIW/OTUUhxqTQsr5XaKxbKcN9bnu
 BSMIyCJpL+fYa2+pVceT4LdnKEs6GDRpYLK7guKgeml5A4fdZcXATovlT1oF4Mqj84snL8+N6GF
 yAqVwams4SyqVy7iynk+dQxzqj0/GgJjbj1O7hPH/yulKXFoP8trc9NzpVUYGkJrdC2DbjirVtw
 atCp7Rz63eVByd4YRnNvrldDO61pbMP8EExRcv0MBOkVpzsxoFwRfUVIcBWRY/4xeLM+4yxX0H2
 l5j95pCZeITloNYYkfEXs1UxesyPXpCP/aMs9bfGgYqmMV3ZJ87rXjO3PFfUpyGXaFM0ge62MlS
 tY0cG2Uj28sLY5s+wjjmzDdHFSaCNTjX/ksXy6QyA==
X-Received: by 2002:a05:600c:a47:b0:496:bbce:ef with SMTP id
 5b1f17b1804b1-4998796ca48mr110524505e9.3.1786823665137; 
 Sat, 15 Aug 2026 12:54:25 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899bff2csm133743775e9.7.2026.08.15.12.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:54:24 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/3] drm/nouveau: destroy the fence event before cancelling
 its work
Date: Sat, 15 Aug 2026 21:54:20 +0200
Message-ID: <178682366002.3748010.12779628082366287968@gmail.com>
X-Mailer: python-smtplib
In-Reply-To: <178682366001.3748010.7798811159846779765@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
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

nouveau_fence_context_del() cancels the uevent work first and only tears
the event down afterwards:

	cancel_work_sync(&fctx->uevent_work);
	nouveau_fence_context_kill(fctx, 0);
	nvif_event_dtor(&fctx->event);

Between the cancel and the dtor the event is still armed, and
nouveau_fence_wait_uevent_handler() queues the work unconditionally:

	schedule_work(&fctx->uevent_work);
	return NVIF_EVENT_KEEP;

So a non-stall interrupt arriving in that window re-arms the work that
was just cancelled. The callers free the context immediately afterwards,
for example nv84_fence_context_del():

	nouveau_fence_context_del(&fctx->base);
	chan->fence = NULL;
	nouveau_fence_context_free(&fctx->base);

nouveau_fence_uevent_work() then runs against freed memory, taking
fctx->lock and walking fctx->pending.

Only chips from G84 on can reach this at all: nouveau_fence_context_new()
returns before nvif_event_ctor() when priv->uevent is clear, and
nv84_fence_create() is the only place that sets it.
nv84_fence_context_del() is the context_del for all of those, because
nvc0_fence_create() and gv100_fence_create() build on nv84_fence_create()
and override only context_new.

Drop the event first, so no further work can be queued, and only then
drain what is already queued.

nouveau_fence_context_kill() keeps its place after the drain. It can
still touch the event: nouveau_fence_signal() returns true when a fence
that had enable_signaling() called on it is signalled and
fctx->notify_ref drops to zero, and the loop then calls
nvif_event_block() once. That call runs in the same thread just after
the dtor, where nvif_event_constructed() is false and it is a no-op.
Blocking an event that no longer exists would be pointless anyway.

The reordering does open one window, so it is worth saying what closes
it. A fence holder that reaches nouveau_fence_enable_signaling()
between the dtor and the kill gets a silent no-op from
nvif_event_allow(), so that fence will not be woken by a non-stall
interrupt any more. It does not have to be: the kill runs immediately
afterwards, signals every fence on fctx->pending under fctx->lock and
sets fctx->killed, after which nouveau_fence_emit() refuses further
work with -ENODEV.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260812231330.705425-1-mczernohous@gmail.com?part=1
Fixes: 39126abc5e20 ("nouveau: offload fence uevents work to workqueue")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08ba0f..4a3698dc2cd1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -96,9 +96,9 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 void
 nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
 {
+	nvif_event_dtor(&fctx->event);
 	cancel_work_sync(&fctx->uevent_work);
 	nouveau_fence_context_kill(fctx, 0);
-	nvif_event_dtor(&fctx->event);
 	fctx->dead = 1;
 
 	/*
-- 
2.54.0

