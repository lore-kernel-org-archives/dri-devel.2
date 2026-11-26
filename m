Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5D606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lUOS2vkA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B8A10E98B;
	Thu, 26 Nov 2026 11:11:50 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4466611227F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=+YHeIVubnkgJCCyo5WgSyJr3T4Mr9IwuThlghOG2VrA=; t=1795691494; x=2111051494; 
 b=lUOS2vkAuNMsILSTNaROffVh+xFDDmdVoanM4bciKBfL62Y4Coyp6JHGC3+LDXukl+6c7hy3v0E
 BUH8wsCFlFoKTT+0JF7Hc1mKq6ZgTtmP7Im2iWD4Uaty6JGJCPQZN9+7bxH/8dhG14dQzw8PWra04
 3ulCELvPG4D+inOCZiLU4NcUR2TDV4nYymIrR8I4BpodKHwmN8EKn4ABudNl2aMZGtHWxTKkDl9kL
 V6Rk7EYQTYjw6dFEWrpVnCbYpxYmUQXs04SLfmuvRaH/aOMfe4hIrgWgwYcEzPMzTK7GzuS6q53XC
 0VkgO/lwLsbLYmoh5SCOHiLPdUntJFnidOcQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXO0-00000004MQJ-2tnG; Thu, 26 Nov 2026 12:11:32 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 5/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_timeline_signal_ioctl chains
Date: Thu, 26 Nov 2026 11:11:15 +0000
Message-ID: <20261126111117.67342-6-tvrtko.ursulin@igalia.com>
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

Use scoped cleanup for drm_syncobj_timeline_signal_ioctl chains array
allocation.

This is a split out step towards converting the whole function with the
goal of simpler error handling and easier extending with a fast path in
the future.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_syncobj.c | 41 +++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index e05051c3895f..da90ae11382e 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1566,15 +1566,33 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 	return ret;
 }
 
+struct syncobj_chains {
+	struct dma_fence_chain **chains;
+	unsigned int count;
+};
+
+static void syncobj_chains_free(struct syncobj_chains *c)
+{
+	if (!c->chains)
+		return;
+
+	for (unsigned int i = 0; i < c->count; i++)
+		dma_fence_chain_free(c->chains[i]);
+
+	kvfree(c->chains);
+}
+
+DEFINE_FREE(syncobj_chains, struct syncobj_chains, syncobj_chains_free(&_T))
+
 int
 drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_array *args = data;
+	struct syncobj_chains chains __free(syncobj_chains) = {};
 	u64 *points __free(kvfree) = NULL;
 	struct drm_syncobj **syncobjs;
-	struct dma_fence_chain **chains;
-	uint32_t i, j;
+	unsigned int i;
 	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
@@ -1606,30 +1624,29 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		goto out;
 	}
 
-	chains = kvmalloc_objs(*chains, args->count_handles);
-	if (!chains) {
+	chains.chains = kvmalloc_objs(*chains.chains, args->count_handles);
+	if (!chains.chains) {
 		ret = -ENOMEM;
 		goto out;
 	}
 	for (i = 0; i < args->count_handles; i++) {
-		chains[i] = dma_fence_chain_alloc();
-		if (!chains[i]) {
-			for (j = 0; j < i; j++)
-				dma_fence_chain_free(chains[j]);
+		chains.chains[i] = dma_fence_chain_alloc();
+		if (!chains.chains[i]) {
 			ret = -ENOMEM;
-			goto err_chains;
+			goto out;
 		}
+		chains.count++;
 	}
 
 	for (i = 0; i < args->count_handles; i++) {
 		struct dma_fence *fence = dma_fence_get_stub();
 
-		drm_syncobj_add_point(syncobjs[i], chains[i],
+		drm_syncobj_add_point(syncobjs[i], chains.chains[i],
 				      fence, points[i]);
+		chains.chains[i] = NULL; /* Ownership transferred to syncobj */
 		dma_fence_put(fence);
 	}
-err_chains:
-	kvfree(chains);
+
 out:
 	drm_syncobj_array_free(syncobjs, args->count_handles);
 
-- 
2.56.0

