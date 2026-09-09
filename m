Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E15C88E42
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3547410F3F5;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="CL1IwwRm";
	dkim-atps=neutral
X-Greylist: delayed 19811 seconds by postgrey-1.36 at gabe;
 Wed, 09 Sep 2026 09:12:31 UTC
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EF410E4AF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1788945099;
 bh=yw5NGiijZ5YALpYySw4SpwKyTfmc247roOEcNi54jXw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=CL1IwwRmPvSyVbdVYF0HsVdQv/7lNCSjVHB0pcVKYOKbxgPwh/BNo0W4jcRaGG3V8
 V+LcV44Ou38b/BZSnLJ4JIcsd4QXI3r+s88XK7QU3t1I3y7Ih6VNXYmOA9kQhVqpKK
 24gGtPc7aIsY+3Uifo+aigEhcF10XLCGAj+uYvKU=
X-QQ-mid: zesmtpsz6t1788945079t3aeb69b1
X-QQ-Originating-IP: DI5LWWLOhAhhqOxp8nE4wrAGDVtZXMdzF1lEklLG0UY=
Received: from hepeiyang-vm.wu.lxd ( [114.212.83.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 09 Sep 2026 17:11:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12982179329491539308
EX-QQ-RecipientCnt: 13
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: airlied@redhat.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux.dev, gurchetansingh@chromium.org,
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] drm/virtio: fix NULL pointer dereference on fence allocation
 failure
Date: Wed,  9 Sep 2026 17:11:14 +0800
Message-ID: <00EFE4BA92889B14+20260909091114.2622550-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NUQ4CqobYn8xBItiZjQwrfeljWdt+sZoC7XENQC7wnKYnto9YvRxhuoh
 uhsaKCi53bLoguRSIpRlwXcGylO8lFuZCTK6b548iNjLDL2VUC0RGVeTVXDJEee31m7HBxO
 B19KOmCN3iuh/rJAgNpX/sB82hAUG2X/tyTlbVfa+x3HlAaT/hcKxLPG9XnGrLsG2VwVOuC
 dTlN0VkIUDpWzgXEzZWjrGn/6/UZQ4S8JZTVisJiW6HSYlORISJjgLvpBG37fVjm0tBu+gO
 /iJwkTe6FBmUiZqvortyIe6MTsdp1+ivc4NITuZhREysV1e+SpW789tiwuXTcrDDj9T0bxm
 MNqAsMypnkStCyUv6plD5sgI20XQBVjr8xIB5M3ALlr4KtFPsIJQDj7P95vyvC69TdFwKbT
 d4Gk9yfSvzqktxDb2yGCxOIW9TzA+Ad0ltxIql4Xkm20UhSUMeqU3YlTfxUxCuGWT45PiOw
 i6mDQeqY0ubFUxlCuxhWTnbkBN0geGKOOPR0LOWe60xPHjLppeskAF4/z9rHlGKdNj8HoNr
 8XbVLCWDI9jrSPcaLASlaMclJ8CCxv+Cqi3IxUlCMnfsoY2IbL2ND+58SkiHqS0APTOU6Z6
 f1D3SXLxluMoZrRuA2ElY0XbbqpIGNwTSHMRqhow84Etu/U4c51cLnCYbKtvBX59eX9W8BR
 T6mD5YsHRXWpHOlko7JxPYBs4MClBh4bl/cR7G0cVZcblZiLciJi0p9sBV251MOATa1wb1k
 W7bQF9SRciVZPaj2vKt82XoTgH5QWNo3f8M58vSMsLDQUrkZLnIGCkub9xWBJ0N6uq7Rr1z
 9mvtxJ73YXBilDceAuxA2jFoDGYawoNdxGeLQhlQBjobt+nOLQhpFUyiAiIAfOxT/GcrQH4
 tEnhLkTKH8HrKM0YQnkc39FkBDT7TOcqG/vpgTJ2PRGYJ5uyxC55Ow37nNDjeXaRNgGOU8J
 ycX3QToMqw13f3roA+7wEeLgxCVrSom5+MforXFgbzY6fiJv5dGVbp8xvKY78dIOxIm4Fpb
 tT7Qc1NMEpZHLTSYHlYcYUQpbgHgyiNS9sUWxgDQgKzkb9hMPrDbNO4VXhy4k=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

virtio_gpu_fence_alloc() can fail due to memory pressure and return NULL,
but its caller like virtio_gpu_init_submit() never checks it. Later,
virtio_gpu_init_submit() passes the NULL fence to
virtio_gpu_fence_event_create(), which unconditionally dereferences it.

Found when fuzzing the virtio driver with Syzkaller:

	Oops: general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] SMP KASAN NOPTI
	KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
	CPU: 1 UID: 0 PID: 9991 Comm: syz.0.121 Not tainted 7.2.0 #4 PREEMPT(full) 
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
	RIP: 0010:virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:295 [inline]
	RIP: 0010:virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
	RIP: 0010:virtio_gpu_execbuffer_ioctl+0xc78/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
	Code: 85 ed 0f 85 21 09 00 00 e8 05 5a c9 fb 48 8b 44 24 10 48 8d b8 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9a 0d 00 00 48 8b 44 24 10 4c 89 b0 90 00 00 00
	RSP: 0018:ffffc900039dfad0 EFLAGS: 00010216
	RAX: dffffc0000000000 RBX: ffffc900039dfdd8 RCX: ffffffff85f6fd3d
	RDX: 0000000000000012 RSI: ffffffff85f6fd4b RDI: 0000000000000090
	RBP: 0000000000000000 R0virtio_gpu_virgl_process_cmd: ctrl 0x102, error 0x1203
	R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880132c4000
	R13: 0000000000000000 R14: ffff888073b6c700 R15: 000000000000003b
	FS:  00007fab480b96c0(0000) GS:ffff8880eb6e9000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007effbf5e55a8 CR3: 0000000048d19000 CR4: 0000000000350ef0
	Call Trace:
	<TASK>
	drm_ioctl_kernel+0x1f4/0x3e0 drivers/gpu/drm/drm_ioctl.c:817
	drm_ioctl+0x5f4/0xc70 drivers/gpu/drm/drm_ioctl.c:914
	vfs_ioctl fs/ioctl.c:51 [inline]
	__do_sys_ioctl fs/ioctl.c:597 [inline]
	__se_sys_ioctl fs/ioctl.c:583 [inline]
	__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
	do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
	do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
	entry_SYSCALL_64_after_hwframe+0x77/0x7f
	RIP: 0033:0x7fab471a82bd
	Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
	RSP: 002b:00007fab480b9018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	RAX: ffffffffffffffda RBX: 00007fab47435fa0 RCX: 00007fab471a82bd
	RDX: 00002000000000c0 RSI: 00000000c0406442 RDI: 0000000000000003
	RBP: 00007fab480b9080 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
	R13: 00007fab47436038 R14: 00007fab47435fa0 R15: 00007ffe85ab0740
	</TASK>
	Modules linked in:
	---[ end trace 0000000000000000 ]---
	RIP: 0010:virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:295 [inline]
	RIP: 0010:virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
	RIP: 0010:virtio_gpu_execbuffer_ioctl+0xc78/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
	Code: 85 ed 0f 85 21 09 00 00 e8 05 5a c9 fb 48 8b 44 24 10 48 8d b8 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9a 0d 00 00 48 8b 44 24 10 4c 89 b0 90 00 00 00
	RSP: 0018:ffffc900039dfad0 EFLAGS: 00010216
	RAX: dffffc0000000000 RBX: ffffc900039dfdd8 RCX: ffffffff85f6fd3d
	RDX: 0000000000000012 RSI: ffffffff85f6fd4b RDI: 0000000000000090
	RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880132c4000
	R13: 0000000000000000 R14: ffff888073b6c700 R15: 000000000000003b
	FS:  00007fab480b96c0(0000) GS:ffff888098ae9000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007f24c3759000 CR3: 0000000048d19000 CR4: 0000000000350ef0
	----------------
	Code disassembly (best guess):
	0:	85 ed                	test   %ebp,%ebp
	2:	0f 85 21 09 00 00    	jne    0x929
	8:	e8 05 5a c9 fb       	call   0xfbc95a12
	d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
	12:	48 8d b8 90 00 00 00 	lea    0x90(%rax),%rdi
	19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
	20:	fc ff df
	23:	48 89 fa             	mov    %rdi,%rdx
	26:	48 c1 ea 03          	shr    $0x3,%rdx
	* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
	2e:	0f 85 9a 0d 00 00    	jne    0xdce
	34:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
	39:	4c 89 b0 90 00 00 00 	mov    %r14,0x90(%rax)

Fix by checking virtio_gpu_fence_alloc() in virtio_gpu_init_submit() and
returning -ENOMEM before any later code can dereference the NULL fence.

Fixes: 70d1ace56db6 ("drm/virtio: Conditionally allocate virtio_gpu_fence")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 32cb1e4aa425..857ed5c5f2a8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -389,10 +389,13 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
 	    exbuf->num_out_syncobjs ||
 	    exbuf->num_bo_handles ||
-	    drm_fence_event)
+	    drm_fence_event) {
 		out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
-	else
+		if (!out_fence)
+			return -ENOMEM;
+	} else {
 		out_fence = NULL;
+	}
 
 	if (drm_fence_event) {
 		err = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
-- 
2.43.0
