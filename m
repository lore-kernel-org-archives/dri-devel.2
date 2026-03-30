Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF1B10D14B4
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A0010E59C;
	Mon, 30 Mar 2026 13:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OIYYKGUo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD4610E41D
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xK6eOWYWJrnWEFSJBmSxQJEmrp4eJ4NFBpMCi/+wPDs=; b=OIYYKGUoCMSvsAjX4Uehgi7c+B
 9CoSUYOWgd2Yj+88FO5el1Td/cgbkAfxjQ8LmJ0XrRH6ynG9Yxcb5g0FnNZr2WKjg0RYyphMETYuK
 MG5hL2RPrLFC03yL6OBBevre9T8BZJkVFujREasNwGs6L5fhYBpUbWrcF10u/Yo6kAp3wvYkXQaIe
 /krgmQZe3c9EqK4nsSg1dsOiDkrGNPbUsbba6gs2wi5U58/muR3Phn5l95dfmhfuHsagkj2/njw5t
 5EPeDVEq0M7V5MtyrV99k7FVQgEzCqyLIbpgXePLcbx2ERZKJrLyF8ctMqLW1v7S1yOJIlLjzw6rW
 3l2lMHbg==;
Received: from [189.7.87.169] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7Cm2-008ztv-Q8; Mon, 30 Mar 2026 15:35:23 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] drm/connector: Make
 drm_connector_attach_hdr_output_metadata_property() return void
Date: Mon, 30 Mar 2026 10:33:04 -0300
Message-ID: <20260330133446.3265938-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drm_connector_attach_hdr_output_metadata_property() always returns zero,
since drm_object_attach_property() returns void. No caller checks the
return value, so change the return type to void.

Also fix a typo in the kerneldoc ("HDR_OUTPUT_METADA" -> "HDR_OUTPUT_METADATA").

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_connector.c | 9 ++-------
 include/drm/drm_connector.h     | 2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 47dc53c4a738..3fa4d2082cd7 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2867,23 +2867,18 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
 
 /**
- * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADA" property
+ * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADATA" property
  * @connector: connector to attach the property on.
  *
  * This is used to allow the userspace to send HDR Metadata to the
  * driver.
- *
- * Returns:
- * Zero on success, negative errno on failure.
  */
-int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector)
+void drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
 	struct drm_property *prop = dev->mode_config.hdr_output_metadata_property;
 
 	drm_object_attach_property(&connector->base, prop, 0);
-
-	return 0;
 }
 EXPORT_SYMBOL(drm_connector_attach_hdr_output_metadata_property);
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index af8b92d2d5b7..c8dc08773a11 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2518,7 +2518,7 @@ int drm_connector_attach_vrr_capable_property(
 void drm_connector_attach_panel_type_property(struct drm_connector *connector);
 int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
 int drm_connector_attach_colorspace_property(struct drm_connector *connector);
-int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
+void drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
 bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state *old_state,
 					     struct drm_connector_state *new_state);
 int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
-- 
2.53.0

