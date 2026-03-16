Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAF4F3380C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928E410E535;
	Tue, 17 Mar 2026 08:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=antgroup.com header.i=@antgroup.com header.b="sDUb6zes";
	dkim-atps=neutral
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com
 [115.124.28.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D91510E2AF;
 Mon, 16 Mar 2026 03:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=antgroup.com; s=default;
 t=1773633198; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=EYW9eEgTMJ7uWMekujL7MMTcejAzJsQIxJcJx52I16g=;
 b=sDUb6zesK5Ok6Qmugc1SK2OSCozwPuRn8Rn/HLr3iKFhSeIOAZnq3T6EnIVpu3SlRF0eSmh4XNVOUF9dlvx6eysRExOuPGhCHfjxxWRJ6yf2Oytwt0ouvS4qsGKJtv+UxuVBAZ+kZJ0NiTDDDa6vM4yk99qhS0RMoa1NFfWjNFg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032053168;
 MF=houwenlong.hwl@antgroup.com; NM=1; PH=DS; RN=47; SR=0;
 TI=SMTPD_---.gt1LISf_1773632892; 
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com
 fp:SMTPD_---.gt1LISf_1773632892 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 16 Mar 2026 11:48:13 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, amd-gfx@lists.freedesktop.org,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ausef Yousof <auyousof@amd.com>,
 Bhuvanachandra Pinninti <bpinnint@amd.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Charlene Liu <charlene.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Chris Park <chris.park@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 dri-devel@lists.freedesktop.org, Gustavo Sousa <gustavo.sousa@intel.com>,
 Harold Sun <Harold.Sun@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jun Lei <jun.lei@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>,
 Leo Chen <leo.chen@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Lohita Mudimela <lohita.mudimela@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Nicholas Carbones <Nicholas.Carbones@amd.com>, Ray Wu <ray.wu@amd.com>,
 Relja Vojvodic <rvojvodi@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Ryan Seto <ryanseto@amd.com>,
 Samson Tam <Samson.Tam@amd.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Wayne Lin <wayne.lin@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Yan Li <yan.li@amd.com>,
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Rename enum 'pixel_format' to
 'dc_pixel_format'
Date: Mon, 16 Mar 2026 11:46:29 +0800
Message-Id: <d3b123a7d3192947e2eb4c33cd10cbaa8c79dfc1.1773629419.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1773629419.git.houwenlong.hwl@antgroup.com>
References: <cover.1773629419.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Rename the enum 'pixel_format' to 'dc_pixel_format' to avoid potential
name conflicts with the pixel_format struct defined in
include/video/pixel_format.h.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h           | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h           | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 03d125f794b0..cadc52728108 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -742,10 +742,10 @@ struct clock_source *resource_find_used_clk_src_for_sharing(
 	return NULL;
 }
 
-static enum pixel_format convert_pixel_format_to_dalsurface(
+static enum dc_pixel_format convert_pixel_format_to_dalsurface(
 		enum surface_pixel_format surface_pixel_format)
 {
-	enum pixel_format dal_pixel_format = PIXEL_FORMAT_UNKNOWN;
+	enum dc_pixel_format dal_pixel_format = PIXEL_FORMAT_UNKNOWN;
 
 	switch (surface_pixel_format) {
 	case SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS:
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index cfa569a7bff1..81d12df8f54e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -218,7 +218,7 @@ enum surface_pixel_format {
 
 
 /* Pixel format */
-enum pixel_format {
+enum dc_pixel_format {
 	/*graph*/
 	PIXEL_FORMAT_UNINITIALIZED,
 	PIXEL_FORMAT_INDEX8,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 37d1a79e8241..854d50ab1a6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -63,7 +63,8 @@ static void populate_inits_from_splinits(struct scl_inits *inits,
 	inits->h_c = dc_fixpt_from_int_dy(spl_inits->h_filter_init_int_c, spl_inits->h_filter_init_frac_c >> 5, 0, 19);
 	inits->v_c = dc_fixpt_from_int_dy(spl_inits->v_filter_init_int_c, spl_inits->v_filter_init_frac_c >> 5, 0, 19);
 }
-static void populate_splformat_from_format(enum spl_pixel_format *spl_pixel_format, const enum pixel_format pixel_format)
+static void populate_splformat_from_format(enum spl_pixel_format *spl_pixel_format,
+					   const enum dc_pixel_format pixel_format)
 {
 	if (pixel_format < PIXEL_FORMAT_INVALID)
 		*spl_pixel_format = (enum spl_pixel_format)pixel_format;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
index 808bca9fb804..0d2c9fcd3362 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
@@ -102,7 +102,7 @@ static int dpp1_dscl_get_pixel_depth_val(enum lb_pixel_depth depth)
 	}
 }
 
-static bool dpp1_dscl_is_video_format(enum pixel_format format)
+static bool dpp1_dscl_is_video_format(enum dc_pixel_format format)
 {
 	if (format >= PIXEL_FORMAT_VIDEO_BEGIN
 			&& format <= PIXEL_FORMAT_VIDEO_END)
@@ -111,7 +111,7 @@ static bool dpp1_dscl_is_video_format(enum pixel_format format)
 		return false;
 }
 
-static bool dpp1_dscl_is_420_format(enum pixel_format format)
+static bool dpp1_dscl_is_420_format(enum dc_pixel_format format)
 {
 	if (format == PIXEL_FORMAT_420BPP8 ||
 			format == PIXEL_FORMAT_420BPP10)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index a62c4733ed3b..e2489eaf0004 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -94,7 +94,7 @@ static int dpp401_dscl_get_pixel_depth_val(enum lb_pixel_depth depth)
 	}
 }
 
-static bool dpp401_dscl_is_video_format(enum pixel_format format)
+static bool dpp401_dscl_is_video_format(enum dc_pixel_format format)
 {
 	if (format >= PIXEL_FORMAT_VIDEO_BEGIN
 			&& format <= PIXEL_FORMAT_VIDEO_END)
@@ -103,7 +103,7 @@ static bool dpp401_dscl_is_video_format(enum pixel_format format)
 		return false;
 }
 
-static bool dpp401_dscl_is_420_format(enum pixel_format format)
+static bool dpp401_dscl_is_420_format(enum dc_pixel_format format)
 {
 	if (format == PIXEL_FORMAT_420BPP8 ||
 			format == PIXEL_FORMAT_420BPP10)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index a61d12ec61bc..b4a95807b73b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -240,7 +240,7 @@ struct default_adjustment {
 	enum dc_color_space out_color_space;
 	enum dc_color_space in_color_space;
 	enum dc_color_depth color_depth;
-	enum pixel_format surface_pixel_format;
+	enum dc_pixel_format surface_pixel_format;
 	enum graphics_csc_adjust_type csc_adjust_type;
 	bool force_hw_default;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
index 5a1d9b708a9d..30990355985d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
@@ -160,7 +160,7 @@ struct scaler_data {
 	struct scaling_ratios ratios;
 	struct scl_inits inits;
 	struct sharpness_adj sharpness;
-	enum pixel_format format;
+	enum dc_pixel_format format;
 	struct line_buffer_params lb_params;
 	// Below struct holds the scaler values to program hw registers
 	struct dscl_prog_data dscl_prog_data;
-- 
2.31.1

