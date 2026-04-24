Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56874FED3E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31C310F66B;
	Fri, 24 Apr 2026 17:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DpDMG748";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C427310F51E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:25:51 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-35fc0d7c310so5224821a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777029951; x=1777634751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FSJ7I3/KIQ88Wa0Cq5z543CNK+Uoag1ofD2MM0j17pQ=;
 b=DpDMG748aXHsBPoIXLfZ1Laf1lVj4BQrdo/9CxaglKVPnlhYhslLatGahaDWlvN7Ho
 R63QK9CLC9w7w8biTFyMoLXOTZJsWp5oFIe6eZJikaveAfoLWvHgTjoBe3K3D1ivE03N
 xbayrulr9ytAUkIJvhXRGY0gF4eWq+roa1XnLgw4pnRpebotzUzhf3vWSmwcJYhkoiO4
 OCSAiUcQwL9DE4FXsk/Kq9daRMY0N6Gz/JkviLbNvSbRqzD8JD4kRa1Ir4TpM2yD/gro
 hDqa8A8qgdopERJPSiAlMpYujS+l99w+23kp3fIshC+0+YwgiEce6OavBKslYbJdVuSy
 VTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777029951; x=1777634751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSJ7I3/KIQ88Wa0Cq5z543CNK+Uoag1ofD2MM0j17pQ=;
 b=j32/Vgnp39YhOYFIQQ+uVywg1vvOdDb7JxStqLEjWzv71ZXJi+vIB5v7a3GE9RdCoT
 pQG/2rSp094nuoKmOOQTlUzZAQkU3NxbyjHQhm+AWMxdJv2v6ebseoeSX6MP5N7wa9c3
 uG6uEZbSI+ThDGLlrMegKyXSqglKxAVyYp9wm/ZD4KWi4/M8TqDVtf+0k/Pplwo0eAs7
 Bd9r/wDmovT4opE6Vg1JKPwPMMNPhyUMc0hW9z6yhmEVDy+5KmJdJQUWpIx3ezofyqFP
 xYh9MHtkIxm3cHvdk0UtvN5Ed7FptZF/nDWezTTSEyAGWBIYE5H9PcCSt7Y8Nh1ytAt/
 Soiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QQZw1Aue9ZCQ2JQpPch1bw1lT3uieyqRNI6hmMhVgQ8019BJ+oil0NgO0cNQOGIJkTfvKSW29kCA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFv+7vKO0toaZ5o/H+0y0ZplXwK4nl804RP1e4+Vyqq/JELVyW
 aJgQ9s3TWixfH3p/VBh/M2dc2Mdk/UkDPyj0GFx/ExMvhni7IaxBpKw=
X-Gm-Gg: AeBDieuyy+aWxgUHbnxik8w1FkqYKVHK+n/uBLDtvmx9L+7p+979YSDxLqFsdgJzttS
 W4FDfKMAO/V921VPI45QPkrjZiGbZzSMQYreKMb+H6d4SsWDNq9rfEwFnQqGzBhKvBYKbvrdpbN
 YYthcErJcUQ5P0SoPPZghSF8wHZl7poS8sQmxHW9iRn7OOrgJOdsKS2blti5Z0mcd4iwoXIKgl6
 9+Pc1piZRkCKB3SVhLA9iZ2js2U6JJxxsCee+A0BfbSSSborqsdkK2irRMJG/Hqe4IHIdDez8kR
 zRObOHywViOhUsWsE5L7KEfQ5UjJ2Lhx/2orTP750K7BXktkbAxj6x9Dqrwmh/AknCcDuOWIAZb
 w1y/82okb98wLAQhhQrbMZ+OtJmzrmeCZp4jcatDnhnntryZdI4MhVKkPMlDB28Y4jMiiLiOmB7
 tTaI4WIXMNRyyvlDGoAGFQ1EWs27L8oIDOjU7GojC7gqrP6cNrQLbtN17uZEvYCJCkJ2e4qjkUv
 SNakFGxdQ==
X-Received: by 2002:a17:90b:380c:b0:35f:b5df:448 with SMTP id
 98e67ed59e1d1-3614049ed12mr32784879a91.24.1777029951174; 
 Fri, 24 Apr 2026 04:25:51 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141990bb6sm23974050a91.17.2026.04.24.04.25.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 04:25:50 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] drm/qxl: Fix missing KMS poll cleanup
Date: Fri, 24 Apr 2026 20:25:18 +0900
Message-ID: <20260424112543.57819-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

drm_kms_helper_poll_init() initializes the output polling work and
enables polling for the DRM device. qxl enables polling before calling
drm_dev_register(), but the drm_dev_register() failure path tears down
the modeset and device state without disabling the polling helper.

The remove path also unregisters and shuts down the DRM device without
first disabling the polling helper. Add matching drm_kms_helper_poll_fini()
calls in both paths so the delayed polling work is cancelled before qxl
tears down the associated modeset/device state.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3..1e6a2392d7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -118,12 +118,13 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Complete initialization. */
 	ret = drm_dev_register(&qdev->ddev, ent->driver_data);
 	if (ret)
-		goto modeset_cleanup;
+		goto poll_fini;
 
 	drm_client_setup(&qdev->ddev, NULL);
 	return 0;
 
-modeset_cleanup:
+poll_fini:
+	drm_kms_helper_poll_fini(&qdev->ddev);
 	qxl_modeset_fini(qdev);
 unload:
 	qxl_device_fini(qdev);
@@ -154,6 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	drm_kms_helper_poll_fini(dev);
 	drm_dev_unregister(dev);
 	drm_atomic_helper_shutdown(dev);
 	if (pci_is_vga(pdev) && pdev->revision < 5)
-- 
2.50.1
