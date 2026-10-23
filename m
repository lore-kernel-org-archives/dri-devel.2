Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF2606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cGcwHn5u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA81E10E630;
	Fri, 23 Oct 2026 12:53:29 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A72310E630
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792760002;
 bh=u+hodaTxkk4y6cSxya0oKZjkT/WivaoVw460vYfXpfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cGcwHn5usQM2dsCvG3Gz+IAd4NZXA6L6wMI3HV6QQjoKXCRNJqxfyHNS2edyJ/rw8
 Z8AqL5aCceISt9VnIPTMzE2vvLXgMMXsM6jQ0hSmmjhOFB8fmNCxbyhMHkZrXmAd6L
 yOXAa0Qk2aXu3yjgxi6NoroMYaqydabUXsSuaOjkDzX0srekLmBoNLJNWISKPqajCZ
 qNWEz8WmBLaeoilY/0cJwpHwgn/9c/0d6UQ5/PJrT/+ZKqbWUSLKe32PQnpL7kqNQv
 prfMbHIDoS5HVhhAyd5WcKWW78Z1/zqS8IPF1zV3Ny0UsDu7gPFxV+pC4ADB6+FZHQ
 ZGr2VAjwutJ1g==
Received: from reinforced (unknown [100.64.0.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: daniels)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D8D5017E0411;
 Fri, 23 Oct 2026 14:53:21 +0200 (CEST)
From: Daniel Stone <daniels@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: boris.brezillon@collabora.com, laura.nao@collabora.com,
 adrian.larumbe@collabora.com, daniel.almeida@collabora.com,
 liviu.dudau@arm.com
Subject: [PATCH v3 1/2] drm/panthor: Add neural-engine presence and power bits
 for v14+
Date: Fri, 23 Oct 2026 13:53:11 +0100
Message-ID: <20261023125319.35905-2-daniels@collabora.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023125319.35905-1-daniels@collabora.com>
References: <20261023125319.35905-1-daniels@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mali v14+ can optionally feature a neural engine. This is not currently
used by Panthor, but add the bare-minimum bits required to detect the
engine's presence and control its power.

Signed-off-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---

v3: No change.

v2: No change.

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

