Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD8E1093163
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5D710E7DC;
	Fri, 20 Mar 2026 01:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="br3sPpKd";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A6610E7DC
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:08:16 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2aaed195901so5425245ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773968896; x=1774573696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g+MtQY3GBP0FcqvY6s09ctlLbOJ05XY1yODrc7nIS/E=;
 b=br3sPpKddW0xS3b3/8JyaqoqEIxfK7/1aaxPQQQ6QIe8ufbLHYh/LoFY03GicjCehO
 JchW6CALrQWqG4IlJUpRFxkzUegDBpbaL/0ZGUBZWBp19CBsKfzoAKmgkBu2gVuhWD/7
 ZwFiClK0KmNqXGwB++9YLKV9Ggj+H8u9XOwOeOm25M30kzCvKWCydhQlb+xSHHKv0Guq
 PHrF/r+jDUI3zSGBnpbqprgyqo/W9eqDjGZnK8a6m339BXT9uSpqZWJipqUF/+dG0u5E
 f7/yWuDs0zweBQTAkLE+zz8AXMBj8Q4yj8of5Y3gJaE7icMUTIgCNtyQkrFeS+cUecor
 tVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773968896; x=1774573696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+MtQY3GBP0FcqvY6s09ctlLbOJ05XY1yODrc7nIS/E=;
 b=LXPpCmrFybyYq9ip7oBr1n24cjXpX7DopOFr+9nsPfbkSLBSu0SQcBM+ZUBHuING81
 L1BQcQsO1ILKvUb9rmgnH612mFYFqg/8Twq16UYdbazBEwWn1j/9RAZy/mYk1aXLqOZm
 ousUwfnhKRW7LP0AAYePCRGxHPG5iwA3pFVgm7drBOT2pH6IhxBFMxEL6/q+/XalfK3N
 wnPLu6NwgIK80RWsqjsfZM+tneh9hshW7Xm0+AlAqT/b8TQAMMBlwKkd+ZHXo/fvN8zl
 d/Y24rtUrnAboF+BxP8zrKAwnfFL/ZT3hc6eEYsfsRPJ4PHfwkl8V6cvk+/9iyTgOhp0
 Qwkg==
X-Gm-Message-State: AOJu0YzgMAe9CQeJFMzYvQDCf2iBBTIOluMROELujTf9BuiAW7eSjrdx
 vur8vFRpYfUKeqcW3RPlm2rk8u3CNS/hb3nfTaII3jm1WMxdxskuOdaX9UTqXeVo
X-Gm-Gg: ATEYQzwE1h0e4A9x9H1NpUl7PKZUocUCH973BMqVx8xYy6GepSaGnOnUxUY7gPoIDZi
 Kz2fQcsBgVvQW/w/weT3d2ouxQKJz0L14LdPpzfpLAdlSN7YUpYelHoricK2WnvxNrMnwKyK7po
 PZ++dgRvUzMmGdDL/MSYdQiJ/5WLBWNBeJ/yDUi7QSBfoVh3L6eH8DfZemXi8l4m64nviYcd1g8
 60hbB5NUjNU3ZORl6AKJRU/vvsw9lq9BGcP/ID+Z5V6jWageX3DRJowoXMidmQiMuWy6APUU+X6
 /exfkuS1ywVn2SBv/9x9XkksBAd9Fq+6GFYrmq0vippXutym4L5+/Fy4C/av4DFhy34CcfSAoXD
 lBS2tCZ5gUMfLfYs1PCUoEo28HmueIQk3ioXYhC2vxXU3vSLz9Fa7pWTG2AEKm2iZm/azen5mlg
 Y5Lsks7k1vgOSywlf0ydCMBps/L3jvK1k3FOtVl8BSsZ/Y85L664FzZBk=
X-Received: by 2002:a17:902:ecc7:b0:2ae:5163:c2aa with SMTP id
 d9443c01a7336-2b0826feed5mr10568955ad.20.1773968895647; 
 Thu, 19 Mar 2026 18:08:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516b96sm5132935ad.7.2026.03.19.18.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:08:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP), 
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/etnaviv: use kzalloc_flex
Date: Thu, 19 Mar 2026 18:07:57 -0700
Message-ID: <20260320010757.32158-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A local helper was developed previously for struct_size.

kzalloc_flex can be used now.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        | 12 ------------
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |  3 +--
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 20dad16fd554..55a9e745604d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -93,18 +93,6 @@ void etnaviv_gem_describe_objects(struct etnaviv_drm_private *priv,
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 #define VERB(fmt, ...) if (0) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 
-/*
- * Return the storage size of a structure with a variable length array.
- * The array is nelem elements of elem_size, where the base structure
- * is defined by base.  If the size overflows size_t, return zero.
- */
-static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
-{
-	if (elem_size && nelem > (SIZE_MAX - base) / elem_size)
-		return 0;
-	return base + nelem * elem_size;
-}
-
 /*
  * Etnaviv timeouts are specified wrt CLOCK_MONOTONIC, not jiffies.
  * We need to calculate the timeout in terms of number of jiffies
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index fbf693addd74..1a77a09b3377 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -32,9 +32,8 @@ static struct etnaviv_gem_submit *submit_create(struct drm_device *dev,
 		struct etnaviv_gpu *gpu, size_t nr_bos, size_t nr_pmrs)
 {
 	struct etnaviv_gem_submit *submit;
-	size_t sz = size_vstruct(nr_bos, sizeof(submit->bos[0]), sizeof(*submit));
 
-	submit = kzalloc(sz, GFP_KERNEL);
+	submit = kzalloc_flex(*submit, bos, nr_bos);
 	if (!submit)
 		return NULL;
 
-- 
2.53.0

