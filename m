Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E3BCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 22:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C1D10E304;
	Mon,  8 Jun 2026 22:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Wkd59CPU";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF81D10E0AE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 22:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780958050; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=M/SX8ZT8VJqSd5FaprrdYfM5moMY1XTLVecA/TSJauuZ6nARkTeKVwY9qCuFY6+bm7OaLrhz97a52FBZ+TvbTQpeX3M6R3q7UqRzVEwwJoTtPEhjl6x/RZ9f4cs0OaVZDqk80Jy2tTHTLz7kCpAFbC+zjluIUtP/1APPLW1ganE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780958050;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qJnJXQftFXbvQfqK6Gbj8JkqC6UiFNK9aTKUsO+DTfU=; 
 b=iSHVus23SLQ0ehItFMkmu9teFlJJ25P3rBhPSByYxo3Ak6/9hb+wcoqcCVBb7iLXtXI7hLWhxC79k1TK+NXzU/ImJ7dQvsN8tru/H1tn1jPM+412JcUFLjq4m2uzi879ENBB9heCJuE7cO4A2C60ceKm7HCbHyQ0JharpzWb3J8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780958050; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=qJnJXQftFXbvQfqK6Gbj8JkqC6UiFNK9aTKUsO+DTfU=;
 b=Wkd59CPUqIWY+p+QwqmFqmVJRFa2JmyJ7GcER+PhL18xgxyyJWJw/SPHLetSMBUu
 naFg5HZSruQ77cujIPxic0V2lFM1NT1/wkR9dhZFhkYifXEqvTSXGWfCvIn45L01x6b
 csJ7YNf8ZPt4cpVEYOrO/KRfF+2oVeVuYzJgXSBY=
Received: by mx.zohomail.com with SMTPS id 1780958049693770.8694267700916;
 Mon, 8 Jun 2026 15:34:09 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 08 Jun 2026 23:33:52 +0100
Subject: [PATCH v2 1/2] drm/gpuvm: Remove dead code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-gpuvm-minor-fixes-v2-1-af07ef9ca969@collabora.com>
References: <20260608-gpuvm-minor-fixes-v2-0-af07ef9ca969@collabora.com>
In-Reply-To: <20260608-gpuvm-minor-fixes-v2-0-af07ef9ca969@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2710;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=XWnKemXD+9v9ZBfqaVPGYie/+sluydjkRyt9RIp1oyU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqJ0NbyQftEgtnbfNtBpZHwv28oX9CDqfWb5cPS
 TBs7/HCbe2JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaidDWwAKCRAOJn5M7lND
 PSOjC/4psUTgLGoKXrpjGeh5nNTakPHDf9c6wQKd8UZ15MRoVnFrfdElIhS4cgGB5oeYrIdMA/k
 3Lk5gEAJMnBkr18obH4aIPUL7KiLCoGLK4y9R9eifURkedw7rI2hBaWksbOyByZg1N9m5CzaKa9
 8EhrkbCNFKOmN95PGRHSx6lc9pi93CzLWlv+DPg2jHLZn07PG7UbFjmfgljtPiWKa8SMThUvDkG
 H81sjsT4QttD+BRB5IFxIx8boswf40lJ99fHD2MXFTptT7E5Fj9cA40/ZyHlOGKAKXwJhXt0uql
 R2BhXAGr6wmieTd77g+8BZgd9ffiVqiEqDaeR9tyHl35yy2uH5zuKYRWA3gNVkacqsu2rDqHZCu
 KPGoBnLyFejdZXk1e6pBEGosIudgwNKd7DIxyctB2zYiSu6NlbNrYlGL627te+BpWRmzVFCXxlr
 /T5MAxfl7PiZJO+In2Td4+1WVQDldV9JROUn87NENMCQFgKdVFEkBHvANyEMpk8S3LvbA=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

drm_gpuva_find_{prev|next}() have no consumers.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 44 --------------------------------------------
 include/drm/drm_gpuvm.h     |  2 --
 2 files changed, 46 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 078cbc0235a4..bb2847897527 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2225,50 +2225,6 @@ drm_gpuva_find(struct drm_gpuvm *gpuvm,
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_find);
 
-/**
- * drm_gpuva_find_prev() - find the &drm_gpuva before the given address
- * @gpuvm: the &drm_gpuvm to search in
- * @start: the given GPU VA's start address
- *
- * Find the adjacent &drm_gpuva before the GPU VA with given &start address.
- *
- * Note that if there is any free space between the GPU VA mappings no mapping
- * is returned.
- *
- * Returns: a pointer to the found &drm_gpuva or NULL if none was found
- */
-struct drm_gpuva *
-drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start)
-{
-	if (!drm_gpuvm_range_valid(gpuvm, start - 1, 1))
-		return NULL;
-
-	return drm_gpuva_it_iter_first(&gpuvm->rb.tree, start - 1, start);
-}
-EXPORT_SYMBOL_GPL(drm_gpuva_find_prev);
-
-/**
- * drm_gpuva_find_next() - find the &drm_gpuva after the given address
- * @gpuvm: the &drm_gpuvm to search in
- * @end: the given GPU VA's end address
- *
- * Find the adjacent &drm_gpuva after the GPU VA with given &end address.
- *
- * Note that if there is any free space between the GPU VA mappings no mapping
- * is returned.
- *
- * Returns: a pointer to the found &drm_gpuva or NULL if none was found
- */
-struct drm_gpuva *
-drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end)
-{
-	if (!drm_gpuvm_range_valid(gpuvm, end, 1))
-		return NULL;
-
-	return drm_gpuva_it_iter_first(&gpuvm->rb.tree, end, end + 1);
-}
-EXPORT_SYMBOL_GPL(drm_gpuva_find_next);
-
 /**
  * drm_gpuvm_interval_empty() - indicate whether a given interval of the VA space
  * is empty
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 655bd9104ffb..f8fc0296c4b7 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -159,8 +159,6 @@ struct drm_gpuva *drm_gpuva_find(struct drm_gpuvm *gpuvm,
 				 u64 addr, u64 range);
 struct drm_gpuva *drm_gpuva_find_first(struct drm_gpuvm *gpuvm,
 				       u64 addr, u64 range);
-struct drm_gpuva *drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start);
-struct drm_gpuva *drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end);
 
 /**
  * drm_gpuva_invalidate() - sets whether the backing GEM of this &drm_gpuva is

-- 
2.53.0

