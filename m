Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D23F109C05D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DEE10E87E;
	Wed, 25 Mar 2026 20:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I9vJdH49";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C29810E870
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 20:12:20 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-126ea4e9694so527304c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774469539; x=1775074339; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=gPB+dnQmZ3RldDKDoUeVq5DzgFmHeQbSMaXNuI1iaNs=;
 b=I9vJdH49mRMlyAkAVg8ld16JKKwkUUsN7T16RBjmskLWu+NSIb7yCD+NyY7uIPCyOB
 8IJmzWBO3mnkd3LYHiETtVUs4SK+Ost6v4kMZWw4dEkrFe5tRbs9fkvtw62Mw81kh0Pb
 ZfF9x3cDrCcAeY3kXjLkOhRtZGcIKDH+2nWPWuaPXfJHCXf+zWDRnP1ftCD+4LrjS3dU
 7QzEO1XRNUowXdWyzv1DEV1vyW+r5UcyxnnQquTI+BODu+9xxwj6TrDVSARRiDI1d1mZ
 dEwyU9/8bKwOm0ilKMoBcplZeXwYLJI5dyZpPCG2uEyPFtrpnzUjnswxn3OwORLsgfH+
 xl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774469539; x=1775074339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gPB+dnQmZ3RldDKDoUeVq5DzgFmHeQbSMaXNuI1iaNs=;
 b=oSBb3EUyFJH5ronXz9GxarpeOIijeQuBzULBY0l6lW2rlhIkIQ5nrDCYwTF5pnA6EZ
 3jIYNGSHrWEJAofeYM1E8gt8T9vqiYVNtb0XMYn2uCXNvlg8RsG9F18RbIqG+twi8l+J
 3vMoNOf63md8actFtRbP+/hhxMJc1giv8bxzJCdmM4GeeC/kMFkOKhYBXq8MNHkXyUP0
 Artr2Z3ko0PtFlqQae7jR5kGNq+s8hfMj9KF4bURSwKGteMWHGrF0qGeucnnHti30/vA
 BJTY3US6+90Jk7zCYqCVLYzmSLHw7QJDC+n5yNhS+gRZowYhw/GRndvD44UMSVo6QBrM
 76Wg==
X-Gm-Message-State: AOJu0YwocdrAk8gLYvjNOe+ChQc59WEW12vSwUhJjes+d7hZv7Fi0sNC
 qNdzIK64wKn1/0kOeEtUauj7lOuiz/sgtjeth1P71JHveduFoAOW3QCm
X-Gm-Gg: ATEYQzyvBwtV0JcyrV0M3MpDE7PGK2sUuACIatyrUvKW93lPii+gzlSDfWUnT36dSeR
 ifQvAPfAU4QDs+lxbxBRGLuPSiPBR4oDf6LlUoX8qyMit8+92A8A2PlJ11Nt17bAK3wh5+doTic
 wBHjln2fMLElg2vwOKZzfDx3zwuEmHggGkh/0Yu1YSkQxVG0gAhVQRVEYlHEHFGB1K9paZLvkEg
 KFF71mI2KKiAiRXerQEUt1vNdnKn726Dq6/tR1iFqot9TJu1c4GB/9Qpq8xW44CBOd0O6rS4DM6
 IzDbWHoHiIVeR+dxU1xei3aU7LSqiiSANAurJx3PzZpE0xaSFDD8YeeoXOcw7FGcxT8qmbxwLgB
 XoNR7eAml9cMMCjcD4TRpWRTEymocEWiWFWAF2fyADG0uqlb2t0WCFS0yLx0zg7npRNLi+ZY0/C
 VqK8wmNn6H4MPSAvFS+W44zzMAFaJLQ+m87IP7
X-Received: by 2002:a05:7022:618b:b0:119:e56b:958a with SMTP id
 a92af1059eb24-12a96e5e7a0mr2460523c88.15.1774469539187; 
 Wed, 25 Mar 2026 13:12:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa7274231sm758086c88.8.2026.03.25.13.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:12:18 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:12:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v2 1/1] drm: Fix use-after-free on framebuffers and
 property blobs when calling drm_dev_unplug
Message-ID: <ec546b71-3b8e-4262-8578-a391f635dc17@roeck-us.net>
References: <20260313151728.14990-3-dev@lankhorst.se>
 <20260313151728.14990-4-dev@lankhorst.se>
 <a89da668-578f-4ae0-809b-f0e68e3550e1@roeck-us.net>
 <42a3616f-f072-47bf-80c8-da4f27b38fe0@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a3616f-f072-47bf-80c8-da4f27b38fe0@lankhorst.se>
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

Hi Maarten,

On Wed, Mar 25, 2026 at 07:28:06PM +0100, Maarten Lankhorst wrote:
> Hello,
> 
> What about this patch?
> 
> Kind regards,
> ~Maarten Lankhorst
> 
> ------8<---------
> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
> index 0358164a623c9..ae49aaf99fb2c 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -588,6 +588,11 @@ static const struct drm_mode_config_funcs simpledrm_mode_config_funcs = {
>   * Init / Cleanup
>   */
>  
> +static void simpledrm_shutdown(struct drm_device *dev, void *arg)
> +{
> +	drm_atomic_helper_shutdown(dev);
> +}
> +
>  static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>  							struct platform_device *pdev)
>  {
> @@ -808,6 +813,10 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>  
>  	drm_mode_config_reset(dev);
>  
> +	ret = drmm_add_action_or_reset(dev, simpledrm_shutdown, NULL);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	return sdev;
>  }
>  

Unfortunately, this results in an exciting new set of refcount underflows.

Guenter

---
[    0.000000] Linux version 6.18.20-spi+ (groeck@server.roeck-us.net) (gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP PREEMPT_DYNAMIC Wed Mar 25 12:10:19 PDT 2026
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.18.20-spi+ root=UUID=ce436484-f920-47a8-a8c4-c17ff3a877e8 ro quiet splash amdgpu.gpu_recovery=1 amdgpu.ppfeaturemask=0xfff73fff vt.handoff=7
...
[    3.806644] nouveau 0000:2b:00.0: NVIDIA GK208B (b060b0b1)
...
[    4.644370] nouveau 0000:2b:00.0: drm: VRAM: 2048 MiB
[    4.644373] nouveau 0000:2b:00.0: drm: GART: 1048576 MiB
[    4.644375] nouveau 0000:2b:00.0: drm: TMDS table version 2.0
[    4.645032] nouveau 0000:2b:00.0: drm: MM: using COPY for buffer copies
[    4.645959] snd_hda_intel 0000:2b:00.1: bound 0000:2b:00.0 (ops nv50_audio_component_bind_ops [nouveau])
[    4.647016] nouveau 0000:2b:00.0: [drm] Registered 4 planes with drm panic
[    4.647019] [drm] Initialized nouveau 1.4.0 for 0000:2b:00.0 on minor 1
...
[    4.728390] fbcon: nouveaudrmfb (fb0) is primary device
[    4.728392] fbcon: Deferring console take-over
[    4.728393] nouveau 0000:2b:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[    4.826620] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
...
[    4.986925] ------------[ cut here ]------------
[    4.986926] refcount_t: addition on 0; use-after-free.
[    4.986933] WARNING: CPU: 2 PID: 493 at lib/refcount.c:25 refcount_warn_saturate+0x12e/0x150
[    4.986938] Modules linked in: qrtr bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep kvm_amd snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi kvm snd_seq btusb snd_seq_device snd_timer btmtk btrtl irqbypass polyval_clmulni btbcm snd ghash_clmulni_intel btintel aesni_intel bluetooth joydev input_leds ee1004 soundcore ccp rapl nouveau mxm_wmi drm_gpuvm gpu_sched drm_ttm_helper ttm drm_exec drm_display_helper cec rc_core i2c_piix4 video i2c_smbus wmi_bmof k10temp bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic nvme usbhid hid igb nvme_core r8169 i2c_algo_bit nvme_keyring ahci realtek dca nvme_auth libahci hkdf wmi
[    4.986973] CPU: 2 UID: 0 PID: 493 Comm: plymouthd Not tainted 6.18.20-spi+ #1 PREEMPT(full) 
[    4.986974] Hardware name: Micro-Star International Co., Ltd. MS-7C94/MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
[    4.986975] RIP: 0010:refcount_warn_saturate+0x12e/0x150
[    4.986977] Code: 1d 28 43 ec 01 80 fb 01 0f 87 fe 61 6c ff 83 e3 01 0f 85 52 ff ff ff 48 c7 c7 18 a3 66 89 c6 05 08 43 ec 01 01 e8 a2 76 80 ff <0f> 0b e9 38 ff ff ff 48 c7 c7 f0 a2 66 89 c6 05 ef 42 ec 01 01 e8
[    4.986978] RSP: 0018:ffffcdec80873990 EFLAGS: 00010246
[    4.986979] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    4.986979] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    4.986980] RBP: ffffcdec80873998 R08: 0000000000000000 R09: 0000000000000000
[    4.986980] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8af0493f7c80
[    4.986981] R13: ffff8af0493f7c80 R14: ffff8af04085e740 R15: dead000000000100
[    4.986982] FS:  0000739d3374e000(0000) GS:ffff8aff93d73000(0000) knlGS:0000000000000000
[    4.986983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.986983] CR2: 0000739d2f268000 CR3: 0000000113bd6000 CR4: 0000000000f50ef0
[    4.986984] PKRU: 55555554
[    4.986984] Call Trace:
[    4.986985]  <TASK>
[    4.986987]  drm_dev_get+0x53/0x80
[    4.986989]  drm_atomic_state_init+0x7b/0xe0
[    4.986991]  drm_atomic_state_alloc+0x98/0xb0
[    4.986992]  drm_atomic_helper_disable_all+0x1d/0x1c0
[    4.986994]  drm_atomic_helper_shutdown+0x9c/0x140
[    4.986995]  simpledrm_shutdown+0xe/0x20
[    4.986997]  drm_managed_release+0x8f/0x160
[    4.986999]  drm_minor_release+0x5f/0x90
[    4.987000]  drm_release+0xda/0x140
[    4.987001]  __fput+0xed/0x2d0
[    4.987010]  fput_close_sync+0x3d/0xa0
[    4.987012]  __x64_sys_close+0x3e/0x90
[    4.987015]  x64_sys_call+0x1b5e/0x26a0
[    4.987019]  do_syscall_64+0x80/0x530
[    4.987022]  ? x64_sys_call+0x1144/0x26a0
[    4.987024]  ? do_syscall_64+0xb8/0x530
[    4.987025]  ? from_kgid_munged+0x17/0x30
[    4.987028]  ? cp_new_stat+0x141/0x180
[    4.987030]  ? __do_sys_newfstat+0x4c/0x80
[    4.987032]  ? __x64_sys_newfstat+0x15/0x20
[    4.987034]  ? x64_sys_call+0x204a/0x26a0
[    4.987035]  ? do_syscall_64+0xb8/0x530
[    4.987037]  ? __x64_sys_newfstat+0x15/0x20
[    4.987038]  ? x64_sys_call+0x204a/0x26a0
[    4.987040]  ? do_syscall_64+0xb8/0x530
[    4.987041]  ? irqentry_exit_to_user_mode+0x2e/0x320
[    4.987043]  ? irqentry_exit+0x43/0x50
[    4.987044]  ? exc_page_fault+0x90/0x1b0
[    4.987046]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.987047] RIP: 0033:0x739d339f774c
[    4.987048] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
[    4.987049] RSP: 002b:00007ffd8ca10660 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[    4.987050] RAX: ffffffffffffffda RBX: 0000615423195870 RCX: 0000739d339f774c
[    4.987051] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
[    4.987052] RBP: 00007ffd8ca10670 R08: 0000000615423196 R09: 0000000000000007
[    4.987053] R10: 0000615423196bc0 R11: 0000000000000293 R12: 0000739d3374df88
[    4.987055] R13: 0000000000000013 R14: 0000615423209840 R15: 0000615423194130
[    4.987057]  </TASK>
[    4.987058] ---[ end trace 0000000000000000 ]---
[    4.987114] ------------[ cut here ]------------
[    4.987115] refcount_t: underflow; use-after-free.
[    4.987119] WARNING: CPU: 2 PID: 493 at lib/refcount.c:28 refcount_warn_saturate+0xfb/0x150
[    4.987121] Modules linked in: qrtr bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep kvm_amd snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi kvm snd_seq btusb snd_seq_device snd_timer btmtk btrtl irqbypass polyval_clmulni btbcm snd ghash_clmulni_intel btintel aesni_intel bluetooth joydev input_leds ee1004 soundcore ccp rapl nouveau mxm_wmi drm_gpuvm gpu_sched drm_ttm_helper ttm drm_exec drm_display_helper cec rc_core i2c_piix4 video i2c_smbus wmi_bmof k10temp bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic nvme usbhid hid igb nvme_core r8169 i2c_algo_bit nvme_keyring ahci realtek dca nvme_auth libahci hkdf wmi
[    4.987147] CPU: 2 UID: 0 PID: 493 Comm: plymouthd Tainted: G        W           6.18.20-spi+ #1 PREEMPT(full) 
[    4.987149] Tainted: [W]=WARN
[    4.987149] Hardware name: Micro-Star International Co., Ltd. MS-7C94/MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
[    4.987150] RIP: 0010:refcount_warn_saturate+0xfb/0x150
[    4.987151] Code: eb 9a 0f b6 1d 56 43 ec 01 80 fb 01 0f 87 41 62 6c ff 83 e3 01 75 85 48 c7 c7 48 a3 66 89 c6 05 3a 43 ec 01 01 e8 d5 76 80 ff <0f> 0b e9 6b ff ff ff 0f b6 1d 28 43 ec 01 80 fb 01 0f 87 fe 61 6c
[    4.987152] RSP: 0018:ffffcdec808739b0 EFLAGS: 00010246
[    4.987153] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    4.987154] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    4.987154] RBP: ffffcdec808739b8 R08: 0000000000000000 R09: 0000000000000000
[    4.987155] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8af045e46000
[    4.987155] R13: ffff8af042b0ba00 R14: ffff8af04085e740 R15: dead000000000100
[    4.987156] FS:  0000739d3374e000(0000) GS:ffff8aff93d73000(0000) knlGS:0000000000000000
[    4.987157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.987158] CR2: 0000739d2f268000 CR3: 0000000113bd6000 CR4: 0000000000f50ef0
[    4.987159] PKRU: 55555554
[    4.987159] Call Trace:
[    4.987159]  <TASK>
[    4.987160]  drm_dev_put+0x8c/0x90
[    4.987162]  __drm_atomic_state_free+0xbe/0xe0
[    4.987163]  drm_atomic_helper_disable_all+0xd0/0x1c0
[    4.987164]  drm_atomic_helper_shutdown+0x9c/0x140
[    4.987165]  simpledrm_shutdown+0xe/0x20
[    4.987167]  drm_managed_release+0x8f/0x160
[    4.987168]  drm_minor_release+0x5f/0x90
[    4.987169]  drm_release+0xda/0x140
[    4.987171]  __fput+0xed/0x2d0
[    4.987172]  fput_close_sync+0x3d/0xa0
[    4.987174]  __x64_sys_close+0x3e/0x90
[    4.987175]  x64_sys_call+0x1b5e/0x26a0
[    4.987177]  do_syscall_64+0x80/0x530
[    4.987178]  ? x64_sys_call+0x1144/0x26a0
[    4.987180]  ? do_syscall_64+0xb8/0x530
[    4.987182]  ? from_kgid_munged+0x17/0x30
[    4.987183]  ? cp_new_stat+0x141/0x180
[    4.987185]  ? __do_sys_newfstat+0x4c/0x80
[    4.987187]  ? __x64_sys_newfstat+0x15/0x20
[    4.987188]  ? x64_sys_call+0x204a/0x26a0
[    4.987189]  ? do_syscall_64+0xb8/0x530
[    4.987191]  ? __x64_sys_newfstat+0x15/0x20
[    4.987193]  ? x64_sys_call+0x204a/0x26a0
[    4.987194]  ? do_syscall_64+0xb8/0x530
[    4.987195]  ? irqentry_exit_to_user_mode+0x2e/0x320
[    4.987196]  ? irqentry_exit+0x43/0x50
[    4.987197]  ? exc_page_fault+0x90/0x1b0
[    4.987199]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.987200] RIP: 0033:0x739d339f774c
[    4.987201] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
[    4.987201] RSP: 002b:00007ffd8ca10660 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[    4.987202] RAX: ffffffffffffffda RBX: 0000615423195870 RCX: 0000739d339f774c
[    4.987203] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
[    4.987203] RBP: 00007ffd8ca10670 R08: 0000000615423196 R09: 0000000000000007
[    4.987204] R10: 0000615423196bc0 R11: 0000000000000293 R12: 0000739d3374df88
[    4.987204] R13: 0000000000000013 R14: 0000615423209840 R15: 0000615423194130
[    4.987206]  </TASK>
[    4.987206] ---[ end trace 0000000000000000 ]---
[    4.987226] ------------[ cut here ]------------
[    4.987227] WARNING: CPU: 2 PID: 493 at drivers/gpu/drm/drm_mode_config.c:571 drm_mode_config_cleanup+0x34f/0x360
[    4.987229] Modules linked in: qrtr bnep sunrpc binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr intel_rapl_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_nvhdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep kvm_amd snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi kvm snd_seq btusb snd_seq_device snd_timer btmtk btrtl irqbypass polyval_clmulni btbcm snd ghash_clmulni_intel btintel aesni_intel bluetooth joydev input_leds ee1004 soundcore ccp rapl nouveau mxm_wmi drm_gpuvm gpu_sched drm_ttm_helper ttm drm_exec drm_display_helper cec rc_core i2c_piix4 video i2c_smbus wmi_bmof k10temp bfq gpio_amdpt mac_hid sch_fq_codel nct6683 msr parport_pc ppdev lp parport nvme_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic nvme usbhid hid igb nvme_core r8169 i2c_algo_bit nvme_keyring ahci realtek dca nvme_auth libahci hkdf wmi
[    4.987252] CPU: 2 UID: 0 PID: 493 Comm: plymouthd Tainted: G        W           6.18.20-spi+ #1 PREEMPT(full) 
[    4.987254] Tainted: [W]=WARN
[    4.987255] Hardware name: Micro-Star International Co., Ltd. MS-7C94/MAG B550M MORTAR MAX WIFI (MS-7C94), BIOS 1.G0 08/22/2023
[    4.987255] RIP: 0010:drm_mode_config_cleanup+0x34f/0x360
[    4.987257] Code: 70 60 48 c7 c7 d7 90 73 89 e8 3d bb 00 00 48 8d 7d 88 e8 c4 32 fe ff 48 85 c0 75 e2 48 8d 7d 88 e8 d6 31 fe ff e9 7b fd ff ff <0f> 0b e9 79 fe ff ff 0f 0b eb 8e e8 01 a4 65 00 90 90 90 90 90 90
[    4.987257] RSP: 0018:ffffcdec80873a10 EFLAGS: 00010297
[    4.987258] RAX: ffff8af053f78e48 RBX: ffff8af045e46368 RCX: 0000000000000000
[    4.987259] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8af045e46368
[    4.987259] RBP: ffffcdec80873a90 R08: 0000000000000000 R09: 0000000000000000
[    4.987260] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8af045e46000
[    4.987260] R13: ffff8af045e46390 R14: ffff8af045e46230 R15: dead000000000100
[    4.987261] FS:  0000739d3374e000(0000) GS:ffff8aff93d73000(0000) knlGS:0000000000000000
[    4.987262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.987262] CR2: 0000739d2f268000 CR3: 0000000113bd6000 CR4: 0000000000f50ef0
[    4.987263] PKRU: 55555554
[    4.987263] Call Trace:
[    4.987264]  <TASK>
[    4.987264]  ? drm_managed_release+0xc2/0x160
[    4.987266]  drm_mode_config_init_release+0xe/0x20
[    4.987267]  drm_managed_release+0x8f/0x160
[    4.987268]  drm_minor_release+0x5f/0x90
[    4.987269]  drm_release+0xda/0x140
[    4.987271]  __fput+0xed/0x2d0
[    4.987272]  fput_close_sync+0x3d/0xa0
[    4.987273]  __x64_sys_close+0x3e/0x90
[    4.987275]  x64_sys_call+0x1b5e/0x26a0
[    4.987276]  do_syscall_64+0x80/0x530
[    4.987278]  ? x64_sys_call+0x1144/0x26a0
[    4.987279]  ? do_syscall_64+0xb8/0x530
[    4.987281]  ? from_kgid_munged+0x17/0x30
[    4.987282]  ? cp_new_stat+0x141/0x180
[    4.987284]  ? __do_sys_newfstat+0x4c/0x80
[    4.987286]  ? __x64_sys_newfstat+0x15/0x20
[    4.987287]  ? x64_sys_call+0x204a/0x26a0
[    4.987289]  ? do_syscall_64+0xb8/0x530
[    4.987290]  ? __x64_sys_newfstat+0x15/0x20
[    4.987291]  ? x64_sys_call+0x204a/0x26a0
[    4.987293]  ? do_syscall_64+0xb8/0x530
[    4.987294]  ? irqentry_exit_to_user_mode+0x2e/0x320
[    4.987295]  ? irqentry_exit+0x43/0x50
[    4.987296]  ? exc_page_fault+0x90/0x1b0
[    4.987298]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.987298] RIP: 0033:0x739d339f774c
[    4.987299] Code: 0f 05 48 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d fc e8 10 1e f8 ff 8b 7d fc 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2c 89 d7 89 45 fc e8 72 1e f8 ff 8b 45 fc c9
[    4.987300] RSP: 002b:00007ffd8ca10660 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[    4.987301] RAX: ffffffffffffffda RBX: 0000615423195870 RCX: 0000739d339f774c
[    4.987302] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000b
[    4.987302] RBP: 00007ffd8ca10670 R08: 0000000615423196 R09: 0000000000000007
[    4.987303] R10: 0000615423196bc0 R11: 0000000000000293 R12: 0000739d3374df88
[    4.987303] R13: 0000000000000013 R14: 0000615423209840 R15: 0000615423194130
[    4.987304]  </TASK>
[    4.987305] ---[ end trace 0000000000000000 ]---
...
[    5.124594] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
...
[   14.891109] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
[   14.891114] fbcon: Taking over console
[   14.923125] Console: switching to colour frame buffer device 240x67
[   15.349010] workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
[   16.124537] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
[   17.855855] nouveau 0000:2b:00.0: drm: Failure to read SCDC_TMDS_CONFIG: -6
