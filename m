Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE242C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D815C10F179;
	Wed, 12 Aug 2026 23:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hcv7mW8/";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C8610E46F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:13:36 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4956d1d9fb2so1348145e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786576415; x=1787181215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b4ewDgBabacjDaP8NBVKD5QYsXGYuSL6SciAIvMhBJc=;
 b=hcv7mW8/lCqCsDCVJqJGJLsDBJVQLnP8lyCiBmLCgZAz78AoSFqMtCFjAlGIsNOqNi
 KIVOFro7jdOPK7wZAfd4m6MqI+ewuW/2eCSJ7Ue/RxQrcafpwPIUwLV4b63jqB/uPkxr
 hr14B2QocQ/FOQDbTHxsdQMXZrTOr3LbN25ZVKaV4fuZM5ieNVvf2Ikt4ii4sgJIneb8
 ndQphOybYsHdhw5Fpoxhs7CjaNQwOsCO/E+OHC46S2hO5gGsXliBHce6epI1L8qiBCPK
 PxrcOTSgCguDFo57FYycLnnzsBvv5ICWRZhREnhN0MwUhBuit+uT8mSO2nnyFoquG3SC
 kzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786576415; x=1787181215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b4ewDgBabacjDaP8NBVKD5QYsXGYuSL6SciAIvMhBJc=;
 b=gFSmRV/V51c3g7fFEOeLZ6Z8g+ZVPkrk8oxu3Jx5TTGEda1LYc2yRSugfXhfB1BDdx
 fSoX50HUKZCkdb5j4fHWiaG15qkdOQmBKSFtUHopA1qOXuuCuGvJsGsrV9vv5vktzxIa
 YtrbcN+I7mkOyQVFb20kaavV616Kg/aWaHncJmLvbwz/r2IXnrskxPOIHpsc/arbVVRK
 pCNbZZl0xmyUggec7XF1dTIMrej8+ywryil9xPC7Mb5GQI9AieklUdx+nMmHDVgeZ8lH
 7kTxPWKyQGBcu+34AXC1i1iXVbgcOhD/Ky+mjT7VTxaV8ot8txLc/EHcm8cc3LiClNOu
 SRmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9mUAIosqLkFPwz6G8h9xmsojPX4sSeTk1aKW+SGPLc03qRx8qlgwENSycv4jrIxB9RlTSyR34ICQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxuagvk41yXqTyOn/+04GoO0BX4PkUHmhhhHQydWGRE7indFTLF
 WgEtuj5trkQAiEMbCPwpBqNeXPlmBW8/Mzey14wB46LmzpfVzTXCEGfs
X-Gm-Gg: AR+sD11+c09QPfnSAEsDZX+O7V3J4yv89spOM9gs9yszPKLsWAVMtdu0EXnF3UXHk3M
 lMQkmQLT4GPka38vLGRf0JYml4d0vZxKcPBKF2EZLBYZxz7O6iqPGpPJQ87bGSKThRaepYsi6Vs
 2Difwo1c5GxNr01cdR4DlUOpqdiXVQyO7h2aeWEMaOz1Gu5WrCu1yijzBcl8oMmeAJZdDik/OM5
 kQJ41cJqvLYyhdhCc+4KWHuIVjP0r84LUkaMPcw5dGXPm/MK4B77N9DTUhtgS+535SzbSSm9BBv
 01w8cJQEKsgW6+/ykLEKxRm1XKAZhPFw3EWiJf8TBQblgncEsDzQ55JWnXayiGI368gC8j1/kQ5
 jX/IlJCnG16dBDth1auG2SHl8BIxJRUOChhSDZzHydsgt+AoTGbbvE2hoF6XYWj+Ojv++Xo3d7/
 xtPFbVsNZqzgnUVKcLtK+NJ2GxextLsLPRTv0pDARFQc3Gw5jZiM/24JTKsUawcwlS9mo3D9i1o
 xHbaYHZfnZqlpVZAC1M+j3PQ98PcygsX+A4j3JcmUCIEvQKbXvEYo8=
X-Received: by 2002:a05:600c:e547:20b0:499:4d41:cd13 with SMTP id
 5b1f17b1804b1-4998212ee6amr4162105e9.0.1786576415303; 
 Wed, 12 Aug 2026 16:13:35 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm44532245e9.14.2026.08.12.16.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 16:13:34 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>
Subject: [PATCH v3 2/4] drm/nouveau: subscribe to the channel-kill event after
 the fence context
Date: Thu, 13 Aug 2026 01:13:28 +0200
Message-ID: <20260812231330.705425-3-mczernohous@gmail.com>
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

nouveau_channel_init() arms the channel-kill subscription early, right
after mapping userd, and only creates the fence context at the very end
of the same function. The handler it installs, nouveau_channel_killed(),
reaches nouveau_fence_context_kill(chan->fence).

The NULL check in nouveau_channel_kill() does not cover the window in
between. The backends publish the pointer before the context is usable:

	fctx = chan->fence = kzalloc_obj(*fctx);
	if (!fctx)
		return -ENOMEM;

	nouveau_fence_context_new(chan, &fctx->base);

and nouveau_fence_context_new() is what runs spin_lock_init(&fctx->lock)
and INIT_LIST_HEAD(&fctx->pending). An event arriving after the
assignment but before that call finds chan->fence non-NULL and unusable:
nouveau_fence_context_kill() takes a lock that was never initialised and
walks a list head whose next pointer is still the NULL left by kzalloc().

Move the subscription behind context_new() so the handler cannot observe
a half-built fence context. The failure path is unchanged in effect: the
caller drops the channel with nouveau_channel_del() either way, which
since the previous patch unsubscribes before freeing the context.

One behavioural change worth naming, and it is not free: a kill
delivered while the channel is still initialising is no longer observed,
because the subscription is not armed yet. That window does not close
here, it moves, and on Fermi and newer it grows by the span between the
old subscription point and context_new(). What changes is what the
window costs. Before, a kill landing in it reached a half-built fence
context; now it is missed, and the channel is left blocked with
chan->killed still 0, so nouveau_channel_idle() and the checks in
nouveau_gem_ioctl_pushbuf() and nouveau_exec_ioctl_exec() keep treating
it as alive. The missed-kill window is not introduced by this patch either:
nvkm_uchan_init() already calls nvkm_chan_allow() and nvkm_chan_insert(),
so the channel is schedulable before nouveau_channel_init() subscribes at
all. Closing it properly means subscribing before the channel becomes
schedulable, which is a bigger change than this fix.

As with the previous patch this is unreachable below Fermi today, and
the last patch in this series lowers the gate to NV50.

Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 55 +++++++++++++++-----------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index f142f6310596..07b0bd1bc519 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -370,27 +370,6 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 	if (ret)
 		return ret;
 
-	if (chan->user.oclass >= FERMI_CHANNEL_GPFIFO) {
-		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
-				sizeof(struct nvif_chan_event_v0));
-		struct nvif_chan_event_v0 *host =
-				(struct nvif_chan_event_v0 *)args->data;
-
-		host->version = 0;
-		host->type = NVIF_CHAN_EVENT_V0_KILLED;
-
-		ret = nvif_event_ctor(&chan->user, "abi16ChanKilled", chan->chid,
-				      nouveau_channel_killed, false,
-				      args, __struct_size(args), &chan->kill);
-		if (ret == 0)
-			ret = nvif_event_allow(&chan->kill);
-		if (ret) {
-			NV_ERROR(drm, "Failed to request channel kill "
-				      "notification: %d\n", ret);
-			return ret;
-		}
-	}
-
 	/* allocate dma objects to cover all allowed vram, and gart */
 	if (device->info.family < NV_DEVICE_INFO_V0_FERMI) {
 		if (device->info.family >= NV_DEVICE_INFO_V0_TESLA) {
@@ -494,7 +473,39 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 	}
 
 	/* initialise synchronisation */
-	return nouveau_fence(drm)->context_new(chan);
+	ret = nouveau_fence(drm)->context_new(chan);
+	if (ret)
+		return ret;
+
+	/*
+	 * Subscribe to the channel-kill event last.  The handler
+	 * dereferences chan->fence, and the fence context is only complete
+	 * once context_new() has returned: the backends assign chan->fence
+	 * from kzalloc() before nouveau_fence_context_new() initialises the
+	 * lock and the pending list, so an event arriving in between would
+	 * find a non-NULL but unusable context and walk a NULL list head.
+	 */
+	if (chan->user.oclass >= FERMI_CHANNEL_GPFIFO) {
+		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
+				sizeof(struct nvif_chan_event_v0));
+		struct nvif_chan_event_v0 *host =
+				(struct nvif_chan_event_v0 *)args->data;
+
+		host->version = 0;
+		host->type = NVIF_CHAN_EVENT_V0_KILLED;
+
+		ret = nvif_event_ctor(&chan->user, "abi16ChanKilled", chan->chid,
+				      nouveau_channel_killed, false,
+				      args, __struct_size(args), &chan->kill);
+		if (ret == 0)
+			ret = nvif_event_allow(&chan->kill);
+		if (ret) {
+			NV_ERROR(drm, "Failed to request channel kill notification: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 int
-- 
2.54.0

