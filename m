Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEBFCA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69DE10EF36;
	Tue, 29 Sep 2026 20:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="I4KjSHPP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563F610EF36;
 Tue, 29 Sep 2026 20:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=tlnMpzwD0LV8XK6KuNQgbIWDcyrhDnEiMD00I7Wj+28=; b=I4KjSHPPL6yezxIV0ZR0E0DE27
 7yblKpkMvQ+b6iVcjjpBYk7IQdnZd7TNKPAVXZlxiMxyKj89Eas8r/JUI7eGVqfBTD64MeDg8EQK8
 qxOxFLga60x2HMdN9kWUBx5V49RYUAZO/ZwAGDGeR9zje/RoBUFxciU4Vh5hIMj/fYuigM9vM1+sh
 x+j2M0V3N29x5eTAY15qqOyZqZFkLemgvnt2QYO/32mAfIz/R7fxtii0IXxyBJDaiuXKcAixV6frE
 iEVJgGw4fFIurspj6vB/EOHl9HvZTu+80HF8WPo8SgNXDzeqlWHxkPL7MW01/TC3ImRqyE7d5apqn
 GDtKKNWw==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xBeWq-0096Z5-1h; Tue, 29 Sep 2026 22:34:20 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 0/2] drm/amdgpu: fix memleak when amdgpu_vm_ptes_update fails
Date: Tue, 29 Sep 2026 17:34:03 -0300
Message-Id: <20260929-amdgpu_vm_update_funcs_abort-v1-0-a8072140a7db@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0gvGoC/yXMSwqDMBAA0KvIrBuwqdimVykS8hntFIwhk0hBv
 LuxXb7N24AxETI8mw0SrsS0hIrrpQH3NmFCQb4aZCv7VkklzOynWPQ66xK9yajHEhxrY5eUhbo
 72906ZfuHh1rEhCN9f/1r+JuL/aDL5wn7fgDtOOI9gAAAAA==
X-Change-ID: 20260929-amdgpu_vm_update_funcs_abort-97cb4349b68d
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Chunming Zhou <david1.zhou@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Natalie Vock <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
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

When amdgpu_vm_ptes_update fails, there might be an IB jobs leak.

This was built on top of the patchset at [1].

A first attempt at fixing this was submitted at [2]. In that thread, it
was discussed that the failure happens due to an unmap trying to split a
hugepage and trying to allocate a PT BO. This is fixed by the patchset
at [1], by making the unmap not allocate any BOs.

However, the same failure might happen later, when the new mappings are
setup and the PT BO needs to be allocated.

The approach taken here is that instead of doing a commit, we introduce
a new abort operation and call it. In the case of SDMA, it frees the
job.

The commit still refers to amdgpu_vm_update_range, but the leak has been
reproduced with the patchset, so it shows up at amdgpu_vm_map_range. I
kept the original function name in the commit, however, as we might
consider to backport this.

[1] https://lore.kernel.org/amd-gfx/20260928151041.1857-1-christian.koenig@amd.com/
[2] https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com/

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Thadeu Lima de Souza Cascardo (2):
      drm/amdgpu: make amdgpu_vm_update_funcs commit return void
      drm/amdgpu: free job when amdgpu_vm_ptes_update fails

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 24 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c      | 13 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     | 20 +++++++++++---------
 5 files changed, 40 insertions(+), 31 deletions(-)
---
base-commit: a7629c76ab981c0d5749eef9f4e47d12a2083330
change-id: 20260929-amdgpu_vm_update_funcs_abort-97cb4349b68d

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

