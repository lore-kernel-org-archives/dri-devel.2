Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73B7CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 17:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E25D10F4F1;
	Thu, 28 May 2026 17:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+U+F4bN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B9510F4F1;
 Thu, 28 May 2026 17:56:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC7376020A;
 Thu, 28 May 2026 17:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CFC1F000E9;
 Thu, 28 May 2026 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779990990;
 bh=AWzYEvXfvyG/WbnGIydi7Wqflso3sQj8/FxrDzygErg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=m+U+F4bNwaRnNIJZzW0bXPbpfEL7vf+9diSh9ffbzJfZEMxfteIzJlW1NBDEWqJgC
 rUROZs7sYCXQ1KWYP2TUQMtgSwqsjvUqBCV3cxiEqsrfvgPgMmxjl7UjJc6x3U3Vgj
 bw7pb7YwUUbvIal6PmdB3csG+F1TNX1hLqoLQHlLnc6khXqfxOErzBoRRoMsSppk/T
 9qnvhZpIzpF2lph3br5l/HkTY+1mqUxCsbQjmtsKJKoso976irCCNp8XKKoEgvOA+r
 w1DC8A05gq20ust8M2CulV7pW/vWjTZOOLx5qxEp7KdebbUCst+HtJwdnA0dfViJQT
 hfo1WcjaUOukQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 19:56:26 +0200
Message-Id: <DIUI56CABZAF.3TU7XCIKTV93R@kernel.org>
Subject: Re: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Cc: "Hongling Zeng" <zenghongling@kylinos.cn>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <airlied@redhat.com>, <ttabi@nvidia.com>, <bskeggs@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <zhongling0719@126.com>
To: <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
 <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
In-Reply-To: <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
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

On Thu May 28, 2026 at 6:41 PM CEST, lyude wrote:
> Will push them to drm-misc in just a moment

[...]

>> =C2=A0 nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage

I think at least this patch has to be reverted, it causes the following oop=
s
probing nouveau on my machine.

I can't currently look into this, but I think Sashiko [1] has a valid point=
 on
this one.

[1] https://sashiko.dev/#/patchset/20260528062451.54107-1-zenghongling%40ky=
linos.cn

May 28 19:49:27 cassiopeiae kernel: BUG: kernel NULL pointer dereference, a=
ddress: 000000000000002c
May 28 19:49:27 cassiopeiae kernel: #PF: supervisor read access in kernel m=
ode
May 28 19:49:27 cassiopeiae kernel: #PF: error_code(0x0000) - not-present p=
age
May 28 19:49:27 cassiopeiae kernel: PGD 0 P4D 0
May 28 19:49:27 cassiopeiae kernel: Oops: Oops: 0000 [#1] SMP NOPTI
May 28 19:49:27 cassiopeiae kernel: CPU: 12 UID: 0 PID: 475 Comm: (udev-wor=
ker) Not tainted 7.1.0-rc5+ #14 PREEMPT(lazy)
May 28 19:49:27 cassiopeiae kernel: Hardware name: ASUS System Product Name=
/TUF GAMING B850-E WIFI, BIOS 1627 02/05/2026
May 28 19:49:27 cassiopeiae kernel: RIP: 0010:r535_gsp_rpc_rm_ctrl_push+0x6=
0/0x110 [nouveau]
May 28 19:49:27 cassiopeiae kernel: Code: 4c 8b 58 08 4c 89 f7 ba 02 00 00 =
00 89 e9 2e 2e 2e 41 ff d3 48 89 c6 48 3d 01 f0 ff ff 72 0b 48 c7 03 00 00 =
00 00 89>
May 28 19:49:27 cassiopeiae kernel: RSP: 0018:ffffd3b38178f250 EFLAGS: 0001=
0213
May 28 19:49:27 cassiopeiae kernel: RAX: 0000000000000020 RBX: ffffd3b38178=
f2a0 RCX: 0000000000000000
May 28 19:49:27 cassiopeiae kernel: RDX: 0000000000000038 RSI: 000000000000=
0020 RDI: ffff8aa9db3339d8
May 28 19:49:27 cassiopeiae kernel: RBP: 0000000000000000 R08: ffffffffbe38=
0560 R09: ffffffffc04c9300
May 28 19:49:27 cassiopeiae kernel: R10: 0000000000000100 R11: ffffffffbd66=
c070 R12: 0000000090f10000
May 28 19:49:27 cassiopeiae kernel: R13: 0000000000000000 R14: ffff8aa9db33=
3000 R15: ffff8aa9e1c2d600
May 28 19:49:27 cassiopeiae kernel: FS:  00007fb0623dc1c0(0000) GS:ffff8ab1=
5f8b9000(0000) knlGS:0000000000000000
May 28 19:49:27 cassiopeiae kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
May 28 19:49:27 cassiopeiae kernel: CR2: 000000000000002c CR3: 000000011efc=
c000 CR4: 0000000000f50ef0
May 28 19:49:27 cassiopeiae kernel: PKRU: 55555554
May 28 19:49:27 cassiopeiae kernel: Call Trace:
May 28 19:49:27 cassiopeiae kernel:  <TASK>
May 28 19:49:27 cassiopeiae kernel:  r535_mmu_vaspace_new+0x1f8/0x520 [nouv=
eau]
May 28 19:49:27 cassiopeiae kernel:  nvkm_uvmm_new+0x1b7/0x210 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  nvkm_ioctl_new+0x22d/0x340 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  ? nvkm_uvmm_search+0x30/0x30 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  nvkm_ioctl+0xf7/0x1f0 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  nvif_object_ctor+0x134/0x2b0 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  ? nvkm_uvmm_search+0x30/0x30 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  ? __kmalloc_noprof+0x205/0x550
May 28 19:49:27 cassiopeiae kernel:  ? nvif_vmm_ctor+0x65/0x280 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  nvif_vmm_ctor+0xe5/0x280 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  nouveau_vmm_init+0x3b/0x50 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  nouveau_cli_init+0x25f/0x450 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  nouveau_drm_device_init+0x69/0x840 [no=
uveau]
May 28 19:49:27 cassiopeiae kernel:  ? pci_bus_read_config_word+0x4b/0x80
May 28 19:49:27 cassiopeiae kernel:  nouveau_drm_probe+0xc7/0x190 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  pci_device_probe+0x1f9/0x300
May 28 19:49:27 cassiopeiae kernel:  really_probe+0x1b8/0x480
May 28 19:49:27 cassiopeiae kernel:  __driver_probe_device+0x9d/0x130
May 28 19:49:27 cassiopeiae kernel:  driver_probe_device+0x1e/0x100
May 28 19:49:27 cassiopeiae kernel:  __driver_attach+0xab/0x210
May 28 19:49:27 cassiopeiae kernel:  ? driver_attach+0x20/0x20
May 28 19:49:27 cassiopeiae kernel:  bus_for_each_dev+0x10b/0x150
May 28 19:49:27 cassiopeiae kernel:  bus_add_driver+0x184/0x2d0
May 28 19:49:27 cassiopeiae kernel:  driver_register+0x61/0xf0
May 28 19:49:27 cassiopeiae kernel:  init_module+0x1bd/0x1000 [nouveau]
May 28 19:49:27 cassiopeiae kernel:  ? cleanup_module+0x2e0/0x2e0 [video]
May 28 19:49:27 cassiopeiae kernel:  do_one_initcall+0x12e/0x350
May 28 19:49:27 cassiopeiae kernel:  ? security_kernfs_init_security+0x58/0=
x130
May 28 19:49:27 cassiopeiae kernel:  ? __kernfs_new_node+0x1be/0x270
May 28 19:49:27 cassiopeiae kernel:  ? security_kernfs_init_security+0x58/0=
x130
May 28 19:49:27 cassiopeiae kernel:  ? __add_to_free_list+0x98/0x170
May 28 19:49:27 cassiopeiae kernel:  ? __free_one_page+0x34c/0x450
May 28 19:49:27 cassiopeiae kernel:  ? free_pcppages_bulk+0x19d/0x270
May 28 19:49:27 cassiopeiae kernel:  ? free_frozen_page_commit+0xaa/0x4b0
May 28 19:49:27 cassiopeiae kernel:  ? __free_frozen_pages+0x29e/0x670
May 28 19:49:27 cassiopeiae kernel:  ? load_module+0x1354/0x14e0
May 28 19:49:27 cassiopeiae kernel:  ? __kmalloc_cache_noprof+0x189/0x420
May 28 19:49:27 cassiopeiae kernel:  do_init_module+0x82/0x270
May 28 19:49:27 cassiopeiae kernel:  __se_sys_finit_module+0x26a/0x3d0
May 28 19:49:27 cassiopeiae kernel:  do_syscall_64+0x12a/0x3b0
May 28 19:49:27 cassiopeiae kernel:  ? vfs_read+0x14d/0x300
May 28 19:49:27 cassiopeiae kernel:  ? __x64_sys_pread64+0x70/0xc0
May 28 19:49:27 cassiopeiae kernel:  ? do_syscall_64+0x165/0x3b0
May 28 19:49:27 cassiopeiae kernel:  ? do_sys_openat2+0x93/0xd0
May 28 19:49:27 cassiopeiae kernel:  ? __x64_sys_openat+0x80/0xa0
May 28 19:49:27 cassiopeiae kernel:  ? do_syscall_64+0x165/0x3b0
May 28 19:49:27 cassiopeiae kernel:  ? __x64_sys_pread64+0x70/0xc0
May 28 19:49:27 cassiopeiae kernel:  ? do_syscall_64+0x165/0x3b0
May 28 19:49:27 cassiopeiae kernel:  ? do_user_addr_fault+0x273/0x6a0
May 28 19:49:27 cassiopeiae kernel:  ? irqentry_exit+0x3f/0x630
May 28 19:49:27 cassiopeiae kernel:  ? do_syscall_64+0xe9/0x3b0
May 28 19:49:27 cassiopeiae kernel:  entry_SYSCALL_64_after_hwframe+0x67/0x=
6f
May 28 19:49:27 cassiopeiae kernel: RIP: 0033:0x7fb062bb26bd
May 28 19:49:27 cassiopeiae kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 =
00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c =
8b 4c 24>
May 28 19:49:27 cassiopeiae kernel: RSP: 002b:00007ffe2bae4d58 EFLAGS: 0000=
0246 ORIG_RAX: 0000000000000139
May 28 19:49:27 cassiopeiae kernel: RAX: ffffffffffffffda RBX: 000055b4032b=
23e0 RCX: 00007fb062bb26bd
May 28 19:49:27 cassiopeiae kernel: RDX: 0000000000000000 RSI: 000055b40343=
4900 RDI: 0000000000000043
May 28 19:49:27 cassiopeiae kernel: RBP: 00007ffe2bae4df0 R08: 000000000000=
0000 R09: 0000000000000000
May 28 19:49:27 cassiopeiae kernel: R10: 0000000000000000 R11: 000000000000=
0246 R12: 000055b403434900
May 28 19:49:27 cassiopeiae kernel: R13: 000055b40340c570 R14: 000000000002=
0000 R15: 000055b403437260
May 28 19:49:27 cassiopeiae kernel:  </TASK>
May 28 19:49:27 cassiopeiae kernel: Modules linked in: nouveau(+) drm_displ=
ay_helper cec gpu_sched drm_gpuvm drm_exec drm_ttm_helper ttm nvme nvme_cor=
e nvme_k>
May 28 19:49:27 cassiopeiae kernel: CR2: 000000000000002c
May 28 19:49:27 cassiopeiae kernel: ---[ end trace 0000000000000000 ]---
May 28 19:49:27 cassiopeiae kernel: RIP: 0010:r535_gsp_rpc_rm_ctrl_push+0x6=
0/0x110 [nouveau]
May 28 19:49:27 cassiopeiae kernel: Code: 4c 8b 58 08 4c 89 f7 ba 02 00 00 =
00 89 e9 2e 2e 2e 41 ff d3 48 89 c6 48 3d 01 f0 ff ff 72 0b 48 c7 03 00 00 =
00 00 89>
May 28 19:49:27 cassiopeiae kernel: RSP: 0018:ffffd3b38178f250 EFLAGS: 0001=
0213
May 28 19:49:27 cassiopeiae kernel: RAX: 0000000000000020 RBX: ffffd3b38178=
f2a0 RCX: 0000000000000000
May 28 19:49:27 cassiopeiae kernel: RDX: 0000000000000038 RSI: 000000000000=
0020 RDI: ffff8aa9db3339d8
May 28 19:49:27 cassiopeiae kernel: RBP: 0000000000000000 R08: ffffffffbe38=
0560 R09: ffffffffc04c9300
May 28 19:49:27 cassiopeiae kernel: R10: 0000000000000100 R11: ffffffffbd66=
c070 R12: 0000000090f10000
May 28 19:49:27 cassiopeiae kernel: R13: 0000000000000000 R14: ffff8aa9db33=
3000 R15: ffff8aa9e1c2d600
May 28 19:49:27 cassiopeiae kernel: FS:  00007fb0623dc1c0(0000) GS:ffff8ab1=
5f8b9000(0000) knlGS:0000000000000000
May 28 19:49:27 cassiopeiae kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
May 28 19:49:27 cassiopeiae kernel: CR2: 000000000000002c CR3: 000000011efc=
c000 CR4: 0000000000f50ef0
May 28 19:49:27 cassiopeiae kernel: PKRU: 55555554
