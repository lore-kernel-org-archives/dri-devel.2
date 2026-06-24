Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD08ACDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F1910F13E;
	Thu, 25 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YwQYtC4+";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010C310F014
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:35:42 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8422a816c89so183899b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782326142; x=1782930942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CkQrwyqUtbEBwCw+6J77RIBxcGN7JfNHmCCOvnM/ljo=;
 b=YwQYtC4+wGcGnHcsR+qZjXN4BzjmaZth6W3sS2G8hoJ3ovuxzabd8KbRmxMAt7tGZR
 cq5z4kTqjyGYYNH013k8cbm1yRDNBdN+/zIhI4cLcS+hD4h9EOCA2wH3HCUjC7El+Oiv
 iKywFtBiVUoNULZGJ6fp6AIlEb4B4Yuf9UyHMCPu4Y78YYUIL7KcgkopZ6C3+fG03HWx
 Z/ykcXWpcSscmm/5/4CK7IMaASA73iBNiGYDI4uw/1pOYnWvP5kk0VC8QxIQPfB+L3ch
 pvMhrBlvIcKOrMMaa1edWAoMDStssfuUoxATW9Re3fs8Zo33yOsAYzSLDwNJpdmQniZZ
 jLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782326142; x=1782930942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkQrwyqUtbEBwCw+6J77RIBxcGN7JfNHmCCOvnM/ljo=;
 b=V5ihgU3hg5f0RhsnpRnTmiKP3cMr1iCg1y8FUjycAvhTKXa2E7OBxMzhzM/26ocp4A
 YBEFUPp2RcxE7M42WVLI0Qbwa/I8ZRMQpoIL5ron/RGVzHjkpEK5gKrZPsIA+MUm1P+y
 P6qwE6B1zSA/yT3qj4ma6kvNrlL2rvEAQGYT8DVZtxVqoDC9Tv2p9RqW20K2/RJf977R
 9sjbzu4USZ2IywyFDVU6R3aReEXavEeREQ3RqFcg97YI7cFmiyCAUZeTwo0+lndOnP9B
 YHP6KwhINJO7E+Y/eHrtfmaJzqzpIqhrQalBTiXK5lEZZnPNndTID8l78KWA2YMxZWu7
 Jq3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6o3QAUuhK5qMOwG8+1MqUQoDrbS52Xi0UUTNKP/3kwTGqDexRUTwMmgn9FhUlXHwgXkveIRgWQ9M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyl6NWYCFkB2vS/v6E83TjBwL+OIYDCKQcCLYvOZ9DzfcvWmDde
 on9EXq9XsX4++iorqS8TGgXiEszVsWO8TuUCX1kVKrpl6R9bDOHIlgXf
X-Gm-Gg: AfdE7cnXj6iv7JozmLGl5bINZSmGFCyHlpVoCCIflZq5h5xWsfg7dPZXrypvLKJAgnr
 4fR4nJ+6rM4rkC/3GTRxEtvuDCXBlufjZTLp6EQ8g+yn8UJQlJwyiZjdQ5PMqb97uu6bA7oKilf
 Zy7G0abBOVLBf5Dtd5aY1jFyjdqszJ0OPH79OZS6vkP28sFk5mOLjKzEcHyN/MGLMJexg2gPt4h
 ErO08nsXC7unZx5zxoiFb9YrVuIPOjI0Zpag3z2J+GYoL2plS6b1Ruqr4AXi1/EJsS1rrR2p3jO
 9xuSWGlNUJsKo4olH3/24xcHLKiXCRnYDWu2ZPxcsQLC9OpYSyBeBcVYFbVdm65WAExL19rWKvp
 52XqYA0m7BnjvmIj909ZM6SVdASsqJzeb3RKjqa4m0gUUNu3SkdAZSrLJXphYcu9Dgv87C5/+pk
 y8ZZ3QLLiZfJO+CqdT
X-Received: by 2002:a17:903:b0e:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2c7bf1a5354mr52776825ad.4.1782326142285; 
 Wed, 24 Jun 2026 11:35:42 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f63b2bd7sm3348575ad.48.2026.06.24.11.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 11:35:41 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] drm/amdgpu/discovery: fix OOB read via unchecked die_offset
 in IP discovery parsing
Date: Wed, 24 Jun 2026 14:34:09 -0400
Message-ID: <20260624183409.1079288-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

Three call sites in amdgpu_discovery.c dereference firmware-controlled
die_offset values without validating them against adev->discovery.size:

  amdgpu_discovery_read_harvest_bit_per_ip() line 776-777
  amdgpu_discovery_sysfs_init()              line 1298-1299
  amdgpu_discovery_reg_base_init()           line 1524-1525

In all three sites the pattern is:

  die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
  dhdr = (struct die_header *)(discovery_bin + die_offset);

die_offset is a firmware-controlled u16 (max 65535). The discovery
binary is allocated as adev->discovery.size bytes (DISCOVERY_TMR_SIZE
= 10240 by default). No bounds check exists between the le16_to_cpu()
call and the pointer cast, so a crafted blob with die_offset >= 10240
produces a pointer past the end of the allocation. The subsequent reads
of dhdr->die_id and dhdr->num_ips are then slab-out-of-bounds reads.

The ip_offset advancement inside the inner loop also uses
struct_size(ip, base_address, ip->num_base_address) where
num_base_address is firmware-controlled, enabling unbounded advancement
past the allocation on each iteration.

ASAN report (kernel 7.1.0+, QEMU/x86_64, nokaslr, slub_debug=FZPUA):

==================================================================
BUG: KASAN: slab-out-of-bounds in poc_init+0x453/0x1000 [amd_oob_harness]
Read of size 2 at addr ffff88800318a801 by task insmod/22

CPU: 0 UID: 0 PID: 22 Comm: insmod Tainted: G           O        7.1.0+ #26 PREEMPTLAZY
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x2b/0x40
 print_report+0x14f/0x4d0
 ? wake_up_klogd_work_func+0x70/0x70
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 kasan_report+0xd4/0x100
 ? poc_init+0x453/0x1000 [amd_oob_harness]
 ? poc_init+0x453/0x1000 [amd_oob_harness]
 poc_init+0x453/0x1000 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 do_one_initcall+0xb0/0x230
 ? initcall_blacklisted+0x150/0x150
 ? kasan_unpoison+0x40/0x60
 do_init_module+0x263/0x810
 ? kasan_save_free_info+0x37/0x50
 ? free_module+0x300/0x300
 ? kfree+0xf1/0x390
 load_module+0x3e12/0x51e0
 ? sysvec_apic_timer_interrupt+0xa/0x80
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? module_frob_arch_sections+0x20/0x20
 ? kernel_read_file+0x4d9/0x790
 ? kernel_read_file+0x36c/0x790
 init_module_from_file+0x136/0x150
 ? __do_sys_init_module+0x180/0x180
 ? do_sys_openat2+0xeb/0x140
 ? fdget+0x64/0x200
 __x64_sys_finit_module+0x39f/0x7a0
 ? __x64_sys_init_module+0xc0/0xc0
 ? __x64_sys_open+0x180/0x180
 do_syscall_64+0x56/0x3f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x4d1259
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb68052f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004d1259
RDX: 0000000000000000 RSI: 000000000a529cf0 RDI: 0000000000000003
RBP: 000000000a529cf0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000a528dd0
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3188
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4000000000000040(head|zone=1)
page_type: f8(unknown)
raw: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000002 ffffea00000c6201 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800318a700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88800318a780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88800318a800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff88800318a880: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff88800318a900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
BUG: KASAN: slab-out-of-bounds in poc_init+0x4b3/0x1000 [amd_oob_harness]
Read of size 2 at addr ffff88800318a803 by task insmod/22

CPU: 0 UID: 0 PID: 22 Comm: insmod Tainted: G    B      O        7.1.0+ #26 PREEMPTLAZY
Tainted: [B]=BAD_PAGE, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x2b/0x40
 print_report+0x14f/0x4d0
 ? add_taint+0x50/0x70
 kasan_report+0xd4/0x100
 ? poc_init+0x4b3/0x1000 [amd_oob_harness]
 ? poc_init+0x4b3/0x1000 [amd_oob_harness]
 poc_init+0x4b3/0x1000 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 ? poc_exit+0xfc0/0xfc0 [amd_oob_harness]
 do_one_initcall+0xb0/0x230
 ? initcall_blacklisted+0x150/0x150
 ? kasan_unpoison+0x40/0x60
 do_init_module+0x263/0x810
 ? kasan_save_free_info+0x37/0x50
 ? free_module+0x300/0x300
 ? kfree+0xf1/0x390
 load_module+0x3e12/0x51e0
 ? sysvec_apic_timer_interrupt+0xa/0x80
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? module_frob_arch_sections+0x20/0x20
 ? kernel_read_file+0x4d9/0x790
 ? kernel_read_file+0x36c/0x790
 init_module_from_file+0x136/0x150
 ? __do_sys_init_module+0x180/0x180
 ? do_sys_openat2+0xeb/0x140
 ? fdget+0x64/0x200
 __x64_sys_finit_module+0x39f/0x7a0
 ? __x64_sys_init_module+0xc0/0xc0
 ? __x64_sys_open+0x180/0x180
 do_syscall_64+0x56/0x3f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x4d1259
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb68052f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000007ffff0 RDI: 0000000000000003
RBP: 000000000a529cf0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000a528dd0
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3188
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4000000000000040(head|zone=1)
page_type: f8(unknown)
raw: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 4000000000000002 ffffea00000c6201 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800318a700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88800318a780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88800318a800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff88800318a880: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff88800318a900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================

Fix by adding a bounds check on die_offset against adev->discovery.size
before the pointer cast in all three sites.

Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binary header")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index be5069642..41ca01e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -774,6 +774,11 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	/* scan harvest bit of all IP data structures */
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
+		if (die_offset + sizeof(*dhdr) > adev->discovery.size) {
+			dev_err(adev->dev, "invalid die_offset %u in harvest table\n",
+				die_offset);
+			return;
+		}
 		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
@@ -1296,6 +1301,11 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 		struct ip_die_entry *ip_die_entry;
 
 		die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
+		if (die_offset + sizeof(*dhdr) > adev->discovery.size) {
+			dev_err(adev->dev, "invalid die_offset %u in sysfs init\n",
+				die_offset);
+			return -EINVAL;
+		}
 		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
@@ -1522,6 +1532,11 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
+		if (die_offset + sizeof(*dhdr) > adev->discovery.size) {
+			dev_err(adev->dev, "invalid die_offset %u in reg base init\n",
+				die_offset);
+			return -EINVAL;
+		}
 		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
-- 
2.53.0

