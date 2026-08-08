Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C498C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A419210E4BD;
	Sat,  8 Aug 2026 11:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZCHQ8FPS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE5910E010;
 Sat,  8 Aug 2026 11:17:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B70360054;
 Sat,  8 Aug 2026 11:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C87BBC2BCB8;
 Sat,  8 Aug 2026 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786187837;
 bh=qBJ2yKuCe+qydBAwBPNKgkU4vVCYc0ywAbFKq6nD8ZM=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ZCHQ8FPSUccVzKfrkcCh1a1gJaDqcz4XxcRFoGuxVU8xJoKRAgH7ItI7wYg4IRmfA
 c5PFu6EVlvgP0U3AD0YnvGDbw30KvjOANcl8WVa4cFBNAjihn7QuwFp/9bp7fgrIi5
 P5j1EyS+PTamHo0MFrfY7FmHoNDPjUT4zcvVg2iTUidkmoZhB8R1mlSuWn1KjL8ZVO
 /wVVZPRDdSrTIEk7/K1YONMfBDdnxSiM8Q7nmOirOK2X2NDsxFHonYjEHTxMj67HZa
 u8V/uwSF10ccjqm9/lTwwWkkA/0xHpNvivfq4Mh7ZQSztEyDmWjHXrdGg9crF628au
 sg+2NSSl+uM5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8B213C55174;
 Sat,  8 Aug 2026 11:17:17 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/2] drm/nouveau: fix unbounded kernel allocations in the
 VM_BIND uAPI
Date: Sat, 08 Aug 2026 19:14:16 +0800
Message-Id: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgPd2oC/x3LQQqAIBBA0avErBOmxJSuEi2kxpqNhqIE4t2Tl
 o/Pr5AoMiVYhwqRCicOvmMaBzhu6y8SfHbDjPOCBo3wIReyWTh+KQmNVqOTTkmjoD9PpD/0Zdt
 b+wB+fx5PXwAAAA==
X-Change-ID: 20260808-nouveau-fixes-70a70f3f5385
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=qBJ2yKuCe+qydBAwBPNKgkU4vVCYc0ywAbFKq6nD8ZM=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrHIBi08MP5l7s2M5cmvP935cMcdbe8FB18a7p2qY4
 pM25joLhneUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARMqaGf4Z2ulnzsx4d9bo
 58z72/0/zZwTbj9T+eCtRXNZ9KbJy5g9ZWSYuTR56f3IApbIlssn3+0oj+IVqd5T+CNHMNXYdfX
 hfnFGAOcWSP0=
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

Two independent fixes to the uAPI added by b88baab82871 ("drm/nouveau:
implement new VM_BIND uAPI").

Patch 1 bounds the sync and operation counts in EXEC and VM_BIND.
nouveau_exec_ucopy() and nouveau_uvmm_vm_bind_ucopy() hand user-supplied
u32 counts straight to u_memcpya(), which only rejects multiplication
overflow -- something a u32 count times a small element size never
reaches on 64-bit.  A wait_count of 0xffffffff thus becomes a 64 GB
vmemdup_user() request: above INT_MAX that trips the WARN_ON_ONCE() in
__kvmalloc_node_noprof(), and below it the kernel attempts a vmalloc of
up to 2 GB that GFP_USER leaves uncharged to the caller's memcg.

Patch 2 rejects a second VM_INIT.  nouveau_uvmm_ioctl_vm_init() never
checks whether the client already has a GPU VA space before overwriting
cli->uvmm.ptr, so a second call orphans the first nouveau_uvmm with no
remaining reference to it.  The orphan, its drm_gpuvm, that gpuvm's
reservation object and its region maple tree are never freed, the buffer
objects mapped in it stay pinned, and its nvif vmm keeps the GPU page
directories allocated until the file is closed.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (2):
      drm/nouveau: bound sync and op counts in EXEC and VM_BIND
      drm/nouveau/uvmm: reject a second VM_INIT

 drivers/gpu/drm/nouveau/nouveau_exec.c | 12 ++++++++++++
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 24 ++++++++++++++++++++++++
 include/uapi/drm/nouveau_drm.h         | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260808-nouveau-fixes-70a70f3f5385

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


