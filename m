Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F64CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2752710F58A;
	Fri,  8 May 2026 18:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="OGb1f0YQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633DA10F58A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 18:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778263269; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PtB3ZH80n42n+Bp+P5Zy26YYguToujaWF5B4xu6w4kSXSl5MnGFXTzveisYK24etBod1qKv/LxymfsMtIQq06hU7vb5ALbZlij/0xqwWPCRY6vGLb4hB0wosul25WvpnxG0qUw9+N7bUZkjnX8tQQrs/OsUYyS0C/adDaRgObKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778263269;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Wjaprlpdu7+O/Bv7e0063yo9+rhSin/QGk4R3K0MOe0=; 
 b=SMIX6toDmy7GZ36onFMhMuiyXl6bz97iZFvWCIjAnyWD2YARl9AnjwJdj9R0KLsrGyIfabo6O+fddGEjYTNibedOHU6KFIJbrJeaFyFoeuknZ5TB4WfFnb8Pm4XcKYCqfBr8r0tKbzQkq/qhyq8I68Ju6MFtOUOog3hgjBcyu1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778263269; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=Wjaprlpdu7+O/Bv7e0063yo9+rhSin/QGk4R3K0MOe0=;
 b=OGb1f0YQGTt/e6B8LQw/V0NpB6ITnj6iboJSAcYwkYoZAtWr1z0k0R4kPdmaNG0r
 KLQTClL66I9hVAs6JEgQOp+WmEfOG0mDPevC1zs0BSnc0RaARetitvIQSMiwAG/wOOL
 9zPYnSkL3KtFjmMRnV5syZZUefN+35pczF+DZGOs=
Received: by mx.zohomail.com with SMTPS id 1778263269089825.9171425113387;
 Fri, 8 May 2026 11:01:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 08 May 2026 20:00:54 +0200
Subject: [PATCH] drm/panthor: Wrap register accessor helpers for type
 safety
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-panthor-gpu-read-type-v1-1-733a9d8b3a11@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBBFr0Jm7SQFRAxXMSxKO4WatNRpMRjC3
 S3i8iXvv79BJLYUoSs2YHrbaGefobwUoCbpR0KrM0MlqptoxB2D9GmaGcewIJPUmD6BsJWqNsb
 osroqyNvAZOz66z76k+MyPEmlI/Y3mF5LPkynBoOMhGp2zqau0OzQ2ajQ05rweEfRoGih3/cv1
 Ycjt7UAAAA=
X-Change-ID: 20260508-panthor-gpu-read-type-7ac3fffd124c
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

In Commit a8f5738779a9 ("drm/panthor: Pass an iomem pointer to GPU
register access helpers"), the gpu register access helpers were changed
from taking a pointer to a struct panthor_device in their first
argument, to taking a void pointer.

This can cause problems, as patches based on panthor before this change
will still compile fine after it. struct panthor_device * implicitly
casts to a void pointer, resulting in completely wrong semantics.

Prevent this problem by wrapping the affected functions with macros that
specifically check for and reject the struct panthor_device * type as
the first argument.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 68 +++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4e4607bca7cc..91e9f499bf69 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -630,49 +630,87 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 
 extern struct workqueue_struct *panthor_cleanup_wq;
 
-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+static inline void _gpu_write(void __iomem *iomem, u32 reg, u32 data)
 {
 	writel(data, iomem + reg);
 }
 
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+static inline u32 _gpu_read(void __iomem *iomem, u32 reg)
 {
 	return readl(iomem + reg);
 }
 
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+static inline u32 _gpu_read_relaxed(void __iomem *iomem, u32 reg)
 {
 	return readl_relaxed(iomem + reg);
 }
 
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+/*
+ * The function signature of gpu_read/gpu_write/gpu_read_relaxed/... used to
+ * take a &struct panthor_device* as the first parameter. During the split of
+ * iomem ranges into individual sub-components, this was changed to take a
+ * void __iomem* instead. These wrappers exists Tto avoid situations wherein
+ * pre-refactor patches are applied in error, as they'd compile fine. That's
+ * because the old calling convention's first parameter implicitly casts to a
+ * void pointer.
+ */
+
+#define gpu_write(iomem, reg, data) ({					\
+	static_assert(!__same_type((iomem), struct panthor_device *));	\
+	_gpu_write((iomem), (reg), (data)); })
+
+#define gpu_read(iomem, reg) ({						\
+	static_assert(!__same_type((iomem), struct panthor_device *));	\
+	_gpu_read((iomem), (reg)); })
+
+#define gpu_read_relaxed(iomem, reg) ({					\
+	static_assert(!__same_type((iomem), struct panthor_device *));	\
+	_gpu_read_relaxed((iomem), (reg)); })
+
+static inline void _gpu_write64(void __iomem *iomem, u32 reg, u64 data)
 {
-	gpu_write(iomem, reg, lower_32_bits(data));
-	gpu_write(iomem, reg + 4, upper_32_bits(data));
+	_gpu_write(iomem, reg, lower_32_bits(data));
+	_gpu_write(iomem, reg + 4, upper_32_bits(data));
 }
 
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+#define gpu_write64(iomem, reg, data) ({				\
+	static_assert(!__same_type((iomem), struct panthor_device *));	\
+	_gpu_write64((iomem), (reg), (data)); })
+
+static inline u64 _gpu_read64(void __iomem *iomem, u32 reg)
 {
-	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+	return (_gpu_read(iomem, reg) | ((u64)_gpu_read(iomem, reg + 4) << 32));
 }
 
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+#define gpu_read64(iomem, reg) ({					\
+	static_assert(!__same_type((iomem), struct panthor_device *));	\
+	_gpu_read64((iomem), (reg)); })
+
+static inline u64 _gpu_read64_relaxed(void __iomem *iomem, u32 reg)
 {
-	return (gpu_read_relaxed(iomem, reg) |
-		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+	return (_gpu_read_relaxed(iomem, reg) |
+		((u64)_gpu_read_relaxed(iomem, reg + 4) << 32));
 }
 
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+#define gpu_read64_relaxed(iomem, reg) ({				\
+	static_assert(!__same_type((iomem), struct panthor_device *));	\
+	_gpu_read64_relaxed((iomem), (reg)); })
+
+static inline u64 _gpu_read64_counter(void __iomem *iomem, u32 reg)
 {
 	u32 lo, hi1, hi2;
 	do {
-		hi1 = gpu_read(iomem, reg + 4);
-		lo = gpu_read(iomem, reg);
-		hi2 = gpu_read(iomem, reg + 4);
+		hi1 = _gpu_read(iomem, reg + 4);
+		lo = _gpu_read(iomem, reg);
+		hi2 = _gpu_read(iomem, reg + 4);
 	} while (hi1 != hi2);
 	return lo | ((u64)hi2 << 32);
 }
 
+#define gpu_read64_counter(iomem, reg) ({				\
+	static_assert(!__same_type((iomem), struct panthor_device *));	\
+	_gpu_read64_counter((iomem), (reg)); })
+
 #define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
 	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
 			  iomem, reg)

---
base-commit: 3c253a3bef01b39d4640cfe3dfd38d8d5557ae0c
change-id: 20260508-panthor-gpu-read-type-7ac3fffd124c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

