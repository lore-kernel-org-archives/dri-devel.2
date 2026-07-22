Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB070C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B42710E433;
	Wed, 22 Jul 2026 06:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZPelsprP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B038D10E2AC;
 Wed, 22 Jul 2026 06:32:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FDB44133C;
 Wed, 22 Jul 2026 06:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1521F000E9;
 Wed, 22 Jul 2026 06:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784701935;
 bh=5oqamf5vYO7nOO3geayZ3HnhE2HUHatoGZ6ODL3Jt+I=;
 h=From:To:Cc:Subject:Date;
 b=ZPelsprPsxfpnRQkp47bjjVCQq4n22h+0/kTqtV4XAtN2oaaSbnH1206mT8nqi0a+
 s3VA1dU4CSBm6DKmpXrOW1g4ZvrCCHREEBBw5EMrFHYej1lnlYTp0c3qkEiidZA1wF
 WZ0VGHDe+/cJBKPCyYR5r5eIt0iJ0OJEzInUqaTbz6vOWk0YjwcJgr5A0pQK4sSwwJ
 0PuXScYYDqWqWzHIhcWPHe+sYbfTMUkoeJpY8ilh9aAC53nryi+RPbTzUpPz73NLvK
 +K0pKiqiGwd/xT6sU0Ee0PF5rJRSvwsA//munScyKJn0xFWpNDdFbdW6nQkjTUqFBp
 JFgmjLwyZhDAA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: use proper context for logging
Date: Wed, 22 Jul 2026 08:32:10 +0200
Message-ID: <20260722063210.1144266-1-jirislaby@kernel.org>
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

To avoid accessing the NULL context, use clk_src->base.ctx->logger
in get_ss_info_from_atombios(). That context is initialized earlier in
dce110_clk_src_construct() -- before get_ss_info_from_atombios() is
actually called. This is done by temporarily redefining DC_LOGGER to
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
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index ecb8493ec523..d3f7aa853e3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1513,6 +1513,10 @@ static const struct clock_source_funcs dce110_clk_src_funcs = {
 	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
 };
 
+/* calc_pll_cs->ctx is set only after get_ss_info_from_atombios(), unlike clk_src->base */
+#pragma push_macro("DC_LOGGER")
+#undef DC_LOGGER
+#define DC_LOGGER CTX->logger
 
 static void get_ss_info_from_atombios(
 		struct dce110_clk_src *clk_src,
@@ -1526,7 +1530,7 @@ static void get_ss_info_from_atombios(
 	struct spread_spectrum_info *ss_info_cur;
 	struct spread_spectrum_data *ss_data_cur;
 	uint32_t i;
-	DC_LOGGER_INIT();
+
 	if (ss_entries_num == NULL) {
 		DC_LOG_SYNC(
 			"Invalid entry !!!\n");
@@ -1631,6 +1635,8 @@ static void get_ss_info_from_atombios(
 	kfree(ss_info);
 }
 
+#pragma pop_macro("DC_LOGGER")
+
 static void ss_info_from_atombios_create(
 	struct dce110_clk_src *clk_src)
 {
-- 
2.55.0

