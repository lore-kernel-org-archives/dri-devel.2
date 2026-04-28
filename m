Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B98EFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDBB10E315;
	Tue, 28 Apr 2026 09:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LTZLdpXO";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3710A10E315
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:24:30 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g4Zkz1g7Hz9tnp;
 Tue, 28 Apr 2026 11:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777368267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TTMP7RZYQSvE7ZYrXkH7RaBTwwFHqShFpiVMiGhJqf8=;
 b=LTZLdpXOy0n7/Ll4jmc0UGFfyRFXGGBz0gXKWzMD1u0P1Axd4oUDhc5uvDy2l2xqcXB8y0
 YR/n8OlhMaGL8O2Fl2w0yFXRkUJOa9tl00uAeMd7yFeiSvMEFeIiWWyOpLdEosCGq15G/Y
 WCIaX9PGmCuTJQ4cA6iJ2mpR9B5wDsL9IqqcFxcKhZ11Gh3rcwuz0VxhJSKLP2bOOYSo50
 xIF8gRGGHrOc7JF66FYpFyTt6VGsXtyeR48RHWK5qS6DNM/qaY7oDTgXEMSvegUclPV1XC
 ec26nUY9Xql6bzP2J7v89rpbKJ5U8rsX/TGQzuz8vnzKZPk8ATAo9xkUykZqcQ==
Message-ID: <3fa7759b-0f2c-4acb-9850-90e6078e8a60@mailbox.org>
Date: Tue, 28 Apr 2026 11:24:23 +0200
MIME-Version: 1.0
Content-Language: en-US, de-DE
To: arunpravin.paneerselvam@amd.com
Cc: dri-devel@lists.freedesktop.org
From: Erhard Furtner <erhard_f@mailbox.org>
Subject: gpu_test_buddy_alloc_exceeds_max_order: EXPECTATION FAILED at
 drivers/gpu/tests/gpu_buddy_test.c:1379, Expected err == -22, but, err == 0
 (0x0) (v7.1-rc1, i686)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qqdn4i5hn5jiadhdngdjqouph6prqjy6
X-MBO-RS-ID: 923bcd21f67083f1531
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

Greetings!

Checked out the new gpu_buddy_test on my Thinkpad T60 (Mobility Radeon 
X1300) on kernel v7.1-rc1, where it fails:

[..]
KTAP version 1
1..1
     # gpu_buddy: Testing GPU buddy manager, with random_seed=0xab6907c1
     KTAP version 1
     # Subtest: gpu_buddy
     # module: gpu_buddy_tests
     1..12
     ok 1 gpu_test_buddy_alloc_limit
     ok 2 gpu_test_buddy_alloc_optimistic
     ok 3 gpu_test_buddy_alloc_pessimistic
     ok 4 gpu_test_buddy_alloc_pathological
     ok 5 gpu_test_buddy_alloc_contiguous
     ok 6 gpu_test_buddy_alloc_clear
     ok 7 gpu_test_buddy_alloc_range
     # gpu_test_buddy_alloc_range_bias: mm_size=7340032, ps=1048576
     ok 8 gpu_test_buddy_alloc_range_bias
     # gpu_test_buddy_fragmentation_performance: Fragmented allocation 
took 1477 ms
     # gpu_test_buddy_fragmentation_performance: Reverse-ordered free 
took 619 ms
     # gpu_test_buddy_fragmentation_performance.speed: slow
     ok 9 gpu_test_buddy_fragmentation_performance
     # gpu_test_buddy_alloc_exceeds_max_order: EXPECTATION FAILED at 
drivers/gpu/tests/gpu_buddy_test.c:1379
     Expected err == -22, but
         err == 0 (0x0)
------------[ cut here ]------------
WARNING: drivers/gpu/buddy.c:474 at gpu_buddy_fini+0x10d/0x19c, CPU#0: 
kunit_try_catch/1235
Modules linked in: gpu_buddy_tests kunit gcm libgf128hash ccm algif_aead 
ctr cbc ecb algif_skcipher aes sha3 libsha3 sha512 libsha512 sha1 md5 
libmd5 af_packet radeon iwl3945 iwlegacy snd_hda_intel snd_intel_dspcfg 
thinkpad_acpi mac80211 drm_suballoc_helper drm_ttm_helper snd_hda_codec 
uhci_hcd ttm snd_hwdep i2c_algo_bit ehci_pci nvram drm_exec snd_hda_core 
platform_profile cfg80211 drm_display_helper ehci_hcd snd_pcm 
sparse_keymap libarc4 rfkill acpi_cpufreq video cec libaes wmi thermal 
usbcore snd_timer joydev backlight battery input_leds evdev ac led_class 
processor usb_common button snd soundcore fuse coretemp pkcs8_key_parser 
hwmon configfs
CPU: 0 UID: 0 PID: 1235 Comm: kunit_try_catch Tainted: G 
N  7.1.0-rc1-P3 #1 PREEMPTLAZY
Tainted: [N]=TEST
Hardware name: LENOVO 2007F2G/2007F2G, BIOS 79ETE7WW (2.27 ) 03/21/2011
EIP: gpu_buddy_fini+0x10d/0x19c
Code: e6 0f a5 d0 f6 c1 20 0f 45 c6 b9 00 00 00 00 0f 45 f1 8b 4d e8 29 
f1 8b 55 ec 19 c2 43 3b 5f 08 89 d0 0f 82 15 ff ff ff eb 27 <0f> 0b e9 
02 00 00 00 eb b1 a1 34 33 8f c6 68 b3 84 61 c6 68 da 01
EAX: 00000c00 EBX: 00000000 ECX: 00000c00 EDX: 00000000
ESI: 80000000 EDI: c7f37e9c EBP: c7f37e94 ESP: c7f37e64
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010206
CR0: 80050033 CR2: a8046000 CR3: 07f14000 CR4: 000006f0
Call Trace:
  gpu_test_buddy_alloc_exceeds_max_order+0x1c2/0x2f0 [gpu_buddy_tests]
  kunit_try_run_case+0x70/0x184 [kunit]
  ? _raw_spin_unlock_irqrestore+0xb/0x2c
  kunit_generic_run_threadfn_adapter+0x18/0x2c [kunit]
  kthread+0xd8/0xec
  ? kunit_try_catch_run+0x1cc/0x1cc [kunit]
  ? kthread_blkcg+0x24/0x24
  ? kthread_blkcg+0x24/0x24
  ret_from_fork+0x8f/0x158
  ? kthread_blkcg+0x24/0x24
  ret_from_fork_asm+0x12/0x18
  entry_INT80_32+0xf0/0xf0
---[ end trace 0000000000000000 ]---
     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:474: 
gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
------------[ cut here ]------------
WARNING: drivers/gpu/buddy.c:482 at gpu_buddy_fini+0x174/0x19c, CPU#0: 
kunit_try_catch/1235
Modules linked in: gpu_buddy_tests kunit gcm libgf128hash ccm algif_aead 
ctr cbc ecb algif_skcipher aes sha3 libsha3 sha512 libsha512 sha1 md5 
libmd5 af_packet radeon iwl3945 iwlegacy snd_hda_intel snd_intel_dspcfg 
thinkpad_acpi mac80211 drm_suballoc_helper drm_ttm_helper snd_hda_codec 
uhci_hcd ttm snd_hwdep i2c_algo_bit ehci_pci nvram drm_exec snd_hda_core 
platform_profile cfg80211 drm_display_helper ehci_hcd snd_pcm 
sparse_keymap libarc4 rfkill acpi_cpufreq video cec libaes wmi thermal 
usbcore snd_timer joydev backlight battery input_leds evdev ac led_class 
processor usb_common button snd soundcore fuse coretemp pkcs8_key_parser 
hwmon configfs
CPU: 0 UID: 0 PID: 1235 Comm: kunit_try_catch Tainted: G        W 
N  7.1.0-rc1-P3 #1 PREEMPTLAZY
Tainted: [W]=WARN, [N]=TEST
Hardware name: LENOVO 2007F2G/2007F2G, BIOS 79ETE7WW (2.27 ) 03/21/2011
EIP: gpu_buddy_fini+0x174/0x19c
Code: 56 c2 ff 8b 07 8b 40 04 e8 69 56 c2 ff 8b 07 e8 62 56 c2 ff 8b 47 
04 e8 5a 56 c2 ff 83 c4 24 5e 5f 5b 5d 31 c0 31 c9 31 d2 c3 <0f> 0b e9 
02 00 00 00 eb c7 a1 34 33 8f c6 68 04 19 68 c6 68 e2 01
EAX: c0000000 EBX: 00000002 ECX: 00000000 EDX: 00000000
ESI: 80000000 EDI: c7f37e9c EBP: c7f37e94 ESP: c7f37e64
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
CR0: 80050033 CR2: a8046000 CR3: 07f14000 CR4: 000006f0
Call Trace:
  gpu_test_buddy_alloc_exceeds_max_order+0x1c2/0x2f0 [gpu_buddy_tests]
  kunit_try_run_case+0x70/0x184 [kunit]
  ? _raw_spin_unlock_irqrestore+0xb/0x2c
  kunit_generic_run_threadfn_adapter+0x18/0x2c [kunit]
  kthread+0xd8/0xec
  ? kunit_try_catch_run+0x1cc/0x1cc [kunit]
  ? kthread_blkcg+0x24/0x24
  ? kthread_blkcg+0x24/0x24
  ret_from_fork+0x8f/0x158
  ? kthread_blkcg+0x24/0x24
  ret_from_fork_asm+0x12/0x18
  entry_INT80_32+0xf0/0xf0
---[ end trace 0000000000000000 ]---
     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:482: 
gpu_buddy_assert(mm->avail == mm->size)
     not ok 10 gpu_test_buddy_alloc_exceeds_max_order
     ok 11 gpu_test_buddy_offset_aligned_allocation
     ok 12 gpu_test_buddy_subtree_offset_alignment_stress
# gpu_buddy: pass:11 fail:1 skip:0 total:12
# Totals: pass:11 fail:1 skip:0 total:12


Some data about the machine:
  # inxi -bZ
System:
   Host: hakla01 Kernel: 7.1.0-rc1-P3 arch: i686 bits: 32
   Desktop: WindowMaker v: 0.96.0 Distro: Gentoo Base System release 2.18
Machine:
   Type: Laptop System: LENOVO product: 2007F2G v: ThinkPad T60 serial: 
L3L8975
   Mobo: LENOVO model: 2007F2G serial: VF05B65E1GU BIOS: LENOVO
     v: 79ETE7WW (2.27 ) date: 03/21/2011
Battery:
   ID-1: BAT0 charge: 0 Wh condition: N/A
CPU:
   Info: dual core Intel T2400 [MCP] speed (MHz): avg: 1833 min/max: 
1000/1833
Graphics:
   Device-1: Advanced Micro Devices [AMD/ATI] RV515/M52 [Mobility Radeon 
X1300]
     driver: radeon v: kernel
   Display: x11 server: X.org v: 1.21.1.22 driver: X: loaded: radeon
     dri: r300 gpu: radeon resolution: <missing: xdpyinfo/xrandr>
     resolution: 1024x768
   API: OpenGL v: 4.5 compat-v: 2.1 vendor: mesa v: 26.0.5
     renderer: ATI RV515
   Info: Tools: api: eglinfo,glxinfo de: xfce4-display-settings x11: xprop
Network:
   Device-1: Intel 82573L Gigabit Ethernet driver: e1000e
   Device-2: Intel PRO/Wireless 3945ABG [Golan] Network driver: iwl3945
Drives:
   Local Storage: total: 465.76 GiB used: 10.44 GiB (2.2%)
Info:
   Memory: total: 3 GiB available: 2.95 GiB used: 771 MiB (25.5%) igpu: 
128 KiB
   Processes: 161 Uptime: 42m Shell: Bash inxi: 3.3.38

  # lspci -s 01:00.0 -v
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] RV515/M52 [Mobility Radeon X1300] (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 2005
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 2000 [size=256]
	Memory at ee100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Express Legacy Endpoint, IntMsgNum 0
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit+
	Kernel driver in use: radeon
	Kernel modules: radeon


Full dmesg and kernel .config available on request.

Regards,
Erhard
