Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5934C79FB1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9076810E504;
	Tue,  8 Sep 2026 20:07:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="DzegxdjM";
	dkim-atps=neutral
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com
 [157.90.84.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0BB10ED49;
 Tue,  8 Sep 2026 20:07:14 +0000 (UTC)
Received: from wsembach-tuxedo.buero.augsburg.tuxedo.de
 (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
 (Authenticated sender: wse@tuxedocomputers.com)
 by mail.tuxedocomputers.com (Postfix) with ESMTPA id 22F572FC008A;
 Tue,  8 Sep 2026 22:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
 s=default; t=1788898032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tJh7oIHd1OG30e5MZpyMaDewB+zPIeuZm1jBsMBTEcY=;
 b=DzegxdjMqhq8SYznp89XG4EiXmKtKbUqvOZvPQ7nUpd/VRGml1RbrAhqlJBFEbIknXpURo
 /UzzbDmgK3FUbDA5udfAPkxaMmHKH8GLQhC4xbdvGHzVgxsQIwf87CQJS8gOiZ0VXKDGiz
 I8b5ROpfY4w6g8J+wleESC+f4J3pr4E=
Authentication-Results: mail.tuxedocomputers.com;
 auth=pass smtp.auth=wse@tuxedocomputers.com
 smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Werner Sembach <wse@tuxedocomputers.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/intel: Generalize PCI ID macro for subvendor and subid
Date: Tue,  8 Sep 2026 22:05:28 +0200
Message-ID: <20260908200707.65516-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
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

Generalize INTEL_QUANTA_VGA_DEVICE macro by introducing a
INTEL_VGA_DEVICE_SUB macro that takes subvendor and subid in addition to
id.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 include/drm/intel/pciids.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
index dff389b56eb3b..7a4a5658942d2 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -37,9 +37,8 @@
 	.driver_data = (kernel_ulong_t)(_info), \
 }
 
-#define INTEL_QUANTA_VGA_DEVICE(_info) { \
-	.vendor = PCI_VENDOR_ID_INTEL, .device = 0x16a, \
-	.subvendor = 0x152d, .subdevice = 0x8990, \
+#define INTEL_VGA_DEVICE_SUB(_id, _subvend, _subid, _info) { \
+	PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, (_id), (_subvend), (_subid)), \
 	.class = PCI_BASE_CLASS_DISPLAY << 16, .class_mask = 0xff << 16, \
 	.driver_data = (kernel_ulong_t)(_info), \
 }
@@ -180,7 +179,7 @@
 	INTEL_IVB_D_IDS(MACRO__, ## __VA_ARGS__)
 
 #define INTEL_IVB_Q_IDS(MACRO__, ...) \
-	INTEL_QUANTA_VGA_DEVICE(__VA_ARGS__) /* Quanta transcode */
+	MACRO__##_SUB(0x016A, 0x152D, 0x8990, ## __VA_ARGS__) /* Quanta transcode */
 
 #define INTEL_HSW_ULT_GT1_IDS(MACRO__, ...) \
 	MACRO__(0x0A02, ## __VA_ARGS__), /* ULT GT1 desktop */ \
-- 
2.43.0

