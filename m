Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED004CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 06:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3550110EA78;
	Wed, 13 May 2026 06:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PaXZG3kz";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DFA810ECD1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:57:31 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so5137968a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778655450; x=1779260250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lpyhgMOndReaAQGfFDlhOvUXYhINkrL7L3hO9NJYJ10=;
 b=PaXZG3kzi/CKpkJeJZdwVmkohFZYgaXM2x0efpWL8yYE1WB6zAUlCyrp/TzbBLa31z
 83yZnzcfe1Cf/b0g4avqyhHVBg2qi1Ae9xRjtFGFFVhDezsTKQ3vdZ0mTJtt7I8Pig6+
 GwGH+xvznQQjstynzYppdK3S9NQTxlr7mL+m/MD1hKhUnf86QP2TYYeqNZTNp6oOR8qB
 b1BUf8a51wfZYfhSZYWUa/2nAhCVNicmTo7+8IrloS4IV/OXESpjT74Ceh5sHJhVlsyK
 twwhuIRN4hyTqC1HEjGUoo8e5jlwjzCwdmtmLpLJEy2VkImTrwlF8MN27J1mXWCXvjBq
 W9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655450; x=1779260250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpyhgMOndReaAQGfFDlhOvUXYhINkrL7L3hO9NJYJ10=;
 b=jdHxQMaX4806Dt6dU/7Y+bawllx78YDXpqYxzzh5N3B2U08vQM8bil5N9ab1KiJRyS
 aO27aBGp7saTpnZClvU7S91RXUIDNoCbJJaX081BWx2K2OCx2Tt6qts4Mkkdpefi+dc8
 ezU610zJ+ccKRYmGtFX6jjzam0oTlzLOZIJLDK5UYOLD6ue56/Cy7gwtXcxgTL6tdOse
 tNcUnqVLapESy2NEUmDeiaScejiNeq6Cy9tjnhxNCoxNMK38a0v85RsUmRVEjCn9B8MS
 kGXMYd3xBeHa8zeIX3QaypRwqZfa0tbu294KTiswHzfyTZ/meoy+X+Hsege2YJ/9Ixw1
 PdJg==
X-Gm-Message-State: AOJu0YwuO6g87f5LhIXC8lvhaTK4cX+TNyfNYTb9W7q72naGIruz23Kw
 MqXiE1JEI8hWn4EHf+6sTQ3l6M9YfbC/2TYe+uh/XL15e3zcqabXK5nJS3FxJ+w=
X-Gm-Gg: Acq92OGZaB2mIFqCXJi1aPtCYV4ziX3ztxU71EwNPU+M/UoyD25G5FMz4Rua2nHxc10
 VSVbGuii/PgEXiaDnnPJrX/QTPW3oaPmsaIeO7plRJcw6k+Qt+69skfv+d6JiKX3s3SP05et9yv
 /cioX+gl8UkBIVir31qsqWfKx05xNhiDGXIDO6lejch8ivbKp1lq072AWqUxEVYELQFpOu6yvyW
 0JuSszWR257V6AKTHkeP/H9YC79dJvzrU3Iqr/uI7Qzql++eRZZz1nFpGp/DeN7MWDQCs2QOgKa
 +om7bCJhKErY7Uux6tvQhlebTxDS9iB7AbVTPTSm42Rz0WP7Mi5KKMsFUkvZTqOKyg2VxD4rKlU
 vGA0hPmZKSrvg/TLkxmDXWyIspEg02gHlcFm/WZXW211GRiU8MGqyrL+n9Qicvs2gLlANDmiu3w
 dmoe3RepLrGe4gHpz0pmQDoWs4MtX2R9z4HwtQu9PnF9ObdbiVZHhotd9w9at/jJdEhWhOsIEFn
 A==
X-Received: by 2002:a17:90b:3a8e:b0:35f:b5df:463 with SMTP id
 98e67ed59e1d1-368f3d1fa46mr2326543a91.14.1778655450438; 
 Tue, 12 May 2026 23:57:30 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368b07163d0sm1945647a91.11.2026.05.12.23.57.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 23:57:29 -0700 (PDT)
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
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>,
 Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v3] drm/loongson: Use managed KMS polling
Date: Wed, 13 May 2026 15:57:00 +0900
Message-ID: <20260513065706.23803-1-mhun512@gmail.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Capitalize the subject as suggested by Huacai Chen.
- Add Reviewed-by and Acked-by tags.

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

