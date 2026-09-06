Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A96C79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE52D10E3E4;
	Sun,  6 Sep 2026 15:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="jT2Ano2t";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CFC10E3E6
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 15:27:46 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cc328b43a56so2212548a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1788708466; x=1789313266; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wEnUCVkPu/gxA7B/RUFtXbRxYKR7yPXsnGF78M1X41k=;
 b=jT2Ano2tnCYZ9sloLuozqxPgc4dIjfUb0mww4CscEKMcRvV3YG7/k/VZCALEVg2dvK
 D74HTZ5ZwtiwUBDs6rDoGCTwtk2PgGsdfLqNEP07yuD7AVv5D/K5Qt+u2J3LxDDoJwb2
 P17FglCVJr0A5Lxkqae/QXLQmQbNYRWCTody4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708466; x=1789313266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wEnUCVkPu/gxA7B/RUFtXbRxYKR7yPXsnGF78M1X41k=;
 b=BFSWE0jYR5X444grfhhEZM/mEs6UR/9fArVCk+fcCCYapVrcf9zT5C5yaw9Av8wNf+
 rT6TldxL1QyznDKWHZsLeM0YzmON61MeB0L4++PO5/rs+BfqmnNOsVNRaBODiUgnipBc
 oENanTwZjKKgOQ56pDQdvHpRZlliCfNnHOJy7WxzkbMwC40zw9+SbXhRlEwxA6ClDeiH
 WK3fqSjoWmvC/plv8g4BlgyJiNhCumljlaOaVQgsIRzgLLMIQTNSwi4lzMu3wNeNUVfm
 4/kF6+SeL/gNwcQmFgy7tJR/PteZTi8i5WBZVK5BZ2MV2E1OISV/uiJikqX8Bb/+PHcd
 Mf8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkGWgxo5NVs4i37ejOg29RDRAcPz05DAh1KF5dtHykFaCZo1Mo6QcH7p/+FAzDlUo2fj1fT9K7Bd4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lNdxCnAGVWCKgGwfZ9BNHnuv+ki45g3qEt6QpbVEtYqdgyR0NI
 GB9KPIdhOrMvMshIh/6reSkg3MFwbLV6lNUr+MCAObVkk26iieAjQtY4RGkqrnM0AQA=
X-Gm-Gg: AYBFou0fymfCl4e3HMdO0p7jbPCP+2gvM6rgWTsBjPEu2fnR4M/Q1bu7CfgnLXWKpnX
 yjc9b0e7Q4ZPceXwkQkCQIYtvFNzQKLgU/t39S48LfKv/nAnt1gLcTcZ5PlmAJ7O4crf+S6WcbK
 2fiNUBjMhKWmbMAxPB/5PM0NEd57jmazFSi63i6rNrjGRDpWJ3bIyOyy6bJhxM7GDwuRPRQSnww
 qRf5MbNhf1u1x9NNh5BjZwDUeq2Wbslpg44G/iSQgWR0SzrY6l4AuFEAqzxnbHOT5lD58kOesiM
 DH8/p1Adq7HaeeZy8cMdNcIU7Si59EVAawkXxNHEGICAzO2GGcHaCnzJX6vGGd2LX+51ud74cy4
 QsX7jaIxihbVHvi6SuNtlG+tXDlI7KclDCqALj5d+8hvWSdQ0WUtJYgcKR46aN5utXtNKlLTCuz
 85EevV5IiTn1EYHQaVAZMLN2rCUCuJkyyq4CNpANVnIrX3DqzMY+5Uzq5gWw==
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-39b26101c20mr27376038a91.9.1788708466096; 
 Sun, 06 Sep 2026 08:27:46 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae9087d3dsm7064589a91.3.2026.09.06.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:27:45 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>
Subject: [PATCH v2] drm/radeon: switch from get_user_pages to pin_user_pages
Date: Sun,  6 Sep 2026 15:27:25 +0000
Message-ID: <20260906152726.1685848-1-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827090100.428302-1-hsj0512@snu.ac.kr>
References: <20260827090100.428302-1-hsj0512@snu.ac.kr>
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

Switch old api get_user_pages to pin_user_pages according to [1].
It guarantees these DMA pages are pinned.

Also pass FOLL_LONGTERM: these userptr pages stay pinned for the
lifetime of the GEM userptr BO's GART binding, not just for the
duration of a single call, so this is a long-term pin.

[1] Documentation/core-api/pin_user_pages.rst

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
v2:
- Add FOLL_LONGTERM

 drivers/gpu/drm/radeon/radeon_ttm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index e7ab8162ac69..c14b215c7e3e 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -346,11 +346,12 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 
 	do {
 		unsigned num_pages = ttm->num_pages - pinned;
+		unsigned gup_flags = (write) ? FOLL_WRITE | FOLL_LONGTERM :
+					       FOLL_LONGTERM;
 		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
 		struct page **pages = ttm->pages + pinned;
 
-		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
-				   pages);
+		r = pin_user_pages(userptr, num_pages, gup_flags, pages);
 		if (r < 0)
 			goto release_pages;
 
@@ -377,7 +378,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 	kfree(ttm->sg);
 
 release_pages:
-	release_pages(ttm->pages, pinned);
+	unpin_user_pages(ttm->pages, pinned);
 	return r;
 }
 
@@ -404,7 +405,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_device *bdev, struct ttm_tt *
 			set_page_dirty(page);
 
 		mark_page_accessed(page);
-		put_page(page);
+		unpin_user_page(page);
 	}
 
 	sg_free_table(ttm->sg);
-- 
2.43.0

