Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9999C44512
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCC910E069;
	Sun, 19 Jul 2026 17:11:35 +0000 (UTC)
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com
 [209.85.160.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F6F10E065
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 17:11:34 +0000 (UTC)
Received: by mail-oa1-f78.google.com with SMTP id
 586e51a60fabf-456cde91306so1603974fac.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 10:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784481094; x=1785085894;
 h=content-transfer-encoding:content-type:to:from:subject:message-id
 :date:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8BQcefzpD21oTep1ua4pACn1Zh/JefrOarGjSiHQSZU=;
 b=Z30TNeiVCXLsmXBRhqoNa+mqaGfx/YyodFrFRrxP0JWg+5JVwueFSQodKYt/CJ0qkb
 EgO6Kyxl9GCTholLYGi7ForKDkN7DLFgOEZgx9/42yHskRVSwCDt9FzlA4dQqcxHVrPj
 HvxoBlyhMl8qdVWesEHbWNc29L520h7wWB9vgGzsQu5aeXwHE4x7RweN1vbXEq5OcHIe
 wzeo19pvPnmJlp7TXcQ3VeOXaf4p6Ut6vcY9WS5DOEMB+PJmU1lDWaWJpCso4IvT6cPC
 PfCm6sVA1CLX2T+5tKRUHTi7iDSoj3QH65+m0EKmguwryHXybpTwGfZfJu0Xb0fAa0oe
 LzTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBl39/dZjt+9wlU7C4aMR8q4mxM5Bho9ceN3ryFmhxP0778hZ2bBtBMYS2f57tCid1nIWvoqgXNyg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5a4gM7mF3ZBcRus68AEk3En7Egr16CjbHxEccM69Fglo+J28W
 8+XZa9tYDkFXVnd2N4qS65/cCzS8i8N6AWBH2OSuy9j/exumHGK/8fiv6MgTRBKPPqrrW68KB73
 14pPp722O9eLkXKLYFMjNXZowZbGsoge4WjFh3wvfnNQWXp2EiKQqYK9WlYQ=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6f8d:b0:497:df42:1dee with SMTP id
 5614622812f47-4a4d040ef1emr6595795b6e.35.1784481093959; Sun, 19 Jul 2026
 10:11:33 -0700 (PDT)
Date: Sun, 19 Jul 2026 10:11:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5d0545.5028b7d0.1f0bb.0246.GAE@google.com>
Subject: [syzbot] [dri?] linux-next test error: WARNING in
 drm_mode_config_validate
From: syzbot <syzbot+6245cb95ae707991bffa@syzkaller.appspotmail.com>
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org, 
 linux-next@vger.kernel.org, louis.chauvet@bootlin.com, 
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com, mripard@kernel.org, 
 sfr@canb.auug.org.au, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
 tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

syzbot found the following issue on:

HEAD commit:    0718283ab28b Add linux-next specific files for 20260717
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16351c32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2f6d4fd2982f997=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D6245cb95ae707991b=
ffa
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-=
1~exp1~20260613092250.77), Debian LLD 22.1.8

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/83fbf4236ddb/disk-=
0718283a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53d15a8f3db7/vmlinux-=
0718283a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d826bc7a4a27/bzI=
mage-0718283a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+6245cb95ae707991bffa@syzkaller.appspotmail.com

smbdirect: subsystem loaded
Key type cifs.spnego registered
Key type cifs.idmap registered
ntfs3: Enabled Linux POSIX ACLs support
ntfs3: Read-only LZX/Xpress compression included
jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
QNX4 filesystem 0.2.3 registered.
qnx6: QNX6 filesystem 1.0.0 registered.
fuse: init (API version 7.45)
orangefs_debugfs_init: called with debug mask: :none: :0:
orangefs_init: module version upstream loaded
JFS: nTxBlock =3D 8192, nTxLock =3D 65536
SGI XFS with ACLs, security attributes, realtime, scrub, repair, quota, no =
debug enabled
9p: Installing v9fs 9p2000 file system support
NILFS version 2 loaded
befs: version: 0.9.3
ocfs2: Registered cluster interface o2cb
ocfs2: Registered cluster interface user
OCFS2 User DLM kernel interface loaded
gfs2: GFS2 installed
ceph: loaded (mds proto 32)
NET: Registered PF_ALG protocol family
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
raid6: skipped pq benchmark and selected avx2x4
input: Power Button as /devices/platform/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/platform/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
N_HDLC line discipline registered with maxframe=3D4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:02: ttyS0 I/O:0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
00:03: ttyS1 I/O:0x2f8 (irq =3D 3, base_baud =3D 115200) is a 16550A
00:04: ttyS2 I/O:0x3e8 (irq =3D 6, base_baud =3D 115200) is a 16550A
00:05: ttyS3 I/O:0x2e8 (irq =3D 7, base_baud =3D 115200) is a 16550A
Non-volatile memory driver v1.3
usbcore: registered new interface driver xillyusb
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 for vgem on minor 0
------------[ cut here ]------------
[PLANE:35:plane-0] pixel format with alpha exposed but blend mode not setup
WARNING: drivers/gpu/drm/drm_mode_config.c:873 at validate_blend_mode_for_a=
lpha_formats drivers/gpu/drm/drm_mode_config.c:872 [inline], CPU#0: swapper=
/0/1
WARNING: drivers/gpu/drm/drm_mode_config.c:873 at drm_mode_config_validate+=
0x1c6a/0x1e60 drivers/gpu/drm/drm_mode_config.c:938, CPU#0: swapper/0/1
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full)=
=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 06/25/2026
RIP: 0010:validate_blend_mode_for_alpha_formats drivers/gpu/drm/drm_mode_co=
nfig.c:872 [inline]
RIP: 0010:drm_mode_config_validate+0x1cab/0x1e60 drivers/gpu/drm/drm_mode_c=
onfig.c:938
Code: 0f 85 ae 00 00 00 4d 8d 77 10 8b 6d 00 4c 89 f0 48 c1 e8 03 80 3c 18 =
00 74 08 4c 89 f7 e8 4d 08 a9 fc 49 8b 16 4c 89 ef 89 ee <67> 48 0f b9 3a e=
b 05 e8 39 fe 3a fc 49 bd 00 00 00 00 00 fc ff df
RSP: 0000:ffffc90000067810 EFLAGS: 00010246
RAX: 1ffff11004d63408 RBX: dffffc0000000000 RCX: ffff88801daeddc0
RDX: ffff8880268100e0 RSI: 0000000000000023 RDI: ffffffff9063bf50
RBP: 0000000000000023 R08: ffff888023a4e3ab R09: 1ffff11004749c75
R10: dffffc0000000000 R11: ffffed1004749c76 R12: dffffc0000000000
R13: ffffffff9063bf50 R14: ffff888026b1a040 R15: ffff888026b1a030
FS:  0000000000000000(0000) GS:ffff888124f37000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e946000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 drm_dev_register+0x7c/0xd80 drivers/gpu/drm/drm_drv.c:1075
 vkms_create+0x40d/0x4f0 drivers/gpu/drm/vkms/vkms_drv.c:208
 vkms_init+0x57/0x80 drivers/gpu/drm/vkms/vkms_drv.c:240
 do_one_initcall+0x250/0x870 init/main.c:1357
 do_initcall_level+0x10a/0x1a0 init/main.c:1419
 do_initcalls+0x59/0xa0 init/main.c:1435
 kernel_init_freeable+0x29d/0x3e0 init/main.c:1670
 kernel_init+0x22/0x1d0 init/main.c:1560
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f 85 ae 00 00 00    	jne    0xb4
   6:	4d 8d 77 10          	lea    0x10(%r15),%r14
   a:	8b 6d 00             	mov    0x0(%rbp),%ebp
   d:	4c 89 f0             	mov    %r14,%rax
  10:	48 c1 e8 03          	shr    $0x3,%rax
  14:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  18:	74 08                	je     0x22
  1a:	4c 89 f7             	mov    %r14,%rdi
  1d:	e8 4d 08 a9 fc       	call   0xfca9086f
  22:	49 8b 16             	mov    (%r14),%rdx
  25:	4c 89 ef             	mov    %r13,%rdi
  28:	89 ee                	mov    %ebp,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 05                	jmp    0x36
  31:	e8 39 fe 3a fc       	call   0xfc3afe6f
  36:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  3d:	fc ff df


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
