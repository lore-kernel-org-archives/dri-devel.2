Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532B9C5620A
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154F710F0A1;
	Thu,  6 Aug 2026 04:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ILDNVWJV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6709010F099;
 Thu,  6 Aug 2026 04:45:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9783560A64;
 Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AB6DC2BCFA;
 Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785991537;
 bh=qps4WXR6Y3kW2L+YWOrgrmtd3I5PsdfE4fmyegP2GcM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ILDNVWJVxJQfuEPhFup9jfsI2OuGe3FdYZAnlYlNMqBwpr9vVfYYBjNukX2PdB+8n
 yfT7pnF96Xm001au9PdM9wJaRlJ+a+K4MGlP/ORn6LPkt0JIjOJ+DLnFTfFN6eFyrS
 TW9y4bFDET4jvR1P6TI4K7NIDOdiof8f0QvPsdkCdi9fUxoPMmPEGQk0EiHSVpXpsu
 iL/vxEWlL3/e3IWRPN1KjRlcNIWkef1Boc7kWCTdtLqSz3AtzphYpPhzd2z1ZUE8t7
 rwlG+WqTiSJ3qzx87IYjFYF6wEkI2lS/FlwBviOXUzG4aBF/jchHkgixbx0o23bELB
 MRm4ILU951b/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 37278C56208;
 Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Thu, 06 Aug 2026 12:45:26 +0800
Subject: [PATCH 3/3] drm/amdgpu: add the BO-va mapping offset when kmapping
 an IB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-amdgpu-fixes-v1-3-ce247012d4da@outlook.com>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
In-Reply-To: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=MbTPCxPC+NDqqRce7zTi4D+evqyxLQPMZapIx+qmD0Q=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBLB/DfZi47l17h7SAeu4BEMcj9s2DaB3/PUHs7Qr
 W735Venv+goZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAiSzNYfjJGLTW9nlC6BXO
 woRQd5XGF9N/L/TaekN2tl3t8czgJm1nRoYNy5/s/vlEadqbDVUJms8cuoTL51u9k/f/yJS309L
 u0B8uAHdPSUc=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
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
Reply-To: moonafterrain@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Junrui Luo <moonafterrain@outlook.com>

amdgpu_cs_patch_ibs() derives the CPU-side view of a UVD/VCE/VCN
indirect buffer from the BO returned by amdgpu_cs_find_mapping():

    r = amdgpu_bo_kmap(aobj, (void **)&kptr);
    kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);

amdgpu_bo_kmap() returns the start of the BO, so only the displacement
of va_start inside the mapping is added.  The page tables, however, are
programmed from mapping->offset (see amdgpu_vm_bo_update()), which
records the offset_in_bo the client passed to AMDGPU_GEM_VA.  The GPU
therefore resolves va_start to BO byte

    m->offset + (va_start - m->start * AMDGPU_GPU_PAGE_SIZE)

while the kernel inspects the byte m->offset lower.  Whenever an IB is
submitted through a mapping created with a non-zero offset_in_bo, the
two views disagree.

Add the missing term so the kmapped pointer describes the same bytes the
page tables do.

Every other CPU-side consumer of amdgpu_cs_find_mapping() omits
mapping->offset in the same way.

Fixes: 4802ce117786 ("drm/amdgpu: fix UVD/VCE VM emulation")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9c514cb01096..a72cee871af3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1047,7 +1047,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		if (r)
 			return r;
 
-		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
+		kptr += m->offset + va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
 
 		if (ring->funcs->parse_cs) {
 			memcpy(ib->ptr, kptr, ib->length_dw * 4);

-- 
2.51.2


