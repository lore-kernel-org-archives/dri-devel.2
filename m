Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599B1606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=pNCm+pLD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14AD11227F;
	Thu, 26 Nov 2026 11:12:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414C910E99F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=udf1zVkr/XM2w6J1wjpfGUx0VL2EIiLeBhGzchtJ30o=; t=1795691492; x=2111051492; 
 b=pNCm+pLDrJXC4UbfIx+BzdvuwLkPmcWNArXyJ2Tyz3N0FIJCEaKwXK0ixGFZVXuEoJX4I04dboE
 0/f0bSuvRX8u81ehP2gAB6Tg1aRAsL1oCNJUwmBJOgZJE3aIl7y+eXyQNrarFoIM/zRP+ttb9nP5w
 dieD8LiizwbboirN29lHH+CfgQZjtR5YGeuCxrDQgp8cDFx5uZ6ZsCGj2778KD5NK3mB+D21GHarz
 70ez2MpsGAdrWlT4NFwWb1x0cQzDrjjlhMhymvG7y76OI2ehNh3i38SLXXXCbp9onKhVBc2KSc4lZ
 AswSzVzh0BPrVC/yGoiNNwG4EfztCj/FDYWQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXNy-00000004MPx-2rLV; Thu, 26 Nov 2026 12:11:30 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 2/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_array_wait_timeout points
Date: Thu, 26 Nov 2026 11:11:12 +0000
Message-ID: <20261126111117.67342-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use scoped cleanup for drm_syncobj_array_wait_timeout points array
allocation.

This is a split out step towards converting the whole function with the
goal of simpler error handling and easier extending with a fast path in
the future.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_syncobj.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 663d6cb8dbf8..bd3f9e74e678 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -193,6 +193,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/cleanup.h>
 #include <linux/dma-fence-unwrap.h>
 #include <linux/eventfd.h>
 #include <linux/export.h>
@@ -1052,8 +1053,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  ktime_t *deadline)
 {
 	struct syncobj_wait_entry *entries;
+	u64 *points __free(kvfree) = NULL;
 	struct dma_fence *fence;
-	uint64_t *points;
 	uint32_t signaled_count, i;
 
 	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
@@ -1063,23 +1064,18 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	}
 
 	points = kvmalloc_objs(*points, count);
-	if (points == NULL)
+	if (!points)
 		return -ENOMEM;
 
-	if (!user_points) {
-		memset(points, 0, count * sizeof(uint64_t));
-
-	} else if (copy_from_user(points, user_points,
-				  sizeof(uint64_t) * count)) {
-		timeout = -EFAULT;
-		goto err_free_points;
-	}
+	if (!user_points)
+		memset(points, 0, count * sizeof(u64));
+	else if (copy_from_user(points, user_points, sizeof(u64) * count))
+		return -EFAULT;
 
 	entries = kvzalloc_objs(*entries, count);
-	if (!entries) {
-		timeout = -ENOMEM;
-		goto err_free_points;
-	}
+	if (!entries)
+		return -ENOMEM;
+
 	/* Walk the list of sync objects and initialize entries.  We do
 	 * this up-front so that we can properly return -EINVAL if there is
 	 * a syncobj with a missing fence and then never have the chance of
@@ -1198,9 +1194,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	}
 	kvfree(entries);
 
-err_free_points:
-	kvfree(points);
-
 	return timeout;
 }
 
-- 
2.56.0

