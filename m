Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A41C43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E095F10E5E4;
	Sun, 28 Jun 2026 11:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2XOgRgz";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D472E10E40C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 21:27:46 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5bd7b57681dso33554e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782509265; x=1783114065; darn=lists.freedesktop.org;
 h=from:mime-version:content-transfer-encoding:content-type:cc:to
 :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JhEjhwL+jQ4Iz3mS5isW4pwmQKPEnci1RgB8Xi6Ae8o=;
 b=F2XOgRgz6fwhK20PKN3T16qU0vNqzEPJHsocLzkei3MNKFX3bP0yyg8saH32ZO4vtV
 jTGGORysL013mZ9JgQ/2/ifxNdloau2xeH+7OpW93NGXcv2PhIABAbsTsRKsxeUOUTT1
 krBpo1yFgCLhwQ00vA8PUknDOT66wc4Ok+2Nq7U3VR/+RWb1h0ShRtJzBELs84w0/lmJ
 C+YVUAeF/n9hfhdZ7InJg5A4W+sEQYeynqPN0Z3XROG0vkYIwpjnPyo+F6PMSsx9mQs8
 beh+qMZ5rr+5qMD5chqL/n+hTg21epuW1/cc4DJVSmwQ/HD4eJJj6bRZz8R5RqSPYeij
 Zmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782509265; x=1783114065;
 h=from:mime-version:content-transfer-encoding:content-type:cc:to
 :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JhEjhwL+jQ4Iz3mS5isW4pwmQKPEnci1RgB8Xi6Ae8o=;
 b=By6JRhsZuzBnanRbnM3IOkmVA9BjIRGb14rz+5uciTMlDsPVRBgaTI0iAx0TNBxrIh
 Mnaw0yYpQgaDfhnkdz24xrtrYZZgMX3DhQuRvBWX3vtaoMTpDxZzXYkFma/bw/XS8wH/
 oEsJH57fBKBDoPwqTie8uzqBeKSmlEbybI2gA0Q0HoaXHXUP2Scj1+EBvsCGOtEekE7R
 OJ3gh15Th6tz4rsZ6+iUtz9KfnPxttP3fYT+Z+8j5HKbS/vzDz/Wk/+sw4FygOLNLdIH
 FcGxGAB3OtQRYdBAPS/D1Oz5L1/PnLTvJ75SCNkOPrWjOMXlKTGJXLF+y7VkQ5dEA4As
 FqGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+l+oU1kESVodWur1NozxUhFt1AGzhky/uDqYgXzsIqz7hovkwvUgA3rkVZiShDkHpHE0lAo6RWXg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUlWvBloOnDPXNLUn0THC9nFYlSzAwVCwYCLMi0G8J4nlzhufL
 tCqKbtpfqvFBrULlLFBdypuykR19j2I7HerE5MuOk8MmyP1iLBpztNJC
X-Gm-Gg: AfdE7cnB1CA0GVx8JYfVRf/ZvXdfMHjnATtZsQ7sCUdmexAlDz7i63h8MqQReVE1HrN
 C94gINevJIutB7P9xx2VodRjQ0dio9nxgVQBIOI3jGLxGrl5e/LS2p3Hb5KFBZI4fwyRg48ERZe
 nIkxC9tHtsPIAhyyZYduhKJXUBZbM6VB5sESZ2Br9M09wTPuBCKFRdEju4R32Gw+75d6xSzg/fQ
 g226SgBoA/G0D7NLzevxHzcRwKz3j2U2cDgS1k1bAqBI9bl5N/RhQng/yizjOS3S7ssM9nfk9Zn
 uoMhNT87y+f5c3p9mPgRwsArtG1S61rQ3hZg6MPd8vK+pt/eFrEih0XPiCg0mGGln0+NUBBPwVD
 wNRcy6EhPU2xNWEquPPDVY5KaFkX3fLjufV3HLhHw7FerG3A9l03GjnSyjwenIUmX0dE48EmM0B
 6uUoWx0H3UJqVf6vr/Ko1BIUmhQMLC9/M1T1iBiajrnBNwWFA9A00Vjk6hmekX1px6J8Atj5o+T
 bqpZYTSRoDs
X-Received: by 2002:a05:6102:2b94:b0:631:4d32:a86 with SMTP id
 ada2fe7eead31-73436af6676mr1414142137.7.1782509265547; 
 Fri, 26 Jun 2026 14:27:45 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-969220da94asm1123830241.1.2026.06.26.14.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 14:27:45 -0700 (PDT)
Message-ID: <6a3eeed1.ce05d057.35d38.3011@mx.google.com>
Date: Fri, 26 Jun 2026 14:27:45 -0700 (PDT)
Subject: WARNING in drm_atomic_helper_wait_for_vblanks
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: sanan.hasanou@gmail.com
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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
Kernel Config: <https://drive.google.com/open?id=1zJHAs5GUroGFBkxAlzfDaWAd_NVPZTfJ>
Unfortunately, we don't have any reproducer for this bug yet.
Thank you!

Best regards,
Sanan Hasanov

------------[ cut here ]------------
[CRTC:35:crtc-0] vblank wait timed out
WARNING: drivers/gpu/drm/drm_atomic_helper.c:1922 at drm_atomic_helper_wait_for_vblanks+0x75f/0x8e0 drivers/gpu/drm/drm_atomic_helper.c:1921, CPU#0: kworker/0:0/9
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 7.0.0-rc1 #1 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:drm_atomic_helper_wait_for_vblanks+0x7ab/0x8e0 drivers/gpu/drm/drm_atomic_helper.c:1921
Code: 45 8b b6 d8 00 00 00 4c 8d 68 20 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8 0f fc e2 fc 49 8b 55 00 4c 89 ff 44 89 f6 <67> 48 0f b9 3a 4d 89 e5 e9 34 ff ff ff 44 89 f1 80 e1 07 80 c1 03
RSP: 0018:ffffc900001af420 EFLAGS: 00010246
RAX: 1ffff11003d97a68 RBX: dffffc0000000000 RCX: ffff8880196f5700
RDX: ffff88801f06b6a0 RSI: 0000000000000023 RDI: ffffffff8f996300
RBP: ffffc900001af548 R08: ffffffff8f8dfdb7 R09: 1ffffffff1f1bfb6
R10: dffffc0000000000 R11: fffffbfff1f1bfb7 R12: ffff8880220eb528
R13: ffff88801ecbd340 R14: 0000000000000023 R15: ffffffff8f996300
FS:  0000000000000000(0000) GS:ffff88809c136000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558b4346e5d8 CR3: 000000000dd4a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 drm_atomic_helper_commit_tail+0x302/0x530 drivers/gpu/drm/drm_atomic_helper.c:1997
 commit_tail+0x2a5/0x390 drivers/gpu/drm/drm_atomic_helper.c:2074
 drm_atomic_helper_commit+0xa50/0xaf0 drivers/gpu/drm/drm_atomic_helper.c:2312
 drm_atomic_commit+0x25c/0x2c0 drivers/gpu/drm/drm_atomic.c:1775
 drm_atomic_helper_dirtyfb+0xd7b/0xed0 drivers/gpu/drm/drm_damage_helper.c:183
 drm_fbdev_shmem_helper_fb_dirty+0x175/0x310 drivers/gpu/drm/drm_fbdev_shmem.c:117
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:248 [inline]
 drm_fb_helper_damage_work+0x2a2/0x730 drivers/gpu/drm/drm_fb_helper.c:274
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xae1/0x1800 kernel/workqueue.c:3358
 worker_thread+0xa0f/0xf70 kernel/workqueue.c:3439
 kthread+0x37d/0x470 kernel/kthread.c:467
 ret_from_fork+0x507/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	45 8b b6 d8 00 00 00 	mov    0xd8(%r14),%r14d
   7:	4c 8d 68 20          	lea    0x20(%rax),%r13
   b:	4c 89 e8             	mov    %r13,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  16:	74 08                	je     0x20
  18:	4c 89 ef             	mov    %r13,%rdi
  1b:	e8 0f fc e2 fc       	call   0xfce2fc2f
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
