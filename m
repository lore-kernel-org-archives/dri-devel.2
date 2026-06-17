Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47946CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5D710EA15;
	Wed, 17 Jun 2026 14:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SFdZmKBy";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5242B10EA15
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781706587;
 bh=BYhd3JyLy4A36Gqzmm534xZlIQvA03wuQHMi5zyr5bY=;
 h=From:Date:Subject:To:Cc:From;
 b=SFdZmKByu1D1pBJz5ieyESOUfMHYGQChP5gee3bJeZjsbOLGFTgnlXfcmJ47bQ0QN
 jnml7ggbzEpSmI0REW+UV1IvcVBXPQk+b+nVlfanTHVHBRPVeEuZoahICO7yWqbF5w
 eIVqm054AL8JnAMrkZMjU/7OAzKSOk/3Rt9PJbitskVn0FSFcu+rzbk3d6p9ypA/A+
 c6Y/Bp/6bl7xnedFnQXmRGvPbWiJHpwLB44ESiI0IFvGbFpYBAYySYx2tICsmpRDTr
 mVmEzMF9C85Bst+pIXOiaBbzQts79gyDR5tUobf0fhgFV7K+KXJEhW83laAO4EGRXg
 UFRkoi/OTXRKA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5852817E0530;
 Wed, 17 Jun 2026 16:29:47 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 17 Jun 2026 16:29:46 +0200
Subject: [PATCH] drm/panfrost: Enable cycle counting when perfcnt is
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-panfrost-perfcnt-timestamp-fix-v1-1-f215f44b55c0@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNyw7CIBAAf4Xs2U0AaRv7K6YHpIvugYdAjUnTf
 5fY48xhZodKhanCLHYo9OHKKXZQFwHuZeOTkNfOoKUe5agmzDb6kmrDTMW72LBxoNpsyOj5i4M
 iaaTU3twM9Egu1PV/cF9OLvTe+qedEh62EroUArdZTM56bfV1UKuB5Th+CT/LsKAAAAA=
X-Change-ID: 20260617-panfrost-perfcnt-timestamp-fix-51e04002f494
To: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781706587; l=1818;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=BYhd3JyLy4A36Gqzmm534xZlIQvA03wuQHMi5zyr5bY=;
 b=KMNjAuSpVPjWa9koGC4iXTK4fM2+sjZv5IETaW+dpetkrLvYlqUFGEKj5+lO64EXoQ3/BTV79
 ehScJ7S9RacAMUA+XWVCHxQRakqMxNo+8itwcqiOUE7gpjqkOfXZlIw
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

If we don't do that, we end up with invalid timestamps in the
block headers.

Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Found while reworking the userside of the perfcnt logic.
Up until now, we were not using the GPU timestamps in the dumps,
but this is going to change, so we need that fix in, and
backported to all stable releases, ideally.
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 7020c0192e18..63861b4c7d95 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -15,6 +15,7 @@
 #include "panfrost_device.h"
 #include "panfrost_features.h"
 #include "panfrost_gem.h"
+#include "panfrost_gpu.h"
 #include "panfrost_issues.h"
 #include "panfrost_job.h"
 #include "panfrost_mmu.h"
@@ -166,6 +167,7 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
+	panfrost_cycle_counter_get(pfdev);
 	perfcnt->user = user;
 
 	return 0;
@@ -207,6 +209,7 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
 	panfrost_gem_mapping_put(perfcnt->mapping);
 	perfcnt->mapping = NULL;
+	panfrost_cycle_counter_put(pfdev);
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 
 	return 0;

---
base-commit: 7caf2a2351d4053075670ff3e26a6815da0a9e1e
change-id: 20260617-panfrost-perfcnt-timestamp-fix-51e04002f494

Best regards,
-- 
Boris Brezillon <boris.brezillon@collabora.com>

