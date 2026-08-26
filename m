Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1C8C61DCD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7D010ECE6;
	Wed, 26 Aug 2026 14:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BF9yF3Ol";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FAA10E2EA
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756187;
 bh=fO0m7ywxhj6aUDMKcRwERhzspxOkjxyxxPEAGdSDe0c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BF9yF3OlVRn0IDps2MZ4UjLT364By/8TahNRr9YSkvJky7uDtxJNgzxpPUReSfnKU
 PuktkJj6ZqJl6D0frGmENPN9oDeB/stw68AviiiEGix/Zzp/bkc+bEDVd39s5tXsX6
 1/wN6P3JDz91j93z7iHG5fprgAixkcw4e+Mt/Tcg+O/9dq0bsJUeMP+9O9meWquDeM
 eOJJ80HXRsncYc1xbtiqPjQMgGOWwbYYOIAAqgFHPFkLzvxiaEbxosW2JG/vNqTCSp
 PA5kQ0H0e5U+BOVm52BaCY3B5MA6mg0ll2gtCuhZ+XQ3DH9YV1YcYSzp38cguKG53n
 XT6+LzQzTR+TA==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CE12017E10F1;
 Wed, 26 Aug 2026 16:56:26 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 26 Aug 2026 16:56:12 +0200
Subject: [PATCH v4 13/18] drm/panthor: Complain if the SOFT_RESET fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-panthor-unplug-fixes-v4-13-982cc8f4234b@collabora.com>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
In-Reply-To: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=1765;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=fO0m7ywxhj6aUDMKcRwERhzspxOkjxyxxPEAGdSDe0c=;
 b=IvxdBPFO4yCr1e+4/FtiBl2rpBBa4Vre28Ql/Jz6o6lCZvvRlkaPeBtKdHUZXgnPIw3quHuHv
 S9mdxZwpR9PC1CgXBKlO8v3y0Hr70fN4MMWqSAtXCgxnWEtixcKOrNx
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

We rely on a functioning SOFT_RESET to avoid HW UAFs when the GPU was
in a state where AS commands were no longer accepted. If we silently
ignore RESET failures, we're just pretending to be safe while exposing
ourselves to the very UAFs we were trying to avoid. On the other hand,
there's basically nothing we can do if both the SOFT_RESET and the
AS_COMMAND(UNMAPPED) fail, so do what we do best: complain loudly and
taint the kernel with a WARN_ON().

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_hw.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 4531c1239cb6..f13fd7b335c1 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -41,9 +41,17 @@ int panthor_hw_init(struct panthor_device *ptdev);
 int panthor_hw_power_status_register(void);
 void panthor_hw_power_status_unregister(void);
 
-static inline int panthor_hw_soft_reset(struct panthor_device *ptdev)
+static inline void
+panthor_hw_soft_reset(struct panthor_device *ptdev)
 {
-	return ptdev->hw->ops.soft_reset(ptdev);
+	/* We're relying on the SOFT_RESET to reset the MMU block if some AS
+	 * were stuck for some reason. Failing to reset the MMU/L2 means we're
+	 * exposing ourselves to HW UAFs. On the other hand, there's basically
+	 * nothing we can do if both the SOFT_RESET and
+	 * the AS_COMMAND(UNMAPPED) fail, so do what we do best: complain loudly
+	 * and taint the kernel.
+	 */
+	drm_WARN_ON(&ptdev->base, ptdev->hw->ops.soft_reset(ptdev));
 }
 
 static inline int panthor_hw_l2_power_on(struct panthor_device *ptdev)

-- 
2.55.0

