Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AE4CD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7A310ECBF;
	Tue, 19 May 2026 13:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Qk5kPoZv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF46810ECBF
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779196370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AG4FqkfMx5fUyMM7BkxHeJoowUaeWn4Zw1beeRp993Q=;
 b=Qk5kPoZvJP40LQROCmMAkplXo9mbFrWRVdzXvehb1fh6XwssMebYlabAwr3k0xlh/jZaHX
 2OpZ6XjvWdc0iO/XAvPJQ8O6Lcm6p2yFxB4jwr5OVIrZhA+Vwkf8EWqS+j6qV4qbX8lInA
 Y9/69RNgRqX/5uX2dOw9EvDmMW+5SIo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-loh3V6VGMEaaWH8iBh9ZYQ-1; Tue, 19 May 2026 09:12:46 -0400
X-MC-Unique: loh3V6VGMEaaWH8iBh9ZYQ-1
X-Mimecast-MFC-AGG-ID: loh3V6VGMEaaWH8iBh9ZYQ_1779196365
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44bf1ac8893so2854555f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779196365; x=1779801165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AG4FqkfMx5fUyMM7BkxHeJoowUaeWn4Zw1beeRp993Q=;
 b=AJYZiANWRuAUMrhfgoVVeSS0OW45iDZr6taqL+LRrKHdBERa+KN8V9u/lkvkXw1KPr
 McCPiHjb4NXxfI2TeJphckn74nvDOPNKLm2PGHTjtJEb3zxWzyH2uOoWndJLhA8Ioqa4
 O+CyxVb4zkuh4nJVhDRPsronZKXpHHBVy2bRxtlfVwILp0AzmQXfg0lJ/ykgIOgTV8Z8
 gNO29RnTKkbosCf2c8IOQVjGxP4qiIoLcWC6M7H6FndTw+Js1z1VWthzZLVFkfkQ3DiS
 UgAxHgjxiaLXS4RXQtxljU3YZbLKd79g6ckosn9sGqu7CesRbHrp+N/HqY7td0yhqL8i
 8qzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/OlnIhNCXelAiPpsix8ZpvjnxXJYoeAd3TpfYKVhC58FpTfajpNlWsuT8aV2Tmr7xIsrIM995zVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDX9C7x0ISoE1ypjtkUj+T3QU21/pRFSmmQfOCsSY20x+vRYiL
 5R3vycrnnI8n+xBoZbg+/zhhwUCKeIfrnHxvPn/6VpLUAaM7taOckFKKWlihfMgsXbgZHTjszq2
 MofLuYrNdaSBzDzeToZ/q1lrYhJrvDAKNxszKAFLeIDy45QDa2FRzjJxBak8AKdHCz865Mg==
X-Gm-Gg: Acq92OHuQ4n6cnySyB0gOvyFoWZPugg9QfGeQGfXr1I/GZGQ/UukUtdGDmwH0ylt/rG
 qJurZ6Hq0EuB9ObKG70q7sWfhe20nwFOdmjV+qrSvwPQkr/9t2jGLRQd3i6Wsdd1lmiIqw4KsDw
 TDyjoYowbL3NqN5ZbNfTgrmt2H8P75Y/uOfXvBh+JxIpqCExkARHS7CpSXXFTqacf8FOyekVYvc
 uv4+lcYg7VJ/aDcZJHfMggjXryRp1SLv0RFHhfc4hRWvYw14br1qUxPaKgy/g7g+DRjN/807ELx
 Yz1W1WYpVv1UD0lB9gfuf8ZDcNivJFMpTDAJLgJmS2xp1ryE6+GPzJoSP0LS5lDdDGxyMSSON54
 fbtgNaavo1gqJ/JApltQDe6Oh4CrNyfdTlOfqX87tMYEDwEcHaZea/jodHA==
X-Received: by 2002:a5d:5d86:0:b0:45e:8547:f217 with SMTP id
 ffacd0b85a97d-45e8547f327mr9475729f8f.37.1779196364771; 
 Tue, 19 May 2026 06:12:44 -0700 (PDT)
X-Received: by 2002:a5d:5d86:0:b0:45e:8547:f217 with SMTP id
 ffacd0b85a97d-45e8547f327mr9475591f8f.37.1779196363474; 
 Tue, 19 May 2026 06:12:43 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm46669982f8f.21.2026.05.19.06.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:12:42 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, David Airlie <airlied@gmail.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Matt Coster <matt.coster@imgtec.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/imagination: Fix missing pvr_power_fw_{en,
 dis}able() argument
Date: Tue, 19 May 2026 15:12:05 +0200
Message-ID: <20260519131239.1291732-1-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u__1_cb1F52N4AFkIhsxjs6KzLmPKdnHz__dQQ0dmko_1779196365
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

Commit 42577ba79fbf ("drm/imagination: Rename FW booted to FW initialised")
dropped by mistake the last argument of the functions pvr_power_fw_enable()
and pvr_power_fw_disable(), leading to the following compile error:

  CC [M]  drivers/gpu/drm/imagination/pvr_power.o
drivers/gpu/drm/imagination/pvr_power.c: In function ‘pvr_power_device_suspend’:
drivers/gpu/drm/imagination/pvr_power.c:382:23: error: too few arguments to function ‘pvr_power_fw_disable’; expected 3, have 2
  382 |                 err = pvr_power_fw_disable(pvr_dev, false);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/imagination/pvr_power.c:93:1: note: declared here
   93 | pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
      | ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/imagination/pvr_power.c: In function ‘pvr_power_device_resume’:
drivers/gpu/drm/imagination/pvr_power.c:412:23: error: too few arguments to function ‘pvr_power_fw_enable’; expected 2, have 1
  412 |                 err = pvr_power_fw_enable(pvr_dev);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/imagination/pvr_power.c:122:1: note: declared here
  122 | pvr_power_fw_enable(struct pvr_device *pvr_dev, bool rpm_resume)
      | ^~~~~~~~~~~~~~~~~~~
make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/imagination/pvr_power.o] Error 1
make[5]: *** [scripts/Makefile.build:548: drivers/gpu/drm/imagination] Error 2
make[4]: *** [scripts/Makefile.build:548: drivers/gpu/drm] Error 2
make[3]: *** [scripts/Makefile.build:548: drivers/gpu] Error 2
make[2]: *** [scripts/Makefile.build:548: drivers] Error 2
make[1]: *** [/home/javier/devel/linux/Makefile:2141: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Fixes: 42577ba79fbf ("drm/imagination: Rename FW booted to FW initialised")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---


 drivers/gpu/drm/imagination/pvr_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index 0ed9e7be604b..a71d5b35601e 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -379,7 +379,7 @@ pvr_power_device_suspend(struct device *dev)
 		return -EIO;
 
 	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
-		err = pvr_power_fw_disable(pvr_dev, false);
+		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
 			goto err_drm_dev_exit;
 	}
@@ -409,7 +409,7 @@ pvr_power_device_resume(struct device *dev)
 		goto err_drm_dev_exit;
 
 	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
-		err = pvr_power_fw_enable(pvr_dev);
+		err = pvr_power_fw_enable(pvr_dev, true);
 		if (err)
 			goto err_power_off;
 	}
-- 
2.54.0

base-commit: c1079aebb4de218caa86c44f9a53700d1a582683
branch: drm-misc-next

