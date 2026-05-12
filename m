Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4CECD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 17:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E6B10E2A0;
	Tue, 12 May 2026 17:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="seeHbiOP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC37610E2A0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:36:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B68C343E3C;
 Tue, 12 May 2026 17:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F0E2C2BCB0;
 Tue, 12 May 2026 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778607390;
 bh=9uHXI+IUdXJGhO0SbSvV3iaivCo0yH+io8U1Lq5lcqA=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=seeHbiOPe5ud1PKf9mZecjxOQC/cjkQxYwcCQ5KH+hMLMeHKzG617isjxTMH3YqmF
 nLx5VEQj+BYKhfs+g3JKUZoknDIV4RlJUe5XLG95YAzRL7S4cvsObAt4hmm1+dEt2l
 sucD/8Ob8EH05DMdyh1wkRSaA3adFV0m3ezJfCs/1hbUd9jY31JnsJXyPkJLuw+zkA
 21ssRwsNAaecPwRaWQuOvro1TWFc2unogqBn62KJFOAsM/JyDQXhR/EeZwuFsHyE8K
 P0yaLIxEjnifWJhYWXpLlk+JG5edFINKSWkZEng2PEtMUwo6IaoQzZJZ6bAIeOM7sj
 1wgcjGCl388lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 81961CD4F25;
 Tue, 12 May 2026 17:36:30 +0000 (UTC)
From: Chia-I Wu via B4 Relay <devnull+olvaffe.gmail.com@kernel.org>
Date: Tue, 12 May 2026 10:36:28 -0700
Subject: [PATCH] drm/panthor: set __GFP_SKIP_KASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-kasan-v1-1-d8d3e275d71b@gmail.com>
X-B4-Tracking: v=1; b=H4sIABtlA2oC/yXMzQ5FMBBA4VeRWWvS1l94FbEYDIakpIPcRLz7L
 Zbf4pwLhDyTQBVd4Olk4dUFmDiCbkI3kuI+GKy2uc6MVRu6fVq9WlDQKaPTorBJ2WJvIDSbp4F
 /769uPsvRztTtzwTu+w/4oywpcQAAAA==
X-Change-ID: 20260512-panthor-kasan-10477239bad1
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Chia-I Wu <olvaffe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=olvaffe@gmail.com;
 h=from:subject:message-id;
 bh=ASiB3HunlPGvoW9uuO3lUbsW+ch1/3mXojcsoRe+zik=;
 b=owGbwMvMwCV2uuv6dHcvAWnG02pJDFnMqbL1Pebrfpx8uyloobn8sZj7fL0r47uNtzUZW+YnM
 avPmcXZUcrCIMbFICumyLJT6fPXwIzCy3eEG9fBzGFlAhnCwMUpABORXMnwP+LmBr44/VUCwtKf
 bFe/WZOrLOxsoVPTsKP6zuc9ZzJ+ZzH8LyqyeB+omLZcm8Xpbf60k86/o9xUF04LeK/tpSf8/Ec
 sNwA=
X-Developer-Key: i=olvaffe@gmail.com; a=openpgp;
 fpr=8C8F791802BBB330399230F27CB6CD58BE1B6831
X-Endpoint-Received: by B4 Relay for olvaffe@gmail.com/default with auth_id=776
X-Original-From: Chia-I Wu <olvaffe@gmail.com>
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
Reply-To: olvaffe@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Chia-I Wu <olvaffe@gmail.com>

Pages that can be swapped out should be allocated with __GFP_SKIP_KASAN.
Rather than setting the flag directly, replace GFP_HIGHUSER by
(GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE) instead, which should match the
preceding comment better.

On a CONFIG_KASAN_HW_TAGS=y system, without __GFP_SKIP_KASAN, the page
allocator assigns a valid tag to both the kernel mapping and MTE,
instead of assigning the match-all KASAN_TAG_KERNEL tag to the kernel
mapping. If userspace also maps the page with PROT_MTE and modifies the
MTE tag, accessing the page via the kernel mapping results in KASAN
invalid-access, such as

  BUG: KASAN: invalid-access in swap_writepage+0xb0/0x21c
  Read at addr f5ffff81aa71dff8 by task WM.task-4/6956
  Pointer tag: [f5], memory tag: [f9]

While userspace cannot map drm gem objects with PROT_MTE, the problem is
shmem_swapin_cluster. When it swaps in a cluster of pages using our gfp
flags, some of the pages might belong to other mappings that have
PROT_MTE.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
The latest snapdragons appear to have MTE support. drm/msm might need
the same treatment.
---
 drivers/gpu/drm/panthor/panthor_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 13295d7a593df..08c03aa0db2f7 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1013,7 +1013,8 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 	 * going to pin these pages.
 	 */
 	mapping_set_gfp_mask(bo->base.filp->f_mapping,
-			     GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+			     (GFP_HIGHUSER_MOVABLE & ~__GFP_MOVABLE) |
+				     __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
 
 	ret = drm_gem_create_mmap_offset(&bo->base);
 	if (ret)

---
base-commit: 6101f78b684895d5860a96322e607e0f46f433ad
change-id: 20260512-panthor-kasan-10477239bad1

Best regards,
--  
Chia-I Wu <olvaffe@gmail.com>


