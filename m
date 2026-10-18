Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8792ACCF2CF
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD7F10E63D;
	Sun, 18 Oct 2026 14:53:14 +0000 (UTC)
X-Greylist: delayed 541 seconds by postgrey-1.36 at gabe;
 Sun, 18 Oct 2026 11:01:21 UTC
Received: from mail.noirlang.tr (mail.noirlang.tr [217.18.210.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C1E10E04A
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noirlang.tr; s=mail;
 t=1792321279; bh=1EF87F7qoFRopDJACB+hV3BqN8xT0TAiYUDE1zfK/3M=;
 h=From:To:Cc:Subject:Date:From;
 b=ih18nUUH1hhr2Sv33S7GQ6UeQii9gMv6J1+6Dw6LaL7rQXww9ebuSP0nDpxzguAt5
 n1nqY8dfyLIWngrdSKg3FB8bs54ATg8LtHeyrv2DChJRFBYQIBmi2fCTkxRnvfXPHq
 Rhp8ca6VsYXYkrOUf/Y2Okr4nb5M6K1Du8oEB6fNgr/ygGhehaeWEm1yCx1QPFFMIp
 4ISALlFsAgEY1EnEIMuCGSXlDv4aQnMRCBiKlBGsuydwTDjatmCIBAmNtln1MNmofp
 Ayp4h7euSY5JS1J285g0gEdzGsUusBTlxBEAyxXAXec4J4VaGlfGHA/wlVcGZuONXR
 JMU/QlJVbJOpQ==
From: Melih Emik <melihemik@noirlang.tr>
To: anitha.chrisanthus@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/kmb/dsi: inline drm_simple_encoder_init()
Date: Sun, 18 Oct 2026 14:01:17 +0300
Message-ID: <20261018110117.298588-1-melihemik@noirlang.tr>
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
v2:
- Drop "Tested:" meta commentary from the commit message.

Test notes:
- Compiled with W=1 on x86_64 with zero warnings.
- Verified with lockdep and debug mutexes enabled
  (CONFIG_PROVE_LOCKING=y, CONFIG_DEBUG_MUTEXES=y).
- Boot-tested full bzImage in QEMU with initcall_debug, confirming
  successful driver registration (kmb_platform_driver_init returned 0)
  and zero lockdep/kernel warnings.
- Verified with scripts/checkpatch.pl (0 errors, 0 warnings).

 drivers/gpu/drm/kmb/kmb_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 59d0e856392f..13adba96bc78 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -14,8 +14,8 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -1427,6 +1427,10 @@ struct kmb_dsi *kmb_dsi_init(struct platform_device *pdev)
 	return kmb_dsi;
 }
 
+static const struct drm_encoder_funcs kmb_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int kmb_dsi_encoder_init(struct drm_device *dev, struct kmb_dsi *kmb_dsi)
 {
 	struct drm_encoder *encoder;
@@ -1437,7 +1441,8 @@ int kmb_dsi_encoder_init(struct drm_device *dev, struct kmb_dsi *kmb_dsi)
 	encoder->possible_crtcs = 1;
 	encoder->possible_clones = 0;
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(dev, encoder, &kmb_dsi_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		dev_err(kmb_dsi->dev, "Failed to init encoder %d\n", ret);
 		return ret;
-- 
2.56.0


