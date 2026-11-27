Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA4606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVIvLnGs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C1310E574;
	Sat, 28 Nov 2026 09:41:07 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C734F10E59A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:39:45 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso3491803a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795786785; x=1796391585; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jsEuJpvlZZyQMdgxCFdQUwfLifMTW9CXYX26w+Rx/vg=;
 b=FVIvLnGsnQ6FtjhafIngnPdat0OYhaBs/KGoLQQfv+Xm3n87SVEsAPL0ClZ3Neholz
 6myxdBwy5ceLAnXBOroiZmUrBYGDUSRS30VmEb6bLPWPVIeefJ2tYX2g25Ridlf1Rd0e
 BRRDI7M0SFVq9WgKYfnxRKkaUq+gc+wWqrMSR0dCAO01imEOOmLh8UljpATcz6VgKrTu
 Cqik/Kk6/YVNZyjxj7IFJ9qGd3/s8MPUCr3WLBCnVPpooN9rQCQ/qE0fOMw6hPz1zRlp
 hQg+CEPvw8ehnPPXYNB/CEmzFXNKaBb0TyLv4X/VNwvAZ3DMQFtgtifmm3cF2BWv1BHW
 F2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795786785; x=1796391585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jsEuJpvlZZyQMdgxCFdQUwfLifMTW9CXYX26w+Rx/vg=;
 b=RzEyx5EnD7XSfE+n+rRQvuZZ1oTQt1otgurQDhSP3x19jImc94TzuzyP6wIaiDLqhC
 ZqtVNJEK1hU3FPA+MNstFMukDitnlpiMBS7CTozVEm5WA/W5e4ThARAQiXP3MM2VUo/O
 uMk/gZsWSaBIeG8QlAAOFfAdehy8kx8NAwppsk5lMXxAS5iFtG30sAJxQVHNpMiY2jvw
 ixdgBJPzN9NKumema3uLvXpXrUVqb49eHEIQGGtXOxiMlJl7GvrLN0EK+ozsY1291cXD
 UoWsgqjB79Xqpiz3nGR0fWstpngfMahl78JN4UVQLVpQqEcrS3SQwSlS7AgQKbhPLBtW
 CWdg==
X-Forwarded-Encrypted: i=1;
 AL+hErG2v0Kdah5enWp4yVFumU44UfqTLrm3no/wSilIqE5ALM+XEAdLEZ10fDT6+cfq5uBoJX4HS7Qj2Fs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8e3DoBqbMPAynmJEshxNtOY9jyMMQgT5OXk2BTAWiivbQ9IElm
 m7NOlf6RK7dE/cWwX0t/DTEQO7wyTvM0eZbomkDf3IVuOfUv1D9pm5v3
X-Gm-Gg: AZFdTZc9nBaNeI0yGC4T34T62XR085EN5UpQXNZH21bMJj2maz4hMCVhOEevWcrrh2A
 zGSyf68BQK/9F85gDrqYJydsQHHanVuQT19ULlnoFKPtKmmr8RdkASlj4wgrzmQMCpuMxsTkUoZ
 567488o8J11nhv/xBd46JkM7jcODanHFTwT6jMWqpIDWWKX1a5IvydnvveG2J6XGTx9rF2a70ml
 P/M1CFXq8SO8V6mllL1w52OV3cqomQUzZGMaVlDmFdexgz97eydRPoAfynrEnrvx7+NQrWV12Gw
 VPvLllKwFybcr94HwGPxHr6QmzF4wWsHOUSh9X4wSv6Oxlsz/yN8IYl9LaRWzuxoLeYZ48AEz4v
 AC2b60CjXsYrDlaSx8bDUHcBSePgfY9p/AurvdyUFijrn922kK4pAMSWFRc/uVu0dJ28SfRxE0x
 HA8Psjn1X3IAN20CKQ6XXNKsVug0IhzUTq56PaWaq3hcFWY3Ya/sAduV119suU1a/lQvw9peczL
 pIiOLT95mrkwe9qlkRYR5DZsE/HDggEKtMiRNxMS1YNp9iLlQyQqTZfF5gYYE5syAK2ZVMK/BOo
 hudj1/55MwBxN9I2lvQt+C+W9oXBBIbC6Z3OM+rV6GzfgUK/PcSoCaF7U8h/PE8pn+z0PoEzjL4
 32eLwtA6FxG/nLvUEx1j32nlsI6iayTAZhW4hPf8IT0Ww1fyEJP8PRCcjXRGWDuZGnggAMFs6AZ
 3BrXyqAbOYRC8hiYo+pcuK7ybQ8ExkNhzQ4iIGamA=
X-Received: by 2002:a17:90b:3f0f:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3b41c9006d4mr33788171a91.23.1795786785058; 
 Fri, 27 Nov 2026 05:39:45 -0800 (PST)
Received: from LAPTOP-3B99V33A
 (ec2-18-138-229-8.ap-southeast-1.compute.amazonaws.com. [18.138.229.8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41aab4729sm37846270a91.0.2026.11.27.05.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:39:44 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)"
 <luob87709@gmail.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/display: hold frontbuffer ref across dirtyfb
 fence callback
Date: Fri, 27 Nov 2026 21:39:35 +0800
Message-ID: <20261127133935.1461-1-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
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
registering the fence callback, and embed a work_struct in
frontbuffer_fence_cb so intel_user_framebuffer_fence_wake() only
schedules the work item and drops the fence reference in atomic
dma_fence signaling context. Perform intel_frontbuffer_flush(), release
the frontbuffer reference with intel_parent_frontbuffer_put(), and free
cb from process context in intel_user_framebuffer_fence_work(). This
avoids calling intel_parent_frontbuffer_put() in atomic context, where
dropping the final reference can sleep on xe or deadlock on non-irqsafe
locks in i915.

Found by static code audit.

Fixes: 1bb2af547a4b ("drm/i915: Handle dma fences in dirtyfb callback")
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
Changes in v2:
- Embed struct work_struct in frontbuffer_fence_cb and move
  intel_frontbuffer_flush(), intel_parent_frontbuffer_put(), and kfree(cb)
  into intel_user_framebuffer_fence_work() so intel_parent_frontbuffer_put()
  is never invoked from atomic dma_fence signaling context (fixing the
  sleeping-in-atomic/deadlock issue flagged on v1).

Testing note:
Compile-tested on x86_64 with W=1 and KASAN for both i915
(drivers/gpu/drm/i915/display/intel_fb.o) and xe
(drivers/gpu/drm/xe/i915-display/intel_fb.o); not runtime-tested on
Intel display hardware.

 drivers/gpu/drm/i915/display/intel_fb.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index 9d71f59..ee0665c 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -5,6 +5,7 @@
 
 #include <linux/dma-fence.h>
 #include <linux/dma-resv.h>
+#include <linux/workqueue.h>
 
 #include <drm/drm_blend.h>
 #include <drm/drm_gem.h>
@@ -2141,16 +2142,26 @@ static int intel_user_framebuffer_create_handle(struct drm_framebuffer *fb,
 
 struct frontbuffer_fence_cb {
 	struct dma_fence_cb base;
+	struct work_struct work;
 	struct intel_frontbuffer *front;
 };
 
+static void intel_user_framebuffer_fence_work(struct work_struct *work)
+{
+	struct frontbuffer_fence_cb *cb = container_of(work, typeof(*cb), work);
+	struct intel_frontbuffer *front = cb->front;
+
+	intel_frontbuffer_flush(front, ORIGIN_DIRTYFB);
+	intel_parent_frontbuffer_put(front->display, front);
+	kfree(cb);
+}
+
 static void intel_user_framebuffer_fence_wake(struct dma_fence *dma,
 					      struct dma_fence_cb *data)
 {
 	struct frontbuffer_fence_cb *cb = container_of(data, typeof(*cb), base);
 
-	intel_frontbuffer_queue_flush(cb->front);
-	kfree(cb);
+	schedule_work(&cb->work);
 	dma_fence_put(dma);
 }
 
@@ -2160,6 +2171,7 @@ static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
 					struct drm_clip_rect *clips,
 					unsigned int num_clips)
 {
+	struct intel_display *display = to_intel_display(fb->dev);
 	struct drm_gem_object *obj = intel_fb_bo(fb);
 	struct intel_frontbuffer *front = to_intel_frontbuffer(fb);
 	struct dma_fence *fence;
@@ -2185,6 +2197,8 @@ static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
 	}
 
 	cb->front = front;
+	INIT_WORK(&cb->work, intel_user_framebuffer_fence_work);
+	intel_parent_frontbuffer_ref(display, front);
 
 	intel_frontbuffer_invalidate(front, ORIGIN_DIRTYFB);
 
-- 
2.51.0.windows.1

