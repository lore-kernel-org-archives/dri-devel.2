Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7E8C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752FC10E2B9;
	Thu,  6 Aug 2026 08:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+3gtN0w";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7916310E2C4
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:52:34 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495522bc0e2so566505e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786006353; x=1786611153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gH1ZijC9dBMRwcIQPOFxOSOLg1MiHZNn8LjvIG16PSY=;
 b=i+3gtN0wjl9xzxpWUwRNXEuknR76817eHoKMvi7VtpWC2pbjXN4WDemHVUcxQ7EhTw
 5sfbHXfb/6N5TGhFLsFNZv83CBdaJMNoQ7keVS/u67+87iTXULMQq43Ti1Ch4Si3aKr9
 XKrNtj6Shl2xJYvpttQD5X4RhpQWBLSdJvcqE2nVUUxKRSr2NbBarUtqPsfhbqqQ2wJV
 6phhySS7484yTm5ul/0tpwoGJvsZ4TT4aFzIZ4o9dkYfBUU/y4Uvdy//pbBTx4jSukTy
 4/xBF56nxU2l/+Z34q0x2846JoypTZH1RJClNcJ/xlI0N4a0H7KpT+rkYwJIW1+F3wxK
 5+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786006353; x=1786611153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gH1ZijC9dBMRwcIQPOFxOSOLg1MiHZNn8LjvIG16PSY=;
 b=e+MnhZhsURbw6igzQjPbe/dFDaCB39HZ+LT10H39j2xZcyoJU1QpX3iqSXVaHWrNRy
 b/e/dlPUDaqt05U76Yfxy7IYffl5beBx4Ih17Bg9DGV7btDEeehpwW3XbbZS/iBw4AV0
 7T/cP0n/cxk2/zboxbINREhjpKdEX3q5TEv9QWKO5lfTyut8K0vqhRHNldF1dU3RNVT+
 5SaF1toCYpBC50ZKFh5brtwBhYZCiHizHlqEfOidM3pa8M56ilp1c61j2ouwxgDpBU7J
 AGjXexe3NsmebxKxQTOL9n2y1qGzS5UzF6uyHc3P6Pude8efdxGBWoYs3wS0hszB/l6+
 rXFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFTdMca0APYbCqWvZfUkTMXoBoebGgtkdlZOcFFU6zdKIdC11ojCu7xN+Pm/QyPxA/+r5t/2tiQpU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhWl7z9VuvWz1nirmaQvQJgHP5rWApxz3BtG+W1bUlbQJmu5NK
 KPTYJ7Z04khByvgzbxmJ68+klJfUqiCKyd1DLAw/wpxtdVoHlTzT0aCa
X-Gm-Gg: AR+sD104b4ZYfikvSOXrAfo1yCzTlxzBPmuh8jGPnPkQ6ri1AXwX0l8HM1YN/UM+BQd
 djJDlERS6gxjBbggp4eR5nRy5/SAVxpf4CV91T20iCbQikN8UcpAFJP9xLfhggQqB5Kzsn9zxay
 W4y0ga8HDMpq9ffgKd7hVOYNtaN2A19NxXNtIn+vs39CMG1Zm2ztCDjhGmdm8CIUbpdstHtdnp/
 l76HOfUvWAgtmMmaUd2l7xrV5tqZW8upfxAGPTmbWS2wBGOb7uojRwGFOQa/FjOseIVz4ixWWTo
 S+Lu42uy/5FeL1SMJSzpu3hFVVwCDGxIXYGgk26aQuqUgUsl5ST/BdWwA7GT1qV4GEggrxEZVbX
 lKsKBOiaZYmgpZYBl+tAElJ/PXQO+AxaIXhjqnFWIdNPqsiKQ8jAmZlg1ha8E9GLRKTjjnS8b4h
 Xw3bxXQIgObMPOxVzyykzW1ZbawE+WLfqWWDUsXp2v+fuwtZjeKH+ONriKfZoPqldQaLZTj5raP
 eJYn7aecr04WtgW2MlGP4M9eTtC4hjZH21wg9ocE9tiSv+IzoxQGiw=
X-Received: by 2002:a05:600c:1549:b0:498:1371:660c with SMTP id
 5b1f17b1804b1-4994e704bd5mr85555625e9.0.1786006352729; 
 Thu, 06 Aug 2026 01:52:32 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420cb4esm45985355e9.2.2026.08.06.01.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 01:52:32 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/nouveau: subscribe to channel-kill events on NV50
 and newer
Date: Thu,  6 Aug 2026 10:52:27 +0200
Message-ID: <20260806085228.1848994-3-mczernohous@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806085228.1848994-1-mczernohous@gmail.com>
References: <20260806085228.1848994-1-mczernohous@gmail.com>
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
The next patch adds such a caller for Tesla, and without a subscriber
the consequences are severe. nouveau_channel_killed() never runs, so
nouveau_fence_context_kill() never runs either, and the pending fences
of the killed channel are never signalled. Everything waiting on them
waits forever: drm_atomic_helper_wait_for_fences() in the display commit
tail waits uninterruptibly and without a timeout, and the TTM delayed
delete workers wait in TASK_UNINTERRUPTIBLE. The user sees a frozen
desktop on a machine that is otherwise alive; it stays that way for
minutes until the fences time out, and a reboot clears it immediately.
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
index 598513f60449..1db9fbd81f5c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -363,7 +363,7 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 	if (ret)
 		return ret;
 
-	if (chan->user.oclass >= FERMI_CHANNEL_GPFIFO) {
+	if (chan->user.oclass >= NV50_CHANNEL_GPFIFO) {
 		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
 				sizeof(struct nvif_chan_event_v0));
 		struct nvif_chan_event_v0 *host =
-- 
2.54.0

