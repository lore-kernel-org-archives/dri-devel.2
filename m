Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADDFD35173
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0425110F04F;
	Wed,  1 Apr 2026 10:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFiIGYeP";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF29D10E1DB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:49:06 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-38cb7ce7fd4so16898211fa.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775040545; x=1775645345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F9UYWTpgkmHiwl2xz9cys6shKpNNbnLAJljb0/zu468=;
 b=EFiIGYeP0Hk7AMRcb0pW4wgp1LJHGADzNUctGzg9xceKh676OFZ++EwYu4y0xV5kwT
 TjC6WCaXc6oDzVBSLcp3JdMBUEtiUE83iGppcl4K5HIzjWvG+jRakxKsc0h2tvvdlfjM
 YCCuU+3ZtKBXBjVPcnotysmvBjUcKewPsUru7nHOCHDI4xpkUIcpeuAQsmvDEEikFTeA
 0ZxVDQP2yl8vjK00M8tgXdNq+RNIsFBC4cQ674bs+WjT55S3Pcn9BIBwcowl9d9i+dWS
 ac9jEz7G1VsLwtnvcciG2P2sU+gDQXe5/V8EK0Byr64Vk7zBuh0vAktjBBYDZ3YEeBm/
 ZE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775040545; x=1775645345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9UYWTpgkmHiwl2xz9cys6shKpNNbnLAJljb0/zu468=;
 b=Z1J4Hs4r8xA4zyLyvJOS2dVZMAMqU3L5rHufgtVwtPT5SROKwjBwmojr2ABDK8HFL/
 aeS2NrF/uMemqpE6l2zvFtgCUshoyq9UCPAXJJ+TUP/MnuQYRWXuX61Gvp/8rrmtXGHR
 bum0ZNID3vSOMz2SW/3SubgY1vz4fEdiWKd36banK2SBqhpg4RsuZyJXrdXVzAE0SYO/
 d7bD9OvFS3jpnr1mpsm4eV4jC3GoSVLU8G3k6JfK2Relk8/Bg14V7+6h+FJRhnGaXbAj
 rLqfE+3zEHUI3G14NnKOR5bbCsMbQQV5pe5ilkez8P2WvvGLT8hIzoQlZLMDujLfXin8
 8rPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm2feqLPJOZ96/gibFADXBAJrOoijE7f7ZJUMiBqKBlF41N4gcI3ZrEIxOp9nHhNBiEACVYQK3xl0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUm2GFYo8hWTBUxXcEzJTwUAIxBUQ4+vbonALqs6MWVubNZK/v
 TpTyOaNmiJGAajaKwpH8M3FnZWvvJa7CxyQSsSqnEtstsbUR8/Xgadcx
X-Gm-Gg: ATEYQzywvJvqSiA+NFFqt2owYHLYsFGpmBGhbzmU4opqIniWkzEcJicFpouGk4Hkp4x
 Vq3qQsrJk8oYV+egNlTc7frLA19UQ9YyZ4s4BStchR+77a86l8GoG/f2JkoGbW02YXB/7dXhREt
 KCSfXkeeXHIntc15WKMmQIlUgQERugfAF5yTUkwVdJwkzE4hWcXmRV66u07RMeuS9fIrNgfsBMV
 PZyFWBgcozwMNR4fTwhm0DAbK9ZPbxHqlchaO/c1g1AUL8CM5x/TosjcxLLECd38+sZsMJVXu65
 JVevVLBgJDwIa3LLBDq//OmJ9XJMHey0EwYrOd2y8oZ125+iQ6hNoBZj9qcI8CwktzciLuzSqGX
 W74cDDZeBlgMoTNg0VVGSJ+aH2MGVaootOpJumu8xI5BaGAu1elT/6YyGYp2UUkd3ttiJm9+p91
 MuLKkJBQuaL0B42XCHdnlSSF98KjIcxjZRGw==
X-Received: by 2002:a05:651c:41c6:b0:38b:f632:e0fc with SMTP id
 38308e7fff4ca-38cc2f199a2mr11399581fa.1.1775040544787; 
 Wed, 01 Apr 2026 03:49:04 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cc97315bcsm2632721fa.38.2026.04.01.03.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 03:49:04 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] drm/amdgpu: use IRQ-safe xarray API for PASID management
Date: Wed,  1 Apr 2026 15:48:59 +0500
Message-ID: <20260401104859.36990-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
regardless of XA_FLAGS_LOCK_IRQ — the flag only affects lockdep
annotations, not runtime locking.

Switch amdgpu_pasid_alloc() to xa_alloc_cyclic_irq() which uses
xa_lock_irq/xa_unlock_irq internally.

For amdgpu_pasid_free(), use explicit xa_lock_irqsave/__xa_erase/
xa_unlock_irqrestore since this function can be called from hardirq
context via amdgpu_pasid_free_cb, where xa_erase_irq()'s
xa_lock_irq/xa_unlock_irq would prematurely re-enable interrupts.

Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
    amdgpu_pasid_free() instead of xa_erase_irq(), since it can
    be called from hardirq context where xa_unlock_irq would
    prematurely re-enable interrupts. (Christian König)
v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index a6ac3b4ce0df..6fc6859d9329 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
-	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
 			    XA_LIMIT(1, (1U << bits) - 1),
 			    &amdgpu_pasid_xa_next, GFP_KERNEL);
 	if (r < 0)
@@ -84,8 +84,19 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
-	xa_erase(&amdgpu_pasid_xa, pasid);
+
+	/*
+	 * Use irqsave because this can be called from IRQ context
+	 * via amdgpu_pasid_free_cb.  xa_erase_irq() is insufficient
+	 * as it uses xa_lock_irq which can prematurely re-enable
+	 * interrupts in hardirq context.
+	 */
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.53.0

