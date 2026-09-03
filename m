Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C72C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275C710F52C;
	Thu,  3 Sep 2026 11:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDBnew/5";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE7810F52C
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:36:25 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so2147402f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788435384; x=1789040184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m5nFAvnp9TbeBbFXDaBPRO3V4SNXTlxxZw2s8E+92CE=;
 b=KDBnew/5lLi041lk58SqZK0WVU6UFcxUJTZFngHthHq2jE8BJhnMI5M0uH9rO/BrFF
 cyp01FMC+IXHtaJgzv/kvUY/Dt7ZOCVJcUsJFLGdhyW5rsaiSOoNH2nzJc+QXMbvQjTh
 eaHu5/0gaXgFgZE02igpDPvAgNLFnJCkKCcG2B7BzAX9h+/ZGrbuUMG9OzpguNNUsVOK
 Icp3OAyOAjsjlBN0DjcO/AJMdFQgC8lrX1QZf1H/L1dDqalQdT8wbBLsl0XqxX6U8eYz
 8l35XbwuhN2TAURTDXNYOJUuil0zgOkzdtVAd2mNVIUDVybzGFAXt+gCkEMJvLWHzlYj
 rE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788435384; x=1789040184;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m5nFAvnp9TbeBbFXDaBPRO3V4SNXTlxxZw2s8E+92CE=;
 b=ZC1ednRed8PIzVIXSzW68g/NtE92eaSXyn5wccMfQiQkYPxfsLiRPmZH4XFP9dM1Ed
 jo2euCBHbh+DgDIS73MVeVeyWsUHx+e6eFDRIRyaLC+SMIAiYZHJJob3/HfVGe69Ig23
 gAxbRPtMtNTo55nyzh/ihx9ZADYWk79IL/rM1XgAFwWDZW56LWlsWFEo7qFcb+kBZrg9
 Q1lIt7ex03MzPS+z2D09e1wGNZkyu4ksgwUIinCtUH2FLCPESxQAgVvCQxN8OMzihXxD
 9uVCqPHcWP3qsr7ku+G59/eHpOAZoeXCoO30dlPSNuMJ2h7jDPfm9rgLQpAInFMAXlOr
 WdNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBws0ANXrYpCER9qm+MbygbI1lm/VRWOXd4hcuIvYDdhctfoXp4Cg/amQ5W6kh0RFoPSIGdYxbV4PSc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lIuudKJUgz6809xeT61DoV37jt13jLs3ZetlaEWemd0h6loAY1
 eJlw4JTk1JwMnt4ZNGcuZUQAmPoyJCuJYa/Qti5RkLbAF64OHW1D00o3
X-Gm-Gg: AYBFou0gGbtf2zmG/QADj+XjtU7ATKg44kIFNUhBTezBNPgc7SEJG9tQ8Q9/i0CXe4W
 40DDJgqSdJd+UoY5+J87KMQOT/sM8Iyjfi0YebyhCh2Mu4WNk/QwEIkke6YpCiB64A0EKc19guO
 odObE4L4BjplEf+x6B42MMWIKLON1aBRJxzxmmYbFvmpCE/WA5VK5wKlZOXuCDOgkkxqUZVsSNX
 xiyvEGEnCe8sU9QrEKgAUkoLUgFGzH4Y8mMK7EDMX9Skzp+Pnk+hPywNztQbWtuKNC/YDPouoiK
 Drw6M4bx972EoWNqRYjVirK4ZFeMvWmKpw5DJWH/56oOLCdKukzJJismxyXNDl6WOF0h57ofzIX
 88yDa8iuRlU+7FNVBsawXLV0E1buiZ/7p4D8CLKFB78a59kKHsI+nTBzT/lGN4zHC0uidCtJl5G
 FBT8+NLZN07vZLvbAXhv93Je0xtg1iRyDMglIOSlgq7St6AIEvlpBeGcFck5aSFatsRFd3LIT2Z
 g==
X-Received: by 2002:a5d:5f46:0:b0:484:36e6:d3f5 with SMTP id
 ffacd0b85a97d-48488f1b255mr21290906f8f.20.1788435383393; 
 Thu, 03 Sep 2026 04:36:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72f02sm13011020f8f.3.2026.09.03.04.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 04:36:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: fix incorrect RCU teardown order
Date: Thu,  3 Sep 2026 13:36:21 +0200
Message-ID: <20260903113621.54660-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
over the fences in an GEM object without holding a reference but only
the RCU read side lock.

What can happen here is that the GEM object is destroyed concurrently
while i915_gem_busy_ioctl is still running. This won't free the GEM
objects memory, but still drops all the dma_fence references.

Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
assumes that a new fence list was installed and re-starts the loop.

But in the case of a destroyed GEM object a new fence list is never
installed, only the old one freed and therefore the iteration never
finishes resulting in an endless loop.

The solution is to drop the fence references only after the RCU grace
period.

The fixes tag is not necessary the patch introducing the problem, but the
one making it so worse that we need to address it.

This problem was pointed out by Sashiko-bot.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
CC: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 5172d3982654..9e01f8b2079a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
 
 void i915_gem_object_free(struct drm_i915_gem_object *obj)
 {
+	dma_resv_fini(&obj->base._resv);
 	return kmem_cache_free(slab_objects, obj);
 }
 
@@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
 {
 	mutex_destroy(&obj->mm.get_page.lock);
 	mutex_destroy(&obj->mm.get_dma_page.lock);
-	dma_resv_fini(&obj->base._resv);
 }
 
 /**
-- 
2.43.0

