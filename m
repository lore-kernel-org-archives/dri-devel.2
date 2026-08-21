Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C3C5DF96
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587D110F323;
	Fri, 21 Aug 2026 15:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UzqebzCV";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2975010F328
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:23:16 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso193806a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787325794; x=1787930594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:cc:to:subject:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8sdbNeUe6ctrJEy+VKy4nn9z2qBfoh++mokomXoK9cc=;
 b=UzqebzCVOknGyf51vMABsWIPh7BBkmuLg70pw9RHHUBx8FxEDBhmYtDbvaMA0Xstzl
 rMxBQukf6tJBBW1lsQWpPrSziwX5faVHDIxSC9/R5go8Bkz5TiCo8c5B8J9iPVwpmzkz
 4lRrX+Qpd26Cco+Ylut/j0KIShzk3mB8HjKpIKFFcvet61dKRRlNPwG+ETygOGu7cwTn
 lMpX5RetEy72jYY7C2L8dAn4ZtvweERhhJ0VDjyT8vog19l5j1vqDPl59Vawz382CG3Y
 ycHHjhppXB7juqXPRlNir1JF/v5s5NP22F6yNz/nP/ewRq/DCHmagnla5XrmRFXprlPD
 k/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787325794; x=1787930594;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:cc:to:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8sdbNeUe6ctrJEy+VKy4nn9z2qBfoh++mokomXoK9cc=;
 b=hPrlfB1/lhIhJUTEmFE6esoR+yJEGkyOm9f8MgdSJH2nX+vKq9oYqEkAHLAqF0ukVt
 QFkhkU44k605iStA5buaz35vUGoGMUoD+Mhnk4lRdT0IUPTvi3z2Yr+QyXTvHTHrSFSV
 eaZc0VQbfVkUF5Lw9/Plgi6v8RKRkWezj5b23KsI/ebW+1jcnZtpV6DoEfo80S3ISQR2
 OIOCvbZ56wAzg/ajH48v8wJAxznm52s7lypepggC6jm+f3kw00NofrLH6oXEOwkEuLBU
 k7bSfH1WMJwWAwHKm0Ye3kGzFtspFcRpNTavWRf2FMX8Wm1Fgirpog8X/7qh1oNeTRQL
 VwOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRrMNGR4rkHt+WynB9zPVv1p6u7ynuO1UbbCXTInMUU7SofuB/4pexT+Bf5QZAFhwSLY5+4UT3uIo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7MK/nmP/Rx+ZkxHfV+9UGXZCq+cL0ktoINmyBpWt3UVu/+23H
 Qw37CWjOJAqo4NRQrybcCtoo9Mj97BMwP3knKuEl6U4HfIA8L2aorNXF
X-Gm-Gg: AR+sD11oj0SFWo+tusY2aKMmVfXovbi7QMEP2mGax58o4G5rAkhUEZhUn8BXWdV3a6l
 6TNWKpilzkW3uUF4tt70XzKRD7RVEJoI27tXjrGk6e/pyO2ByhkcBPtiY1QuwKjp6PXN2CRpQ6Z
 +QSmzfq8I5mVCui69I0JQLyRiIAC4EhVsQeQHj34eAYwL7yuQWeO5s1zI+xK9ap9JyzsXRn1rqA
 m6wWl/aFvh1Qdze5hLz9R2vmtXD5k6ejXtUNeRAqY4Ty3sX1ZCtuha9pS8bOy/GZfVX7wFYh4Ut
 3JQrGbArmXGuq8q3+8iWFwgTTz3ZUsHyIf8piHdB7lrc9qX0kSa1EZ3Pfgjr2ID7KAmC6PN73QO
 rsj0DgMPYsqW/sG2i9oP0bvlJFzhV0MYVUgAKtyNU0giPAPdNp3C1aLHqmKNFYUD268QNDol1HS
 ybfIAnFJuB905DJ22UOqC1aNDw6G58RhVBRnJT0Me3/I78Vp3WyaeBeH+1SlJ5mTqS2Dyx5BF2J
 syc2lkHZ05BLAAAYPY4DmP0JYLMyZlMvziXRjzmSw==
X-Received: by 2002:a17:907:cd0e:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c246a63d6b3mr388498966b.4.1787325794415; 
 Fri, 21 Aug 2026 08:23:14 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591dc662sm506198566b.42.2026.08.21.08.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:23:13 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
Date: Fri, 21 Aug 2026 17:23:01 +0200
Subject: [PATCH v4 3/3] drm/nouveau: subscribe to channel-kill events on NV50
 and newer
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>
Message-ID: <178732578167.167481.2178147998794444181@gmail.com>
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

nouveau_channel_init() only subscribes to the channel-killed event for
FERMI_CHANNEL_GPFIFO and newer. On NV50/Tesla the subscription therefore
never happens, and nvkm_chan_error()'s NVKM_CHAN_EVENT_ERRORED is
delivered into an empty notifier list.

Today that is harmless, because nothing kills a channel on Tesla: the
only nvkm_chan_error() callers are the Fermi and newer recovery paths.
So this patch changes no observable behaviour on its own, and that is
deliberate: it removes a latent trap before anything can fall into it.
I am carrying a Tesla recovery path that does add such a caller and will
send it separately once it is ready. Without a subscriber in place the
consequences there are severe: nouveau_channel_killed() never runs, so
nouveau_fence_context_kill() never runs either, and the pending fences
of the killed channel are never signalled. Everything waiting on them
waits forever: drm_atomic_helper_wait_for_fences() in the display commit
tail waits uninterruptibly and without a timeout, and the TTM delayed
delete workers wait in TASK_UNINTERRUPTIBLE. The user sees a frozen
desktop on a machine that is otherwise alive, and nothing in the kernel
ends that state: both waits pass MAX_SCHEDULE_TIMEOUT, so the fences
cannot time out. They are signalled only when the fence context is torn
down, that is when the DRM client owning the channel closes its fd and
nouveau_fence_context_del() runs. Killing the client, or rebooting,
clears it; waiting does not.
That is also a dma-fence contract violation: a fence must always be
signalled, with an error if necessary.

Lower the class gate to NV50_CHANNEL_GPFIFO. The nvkm side is already
class neutral: the KILLED case hangs the notifier on runl->chid->event,
which every fifo owns since the runlist rework, and nvkm_uchan_uevent()
does not discriminate by class. Pre-NV50 chips keep the old behaviour,
so NV04 to NV40 are unaffected.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 605ce74c0d15..54e2202cb852 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -378,7 +378,7 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 	if (ret)
 		return ret;
 
-	if (chan->user.oclass >= FERMI_CHANNEL_GPFIFO) {
+	if (chan->user.oclass >= NV50_CHANNEL_GPFIFO) {
 		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
 				sizeof(struct nvif_chan_event_v0));
 		struct nvif_chan_event_v0 *host =
-- 
2.54.0


