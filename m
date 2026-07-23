Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5802BC4452B
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D00B10E50E;
	Thu, 23 Jul 2026 04:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hIkpad+Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B03710E05D;
 Thu, 23 Jul 2026 04:25:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9437A600AB;
 Thu, 23 Jul 2026 04:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75171F000E9;
 Thu, 23 Jul 2026 04:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784780753;
 bh=XOAiBQVsKE+a+mmnQ5qruWwz3JayhWyzQU7FibWfMRY=;
 h=From:To:Cc:Subject:Date;
 b=hIkpad+QEoEj5yIDC7JoO0ilqCJQJu/7GlUBYpWlx3/6TFH9CtJh7FY7aFKxj1m/d
 SogHWhgNB02Ie1uGA6E9DF63oyM2PaViWdRdyda95uB7yxqT2aIgChJp6P8Xnwj6E4
 S4oTUP/mW+0uF+Y5eTRs3dLfD45W8XChrwW7e5HtlyOOR4xyLf1+LlgfKqiB5IqzqS
 n88SZihMAvbyL9wbE2gef8uVQoFQmgu5oFIdnvbe81/8hXdWTHvAcvm1IxZXLYKCdD
 u7ybbYcqiQ2w2IzhCyfKvSI7wtQMbS6trxJiphYyZCE8lwNhBecg0aytzn8V+dwWU9
 66fbmV4gjdI8g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: use proper context for logging
Date: Thu, 23 Jul 2026 06:25:48 +0200
Message-ID: <20260723042548.1225691-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.55.0
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

The same as the rest of the code, get_ss_info_from_atombios() uses
calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is
initialized only later in calc_pll_max_vco_construct(). Therefore, any
output using DC_LOG_SYNC() leads to a NULL pointer deference in
get_ss_info_from_atombios().

According to Sashiko, the very same problem exists in
dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers() too.

To avoid accessing the NULL context, use clk_src->base.ctx->logger
everywhere. That context in base is initialized earlier in
dce110_clk_src_construct() and dce112_clk_src_construct(). Before
get_ss_info_from_atombios() or Sashiko's get_pix_clk_dividers functions
above are actually called. This is done by redefining DC_LOGGER to
CTX->logger.

Before:
dce110_clk_src_construct() did:
 -> sets clk_src->base.ctx = ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses calc_pll_cs->ctx  # BOOM
 -> calc_pll_max_vco_construct()    <- sets calc_pll_cs->ctx

After:
dce110_clk_src_construct() does:
 -> sets clk_src->base.ctx = ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses clk_src->base.ctx

Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271175
Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@kernel.org/
Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
---
Cc: dri-devel@lists.freedesktop.org

[v2] Set DC_LOGGER to CTX->logger unconditionally (Bhawanpreet).
[v1] https://lore.kernel.org/all/20260722063210.1144266-1-jirislaby@kernel.org/
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index ecb8493ec523..8e3862f6dac2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -45,9 +45,7 @@
 	clk_src->base.ctx
 
 #define DC_LOGGER \
-	calc_pll_cs->ctx->logger
-#define DC_LOGGER_INIT() \
-	struct calc_pll_clock_source *calc_pll_cs = &clk_src->calc_pll
+	CTX->logger
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -287,6 +285,7 @@ static bool calc_pll_dividers_in_range(
 }
 
 static uint32_t calculate_pixel_clock_pll_dividers(
+		struct dce110_clk_src *clk_src,
 		struct calc_pll_clock_source *calc_pll_cs,
 		struct pll_settings *pll_settings)
 {
@@ -474,7 +473,7 @@ static uint32_t dce110_get_pix_clk_dividers_helper (
 {
 	uint32_t field = 0;
 	uint32_t pll_calc_error = MAX_PLL_CALC_ERROR;
-	DC_LOGGER_INIT();
+
 	/* Check if reference clock is external (not pcie/xtalin)
 	* HW Dce80 spec:
 	* 00 - PCIE_REFCLK, 01 - XTALIN,    02 - GENERICA,    03 - GENERICB
@@ -517,12 +516,14 @@ static uint32_t dce110_get_pix_clk_dividers_helper (
 		/*Calculate Dividers by HDMI object, no SS case or SS case */
 		pll_calc_error =
 			calculate_pixel_clock_pll_dividers(
+				        clk_src,
 					&clk_src->calc_pll_hdmi,
 					pll_settings);
 	else
 		/*Calculate Dividers by default object, no SS case or SS case */
 		pll_calc_error =
 			calculate_pixel_clock_pll_dividers(
+					clk_src,
 					&clk_src->calc_pll,
 					pll_settings);
 
@@ -568,7 +569,6 @@ static uint32_t dce110_get_pix_clk_dividers(
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
 	uint32_t pll_calc_error = MAX_PLL_CALC_ERROR;
-	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
@@ -600,7 +600,6 @@ static uint32_t dce112_get_pix_clk_dividers(
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
-	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
@@ -1442,8 +1441,6 @@ static uint32_t dcn3_get_pix_clk_dividers(
 	unsigned long long actual_pix_clk_100Hz = pix_clk_params ? pix_clk_params->requested_pix_clk_100hz : 0;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
 
-	DC_LOGGER_INIT();
-
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
 		DC_LOG_ERROR(
@@ -1513,7 +1510,6 @@ static const struct clock_source_funcs dce110_clk_src_funcs = {
 	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
 };
 
-
 static void get_ss_info_from_atombios(
 		struct dce110_clk_src *clk_src,
 		enum as_signal_type as_signal,
@@ -1526,7 +1522,7 @@ static void get_ss_info_from_atombios(
 	struct spread_spectrum_info *ss_info_cur;
 	struct spread_spectrum_data *ss_data_cur;
 	uint32_t i;
-	DC_LOGGER_INIT();
+
 	if (ss_entries_num == NULL) {
 		DC_LOG_SYNC(
 			"Invalid entry !!!\n");
@@ -1657,6 +1653,7 @@ static void ss_info_from_atombios_create(
 }
 
 static bool calc_pll_max_vco_construct(
+			struct dce110_clk_src *clk_src,
 			struct calc_pll_clock_source *calc_pll_cs,
 			struct calc_pll_clock_source_init_data *init_data)
 {
@@ -1808,6 +1805,7 @@ bool dce110_clk_src_construct(
 	ss_info_from_atombios_create(clk_src);
 
 	if (!calc_pll_max_vco_construct(
+			clk_src,
 			&clk_src->calc_pll,
 			&calc_pll_cs_init_data)) {
 		ASSERT_CRITICAL(false);
@@ -1822,7 +1820,7 @@ bool dce110_clk_src_construct(
 
 
 	if (!calc_pll_max_vco_construct(
-			&clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {
+			clk_src, &clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {
 		ASSERT_CRITICAL(false);
 		goto unexpected_failure;
 	}
-- 
2.55.0

