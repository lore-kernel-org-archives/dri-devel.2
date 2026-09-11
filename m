Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ADAC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68EC10F6AB;
	Fri, 11 Sep 2026 17:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="HC7y0BiC";
	dkim-atps=neutral
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com
 [209.85.222.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C12A10F6AB
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:22 +0000 (UTC)
Received: by mail-ua1-f100.google.com with SMTP id
 a1e0cc1a2514c-97ca74bd6e0so607519241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789149381; x=1789754181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tKmOUocrauyeK7OUmDQb9zXFbJNdZJDpnUAdZqB3sgE=;
 b=hwbNvqg+msgZWOD9x+WEyjV2BixP9Lh0z83KaSESi4rd+aTTg8FRFHRvc9xsM0xDSL
 YiVaGEr/Vn35ZrOtRlZ8xOwAW354FBJnBXIt1NEpKBoEeZBs8Fw9yvUEUIdk+sv3Rdz2
 ZbhMzL6r3E2cYf2fYRTtjQ4TLpFvCUyEuKJ9ZUTsQ6VDRQ9DMB8UFwc+LUJVSl4l8S7E
 URJT2D+ISTMDAs3d4kgCC0Ag2jlPo0dG2iilH2gyQr7HTykteXHlUUuz6a4c/9lqyw+v
 /O4lWs5Voi1mTczpa7hKuzpLklNjEOmFzzJ+UtDNZUFb23TQfNDBNsON7PlrrVnSD9cq
 FbLg==
X-Gm-Message-State: AFuF++mQHhCFydjwcVNKw/81u3vNKv6+BFd4Hi4dwrqpdxGzrWYIIAuo
 R0XL9ym0ZY0+ReDEj5Vp9QPU+JL+YgCgOdA4nkjx/VdKWnHOz+lhplTcKe1LDKK+EuF34biuIpe
 VsB6I7YeZkInCPwwLK8xTizw2F9rgPwNsnFh0+kTasql9oC9QC3HsLCg3HpbMdyIp0tNstAzFje
 LuqQUQLkLz1Dvji19SaTFBWQe++yiFwubbcRhpexFRaC43I/e8ljTo9uQi09dvhrUtVbGK/Zkcd
 gLCg8CFVhM7ZX7n+5Y5
X-Gm-Gg: AYBFou3RfWeUYK7h3vqfrJOH2/HS7p8yp5lqhTT5MvnFTfJFRw//xzjEc6AJi1HkzRk
 iFXiX/+DpYm4xzqJKiDu9qhox3aq5MQhI169848D2amhE8CT9E/dZ21yzb0f9/g/rJxSJ/u131X
 EioqZR7nOodotl9nHxsx70DMXXtri0G7egIpO2xkNfqYpUsywxIjSGmENFqobg52JbvCQ+J2Ml+
 P2SiIFZGTJmoaS7fVbFeG3xb6DGyXWU0qOHjVxBMM78L+JDtr9EQopI8/8uwWRFA83ou8VrdQvY
 /BzfvItk3n2v4dyAea2dlArj/SiqtGMmCCq+HGBqvs06Bt9swcU4fdsHV75c91LSGcOiMNV8HGH
 Xbhc1Qk62uv4l1tPOAfdFnAtdw+9A5YTqLEr88vlI8UO+YKD+8R8JOByy/sFmYrfVYuEVI0WMt1
 t5OlQf2nXhDwWgN4NTSKd4HEtFW5qeXwNT
X-Received: by 2002:a05:6122:d82:b0:5bf:a179:b2be with SMTP id
 71dfb90a1353d-5c846310516mr8633068e0c.7.1789149380679; 
 Fri, 11 Sep 2026 10:56:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c8470ae879sm1306832e0c.4.2026.09.11.10.56.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Sep 2026 10:56:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-530cfe43441so17549191cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789149380; x=1789754180;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tKmOUocrauyeK7OUmDQb9zXFbJNdZJDpnUAdZqB3sgE=;
 b=HC7y0BiCxwHlmjzSvJl5UkzemCNHsDi46JDR7sYIR6SVto480BOiWb40JvhZtLj0fn
 AXmSrvb7xXHeukwQ+gBETgN2GUkJqnRBLVnFJ+P/GrhGGvdI7wxt+BmWVwAwd0r0Vk47
 OPo/zDfQB4kLwZsEdlrx1Fm+8zNzi+AXYYfv4=
X-Received: by 2002:a05:622a:386:b0:52f:c0b8:b619 with SMTP id
 d75a77b69052e-530c86a10f7mr76252341cf.29.1789149379930; 
 Fri, 11 Sep 2026 10:56:19 -0700 (PDT)
X-Received: by 2002:a05:622a:386:b0:52f:c0b8:b619 with SMTP id
 d75a77b69052e-530c86a10f7mr76247401cf.29.1789149374481; 
 Fri, 11 Sep 2026 10:56:14 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4b3dcesm26160406d6.31.2026.09.11.10.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 10:56:14 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Add blend mode property
Date: Fri, 11 Sep 2026 12:56:07 -0500
Message-ID: <20260911175607.1127474-1-ian.forbes@broadcom.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..c06548960008 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -20,10 +20,17 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_sysfs.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_blend.h>
 
 void vmw_du_init(struct vmw_display_unit *du)
 {
 	vmw_vkms_crtc_init(&du->crtc);
+	drm_plane_create_blend_mode_property(&du->primary,
+					     BIT(DRM_MODE_BLEND_PIXEL_NONE));
+	// Check that the cursor plane was actually initialized
+	if (du->crtc.cursor == &du->cursor.base)
+		drm_plane_create_blend_mode_property(&du->cursor.base,
+						     BIT(DRM_MODE_BLEND_PREMULTI));
 }
 
 void vmw_du_cleanup(struct vmw_display_unit *du)
-- 
2.55.0

