Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A123C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 07:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4FD10E099;
	Sun, 13 Sep 2026 07:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="deYhgR+D";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6801410E099
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 07:41:31 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso739474a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 00:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789285291; x=1789890091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QGMxhoqEc5sqXnRI8fK9K0ab088f98eW85+fhaIuxJM=;
 b=deYhgR+DbB4JS8+e8xXbMzqfxOtQ5yhMM6J1wqZ64mc+AZ0TO3yV6eNBr48q3eiMdU
 7mqGQJT31yQp2sPhmTl+ZEh4/awj2Uo/CIi/iL4OBaRMVPL0iK60S3o1Wnyk7UAD7qIv
 6HDc59QogGAZ0QubxLQVDfU5pODy3g+3FsbUIA6rF62TCdDKlYitVVfiSxS4jE3POO0I
 Bwq5SKEp9IsvQV3BMj9t+KCRr91t13T9FxG5HUddQqXDO95ZJzlIJ5DMxop7XVeOBR1s
 5UAzFh0gDH/WXytyjCUaUqT0mfsAQprx+y/fwHcxHTBl3n/KFi2Z8NRvXx5K9RyJW09u
 FQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789285291; x=1789890091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QGMxhoqEc5sqXnRI8fK9K0ab088f98eW85+fhaIuxJM=;
 b=ZS8EAH4CIFcPdLEJlT83OSZmG7WaiD3/YOe+a3QyP7jrrkWCNTWS5cN8iGGzxaaXa5
 8rw7xZW7hjXRD7YllIWAAJrRqtjDUBOjMIErmAngFe+D1WuPAG+klXCItUTGSWyqqX7i
 MUaBGH+JwVyGKzTcAhC6Pi58i/4YYywX0RLzZHaeqdSN7w/qwUAuRFrYLA4YIy6e2IWS
 LFsuiEXFgeVqF+LVkl0P+h4n5BYxnvkb0Lo1iq04ZI+QLy1R2pqtm8lqJbaYAmWT27Gq
 iMbemZ1In9uv77Ry2rx/VsIj35um1B0Z/SWg2rg/WDByrBBGcyvnQByUUOPLVoXPebGA
 T5vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwT5V4gigFEk7i6JZMUsnVFkYvACdR9QY9csBnFnn4hbBOt6A83xLrluNNgwmPXM2MAgpDLxOKDGQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l8H9cra5Z7l3Qr2MBtSwtinikwnrK68XCb328EUFPEvm1f9Mxv
 NDOyRIKiXzBMyDx/Cmnv9goGMgrqyZBA7nn3CgHrdfVqxKJBZ05XEi4sfQ6d3g==
X-Gm-Gg: AYBFou2IQJsF3YHtafo5jtn+EYG/G1PKCjnXCrq6eDN9aCBxPI3u/6wIoEtksE2/AJV
 OKuoNYokjYsn5HGX1OQSI5tR6GyjgTXYVju5j1m7ObcNI2/jvhN3IcjNOg8eahEaQ2NhNqzYgOD
 Kb1yVqK8Utv7SVtcDinF5m4l5+d31FmbNOy/OIvo+kcrlvwq58KnxhsQeF2VmYN4hWjSxzs4VFY
 b0IVzs11KYQ+kdPL2/jWgpd/8KS45cbND3nbblCRRY4sXpfkkaz6zivUMb4OuoJujTtVbnBSU3b
 d0Y6kAYq34VdrA8n30LMaX9ZSLxCb992NYCtzfWs6NkeYq2VAt6nYta5DKva1H0s3VdRwv1uPhW
 d3OqUm67mm0tF6msSFTOxV0jy7xjYcG6xwg+XhJPOk/dU91CWaOZdmUTp5I0WyXiM+JA8fHFmAS
 XgApoT8b7hY5PAv2rU/C49Jh2BAjo1OlSuwaIqEuG1noBM6Kqhxmf33A==
X-Received: by 2002:a17:90b:4984:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39d9c3968dcmr22793828a91.25.1789285290819; 
 Sun, 13 Sep 2026 00:41:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95092c06sm14395927a91.4.2026.09.13.00.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:41:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/kmb: fix potential use-after-free on probe failure
Date: Sun, 13 Sep 2026 15:41:20 +0800
Message-ID: <20260913074120.1483518-1-lgs201920130244@gmail.com>
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

kmb_irq_install() registers the LCD interrupt handler with the DRM
device as its dev_id. If drm_dev_register() subsequently fails, the
probe error path tears down polling but does not uninstall the IRQ.

The DRM device is allocated with devm_drm_dev_alloc(), so its initial
reference is automatically released by devres after probe returns an
error. The missing IRQ cleanup can therefore leave the registered
interrupt handler holding a pointer to the freed DRM device.

The failure sequence is:

  kmb_probe()                            IRQ context
  -----------                            -----------

  kmb_irq_install()
    request_irq(..., drm)
            |
            | success
            v
  drm_dev_register()
            |
            | fails
            v
  err_register
    drm_kms_helper_poll_fini()
            |
            | IRQ remains registered
            v
  probe returns error
            |
            v
  devres cleanup
    drm_dev_put()
            |
            v
  kmb / drm freed                       interrupt occurs
                                            |
                                            v
                                       kmb_isr(..., drm)
                                            |
                                            v
                                       handle_lcd_irq(drm)
                                            |
                                            v
                                      access freed object

A later interrupt can thus invoke kmb_isr() with a stale drm pointer
and result in a potential use-after-free.

Call kmb_irq_uninstall() after drm_dev_register() fails. This disables
the LCD interrupts and frees the IRQ before the devm-managed DRM device
can be released.

This issue was found by manual code inspection.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..d8e2fc28ee9e 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -569,6 +569,7 @@ static int kmb_probe(struct platform_device *pdev)
 
  err_register:
 	drm_kms_helper_poll_fini(&kmb->drm);
+	kmb_irq_uninstall(&kmb->drm);
  err_irq:
 	pm_runtime_disable(kmb->drm.dev);
  err_free:
-- 
2.43.0

