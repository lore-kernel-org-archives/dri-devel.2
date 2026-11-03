Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39E606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gFWfxm5g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B83210F812;
	Tue,  3 Nov 2026 20:36:36 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C48E010F812
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793738185; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C0VfGACKNXhIOjOFU36AcExJe+e6uM1CAIp0tQ5dJf1GwQe8+/78FdnxjYpbH5QchHj8UDfcsfPtvmwK0tO4Qe6v8ZlD1UuEo0oHK/aDu58odzKgzRYnynWF1N7/a3VM3KIcYIx48v5JsGkrvs4zCX0kbrMcq19Q2SbJpRKt5FA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793738185;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Lc9HQXwzrOnFUZCljkZ2ROiKdVomMbqE4z9oE7SCNpY=; 
 b=R1mmPZxihBjH50XoLQGDkj1I9w5A4CbtD10d56P9iQlTuA76nKJM/Mr1HAUHuc/IK5eiKMlkNOHc4wbm/fQPOrzu9NNPQBq/zyZgqB7VU3fOY/f549ImtBjUdFxP4X7Ht4MrN7BnhtD7ISbpAYQIjUJpk6CeDbTWIVLXq5Gt1BY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=gFWfxm5gdAC+5MIokI2BxA0uQR/ahk8l49vpNfpJuL2XQ1JemkPffFk+sXgGckcSwZc1qEEHJAXgS9xViehSvxjuR1IpktUN6u3ZgvalYQXzoMdQajML2xcj73Hb1QhYgqD31xtRNBsRcecfaFEVWKTNjOo6cqj08c+i1Dlvz4I=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=Lc9HQXwzrOnFUZCljkZ2ROiKdVomMbqE4z9oE7SCNpY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793738184399526.6139064041298;
 Tue, 3 Nov 2026 12:36:24 -0800 (PST)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 03 Nov 2026 20:36:08 +0000
Subject: [PATCH v2 1/2] drm/panfrost: Enable cycle counting when perfcnt is
 enabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261103-panfrost-reset-races-fixes-v2-1-454207b1d4e3@collabora.com>
References: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
In-Reply-To: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=//zfzkb5ap92oHmlf8i7Ok7nFSgu4yTDiW4t7dFbrtU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq6kXACHxoIOJlQwLEopSlFqUbzwHWAOhOZz1nf
 V4O5dGFF9KJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaupFwAAKCRAOJn5M7lND
 PdTsDACJn/F6Yy1xAJR5xxJ8TGe5VlgI88nkbByYNVp2jrVUw0uY/YCy/RdCZFCrFihl0dckJ3R
 iQTmhhBl7nACwYEW8vEk46wFSIxYIsnGFtW/DZtFcp/KbQi5Xg73aJetS3AwM2Rp9Yn9FaMf4Ri
 pQi/b8xt7uFmmw8vgUsj9dTFFCuHtkntIm7jYBvGDq1kPuuSTG5Ae+xUtbSE85ZQNJjmT7PbTE0
 Y8R6gSJt/rNc1vg21DNDFpXt0tTBPCDUMW33dzvJi+qLfetQhzhtMLsrNjpBwTsgfhJ6gjczJgv
 DGyuDoY91eh13/9vMRFMua3Qo2Wiu9vw5fXQGjL1FqgubmS8+A1yUSVeX9ad6R3VVvqkUhD3V0J
 JvrCQNfcySIvMEYxr1IYI+DJTSsNMA2Z+hvYjuStRJ5gQW4/DvP6cVxxbJfSH+2mey/wseVtSbw
 gZAGDSOu1L32zDT2ooqNj0U18wDdkxmXryqDSMX95Ib/e0NXTJHY/ox3gXLgD2D35M1zk=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Boris Brezillon <boris.brezillon@collabora.com>

If we don't do that, we end up with invalid timestamps in the block
headers.

We also need to avoid the warning on the cycle counter reference being
other than 0 during device reset, because of perfcnt's lingering ref.

Ideally this would be dealt with by splitting the reset sequence into
pre and post stages, so that a hypothetical panfrost_perfcnt_pre_reset()
would release the cycle counter reference. In the absence thereof, we
just make do.

Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c     | 6 +++---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 6081b27829e1..7d66b1b50968 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -94,10 +94,10 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
 
 	/*
-	 * All in-flight jobs should have released their cycle
-	 * counter references upon reset, but let us make sure
+	 * Even though all in-flight jobs should have released their cycle counter
+	 * references upon reset, perfcnt's might still hang about.
 	 */
-	if (drm_WARN_ON(&pfdev->base, atomic_read(&pfdev->cycle_counter.use_count) != 0))
+	if (atomic_read(&pfdev->cycle_counter.use_count) != 0)
 		atomic_set(&pfdev->cycle_counter.use_count, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index a9def452d5ef..b26da057a1a0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -17,6 +17,7 @@
 #include "panfrost_device.h"
 #include "panfrost_features.h"
 #include "panfrost_gem.h"
+#include "panfrost_gpu.h"
 #include "panfrost_issues.h"
 #include "panfrost_job.h"
 #include "panfrost_mmu.h"
@@ -52,6 +53,7 @@ static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
 	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
 
 	if (perfcnt->owns_as_ref) {
+		panfrost_cycle_counter_put(pfdev);
 		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
 		perfcnt->owns_as_ref = false;
 	}
@@ -84,6 +86,7 @@ static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
 		return ret;
 
 	perfcnt->owns_as_ref = true;
+	panfrost_cycle_counter_get(pfdev);
 
 	as = ret;
 	cfg = GPU_PERFCNT_CFG_AS(as) |

-- 
2.56.0

