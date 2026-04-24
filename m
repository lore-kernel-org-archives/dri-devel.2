Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC27FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C7310F6E2;
	Fri, 24 Apr 2026 22:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wR8qB00A";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C8F10F6DE;
 Fri, 24 Apr 2026 22:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nr0AXiRr/2lfjGUoCTQzD/Ie7h7yzNgLHczBKDrSeSSmDuA7MLHvJ7beSRSNG0jcTAc6FULsT42RgMuVWVu4CrJcOWMpYksGfPJwJue7GKnGg/SLIXbRmHvzdZFphzr87DjN4C8U5KUFoU8kmD1byxirGxd0n3cBNR/NdMO2BBeWwtvVgVF3wruVav2WXHi2DMmHOQ0/tGEpNqkdGkFp2MAeTItUlHru8Zwy5pAtv7fS1HQtu308JujMhGs8Hd/X0ehwVr8quXD6OUtkRegpOAW7WSpIjgSAmKUAR72J/CwCN1pX+JFghFl3RADSfds6ccyE+gmZer33yT80TmZB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaatD0hhAl1jTCJMwjTexp5WaNCYfZle8a6aEZ1PJ/k=;
 b=JkGuh7XnIo9wisD78MIDyYbD6KnLWm2zWpbyckok6k04VIiLph//PWrNt6un8rnKUN+hAgOVqeFf+3kfalcZEbosZNGEoBfNZZ0+rnatfXgi2dUN7iv/2Nj3OEEUkg0wgED1J1MSaMakbv5eIqkCwoqFWlxzBgcSkM+LdlDo0oJ+lucX+RBnb/bWUHInj7z+rp/TrII2h6m6ZMj2k2jjyd2HpQ9U/erUG0df++3HTczrQo+idVd8DOUGrJnM0gokgPfBCAFTHnv5KNfpydvKts7oMFnVJUd2+gTbAnl2r4Jruom5WeEed08A5JiNQPiDX2eBf9/8pRmwDOkInUNqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaatD0hhAl1jTCJMwjTexp5WaNCYfZle8a6aEZ1PJ/k=;
 b=wR8qB00Ag5P+naTRc+A+sijRHCx3Xnv7TEWMiMDfAlr2OFUoSknRFKtwxOGxYr0XZ2PvPDOGyJZSTGShYk1TzJ41kj66Du2LYfvdTRwk4Ptkm3aBh0gIcXf++03i5u9sfLtzzNl2+bXkSa9tp1yyTrLUOGmWcu/P7gQ3OdPJZDc=
Received: from CY5PR19CA0001.namprd19.prod.outlook.com (2603:10b6:930:15::15)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 22:10:33 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:930:15:cafe::54) by CY5PR19CA0001.outlook.office365.com
 (2603:10b6:930:15::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:32 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:31 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] IGT: Add a luminance test
Date: Fri, 24 Apr 2026 17:10:19 -0500
Message-ID: <20260424221021.167179-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 959d6ab4-0eea-4ae1-fff7-08dea24e4d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|18096099003|11006099003;
X-Microsoft-Antispam-Message-Info: pPJ3FwMvRasF9Hmk3G9kWJ48wA+yC9VnU/rU8jTVwg9S4EMJ1C4bnKcooxD8EMD0Zy6g9e3toU2O4XUZY8hJKi9+sQMKZJO+6mpHf+qyAOZ+nRMATgVys806dHkstePAaJFIwVSHVtJ13OZ0QCjCVtJ1p6LyUpLMwJukNK4AHnLUxDpcqfSZVqD8scH9ish0kppjx7EQsezP8Z9/pQznwimG2sL2mmwJtR3oDlg7k9lHhTge++tB4ZSxM9BAI5nOclHul67O60unL8Xu++bOvyomyoCmSXIyWgpBi6+w1auEk1sWu6qQPG/Xn5HWkx2WFVJia90InP8Vj5+Ub7wNi4RrobOaL0puTtRHkU8dVpKVNqUBwh+lnYnrrSLQCa1SrekeFAEzkuqHwMWClLWPbxb4V2iwCtwSTsIomW1QKzZtgN2Kh39c3/xM+0E28Aidjd/MztcuekdA+oNLLp957zSCi9ga6eB1k5cm3CQ4BeDDc18FejIJATPAIATyVhJ2+A+f1pj+xzQIOT4Gw1nHsNak7itf5y9egnr3o8vkv31w5bY9TaB6DKVEYwYMYup1RT8MQT9TfNeDSV3LOc3rhTzQGySAXqrWma2D62vltPzxMwn8/biATriVJhWJQtv7vhLjI8ntpT+zyjoOr8cqancg8Y1ssve5oZmHl88yOo2krrxBTL7fUNubH0wr4RpjtseDsCTQjIbGsKkbjy/eVFxR/A6xnS7EypkalGv9cgOjE8s7m4J36ct+Akoljn625lug+PL+UVO/7xe1z7krVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(18096099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p0jbodQUBf9jIeYabikzOT3mOSPIKCbrtEkne0kE7xLuhWapjnOqwzmiXOnKas4rh4Wq2SGkSg0R8KYVHDPNjow46mRs/4B+Xk/g84bpsNG8g2wemgoDD7uDh6JdSc8vESTwx6gWkmY16nNFx9wrfv3Y3OxuI+5UOjTugudCitN78WxuMObjAPb4WJoIOFQ2cKXc5EG6SYP4p1QQgBR8XoJQYR7UGP+R2I2VPYG5M6abaxeAp/0JOHjjW6s1wDfqPXcS6d00+7+TUvBOtRIThMQDqjG/8HaQSNznV+M4YpAvyyypsjFzDZUCSOett/jNIZdyE/ES7Zdkdj929Ln86mSXur0rX5YdDBGPILkKpT9TKqsmpuY69dUelOPPjoy0OQIbyq+R69CL8ylgQ0vgGaWixUKtBKLp2XP6Cb06hwzuOsYC5UgMEcawV/ATV4xf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:32.2607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959d6ab4-0eea-4ae1-fff7-08dea24e4d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051
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

From: Mario Limonciello (AMD) <superm1@kernel.org>

This will make sure that luminance can be changed from DRM master
and that it stays in sync with sysfs.

Assisted-by: Claude Sonnet
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 tests/kms_luminance.c | 393 ++++++++++++++++++++++++++++++++++++++++++
 tests/meson.build     |   1 +
 2 files changed, 394 insertions(+)
 create mode 100644 tests/kms_luminance.c

diff --git a/tests/kms_luminance.c b/tests/kms_luminance.c
new file mode 100644
index 000000000..9e4499eac
--- /dev/null
+++ b/tests/kms_luminance.c
@@ -0,0 +1,393 @@
+/*
+ * Copyright © 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+/**
+ * TEST: kms luminance
+ * Category: Display
+ * Description: Test LUMINANCE connector property and backlight synchronization
+ * Driver requirement: any
+ * Mega feature: General Display Features
+ */
+
+#include "igt.h"
+#include <dirent.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#define BACKLIGHT_PATH "/sys/class/backlight"
+
+/**
+ * SUBTEST: luminance-basic
+ * Description: Verify LUMINANCE property exists and has correct range
+ */
+
+/**
+ * SUBTEST: luminance-dpms-coordination
+ * Description: Verify LUMINANCE is forced to 0 when DPMS is off
+ */
+
+/**
+ * SUBTEST: luminance-sysfs-to-drm
+ * Description: Test sysfs brightness changes synchronize to DRM LUMINANCE property
+ */
+
+/**
+ * SUBTEST: luminance-drm-to-sysfs
+ * Description: Test DRM LUMINANCE property changes synchronize to sysfs brightness
+ */
+
+typedef struct {
+	int drm_fd;
+	igt_display_t display;
+	igt_output_t *output;
+	char backlight_path[256];
+	int max_brightness;
+} data_t;
+
+static bool find_backlight_for_connector(igt_output_t *output, char *path, size_t path_len)
+{
+	char link_path[512];
+	char backlight_name[256];
+	ssize_t len;
+	DIR *dir;
+	struct dirent *entry;
+	char *slash;
+
+	/* Try to find backlight linked to this connector via sysfs */
+	snprintf(link_path, sizeof(link_path),
+		 "/sys/class/drm/card%d-%s/backlight",
+		 output->display->drm_fd,
+		 igt_output_name(output));
+
+	len = readlink(link_path, backlight_name, sizeof(backlight_name) - 1);
+	if (len > 0) {
+		backlight_name[len] = '\0';
+		/* Extract just the backlight device name */
+		slash = strrchr(backlight_name, '/');
+		if (slash)
+			snprintf(path, path_len, "%s/%s", BACKLIGHT_PATH, slash + 1);
+		else
+			snprintf(path, path_len, "%s/%s", BACKLIGHT_PATH, backlight_name);
+		return true;
+	}
+
+	/* Fallback: look for any backlight device (common case: single panel) */
+	dir = opendir(BACKLIGHT_PATH);
+
+	if (!dir)
+		return false;
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_name[0] == '.')
+			continue;
+
+		snprintf(path, path_len, "%s/%s", BACKLIGHT_PATH, entry->d_name);
+		closedir(dir);
+		return true;
+	}
+
+	closedir(dir);
+	return false;
+}
+
+static int read_sysfs_int(const char *path)
+{
+	FILE *f;
+	int value = -1;
+
+	f = fopen(path, "r");
+	if (!f)
+		return -1;
+
+	if (fscanf(f, "%d", &value) != 1)
+		value = -1;
+
+	fclose(f);
+	return value;
+}
+
+static bool write_sysfs_int(const char *path, int value)
+{
+	FILE *f;
+
+	f = fopen(path, "w");
+	if (!f)
+		return false;
+
+	fprintf(f, "%d\n", value);
+	fclose(f);
+	return true;
+}
+
+static void require_luminance_support(data_t *data)
+{
+	uint64_t value;
+
+	igt_require(igt_has_drm_cap(data->drm_fd, DRM_CLIENT_CAP_ATOMIC));
+	igt_require(drmSetClientCap(data->drm_fd, DRM_CLIENT_CAP_ATOMIC, 1) == 0);
+
+	/* Check if LUMINANCE capability is supported */
+	igt_require(drmSetClientCap(data->drm_fd, 8 /* DRM_CLIENT_CAP_LUMINANCE */, 1) == 0);
+
+	/* Find eDP output with LUMINANCE property */
+	for_each_connected_output(&data->display, data->output) {
+		if (data->output->config.connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+			if (kmstest_get_property(data->drm_fd,
+						 data->output->config.connector->connector_id,
+						 DRM_MODE_OBJECT_CONNECTOR,
+						 "LUMINANCE",
+						 NULL, &value, NULL)) {
+				/* Found eDP with LUMINANCE */
+				igt_require(find_backlight_for_connector(data->output,
+									  data->backlight_path,
+									  sizeof(data->backlight_path)));
+				return;
+			}
+		}
+	}
+
+	igt_skip("No eDP connector with LUMINANCE property found\n");
+}
+
+static void test_luminance_basic(data_t *data)
+{
+	uint32_t prop_id;
+	uint64_t value, range_min, range_max;
+	bool is_atomic;
+	drmModePropertyPtr prop;
+
+	igt_info("Testing LUMINANCE property on %s\n", igt_output_name(data->output));
+
+	igt_assert(kmstest_get_property(data->drm_fd,
+					data->output->config.connector->connector_id,
+					DRM_MODE_OBJECT_CONNECTOR,
+					"LUMINANCE",
+					&prop_id, &value, NULL));
+
+	/* Verify property is atomic */
+	prop = drmModeGetProperty(data->drm_fd, prop_id);
+	igt_assert(prop);
+	is_atomic = !!(prop->flags & DRM_MODE_PROP_ATOMIC);
+	igt_assert_f(is_atomic, "LUMINANCE property must be atomic\n");
+
+	/* Verify range is [0, 65535] */
+	igt_assert_f(prop->count_values == 2, "LUMINANCE must be a range property\n");
+	range_min = prop->values[0];
+	range_max = prop->values[1];
+	igt_assert_f(range_min == 0, "LUMINANCE min must be 0, got %lu\n", range_min);
+	igt_assert_f(range_max == 65535, "LUMINANCE max must be 65535, got %lu\n", range_max);
+
+	igt_info("LUMINANCE property: id=%u, value=%lu, range=[%lu, %lu]\n",
+		 prop_id, value, range_min, range_max);
+
+	drmModeFreeProperty(prop);
+}
+
+static void test_luminance_sysfs_to_drm(data_t *data)
+{
+	char brightness_path[512];
+	char max_brightness_path[512];
+	int original_brightness, new_brightness, max_brightness;
+	uint64_t original_luminance, new_luminance, expected_luminance;
+
+	snprintf(brightness_path, sizeof(brightness_path), "%s/brightness", data->backlight_path);
+	snprintf(max_brightness_path, sizeof(max_brightness_path), "%s/max_brightness", data->backlight_path);
+
+	max_brightness = read_sysfs_int(max_brightness_path);
+	igt_assert_f(max_brightness > 0, "Failed to read max_brightness\n");
+
+	/* Read original values */
+	original_brightness = read_sysfs_int(brightness_path);
+	igt_assert_f(original_brightness >= 0, "Failed to read brightness\n");
+
+	kmstest_get_property(data->drm_fd,
+			     data->output->config.connector->connector_id,
+			     DRM_MODE_OBJECT_CONNECTOR,
+			     "LUMINANCE",
+			     NULL, &original_luminance, NULL);
+
+	igt_info("Initial: sysfs=%d/%d, LUMINANCE=%lu\n",
+		 original_brightness, max_brightness, original_luminance);
+
+	/* Test multiple values: min, 25%, 50%, 75%, max */
+	int test_values[] = {0, max_brightness / 4, max_brightness / 2,
+			     max_brightness * 3 / 4, max_brightness};
+
+	for (int i = 0; i < 5; i++) {
+		new_brightness = test_values[i];
+		igt_assert(write_sysfs_int(brightness_path, new_brightness));
+
+		/* Give kernel time to propagate notification */
+		usleep(300000); /* 300ms */
+
+		/* Read back DRM property */
+		kmstest_get_property(data->drm_fd,
+				     data->output->config.connector->connector_id,
+				     DRM_MODE_OBJECT_CONNECTOR,
+				     "LUMINANCE",
+				     NULL, &new_luminance, NULL);
+
+		/* Calculate expected LUMINANCE value using kernel's formula:
+		 * set = (v * U16_MAX) / max
+		 */
+		expected_luminance = ((uint64_t)new_brightness * 65535) / max_brightness;
+
+		igt_info("Test %d: sysfs=%d, LUMINANCE=%lu (expected %lu)\n",
+			 i, new_brightness, new_luminance, expected_luminance);
+
+		/* Allow for small rounding differences - at most 2 to catch formula bugs */
+		igt_assert_f(abs((int)(new_luminance - expected_luminance)) <= 2,
+			     "LUMINANCE not synchronized: expected %lu, got %lu (diff: %d)\n",
+			     expected_luminance, new_luminance, abs((int)(new_luminance - expected_luminance)));
+	}
+
+	/* Restore original brightness */
+	write_sysfs_int(brightness_path, original_brightness);
+	usleep(100000);
+}
+
+static void test_luminance_drm_to_sysfs(data_t *data)
+{
+	char brightness_path[512];
+	char max_brightness_path[512];
+	int original_brightness, new_brightness, max_brightness, expected_brightness;
+	uint64_t original_luminance, new_luminance, luminance_max;
+	drmModeAtomicReqPtr req;
+	drmModePropertyPtr prop;
+	uint32_t prop_id;
+	int ret;
+
+	snprintf(brightness_path, sizeof(brightness_path), "%s/brightness", data->backlight_path);
+	snprintf(max_brightness_path, sizeof(max_brightness_path), "%s/max_brightness", data->backlight_path);
+
+	max_brightness = read_sysfs_int(max_brightness_path);
+	igt_assert_f(max_brightness > 0, "Failed to read max_brightness\n");
+
+	/* Read original values */
+	original_brightness = read_sysfs_int(brightness_path);
+	igt_assert_f(original_brightness >= 0, "Failed to read brightness\n");
+
+	kmstest_get_property(data->drm_fd,
+			     data->output->config.connector->connector_id,
+			     DRM_MODE_OBJECT_CONNECTOR,
+			     "LUMINANCE",
+			     &prop_id, &original_luminance, NULL);
+
+	/* Get LUMINANCE property range */
+	prop = drmModeGetProperty(data->drm_fd, prop_id);
+	igt_assert(prop);
+	igt_assert(prop->count_values == 2);
+	luminance_max = prop->values[1];
+	drmModeFreeProperty(prop);
+
+	igt_info("Initial: sysfs=%d/%d, LUMINANCE=%lu/%lu\n",
+		 original_brightness, max_brightness, original_luminance, luminance_max);
+
+	/* Test multiple values: min, 25%, 50%, 75%, max of the LUMINANCE range */
+	uint64_t test_luminance[] = {0, luminance_max / 4, luminance_max / 2,
+				     luminance_max * 3 / 4, luminance_max};
+
+	for (int i = 0; i < 5; i++) {
+		new_luminance = test_luminance[i];
+
+		req = drmModeAtomicAlloc();
+		igt_assert(req);
+
+		ret = drmModeAtomicAddProperty(req, data->output->config.connector->connector_id,
+					       prop_id, new_luminance);
+		igt_assert(ret >= 0);
+
+		ret = drmModeAtomicCommit(data->drm_fd, req, DRM_MODE_ATOMIC_ALLOW_MODESET, NULL);
+		igt_assert_f(ret == 0, "Atomic commit failed: %s\n", strerror(errno));
+
+		drmModeAtomicFree(req);
+
+		/* Give kernel time to update sysfs */
+		usleep(300000); /* 300ms */
+
+		/* Read back sysfs brightness */
+		new_brightness = read_sysfs_int(brightness_path);
+		igt_assert_f(new_brightness >= 0, "Failed to read brightness after DRM change\n");
+
+		/* Calculate expected sysfs value using kernel's formula:
+		 * brightness = (luminance * max_brightness) / luminance_max
+		 */
+		expected_brightness = (new_luminance * max_brightness) / luminance_max;
+
+		igt_info("Test %d: LUMINANCE=%lu, sysfs=%d (expected %d)\n",
+			 i, new_luminance, new_brightness, expected_brightness);
+
+		/* Allow for small rounding differences - at most 2 to catch formula bugs */
+		igt_assert_f(abs(new_brightness - expected_brightness) <= 2,
+			     "sysfs not synchronized: expected %d, got %d (diff: %d)\n",
+			     expected_brightness, new_brightness, abs(new_brightness - expected_brightness));
+	}
+
+	/* Restore original value */
+	req = drmModeAtomicAlloc();
+	igt_assert(req);
+	drmModeAtomicAddProperty(req, data->output->config.connector->connector_id,
+				 prop_id, original_luminance);
+	drmModeAtomicCommit(data->drm_fd, req, DRM_MODE_ATOMIC_ALLOW_MODESET, NULL);
+	drmModeAtomicFree(req);
+	usleep(100000);
+}
+
+int igt_main()
+{
+	data_t data = {};
+
+	igt_fixture() {
+		data.drm_fd = drm_open_driver_master(DRIVER_ANY);
+		igt_require(data.drm_fd >= 0);
+
+		kmstest_set_vt_graphics_mode();
+
+		igt_display_require(&data.display, data.drm_fd);
+		require_luminance_support(&data);
+
+		igt_info("Using backlight: %s\n", data.backlight_path);
+	}
+
+	igt_describe("Verify LUMINANCE property exists and has correct range");
+	igt_subtest("luminance-basic")
+		test_luminance_basic(&data);
+
+	igt_describe("Test sysfs brightness changes synchronize to DRM LUMINANCE property");
+	igt_subtest("luminance-sysfs-to-drm")
+		test_luminance_sysfs_to_drm(&data);
+
+	igt_describe("Test DRM LUMINANCE property changes synchronize to sysfs brightness");
+	igt_subtest("luminance-drm-to-sysfs")
+		test_luminance_drm_to_sysfs(&data);
+
+	igt_fixture() {
+		igt_display_fini(&data.display);
+		drm_close_driver(data.drm_fd);
+	}
+}
diff --git a/tests/meson.build b/tests/meson.build
index 60cea3aa8..0fe7caf48 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -46,6 +46,7 @@ test_progs = [
 	'kms_hdr',
 	'kms_invalid_mode',
 	'kms_lease',
+	'kms_luminance',
 	'kms_multipipe_modeset',
 	'kms_panel_fitting',
 	'kms_pipe_crc_basic',
-- 
2.53.0

