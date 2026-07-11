Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2FBC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 14:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF5510E02F;
	Sat, 11 Jul 2026 14:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="XjOct0D2";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2876110E02F
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 14:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783781328; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BH4dZUWFXQTfpBTQhaOCxYSOrJSIBoAMYPL0GW2hOvxf8SPFEl3Jaz/BLUiAaj+YfT4mmi0BJKs0xDW7qcFSEn/NuISdleLOwOspZtx1lSCrkl5WkP2L6aGxdK4nswV6YvI7MZ+Vjs8wCBZJmm3on2Poj+K9s8ExjZDMiN6xaoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783781328;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kGHh/6tYI5CXdwmaq9gUtobNs8A8Brc1JnxMpe3H3lc=; 
 b=kscEkUlWDfYiPizyVcRM2SqCMaGPorOa1/2xfEC/oLBE9CmvrWgDCM9Wa4B/xLYvFP94zbCZRobizZETbC8R4XIyxog1/mQHqHZMGAj4a0QJG+A5qJdXsy6l/R5zpBgQCtBY41snFaMtJ/inbXYfSXiyo/wxUe91yEGOQeFlQc8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783781328; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=kGHh/6tYI5CXdwmaq9gUtobNs8A8Brc1JnxMpe3H3lc=;
 b=XjOct0D2Ll/nKAqt2RjQ+kSHU589TeaBxWRRs6xjdGy6+gpcnFZ/7kuq8FefC1ho
 o40rOta3xUV1OIgsZs8owLfrX0PyKtKO7HbD1sm/kgzZUl4+DY9jSy5mO2Qp6OfXlof
 nscyEV5UGpn1hAMcyZ2+X4qYIUq18BQHecMkNs2U=
Received: by mx.zohomail.com with SMTPS id 1783781326029184.89565228296215;
 Sat, 11 Jul 2026 07:48:46 -0700 (PDT)
From: Robert Mader <robert.mader@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Robert Mader <robert.mader@collabora.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dma-buf/udmabuf: Introduce
 CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
Date: Sat, 11 Jul 2026 16:48:12 +0200
Message-ID: <20260711144814.8205-1-robert.mader@collabora.com>
X-Mailer: git-send-email 2.55.0
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

As udmabuf increasingly enjoys popularity - being used in projects like
libcamera, Gstreamer, Mesa and KWin - users more frequently encounter
cases where the current default size limit of 64MB is too low. Examples
include allocating video buffers at a 8K resolution - and even 4K is
affected when using non-subsampled video formats or high bit depths.

While the limit can already be changed via the kernel command line,
exposing it as a kernel config makes that easier and more discoverable
for distros. Thus let's do that.

Signed-off-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/dma-buf/Kconfig   | 6 ++++++
 drivers/dma-buf/udmabuf.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 7efc0f0d0712..35f0779cdc80 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -40,6 +40,12 @@ config UDMABUF
 	  A driver to let userspace turn memfd regions into dma-bufs.
 	  Qemu can use this to create host dmabufs for guest framebuffers.
 
+config UDMABUF_SIZE_LIMIT_MBYTES
+	int "Size limit in Mega Bytes"
+	default 64
+	help
+	  Maximum size of a udmabuf, in megabytes. Default is 64.
+
 config DMABUF_DEBUG
 	bool "DMA-BUF debug checks"
 	depends on DMA_SHARED_BUFFER
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index bced421c0d65..a83153326362 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -20,7 +20,11 @@ static int list_limit = 1024;
 module_param(list_limit, int, 0644);
 MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
 
+#ifdef CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
+static int size_limit_mb = CONFIG_UDMABUF_SIZE_LIMIT_MBYTES;
+#else
 static int size_limit_mb = 64;
+#endif
 module_param(size_limit_mb, int, 0644);
 MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 64.");
 
-- 
2.55.0

