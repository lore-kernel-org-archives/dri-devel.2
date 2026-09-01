Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D981C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B5310EBA3;
	Tue,  1 Sep 2026 07:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iAiCQes0";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2895710E981;
 Tue,  1 Sep 2026 06:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788245755; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=bABm3+xrFKtz5tDE4aE1SofEi8/oUAjtsC5NdfwbKhk=;
 b=iAiCQes0IaOYTCynmVa70vRmTr8ki5iJFhimdn4ePT2ErvjVDkq75RSVhZhLA2vLeDEzrzLuhn5DwKCZk2rBEJhM6JehvlrVoLTqTbv/LFtf6bvv2lS7wTD5M34V1lbeXqJ09wVM3hafHk6E0LIMvoKHq08wUdo5EOXZNEQTDjo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=qinyuntan@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0XA4XWTM_1788245450; 
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com
 fp:SMTPD_---0XA4XWTM_1788245450 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 01 Sep 2026 14:50:51 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, airlied@redhat.com, jfalempe@redhat.com,
 kraxel@redhat.com, dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 2/4] drm/qxl: create blend mode property on primary and cursor
 planes
Date: Tue,  1 Sep 2026 14:50:43 +0800
Message-ID: <20260901065045.1152136-3-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
References: <20260901065045.1152136-1-qinyuntan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed"), drm_mode_config_validate() warns when a
plane exposes an alpha pixel format but not the "pixel blend mode"
property. Both the qxl primary and cursor planes expose ARGB8888 and
trip this on driver load.

The planes have always blended with pre-multiplied alpha and userspace
assumes that blend mode when the property is not attached. Expose a
"pixel blend mode" property advertising only DRM_MODE_BLEND_PREMULTI
to make the existing semantics explicit and silence the warning. No
functional change.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 7f4178800afd7..0cd1456cca347 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -30,6 +30,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_framebuffer.h>
@@ -993,6 +994,9 @@ static struct drm_plane *qxl_create_plane(struct qxl_device *qdev,
 
 	drm_plane_helper_add(plane, helper_funcs);
 
+	drm_plane_create_blend_mode_property(plane,
+					     BIT(DRM_MODE_BLEND_PREMULTI));
+
 	return plane;
 
 free_plane:
-- 
2.43.7

