Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4D9CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56EC510EAFA;
	Sun,  4 Oct 2026 17:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="eHOvwfMH";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D521A10E2E0;
 Sat,  3 Oct 2026 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Qk
 3GrePbv9eu1xk5tupyIxeqhb2lAK9MbLxhiUca/KA=; b=eHOvwfMHvNGzeojbXg
 pZ2q3OeLtl52ICUnuVuobc+Zlea/ah83N8yyp69EuxLmM+MHsJfYHL9UGGlcKIQc
 LwK0Otq4fXpzCKAJBDt6SNx0WcV7XUMxO4HTOV0+XRzUYTqXJRfoBTdRq7lVwMBy
 JG88BRAvPOTO7HVuFt60BctrE=
Received: from pc.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDHr60ezcBqgZmsCg--.23244S2;
 Sat, 03 Oct 2026 17:38:39 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Qiang Yu <yuq825@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>,
 Heiko Stuebner <heiko@sntech.de>, Andreas Baierl <ichgeh@imkreisrum.de>,
 Simon Shields <simon@lineageos.org>, Erico Nunes <nunes.erico@gmail.com>,
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] drm/lima: Drain fence callbacks before destroying slab
Date: Sat,  3 Oct 2026 17:38:36 +0800
Message-Id: <20261003093837.545278-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgDHr60ezcBqgZmsCg--.23244S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1kXr4UGF4DXr4Dury3Arb_yoWDArb_Kw
 43Wrn3Gw17GFnrK3ZrZrn3Wr9akasrZFZ5ZrnYvFWfKry7JF1UXw4jgr45Z34UJ3W2y3Zx
 tanFqFyrXr9F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMWrXtUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR9Ff2rAzR+9BQAA3o
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:20:52 +0000
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

lima_fence_release() defers freeing fences from lima_fence_slab to an
RCU callback. The last lima_sched_slab_fini() can destroy the slab and
clear its pointer while a release callback is still queued. Module removal
can also free lima_fence_release_rcu() before that callback runs.

Drain outstanding callbacks before destroying the last fence slab.

Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 9a1e6b9ecbe5..9c5ff1929d3e 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -44,6 +44,7 @@ int lima_sched_slab_init(void)
 void lima_sched_slab_fini(void)
 {
 	if (!--lima_fence_slab_refcnt) {
+		rcu_barrier();
 		kmem_cache_destroy(lima_fence_slab);
 		lima_fence_slab = NULL;
 	}
-- 
2.34.1

