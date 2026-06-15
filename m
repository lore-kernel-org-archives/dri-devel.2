Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F059CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A5410ECE3;
	Tue, 16 Jun 2026 18:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmDA7JVn";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2E510E563
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 23:50:02 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-915e1354934so420299385a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781567401; x=1782172201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aD59fWP6U+2oV2sPLiRI6B5viEMhkSgKAPCznTndvPM=;
 b=BmDA7JVn0uV1v4ZsXQGicc8fAl+y27tnVP2ISjJrBua2K02y8mEyZF2F7f3N561Ri4
 22q3my2h+4j/BcmTz9cs7ezMLvjhWRmBghTysVhd5plw+bgq7quE/9QruyTE6thmVLtj
 bF0VPQcPbOVz39+ZaFBLNlQhchvERUgyW0wEkJ22blxBU4UnZ8A8uFmvZbVEFuWNvui2
 s0ctUxqbTdO7a0nCwvlMX7RhIj8pjwNVYQRHy2QSxKgUqh6UF1HD3CGB78UuhrD5NXoI
 QidkDryNOwpDeLAjpWZkSJYZ1Nymnq7Gf45tL+IXrSHVTMGgqwFD5dFBWcIspmPrxCeV
 QBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781567401; x=1782172201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aD59fWP6U+2oV2sPLiRI6B5viEMhkSgKAPCznTndvPM=;
 b=NN6QSIWmBEs0iNRA89Z7GGym7Sa98ZRQQ0P34LeTF3jMrtHhJLi8tzMd5QntcJ/klI
 83ogDgkI6+CBZxoBHHTK75DeOhVX+vs5zudcVEUjwJnrwHxzwfA/QSNW0FgHEQi3jnYM
 iXHPhHtuJciZY1cqfmSJs31Kw8vbp0Dav0BvEH27zU+B70XzwBRP9A7+rdf7ksNn31Y2
 yMcRNGcTMXaRI5bfv3SA8hg+ube6iSUuCzT2e17rwsBCrrTrkajD9NFBxPry2ux2Tn2t
 4U5Nd2u9Tr5zDcQjowjQKoJn+yQEShB6Rf9N4hbASK+kk1iLpODL5SRRmzZeHaVvAm1U
 OfBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7rEIHxt5rEMDzmvM7LLJOJ9bun4I8db55DcUX644c8qDrQTyZUkfnct7bfR/jIZ5cO4Buw/xkjJA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx56azDI3g3zGjM0CyhH/7HU2WQQ8GYYyTR6ssDBPM8y8U7Ecux
 J8zt4/cgWld2lZL7ULY/q4qxzaVVebotR87CzT5ZWE+aWM7Mdrqc7o/+
X-Gm-Gg: Acq92OGR7F5+rbzFGnlBO89UJlZXP5z1Lcwi/fb071ZYSV9D8hQNzw+2DOkl6AAUu/K
 WZ9HjVoX5HXYC1OZLNsifekIH4VMBqdDsF9xcyD2VxBs/+zRAdkhcyMGiiAwfKJWe72sjfumuIL
 mY8FuviBH8yHg9RTP8h8RX7zPDOPjD9UCW7DmZVvRIESZAMcbKMkZ2rUTygTse4OsDJ5SkYGO+e
 T4vto+Q2G0txG1vJ7J2kgzX3Z/R+JFBR4LS1uaIYfQBam9zH4+bmvLYBbDB7df/+MBj0G+d88vG
 TFTNVYSXg5yDbB4nTFwgykGoZJGRvXIxw/vpIHP8R896Uary9pjCxHePnJ289diB8rVy1CCqxDh
 6Rwv98eCBMVimT3u97hjz8Yf6FhilKz1KFYZAEcFObv0XwU3vU1Hfj3BUOcuC5Qv9aH0Mw8LILB
 RwDW+ROSC3LNUPPX+tn1uZkpqu3GxIK0zPHufZ3ZT8AwTjDmzFoi/+PxAVnJQtKRLZvWocSxSBF
 Dy4LRfw6C21
X-Received: by 2002:a05:620a:4720:b0:915:8f76:7ffa with SMTP id
 af79cd13be357-917f1474c76mr2073103685a.45.1781567400807; 
 Mon, 15 Jun 2026 16:50:00 -0700 (PDT)
Received: from tropical-turnip.tail32462.ts.net ([216.132.43.94])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a00af50sm1387942285a.30.2026.06.15.16.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 16:50:00 -0700 (PDT)
From: Samuel Ainsworth <skainsworth@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Samuel Ainsworth <skainsworth@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v1 1/2] drm/ttm: don't leave bulk_move cursor dangling for
 unevictable resources
Date: Mon, 15 Jun 2026 19:49:21 -0400
Message-ID: <20260615234922.151263-2-skainsworth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615234922.151263-1-skainsworth@gmail.com>
References: <20260615234922.151263-1-skainsworth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:18:52 +0000
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

ttm_resource_add_bulk_move() and ttm_resource_del_bulk_move() both act
only when the resource is evictable (!ttm_resource_unevictable()). A
resource is added to its bo's bulk_move cursor (pos->first / pos->last)
while evictable, but it can become unevictable -- pinned or swapped --
after it has been added.

ttm_resource_del_bulk_move() is reached both when the resource is freed
(ttm_resource_free()) and when the bo's bulk_move is cleared on teardown
(ttm_bo_set_bulk_move()). If the resource has become unevictable by then,
the del is skipped, so pos->first / pos->last are left pointing at it.
Once the resource is freed the cursor dangles, and the next
ttm_resource_add_bulk_move() / ttm_resource_move_to_lru_tail() on that
bulk_move dereferences it: a use-after-free read of
pos->first->bo->base.resv (the WARN_ON in ttm_lru_bulk_move_add())
followed by a list_move() through freed memory that corrupts the LRU
list. With CONFIG_DEBUG_LIST this manifests as a fatal "list_del
corruption" BUG.

On a Framework 13 (AMD Ryzen 7040, gfx1103) this is hit via hibernation:
a buffer object swapped out during hibernate (its resource becomes
unevictable) is later closed after resume (amdgpu_gem_object_close ->
amdgpu_vm_bo_del -> ttm_bo_set_bulk_move()), which skips removing its
resource from the VM's bulk_move cursor; a later GEM allocation on that
cursor then faults. KASAN reports a slab-use-after-free in
ttm_resource_add_bulk_move().

Track whether a resource is actually on the bulk_move cursor with a new
ttm_resource::bulk_move flag, set when it is added, and remove based on
that flag rather than on the resource's current evictability. The del
then always undoes what the add did, regardless of any pin/swap
transition in between.

Fixes: fc5d96670eb2 ("drm/ttm: Move swapped objects off the manager's LRU list")
Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
Signed-off-by: Samuel Ainsworth <skainsworth@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 18 +++++++++++++++---
 include/drm/ttm/ttm_resource.h     |  9 +++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 192fca24f37e..1a031ef151a7 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -280,16 +280,27 @@ static bool ttm_resource_unevictable(struct ttm_resource *res, struct ttm_buffer
 void ttm_resource_add_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo)
 {
-	if (bo->bulk_move && !ttm_resource_unevictable(res, bo))
+	if (bo->bulk_move && !ttm_resource_unevictable(res, bo)) {
 		ttm_lru_bulk_move_add(bo->bulk_move, res);
+		res->bulk_move = true;
+	}
 }
 
 /* Remove the resource from a bulk move if the BO is configured for it */
 void ttm_resource_del_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo)
 {
-	if (bo->bulk_move && !ttm_resource_unevictable(res, bo))
+	/*
+	 * Remove based on whether the resource was actually added, not on its
+	 * current evictability: a resource can become unevictable (pinned or
+	 * swapped) after being added, and must still be taken off the bulk_move
+	 * cursor before it is freed -- otherwise pos->first/last are left
+	 * dangling at freed memory.
+	 */
+	if (res->bulk_move) {
 		ttm_lru_bulk_move_del(bo->bulk_move, res);
+		res->bulk_move = false;
+	}
 }
 
 /* Move a resource to the LRU or bulk tail */
@@ -303,7 +314,7 @@ void ttm_resource_move_to_lru_tail(struct ttm_resource *res)
 	if (ttm_resource_unevictable(res, bo)) {
 		list_move_tail(&res->lru.link, &bdev->unevictable);
 
-	} else if (bo->bulk_move) {
+	} else if (res->bulk_move) {
 		struct ttm_lru_bulk_move_pos *pos =
 			ttm_lru_bulk_move_pos(bo->bulk_move, res);
 
@@ -339,6 +350,7 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
 	res->bus.is_iomem = false;
 	res->bus.caching = ttm_cached;
 	res->bo = bo;
+	res->bulk_move = false;
 
 	man = ttm_manager_type(bo->bdev, place->mem_type);
 	spin_lock(&bo->bdev->lru_lock);
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 33e80f30b8b8..1fedf75bab96 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -274,6 +274,15 @@ struct ttm_resource {
 	 * @lru: Least recently used list, see &ttm_resource_manager.lru
 	 */
 	struct ttm_lru_item lru;
+
+	/**
+	 * @bulk_move: Whether this resource is currently tracked by its bo's
+	 * &ttm_buffer_object.bulk_move cursor. Recorded when the resource is
+	 * added so the matching del removes it even if the resource has since
+	 * become unevictable (pinned or swapped) -- otherwise the cursor would
+	 * be left pointing at this resource after it is freed.
+	 */
+	bool bulk_move;
 };
 
 /**
-- 
2.54.0

