Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65087C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE68310E993;
	Tue, 30 Jun 2026 13:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOpqV1Mb";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217EB10E993
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:32:31 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-969524c1a63so1103910241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782826350; x=1783431150; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+YCywkOkO70aRG21KZPW97TUrAbHKntR10JJ7tL/IY=;
 b=bOpqV1MbZIfk/ewwy0hnZiLCewwk9JYyxMx1m00zeZdpGZX4mfiMdvasoV3u2yLtOW
 N2UfsDRXeSttXk4gaYE8LeuaUP+LYj17QWURg4qjfodtR2b6KDeB3b/SqVx8XSQYyhjR
 90TizcFmJUpO0E57jrmnidDJzDvwfFuq6DFbTwyGaseb9BSmOSZb7s54RO98Zxhikw04
 Zm5OYa8O6MMw09DvRIOGEibrE1kHQ40I4667G5UK4rLaDY7dllqsHlIoHVJRuYA2qh6P
 qqWnjRB+tI651GsLN6vd+3hjCfFKi/ryvL9OUYdNkDlLkv6kSDf84M1Wfrj22yTjgC5L
 Dv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826350; x=1783431150;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+YCywkOkO70aRG21KZPW97TUrAbHKntR10JJ7tL/IY=;
 b=A+ecflSflJ49rG03nI1VDZhZk3no+b4zGqj0Meg89WT3pAafh9Hs5fMioq8x1LnuNq
 7B5me3APHyOUws9ymu+0ZMLIoS1oiQQKTV4jGieDexG6Q1Q74hpKKOmVkCTDnyPVLopT
 EhnfVzPZ6Enqr8M/1MbnEMNwERlG0p2QlJGzzbDzhtUd0JD9zcqkhTQN0qSwtXfBXHgY
 yAiun3QfOiAdwF6amfyjm6Rm6Py8i5tisBDpMLfvrrbmuwXQo8izIJX5Uxm+KsCOgaTk
 kvtyvTqOKwBD1RoRr3y716EIveXH14TbnKTwhGjk+3ONFYVjDSrfmmBDRJkquuR32xzL
 D1MA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq1iaPrHMm7RrbfTuu/mgRaPMP8R8PdfYGajL+B0uG1TBX94l6WycRtZCYtKpiSW3dGn9EOwJIRMk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3Aa06QCuOcCKJBkeQsHuy3VgRplb3j0jQVypxWhBwI8je8FF7
 FIqUVAdTpRljnOir2ZOkY3WEQK+gjPqH2YmO4TaNApZh0Yd+uGo7WV0k
X-Gm-Gg: AfdE7cndiZykTfOrM0HduCrb1putSw5UuDaxii7+yEVG8O07BAkaoIMmgGsu8+sko7r
 64fBn1W4E42aUromZX4/21H55KPwviOnjOmBQWe8JX1+0Y2KVeaPEeJh4n/8uGAVoJGoDAcO6+W
 EMCu1rx/JQ0WNKFMvcwkPM6INcR91fPUIMJpV4cNpGaEOfVuqBxSKFerCLbgrjzmImrU73OeEHi
 yAqbYh7xjPB2QUwD4V0Db9egZwpTrpROgGVLTOSKuCHFjh8XdzAgWhpjUl9OKpp6HqlI+Bx9hDW
 ZIoL88bBS7KSd53UyWN9Hf1qqRCp8uEqAWfWHRAUoweXv8dCJfbLuT9yBz97fypMIo37yJFMosv
 ju2sUuC9+9nsFTGJyReZZKK8NJD18eVlRV4vdzWkRoDkNgd4vkE4dq3ejhMVR3kpYBIlNhddpn3
 UjXW0o
X-Received: by 2002:a05:6102:644b:b0:737:d243:33a9 with SMTP id
 ada2fe7eead31-73a38c35b92mr1717041137.22.1782826349559; 
 Tue, 30 Jun 2026 06:32:29 -0700 (PDT)
Received: from localhost ([74.80.182.83]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96965eb2affsm950502241.6.2026.06.30.06.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:32:28 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:32:23 +0300
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
Subject: [PATCH v2] drm/vmwgfx: Fix NULL vs error pointer bug in
 vmw_prime_import_sg_table()
Message-ID: <akPFZ-e9usvsYgf_@stanley.mountain>
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

Propagate the error code from vmw_bo_create().

Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: Propagate the error code from vmw_bo_create() instead of hardcoding
    -ENOMEM.

 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index 39f8c46550c2..93a92ae625f8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -184,7 +184,7 @@ struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
 {
 	int ret;
 	struct vmw_private *dev_priv = vmw_priv(dev);
-	struct drm_gem_object *gem = NULL;
+	struct drm_gem_object *gem;
 	struct vmw_bo *vbo;
 	struct vmw_bo_params params = {
 		.domain = (dev_priv->has_mob) ? VMW_BO_DOMAIN_SYS : VMW_BO_DOMAIN_VRAM,
@@ -201,8 +201,10 @@ struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
 	dma_resv_lock(params.resv, NULL);
 
 	ret = vmw_bo_create(dev_priv, &params, &vbo);
-	if (ret != 0)
+	if (ret != 0) {
+		gem = ERR_PTR(ret);
 		goto out_no_bo;
+	}
 
 	vbo->tbo.base.funcs = &vmw_gem_object_funcs;
 
-- 
2.53.0

