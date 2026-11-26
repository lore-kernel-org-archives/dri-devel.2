Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB47606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUpYk//x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824B1112254;
	Thu, 26 Nov 2026 09:39:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C7B112249
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46D78450E7;
 Thu, 26 Nov 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685848;
 b=iHlRJnQrOEJvmj5be0vnHzYPsBD9LJl9WuHZ7YS+czH/ey4AUQMhfeeorkq33A4k7EdL
 yHauyDjvcwPeuaQr6Nyu42bk3ss+md2VZIRMuYZR93d/ArmNdnKoSxIj2r/6LT7ZSq+Bb
 FAI8m5/ie1gbZS9kMwZNtmnemF9TAVLwvfueHsstD9cHSWOeIf7KAivPocNFo2XWNEEBZ
 Wfm4rzXWIqxtzdu/xaQM27i4i7miUMZ7cBhp4ldvT3n6/ZOiKI3Yu5pUeU5t/bXYX8tNb
 aLTQ88ESA0gGTi0jo1bzWNsRt5V0GA4yM14WIS5TZYvieNfaS/iI+TNyMncqIsZnMTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685848;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Px40m0YjZ0/FcREAQzSI37lydK8nL5M7PoD7PHIoihE=;
 b=wCpjv2RT4iTNuG4p9DpLkTr30PVNsbuD0hIgogAUT3pUqiWBQNISeMuZB0NAyWU2W0MR
 fo06Aooikx52AzQufmE2buhoGbmsB23Ri2Aqk/thGBlm5Fd1NF5njVA+vj0zH2crA17yi
 IZknbFE0TLuBiOeHrNBCgfogK86FFT517PooxeZTC7gKyvtFxJDwhz1LdZ0pHDZM34sHd
 9+iBM6FmgoP/bbDJ4qsJlH8IvpIznhhKrJGCnQ8fLgJ+r/6FPEVJrhaqc5hH/GQ9AKSSo
 D3XOGTCCBLOJbkGPlSKG23qbUHBsclqPPf93hJHgy1oS1tYX1QKVRN4mSHJayvCuUSQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 2E9671F02EF4;
 Thu, 26 Nov 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685848;
 bh=Px40m0YjZ0/FcREAQzSI37lydK8nL5M7PoD7PHIoihE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=HUpYk//xVxwk0jcvK6hjBEmXWk1yNVy6jMv/8i0NmIBzEiDYRvzYkAxHmObGnexoz
 9RtIExdqx6O+bbq8bxqoF7KmqQXldX8zu2i+EKXN4tDNX8F0wH5mltddxSgvsN+UFR
 NZRIGJqJaEK2bNGKWH4/4hXdLabIasRqdUH5oz7pUFgbv0a+KPdNn7jgxNbNiytRsT
 bS4OuxkDKx7SMlr+75VRK5EXBkIHDqO3V5ENArXiJwd1Ms2Of7nrUfJgB4NMOVkxhu
 YHhQNb6G6XyU0KQLoihh4CIh8odXcClUFd5su2acqQrmW/qDmSqok6FJ/Icumi8CJv
 2Jx78+72UGXiw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id AB0E94D37C;
 Thu, 26 Nov 2026 09:36:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:47 +0000
Subject: [PATCH v4 04/17] drm/panfrost: Don't take a reference on a mapping
 that is being freed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-4-23579629ceca@gmail.com>
References: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
In-Reply-To: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=1091;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=DRy+Ft25cf0YsAswanqBu0wCkKWVe6G3uWYwsT/P0E0=;
 b=BeRxzfza9dgdvDaouiy4kBCOHRyONEbOdHBsY/digbDvQ/nNj9C3BBftdEP+lgWGQ+skkbxQX
 pCWD2vRDPm/CpBLdCj5+RWZACHCe2blh0etmG+n0ZxWad+Dw7qwbgT4
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

A mapping stays in the drm_mm after its last reference is dropped, so
a GPU fault can revive it with kref_get(). Use kref_get_unless_zero().
Not reproduced.

Fixes: bdefca2d8dc0 ("drm/panfrost: Add the panfrost_gem_mapping concept")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-206570@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
v4: shorter commit message.
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index faa62643c..789a64fd3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -576,7 +576,8 @@ addr_to_mapping(struct panfrost_device *pfdev, int as, u64 addr)
 		    offset < (node->start + node->size)) {
 			mapping = drm_mm_node_to_panfrost_mapping(node);
 
-			kref_get(&mapping->refcount);
+			if (!kref_get_unless_zero(&mapping->refcount))
+				mapping = NULL;
 			break;
 		}
 	}

-- 
2.55.0


