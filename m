Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71803C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3BC10E64E;
	Mon, 17 Aug 2026 06:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jSK3E7cu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF7A10E648;
 Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 32FF443CEF;
 Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 024CAC2BCF7;
 Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786949443;
 bh=0jIfKSzAE+75ToUwYrMLODJzLMibfWw9F/XdnV6FoW0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=jSK3E7cu+VAaOG+FFC8ni1vvHjR4yd2XjVUhz131j6+wuv7uTpasKuavN9O0gtGYj
 QNvu2tSfZzsi/ggaPb5cCCzzeaU00PEfCGE6jyn0IwVkfTi1poF7XNqrOpunkZM2he
 wjKbVlikUy9H+g3S6khgSxLKqXvWqeAlO7rkq2qu1V5AJaorrZ3hjPv80Bk4oxpC4V
 p2FP+ZTAO+BRC7frxgcACl5zlHtXs5LFmxh7Achp/FH0opeKjifcOAYMcx3BTr/Yz9
 I2s7RiJA7g7xv34fZB+7QYvX5xk3eMnKQXubitlLP+BDkb4DPxrILzFj81HQYxDY3+
 GuxDKsYNSyhmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB3C5B572;
 Mon, 17 Aug 2026 06:50:42 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 17 Aug 2026 14:50:40 +0800
Subject: [PATCH 1/2] drm/nouveau/dmem: pin VRAM for the whole registered range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
In-Reply-To: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Balbir Singh <balbirs@nvidia.com>, Mary Guillemard <mary@mary.zone>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=JWyT9l1BGNNzUOMeazwU1aUewzuACkAELT3y3ijb100=;
 b=kA0DAAoWceg4UIuO8EAByyZiAGqCr0Gia1eSm2iWLYigw1j3zlknOQqpGbukRHCvB7tZSeHHK
 4h1BAAWCgAdFiEEx3DS9jhNtC20TLRjceg4UIuO8EAFAmqCr0EACgkQceg4UIuO8EBu7wEAvphn
 +7tRZx/3bKNUMnkzJnovZ17334oxd+Xun10yN7gA+wY0GrtObNtbcC+rhjGswyHDmreHedTP47s
 SD0tqP8QB
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

Commit c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory
migration") grew the device-private region that
nouveau_dmem_chunk_alloc() registers from DMEM_CHUNK_SIZE to
DMEM_CHUNK_SIZE * NR_CHUNKS, but left the VRAM buffer object backing that
region at DMEM_CHUNK_SIZE.

nouveau_dmem_page_addr() returns chunk->bo->offset plus the page's offset
within the registered region, so every page past the first chunk resolves
to VRAM outside the buffer object.

Size the buffer object to the region it backs.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 9442ec6e1f6c..356ff8f3c1b8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -325,8 +325,8 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, struct page **ppage,
 	chunk->pagemap.ops = &nouveau_dmem_pagemap_ops;
 	chunk->pagemap.owner = drm->dev;
 
-	ret = nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM, DMEM_CHUNK_SIZE,
-				 &chunk->bo);
+	ret = nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM,
+				 DMEM_CHUNK_SIZE * NR_CHUNKS, &chunk->bo);
 	if (ret)
 		goto out_release;
 

-- 
2.51.2


