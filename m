Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D63606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Et88hbJB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15CF10FC31;
	Wed, 18 Nov 2026 13:46:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8887210FCC8;
 Wed, 18 Nov 2026 13:46:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C5C0446F3;
 Wed, 18 Nov 2026 13:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8611F000CB;
 Wed, 18 Nov 2026 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795009572;
 bh=sDJGspNFkUyu8KxOLu1jE5eutQREHyym7I9CvkghZBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Et88hbJBRGxCGoNpGGEEpOInHeVF2PPHct24eJZfCN58VJ/QUk+bBjz3PPlnEHEvv
 M/k+Fv5cuwhXXOdab4BEWxpbTB2zijxONxjiWc2NSqpr7OTQNPjsZsJkQGrr98tOlN
 5TJOosp3QtfF8xTFqjhlYrFmpjf1n40YXxV3QNy8PVqvcf2SOWWbNA7+roaW7ADmBZ
 8jmwTNoTugKWl4srTRmwRr7XJjCN3IsPtBZ4Vsl+aKdEirLZV14I7EDGTXNJXGzwFG
 4FvZTeDqbELFlCPM9+s3QaDV3x1yATofQTzCdGz6u6TkbTKA6SPE8UWti/RbKP5JQG
 Jz6zt5eJMdsVw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 David Rosca <david.rosca@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.or
Subject: [PATCH v2 3/3] dma-buf: dma-fence: Remove dma_fence_init64()
Date: Wed, 18 Nov 2026 14:45:23 +0100
Message-ID: <20261118134522.1646892-5-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118134522.1646892-2-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All users of dma_fence_init64() have been removed. They now use the
respective initialization flag in dma_fence_init().

Remove dma_fence_init64().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 27 ---------------------------
 include/linux/dma-fence.h   |  2 --
 2 files changed, 29 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 7bc925793e24..0776ca7c795e 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1139,33 +1139,6 @@ dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 }
 EXPORT_SYMBOL(dma_fence_init);
 
-/**
- * dma_fence_init64 - Initialize a custom fence with 64-bit seqno support.
- * @fence: the fence to initialize
- * @ops: the dma_fence_ops for operations on this fence
- * @lock: optional irqsafe spinlock to use for locking this fence
- * @context: the execution context this fence is run on
- * @seqno: a linear increasing sequence number for this context
- *
- * Initializes an allocated fence, the caller doesn't have to keep its
- * refcount after committing with this fence, but it will need to hold a
- * refcount again if &dma_fence_ops.enable_signaling gets called.
- *
- * Context and seqno are used for easy comparison between fences, allowing
- * to check which fence is later by simply using dma_fence_later().
- *
- * New users MUST NOT use external locks. Check the documentation in
- * dma_fence_init() to understand the motives behind the legacy use cases.
- */
-void
-dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
-		 spinlock_t *lock, u64 context, u64 seqno)
-{
-	__dma_fence_init(fence, ops, lock, context, seqno,
-			 BIT(DMA_FENCE_FLAG_SEQNO64_BIT));
-}
-EXPORT_SYMBOL(dma_fence_init64);
-
 /**
  * dma_fence_driver_name - Access the driver name
  * @fence: the fence to query
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 6f5c245d89ec..56c4e5beaafe 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -288,8 +288,6 @@ struct dma_fence_ops {
 void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 		    spinlock_t *lock, u64 context, u64 seqno,
 		    unsigned long flags);
-void dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
-		      spinlock_t *lock, u64 context, u64 seqno);
 void dma_fence_release(struct kref *kref);
 void dma_fence_free(struct dma_fence *fence);
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq);
-- 
2.56.0

