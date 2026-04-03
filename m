Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E2DE7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A4810F44A;
	Fri,  3 Apr 2026 09:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PI4BWz3Z";
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BC610F3C9
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 08:22:26 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-38a43f1f978so16168721fa.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775204545; x=1775809345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoBcZm06Ka/jy/EkbXTQ5nbauHlGfVYOrcx3b8Ix9uY=;
 b=PI4BWz3Z3Hu+pfxfQhFetXFIE1kUlbF6DKDYl1BFe82mVABwtMV3qldHSjcXzsfbJ/
 LEuDAx2NkP/xT0DqAQK0FlOYFHUdavh/mdKqmp2zm4llsOhcIt7ddBP9xzoWw/Ci+THv
 bYw4QPEZb/lAvXnQye0lwgdLj+ZuvgCOFZKZJxTeWkjifI7JOc5iTEHlZo4q6nKmKo5R
 L1d1Zl0JYje5ZeMbMm1dSv0wnMDguSpl6ELebGIczuEyorPYwXtBJcZfJyDFQrC8u1iY
 BmhQGIhWzT/p4h7YIgVieC/uIwuPsUq7NyduOG6OkjjAkMPMJPOcaMvi9Hh5PAEj2Dyk
 /0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775204545; x=1775809345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OoBcZm06Ka/jy/EkbXTQ5nbauHlGfVYOrcx3b8Ix9uY=;
 b=jJsmsJZ24eGRkcNWfGbZCyKa2UUpKHOWvNOAA3cVFWgM2c6G1i3OUU8qFtWiDe9VxA
 Lig2tVMJ9T1AVDg/EtaC3LSvsRhTrXjBG++Y1miIevv6sbRrBU4UdoB4hF4IElGpWmea
 kV1JtCCqvsc+bNKnaUE48mkDTjIwyuVV6lsGw0oGphTU2ARx5OaHDKtuPKWirGZNGUnE
 cP1N8et1lxKTnZZKKv6wCghhDHWqYIt7UIuRhAnkmQ8njb1S3ckdJxkuviAoFKs7TX+z
 bjR0asEwv12dfKl85HVFEhLCtEl9WI5bfpBDTrdDe01rv8ss5pC8T17aegD8gWsxPkbq
 FDEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMx1Jy2q8f5kmUZvHYTnLZzV+tmIA03aVJGZwQO0x32jycTtaDEWOD+wZbHQMi9BxUy/JnMiqV/jI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYHTZZd5+CwFfcNb4UjNK0rPCl8u7PfUexi4kn+XGluZYp7Xfg
 iFqYGSNydJmtQ1mzAod5rvTZ2hnXW7EhE38szQESUD0etFKk51agert3
X-Gm-Gg: AeBDieu4IhoPaKx8B2Ho6FbKeaLjfMTdnVOomrKJVKs6WIMem5SVzognKU9ojh2YBSY
 wAA8JBkca6ozEhISQVIKT4x1yN//deClg4dd0KPQw4yHAogSMoDfpN0SYCBonuF5k2e4oz54tvj
 XkgMaxjXflqSC2xr1HqApywRfa6NWlmZA5eGz3fnI19gFVU5d41h/LT1IuVHtjFSBRy5aFpR7LB
 sI3jFlE/K+aDtl0LUokHtXCj/VWfeybbMljyVnof9MXxIC0zjEVg2eHgPvEnQpWTvNkUQA/iBIu
 j8UHm9eJQoYHDToP+cB2Y+bZAPbPB1GoFAhCZ7qing8qa4r5zHmLL6YzDZPcpMbtylDqDFiE5ey
 h4Grue7QvbhDI+oSRY8smPw0RUsu+XKVY2VVyYtaLVv+HEjKoCEqIAFRerkyXLR7ua+jqVl3V6r
 AFszUyz7p1T1VodsLnuzayBXqM9pmdUru356kjzGcMpeX8H3f/D2R4
X-Received: by 2002:a2e:9a11:0:b0:38b:fd3e:c445 with SMTP id
 38308e7fff4ca-38d8d34c11bmr5680411fa.3.1775204544823; 
 Fri, 03 Apr 2026 01:22:24 -0700 (PDT)
Received: from localhost (94.191.136.33.mobile.tre.se. [94.191.136.33])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd20088a8sm10866661fa.18.2026.04.03.01.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 01:22:24 -0700 (PDT)
From: Linus Probert <linus.probert@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linus Probert <linus.probert@gmail.com>,
 "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH 1/2] drm/amd/display: Replace inline NUM_ELEMENTS macro with
 ARRAY_SIZE
Date: Fri,  3 Apr 2026 10:22:06 +0200
Message-ID: <20260403082207.1533450-2-linus.probert@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403082207.1533450-1-linus.probert@gmail.com>
References: <20260403082207.1533450-1-linus.probert@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Replaces the use of local NUM_ELEMENTS macro with the ARRAY_SIZE macro
defined in <linux/array_size.h>.

This aligns with existing coccinelle script array_size.cocci which has
been applied to other sources in order to remove inline
sizeof(a)/sizeof(a[0]) patterns from other source files.

Suggested-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Linus Probert <linus.probert@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 052d573408c3..d42d7befef42 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include <linux/array_size.h>
+
 #include "dm_services.h"
 #include "core_types.h"
 #include "timing_generator.h"
@@ -40,7 +42,6 @@
 #include "dcn10/dcn10_hubbub.h"
 #include "dce/dmub_hw_lock_mgr.h"
 
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 #define MAX_NUM_MCACHE 8
 
 /* used as index in array of black_color_format */
@@ -230,7 +231,7 @@ const uint16_t *find_color_matrix(enum dc_color_space color_space,
 	int i;
 	enum dc_color_space_type type;
 	const uint16_t *val = NULL;
-	int arr_size = NUM_ELEMENTS(output_csc_matrix);
+	int arr_size = ARRAY_SIZE(output_csc_matrix);
 
 	type = get_color_space_type(color_space);
 	for (i = 0; i < arr_size; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5722be965422..9d043cc35eb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include <linux/array_size.h>
+
 #include "dm_services.h"
 
 
@@ -57,8 +59,6 @@
 #define CALC_PLL_CLK_SRC_ERR_TOLERANCE 1
 #define MAX_PLL_CALC_ERROR 0xFFFFFFFF
 
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
-
 static const struct spread_spectrum_data *get_ss_data_entry(
 		struct dce110_clk_src *clk_src,
 		enum signal_type signal,
@@ -1267,7 +1267,7 @@ const struct pixel_rate_range_table_entry *look_up_in_video_optimized_rate_tlb(
 {
 	int i;
 
-	for (i = 0; i < NUM_ELEMENTS(video_optimized_pixel_rates); i++) {
+	for (i = 0; i < ARRAY_SIZE(video_optimized_pixel_rates); i++) {
 		const struct pixel_rate_range_table_entry *e = &video_optimized_pixel_rates[i];
 
 		if (e->range_min_khz <= pixel_rate_khz && pixel_rate_khz <= e->range_max_khz) {
-- 
2.53.0

