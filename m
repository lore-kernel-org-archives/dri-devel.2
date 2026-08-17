Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D97C5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B0A10E648;
	Mon, 17 Aug 2026 06:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oQHfE9h0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E6310E648;
 Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0707A41B5F;
 Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2937C2BCB3;
 Mon, 17 Aug 2026 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786949442;
 bh=u/VaKggcAOLEcGn3Y0lUjyHfOlHj39Ku/qCdC+XjX+M=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=oQHfE9h04Fb5MICfUSIokRTDbI2UqOnZfklYwq15HIiDRGX9yIfaIsF57i0VZEVP1
 SHcqREuVIz0ShnqobyCSELwcWnR+sBV7COkxCl1RpdtM1q5nwpzKfSEt0mQG2tZaJy
 +YYCSknN2lqxJ7TMh1T9lVgmhHFYCD1chgUDtL8vOx1mwtx6K02ZJO9xYQ93XP0ZpA
 V8hYpil8CpytroBzBjsHRnGvcSHPklbt4feOXN1vapMjsJfLb3FfH09ZcLgszFHkzv
 YoBPXRuEv1TXbzM6IIN3uUvBMxUxTbFzjMSzEoLuQCKvc3E7pAmolddV4GM80HvUbq
 RSWchTuwSQ5zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BB1ACC5DF74;
 Mon, 17 Aug 2026 06:50:42 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/2] drm/nouveau: fix out-of-bounds VRAM access and VM_BIND
 page-size mismatch
Date: Mon, 17 Aug 2026 14:50:39 +0800
Message-Id: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+vgmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nz3bz80rLUxFLdtMyK1GJdI2MLc3MLE9Nk48QkJaCegqJUsARQS3R
 sbS0AIPyWx18AAAA=
X-Change-ID: 20260817-nouveau-fixes-23877845c3ab
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=u/VaKggcAOLEcGn3Y0lUjyHfOlHj39Ku/qCdC+XjX+M=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrKb1DskN65l1HvV2Gn0WWd6l+6pxq8KdBMs357hnN
 vsvjuD/u6yjlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJjLvKMN/n93uaXl7lH71
 1PQdu5PkcFuIQ8bm/rFZF7nfTKpRul9yg5HhSv2bRfWmDg8lLzxYPynz1d1VPnPquyp/v2qXF2n
 qm72bGwBBAE9E
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

Two unrelated fixes; they touch different files and can be applied
independently.

Patch 1 sizes the VRAM buffer object backing a device-private region to
the region it actually backs. The region grew to DMEM_CHUNK_SIZE *
NR_CHUNKS while the buffer object stayed at DMEM_CHUNK_SIZE, so
nouveau_dmem_page_addr() resolves every page past the first chunk to VRAM
outside the object.

Patch 2 rejects a VM_BIND that replaces a mapping with one using a
different page size. A new mapping takes over the page tables of the
mappings it replaces, which only holds while they all use the same page
size. Since select_page_shift() started deriving one per mapping it no
longer does, and the new mapping ends up mapping at a size its page
tables were never built for.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (2):
      drm/nouveau/dmem: pin VRAM for the whole registered range
      drm/nouveau/uvmm: reject replace across page sizes

 drivers/gpu/drm/nouveau/nouveau_dmem.c |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)
---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260817-nouveau-fixes-23877845c3ab

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


