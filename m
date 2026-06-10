Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A983CD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBB710E9B6;
	Wed, 10 Jun 2026 14:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z0M/hvoI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B0810E99E;
 Wed, 10 Jun 2026 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781100957; x=1812636957;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N7PWzNnZPrYUq3XrfcJIp98EH5hHx7N1LLN6Lkt380k=;
 b=Z0M/hvoIiOa4o0QS5RBfwq0HWPdbDllCPz2o6bRr+VJ4GtCtrfIqbxOe
 bmTKc5FGtMnKLEJs8aPQ2MqeC2xZ7yXNIEdrzfsqQnYUemXu1v2P0mFcg
 3rEglx9xV6gmZsdEE3Xp9yq+ewdlyjUT4e4XiLT9U9CFndCUB4+IkaUsT
 emj48MDFZ9ccQpVyUcIDcyIcsRwaoLjho3LwtWKsWEg3gMPgzSViBSEUE
 GuzuTojN0blb1iCqbWKGrf2plIOd0Xx8wpddXbPyX2Rg79NJiaUzkurou
 8BC/cW46T58UA7LzIRzv4M+aGFLXS5myytPJdYK7xwdyxrRats8J6RMWH g==;
X-CSE-ConnectionGUID: AW+5prQLQVC3fKO9uNGMlg==
X-CSE-MsgGUID: /5P/1v+OS0ylYO1kRo2MdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81741053"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81741053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:15:57 -0700
X-CSE-ConnectionGUID: 1W9VfwU0T96lfGI5pL++vw==
X-CSE-MsgGUID: ElMRxXb/TtCTeXYE45LVtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245333691"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.3])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:15:54 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 jani.nikula@intel.com, Dave Airlie <airlied@redhat.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/displayid: fix Tiled Display Topology ID size
Date: Wed, 10 Jun 2026 17:15:49 +0300
Message-ID: <20260610141549.555605-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

The Tiled Display Topology ID of a DisplayID Tiled Display Topology Data
Block consists of three fields:

- Tiled Display Manufacturer/Vendor ID Field (3 bytes)
- Tiled Display Product ID Code Field (2 bytes)
- Tiled Display Serial Number Field (4 bytes)

i.e. a total of 9 bytes, not 8.

The DisplayID Tiled Display Topology ID is used as the tile group
identifier.

Update both struct displayid_tiled_block topology_id member and struct
drm_tile_group group_data member to full 9 bytes.

The group data was missing the last byte of the serial number. I don't
know whether there are known bug reports that might be linked to this,
but it's plausible the last byte could be the differentiating part for
the tile groups, and fewer tile groups might have been created than
intended.

Fixes: b49b55bd4fba ("drm/displayid: add displayid defines and edid extension (v2)")
Fixes: 138f9ebb9755 ("drm: add tile_group support. (v3)")
Cc: Dave Airlie <airlied@redhat.com>
Cc: <stable@vger.kernel.org> # v3.19+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_connector.c          | 12 ++++++------
 drivers/gpu/drm/drm_displayid_internal.h |  2 +-
 include/drm/drm_connector.h              |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index cbb067d02cb9..95028483e0d1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3756,7 +3756,7 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
 /**
  * drm_mode_get_tile_group - get a reference to an existing tile group
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Use the unique bytes to get a reference to an existing tile group.
  *
@@ -3764,14 +3764,14 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
  * tile group or NULL if not found.
  */
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8])
+					       const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int id;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
 	idr_for_each_entry(&dev->mode_config.tile_idr, tg, id) {
-		if (!memcmp(tg->group_data, topology, 8)) {
+		if (!memcmp(tg->group_data, topology_id, sizeof(tg->group_data))) {
 			if (!kref_get_unless_zero(&tg->refcount))
 				tg = NULL;
 			mutex_unlock(&dev->mode_config.idr_mutex);
@@ -3786,7 +3786,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
 /**
  * drm_mode_create_tile_group - create a tile group from a displayid description
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Create a tile group for the unique monitor, and get a unique
  * identifier for the tile group.
@@ -3795,7 +3795,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
  * new tile group or NULL.
  */
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8])
+						  const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int ret;
@@ -3805,7 +3805,7 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 		return NULL;
 
 	kref_init(&tg->refcount);
-	memcpy(tg->group_data, topology, 8);
+	memcpy(tg->group_data, topology_id, sizeof(tg->group_data));
 	tg->dev = dev;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 5b1b32f73516..4590d6a3d821 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -109,7 +109,7 @@ struct displayid_tiled_block {
 	u8 topo[3];
 	u8 tile_size[4];
 	u8 tile_pixel_bezel[5];
-	u8 topology_id[8];
+	u8 topology_id[9];
 } __packed;
 
 struct displayid_detailed_timings_1 {
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 4317166562cf..d75deba31d93 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2717,13 +2717,13 @@ struct drm_tile_group {
 	struct kref refcount;
 	struct drm_device *dev;
 	int id;
-	u8 group_data[8];
+	u8 group_data[9];
 };
 
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8]);
+						  const char topology_id[9]);
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8]);
+					       const char topology_id[9]);
 void drm_mode_put_tile_group(struct drm_device *dev,
 			     struct drm_tile_group *tg);
 
-- 
2.47.3

