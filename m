Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181E51098797
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C4510EAFF;
	Fri, 20 Mar 2026 15:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCwhwl1g";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD53C10EAFF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:38:04 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso15830015e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774021083; x=1774625883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LC8/Krjsz/8eMfvmK5q2jyfb9Doz50BbBIjca4omGxs=;
 b=UCwhwl1g65N4Rpy0Wfn0YRBHSlKln0eRX3tLIaas0oaf/eknjFyrfppqhPXoC7pKan
 0Zd+I7fI973VPF4FeGqkWFRJDczYMVakNY5Duvlj4nVuPbYWpexFv76JXKshjmbnTn9H
 NfLNxNfd2X1TObZ+5SSYLyzqXFUG3ejT7LI9IBBSJiRVp+rrP8wiqGEBnWzCE9F72nCj
 wgy6msIHZVoInDdkY+sTOegfYkfJUpCyxeTmIVcRCcXa/W1g9DGy1z6lAQqF7Sojyp52
 nTGKJHUrC3kf/7vRLa+659kOLa2fqHxCgcjhXU5kqP6KrYonffRz55rti9f7cHZZ97u1
 JHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021083; x=1774625883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC8/Krjsz/8eMfvmK5q2jyfb9Doz50BbBIjca4omGxs=;
 b=dGEJw0JWY1gktdaY2HSMYV0n5N1gBTXXkPR1WYY7w3LGBhILqnIr1i6Hj6GxatOQab
 ro+L0IrHYqpbfUryK6aXU5mrBhdhi2X7a5KbNJXaAYaWE8qrXvWMGwJ9a00Nr2/nAtky
 MXrFSYitTy5ab08ZEGG41oIoLmwxgXWQlMcKr8Fm0FHTBFipO0lTeV6kOmxJLVwFhgnM
 KFAzufvOAb7R90o7FvCVo5PcYDb3O5poJpddNa5NLRQRaASxUXyO7Rgwu4hBmmd5N42j
 LEmU0B6Izf3JRs0GVpARmlg1rh0mQnRa4dlp+L4Q4pXFLEumi99vAvxbKK6M0DGh9VWm
 6FOw==
X-Gm-Message-State: AOJu0YxielYsF9QXXSB+5KEZAZEMzJ1+En/QodkisiZYxMviI+qJ9NeG
 LJd2gH4Uue+w+we86h4kFMCK5kw/qFmx/lNB6XxE6sVnKCv23opM+zmhpHTIQJyd
X-Gm-Gg: ATEYQzwqzWsfS/oc2ye70eNxs40OZxvFiL6Ft65qvEoOv2gXUz9t8RR2Js+h6tDtrdk
 Dsw/3afRKllxa4nMqDKLoYGFCSHc2sef5PU5jL89Fy+NT6siElxnmntb1sIsUi93IZ4h22YF2cJ
 Jjz2TWfJSF/DZzgGRU7a+1Qt1Hrs+ifmdtKw/ytkOj5WVgVQBdwuVDmIR/h7VsBO8MF6QrIeWb2
 IcFaBhQoWEwDWyjfbxvh3iaBEkqwt1YAQ1bwJ0FGcX/A8eJy8UErSIvXCwPt56KhyA2hkCZj0LL
 uLCRhCl5Sc0vqKJL405WvRNG6C3yObSrqgfZUNVdlQGFSGBLDb5ppaVrEFfvDDViPjmc1+q4lLz
 u9l/od0+M4smfXI4AAxQO1676nENDiIed0kja+bXWpqPOvX2JWN0rFto+WL/navc8Itx/S62+yI
 YViq0vaC7PJ+ddhbRaf9E=
X-Received: by 2002:a05:600c:8508:b0:485:3b00:f92e with SMTP id
 5b1f17b1804b1-486fedab7dbmr51111835e9.2.1774021082580; 
 Fri, 20 Mar 2026 08:38:02 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff19d387sm18532675e9.17.2026.03.20.08.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:38:01 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 RESEND] drm/mediatek: dsi: Store driver data before
 invoking mipi_dsi_host_register
Date: Fri, 20 Mar 2026 15:37:37 +0000
Message-ID: <20260320153753.25450-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The call to mipi_dsi_host_register triggers a callback to mtk_dsi_bind,
which uses dev_get_drvdata to retrieve the mtk_dsi struct, so this
structure needs to be stored inside the driver data before invoking it.

As drvdata is currently uninitialized it leads to a crash when
registering the DSI DRM encoder right after acquiring
the mode_config.idr_mutex, blocking all subsequent DRM operations.

Fixes the following crash during mediatek-drm probe (tested on Xiaomi
Smart Clock x04g):

Unable to handle kernel NULL pointer dereference at virtual address
 0000000000000040
[...]
Modules linked in: mediatek_drm(+) drm_display_helper cec drm_client_lib
 drm_dma_helper drm_kms_helper panel_simple
[...]
Call trace:
 drm_mode_object_add+0x58/0x98 (P)
 __drm_encoder_init+0x48/0x140
 drm_encoder_init+0x6c/0xa0
 drm_simple_encoder_init+0x20/0x34 [drm_kms_helper]
 mtk_dsi_bind+0x34/0x13c [mediatek_drm]
 component_bind_all+0x120/0x280
 mtk_drm_bind+0x284/0x67c [mediatek_drm]
 try_to_bring_up_aggregate_device+0x23c/0x320
 __component_add+0xa4/0x198
 component_add+0x14/0x20
 mtk_dsi_host_attach+0x78/0x100 [mediatek_drm]
 mipi_dsi_attach+0x2c/0x50
 panel_simple_dsi_probe+0x4c/0x9c [panel_simple]
 mipi_dsi_drv_probe+0x1c/0x28
 really_probe+0xc0/0x3dc
 __driver_probe_device+0x80/0x160
 driver_probe_device+0x40/0x120
 __device_attach_driver+0xbc/0x17c
 bus_for_each_drv+0x88/0xf0
 __device_attach+0x9c/0x1cc
 device_initial_probe+0x54/0x60
 bus_probe_device+0x34/0xa0
 device_add+0x5b0/0x800
 mipi_dsi_device_register_full+0xdc/0x16c
 mipi_dsi_host_register+0xc4/0x17c
 mtk_dsi_probe+0x10c/0x260 [mediatek_drm]
 platform_probe+0x5c/0xa4
 really_probe+0xc0/0x3dc
 __driver_probe_device+0x80/0x160
 driver_probe_device+0x40/0x120
 __driver_attach+0xc8/0x1f8
 bus_for_each_dev+0x7c/0xe0
 driver_attach+0x24/0x30
 bus_add_driver+0x11c/0x240
 driver_register+0x68/0x130
 __platform_register_drivers+0x64/0x160
 mtk_drm_init+0x24/0x1000 [mediatek_drm]
 do_one_initcall+0x60/0x1d0
 do_init_module+0x54/0x240
 load_module+0x1838/0x1dc0
 init_module_from_file+0xd8/0xf0
 __arm64_sys_finit_module+0x1b4/0x428
 invoke_syscall.constprop.0+0x48/0xc8
 do_el0_svc+0x3c/0xb8
 el0_svc+0x34/0xe8
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c
Code: 52800022 941004ab 2a0003f3 37f80040 (29005a80)
---[ end trace 0000000000000000 ]---

Fixes: e4732b590a77 ("drm/mediatek: dsi: Register DSI host after acquiring clocks and PHY")
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
v3: Also initialize irq_wait_queue before calling platform_set_drvdata
v2: Added Fixes tag

 drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index d7726091819c..acee2227275b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1232,6 +1232,11 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 	dsi->host.ops = &mtk_dsi_ops;
 	dsi->host.dev = dev;
+
+	init_waitqueue_head(&dsi->irq_wait_queue);
+
+	platform_set_drvdata(pdev, dsi);
+
 	ret = mipi_dsi_host_register(&dsi->host);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to register DSI host\n");
@@ -1243,10 +1248,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
 	}
 
-	init_waitqueue_head(&dsi->irq_wait_queue);
-
-	platform_set_drvdata(pdev, dsi);
-
 	dsi->bridge.of_node = dev->of_node;
 	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
 
-- 
2.43.0

