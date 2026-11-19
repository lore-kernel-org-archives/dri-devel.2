Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222EE606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T7dzSWGe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134F7112670;
	Thu, 19 Nov 2026 17:07:28 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4AD112670
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:07:15 +0000 (UTC)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4ae40674bd0so22189fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108034; x=1795712834;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7+8hy451Az1QACplhl6NMxwsBcDH/OzMgfYQcFFvdBo=;
 b=T7dzSWGe/V9sGEW1Ioi0r4jCxBQJAIjpWnuJeoWJxwPZ6XPVPICbDEqUNDqPqhfMqu
 AEsVg7lBKDJwk3eLUNfrUgdJtON6WzMJRgF/bZynj0lCNcxWSYigaJsW1cYeQZvNOf7X
 XhIToUP9PTErlaEgqSY5k0icIcPnNm9BRShIQR8316BIWZezcgpInCS9xGTsn9x0oJFW
 fAMESWCxAilC49d7/VjZMHIx8L0CdN9ZH7ff+RdKgW49uYnzh6CIFfb9veZiNLhG/y+S
 0xv1LEEItXPbcFLzSIpLHN9rMVjKv77KY+mpOmRTdCQM8HC4IoXpiU2eYD7Z0ftymDX9
 tiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108034; x=1795712834;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7+8hy451Az1QACplhl6NMxwsBcDH/OzMgfYQcFFvdBo=;
 b=T4TeiKs98NfN7gfT7JGQ7l5P1obuHc6N2FIgdH7xdQY22k7P3pkm80ZvBNSiVOpxc3
 oJILPW2Fnl/ZoFUrDvFgyB/EOkwB9Eax4cFatA28oKiREHwtiWOHQGHCLLkegt1gaK/n
 lpNXE1u4YGHymUA4p1sxqIEuewuPGuOeqmsl2woImnSg2ejg7e5qX9Asls+TxI2dZiIL
 RvZ9gdxEeG/269wlRGA4i53cq6fyw5bl9sg/ilIHFAfNFQFj2sKSD4bPMp9/06CyH89N
 SqoXLTqf+FHQuAx6x0RjtuEtAAgctBUxSgNGjf01gqm38lr7OkCtJrwyLjTQW/q73c0l
 4vTA==
X-Forwarded-Encrypted: i=1;
 AL+hErEFM+G+ugkYvRGhcT1L+eFw7VuXCS2lGTft15RJ6zBrtJ0JQOm/dQ8pjV+V0xwPmsHq6k3l/GuQmkA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+z8dl8ndw+A7dHZVULORuCb9fALIN0tBaNFB7zNLlGzdPC+S3g
 o1mVpiFGhbxZwnAKTkdTz3mIXEb70+JEND1YU6eMq0Wli0VDU7Bb7iPTpXHZ8RU8CY4nnYYHIdF
 k5mt0OxESqw==
X-Received: from oibkf8.prod.google.com ([2002:a05:6808:4788:b0:4f2:da8a:16de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3503:b0:4f5:eaac:5151
 with SMTP id 5614622812f47-57a0b0414a8mr598706b6e.39.1795108034097; Thu, 19
 Nov 2026 09:07:14 -0800 (PST)
Date: Thu, 19 Nov 2026 09:07:05 -0800
In-Reply-To: <cover.1795106955.git.irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <cover.1795106955.git.irogers@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <6fcb1e5c7545f8bcfee9ac9a3abd296c475aa1b7.1795106955.git.irogers@google.com>
Subject: [PATCH 2/2] drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()
From: Ian Rogers <irogers@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In amdgpu_ttm_clear_buffer(), 'r' is declared uninitialized. When
consider_clear_status is true (such as AMDGPU_GEM_CREATE_VRAM_CLEARED
allocations) and all backing buddy blocks already have DRM_BUDDY_CLEARED
set, every iteration of the cursor loop hits 'continue' without assigning
'r', returning uninitialized stack memory to amdgpu_bo_create().

Initialize 'r' to 0.

Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Build-tested under LLVM=1 W=1 (-Werror) and
-Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.

Fixes: 23bd7e67961e ("drm/amdgpu: get rid of amdgpu_ttm_clear_buffer")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f86777250fc..280fcdfb9cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2675,7 +2675,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
 	bool vm_needs_flush = false;
-	int r;
+	int r = 0;
 
 	if (!entity)
 		return -EINVAL;
-- 
2.56.1.708.g77570a6a1d-goog

