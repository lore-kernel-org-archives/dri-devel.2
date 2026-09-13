Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D5FC88E6C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E5310E9E7;
	Sun, 13 Sep 2026 20:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nH9hQWTU";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A0410E9A1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:13:18 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1e023so636651e87.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789330397; x=1789935197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tvQTHWXId30lHl89cQONJGQBaXvDgk+KicdEmbWVsGQ=;
 b=nH9hQWTU3pD/h0ZmLPu9s9V3lZnqzXulVyto88qcDb/NTy97RI87HQkXBWDQ94IdYV
 4IVEjB7w8knMLebM16z4l/gD3WkgR4hgWI50AZU4qrpJSsxQNhZjufiQK3ow8HhOvlJq
 o5DFh6Ybcze+JjS+BMB9qrDPwj79SqDQ7lERoBFXUOFlDXXg0HRYLD5OyAhkPy1mDZ8j
 ksArBaCrY0mafAgnCbCMA/nnBl2jH+fpDfJ4sT9pyczPYIqwzYeSr36+xy4RI54Xp6if
 1gcFHgNISYtrl2SBckk6aJgQARLHSnjqtXhpHL2DmQYm2h+iT7BnY48wOU/4OrgfCmhz
 TKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330397; x=1789935197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tvQTHWXId30lHl89cQONJGQBaXvDgk+KicdEmbWVsGQ=;
 b=TQefaY2SFYDu8B7xRcbFFRPrY6lQhNLhb0kZCkbBrxzpDZcU3IiqsOyEEp7BA6FU+R
 Yj1Y5281Q83enM7/J4T7sTAW5rHRMPlnjb5M/1jUNd+MtoJfODnJPaGX83h3KRIBsCT9
 KzxnO8wu9JOJOc+4VteupeQFu7eStdFom/mRW0SVS+NhsmGu2L4WDF0SU2I2e1NrcjQo
 k1F6NJ1mcIIwDFTnPvE5XPrPut5EZTXTmjujDCogoT7QScZJbdXoPsA2OwqcNvfWyEzU
 VkzG1yYSyiO9tqqZDhSlAOT5cjpAn9sxrPKhyYBwQhVS7+p41sUO2tWTPgmC+PAiHfPp
 BIUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySy5PGLtDa6X8MchqYtALUGdgIcKm1PnBm0O04TkMsKRScGYf2hdSV5xXFObpFEiL3/OhoukJ/mZw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kS4JJIUY28zHgmlIIHThhmhm4xpVUQgm3/MIcznWg5WaGbZqjz
 CZZDFa8LuWDhYJslK9Aql5v2+Dziv9ATpYribfc0Za2J4v7ELeZK6Ch5
X-Gm-Gg: AYBFou1PkJCD1d6BYz45AxSj6+LpaQtx/X6z22UjT83FXoA1ckOLdFm09uuQlFlAQyZ
 b7i3pxToe1tdh/YsOMkYIZnKAEIkbY4Kz/kPXjoj530I6LmlKsD4nOgx9L5VAdP8rF71zkmfuqO
 J3eUrOFHioINkePdDPnUmERJ/j/hX9hg8dxldFtexPq3Xt7CHHAlNvbjKkNXfg9pjcM88Oq+e0h
 EU/XXOvY/WpeKLUE5Q25c8oqJeaDGJE4z3+KjO+lGhYqDXGiQKhaaw8ohEViiZuCoLpMh9v1lf7
 FmNK23cCvWBiefLwokYeJeiKH0Xbg/D1eI2R2KUmjbkwh4ngbVVbaCo+YMu1r7IMfHIrCI02N23
 TgbYcMnzujd5iTQR15wLv3uHwwMU+B41nQjnhkStJmToN69GXVEVi3ElCw3wZ7Nn1oCN3uqPzO2
 kKTBI5QUPHc09hY98StcweZQgKtSJT1/LlguFrM+zWrasOhWWYcK/4bwhpRVjNB0aKFe3EIdR54
 da11sY7QnlIyLncMUyHq0p99On9dKrm20/uME9T887a
X-Received: by 2002:a05:6512:159b:b0:5b7:f0b4:de57 with SMTP id
 2adb3069b0e04-5b8abae311amr551289e87.6.1789330396785; 
 Sun, 13 Sep 2026 13:13:16 -0700 (PDT)
Received: from tallipc.shacknet.nu (91-157-240-22.elisa-laajakaista.fi.
 [91.157.240.22]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a03a85cesm2003345e87.1.2026.09.13.13.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:13:16 -0700 (PDT)
From: Risto Pajula <or.pajula@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Risto Pajula <or.pajula@gmail.com>
Subject: [PATCH 2/2] drm/nouveau/fifo: use global nonstall event on legacy FIFO
Date: Sun, 13 Sep 2026 23:12:25 +0300
Message-ID: <20260913201225.5975-3-or.pajula@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913201225.5975-1-or.pajula@gmail.com>
References: <20260913201225.5975-1-or.pajula@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The per-runlist nonstall interrupt handling change made channel
nonstall event registration use the runlist ID instead of the global
event index 0.

Legacy FIFO implementations do not provide a nonstall constructor.
They have a single global nonstall event, and their interrupt handlers
signal event index 0. Registering channel events using runl->id can
therefore leave fence completion waiting for an event that is never
signalled.

Use the runlist ID when per-runlist nonstall interrupts have been
constructed, and keep using event index 0 for legacy FIFO
implementations.

Fixes: 55e1a5996085 ("drm/nouveau/fifo/ga100-: add per-runlist nonstall intr handling")
Assisted-by: LLM
Signed-off-by: Risto Pajula <or.pajula@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c
index d6a87cec2..b96e84192 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c
@@ -52,7 +52,8 @@ nvkm_uchan_uevent(struct nvkm_object *object, void *argv, u32 argc, struct nvkm_
 
 	switch (args->v0.type) {
 	case NVIF_CHAN_EVENT_V0_NON_STALL_INTR:
-		return nvkm_uevent_add(uevent, &runl->fifo->nonstall.event, runl->id,
+		return nvkm_uevent_add(uevent, &runl->fifo->nonstall.event,
+				runl->fifo->func->nonstall_ctor ? runl->id : 0,
 				       NVKM_FIFO_NONSTALL_EVENT, NULL);
 	case NVIF_CHAN_EVENT_V0_KILLED:
 		return nvkm_uevent_add(uevent, &runl->chid->event, chan->id,
-- 
2.47.3

