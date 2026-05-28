Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D68FCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A04710ED28;
	Thu, 28 May 2026 07:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="KQn346g6";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9FC10ECCF;
 Thu, 28 May 2026 07:01:19 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D114727335;
 Thu, 28 May 2026 09:01:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwNNDmpAue_S; Thu, 28 May 2026 09:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779951669; bh=ftINLFoB5as07uLajF9oygEXwyvPd6Lsrtt1KSfGsDI=;
 h=From:To:Cc:Subject:Date;
 b=KQn346g6fQTc7XLnR73RTofd1OQdyPbRGWOIv1Bij+Ma79cib4OLSDmOrL6qsGkSE
 lZYboWldxLClG1z8UutQtvNhyST6NWK2J9bSW0aOdXWN3q8d0xy72LQ9Kl8kfM0Cqm
 D+R9K9m7/T5piKnFUdYwlzS/uBDloUl5HL9L1eyEdWsuCOzPAhjru8GCQUCrJwps5O
 rHv+Bf/iN7UPIBmH1FQOaplYGqUO4td4e6R3CkXGkK5UP+l59SxcSY+qtuz+9c7Tnb
 qiKam1ezPTydkzkM0YcRcY/sYrR0DQ46YBcI2yORLl0EG96iv+ElhiafMyJnLo6t+4
 7U9XX5ZaKrL8A==
From: Leorize <leorize+oss@disroot.org>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Leorize <leorize+oss@disroot.org>
Subject: [PATCH] drm/amd/display: add missing CSC entries for BT.2020 for DCE
 IPs
Date: Wed, 27 May 2026 23:58:54 -0700
Message-ID: <20260528070016.14843-1-leorize+oss@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:17 +0000
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

DCE-based hardware does not have the CSC matrices for BT.2020, which
causes the driver to fallback to the GPU built-in matrices. This does
not appear to cause any issues for RGB sinks, but causes major color
artifacts for YCbCr ones (e.g. black becomes green).

This commit adds the missing CSC matrices (taken from DC common) to DCE
CSC tables, resolving the issue.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3358
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5333
Assisted-by: oh-my-pi:GPT-5.5
Signed-off-by: Leorize <leorize+oss@disroot.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c     | 10 +++++++++-
 .../gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c   | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index b3640682fa60..12c85c3afd6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -110,7 +110,15 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 { COLOR_SPACE_YCBCR601_LIMITED, { 0xE00, 0xF447, 0xFDB9, 0x1000, 0x991,
 	0x12C9, 0x3A6, 0x200, 0xFB47, 0xF6B9, 0xE00, 0x1000} },
 { COLOR_SPACE_YCBCR709_LIMITED, { 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, 0x16E3,
-	0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} }
+	0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
+{ COLOR_SPACE_2020_RGB_FULLRANGE,
+	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
+{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
+	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
+	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+{ COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
+	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 static bool setup_scaling_configuration(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
index cf63fac82832..1ed018aaa4bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
@@ -88,7 +88,15 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 { COLOR_SPACE_YCBCR601_LIMITED, { 0xE00, 0xF447, 0xFDB9, 0x1000, 0x991,
 	0x12C9, 0x3A6, 0x200, 0xFB47, 0xF6B9, 0xE00, 0x1000} },
 { COLOR_SPACE_YCBCR709_LIMITED, { 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, 0x16E3,
-	0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} }
+	0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
+{ COLOR_SPACE_2020_RGB_FULLRANGE,
+	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
+{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
+	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
+	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+{ COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
+	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 enum csc_color_mode {
-- 
2.54.0

