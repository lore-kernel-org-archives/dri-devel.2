Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F42DC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 14:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB63110E0CD;
	Sat,  5 Sep 2026 14:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FDRlW/+u";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4773B10E289
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 14:25:41 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3990fe066ebso1564483a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788618341; x=1789223141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=irtRdSHYVWU6V1hRtF1N7wOshHHRxGrEgOQHGUw+S0o=;
 b=FDRlW/+u8lA29qN+drgG/atl6HWHIti7aQ2oJyBe+njHdxFkAYNPh5RNFgJpJz4+Z9
 NNJmS3P+L968NrvMmZAJul2fGt4BSBMe7yUYTOSKEwkB7qiBQHO4QW2GsnP0jizogf5c
 cWKZFAngbX9qi7LHog3hOJj5AOm3WuPUCPAN6ZV41RZkf07Mg/cYbqR1tUNZln7CF3MB
 mWDqFRIE6W1SpXotPHSNVUGXJ7Yn2Nokl0RgBu2/mYA/MTmCMG1oHZlYHHMkIcs20Jxx
 vJr236vG76Cr2JeO3WnSR4aifyOMLudWYgrGjTRAgUEP4qtoBjnKf70Y8woEk7kbaXct
 Z5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788618341; x=1789223141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=irtRdSHYVWU6V1hRtF1N7wOshHHRxGrEgOQHGUw+S0o=;
 b=J0aE/AXcZ26eDI030vqVUgRbnTzdz+vc7XmtMwquDUmbQXedOao0C0u1/YTrZHS+Lj
 z9xgtjnvhs4rLw1gXDYVhkbCI8Nb/tg1fxpkdk7jVw7RRvj+0Zks9oVHpkDxSW/lKqC7
 PUuw3h8rBwOoKzYFa6NXMXN1ONZsOLENZE6/1h6b9MZ3GB+dWEDn1JaEU6asw9yQ5I9H
 PRewVQsp3fVmDDcQ1/1WlIIlw5AWky6XCDy4CaaeCBlwGyF1RtxJL3oXZ+0/t46r2pLP
 5t2Uj0gbTMXJVnYILQGv48yJpDr9E7LPJW8f5PrLVBSC8YorKm22Iv6ul0xr8mITi2aM
 YEyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw52hjLvRR1yK+KUTwmOMq7WdrtXZFuYVLugASxxPpQ83MtEipYBTL4ngr4rs8D2KyDW4EZSfQGdNs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mkApTXOvuDCr/IQKxFW1/ZPqfIMQ/sdO6/06xN2WF0SzCob7Xe
 pwj2HMUmUG1mSBPL9f1GuhUbqB7Ll+r1m7dogvQylNt+IKAErcyp9YeB
X-Gm-Gg: AYBFou0SCq6eHlmWR8OIVcf4mqDjQHHHuTyiIgUyYq0+M5zb6jPXKyiRINC9l30y9Bf
 GDfEQpqYjYAwpDvK5A/gESn8hUioTUO7HhWPIl7HaiL8XXv0PqyHxMX2bx3PDIwFKNKW3dN+CWw
 n+qNo/klI5mlYRDwSR5ifIDJc7sfIwSUAk0cbH2ILyQ1FKNK2h7KW8lX4FEJmcxXtDzUD3BWchn
 YBXqkWUV9/oQd4aouzKBmmpIn3z8c1vlyILKYsiZSiJfEaLBIZdk47v08RMei94fvxud7NohbUS
 nCxYX8YF/oThz0orcFZYM0FV/Qyh0RhjdiPWia41MuxxGdtm5lE1kP5FcH3byC8DoipORltcuaZ
 hHrLiZBrW11ziWcefqMqqORTCl1LjETtNAvDHwWd4gip23m/irR9tdjizOEVLsdv18vPk3sf8dS
 hYB2AtpB05mI1qwQulQZf+b8poQafw50yrpJZ4bLLaYdh4F+zLU+ZzjnbSiKxdbptcFw6GQHoRk
 oJeS0lOL00BPgIdA4Eom3uPnKVVu3sjuBGjNxspymdH7M55xo3G
X-Received: by 2002:a17:90b:3a81:b0:398:c292:ac80 with SMTP id
 98e67ed59e1d1-39b2612eaa4mr17477270a91.10.1788618340676; 
 Sat, 05 Sep 2026 07:25:40 -0700 (PDT)
Received: from XiaomiLaptop (n112119120034.netvigator.com. [112.119.120.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b260fdf9asm10501790a91.9.2026.09.05.07.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 07:25:40 -0700 (PDT)
From: Andrew Zhou <zhoulol888@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andrew Zhou <zhoulol888@gmail.com>
Subject: [PATCH] drm/xe/display: Remove invalid initial plane PTE check for
 iGPU
Date: Sat,  5 Sep 2026 22:25:00 +0800
Message-ID: <20260905142500.17666-1-zhoulol888@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Pantherlake intergrated graphics can have the XE_GGTT_PTEDM bit set
in the BIOS-initialised framebuffer PTE. The new validation rejects
this and fails to create the initial frambuffer, resulting in static.

Remove the too-strict validation.

Signed-off-by: Andrew Zhou <zhoulol888@gmail.com>
Tested-by: Andrew Zhou <zhoulol888@gmail.com>
Tested-on: Intel Core Ultra X7 358H, integrated graphics, B0 stepping
---
 drivers/gpu/drm/xe/display/xe_initial_plane.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
index 0f86b7303..8c95dc4e6 100644
--- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
+++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
@@ -85,7 +85,6 @@ initial_plane_bo(struct xe_device *xe,
 			    &phys_base);
 	} else {
 		struct ttm_resource_manager *stolen;
-		u64 pte;
 
 		stolen = ttm_manager_type(&xe->ttm, XE_PL_STOLEN);
 		if (!stolen) {
@@ -93,13 +92,6 @@ initial_plane_bo(struct xe_device *xe,
 			return NULL;
 		}
 
-		pte = xe_ggtt_read_pte(tile0->mem.ggtt, base);
-
-		if (is_pte_local(pte) != need_pte_local(xe)) {
-			drm_err(&xe->drm, "Initial plane PTE has bad local memory bit\n");
-			return NULL;
-		}
-
 		phys_base = base;
 		flags |= XE_BO_FLAG_STOLEN;
 
-- 
2.55.0

