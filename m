Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62625606A337
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yjygbcGP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A288A112136;
	Thu, 26 Nov 2026 08:11:11 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E29E10E1E6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:08:26 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdb2e0062bbso2651411a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795673306; x=1796278106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2yyDoeUfOAGstlBUWiMGIeqYp1mC1ESfIoYKc0SeXTw=;
 b=yjygbcGPPm9Y4y3XRhKEjrd69DwNnq8dVS/XqHHum6AQCRkSA2rEZR3AuAefjnmKoo
 duaeYc7yiR7zbpD4oY3X9CuMBDr9LJFfyUFJdajW2qWoWP9Tqy5OIaVdmpTYuvyPtAls
 91bqYXH7NUI3AOCuH20ULHFhF8N6iymAZToqORCs+8cXX6GcM5+KQ5cOO/Cushay+G2u
 4kX65vlbF1406C4h+ylxr5BSGL+Ta4xGQH/nowe2tXFJ/K3JGS//wOl+H0fAZ6fymbNw
 DsEbVHJoBGvkzJZjuOPEjHLU545DnVKem1BQioP7ubT45TEtzLG1gki8fsO3yZjp41wI
 GOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795673306; x=1796278106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2yyDoeUfOAGstlBUWiMGIeqYp1mC1ESfIoYKc0SeXTw=;
 b=osVTQrtIwFKEhYG+iQLja8MmpWEYj69gwrmb20JjW7WUBE62kuVJN6n9j0z2I7sDrk
 SlQuuNq+LtO8VusEb1vV1Jv+kV7ZG00BtsbDpijmnDE5d4VJ3ROa4/1EBdG5g9TPo/Ob
 sTNGhHLII4rpItC9NzPDT0Kqq0Ka6lCdDPiCzQv2Cu1hOifGnNYi5lHj4wV7vl4lC6jW
 BZYBBSc85PtW5D6CAyepCrI8W2MWKCUDFct+SCfK9JnVlZ1++0OLwMbXtBI9NdQ5cPl9
 upT0WvqdBWeyXk+KQU1EPdR0NC/kul/VQ1UBWrZ4Ulqo/G+/sSuHA4dzT+Nd64Ox8XI7
 RNMw==
X-Forwarded-Encrypted: i=1;
 AL+hErHoecglGqKR2629jOLLiQoDdxK+w5XgCRLmvo0JcrMUyDGMVkA7NgDqP3PvBok8qbKt6S4dqOVur+4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+UToSDLMF8mOBwY7iM/WruwbbAmto9jlFmTUNsQDiBwB8VrH3g
 WYwVf30c8qU4+tg0t132jVNpirtfVEdy55OTh+i7JeTM6IYWSID3BRMc
X-Gm-Gg: AZFdTZfiWGxmGlrWPVmaFoUmulH88wMXse4AAoz1Snu2McGtMahG8qcxhuFCpm1x8+E
 RTOCts25dQNxCHzfdxKqAY95kR/XVGeCoajIONxvtyy5Lc6gloV+C3Mnani3oqAzxXqPm8w+Abt
 dRKfQE4MMcXIAjnWEWLMR4gLXfFAgKh8zzCBxtfG9D+ZtUSmqawE8Yc2ZEUDAeEOZBrQ6ICO0Kj
 nJCotAbQ1MBNA9RYK6im0qSpHGCYdNgfRPp0xzBfA2AMS295wF1yMQzbUtWmTgWSpskayGo4hlh
 ZzS0K0JtDeajARO+FwJ1Q6KZTjL4LViXXtMVvtf0a7cGYQ4Wa1pGS2X2bPOXhF+cg0hE8tfSuvZ
 mPgZhj0l4UWfvikk2mKykcVljfNPl8sWQMR3q1QmPvHdLBvPgQ6lQ2vltRMdh1+Vt/FXVemiyR3
 gfmTxkOLEXG0yj4V4xW1eLxzOpLfodTszPL3h1gu7GUttPAopD2LVtsXytMjYDzLEcN6i5ea3x6
 lgaUcfkPUUGjIrr5BfuOB6lZEAsNf+PX00zDVmnvp1LTxuk93ocZI92Loj5A0ZiiBJEjO5bMMlT
 D9j1L9OueN4rNWgBNxWMjp+agACqotBEIyAR+fDmTrTZJU4snotq/qgMyc2NEowFQTrlnUgjOWg
 zt12hkIumWNvOSHK5+mjl2ZY3kBGX0vAfXwPp7rvSyL/O1kMUjAZvQ7MTY0FfV5Tqc58tRxHAjb
 jWwxb3MmiLIrovGj22YMtsflqTtZGpiq22the85yrgXA==
X-Received: by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5 with SMTP id
 98e67ed59e1d1-3b41c988620mr17565188a91.48.1795673305926; 
 Wed, 25 Nov 2026 22:08:25 -0800 (PST)
Received: from LAPTOP-3B99V33A
 (ec2-3-38-183-164.ap-northeast-2.compute.amazonaws.com. [3.38.183.164])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad92c07sm31324076a91.13.2026.11.25.22.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:08:25 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)"
 <luob87709@gmail.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/display: hold frontbuffer ref across dirtyfb fence
 callback
Date: Thu, 26 Nov 2026 14:08:18 +0800
Message-ID: <20261126060818.1654-1-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_user_framebuffer_dirty() stores the raw intel_frontbuffer pointer
in frontbuffer_fence_cb without taking a frontbuffer reference. If the
framebuffer is destroyed and its owner frontbuffer reference is dropped
before the reservation dma_fence signals,
intel_user_framebuffer_fence_wake() passes a freed intel_frontbuffer
pointer to intel_frontbuffer_queue_flush(), causing a use-after-free.

Take a frontbuffer reference via intel_parent_frontbuffer_ref() before
registering the fence callback, and release it via
intel_parent_frontbuffer_put() in intel_user_framebuffer_fence_wake()
after queuing the flush.

Fixes: 1bb2af547a4b ("drm/i915: Handle dma fences in dirtyfb callback")
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
Found by code inspection. Compile-tested on x86_64 with W=1 and KASAN
for both i915 (drivers/gpu/drm/i915/display/intel_fb.o) and xe
(drivers/gpu/drm/xe/i915-display/intel_fb.o); not runtime-tested on
Intel display hardware.

 drivers/gpu/drm/i915/display/intel_fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index 9d71f59..3bbbedc 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -2148,8 +2148,10 @@ static void intel_user_framebuffer_fence_wake(struct dma_fence *dma,
 					      struct dma_fence_cb *data)
 {
 	struct frontbuffer_fence_cb *cb = container_of(data, typeof(*cb), base);
+	struct intel_frontbuffer *front = cb->front;
 
-	intel_frontbuffer_queue_flush(cb->front);
+	intel_frontbuffer_queue_flush(front);
+	intel_parent_frontbuffer_put(front->display, front);
 	kfree(cb);
 	dma_fence_put(dma);
 }
@@ -2160,6 +2162,7 @@ static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
 					struct drm_clip_rect *clips,
 					unsigned int num_clips)
 {
+	struct intel_display *display = to_intel_display(fb->dev);
 	struct drm_gem_object *obj = intel_fb_bo(fb);
 	struct intel_frontbuffer *front = to_intel_frontbuffer(fb);
 	struct dma_fence *fence;
@@ -2185,6 +2188,7 @@ static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
 	}
 
 	cb->front = front;
+	intel_parent_frontbuffer_ref(display, front);
 
 	intel_frontbuffer_invalidate(front, ORIGIN_DIRTYFB);
 
-- 
2.43.0

