Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66F6CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205AB10EBD5;
	Thu, 15 Oct 2026 13:13:20 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5572310EBBA
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792069984;
 bh=L2h83T4lcyhaW9RVbgyvT9b940P8kRLls71zQ8BnDEI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h65R+NHCl8iBHPPwp7qZztrCUVWdNrrxN9YkBAPQ3efWvp6tvMTKhDOTINHhhd+w5
 IWpdhWcBRio2GuOd/ByXOlNUaijUvBC+37ieJE6eYfA5Ttv7+RK8ZDSGtbZVMFl+6r
 cwjY/gldHuLkTSqt+BCoGEtalagZFU7e4zIfzreTFy08EdivlcDmxgYAxqGTrZ571y
 0Fyb62cY/kDr7UFBM6HJSzC2UOZiN0G4rNdzWx5DLO+z22BVrULMRKg1iPrd0iSgdJ
 Tp5I/8J+gB+VK0fIUuczGPUrtMqP96gWQe14H+AUWKzighVID+2LLWxbTYzj0U8K6p
 7bVlrpXctXOhQ==
Received: from reinforced (unknown [100.64.0.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: daniels)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B4F6317E020C;
 Thu, 15 Oct 2026 15:13:03 +0200 (CEST)
From: Daniel Stone <daniels@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: boris.brezillon@collabora.com, laura.nao@collabora.com,
 adrian.larumbe@collabora.com, daniel.almeida@collabora.com,
 liviu.dudau@arm.com
Subject: [PATCH 1/2] drm/panthor: Add neural-engine presence and power bits
 for v14+
Date: Thu, 15 Oct 2026 14:10:40 +0100
Message-ID: <20261015131301.711153-2-daniels@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015131301.711153-1-daniels@collabora.com>
References: <20261015131301.711153-1-daniels@collabora.com>
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

Mali v14+ can optionally feature a neural engine. This is not currently
used by Panthor, but add the bare-minimum bits required to detect the
engine's presence and control its power.

Signed-off-by: Daniel Stone <daniels@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu_regs.h | 1 +
 drivers/gpu/drm/panthor/panthor_hw.h       | 6 ++++++
 drivers/gpu/drm/panthor/panthor_pwr_regs.h | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 4c5b953796e4f..5340966caef37 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -67,6 +67,7 @@
 
 #define GPU_FEATURES					0x60
 #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
+#define   GPU_FEATURES_NEURAL_ENGINE			BIT(4)
 #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
 
 #define GPU_TIMESTAMP_OFFSET				0x88
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index f797663893b2d..924faea27061a 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -61,4 +61,10 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
 }
 
+static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
+{
+	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
+	        ptdev->gpu_info.gpu_features & GPU_FEATURES_NEURAL_ENGINE);
+}
+
 #endif /* __PANTHOR_HW_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index 9cf7a715066f8..80d8e1e522298 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -20,12 +20,14 @@
 #define   PWR_STATUS_ALLOW_L2				BIT_U64(0)
 #define   PWR_STATUS_ALLOW_TILER			BIT_U64(1)
 #define   PWR_STATUS_ALLOW_SHADER			BIT_U64(8)
+#define   PWR_STATUS_ALLOW_NEURAL			BIT_U64(9)
 #define   PWR_STATUS_ALLOW_BASE				BIT_U64(14)
 #define   PWR_STATUS_ALLOW_STACK			BIT_U64(15)
 #define   PWR_STATUS_DOMAIN_ALLOWED(x)			BIT_U64(x)
 #define   PWR_STATUS_DELEGATED_L2			BIT_U64(16)
 #define   PWR_STATUS_DELEGATED_TILER			BIT_U64(17)
 #define   PWR_STATUS_DELEGATED_SHADER			BIT_U64(24)
+#define   PWR_STATUS_DELEGATED_NEURAL			BIT_U64(25)
 #define   PWR_STATUS_DELEGATED_BASE			BIT_U64(30)
 #define   PWR_STATUS_DELEGATED_STACK			BIT_U64(31)
 #define   PWR_STATUS_DELEGATED_SHIFT			16
@@ -48,6 +50,7 @@
 #define   PWR_COMMAND_DOMAIN_L2				0
 #define   PWR_COMMAND_DOMAIN_TILER			1
 #define   PWR_COMMAND_DOMAIN_SHADER			8
+#define   PWR_COMMAND_DOMAIN_NEURAL			9
 #define   PWR_COMMAND_DOMAIN_BASE			14
 #define   PWR_COMMAND_DOMAIN_STACK			15
 #define   PWR_COMMAND_SUBDOMAIN_RTU			BIT(0)
@@ -68,6 +71,10 @@
 #define PWR_SHADER_READY				0x208
 #define PWR_SHADER_PWRTRANS				0x210
 #define PWR_SHADER_PWRACTIVE				0x218
+#define PWR_NEURAL_PRESENT				0x240
+#define PWR_NEURAL_READY				0x248
+#define PWR_NEURAL_PWRTRANS				0x250
+#define PWR_NEURAL_PWRACTIVE				0x258
 #define PWR_BASE_PRESENT				0x380
 #define PWR_BASE_READY					0x388
 #define PWR_BASE_PWRTRANS				0x390
-- 
2.47.3

