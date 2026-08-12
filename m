Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DD6C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401B110F25B;
	Thu, 13 Aug 2026 09:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="XAnu6obF";
	dkim-atps=neutral
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86BD10E331;
 Wed, 12 Aug 2026 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786558469; bh=MD1tjg36c3OeZ9hDq0F6/eietHx/Pou6c3Od0JphNqw=;
 h=Date:To:Cc:From:Subject;
 b=XAnu6obF+WROv4wZcRuGywXs7YjGZDxHJpYjvkm0bfBjcy3UF7MXVnxzYTy59KA/L
 lYeVxnVLGFVJ9uqqmtTgRJr+7KZJCZtI/hvbf4uMPXGsf+/0wmCuwMk+9kWrxPBB8H
 79ZcJmE+vKbL3wum+T3bFunhmsPo4/4fvGqCVCOQ=
Received: from [IPV6:2409:8a00:7894:a160:585d:605d:694d:91cf]
 ([2409:8a00:7894:a160:585d:605d:694d:91cf])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 34A97EC5; Thu, 13 Aug 2026 02:13:10 +0800
X-QQ-mid: xmsmtpt1786558390tpe6y633z
Message-ID: <tencent_7F7A79BF9FCDCFA0A6CE645F7B0D8A71870A@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7iIfk7wHMrsd30dW8I71YlAxkWwUPKckb2f7LhJ5Lts8uuuNeqJ
 mGst7R9V0kr89RTq86LxC5DaxrwgsSfOYOQy3HPOF3eG/JJhVt9rK1IcJPe2x2fPztKc8eQZgmyc
 cc7HegRfG6kwYgeIiVRUU82eoyPVNY2av/5O24/wWCTclKAX9p/uEBTmHbCXhKarwce7X72R4FsX
 y70NbU57c3BYoElNi1RarNdZYXYWw05qyZheAalb0Li4JxspUAAQl9YMRqINRZ1z0ccJEhZUCXN6
 vfdAW5Qyuv8DWyi2fpnZZuxxv/xZp+tz7rSSZjdPmvvtm++Gd56nPnYUUqzANA1lv2m3OqwIIhOL
 F5+NKAmdmdEbn/hpGPf7LuLBCb2o4nKTciaBEXhFpVDB0IiBXGjMvD4rpjZZzg9RUwCSiaA38ZTf
 Tut7Fc7CLmD4OGUu+bY0DRTqnmtDO4HGadwuDftGm8vXtzwyyKh8GGZHp6n6DcoozNQeiJ75wNrE
 TnhbwGM/rKJrMp2eqaZpIL8RLgHqpPDLDdZ2oZGu+B5miodzQTUYS3o8ai2SL/zmHj0qWNWI5A9Z
 wp1+eXbGNErhr66OxatAggwHhLyxBI3HbiZ01wzLGlbcZMenycJrCF6E0q4RtLfC4RIvck7V9sdB
 aQZtgdXsY03H8IROb+UJjOI77ToJp/AbA+b5FBzXplpd2nVfL0REfd65/nZDBhVqy0AnR5+FZXmO
 7csHKYonSlw+dA2vJNtM6EzUT6xYC6vvqvUAYJ3ibW75O7EgplbjNqfFlZmGpNUQuoDyzWWfy59r
 f8x99UK79oEHQqy14+gi50Ojixa+ER+DT9q+ew+8R7Suy0Yu/FKOI3Jx3m3MfpwVqJKnyDgcFiYF
 GLH8xl+9bYtOTsQ3cGF0d30xbxHR+aQ+yNvPWv7syJwykbkVylK7exczh1yAqLVEOkiU4DkkQhVs
 qQglmEo1jobYsbq4OTgPi1c1S35ET6r9z1i97qKyRMp/B4wWTC5BhsGpdJN17koEeuKsppPNaEDR
 WG9yu1jZdt51+DMo2pj8JiRNZXbnfvak4NoeXcewTPHAgxijVtj9tomMrAus0=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <92443462-90c5-4924-bdb0-ab7340f327ad@qq.com>
Date: Thu, 13 Aug 2026 02:13:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] double fault in amdgpu_discovery_init [amdgpu] [syzkaller]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Hi,

While fuzzing kernel v7.1 with syzkaller, we found a kernel double fault PANIC 
in the amdgpu IP discovery initialization path. The crash was triggered during 
GPU probe on a custom QEMU virtual NAVI14 device.

Kernel PANIC via double fault in `amdgpu_discovery_init()` at
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:635 during IP discovery
table reading. The function triggered a double fault at its entry point
(large stack frame allocation of 0x1358 bytes), causing a PANIC.

The crash occurs at `amdgpu_discovery_init+0x18` — very early in the
function. The trapping instruction is a `call` at offset 0x18, after the
function prologue allocates a large stack frame (`sub $0x1358, %rsp` =
4952 bytes). A double fault at function entry indicates stack corruption
or stack overflow — the large stack allocation may have crossed into an
unmapped guard page, or the stack was already corrupted by anomalous
MMIO responses from the virtual device.

The amdgpu driver's `amdgpu_discovery_init()` function does not validate
the device's IP discovery data sufficiently before proceeding with
stack-intensive operations. The virtual device returned anomalous IP
discovery data, causing memory/stack corruption that led to the double
fault.

- Kernel: 7.1.0 #1 PREEMPT(lazy)
- Hardware: QEMU Standard PC (Q35 + ICH9), virtual NAVI14 (0x1002:0x7340)
- Tainted: G B W O (BAD_PAGE, WARN, OOT_MODULE)

The crash report attached below:

amdgpu 0000:00:05.0: enabling device (0000 -> 0002)
amdgpu 0000:00:05.0: initializing kernel modesetting (NAVI14 0x1002:0x7340 0x1AF4:0x1100 0x00).
amdgpu 0000:00:05.0: register mmio base: 0xFC000000
amdgpu 0000:00:05.0: register mmio size: 33554432
traps: PANIC: double fault, error_code: 0x0
Oops: double fault: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 715 Comm: syz.0.2 Tainted: G    B   W  O        7.1.0 #1 PREEMPT(lazy) 
Tainted: [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:amdgpu_discovery_init+0x18/0x87f0 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:635 [amdgpu]
Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 54 53 48 81 ec 58 13 00 00 48 89 bc 24 08 13 00 00 31 ff <e8> b3 df b8 f6 48 89 84 24 f0 12 00 00 31 ff e8 54 e3 b8 f6 48 89
RSP: 0018:ffff8880600ff710 EFLAGS: 00010246
RAX: 0000000000000001 RBX: ffff8880099860c8 RCX: 0000000000100000
RDX: ffffc90004409000 RSI: 00000000000fffff RDI: 0000000000000000
RBP: ffff888060106d48 R08: 0000000000000000 R09: 0000000000000000
R10: ffff888060106c20 R11: ffffed100c020da4 R12: ffff8880099860c8
R13: ffff888009986078 R14: ffff888009986000 R15: ffff888009986000
FS:  000055557874c500(0000) GS:ffff8880e6a8d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880600ff708 CR3: 00000000694a9000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 amdgpu_driver_load_kms+0x147/0x5c0 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:148 [amdgpu]
 </TASK>
Modules linked in: amdgpu(+) ppp_generic slhc gadgetfs udc_core sit tunnel4 ip_tunnel geneve ip6_udp_tunnel udp_tunnel macsec macvtap tap ipvlan macvlan virt_wifi veth nlmon dummy team bonding tun rfuzzer_device(O) i2c_dev iTCO_wdt intel_pmc_bxt ppdev watchdog vga16fb vgastate parport_pc parport gpu_sched drm_panel_backlight_quirks amdxcp drm_exec drm_suballoc_helper lpc_ich mfd_core drm_ttm_helper bochs mousedev serio_raw tpm_tis tpm_tis_core tpm dm_mod dax dmi_sysfs qemu_fw_cfg virtio_rng kt_runtime(O) uio_pci_kerneltracker_driver(O) [last unloaded: amdgpu]
---[ end trace 0000000000000000 ]---
RIP: 0010:amdgpu_discovery_init+0x18/0x87f0 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:635 [amdgpu]
Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 54 53 48 81 ec 58 13 00 00 48 89 bc 24 08 13 00 00 31 ff <e8> b3 df b8 f6 48 89 84 24 f0 12 00 00 31 ff e8 54 e3 b8 f6 48 89
RSP: 0018:ffff8880600ff710 EFLAGS: 00010246
RAX: 0000000000000001 RBX: ffff8880099860c8 RCX: 0000000000100000
RDX: ffffc90004409000 RSI: 00000000000fffff RDI: 0000000000000000
RBP: ffff888060106d48 R08: 0000000000000000 R09: 0000000000000000
R10: ffff888060106c20 R11: ffffed100c020da4 R12: ffff8880099860c8
R13: ffff888009986078 R14: ffff888009986000 R15: ffff888009986000
FS:  000055557874c500(0000) GS:ffff8880e6a8d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880600ff708 CR3: 00000000694a9000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	66 90                	xchg   %ax,%ax
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	41 57                	push   %r15
  14:	41 56                	push   %r14
  16:	41 54                	push   %r12
  18:	53                   	push   %rbx
  19:	48 81 ec 58 13 00 00 	sub    $0x1358,%rsp
  20:	48 89 bc 24 08 13 00 	mov    %rdi,0x1308(%rsp)
  27:	00
  28:	31 ff                	xor    %edi,%edi
* 2a:	e8 b3 df b8 f6       	call   0xf6b8dfe2 <-- trapping instruction
  2f:	48 89 84 24 f0 12 00 	mov    %rax,0x12f0(%rsp)
  36:	00
  37:	31 ff                	xor    %edi,%edi
  39:	e8 54 e3 b8 f6       	call   0xf6b8e392
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

Regards,
Yang Zi

