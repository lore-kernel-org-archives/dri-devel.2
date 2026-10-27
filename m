Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F43606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asmblr.net header.i=@asmblr.net header.a=rsa-sha256 header.s=1706450368.internal header.b=Kv8UBPlD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40AC112055;
	Thu, 29 Oct 2026 07:59:14 +0000 (UTC)
X-Greylist: delayed 580 seconds by postgrey-1.36 at gabe;
 Tue, 27 Oct 2026 19:45:51 UTC
Received: from shared-aoh59.rev.nazwa.pl (shared-aoh59.rev.nazwa.pl
 [85.128.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3E510E46A;
 Tue, 27 Oct 2026 19:45:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new using ClamAV (26)
X-Spam-Score: 3.374
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asmblr.net;
 s=1706450368.internal; t=1793129767;
 bh=GXZiXxLaCT6zNJxqGPpsw8ftIxUw0oJV+4UMcKmAg9g=;
 h=From:To:Cc:Subject:Date;
 b=Kv8UBPlDRuya9W/HtAuHl4iEbOXKZ3H6dcFBOK7RxJizWbG8bgHpq9BD+8LyVOPZz
 4R8YWrA+kzyPpPsUR0U9cgD5q9aN5vDwBPPcjkrqiA/DFq6QeE2np2mYbx+TesOOn9
 rffwEwwMdmLPyz0N3EXCQ5RkcII23/SJH+WtKEnI4ixqAW3SGIhaaI1EYlDshM/EMO
 92nJ4/PaEg4DCgaFm3Pk3pbSsnzl/d6t3IokfqIv6r15wYKsYQZQtt3MSGmOY8LuuF
 FsH3HjYab3CucrX0fPS+5fdGCq6cZi7Ru2w4La6r0eksZJ93L0V8BcJQZZUIOlMZCv
 P6L4Bd61JQNzA==
Received: from milkyway (91-150-220-230.dynamic.play.pl [91.150.220.230])
 by server753313.nazwa.pl (Postfix) with ESMTP id D4CAA1BD892;
 Tue, 27 Oct 2026 20:36:06 +0100 (CET)
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
Subject: [PATCH 1/2] drm/amdgpu: Prevent debugfs nullptr dereference
Date: Tue, 27 Oct 2026 20:35:58 +0100
Message-ID: <20261027193559.28474-1-amade@asmblr.net>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running
cat /sys/kernel/debug/dri/0/psp_spirom_dump
with amdgpu card that doesn't support it leads to nullptr dereference.
Add checks to prevent that.

Signed-off-by: Amadeusz Sławiński <amade@asmblr.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 82a2684dbd2e..627c74f16914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -5381,6 +5381,9 @@ static int psp_read_spirom_debugfs_open(struct inode *inode, struct file *filp)
 	struct spirom_bo *bo_triplet;
 	int ret;
 
+	if (!adev->psp.funcs || !adev->psp.funcs->dump_spirom)
+		return -EOPNOTSUPP;
+
 	/* serialize the open() file calling */
 	if (!mutex_trylock(&adev->psp.mutex))
 		return -EBUSY;
@@ -5473,6 +5476,9 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 
+	if (!adev->psp.funcs || !adev->psp.funcs->dump_spirom)
+		return;
+
 	debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_root,
 				 adev, &psp_dump_spirom_debugfs_ops, AMD_VBIOS_FILE_MAX_SIZE_B * 2);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index a4ec60f6c317..975d12359358 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -574,7 +574,7 @@ struct amdgpu_psp_funcs {
 	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
 
 #define psp_dump_spirom(psp, fw_pri_mc_addr) \
-	((psp)->funcs->dump_spirom ? \
+	(((psp)->funcs && (psp)->funcs->dump_spirom) ? \
 	(psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
 
 #define psp_vbflash_status(psp) \

base-commit: 83f32c773255720a661aa45d83e36278135f23f5
-- 
2.56.0

