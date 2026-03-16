Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B97F46434
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1926F10E23F;
	Mon, 16 Mar 2026 09:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OAMkIw0R";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6434910E38F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:30:09 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-82989744ee0so4035692b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773653409; x=1774258209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=jMzVdfWmoxsbjdrwxTR344TWHoc2r0TzX142Ck3c4OM=;
 b=OAMkIw0R2botM49Wt3n86dtNwkfCAwHlHigBfAz9z0fwlJ9fR8oa6ytQP7AafxYSeS
 DxLL+a9UpTHa3q+wpStTHLS91q/0hqoV1CuoqNgjXf51DvqlgP8Q2IPbWwHmGE8hNQ3T
 2QJg/DVHwEO6JIjjc2fdJl6xw+jlbjG/agm3w4zvscNwG5rzEQr+TmTwHTVlOPCox904
 mB2g3d8olW7NLWhAI4u1AKidkKAYCmVW+1qvKYFdXEaeU5tE67TIyHgOQBHxemSNaXLK
 qt/GIYPGDGo/9XvPCxCwKLfN5gSSFg3w7H47wpbcK++Sl9L14YkAvGpfNM2aniIlQhtT
 tJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773653409; x=1774258209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMzVdfWmoxsbjdrwxTR344TWHoc2r0TzX142Ck3c4OM=;
 b=YDVe8lhp2tsVj6qS/9mIDsDoFmJwu5QJ/YlK8TUPjxw0NeKIey4ZbCR8KAArkBYodp
 UfzmwN9BJ3lj4t+XzfcGu2HWp/Rvw8lshHWPXBZ6DQJGq9Ac6WOLGddrNud+yPn5R577
 R0408O4e0GAGHgrvv9P7vkztMVfIv7lu5lo2BcsyoU5wD5xON8lXvdM4rFGbev23DCxw
 Je7zmUpGBDbAxtJjFgFkLM2kPCFZ8gSEIxNIk1UgQZAIdu8A6Tm2a3RuWxpIIfHL7t//
 pkUGSrkp5uDNZV2bEZRzWfDUpSEf+DK9a8kh5KPYDXYYViiDYmBJ1mQSO7ZEcNOcF+zq
 YvSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULfTX33HvpRSgR8c0Jk4MsGSxKpkwVy+0Vy8aRN7wlwhm0/ik8S49UdYWFEh9cMl+0QVL3eBZNlao=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzkf+H8ej5r/fIf6M+6HND5t8wRTLmLsEU5P/4getrSiQjFNkuv
 HqjCR5nLevZfnVL3rfRNUeAb/8U5oS9XMa8RKI4zjUsqtwcTc59xfOneJqyYzXVoUhUM2Q==
X-Gm-Gg: ATEYQzzJaSj0V8CFc4ie8op70VnTzoBKQim7CXwVcH/Rz6KRsdOpHfdj0Vs8m/A4D0+
 1bVPmvqBYoSbozXM/2Ux03nP2aHWEHw/OBHtC7vdN42N8w2x9iVQ25IX1DVKlCRYCpg7So4yJ95
 riGbJ0NF4qpqQL/XVtMT0h1q4efvu7RMXgBugSxNEg15dobHtULMyY8z/S6h/6oHuDB9IM5JQXK
 ud6kIw2zx3BDn54IOgOlbThssPa3F7yzfrJT+7sEYnoIv8RokyLwpDq9MuMFgj9DapmYgJ0sZ4M
 bdkAjJfxbj+qU6rQaczNSIIbShz6Jt2gbA+N2pPGmONclEpldgLOmqcNs1shqE5auqvNNmdpWzY
 Xa0lgVymB1LR6mk5qTyxJiZ5wKp4TVVCty3vOEeprqIIB+AClivaALhgCd3jRKgFP5WNM6IvrhY
 bOZ5zE3lr1zaPuHftD
X-Received: by 2002:a05:6a21:a345:b0:398:9820:f6ed with SMTP id
 adf61e73a8af0-398ecd67b1cmr12899112637.56.1773653408677; 
 Mon, 16 Mar 2026 02:30:08 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4468])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7400000532sm3693942a12.27.2026.03.16.02.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 02:30:07 -0700 (PDT)
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/xelpdp/tc: Convert TCSS power check WARN to a debug
 message
Date: Mon, 16 Mar 2026 17:30:01 +0800
Message-ID: <20260316093001.689992-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The BIOS can leave the TypeC HPD live status bits set on an MTL/XeLPDP
port indicating a connected device, while TCSS (TypeC Subsystem) power
has not been enabled. This is a known BIOS handoff condition observed
during cold/warm boot on headless Meteorlake platforms.

When this happens, tc_phy_get_current_mode() returns TC_PORT_DP_ALT
(from HPD live status bits) but xelpdp_tc_phy_tcss_power_is_enabled()
returns false because TCSS power was never enabled by BIOS/GOP. This
causes the drm_WARN_ON in xelpdp_tc_phy_get_hw_state() to fire during
driver probe, even though the driver handles this state correctly
afterwards by calling intel_tc_port_update_mode() to reconcile the
PHY state.

Convert the drm_WARN_ON to a drm_dbg_kms() message, consistent with
the approach taken for the analogous AUX power check in
commit d7fa5754e83cd ("drm/i915/icl+/tc: Convert AUX powered WARN to a
debug message").

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_tc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index bd12148e42f70..18218e450b16c 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1187,9 +1187,10 @@ static void xelpdp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 			tc->max_lane_count = 4;
 	}
 
-	drm_WARN_ON(display->drm,
-		    (tc->mode == TC_PORT_DP_ALT || tc->mode == TC_PORT_LEGACY) &&
-		    !xelpdp_tc_phy_tcss_power_is_enabled(tc));
+	if ((tc->mode == TC_PORT_DP_ALT || tc->mode == TC_PORT_LEGACY) &&
+	    !xelpdp_tc_phy_tcss_power_is_enabled(tc))
+		drm_dbg_kms(display->drm, "Port %s: TCSS unexpectedly not powered\n",
+			    tc->port_name);
 
 	__tc_cold_unblock(tc, domain, tc_cold_wref);
 }
-- 
2.53.0

