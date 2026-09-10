Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2020C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8227110F51D;
	Fri, 11 Sep 2026 07:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="ykWp9MEi";
	dkim-atps=neutral
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B475510F359;
 Thu, 10 Sep 2026 08:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1789027646;
 bh=CHrVd4QupN2Icd5LuQOXtHU8JZxOORarAdWW213eHzg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=ykWp9MEiSk7Jc+yhTjpeebX8Pp7PdhLcJ3kXtQBnhjKPTXM/xF3iJXF/tNf/kmaX1
 to8hx3iKMxszLgigEloFvFEPuVsXusS8aJBdcooKYrYZdbIOzpbpg4+r/EdvN0jJUk
 chzaSR1PiSbZDEDANYn56MnQ/I/aVzNnDSrolUHU=
X-QQ-mid: zesmtpsz6t1789027641tf2e5ab1e
X-QQ-Originating-IP: v57H0f8v9d+o9uYBjxvMedZTdt78u9k9xEX1xQad5tc=
Received: from hepeiyang-vm.wu.lxd ( [114.212.83.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 10 Sep 2026 16:07:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14959840024138416349
EX-QQ-RecipientCnt: 8
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: lyude@redhat.com, dakr@kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, bskeggs@redhat.com,
 Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] drm/nouveau: don't bump pin count on failed re-pin in
 nouveau_bo_pin_locked()
Date: Thu, 10 Sep 2026 16:06:59 +0800
Message-ID: <4C61D1CE5BB7CD58+20260910080659.2798052-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NpfbsqbTlzxUOvzqVtC/TKNNUMMBZqoi3BMLUiaduAYbs2die1X2i2g/
 EY9q0s7n+cB+RsdxX2JxQyA8Dos0iPQm3xhb54Q27Mg+MtwpFY9jGMW9QhNwM7xcnrUvSOm
 5EiQ6lxXtRGw3zjwqaMsL1abWg6J2hEFlsE5Rv+Q35cKLrSkwuzdKts5rOUrlnf7DwUChHr
 7cyJeZqDuVDkZiIvOM7wbznVZe28kd0Ai4x3ybQUWdA93xWCvSL3Sk16g0xvJqdn5MYBjCG
 HmdbMTCdWsfay1Dw4kC1OSrsXCMLDIHfGGr07eT/p6Pu6FdKmMpal1XASi0QulNHiX/R5SA
 Dx6rZPzpWSC2uKJXTd534geCr4H7ZILEZfiM5hppxIHcxVPsyAhSte4ksGl/UmNv9hnSoAU
 0TULnaPwzCx8Rydg4t6NdlDsH2TPXbF8xnSQN1KaoylvuhC24u7KnQ9uFFKwWdpPP/D94xN
 BoVSCXucZs7YBN1SGcXYtQ64OAWl3Yopac4bR6UWEaCmu0RW8GVbCLX11lNNKvv2wWDT63X
 zmDYSluXhUCvxF9v/iVdFaxIv0VVrzPjh6wl/hUyUJe8rDnbMHuuB63NRqkSGPPpMzSkjqU
 tWJNcuBmb7eBC4Np8IhYiSjWFcOL87/3Hc4P0jE2rpvRa/vE1tD+FaIWVYFTiIzB5vVAsTV
 GtkJyBu5XhO37hCBap0ta1SOJQgPMbX1D4EGO6Yael08h2DCN3vFFMyyybfxVIarYDEH5Db
 EelEPOOYfpN1Mk1iyp6hRnL6Nfd8XzT1/15I9vwtSEn5SGLCMsBMbxgmXCERhHd72hVHRku
 ITT3NzI4Mtb9kcLnhJQsi3V/dzEKWcrBVRCP4Kr44nYBeJE/xUxKlCICg5U1om9A7zAYcNL
 PY7EOT8e29RDAjXJI+LEpRKI2bMLL/3uY6iwR8Ywd8fS/mBMPYA0i8Coz2fsVgxMV8i8GPi
 Vf7LyTZLiYOdIho0vf+hsKQzRvaaFW5Wssho+nNB9DdVUuWeRuIQEDdSvNx3nQyuvKGcU7h
 t8Kmz667Ttb5JbxSL/
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

nouveau_bo_pin_locked() checks whether an already pinned BO is in a
memory domain compatible with a new pin request. When the domains are
incompatible, it sets -EBUSY but still calls ttm_bo_pin() before
returning.

Callers treat a failed nouveau_bo_pin() as not having acquired a new pin,
so the extra pin count is never decreased by a matching unpin.
This triggers the warning in ttm_bo_release():

	WARN_ON_ONCE(bo->pin_count);

Found when fuzzing the nouveau driver with a modified Syzkaller:

	WARNING: drivers/gpu/drm/ttm/ttm_bo.c:256 at ttm_bo_release+0x827/0x9e0 drivers/gpu/drm/ttm/ttm_bo.c:256, CPU#1: syz.3.24/2212
	Modules linked in:
	CPU: 1 UID: 0 PID: 2212 Comm: syz.3.24 Not tainted 7.2.0 #24 PREEMPT(lazy) 
	nouveau 0000:01:00.0: gsp:msg fn:103 len:0x40/0x20 res:0x19 resp:0x19
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
	RIP: 0010:ttm_bo_release+0x827/0x9e0 drivers/gpu/drm/ttm/ttm_bo.c:256
	Code: 02 00 0f 85 51 01 00 00 48 8b 7b 08 e8 d2 20 01 00 e9 80 fd ff ff e8 d8 15 c0 fe 90 0f 0b 90 e9 e1 f8 ff ff e8 ca 15 c0 fe 90 <0f> 0b 90 e9 a4 f8 ff ff e8 bc 15 c0 fe be 03 00 00 00 4c 89 e7 e8
	msg: 00000000: 05 00 d0 c1 04 00 f0 f1 01 30 00 00 2d 90 00 00  .........0..-...
	RSP: 0018:ffffc9000f5cf710 EFLAGS: 00010293
	RAX: 0000000000000000 RBX: ffff888018e5d2a8 RCX: ffffffff82bb1b36
	RDX: ffff888017b68000 RSI: 0000000000000004 RDI: ffff888018e5d2a8
	msg: 00000010: 19 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	RBP: ffff88801261c720 R08: 0000000000000001 R09: ffffed10031cba55
	R10: ffff888018e5d2ab R11: 00000000000000f3 R12: ffff888018e5d290
	R13: ffff888018e5d2d4 R14: ffff88801b219c18 R15: dffffc0000000000
	FS:  0000000000000000(0000) GS:ffff8880e0f6f000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 0000001b31223ffc CR3: 0000000028e00005 CR4: 0000000000770ef0
	PKRU: 80000000
	Call Trace:
	<TASK>
	kref_put include/linux/kref.h:65 [inline]
	ttm_bo_put drivers/gpu/drm/ttm/ttm_bo.c:325 [inline]
	ttm_bo_fini+0x55/0x80 drivers/gpu/drm/ttm/ttm_bo.c:330
	nouveau_gem_object_del+0xb2/0x1b0 drivers/gpu/drm/nouveau/nouveau_gem.c:90
	drm_gem_object_free+0x5f/0x90 drivers/gpu/drm/drm_gem.c:1165
	kref_put include/linux/kref.h:65 [inline]
	__drm_gem_object_put include/drm/drm_gem.h:562 [inline]
	drm_gem_object_put include/drm/drm_gem.h:575 [inline]
	nouveau_abi16_chan_fini.constprop.0+0x44f/0x5a0 drivers/gpu/drm/nouveau/nouveau_abi16.c:195
	nouveau 0000:01:00.0: syz.2.23[2209]: Unknown handle 0x00000000
	nouveau_abi16_fini+0x1d0/0x340 drivers/gpu/drm/nouveau/nouveau_abi16.c:225
	nouveau_drm_postclose+0x18b/0x3e0 drivers/gpu/drm/nouveau/nouveau_drm.c:1284
	nouveau 0000:01:00.0: syz.2.23[2209]: validate_init
	drm_file_free.part.0+0x6d6/0xb60 drivers/gpu/drm/drm_file.c:267
	drm_file_free drivers/gpu/drm/drm_file.c:237 [inline]
	drm_close_helper.isra.0+0x11a/0x160 drivers/gpu/drm/drm_file.c:290
	drm_release+0x1ab/0x330 drivers/gpu/drm/drm_file.c:438
	__fput+0x39c/0xa60 fs/file_table.c:512
	nouveau 0000:01:00.0: syz.2.23[2209]: validate: -2
	task_work_run+0x15a/0x230 kernel/task_work.c:233
	exit_task_work include/linux/task_work.h:40 [inline]
	do_exit+0x82b/0x25a0 kernel/exit.c:1009
	do_group_exit+0xc2/0x280 kernel/exit.c:1152
	get_signal+0x1d6e/0x1f30 kernel/signal.c:3046
	arch_do_signal_or_restart+0x7d/0x6e0 arch/x86/kernel/signal.c:337
	__exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
	exit_to_user_mode_loop+0xdf/0x440 kernel/entry/common.c:101
	__exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
	syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
	syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
	do_syscall_64+0x4f8/0x690 arch/x86/entry/syscall_64.c:100
	entry_SYSCALL_64_after_hwframe+0x77/0x7f
	RIP: 0033:0x7f12bac8594d
	Code: Unable to access opcode bytes at 0x7f12bac85923.
	RSP: 002b:00007f12b96e70d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
	RAX: 0000000000000001 RBX: 00007f12baf15fa8 RCX: 00007f12bac8594d
	RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f12baf15fac
	RBP: 00007f12baf15fa0 R08: 00007f12baee8000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
	R13: 00007f12baf16038 R14: 0000000000000006 R15: 00007ffe2ed394b0
	</TASK>
	irq event stamp: 47867
	hardirqs last  enabled at (47883): [<ffffffff815cafc6>] __up_console_sem+0x66/0x70 kernel/printk/printk.c:347
	hardirqs last disabled at (47892): [<ffffffff815cafab>] __up_console_sem+0x4b/0x70 kernel/printk/printk.c:345
	softirqs last  enabled at (47880): [<ffffffff81434277>] __do_softirq kernel/softirq.c:656 [inline]
	softirqs last  enabled at (47880): [<ffffffff81434277>] invoke_softirq kernel/softirq.c:496 [inline]
	softirqs last  enabled at (47880): [<ffffffff81434277>] __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
	softirqs last disabled at (47875): [<ffffffff81434277>] __do_softirq kernel/softirq.c:656 [inline]
	softirqs last disabled at (47875): [<ffffffff81434277>] invoke_softirq kernel/softirq.c:496 [inline]
	softirqs last disabled at (47875): [<ffffffff81434277>] __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735

Fix by going to the out path as soon as the incompatible placement
is detected. This matches the correct bahaviour in other DRM drivers
such as amdgpu_bo_pin() in amdgpu.

Cc: stable@vger.kernel.org
Fixes: ad76b3f7c7a0 ("drm/nouveau: teach nouveau_bo_pin() how to force a contig vram allocation")
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 0e8de6d4b36f..bdd0390b590e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -578,6 +578,7 @@ int nouveau_bo_pin_locked(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
 				      "0x%08x vs 0x%08x\n", bo,
 				 bo->resource->mem_type, domain);
 			ret = -EBUSY;
+			goto out;
 		}
 		ttm_bo_pin(&nvbo->bo);
 		goto out;

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.43.0
