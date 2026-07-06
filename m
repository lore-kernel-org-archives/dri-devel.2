Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A092AC44502
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96CF10E897;
	Mon,  6 Jul 2026 10:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="HtnZymoT";
	dkim-atps=neutral
Received: from 10.mo534.mail-out.ovh.net (10.mo534.mail-out.ovh.net
 [46.105.32.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696ED10E894;
 Mon,  6 Jul 2026 10:16:46 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0SR2vl7z6JVC;
 Mon,  6 Jul 2026 10:08:55 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:55 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.168.36])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gv0SR1qmVz7tLG; Mon,  6 Jul 2026 10:08:55 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 4C6098E18F1; 
 Mon,  6 Jul 2026 10:08:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005bf0a9a5b-634e-471f-9c15-56b367536c5c,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Date: Mon, 06 Jul 2026 12:07:50 +0200
Subject: [PATCH v2 08/10] drm/xe: remove workaround for TTM internals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-ttm_2_drm_exec-v2-8-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
In-Reply-To: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 9130766770950267196
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFMobFMhrI6mwdMIl0lqtl+jezqUsZKJEyxHHMvx1PsgGmhE5En/0ZDeXryAId2Em9Mti8vRUtIpVOn34/99l1LQ5l030FgMhMXOhVLq+uBm75VRIHj8rLyfz57Jhny6pfLI/a5uMuUBxpgTHiF4Nm51UDgsM1GTjEqQdO2rrr5aKw8so40daAKRKUV/l8A6+ijQJxCtS4zhdGd3Y4dJeQFCQjwYxQZLH5omJZDNaE6whidqSgL6+1HipjQPAFyJDuayta6IuE6t8k2dyZTEl7shc/jp3BLOkEEp/W6WxCVj1xm3fYRykYHxmmG6YjlwsomrEf7+MIILpb+XKIutt3OJ7CA1TJ/vMDYXDKTaoXwPoy3ieHmghJM9xDISzSfl5j/onWhhc7KnKEjIe8aaSq+Br5IdnSj077vprrymbsZBXJ3RwWazEUgqr+vkZ1iV6XeUtoOSfubd+9wZbHy6xtGaHn9xkRv7uZgoIHjo+xDxuKWGDXYUPixYXVsUBrrW9FZ3yXfmla5QaToqulPvdgMAk35Q5gWYvLvFbdWpdZwW0MYAPO6MLgHUuGgA8lon5pB6pIEWNP0vSeZNCscgGMOko2/3FNjatlyI8vkRKfQsIiyoBf+wwrdfqp8bT/tmiauKLyUcpqfBtkhMsBcZyEaOlIoL/38tkH9r+Vb0lSTDg
DKIM-Signature: a=rsa-sha256; bh=V1VfkBOzIlL1diOCJO7aBkMIwTJ+y/SjTldGqzLicPY=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332535; v=1;
 b=HtnZymoTFsua9NRHq9CojE+JhLNQNw/fO5lZi4G6jCuQ7BUkBu8FsCQXKQfMN/Dsx+B/4S8A
 ya4QAIFY/nmv6Yl+f85BY3QfaSOkxjzGWsTHJnas9nAb7r8HD2DkAr6Gd1mJWQZru8miAIQaDVP
 +qLLb5ZclQfvfgd3JZ9ILADvCQKw/Axf1O4hKtkB60rJV31kCXxi6f2HKxuJKMKqThUMw93Ayx5
 BSc5AWhne6wBn1ISPUOxHpWUUtk3WSZju0KBgs4hW8djIy9CI9vjbScT73WLDJlAr/zHTaou1Oi
 9AuR+AlcXO7/PUbtVuJithM/VpM+6rvYNN2MkYD9n6BNQ==
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

This should no longer be necessary, TTM doesn't lock the BO without a
reference any more.

Only compile tested!

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/xe/xe_bo.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 5843f850339c7..34eae56716076 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1642,31 +1642,6 @@ static unsigned long xe_ttm_io_mem_pfn(struct ttm_buffer_object *ttm_bo,
 
 static void __xe_bo_vunmap(struct xe_bo *bo);
 
-/*
- * TODO: Move this function to TTM so we don't rely on how TTM does its
- * locking, thereby abusing TTM internals.
- */
-static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
-{
-	struct xe_device *xe = ttm_to_xe_device(ttm_bo->bdev);
-	bool locked;
-
-	xe_assert(xe, !kref_read(&ttm_bo->base.refcount));
-
-	/*
-	 * We can typically only race with TTM trylocking under the
-	 * lru_lock, which will immediately be unlocked again since
-	 * the ttm_bo refcount is zero at this point. So trylocking *should*
-	 * always succeed here, as long as we hold the lru lock.
-	 */
-	spin_lock(&ttm_bo->bdev->lru_lock);
-	locked = dma_resv_trylock(&ttm_bo->base._resv);
-	spin_unlock(&ttm_bo->bdev->lru_lock);
-	xe_assert(xe, locked);
-
-	return locked;
-}
-
 static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 {
 	struct dma_resv_iter cursor;
@@ -1680,8 +1655,11 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	bo = ttm_to_xe_bo(ttm_bo);
 	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.refcount)));
 
-	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
-		return;
+	/*
+	 * This should never fail since there are no other references to the BO
+	 * any more.
+	 */
+	WARN_ON(!dma_resv_trylock(ttm_bo->base.resv));
 
 	/*
 	 * Scrub the preempt fences if any. The unbind fence is already

-- 
2.55.0

