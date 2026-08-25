Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF51C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44BB10E164;
	Tue, 25 Aug 2026 08:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jqjEExv1";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8117F10E164
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787644891;
 bh=3TNOGAvccl1TNM4QLXC4SAQP/XgcNL1NcuiVhIv6acY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jqjEExv1yRgbzcqmG3c6mTwpDjpjt9+MCqI/N7wrxpN3FX2Ih7geQugjgvYaGADoG
 /dQ9a/n8S/yf0DxzRW+gHUGvqy5ZCZr9WYSmCLEl2vxN8x8+QRNFBWVeiqcXuDExsU
 t9W05MufbAv41WhD+frIjfao565B5sIaokWhFmd2gt3WjxgA+/kKezKnT7+l09Fxf0
 dI4em34JYfq8dglgqmBpKZTcMJtTkNB4zAKCWug0z+YevvzcnqKHN+6xj08bB/rdbU
 k4naWUbMyoAJdj+k8JuqeGC1u0lljSk+l2Ge/4hLGy+AW3JS8uYNI5oHkYD0I/TJQZ
 G3xDKUnOivhAA==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D388617E0A44;
 Tue, 25 Aug 2026 10:01:30 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 25 Aug 2026 10:01:23 +0200
Subject: [PATCH v7 2/9] drm/panthor: Move the register accessors before the
 IRQ helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-panthor-signal-from-irq-v7-2-ebb5b4c891a4@collabora.com>
References: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
In-Reply-To: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787644889; l=5742;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=3TNOGAvccl1TNM4QLXC4SAQP/XgcNL1NcuiVhIv6acY=;
 b=cOqPPUrWWQeam95HTNZ50Oj9j0jB/5K8eMsprxS451xd44L6/vwk2DHZEX+k8hR9FtssNZbAV
 S82w9X0KawjDK6NrAjla7NWVSr10SPXptxfo7jVAIGHe6RIgwR6oPag
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

We're about to add an IRQ inline helper using gpu_read(). Move things
around to avoid forward declarations.

No functional changes.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 142 +++++++++++++++----------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4e5f7b0fb53f..b102ea77fd1a 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -495,6 +495,77 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
+static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+{
+	writel(data, iomem + reg);
+}
+
+static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+{
+	return readl(iomem + reg);
+}
+
+static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+{
+	return readl_relaxed(iomem + reg);
+}
+
+static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+{
+	gpu_write(iomem, reg, lower_32_bits(data));
+	gpu_write(iomem, reg + 4, upper_32_bits(data));
+}
+
+static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read_relaxed(iomem, reg) |
+		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+{
+	u32 lo, hi1, hi2;
+	do {
+		hi1 = gpu_read(iomem, reg + 4);
+		lo = gpu_read(iomem, reg);
+		hi2 = gpu_read(iomem, reg + 4);
+	} while (hi1 != hi2);
+	return lo | ((u64)hi2 << 32);
+}
+
+#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				     timeout_us)				\
+	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				       timeout_us)				\
+	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
+					     timeout_us)			\
+	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
+				 timeout_us, false, iomem, reg)
+
+#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
+					timeout_us)				\
+	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
+			  false, iomem, reg)
+
 #define INT_RAWSTAT 0x0
 #define INT_CLEAR   0x4
 #define INT_MASK    0x8
@@ -630,75 +701,4 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 
 extern struct workqueue_struct *panthor_cleanup_wq;
 
-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
-{
-	writel(data, iomem + reg);
-}
-
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
-{
-	return readl(iomem + reg);
-}
-
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
-{
-	return readl_relaxed(iomem + reg);
-}
-
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
-{
-	gpu_write(iomem, reg, lower_32_bits(data));
-	gpu_write(iomem, reg + 4, upper_32_bits(data));
-}
-
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read_relaxed(iomem, reg) |
-		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
-{
-	u32 lo, hi1, hi2;
-	do {
-		hi1 = gpu_read(iomem, reg + 4);
-		lo = gpu_read(iomem, reg);
-		hi2 = gpu_read(iomem, reg + 4);
-	} while (hi1 != hi2);
-	return lo | ((u64)hi2 << 32);
-}
-
-#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				     timeout_us)				\
-	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				       timeout_us)				\
-	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
-					     timeout_us)			\
-	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
-				 timeout_us, false, iomem, reg)
-
-#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
-					timeout_us)				\
-	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
-			  false, iomem, reg)
-
 #endif

-- 
2.55.0

