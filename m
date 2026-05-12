Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858D8CD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB83510E1AE;
	Tue, 12 May 2026 06:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HWaiRZPZ";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9278A10E1AE
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:54:43 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8367df48711so2368846b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778568883; x=1779173683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
 b=HWaiRZPZ7D0GvwJ5CZ8t2RpST4Slt2GS2HGiY++loMuO/jqYsVuF/ybJAmATQonGy3
 qf54Txlo2S+f+DyDtMJ4nhh6RS/O77W+RS7uiSoMPMEvlHnkRIX0S26aHj/lIbfJ+Js+
 XqUoQfZVIv+SXA89PIHr5mURaKiujbmutvgj3DMogUkoCWQfQSsa4nFbIPgGSJeBUmCA
 07iIWUzdG99RXbvUNhE/OpM2WLmMDJrn28d4bCh4pfj4xViHwmlAIMar/Lq9SXZskNGj
 7VeWt2JwM79DwGWLqft3PO9sDdmUCity/dmouN1Dc+454ncUT5tM0bZSY/RWzdod4w0R
 ShWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778568883; x=1779173683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
 b=dkRdOgbYwLUzWtyegLsI8nVBrZMXLSd6Xxm91rhXNSRKKhJGWCTNPnT6WtF1ztWcPZ
 2PTKHrO3yc/e7Ft6JnA9SHrdHcgNvfs+Ta3q+u57lSsHjsO3/fm3oKBP26ogKRc2BrOe
 TbPCK5SQDDUXyIOC2nSrLgBSqhkrJXZNA8ni9Zu0SuBQIsPU8xeGBu//27vT1skFiU0J
 MlnkVtJRsAQ6WraQAiIMGiOmWcgipmVqr3Wrd1HuYFdXSH6RYJ7I4wKKYEd36AO7CEtN
 E9nsff5+e7axb6J9s00P5LnkKuOp2mZZDY+8CazSHTsUZlMhnAUuWm551K1qpG3Sh2fG
 fq1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qBSbXohjKuDtcOBYW+vDLHqL1lIshUy5nfM+kjPbD2bTVgpnhxRMB8Ybwv6yXT4E8FmbST9IGkbE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ2DoXnWTUGxHnUElQ7GHkVzvWgY1uI4EHVJ3u/44Tv4mYHNdi
 D0RWEGJgmAAxXuO4JcUHzGu8R5ZbGPlTupsrNMDJm683s8P6eebYYb4=
X-Gm-Gg: Acq92OH1rNmSbKAh8xsUkReFkhc5A3KYBDvEM09kd4HfX3IJfesNxsZpB0FfZRSnluI
 98JJ5xyDICxqRE6hh/99C41OdPkK0F3E1ZiYBbAAS/gSo/wxBP4ABTOHnePeAKYSaL+kw+Ad9FR
 bbjKAajNexiZYQ2QYX3b9BcBdhELUQYD6InHvw5/bUUMwEvyjYFnAIdMQ5V9q5ZqXhMrSYzkA60
 abNTtTX7KjwNItzEyC6UQwU26HjPz4c7jwtRSryX3bK5XSTVYznM/jcX7NoIozUalzCC66mZmPe
 GZYXp3X3RkXcBxKaa6UI1aI4TpdeSnZgjopt4W1mAX/4WidnjIRxcePnEThXNzKWUBrS/1GPt49
 BHHQO6pmOuBCl+NJ1oQ7QVCKX+OuEQwGS8IvrnYM/6Z75d9rv71+Bg39NZBCtXOeF0+T30FgicM
 pIcx6SLdN7+n1Re3lYRWAyjrvPW3zVHsWF0OHEWJH+qYF7deGzepiZJ3Y9EERLq17nApjvoXG9v
 EKldkCD1WhN
X-Received: by 2002:aa7:88d6:0:b0:837:e9cc:d470 with SMTP id
 d2e1a72fcca58-83eebb5004dmr1861920b3a.20.1778568882988; 
 Mon, 11 May 2026 23:54:42 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965646254sm23272580b3a.10.2026.05.11.23.54.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:54:42 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tobias Klauser <tklauser@distanz.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, dri-devel@lists.freedesktop.org
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
Date: Tue, 12 May 2026 15:53:31 +0900
Message-ID: <20260512065436.74729-1-mhun512@gmail.com>
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

