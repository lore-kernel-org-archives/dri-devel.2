Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2061C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E58310F069;
	Thu, 17 Sep 2026 18:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+WzPnKr";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13FF910F06D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:52:58 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so1906917a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789671176; x=1790275976; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rja8CkyCHKN0BB+9VZU25/yAjyQ+Z2Lz6sA9AfSQojE=;
 b=H+WzPnKrQhzoyV9HGhcOA9NqhXcfhS/qhR++9/kbJdbJ72YqSFpq5rOwBgn70LP5xJ
 GsGHHHVgGAAYOA105PcOmMkXBSb4Ngdmo1Xl4HWfWjucS7K35Xkqiuxh/kekz5fFcEQp
 e+4yQoDA27YtO+9MHk4vutPEhm2lNt9yrvDGjFWaw+FY+KnEBqnLOI/spgcFQYFNUXXy
 r/3tpM0M6WCgvjgNyoS3xpPc16rhM7DqaWoWAkkrDtjeP6DdgWxIZOloTJpvHqYPGFCm
 urLT7hR2s64aAX7Jk2hDKHkGJfibD5OU8fqQ4IpyVNtzeV0MSetJAkmmEiTB8+8YKqPS
 EvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789671176; x=1790275976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rja8CkyCHKN0BB+9VZU25/yAjyQ+Z2Lz6sA9AfSQojE=;
 b=aiL1F1AZGVAnaqrUlBBFm2ruyXSpM+93EVRqlzI8PhxgO6XkL+m5u33lv/YUJplKKI
 B07csZOJQAJRqXqkSqQ7tF5wgIqpz4QPCLbJHs0UWdstvcSNSxWQjTThbxzvfH7jwjzO
 KtYeCu7yqrt20dYR2B/pjwLiD52sbWb6S3nUG7up/SskLAJYTG3oAMQscvKJohIGwmvl
 EqVWTUVTi90LD37FsjFfqfxf6m2F+KRsvwOwiyJKK5gEXL+gEuXlhvfx0R9+hacGBYSo
 hZDa6dBaFzhNmykDk23r1WHMR7Yv0Dl9HW8QQUl/mVn5futbKvvbLg0F41BoWone/wba
 P8rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/IbPrljz8U6HInpKbY53exS+T+2QPka/130JJdwMMbAwWRw+yMjn0wT0/5lK8kzG4sojgZeUJMbQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nagM3KrOr2iSRfF7DQ1IQ+jCmdCeGwZjlxmlaq6tgKDQWwIJwJ
 pKq1+HIv9AsHxusxPJv0M1Yi3cN930Gwt5t2+nb88TEEYRXDV+Epw00u
X-Gm-Gg: AYBFou0FH3k3iNTlZEuiv5jVJcBeIkR3qa5SO+cfu9JBRVewEQ0bWJcrcNVFzkJPsYg
 cpgrYlWmJclxNogtJ3NAwSrY7Zrom9PUypmQR6u9pbTugimhDPzm0FL/kNhDoMuocJtmTgdfTKM
 3qYoJYF+ZffTHSgXMm3PPByvaTXKAFUbNGEtFTeSRS1IOja1jxh/w4UnmJC3kqgMboZDSUW+6Ox
 O/tuJqWok0gqWq4GEB1pSg4PAz8A97wjmHOctsw+Rfu1r51somuBwlrSY+Du7dWaot39l93kHK2
 tKNZpiHd+Bmer4Lemf5ixsvLVexJm1pM+/8BGBFAywBucKDjGRhW2axo8lHa2hmhpEhqQI/N268
 bLBsnvzDqEXpMdCeivlLQ6Tbb4HHfyZymhAMQFwg+E53y/4F7ow20WD/YptgG0o3xna0X5oiDL9
 Wbz0bkcldBxfslXAlN6A7g/YGLhObodqaDjvAmUT/ZdyWZ4Ltb5umW21XaBbQORkalc1s=
X-Received: by 2002:a05:6402:24c5:b0:6aa:13a8:beea with SMTP id
 4fb4d7f45d1cf-6aa22452a31mr10658257a12.21.1789671175963; 
 Thu, 17 Sep 2026 11:52:55 -0700 (PDT)
Received: from cartold ([77.213.69.61]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d286e76sm3610549a12.23.2026.09.17.11.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:52:55 -0700 (PDT)
From: Theo Andersen Carton <andersen.theo@gmail.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Theo Andersen Carton <andersen.theo@gmail.com>
Subject: [PATCH v3] drm/i915/ddi: add DDI A force 4 lanes quirk for Apple
 MacBookPro11, 5
Date: Thu, 17 Sep 2026 20:52:35 +0200
Message-ID: <20260917185235.23792-1-andersen.theo@gmail.com>
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

Tested on a MacBookPro11,5 (Haswell Crystal Well, Iris Pro 5200 +
Radeon R9 M370X): with the quirk, DDI A comes up as 4 lanes, link
training passes at link rate 270000 / lane count 4, and i915 drives the
internal panel at its native 2880x1800.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17087
Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
---
Numbering note: neither earlier posting was labelled, so to match the
numbering already used on the list this is v3. v1 [1] was pasted into a
mail client by hand, which hard-wrapped the diff and detabbed it, leaving
it unapplicable. v2 [2] was the same patch resent with git send-email,
unlabelled.

v3:
- No functional change since v2.
- Commit message: the machine is Haswell (Crystal Well), not Broadwell as
  v1/v2 claimed. The DMI match was always by model, so no code change.
- Added Closes: tag for the bug report, which carries the failing-case
  logs, the VBT dump and the EDID.

[1] https://lore.kernel.org/r/CANFnrspHiK7ii28XPdLkOMyhSZcJ9xz6CT-kNX+oiiF+8N-2Fg@mail.gmail.com
[2] https://lore.kernel.org/lkml/20260912091805.531666-1-andersen.theo@gmail.com/
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

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.55.0

