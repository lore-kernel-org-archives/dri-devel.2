Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E099ACA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE7B10E64B;
	Fri,  2 Oct 2026 18:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCQCGpPC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9EE10E669;
 Fri,  2 Oct 2026 18:09:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A0B2A447FF;
 Fri,  2 Oct 2026 18:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83977C4AF19;
 Fri,  2 Oct 2026 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790964560;
 bh=JVcZAIT4blingZlqDwuU8K//v4iaqW2865cNyjb1tss=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PCQCGpPCwBuQy7Wov0S7nBnupga2y129u/XtM2F6/O3uGuDX9ZyE9BpFutGZzS1Ax
 B/oKm3wmNfQcRxI7oxFo/yhUsRhdUyY84ju7R1ubqEXL7tswEAtzK3JLT+o5So4MJK
 Laxe540A0205nYKaaBAyFQsTlPSXhGNVo9FMsM1b+nch9ORiwo//zMKtfLmZyPM1cM
 n/I8vipYp9V36tocoYIKpXeht4fFVPWr14grl+8jDfoBSkkMmHZAJ+FKEIFQw3UxPO
 du7ecSZjCbEbADefoAEn05MYM+mQf7/DdI+aRK7h/zg8d3XqFz444r6AcN5Z72bgVP
 oKWErocbXlk9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6B885CA5FE4;
 Fri,  2 Oct 2026 18:09:20 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Fri, 02 Oct 2026 12:09:14 -0600
Subject: [PATCH 3/3] drm/nouveau/gsp: Fix NULL dereference in
 nvkm_gsp_gcx_ready()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-my-fixups-v1-3-a83d20f9d3fe@gmail.com>
References: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
In-Reply-To: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790964559; l=2861;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=2M9dEq49i0aD+XeaJ6avEiyZMMSw/YZ4lgbD6+NZKCg=;
 b=kH526DYovITBtZAg3q9UHXTnXfSCO9eGG6JfkQ3j7V4TQMnLPlDc5Y7BkzXsm1Qn3VmfBHDPU
 cA/QFTTRIYtBPr8vE2YpS4xvYAFPodPQJlB+JLn5GI0QlLEb4WIaRVq
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
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
Reply-To: jim.cromie@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jim Cromie <jim.cromie@gmail.com>

Commit cb4c7603678c ("drm/nouveau/gsp/r570: Add support for
INTERNAL_GCX_ENTRY_PREREQUISITE") hooked nvif_device_gcx_ready() into
nouveau_pmops_runtime_suspend() to consult GSP before runtime suspend.

On GPUs running without GSP-RM (e.g. Volta GV100, NvGspRm=0, or missing
GSP firmware blobs), device->gsp is instantiated but gsp->rm remains
NULL. nvkm_udevice_gcx_ready() checked "!gsp" instead of verifying
nvkm_gsp_rm(gsp), allowing non-RM instances to invoke
nvkm_gsp_gcx_ready(). nvkm_gsp_gcx_ready() then unconditionally
dereferenced gsp->rm->api, causing a kernel oops:

  RIP: 0010:nvkm_gsp_gcx_ready+0x10/0x30 [nouveau]
  Code: ... 48 8b 87 70 0e 00 00 <48> 8b 40 18 ...
  RAX: 0000000000000000 RDI: ffff8c9555fca000
  Call Trace:
   nvkm_udevice_mthd+0xa5/0x150 [nouveau]
   nvkm_ioctl+0xcc/0x1d0 [nouveau]
   nvif_object_mthd+0x110/0x1e0 [nouveau]
   nvif_device_gcx_ready+0x36/0x60 [nouveau]
   nouveau_pmops_runtime_suspend+0x39/0x140 [nouveau]

Instruction decode shows `mov rax, [rdi+0xe70]` loads gsp->rm (0x0),
and `<48> 8b 40 18` (`mov rax, [rax+0x18]`) faults accessing rm->api.

Fix by:
0. Checking !nvkm_gsp_rm(gsp) in nvkm_udevice_gcx_ready() so non-RM
   devices report GC6/GcOff ready and bypass the GSP call entirely.
1. Guarding gsp and gsp->rm in nvkm_gsp_gcx_ready() before inspecting
   gsp->rm->api->gsp->gcx_ready.

Fixes: cb4c7603678c ("drm/nouveau/gsp/r570: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
index f78e6b9b4292..d469437eb991 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
@@ -201,7 +201,7 @@ nvkm_udevice_gcx_ready(struct nvkm_udevice *udev, void *data, u32 size)
 	} *args = data;
 	int ret = -ENOSYS;
 
-	if (!gsp) {
+	if (!nvkm_gsp_rm(gsp)) {
 		args->v0.ready = NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
 		return 0;
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
index e475d0e8fa7b..9e07d67dcb0f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
@@ -51,7 +51,7 @@ nvkm_gsp_intr_stall(struct nvkm_gsp *gsp, enum nvkm_subdev_type type, int inst)
 int
 nvkm_gsp_gcx_ready(struct nvkm_gsp *gsp)
 {
-	if (!gsp->rm->api->gsp->gcx_ready)
+	if (!gsp || !gsp->rm || !gsp->rm->api->gsp->gcx_ready)
 		return NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
 
 	return gsp->rm->api->gsp->gcx_ready(gsp);

-- 
2.55.0


