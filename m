Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B02CD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 18:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326DE10E292;
	Sat,  6 Jun 2026 18:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BhHlnPsu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C4510E292
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JcdQ8U/FxF60JIx6GZcxkR6n8niRCwE5zF2E00xKad4=; b=BhHlnPsu7KMUOWqckPe7n17iHs
 Fubn27bR8y+Fq2v2VZEW9rHQRPZoQOu63IOIrFX5rjGXsGYd/yYE0TuyZmtS0whFnIBd1mZ1Jv6+f
 WYi2Dv8JrVFTbn1htWWOoXLE3+6VEhUlmx51HcoYohX+y9cWdWizNWibPsB262EM8rb3pMinshI8B
 FJl/7y1ZBIMqCtF/rB8fwT8i5tABIKxktVSizkx7Mm5j/XDs2sp75Sc85XS6l81dUzAvupAay+Kh9
 V7NBcm13rPPI5ugsLf8ySgECwPLWJSeSj3Uzl6KOzEnOy5gjpN1T7leIKjf+YwxTfPFj2r1iboXr+
 47XKLyUw==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVwCj-00DhhS-Ul; Sat, 06 Jun 2026 20:57:10 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Emma Anholt <anholt@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] drm/v3d: Deprecate V3D 3.3 and 4.1 support
Date: Sat,  6 Jun 2026 15:55:13 -0300
Message-ID: <20260606185616.694188-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
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

V3D 3.3 (Broadcom BCM7268) and V3D 4.1 (Broadcom BCM7278) has had no
in-tree userspace since Mesa dropped support in 2024, on the grounds
that those generations were no longer being tested. The situation in
the kernel is similar: the maintainers don't have this hardware, the
hardware is not available for purchase, and there is no known user of
these GPUs.

With no userspace left to drive it and no known users, maintaining the
ver <= 41 code paths is a cost without a benefit, considering that these
paths are not being exercised on real hardware.

As a first step toward removal, emit a deprecation warning at probe for
V3D versions earlier than or equal to 4.1. The hardware remains
functional for now; this only warns. If any real user appears and
explain its use-case, support can be retained.

Schedule the removal of V3D 3.3 and 4.1 support to the next kernel
release.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25851
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 805d84435ee0..8d914dbc3315 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -4,7 +4,11 @@
 /**
  * DOC: Broadcom V3D Graphics Driver
  *
- * This driver supports the Broadcom V3D 3.3 and 4.1 OpenGL ES GPUs.
+ * This driver supports the Broadcom V3D 4.2 and 7.1 GPUs.
+ *
+ * Support for V3D 3.3 and 4.1 GPUs is deprecated and it will be removed
+ * in the next kernel release.
+ *
  * For V3D 2.x support, see the VC4 driver.
  *
  * The V3D GPU includes a tiled render (composed of a bin and render
@@ -414,6 +418,18 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	 */
 	WARN_ON(v3d->ver != gen);
 
+	/* V3D 3.3 and V3D 4.1 has had no in-tree userspace since Mesa
+	 * dropped support in 2024 (MR#25851) and they have no known users.
+	 * Due to that, support is scheduled for removal in the next release.
+	 */
+	if (v3d->ver <= V3D_GEN_41) {
+		dev_warn(dev,
+			 "V3D %u.%u support is deprecated and will be removed "
+			 "in the next kernel release. If you rely on this hardware, "
+			 "please report it to dri-devel@lists.freedesktop.org.\n",
+			 v3d->ver / 10, v3d->ver % 10);
+	}
+
 	v3d->cores = V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_NCORES);
 	WARN_ON(v3d->cores > 1); /* multicore not yet implemented */
 
-- 
2.54.0

