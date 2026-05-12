Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1AFCD484E
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEBB810E587;
	Tue, 12 May 2026 06:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nB722uvo";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013CD10E976
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:37:03 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-836ed29d1e5so2206421b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778567823; x=1779172623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
 b=nB722uvort/+3xutJG5Emyd3xreveLcWpN6nzJaWVDwlgGCAI+pJv97UOXgzwXHdEg
 NXuEfbkKgFWUjscQb576MupbdwBnqKB9yTLcgcloR2QPXpe2G+8fY3s8Fxuq+4r+aUj0
 2DqLXNhsxbDrPbaz1noVhT8HgxsEhELbB7VlhECeUSjgLdIRVl4uG+R2ZePy7ECxp7Da
 r2nu2RwDDDeFX6jQcyuNgb/wF3eES0oOw52BF76hIHEVhAj7IKumTcxn+CUf19MhL2Ks
 uT/bnnPsvMKBNV4dJ4iUdj0wITFXRPKKyeE15dNd9e0QQBzoSHr5SGnk8LrrM0PQstcu
 k01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567823; x=1779172623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
 b=VjHQCLRC8RkxdS3uATuQEAM0d7KWOZCL7dw+5UfxU/WLRXjpt7IsJkBDiuEgkmwdaq
 2Uc5RDVUTQL0+//b7A1QGqbISYvCDgetk7OHaxYxxSMnBexhFSDhoVIKusipIU1rV/Cn
 gNfqZV1OuPP5WRsWeDwphsIenCHqC+UQe++iE9G2CtJSU9n3WgQUuNfatP5AdSql0afI
 Z4gvOuMFrJ28cBHNzUQ6z0cQ2DDV7JL/TasxS/Ss9IcWWNvOc2fTu7CZMxSevjwBp4u2
 gkCSSTK5YkQXMs7UoASgUrK8AiilFF54f84x87u1MSMwp3TIbt/x3LuM9ZQ5YC8zIgJN
 ZPRg==
X-Gm-Message-State: AOJu0YxsN751rcP1PquiB89EU6qTnpx6KH2Sj4aipBQn6AkAz0Hcodo+
 7hYCBNST7XFFp7MVT2ecetPSqSUY4CNrmTKktl5qdNkHeH8K5FNMmsjlUg9/bCs=
X-Gm-Gg: Acq92OE3soux86h6oDj6kUdeJ97PWkFEJr5tWiqhWv/NTF89Jw5KbzOOJzF9mYA/vLz
 O4RSZ/itx1d86C//V2MyuXBW/1wqUqkfSWG2Hokz95HChdjKuWwB+uDyAcnoktg24W9evwrhaIt
 wbEZO1+Hhm9+9Ku8WZivtFedXNNcRmS+0gluSBe2/CUMGrrjwR/Zz8mypXEdNioIrB7K7xCCbiE
 Kxja606qcmJ4IEO3nTUyh3OtCVAUYtXckPaTN2VHZFXVg0QE9OjrsrcHZy7fJskAHHJWE8W+NVP
 woV1XYEqjKfT4FrTsLcGboI6KL9W7l3Xpcopj/U8xAl6IM2hOtDx1VxmbvPE6FsXqWQpfqsN6P2
 3wpYz6Qh90+OW1eAeHq6zu6Has9fV+Zk6DxPTnoBL1Cv9pZn9n2c3o8vew6+xMCGycggjqV5lS+
 fQ+ODJ/4UHkbhHQBiX1YVozra4JH6RArH+iNPted9JB2FcpuIPTFFr9s1hlP4SQaH1GvlBsng/s
 A==
X-Received: by 2002:a05:6a00:429a:b0:838:c01a:7a50 with SMTP id
 d2e1a72fcca58-83eebc24f3bmr1610402b3a.30.1778567822961; 
 Mon, 11 May 2026 23:37:02 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbf7d2sm29996163b3a.49.2026.05.11.23.36.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:37:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Myeonghun Pak <mhun512@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sui Jingfeng <suijingfeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] drm/loongson: use managed KMS polling
Date: Tue, 12 May 2026 15:36:51 +0900
Message-ID: <20260512063657.53100-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

lsdc_pci_probe() initializes KMS polling before setting up vblank support,
requesting the IRQ and registering the DRM device. If any of those later
steps fails, probe returns without finalizing polling. The driver also
never finalizes polling on regular removal.

Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
lifetime and automatically finalized on probe failure and device removal.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
  and Thomas Zimmermann instead of adding manual cleanup paths.

 drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index abf5bf68ee..4b97750897 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	vga_client_register(pdev, lsdc_vga_set_decode);
 
-	drm_kms_helper_poll_init(ddev);
+	drmm_kms_helper_poll_init(ddev);
 
 	if (loongson_vblank) {
 		ret = drm_vblank_init(ddev, descp->num_of_crtc);
-- 
2.47.1

