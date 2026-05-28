Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0A2CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB0110EC60;
	Thu, 28 May 2026 05:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AWkHCXHF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB7710EC60
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2215240D59;
 Thu, 28 May 2026 05:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B3A1F000E9;
 Thu, 28 May 2026 05:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947442;
 bh=rbqyqMT+zcesIoiBhMt0pVksINOE+7SSTxxCQQLPi8k=;
 h=From:To:Cc:Subject:Date;
 b=AWkHCXHFCgJ1l44QLSko2/8FDVSiKv9Hsyr6aFxdAByLT6ExdoYpJElmR7HXa2DUc
 0hS9utIOatikdZW8EA9l/sBSw84WX8KzRJfuhGhpMZdd6KbF1zqatlRe0WrUhzUhLz
 mXJpzJN2BMiYGS4Oy0RnY0CCV9bWmkPtYa0F0HjQBO8MLR5f2+iwPB7XwErTjTwnYd
 FVu+9v2+P9NiZTqdzAKbn8mLafzoUYwIgH5VfoNaGGlnI80w6BO1N1rAUTzXSdANvk
 5T5E7kNCrjPHX1fchmiNAw9ovOECl9AZ0XVnVt59Nnz68AB/OS+BwnzEW8OyZTE7oH
 Ew1W0LmylQRqw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2] IGT: Add a luminance test
Date: Thu, 28 May 2026 00:50:33 -0500
Message-ID: <20260528055035.1514478-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This will make sure that luminance can be changed from DRM master
and that it stays in sync with sysfs.

Assisted-by: Claude Sonnet
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Fix some warnings
 * Handle -EBUSY for DRM_CLIENT_CAP_LUMINANCE
---
 tests/kms_luminance.c | 423 ++++++++++++++++++++++++++++++++++++++++++
 tests/meson.build     |   1 +
 2 files changed, 424 insertions(+)
 create mode 100644 tests/kms_luminance.c

diff --git a/tests/kms_luminance.c b/tests/kms_luminance.c
new file mode 100644
index 000000000..1baa3d9c9
--- /dev/null
+++ b/tests/kms_luminance.c
@@ -0,0 +1,423 @@
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
+ * Description: Test LUMINANCE connector property and backlight takeover
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
+#ifndef DRM_CLIENT_CAP_LUMINANCE
+#define DRM_CLIENT_CAP_LUMINANCE 8
+#endif
+
+/**
+ * SUBTEST: luminance-basic
+ * Description: Verify LUMINANCE is atomic and uses the expected range
+ */
+
+/**
+ * SUBTEST: luminance-sysfs-to-drm
+ * Description: Verify sysfs brightness writes fail during luminance takeover
+ */
+
+/**
+ * SUBTEST: luminance-drm-to-sysfs
+ * Description: Verify DRM LUMINANCE updates sysfs brightness
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
+	size_t needed;
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
+		if (slash) {
+			needed = strlen(BACKLIGHT_PATH) + 1 + strlen(slash + 1) + 1;
+			if (needed <= path_len)
+				snprintf(path, path_len, "%s/%s", BACKLIGHT_PATH, slash + 1);
+			else
+				return false;
+		} else {
+			needed = strlen(BACKLIGHT_PATH) + 1 + strlen(backlight_name) + 1;
+			if (needed <= path_len)
+				snprintf(path, path_len, "%s/%s", BACKLIGHT_PATH, backlight_name);
+			else
+				return false;
+		}
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
+		needed = strlen(BACKLIGHT_PATH) + 1 + strlen(entry->d_name) + 1;
+		if (needed > path_len)
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
+static int write_sysfs_int(const char *path, int value)
+{
+	int fd;
+	int ret;
+	int saved_errno;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = dprintf(fd, "%d\n", value);
+	if (ret < 0) {
+		saved_errno = errno;
+		close(fd);
+		return -saved_errno;
+	}
+
+	if (close(fd) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static void require_luminance_support(data_t *data)
+{
+	uint64_t value;
+
+	igt_require(igt_has_drm_cap(data->drm_fd, DRM_CLIENT_CAP_ATOMIC));
+	igt_require(drmSetClientCap(data->drm_fd, DRM_CLIENT_CAP_ATOMIC, 1) == 0);
+
+	/* Enable luminance takeover support. */
+	igt_require(drmSetClientCap(data->drm_fd, DRM_CLIENT_CAP_LUMINANCE, 1) == 0);
+
+	/* Find an eDP output with LUMINANCE. */
+	for_each_connected_output(&data->display, data->output) {
+		if (data->output->config.connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+			if (kmstest_get_property(data->drm_fd,
+						 data->output->config.connector->connector_id,
+						 DRM_MODE_OBJECT_CONNECTOR,
+						 "LUMINANCE",
+						 NULL, &value, NULL)) {
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
+	int original_brightness, current_brightness, new_brightness, max_brightness;
+	uint64_t original_luminance, new_luminance;
+	int test_values[] = {0, 0, 0, 0, 0}; /* Will be filled after reading max_brightness */
+	int ret;
+
+	igt_assert_eq(drmSetClientCap(data->drm_fd, DRM_CLIENT_CAP_LUMINANCE, 1), 0);
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
+	/* Test min, quartiles, and max. */
+	test_values[0] = 0;
+	test_values[1] = max_brightness / 4;
+	test_values[2] = max_brightness / 2;
+	test_values[3] = max_brightness * 3 / 4;
+	test_values[4] = max_brightness;
+
+	for (int i = 0; i < 5; i++) {
+		new_brightness = test_values[i];
+		ret = write_sysfs_int(brightness_path, new_brightness);
+		igt_assert_f(ret == -EBUSY,
+			     "Expected sysfs write to fail with -EBUSY after setting DRM_CLIENT_CAP_LUMINANCE, got %d\n",
+			     ret);
+
+		current_brightness = read_sysfs_int(brightness_path);
+		igt_assert_f(current_brightness >= 0,
+			     "Failed to read brightness after rejected sysfs write\n");
+
+		/* Read back DRM state. */
+		kmstest_get_property(data->drm_fd,
+				     data->output->config.connector->connector_id,
+				     DRM_MODE_OBJECT_CONNECTOR,
+				     "LUMINANCE",
+				     NULL, &new_luminance, NULL);
+
+		igt_info("Test %d: rejected sysfs=%d with -EBUSY, brightness=%d, LUMINANCE=%lu\n",
+			 i, new_brightness, current_brightness, new_luminance);
+
+		igt_assert_f(current_brightness == original_brightness,
+			     "Brightness changed after rejected sysfs write: expected %d, got %d\n",
+			     original_brightness, current_brightness);
+		igt_assert_f(new_luminance == original_luminance,
+			     "LUMINANCE changed after rejected sysfs write: expected %lu, got %lu\n",
+			     original_luminance, new_luminance);
+	}
+}
+
+static void test_luminance_drm_to_sysfs(data_t *data)
+{
+	char brightness_path[512];
+	char max_brightness_path[512];
+	int original_brightness, new_brightness, max_brightness, expected_brightness;
+	uint64_t original_luminance, new_luminance, luminance_max;
+	uint64_t test_luminance[] = {0, 0, 0, 0, 0}; /* Will be filled after reading luminance_max */
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
+	/* Get the LUMINANCE range. */
+	prop = drmModeGetProperty(data->drm_fd, prop_id);
+	igt_assert(prop);
+	igt_assert(prop->count_values == 2);
+	luminance_max = prop->values[1];
+	drmModeFreeProperty(prop);
+
+	igt_info("Initial: sysfs=%d/%d, LUMINANCE=%lu/%lu\n",
+		 original_brightness, max_brightness, original_luminance, luminance_max);
+
+	/* Test min, quartiles, and max. */
+	test_luminance[0] = 0;
+	test_luminance[1] = luminance_max / 4;
+	test_luminance[2] = luminance_max / 2;
+	test_luminance[3] = luminance_max * 3 / 4;
+	test_luminance[4] = luminance_max;
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
+		/* Give the kernel time to update sysfs. */
+		usleep(300000); /* 300ms */
+
+		/* Read back sysfs brightness. */
+		new_brightness = read_sysfs_int(brightness_path);
+		igt_assert_f(new_brightness >= 0, "Failed to read brightness after DRM change\n");
+
+		/* Kernel formula:
+		 * brightness = (luminance * max_brightness) / luminance_max
+		 */
+		expected_brightness = (new_luminance * max_brightness) / luminance_max;
+
+		igt_info("Test %d: LUMINANCE=%lu, sysfs=%d (expected %d)\n",
+			 i, new_luminance, new_brightness, expected_brightness);
+
+		/* Allow small rounding differences. */
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
+	igt_describe("Verify LUMINANCE is atomic and uses the expected range");
+	igt_subtest("luminance-basic")
+		test_luminance_basic(&data);
+
+	igt_describe("Verify sysfs brightness writes fail during luminance takeover");
+	igt_subtest("luminance-sysfs-to-drm")
+		test_luminance_sysfs_to_drm(&data);
+
+	igt_describe("Verify DRM LUMINANCE updates sysfs brightness");
+	igt_subtest("luminance-drm-to-sysfs")
+		test_luminance_drm_to_sysfs(&data);
+
+	igt_fixture() {
+		igt_display_fini(&data.display);
+		drm_close_driver(data.drm_fd);
+	}
+}
diff --git a/tests/meson.build b/tests/meson.build
index fe0818118..525dcc6d8 100644
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
2.54.0

