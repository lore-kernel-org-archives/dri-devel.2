Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B02CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F47410F907;
	Mon,  8 Jun 2026 19:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="I5CpvjbO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D093C10F90A;
 Mon,  8 Jun 2026 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=31JmmMTKHzct1nDyUHBaEfHsNN0eM6NOmSqMdavHu+U=; b=I5CpvjbOBOeVFX2nUPWcOkIESe
 MoEym5fMSTo0BjcemHTvD2hZ1x0slMvtlq65iaoL6iIDx1+6oV+/Bm3CMCK30WCI+zQBBJ351xces
 HhccmKmKDW4Z3zrIplUB8wWSQnSN+lbvRvmPDZRp2eJHkdaUcWT6j8obeEVIsTiJ0MiMT4Z/WnlOq
 sZriicTeQoImFxsgUQJ1dji/SKT3xQsvDm6B9L6ukWlfCxjuCBdo/g22KRX1KfDsK7reiBEC0k/ly
 J2C2qpNkCvvZbWdmnTNQ4BnHA23uXLwNp6krP7VZxccUZ4KD4yNgimVOXIR5IWT73Lfhm/HhdUfQA
 3UocaZRw==;
Received: from 179-125-70-185-dinamico.pombonet.net.br ([179.125.70.185]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWfYa-00EY5f-NY; Mon, 08 Jun 2026 21:22:45 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 08 Jun 2026 16:22:35 -0300
Subject: [PATCH] drm/amdgpu: initialize irq.lock spinlock earlier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-amdgpu-mutex-fix-2-v1-1-1d850180ed19@igalia.com>
X-B4-Tracking: v=1; b=H4sIAHsWJ2oC/yXMQQqAIBCF4avErBtQA5GuEi0sp5rACs0Iortnt
 fx4vP+CSIEpQl1cEOjgyOuSIcsC+skuIyG7bFBCaaGFQevduCX0aacTBz5RYWWkrTpyRg4C8nE
 LlIcv2rS/Y+pm6ve3BPf9AHPFhzt2AAAA
X-Change-ID: 20260608-amdgpu-mutex-fix-2-381a3bed81f0
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
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

If there is an early failure during amdgpu probe, like missing firmware, it
will end up calling amdgpu_irq_disable_all, which takes irq.lock spinlock
without it being initialized.

Initializing irq.lock earlier at amdgpu_device_init fixes the issue.

[   79.334079] INFO: trying to register non-static key.
[   79.334081] The code is fine but needs lockdep annotation, or maybe
[   79.334083] you didn't initialize this object before use?
[   79.334084] turning off the locking correctness validator.
[   79.334088] CPU: 2 UID: 0 PID: 1819 Comm: bash Not tainted 7.1.0-rc5-gfd06300b2348 #96 PREEMPT  8e8f461221633dae3c832d6689eaf0546c0ed4cd
[   79.334092] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0133 08/05/2024
[   79.334094] Call Trace:
[   79.334095]  <TASK>
[   79.334097]  dump_stack_lvl+0x5d/0x80
[   79.334103]  register_lock_class+0x7af/0x7c0
[   79.334109]  __lock_acquire+0x416/0x2610
[   79.334114]  lock_acquire+0xcf/0x310
[   79.334117]  ? amdgpu_irq_disable_all+0x3b/0xf0 [amdgpu c88bab43d391d519ad0d5c8e5a099b4aceefa180]
[   79.334503]  ? _raw_spin_lock_irqsave+0x53/0x60
[   79.334508]  _raw_spin_lock_irqsave+0x3f/0x60
[   79.334510]  ? amdgpu_irq_disable_all+0x3b/0xf0 [amdgpu c88bab43d391d519ad0d5c8e5a099b4aceefa180]
[   79.334881]  amdgpu_irq_disable_all+0x3b/0xf0 [amdgpu c88bab43d391d519ad0d5c8e5a099b4aceefa180]
[   79.335240]  amdgpu_device_fini_hw+0x90/0x32c [amdgpu c88bab43d391d519ad0d5c8e5a099b4aceefa180]
[   79.335704]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu c88bab43d391d519ad0d5c8e5a099b4aceefa180]
[   79.336159]  amdgpu_pci_probe+0x204/0x440 [amdgpu c88bab43d391d519ad0d5c8e5a099b4aceefa180]
[   79.336494]  local_pci_probe+0x3c/0x80
[   79.336500]  pci_call_probe+0x55/0x2e0
[   79.336505]  ? _raw_spin_unlock+0x2d/0x50
[   79.336508]  ? pci_match_device+0x157/0x180
[   79.336512]  pci_device_probe+0x9b/0x170
[   79.336516]  really_probe+0xd5/0x370
[   79.336521]  __driver_probe_device+0x84/0x150
[   79.336525]  device_driver_attach+0x47/0xb0
[   79.336528]  bind_store+0x73/0xc0
[   79.336531]  kernfs_fop_write_iter+0x176/0x250
[   79.336536]  vfs_write+0x24d/0x560
[   79.336542]  ksys_write+0x71/0xe0
[   79.336546]  do_syscall_64+0x122/0x710
[   79.336550]  ? do_syscall_64+0xd1/0x710
[   79.336553]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   79.336557] RIP: 0033:0x7f92fd675006
[   79.336561] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
[   79.336562] RSP: 002b:00007ffe4fa867a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   79.336565] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f92fd675006
[   79.336567] RDX: 000000000000000d RSI: 000055b2dfce59b0 RDI: 0000000000000001
[   79.336568] RBP: 00007ffe4fa867c0 R08: 0000000000000000 R09: 0000000000000000
[   79.336569] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000d
[   79.336570] R13: 000055b2dfce59b0 R14: 00007f92fd7ca5c0 R15: 000055b2dfdbaf70
[   79.336574]  </TASK>

Fixes: 9950cda2a018 ("drm/amdgpu: drop the drm irq pre/post/un install callbacks")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 21a3fb574d53..e5a9f6325c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3749,6 +3749,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
 
+	spin_lock_init(&adev->irq.lock);
+
 	amdgpu_device_init_apu_flags(adev);
 
 	r = amdgpu_device_check_arguments(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 254a4e983f40..40b8506ac66f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -309,8 +309,6 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	unsigned int irq, flags;
 	int r;
 
-	spin_lock_init(&adev->irq.lock);
-
 	/* Enable MSI if not disabled by module parameter */
 	adev->irq.msi_enabled = false;
 

---
base-commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0
change-id: 20260608-amdgpu-mutex-fix-2-381a3bed81f0

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

