Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B137CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F74810EAB7;
	Fri,  9 Oct 2026 17:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YQcz9eGo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A484C10EAA2;
 Fri,  9 Oct 2026 17:44:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B470A60AB9;
 Fri,  9 Oct 2026 17:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DEC6C2BCF7;
 Fri,  9 Oct 2026 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791567878;
 bh=XOnWl72BThB1Wx0FtcIF2mVsQ3qJHvVO40/kWNJOjPs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=YQcz9eGogpcYFNRBefNq8WnIELLxdntxr33KJLL0AZ+ryzLdOp/ShuHRTc2yJgDDM
 JY8iqyZq7Nto69HSmBDia/zUs2Z4JWE101G1NJpM7Wr/VGKZ2JQWRB30G4sdFCu5i9
 1kNyTXzdxrbCZmVtxgh6BkT+yYezlaOs4SMScAvgATK5303vd7WwkDNv7UZEzpoP6u
 5WvIGnV+72jKGS7SzcaWwwqwhVFAS9586432SHxOPkFsCcPnrM0p5S/nL4yxPlE3mE
 I8QInM80f+BHjEYZ1DyGloQURGwAyvTV1vGbiOgYnRvutRK2ABUnF38pnzLpSuZE2i
 CZO8qigO9/nQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 36A29CA9EBD;
 Fri,  9 Oct 2026 17:44:38 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Fri, 09 Oct 2026 11:44:24 -0600
Subject: [PATCH v2 1/3] nouveau: Fix NULL pointer dereferences in GETPARAM
 ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-my-fixups-v2-1-839e2bbe514d@gmail.com>
References: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
In-Reply-To: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Daniel Campos Ramos <Capitain_Jack@yahoo.com>, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791567877; l=2685;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Hif+OXQYKGWad7cgItXjfW/GXatKjgqK4mxSXyvdrUE=;
 b=9cdX7+DUx135DFDJCetWzH9k6vfQQujrkuxa/oz4qwmA06OyhC7CiX9BCv1kVkG8JLTwPwxNC
 YIYLlsJo9aPDJRTkKENISrnqqpG3lA8kUAlCWBZWX1oBgm/i+89bEvM
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

When hardware or firmware initialization fails, the graphics engine
(gr) or device functions may remain NULL. Attempting to access these
during the GETPARAM ioctl (e.g., NOUVEAU_GETPARAM_GRAPH_UNITS) results
in a kernel NULL pointer dereference, causing a crash when userspace
(GNOME/Mesa) attempts to probe the device.

Add safety checks for 'gr', 'gr->func', and 'nvkm_device->func' in the
ioctl handler. Return -ENODEV to signal the missing hardware state to
userspace, and use NV_ERROR_ONCE to provide diagnostic proof in the
kernel log without risking a console flood.

NOTE:

I encountered these crashes while booting unrelated code (in
dynamic-debug) on real HW.  There was also some fwupd updates around
this time, so it could all be transient/unreproducible.  But it did
happen, and could happen again in unforseen circumstances.

@Capitain_Jack tested the error path in v1 by deleting the FW

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 4542d5f4ded8..3f130cd4fbcd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -306,6 +306,11 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		getparam->value = 1;
 		break;
 	case NOUVEAU_GETPARAM_GRAPH_UNITS:
+		if (!gr || !gr->func) {
+			NV_ERROR_ONCE(drm, "GETPARAM_GRAPH_UNITS: no gr engine or func\n");
+			return -ENODEV;
+		}
+
 		getparam->value = nvkm_gr_units(gr);
 		break;
 	case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
@@ -315,10 +320,23 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		break;
 	}
 	case NOUVEAU_GETPARAM_VRAM_BAR_SIZE:
-		getparam->value = nvkm_device->func->resource_size(nvkm_device, NVKM_BAR1_FB);
+		if (!nvkm_device || !nvkm_device->func || !nvkm_device->func->resource_size) {
+			NV_ERROR_ONCE(drm, "GETPARAM_VRAM_BAR_SIZE: no device func\n");
+			return -ENODEV;
+		}
+
+		getparam->value =
+			nvkm_device->func->resource_size(nvkm_device, NVKM_BAR1_FB);
 		break;
 	case NOUVEAU_GETPARAM_VRAM_USED: {
-		struct ttm_resource_manager *vram_mgr = ttm_manager_type(&drm->ttm.bdev, TTM_PL_VRAM);
+		struct ttm_resource_manager *vram_mgr =
+			ttm_manager_type(&drm->ttm.bdev, TTM_PL_VRAM);
+
+		if (!vram_mgr) {
+			NV_ERROR_ONCE(drm, "GETPARAM_VRAM_USED: no vram mgr\n");
+			return -ENODEV;
+		}
+
 		getparam->value = (u64)ttm_resource_manager_usage(vram_mgr);
 		break;
 	}

-- 
2.56.0


