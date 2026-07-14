Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B83C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ABDC10EBD5;
	Tue, 14 Jul 2026 04:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RGR81HgJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB6C10EBD5;
 Tue, 14 Jul 2026 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784003340; x=1815539340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OF75BhOONNQwzjaDyW6clqtCVnBwxI6cANd1t7Zpbe0=;
 b=RGR81HgJ++7bseUJa0ErxPLg6iVE5ML8DrzmUefaBLlN6Wc5xOGs/vD1
 1AluWUuVPlgc1oY5yUy/OW7T5DhqoyKyzB8bXMB57cwIRl04eDNWeDC88
 +2sHloXa0sQRKOXfTiXAXUJe6Fratwmi+SU1IGizntc8cKQToAm2/YO/J
 at4mFgfJYC7x+k56DroK21g/7I1NTVlSTogEeB4n71aDUj0qZYn9qqomI
 PUkw2pYYdDC/2p+biouQYLVoMd+cHt1hlXM3Ggm7Uy7xQ8bhZlFhuomoq
 aa9vCBunoU24j3wW1G2d+X3EMPLcZblxWW57Hk3x85QAyOo6LdMyTVqCR Q==;
X-CSE-ConnectionGUID: NC4O44YKQoKtnGMxOkyyTQ==
X-CSE-MsgGUID: bFdwFt1ITWKzwMmjAp2IJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88297114"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="88297114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 21:29:00 -0700
X-CSE-ConnectionGUID: 2NG896aqSQOdqmu+y68zqQ==
X-CSE-MsgGUID: 9MKkoAS7QMOcsNRNFdUDnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="255243194"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa008.jf.intel.com with ESMTP; 13 Jul 2026 21:28:53 -0700
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: uma.shankar@intel.com, arun.r.murthy@intel.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com,
 kernel-dev@igalia.com, John.Harrison@Igalia.com,
 Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v6 5/7] drm: writeback: Modify drm_writeback_get_out_fence
 helper
Date: Tue, 14 Jul 2026 09:58:03 +0530
Message-Id: <20260714042805.77934-6-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714042805.77934-1-suraj.kandpal@intel.com>
References: <20260714042805.77934-1-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

drm_writeback_get_out_fence() does not itself need the parent
drm_connector object, but update it to take drm_connector for
consistency across the writeback interface, which is being moved
to use the top level drm_connector and traverse down to
drm_writeback_connector rather than passing in the lower level
object and traversing back up.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: John Harrison <John.Harrison@Igalia.com>
---
v5 -> v6:
- Rebase over latest kernel

v3 -> v4:
- Update subject line for consitency (John)
- Update commit message across commits for consitency (John)

 drivers/gpu/drm/drm_atomic_uapi.c | 4 +---
 drivers/gpu/drm/drm_writeback.c   | 4 ++--
 include/drm/drm_writeback.h       | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index a5c11832ff64..2271cd970985 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1492,7 +1492,6 @@ static int prepare_signaling(struct drm_device *dev,
 	}
 
 	for_each_new_connector_in_state(state, conn, conn_state, i) {
-		struct drm_writeback_connector *wb_conn;
 		struct drm_out_fence_state *f;
 		struct dma_fence *fence;
 		s32 __user *fence_ptr;
@@ -1514,8 +1513,7 @@ static int prepare_signaling(struct drm_device *dev,
 		f[*num_fences].out_fence_ptr = fence_ptr;
 		*fence_state = f;
 
-		wb_conn = &conn->writeback;
-		fence = drm_writeback_get_out_fence(wb_conn);
+		fence = drm_writeback_get_out_fence(conn);
 		if (!fence)
 			return -ENOMEM;
 
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index df8484a7aa03..d2ccb4dcba0a 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -531,10 +531,10 @@ drm_writeback_signal_completion(struct drm_connector *connector,
 EXPORT_SYMBOL(drm_writeback_signal_completion);
 
 struct dma_fence *
-drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
+drm_writeback_get_out_fence(struct drm_connector *connector)
 {
 	struct dma_fence *fence;
-	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
+	struct drm_writeback_connector *wb_connector = &connector->writeback;
 
 	if (WARN_ON(connector->connector_type !=
 		    DRM_MODE_CONNECTOR_WRITEBACK))
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 5e8ab51c2da4..2afa48ea7c00 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -104,5 +104,5 @@ drm_writeback_signal_completion(struct drm_connector *connector,
 				int status);
 
 struct dma_fence *
-drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector);
+drm_writeback_get_out_fence(struct drm_connector *connector);
 #endif
-- 
2.34.1

