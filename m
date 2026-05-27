Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A943CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677AA10ED14;
	Thu, 28 May 2026 07:29:18 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F4B10E782
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 11:44:15 +0000 (UTC)
Received: from fric.. (unknown [36.110.52.3])
 by APP-03 (Coremail) with SMTP id rQCowACXpMsI2RZqbNWNEg--.9811S2;
 Wed, 27 May 2026 19:44:08 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] drm/atomic-helper: Downgrade vblank wait timeout from WARN to
 drm_warn
Date: Wed, 27 May 2026 11:43:55 +0000
Message-Id: <20260527114355.3681305-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXpMsI2RZqbNWNEg--.9811S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFykury7Gry3ArWkKFWkCrg_yoW7Wry3pr
 4agr9Fkr48Xan8ta9rJ3WxA343Ka17Aa4xt397Jw1fZ3WUAFnrZrnrKrWFq34UJr1UZr4x
 tFnrAwnYkr1DCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
 YxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
 1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
 b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
 vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
 nxnUUI43ZEXa7VUjEoGDUUUUU==
X-Originating-IP: [36.110.52.3]
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:17 +0000
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

When the system is under severe CPU pressure (e.g., SOFTLOCKUP), the
hrtimer-based vblank simulation used by virtual GPU drivers like virtio-gpu
may not fire within the 1000ms timeout. This triggers a WARN that, when
panic_on_warn is set, panics the kernel unnecessarily.

The timeout is not a kernel logic bug — it is a transient system resource
condition.  drm_atomic_helper_wait_for_flip_done() already uses drm_err()
for a similar timeout, so downgrade this WARN to drm_warn() for consistency
and to prevent secondary crashes under system stress.

Fixes: 8d4d0d700dda ("drm/atomic-helper: Print an error if vblank wait times out")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 drivers/gpu/drm/drm_atomic_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 51f39edc31ed..7cad7aa4dd2e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1918,8 +1918,9 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 						drm_crtc_vblank_count(crtc),
 					 msecs_to_jiffies(1000));
 
-		WARN(!ret, "[CRTC:%d:%s] vblank wait timed out\n",
-		     crtc->base.id, crtc->name);
+		if (!ret)
+			drm_warn(dev, "[CRTC:%d:%s] vblank wait timed out\n",
+				 crtc->base.id, crtc->name);
 
 		drm_crtc_vblank_put(crtc);
 	}
-- 
2.34.1

Found by fuzzing. Here is the report:

------------[ cut here ]------------
[CRTC:35:crtc-0] vblank wait timed out
WARNING: drivers/gpu/drm/drm_atomic_helper.c:1922 at drm_atomic_helper_wait_for_vblanks+0x39a/0x3f0 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_atomic_helper.c:1921, CPU#0: kworker/0:0/80597
Modules linked in:
CPU: 0 UID: 0 PID: 80597 Comm: kworker/0:0 Tainted: G             L      7.0.10 #2 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:drm_atomic_helper_wait_for_vblanks+0x3a5/0x3f0 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_atomic_helper.c:1921
Code: f0 02 00 00 48 39 c5 7d 28 e8 47 7f 6c fe e9 b2 fd ff ff e8 3d 7f 6c fe 48 8d 3d 56 41 7f 04 41 8b 75 60 4c 89 eb 49 8b 55 20 <67> 48 0f b9 3a eb b3 e8 1f 7f 6c fe eb 05 e8 18 7f 6c fe 48 8d 05
RSP: 0018:ffa000000e817b40 EFLAGS: 00010293
RAX: ffffffff82faa093 RBX: ff1100000d5cebc8 RCX: ff11000018d39840
RDX: ff1100000d2ca830 RSI: 0000000000000023 RDI: ffffffff8779e1f0
RBP: 0000000000000000 R08: ffffffff82faa052 R09: 0000027b3c832418
R10: 0000027b3c832418 R11: 0000000000000000 R12: ff1100000a8f3230
R13: ff1100000d5cebc8 R14: ff11000018207300 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff110000f40c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000071ad60 CR3: 0000000060bac000 CR4: 0000000000751ef0
PKRU: 55555554
Call Trace:
 <TASK>
 drm_atomic_helper_commit_tail+0x132/0x1e0 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_atomic_helper.c:1997
 commit_tail+0x11d/0x210 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_atomic_helper.c:2074
 drm_atomic_helper_commit+0x3d5/0x3e0 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_atomic_helper.c:2312
 drm_atomic_commit+0x148/0x170 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_atomic.c:1782
 drm_atomic_helper_dirtyfb+0x32b/0x440 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_damage_helper.c:183
 drm_fbdev_shmem_helper_fb_dirty+0x6f/0x120 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_fbdev_shmem.c:117
 drm_fb_helper_fb_dirty home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_fb_helper.c:248 [inline]
 drm_fb_helper_damage_work+0xcf/0x1e0 home/zzzrrll/tmp/linux-7.0.10/drivers/gpu/drm/drm_fb_helper.c:274
 process_one_work home/zzzrrll/tmp/linux-7.0.10/kernel/workqueue.c:3289 [inline]
 process_scheduled_works+0x2f8/0x6b0 home/zzzrrll/tmp/linux-7.0.10/kernel/workqueue.c:3372
 worker_thread+0x318/0x480 home/zzzrrll/tmp/linux-7.0.10/kernel/workqueue.c:3453
 kthread+0x18d/0x1e0 home/zzzrrll/tmp/linux-7.0.10/kernel/kthread.c:436
 ret_from_fork+0x19f/0x480 home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 home/zzzrrll/tmp/linux-7.0.10/arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	48 39 c5             	cmp    %rax,%rbp
   5:	7d 28                	jge    0x2f
   7:	e8 47 7f 6c fe       	call   0xfe6c7f53
   c:	e9 b2 fd ff ff       	jmp    0xfffffdc3
  11:	e8 3d 7f 6c fe       	call   0xfe6c7f53
  16:	48 8d 3d 56 41 7f 04 	lea    0x47f4156(%rip),%rdi        # 0x47f4173
  1d:	41 8b 75 60          	mov    0x60(%r13),%esi
  21:	4c 89 eb             	mov    %r13,%rbx
  24:	49 8b 55 20          	mov    0x20(%r13),%rdx
* 28:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2d:	eb b3                	jmp    0xffffffe2
  2f:	e8 1f 7f 6c fe       	call   0xfe6c7f53
  34:	eb 05                	jmp    0x3b
  36:	e8 18 7f 6c fe       	call   0xfe6c7f53
  3b:	48                   	rex.W
  3c:	8d                   	.byte 0x8d
  3d:	05                   	.byte 0x5

