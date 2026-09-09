Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63FCC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A1310F404;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FJvJafI6";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5DE10EA53
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:51:07 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a91e06e2f9so1417405a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788987066; x=1789591866; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eJxZDDzOzotiu9MIMPs18NtUcg846lKcSJ1Zq48T8/E=;
 b=FJvJafI6Rz9QNlAlfv9/rVjkoePFx2KEfxbiP3Pfqz3kcfgRe56lTOaR5oEv7/+Flu
 bOaJwvzBFKvR/itBJuFgIYYpTRQSWVTCRPMMkt28I4OqLmy7S9HcIwqIaIjpQUN6uWO4
 Ret6vvARyFcDDLgbGYFep3riZUE0PjTKOelHfBEVXt08DappzzKdwRULCOL2b60cJkQc
 My6lcoFA3RHt9deK/cPUQTGq2GSdG1FcHZF6EEB4cE/LTKKbk8A2eOdWfnIJq2VAUqZT
 BUX/npNjx+T7c5kAZxL0ipm1h1GxciiVL8IdpF1kjv5Y03nQCKL3PMnf2jHIQpNQ94cV
 lbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987066; x=1789591866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eJxZDDzOzotiu9MIMPs18NtUcg846lKcSJ1Zq48T8/E=;
 b=spQJAHiNBt44L2ldh15gVHx7klufQZs+6SV3xaQXyu1wfW4T9djR1rbmF8wC+uH26R
 r6QBaELGXY7aJ2dlqOxM/1Ks5895BrpOxPwaNZdjB5kKbTL0AlBRyxKg4BNkEqEKIzHo
 r7Y9sCnmsobCW0MTLq59ETco8ZPfN/Os6I4U81NZoDhp7PR+1AlQMsRw7MIXI7tjZg0w
 PfWOaNJbROsv5bPs21OfZpnNovKuit05LdBKHlgQJDv5vCGiITd1xUnigsdF1DXTOQjL
 k4stoGaOqw47JTLlriok1u/9z4Yqwrc6mKV+g9UQL9Zf5jmFB8Rrae39BVCq9OJcmM1h
 xTXg==
X-Gm-Message-State: AFuF++k74XkhXHYDHkOaHgz73Hi3Uvul0L5viUDG15I1sEq9J+3HQziB
 +kQyuRSgV7bNi7iXebgfk+s1gCydD6AX5Z0z1smTGlyg2o8F1cIPwiQMIhi+mM8FtUszLHilv8o
 =
X-Gm-Gg: AYBFou2s+3B0JZTst/b+7eP603Pd6fgI7rbAgpgGaZrC9GNlz5PUCG95bvuPLE1DCVD
 hagX55q25ckjh5n0UkcFY1se4utxwHW6msZBg24s5/BYjhJ0R2IYhVW+5FxlaGxQLQ6Iw51Q3+q
 G4utR4zc6j+FCKwQIj4cjDZejoUIJzIksQGdEMg2A+IqOvsQL+Sh3h0zkfnQrs63yBHLrCl9khl
 d5gzpePzL2WzkoTaeOlO675hRT+ai/gpsgRTPFACJdOHwpPwiNuusqI/2hVPENHjtPPQNDQPs+Y
 slVAZp8w43+xqbUmWBCH2NAg4bHovr5VNP7gynOkzgGtSBDZAwRH4+aONLnia3WGrdjfmNhPQw6
 y6+MkhaFHMMRphEjIE7KXtlPC8xVq/Tslhrg/4V7bbLSWQx731Hbqc/g1wMKoyXkEFkXfMIr6an
 xU/rRUUEF+9ep8/JM1b9clb8Pinvcx2iL/M04KVTL2aPFvaFHK8/4gVU/Vrr0zWUKhK0TWbKA48
 kXJSQ==
X-Received: by 2002:a17:907:3f0d:b0:c25:f7db:4bec with SMTP id
 a640c23a62f3a-c2945eecb04mr57074466b.18.1788987065689; 
 Wed, 09 Sep 2026 13:51:05 -0700 (PDT)
Received: from bbzr-mini (cool-t.fvds.ru. [103.137.251.133])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d03644bsm825646266b.6.2026.09.09.13.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:51:05 -0700 (PDT)
From: Vadim Nikitushkin <bub4z0r@gmail.com>
To: christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, skainsworth@gmail.com, alexander.deucher@amd.com,
 bernardomagri21@gmail.com, Vadim Nikitushkin <bub4z0r@gmail.com>
Subject: [PATCH] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
Date: Wed,  9 Sep 2026 23:50:28 +0300
Message-ID: <20260909205028.13799-1-bub4z0r@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

ttm_tt_swapout() returns the number of pages swapped out on success and
a negative error code on failure; for a populated ttm it never returns
zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU
walk on swapout failure") moved the bulk_move bookkeeping in
ttm_bo_swapout_cb() under "if (!ret)", so the
ttm_resource_del_bulk_move_unevictable() / ttm_resource_move_to_lru_tail()
pair is now skipped on every successful swapout. The equivalent change
for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink()
infinite LRU walk on backup failure") tests "lret > 0", which is what
was intended here as well.

Before b2ed01e7ad3d the resource was taken off the bulk_move before the
swapout; since then a swapped-out resource stays inside its BO's
bulk_move range (and on the manager LRU) although it is unevictable.
When it is later freed or the BO leaves the bulk_move
(ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
ttm_resource_del_bulk_move() skips it because of its
!ttm_resource_unevictable() guard, so a range endpoint in pos->first /
pos->last is left pointing at freed memory. The next
ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that cursor
is a use-after-free, seen as the resv WARN in ttm_lru_bulk_move_add(),
"list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
dereference in ttm_resource_manager_next() -- minutes to hours after a
hibernation, or at process exit / reboot following one. Samuel
Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
dangling cursor; the missing removal at swapout time is the reason it
dangles.

Testing the condition for success restores the removal. On an AMD
Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate on
a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
crashed 5 of 18 hibernation cycles; a function profile of one
hibernation showed 336 ttm_tt_swapout() calls and zero
ttm_resource_del_bulk_move_unevictable() calls. With this change the
removal happens for every swapped-out resource and 12 further cycles
were clean.

Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure")
Cc: stable@vger.kernel.org # v7.1+
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
Link: https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index ef56c18..9b85b5f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 	if (ttm_tt_is_populated(tt)) {
 		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
-		if (!ret) {
+		if (ret > 0) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
 			ttm_resource_move_to_lru_tail(bo->resource);
-- 
2.53.0

