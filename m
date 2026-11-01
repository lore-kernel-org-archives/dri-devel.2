Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB27606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlGUW+ex
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8951910EA01;
	Sun,  1 Nov 2026 11:58:19 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBFB10E108
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 03:27:45 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-369f33df08eso3882613eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793503664; x=1794108464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uZ1wu6PLqXMmPV5e2kmvwPP60bjqKeA1CATvShGwVGc=;
 b=DlGUW+exltg7pXLxb4q86Nv1D4uN3vjjicGk3Hnmajj/2OfCi5BLaVP57Rf8tHkdl2
 rbuM+Gav6u4pJzLDGEEbEyiPDa4BhSWdPvD0tXiZWPDRPvmQfvPVVXvdzZZbjZ5sc0fS
 +k11myz0nzA0JxLLksisSD+R465zsOOKXc8OjF9Myo2rheS/uPeMy644Q7i4+/uADu6t
 hJYeQpKMx2/FrqHi9j9XXCHI8SDynunmLz3PJEcJZFLzygYMe9lr7lgYKIXGcNu4FP/x
 f6Q/lhlizIq/0fos5JpU3FNmNxpE1Vgh7LAFqmyKKEKanmXg13ex1uUeuub4HjqLqJ+S
 9MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793503664; x=1794108464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZ1wu6PLqXMmPV5e2kmvwPP60bjqKeA1CATvShGwVGc=;
 b=g511Dv8gKKp0Rv/R690e4IH0wO0aJqU1JxD1VLEdfg+2HGnlmVHPdp/zp40tMbS5bb
 5TvTcZHCrZOTHeaCd4r6dQBOEmL739y1Gk7kK3105viN8V+UCInA3FyLQzASGdx09uFm
 j5GY+/Q7+B7dnbRn0OnH2djbsOmZ2Tg9w7+GM65JAMivt6SPxkWzJSH+e9DUlOvAoHMS
 U/cYbY5UodZd6n5CL6VfTTbjmQ9F4fplz/3R3xrGws0ZqEgKCQOp/Jn8PN/Fhs+e0mAl
 1xnKh8uNerJ6NtsU3MzhDRsjqPsmksenDUCXIY7QitNyMcjnqdAWhqVsqxwMTycxEuxS
 qjeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByOuX9CdfwFL9e4T30RSmBglZbReoRn3+xAzxsfFL04NajxbNfMircJiHjWBF045qr18X9AgFQGetI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81oFk2v/qGj0j5Kkakd6J0rPJDlzW4KEgxSol/sVTimy+hvzAS
 M8Z1nF0swTwCCPugU5+8mS87wxCPYeoYiq6L9b3dmqiUTcq/oUSm+GWG
X-Gm-Gg: AYBFou0y+224YUzsxjwKwa+i6nAFxpZmelQbUIhKNcS9ZSeNxBlW+x7/yf6HpW9SNdy
 shd/9bDYjlW7gn/qpjuO0xLEwnDali/eE64UDt6+lvUGlXTQ3hU+XwKYl2HiVYmwYYKZ/tVH9r7
 KzYh5q3nXrMdvkY6/7zqP6mguQ2vbLcpAsA5ZSrZt/EimT/HMGZ44FNnI3+kRQRqe0pa6Xw4xdP
 aogXT7zcq9pY58am6IMO0K2C1RPb0RyXew2rccdn8LQbmxcWmayx8IT7fg3SPqdJy3o4MxZJQEh
 +38cCBzE27AL/VqKgDxJLD/YRjy7xSKpZ2kEI2P/aQkzO7JjWrYo/qZFjxMX74/upKkel0HBvU6
 qF8+soCIKuV2raM5v9rclMtj5sSO4Jkq/xlqlXm1lzmRmgG19fGDzazMVnbMAMFvZkc71VyflJj
 Zo2MP3aVH0DyNx0yzMDMCLWaYffgCKoliK8MFXbEZYiG6JyOkkhTz1Qsz8G8JXFcK+90tXwBgPM
 +pJJPgEc1lZmTdBnNwq6W785PqWd6h4gaH3NuLINfjxzlAi/ESJNCijnoIZMxi44cdT1iShF+Gk
 lhL/USE41K5mrSp+mosjibHrtEelmsp0Un+uZDyZ+fAvVq6YqWeLF2/XlnD6Yw6cz2K709iMxPm
 a6c4YoJXHo5ZFmMcaIEFsFwY7w4/QhJQUlIeGYz+v+o1UCj5aEfcpirzwX+5y9AE4NALT+jzkEU
 1muxM=
X-Received: by 2002:a05:7301:618b:20b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-36a4241b070mr8889110eec.30.1793503664340; 
 Sat, 31 Oct 2026 20:27:44 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42935b4asm31034735eec.16.2026.10.31.20.27.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 31 Oct 2026 20:27:43 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: clear config->dev when vkms_create() fails
Date: Sun,  1 Nov 2026 13:27:28 +1000
Message-ID: <20261101032728.11422-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vkms_create() stores the new device in config->dev right after
devm_drm_dev_alloc(), but the error path frees the device through
devres_release_group() and faux_device_destroy() without clearing the
pointer. The configfs "enabled" store returns the error without marking
the device as enabled, so the next "enabled" write runs
vkms_config_is_valid() again, which uses config->dev to print its
diagnostics and dereferences the freed drm_device.

Clear config->dev on the error path, as vkms_destroy() does.

Fixes: 13fc9b9745cc ("drm/vkms: Add and remove VKMS instances via configfs")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b5..ecc2e47 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -215,6 +215,7 @@ int vkms_create(struct vkms_config *config)
 
 out_devres:
 	devres_release_group(&fdev->dev, NULL);
+	config->dev = NULL;
 out_unregister:
 	faux_device_destroy(fdev);
 	return ret;
-- 
2.43.0

