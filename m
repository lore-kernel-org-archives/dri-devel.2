Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E249C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D9A10E7E3;
	Fri, 18 Sep 2026 04:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qHI0C/eJ";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902DE10F176
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 04:23:41 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso197568a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789705421; x=1790310221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9BEYrdPncK5+8wcIBCPJhFb06NPsWm4ypvW09xMw3CI=;
 b=qHI0C/eJFb50F1EpI7B9hMAjwyPq0vjEuKKfDYdmM+aAwCQUve2R45wMYOs7/1NzRF
 mKzJFu48+aqYXi/kno40VrWWpeHKmfF2pDNiGO6Y4hbGKv8c/Ib5+PIZLO0qnLQxlTEn
 0TIuzMN6S7bn0/RPgIiydE3t6mrfwZqQncHnWuwMhHEOrODistrgbgdNFzEJJjX8+Hib
 qVj12mJbewK+GerZUeLqZFH4VFZMIl5m2Psn4K8yXjXvXPByRaHfscuhWgTbJbq89hGd
 lhl7v4SMYGjEQ18CrOi74LdIDVYY9Fe9C0B+4PRNokWAi4V7EyJ2KMgAa4GoyeyV3Pa0
 4c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705421; x=1790310221;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9BEYrdPncK5+8wcIBCPJhFb06NPsWm4ypvW09xMw3CI=;
 b=2zMolBB5xOduRhx/TfMIgiCzrJSHS1D6v8pmL7MZS8tfCXS9ZTfpCfQqP3/aoKpEmZ
 wSIV/Bw+LaEZ86BH5ZgA4rOWXFtLiL6bD7ygUdbR30eV7kMNwZ45sC6CexmemgzHzUkY
 ejYYxE2pagLxJwoiy1kCm+d27zdHyD//71OHaZGVnV+d+dtVmcJ2KSfjncstap3DC0RD
 VVEFkfgRd4nTGzZ80DYu1Ib0pACVVzO3EYkghR5nlOqXkOJINnDGUCqpjIFwUcWhUlIC
 EBiDsu5CUbFDOAfTFDapanCqeFu1a3VRAhNqbbH/Hvi+TTHdC+L93+TLoHyWDXwRrEpg
 KrBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxO2OifGD31cEEqIHzVQBOu2QYm4vBVTGQiSX1/w4yuxW45hw+W2f97m4MNmY+dQiGz2SlIWi4D+g8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqI6OpT7wozmaYhsWPxWJwn+c9bv+l/DjDDOMfudw58fJTh6Lv
 SvUnQZO1yDmkmLAclxA2qnKM2QTs7sAh/H/ZrJX6oK0dD8OZ04tOuyUz
X-Gm-Gg: AYBFou3PbNG+I3UqOPEERMSTmLODFzjVELbgwn30788voIb0d0a589dfZttzqijFm9x
 1RP7u3q94znTPEY2bfrXmC2ePRtcOJmoYQfRc1ySOxffCMWi2KaWqnZIo6GjM7NZtz6FXJL340Z
 Wa3qMX3fMrkOw8QmEju6HebA9EwoUhiu3doXcc36+NGbIJZN1BNhBItreXO9T/lO6DSMOuJUxng
 tGQbWBxfqPRNV0JsBh411KmzSChGGY+269zYfqLRvwpOSoFNhp//ZhTdOhY9cQN8WpKgQALVVd1
 U8T7FtsK9TPQUzkgg5P0k2F2WpAOA59w0XgaYxzpS5XZUxrB6/zToNg3V5PHCFj2tY8HVN5dvWZ
 J1ZoaqQUpHhyC7qJ4yeh7I2VRUHCsMw3vSXEJjQi/bXiadqZuE9Hns+2gW3rzdQCipY7QBlSq1Q
 uKLB9XCALdmk2q5nMfS9FPOyXEXyIlRlx3JMZmuUBZtbvqSSTIj5DrK4TT6ySVSWHdFY3v+Sua
X-Received: by 2002:a05:6a20:6a20:b0:3d2:2afa:d7d with SMTP id
 adf61e73a8af0-3dd8c52d98emr2724989637.18.1789705420877; 
 Thu, 17 Sep 2026 21:23:40 -0700 (PDT)
Received: from G15-5520 ([103.246.195.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm2305851c88.5.2026.09.17.21.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:23:40 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Zhenyu Wang <zhenyuw.linux@gmail.com>,
 Zhi Wang <zhi.wang.linux@gmail.com>,
 intel-gfx@lists.freedesktop.org (open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS), 
 intel-xe@lists.freedesktop.org (open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] drm/i915: use string choice helpers
Date: Fri, 18 Sep 2026 04:23:18 +0000
Message-ID: <20260918042325.17700-1-lalitshankarch@gmail.com>
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

Prefer the str_high_low() and str_read_write() helper functions
over ternary operators with hardcoded strings.

No functional changes.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 5 +++--
 drivers/gpu/drm/i915/gvt/aperture_gm.c       | 4 +++-
 drivers/gpu/drm/i915/vlv_iosf_sb.c           | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index dbebd7210848..b83f0afaa9b5 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -5,6 +5,7 @@
 
 #include <linux/log2.h>
 #include <linux/math64.h>
+#include <linux/string_choices.h>
 
 #include <drm/drm_print.h>
 
@@ -189,7 +190,7 @@ int intel_cx0_wait_for_ack(struct intel_encoder *encoder,
 		drm_dbg_kms(display->drm,
 			    "PHY %c Error occurred during %s command. Status: 0x%x\n",
 			    phy_name(phy),
-			    command == XELPDP_PORT_P2M_COMMAND_READ_ACK ? "read" : "write", *val);
+			    str_read_write(command == XELPDP_PORT_P2M_COMMAND_READ_ACK), *val);
 		intel_cx0_bus_reset(encoder, lane);
 		return -EINVAL;
 	}
@@ -198,7 +199,7 @@ int intel_cx0_wait_for_ack(struct intel_encoder *encoder,
 		drm_dbg_kms(display->drm,
 			    "PHY %c Not a %s response. MSGBUS Status: 0x%x.\n",
 			    phy_name(phy),
-			    command == XELPDP_PORT_P2M_COMMAND_READ_ACK ? "read" : "write", *val);
+			    str_read_write(command == XELPDP_PORT_P2M_COMMAND_READ_ACK), *val);
 		intel_cx0_bus_reset(encoder, lane);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i915/gvt/aperture_gm.c
index 253b41789be9..794fb50e48dd 100644
--- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
+++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
@@ -34,6 +34,8 @@
  *
  */
 
+#include <linux/string_choices.h>
+
 #include <drm/drm_print.h>
 
 #include "gt/intel_ggtt_fencing.h"
@@ -76,7 +78,7 @@ static int alloc_gm(struct intel_vgpu *vgpu, bool high_gm)
 	mutex_unlock(&gt->ggtt->vm.mutex);
 	if (ret)
 		gvt_err("fail to alloc %s gm space from host\n",
-			high_gm ? "high" : "low");
+			str_high_low(high_gm));
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/vlv_iosf_sb.c b/drivers/gpu/drm/i915/vlv_iosf_sb.c
index 1f0332b4ad0d..fede1735bc08 100644
--- a/drivers/gpu/drm/i915/vlv_iosf_sb.c
+++ b/drivers/gpu/drm/i915/vlv_iosf_sb.c
@@ -3,6 +3,8 @@
  * Copyright © 2013-2021 Intel Corporation
  */
 
+#include <linux/string_choices.h>
+
 #include <drm/drm_print.h>
 #include <drm/intel/display_parent_interface.h>
 
@@ -101,7 +103,7 @@ static int vlv_sideband_rw(struct drm_i915_private *i915,
 				    VLV_IOSF_DOORBELL_REQ, IOSF_SB_BUSY, 0,
 				    5)) {
 		drm_dbg(&i915->drm, "IOSF sideband idle wait (%s) timed out\n",
-			is_read ? "read" : "write");
+			str_read_write(is_read));
 		return -EAGAIN;
 	}
 
@@ -125,7 +127,7 @@ static int vlv_sideband_rw(struct drm_i915_private *i915,
 		err = 0;
 	} else {
 		drm_dbg(&i915->drm, "IOSF sideband finish wait (%s) timed out\n",
-			is_read ? "read" : "write");
+			str_read_write(is_read));
 		err = -ETIMEDOUT;
 	}
 
-- 
2.53.0

