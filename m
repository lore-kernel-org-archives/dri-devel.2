Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384B606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=KIrJAl/b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8133B10E99F;
	Thu, 26 Nov 2026 11:11:50 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA676112273
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=WJ0HbR0Myxv1wfkGkFH8+HTcU+P7qqiG2ZGUPntqwX4=; t=1795691493; x=2111051493; 
 b=KIrJAl/btQ8vKMRHmqLl56LJxcjF7oAN5fSjn3VmXE/co8Hel2DUvp+BEtxGuW9dMw6BhfI0F4i
 UM0O9oLk0wlJMaUnJaWPxagCp09jcYBPxBVZZNXWdodS/cCm8KFsF0se5AJ//eqAYl+I0phD5JUnn
 GiH0wnSYNfMePWZx+Wxhi22Rm6P8tBFC7EKbV1LPehmwNS9K/dfjcc5bj6dtD7xe2lM9XJRJKZ8eU
 ih9cmA9n3kffB2+QKbs3z4GqjYPyIf87SJTUFg9iGHXvZKm0TxdzoGZEQx8mB+rJQzvO30SXkDK+s
 H9ZdQd3YzvwV1XA2Lzy6QhfgHuakQVuxGPcQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXO0-00000004MQC-09Eq; Thu, 26 Nov 2026 12:11:32 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 4/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_timeline_signal_ioctl points
Date: Thu, 26 Nov 2026 11:11:14 +0000
Message-ID: <20261126111117.67342-5-tvrtko.ursulin@igalia.com>
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

Use scoped cleanup for drm_syncobj_timeline_signal_ioctl points array
allocation.

This is a split out step towards converting the whole function with the
goal of simpler error handling and easier extending with a fast path in
the future.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_syncobj.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 7d5c4e4e29b2..e05051c3895f 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1571,9 +1571,9 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_array *args = data;
+	u64 *points __free(kvfree) = NULL;
 	struct drm_syncobj **syncobjs;
 	struct dma_fence_chain **chains;
-	uint64_t *points;
 	uint32_t i, j;
 	int ret;
 
@@ -1599,17 +1599,17 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		goto out;
 	}
 	if (!u64_to_user_ptr(args->points)) {
-		memset(points, 0, args->count_handles * sizeof(uint64_t));
+		memset(points, 0, args->count_handles * sizeof(u64));
 	} else if (copy_from_user(points, u64_to_user_ptr(args->points),
-				  sizeof(uint64_t) * args->count_handles)) {
+				  sizeof(u64) * args->count_handles)) {
 		ret = -EFAULT;
-		goto err_points;
+		goto out;
 	}
 
 	chains = kvmalloc_objs(*chains, args->count_handles);
 	if (!chains) {
 		ret = -ENOMEM;
-		goto err_points;
+		goto out;
 	}
 	for (i = 0; i < args->count_handles; i++) {
 		chains[i] = dma_fence_chain_alloc();
@@ -1630,8 +1630,6 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 	}
 err_chains:
 	kvfree(chains);
-err_points:
-	kvfree(points);
 out:
 	drm_syncobj_array_free(syncobjs, args->count_handles);
 
-- 
2.56.0

