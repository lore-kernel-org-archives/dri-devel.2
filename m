Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53AF606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUnVub/z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDAF1129BC;
	Fri, 27 Nov 2026 10:20:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09CF1129BC;
 Fri, 27 Nov 2026 10:20:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A108A459B5;
 Fri, 27 Nov 2026 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79191F000C1;
 Fri, 27 Nov 2026 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774820;
 bh=G26qrvYEnf3XkTM55Hz4I7jUepmcpg76jzpe7qYVv+8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LUnVub/zJIjk7WOXcRX5o1E4BdvdmyLM5vpiIh5/ter7Tb65pG/l+AV+eDQ2lcZw+
 VP+Zz0UhqUgM7AYzSAyvW9RxL/hplY81ph4uDZayrH+w59EWU//MCs+3Kkc35mxf12
 ooMxv9IVyZciKc+XcSrq5ODhSVpWES1vENRifb/xBefZWOYbql3hDZVJAjlMjkvL3E
 efIO9eYIt5p3sOup71mmUXPyIyecDmeHEiMe2yIyWGbm30ex94ENNJgQOxxtCOo7EE
 s5HIk9OZphLGDJmqcfpYXmwsPXDs3xBNu1TdMRj4OxjvNIpL9GcFqVYEthMNb6yrL5
 vWZJgIgich70g==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ruslan Vagner <rusya92266@gmail.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [RFC PATCH 3/8] dma-buf: dma-fence: Ensure ordering with locks for
 timestamps
Date: Fri, 27 Nov 2026 11:18:08 +0100
Message-ID: <20261127101812.2706432-5-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127101812.2706432-2-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The memory ordering in dma_fence_timestamp() is currently being done
manually with acquire functions. It can be done more elegantly with the
fence's spinlock. This also allows for removing the TIMESTAMP bit in the
long run.

Use locking in dma_fence_timestamp().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c |  9 ---------
 include/linux/dma-fence.h   | 24 ++++++++++++------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c947aec1bf91..ab02afdb0f18 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -378,15 +378,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 	list_replace(&fence->cb_list, &cb_list);
 
 	fence->timestamp = timestamp;
-	/*
-	 * TODO:
-	 * This is a temporary hotfix to prevent misordering until we
-	 * can completely remove the TIMESTAMP bit.
-	 *
-	 * The counterpart of this barrier are the test_bit_acquire()s in
-	 * dma_fence_timestamp().
-	 */
-	smp_mb__before_atomic();
 	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
 
 	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 29c4332c8662..1c1aa4c7635a 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -680,23 +680,23 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
  * dma_fence_timestamp - helper to get the completion timestamp of a fence
  * @fence: fence to get the timestamp from.
  *
- * After a fence is signaled the timestamp is updated with the signaling time,
- * but setting the timestamp can race with tasks waiting for the signaling. This
- * helper busy waits for the correct timestamp to appear.
+ * Return:
+ * The fence's timestamp if the fence is already signaled, the current time
+ * otherwise.
  */
 static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
 {
-	/*
-	 * The test_bit_acquire() calls order against the
-	 * smp_mb__before_atomic() in dma_fence_signal_timestamp_locked().
-	 */
+	unsigned long flags;
+	ktime_t ret;
+
+	dma_fence_lock_irqsave(fence, flags);
 	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
-		return ktime_get();
+		ret = ktime_get();
+	else
+		ret = fence->timestamp;
+	dma_fence_unlock_irqrestore(fence, flags);
 
-	while (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
-		cpu_relax();
-
-	return fence->timestamp;
+	return ret;
 }
 
 signed long dma_fence_wait_timeout(struct dma_fence *,
-- 
2.56.0

