Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90351C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E353B10E04D;
	Mon, 29 Jun 2026 06:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KAPYmnec";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C1210E04D
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:34:12 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493a440bc10so7523685e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782714851; x=1783319651; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=deDbtmrhTXIdh4Sf08VPUmvpFowe+xk92+r1s9mAVGU=;
 b=KAPYmnecUmdeBhb+ccLlWFUuAlOUg3JojY6vuk1SEUU3n+LOQmC/2Ni8/dzSC8UYss
 GP4NXEcSJVnO86BipYtPg65k+tlf5dERmIIBfLmz5vyxGOBm5cX2vkkHpNYY6/2xC0Gz
 T7addkRZJAUzNZ61VMGegeBxSwAAbHNsjS+4EreRfczSHs2grmAv/Y0n2TlXq1ne/gVa
 VUoSey7BlbVxotVo4CcGa0spjm6I/3F5EUtcQNsTVBlds1Ya82/7OiuUIf3N01x/fBgq
 wZt8kbNqzLEKOKP684PwJR9jUmX2vYpjjWLYTomHBsxqbLa4eoxu9ix6C+Iy4FWmkFg5
 Zc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782714851; x=1783319651;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=deDbtmrhTXIdh4Sf08VPUmvpFowe+xk92+r1s9mAVGU=;
 b=beHVq59m2doN6rt3eaNi4nA2Zslhv/xDjdCsRIJSc7FUPG0KDKt5mRFJzqD48XT5rN
 ZqobnKJhXjnL5AX1B9PetyLjcVjkx7BZTqqG6sg/iUgvct9g+HuTYB0ep/TaRhnbGFiH
 VI0egN2QS4+FVZA2gihyD+W0gWpWJiEcd6eswd7zODyv4hdOTifMxPBd5O4HD9deB0xW
 QsapAtquSNNBQFgnC+nF3M+PI8wzN82L/prIO4feZCbVfXrD0DjyVfYmjE8GBAtip6WB
 njyx4VkxjmKgJOE5pwYqfEU5iDalIGJ7+Ap7SVHIXK3u7/WTkVdI2YzUqOPWNCS9jDgm
 2kNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vcH/PTRWBVniRvP/C/NMSmibSbIOj5QzyqS/4XCxLGL4Y2K6CowrKBIWLVFE/mHKl/XH/jGQ3tNc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzt16ylfUqa8wTTlAcBlzfmTMyJkSZLl36uRwH7QRUup0jrB8Nh
 oA8jfDGE7MgVHjJs3LB7V2PRtXWbPE37Pepq1S1oVHMQEltCCBy61roA
X-Gm-Gg: AfdE7cnAgDjf2nvYLiKs9NQPMhZzcasP68fh1DfoHWW1+LP04kYKx/pWmMZ7+F31xPR
 q5hrFojN/yP3zUmdwr/s2C0rkZRWQp5Gjta2t//5hc0DHCBmjd+GLR3AkmRxXZjNcMGO0GQfeP/
 MYw4MpMS7Sv3bYF8zUIOR8DMkwyOjX3TVi1fyyK7DOqbDs0d8zTcXj3dTBYcs/VCcBby/byQA3e
 xcV8fooyxvdxcaXCaWZ739E18k099JqTFusCt5/K44X5OzK8pocsiUhTjNKwCBsuC6986H0OuXu
 PHf9fUjGxahDO1zB0L8VIPiqb3HBHNWJ8i5uHmeBkHeZF8sLa89u4t6OneI9iZMuJX6ZiFwuiPF
 hNzjmNhaN54bd6bklhaWTcnbgnseKhI2uIVSJm/myTA/pPjPal1n7C16mpjz+S4j5giuwuFa3BN
 ECmjK1g/6z1w==
X-Received: by 2002:a05:600c:3f16:b0:493:a5f9:d341 with SMTP id
 5b1f17b1804b1-493a5f9d611mr70376585e9.15.1782714850503; 
 Sun, 28 Jun 2026 23:34:10 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:9cf4:43df:e612:817b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49271c1bb11sm186749385e9.4.2026.06.28.23.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 23:34:09 -0700 (PDT)
Date: Mon, 29 Jun 2026 09:34:05 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Martin Krastev <martin.krastev@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix NULL vs error pointer bug in
 vmw_prime_import_sg_table()
Message-ID: <akIR3WlKLCiCTb5T@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

The vmw_prime_import_sg_table() function is expected to return error
pointers on error and not NULL.  Otherwise it leads to a NULL dereference
in the caller drm_gem_prime_import_dev().

Change the NULL to ERR_PTR(-ENOMEM).

Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index 39f8c46550c2..f25db04f8777 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -184,7 +184,7 @@ struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
 {
 	int ret;
 	struct vmw_private *dev_priv = vmw_priv(dev);
-	struct drm_gem_object *gem = NULL;
+	struct drm_gem_object *gem = ERR_PTR(-ENOMEM);
 	struct vmw_bo *vbo;
 	struct vmw_bo_params params = {
 		.domain = (dev_priv->has_mob) ? VMW_BO_DOMAIN_SYS : VMW_BO_DOMAIN_VRAM,
-- 
2.53.0

