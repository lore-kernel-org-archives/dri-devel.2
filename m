Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F59CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10CF10FFE8;
	Fri,  9 Oct 2026 09:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V3ckakU/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735AF10FFE8;
 Fri,  9 Oct 2026 09:21:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 150B7439BA;
 Fri,  9 Oct 2026 09:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDCA7C2BCF4;
 Fri,  9 Oct 2026 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791537689;
 bh=qxzaWP43zMK890klSaHe9pUuha590tppejHYhCYdmWM=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=V3ckakU/wOS5fjZI3UykxDY7NzSCB0syU5TwjQN4ZBPmVu5gnF9ovl0lMCydA+bT7
 27G5NE0rObBU9iPMFHgbFHhZdYnwAvhsf8ho8NxWxB48idEgRVQBcZ0Lyer2JH/P7w
 L3xgDTmGZS757S/mTZFSRRehrMoNdZbsMoEk45tFItRCAqUx93wtymMtVpMQdryFcW
 5Ie6GgqsdwKk2TQd4xKJCfsdJlLyFzIPZy7QAo9J/Zn0hVI0fQ34wIa3IsuL8RCa5N
 91tqdCCzF7T1pCqMa3UHHX2TyiWuMzk9COCXm/QJSQBFcbLSV1dXl8G9flpZGKs1M9
 tQ6X8vejdkvWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C7B16CA6019;
 Fri,  9 Oct 2026 09:21:28 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Fri, 09 Oct 2026 16:52:22 +0800
Subject: [PATCH v2] drm/nouveau/uvmm: reject replace across page sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-nouveau-fixes-v2-1-a0b71bf8df1b@outlook.com>
X-B4-Tracking: v=1; b=H4sIAEWryGoC/3WMyw7CIBBFf6WZtRgeIsSV/2G6qHSwRGUMFKJp+
 u9i9y7PvTlngYwpYIZTt0DCGnKg2EDuOnDTEG/IwtgYJJdHboVhkUrFoTAf3piZVNYYe9BODVd
 ozivhdjTl0jeeQp4pfbZ8Fb/1X6kKxpnXwo7cGaW9OlOZH0T3vaMn9Ou6fgGMdF8nrAAAAA==
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
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4438;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=6FpAwbqLK/tSxZV1GoB5Wx5YVWdL5AMEJN9IWTGboAc=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBObxKWk9iQ8Eb7z+YiglLegTv0bxkKF7RVzbj/3+
 vpqZkaO+46OUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmMjiPoafjHutxK33MEb7
 /oq8tHfa+d31Yo7xjwpto4ON2U/38TqUMfxPu3fV7qLlpMTHtqIyX01uf//C1jq7wLxn1VaOsF+
 FP1dzAQCWFku6
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

A new mapping takes over the page tables of the mappings it replaces.
nouveau_uvmm_sm_prepare() only acquires page tables for the range no
existing mapping covers, and the map path frees the replaced mappings
without putting their references. That is only valid while all of them
use the same page size, which select_page_shift() no longer guarantees.

Rebinding a GART BO over a 2MiB VRAM BO therefore leaves the new mapping
owning page tables built for a different page size, and it then maps at a
size that was never referenced over that range. Since raw map does not
allocate, nvkm_vmm_iter() can walk down to a NULL leaf and dereference
it. The remainders of a split have the same problem: op_map_prepare()
recomputes a page size with select_page_shift() while the remainder keeps
the parent's page tables, so a parent that was itself downgraded can leave
a remainder that re-aligns to a larger size. This happens on the unmap
path too.

Reject the bind, and make split remainders inherit the page size of the
mapping they are split from.

Fixes: c488a94e7e14 ("drm/nouveau/uvmm: Allow larger pages")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
Changes in v2:
- Drop patch 1, which has been merged.
- Use the abbreviated conditional operator for page_shift (Lyude Paul).
- Compare against remap_args.page_shift (Lyude Paul).
- Use Assisted-by: LLM (Balbir Singh).
- Add Lyude's Reviewed-by.
- Link to v1: https://lore.kernel.org/r/20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index f5e4756b4de4..aa5b93808f41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -85,6 +85,8 @@ struct uvmm_map_args {
 	u64 addr;
 	u64 range;
 	u8 kind;
+	/* Page size to give the new mapping, or 0 to derive it from the op. */
+	u8 page_shift;
 };
 
 static int
@@ -655,7 +657,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 
 	uvma->region = args->region;
 	uvma->kind = args->kind;
-	uvma->page_shift = select_page_shift(uvmm, op);
+	uvma->page_shift = args->page_shift ?: select_page_shift(uvmm, op);
 
 	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
@@ -684,8 +686,20 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 	struct drm_gpuva_op *op;
 	u64 vmm_get_start = args ? args->addr : 0;
 	u64 vmm_get_end = args ? args->addr + args->range : 0;
+	u8 map_page_shift = 0;
 	int ret;
 
+	/* A new mapping takes over the page tables of the mappings it replaces,
+	 * so every one of them has to be using its page size. The new mapping
+	 * is the last op drm_gpuvm_sm_map_ops_create() emits.
+	 */
+	if (args) {
+		struct drm_gpuva_op *last = drm_gpuva_last_op(ops);
+
+		if (last->op == DRM_GPUVA_OP_MAP)
+			map_page_shift = select_page_shift(uvmm, &last->map);
+	}
+
 	drm_gpuva_for_each_op(op, ops) {
 		switch (op->op) {
 		case DRM_GPUVA_OP_MAP: {
@@ -713,11 +727,22 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 			struct uvmm_map_args remap_args = {
 				.kind = uvma_from_va(va)->kind,
 				.region = uvma_from_va(va)->region,
+				/* The remainders of the split keep the page
+				 * tables of the mapping they are split from,
+				 * so they must keep its page size too.
+				 */
+				.page_shift = uvma_from_va(va)->page_shift,
 			};
 			u64 ustart = va->va.addr;
 			u64 urange = va->va.range;
 			u64 uend = ustart + urange;
 
+			if (map_page_shift &&
+			    remap_args.page_shift != map_page_shift) {
+				ret = -EINVAL;
+				goto unwind;
+			}
+
 			op_unmap_prepare(r->unmap);
 
 			if (r->prev) {
@@ -756,6 +781,11 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 			u64 uend = ustart + urange;
 			u8 page_shift = uvma_from_va(va)->page_shift;
 
+			if (map_page_shift && page_shift != map_page_shift) {
+				ret = -EINVAL;
+				goto unwind;
+			}
+
 			op_unmap_prepare(u);
 
 			if (!args)

---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260817-nouveau-fixes-23877845c3ab

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


