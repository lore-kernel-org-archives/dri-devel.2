Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E524CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2DD10ECDF;
	Tue, 19 May 2026 13:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fUgZVO7m";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4666D10ECBF
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779196315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lmE8m1KTGvjbfJBeKvFdnsCGJAOM6YzAXXd3ty/sM/w=;
 b=fUgZVO7mijp8BKyEs+aILQvW/BIBBA8OEwzXp266bDjvkSIWl0GdnS+YYDkZkA6OduZAhe
 rigk5H9ClwjVM/5fjZdnx4Aq+YLxVlX1/MS3/3K/TAL01fMHVuyEgoponza+kCjtqf/apq
 w5m/u/x7ddCvaXQuCxrHbAg7ZNPaw4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-YBtvCsmYP2iil5v4VeSF9A-1; Tue, 19 May 2026 09:11:53 -0400
X-MC-Unique: YBtvCsmYP2iil5v4VeSF9A-1
X-Mimecast-MFC-AGG-ID: YBtvCsmYP2iil5v4VeSF9A_1779196313
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fde68e420so33259765e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779196313; x=1779801113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmE8m1KTGvjbfJBeKvFdnsCGJAOM6YzAXXd3ty/sM/w=;
 b=iV61tGriJDDynA/1bge7gG/XO8dE3FFKQS/DmXDh/qz57FKiv62XDYPqBqt46mqMch
 v3a9kbPEbxofYgyF+BjdvQvA5owZE2wcjzrGxqAbGovtj59UGjQr+g5s9iJ0Tt1chBqa
 bazbwAijRwHfHckXfkpqaX7gvLp6+/CLb0qiHUH7aQk0gWeCwK7RZksESifc7iBql5bU
 hL/CAby6foj2qM8ySSG7QmHBIrrzgbUzBLpo4cG5+cyX+2GNPluqZNW2xn4uAgbETjHF
 MZ5ZPbGFZShjlZg2ErwJKq28ljWMAAc8CBDnT/jp5WNAf9nyNzr6Qk4WT1wWzvYW22C5
 6fZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zFXHOW2qqpZHWe6XCI96tgdLc7DFSWCps9Dup2RyP+unJTmDxxoMrB74LlUiL8pnZMo/uf/d0/DE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6p5gDM+V9wUkKe9n6+cmAaI03iT3zPpaapa09X40uwM91zoP1
 Wnvm9+nphq2EExMCHS7tarqc2Ki5KlfA5rFzdtcArgeg9zRYi/SkJ/pfILRapWbqU6ApbLLxjXC
 Nsu7pE448FmlCJbWSiIKgRMMcslQMlWX7S+ZIHBUg+eyD9iHav566854NYNc8CDWmBdkOPg==
X-Gm-Gg: Acq92OGscB7LNv/CisnRF75h0zmSwlkPIzhNKNMToaADYA9dOO9KuYCsrAuRDaJzQCO
 fdetQ7jU+MlEChAeig+DICNPMwPOeX8XdiI+OQirJJZNZ04C9IxHNIJP6yFO07X7jUgFR84Vqw4
 Gt/Yj4gMIzmAFwcJRlMyh0+09cGvesQzxtYWnJYxBgpT1lBPDWGgaVIoJlQSCh6YUTKthWD3nXY
 EwqRD45IPBVi7iVlMsr2v4IvOK6St06kj2Cq6kW8Hz3yb41VTVxRePFaCMe2dQZmXKJYzO/uPHv
 vQHvRwSfglO+TenioUDdDbHY1+xFpyhFzGQtQIJxJXfVDilOcfMXdNrovT5FJM3aJO1m6FzM7v4
 x0rQZRUsk6eHuxG63G9/t660BCumSRO1kx5vj/mYd08bcV0M=
X-Received: by 2002:a05:600c:3b12:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-48fe59ab80emr299209875e9.0.1779196312634; 
 Tue, 19 May 2026 06:11:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b12:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-48fe59ab80emr299209445e9.0.1779196312141; 
 Tue, 19 May 2026 06:11:52 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57943b2sm334627745e9.8.2026.05.19.06.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:11:51 -0700 (PDT)
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
Date: Tue, 19 May 2026 15:11:30 +0200
Message-ID: <20260519131150.1290393-1-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VuFJ3NtL7Mm4WndXv69AAVmLK-MxZ-IQE8iNnqaQOtU_1779196313
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
and pvr_power_fw_disable(), leading to the following build error:

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

