Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9438FC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E58910E71E;
	Sat, 12 Sep 2026 15:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aheymans-xyz.20251104.gappssmtp.com header.i=@aheymans-xyz.20251104.gappssmtp.com header.b="OnLQY6xd";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B629710E71E
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:11:40 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so4448355e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aheymans-xyz.20251104.gappssmtp.com; s=20251104; t=1789225899; x=1789830699;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UNp2ej2UnoB5ep8eGYhUlJSsYiFkYUAkgSgRSLrvMp8=;
 b=OnLQY6xdVthyF8lmvVo62Q/jTN81tWCvk85jsciR762oUVyXXl1tb5vNO7aMMjF2bT
 sIxqX1pT4U3W9LsPOU1V/ncML0zE9Fv1ymzrrr2u1CsQZ6N/O6CPGahyqYdyT3quqzAN
 DVR8kZvVO0jYEANU6atCHN0WIwGcaG9g7ZoBKhvZXZjSZSqKjhabX4XgKP4uPhbxTnqi
 uXb8EuUVJKnPWZOLPiavap2cxornQvYWEbmAnPaXwAXCvzs5R4AjRJYEcSKH9/drzDcM
 FLJp8ZnjyMS4ct2EUQ+Hh7PSxfmRIIbbZX1L33poh8A9wvsRC3xamK+3gvI8CZbFp2y6
 Y/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789225899; x=1789830699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UNp2ej2UnoB5ep8eGYhUlJSsYiFkYUAkgSgRSLrvMp8=;
 b=kqiU6ywnmhvpxBaGCO4DsxtdLtB1+FjkzS+HazxYwaSpnBztpAmhdwxFUCzghb19v7
 ukH9+41BC5vZQ7OKM6KkP3ezioxMX/5gjy2HUY769CbLT4RmMEjzo/6U1OQxnrWtE0A+
 iU8zg4pDl5/6ArUopMDjat+cwGKWoLYSD6kJojcbACkQhDcfUk4xaSfHh/tWl99g7cca
 RRcc1MqYneYaRPIkHaXueBXWFZ92hh/GFmgV5+yxQskA8r8qKz5lbI4wMb3Pdh3MOqFf
 ICn+q96x1yHQCTd20hD92ZuFxJdXS24qAh5lIQKl7+HeuEia+TQz0kGJWfGuxUEj6UnZ
 APtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnDtc0Gu4kni+AKIBSO3FpHz1FWJgFo5ZfJs9LgtCVP7xP3xsxQLvBoCa3j8y+iQaoaDnjdkkmcfA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lBryDGMyLTN5pZU8jD2EtYuCz5KF007V640rER5wSQKNB3e6oA
 vl8cQ5TfdyWcjwrgJFM85JpZXlBxESjssRviuQH4dbzLcrYkHk5XvagdNyP9qrQXGeY=
X-Gm-Gg: AYBFou16oovuSzuhXA8J472Z7EV8Rb2+oWHgbLz8bFEUtRHJcyC17pN020ylmV/EODJ
 9XXfnnOZMmXd8JGXiLIx7RVDKoT3PGV/IDHoqm4THhQ51est9CM7cO2aJ6VzfH02iqV7Yo2E0eI
 kfpPCqn3gdRyrIUzjUXu5Sy4WVVqvSdz3j4ifHLBzeWnQZtTFhuOduQ9TzG4UWZv1VK7qduhSxn
 W9WfmCXVJNDf3xrRXiVBrLNMQJ2joLin+8HbyWrZzb+2Qivcfeh6jgiaLz5FazrzH9n/a4STu6P
 cSA9QiaHMdiwUPgriucREuztaEH44j64oIuzJVq1VyIe2ZkqR5U92M1JCaQMCmzz0RN/mtEY9UT
 wrHMQYvgReFVfleLOixKncMY1On2XaGIif05Ffmkmy022D59+nqe6Xa8CSOBNn7ffWcMD7LxDGU
 4G0+0a2UuQiZArz78MPoJVdst0jQrNWA26TTu3X7TZVPZNkboJdXqL/WXcAynvCG1/XnZOD07D5
 Iecb8y0VOZ0UUMmgsaPZGJtznX5kHINUy8+RdoK8csyy7CKREQE0CiRj6sZCBejvZ9IjCRUkYHb
 8m8bKYXxDtOjUbu+OpvjXtJHOIv9dVzcH+i1mUE=
X-Received: by 2002:a05:600c:2301:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49e619cbf88mr155925425e9.16.1789225898398; 
 Sat, 12 Sep 2026 08:11:38 -0700 (PDT)
Received: from localhost
 (2a02-1810-b422-d400-af60-1d41-c104-7560.ip6.access.telenet.be.
 [2a02:1810:b422:d400:af60:1d41:c104:7560])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaeefsm162063135e9.12.2026.09.12.08.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 08:11:38 -0700 (PDT)
From: Arthur Heymans <arthur@aheymans.xyz>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 michael.mityushkin@amd.com, nicholas.kazlauskas@amd.com,
 qingqing.zhuo@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Arthur Heymans <arthur@aheymans.xyz>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Preserve eDP mode on initial ASSR failure
Date: Sat, 12 Sep 2026 17:11:37 +0200
Message-ID: <20260912151137.3913987-1-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

Commit 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when
reinitializing hardware") made ASSR failure fall back to the default panel
mode unless eDP mode had previously been applied.

However, dc_link is zero-initialized and DP_PANEL_MODE_DEFAULT is zero.
Before the first call to dp_set_panel_mode(), panel_mode therefore looks
like a previously applied default mode. If ASSR setup fails during the
first link training attempt, the driver incorrectly trains the eDP link
using the default scrambling mode.

On a Google Vilboz Chromebook running self-built coreboot firmware and
PSP verstage, this leaves the panel mostly black with corrupted output
along the top edge.

Track whether panel_mode has actually been initialized, and only consult
the saved mode after it has been applied. This retains the recovery
behavior while preserving eDP mode during initial link training.

Fixes: 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when reinitializing hardware")
Cc: stable@vger.kernel.org # v6.4+
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4ecd5699ac5e..0db55a73da0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1912,6 +1912,7 @@ struct dc_scratch_space {
 	struct ddc_service *ddc;
 
 	enum dp_panel_mode panel_mode;
+	bool panel_mode_initialized;
 	bool aux_mode;
 
 	/* Private to DC core */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 9883216dcc9d..cd90576bc6f0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -93,6 +93,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 	}
 
 	link->panel_mode = panel_mode;
+	link->panel_mode_initialized = true;
 	DC_LOG_DETECTION_DP_CAPS("%d eDP panel mode supported: %d, enabled: %d\n",
 				 link->link_index,
 				 link->dpcd_caps.panel_mode_edp,
@@ -1300,7 +1301,8 @@ void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 
 		result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
 
-		if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+		if (!result && link->panel_mode_initialized &&
+		    link->panel_mode != DP_PANEL_MODE_EDP)
 			*panel_mode = DP_PANEL_MODE_DEFAULT;
 	}
 }
-- 
2.55.0

