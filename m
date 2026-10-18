Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D671ACCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C87D10E6A3;
	Sun, 18 Oct 2026 14:54:42 +0000 (UTC)
Received: from mail.noirlang.tr (mail.noirlang.tr [217.18.210.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117A410E04A
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noirlang.tr; s=mail;
 t=1792322136; bh=uagooDmWdsyPLKYdmSRczmN/LIDb7VqxAfG/z/3uxug=;
 h=From:To:Cc:Subject:Date:From;
 b=XZhNIahhZK1fE7wFkXofCz3uoDx21fCzxRAh7KeD0b70XJ/dMJOMLPZdvRuHcy44h
 VJpWWBT4m5bxZ8Mdt6dKJ6mQeaIJn5T+bgVibFSV6mYZ9UMZWRkKefXVJamMYJ1F0U
 BKQowx3UkYw8wFIa5N+DRmVhCT4TJANsZQ9Czy7pCjeLTbhR2BMxpNK5Rxhw5UrFe2
 C9uS+bnBrZq8pvkgHXJRXXqIwkRr+a0yWd+uesj5aPdsmvkw6yebSRGDuFTDKuUyto
 RmAIOT/OhA5iAtATjVCKd7MBsaEcY30E2o0i+SlT3manqItTC1VQr0faSfs9Lb3nHj
 AmneD1p5lppqg==
From: Melih Emik <melihemik@noirlang.tr>
To: xinliang.liu@linaro.org
Cc: sumit.semwal@linaro.org, yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/hisilicon: inline drm_simple_encoder_init()
Date: Sun, 18 Oct 2026 14:15:34 +0300
Message-ID: <20261018111534.354449-1-melihemik@noirlang.tr>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

The helper drm_simple_encoder_init() is deprecated because it adds an
unnecessary intermediate layer between atomic modesetting and DRM drivers,
as documented in Documentation/gpu/todo.rst.

Inline the functionality by calling drm_encoder_init() directly with a
local instance of struct drm_encoder_funcs. This allows removing the
dependency on <drm/drm_simple_kms_helper.h> in favor of
<drm/drm_encoder.h>.

Signed-off-by: Melih Emik <melihemik@noirlang.tr>
---
Tested:
- Compiled with W=1 on x86_64 with zero warnings or errors.
- Verified with lockdep and debug mutexes enabled
  (CONFIG_PROVE_LOCKING=y, CONFIG_DEBUG_MUTEXES=y).
- Boot-tested full bzImage in QEMU with initcall_debug, confirming
  successful driver registration (dsi_driver_init returned 0) and
  zero lockdep/kernel warnings.
- Verified with scripts/checkpatch.pl (0 errors, 0 warnings).

 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 15042365dec0..8c83fb09dda7 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -20,11 +20,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "dw_dsi_reg.h"
 
@@ -695,6 +695,10 @@ static const struct drm_encoder_helper_funcs dw_encoder_helper_funcs = {
 	.disable	= dsi_encoder_disable
 };
 
+static const struct drm_encoder_funcs dw_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int dw_drm_encoder_init(struct device *dev,
 			       struct drm_device *drm_dev,
 			       struct drm_encoder *encoder)
@@ -708,7 +712,8 @@ static int dw_drm_encoder_init(struct device *dev,
 	}
 
 	encoder->possible_crtcs = crtc_mask;
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm_dev, encoder, &dw_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		DRM_ERROR("failed to init dsi encoder\n");
 		return ret;
-- 
2.56.0


