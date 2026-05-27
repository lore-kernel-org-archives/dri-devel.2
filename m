Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2A7CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2B710E948;
	Wed, 27 May 2026 20:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="H7651F4Y";
	dkim-atps=neutral
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com
 [209.85.161.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4284110E948
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:20:31 +0000 (UTC)
Received: by mail-oo1-f97.google.com with SMTP id
 006d021491bc7-69d42abd04dso3515115eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779913230; x=1780518030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/o50EFC0sji7vfRJ4UfvwqKRH6fM2XPOFR685hxklgk=;
 b=FzXp+kBwz+m8oxs5msoDRRSHUblUWQtkZngB65m+zeSUp3h1C/Efr+ds49lGfm4jTs
 WAtsRUnI4XoV5AHRgtnJaaWbyXzEdn8SD6DhO2RyMNm5H0aAKHyxS+ADTmxpCfAUDvdE
 08KFOHI8FT9lHGL7kEx1AJtS7S9DbQN0MHwhuWb6Okzk5LtoD/edZ0FEnHsl5DWiZS+K
 00jUkcvIcpJNZW48SopEx4ia7gXMUinFzNLeJh4+c8deCTLFhbOQpoTTnU7WGv/EXUmN
 PZIe6XYfRI2lW/uq4FDkBRFJz8Wap2OL9UhpgbmAvk1liWzxkBGb6NodG5G1FOQQzQDC
 RHyQ==
X-Gm-Message-State: AOJu0YwzOEIjns0LIipu9/llReznZEY6XAnEE/hjnOJ52fVBC8F0psdV
 5anVlxXX1OzPnDt06B3cWLwryg09umytWQeo/OeOA6iT4xqjga+QXGTFDAaXaNXVMs9vaeZvfoc
 44iL0xPAxRCTP+Z76d5XJlY6IHtuZ+05wUcRs9sUE0aqMiYw7EGDxA0ExqBXKV2dkYE0Bld9HAv
 uoGjfrCkt3iFHhDcH345BSm8e5sBmVR/otkCiOhkEHYtOooeh3nNCT4I2OJ0oWO3XXhNEbORx19
 pDyECyrPUlNDmy/PtOI
X-Gm-Gg: Acq92OET9pwtsCfhkO1wxhOOeqPjVjIv9FBdbfJwGQLPFhbVGnjVW7JQl4kA9IqQqvy
 QzbITTfKzCWYHJKFGA3kzkE03MgKcJHmazAPBQkpOXRPrbwl+4tnbNteP1NL53p9rfA6Q/Y46di
 8ZwUqCaiEdSoTuBFmLR+4OVSo3r664Y2c0Ddp34U9UycDa/m6Ty9j3o67grSeKuVvZBNUG5MOyc
 I+CQ9JWrLvSKOW9dFNH4DwhLWJyQiRLG/uZW+ab6cuVR5VV1BtzJZs5L0hdOmzgri25ZlL1MuDe
 qUgIz4rQyGUvHQALBAPLma7O8YRb3oQpTfFk3695Z1k5rjiuolSkQl+RGywIqHYFDpNOYiDiCu4
 rd9qeOIma4HuUb5kJCnD25/GF8uidjCJLPWWAs49q9OGAkBKEJMm7NN4tCBERlCPl3a/Zvq499x
 vXxiwGxYmFjSX2t5zl5A38ldnAncj1Lx2hQMuv5HiysRMAyfayg0dZvcf52ktyvf8L7Pw=
X-Received: by 2002:a05:6820:1888:b0:69d:95d6:2629 with SMTP id
 006d021491bc7-69d95d62775mr9836952eaf.26.1779913230041; 
 Wed, 27 May 2026 13:20:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-69d83ad6518sm725870eaf.19.2026.05.27.13.20.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 May 2026 13:20:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so12080037eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779913227; x=1780518027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/o50EFC0sji7vfRJ4UfvwqKRH6fM2XPOFR685hxklgk=;
 b=H7651F4YRLMIZBIZIIrlmWAEPVRhNiDvERl9MfxhFASs3YG2aWUg4GUzQ+Xks0hJls
 tvABkXjrukIJGt5rahRa/HtVxBEYzKLUIUwvu0fjV6HLHBsnlJKDZzK1XhARHKzz9nxZ
 taJ+K/xkVqEDzG8fl3m3McIwMo+HJftjIS0OE=
X-Received: by 2002:a05:693c:69dc:b0:304:8114:8d8f with SMTP id
 5a478bee46e88-30481149117mr4231478eec.31.1779913227446; 
 Wed, 27 May 2026 13:20:27 -0700 (PDT)
X-Received: by 2002:a05:693c:69dc:b0:304:8114:8d8f with SMTP id
 5a478bee46e88-30481149117mr4231451eec.31.1779913226758; 
 Wed, 27 May 2026 13:20:26 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304522547fesm14052914eec.21.2026.05.27.13.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 13:20:26 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@redhat.com,
 Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] ttm/pool: Don't leak LRU list on shutdown
Date: Wed, 27 May 2026 15:20:18 -0500
Message-ID: <20260527202018.1223912-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

TTM pool was changed from a regular list to an lru list in the
referenced fixes commit. list_lru_init allocates state and it needs to
be freed unlike a simple list.

Found using the igt@core_hotunplug and kmemleak.

Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 26a3689e5fd9..a41addbf3ddf 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -395,6 +395,7 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt)
 
 	list_lru_walk(&pt->pages, pool_move_to_dispose_list, &dispose, LONG_MAX);
 	ttm_pool_dispose_list(pt, &dispose);
+	list_lru_destroy(&pt->pages);
 }
 
 /* Return the pool_type to use for the given caching and order */
-- 
2.54.0

