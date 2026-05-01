Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36408FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43C210E982;
	Tue,  5 May 2026 07:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EdpfA2/Z";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6D610F639;
 Fri,  1 May 2026 21:26:50 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g6kd35YnZz9tFt;
 Fri,  1 May 2026 23:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777670807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rL5DJcDLL7ryyIJMpyyMrWM4E9aNl3wjGnZIjhLgWmQ=;
 b=EdpfA2/ZcxWLKtITUkgzcZjUDqtlJoK+5T6po1Le/ufW4bZ8xaHA/i+WTZuh4H0u/I0tph
 QIA1m9BECA8hL0GLUrqDODk5D9+auhWu7z3+2X0EKc8jGoMD6CIJZLqQLU2On5fIt3xknI
 nDdQUOJe1W7Lmnmdno44YA+nRamGhA9W1/hL+Ai/GYwt93ms+KUuKi9gcteSyVAX5yYOGp
 m0Cye5ORStYgq8cxVUymX37AK9R/KTmiYMXjjk50/ZA1mGO0kkSprYBGoqB92psECixcFj
 rvTa9Ytv80KObf2vtX9Zjkj3vk8E09jZEXAAIHGPgHnbfyqiVQRZ5v4fbXgb7Q==
From: Alexander Stein <alexander.stein@mailbox.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: amdgpu: possible regression since 7.0
Date: Fri, 01 May 2026 23:26:45 +0200
Message-ID: <tkBbGbJTT9OdqQhIfM1xCA@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-MBO-RS-ID: 10cebc10675decefba0
X-MBO-RS-META: oc93q58hc5ctzf1rexkd31dmbuo9comg
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

I'm running an Arch 7.0.3 kernel and I'm experiencing various lockups of the
GPU. System still runs and I can shutdown using another VT.
I haven't experienced that on a 6.19.x kernel before.
If you need more information I can try, but it occurs more or less randomly.
Below is the kernel log. My GPU is
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] N=
avi 48 [Radeon RX 9070/9070 XT/9070 GRE] (rev c0)

Best regards,
Alexander

amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:416:crtc-0] flip_done timed out
amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:416:crtc-0] commit wait timed out
amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
amdgpu 0000:03:00.0: [drm] *ERROR* [PLANE:413:plane-7] commit wait timed out
=2D-----------[ cut here ]------------
acrtc->event
WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9572 a=
t amdgpu_dm_atomic_commit_tail+0x38cf/0x3930 [amdgpu], CPU#3: systemd-login=
d/1063
Modules linked in: cmac nls_utf8 cifs nls_ucs2_utils rdma_cm iw_cm ib_cm ib=
_core cifs_md4 dns_resolver netfs snd_seq_dummy snd_hrtimer snd_seq vfat fa=
t snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_=
hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel btusb mt7921e uvcvideo s=
nd_hda_codec btmtk mt7921_common snd_usb_audio videobuf2_vmalloc btrtl snd_=
hda_core uvc mt792x_lib btbcm snd_usbmidi_lib videobuf2_memops snd_intel_ds=
pcfg mt76_connac_lib btintel videobuf2_v4l2 snd_ump amd_atl snd_intel_sdw_a=
cpi snd_rawmidi intel_rapl_msr videobuf2_common r8169 mt76 intel_rapl_commo=
n snd_hwdep snd_seq_device bluetooth videodev spd5118 joydev mousedev realt=
ek snd_pcm mdio_devres mac80211 snd_timer mc libphy eeepc_wmi snd asus_wmi =
mdio_bus libarc4 ghash_clmulni_intel soundcore sp5100_tco aesni_intel platf=
orm_profile sparse_keymap wmi_bmof rapl pcspkr i2c_piix4 gpio_amdpt k10temp=
 i2c_smbus gpio_generic mac_hid cfg80211 rfkill vboxnetflt(OE) vboxnetadp(O=
E) vboxdrv(OE) kvm_amd ccp kvm dm_mod
 irqbypass i2c_dev crypto_user nfnetlink uas usb_storage amdgpu amdxcp i2c_=
algo_bit drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sched n=
vme drm_suballoc_helper drm_buddy nvme_core drm_display_helper nvme_keyring=
 video nvme_auth cec hkdf wmi
CPU: 3 UID: 0 PID: 1063 Comm: systemd-logind Tainted: G           OE       =
7.0.3-arch1-1 #1 PREEMPT(full)  653fa807272d34162f0f7604ba64e0a2aa402e05
Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: ASUS System Product Name/TUF GAMING B850M-PLUS WIFI, BIOS 16=
44 03/10/2026
RIP: 0010:amdgpu_dm_atomic_commit_tail+0x38cf/0x3930 [amdgpu]
Code: 8d 84 24 20 5b 04 00 c6 85 18 fe ff ff 00 48 89 85 20 fe ff ff e9 b0 =
cd ff ff 0f 0b 0f 0b e9 9f f7 ff ff 0f 0b e9 f2 cd ff ff <0f> 0b e9 b0 f7 f=
f ff 48 c7 85 18 fe ff ff 00 00 00 00 48 c7 85 e8
RSP: 0018:ffffcf07c5537418 EFLAGS: 00010082
RAX: 0000000000000001 RBX: 0000000000000296 RCX: ffff8e36d56c6118
RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff8e36d7980178
RBP: ffffcf07c5537688 R08: ffffcf07c553730c R09: 0000000000000000
R10: 0000000000000000 R11: ffffcf07c553737c R12: ffff8e36d56c6118
R13: ffff8e3c0f7c7800 R14: 0000000000000000 R15: ffff8e36d56c6000
=46S:  00007f77aa5488c0(0000) GS:ffff8e3e69b52000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000024c6052cc000 CR3: 0000000134fe5000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 commit_tail+0xc1/0x150
 drm_atomic_helper_commit+0x13c/0x180
 drm_atomic_commit+0xb1/0xe0
 ? __pfx___drm_printfn_info+0x10/0x10
 drm_client_modeset_commit_atomic+0x1ec/0x230
 drm_client_modeset_commit_locked+0x58/0x160
 ? mod_memcg_lruvec_state+0xc5/0x1f0
 __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x27/0x90
 drm_fb_helper_set_par+0x57/0x70
 fb_set_var+0x23c/0x430
 ? update_cfs_rq_load_avg+0x1a/0x240
 ? update_load_avg+0x73/0x210
 ? psi_group_change+0x10c/0x2c0
 ? set_next_entity+0xe7/0x270
 fbcon_blank+0x1f2/0x310
 do_unblank_screen+0xc8/0x1b0
 complete_change_console+0x54/0x120
 vt_ioctl+0xeca/0x1460
 ? security_capable+0x7d/0x1a0
 ? capable+0x32/0x60
 ? kernel_termios_to_user_termios+0x13/0x20
 ? tty_mode_ioctl+0x67a/0x6e0
 tty_ioctl+0xe4/0x980
 ? __seccomp_filter+0x42/0x5a0
 __x64_sys_ioctl+0x97/0xe0
 do_syscall_64+0x12b/0x15f0
 ? __x64_sys_ioctl+0x97/0xe0
 ? do_syscall_64+0x12b/0x15f0
 ? do_syscall_64+0x12b/0x15f0
 ? evdev_ioctl+0x6d/0xa0
 ? __x64_sys_ioctl+0x97/0xe0
 ? do_syscall_64+0x12b/0x15f0
 ? do_syscall_64+0x12b/0x15f0
 ? evdev_ioctl+0x6d/0xa0
 ? __x64_sys_ioctl+0x97/0xe0
 ? do_syscall_64+0x12b/0x15f0
 ? do_syscall_64+0x12b/0x15f0
 ? __x64_sys_close+0x3d/0x80
 ? do_syscall_64+0x12b/0x15f0
 ? __irq_exit_rcu+0x4c/0xf0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f77a9d1604d
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 =
48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 f=
f ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007fffe582da10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00007f77a9d1604d
RDX: 0000000000000001 RSI: 0000000000005605 RDI: 000000000000001b
RBP: 00007fffe582da60 R08: 00000000ffffffff R09: 00007fffe582da40
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055ae5d6c6e80
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
=2D--[ end trace 0000000000000000 ]---
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero when=
 fini
amdgpu 0000:03:00.0: VM memory stats for proc Xorg(1111) task Xorg:cs0(1106=
) is non-zero when fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero when=
 fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero when=
 fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero when=
 fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero when=
 fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero when=
 fini


