Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926B3C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DED10EB3C;
	Tue, 22 Sep 2026 08:41:22 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C81C10E0A0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:23:55 +0000 (UTC)
Received: from fric.. (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAD3AkGg2LFqZ79VCA--.18880S2;
 Tue, 22 Sep 2026 09:23:44 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: kraxel@redhat.com, vivek.kasireddy@intel.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com
Cc: robert.mader@collabora.com, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] dma-buf/udmabuf: reinstate a reasonable default size limit
Date: Tue, 22 Sep 2026 01:23:41 +0000
Message-Id: <20260922012341.367268-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3AkGg2LFqZ79VCA--.18880S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw4xZFyDXr45ArW3Gry7GFg_yoWxJrW8pr
 43Wr4UCr40qF1UJF1UJrn8Ar1UAa1UAFWUWrWxGwn7ZF15Cw1UZFn7GrW8tryDG34UZa47
 tF4DAw1Fgr1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr
 1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
 5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw2
 8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
 x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
 CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
 80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUrb18DUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Commit 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
default") raised the default size_limit_mb from 64 to INT_MAX.

With 4 KiB pages on a 64-bit system, creating a buffer larger than
about 1 TiB makes the two per-page pointer arrays in init_udmabuf()
exceed what kvmalloc() can handle.  __kvmalloc_node_noprof() warns and
fails when the requested size exceeds INT_MAX bytes, which is
trivially triggerable by unprivileged users through the UDMABUF_CREATE
ioctls:

  WARNING: CPU: 0 PID: 412 at mm/slub.c:7021 __kvmalloc_node_noprof
  Call Trace:
   udmabuf_create
   udmabuf_ioctl_create_list

Instead of using a fixed megabyte value, derive the default limit from
the kvmalloc() threshold:

  (((INT_MAX / sizeof(struct folio *)) - 1) >> 20) << PAGE_SHIFT

On a 64-bit system with 4 KiB pages, this evaluates to 1044480 MB
(1020 GiB), allowing buffers a little below 1 TiB while keeping the
per-page pointer array allocations below INT_MAX bytes.

Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
Suggested-by: Christian König <christian.koenig@amd.com>
Assisted-by: OpenCode:DeepSeek-V4-Flash
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
V2 -> V3:
- Replace the fixed 256 MB default with a limit derived from the
  kvmalloc() INT_MAX threshold, as suggested by Christian König.  On
  64-bit systems with 4 KiB pages, this allows buffers just below
  1 TiB.

V1 -> V2:
- Instead of adding a pgcnt check in udmabuf_create(), restore a
  reasonable default size limit (256 MB), as suggested by Christian
  König.
- Drop the second Fixes tag; the regression is solely due to
  44e9eb5a7621.
- Drop the "Cc: stable" tag; 44e9eb5a7621 is only in v7.3-rc1 and has
  not shipped in any released kernel yet.

V1: https://lore.kernel.org/all/20260918013434.1849135-1-xujiakai24@mails.ucas.ac.cn/
V2: https://lore.kernel.org/all/20260919015731.2077604-1-xujiakai24@mails.ucas.ac.cn/
---
 drivers/dma-buf/udmabuf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd00462423..7ec269809fb49 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -20,9 +20,10 @@ static int list_limit = 1024;
 module_param(list_limit, int, 0644);
 MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
 
-static int size_limit_mb = INT_MAX;
+static int size_limit_mb = (((INT_MAX / sizeof(struct folio *)) - 1) >> 20) << PAGE_SHIFT;
 module_param(size_limit_mb, int, 0644);
-MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is INT_MAX.");
+MODULE_PARM_DESC(size_limit_mb,
+		 "Max size of a dmabuf, in megabytes. Default is derived from the kvmalloc() limit.");
 
 struct udmabuf {
 	pgoff_t pagecount;
-- 
2.34.1


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

