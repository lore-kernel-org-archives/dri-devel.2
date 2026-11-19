Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DB60A262F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=he+hqyxY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF8611267E;
	Thu, 19 Nov 2026 17:10:59 +0000 (UTC)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621F911267C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:10:52 +0000 (UTC)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-46509ab0149so34891fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108251; x=1795713051;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UgCYURNKZXvnpxT2x6kH2Yd3H2eYME7sOBjpX93BA1E=;
 b=he+hqyxYizP/a89nSv7C27BARC/L72litL+lTYLFdFlogHDHro7JGAFC0EtDm/CuWe
 6UoyD6sItWG4JqLTbkqnUQqYcELL5PVBbhVMtHmZY4TqOEeT8j804lfEoxa24ej/lX/j
 qYzq2K3rlMBfx2Gw0ElUF7pvAWStoUi7cegaawbEFU+CbN9phKZc/noX7l2+ZSwsadcU
 M7GDq3yzq2tjTAqsdJ/XoRcrkK64IW8C/jTlST1rud03cl6S8TtX4rXwkBMgc+AXbGMY
 8E7v4lRLHPQ0tiMA4O4eBAsRXKyYiY8H6r4gfEl5y7z3WQ5f7HusyKNNHm0ofgKFzH4l
 2A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108251; x=1795713051;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UgCYURNKZXvnpxT2x6kH2Yd3H2eYME7sOBjpX93BA1E=;
 b=PACFyW9Ynv3BU4EMbdTFhJ03R3nfwEvrSQIf8NTmrsLl3J7ciE/9loCnd0RJpPGaXM
 Dg+83dCSLmrkc0mmxM1kM1WHth1R0FNijHXItit3rrV84eTNkBKOFKCRc/Abo9mqNiY0
 u2Dq+LM8nS88aJlcSfXeEBhmYA1/uwJQpVaxu6zSzQYSVmHgwbacdFBmYxiUbFzW8rpI
 mvrwJSbMfEeP9J3UaQ78MPZyIk35289Ole9keyVvhnWfBkQ2sUfCIGJ4jNOvIMIJtDcc
 f4yipJQlqHHJNDDN8ENX1H0PdankRMBXylpIMiWnd3NQdxehLelAn+I3XLLnulv65BPX
 Gdyg==
X-Forwarded-Encrypted: i=1;
 AL+hErEaor76w7MJoeQ4OD1V+xwekMGDH6a4fespO26gvJmgl0j9AYENupuHkI2ZfMV04NtUE9QiGR4v6iY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/S65k+xsok4v/X6ihVYg3XxMpVEDEqX9BrT7/2OrxPcDQ+K1j/
 ecspSxF1FIRKKuXdxcNJC6CAUVakIhDd0RYbYeLJl5JxGWcmEgO1zm1Q4jnrHtRANaoeOnSVfud
 KaY0CvTJPBA==
X-Received: from oadxh9-n1.prod.google.com
 ([2002:a05:6871:ed09:10b0:4a7:1cc1:e72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:b14d:b0:4a2:47f6:3cbf
 with SMTP id 586e51a60fabf-4bc7d56ee04mr238017fac.8.1795108251216; Thu, 19
 Nov 2026 09:10:51 -0800 (PST)
Date: Thu, 19 Nov 2026 09:10:46 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119171046.1536673-1-irogers@google.com>
Subject: [PATCH] drm/msm/dp: Return MODE_BAD instead of -EINVAL from
 mode_valid callbacks
From: Ian Rogers <irogers@google.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>,
 Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_dp_display_mode_valid() and msm_edp_bridge_mode_valid() have
return type enum drm_mode_status, but return -EINVAL (-22) when dp,
dp->connector, or mode->clock is zero/NULL. If a mode with zero pixel
clock is validated and pruned, passing -22 to
drm_get_mode_status_name() computes a negative array index and fires
WARN_ON().

Return MODE_BAD instead of -EINVAL in both callbacks.

Found via Clang -Wassign-enum on an x86_64 allyesconfig build.
Verified by building drivers/gpu/drm/msm/dp/dp_display.o and dp_drm.o
with LLVM=1 W=1 (-Werror) and -Wassign-enum; not runtime-tested on
Qualcomm Snapdragon DP/eDP hardware.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Fixes: 05d001352733 ("drm/msm/dp: use the eDP bridge ops to validate eDP modes")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 drivers/gpu/drm/msm/dp/dp_drm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c0c150e2c575..51649b584573 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -759,7 +759,7 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 
 	if (!dp || !mode_pclk_khz || !dp->connector) {
 		DRM_ERROR("invalid params\n");
-		return -EINVAL;
+		return MODE_BAD;
 	}
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index c1e4147bfef1..dd4e8426cfe0 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -251,7 +251,7 @@ static enum drm_mode_status msm_edp_bridge_mode_valid(struct drm_bridge *bridge,
 
 	if (!dp || !mode_pclk_khz || !dp->connector) {
 		DRM_ERROR("invalid params\n");
-		return -EINVAL;
+		return MODE_BAD;
 	}
 
 	if (msm_dp_wide_bus_available(dp))
-- 
2.56.1.708.g77570a6a1d-goog

