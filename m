Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FB1C982F0
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1B310E715;
	Mon, 21 Sep 2026 13:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W1jQUdHY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A2910E715;
 Mon, 21 Sep 2026 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789996144; x=1821532144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZXkVSxJPt1S6YbTH/3RPBdYV3dlDdfOeZggZAEjxEF8=;
 b=W1jQUdHYU5xPa5Ul3YjUXUpek0fePrsm5puBJXzAH7zZ3xO+o0kBkGwt
 LtCceizbye2DWrjvHn+2TMMebQHC0GLzQZPhjf37RB6P7kWpc9oeCCc29
 SgbEb+V9f5q2P4mthYAQJAT1Royvezk7pbTH9ImpO98GtSPxLLOmoLlTq
 eNuCXlcUXYkPK7datfNmWMzJ2MR6m1dxPVu43Xhb47psAn0CeVAUmQLGX
 rc6Dzan1N/ryro7KJW/IcrHK9KTh8faxowriuFsocwCYzUEBmBn1bb/HI
 OOiNLiJaLpPTL5pdHevvCpA89L++Up/JuGRVtiIPpNa1Hm0eyFxhXfPOr A==;
X-CSE-ConnectionGUID: BMT5ZSkZTVGsJKBDEb90PA==
X-CSE-MsgGUID: LyQhXCnkSTab7wJ2WEXn9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101855968"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="101855968"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 06:09:04 -0700
X-CSE-ConnectionGUID: 493LabZIQWmvegAiDiF7EA==
X-CSE-MsgGUID: EdeO/YCNTQWSHdp3Sd06AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3678338"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa011.fm.intel.com with ESMTP; 21 Sep 2026 06:09:02 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 ankit.k.nautiyal@intel.com, adarsh.g.m@intel.com,
 Arun R Murthy <arun.r.murthy@intel.com>
Subject: [PATCH libdrm 2/2] tests/crtclist: add utility to inspect CRTC usage
Date: Mon, 21 Sep 2026 18:37:46 +0530
Message-Id: <20260921130747.2557722-3-arun.r.murthy@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921130747.2557722-1-arun.r.murthy@intel.com>
References: <20260921130747.2557722-1-arun.r.murthy@intel.com>
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

Add a small diagnostic utility built on the new drmModeGetCrtcList()
API. It prints the total number of CRTCs, how many are free vs in use,
and a per-CRTC line with state, scanout framebuffer and active mode.

Built like the other tests/ utilities (drmdevice, modeprint); it is a
human-facing tool and is intentionally not registered as a meson test,
since correctness is covered by the drmmode_crtc_list_ult suite.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 tests/crtclist.c  | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/meson.build |   9 ++++
 2 files changed, 125 insertions(+)
 create mode 100644 tests/crtclist.c

diff --git a/tests/crtclist.c b/tests/crtclist.c
new file mode 100644
index 00000000..7ac16853
--- /dev/null
+++ b/tests/crtclist.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright © 2026 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*
+ * crtclist - inspect CRTC usage on a DRM device via drmModeGetCrtcList().
+ *
+ * Prints the total number of CRTCs, how many are free vs in use, and a
+ * per-CRTC line showing state, scanout framebuffer and active mode. Useful
+ * for compositor bring-up to see which CRTCs are available.
+ *
+ * Usage: crtclist [/dev/dri/cardN]   (defaults to the first KMS node)
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <xf86drm.h>
+#include <xf86drmMode.h>
+
+static int open_kms_node(void)
+{
+	char path[64];
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		int fd;
+
+		snprintf(path, sizeof(path), "/dev/dri/card%d", i);
+		fd = open(path, O_RDWR | O_CLOEXEC);
+		if (fd < 0)
+			continue;
+		if (drmIsKMS(fd)) {
+			printf("Using %s\n", path);
+			return fd;
+		}
+		close(fd);
+	}
+	return -1;
+}
+
+int main(int argc, char **argv)
+{
+	drmModeCrtcListPtr list;
+	int fd, i;
+
+	if (argc > 1)
+		fd = open(argv[1], O_RDWR | O_CLOEXEC);
+	else
+		fd = open_kms_node();
+
+	if (fd < 0) {
+		fprintf(stderr, "No accessible KMS DRM device (try running as root).\n");
+		return 1;
+	}
+
+	list = drmModeGetCrtcList(fd);
+	if (!list) {
+		fprintf(stderr, "drmModeGetCrtcList() failed\n");
+		close(fd);
+		return 1;
+	}
+
+	printf("Total CRTCs : %d\n", list->count);
+	printf("Available   : %d\n", list->count_available);
+	printf("In use      : %d\n\n", list->count - list->count_available);
+
+	printf("%-5s %-8s %-13s %-8s %s\n",
+	       "idx", "crtc_id", "state", "fb_id", "mode");
+	printf("-------------------------------------------------------\n");
+	for (i = 0; i < list->count; i++) {
+		drmModeCrtcInfoPtr c = &list->crtcs[i];
+		const char *state;
+
+		if (c->in_use)
+			state = "IN USE";
+		else if (c->driver_active)
+			state = "ACTIVE";
+		else
+			state = "FREE";
+
+		printf("%-5d %-8u %-13s %-8u ",
+		       c->index, c->crtc_id, state, c->buffer_id);
+		if (c->in_use)
+			printf("%ux%u @ %uHz (%s)\n",
+			       c->width, c->height, c->mode.vrefresh,
+			       c->mode.name);
+		else if (c->driver_active)
+			printf("(active in hardware, not enabled via KMS)\n");
+		else
+			printf("-\n");
+	}
+
+	drmModeFreeCrtcList(list);
+	close(fd);
+	return 0;
+}
diff --git a/tests/meson.build b/tests/meson.build
index ac9e66b0..9c98bc2b 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -69,6 +69,15 @@ drmdevice = executable(
   install : with_install_tests,
 )
 
+crtclist = executable(
+  'crtclist',
+  files('crtclist.c'),
+  include_directories : [inc_root, inc_drm],
+  link_with : libdrm,
+  c_args : libdrm_c_args,
+  install : with_install_tests,
+)
+
 test('hash', hash)
 test('drmsl', drmsl)
 test('drmdevice', drmdevice)
-- 
2.25.1

