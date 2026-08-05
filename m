Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C09EC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30CA210F0E3;
	Thu,  6 Aug 2026 06:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=xbow.com header.i=@xbow.com header.b="MK1qRheC";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67EB10E1F2
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 12:44:47 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso733735a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xbow.com; s=google; t=1785933887; x=1786538687; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QBugC61SebRfHUYlxhe8LyjAwmlc8xHKfpXGCT71Nbs=;
 b=MK1qRheCtqeaq1Tdn9SxY4VnUTXWKfhLWjgTdpyDs9He8ktzoFQ+dkcNb2K3H52lyk
 N/iE5FGp9OBD/TOlllMIHNOwK00hG5W+R9Sednn5Jb6eenHY/jY51BrT9WR1ojMpZIc4
 ge84xIPyMlDj5UC5eIPV5A8yKojTEyZJJ7EKX49t3MWI7Kd2UL0j3VjVJLsDudkk3RS6
 khsfm/sftlnSn8lr0XlUBfYTRZxcFBve48j33fuTMqRTJxo4lP86bwjlPcu+yZSgIxMk
 JtHfIm/HAIUSALvvahQ9Af4arvGvcEnaqEcabLrcwZrRqQ574yONLIsfyP1uBeQMRyhd
 H7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785933887; x=1786538687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QBugC61SebRfHUYlxhe8LyjAwmlc8xHKfpXGCT71Nbs=;
 b=Nm/D4cNqu+qswhYMng3FemYmpEppzIAAQBq8QMORREzYpWCcEtJhlhHinktaFJkx12
 f+hBgmu5lU3N6jfxkmGV7I3Vjl9Ab6GdvCjdwVn34hA0zgRZfxzAhtS/OLsGJAObXeAA
 4gFPA5EmUIu1XIPx3Nulhd9e0CbIJTD4272raQQ3UiqY0Mxzvj5uUKLtUzSLn0tZGWzR
 VJNbgkxKRbF2GbzRr/7DkJzurxteir/zOg9vfUmkXOa3/SW5Fvyq0WNlClF07VgBjvGb
 qfiCLYyAIvcVf4fSX+8UhhXZAzfNeLUMoTvthYegY8jTfsXtVRkQunlWNUzhmWat/yTJ
 fQFQ==
X-Gm-Message-State: AOJu0YyZHeZEKN95IAjG/lIhShLi7/5uCRW849GjIfzB9ubImn5cPNCQ
 1yqhCgICm9Cw95uzVdsAu2w0lmeJLbGs6CThS+PJbl0HqaRv7EdMAJLXb7YZy0/2qf4=
X-Gm-Gg: AR+sD12hJfH1wR9NC0+FtHIx0CuO8bQiEeordnDhj9wPsJfM8dxTbbqy1KAk3c0ZCVU
 +vf2361lqKp2xI4SzMMzf7my2eaeal4nbwAG1m6DzZTL7wMX9FGxPOJUDLAZvHkPMz+W0l+GlV4
 viFMi1BEQmUnWcByYxFFwjOjimUNN613FUtB0sPP6/0CPrWaR+VA1MiHi8OXQNHv9dXq7hlJxYN
 sv4jgqDav/ufMhShZogaIj+JjSGIkc93P5thp73+Y56v0IvrGPbkB0aIG0dScukg3o5j+gLn67D
 e7rQuHV1BO6A4MxS6uuBEH/BbsahuW+5a9UkvfRZsN1ybjGuQ1Zqiekd18t15Tvxv0JSUx1D5aQ
 vMKtOkF3yRVwBlRwKBVnfNipzU7kZ1/cbk0/bpDCh1rw0U2qK9S7gtMf8XGqaEge7DzOr6TUjUb
 Nf0fW3CRc3NdAE2hPufEBHkIopGXAXO6RXbhcoRVEQwPt9DjBI8Pns25qzT+E9ork5+jj9WMZkK
 q1IlY60csEuSWUS9OPI5RSrAys4CT7ohWiqUvI=
X-Received: by 2002:a05:6a00:4b43:b0:845:e2da:91a3 with SMTP id
 d2e1a72fcca58-84f2e0276ddmr6987044b3a.30.1785933887134; 
 Wed, 05 Aug 2026 05:44:47 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe707cab37sm1546962a12.7.2026.08.05.05.44.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Aug 2026 05:44:46 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/gem-dma: fix double GEM object put on the mmap error path
Date: Wed,  5 Aug 2026 21:44:42 +0900
Message-ID: <20260805124442.57426-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:52:41 +0000
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

drm_gem_dma_mmap() drops a GEM reference when the DMA mapping fails:

	if (ret)
		drm_gem_vm_close(vma);

drm_gem_vm_close() puts vma->vm_private_data.  drm_gem_mmap_obj() has
already pointed that at the object, and puts it again when the callback
returns an error:

	drm_gem_object_get(obj);
	vma->vm_private_data = obj;
	...
	ret = obj->funcs->mmap(obj, vma);
	if (ret)
		goto err_drm_gem_object_put;

One get, two puts: a failing dma_mmap_wc() or dma_mmap_pages() underflows
the reference count and can free the object while the caller still holds
it.

The callee does not own that reference.  drm_gem_shmem_mmap() returns the
error and leaves the put to the caller, and both callers do it,
drm_gem_mmap_obj() as above and drm_gem_prime_mmap() from its own error
path.  Drop the call.

It was harmless until commit f49a51bfdc8e ("drm/shme-helpers: Fix
dma_buf_mmap forwarding bug") moved the vm_private_data assignment ahead
of the callback; before that the field was still NULL when the callback
ran and drm_gem_vm_close() put nothing.

exynos_drm_gem_mmap() and __tegra_gem_mmap() have the same error path.

Fixes: f49a51bfdc8e ("drm/shme-helpers: Fix dma_buf_mmap forwarding bug")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 1c00a71ab3c9..a34561efd1ae 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -550,8 +550,6 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 				  dma_obj->vaddr, dma_obj->dma_addr,
 				  vma->vm_end - vma->vm_start);
 	}
-	if (ret)
-		drm_gem_vm_close(vma);
 
 	return ret;
 }
-- 
2.50.1 (Apple Git-155)
