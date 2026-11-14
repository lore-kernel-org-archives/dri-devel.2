Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8AE606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSQ1cpiE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBF210F008;
	Sat, 14 Nov 2026 16:24:54 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9091C10E73E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:09:56 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so356710266b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794618595; x=1795223395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VDpGr0Ny1586UxfYRIA6pWm7qONogFd4lJKpBO64/Wg=;
 b=rSQ1cpiEBunewvD5hwtoy1irb+Sve+rYSAWI5UT6LY17cFUOuz5WrxYFTqkIbYugg7
 2gdGuZWGIsUOqGlf4mAyEY9Ln7K6aGwXDvbU3N6pDluZa1x3Y10JYHIxRetcPW5svs9J
 sOQ3gPDWYeqAvESbCw4EpPC5pjnFAZJk8MEDLWUw+R8BL1RDSY20m1FH4jrSKcdu4NCY
 FzeIcus6R+jFGkEUst5DQYDVzsiRLuuwQ+wiPtHQ3rE3jzB+ehgI1z6AeadfSSN9zRwE
 z5Vwb5lDTTaUaTirRM4VBUw/C4FZF9tGDMzM4K5D4yLDSCXIcHF5Dq/htUyRpHniohkU
 k5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794618595; x=1795223395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VDpGr0Ny1586UxfYRIA6pWm7qONogFd4lJKpBO64/Wg=;
 b=PykQISdsAh+4qnZSJFIsDUPjuVPBwJqRYsog66ZtLg4Huiy4qdxTTl/Alquq9nsZ/l
 wLqo5gDAThmuOdF6fW+uKJGCFM+vJdfQj5g4XT4mzBJ7dHJni8dAjCfZKvKy9gnxeGTp
 EdLuGBSZbdlv8vEzY9GA8BTBd9Fa9L1hiJfLsUjBybQSit5ZkK/qc8nkuU8ZQtZtbnEu
 bCW4GVSygzDkxkSigmUNpvufyprZ+ZSCYX4UDHGSfy+1IRw/eDXD1sDvpafr3SJTSbBs
 p7/ODB9V3RQUFHAkso45vHwtJMdIxk2AGXXwLO1Z0YujwtbzYTFaZH72Pl/SAmW9iCB2
 3r6A==
X-Gm-Message-State: APuU4Z9jcPJNEkOHsoZgFrppd8OAhZGE0/ihRqXa4FerbMIrRkaBiQeJ
 T3qYdv7zCmZTiEK86LTRMGC01BbelsYKZS/keYIuJfRuygkbOknLhzoHEttWEFlJ
X-Gm-Gg: AYBFou3b0wZ4yevMLJizNe4TCSzJIg+X7jFZjcVmLsWuGy6V3HgMKcVMs4PxM+e0Hhq
 R7WZMuWjVwhsuQfkyjQUW4IswS/SK8jagioEHM6jbNpqUpc5bxI8O2HZEQKn0rXsRqq5EMHqLA3
 wIp55Fd2LXkR4h+KQWXMo5lxQnOlrQu6BjVVTUEoZ9DS/FNoTDyN/x5pK3nSU/qN5dP/Qozs3Ii
 Q77DvQT0qlHSijTgrjq+jgvBckA3gN4RyvDlsyxuZRoNxuSnFntfOkcdgVdzPsRCC4Jxzake/kZ
 PoVwWkrB//av2LnP9wZaSafy/x6kFAbnXvkPsyjNHerJSiGX13z/0RlcFJVhfIXRrXT2oQ5O19f
 lnslwk/VRSW7egTvyZaFfYU0SZJWHeAUoYcFQVqGfhIyP1bZ64sbtf2s4Z2vB1VH2Kgaa7Xivn7
 BRGwH0t26JSe7KTSdn763ngfsq0GMVfRM8oFJZDsjIcbPgs+vMw0tXvE9eZbmxK3rrgxoXyZxJK
 5vQEun1k4vPIfsUP/hxneOKuKmnpmF60lBPpatZ/3Gzxd5KKRBd8Kxo1xKWKE0xrptwcDKZlbxu
 fuElheOGzsfDWmMe9vo+iNlXS1xQpDHDRyqqExt+3awVHH/Yom5YshKrEW98KIamQ1ve+AGoHwU
 Hdh4YsbOH9Rg1IEXG8Mjhecg9
X-Received: by 2002:a17:907:72cb:b0:c42:fc8b:6c6a with SMTP id
 a640c23a62f3a-c50963841e5mr330347366b.14.1794618594704; 
 Fri, 13 Nov 2026 17:09:54 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b71608sm156983166b.64.2026.11.13.17.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:09:54 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com,
 ville.syrjala@linux.intel.com, j@metarealtyinc.ca,
 litaliano00.contact@gmail.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 linux-kernel@vger.kernel.org, ElXreno <elxreno@gmail.com>
Subject: [PATCH] drm/edid: Read the monitor range from the DisplayID
 Adaptive-Sync block
Date: Sat, 14 Nov 2026 04:07:49 +0300
Message-ID: <20261114010749.1949247-1-elxreno@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A DisplayID 2.x Adaptive-Sync data block (tag 0x2b) lists the refresh
rate ranges a display supports with an adaptive vertical total. Some
panels advertise their variable refresh range only there, and some
keep a narrower one in the base block range limits. The BOE
NE180QA1-MM1 is of the second kind: the range limits descriptor says
48-120 Hz, the Adaptive-Sync block has three descriptors,

 27 00 30 ef 00 00
 27 00 30 77 00 00
 27 00 30 3b 00 00

for 48-240, 48-120 and 48-60 Hz. A driver that checks a mode against
monitor_range then refuses VRR for the 240 Hz timing of that panel.

Use the block in both cases. Without a range from the base block take
the range from the descriptors. With one, keep its minimum and only
raise the maximum, and only from descriptors that reach down into it,
so that the result never goes below what the base block promises.

monitor_range stays one range per connector. Only descriptors for the
native panel range that declare the adaptive vertical total operation
mode count: a descriptor for fixed average vertical total alone does
not describe a range to pick a vertical total from. Where several
count, the highest minimum and the highest maximum are used. Without
a base range every rate in the result is then within the descriptor
that reaches highest. With one, every rate is within the base range
or within that descriptor, which overlaps it.

The layout is taken from edid-decode (parse_displayid_adaptive_sync()
in utils/edid-decode/parse-displayid-block.cpp of v4l-utils), not
from the DisplayID text: a descriptor is 6 bytes plus the count in
bits 6:4 of the block revision, byte 0 has the native panel range
flag in bit 0 and the operation mode in bits 3:2 (1 for fixed average
and adaptive vertical total), byte 2 is the minimum refresh rate,
bytes 3-4 hold the maximum refresh rate minus one in ten bits. The
block is read from any section of structure version 2.0 or later,
which is what the panel above declares.

This reaches every driver that reads monitor_range. A display with
such a block and no base block range now has a range where it had
none, which is the point for i915 and xe (their other VRR conditions
still apply). amdgpu scans DisplayID tag 0x25 on its own when the
minimum or the maximum is zero, and with a range from the
Adaptive-Sync block that scan is no longer reached. When the display
has no AMD VSDB, amdgpu takes monitor_range as its refresh rate
range, so it follows the raised maximum, and a DP or eDP display that
has only the Adaptive-Sync block can now pass its FreeSync test (a
range wider than 10 Hz and a sink that ignores the MSA timing). With
a VSDB that advertises FreeSync the range still comes from there.

Signed-off-by: ElXreno <elxreno@gmail.com>
---

Two parsers for this area were posted this spring, both as a fallback
for panels with no range in the base block: Adriano Vero's for tag
0x25, v1 in [1] and a v2 on April 1 after Jani's review, and Jake S's
for tags 0x2b and 0x25 [2]. Asked by Ville why he had posted a
different version, Jake offered to fold the 0x2b part into Adriano's
series [3]. I found no later posting of either, and the DRM core in
drm-tip parses neither tag. This one covers the case where the base
block has a range that is narrower than the Adaptive-Sync one, looks
at the native range flag and the operation mode of the descriptors,
and leaves tag 0x25 alone. I am happy to rebase onto either of them
instead.

The i915 series that needs it for a 3840x2400@240 panel is "drm/i915:
VRR with the pipe joiner" on intel-gfx.

Tested on the BOE NE180QA1-MM1 only: monitor_range goes from 48-120
to 48-240. No KUnit case comes with it.

On tooling, per Documentation/process/generated-content.rst: written
with an LLM coding assistant (Claude Code), which also decoded the
panel's EDID against edid-decode. I have reviewed all of it and take
responsibility for the result.

[1] https://lore.kernel.org/r/20260328132027.22383-1-litaliano00.contact@gmail.com
[2] https://lore.kernel.org/r/20260415130626.10523-2-j@metarealtyinc.ca
[3] https://lore.kernel.org/r/69dfe22d.050a0220.60470.81b5@mx.google.com

 drivers/gpu/drm/drm_displayid_internal.h | 17 ++++++
 drivers/gpu/drm/drm_edid.c               | 68 ++++++++++++++++++++++++
 include/drm/drm_connector.h              | 10 ++--
 3 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index ef7e6c9bd4db..6ea1c45c04b6 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -67,6 +67,7 @@ struct drm_edid;
 #define DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY	0x28
 #define DATA_BLOCK_2_CONTAINER_ID		0x29
 #define DATA_BLOCK_2_TYPE_10_FORMULA_TIMING	0x2a
+#define DATA_BLOCK_2_ADAPTIVE_SYNC		0x2b
 #define DATA_BLOCK_2_VENDOR_SPECIFIC		0x7e
 #define DATA_BLOCK_2_CTA_DISPLAY_ID		0x81
 
@@ -142,6 +143,22 @@ struct displayid_formula_timing_block {
 	struct displayid_formula_timings_9 timings[];
 } __packed;
 
+/* Bits 6:4 of the block revision: descriptor bytes beyond the base six */
+#define DISPLAYID_ADAPTIVE_SYNC_DESC_EXTRA	GENMASK(6, 4)
+
+#define DISPLAYID_ADAPTIVE_SYNC_NATIVE_RANGE	BIT(0)
+#define DISPLAYID_ADAPTIVE_SYNC_MODE		GENMASK(3, 2)
+#define DISPLAYID_ADAPTIVE_SYNC_MODE_FAVT_AVT	1
+#define DISPLAYID_ADAPTIVE_SYNC_MAX_REFRESH	GENMASK(9, 0)
+
+struct displayid_adaptive_sync_descriptor {
+	u8 flags;
+	u8 max_duration_increase;
+	u8 min_refresh;
+	__le16 max_refresh;	/* [9:0] refresh rate - 1 */
+	u8 max_duration_decrease;
+} __packed;
+
 #define DISPLAYID_DEVICE_TECH_UNSPECIFIED	0
 #define DISPLAYID_DEVICE_TECH_LCD		1
 #define DISPLAYID_DEVICE_TECH_OLED		2
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index b8f882a17c8f..4307a4bc5899 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6916,9 +6916,71 @@ drm_displayid_parse_display_params(struct drm_connector *connector,
 	}
 }
 
+/*
+ * Collect the refresh rate range of the Adaptive-Sync descriptors that
+ * are for the native panel range and allow an adaptive vertical total.
+ */
+static void drm_displayid_parse_adaptive_sync(struct drm_connector *connector,
+					      const struct displayid_block *block,
+					      struct drm_monitor_range_info *as_range)
+{
+	const struct drm_monitor_range_info *range = &connector->display_info.monitor_range;
+	int size = sizeof(struct displayid_adaptive_sync_descriptor) +
+		FIELD_GET(DISPLAYID_ADAPTIVE_SYNC_DESC_EXTRA, block->rev);
+	const u8 *data = (const u8 *)(block + 1);
+	int i;
+
+	for (i = 0; i + size <= block->num_bytes; i += size) {
+		const struct displayid_adaptive_sync_descriptor *desc =
+			(const struct displayid_adaptive_sync_descriptor *)&data[i];
+		u16 min_vfreq = desc->min_refresh;
+		u16 max_vfreq = FIELD_GET(DISPLAYID_ADAPTIVE_SYNC_MAX_REFRESH,
+					  le16_to_cpu(desc->max_refresh)) + 1;
+
+		if (!(desc->flags & DISPLAYID_ADAPTIVE_SYNC_NATIVE_RANGE) ||
+		    FIELD_GET(DISPLAYID_ADAPTIVE_SYNC_MODE, desc->flags) !=
+		    DISPLAYID_ADAPTIVE_SYNC_MODE_FAVT_AVT)
+			continue;
+
+		if (!min_vfreq || min_vfreq >= max_vfreq)
+			continue;
+
+		/* Only extend a base block range the descriptor reaches down into */
+		if (range->max_vfreq && min_vfreq > range->max_vfreq)
+			continue;
+
+		as_range->min_vfreq = max(as_range->min_vfreq, min_vfreq);
+		as_range->max_vfreq = max(as_range->max_vfreq, max_vfreq);
+	}
+}
+
+/*
+ * Use the Adaptive-Sync range when the base block has no range limits,
+ * and to raise their maximum when it has: a panel may keep the base block
+ * range at what it does without Adaptive-Sync.
+ */
+static void drm_displayid_update_monitor_range(struct drm_connector *connector,
+					       const struct drm_monitor_range_info *as_range)
+{
+	struct drm_monitor_range_info *range = &connector->display_info.monitor_range;
+
+	if (as_range->max_vfreq <= range->max_vfreq)
+		return;
+
+	if (!range->min_vfreq)
+		range->min_vfreq = as_range->min_vfreq;
+	range->max_vfreq = as_range->max_vfreq;
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] Adaptive-Sync refresh rate range is %d Hz - %d Hz\n",
+		    connector->base.id, connector->name,
+		    range->min_vfreq, range->max_vfreq);
+}
+
 static void update_displayid_info(struct drm_connector *connector,
 				  const struct drm_edid *drm_edid)
 {
+	struct drm_monitor_range_info as_range = {};
 	const struct displayid_block *block;
 	struct displayid_iter iter;
 	bool base_section_header_processed = false;
@@ -6933,8 +6995,14 @@ static void update_displayid_info(struct drm_connector *connector,
 		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
 		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS)
 			drm_displayid_parse_display_params(connector, block);
+
+		if (displayid_version(&iter) >= DISPLAY_ID_STRUCTURE_VER_20 &&
+		    block->tag == DATA_BLOCK_2_ADAPTIVE_SYNC)
+			drm_displayid_parse_adaptive_sync(connector, block, &as_range);
 	}
 	displayid_iter_end(&iter);
+
+	drm_displayid_update_monitor_range(connector, &as_range);
 }
 
 static void update_display_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f656ed8324d3..8fd484d36671 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -456,12 +456,15 @@ drm_hdmi_connector_get_broadcast_rgb_name(enum drm_hdmi_broadcast_rgb broadcast_
  * &drm_display_info
  *
  * This struct is used to store a frequency range supported by panel
- * as parsed from EDID's detailed monitor range descriptor block.
+ * as parsed from EDID's detailed monitor range descriptor block and
+ * from the DisplayID Adaptive-Sync data block.
  *
  * @min_vfreq: This is the min supported refresh rate in Hz from
- *             EDID's detailed monitor range.
+ *             EDID's detailed monitor range, or from the Adaptive-Sync
+ *             data block when there is no such range.
  * @max_vfreq: This is the max supported refresh rate in Hz from
- *             EDID's detailed monitor range
+ *             EDID's detailed monitor range or the Adaptive-Sync data
+ *             block, whichever is higher.
  */
 struct drm_monitor_range_info {
 	u16 min_vfreq;
@@ -1002,6 +1005,7 @@ struct drm_display_info {
 
 	/**
 	 * @monitor_range: Frequency range supported by monitor range descriptor
+	 * and the DisplayID Adaptive-Sync data block
 	 */
 	struct drm_monitor_range_info monitor_range;
 

base-commit: f40cc5e715fe9e7a5e61f7cd44f63f68c1625f2c
-- 
2.56.0

