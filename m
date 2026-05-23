Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A53CD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 15:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADFB10E308;
	Sat, 23 May 2026 15:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ExwsO3CI";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796A210E308
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 15:41:30 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2bc85eda6b6so41945965ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779550890; x=1780155690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=tlfATX24+gOXKKLMuPk5Ufobg0T/xx+iuzrEcxjjNAY=;
 b=ExwsO3CIx3xEyreCPIAJ5fqhz9hJRSYl9pKkj3oY4/3IMSHPTgrPJRB4M3xk48F9TV
 wb68oNnwQre8IQ1VlQwi2ZGUqpG0q9aGt2l2m/5MiYQ6ydoQSsLezzZUKUH5ClE49MTE
 UtaE6n6XR0Ancqx7hIc+gsWfdyP6VxoXf2tKirm7zDMgcQDENlYnisM06WbkYv0fkxP6
 XCxGYcIH4Xm4ePprmbHE8yhY22NjvsoFVnPKeV44M82pB9mEovpKIFVEPhXbwAWB0U2M
 JcW2xtS6MJe3gzq+ZrCxlsKYzLbwb4UTaA4EvjVhJcndwRfZoby3rcMlPS5YJwN9ne8Y
 y/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779550890; x=1780155690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlfATX24+gOXKKLMuPk5Ufobg0T/xx+iuzrEcxjjNAY=;
 b=bIC5QykXxAkD1j4pwSkxf5gvM571lxaXDvf90ykD9psHAyBvikS+ZR3SeTqPpW4Tlf
 j/+WrcA+0G7KoKyxh5XSQ0CCAndBlMZGG+ONyciDBMSHZcsPz24XLrOXcJVKpTlBEfTl
 pUXiqGKvumR7g0gMONpUq51awLDCi0b7bByDjcpC0mPGt+tyLLqUIW88JvVZCjIxWRab
 7Kr5NlvSnsirfQKMYhHATf7N/QYqF3QyyK4SKAtj1NmSPhROhbYDbrNRcU7gtLsUyoUg
 a0Aq8/YKljLbeu8N5l9cUg3Wnd6eanyE9CI/8j+EqbCr93JP+cqwzPrIlaFBlAg3R2Fs
 IzrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yq5RE8oP9UsQOmVeIokm3npUuS4bYuAVUESwRRWQI+47nbu4ftiza7qGYgbU5IM/7/lB0+jHZ8z8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUQXmRHWU7y506RrOcTKVtKQ5ZDZHLYq4gmyp9Wli2LhrN+I7h
 bzItr4sbb7BOtPzU9J81jip7qI9JO4a89GpHJCrOhXoGhxcFd2w665eH
X-Gm-Gg: Acq92OHzNOtxDIiDt/HQEQhijqKFV0VkPj8cJ9H+33gHoOqkjAH0f5xgY/cRBsZyrck
 bBqTNGns/pSMo9lm++f+gwReEqPgI4nvixQBae013Vfj3LvC6PGMb9WMtHNaBW+yej1Mablrr0Z
 BUC6LALFOveMSzTScOWosCHEUSFt8dAcXKC5OREb+EnrK8KySxR7v9NcQ7QBiLOl5ePLciaVEH8
 RTZrN0nJYvkWbwD8f3DX0DcwZ2Q61m2FDuId9S7cwvQ7FABtkqDdIbXMcAD5hzqKJEzGISJ2HT9
 1w4cHK4gkSX6Jz1l1X9mS41gBgoNjgHH1LRzL5Ef8ytu2wAWjMZ4+Bxo3GVP+VI9ulS/olrzcXE
 h8R/+C/W+lVd/f0NJ2R1ZAxlMCjs6jLBFOTcDooibqMHARJRJhe9GBchElE2QR1HXv2LSnJ2SKM
 UEHpZrYI2TO18ThP3d5ziq79AsJXudqv7sQP+XeDzUxKnuljshCMgkyU+hVVllO/BzQbg0xrmrF
 VE=
X-Received: by 2002:a17:903:19e8:b0:2b0:6e4a:32d0 with SMTP id
 d9443c01a7336-2beb06a6053mr89764875ad.35.1779550889927; 
 Sat, 23 May 2026 08:41:29 -0700 (PDT)
Received: from nixos-office (mx-ll-171.5.30-148.dynamic.3bb.co.th.
 [171.5.30.148]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695c40sm45239765ad.5.2026.05.23.08.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 08:41:28 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] drm/i915: use 'depends on' with visible DEBUG_OBJECTS for
 DRM_I915_DEBUG and DRM_I915_SW_FENCE_DEBUG_OBJECTS
Date: Sat, 23 May 2026 16:41:21 +0100
Message-ID: <20260523154121.147103-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
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

A previous version of this patch[1] accidentally introduced an unmet
dependency bug, because DRM_I915_DEBUG selects
DRM_I915_SW_FENCE_DEBUG_OBJECTS without also depending on DEBUG_OBJECTS.

DRM_I915_SW_FENCE_DEBUG_OBJECTS currently selects DEBUG_OBJECTS even though
DEBUG_OBJECTS is visible to users. Other config options use 'depends on'
for DEBUG_OBJECTS, so let's do the same here.

This select-visible Kconfig misusage was detected by Kconfirm, a static
analysis tool for Kconfig.

Link 1: https://lore.kernel.org/all/20260502191932.4491-1-julianbraha@gmail.com/

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v2:
- select PREEMPT_COUNT, avoid recursive dependency

 drivers/gpu/drm/i915/Kconfig.debug | 3 ++-
 lib/Kconfig.debug                  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 3562a02ef7ad..657cdf49181e 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -35,6 +35,7 @@ config DRM_I915_REPLAY_GPU_HANGS_API
 
 config DRM_I915_DEBUG
 	bool "Enable additional driver debugging"
+	depends on DEBUG_OBJECTS
 	depends on DRM_I915
 	depends on EXPERT # only for developers
 	depends on !COMPILE_TEST # never built by robots
@@ -153,7 +154,7 @@ config DRM_I915_TRACE_GTT
 config DRM_I915_SW_FENCE_DEBUG_OBJECTS
 	bool "Enable additional driver debugging for fence objects"
 	depends on DRM_I915
-	select DEBUG_OBJECTS
+	depends on DEBUG_OBJECTS
 	default n
 	help
 	  Choose this option to turn on extra driver debugging that may affect
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8ff5adcfe1e0..6501b7040706 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -760,7 +760,7 @@ source "mm/Kconfig.debug"
 
 config DEBUG_OBJECTS
 	bool "Debug object operations"
-	depends on PREEMPT_COUNT || !DEFERRED_STRUCT_PAGE_INIT
+	select PREEMPT_COUNT if !DEFERRED_STRUCT_PAGE_INIT
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, additional code will be inserted into the
-- 
2.54.0

