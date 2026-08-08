Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E7EC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7AA10E69D;
	Mon, 10 Aug 2026 06:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JBR69Q6v";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D799810E092
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 23:10:02 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so345108a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786230602; x=1786835402; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rH2W1wopjxMu7bNPTu3XbUp0wkIuNWweLs/V8E2Ud3Y=;
 b=JBR69Q6vZ+ZTMB80/fmJRzOSvCKn7+zLH7BuRa2xy15EYx26xRxdD/QxBbCVnpPTP6
 fN3MIsnF1LGzoqRx6bbvZxE/eGMBjGsRIppM65Sjk/4PvGKEzjvH2052Q3d3c9ObTTt5
 rhCL97lK5/bBPN6BwOEoxdrHnC9InqNnLrHpBY2W2nopWqpW7ntkGYcV7L9FxUjN5DkN
 W1QAlm2hdf7YmIAvfJB+GQrGXR2bG5nkyGzpjUZoMzjoqFbNcocuf1B5OtSnoWIclMwZ
 tg4XC00FaWKr4347CfgVeWejsKWZaCGFGHtkmzSOvp3+jkN00qhBhKB4X/5CesShp4Ju
 FvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786230602; x=1786835402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rH2W1wopjxMu7bNPTu3XbUp0wkIuNWweLs/V8E2Ud3Y=;
 b=rgMzmcRhUgyZnvQNhWantnbUC1hq2VXWsS1WUrKySlnfDLSMYYPFNhlXkoZdr1epoq
 9Mjeay7RjNClLgHNcryy0zdpqPFiX+bsK/J2cOsFIWuaOMhF5ObYOliINSk8wjk7fSDT
 jF8BLf41OQ64MomiyaBAmwZebOE7zpgeBS4eKWQMkqjHwF1o46HKqhOD5lkAECyo81q0
 mb9zoH8QO5C7WMFqz6WFgwTHU02r3WEYppHN7oXuK8byRV76NzNsAcpXi+4Ta73o+cQw
 kr8N/rJfJBhk7JKwMfx23vqgS31q8+glpvVOUomm2P8/36u4gDXvhG1pO2w2qUJhhph8
 jNaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCjXaiwAo6KtK9RfDt7dIghGBDxb6mAWTcPI53X1rJ6SdLH6ztgylmhMPtpaTLRUUXRlVui+5kyEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXm4SMw41TebOXFF5OdT+dsuA4GPwOSLOImQQgqi8f2ToG6Lff
 yNxBzH6Jsq6oqf9WUVxLvZmhJVWKcK1EGTP7ql7m3dcTwLCyUh6Ec98G
X-Gm-Gg: AR+sD10/nZclHNMeJPLHSBWN6FBzWjfm2qbVimkvmcBHNvNS51KPL1JCCjyd3R1ObfK
 SYyWYwAJ1+MzWJ5uTO3pysPoy6sZ/KyE2ozyyMjDZu55SrtVS7mgQfK22l+HMTfweMK8KRKY9JN
 /mF4LRX3XD3kJbMDNDPOOy840dtSuK0J+TCNu81H/7YeU2rlUtPxzxCJJiYLrqxTw5CzsfOnHJZ
 P/hnJZwtGvlB6cAcNoFTny8sDABY9SHGwKzlBEKCyfW3qsZf+nN8T6O/kNGezPYf9w51enrSg7a
 exTi7XAcvA/IfvVKfolAjY2bb9nthyvGmE91SjnpemKzF7E7jMzfgBhP5KjVS6RFPe9Z5hUfg45
 7Qhce4KHEyCeGmWoG8rQWPQ9JjNgez1/qTFbXXogRAYG2uP8Ah7hTZumqdEqUp38IVZaWH+DqcD
 qzVr2UwjWlv0BqZHgIC0wvkjkizWU8GxZ5Dq4fEn3/iNa1N0q40Q0n
X-Received: by 2002:a05:6a20:9c17:b0:3c4:397a:69b0 with SMTP id
 adf61e73a8af0-3cbadc17561mr24004662637.21.1786230602271; 
 Sat, 08 Aug 2026 16:10:02 -0700 (PDT)
Received: from beelink.. ([186.22.57.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec26a5dsm23319791eec.26.2026.08.08.16.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 16:10:01 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size
 computation
Date: Sat,  8 Aug 2026 20:09:45 -0300
Message-ID: <20260808230945.67525-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

qxl_alloc_surf_ioctl() works out the backing size of a surface with

	actual_stride = param->stride < 0 ? -param->stride : param->stride;
	size = actual_stride * param->height + actual_stride;

where size and actual_stride are int and param->height is __u32.  Every
operand comes straight from userspace through DRM_IOCTL_QXL_ALLOC_SURF,
which is DRM_AUTH, and the expression is evaluated modulo 2^32 with no
overflow check.

The wrapped value is what reaches qxl_bo_create(), which only rounds it
up to a page.  The original width, height and stride are kept verbatim
in bo->surf and are later handed to the device by qxl_hw_surface_alloc()
together with the address of that undersized allocation, so the driver
tells the host about a surface far larger than the memory backing it.

For example stride=4096, height=1048576 gives
4096 * (1048576 + 1) = 0x1_0000_1000, which truncates to 4096: a
one-page buffer object described to the device as a 4 GiB surface.
Measured on 6.12.101 by probing mmap() lengths against the resulting
GEM object, the backing is 4096 bytes while the surface declared to the
device is 4294967296 bytes.

Two smaller problems are fixed at the same time.  Negating param->stride
is undefined for INT_MIN, and unlike QXL_ALLOC there is no rejection of
a zero-sized request.

Compute the size in a type that cannot wrap, reject INT_MIN and zero
dimensions, and bound the result so it still fits the int parameter of
qxl_gem_object_create().

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -23,6 +23,7 @@
  *          Alon Levy
  */
 
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
@@ -386,12 +387,26 @@
 	struct drm_qxl_alloc_surf *param = data;
 	int handle;
 	int ret;
-	int size, actual_stride;
+	int actual_stride;
+	size_t size;
 	struct qxl_surface surf;
 
 	/* work out size allocate bo with handle */
+	if (param->stride == INT_MIN)
+		return -EINVAL;
 	actual_stride = param->stride < 0 ? -param->stride : param->stride;
-	size = actual_stride * param->height + actual_stride;
+	if (!actual_stride || !param->width || !param->height)
+		return -EINVAL;
+	/*
+	 * size = actual_stride * (height + 1), evaluated in a type that cannot
+	 * wrap, then bounded so it survives the int parameter of
+	 * qxl_gem_object_create().
+	 */
+	if (check_mul_overflow((size_t)actual_stride,
+			       (size_t)param->height + 1, &size))
+		return -EINVAL;
+	if (size > INT_MAX)
+		return -EINVAL;
 
 	surf.format = param->format;
 	surf.width = param->width;
