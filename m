Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95420C44502
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C97A10E87E;
	Mon,  6 Jul 2026 10:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="un6e2Xv4";
	dkim-atps=neutral
X-Greylist: delayed 57908 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 10:16:38 UTC
Received: from 10.mo533.mail-out.ovh.net (10.mo533.mail-out.ovh.net
 [46.105.72.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F1910E348
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:16:38 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0SJ5Ky8z64KM;
 Mon,  6 Jul 2026 10:08:48 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:48 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.96.8])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0SJ1x31z7tDj;
 Mon,  6 Jul 2026 10:08:48 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 280418E1903; 
 Mon,  6 Jul 2026 10:08:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00570e4088a-46ed-48af-94f6-ec5b2f6013be,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Date: Mon, 06 Jul 2026 12:07:46 +0200
Subject: [PATCH v2 04/10] drm/ttm: grab BO reference before locking it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-ttm_2_drm_exec-v2-4-4bf6bfc0d320@pixelcluster.dev>
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
x-ovh-tracer-id: 9128796448561848636
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF2rMupFDtSz5VGJXaGrwYUaRUbsc9Nn7nc8ghpwc35VyZFauYARogcas+VOSD8wf0IhZl41F2o83TSTJEqn1M70AEfTiU3uOfrR34AN46Y0JjeW4xo6cV+rH2TUD4SE1NDtof+377HjW5jUw1vYYddQq9f46CIv1pXDMg+OvLcv0mAeBq8idZd3/oeDOqFYW+mp/D/hf65ucF8pcrq4BoeAZT2yueghykMKcN1pOaBvVNRQXaTXALuE+8w2Owws5LoK70lx9jAX+i5vFCotZFddZWqe5L2MI0ywEcZRGnxLB/PRWCfMsAV61ff3CxEAEQBj4aCGHb8mrffVRaINrHze7ZOeRvAY5Xkp0vrVNGkK8+RJnyzVoe/LOecOZELTwlB63OAA+WiB2M00rs3kyaG8GOESvA92OgSN0L8sVN6xZIPI0IQgVz6u4W1aaRbK/iyfkwJtG33fwLm0iFxYzJ0qaeQyQgTPJeTJtr3C6tDpPzEhzqZ9s9Jmil5DjGXu375kInZ+rL8OGHB2BpZHCcDHT11HW4E+h/XgbISwzi+8IJUPK3XdDQYvcj5CUHrMWxUnTlG/vSmCK61rnfbq9nqiCEZN+ZisO6TZ1NQXJRNkKmi4LazbfDhi2Gh8UkpGoc2JQhGzIdLNkF3pgk3zk6QCydoYfaV6JJ6vp25wL+Ncg
DKIM-Signature: a=rsa-sha256; bh=Ust/Lq5DbKVlp/aaj05H8qrX9vfxF8zPwOwSKnBCPBU=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332529; v=1;
 b=un6e2Xv4cTU7fmByjvHV6GE/6N/JiXRrk3IFarOyX8OjDj/6AgGBQLQyCI3a/hOKb1j0JHcN
 1x3BhatK3UUjm54m1ueOs/BTHJVKAtwjjAkKCzDcYyod/N+gAed6Y7n3cvutD/xAX9g/GaiScZI
 PSd9WHtSP4rTOn0FCSvYmDhT7Lx6mcdQiZRP0pBfye2ckx3WvfY/0ll3kplNNkBAv0/LRebQsP4
 XJtm3FRrFfIkgTPoaANlCGNemOObhH8r0MDuGJTjCEXiEXQbI/dLjWGrEpAmnmzxNBsz07aivNi
 Qgk/zvwUvxnbyZsckwWDy3csWPSP7/hYmbyNm/zytOp/A==
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

Previously we always grabbed the BO reference after taking the lock, but
that isn't necessary any more.

So avoid doing that and cleanup the handling here.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 29f068944a972..a53b25e8c2967 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1010,14 +1010,17 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
 			break;
 
 		bo = res->bo;
-		if (ttm_lru_walk_trylock(curs, bo))
-			bo_locked = true;
-		else if (!arg->ticket || arg->ctx->no_wait_gpu || arg->trylock_only)
+		if (!ttm_bo_get_unless_zero(bo))
 			continue;
 
-		if (!ttm_bo_get_unless_zero(bo)) {
-			if (curs->needs_unlock)
-				dma_resv_unlock(bo->base.resv);
+		if (ttm_lru_walk_trylock(curs, bo)) {
+			bo_locked = true;
+
+		} else if (!arg->ticket || arg->ctx->no_wait_gpu ||
+			   arg->trylock_only) {
+			spin_unlock(lru_lock);
+			ttm_bo_put(bo);
+			spin_lock(lru_lock);
 			continue;
 		}
 

-- 
2.55.0

