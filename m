Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2486C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC49610EA01;
	Sun, 13 Sep 2026 20:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nMgwZOQO";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB3C10E6AC
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 09:18:13 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c2940ff2313so49061966b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789204692; x=1789809492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=STiZW/IcHvT4e1S/BFbyfQE4PgoHv6tak0bixvasDdQ=;
 b=nMgwZOQOQd0AC2wibBmM6WL29jAHIvGv75YXtXIqkoaiJ7sExEshbGDc/j2feOh4sP
 GtKGp7Mo5Cnxw/hY+3zLhklgcvCnknAF4g9TtYZmt33mfqSaEg+cQxNwVJ4YYsD60upr
 FW6Y6NY9JkuC1YkuxtQovRxUUYDA3xsvOTlGopxJirqVnqAk7IGO8KlMBb7w3UiCXVXO
 EDvvKMyAoKN5b+UBm5IYm53OZTPMiaHDfhn+a58cc+4QLgFMbjwkEom0GaKmKtUoIzY6
 qo7xfbokABy6LCsh65kjLcnAEo11COKem0wnrQpTCbf+1e/T/dR4nXMMhqMz8mSnWSg3
 HZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789204692; x=1789809492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=STiZW/IcHvT4e1S/BFbyfQE4PgoHv6tak0bixvasDdQ=;
 b=EztR2PyI/I9SfTGnE7HMOZwFqMGRu0ayQvUJ+L3Rf8vnflL1elqQ7RUeMi6ZLMR53m
 vmp2/sJLxlHb5Io9xxyWAI/CHJPry9K6bwvuv8fUykeY7AZw3hR24lYH3t/b+0UQ2kHz
 0lPZC0YBXZC36+Mr1kVeQA/7V00FFqhcDUK8HBD6iOBlp8icPmo/F7pKK4pcZJLL9C1y
 o8FrZZu26laILlcoQQSoZ557NwNm9wgA7W+4uOe4ETigYELOjZD8hldRdKJtSWc6WrL/
 4G4iZYO+VqEyg8tF2HdGUvxPWRDf7FkE6h2W4m7t26SrMVBdVtjYvCw8xZbIt7wY2vs2
 abzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIGELA0ddit9bufe8oPMR/Tccoz5eqa/nDuTaaqHolqxDY8HC/jz2+EcVemf9w8CfpspQvwwltrb4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3A4aTCAfnLBaPfTE3kCfZD0ahMwswCMtPb5T3FqKLbrwxKnyv
 E6T2KMSJCHB2UNWV710np1+Wg/EyUtgISCYYU2fjkNUBV3PY0YfzPvqJ
X-Gm-Gg: AYBFou3e1ppxVQlSrC6fxXakpfU8Bcl5Ib6DkR+4MScllTuov6RtrKhDs3SKyXSVAKw
 e/8mYwa6N9KWAlPfp44CWqR/y5fvm+9/ZQTscWYmxRpAZgmAkAltTSiXsTK+H4UA4FFWgDfnC5D
 4Msz6mZAo6IuxUWs7JzSmOSxVUm2BlLpqPMuNtglwuANil70SwDgpfcZKsGQjcfrX7jx4DUdtcL
 bH4InncRIS/hgj2OODP0ndxcWCjaatMmGh6nA8DxnKJ8RzsHhAfyD3+K3dAfmoY8O+yYWWSxlIk
 lFjcJ3aI0UJ9imCt52mCrIQ4b3/09mVlUk+vNpetlaaYhoA8kTazjsDoGJOlAOnZbCbol7Nl5Fz
 51ki655gfj7WtukPGkCm8nZPQk+9Mn8gShgDWOiJSdozQ2OTZW1rIJQbKc5SbyS5hHeG6zIF59h
 sbVCzEfgF43y+AXUGcWkuIJjIIe49VoqvPLAdc351vp9aIuxxDUlHoXCqzz0rWFMSvq/uixTvO4
 KmGf4Ak1iteydBXz+2O
X-Received: by 2002:a17:907:3c86:b0:c25:f7db:4bef with SMTP id
 a640c23a62f3a-c2962c9944bmr512031466b.21.1789204691464; 
 Sat, 12 Sep 2026 02:18:11 -0700 (PDT)
Received: from cartold.tail1da87c.ts.net ([77.213.69.61])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29660234e7sm170786066b.15.2026.09.12.02.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 02:18:11 -0700 (PDT)
From: Theo Andersen Carton <andersen.theo@gmail.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Theo Andersen Carton <andersen.theo@gmail.com>
Subject: [PATCH] drm/i915/ddi: add DDI A force 4 lanes quirk for Apple
 MacBookPro11, 5
Date: Sat, 12 Sep 2026 11:18:05 +0200
Message-ID: <20260912091805.531666-1-andersen.theo@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

On dual-GPU Retina MacBooks the internal panel is muxed to the discrete
GPU at boot, so Apple's firmware never lights up eDP on the Intel side.
As a result it never sets DDI_A_4_LANES, and intel_ddi_max_lanes() reads
back a source maximum of two lanes for port A.

intel_dp_max_common_lane_count() then takes min3(source_max = 2,
sink_max = 4, ...) = 2, giving 2 x 2.7 Gbps x 8/10 = 4.32 Gbps of link
bandwidth. The panel's native 2880x1800@60 8bpc mode needs 8.1 Gbps, so
every mode is rejected with MODE_CLOCK_HIGH and the connector comes up
with no usable modes at all -- the panel stays dark whenever i915 is
made to drive it, which looks like a hardware limitation but is not.

The lanes are physically there. Reading the panel's DPCD from the AMD
side, where amdgpu drives it correctly, reports MAX_LANE_COUNT = 0x84,
i.e. 4 lanes, and amdgpu's own link_settings shows it running the panel
at 4 lanes / HBR. macOS likewise drives this panel from the iGPU at its
native resolution, so all four lanes are routed through the gmux to
DDI A. Only the register bit is unset.

intel_ddi_a_force_4_lanes() already exists for exactly this situation --
its neighbouring comment notes that "Some BIOS might fail to set this
bit on port A if eDP wasn't lit up at boot" -- but it only covers
Broxton and Geminilake. Extend it with a DMI quirk so affected Macs get
the correct lane count too.

The DMI match is deliberately narrow. Other dual-GPU models in the same
family are very likely affected identically, but they are untested, so
widen the match only as reports come in.

Tested on a MacBookPro11,5 (Broadwell, Iris Pro + Radeon R9 M370X):
with the quirk, DDI A comes up as 4 lanes, link training passes at
link rate 270000 / lane count 4, and i915 drives the internal panel at
its native 2880x1800.

Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c    |  7 +++++
 drivers/gpu/drm/i915/display/intel_quirks.c | 34 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 02a53c9848e1..f746287830b3 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4976,6 +4976,13 @@ static bool intel_ddi_a_force_4_lanes(struct intel_digital_port *dig_port)
 	if (display->platform.geminilake || display->platform.broxton)
 		return true;
 
+	/*
+	 * Machines whose firmware leaves eDP dark on the Intel side never set
+	 * the bit, so trust the quirk rather than the register.
+	 */
+	if (intel_has_quirk(display, QUIRK_DDI_A_FORCE_4_LANES))
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d5..feb28956a013 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -100,6 +100,20 @@ static void quirk_disable_psr2(struct intel_display *display)
 	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
 }
 
+/*
+ * Dual-GPU Macs boot with the internal panel muxed to the discrete GPU, so
+ * the firmware never lights up eDP on the Intel side and consequently never
+ * sets DDI_A_4_LANES -- even though all four lanes are wired through the gmux
+ * to DDI A. Without the bit, port A is capped at two lanes, which is not
+ * enough bandwidth for the panel's native mode, leaving the connector with no
+ * usable modes at all.
+ */
+static void quirk_ddi_a_force_4_lanes(struct intel_display *display)
+{
+	intel_set_quirk(display, QUIRK_DDI_A_FORCE_4_LANES);
+	drm_info(display->drm, "Applying DDI A force 4 lanes quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -142,6 +156,13 @@ static int intel_dmi_no_pps_backlight(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int intel_dmi_ddi_a_force_4_lanes(const struct dmi_system_id *id)
+{
+	DRM_INFO("DDI A is 4 lanes despite firmware on %s\n", id->ident);
+
+	return 1;
+}
+
 static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 	{
 		.dmi_id_list = &(const struct dmi_system_id[]) {
@@ -188,6 +209,19 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 		},
 		.hook = quirk_no_pps_backlight_power_hook,
 	},
+	{
+		.dmi_id_list = &(const struct dmi_system_id[]) {
+			{
+				.callback = intel_dmi_ddi_a_force_4_lanes,
+				.ident = "Apple MacBookPro11,5",
+				.matches = {DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+					    DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,5"),
+				},
+			},
+			{ }
+		},
+		.hook = quirk_ddi_a_force_4_lanes,
+	},
 };
 
 static struct intel_quirk intel_quirks[] = {
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 970a4fe52faf..d2b8e9183c62 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -23,6 +23,7 @@ enum intel_quirk_id {
 	QUIRK_EDP_LIMIT_RATE_HBR2,
 	QUIRK_DISABLE_EDP_PANEL_REPLAY,
 	QUIRK_DISABLE_PSR2,
+	QUIRK_DDI_A_FORCE_4_LANES,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.55.0

