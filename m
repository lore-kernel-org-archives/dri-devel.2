Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF414C5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D60910E91F;
	Mon, 10 Aug 2026 16:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cASpjYhd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BA510E20D;
 Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 32A0B60A6C;
 Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB0C6C2BCF7;
 Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786378667;
 bh=TtwXuOo7f/6QzG98rp5LXPITn3SYcjaZqv2NU1Zo/2M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=cASpjYhdIVf0owsIGF8yCYwZQ3IeDnTbp0qffmKhq+RzZRsJ8gwg9MMdMibzLnlJV
 uGpq8UcU7DTtT6CZyY8tOHHQEVQwLel8jWb1CT1tZwF2x9FsOxuwCm6VmAO04fdxFR
 09hUZEUWe9FpOArXNKFPX4gvyoMuvJArv17DmWFvf87OaTOY7i/TnkaHX95vLyNg94
 sQWXxmb0ly5a5xFoVEoVNiq8CCLZHfmoXm+xYOAgZNf+2kdcPAf7TuwN3Nmk+BI8Ke
 3dRzdzYgSkxW77ceUN9jHx3xirPu8egARiWeBs5hTxwyPc2Wjva9wPkqm4RbuUxIEy
 T/baJexq4Wh+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BCCEAC5B56D;
 Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 11 Aug 2026 00:13:11 +0800
Subject: [PATCH 2/5] drm/amdgpu: reject PRT mappings as user queue buffer VAs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amdgpu-fixes-v1-2-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
In-Reply-To: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>, 
 =?utf-8?q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=lfRKX90eM1yWKlq0c1LdgUl6q5HeCXaJonPRnO3TU20=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMqfS8MzkkW8LcUEFkwJaFi1V09slfqyG/p2N5wes
 iw49vLaimkdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMBFRB4b/SdMkBBe5RRtO
 Kl8g8cNstk7TrfXJ4Q4LbT0f2EaHsxRdYGS4rlpeoZampVt1JDRg451N3yeHZ+1T8PzAf9bk7c5
 PjdbcAPu3SQM=
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

amdgpu_userq_input_va_validate() resolves a user-supplied queue_va,
rptr_va or wptr_va to a VM mapping and latches userq_va_mapped on
the owning bo_va. It only checks that a mapping exists and that
the requested span is contained in it, never that the mapping has
a backing BO. PRT mappings do not: amdgpu_gem_va_ioctl() routes
every AMDGPU_VM_PAGE_PRT map through fpriv->prt_va, created via
amdgpu_vm_bo_add(adev, vm, NULL), so base.bo stays NULL while
amdgpu_vm_bo_insert_map() still sets mapping->bo_va.

A VA inside such a mapping therefore passes validation and marks
fpriv->prt_va as userq mapped. The flag is never cleared. On the
next unmap of any PRT mapping in that VM, amdgpu_vm_bo_unmap() sees
userq_va_mapped and calls amdgpu_userq_gem_va_unmap_validate(), which
reads bo_va->base.bo->tbo.base.resv before its ip_mask guard, leading
to a NULL pointer dereference.

Fix by rejecting a mapping without a backing BO in the validation
helper, so the invariant amdgpu_userq_gem_va_unmap_validate() relies
on holds by construction. A sparse mapping has no memory behind it and
cannot serve as a ring, rptr or wptr buffer.

Fixes: 2e7ceac0ea41 ("drm/amdgpu: validate userq va for GEM unmap")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..bec107216811 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -259,6 +259,14 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	if (!va_map)
 		return -EINVAL;
 
+	/*
+	 * A PRT mapping has no backing BO and so can't carry the eviction
+	 * fence which amdgpu_userq_gem_va_unmap_validate() waits on. Reject it
+	 * here, otherwise that helper dereferences a NULL bo on GEM unmap.
+	 */
+	if (!va_map->bo_va->base.bo)
+		return -EINVAL;
+
 	/* Lookup guarantees start_page is mapped; ensure full span is covered. */
 	if ((end_addr >> AMDGPU_GPU_PAGE_SHIFT) <= va_map->last) {
 		va_map->bo_va->userq_va_mapped = true;

-- 
2.51.2


