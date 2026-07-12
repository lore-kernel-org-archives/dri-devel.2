Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8970DC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0C510E4A1;
	Sun, 12 Jul 2026 15:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="I8DUQyG2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F8C10E49E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=POVecxJo4zwZUgERoZ5svXQmm69KssESofLU10hbjYM=; b=I8DUQyG2bkjduejyIHXjg+FFCp
 uYv6u1Co7CrDBpkvlco7IEJTuUNTRdq7mV3g4Uq1hEAWklK4AmPl67v5MHs6SELeVh28JUfQ04pQv
 6t1f1IL6YugkQNqUffpHuQAmWGoDoPWcIdsSXJpytzNcd+R0KaUz+tAaXIn+Nu3oCwnSnkOjk6Tla
 TTc5E2RIIQqUXLERZVzFvWcCLtZHEmaWE0gOf6r+1iZIFqDr6D4oB96yAcnIkzl0sn07Sf3UrASgo
 f38NFfqieGzv8Ut9K6gNPezSf0VfMUINUf9CV1Obep2zQNZQJto6u3X+qS9AyUgg8U+euMmC0/cXK
 4N8VN48Q==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wivtn-00DnB6-4i; Sun, 12 Jul 2026 17:15:19 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 12 Jul 2026 12:14:41 -0300
Subject: [PATCH v3 8/8] drm/vc4: Use unique fence timeline names per queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260712-vc4-drm-scheduler-v3-8-ed6dc4defa53@igalia.com>
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
In-Reply-To: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=/B+/LCq2qCK0xfxjZR1vfiQzIm5bA193rCDvDqMipoc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqU69gP5RbopA00s/amsKHQ8OTdSWgS+qiIOMxG
 7Q1Mx5+teCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCalOvYAAKCRA/8w6Kdoj6
 ql8LB/0UcUsJcG4zGlpfbuIM2XB3AM5fi1o8Qa2BTB+xDRuoNZgqwN2DNgLGmdYaopxtyLwVvML
 ZC0NNGRUYNoAwm4PUYAmi3sJxDtZ5mH9CXkyor5hpVM6hsvd5BvGR9/5f024RtxHt0nviJbqXhJ
 vdHZEDvHNNq8wCZ2ZSZXqJS/S48AMDwelk/M+zn5/NsVwpAWDf/zpH7uSYc2FkV0IpiLHgOgzRR
 ZdrQXfbRQPrh5sFfD9FLB3fEyEaH5txqSCkR6i6acbO6Qz4FaugTr4BshHpZYC/a1GylXOjGbYk
 GeL/BTuX2t33BVTSr3LFqfMhDEPKVgLS65ssPmbRZkAgsxBB
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Return distinct timeline names ("vc4-bin" and "vc4-render") from
vc4_fence_get_timeline_name() based on the fence's queue, instead of
the generic "vc4-v3d" for all fences. This improves debuggability when
inspecting fence state.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_fence.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_fence.c b/drivers/gpu/drm/vc4/vc4_fence.c
index 12f164983238..3b30107bbc4a 100644
--- a/drivers/gpu/drm/vc4/vc4_fence.c
+++ b/drivers/gpu/drm/vc4/vc4_fence.c
@@ -48,7 +48,16 @@ static const char *vc4_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *vc4_fence_get_timeline_name(struct dma_fence *fence)
 {
-	return "vc4-v3d";
+	struct vc4_fence *f = to_vc4_fence(fence);
+
+	switch (f->queue) {
+	case VC4_BIN:
+		return "vc4-bin";
+	case VC4_RENDER:
+		return "vc4-render";
+	default:
+		return "vc4-unknown";
+	}
 }
 
 const struct dma_fence_ops vc4_fence_ops = {

-- 
2.54.0

