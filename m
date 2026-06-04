Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54639CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBAA10EF63;
	Thu,  4 Jun 2026 20:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FdpqnRox";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E65610F0D8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGzxWorI1WSPNnuszObDbT35PKIqjrK3mVfXTUiu0o8=; b=FdpqnRox+FBBfxj4N7mN79IidN
 J6vNGgWjw5fqpi+gByl2lxtwPcRXF+f49m24X7euJ0vdMi35C7kTDCVho/DGzxCcUmhj8RbJpcMYt
 R/iQVzOaVhPqsPTxEZeE7DDb+FXKAWe/g6ZlvG9JfifT8/LJeDjlukCno/a28IsZIDqfb6bppLBiG
 fBLccbIBYTw6Eru26yD/vVypqDMLgGK7vhubYa2OGOrUZSygC7i4zTnxkQORIbWyZsc6SAz6G9NsJ
 lf3WaTmiHj/sq9DVTfr7SHKif6k7GNNGZzcDJloacahAImys8qFkSJk5Q/jdYvYfPLNcJ0u0Zy7II
 wj2Revgw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVEjs-00CoGD-QW; Thu, 04 Jun 2026 22:32:29 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 04 Jun 2026 17:32:14 -0300
Subject: [PATCH v4 01/12] drm/v3d: Drop unused drm_encoder.h include from
 v3d_drv.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-v3d-sched-misc-fixes-v4-1-c068f5bf5ccf@igalia.com>
References: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
In-Reply-To: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=scpYwZF1xTCU+NKRY+hI7mDvbzs1OcGFXyPoGpF+9yM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIeDTerpTKt0B0QbvzQcU6urE2aObzJDVmB+Cv
 s50qTeFXUKJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiHg0wAKCRA/8w6Kdoj6
 qu7wCAC7NuYaoe1acjbDqIyXtZWYsaYVep584aHHh75o9ZTx+lgAKgdTq607yx7ul17TQwd2pWX
 Kp4tIwkfpqLokCk4giAGKbFNS8KJu2jhssB5THjUrtbnrrIQrJVMVREgW1EhG3vBxoNynyZGmbR
 5pqmPZ8PlT1edgm9RhR9AZo/LtM3+Oq/0e2AXVAM4D89sPp6PXjKYwetsk6PxKGb6eBXWeEQ5N3
 PISwtbCSgRXPNmq5XbpBG+OVKAYOfbvMatdEE/r5MPShhohgNhRQ9Svq81YFohXXiCzfM2nMtpv
 O7qgypuAM71mQwin0loLw8gDanmawCbZVVn/LFlZyCFZLSzN
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The V3D driver has no display pipeline, so nothing in the driver requires
drm_encoder.h. Remove the stale include.

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 4ebe175a8c6b..5a0b9da2c3aa 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -7,7 +7,6 @@
 #include <linux/spinlock_types.h>
 #include <linux/workqueue.h>
 
-#include <drm/drm_encoder.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/gpu_scheduler.h>

-- 
2.54.0

