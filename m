Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFE3C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4340F10E931;
	Thu,  3 Sep 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gdhCKrKT";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C1D10E3C7;
 Tue,  1 Sep 2026 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788251567; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=dmsGvnFPGiJMko6TrciY1hQhSYuIL5q33C55EfI8xTo=;
 b=gdhCKrKTlLn8XpACMffzxzykaazJTdOXfyopQYG0ZFH1K/Gk13koFSpRRTQZd0lKH5mAEBOeC4NLGazbHwVcta98tP8bDlFK5DsHYPX03lx6aKRNtvg9zSw2XDC1bbKDd4tt1FvfV3f8jpsvubKLwLj4awygpzD44giKvvWuIMo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=qinyuntan@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0XA5o3sc_1788251565; 
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com
 fp:SMTPD_---0XA5o3sc_1788251565 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 01 Sep 2026 16:32:46 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, airlied@redhat.com, jfalempe@redhat.com,
 kraxel@redhat.com, dmitry.osipenko@collabora.com, hansg@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 leandro.ribeiro@collabora.com, daniels@collabora.com,
 pekka.paalanen@collabora.com, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH v2 1/4] drm/ast: create blend mode property on cursor plane
Date: Tue,  1 Sep 2026 16:32:31 +0800
Message-ID: <20260901083234.1828755-2-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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
property. The ast cursor plane (ARGB4444, ARGB8888) trips this on
driver load:

  [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x48f/0x510 [drm]
  ...
  Call Trace:
   drm_dev_register+0x1ce/0x290 [drm]
   ast_pci_probe+0x19d/0x3f0 [ast]
   local_pci_probe+0x41/0x90

Per Thomas Zimmermann's review, the ASPEED documentation describes the
hardware cursor as blending with straight (non-pre-multiplied) alpha,
which corresponds to DRM_MODE_BLEND_COVERAGE. Expose a "pixel blend
mode" property advertising only DRM_MODE_BLEND_COVERAGE to make the
hardware semantics explicit and silence the warning.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
v2: advertise DRM_MODE_BLEND_COVERAGE instead of PREMULTI, per Thomas
Zimmermann's review and the ASPEED documentation.

 drivers/gpu/drm/ast/ast_cursor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index fd19c45f2abe2..690d4cd1db5ee 100644
--- a/drivers/gpu/drm/ast/ast_cursor.c
+++ b/drivers/gpu/drm/ast/ast_cursor.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -355,6 +356,8 @@ int ast_cursor_plane_init(struct ast_device *ast)
 	}
 	drm_plane_helper_add(cursor_plane, &ast_cursor_plane_helper_funcs);
 	drm_plane_enable_fb_damage_clips(cursor_plane);
+	drm_plane_create_blend_mode_property(cursor_plane,
+					     BIT(DRM_MODE_BLEND_COVERAGE));
 
 	return 0;
 }
-- 
2.43.7

