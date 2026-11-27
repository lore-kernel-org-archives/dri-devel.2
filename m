Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37F606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLXVh0Ex
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8F71129AD;
	Fri, 27 Nov 2026 10:20:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DA91129BA;
 Fri, 27 Nov 2026 10:20:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61E7D4557F;
 Fri, 27 Nov 2026 10:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947621F0089F;
 Fri, 27 Nov 2026 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774807;
 bh=yrYR0q6nUuvJ4hHyNfVgv3yvODscAW5Pi/E+MKFC5So=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZLXVh0Exjw6q+FG8YIJtriF3iMNMHk5Erd6SVVvQRDKyLIni5Fvy1slxdPIESCllT
 f8s3LQ/5DMXB33otavzQpPTbBNAf5TQN46Bpj0iYPlob1k54gw0jKVXQQWejTPKi0u
 lOi87lL40zXlXpihdYJSmIwbzTq9GEky4X2GOZHAFcetSdw62IsoT3HSYBvGdlDzjo
 yiAgxKzBXnsGbLSIQOxSpX5mvn6H6Ymd4jMLac3SalR2VF0GO9Ru/SZ576OI/laHjl
 AocSc7kT9FCAOobEAF6yGz8+BeRUi84Zs/C/0Pj2++ATr4TppeHzVykqD2yo+FwOT2
 gw0oU3v78wnwQ==
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
 intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: [RFC PATCH 1/8] dma-buf: dma-fence: Hot-fix timestamp misordering
Date: Fri, 27 Nov 2026 11:18:06 +0100
Message-ID: <20261127101812.2706432-3-phasta@kernel.org>
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

fence timestamps can be written and read without any memory ordering
since, presumably, forever. This can cause real bugs, other than false
accounting, for parties whose algorithms depend on the timestamp.

Hot-fix the problem for now so that it can be backported until we found
a suitable way forward for mainline.

Cc: stable@vger.kernel.org
Fixes: 76250f2b743b ("dma-buf/fence: Avoid use of uninitialised timestamp")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 9 +++++++++
 include/linux/dma-fence.h   | 8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index ab02afdb0f18..c947aec1bf91 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -378,6 +378,15 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 	list_replace(&fence->cb_list, &cb_list);
 
 	fence->timestamp = timestamp;
+	/*
+	 * TODO:
+	 * This is a temporary hotfix to prevent misordering until we
+	 * can completely remove the TIMESTAMP bit.
+	 *
+	 * The counterpart of this barrier are the test_bit_acquire()s in
+	 * dma_fence_timestamp().
+	 */
+	smp_mb__before_atomic();
 	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
 
 	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 513d9dbbff47..29c4332c8662 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -686,10 +686,14 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
  */
 static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
 {
-	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
+	/*
+	 * The test_bit_acquire() calls order against the
+	 * smp_mb__before_atomic() in dma_fence_signal_timestamp_locked().
+	 */
+	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
 		return ktime_get();
 
-	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
+	while (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
 		cpu_relax();
 
 	return fence->timestamp;
-- 
2.56.0

