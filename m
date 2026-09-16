Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAED0C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA3010E2A4;
	Wed, 16 Sep 2026 19:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="hWVN5pT3";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CC910E2A4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 19:17:22 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=e8COaffNECHJoBz+99fGiuGWKjkgRyKe5SPUvBaBQG4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789586241; v=1; x=1790191041;
 b=hWVN5pT33dSgqR2lv1+H56Ljsf2NA5r9wmpbzuJPI4b8fNL5L2A6TsEQS50nHHgYCCuxzmCr
 gP0yNlxeTtcH2blsukKzO+Ga+GeZF71ppr96QNGkLfotSShBOYe6O5pxk3bDofXEh9SSyjdqQs3
 +IZngYn/wuzRL0wpmCZ0ceo8=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 76568a483f617875;
 Wed, 16 Sep 2026 19:11:17 +0000
X-Mizu-Trace-ID: 76568a483f617875
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Ray Wu <ray.wu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH RESEND 2/2] drm/amd/display: Keep backlight precision in
 millipercent
Date: Wed, 16 Sep 2026 12:11:02 -0700
Message-ID: <20260916191102.1195881-2-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916191102.1195881-1-matthew.schwartz@linux.dev>
References: <20260916191102.1195881-1-matthew.schwartz@linux.dev>
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

The power module takes the backlight level in millipercent, but DM
rounds the 16-bit level to a whole percent before multiplying by 1000,
collapsing the range to 101 steps. It also divides the absolute level,
which already includes the panel minimum, by the min to max span, so
panels with a nonzero minimum PWM overshoot the top of the range.

Scale the offset from the minimum to millipercent directly so the full
resolution reaches the power module and the minimum is only added once.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 45e1732a5b04..079277d47b3f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -326,7 +326,8 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	} else {
 		/* power module uses millipercent */
 		get_brightness_range(caps, &min, &max);
-		brightness = DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
+		brightness = DIV_ROUND_CLOSEST_ULL((u64)(brightness - min) * 100000,
+						   max - min);
 		rc = mod_power_set_backlight_percent(dm->power_module, stream,
 						     brightness, 0, false);
 	}
-- 
2.55.0

