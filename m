Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FA6C5DF67
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0E110F176;
	Wed, 12 Aug 2026 23:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ie73yMB5";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355AE10F158
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:13:39 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47c2ae992beso90511f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786576417; x=1787181217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z565EJ0GnjhReuEzH6bow6YJdlk7vm6R+vte4T3cg/Q=;
 b=ie73yMB5rj3mGqDcq5LCh8U2gGxw4yaT+LUiu517budxa0ec93VNnHr0gyEuP3+Ecl
 ihevJxJxkuf7uY8F2ElyHzN74oORObXf9ZsEn7zg5TayS2xZtLv+eA0qLcfQa4kXqGn+
 nlE2KjCECu3Wsd/k5RawRN77H0FCkGWBLKNZG9XHc+WQ35bbIWmfcbnUV93k7HRYutLt
 aA1uAF1j3HhvrjlgJp/cFt1Y2OdwYhObfMRoxCgMhz7yAUlOfj1IhKK8MupNTmwokjNn
 vlC9hky5Q8zyQsxPQ3WvPrtNzZ+zsDbdNLJfufERch/P2bV7TRrAQVgxF6l1S0VTMoRs
 5jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786576417; x=1787181217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z565EJ0GnjhReuEzH6bow6YJdlk7vm6R+vte4T3cg/Q=;
 b=pwKXEQBVNbDaWU/4Z1CBJP+fb8rSWa8uRpo4VAffitUShz2YwkWub9iwS33TkO0Xln
 4oFaj3Nnexh2Fcy80CZZNIXw5+oEbTieKTspseKrcfk//8d/jY7kKx+wRoo/fG/01Stu
 ucOBY9u0yvjemnHtnVn1CZdqlSiOil5eQMDtr/rflm5BWq9ZHxRHMFvhBG80pbLBvRo/
 bPTkIdWSdx+UcCbtCAGzMjjnYPf4O8p9rFh4YbyTYn8nTMW8Q7hMFSdEjMgAivNcx5kq
 OxpGkfH+/55FyTsjZR0drzQyO0nqkRRrhbbi8Ijo3SO4mMv3MKtcbfBC//qfF/s8rDQG
 vA5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrn8a8xzeA45Ir/CtUvZAchBOmgWOZ0BtPf1/Na1fLhf8kxxqHfj07OK5E044a1qnXdFSy64sbKHKM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyJ7CgdiRoXHpp79bcSYqJ5vb8Y+CBbLfR5Pk1+lI29fUJGBiz
 /kwKyWXUkz/l955mCD1vi7pEVtJp+ajC9tYBdV+jGsaysBsF91CHl1tY
X-Gm-Gg: AR+sD13I08jSPd44wBoor1ol8pOHhzvRs3KRvDYTowTq5y9Bu7Z1Qwcs4uUbmERMp1e
 x6ITvCibiy8+1B1n2AMUXnFoOuAqmMHDsG4Ux/EepkUQQypeKpOJqWylO10FuSNOGPweNZVwEG1
 gXshLFKd1treu+J91CwX3SqQfrWqaoLyas/9LgBRNQ0TyRCURxg/t6m1WqdLaebY61akFSke0bx
 yAezyQjNNjp2BmHwljhw54bXKebkrD+UVOQagIHmtipoixlAQvEaQUPt79cVnSJECmeaW0gkBr1
 8Z2UhqW5jrJSpUWA/SKmj7wuffihLAvJOBvrOYnr8zYP3812xehTXFOhpRuceheD+GXlUmq+2iw
 3oKGOR18D1/kMz+7r+yYIGx2FoJ11VLLfRpQD7JaM3sH4axnnP0RFspfG8lgRQ+/Vve6u7hHiG3
 aUz56EZDENTwNNTq5JQW2N39R7fi0HbuwnhmqQ9N+BA+nmkwP9OoQs2t2nv77i5LMPmLDTkaBxY
 OUntU9EBNcDg8NAcL6sAv4tsM8Jk/vV/LRJQ1+cBPjkVcyKT6OaMZs=
X-Received: by 2002:a05:600c:b93:b0:499:59da:12b9 with SMTP id
 5b1f17b1804b1-499825cefdcmr4797315e9.0.1786576417330; 
 Wed, 12 Aug 2026 16:13:37 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm44532245e9.14.2026.08.12.16.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 16:13:36 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>
Subject: [PATCH v3 4/4] drm/nouveau: subscribe to channel-kill events on NV50
 and newer
Date: Thu, 13 Aug 2026 01:13:30 +0200
Message-ID: <20260812231330.705425-5-mczernohous@gmail.com>
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
index 07b0bd1bc519..5c2f4b9342b7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -485,7 +485,7 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 	 * lock and the pending list, so an event arriving in between would
 	 * find a non-NULL but unusable context and walk a NULL list head.
 	 */
-	if (chan->user.oclass >= FERMI_CHANNEL_GPFIFO) {
+	if (chan->user.oclass >= NV50_CHANNEL_GPFIFO) {
 		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
 				sizeof(struct nvif_chan_event_v0));
 		struct nvif_chan_event_v0 *host =
-- 
2.54.0

