Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E21CD98E6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF6510E07D;
	Fri, 19 Jun 2026 07:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E5vqyN5Q";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6BA10E0D2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 22:24:55 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-9638f63e25cso32821241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781821494; x=1782426294; darn=lists.freedesktop.org;
 h=from:mime-version:content-transfer-encoding:cc:to:subject:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eOXz7fjbCaL1ZPkp7iG/yz8Tvbl1UGW23Kh77o/O4bs=;
 b=E5vqyN5Qnk9vbdfeintsfY9jpN6oinnJw1+UYjgtYP+mHAbS1q+XHVG8dByjdmnLmm
 ZPHWQEwtvmKZIJvzyiHPxc0hsUCxDke0jWsmhZe3ZrOViPxjq1uEnj5wqsHsaYMyQXlT
 d24S8Ko76uDMycUAwktzg9MsJ7okfuzJeX7JVrQwlOnoJHA3G0+Tl5GfYJufAK+rumqs
 G2B/DSPhebHE6m5sHPlVfTAHRpSQm0JoShuq2Xibk02s4lnZwqwYt9KhmAkZI9x7KqDI
 nuD0S7Wk8ePxoYNvCu92b6ONWH3gqbKxiPEEBBcOlbe1D9Z5Uaq97PFWJFnWWUzq+QY1
 kFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781821494; x=1782426294;
 h=from:mime-version:content-transfer-encoding:cc:to:subject:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOXz7fjbCaL1ZPkp7iG/yz8Tvbl1UGW23Kh77o/O4bs=;
 b=l8sPlmyM8HRkds4gv9L2vCxNntm/ps+TtlbEQy8B6bJ68apjry13HFUZZ3RebfvmxC
 dd3SIr0aV2sxYkRZ4I+NGxZHjdGDTTYTnnrc3ipyu0Cx+VkqdJWushQvJOz7HfYAxccw
 80kw8WqW+WaH5TbEk8BTzMJsbrJT6XJ/4EfzeGwJhVA/mZdDjuhXOg0bUg5hxsZIS714
 vDoK8+d2klc3hakFN2Ej/zEEzw/cQEAOd3fOt9R8X5pGdNS7xwuvcUTwWHuC1FchnGP9
 c/vAX8F4t2WPZetc2Z+hD5q8FYb77UxAIYac7KGJHXwCAWjWp+skPYUcIi0oVJp9wrBq
 Zbcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+zZIgC6HQWl2W55Q2xOPlTvCZ2bR9mQUA4ZE6IBiPlcmMp6mV2W9rLZhSJZ3T84WjGBWB64rdSTc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwHuePldkbNGnhchjIcNOkQ9ekXk00PbFnZyFonWU12Xx42OFX
 zObewalx6VFJrTD0vKrDd1xEcquzVlTAT2AwzeqrzI99kpjKjL0Tq5je
X-Gm-Gg: AfdE7ckT9wsN7mLrA6G4FC7SergtJocfLAECkdyp/QsMsqIzkVRpItAO+jieMCppHEL
 KQf9U8OFxV3KUvJ49KnYklmBiSsbGw6GGOn63+h8JMrCa2SRcWk68RekgUzefCobcxUINGBcxAT
 GpfD/MMjqA73Sk46f7qzALhY5TPh45WDqibnNKy/z75rRa6UxPU287mK6587hlXYK+hlfL8OzeO
 hqIQT1iF1ImU5YFEfNoh4ScA2BkVOYbsMvCKoUKOlmjHs/hOLxcLHFTGcqE7m2lSZUnY50kdM5h
 Dgbanmt6D5nzO8MjljVY8fOiNKH+UBZ4ossUtkr0JIqJ9JB0N58/wbAQFNJQiU02+B5pAWiBPpJ
 +mD9HYKTuIvsRwRN09bZZY2J4x3BXa/A7aWKkwXdSliJ77wuSeYCDSouXJSEZta8aR5u2JDuk3V
 TzRmJkQV2VhVY8JqAzOGi0ELSqkBzmYRMwfVfWPM36rgy7gVVwQj9WhMm5r6dntz8eo2pC/X8x4
 KQStf5hefAX
X-Received: by 2002:a05:6102:5093:b0:6d1:8f7:18a5 with SMTP id
 ada2fe7eead31-72a01125388mr439558137.1.1781821494386; 
 Thu, 18 Jun 2026 15:24:54 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bbea0f86dbsm719910e0c.4.2026.06.18.15.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 15:24:53 -0700 (PDT)
Message-ID: <6a347035.4ad61264.c0449.5a8e@mx.google.com>
Date: Thu, 18 Jun 2026 15:24:53 -0700 (PDT)
Subject: WARNING: at drm_crtc_wait_one_vblank, CPU: kworker/NUM:NUM/NUM
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
bochs-drm 0000:00:02.0: [drm] vblank wait timed out on crtc 0
WARNING: at drm_crtc_wait_one_vblank+0x33a/0x4f0 drivers/gpu/drm/drm_vblank.c:1320, CPU#0: kworker/0:1/10
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 7.0.0-rc1 #1 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:drm_crtc_wait_one_vblank+0x4a3/0x4f0 drivers/gpu/drm/drm_vblank.c:1320
Code: 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ef e8 bf ba f8 fc 4d 8b 7d 00 4c 89 e7 48 8b 74 24 18 4c 89 fa 44 89 f1 <67> 48 0f b9 3a 48 8b 7c 24 28 44 89 f6 e8 9b f6 ff ff b8 92 ff ff
RSP: 0018:ffffc900000af9a0 EFLAGS: 00010246
RAX: 1ffff110029ee41a RBX: 1ffff92000015f3c RCX: 0000000000000000
RDX: ffff888014b9b220 RSI: ffffffff8c4a0d60 RDI: ffffffff906b4414
RBP: ffffc900000afaa8 R08: ffff88801d533833 R09: 1ffff11003aa6706
R10: dffffc0000000000 R11: ffffed1003aa6707 R12: ffffffff906b4414
R13: ffff888014f720d0 R14: 0000000000000000 R15: ffff888014b9b220
FS:  0000000000000000(0000) GS:ffff8880d98df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888012801000 CR3: 000000000e6ff000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 drm_client_modeset_wait_for_vblank+0xc7/0xe0 drivers/gpu/drm/drm_client_modeset.c:1330
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:236 [inline]
 drm_fb_helper_damage_work+0x116/0x720 drivers/gpu/drm/drm_fb_helper.c:274
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0x811/0xf10 kernel/workqueue.c:3358
 worker_thread+0x9c1/0xeb0 kernel/workqueue.c:3439
 kthread+0x3c1/0x4d0 kernel/kthread.c:467
 ret_from_fork+0x608/0xc40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
   7:	fc ff df
   a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   e:	74 08                	je     0x18
  10:	4c 89 ef             	mov    %r13,%rdi
  13:	e8 bf ba f8 fc       	call   0xfcf8bad7
  18:	4d 8b 7d 00          	mov    0x0(%r13),%r15
  1c:	4c 89 e7             	mov    %r12,%rdi
  1f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  24:	4c 89 fa             	mov    %r15,%rdx
  27:	44 89 f1             	mov    %r14d,%ecx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
  34:	44 89 f6             	mov    %r14d,%esi
  37:	e8 9b f6 ff ff       	call   0xfffff6d7
  3c:	b8                   	.byte 0xb8
  3d:	92                   	xchg   %eax,%edx
  3e:	ff                   	(bad)
  3f:	ff                   	.byte 0xff

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
