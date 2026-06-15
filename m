Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2096CD98EF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65D610E67C;
	Mon, 15 Jun 2026 20:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="Rci3VHpa";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032FF10E682;
 Mon, 15 Jun 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1781554726;
 bh=/Fm27havni7MNlmsXqPxuEk9ti8anXosMDlKd+HcKVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rci3VHpaTFaPvxPUSKRvdMqrwaUFfWdrltZYwsuE8l+teXxrO+lijPL3XqkpQzz2p
 t2CkZZpjTlcYTmAo96j/8T1H94J7hrnNDPJcTLfD8nbzCkIZM4XS8ct605r31yVvj4
 RAowckRwyRaIPPGABbmyRy73xfTpAzGV3JnamtSB0F+25NhCd5fWoXMHPqeC14N6ZP
 YkraVpJRHH+xIfp5Z2py+uxaLzX6LoOuiKhV9s4Xe14kV46ovXdq/OJZmSHSJy2jFG
 m4awEzoi0oqlyfKcGYuUhl394Far5cDg0mTwpcTyALD/l591WeeAwYkacmaRMJ/FEa
 RwA4DJ4VtatRg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v8 23/27] PREEMPT_RT injection
Date: Mon, 15 Jun 2026 22:18:41 +0200
Message-ID: <20260615201846.307297-24-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615201846.307297-1-dev@lankhorst.se>
References: <20260615201846.307297-1-dev@lankhorst.se>
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

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/Kconfig.debug | 15 ---------------
 drivers/gpu/drm/xe/Kconfig.debug   |  5 +++++
 kernel/Kconfig.preempt             |  4 ++--
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 52a3a59b4ba2c..5977d0b262b85 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -233,21 +233,6 @@ config DRM_I915_LOW_LEVEL_TRACEPOINTS
 
 	  If in doubt, say "N".
 
-config DRM_I915_DEBUG_VBLANK_EVADE
-	bool "Enable extra debug warnings for vblank evasion"
-	depends on DRM_I915
-	default n
-	help
-	  Choose this option to turn on extra debug warnings for the
-	  vblank evade mechanism. This gives a warning every time the
-	  the deadline allotted for the vblank evade critical section
-	  is exceeded, even if there isn't an actual risk of missing
-	  the vblank.
-
-	  Recommended for driver developers only.
-
-	  If in doubt, say "N".
-
 config DRM_I915_DEBUG_RUNTIME_PM
 	bool "Enable extra state checking for runtime PM"
 	depends on DRM_I915
diff --git a/drivers/gpu/drm/xe/Kconfig.debug b/drivers/gpu/drm/xe/Kconfig.debug
index 01227c77f6d70..1d5f11c6e88f3 100644
--- a/drivers/gpu/drm/xe/Kconfig.debug
+++ b/drivers/gpu/drm/xe/Kconfig.debug
@@ -30,6 +30,11 @@ config DRM_XE_DEBUG
 
 	  If in doubt, say "N".
 
+config DRM_I915_DEBUG_VBLANK_EVADE
+        def_bool y
+        depends on DRM_XE
+
+
 config DRM_XE_DEBUG_VM
 	bool "Enable extra VM debugging info"
 	default n
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 88c594c6d7fcd..11bec9be95405 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -90,9 +90,9 @@ config PREEMPT_LAZY
 endchoice
 
 config PREEMPT_RT
-	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !COMPILE_TEST
+	def_bool y
 	select PREEMPTION
+	depends on ARCH_SUPPORTS_RT
 	help
 	  This option turns the kernel into a real-time kernel by replacing
 	  various locking primitives (spinlocks, rwlocks, etc.) with
-- 
2.53.0

