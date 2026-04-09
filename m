Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA74BE9DE41
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 07:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC8110E74B;
	Thu,  9 Apr 2026 07:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gcMu0ljX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2F010E74B;
 Thu,  9 Apr 2026 07:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775718087; x=1807254087;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HC0z3AjOAJIWLdmgIAhd2wWiJAFJS5oyoyGLy0gtNCs=;
 b=gcMu0ljXQBC5JR9BzJt/OfnyucwLgqnd6cyzuOc5t91HVPyyToplV8Wg
 ArZpgeaYUX/w7/NNJSBoQT5pIMWzJYku0tf+92Yo19UGffXolFUTZGM8v
 GhCTgX1d3Z89RYMM3Kwb7Plk6Ceo2kVe2wdQHVMLEIP6Znmhs+zFaHXMU
 o0kbAAyMQIgSxymUn+dMTbeYwsCKrrFvOsCPuwkKCF9LQQjNXZtfpEb7O
 W3SfcBfov8d7maTFptAxOGro1PUkAwvjvUlyrJdo91A+ZdozyZqHOLHi3
 Nj26JyOZJVxuF5UKlL+P3Ehdm2KGBYi0eceXm2aVgTKpmVWU+b2ts+Kug A==;
X-CSE-ConnectionGUID: WQp0DimtQ/idU7+SGhXUkg==
X-CSE-MsgGUID: /X9QgY12RIuXnbhQx9cHqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76836491"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76836491"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:01:27 -0700
X-CSE-ConnectionGUID: ktDHjhy9RwecRw5MbbFxig==
X-CSE-MsgGUID: GKnqbfbFQFCBkfnc1vu71w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="233576579"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:01:22 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, anvesh.bakwad@intel.com,
 maarten.lankhorst@linux.intel.com, Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v2 2/2] drm/xe/xe_drm_ras: Add support for clear-error-counter
 in XE drm_ras
Date: Thu,  9 Apr 2026 13:03:20 +0530
Message-ID: <20260409073318.2909379-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260409073318.2909379-4-riana.tauro@intel.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
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

Add support for clear-error-counter command in XE drm_ras
This resets the counter value.

Usage:

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":1}'
None

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 35 +++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index e07dc23a155e..c21c8b428de6 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -27,6 +27,16 @@ static int hw_query_error_counter(struct xe_drm_ras_counter *info,
 	return 0;
 }
 
+static int hw_clear_error_counter(struct xe_drm_ras_counter *info, u32 error_id)
+{
+	if (!info || !info[error_id].name)
+		return -ENOENT;
+
+	atomic_set(&info[error_id].counter, 0);
+
+	return 0;
+}
+
 static int query_uncorrectable_error_counter(struct drm_ras_node *ep, u32 error_id,
 					     const char **name, u32 *val)
 {
@@ -37,6 +47,15 @@ static int query_uncorrectable_error_counter(struct drm_ras_node *ep, u32 error_
 	return hw_query_error_counter(info, error_id, name, val);
 }
 
+static int clear_uncorrectable_error_counter(struct drm_ras_node *node, u32 error_id)
+{
+	struct xe_device *xe = node->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE];
+
+	return hw_clear_error_counter(info, error_id);
+}
+
 static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id,
 					   const char **name, u32 *val)
 {
@@ -47,6 +66,15 @@ static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id
 	return hw_query_error_counter(info, error_id, name, val);
 }
 
+static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_id)
+{
+	struct xe_device *xe = node->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
+
+	return hw_clear_error_counter(info, error_id);
+}
+
 static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
 {
 	struct xe_drm_ras_counter *counter;
@@ -92,10 +120,13 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	if (IS_ERR(ras->info[severity]))
 		return PTR_ERR(ras->info[severity]);
 
-	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
+	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
 		node->query_error_counter = query_correctable_error_counter;
-	else
+		node->clear_error_counter = clear_correctable_error_counter;
+	} else {
 		node->query_error_counter = query_uncorrectable_error_counter;
+		node->clear_error_counter = clear_uncorrectable_error_counter;
+	}
 
 	return 0;
 }
-- 
2.47.1

