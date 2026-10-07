Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720DCA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCEA10E4B7;
	Wed,  7 Oct 2026 18:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcgX8m8O";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D739310E4B7
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 18:12:35 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so21678275e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791396754; x=1792001554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SmdRitxTTgFdGJeHgGQ6RNQbSBJ7pC2HNIG3s7QSzuM=;
 b=GcgX8m8OAv2rLUUFH1v+Pos/l09tp/pIiZGxLqAGP4lW1IEB6pT35F0YFRR84zjrFP
 BgyjXmCfWUcjIxX3VcuKbdDt/Q7pX6v+i4nU4CEIKNjJ5bGCQl2UQsmHCzUuu1D1xkzo
 3yE1zPOKSNTq+xQ55tEPhiZMCu0wdOeho24vp+pSNaQ255wlRVIB5T6XIRodMHp/cMJS
 LtA17avXjOPQTEFNfxCBU7XtSLkiL2SBbigIpESONet16bTN+Vxp61P9CO4XKXtE5Thn
 9BJNfhES8vm2a6PBVtp5QsknLp/ZinFcMF3KGZ0MlsbxQgeH0AQc0fXcqV6uh51G0RBN
 2Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396754; x=1792001554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmdRitxTTgFdGJeHgGQ6RNQbSBJ7pC2HNIG3s7QSzuM=;
 b=hJrB4d0EAa8RIXGxX7HlDJeDdmIdlu5a4rrsIofu1x9g3D70/7kTfgH4TxMPZWOcCp
 2ZOr/D26F8EH1PbxCC/TJBl5OJDIPMLmGAtPIdAne9qvpLnidZee2M5kwMu8mhqYZTDY
 wLgyWl2yYnEvnyEnwayHhWZTuIEn+LYVvukFryaFNfMIXtTNEQ+F5EgVHsLlJ4e/Rj4W
 UgaDuKUB79uTgzLw44xnDwm2PBKKEAzAYWTw1Eh0ukXq1rsfrGRN1/9VrimVtgx+hNO9
 VGwc9qGoP2DfslP70hfYTGGaBqVU+Qes2vDlw96CbF40Z/zAeAoMmyjwiqaxD2wgOotA
 K0sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi+Kb72WkAORP1HXMAow478MAD6V3XtNpODtKqsOh28/5bz5HxNUW2NfBumH4d/rgDY317JWQzhvg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mnN0NNs/QLZfjgZQf595diNE6jdHt79JImmsx17Bl8jj6MuDnR
 8RAcESEaXQhqzQAoU6PbQzzLlkPSfkIVLxgWrrzBflInrC22PGtETBXx
X-Gm-Gg: AYBFou167JenQL9XUQURvqpJeI88iU2wd0gi3Ie4xV6wU1WWVJSZ39qmOZuKadGLTNo
 Lwi+8EIJUw2BeEVbEStW0K2FaJ4Niud6Ns8ed8ZZDX06PmzN+FLd6WDoAfAuuFTkTGWFsCoHhrw
 u0q5yjl2ftf2XPYHuXobEXfoPb7RAioTQUP37woauRnTYAe64UNmKAR+Bu2sY7NCJRiOjcfNXmA
 RIf6ZBtt+lrhWZSc8/kzJXW626c311ImsYVxqZ0WWayfM7YCRcR4XfRz9LMxoszTBZvbBUql5Ly
 zZsVb4PCoNia7+S6oSGYYINCvns8jtrkM0d8cAwqOQkowWO6KZFAzuvxDky8+4ItIyfNA8q8yQv
 j5VTAuOqOs5bXX2OwZGKegdI7QufMRuIOnD4+5r+TMZCbYJDDRDuDZDsCRcKXTb5IF+ygMv8PQa
 Ml9bP9DAHg4AAh2rnHmPCtrcTHXjXdsytE7YHhh+kZrEudc9YQELM1OXWnLjmN8BPC09O8uznOg
 XvRc8MRFiICv3ymwHh1ZsRKATNNopAEfQ==
X-Received: by 2002:a05:600c:6749:b0:4a0:251f:a726 with SMTP id
 5b1f17b1804b1-4a180455d47mr54022405e9.24.1791396754013; 
 Wed, 07 Oct 2026 11:12:34 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:b456:28a3:bd59:abb6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843e3356sm7115815e9.14.2026.10.07.11.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:12:33 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check
 and erase
Date: Wed,  7 Oct 2026 20:12:19 +0200
Message-ID: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
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

panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
xa_erase() without holding the xarray lock across both. If the handle is
destroyed by another thread in between, and a concurrent GROUP_CREATE
reuses the freed ID, the first destroy erases and releases the new,
still-initializing group, leading to a use-after-free in
panthor_group_create().

Do the mark check and erase atomically under xa_lock().

Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0493858e55d7..a343c5180e01 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
-	struct panthor_group *group;
+	struct panthor_group *group = NULL;
 
-	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
-		return -EINVAL;
+	/*
+	 * Check the mark and erase the entry atomically, so a concurrent
+	 * destroy + create can't make us erase a group that's still being
+	 * initialized and happens to reuse the same handle.
+	 */
+	xa_lock(&gpool->xa);
+	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
+		group = __xa_erase(&gpool->xa, group_handle);
+	xa_unlock(&gpool->xa);
 
-	group = xa_erase(&gpool->xa, group_handle);
 	if (!group)
 		return -EINVAL;
 
-- 
2.53.0

