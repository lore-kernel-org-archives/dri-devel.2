Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A12C88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CDF10E084;
	Wed, 16 Sep 2026 19:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="UkLIHhXr";
	dkim-atps=neutral
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B1310E084
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 19:01:54 +0000 (UTC)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2dd05e8b98cso127425ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789585314; x=1790190114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HQjL7mB3HOpapqPau0b0W9gBmfWNxjEV90JOaj+pSA4=;
 b=WOVMr9+pugs8BcY5IzEIobmVCgPaAfJWN5RlON57ZqVB3e3p99Hs4GGOxe+yBlvLkx
 QU3zseCjsN5/2jSvKPGbA81NIeJlvSSvS5F+8sBx4pZ/MsbfkCz20CK+KJZrlrdNMlRo
 IQIRyGCt7M8SVgTkRqBOm5kcCfMcasYcz8AJZE4XUSiJqZb9nwEu/ghB+RR3fiycr4TH
 2owU7UJfGYi0/U0QbOV658wn2/VECz3Bg8uP8UsQDBkkcHO9MPupJUdRiBHLy4tKED2B
 YT0ypD0OP1Ws9aLxLWuQ6BsrmvYaoslgI/bAJ0HRJvQxYMdGO3SQUjVC4isnRwWPCGoj
 4Omw==
X-Gm-Message-State: AFuF++nwMhuEQNYfQeMvGVACyt9twabXl9JGomCO1Me+NUaRHehgFlWK
 kEUXRQOBogvRp1Lj+YRGH3wzZ3i5GDWwJkeJ/1hyt9/oNbZvJOIKu/G1otiGAKm71izkKs1ktYK
 PplSMa0w9bGsaYRJ2Jr8sMWqjCiFZCochP1np+tFWMwLHJFMNrhl82JpU2FlEATCwtKDml/6KOQ
 eyuTAWZt3CVihQv0q/5YB0iWMIRzyhPY/Ag7qvan5Bt61qKwpgMRfilBQkNMrxLvHscZmgEpHSW
 G1Thn77S/J8ns0tEeH+
X-Gm-Gg: AYBFou0RZwUioZ0rwfElOCZLlw7wqRYeYJetkniuQZ5ycqTbZSb7RG1XGHKIDBxXc+H
 1kaQDcgNapt2FA4W6iczo7RhwHweaxHcgujtNsQk1raBzg12Gqak16sd+M10hzBO3CxbtV3WToW
 2Xk9svHBAXmpmWdRVj/SXNwwE37T/YfMMFjtk4rB0ZaMm/lJG0N3ASwmjhEe+xKoxd8R4o0dyfQ
 cYKEDMPfQsIZLjvvYi0rclqyn7lzq0d9m3eCH1g7ofCfLh+z+rEmdDXdPMmWIq6BDDzwSA8UdsS
 pLVjoz1gDKqzbY0Tp7k5nEHN0fdBSSet5RQCNRBF+k7kXm2s//d78+fng4x+lC35Gzv1xtwYtR/
 Zn2Qs40nIZ/ArmHqQWjxhEdV29B55lVp+bqWldbYaB672ttaUTN8wdsafVyrSTKl4n5ZSoKZRkJ
 kvBWiIHlXnke9ceU1uwhLXf/bB3T87BS9kO7A=
X-Received: by 2002:a17:902:db09:b0:2ca:6c8:abd8 with SMTP id
 d9443c01a7336-2dd8e52586amr74983455ad.12.1789585313985; 
 Wed, 16 Sep 2026 12:01:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2dd89f2184esm1439795ad.54.2026.09.16.12.01.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Sep 2026 12:01:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-805da97443aso21486a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789585312; x=1790190112;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HQjL7mB3HOpapqPau0b0W9gBmfWNxjEV90JOaj+pSA4=;
 b=UkLIHhXrdTUmFKTu0Of5U1VLaaMVgu7MSg/qwN+3nXW9lp5z9ZF95aM+ODLI+TCHsv
 ojhO834xByd9lDZYNgb15pg/8oub9s6V7sTUhd5vHAbSjmDRw9fQYSSGrFrPJr8gUU/s
 np74dbNFiuavnZkBW61aUOFNlAp0OyFea8++I=
X-Received: by 2002:a05:6820:f02f:b0:6bd:dede:11d7 with SMTP id
 006d021491bc7-6c7d36fa639mr3756007eaf.37.1789585312293; 
 Wed, 16 Sep 2026 12:01:52 -0700 (PDT)
X-Received: by 2002:a05:6820:f02f:b0:6bd:dede:11d7 with SMTP id
 006d021491bc7-6c7d36fa639mr3755948eaf.37.1789585311672; 
 Wed, 16 Sep 2026 12:01:51 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a0c5sm9627234eec.7.2026.09.16.12.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 12:01:50 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH v2] drm/vmwgfx: Add blend mode property
Date: Wed, 16 Sep 2026 14:01:44 -0500
Message-ID: <20260916190144.2080777-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

This stops the log spamming introduced by the referenced fixes commit.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---

v2:
 - Add DRM_MODE_BLEND_PREMULT to primary plane to fix IGT

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..31d3ee0825ca 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -20,10 +20,18 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_sysfs.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_blend.h>
 
 void vmw_du_init(struct vmw_display_unit *du)
 {
 	vmw_vkms_crtc_init(&du->crtc);
+	drm_plane_create_blend_mode_property(&du->primary,
+					     BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+					     BIT(DRM_MODE_BLEND_PREMULTI));
+	// Check that the cursor plane was actually initialized
+	if (du->crtc.cursor == &du->cursor.base)
+		drm_plane_create_blend_mode_property(&du->cursor.base,
+						     BIT(DRM_MODE_BLEND_PREMULTI));
 }
 
 void vmw_du_cleanup(struct vmw_display_unit *du)
-- 
2.55.0

