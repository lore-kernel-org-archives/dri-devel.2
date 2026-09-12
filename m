Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CEDC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34FC10E9CE;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNewl2Xa";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02CA10E69D
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 09:00:08 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9c60b9so50474866b.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 02:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789203607; cv=none;
 d=google.com; s=arc-20260327;
 b=Z1icSX4N0bdFR65TC0WwCN5qvhIhEo7vdx39Csz0jabQoZH2/hGdNJ+cH/RT+Zkwnb
 sPwTgN5p7uArc6xszKnhsKsa7vkuaJWd2mb3fIdxlgcV5cW47v2bPuVMMWxep5yZ50t/
 xCt94o9Qd+f8Z5VUOE/9+V6bFkd92mCvlka7RUFAq7t2EurFpjEjmDVaQJe9GPoEvlya
 ETm8l7i5fwgw5yhGrWWALz76++MCBl7zbswXWPTfVOZgqZP+AZTyzsDwym6ncfLkuCbd
 jKErVjQVlKQm75JhLroJEaM4e8CSDyoSSHjCZWdEl1yRhyRNsmeb/Ukq4waxxyZyJIRa
 0EFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=WCT0+gv9JmQdBqllyCgHijfl0um7k0RWeP6aTzXVQp0=;
 fh=Itai9nu6IrQXUrl4hOd0wJUtKmd2jlQVDntmy/Egwvk=;
 b=AWEfJsFFYg5QwUO1SWEDUyHYt27DYNzBkUiPnxFGpF6GVqi9DBea8f5OJTpI7ZT5J8
 s4fIJxGTEYBsxIiqZiuP0cQwQ9J0/FlaKCEADXloepYyma4liVsSP/ghBYgKV2irWC34
 i9DDqSbJjn8rc1Cl34hulnXZSsaUbnd3xEetTiWlD3nQYQfs46FDLMBB2NH8JmjxdcI4
 LOIe/AJDmvpbk+p3WtsVHTNplfM2wlt4e8WF936dev6cTidB2dWvOTD6k0/GRsGKTrbm
 fafcxVJIeSAx5uVBf2CMfsOLpOjxPEyKdkLZ97qaX0SobmOfmQ+7h6zUlDZsbJt+GCiW
 joUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789203607; x=1789808407; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WCT0+gv9JmQdBqllyCgHijfl0um7k0RWeP6aTzXVQp0=;
 b=gNewl2Xae+d5lLP4h6l2fCqVGhUF9dz91Wqv/E/Ue7lQpTvwarDhnn46i0kHy7kKSD
 RlCsAVeqjQhx0xmc5e5DLOPZ9ttrCOs8KC7fIb1sVRln6ZYYhTMhyKz0Yr/7KszBlYij
 v9JcqFdBl1L6PbNTprpzBX9BBhsls5DsODnqxCGOcfpCx3u3BksMY69aq4h1te4ENELj
 94T0GsRJ5pR0jUvgCrXxa6lZj1FnXoxut2L5aV+fDrmHPnEQfAZvRL+kbQhLQFGaZVIG
 UZjGpclfzOyPT2WVvhvqtg3vOjZUy8EVukRa0nZlenai6EDlH10vta96khSStA186ohK
 lsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789203607; x=1789808407;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WCT0+gv9JmQdBqllyCgHijfl0um7k0RWeP6aTzXVQp0=;
 b=OhBJKNql+KbjzQ+7hy0z9ariYbs2pOX0AYVRV+JWDJnldU5vFmKd6vPVOzBc1Kup0R
 kURVKC7fik3nwv2LBYTdM7LKVc6EyQc3f/gQs8fwdgB99sonp2fD02goLSIDbLtH4PwL
 dtqj9DnaDJ9p65bKvfb0zZJ2/GW28nqZjWG6vI122x8CkSANClpPTNvWtk3DFdIpGf1G
 hPuerOYoKISpBopQm7xTCgUmppCgkP46JqaZBJfmttl8PGVRRj6OLEDF32GOkFiWL0Is
 qnLAkaO2wELfbSlFFQIyeFiqpVgrUCaqJxjGib2k3ajnUHpBhabO2UfUuaSiFBzmc9Qt
 KT3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3ymrt40dUGLg5sEehESGCDFsYgFcRL6ihZLKdyTdSfZvlCtTx4uv3x7oxeUx81ooi1vVycjFVF/E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mHDW2cOHYTmSBve1F7jTBh1mXuCEvkM2ntXCCFniWBfr5VRq8j
 AYRi5qHceyfdAFAOlsFahsWikr2LUvx4Ic3Pxay1kxIjznmhAfvzqFnfEsc8ROF3gJNnSiY2IpV
 us0YcZYl6cRu9cxg31f6oIRNJTYmhbR4=
X-Gm-Gg: AYBFou1xPvM1p7encaTTvPOY0oaNjqXLyRTsot/TPtIPHFveJFN455jm6bneM7tX++z
 cZqmqZ/5Q6ont2pS4FfABi94wIsf89U7xwxVIhnuAr16lcqM+xS5CXEZZR2CNGJaS8OLTotpgdi
 TufoYXXGApsRhFsDa2ibsGLiYahEB2zL4Ti9n9d/Skrg7GNB14Nt1aju0loseXE5ncJAb66tLM+
 KYFCtC6Lv+ZTYhLwLW5us9UMu0gpsHDl/zgc9UeZJYUEcEQdJusAoNQDE1npFlI0rG6WtfnBXKg
 0RsMScjSPgySGhOevbwBtUB1cTDsHDr8TvBRy27sYNXM1OJhKRbydA==
X-Received: by 2002:a17:907:3f20:b0:c29:58ae:8327 with SMTP id
 a640c23a62f3a-c2962c8a439mr511541966b.19.1789203606684; Sat, 12 Sep 2026
 02:00:06 -0700 (PDT)
MIME-Version: 1.0
From: Theo Andersen Carton <andersen.theo@gmail.com>
Date: Sat, 12 Sep 2026 10:59:55 +0200
X-Gm-Features: AcwNN1XIwcl6bWbN5jv4kI4IsYuPAdJ2UAe5lOJ64SbegT19zk8Ge8XZXviCxbs
Message-ID: <CANFnrspHiK7ii28XPdLkOMyhSZcJ9xz6CT-kNX+oiiF+8N-2Fg@mail.gmail.com>
Subject: [PATCH] drm/i915/ddi: add DDI A force 4 lanes quirk for Apple
 MacBookPro11, 5
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com, 
 simona@ffwll.ch, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On dual-GPU Retina MacBooks (mid 2015 fx) the internal panel is muxed
to the discrete
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

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c
b/drivers/gpu/drm/i915/display/intel_ddi.c
index 02a53c9848e1..f746287830b3 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4976,6 +4976,13 @@ static bool intel_ddi_a_force_4_lanes(struct
intel_digital_port *dig_port)
  if (display->platform.geminilake || display->platform.broxton)
  return true;

+ /*
+ * Machines whose firmware leaves eDP dark on the Intel side never set
+ * the bit, so trust the quirk rather than the register.
+ */
+ if (intel_has_quirk(display, QUIRK_DDI_A_FORCE_4_LANES))
+ return true;
+
  return false;
 }

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d5..feb28956a013 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -100,6 +100,20 @@ static void quirk_disable_psr2(struct
intel_display *display)
  drm_info(display->drm, "PSR2 support not currently available for
this setup, applying disable PSR2 quirk\n");
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
+ intel_set_quirk(display, QUIRK_DDI_A_FORCE_4_LANES);
+ drm_info(display->drm, "Applying DDI A force 4 lanes quirk\n");
+}
+
 struct intel_quirk {
  int device;
  int subsystem_vendor;
@@ -142,6 +156,13 @@ static int intel_dmi_no_pps_backlight(const
struct dmi_system_id *id)
  return 1;
 }

+static int intel_dmi_ddi_a_force_4_lanes(const struct dmi_system_id *id)
+{
+ DRM_INFO("DDI A is 4 lanes despite firmware on %s\n", id->ident);
+
+ return 1;
+}
+
 static const struct intel_dmi_quirk intel_dmi_quirks[] = {
  {
  .dmi_id_list = &(const struct dmi_system_id[]) {
@@ -188,6 +209,19 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
  },
  .hook = quirk_no_pps_backlight_power_hook,
  },
+ {
+ .dmi_id_list = &(const struct dmi_system_id[]) {
+ {
+ .callback = intel_dmi_ddi_a_force_4_lanes,
+ .ident = "Apple MacBookPro11,5",
+ .matches = {DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+    DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,5"),
+ },
+ },
+ { }
+ },
+ .hook = quirk_ddi_a_force_4_lanes,
+ },
 };

 static struct intel_quirk intel_quirks[] = {
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h
b/drivers/gpu/drm/i915/display/intel_quirks.h
index 970a4fe52faf..d2b8e9183c62 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -23,6 +23,7 @@ enum intel_quirk_id {
  QUIRK_EDP_LIMIT_RATE_HBR2,
  QUIRK_DISABLE_EDP_PANEL_REPLAY,
  QUIRK_DISABLE_PSR2,
+ QUIRK_DDI_A_FORCE_4_LANES,
 };

 void intel_init_quirks(struct intel_display *display);
--
2.55.0
