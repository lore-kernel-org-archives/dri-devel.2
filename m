Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0073410F6FDB
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 22:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660F810E056;
	Wed,  1 Apr 2026 22:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="owZatc1a";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7518110E056
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 22:07:02 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso790647c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775081222; x=1775686022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rRronI06lIok0fDejOYVVuN665UjtkDK5qK1tzC967Q=;
 b=owZatc1a5OSkaRU5gTA2rQgHBqXTeScVi5YVcDHxMa4w+/K1DXV6xXq4alpbw5XgB/
 PUZzRJptGISQByBGdI3uPvfbR08BXim6DY13sKXAGTS+ePWCZ/ghada9Zo6u9XeHBFZ4
 xB4m6WSG0wAKzVJuQOkDMM39vuEjBJsLJs4TmMNRLE0l2lWOvug6OkwlQ4wT6m2mYkxw
 KhEhYGH6pCLGjoMYEPpKQ8YW7J3LH7sDM8VvPnGHwaPc75MAxmFJQyIqzzacTzRNrui1
 KOtwVyKDpFKmpA8CfDXCfwiFPLw3+tFH0HPlu0VXe/RUpIdTXHWPQHU1h53af3EHn55I
 L6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081222; x=1775686022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRronI06lIok0fDejOYVVuN665UjtkDK5qK1tzC967Q=;
 b=HzAZDyVt+z9OSz6ttXQbb9vYd49Tk9YOxyhv/DyPvx3wZzuc0ZQSwg2LD6xnp7j1MU
 IsWumigoH9VicOztuxT9gh/IPrr4LwXG/rc/d1mnJb+34timjYCt03aKZYS92INJ/eLj
 2DjLKTCI8BA45rJ/JHrFha/RmYCTi/VkctFk+aSgvbs2JPA5mBn2wJ3K0ixJZC0koE9j
 nyVtMyTCeqnVLDbXytBkJS4/F5s8UkNma6qsTy0O601CP3Yt2bQAYojPuYLdVhSe1L5S
 kDK1NKzSs7J4AZUrrrPVvqfnB2llICfUwuJYC/TV9wPIoLsdGn6wYkQ7TjNkcD2cLHNt
 7azA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4vzJOs3xXRNE+BMTKdTce9tssmrElOV1E2eFN9T4EUjnJmuS9UQMcpWrCFBq4CTrbZLXSsWhrOyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiedxKlyHp76OR6prW6GTN8HQqPYv7TyoCCvbFj8bBhGqsdbk8
 OFmixplF1e3dNe+ObjAQnFxZH0q5EkXrXieBW3m2T9+t0CmPAfohfOfJ
X-Gm-Gg: ATEYQzzFzbF2UWhdE4MZ6qS75tOjd2xkjgXimpNGPSck5K9HiS02o13b1Tkz8gNLSGR
 4fCUJyMQ405YFuSaUtNcUQeU9JjCVjDtizaBYyUseEn5sox+XCKyqyiypqO2OVIP9ieuMbxhlxL
 xdFYUhm03Z+7+9z4Gc61k2w80dz9+Xpr54o+7C9+6MsU5leu6KtTwvsxDgRvzxbwG9yVi9dPen/
 UDwS4GodlBJ+8PrfJtZhMiZXQIyL/27BrnfmPXTOERmh9anA5M+dPg2qZRkHPJcJgbE69q30/uf
 stDrf/geDFK4w0LThqkzeZywvMK57x1cJr43WDCPj57CBC4iS0bwycFisqOXJGHQ0VllfTcBlrq
 lSh9VV2ddik2YAc28JyvVF06IihRmJUyoOlPmVKzDcNAgJyYYns2C3vLV8BOSel0Go38t6z6KHV
 VIFc5JtCl2+k6AAzasgFTeQBjODzxo3ZotPtu6XJEHCbsgJY7TpQI4EvEA3dD+OVjVCg==
X-Received: by 2002:a05:7022:698b:b0:12a:7165:7405 with SMTP id
 a92af1059eb24-12be640d75amr3359834c88.8.1775081221588; 
 Wed, 01 Apr 2026 15:07:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede54ba8sm1605984c88.10.2026.04.01.15.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 15:07:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:QUALCOMM CLOUD AI (QAIC) DRIVER),
 linux-kernel@vger.kernel.org (open list),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
Date: Wed,  1 Apr 2026 15:06:43 -0700
Message-ID: <20260401220643.12802-1-rosenp@gmail.com>
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

Consolidate the two-element allocation into a single allocation using a
flexible array member. This reduces memory fragmentation and simplifies
the error path by eliminating the need to check for allocation failure
between the two allocations.

Add __counted_by for runtime bounds checking.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use macro for number of elements. reword commit message.
 drivers/accel/qaic/qaic.h     | 4 ++--
 drivers/accel/qaic/qaic_drv.c | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
index fa7a8155658c..e237020f6aa9 100644
--- a/drivers/accel/qaic/qaic.h
+++ b/drivers/accel/qaic/qaic.h
@@ -152,8 +152,6 @@ struct qaic_device {
 	struct list_head	cntl_xfer_list;
 	/* Synchronizes MHI control device transactions and its xfer list */
 	struct mutex		cntl_mutex;
-	/* Array of DBC struct of this device */
-	struct dma_bridge_chan	*dbc;
 	/* Work queue for tasks related to MHI control device */
 	struct workqueue_struct	*cntl_wq;
 	/* Synchronizes all the users of device during cleanup */
@@ -206,6 +204,8 @@ struct qaic_device {
 	void			*ssr_mhi_buf;
 	/* DBC which is under SSR. Sentinel U32_MAX would mean that no SSR in progress */
 	u32			ssr_dbc;
+	/* Array of DBC struct of this device */
+	struct dma_bridge_chan	dbc[] __counted_by(num_dbc);
 };

 struct qaic_drm_device {
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 63fb8c7b4abc..1dda8dfea5a4 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -43,6 +43,7 @@ MODULE_IMPORT_NS("DMA_BUF");
 #define QAIC_DESC			"Qualcomm Cloud AI Accelerators"
 #define CNTL_MAJOR			5
 #define CNTL_MINOR			0
+#define DBC_NUM				16

 struct qaic_device_config {
 	/* Indicates the AIC family the device belongs to */
@@ -405,15 +406,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 	struct drm_device *drm;
 	int i, ret;

-	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
+	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, DBC_NUM), GFP_KERNEL);
 	if (!qdev)
 		return NULL;

+	qdev->num_dbc = DBC_NUM;
 	qdev->dev_state = QAIC_OFFLINE;
-	qdev->num_dbc = 16;
-	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
-	if (!qdev->dbc)
-		return NULL;

 	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
 	if (IS_ERR(qddev))
--
2.53.0

