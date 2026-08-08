Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E67C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5D010E03C;
	Sat,  8 Aug 2026 14:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ro3/+Rm/";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC9710E061
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:49:27 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38101f85591so2685820a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786200567; x=1786805367; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oj+LpxJwmFVdLd+RvTFySlTh8hVfSNWlJ1ThruNqG6Q=;
 b=ro3/+Rm/rq3gZyYvYLmbCpGs5HSqry3+MjeLxDsevMsPfQNfls9aHQXR6MhlV0r2Es
 lM5pVge4K2KvhEX8p7sj+QSKn2Ky6TxJ4KfGOdIM9bNOsSWYpZ0+ARkHUXvzHeVwFTuU
 Uc6Bc4YpBFkynjYPt1ufCgxtwoFW3u1tAX5/dBQXWRWdHcU8VjpdruieanFfWHRodnoA
 vvgHgyiiyfLzXCMtjCEVshcsgUFJL+d1l3nLUGJ0maPFsDXZJXMWmNd/RAXG7ailmacX
 ztw1aEwE6X8HZ7F+2RnwzqEk2dlhhFDm2PT8aYyE9gNXcV7Yxu2dW7ND9AE9QlpS/QpD
 yCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786200567; x=1786805367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oj+LpxJwmFVdLd+RvTFySlTh8hVfSNWlJ1ThruNqG6Q=;
 b=Yg5S8Nw2SZyFvtt/wbsdoLT1x9eV8r5y3IHehzP9t2Of5tnwMOllSfdv4Iy20xj/zs
 KyDkR6Uyo3zfL0ScEcNWpuWiQ6C986cwWwt1bKVSpUeFk6VTR3hlObkHZFu/NsdO+hJr
 2645/xnDUgpP35Nnc3yNZ3bZleT1fP80g1UHY/UmAC68vcADuJBBOdE/TyAC571H36OF
 inGxpvBTs92C6PXJx0ukAw3Gwu5BEl//pRX4NHwxiUKz+Xn23BhvDRXC9iimsVmyDsca
 opNeAMTD7RkuQZoC5C6bCcJyHFbo2L6gBsbt2q5wBDN6lqfIl3Sdkv+ECG9HmXKNdFJp
 becg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWLhhox5hGIMsB/OMI6D7Kbc1TqPEAaTg1rmHZygvESaGttZEAOOMYEkx90QpeZMLUYztsnvRmxN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHoR9uZg+jSHb6hOOPTdA0T4gLDaFUehZdHDa0YSInYLnG0CIq
 OL/EReMV5hpQtC9O3w42aKmMkJvtY7XsJFfRFg2KCg8ifkl+g8LSByXUriRQ7z3SOXo=
X-Gm-Gg: AR+sD11K+BTNpQATU8wDOeE7HOxc9gStbQ94DKoqxRF2g4tsDchfcQMgaE/m7Y1ecAk
 G7Om8hYspJblmNZmTSgwWuOBTTMRxYOz0LUHi8V5XNoCCPlSsrbL5kdFGFsLkXiqdA9dSsyVsEz
 /edfbrY7UrgSog2DfCmo+hY/Z4Gsh5LvjbiFNDPQAcfX+0W6E5P8ezldC8f786Xd2hwZHrkujWk
 aJUGvAj6jr6Z3pdxKxP/EUwVTZPHsl+nChByRQh7SmR1UBUBh0lTBnIlrrv//yDGQHAzHEhjmM6
 lNXdP9B/JVQga49A6XubdcyMdAPgcCYElC5YbjHB1H0gnsY0TJu9COir/ngIddmu4wwoskgAbJt
 RuGcf9Kt1b9ynlLkIQ2Ufbr4ub8eIg2zW1IMQtGpFK/1HunU7Ox7o/VppFvRBAVrp3lBAgii7n0
 pjDD28fRv8Dj2sGn6jIaYkgyQ5bS78TcKueslhl2nkmmAI88Zhkg==
X-Received: by 2002:a17:90a:ec86:b0:390:b3c5:e2c9 with SMTP id
 98e67ed59e1d1-392846fd57fmr2663920a91.17.1786200566741; 
 Sat, 08 Aug 2026 07:49:26 -0700 (PDT)
Received: from lgs.. ([36.255.223.70]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fd95270sm6365730a91.5.2026.08.08.07.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:49:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:49:07 +0800
Message-ID: <20260808144907.2918746-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

xe_pm_runtime_init() calls pm_runtime_use_autosuspend(), but
xe_pm_runtime_fini() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the runtime
PM teardown path.

This issue was found by manual code inspection.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 99562f691080..301789adaa21 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -518,6 +518,7 @@ static void xe_pm_runtime_fini(struct xe_device *xe)
 	if (IS_SRIOV_VF(xe))
 		return;
 
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
 }
-- 
2.43.0

