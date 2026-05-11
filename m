Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14303CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 17:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742DD10E844;
	Mon, 11 May 2026 17:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LSezUvfH";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D10B10E844
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:02:04 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8353ca0f1f1so2313131b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778518923; x=1779123723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oB4TtcqxvRLjMRr1fJG7J4uzFOlt2Uo+LQk87OI5Vsc=;
 b=LSezUvfH4AGwQ9cXsXtg9fRTqLPsrnYTvMiFdWljt9lDhRjn0QgcjCMa5O0GfhGq3v
 nBSHvZmKW1yOkQ4miwNs34n3re0ZrM6nFAFBiIqjxcd/oF0yjQGwynWnzYfcx/tQp3bI
 JvtZZuybJKmVqJHvgvlPI6Pfd/l2dDUBiW2TUKAlHLslWKX3v9/2XiEXECMdqu+iqv4d
 xAfXCypsgwFw6VJTxyPGUXuBSySNE1i9h+uYZ6TlhDfxPw3Ps7TFOv+TSHACRQQY6CC0
 7n/lCrXR8i61GdKxzZfbyYH4QD2WgEOUEzrqBtV9nH9/IEmGAcI0ncMIrBJYwxR2VuYt
 mSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778518923; x=1779123723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oB4TtcqxvRLjMRr1fJG7J4uzFOlt2Uo+LQk87OI5Vsc=;
 b=ipc0ZDkvobJkbSnU2l28ved0b2y9v64dIWpiqFCJ4tuf51lyGlXhThfK2kRNh1qb1p
 1IYVYx1yAoxtlv6+7ZJ2di+5U1fXxvMjV3/WIePh4tDTmgAPhXDE+ULsb9C12A/Lk/lF
 U4+HI22GulUgFvalOdVCwe/vstJYSQEGi1Cd6jUpbPhijHs2bHa4oVTOiKXBjCEOV/Uq
 +fa2syiHNuZM/4xBDDoYo0GNH2A0i9J6tboyglqG185TzPo4xJLGFgQOnXm2IDUSChQx
 lT3CbgRgLrJMHLPCw9//2Oa7/Hcua2p0a6PyjN1NS/PA11e7/y5o9Y/hSYSW70c2FVcr
 2hTw==
X-Gm-Message-State: AOJu0YzIGUGIoBYUJPLb9l3NJ7wYLvHOJ+tEm6iIL7K0RSE1ESVJx6xY
 u9A4Vl+1/sYXEv29xRbFWo7OG3w1w8JLRNUAb3Dj748V3+rU1heW5HKqJxpmd04u3w==
X-Gm-Gg: Acq92OEE3Qpu12GjYoBCzySY9RbXr1DcXvyADxASfTI6aVd2nTqTMLqIvshxbTk7iou
 GQKPe5Z2Er3mEILl90kaKewx6y1YLvyVNmDiS3UfGo/PEbYtA5Grr8qsLhE9Jw1a2/qXORVTzWW
 RI52ctJ88g5ny5VTSBaVTLya+2F3QzBSfElWnDuvIDvY+hAY7+pSjMiaiCDQ/OYITK3DdoTA2/X
 BmYGmKdF1sDOyDVIJakuaVSoO8bEaSX6EsrJvxBr/QYNpUIJZ7IGKZ/Zn65nmV0uMDKU/IygSBL
 ssLZAN31PNtsD8JEGV7uZ34XPdG308n6vB1b2StCH+ANAPPy/y5i8Z5FEcg6z9jC28HmdCkZNWf
 u5lIHaFFPphE4WZlu7d8wEys7tkT4Bv+sIAjXAhLDAGD8sfbotzzgZBXjEU3ciqyQtbU2HPTA/u
 uroBEs+5LTUOF803uPhr7LKfU5F2TxQIbQtaL9ZRrdct0h33xflignxXBhuUnOyV3ir1jSkIY=
X-Received: by 2002:a05:6a00:2394:b0:837:8a0c:8f70 with SMTP id
 d2e1a72fcca58-83ee83ec7cdmr272378b3a.28.1778518922808; 
 Mon, 11 May 2026 10:02:02 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbf7d2sm28032387b3a.49.2026.05.11.10.01.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 10:02:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Myeonghun Pak <mhun512@gmail.com>, Sui Jingfeng <suijingfeng@loongson.cn>,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/loongson: clean up KMS polling on probe failure
Date: Tue, 12 May 2026 02:01:40 +0900
Message-ID: <20260511170152.16957-1-mhun512@gmail.com>
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
steps fails, probe returns without finalizing polling. The remove path has
the same lifetime gap when tearing down a successfully registered device.

Route those probe failures through a poll cleanup label. Also finalize
polling from remove before unregistering the DRM device.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index abf5bf68ee..3db1f8690a 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -297,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (loongson_vblank) {
 		ret = drm_vblank_init(ddev, descp->num_of_crtc);
 		if (ret)
-			return ret;
+			goto err_poll_fini;
 
 		ret = devm_request_irq(&pdev->dev, pdev->irq,
 				       descp->funcs->irq_handler,
@@ -305,7 +305,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				       dev_name(&pdev->dev), ddev);
 		if (ret) {
 			drm_err(ddev, "Failed to register interrupt: %d\n", ret);
-			return ret;
+			goto err_poll_fini;
 		}
 
 		drm_info(ddev, "registered irq: %u\n", pdev->irq);
@@ -313,17 +313,22 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		return ret;
+		goto err_poll_fini;
 
 	drm_client_setup(ddev, NULL);
 
 	return 0;
+
+err_poll_fini:
+	drm_kms_helper_poll_fini(ddev);
+	return ret;
 }
 
 static void lsdc_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *ddev = pci_get_drvdata(pdev);
 
+	drm_kms_helper_poll_fini(ddev);
 	drm_dev_unregister(ddev);
 	drm_atomic_helper_shutdown(ddev);
 }
-- 
2.47.1
