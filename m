Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B644AC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B1C10EA25;
	Fri, 25 Sep 2026 08:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OTcVbO8C";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28B210EA25;
 Fri, 25 Sep 2026 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=tyVss/7ya63mZWkQTf0O8as+/zSeErFL/MAD/HoyieY=; b=OTcVbO8CpgxmmhiUhrrqGnWJqs
 sxIDDWW7kqIp4RwXZQbI1uEbH9MsVBOxOfNm8iQq1lbArxWumk68zqXl5+NVP1F2EfEtplSwn7www
 fw4slvXx5S8H9soN4xqW1/2E9HNFXeVOob5OW5IjT+ZkJ67y06UHVYXo1JIukuWKYolL+sLHIxe4z
 gBl/uq51fZLYfMPQT3omvVpSq063qYhPRrfbcBRbE5qGWqaDRhURuPkIJueuItqzdUaE15Qvs7Q2K
 K64YEa2wn4ztKOAkv+aIBKGbgZ7PCb/+HEFyJ4b7pai1H1HA2s2HudcRnI106P1pOq2VoRIsw1ef+
 Dk0GWGtQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xA1hM-0073wo-AV; Fri, 25 Sep 2026 10:54:28 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Fri, 25 Sep 2026 05:54:04 -0300
Subject: [PATCH] drm/amdgpu: remove unused adev parameter from
 amdgpu_vm_pt_free_list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-amdgpu_vm_pt_free_list_args-v1-1-f6f1c644c878@igalia.com>
X-B4-Tracking: v=1; b=H4sIAKw2tmoC/x3MUQqDMAwA0KtIvlewdRPcVcYIcY01MF1JVATx7
 pZ9vp93gLEKGzyrA5Q3MfnNBf5WwWekObGTWAyhDm3dhbujKaa84jZhXnBQZvyKLUiazHnm2Pr
 GE/UPKENWHmT/76/3eV4SskMtbQAAAA==
X-Change-ID: 20260924-amdgpu_vm_pt_free_list_args-1eed6131aab5
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Since commit b6c4f90b3819 ("drm/amdgpu: sync page table freeing with tlb
flush") simplified amdgpu_vm_pt_free_dfs into amdgpu_vm_pt_free_list, it
does not need adev as it already finds the target PTs on the
tlb_flush_waitlist.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 +---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bb04101b0fb5..d090bbbdc00d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1252,7 +1252,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		tlb_cb = NULL;
 	}
 
-	amdgpu_vm_pt_free_list(adev, &params);
+	amdgpu_vm_pt_free_list(&params);
 
 error_free:
 	kfree(tlb_cb);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d32183cd9e0f..5d9063e71268 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -613,8 +613,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
-void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
-			    struct amdgpu_vm_update_params *params);
+void amdgpu_vm_pt_free_list(struct amdgpu_vm_update_params *params);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e43a60d09808..af0d95fa8965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -551,13 +551,11 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 /**
  * amdgpu_vm_pt_free_list - free PD/PT levels
  *
- * @adev: amdgpu device structure
  * @params: see amdgpu_vm_update_params definition
  *
  * Free the page directory objects saved in the flush list
  */
-void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
-			    struct amdgpu_vm_update_params *params)
+void amdgpu_vm_pt_free_list(struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
 	bool unlocked = params->unlocked;

---
base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
change-id: 20260924-amdgpu_vm_pt_free_list_args-1eed6131aab5

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

