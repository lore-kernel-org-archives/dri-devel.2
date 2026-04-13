Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB69F9D0F0
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B3A10E611;
	Tue, 14 Apr 2026 18:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mechasystems-com.20251104.gappssmtp.com header.i=@mechasystems-com.20251104.gappssmtp.com header.b="URgiXXSR";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F6110E0F7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:47:32 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-82f2385724aso1177921b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems-com.20251104.gappssmtp.com; s=20251104; t=1776080852;
 x=1776685652; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b/LOXITNDN/uMhBAVQruWsPEexWMWJ2BqlDUKp8QBqI=;
 b=URgiXXSRWyCt/Zc/GhYBL8KZ+TDsWcN9SfeDBga6oZ7DKEiS/v56ggQIzJSWIDgOiO
 BU3lgrFYPBB949poAaHtmEdjDue2tpa0fr0nlGd24erjrV8XAkYMpd4wD4VvpNdWslKb
 DQVma3RruBOzS9hfjdO1OmUz3r471xbm/hhkCSnUE/0IKxhbnRBcEsMT9nVNTg85dgsq
 pUm8n3XTWbO2dsHQ4oYWxIdj9Gv8/hs1b2nP3nqumxDODkcLcs3Uc6AimxKVijNUuIru
 pVTUdVcMfDvUAGMnu2iPjzVa726bRTfFXAbHTvaVagDgVIuHemmZxf9JefI9uYcRsUb4
 qYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776080852; x=1776685652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/LOXITNDN/uMhBAVQruWsPEexWMWJ2BqlDUKp8QBqI=;
 b=IXzOS5vhM64tmTOeljsoVo/LRrRGLRMygYb8zl0qGTHJFEUEEQnxsVBxZ5jH9H1X/2
 hutu6D+JfksxFi86sDEoksqgHyb/BYBgPjoC2LHmngUBuPloksMxoW61R0fxYCe65Cn4
 vdCWCsi+TMG3n6LsTMvqBCi74X8Mu0ZyEbsSm8qkXE7OhBTCkcm20fy8R7rKpxHiHN8S
 qOVMkuDvY0/qaBKipf1ffcfVZvGVALr5rCU5JX4ynarmFws+OZ+Gouj2ezeSuy5nQI6+
 nB/Qlehikev2hW/IxR6gSldzuQyuG+r6KfTahjR2Gm0foIzbWy947p2nHm72PTdh7oTO
 PG6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+su1HW7N9mJOAZFDTkv1xe0cSUKS9/wWGF3EyXbiwgLSumYyqCjSG+OTCi60u/jKuZpTSYM2I5ipE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRKGUScPRY2Cid2d9shyMl6FJ7miJvjcBu3TVlpAJF6qWJMFXh
 M9m/3LondNk8N5Pzdmb0sFnfRxzcT1BQiymGrtc/faeMUGVu84YNKtLAxXDZKHsXQTg=
X-Gm-Gg: AeBDieuI3Zk5chxmvNZAYeMwN5adMvgl8Xlx8jdBPcQ7s6HQocvF3m6tXQtQzDZzu3D
 p5Jigu3qObNrqbC4QsyJBi6EQkXoxkAj3J8eS+PEQfLgxLDYDK1fjMcW4spN0oOnY+k1bxiHx2/
 xCa1ATRCtIJI92L2JTxYKZd3cHYKBFAail8y6EgDb5g2WfzEuIxjUzW6v9ni8m1TTx+oCaVSu7S
 0xnKVwOkFbg1CGEQ6dymlmnW/xxug5jbz2VAFy+zZCZxqmidUF+FwvqlGsW34VGVSZ/OqXj2XAd
 fU87+hH6OubhoEVRuKQUMWtP9oJQOzjV3rslUAumb/yXwpOcgM6NQjzc5dB7R/iXWnHWcX6b7hh
 DXx+FhTzB5f8Ew75n29Nhe1DJEzX8rbhtACDHl3d7qriHetu283epIDmLWN8nSR82wuhY2VQa6k
 CcLZtikZXeFN8sFLB+JENlTIkVLoyxdkDDBwfp
X-Received: by 2002:a05:6a00:39a9:b0:82c:e3f4:f5e9 with SMTP id
 d2e1a72fcca58-82f0c219ccfmr14135131b3a.18.1776080852304; 
 Mon, 13 Apr 2026 04:47:32 -0700 (PDT)
Received: from advait-work.lan ([2001:df0:e1c0:3414:7eaf:93c5:46f:fbe4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c330925sm12822137b3a.15.2026.04.13.04.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:47:31 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: marex@denx.de
Cc: stefan@agner.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Advait Dhamorikar <advaitd@mechasystems.com>
Subject: [PATCH] drm: mxsfb: lcdif: enforce 64-byte pitch alignment for scanout
Date: Mon, 13 Apr 2026 17:14:56 +0530
Message-ID: <20260413114456.173485-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Apr 2026 18:48:22 +0000
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

The LCDIF controller expects framebuffer pitch to be aligned to a
64 byte boundary for reliable scanout. While byte-granular pitches are
supported by the interface, the i.MX8MP reference manual
recommends 64-byte alignment for optimal operation.

Corrupted output was observed with XR24 framebuffers where a pitch of
4320 bytes caused visible corruption and choppy display, while an aligned
pitch of 4352 bytes worked correctly.

Ensure that only framebuffers with properly aligned pitch are accepted
by rejecting invalid configurations in lcdif_plane_atomic_check().
This allows userspace to fall back to a compatible allocation.

Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
---
 drivers/gpu/drm/mxsfb/lcdif_kms.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index 72eb0de46b54..8e574e9a591a 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -674,6 +674,18 @@ static int lcdif_plane_atomic_check(struct drm_plane *plane,
 	crtc_state = drm_atomic_get_new_crtc_state(state,
 						   &lcdif->crtc);
 
+	/*
+	 * While byte granularity is supported, LCDIF requires
+	 * that framebuffer pitch be aligned to 64 bytes.
+	 */
+	if (plane_state->fb &&
+	    !IS_ALIGNED(plane_state->fb->pitches[0], 64)) {
+		DRM_DEV_DEBUG_DRIVER(plane->dev->dev,
+							"Framebuffer pitch (%u bytes) must be aligned to 64 bytes\n",
+							plane_state->fb->pitches[0]);
+		return -EINVAL;
+	}
+
 	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
 						   DRM_PLANE_NO_SCALING,
 						   DRM_PLANE_NO_SCALING,
-- 
2.43.0

