Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C626109C05E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFAF10E7D3;
	Wed, 25 Mar 2026 20:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="OsMQ1qjE";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CBF10E0F2;
 Wed, 25 Mar 2026 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1774470662;
 bh=KB9XEIF2zZORwgUS/XGO0kpzJhbx+KeMt7rLpLmTTIw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OsMQ1qjElpdqCUAh4GoiGHQzeq/PtjLnyOgWED8T344wpBiJeAE1YuEBclarmtSN1
 Ryam8CFcGYZSCm3ExiNQHvjK7FS3Dn8kJmsY5ktl0857DHOoEVbnnzfQa283s0MF9+
 AOYHNBjP5kuJvbckEBA3ldqhlzhicWWQ0zKxG5Hvzn5nB+nqvrbJiotcBep27KYfNP
 dZJ3qjicX2c4DTzftB/dqvvIZO0D4PZCiGzY9wmhCM9FTDST133SEaZKHlhF4UL5Qd
 HNTXBPEL49XaIvV/dBm2Fw5Z+kWma/bpMQRQP57RNJG1JIdaU72tittps/C41mLDu+
 SOXkAXZzqI/hw==
Message-ID: <8ee09620-dd9b-413a-9596-8489d30db312@lankhorst.se>
Date: Wed, 25 Mar 2026 21:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm: Fix use-after-free on framebuffers and
 property blobs when calling drm_dev_unplug
To: Guenter Roeck <linux@roeck-us.net>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260313151728.14990-3-dev@lankhorst.se>
 <20260313151728.14990-4-dev@lankhorst.se>
 <a89da668-578f-4ae0-809b-f0e68e3550e1@roeck-us.net>
 <42a3616f-f072-47bf-80c8-da4f27b38fe0@lankhorst.se>
 <ec546b71-3b8e-4262-8578-a391f635dc17@roeck-us.net>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <ec546b71-3b8e-4262-8578-a391f635dc17@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hey,

Den 2026-03-25 kl. 21:12, skrev Guenter Roeck:
> Hi Maarten,
> 
> On Wed, Mar 25, 2026 at 07:28:06PM +0100, Maarten Lankhorst wrote:
>> Hello,
>>
>> What about this patch?
>>
>> Kind regards,
>> ~Maarten Lankhorst
>>
>> ------8<---------
>> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
>> index 0358164a623c9..ae49aaf99fb2c 100644
>> --- a/drivers/gpu/drm/sysfb/simpledrm.c
>> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
>> @@ -588,6 +588,11 @@ static const struct drm_mode_config_funcs simpledrm_mode_config_funcs = {
>>   * Init / Cleanup
>>   */
>>  
>> +static void simpledrm_shutdown(struct drm_device *dev, void *arg)
>> +{
>> +	drm_atomic_helper_shutdown(dev);
>> +}
>> +
>>  static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>  							struct platform_device *pdev)
>>  {
>> @@ -808,6 +813,10 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>  
>>  	drm_mode_config_reset(dev);
>>  
>> +	ret = drmm_add_action_or_reset(dev, simpledrm_shutdown, NULL);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>>  	return sdev;
>>  }
>>  
> 
> Unfortunately, this results in an exciting new set of refcount underflows.


Thank you, that's very fascinating and unexpected..

What happens if you loudly complain on fd close instead?
---------8<----
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index c8c7155319951..237ab6d606127 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -251,7 +251,7 @@ void drm_file_free(struct drm_file *file)
 	drm_events_release(file);
 
 	if (drm_core_check_feature(dev, DRIVER_MODESET) &&
-	    drm_dev_enter(dev, &idx)) {
+	    !WARN_ON(!drm_dev_enter(dev, &idx))) {
 		drm_fb_release(file);
 		drm_property_destroy_user_blobs(dev, file);
 		drm_dev_exit(idx);
---------------
> Guenter
> 
> ---
> [    0.000000] Linux version 6.18.20-spi+ (groeck@server.roeck-us.net) (gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP PREEMPT_DYNAMIC Wed Mar 25 12:10:19 PDT 2026
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.18.20-spi+ root=UUID=ce436484-f920-47a8-a8c4-c17ff3a877e8 ro quiet splash amdgpu.gpu_recovery=1 amdgpu.ppfeaturemask=0xfff73fff vt.handoff=7
> ...
> [    3.806644] nouveau 0000:2b:00.0: NVIDIA GK208B (b060b0b1)
> ...
> [    4.644370] nouveau 0000:2b:00.0: drm: VRAM: 2048 MiB
> [    4.644373] nouveau 0000:2b:00.0: drm: GART: 1048576 MiB
> [    4.644375] nouveau 0000:2b:00.0: drm: TMDS table version 2.0
> [    4.645032] nouveau 0000:2b:00.0: drm: MM: using COPY for buffer copies
> [    4.645959] snd_hda_intel 0000:2b:00.1: bound 0000:2b:00.0 (ops nv50_audio_component_bind_ops [nouveau])
> [    4.647016] nouveau 0000:2b:00.0: [drm] Registered 4 planes with drm panic
> [    4.647019] [drm] Initialized nouveau 1.4.0 for 0000:2b:00.0 on minor 1
> ...
> [    4.728390] fbcon: nouveaudrmfb (fb0) is primary device
> [    4.728392] fbcon: Deferring console take-over
> [    4.728393] nouveau 0000:2b:00.0: [drm] fb0: nouveaudrmfb frame buffer device
> [    4.826620] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
> ...
> [    4.986925] ------------[ cut here ]------------
> [    4.986926] refcount_t: addition on 0; use-after-free.
> [    4.986933] WARNING: CPU: 2 PID: 493 at lib/refcount.c:25 refcount_warn_saturate+0x12e/0x150
> [    4.986938] Modules linked in: qrtr bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep kvm_amd snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi kvm snd_seq btusb snd_seq_device snd_timer btmtk btrtl irqbypass polyval_clmulni btbcm snd ghash_clmulni_intel btintel aesni_intel bluetooth joydev input_leds ee1004 soundcore ccp rapl nouveau mxm_wmi drm_gpuvm gpu_sched drm_ttm_helper ttm drm_exec drm_display_helper cec rc_core i2c_piix4 video i2c_smbus wmi_bmof k10temp bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic nvme usbhid hid igb nvme_core r8169 i2c_algo_bit nvme_keyring ahci realtek dca nvme_auth libahci hkdf wmi
> [    4.986973] CPU: 2 UID: 0 PID: 493 Comm: plymouthd Not tainted 6.18.20-spi+ #1 PREEMPT(full) 
> [    4.986974] Hardware name: Micro-Star International Co., Ltd. MS-7C94/MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
> [    4.986975] RIP: 0010:refcount_warn_saturate+0x12e/0x150
> [    4.986977] Code: 1d 28 43 ec 01 80 fb 01 0f 87 fe 61 6c ff 83 e3 01 0f 85 52 ff ff ff 48 c7 c7 18 a3 66 89 c6 05 08 43 ec 01 01 e8 a2 76 80 ff <0f> 0b e9 38 ff ff ff 48 c7 c7 f0 a2 66 89 c6 05 ef 42 ec 01 01 e8
> [    4.986978] RSP: 0018:ffffcdec80873990 EFLAGS: 00010246
> [    4.986979] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    4.986979] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    4.986980] RBP: ffffcdec80873998 R08: 0000000000000000 R09: 0000000000000000
> [    4.986980] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8af0493f7c80
> [    4.986981] R13: ffff8af0493f7c80 R14: ffff8af04085e740 R15: dead000000000100
> [    4.986982] FS:  0000739d3374e000(0000) GS:ffff8aff93d73000(0000) knlGS:0000000000000000
> [    4.986983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.986983] CR2: 0000739d2f268000 CR3: 0000000113bd6000 CR4: 0000000000f50ef0
> [    4.986984] PKRU: 55555554
> [    4.986984] Call Trace:
> [    4.986985]  <TASK>
> [    4.986987]  drm_dev_get+0x53/0x80
> [    4.986989]  drm_atomic_state_init+0x7b/0xe0
> [    4.986991]  drm_atomic_state_alloc+0x98/0xb0
> [    4.986992]  drm_atomic_helper_disable_all+0x1d/0x1c0
> [    4.986994]  drm_atomic_helper_shutdown+0x9c/0x140
> [    4.986995]  simpledrm_shutdown+0xe/0x20
> [    4.986997]  drm_managed_release+0x8f/0x160
> [    4.986999]  drm_minor_release+0x5f/0x90
> [    4.987000]  drm_release+0xda/0x140
> [    4.987001]  __fput+0xed/0x2d0
> [    4.987010]  fput_close_sync+0x3d/0xa0
> [    4.987012]  __x64_sys_close+0x3e/0x90
> [    4.987015]  x64_sys_call+0x1b5e/0x26a0
> [    4.987019]  do_syscall_64+0x80/0x530
> [    4.987022]  ? x64_sys_call+0x1144/0x26a0
> [    4.987024]  ? do_syscall_64+0xb8/0x530
> [    4.987025]  ? from_kgid_munged+0x17/0x30
> [    4.987028]  ? cp_new_stat+0x141/0x180
> [    4.987030]  ? __do_sys_newfstat+0x4c/0x80
> [    4.987032]  ? __x64_sys_newfstat+0x15/0x20
> [    4.987034]  ? x64_sys_call+0x204a/0x26a0
> [    4.987035]  ? do_syscall_64+0xb8/0x530
> [    4.987037]  ? __x64_sys_newfstat+0x15/0x20
> [    4.987038]  ? x64_sys_call+0x204a/0x26a0
> [    4.987040]  ? do_syscall_64+0xb8/0x530
> [    4.987041]  ? irqentry_exit_to_user_mode+0x2e/0x320
> [    4.987043]  ? irqentry_exit+0x43/0x50
> [    4.987044]  ? exc_page_fault+0x90/0x1b0
> [    4.987046]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    4.987047] RIP: 0033:0x739d339f774c
> [    4.987048] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
> [    4.987049] RSP: 002b:00007ffd8ca10660 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> [    4.987050] RAX: ffffffffffffffda RBX: 0000615423195870 RCX: 0000739d339f774c
> [    4.987051] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
> [    4.987052] RBP: 00007ffd8ca10670 R08: 0000000615423196 R09: 0000000000000007
> [    4.987053] R10: 0000615423196bc0 R11: 0000000000000293 R12: 0000739d3374df88
> [    4.987055] R13: 0000000000000013 R14: 0000615423209840 R15: 0000615423194130
> [    4.987057]  </TASK>
> [    4.987058] ---[ end trace 0000000000000000 ]---
> [    4.987114] ------------[ cut here ]------------
> [    4.987115] refcount_t: underflow; use-after-free.
> [    4.987119] WARNING: CPU: 2 PID: 493 at lib/refcount.c:28 refcount_warn_saturate+0xfb/0x150
> [    4.987121] Modules linked in: qrtr bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep kvm_amd snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi kvm snd_seq btusb snd_seq_device snd_timer btmtk btrtl irqbypass polyval_clmulni btbcm snd ghash_clmulni_intel btintel aesni_intel bluetooth joydev input_leds ee1004 soundcore ccp rapl nouveau mxm_wmi drm_gpuvm gpu_sched drm_ttm_helper ttm drm_exec drm_display_helper cec rc_core i2c_piix4 video i2c_smbus wmi_bmof k10temp bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic nvme usbhid hid igb nvme_core r8169 i2c_algo_bit nvme_keyring ahci realtek dca nvme_auth libahci hkdf wmi
> [    4.987147] CPU: 2 UID: 0 PID: 493 Comm: plymouthd Tainted: G        W           6.18.20-spi+ #1 PREEMPT(full) 
> [    4.987149] Tainted: [W]=WARN
> [    4.987149] Hardware name: Micro-Star International Co., Ltd. MS-7C94/MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
> [    4.987150] RIP: 0010:refcount_warn_saturate+0xfb/0x150
> [    4.987151] Code: eb 9a 0f b6 1d 56 43 ec 01 80 fb 01 0f 87 41 62 6c ff 83 e3 01 75 85 48 c7 c7 48 a3 66 89 c6 05 3a 43 ec 01 01 e8 d5 76 80 ff <0f> 0b e9 6b ff ff ff 0f b6 1d 28 43 ec 01 80 fb 01 0f 87 fe 61 6c
> [    4.987152] RSP: 0018:ffffcdec808739b0 EFLAGS: 00010246
> [    4.987153] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    4.987154] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    4.987154] RBP: ffffcdec808739b8 R08: 0000000000000000 R09: 0000000000000000
> [    4.987155] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8af045e46000
> [    4.987155] R13: ffff8af042b0ba00 R14: ffff8af04085e740 R15: dead000000000100
> [    4.987156] FS:  0000739d3374e000(0000) GS:ffff8aff93d73000(0000) knlGS:0000000000000000
> [    4.987157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.987158] CR2: 0000739d2f268000 CR3: 0000000113bd6000 CR4: 0000000000f50ef0
> [    4.987159] PKRU: 55555554
> [    4.987159] Call Trace:
> [    4.987159]  <TASK>
> [    4.987160]  drm_dev_put+0x8c/0x90
> [    4.987162]  __drm_atomic_state_free+0xbe/0xe0
> [    4.987163]  drm_atomic_helper_disable_all+0xd0/0x1c0
> [    4.987164]  drm_atomic_helper_shutdown+0x9c/0x140
> [    4.987165]  simpledrm_shutdown+0xe/0x20
> [    4.987167]  drm_managed_release+0x8f/0x160
> [    4.987168]  drm_minor_release+0x5f/0x90
> [    4.987169]  drm_release+0xda/0x140
> [    4.987171]  __fput+0xed/0x2d0
> [    4.987172]  fput_close_sync+0x3d/0xa0
> [    4.987174]  __x64_sys_close+0x3e/0x90
> [    4.987175]  x64_sys_call+0x1b5e/0x26a0
> [    4.987177]  do_syscall_64+0x80/0x530
> [    4.987178]  ? x64_sys_call+0x1144/0x26a0
> [    4.987180]  ? do_syscall_64+0xb8/0x530
> [    4.987182]  ? from_kgid_munged+0x17/0x30
> [    4.987183]  ? cp_new_stat+0x141/0x180
> [    4.987185]  ? __do_sys_newfstat+0x4c/0x80
> [    4.987187]  ? __x64_sys_newfstat+0x15/0x20
> [    4.987188]  ? x64_sys_call+0x204a/0x26a0
> [    4.987189]  ? do_syscall_64+0xb8/0x530
> [    4.987191]  ? __x64_sys_newfstat+0x15/0x20
> [    4.987193]  ? x64_sys_call+0x204a/0x26a0
> [    4.987194]  ? do_syscall_64+0xb8/0x530
> [    4.987195]  ? irqentry_exit_to_user_mode+0x2e/0x320
> [    4.987196]  ? irqentry_exit+0x43/0x50
> [    4.987197]  ? exc_page_fault+0x90/0x1b0
> [    4.987199]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    4.987200] RIP: 0033:0x739d339f774c
> [    4.987201] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
> [    4.987201] RSP: 002b:00007ffd8ca10660 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> [    4.987202] RAX: ffffffffffffffda RBX: 0000615423195870 RCX: 0000739d339f774c
> [    4.987203] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
> [    4.987203] RBP: 00007ffd8ca10670 R08: 0000000615423196 R09: 0000000000000007
> [    4.987204] R10: 0000615423196bc0 R11: 0000000000000293 R12: 0000739d3374df88
> [    4.987204] R13: 0000000000000013 R14: 0000615423209840 R15: 0000615423194130
> [    4.987206]  </TASK>
> [    4.987206] ---[ end trace 0000000000000000 ]---
> [    4.987226] ------------[ cut here ]------------
> [    4.987227] WARNING: CPU: 2 PID: 493 at drivers/gpu/drm/drm_mode_config.c:571 drm_mode_config_cleanup+0x34f/0x360
> [    4.987229] Modules linked in: qrtr bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep kvm_amd snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi kvm snd_seq btusb snd_seq_device snd_timer btmtk btrtl irqbypass polyval_clmulni btbcm snd ghash_clmulni_intel btintel aesni_intel bluetooth joydev input_leds ee1004 soundcore ccp rapl nouveau mxm_wmi drm_gpuvm gpu_sched drm_ttm_helper ttm drm_exec drm_display_helper cec rc_core i2c_piix4 video i2c_smbus wmi_bmof k10temp bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic nvme usbhid hid igb nvme_core r8169 i2c_algo_bit nvme_keyring ahci realtek dca nvme_auth libahci hkdf wmi
> [    4.987252] CPU: 2 UID: 0 PID: 493 Comm: plymouthd Tainted: G        W           6.18.20-spi+ #1 PREEMPT(full) 
> [    4.987254] Tainted: [W]=WARN
> [    4.987255] Hardware name: Micro-Star International Co., Ltd. MS-7C94/MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
> [    4.987255] RIP: 0010:drm_mode_config_cleanup+0x34f/0x360
> [    4.987257] Code: 70 60 48 c7 c7 d7 90 73 89 e8 3d bb 00 00 48 8d 7d 88 e8 c4 32 fe ff 48 85 c0 75 e2 48 8d 7d 88 e8 d6 31 fe ff e9 7b fd ff ff <0f> 0b e9 79 fe ff ff 0f 0b eb 8e e8 01 a4 65 00 90 90 90 90 90 90
> [    4.987257] RSP: 0018:ffffcdec80873a10 EFLAGS: 00010297
> [    4.987258] RAX: ffff8af053f78e48 RBX: ffff8af045e46368 RCX: 0000000000000000
> [    4.987259] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8af045e46368
> [    4.987259] RBP: ffffcdec80873a90 R08: 0000000000000000 R09: 0000000000000000
> [    4.987260] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8af045e46000
> [    4.987260] R13: ffff8af045e46390 R14: ffff8af045e46230 R15: dead000000000100
> [    4.987261] FS:  0000739d3374e000(0000) GS:ffff8aff93d73000(0000) knlGS:0000000000000000
> [    4.987262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.987262] CR2: 0000739d2f268000 CR3: 0000000113bd6000 CR4: 0000000000f50ef0
> [    4.987263] PKRU: 55555554
> [    4.987263] Call Trace:
> [    4.987264]  <TASK>
> [    4.987264]  ? drm_managed_release+0xc2/0x160
> [    4.987266]  drm_mode_config_init_release+0xe/0x20
> [    4.987267]  drm_managed_release+0x8f/0x160
> [    4.987268]  drm_minor_release+0x5f/0x90
> [    4.987269]  drm_release+0xda/0x140
> [    4.987271]  __fput+0xed/0x2d0
> [    4.987272]  fput_close_sync+0x3d/0xa0
> [    4.987273]  __x64_sys_close+0x3e/0x90
> [    4.987275]  x64_sys_call+0x1b5e/0x26a0
> [    4.987276]  do_syscall_64+0x80/0x530
> [    4.987278]  ? x64_sys_call+0x1144/0x26a0
> [    4.987279]  ? do_syscall_64+0xb8/0x530
> [    4.987281]  ? from_kgid_munged+0x17/0x30
> [    4.987282]  ? cp_new_stat+0x141/0x180
> [    4.987284]  ? __do_sys_newfstat+0x4c/0x80
> [    4.987286]  ? __x64_sys_newfstat+0x15/0x20
> [    4.987287]  ? x64_sys_call+0x204a/0x26a0
> [    4.987289]  ? do_syscall_64+0xb8/0x530
> [    4.987290]  ? __x64_sys_newfstat+0x15/0x20
> [    4.987291]  ? x64_sys_call+0x204a/0x26a0
> [    4.987293]  ? do_syscall_64+0xb8/0x530
> [    4.987294]  ? irqentry_exit_to_user_mode+0x2e/0x320
> [    4.987295]  ? irqentry_exit+0x43/0x50
> [    4.987296]  ? exc_page_fault+0x90/0x1b0
> [    4.987298]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    4.987298] RIP: 0033:0x739d339f774c
> [    4.987299] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
> [    4.987300] RSP: 002b:00007ffd8ca10660 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> [    4.987301] RAX: ffffffffffffffda RBX: 0000615423195870 RCX: 0000739d339f774c
> [    4.987302] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
> [    4.987302] RBP: 00007ffd8ca10670 R08: 0000000615423196 R09: 0000000000000007
> [    4.987303] R10: 0000615423196bc0 R11: 0000000000000293 R12: 0000739d3374df88
> [    4.987303] R13: 0000000000000013 R14: 0000615423209840 R15: 0000615423194130
> [    4.987304]  </TASK>
> [    4.987305] ---[ end trace 0000000000000000 ]---
> ...
> [    5.124594] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
> ...
> [   14.891109] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
> [   14.891114] fbcon: Taking over console
> [   14.923125] Console: switching to colour frame buffer device 240x67
> [   15.349010] workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [   16.124537] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
> [   17.855855] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6

