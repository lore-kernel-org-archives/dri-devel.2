Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFF5C79FAF
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606D010ED43;
	Tue,  8 Sep 2026 20:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="IsGe1pGR";
	dkim-atps=neutral
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com
 [157.90.84.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1791010E4BE;
 Tue,  8 Sep 2026 20:07:15 +0000 (UTC)
Received: from wsembach-tuxedo.buero.augsburg.tuxedo.de
 (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
 (Authenticated sender: wse@tuxedocomputers.com)
 by mail.tuxedocomputers.com (Postfix) with ESMTPA id 170142FC008B;
 Tue,  8 Sep 2026 22:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
 s=default; t=1788898033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7o/89PLTN4U51tEmLs7Y8nmhdGxBiG8G10SgvfZEyj0=;
 b=IsGe1pGRz2pjAljjYyLmBLdHTwqhdOlKHwiH5yWyvwhZroQjJb6Ekpbs7T0em+w/0MDdlR
 LOU1mL+qpxYcj6h32WqR+sfTaE7HQlMI772tX1Rd7e13bin/QmwNp9fkK6o5UvsOlOUsXU
 Iv3a6OsQ/+Lk3omJ9tUEVbeEsJJHp/c=
Authentication-Results: mail.tuxedocomputers.com;
 auth=pass smtp.auth=wse@tuxedocomputers.com
 smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Subject: [PATCH 2/2] drm/intel: Add quirk to disable rc6 on some TUXEDO devices
Date: Tue,  8 Sep 2026 22:05:29 +0200
Message-ID: <20260908200707.65516-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908200707.65516-1-wse@tuxedocomputers.com>
References: <20260908200707.65516-1-wse@tuxedocomputers.com>
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

Some TUXEDO devices have random rare hard resets during video streaming.

Disabling rc6 fixes this. Until the root cause is found this is a pragmatic
workaround.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/i915/i915_pci.c | 11 +++++++++++
 include/drm/intel/pciids.h      | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 2f03f95945f1b..a52b56bedcf4f 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -687,6 +687,16 @@ static const struct intel_device_info adl_p_info = {
 	.dma_mask_size = 39,
 };
 
+static const struct intel_device_info adl_p_tux_ibp8_quirk_info = {
+	GEN12_FEATURES,
+	PLATFORM(INTEL_ALDERLAKE_P),
+	.platform_engine_mask =
+		BIT(RCS0) | BIT(BCS0) | BIT(VECS0) | BIT(VCS0) | BIT(VCS2),
+	.__runtime.ppgtt_size = 48,
+	.dma_mask_size = 39,
+	.has_rc6 = 0,
+};
+
 #undef GEN
 
 #define XE_HP_PAGE_SIZES \
@@ -863,6 +873,7 @@ static const struct pci_device_id pciidlist[] = {
 	INTEL_DG1_IDS(INTEL_VGA_DEVICE, &dg1_info),
 	INTEL_RPLS_IDS(INTEL_VGA_DEVICE, &adl_s_info),
 	INTEL_RPLU_IDS(INTEL_VGA_DEVICE, &adl_p_info),
+	INTEL_RPLP_TUX_IBP8_QUIRK_IDS(INTEL_VGA_DEVICE, &adl_p_tux_ibp8_quirk_info),
 	INTEL_RPLP_IDS(INTEL_VGA_DEVICE, &adl_p_info),
 	INTEL_DG2_IDS(INTEL_VGA_DEVICE, &dg2_info),
 	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
index 7a4a5658942d2..e4f74916a62c2 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -712,6 +712,28 @@
 	MACRO__(0xA7AC, ## __VA_ARGS__), \
 	MACRO__(0xA7AD, ## __VA_ARGS__)
 
+#define INTEL_RPLP_TUX_IBP8_QUIRK_IDS(MACRO__, ...) \
+	MACRO__##_SUB(0xA720, 0x1D05, 0x124A, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA720, 0x1D05, 0x124C, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA720, 0x1D05, 0x124E, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA720, 0x1D05, 0x130F, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A0, 0x1D05, 0x124A, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A0, 0x1D05, 0x124C, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A0, 0x1D05, 0x124E, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A0, 0x1D05, 0x130F, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A8, 0x1D05, 0x124A, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A8, 0x1D05, 0x124C, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A8, 0x1D05, 0x124E, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7A8, 0x1D05, 0x130F, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AA, 0x1D05, 0x124A, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AA, 0x1D05, 0x124C, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AA, 0x1D05, 0x124E, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AA, 0x1D05, 0x130F, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AB, 0x1D05, 0x124A, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AB, 0x1D05, 0x124C, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AB, 0x1D05, 0x124E, ## __VA_ARGS__), \
+	MACRO__##_SUB(0xA7AB, 0x1D05, 0x130F, ## __VA_ARGS__)
+
 /* RPL-P */
 #define INTEL_RPLP_IDS(MACRO__, ...) \
 	MACRO__(0xA720, ## __VA_ARGS__), \
-- 
2.43.0

