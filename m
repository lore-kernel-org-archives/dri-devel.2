Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B04C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15EA10EE5B;
	Wed, 12 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rKfp7qQu";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578A410E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:42:42 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so513645e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786477361; x=1787082161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=maGvDaUsV8Puzc/vzM2VfATUwgjtE+oqcHZemKrSRow=;
 b=rKfp7qQuVm2VZg4xCujsjPQlXeEBZ7IrzsAKaeKRRO+FPYBwPtUoE6jQzLSnO7NVrw
 epr1cH5mgLtxvOkJmVWo1b2HLYDR5re/PRPn2I4dfWaWum7HColQlwqu3ujU5MtEwDiM
 NUhqfjSx+D0vgDM1QrBOImzwxaHRekFqZvTW72HVufb57kY4Gjd55toWYaiPD04dKCow
 arYQm6a2EfLpgoqXhxB36a+Ie3UOL4CxZWoyCsFHtqPv4my0GL9pO/mjkcZ90Hzrhs0k
 xo22WAaDbrreI3RxOC+DCa6/gCoS9UTvp6vgWfGgGhXEbyrd9jhs2Zv2sS/IrggpLsfL
 ZjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786477361; x=1787082161;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=maGvDaUsV8Puzc/vzM2VfATUwgjtE+oqcHZemKrSRow=;
 b=VHKQoxwN5cyjxFz2WtFiJx/nU78KVodMeNTdJ7NWRFhQ2hLh8FxsWypJYGxtkAJk7Q
 f78cyGklkiHNTq1R5oUr1sLwOaRCOO5Q4t1IhAtevazxA7zElbnl/DklsSMD/W+oL8aF
 5cUR8kyD+61b0Zudtsm4tdiXMwN0Pgzak6DWKNZzjsoVzauqTBHnzsSqRoliU+y5Xk0I
 kYneC8pbTJkhmIGuSvl3H+8NzlQc4tqhHxAqnDNeYCihZqsiNPHISKj+2VhtnW8at5UZ
 YEajmOCHCgFWUdVLt4kOmUqh57m9AxCcjhV75BGezh37wbWeFNSht3j2GqYYE/x+pSmO
 bYDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrzc2uOqEI0TMtKephhAKuKU1IfaHb/x/bLZrbYZZhSzs3An+GamRV9wQ3Ties8TWG9cogb4WAUgGQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9yYIH/MZlH4O9ap1L5zxbpNrA7lK4XI9CKi4i5A2M3EcKYgLA
 dmy1w1ke4HROeTyqvH7odUdmdrPsYAOhZsy3Ku/wyu0ro64ErzMBDFp4
X-Gm-Gg: AR+sD12EG/8XQM4mf7xieLCxKH4TJH6VJ+WG34TigUB/CbE1+DpKab/oRYrNDSg7Sc9
 s74vP4DjaJlb/npge21lzqZC7wGf80WRkv3GuGxXydEdn5ZIPijI5+8RddJXpEzpdw9xO3gAxF/
 YHAu6aIARvfraHpWTl346I1//kGj3KAMPzEBHuoE+44j/viWsyFne+MoCt7m5nv1H7Nglm6gkSG
 YLfK81fI9xN/9Yo3QNvgZOiTG/GSj6LJgyr0Vx5WNhFeVA0glCiXOgcfwlCdcp+MJfgBWSFe/p3
 9/5VKfLqmbLgPsKxVzNnjHgPwOMjVmGPlwYlLRim+bE7LTsmzZdWu+/vbDBIit4HUfd8FGSKTgn
 PFIoO1Qgi28QQ3renqT83EmlO7Mg1acO3oDtKntz9P0+KKVxrZ+G3ciDu3drEk+m7m1xpsBrqdh
 jKMjKLV37MHq1G2tV74SzfAA2n7p6h9LTRLLErDtvJnynS7bLJeJVt2yhWKBOHFNlO9l0C6CAVh
 2PfELra7uYCUN81lKq83PDxlPlaO2gApEpxe0jENYYSICD7kIHD
X-Received: by 2002:a05:600c:1d0c:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-499784611c4mr86084415e9.17.1786477360587; 
 Tue, 11 Aug 2026 12:42:40 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:42:40 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: [PATCH v5 2/6] list_lru_init() does not check return value
Date: Tue, 11 Aug 2026 21:42:17 +0200
Message-ID: <20260811194224.121597-3-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194224.121597-1-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

Bug: list_lru_init() does not check return value in
ttm_pool_type_init().

Fix: Check the return value from list_lru_init() and propagate the error.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 88c0d33eed1a..8637f7942347 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -354,17 +354,23 @@ static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid)
 }
 
 /* Initialize and add a pool type to the global shrinker list */
-static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
+static int ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
 			       enum ttm_caching caching, unsigned int order)
 {
+	int ret = 0;
+
 	pt->pool = pool;
 	pt->caching = caching;
 	pt->order = order;
-	list_lru_init(&pt->pages);
+	ret = list_lru_init(&pt->pages);
+	if (ret)
+		return ret;
 
 	spin_lock(&shrinker_lock);
 	list_add_tail(&pt->shrinker_list, &shrinker_list);
 	spin_unlock(&shrinker_lock);
+
+	return 0;
 }
 
 static enum lru_status pool_move_to_dispose_list(struct list_head *item,
-- 
2.55.0

