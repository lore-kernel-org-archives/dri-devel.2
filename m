Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D59BFB5E90
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 00:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCA210E146;
	Tue, 17 Mar 2026 00:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXYEtCWg";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C2210E146
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 00:30:52 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so4828910b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773707452; x=1774312252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PMczMzhV3A2GonGYjmIFHjc1BY+/VEDhWUtNnoc7Cvo=;
 b=OXYEtCWgnK8G10o8ijAF0BWLaMWPSmsubL3GKmtoq1FRKn805MzI8e77F3kqwyIJBJ
 XyEEiMbLe2L7Q0tvXdvgQV49coHEm+dLtwV4hlFJC9Bvm4dg8YBBNW6sdq8kRdoku3iW
 MgFaprSaKMdV5iHylCTlOY2N9HFID1vUBHxdo2b1oVO3Jwi7gJcEo/9+F96kKKXde4vK
 rI7qo8PZ4WhLvomyFH3ZPIOcDYuRWb5eCB3SIj4+mV45dtWsP5ESJtFdtPJ5fHvmbWHr
 uAz0iwZgrhZ12x5yn/zQQBsd2kMHdCUjANa977+2poiejChqpzur4Gj0oRvYv7FXV3Wk
 rHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773707452; x=1774312252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMczMzhV3A2GonGYjmIFHjc1BY+/VEDhWUtNnoc7Cvo=;
 b=hLW1mLI46czRX6G5Kwh0NwPgCKFfmadCkgjjMg05P17G2iG+NH37Hdk6sln2EbLzk8
 twaG1sa2OnzoqPk/J3QdQV50dMYj+Hcch16S+IqoeWyk3b1rkbDC61lQ7Lm9i9c0s+wQ
 iu5uD4oR2oK4b1pwcSG0kAnhJMkgZD1jc9NNAIwfm+HfCLW5i982bD88c4Y65f3OR+Yc
 Ghj9p1HIvux4xZAx0wLTthyha9Mzriohk4XDNAG+I4oPvQdXXp7RhaemcOxG++5lnTxO
 TTjyj6omYIzfZkw8zOUGFrWM+JUhxrx5VOtLrxbie1P1fyovXejLmeBmw43I0PXyh3LD
 IRjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZe9lE4OzsxsRhtjTrMRwS7KJXfk6G19tRXfWztvs0aTARfeMUMrsj10mdCEJA6bdx+4tg9ikCAg0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCg/RWFpL76UsMF1CwroOHtGfXRXeMC2iSbaPpuE7bMC8i875Z
 ZuvwN2jhALU1iAxNyKhGCly1stv4HsH9dP6rN98AxdU4rPjR7bm8z/ah
X-Gm-Gg: ATEYQzzintJpgEfzabDy+ZFa5Pvk8Hu57gaCCro85jhFMVe4LJtHzG1XXodn4PTf0IV
 h63MpaEbDfUlDruqMnM0DmYALwHwGJPJG6cWh/KfHTdr4gh78bgSMfQ/LL6kUF3mfcT7Fvo3erx
 ejVitDLe86J1dLPI6wvGQcC9mVxu470vlntzS+5MkBQsQSAnr+sUyzvr/118Znpq3keFp6Ufr/J
 Ocaui8KBxFfkFsTSvVytmlW47PdxXDKrsx3YvW9bNPg3W4y9b/Mb9AxwLuW5rM3F8eGJfa65Nw4
 tr9bHjluFBxLc1wi6pAjlscfnNOHtgHYr/yXdmLs6JjqRApmxl6J3gYxgZLeBloUbouQW6dZV3p
 qsT29NN2Y0+LoherMRz7fr2Z5xFC2WYEPuYY8N4p2WBve4pkqYHLk86VaDVUkquBGeuH6S+QM+b
 fs7pYYhQ8o3CkO5TRgi5AkjyQNB7uO8yUVYPlJiddICIbZn4Hr0+Z1DDk=
X-Received: by 2002:aa7:8896:0:b0:823:1212:8e87 with SMTP id
 d2e1a72fcca58-82a198d7220mr13987513b3a.32.1773707452151; 
 Mon, 16 Mar 2026 17:30:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0736deb4sm14420074b3a.44.2026.03.16.17.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 17:30:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org (open list:QUALCOMM CLOUD AI (QAIC) DRIVER),
 dri-devel@lists.freedesktop.org (open list:QUALCOMM CLOUD AI (QAIC) DRIVER),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] accel/qaic: kcalloc + kzalloc to kzalloc
Date: Mon, 16 Mar 2026 17:30:34 -0700
Message-ID: <20260317003034.71618-1-rosenp@gmail.com>
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

Combine allocations by using a flexible array member.

Use __counted_by for extra runtime analysis. Move counting variable
assignment as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/accel/qaic/qaic.h     | 4 ++--
 drivers/accel/qaic/qaic_drv.c | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

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
index 63fb8c7b4abc..ab428ecd26f5 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -405,15 +405,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 	struct drm_device *drm;
 	int i, ret;
 
-	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
+	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, 16), GFP_KERNEL);
 	if (!qdev)
 		return NULL;
 
-	qdev->dev_state = QAIC_OFFLINE;
 	qdev->num_dbc = 16;
-	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
-	if (!qdev->dbc)
-		return NULL;
+	qdev->dev_state = QAIC_OFFLINE;
 
 	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
 	if (IS_ERR(qddev))
-- 
2.53.0

