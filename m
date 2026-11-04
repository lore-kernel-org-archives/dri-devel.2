Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E1606D804
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BED10F984;
	Wed,  4 Nov 2026 02:53:38 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72A010F982
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:53:37 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowADnD_osnupq4+Q+AA--.29482S2;
 Wed, 04 Nov 2026 10:53:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/gem-atomic-helper: fix explicit fence leak without a
 framebuffer
Date: Wed,  4 Nov 2026 02:53:42 +0000
Message-Id: <20261104025342.1527424-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnD_osnupq4+Q+AA--.29482S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxtr47tFy7XF1UAr1fJFb_yoW8WFy8pw
 s8Gry5Krs8tF4Y93Z7WF1vvayakw4fKFWIgrWkAr4a9w1Yqr17ZF1jvrZrur43Jr97Cw13
 tr12y3Z5uryUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
 v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
 McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAa
 w2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
 Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bpfOcUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQBA2rqY-niiAAAsv
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_gem_plane_helper_prepare_fb() takes a reference on state->fence
before checking whether the plane state has a framebuffer. An explicit
fence can be attached to a disabled plane through the IN_FENCE_FD
property, and drm_atomic_plane_check() accepts that state because CRTC
and framebuffer are both unset. The early return for the missing
framebuffer then drops the newly acquired reference without releasing
it.

Move the reference acquisition after the framebuffer check.

Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper_prepare_fb v2")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index dd9efa7e3216..6c7bdb141905 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -114,7 +114,7 @@
 int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
-	struct dma_fence *fence = dma_fence_get(state->fence);
+	struct dma_fence *fence;
 	enum dma_resv_usage usage;
 	size_t i;
 	int ret;
@@ -122,6 +122,8 @@ int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 	if (!state->fb)
 		return 0;
 
+	fence = dma_fence_get(state->fence);
+
 	/*
 	 * Only add the kernel fences here if there is already a fence set via
 	 * explicit fencing interfaces on the atomic ioctl.
-- 
2.34.1

