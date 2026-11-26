Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB3606A331
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imU+P913
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A615D11224C;
	Thu, 26 Nov 2026 09:37:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB95112247
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 539B146512;
 Thu, 26 Nov 2026 09:37:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685847;
 b=xFhKr6YzOoagpPXbePQQrgv+YIVTVmyjhIrWzLHW1gQWtWUAfUb0fAI/wv9ANwUUCF1L
 z/fGzYEXOR0QzzF5k/cCTLXfkBPXSuB9yd7lNwvDyH/4US5xrv9qhi/bgJanftYMFPtVV
 t41m7wWVdTyw+9kebQftgxns0wC/adlC8M1Rf5/ui9CST3ynl/4mCjvC3zmgbxjzmmH2V
 2c7OrsM9uszzkftamNSLg5+xKXk1jO2wazIEsHVlKr04MpdcDjgShMNxTvU/iPez5DBXN
 7+T2qqgFAzCz/dNfMZQvwd71CPg6mrb7nYYMLpD88nGitnVsxZYLCiauATCVGKMfgsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685847;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=K1EBAYTDShITHjIGR2ujPscGBbbDr+2wQ9JYIaEtWTY=;
 b=PrM8nCp+3vuuQsf3lAbgXKcxXpiShO71KgpohkeegD6pbI1K9XwX3soly1OA1Hz++jsc
 OwhedzbM/1sLEd9LrlKGt9CXr9FRCw7nIdHWbqRSUO31/9nNephfeupQo1Emldkdj6s8X
 tJqbuOCpGvNJG4KkQFm2cEUNJu3HCibu0cdW2nRvH91D0P1QV/az0i7VLY2ZYbaW45IO1
 FS/ltBX3vqWnaVsUcXgcz49rORCe4f7+gQz2BQMEW/RUEqiiKaSVQLXyuctOVv8vGDAdJ
 szwo2oZjF32RBHoqqQ5F5pteqmi/opEx9s9JenQnGfuryirWksKiX8Sjn3+yuewhMSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D79361F000E0;
 Thu, 26 Nov 2026 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685847;
 bh=K1EBAYTDShITHjIGR2ujPscGBbbDr+2wQ9JYIaEtWTY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=imU+P91323OhNApzjBQGOpVy/ejWT36YzeBB8Pz7BfX5MFfmNQxcRuGEEsp/NeRTC
 5rMOC6GYmPctJ+1Pm4gLr9NNJzYeyXkRjkBHX/MaLHrr1QO7nunq0Wv9th7SxdSdJC
 RZ1gVQt9wv3iffDtH1Yuuh3KHp9/A8ycSgLEnPQNavubfHeTMR15+xby5ID/oqkCna
 UHh7ydU9yZf0B6fKRnd4LIWgbns11tHkd093Z11wHd2kt7ISDaFtF2y/WwK/wmdUG3
 W5ENhGu3IUL2ZPbEX3eDBCuNFNH27yNPaPxQEG1DoUMHgxCnwxIHoot+PcY0sgcFZJ
 4+bJ5XSr+nU0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id EA8CE4D384;
 Thu, 26 Nov 2026 09:36:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:49 +0000
Subject: [PATCH v4 06/17] drm/panfrost: Unwind a failed GPU mapping without
 dropping its pages
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-6-23579629ceca@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=2423;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=B/OG9Mi1gxkvCDAJITmI6/1lXQ/Ts4PcA1q80c3wpeo=;
 b=bcjlOTqPwsnf21usnsfiZw56HGvmcI17qplT8gQopkmT5sDR57+EeWPdxy7GwOcKWKRin6Av6
 DeDxpjdymdIDdhAVCZvyMYUPx3tYIW8UMqGnpkT6014fdkl1+kONgLu
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

Two error paths leave wrong state when a BO mapping fails part-way:
- If mmu_map_sg() fails, panfrost_mmu_map() calls
  drm_gem_shmem_put_pages_locked() without the reservation lock and
  drops pages that shmem->sgt still maps (an imported BO underflows
  pages_use_count). Keep the pages.
- If ops->map_pages() fails, the PTEs that call mapped stay in a VA
  range drm_mm hands out again. Unmap and flush them too.

Tested with a test-only map_pages() failure: before, the pages were
freed under the cached sg table and an imported BO kept 512 PTEs;
after, neither.

Fixes: 4da352cf8fb1 ("drm/panfrost: Handle page mapping failure")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
v4: test result added; no code change.
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index e70ae393e..e59a16b68 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -442,8 +442,10 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 
 			ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
 				       GFP_KERNEL, &mapped);
-			if (ret)
+			if (ret) {
+				total_mapped += mapped;
 				goto err_unmap_pages;
+			}
 
 			/* Don't get stuck if things have gone wrong */
 			mapped = max(mapped, pgsize);
@@ -459,7 +461,10 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	return 0;
 
 err_unmap_pages:
-	mmu_unmap_range(mmu, start_iova, total_mapped);
+	if (total_mapped) {
+		mmu_unmap_range(mmu, start_iova, total_mapped);
+		panfrost_mmu_flush_range(pfdev, mmu, start_iova, total_mapped);
+	}
 	return ret;
 }
 
@@ -483,18 +488,15 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	if (IS_ERR(sgt))
 		return PTR_ERR(sgt);
 
+	/* shmem->sgt holds the only page reference: keep the pages. */
 	ret = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
 			 prot, sgt);
 	if (ret)
-		goto err_put_pages;
+		return ret;
 
 	mapping->active = true;
 
 	return 0;
-
-err_put_pages:
-	drm_gem_shmem_put_pages_locked(shmem);
-	return ret;
 }
 
 void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)

-- 
2.55.0


