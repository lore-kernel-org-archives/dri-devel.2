Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C96CC5DF6A
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7979B10F736;
	Fri, 14 Aug 2026 21:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nIMcpQiC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7296A10F71C;
 Fri, 14 Aug 2026 21:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udeEXFg8UKEQj3amzQaX+i+qwaZZ36P41QfWyAeY4SssDrVP/FIEoVZrNtx6Ln0x5kCuQPCybF6XFqKJpYyCKZbyAoBYNyOeajZkHbZcJPW3OcXKnrUEZPgCUCg9hWrxenWHEV0TppB4A6qQAAiDswu87Xdo8ZVSEzvLPWY9P9ckgmu+QITQAIB88gw3iDLPr8hZRZKXpdr0MEll/A9RH3oVA+R6dRPcPmaOiqO8XP8IPBMAWRH7uUe3SeXDJK2iNMI+3NpSkgBODKrEUgoWxddTw6rL7RbTYHgUo5bM60UIQCXau/7WneScAhpu7xj6IesoguVd0KOVXJgSv42kIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yovNq90POqG+6FVW0cAwtKiAIE8T5iqvuKiV/zxJQk=;
 b=SyJG5mscKvMpQvRghdcNZbZIG5ETEZeQKOCdrJIFBNbQP9tiYOAAZbopNeQe3JacIdVIglsxkZvIL+u4wypAL+lcLsK9JhpQ5AslVm9biqIMsekC934YyZN8GmyUZchW5eAe6Sj/44KN5jq4TgtxFABEd+SNVtSwMbywMOteiSSRgSs2g2lS1ATZm4+j+ripJLuRBBFJ4z2uMhXnVxt8Lyq41EjTNGqWUEr02xckhsSQhL3jt6wsIFuMRvdoQ+6dyqHww5T4HJqK20UYCb9GbUWGWLLzJTlnlBzZYJEUrCbUhp5uoHniKpMqTljqkKdLIaLxudpzirei9EVNiKf6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yovNq90POqG+6FVW0cAwtKiAIE8T5iqvuKiV/zxJQk=;
 b=nIMcpQiCmVLYon1D0QajdGdvPbnAY5e14iyszIzyGmqLr+UrLiivoad/gzcbpqXZexaCpaFvh+HXS84nWEVjwzmG3aS/hRce1zrLmcxF9XCVC2JB+wtVfd6W8lH1qhlc/JbW4mt7AqrFt0qW1RgUQzTPFZyIQxs+ZppWMK9FfeU=
Received: from CH0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:610:75::13)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:18:20 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::99) by CH0PR04CA0098.outlook.office365.com
 (2603:10b6:610:75::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:19 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:19 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 02/10] drm/vkms: Fix limited-range YCbCr to RGB conversion
 scaling
Date: Fri, 14 Aug 2026 17:18:08 -0400
Message-ID: <20260814211816.1219597-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a78abc1-2c95-4d9d-46bb-08defa4990c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|11063799006|56012099006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L/Yf4fFTBTc1AFYmKIwAIljsmQhPHUZlupxIAZSLIw2LZWcRPYLgxjwhgaO84bsbz6IjWUs3xUFEA8xBwh+Bnz6Z7HXjwNfWDgOc+n037ur6/drhyh3uYenWe3dirhzSqR28dwUsQmsGnagUY0lSQSOAnqXgvpO1p49iDO0CE335ybhmax3SHh5Y6sM9ZxB30FIKFA68OOg7NQuGJI2ZTgz0sKFEpqLZZHi9ftn7CJ4Q+suCqm95yTIfu/5WSTIxxZxKVPV4KCWQi6Gm7UyHfQUOq8HHSkGxLkGbfvkfban+8PR4qPAbL/XW4nzn0/6o4OyJ24UY7H+s6ASZtQ8hQCygvAePqKbCJo0wqu4K+SqhYUrgTEEuAMa+F39sEqGE1rpl2KTzuKRGdoYW56Xzq0RioyPktYNO/WcVNG20KXoKvYUAYBLgBQ9xXdR0nGEVXc0DYF5KvI8h/GKEkx2BBPsJPr76fKmXbWkjf6I1y+i3sPDSovmtgXCigJ5bStNAmoawvRDvQ5F8J6xbkJuw67k2aqNsvquwavfcMYhLfxH+e/ozs8w2pThBDxgDV2ZBDFBHWCGlCodmRpIIjhRo6IpeEjkFUVZIv/NhB1KtUkyxV6QRL2n7hOCqw30GYBODy33yqhv02FKfQVmEt1QW9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(13003099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yoMwahL8R7G9pJaCxO+IIZg0edF7uPdM9VXFGbgk3fbkfgckUhwaG52FMt8f02Gv5ZMefxqhq5ZP30QUB6d3KIEKz0re2WC+LomuWVb01j6I4vAUs2Q8FosLtRyEKkY24h+3g7pAeNP9POIe4z/mIXe5uAfkvnz/GPlYjhyHlRipeDYGJQpNEMA+n3WlOjfEGMVX7/na+Pss1S0qQ4Xd/0qasycq1c3c9qlRhDjqisq8NVuy+btYkH4LsuivhjeaqGCjHelzTrXVfPChd/DpuJan8DCNcKPCojUuEpymKP4nB3ejlk0cEJqsMkNeqCfuzkscaRXtWPLl70AuWti0MIR83SLUj8frgvE6ymR1YmF4m6aZYHnoC/774FRdqvvAx17nM1bgcV1IVHwtEVQ6ZHjIkRxH4lMb7RXlnaJOZwdqqsD0oN4JapmVWJOhD6UI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:20.0785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a78abc1-2c95-4d9d-46bb-08defa4990c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
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

The limited-/studio-range YCbCr to RGB conversion matrices were generated
with colour.matrix_YCbCr(is_legal=True, bits=8), which normalises the
narrow range by 2^bits (256 for 8-bit) rather than by the full-range
maximum 2^bits - 1 (255). As a result the luma scale was 256/219 and the
chroma scale 256/224 instead of the correct 255/219 and 255/224.

This over-scales every limited-range conversion by a factor of 256/255,
producing an error of up to ~3/255 (8-bit) and causing IGT tests that
compare software-computed surfaces against VKMS-processed ones to fail.

Recompute the three limited-range matrices from first principles rather
than relying on colour's is_legal scaling:

 1. Start from the standard ITU-R YCbCr -> RGB relations for the luma
    weights Kr, Kb (Kg = 1 - Kr - Kb) of each encoding (BT.601, BT.709
    and BT.2020 non-constant luminance). These are the same relations
    that produce the existing full-range matrices.
 2. Expand the studio input range to full range relative to a full-range
    maximum of 2^n - 1: the luma coefficient by 255/(235 - 16) and the
    chroma coefficients by 255/(240 - 16). This matches the DRM UAPI
    definition and IGT's igt_ycbcr_to_rgb_matrix().
 3. Convert each coefficient to S31.32 fixed point (round(coeff * 2^32)).

Update the limited-range reference values in the vkms-format KUnit test
accordingly. Provide a python script to show how the kunit test value
are calculated.

Fixes: fe22d21e9342 ("drm/vkms: Add YUV support")
Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 .../gpu/drm/vkms/tests/gen_yuv_conversion.py  | 87 +++++++++++++++++++
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 38 ++++----
 drivers/gpu/drm/vkms/vkms_formats.c           | 55 ++++++++----
 3 files changed, 144 insertions(+), 36 deletions(-)
 create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py

diff --git a/drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py b/drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
new file mode 100755
index 000000000000..f4d226137cc2
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
@@ -0,0 +1,87 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+"""
+Derive the VKMS YCbCr -> RGB conversion constants and the vkms-format KUnit
+reference values.
+
+It produces:
+  1. The S31.32 fixed-point conversion matrices used in
+     drivers/gpu/drm/vkms/vkms_formats.c and asserted by
+     vkms_format_test_conversion_matrix.
+  2. The 16-bit reference YCbCr inputs for the limited-range
+     yuv_u16_to_argb_u16 round-trip cases (the values changed by the fix).
+
+Requires numpy.
+"""
+
+import numpy as np
+
+FP = 1 << 32                       # S31.32 scale: fixed = round(coeff * 2^32)
+
+# ITU-R luma weights (Kr, Kb); Kg = 1 - Kr - Kb.
+ENCODINGS = {
+    "BT601":  (0.299,  0.114),
+    "BT709":  (0.2126, 0.0722),
+    "BT2020": (0.2627, 0.0593),    # non-constant luminance
+}
+
+# 8-bit studio-range levels: luma 16..235 (range 219), chroma 16..240
+# (range 224, neutral 128); full-range maximum is 2^n - 1 = 255.
+FULL_MAX = 255
+Y_RANGE  = 235 - 16                # 219
+C_RANGE  = 240 - 16                # 224
+
+# 16-bit RGB test colors.
+COLORS = {
+    "white": (0xffff, 0xffff, 0xffff),
+    "gray":  (0x8080, 0x8080, 0x8080),
+    "black": (0x0000, 0x0000, 0x0000),
+    "red":   (0xffff, 0x0000, 0x0000),
+    "green": (0x0000, 0xffff, 0x0000),
+    "blue":  (0x0000, 0x0000, 0xffff),
+}
+
+
+def rgb_matrix(kr, kb, limited):
+    """Normalized YCbCr -> RGB (Y in [0,1], Cb/Cr in [-0.5, 0.5])."""
+    kg = 1.0 - kr - kb
+    # Standard full-range relations.
+    m = [[1.0,  0.0,                     2 * (1 - kr)],
+         [1.0, -2 * (1 - kb) * kb / kg, -2 * (1 - kr) * kr / kg],
+         [1.0,  2 * (1 - kb),            0.0]]
+    if limited:
+        # Expand studio input range to full range: luma by 255/219,
+        # chroma by 255/224 (relative to full-range maximum 2^n - 1).
+        ys, cs = FULL_MAX / Y_RANGE, FULL_MAX / C_RANGE
+        m = [[r[0] * ys, r[1] * cs, r[2] * cs] for r in m]
+    return m
+
+
+def ref_yuv(m, y_offset):
+    """16-bit YCbCr that VKMS decodes back to each RGB color.
+
+    VKMS decode: [R,G,B] = M . [Y - y_offset*257, Cb - 128*257, Cr - 128*257]
+    (8-bit offsets lifted to 16-bit by *257 = 65535/255), so invert and
+    re-add the offsets.
+    """
+    inv = np.linalg.inv(np.array(m, float))
+    off = np.array([y_offset * 257, 128 * 257, 128 * 257])
+    return {name: tuple(int(min(max(round(v), 0), 0xffff))
+                        for v in inv @ np.array(rgb, float) + off)
+            for name, rgb in COLORS.items()}
+
+print(f"== RGB REFERENCE VALUES ==")
+for name, rgb in COLORS.items():
+    print(f"    {name:6} {{ {rgb[0]:#06x}, {rgb[1]:#06x}, {rgb[2]:#06x} }}")
+print()
+
+for enc, (kr, kb) in ENCODINGS.items():
+    for limited in (False, True):
+        m = rgb_matrix(kr, kb, limited)
+        y_offset = 16 if limited else 0
+        print(f"== {enc} {'LIMITED' if limited else 'FULL'} (y_offset={y_offset}) ==")
+        for row in m:
+            print("    { " + ", ".join(str(round(v * FP)) for v in row) + " },")
+        for name, yuv in ref_yuv(m, y_offset).items():
+            print(f"    {name:6} {{ {yuv[0]:#06x}, {yuv[1]:#06x}, {yuv[2]:#06x} }}")
+        print()
diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index a7788fbc45dc..d2ae6321383b 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -54,6 +54,8 @@ struct yuv_u16_to_argb_u16_case {
  * The YUV color representation were acquired via the colour python framework.
  * Below are the function calls used for generating each case.
  *
+ * The limited-range cases are generated by gen_yuv_conversion.py.
+ *
  * For more information got to the docs:
  * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_YCbCr.html
  */
@@ -101,12 +103,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
 		.n_colors = 6,
 		.colors = {
-			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
-			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
-			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
-			{ "red",   { 0x517b, 0x5a34, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
-			{ "green", { 0x908e, 0x35cc, 0x2237 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
-			{ "blue",  { 0x28f7, 0xf000, 0x6dc9 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x51cd, 0x5a8e, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0x911e, 0x3602, 0x2259 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x2920, 0xf0f0, 0x6e37 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
 		}
 	},
 	/*
@@ -151,12 +153,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
 		.n_colors = 6,
 		.colors = {
-			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
-			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
-			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
-			{ "red",   { 0x3e8f, 0x6656, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
-			{ "green", { 0xaca1, 0x29aa, 0x1a45 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
-			{ "blue",  { 0x1fd0, 0xf000, 0x75bb }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x3ece, 0x66bc, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xad4e, 0x29d4, 0x1a5f }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1ff0, 0xf0f0, 0x7631 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
 		}
 	},
 	/*
@@ -201,12 +203,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
 		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
 		.n_colors = 6,
 		.colors = {
-			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
-			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
-			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
-			{ "red",   { 0x4988, 0x60b9, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
-			{ "green", { 0xa47b, 0x2f47, 0x1902 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
-			{ "blue",  { 0x1cfd, 0xf000, 0x76fe }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x49d2, 0x611a, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xa520, 0x2f76, 0x191b }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1d1a, 0xf0f0, 0x7775 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
 		}
 	},
 };
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index dfb8e13cba87..4d5fcaeb82c5 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -788,15 +788,36 @@ static const struct conversion_matrix yuv_bt601_full = {
 };
 
 /*
- * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
- *                                  is_legal = True,
- *                                  bits = 8) * 2**32).astype(int)
+ * BT.601 limited-/studio-range YCbCr to full-range RGB.
+ *
+ * The coefficients are derived as follows:
+ *
+ *  1. Take the standard ITU-R YCbCr -> RGB relations for luma weights
+ *     Kr, Kb (Kg = 1 - Kr - Kb), with Y in [0, 1] and Cb, Cr in
+ *     [-0.5, 0.5]. For BT.601 Kr = 0.299 and Kb = 0.114:
+ *
+ *       R = Y                                + 2 * (1 - Kr)          * Cr
+ *       G = Y - 2 * (1 - Kb) * Kb / Kg * Cb - 2 * (1 - Kr) * Kr / Kg * Cr
+ *       B = Y + 2 * (1 - Kb)          * Cb
+ *
+ *     These are exactly the yuv_bt601_full coefficients above.
+ *
+ *  2. Expand the studio input range to full range, relative to a
+ *     full-range maximum of 2^n - 1 (255 for 8-bit): the luma
+ *     coefficient is scaled by 255/(235 - 16) and the chroma
+ *     coefficients by 255/(240 - 16). This matches the DRM UAPI
+ *     definition and IGT's igt_ycbcr_to_rgb_matrix(). Note this differs
+ *     from colour.matrix_YCbCr(is_legal=True), which normalises by 2^n
+ *     and is thus off by a factor of 256/255.
+ *
+ *  3. Convert each coefficient to S31.32 fixed point, i.e.
+ *     round(coeff * 2^32).
  */
 static const struct conversion_matrix yuv_bt601_limited = {
 	.matrix = {
-		{ 5020601039, 0,           6881764740 },
-		{ 5020601039, -1689204679, -3505362278 },
-		{ 5020601039, 8697922339,  0 },
+		{ 5000989317, 0,           6854882848 },
+		{ 5000989317, -1682606224, -3491669458 },
+		{ 5000989317, 8663946082,  0 },
 	},
 	.y_offset = 16,
 };
@@ -816,15 +837,14 @@ static const struct conversion_matrix yuv_bt709_full = {
 };
 
 /*
- * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
- *                                  is_legal = True,
- *                                  bits = 8) * 2**32).astype(int)
+ * BT.709 limited-range YCbCr to full-range RGB (Kr = 0.2126, Kb = 0.0722).
+ * Derived as described for yuv_bt601_limited.
  */
 static const struct conversion_matrix yuv_bt709_limited = {
 	.matrix = {
-		{ 5020601039, 0,          7729959424 },
-		{ 5020601039, -919487572, -2297803934 },
-		{ 5020601039, 9108275786, 0 },
+		{ 5000989317, 0,          7699764272 },
+		{ 5000989317, -915895824, -2288828138 },
+		{ 5000989317, 9072696586, 0 },
 	},
 	.y_offset = 16,
 };
@@ -844,15 +864,14 @@ static const struct conversion_matrix yuv_bt2020_full = {
 };
 
 /*
- * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
- *                                  is_legal = True,
- *                                  bits = 8) * 2**32).astype(int)
+ * BT.2020 non-constant-luminance limited-range YCbCr to full-range RGB
+ * (Kr = 0.2627, Kb = 0.0593). Derived as described for yuv_bt601_limited.
  */
 static const struct conversion_matrix yuv_bt2020_limited = {
 	.matrix = {
-		{ 5020601039, 0,          7238124312 },
-		{ 5020601039, -807714626, -2804506279 },
-		{ 5020601039, 9234915964, 0 },
+		{ 5000989317, 0,          7209850391 },
+		{ 5000989317, -804559491, -2793551177 },
+		{ 5000989317, 9198842076, 0 },
 	},
 	.y_offset = 16,
 };
-- 
2.55.0

