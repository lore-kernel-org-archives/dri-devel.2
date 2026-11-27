Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qji4ixgx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1C41129D2;
	Fri, 27 Nov 2026 10:20:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECAC1129BB;
 Fri, 27 Nov 2026 10:20:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A701F416EA;
 Fri, 27 Nov 2026 10:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D50F1F00929;
 Fri, 27 Nov 2026 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774838;
 bh=l1oAF/DiYNS3X/YLQAQd9jHYIgVJICE43BOpftyq7DM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Qji4ixgxNe/uPnxNQATM7G79DPAjqHzxro0BE4Uy8CMXl+3avk6TCqY90BEl2Bn/a
 nWjAYt40p2SaRX937+fv6Jhp/JKfWJSOAe5IzitvMdKA9RsO43q5xLK7otJO7TkLCV
 cx2oLFERKILvx/J2ICzjmVzwtkf9kJ0Iz0KOWtHku3VgQ2H+XXrrN+ovaBrDfIth3O
 FKXEkop+4Sq8uFRdsL6e/kHIFf1NNVJSBZWLUbgwsZYvMx9FDtL0u6NsJMjq4098zX
 P0+FWHnJ3VMZVjT+N0JL969edrs4uTnl3+HOBJzaMlEUkiQ7fGnw7Vco8yk4cyRhRR
 GlfvGrL9hPijQ==
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
Subject: [RFC PATCH 6/8] dma-buf: sync_debug: don't use TIMESTAMP bit
Date: Fri, 27 Nov 2026 11:18:11 +0100
Message-ID: <20261127101812.2706432-8-phasta@kernel.org>
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

dma_fence's TIMESTAMP bit doesn't really serve a purpose and should be
removed. Direct accessors should therefore be ported.

Use dma_fence_timestamp() in sync_debug.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/sync_debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
index 9e5d662cd4e8..58c0d00ba5b3 100644
--- a/drivers/dma-buf/sync_debug.c
+++ b/drivers/dma-buf/sync_debug.c
@@ -46,6 +46,8 @@ static void sync_print_fence(struct seq_file *s,
 			     struct dma_fence *fence, bool show)
 {
 	struct sync_timeline *parent = dma_fence_parent(fence);
+	struct timespec64 ts64;
+	ktime_t ts;
 	int status;
 
 	status = dma_fence_get_status_locked(fence);
@@ -55,10 +57,8 @@ static void sync_print_fence(struct seq_file *s,
 		   show ? "_" : "",
 		   sync_status_str(status));
 
-	if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags)) {
-		struct timespec64 ts64 =
-			ktime_to_timespec64(fence->timestamp);
-
+	if (dma_fence_timestamp(fence, &ts) == 0) {
+		ts64 = ktime_to_timespec64(ts);
 		seq_printf(s, "@%ptSp", &ts64);
 	}
 
-- 
2.56.0

