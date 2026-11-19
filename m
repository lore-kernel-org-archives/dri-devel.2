Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE95606A33B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsdMZiq6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E739A1123B7;
	Thu, 19 Nov 2026 13:19:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8021123B7
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:19:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2C2163664;
 Thu, 19 Nov 2026 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DD61F000D1;
 Thu, 19 Nov 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795094389;
 bh=AvbwH9Y5JevoXi9lMUsj5Ll88ttiIsFxxF+BtKfWlmw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bsdMZiq6Eiul/chqMrOMove8RWik4U638CdUM/Ho3cxG20J1TXFbRIyMdmcxChAMg
 IxoDA9xRArEP/4K/+izpDc2Gx5/3SivsubFflekLq/Tb/rdX9Iry31StAJApI3M+Gn
 MjKv+g56ACMIh8LD5okcyPJTJUwfT/aQV/IdX89Ixf8qPkUmFCgqhOZw19e1CSHgXA
 OntwljjtP6c/vpeszQL9S8ix3MlNSsH9yT1Jx6sny/vbNrd+equmj312s/paMy9B3I
 AgnvWLLNQNmhP529ieXoJspvgk8+KYa/LeFDpoLLurp03lFmW78VZ4h2mQP+VZdyli
 sXILWAh4vsmXQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Yunxiang Li <Yunxiang.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/3] dma-buf: dma-fence: Add dma_fence_overwrite_timestamp()
Date: Thu, 19 Nov 2026 14:18:30 +0100
Message-ID: <20261119131830.2535266-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119131830.2535266-2-phasta@kernel.org>
References: <20261119131830.2535266-2-phasta@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A fence's timestamp is just an opportunistic data point for debugging
information etc. drm_sched, for example, uses the timestamps for its
scheduling algorithms.

In rare situations it can make sense to allow users to overwrite a
timestamp with a more accurate value. This is relatively harmless since
the timestamp has no meaning for the implementation itself.

Add dma_fence_overwrite_timestamp().

Cc: stable@vger.kernel.org
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 28 ++++++++++++++++++++++++++++
 include/linux/dma-fence.h   |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..f1b7e90864bf 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -412,6 +412,34 @@ void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp)
 }
 EXPORT_SYMBOL(dma_fence_signal_timestamp);
 
+/**
+ * dma_fence_overwrite_timestamp - overwrite a fence's timestamp
+ * @fence: the fence whose timestamp shall be overwritten
+ * @timestamp: the timestamp
+ *
+ * A dma_fence's timestamp is merely an opportunistically evaluated value to
+ * obtain information such as scheduling granularity. In some situations it can
+ * make sense to overwrite with a custom value. This function provides said
+ * functionality with the correct memory ordering.
+ *
+ * Return: 0 on success, -EAGAIN if the fence was not yet signaled.
+ */
+int dma_fence_overwrite_timestamp(struct dma_fence *fence, ktime_t timestamp)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	dma_fence_lock_irqsave(fence, flags);
+	if (dma_fence_test_signaled_flag(fence))
+		fence->timestamp = timestamp;
+	else
+		ret = -EAGAIN;
+	dma_fence_unlock_irqrestore(fence, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(dma_fence_overwrite_timestamp);
+
 /**
  * dma_fence_signal_locked - signal completion of a fence
  * @fence: the fence to signal
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 34aefb63a7fe..815471b844f0 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -447,6 +447,7 @@ bool dma_fence_check_and_signal_locked(struct dma_fence *fence);
 void dma_fence_signal_locked(struct dma_fence *fence);
 void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp);
 void dma_fence_signal_timestamp_locked(struct dma_fence *fence, ktime_t timestamp);
+int dma_fence_overwrite_timestamp(struct dma_fence *fence, ktime_t timestamp);
 signed long dma_fence_default_wait(struct dma_fence *fence,
 				   bool intr, signed long timeout);
 int dma_fence_add_callback(struct dma_fence *fence,
-- 
2.56.0

