Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B9CC88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147E110E9C5;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DR2HGogz";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C5810E664
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:18:02 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso20673975e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789201081; x=1789805881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RocYUdBBcIeZ/ASBsFYpzq2iQKAbEehKSNM8n1TlCEA=;
 b=DR2HGogzS+1zel3deHKG8agDNgFhAEvz/WDsJeGoGG235ZoOmHe3QP0czm36+qf5Ry
 uY5BwEAOJ20/3CsEGR5LnKI6r04MnrtY6AGd+LqAUwPK9MK3vDtKg/ukLJrT42Q82D4W
 ueRZzecuIhJKCdZpOkdiiQaHnKci43QgNVXsGfTcZ2Qc7QqLQPAJ2N9/TRJ/eIFCYU0p
 Cgt8a9FKenOw4Ya3Oy7g4C3z9vpBNXMCLfLNw30b6iWahYlmP1bMtSidoEHxCNyYsKGe
 zKDIUr0AhJpzLQ45N2/9gIAAYjk0c3C8KGZLlqFjoCdSNFRBTZu9gtH2yTHjO/i18cCo
 L9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789201081; x=1789805881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RocYUdBBcIeZ/ASBsFYpzq2iQKAbEehKSNM8n1TlCEA=;
 b=Y2pTj6giievvm70CO7BFcTTyna4BbSXQLDk+pB6NvXxYvNjGdqmKKKb1USKkd3l/bU
 5AYvUhjEyYJ3VuJU0J6rhoybJSQrykmvEUvf/7WBzAJNz11+1EJw/hlgWvm95ctrB3Yy
 lRDq8yZmopMHOXn4hIn23ytsj8oLTsD8meFFIf+TtSd1DMzYufEO+BTeC4yrAcdmLoP3
 94mlS3u526sfV1Hcuq78mqyefSlWb4HpKY3nHVxv1UVnDj1UunR9ZVjyFc90bP1hVcus
 XWrwrQpJR63Qp+8a6D9293qzG/Kyuocn4aB9AJJFSskhZW1giyHbVZGnjMh7T29RwjFZ
 2UGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnHWN+25fOO+EsN/DWLDPqXiDNZdipCx4/XqVNd5p8usISzccto8ou6riyTE+ONyCkaUGIWP0qkiY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lm6nUytt+K24rv0MR25KyNNtmJj2HI/MoqTktx0TfFkf4k9Q+C
 wJs/W3y2sYF0gheKkU/wn8spT06Ph14EUvuHRn2BS0UaYOMS4P6w9HZE
X-Gm-Gg: AYBFou1yCA5sf8fVrPoIHLhnsOXHZHSrJLKcC3bWxVQ3HvHEtRtYq8sFM6e7hfolRSm
 RZzv45Fgc7EOCmeWzBlzhQuFUVkGdPuTm+f1aZI9NQdnJ39zacC63ide2AcEXHNX2QlAGZ4qWgC
 SyLJxgXiX+DXwQsiDblkNXd4f74dR3fc6m+gyxbzeEjeIaTyL3oSpQZUc6wNW8vxlSKdqKyuo37
 vyE39yyMl2aHT0sxD76Th5OSOWMU2h5bbrOJDoc0t2FwH/sMbx7nhS4ZO6eua2oFhEwShoH2EfH
 7XpaBUHbpXQl8v9ua3hhK4nKUYpIfAkGn8n6p+DrJMs1+9za/rBwAShLoCepmzydJQS++MxrhTM
 iSFXmNbLTdncl6hepiWNh0RbWFnJtREptaoExotlQnu0zVsZcWtweyIVjhgufduTjeqJhWTwRxe
 cDBHiEtV1CPYa08QZj272F4UUGj5WRDTb2tqtVBmmYcc/CFnkYweO1tmV3zJqHQvlIBERxzqWhO
 XvlUK/2xbX4dHNkfm/87ckzojtIbpI1+Xk3OwiAJ0uYRemvEcDBVTMf/+mh8SPmu6LmnOZrxici
 o3/52WS1sz/HOMrLxOVM5gLwjEGPa9InJZ8D4LXQEt6vqOLo18AS73Bwj4cb07b8/uaDnsFZxxq
 LYp/1C5jyI1NS
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr62627265e9.12.1789201080628; 
 Sat, 12 Sep 2026 01:18:00 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de.
 [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6420de77sm57620925e9.3.2026.09.12.01.17.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 12 Sep 2026 01:18:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/pagemap_util: Fix drm_pagemap_shrinker_create_devm()
 kernel-doc
Date: Sat, 12 Sep 2026 10:17:55 +0200
Message-Id: <20260912081755.60885-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

drm_pagemap_shrinker_create_devm() returns the new struct
drm_pagemap_shrinker, or an ERR_PTR() on failure, but its kernel-doc
says "%0 on success", which was never true. Describe the pointer.

Fixes: 77f14f2f2d73 ("drm/pagemap: Add a drm_pagemap cache and shrinker")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/drm_pagemap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_pagemap_util.c b/drivers/gpu/drm/drm_pagemap_util.c
index 6111d90a38e24586fbcb06f8182e9025339b26b0..c9077a84e3467a5c547d437baae9159bfcd9bea1 100644
--- a/drivers/gpu/drm/drm_pagemap_util.c
+++ b/drivers/gpu/drm/drm_pagemap_util.c
@@ -412,7 +412,7 @@ static void drm_pagemap_shrinker_fini(void *arg)
  * The shrinker is drm_device managed and unregisters itself when
  * the drm device is removed.
  *
- * Return: %0 on success, negative error code on failure.
+ * Return: the new shrinker on success, an ERR_PTR() on failure.
  */
 struct drm_pagemap_shrinker *drm_pagemap_shrinker_create_devm(struct drm_device *drm)
 {
-- 
2.39.5 (Apple Git-154)

