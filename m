Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44148C88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946AC10E0BD;
	Wed, 16 Sep 2026 19:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Q0mHmn6s";
	dkim-atps=neutral
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Wed, 16 Sep 2026 19:14:38 UTC
Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B5510E0BD
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 19:14:37 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=d5rIYyuUq1yZ3+uvYAUim7aaKaINlMEW4ezCIRPM5Fs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789586076; v=1; x=1790190876;
 b=Q0mHmn6szaiFQhU9pdAlueNu/5N+QDPEowouD0fGDNEG+alQfirZmT2oFGaK8f+VeiUTVWaq
 KoHLiX26WsszwEjZY6ivAF+Fz0aIlHWYDMvUB+5ktJ0Q8PX+/EjgXHf1EmWFXr/B+8rhznsh4fU
 BsQANzV0ieivfP3yJGGqOM7U=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id deeea5a6716aa5cc;
 Wed, 16 Sep 2026 19:08:32 +0000
X-Mizu-Trace-ID: deeea5a6716aa5cc
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Ray Wu <ray.wu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 1/2] [FOR-UPSTREAM] drm/amd/display: Use linear backlight
 curve in power module
Date: Wed, 16 Sep 2026 12:08:22 -0700
Message-ID: <20260916190823.1193460-1-matthew.schwartz@linux.dev>
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

amdgpu_dm already applies the ATIF custom brightness curve in
convert_custom_brightness() before handing the level to the power
module. The power module then builds its own percent to PWM LUT from
the same ATIF data in initialize_backlight_caps() and applies the curve
a second time. On the Lenovo Legion Go S this maps the bottom 40% of the
brightness range to under 12% PWM, where the panel no longer visibly
changes.

Tell the power module to use its linear curve so the PWM is a straight
rescale of the level DM computed, matching the behavior before the power
module took over backlight programming.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ca795cda8084..63acefc0acfb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -455,7 +455,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *
 			!(amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK);
 		init_data[i].use_custom_backlight_caps = false;
 		init_data[i].custom_backlight_caps_config_no = 0;
-		init_data[i].use_linear_backlight_curve = false;
+		init_data[i].use_linear_backlight_curve = true;
 		init_data[i].def_varibright_enable = 0;
 		init_data[i].varibright_level = 0;
 		/*
-- 
2.55.0

