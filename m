Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6BFC88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3386210F20E;
	Mon, 14 Sep 2026 20:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Y44WWrX+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F9010F20E;
 Mon, 14 Sep 2026 20:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=EXmjhdvec8gHXP1U1Nx31KxYyIwUrFSGAJdUqSK/91o=; b=Y44WWrX+Zy7Uh5WqYePTDErCXk
 tAE1EbyalyHOgvG+XiQ3Jg/8Hw2dUstsVyfYKxQe0tC1xk49jEUccN9pitwTwDiPT7/HRlureYDAi
 PUGxSw2Ue529Z3lTlNNx86stlomO6znkLdtOh2FNBzQ5RpuSwdLPtLHcsPrNCZ4N4BH1S50C+jmyB
 Kd+UZCj/8bKzTVLWvXyuSgPjpa1oO0pe7dCnRSM2ITL6XFBaCQL8dELHga+nYVT/7Sgt/42qBzch6
 YpWIGgOMWMujBeduyn78wG18WrWP2r8zRFbPTUQW8wtG1REaBqtWydPgJCUDE36SifTAFdf7AXkvu
 aMfqWN1w==;
Received: from 179-125-70-185-dinamico.pombonet.net.br ([179.125.70.185]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6DEu-00258e-0c; Mon, 14 Sep 2026 22:25:20 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 0/4] drm/amdgpu: fix bugs when amdgpu_vm_ptes_update fails
Date: Mon, 14 Sep 2026 17:25:03 -0300
Message-Id: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFYqGoC/yXM2wpAQBSF4VfRvjZlNMbhVaQJs7GVQ7ORknc3u
 Pxa/esCRkfIUAQXODyIaZk9ZBhAO9Rzj4KsN8RRrKNcKlFPtl93c0ymoxNZWK2sVGmmkxTBV6v
 Db/BRWf3mvRmx3d4buO8Hd171AXMAAAA=
X-Change-ID: 20260914-amdgpu_vm_fixes-d64d1478657e
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com, 
 Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.16-dev-62088
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

When amdgpu_vm_ptes_update fails, there might be jobs leak and mappings
might be kept in an on-stack list, which will lead to invalid list
walking later on.

One of the approaches that was attempted was introducing an abort
function to amdgpu_vm_update_funcs. But given the possibility that some
mappings have already been pushed and committed and some may have been
moved to tlb_flush_waitlist, do a partial commit instead and return the
error to amdgpu_vm_update_range caller.

Also, fix amdgpu_vm_clear_freed ignoring the result of
amdgpu_vm_update_range.

I just noticed a different fix for the latter was submitted at [1]. It
re-adds the mapping to the freed list instead of not removing it when
amdgpu_vm_update_range fails.

[1] https://lore.kernel.org/amd-gfx/20260905023151.90699-1-oushinnyo@163.com/

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Thadeu Lima de Souza Cascardo (4):
      drm/amdgpu: make amdgpu_vm_sdma_commit handle NULL or empty job
      drm/amdgpu: make amdgpu_vm_update_funcs commit return void
      drm/amdgpu: don't free mapping when amdgpu_vm_update_range fails
      drm/amdgpu: commit pending work when amdgpu_vm_ptes_update fails

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 14 +++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 26 ++++++++++++++++----------
 5 files changed, 27 insertions(+), 27 deletions(-)
---
base-commit: 59ced288fcba9e91bd38e61a972ad782c4edb7d0
change-id: 20260914-amdgpu_vm_fixes-d64d1478657e

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

