Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0C9CD98E6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2BE10E03F;
	Fri, 19 Jun 2026 07:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pSfVJyzV";
	dkim-atps=neutral
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D2310E8C8
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 22:26:40 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-966ca733ceaso31737241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781821599; x=1782426399; darn=lists.freedesktop.org;
 h=from:mime-version:content-transfer-encoding:cc:to:subject:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JYGF/DJ+ztKFUQu6cR3gDkiA0lX2QJYHmlkla2UJLN0=;
 b=pSfVJyzVdW7rnq1cGOeRr1KkYk4285H2aRjsMyz/sNOtQuYC5AeDTjNM2kD2mw9rP6
 R9eDj/O9fnj5Vvp+SSFm9iUw+tpZx8ZalMhFongc+ftRHVsJP280z4s7gqmdZubb+6pu
 JMg6EOIic0ChAzy5W6bvxaf2RsrAcqKeDn7dVapWGGeoSF9XcCoe5d2tZdSYGQJ5jkiC
 WTVXKE11S5fQdYDg6XBlgmgfkd8V5+5ofzntWdP7trID2Ndwpdi3FcJ2wBCQM4DiZd1j
 6u574w2dCmMsRr1igkFwhm+wP0igz9iApdnE7vTJjT4UhreOm1A4oVikq/BXWpokaNk6
 TxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781821599; x=1782426399;
 h=from:mime-version:content-transfer-encoding:cc:to:subject:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYGF/DJ+ztKFUQu6cR3gDkiA0lX2QJYHmlkla2UJLN0=;
 b=nTUHEl8B5fRvFV4WEXOnsZQBGdwMO5VXvlJAdXGJ7xMUoELrYAZcWATEsxDVm/js1E
 QjAtQJJJ5deQOaXwgFDz5dMT/rColB9N/uniKIOrii2c5BFiHntY/cV/gutdqeY3tsCI
 AtMIIM5MOIKs2tEyloM7h2KXIoAnkz6yM4P47qv6CLI9Vv9Ss9RP+vGo/fBC2caNLS7Z
 dH7jpVoM/wAbM64970BDONkKKtdZBoLw7dDabK3jgCtObvHhoIDSDGCNsdZfn7W8NaNn
 gsjXBCXByNf5ZfdcjIu1H3r0695lsjvJJaBLm/oCtwI2WSXR85dYTnXR4bbLk9KWMyzZ
 fqZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LwYAAJhGorkEoVib+Fq08BVjbiHnC2UOfniC9hc44TpLzDYQ7vqzYSCKKxGLF3G0E+73NbEY6+F8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyccdCYq+hrl4ftySusbLXgmdKatLUeBGgFy2/DFTsmHKTC3SWQ
 y3nzc2eBM77VjT25lvfd33v/22tDZ67pG576FTEYTSZpO4R4Xcwdh2/9
X-Gm-Gg: AfdE7ckLLHHVn5fIjz0qMn7FbKmEmEhQbjkVvZrkw2+hFEvHkM1tMNF8/ZZmDv38HY5
 61sV3pyOXZgishktyPzCc4cWOO8Mb6Lp3H9/WSEYCUGAP8wPPbrhACPFtyH2rO9kAzB2TcfRGJC
 BlW/t+mQv6zVdRjdHeQC11VE0chcsyqZY/ybuMUtuYj1HmgVvUZivPITgFY6KSBwAGbIOOpBw2r
 FHxeEvig1bQqcfPJHPDjT7YbGEZGKihqXEeI2PesviVIhZ415HFRI6tJ5qEmR9v88VV6L0L285W
 jGRU+uGQ/VLQQF3EBi02iBbnyIG5LfNCkg2vVPi1w9k1Qf0gPtledUFGYtGJJlrQ/FPSxm7IrXJ
 UH8R0x2O9e1Cl1FDm5+DpsF7+tp3OXzxLC2zYhIDegEsoyzzDVyqgPn+1ZN6F0cJVHsPqtmbEI5
 DLI7UNS1rV7bnhDbvBKKHqMkHuzO3LLOvs00FsSIOoOMuLESoibr/q4IyLd4lrqFpFurVSBX5kf
 T2MCf7kn+Mj
X-Received: by 2002:a05:6102:4415:b0:632:509b:e399 with SMTP id
 ada2fe7eead31-72a03b8d80bmr455311137.3.1781821598922; 
 Thu, 18 Jun 2026 15:26:38 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-966fc0f3109sm695984241.0.2026.06.18.15.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 15:26:37 -0700 (PDT)
Message-ID: <6a34709d.0ca26d91.115e9.fdf4@mx.google.com>
Date: Thu, 18 Jun 2026 15:26:37 -0700 (PDT)
Subject: WARNING: at drm_atomic_helper_wait_for_vblanks,
 CPU: kworker/NUM:NUM/NUM
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: sanan.hasanou@gmail.com
X-Mailman-Approved-At: Fri, 19 Jun 2026 07:13:40 +0000
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

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=173DLEAEPKPhhR1TcqofdnkLpdoK7PMFl>
Unfortunately, we don't have any reproducer for this bug yet.
Thank you!

Best regards,
Sanan Hasanov

------------[ cut here ]------------
[CRTC:35:crtc-0] vblank wait timed out
WARNING: at drm_atomic_helper_wait_for_vblanks+0x764/0x8f0 drivers/gpu/drm/drm_atomic_helper.c:1921, CPU#1: kworker/1:1/30
Modules linked in:
CPU: 1 UID: 0 PID: 30 Comm: kworker/1:1 Not tainted 7.0.0-rc1 #1 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:drm_atomic_helper_wait_for_vblanks+0x7b0/0x8f0 drivers/gpu/drm/drm_atomic_helper.c:1921
Code: 45 8b b6 88 00 00 00 4c 8d 68 20 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8 9a 83 f4 fc 49 8b 55 00 4c 89 ff 44 89 f6 <67> 48 0f b9 3a 4d 89 e5 e9 34 ff ff ff 44 89 f1 80 e1 07 80 c1 03
RSP: 0018:ffffc900002075a0 EFLAGS: 00010246
RAX: 1ffff11003a891c3 RBX: dffffc0000000000 RCX: ffff88801330e180
RDX: ffff88801c9712c0 RSI: 0000000000000023 RDI: ffffffff906b49a8
RBP: ffffc900002076e0 R08: ffff88801d478833 R09: 1ffff11003a8f106
R10: dffffc0000000000 R11: ffffed1003a8f107 R12: ffff88801ca0ec28
R13: ffff88801d448e18 R14: 0000000000000023 R15: ffffffff906b49a8
FS:  0000000000000000(0000) GS:ffff8880d99df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000e6ff000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 drm_atomic_helper_commit_tail+0x2d2/0x4e0 drivers/gpu/drm/drm_atomic_helper.c:1997
 commit_tail+0x298/0x3a0 drivers/gpu/drm/drm_atomic_helper.c:2074
 drm_atomic_helper_commit+0xa2e/0xad0 drivers/gpu/drm/drm_atomic_helper.c:2312
 drm_atomic_commit+0x261/0x2c0 drivers/gpu/drm/drm_atomic.c:1775
 drm_atomic_helper_dirtyfb+0xdc0/0xf10 drivers/gpu/drm/drm_damage_helper.c:183
 drm_fbdev_shmem_helper_fb_dirty+0x161/0x2d0 drivers/gpu/drm/drm_fbdev_shmem.c:117
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:248 [inline]
 drm_fb_helper_damage_work+0x296/0x720 drivers/gpu/drm/drm_fb_helper.c:274
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0x811/0xf10 kernel/workqueue.c:3358
 worker_thread+0x9c1/0xeb0 kernel/workqueue.c:3439
 kthread+0x3c1/0x4d0 kernel/kthread.c:467
 ret_from_fork+0x608/0xc40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	45 8b b6 88 00 00 00 	mov    0x88(%r14),%r14d
   7:	4c 8d 68 20          	lea    0x20(%rax),%r13
   b:	4c 89 e8             	mov    %r13,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  16:	74 08                	je     0x20
  18:	4c 89 ef             	mov    %r13,%rdi
  1b:	e8 9a 83 f4 fc       	call   0xfcf483ba
  20:	49 8b 55 00          	mov    0x0(%r13),%rdx
  24:	4c 89 ff             	mov    %r15,%rdi
  27:	44 89 f6             	mov    %r14d,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4d 89 e5             	mov    %r12,%r13
  32:	e9 34 ff ff ff       	jmp    0xffffff6b
  37:	44 89 f1             	mov    %r14d,%ecx
  3a:	80 e1 07             	and    $0x7,%cl
  3d:	80 c1 03             	add    $0x3,%cl

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
