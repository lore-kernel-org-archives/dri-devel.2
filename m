Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6094CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E742E10F549;
	Mon,  8 Jun 2026 14:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="s3hds3+p";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FC410F549;
 Mon,  8 Jun 2026 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UyJJnCKwCMPPUe8XA6TmvI54zPoKOHcRM8nji9095GM=; b=s3hds3+pHRKOyZK+c0MyNB6FzF
 59fX+V0CqfWDWuP28rxFVp0apgTuHCHpB8dshIu+Bfea4+z/JkKJ2IB9lZunwfKjlJmTgKU0jG8XL
 dbLHIxxX3roV2clxnNuyJwmLCPssbh/pYdSUF7YBT6USO8qp8iLHGT49W3pg7AkoH2yrLiZJtDeIn
 hznpOmKOpmBJMpFisnAtitOxPkpNp5IFuflDDw6OC09iHMhKFQoBE3HYeG6Ik5C8qrVaRQZ2eL46q
 yEB22k8+/N4fiPAZmb1oHUFtZhzTodChEMZLMPt+tdB0GTaJ6+Wdlj94ZoKgkxoWfkvrIW5UuPvTq
 I2uHWs5w==;
Received: from 179-125-70-185-dinamico.pombonet.net.br ([179.125.70.185]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWbJk-00EQkI-SH; Mon, 08 Jun 2026 16:51:09 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 08 Jun 2026 11:50:58 -0300
Subject: [PATCH] amd/amdkfd: initialize profiler_lock mutex earlier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-amdgpu-mutex-fix-v1-1-f1fdc889369c@igalia.com>
X-B4-Tracking: v=1; b=H4sIANHWJmoC/yXM3QpAQBCG4VvRHJtaVqPcihwsOxjlp10rJfduc
 fh89b0XeHbCHqrkAseHeFmXiCxNoBvNMjCKjYZc5aRIFWhmO2wB57Dzib2cWGrSZDPVkykh3jb
 Hcf6SdfPbh3bibn87cN8PSqZNIHQAAAA=
X-Change-ID: 20260604-amdgpu-mutex-fix-73636d10f6a7
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benjamin Welton <bewelton@amd.com>, Kent Russell <kent.russell@amd.com>, 
 Yifan Zhang <yifan1.zhang@amd.com>, Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

kfd_init_node/kfd_resume will end up calling init_mqd, which uses the
profiler_lock mutex before it is initialized, resulting in the warning
below when CONFIG_DEBUG_MUTEXES=y.

Moving the initialization of profiler_lock earlier in kgd2kfd_device_init
fixes the issue.

[   13.121334] kfd kfd: Allocated 3969056 bytes on gart
[   13.121439] kfd kfd: Total number of KFD nodes to be created: 1
[   13.122509] ------------[ cut here ]------------
[   13.122523] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[   13.122524] WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x623/0x1160, CPU#2: (udev-worker)/598
[   13.122544] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 joydev snd_soc_acp5x_mach algif_hash algif_skcipher snd_acp5x_pcm_dma snd_acp5x_i2s af_alg mousedev snd_sof_amd_acp70 ramoops nf_tables reed_solomon bnep snd_sof_amd_acp63 hid_multitouch intel_rapl_msr amdgpu(+) intel_rapl_common snd_sof_amd_vangogh snd_sof_amd_acp snd_sof_pci btusb btrtl snd_sof rtw88_8822ce btintel snd_sof_utils i2c_algo_bit rtw88_8822c kvm_amd btbcm snd_sof_xtensa_dsp rtw88_pci drm_buddy btmtk hid_steam drm_ttm_helper snd_pci_ps snd_hda_codec_atihdmi rtw88_core ttm snd_soc_acpi_amd_match snd_hda_codec_hdmi mac80211 kvm snd_soc_acpi_amd_sdca_quirks ff_memless bluetooth snd_hda_intel libarc4 drm_exec cdc_acm snd_soc_sdca ecdh_generic snd_hda_codec sp5100_tco irqbypass snd_soc_cs35l41_spi snd_acp_pci drm_suballoc_helper aesni_intel snd_soc_cs35l41 snd_soc_cs35l4
 1_lib drm_panel_backlight_quirks
[   13.122617]  snd_amd_acpi_mach gf128mul atkbd snd_acp_legacy_common snd_hwdep snd_soc_nau8821 snd_soc_wm_adsp gpu_sched snd_hda_core rapl snd_pci_acp6x cfg80211 libps2 snd_soc_core i2c_piix4 snd_intel_dspcfg amdxcp video vivaldi_fmap snd_compress pcspkr wdat_wdt opt3001 ltrf216a wmi i2c_smbus rfkill cs_dsp drm_display_helper snd_pcm i2c_hid_acpi snd_timer industrialio snd_pci_acp5x i2c_hid snd snd_acp_config cec soundcore snd_soc_acpi 8250_dw ccp mac_hid pkcs8_key_parser crypto_user loop fuse dm_mod nfnetlink zram 842_decompress lz4hc_compress 842_compress overlay ext4 crc16 mbcache jbd2 usbhid vfat fat btrfs xor libblake2b raid6_pq sdhci_pci sdhci_uhs2 serio_raw sdhci xhci_pci cqhci nvme xhci_hcd mmc_core nvme_core i8042 serio spi_amd
[   13.122778] CPU: 2 UID: 0 PID: 598 Comm: (udev-worker) Not tainted 7.1.0-rc5-g17cdb54644e7 #95 PREEMPT  fe7e422e25ce48c0eeff34bf50e2cbbb74b08f52
[   13.122792] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0133 08/05/2024
[   13.122799] RIP: 0010:__mutex_lock+0x62a/0x1160
[   13.122807] Code: ff e8 ba 2c 87 ff 85 c0 0f 84 95 fa ff ff 8b 05 fc d1 b5 00 85 c0 0f 85 87 fa ff ff 48 8d 3d 5d ae b6 00 48 c7 c6 85 eb 63 a9 <67> 48 0f b9 3a e9 6f fa ff ff 48 8b 7d 80 e8 f3 8a 00 00 41 f7 c5
[   13.122823] RSP: 0018:ffffcdbdc2567560 EFLAGS: 00010246
[   13.122830] RAX: 0000000000000000 RBX: ffff8c055f1486d8 RCX: 0000000000000000
[   13.122837] RDX: 0000000000000001 RSI: ffffffffa963eb85 RDI: ffffffffa9a727f0
[   13.122843] RBP: ffffcdbdc2567610 R08: ffffffffc1a7c8f0 R09: 0000000000000000
[   13.122850] R10: ffffcdbdc2567628 R11: 0000000000000002 R12: 0000000000000000
[   13.122857] R13: 0000000000000002 R14: ffff8c0567139200 R15: 0000000000000000
[   13.122863] FS:  00007f9e0ffdf8c0(0000) GS:ffff8c08c4cf7000(0000) knlGS:0000000000000000
[   13.122872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.122877] CR2: 00007f209b4917c8 CR3: 0000000109705000 CR4: 0000000000350ef0
[   13.122885] Call Trace:
[   13.122889]  <TASK>
[   13.122892]  ? mark_held_locks+0x40/0x70
[   13.122902]  ? init_mqd+0x140/0x1b0 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.123412]  ? lockdep_hardirqs_on+0x78/0x100
[   13.123424]  ? init_mqd+0x140/0x1b0 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.123896]  init_mqd+0x140/0x1b0 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.124236]  init_mqd_hiq+0x12/0x30 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.124570]  kq_initialize.constprop.0+0x2f3/0x3a0 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.124908]  kernel_queue_init+0x44/0x60 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.125268]  pm_init+0x70/0x100 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.125653]  start_cpsch+0x1d7/0x270 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.125994]  kgd2kfd_device_init.cold+0x7a7/0xa02 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.126387]  amdgpu_amdkfd_device_init+0x193/0x260 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.126727]  amdgpu_device_init.cold+0x18c7/0x1d94 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.127118]  amdgpu_driver_load_kms+0x19/0x80 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.127412]  amdgpu_pci_probe+0x204/0x440 [amdgpu 124ada0c0ee626a38601e4af30deafe4f3d26a19]
[   13.127698]  local_pci_probe+0x3c/0x80
[   13.127706]  pci_call_probe+0x55/0x2e0
[   13.127712]  ? _raw_spin_unlock+0x2d/0x50
[   13.127717]  ? pci_match_device+0x157/0x180
[   13.127722]  pci_device_probe+0x9b/0x170
[   13.127727]  really_probe+0xd5/0x370
[   13.127733]  ? __device_attach_driver+0x120/0x120
[   13.127738]  __driver_probe_device+0x84/0x150
[   13.127742]  driver_probe_device+0x1f/0xa0
[   13.127747]  __driver_attach+0xb3/0x1e0
[   13.127752]  bus_for_each_dev+0x8e/0xe0
[   13.127757]  bus_add_driver+0x11e/0x200
[   13.127762]  driver_register+0x72/0xc0
[   13.127768]  ? nft_reject_icmpv6_code+0xed0/0xed0 [nft_reject 0e902f0803e5bbdfadf527319d5a2d5ea2df373c]
[   13.127775]  do_one_initcall+0x6e/0x3a0
[   13.127782]  do_init_module+0x60/0x230
[   13.127787]  init_module_from_file+0xc4/0xe0
[   13.127794]  idempotent_init_module+0x11a/0x310
[   13.127801]  __x64_sys_finit_module+0x71/0xe0
[   13.127806]  do_syscall_64+0x122/0x710
[   13.127812]  ? __seccomp_filter+0x42/0x5d0
[   13.127819]  ? do_syscall_64+0xd1/0x710
[   13.127824]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   13.127830] RIP: 0033:0x7f9e10860f6d
[   13.127835] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 ed 0c 00 f7 d8 64 89 01 48
[   13.127844] RSP: 002b:00007ffc537eaed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   13.127851] RAX: ffffffffffffffda RBX: 000056344d23c3f0 RCX: 00007f9e10860f6d
[   13.127855] RDX: 0000000000000000 RSI: 000056344d23dc60 RDI: 000000000000003a
[   13.127859] RBP: 00007ffc537eaf70 R08: 0000000000000000 R09: 00007ffc537eaf40
[   13.127863] R10: 0000000000000000 R11: 0000000000000246 R12: 000056344d23dc60
[   13.127867] R13: 0000000000020000 R14: 000056344d23ab40 R15: 0000000000000000
[   13.127874]  </TASK>
[   13.127877] irq event stamp: 603391
[   13.127880] hardirqs last  enabled at (603391): [<ffffffffa8f105cc>] _raw_spin_unlock_irqrestore+0x4c/0x60
[   13.127887] hardirqs last disabled at (603390): [<ffffffffa8f10343>] _raw_spin_lock_irqsave+0x53/0x60
[   13.127892] softirqs last  enabled at (601682): [<ffffffffa8103402>] __irq_exit_rcu+0xf2/0x190
[   13.127900] softirqs last disabled at (601671): [<ffffffffa8103402>] __irq_exit_rcu+0xf2/0x190
[   13.127906] ---[ end trace 0000000000000000 ]---
[   13.127977] amdgpu: Virtual CRAT table created for GPU
[   13.129101] amdgpu: Topology: Add GPU node [0x1002:0x163f]
[   13.129117] kfd kfd: added device 1002:163f

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c2c59781feee..8b2039bcbc4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -736,6 +736,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	int partition_mode;
 	int xcp_idx;
 
+	mutex_init(&kfd->profiler_lock);
+
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC1);
 	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
@@ -937,7 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	svm_range_set_max_pages(kfd->adev);
 
 	kfd->profiler_process = NULL;
-	mutex_init(&kfd->profiler_lock);
 
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,

---
base-commit: 17cdb54644e7d92b62cff1c4d1bd3d1486515f68
change-id: 20260604-amdgpu-mutex-fix-73636d10f6a7

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

