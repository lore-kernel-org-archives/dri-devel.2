Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6179CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F128D10E189;
	Wed,  6 May 2026 07:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=alexanders83@web.de header.b="uhZAiz5e";
	dkim-atps=neutral
X-Greylist: delayed 455 seconds by postgrey-1.36 at gabe;
 Wed, 06 May 2026 04:06:52 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32AB10EC6B;
 Wed,  6 May 2026 04:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1778040411; x=1778645211; i=alexanders83@web.de;
 bh=aGBEo2EK5ttcDFGXea5lOQ0GxuV2d/r3SEIJBSPZ+NM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uhZAiz5eG8LdaHAfVUaoKOoUFxP4Fll1g/VBgJcSCxc3NVuUY7mSedw1YAWpSY5E
 YguS/Nw/OCexXwmdE4J5LjsqxyKxJMRLt8Lkox0osCQg8ZNnQ4wWg2UyrpsI6uvXZ
 1ShA7bWPLqLIXofFuByl/S5XhGG6eFfpCZ4A0NKYq2fHf9zxJLU5mjc1bmIg76p3d
 u6xRwzMZXMLPfMZi4md5HOoRG8TPru457DDbRehwsCeXRbz99yB/6XSPJNExil0s4
 HgpmTM8zWgQ8o7WXYEisAHuqBcVG0dOnnA38DHj+3XQbqC1WOVnQfUS1lHpTUYuvX
 t/0kta0d/jUWl6UtjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LwP-1vIHpB2I2t-00tixn; Wed, 06
 May 2026 05:54:10 +0200
From: Alexander Stein <alexanders83@web.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu: possible regression since 7.0
Date: Wed, 06 May 2026 05:54:09 +0200
Message-ID: <DgNdVC2lSBiLvQZjtA0kFg@web.de>
In-Reply-To: <CADnq5_N3OkOmsbv3zCbc5Kk1P1rAtngt5DQowUg8kKOb_2Divg@mail.gmail.com>
References: <EPoORLxTThi7O4O6Mpq3ZQ@web.de>
 <CADnq5_N3OkOmsbv3zCbc5Kk1P1rAtngt5DQowUg8kKOb_2Divg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:9LM5O+d25CeV8iLF/WO5SE+iW1DOytBAJX7+n8JnUxROBEOmsTm
 8/CLdibIH2CKIZczhnIjO4h9AX0c6+tt39tODmq8O+ROBOz40TYdIFStmJuuvwJInSxoxv/
 mJ1y4IV6KcngqyrYG4LLusXj36lSyRDi5tl7gEjVU9nNdyfQrUapUKlgsl4RWhQm4lszP6Q
 Hf7LQDjUOt6d+XvVlWexA==
UI-OutboundReport: notjunk:1;M01:P0:r6rdQzCqhVw=;sdWgnZ9YZT+EkyOJWM/4U2/T3UE
 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
X-Mailman-Approved-At: Wed, 06 May 2026 07:47:21 +0000
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

Am Dienstag, 5. Mai 2026, 15:06:56 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Alex=20
Deucher:
> On Tue, May 5, 2026 at 3:34=E2=80=AFAM Alexander Stein <alexanders83@web.=
de> wrote:
> > Hi,
> >=20
> > I'm running an Arch 7.0.3 kernel and I'm experiencing various lockups of
> > the GPU. System still runs and I can shutdown using another VT.
> > I haven't experienced that on a 6.19.x kernel before.
> > If you need more information I can try, but it occurs more or less
> > randomly. Below is the kernel log. My GPU is
> > 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/AT=
I]
> > Navi 48 [Radeon RX 9070/9070 XT/9070 GRE] (rev c0)
>=20
> Can you bisect?

I can try. Although the problem just occurred randomly without any idea (fo=
r=20
now) hwo to reproduce.

Best regards,
Alexander

> Thanks,
>=20
> Alex
>=20
> > Best regards,
> > Alexander
> >=20
> > amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:416:crtc-0] flip_done timed out
> > amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
> > amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:416:crtc-0] commit wait timed =
out
> > amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
> > amdgpu 0000:03:00.0: [drm] *ERROR* [PLANE:413:plane-7] commit wait timed
> > out ------------[ cut here ]------------
> > acrtc->event
> > WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:95=
72
> > at amdgpu_dm_atomic_commit_tail+0x38cf/0x3930 [amdgpu], CPU#3:
> > systemd-logind/ 1063
> > Modules linked in: cmac nls_utf8 cifs nls_ucs2_utils rdma_cm iw_cm ib_cm
> > ib_core cifs_md4 dns_resolver netfs snd_seq_dummy snd_hrtimer snd_seq v=
fat
> > fat snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic
> > snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel btusb mt7921e
> > uvcvideo snd_hda_codec btmtk mt7921_common snd_usb_audio
> > videobuf2_vmalloc btrtl snd_hda_core uvc mt792x_lib btbcm snd_usbmidi_l=
ib
> > videobuf2_memops snd_intel_dspcfg mt76_connac_lib btintel videobuf2_v4l2
> > snd_ump amd_atl snd_intel_sdw_acpi snd_rawmidi intel_rapl_msr
> > videobuf2_common r8169 mt76 intel_rapl_common snd_hwdep snd_seq_device
> > bluetooth videodev spd5118 joydev mousedev realtek snd_pcm mdio_devres
> > mac80211 snd_timer mc libphy eeepc_wmi snd asus_wmi mdio_bus libarc4
> > ghash_clmulni_intel soundcore sp5100_tco aesni_intel platform_profile
> > sparse_keymap wmi_bmof rapl pcspkr i2c_piix4 gpio_amdpt k10temp i2c_smb=
us
> > gpio_generic mac_hid cfg80211 rfkill
> > vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm_amd ccp kvm dm_mod
> >=20
> >  irqbypass i2c_dev crypto_user nfnetlink uas usb_storage amdgpu amdxcp
> >=20
> > i2c_algo_bit drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks
> > gpu_sched nvme drm_suballoc_helper drm_buddy nvme_core drm_display_help=
er
> > nvme_keyring video nvme_auth cec hkdf wmi
> > CPU: 3 UID: 0 PID: 1063 Comm: systemd-logind Tainted: G           OE
> > 7.0.3-arch1-1 #1 PREEMPT(full)  653fa807272d34162f0f7604ba64e0a2aa402e05
> > Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > Hardware name: ASUS System Product Name/TUF GAMING B850M-PLUS WIFI, BIOS
> > 1644 03/10/2026
> > RIP: 0010:amdgpu_dm_atomic_commit_tail+0x38cf/0x3930 [amdgpu]
> > Code: 8d 84 24 20 5b 04 00 c6 85 18 fe ff ff 00 48 89 85 20 fe ff ff e9=
 b0
> > cd ff ff 0f 0b 0f 0b e9 9f f7 ff ff 0f 0b e9 f2 cd ff ff <0f> 0b e9 b0 =
f7
> > ff ff 48 c7 85 18 fe ff ff 00 00 00 00 48 c7 85 e8
> > RSP: 0018:ffffcf07c5537418 EFLAGS: 00010082
> > RAX: 0000000000000001 RBX: 0000000000000296 RCX: ffff8e36d56c6118
> > RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff8e36d7980178
> > RBP: ffffcf07c5537688 R08: ffffcf07c553730c R09: 0000000000000000
> > R10: 0000000000000000 R11: ffffcf07c553737c R12: ffff8e36d56c6118
> > R13: ffff8e3c0f7c7800 R14: 0000000000000000 R15: ffff8e36d56c6000
> > FS:  00007f77aa5488c0(0000) GS:ffff8e3e69b52000(0000)
> > knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000024c6052cc000 CR3: 0000000134fe5000 CR4: 0000000000f50ef0
> > PKRU: 55555554
> >=20
> > Call Trace:
> >  <TASK>
> >  commit_tail+0xc1/0x150
> >  drm_atomic_helper_commit+0x13c/0x180
> >  drm_atomic_commit+0xb1/0xe0
> >  ? __pfx___drm_printfn_info+0x10/0x10
> >  drm_client_modeset_commit_atomic+0x1ec/0x230
> >  drm_client_modeset_commit_locked+0x58/0x160
> >  ? mod_memcg_lruvec_state+0xc5/0x1f0
> >  __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x27/0x90
> >  drm_fb_helper_set_par+0x57/0x70
> >  fb_set_var+0x23c/0x430
> >  ? update_cfs_rq_load_avg+0x1a/0x240
> >  ? update_load_avg+0x73/0x210
> >  ? psi_group_change+0x10c/0x2c0
> >  ? set_next_entity+0xe7/0x270
> >  fbcon_blank+0x1f2/0x310
> >  do_unblank_screen+0xc8/0x1b0
> >  complete_change_console+0x54/0x120
> >  vt_ioctl+0xeca/0x1460
> >  ? security_capable+0x7d/0x1a0
> >  ? capable+0x32/0x60
> >  ? kernel_termios_to_user_termios+0x13/0x20
> >  ? tty_mode_ioctl+0x67a/0x6e0
> >  tty_ioctl+0xe4/0x980
> >  ? __seccomp_filter+0x42/0x5a0
> >  __x64_sys_ioctl+0x97/0xe0
> >  do_syscall_64+0x12b/0x15f0
> >  ? __x64_sys_ioctl+0x97/0xe0
> >  ? do_syscall_64+0x12b/0x15f0
> >  ? do_syscall_64+0x12b/0x15f0
> >  ? evdev_ioctl+0x6d/0xa0
> >  ? __x64_sys_ioctl+0x97/0xe0
> >  ? do_syscall_64+0x12b/0x15f0
> >  ? do_syscall_64+0x12b/0x15f0
> >  ? evdev_ioctl+0x6d/0xa0
> >  ? __x64_sys_ioctl+0x97/0xe0
> >  ? do_syscall_64+0x12b/0x15f0
> >  ? do_syscall_64+0x12b/0x15f0
> >  ? __x64_sys_close+0x3d/0x80
> >  ? do_syscall_64+0x12b/0x15f0
> >  ? __irq_exit_rcu+0x4c/0xf0
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >=20
> > RIP: 0033:0x7f77a9d1604d
> > Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00=
 00
> > 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 =
f0
> > ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> > RSP: 002b:00007fffe582da10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00007f77a9d1604d
> > RDX: 0000000000000001 RSI: 0000000000005605 RDI: 000000000000001b
> > RBP: 00007fffe582da60 R08: 00000000ffffffff R09: 00007fffe582da40
> > R10: 00000000ffffffff R11: 0000000000000246 R12: 000055ae5d6c6e80
> > R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
> >=20
> >  </TASK>
> >=20
> > amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero
> > when
> > fini
> > amdgpu 0000:03:00.0: VM memory stats for proc Xorg(1111) task
> > Xorg:cs0(1106) is non-zero when fini
> > amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero
> > when
> > fini
> > amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero
> > when
> > fini
> > amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero
> > when
> > fini
> > amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero
> > when
> > fini
> > amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero
> > when
> > fini
> > --
> > Sorry if this hits the mailinglist twice. I sent it already days ago, b=
ut
> > it was not visible in the archives.




