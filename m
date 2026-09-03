Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410DFC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FD910E0C5;
	Thu,  3 Sep 2026 15:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q8TA/JdP";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CEA10E0C5
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 15:58:06 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-482dd6ee390so26131f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788451085; x=1789055885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b6tKOR5KZSNLaAYuQSBE34bjWw9CzqlGHsE0UPAcN9E=;
 b=q8TA/JdPCSsYkTiZJIk8pKurKOxrbt+HT++0TvryfN/7VOpDHXrMPxC99kuFSQkVNA
 zW/3nSklpe9D3mF3hn7VsoKzjxhwjKcBorpmQgWGVbDpTLrvRBNYAJ3zi8JHvmywp/W6
 XuBt7dID4KrUc3IF+Upw6nMjxIWlUE7moC0I2Sp0yjXY9QCegDjteI4TpUN1scToVxyh
 uyohHcnPQVuWkq7KuNwNkG/D1iGd1iFsqYVaGIEEBe2kV3pbVBXkMkMfpD2L1+eBdvRL
 bD4j6zQiuqAsL0j2YoVv+dIFiTIooSYDOT1CQ7Xhc72pca1glJqfQok4CnAOnMMEbhma
 CAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451085; x=1789055885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6tKOR5KZSNLaAYuQSBE34bjWw9CzqlGHsE0UPAcN9E=;
 b=ZnUACgtl40u1EZpAVFupRku/oqKSd3if21xyXvrdXi2eFu6qsnPcSlh01HDRQQcsuc
 GpaHVgVjKYJYdzdOm0H/vsPfGrvfSpHQGiRzB5+qU635I/eKFIifLo3ftB6M8CRxCyVB
 2r8xYZ1AVMivlPOhQ6EannqqadQDMxjWTFc0V3swZXBscLrP2TRNifm489CabAUsenpz
 0zhUIw0z0PiyCPhlXoYaow4ElYkUrAJXZsuH2JsQ5CDsvtFl75RL2/JlDfc5aildlu2J
 oSgWd4ET5uwmXgHNOGHOEUUMLP147S1HnYpJAVNYKhBGOKjzegh5wBmQzHXag9BTd1SI
 dUGw==
X-Gm-Message-State: AFuF++nmITaEUWB0/ivVzAc9ZtMm0gqQla+h7PRf1GxSUVjhCIi8ogpT
 9EzgPQgTmjUOw/cMS1973HPyGtiUPDyUbxGEPMmqM/uX82jpP/d9w8ynohK+ylQX
X-Gm-Gg: AYBFou3+j3d8gJ8PPvuycPtKsyyPeggBQ+vaHq9uaAcjyU+LlCJgpHvj2WUXGMczUZ/
 M8YtfSDxh+aB5R1sySqs7zZRjCzDaBnYuqxA3NYiuhVPPbSl0PGA1ks91yn2DILylQcbOL68B7P
 frrGvaJ5JQC5uzzUgbb3tK9F2If2bBz0o6rA8WmXk9+ZsRXuVfMZj4kjPC33PEkHTG8aGH5SnPY
 fasuveEy6TUtKg1g8o+aqQGjRMVug02uAam47Ifrgm8ayLgpTjdUkZyxT6yFTxwzOXl5OGprJd8
 NrVd5vPnX8PUuX972Nb7AZ7yjB6tLiU7RIToMHnYPZJaOheoGhNJGmD8Vr6qRWnlB5ZjgNoUzQp
 2X0i9YIo3OA1tYf/b1yuCYwJDT8uQPU/4soGkqu0W9JyAoyqYzjaSYJeKJgr/c5QasD2QBtkbVg
 gRd22/0GxXuKkMUlkgUdUx4rAANpQlJhSznyHvykn1gz4CiIvmArhKtumciTbpehZTL83yqUann
 XiMpA==
X-Received: by 2002:a05:600c:6749:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49cf5be1647mr19593155e9.12.1788451084371; 
 Thu, 03 Sep 2026 08:58:04 -0700 (PDT)
Received: from localhost.localdomain ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm14388587f8f.5.2026.09.03.08.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:58:03 -0700 (PDT)
From: Andrey Erokhin <language.lawyer@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm: Register the full minor range
Date: Thu,  3 Sep 2026 20:57:43 +0500
Message-ID: <20260903155745.3027211-1-language.lawyer@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Commit 071d583e01c8 ("drm: Expand max DRM device number to full MINORBITS")
expanded DRM minor allocation to the full range provided by MINORBITS.
However, drm_core_init() still uses register_chrdev(),
which registers only minors 0 through 255.

Consequently, character-device lookup for a DRM minor greater than 255
fails with -ENXIO before drm_stub_open() can handle the open.

Register and unregister the full minor range explicitly.

Fixes: 071d583e01c8 ("drm: Expand max DRM device number to full MINORBITS")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
---
 drivers/gpu/drm/drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index c808958a2188..25819c88c627 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1250,7 +1250,7 @@ static void drm_core_exit(void)
 	drm_privacy_screen_lookup_exit();
 	drm_panic_exit();
 	accel_core_exit();
-	unregister_chrdev(DRM_MAJOR, "drm");
+	__unregister_chrdev(DRM_MAJOR, 0, MINORMASK + 1, "drm");
 	drm_debugfs_remove_root();
 	drm_sysfs_destroy();
 	WARN_ON(!xa_empty(&drm_minors_xa));
@@ -1273,7 +1273,7 @@ static int __init drm_core_init(void)
 	drm_debugfs_init_root();
 	drm_debugfs_bridge_params();
 
-	ret = register_chrdev(DRM_MAJOR, "drm", &drm_stub_fops);
+	ret = __register_chrdev(DRM_MAJOR, 0, MINORMASK + 1, "drm", &drm_stub_fops);
 	if (ret < 0)
 		goto error;
 
-- 
2.55.0

