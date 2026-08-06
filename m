Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200B2C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5550110E280;
	Thu,  6 Aug 2026 04:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U/x0iTAs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9856810F089;
 Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5035B435D9;
 Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30F8CC2BCF5;
 Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785991537;
 bh=JTWQsMVQWpqAcgi+OJObB+Qe7+AfYuU84GSs5YSeK3o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=U/x0iTAsLGlq0H2AAeKCP5ZySWe8sNag3kBEpXV6BEh/+Hgo8dEc1OPDc7WYNYMTO
 sW8z6TA+LA+BkQK5M39oamWrYtiXnWZIzfWh6Tsnv5M+jvpOxd3LpttFttRvp1t2tE
 2jmwtunmEtD9P4SkWoDwi/u1nIXYzyexV2gIhlu132aLwu5+EfRNbeQpbgWruIClQS
 OGpcM1bYKaeQQzKclukUR4z9Uutqb3dW1s5NY/RdkDvmrlE9hbMwImFapnBnqgMh9O
 z/WWbWr4cMBW8lB5EopamSiRGVYyecm8bDH1rPwRFILl4KtEVSxMfR9oQmtgVPuTdr
 qRNHjOV11TqZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 11665C55838;
 Thu,  6 Aug 2026 04:45:37 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Thu, 06 Aug 2026 12:45:24 +0800
Subject: [PATCH 1/3] drm/amdgpu: disallow multiple FENCE chunks in one submit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-amdgpu-fixes-v1-1-ce247012d4da@outlook.com>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
In-Reply-To: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=U1v7v3zFLG1cH7eOPY13uCvfCEVk89tQy4HVVMDjA30=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBLB/Ihr1ifkNpY86DomM62A6+quZw2Ll7DvtuFu3
 HP70+MbCic6SlkYxLgYZMUUWY4XXPpm4btFd4vPlmSYOaxMIEMYuDgFYCJWMxgZJiQZdbx4+8gq
 ykxiptS8TfHehaEdndwHzsxKmS5hqXnzNMM/Zc3i+6+zV4kUs6p5yTEzOMZpa3lcW1L7lcWnbs6
 5Ffu4AMMlSJ8=
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

amdgpu_cs_pass1() dispatches on chunk_id once per chunk without
rejecting repeated ids. p->uf_bo is a single-slot field, so a
submission carrying two AMDGPU_CHUNK_ID_FENCE chunks runs
amdgpu_cs_p1_user_fence() twice, and the second run overwrites
p->uf_bo with a freshly referenced BO without dropping the reference
taken by the first.

amdgpu_cs_parser_fini() only unrefs the final p->uf_bo, so every FENCE
chunk but the last leaks a BO reference. The leaked BO outlives handle
close and process exit.

Reject duplicate FENCE chunks the same way commit fec5f8e8c6bc
("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit") did
for p->bo_list.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5445f75741b5..9c514cb01096 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -228,6 +228,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
 				goto free_partial_kdata;
 
+			/* Only a single user fence is allowed to simplify handling. */
+			if (p->uf_bo)
+				goto free_partial_kdata;
+
 			ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
 						      &uf_offset);
 			if (ret)

-- 
2.51.2


