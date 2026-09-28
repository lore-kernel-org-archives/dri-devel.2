Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD0CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F29810ED89;
	Tue, 29 Sep 2026 08:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J1J5PxZ2";
	dkim-atps=neutral
Received: from mail-pj2-f23.google.com (mail-pj2-f23.google.com
 [74.125.227.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D13D10E7F1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:15:11 +0000 (UTC)
Received: by mail-pj2-f23.google.com with SMTP id
 d9443c01a7336-2d747f066d8so6910745ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790583310; x=1791188110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3PGFMLkqPdnEjr3rj+p66S6V4/orGCF5/967SLXqniU=;
 b=J1J5PxZ2/e/P6aRtz7OTYySz3VTJSZBID+OooYnwDxc8eXsXsH+4m0rAg2CeKW6H7Z
 SXTI3hBocsn5hEN91VktZh8/9Wqa2PcnS42aAwfC5AZJsRJ0gyyfBGEV8JplJSlgSCWH
 cpFBUs41ABIg8JHsZcLUDv5pjFiRj+YQAtTeQxwrvEHCOTH1lt2t0PKbipZc27XtGJcG
 yxzoPukXa8uyDgmBUgOsBP0moqFjVRdu0TPmHJK9s+G0hrZsY+MdMtk2hIj3uocWD3AK
 7JfEasvCCxQlPPMOyx6mEtlBt3Vbf7MqLfnXVvX+iBLwtlACl6coFIUIoy75P4jQlUzd
 Y64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790583310; x=1791188110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3PGFMLkqPdnEjr3rj+p66S6V4/orGCF5/967SLXqniU=;
 b=fvWp5VABL86wG8HO3mgzfAqtuVsdH/a/qalf5r+8+T1oid5LktI6aHpQxalzifEwjM
 WQLVbu6T4YYo+lj7CnTDQYfStWnT2HwHzB5jCF26yFCpSuaLqIUd3hZi8lvsyfPeoLCH
 DMnxEExq+xzbWUMNJpysl2Ec1izoNJZ7nGyreMM+78D8+VtBCg6HhrwXO+SMZaGc4j29
 jFRqL4KY4fAHS8wCSAjpGE+DZDPES9bdjJR3KEn7MyYyEblAh1YEV3QqlT7GSKcocF34
 Hh9aT4K4ilXfeCV5aHSgQhbkqQ/dIqhqmRJcrTbbuZV4YE06ZNKUfERPYX3coKqGql3U
 PxgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwF/6E2vERIM6eSEvzY8hG4LwUEx06R2LcxvcBPjte2QIS4VNsKOj390XSRYMjKxuHr583CEfx4rk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ9H9wj24Ix5WQXUWv/nvYIw9oz6q2IU8Uuzu2F44WXg+zj0Dbx
 V071T12XO8zICTT7V6Xt6HsYe+STiZ9NBO4Ae/NW5gjbu4vcKTNv+AQZ
X-Gm-Gg: AYBFou3n7H7PH97WpUvN/I5eRA4Rdy5XUSZ6oGY54XqFlNXOGs8dqp+9Rr8fCXGdCaD
 Xld3D7xRfT5GILh+RlNDEgS/S9tj1o6slYBGP8EMjVFhMb1sma3bLcvCQxW3zS8Kjo4hSjfRx/W
 R8+e/mPw5+btY5iqEbX51AtPhzR7PKGFfTSygUd2PulLkwqWIO8T/tL1nq3hkwP4kjkjKtzAcHZ
 kV1C7fWggRr2u/TH3bw/xEzabwQ/rrcWK09Au0W6l+BDATciE/TnRSK3Pkv2BMd8UsYDRssmm/Q
 /ZyFJ8OG2D2etz04T/Cr6jVtHfImh9zR1V6XTIrP7R3/m2zOKnoGIiBQQ8DHb++xM1nbyT7P1TD
 LNicymicowZVGzCogwzc9MCRk8WUKn/IMpQgs15DeL2LrgUP16woy1SdGwN9JAeKr8wTgmU4zlk
 8Zb6PlACcU2zfQtI6TwkYtoXalkV7uOJxJ00NV+2GyFT0tBsIFywhho9ChfMtkkx1Hroj70T6Fv
 SMbIiMQK+e26mf7hijG77yNuaD8qithzU+DsSc=
X-Received: by 2002:a17:902:fdae:b0:2df:67e8:4a39 with SMTP id
 d9443c01a7336-2df7dfef6ffmr74050975ad.10.1790583310497; 
 Mon, 28 Sep 2026 01:15:10 -0700 (PDT)
Received: from DESKTOP-HOME ([2406:5900:111f:dc2a:3071:69c7:a4c4:6259])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df90fb675bsm37833275ad.10.2026.09.28.01.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:15:10 -0700 (PDT)
From: Beomseok Kim <dilddream31@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Beomseok Kim <dilddream31@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
Date: Mon, 28 Sep 2026 17:14:50 +0900
Message-ID: <20260928081450.19340-1-dilddream31@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

nouveau_fence_signal() clears fence->channel before dropping its
reference.  nouveau_fence_no_signaling(), however, removes an already
signaled fence from fctx->pending without clearing the pointer.

The fence can remain attached to a BO reservation object and be used
later in nouveau_fence_sync() after channel teardown has freed the
channel.  This leaves a stale channel pointer that the sync path can
dereference.

A diagnostic build with concurrent short-lived Wayland GL clients
observed nouveau_fence_no_signaling() with a fence pointing to channel
C, nouveau_channel_del(C) returning, and then nouveau_fence_sync()
attempting to read C->cli.  A no-fault read failed after teardown.

Clear the pointer in nouveau_fence_no_signaling() to match
nouveau_fence_signal(), so the sync path uses the fence wait fallback.

Fixes: 29ba89b2371d ("drm/nouveau: rework to new fence interface")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Beomseok Kim <dilddream31@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08b..5b09cf134 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -488,6 +488,7 @@ static bool nouveau_fence_no_signaling(struct dma_fence *f)
 	 */
 	if (nouveau_fence_is_signaled(f)) {
 		list_del(&fence->head);
+		rcu_assign_pointer(fence->channel, NULL);
 
 		dma_fence_put(&fence->base);
 		return false;
-- 
2.55.0

