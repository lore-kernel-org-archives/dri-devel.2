Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60801CD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16C110F346;
	Thu, 21 May 2026 14:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fL5+WLJl";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E4E10F349
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:45:27 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso67990495e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779374726; x=1779979526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=H2yWVwJxTaScCgj+pdDqJvd1+BNm6/dyL9FgYCmk8UQ=;
 b=fL5+WLJldpB9wXbhmidcSfD2q6/TqKbojRadFwfIZhEGPwb+r1CYPaYpUsSTnwJZiT
 cHM5cS3qCAgKozrkGorzGWl//v7feYeRYGsiyG3ztTWUTAX6Yf+LBjVKekf+VOdWnpjG
 uFZKqYMXvviTPSWCPprDNbRMuT/XzSfAipUas/V+LKgo9HtwBd/ZXQpjz4tJoScHQEeP
 weDagi6a7lsWdyAdRcxAmiqfd+lIEywqIF/XdjWs/dOZle+KtUjeGOV4SFdZui1r+K7a
 otoe3L4BK/czsxLgy+V4gNKdL9yrmp2Kh30tMxTtXo9ssrK9th8a+PZksrBTr4Tfx9BD
 Q+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374726; x=1779979526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2yWVwJxTaScCgj+pdDqJvd1+BNm6/dyL9FgYCmk8UQ=;
 b=qHRdKrBOqVAbu3Wo1E2sLfxnamzmaI1VluHaVc3xaSw/PJapIilF02ZaO1xv0OMFJm
 TIPOe3kqhvd7dtu5qWGlliI92tIHAhmPgz79WEC5rgl+Ual0T7avONTnaZc9k8aX1TPF
 Vf1wDDnx9ihQDZSSP5vUSxLLP7eGqzenzCZkh2M+y2fMomRn5dnTPwIcyAJA3szQZgRJ
 WyKxqRcLHIK8ZPJHAZ1C4X1KZldJb7Sn3tkE6i68U8Vz7RRnvhICkCEI/w2Z5MgYzter
 4mT4CXXyCnF9bhDHmyw+75xto8d+cZCXiwkdqUrVlQ7db9SGcatwi9B3Mu88AdkoDp+X
 ovpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SZcyiuA2liEivomFI7U6NeoLQBx4Vx6opfICr8t5ovKvMMu+1m0IzTuCsb/PVOyiyIArQux1IypM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzky2rJN6tSbFvnYBDvQxmgqPnrLcVw8IYsEcFxrx5E3INictHq
 7adSnUzauC70VltCLbZulMpYrQ0Vyy5JmrMcS8pmyLKf6kZxp2C85C6z
X-Gm-Gg: Acq92OGibRvzlU6wwJJyVe7wr/bseMB1UImP5vBegND6Ts92jlEuSb7KO6GPjn+wfk7
 HS/OsZAV02U2+M5zxL1K9dHsEcg1Gg/XTAcL+EqA7RL7SE7S0QsPzteDUk75sPEjW8+TvYP364O
 pvza+gKUUjJZUi02jYW5sqFoX9tIxQ7Wih6ydDeL3zVae4G9v10WMjeUT3I12bzGwvwsTsKMssc
 KDkgBMS8eA8If4LKyhnNJ1E2Gde7bePITeBBia+R7l2+ro1PyRhslpBoldpD4rilMRylMrn6W5r
 ihSbEk3z5mlr96nzHRoNubU9UMhomIMJzjhkdxcZ7U6GY72p0AtkhuLEele6KzjOE39O0/pJe9H
 CkqxxfpYrGEoBHYRpaxug9yv/1nv26WGY5NWWcwKE0IQsYWUgCNeyqZCoDmwo4cCxvoCIUbPt01
 f/XuACcmh1pDy7kBPBW212vORC166VGAL2YgPOQMjZaZFfsQDFVvgNoRw=
X-Received: by 2002:a05:6000:2403:b0:45e:655d:6f7 with SMTP id
 ffacd0b85a97d-45ea3ae887emr5723344f8f.24.1779374725641; 
 Thu, 21 May 2026 07:45:25 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7da46esm3699744f8f.14.2026.05.21.07.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:45:24 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drm/i915: use 'depends on' with visible DEBUG_OBJECTS for
 DRM_I915_DEBUG and DRM_I915_SW_FENCE_DEBUG_OBJECTS
Date: Thu, 21 May 2026 15:45:18 +0100
Message-ID: <20260521144518.410717-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
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

In this new version of the patch, let's also add the dependency on
DEBUG_OBJECTS to DRM_I915_DEBUG, to prevent the unmet dependency.

This select-visible Kconfig misusage was detected by Kconfirm, a static
analysis tool for Kconfig.

Link 1:
https://lore.kernel.org/all/20260502191932.4491-1-julianbraha@gmail.com/

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/i915/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.53.0

