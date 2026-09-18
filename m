Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D16C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5988A10F212;
	Fri, 18 Sep 2026 07:13:47 +0000 (UTC)
X-Greylist: delayed 363 seconds by postgrey-1.36 at gabe;
 Fri, 18 Sep 2026 01:41:00 UTC
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8205C10E509
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 01:41:00 +0000 (UTC)
Received: from fric.. (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACnfvIrlaxqB_xECA--.11695S2;
 Fri, 18 Sep 2026 09:34:35 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: Huan Yang <link@vivo.com>, Robert Mader <robert.mader@collabora.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] dma-buf/udmabuf: avoid oversized kvmalloc in init_udmabuf()
Date: Fri, 18 Sep 2026 01:34:34 +0000
Message-Id: <20260918013434.1849135-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnfvIrlaxqB_xECA--.11695S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1kKr48GFW7uryxCrWktFb_yoW7Xrykpr
 4aqr4UCr40qF1DA3WUJFn8Jw1UAa1DAFW7W3y7Gr1kZF1UCw1UZFn7Gry8JryDGw1UZay7
 tF1DAw40qr1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F
 4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
 5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw2
 8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
 x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
 CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
 80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1-txDUUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

init_udmabuf() allocates two pointer arrays with one entry per page of
the created buffer.  Since commit 1c0844c6184e ("udmabuf: change folios
array from kmalloc to kvmalloc") these arrays are allocated with
kvmalloc(), which warns and fails when the requested size exceeds
INT_MAX bytes.

With the default size limit of 64 MB the largest possible request was
far below that threshold, but commit 44e9eb5a7621 ("dma-buf/udmabuf:
Disable the size limit by default") raised the limit to INT_MAX MB.
With 4K pages, creating a buffer of more than INT_MAX / 8 pages (about
1 TB of pinned memory) now makes kvmalloc() hit its "crazy size"
WARN_ON_ONCE(), which is trivially triggerable from unprivileged users
through the UDMABUF_CREATE ioctls:

  WARNING: CPU: 0 PID: 412 at mm/slub.c:7021 __kvmalloc_node_noprof
  Call Trace:
   udmabuf_create
   udmabuf_ioctl_create_list

Fix it by rejecting buffers whose page count exceeds what the pointer
arrays can address before calling init_udmabuf(), returning -EINVAL.

Fixes: 1c0844c6184e ("udmabuf: change folios array from kmalloc to kvmalloc")
Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 drivers/dma-buf/udmabuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd00462423..25984e75d7ff3 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -383,6 +383,14 @@ static long udmabuf_create(struct miscdevice *device,
 	if (!pgcnt)
 		goto err_noinit;
 
+	/*
+	 * init_udmabuf() allocates two arrays of pointers, one entry per
+	 * page, with kvmalloc(), which cannot handle sizes larger than
+	 * INT_MAX bytes.
+	 */
+	if (pgcnt > INT_MAX / sizeof(struct page *))
+		goto err_noinit;
+
 	ret = init_udmabuf(ubuf, pgcnt);
 	if (ret)
 		goto err;
-- 
2.34.1


-- 
Below is the crash report:
------------[ cut here ]------------
WARNING: mm/slub.c:7013 at __kvmalloc_node_noprof+0x516/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013, CPU#0: syz.5.27938/167363
Modules linked in:
CPU: 0 UID: 0 PID: 167363 Comm: syz.5.27938 Tainted: G        W    L      7.3.0-rc2 #1 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__kvmalloc_node_noprof+0x516/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013
Code: 05 bf fa 2d 08 49 8b 0f c6 04 08 00 65 48 ff 0d 90 fa 2d 08 0f 85 4c fd ff ff e8 05 43 8c ff e9 42 fd ff ff e8 9b 86 0e 04 90 <0f> 0b 90 31 db e9 d2 fe ff ff f3 0f 1e fa 65 8b 05 8d fa 2d 08 89
RSP: 0018:ffffc90002bc3cf8 EFLAGS: 00010246
RAX: 0000000000000100 RBX: 0000000000000000 RCX: 0000008000000000
RDX: 0000008000000000 RSI: 0000000000000000 RDI: ffffffff835e3226
RBP: 00000000ffffffff R08: 00000000000028c0 R09: 00000000ffffffff
R10: 0000000000000006 R11: 0000000000000002 R12: 0000008000000000
R13: 00000000000028c0 R14: 0000001000000000 R15: 0000008000000000
FS:  00007fc89ae45640(0000) GS:ffff8880f3de4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2ff305 CR3: 000000002b3d4000 CR4: 0000000000752ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000006000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 80000000
Call Trace:
 <TASK>
 init_udmabuf home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:193 [inline]
 udmabuf_create+0x1b6/0x750 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:386
 udmabuf_ioctl_create home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:465 [inline]
 udmabuf_ioctl+0x132/0x1d0 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:496
 vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:51 [inline]
 __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xbc/0x130 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:583
 do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x12b/0x350 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x590d6d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc89ae44fd8 EFLAGS: 00000216 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000611e7f RCX: 0000000000590d6d
RDX: 00002000000023c0 RSI: 0000000040187542 RDI: 000000000000000a
RBP: 00007fc89ae45010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: 00007fc89ae45640
R13: 000000000000000b R14: 0000000000528d40 R15: 00007fc89ae25000
 </TASK>
---[ end trace 0000000000000000 ]---
---

