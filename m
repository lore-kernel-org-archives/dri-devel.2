Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883060D8784
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=AMzVfm7T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0AC10FE9C;
	Wed,  4 Nov 2026 19:52:24 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A8210FE9C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793821931; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MoLHc54x7qGgeme3uIi4vzQxOsXG56m41YDZc5JXxBtcfoEHcVseu1D8Q6saZBGIsis+HUYniq24+DGkUnWdJQ7U9OGvr3Qo+zxj4GA96KMEOR5pLDWqQ/MKDaSfz7eZwzQqkHE8cVeAdqENAuFAUzYOerlh0jNTev00XO1Qotg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793821931;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8sxA/Ew+8y+kh+ApHCSaVPuVXPRc9Y/87473zlKJEcg=; 
 b=DVCXHUJ4vWWTEcx2VI5BBE10BBcdHJB9j0JJKoFfnMC9TICghijBpWueJOxsLDjp1ruKjtuEZfSfkWVw8LE6RAG/0gU3Jdg0pRsh4tb2mWkwWP4l6kXv4RmCBayMR+YpvVO+CVajCK2zNFRMQyhaR7LC8NIzUr7/iQ87++fL8TU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=AMzVfm7TjGCFuy+liHxGnSX3/jMHnnKs3ADOkLqCkfh3iDas56D5RiUSpJsS7C47ihjD7T3603asn2vqF7xRpuEg41FZnGVbqORVBeAc9dNfD5qhlnqg+CDAIZmOUHZncB9YmAtgFMrH5e4BuzdwMep2n76tSrCXynARADlUHLo=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=8sxA/Ew+8y+kh+ApHCSaVPuVXPRc9Y/87473zlKJEcg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793821929857405.4513400697864;
 Wed, 4 Nov 2026 11:52:09 -0800 (PST)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 04 Nov 2026 19:51:53 +0000
Subject: [PATCH v3 1/2] drm/panfrost: Enable cycle counting when perfcnt is
 enabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-panfrost-reset-races-fixes-v3-1-09868a88c351@collabora.com>
References: <20261104-panfrost-reset-races-fixes-v3-0-09868a88c351@collabora.com>
In-Reply-To: <20261104-panfrost-reset-races-fixes-v3-0-09868a88c351@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=EYaOvCu9driwxEg1ovUxjwRxgMl/N3tcKGd7zqJyWX8=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq64zh25mXNlQSAlmlarJgMZGErNmxyJpSQRG84
 RPbtTGfyoeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCauuM4QAKCRAOJn5M7lND
 PbsnDAC06UJKySvidbXxD0ZBQcJWlYl0KA7DrOEyYAtVBSPQ50zQFBWm0yY56r5BIPcrpiAD/Cz
 gS6Rid0v+aOoKicGNcdIbphp+0TvCpoDH1OPoJyAiZZlHLC5pVl8Vtjq6LMX/5J7IKryOE4rst1
 tiNmUFXCnWuO1NYXshaYhHi7UB3yru/HPAhakVDGgt7km6sX0nOLeLyW8c8+EmKyNPg4UlifT7e
 H/Snpru1gt9PscYYzsx1dSFghSDXPtuJRJda5mfUGPLBAdx6CTholBaLi6Hptc0quinImjrAZNQ
 xDjHWxynz4j69kePVS50MzrMVmoJkayqJ8LCaJM2LcKzJUPv++rBQXgFy/dkN7z9BmcZgNkxJUj
 2IH5KceHl5GslfSiDU8w46UsFBolfOjQTnPECFK/Y8hjScSU+gS6jozf0V613d8DZDM07OrUux+
 ndVw7TmgGXzPa58NkUoF3smgKPdiK64COv5lB/cFZ/c+nbdxUPRCjyP8yHJXzsPQe5lXQ=
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

We also need to skip the warning on the cycle counter reference being
other than 0 during device reset, because of perfcnt's lingering ref.

Ideally this would be dealt with by splitting the reset sequence into
pre and post stages, so that a hypothetical panfrost_perfcnt_pre_reset()
would release the cycle counter reference. In the absence thereof, we
just make do.

Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c     | 7 +++----
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 3 +++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 6081b27829e1..5c3fee65c9e3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -94,11 +94,10 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
 
 	/*
-	 * All in-flight jobs should have released their cycle
-	 * counter references upon reset, but let us make sure
+	 * Even though all in-flight jobs should have released their cycle counter
+	 * references upon reset, perfcnt's might still hang about.
 	 */
-	if (drm_WARN_ON(&pfdev->base, atomic_read(&pfdev->cycle_counter.use_count) != 0))
-		atomic_set(&pfdev->cycle_counter.use_count, 0);
+	atomic_set(&pfdev->cycle_counter.use_count, 0);
 
 	return 0;
 }
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

