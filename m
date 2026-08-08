Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF80C5AD2B
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 10:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DA610E4B2;
	Sat,  8 Aug 2026 10:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mNMAq61W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB5F10E4AA;
 Sat,  8 Aug 2026 10:07:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DFA5432A3;
 Sat,  8 Aug 2026 10:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B48BC2BCB8;
 Sat,  8 Aug 2026 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786183654;
 bh=gUPN+M1TrpJU5VvlJKMa+SHlUKRGWi0Tsmx1lfmrOIs=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=mNMAq61Wh0+uTmLj95Muan3Y/xvizHBUv4wZT+6qXfpWLBRjYP2mVe0dWoUFD9ar0
 WfUrHCYj0oUCjj26Az2K3Uf4ABGZ5+gHWTuh1eHMr8mskgkV43lwyNvhPccZSoPWz9
 52R4bCu8TpcFJ8a1XGr6hZQuYa/Td1yei4Os4OP5ip+RsA/LkfGlvY0im4WMm2PnND
 RvJ4R4bdfaJJf+hvfSN49cwE+FRixhnTM5K7HajlCBNhOhts1hQ8zsjGcsFtm6S/A1
 fdcPAvI7zx/2JhTMrxx8fVykzlDCnBizZzEelx0LuASf0yNfHToMYa+jGgBdKAzNMO
 96dZ4r79kHVqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 27EEEC5AC67;
 Sat,  8 Aug 2026 10:07:34 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 08 Aug 2026 18:07:26 +0800
Subject: [PATCH v2] drm/amdgpu: add the BO-va mapping offset when kmapping
 an IB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260808-amdgpu-fixes-v2-1-36d66398601f@outlook.com>
X-B4-Tracking: v=1; b=H4sIAN3/dmoC/x3LQQqAIBBA0avIrBNGF2VdJVqIjjaLTJQikO6et
 Hx8foNKhanCIhoUurnymTr0IMDtNkWS7LtBox7RoJH28DFfMvBDVc7OKgwWJ1IIfcmF/tCPdXv
 fD5LIg2xeAAAA
X-Change-ID: 20260808-amdgpu-fixes-9ca10fa07e10
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=3FBj59YR9q4hNFYlTzD+oO1vogRrIbKjZwQeOYVwbY4=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrLL/j5LPXtkjmyZdbdzboX/ab4H+s35D75Blv2+7f
 ZR7uX/PlhcdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMBGtGIY/fJUxaotOOr/P
 uPCvbapvhFXwb+Zllak+D1aKfQl58qVlLcN/31milS8V3qhJeh2Yz7DC8dG3f40PLiwU79W5mPx
 /8sQIJgB7+VFO
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

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
Changes in v2:
- Drop the Fixes tag.
- Pick up Christian's Reviewed-by.
- Resend standalone.
- Link to v1: https://lore.kernel.org/r/20260806-amdgpu-fixes-v1-3-ce247012d4da@outlook.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5445f75741b5..17fe6d56e020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1043,7 +1043,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		if (r)
 			return r;
 
-		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
+		kptr += m->offset + va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
 
 		if (ring->funcs->parse_cs) {
 			memcpy(ib->ptr, kptr, ib->length_dw * 4);

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260808-amdgpu-fixes-9ca10fa07e10

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


