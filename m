Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB959CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B01310E5EE;
	Mon, 22 Jun 2026 10:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aTW7Y/ak";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979D410E5EE
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:21:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CAF846001A
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82A90C2BCB4
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782123677;
 bh=LpHyG1M8WvjQg+oHm/kB63iM/5qByggEk09BSwut4jc=;
 h=From:To:Subject:Date:From;
 b=aTW7Y/akKCkx6vutjK8FcvW8thwHyJ7G2DUoR9j0i7svyGP1k3L3W+0p9KNKNkpd6
 fdGJGw0nP8qVTb173S0o8R9JF7l8hv21wdCdWn7xx7HBxEHPSMG6Qk0y/n3ersZGr1
 H7v2J+gfQQMGbFDOhxMcUL81zFerN2KTPaFQOsfwYsMTQb7VCFBmnHHl7j6wKjvxP/
 yiUqspE2KTyPZEABgpB1BScv3j2eng5S1fBdgc5njnRtkbXljnd0NMx42PWPqfVdUc
 KWUMvmdmvv3Q5Q6zT88bGtbqIrHVYee4lHrDYRHnzKgscUYPPu3QhPLJVskybIK/uo
 kirwUi1WyFV3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 64309C41613; Mon, 22 Jun 2026 10:21:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221679] New: BUG: kernel NULL pointer dereference, address:
 0000000000000000 - amdgpu_hmm_invalidate_gfx+0x36/0xe0
Date: Mon, 22 Jun 2026 10:21:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jy6x2b32pie9@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221679-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221679

            Bug ID: 221679
           Summary: BUG: kernel NULL pointer dereference, address:
                    0000000000000000 - amdgpu_hmm_invalidate_gfx+0x36/0xe0
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: jy6x2b32pie9@yahoo.com
        Regression: No

Sometimes, when opening video, the kernel BUGs and mpv crashes.
Experienced on 7.1.0 and 7.1.1; exact replication conditions unknown.

[59986.001183] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[59986.001195] #PF: supervisor read access in kernel mode
[59986.001197] #PF: error_code(0x0000) - not-present page
[59986.001200] PGD 0 P4D 0=20
[59986.001204] Oops: Oops: 0000 [#1] SMP NOPTI
[59986.001209] CPU: 1 UID: 1000 PID: 235492 Comm: demux Tainted: G         =
   E
      7.1.1-gentoo #1 PREEMPT(lazy)=20
[59986.001213] Tainted: [E]=3DUNSIGNED_MODULE
[59986.001215] Hardware name: LENOVO 21Q5/LNVNB161216, BIOS PXCN22WW 10/16/=
2024
[59986.001217] RIP: 0010:amdgpu_hmm_invalidate_gfx+0x36/0xe0 [amdgpu]
[59986.001519] Code: 41 89 c0 41 83 e0 01 75 05 44 89 c0 c3 cc 53 48 89 d3 =
48
83 ec 20 48 8b 57 f0 48 8b 8f 58 ff ff ff 48 89 3c 24 44 88 44 24 1f <48> 8=
b 12
4c 8d 89 00 c7 04 00 4c 89 cf 4c 89 4c 24 08 48 8b 92 70
[59986.001522] RSP: 0018:ffffd0f0014a7010 EFLAGS: 00010282
[59986.001525] RAX: 0000000000000001 RBX: 0000000000000003 RCX:
ffff8c69a8f0ed90
[59986.001527] RDX: 0000000000000000 RSI: ffffd0f0014a70a8 RDI:
ffff8c6a65c7be60
[59986.001528] RBP: ffffd0f0014a70a8 R08: 0000000000000001 R09:
0000000000000000
[59986.001530] R10: 0000000000000000 R11: ffffffffadd828c0 R12:
ffff8c6d93ce9ae0
[59986.001531] R13: 0000000000000003 R14: 0000000000000000 R15:
ffff8c6de3b4f200
[59986.001533] FS:  00007fbbd0ad26c0(0000) GS:ffff8c6fb3936000(0000)
knlGS:0000000000000000
[59986.001535] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[59986.001537] CR2: 0000000000000000 CR3: 00000003baf72000 CR4:
0000000000f50ef0
[59986.001538] PKRU: 55555554
[59986.001540] Call Trace:
[59986.001544]  <TASK>
[59986.001548]  ? page_vma_mapped_walk+0x11e/0xb20
[59986.001556]  __mmu_notifier_invalidate_range_start+0x269/0x2e0
[59986.001561]  try_to_migrate_one+0xce2/0xda0
[59986.001565]  ? __isolate_free_page+0x1a1/0x360
[59986.001569]  ? post_alloc_hook+0x87/0xe0
[59986.001572]  rmap_walk_anon+0x110/0x290
[59986.001575]  try_to_migrate+0x8c/0xe0
[59986.001577]  ? try_to_unmap_one+0x1170/0x1170
[59986.001579]  ? set_tlb_ubc_flush_pending.isra.0+0x100/0x100
[59986.001582]  ? folio_get_anon_vma+0xa0/0xa0
[59986.001584]  ? invalid_mkclean_vma+0x20/0x20
[59986.001587]  migrate_pages_batch+0x2ec/0xdf0
[59986.001591]  ? isolate_freepages_block+0x490/0x490
[59986.001594]  ? compaction_proactiveness_sysctl_handler+0x140/0x140
[59986.001597]  ? __mod_memcg_lruvec_state+0x110/0x270
[59986.001601]  ? mod_lruvec_state+0x24/0x40
[59986.001603]  migrate_pages+0xa37/0xb90
[59986.001606]  ? isolate_freepages_block+0x490/0x490
[59986.001608]  ? compaction_proactiveness_sysctl_handler+0x140/0x140
[59986.001611]  compact_zone+0x648/0x10f0
[59986.001615]  compact_zone_order+0xe3/0x130
[59986.001619]  try_to_compact_pages+0xc3/0x320
[59986.001623]  __alloc_pages_slowpath.constprop.0+0x2e5/0x1220
[59986.001625]  ? xfs_vm_readahead+0x9a/0xc0
[59986.001631]  __alloc_frozen_pages_noprof+0x31b/0x380
[59986.001634]  alloc_pages_mpol+0xb2/0x180
[59986.001638]  folio_alloc_noprof+0x5e/0xf0
[59986.001640]  page_cache_ra_order+0x1c3/0x3e0
[59986.001646]  filemap_readahead.isra.0+0x75/0xa0
[59986.001651]  filemap_get_pages+0x307/0x810
[59986.001654]  filemap_read+0x123/0x4d0
[59986.001658]  xfs_file_buffered_read+0x5e/0xe0
[59986.001661]  xfs_file_read_iter+0x9f/0x200
[59986.001664]  ? rw_verify_area+0x61/0x190
[59986.001668]  vfs_read+0x317/0x460
[59986.001672]  ksys_read+0x7b/0x110
[59986.001674]  do_syscall_64+0xe6/0x600
[59986.001680]  ? do_anonymous_page+0xef/0xb10
[59986.001682]  ? __pte_offset_map+0x1b/0xa0
[59986.001685]  ? __handle_mm_fault+0xc41/0x1120
[59986.001687]  ? do_mprotect_pkey+0x181/0x590
[59986.001691]  ? count_memcg_events+0xe2/0x220
[59986.001693]  ? handle_mm_fault+0x247/0x330
[59986.001696]  ? do_user_addr_fault+0x2cb/0x840
[59986.001700]  ? do_syscall_64+0x9d/0x600
[59986.001702]  ? exc_page_fault+0x69/0x160
[59986.001705]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[59986.001709] RIP: 0033:0x7fbbed8207a2
[59986.001711] Code: 08 0f 85 a1 3b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce
4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 6=
6 2e
0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 83 ec 08
[59986.001713] RSP: 002b:00007fbbd0acfd08 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[59986.001716] RAX: ffffffffffffffda RBX: 00007fbb98004450 RCX:
00007fbbed8207a2
[59986.001717] RDX: 0000000000067791 RSI: 00007fbaf49e593d RDI:
0000000000000011
[59986.001719] RBP: 000000000000000a R08: 0000000000000000 R09:
0000000000000000
[59986.001720] R10: 0000000000000000 R11: 0000000000000246 R12:
00007fbb980009a0
[59986.001722] R13: 0000000000067791 R14: 00007fbaf49e593d R15:
00007fbb98006160
[59986.001724]  </TASK>
[59986.001725] Modules linked in: wacom(E) uinput(E) rfcomm(E) snd_seq_dumm=
y(E)
snd_hrtimer(E) snd_seq(E) snd_seq_device(E) hid_sensor_als(E)
hid_sensor_trigger(E) hid_sensor_iio_common(E) kfifo_buf(E) industrialio(E)
uhid(E) hid_logitech_hidpp(E) des_generic(E) libdes(E) md4(E) uvcvideo(E)
uvc(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_v4l2(E)
videobuf2_common(E) videodev(E) uas(E) usb_storage(E) hid_logitech_dj(E)
bnep(E) mc(E) cuse(E) amdgpu(E) btusb(E) btmtk(E) btrtl(E) btbcm(E) btintel=
(E)
bluetooth(E) snd_acp_legacy_mach(E) snd_acp_mach(E) snd_soc_nau8821(E)
iwlmvm(E) snd_acp3x_rn(E) snd_acp70(E) snd_acp_i2s(E) snd_acp_pdm(E)
snd_soc_dmic(E) snd_acp_pcm(E) snd_sof_amd_acp70(E) snd_sof_amd_acp63(E)
snd_sof_amd_vangogh(E) snd_sof_amd_rembrandt(E) snd_sof_amd_renoir(E)
snd_sof_amd_acp(E) amd_atl(E) snd_sof_xtensa_dsp(E) mac80211(E) snd_sof_pci=
(E)
snd_sof(E) snd_sof_utils(E) snd_pci_ps(E) snd_soc_acpi_amd_match(E)
snd_amd_sdw_acpi(E) edac_mce_amd(E) soundwire_amd(E) snd_hda_codec_alc269(E)
[59986.001782]  soundwire_generic_allocation(E) amdxdna(E)
snd_hda_codec_realtek_lib(E) soundwire_bus(E) snd_hda_scodec_component(E)
i2c_algo_bit(E) snd_hda_codec_atihdmi(E) snd_hda_codec_generic(E) drm_buddy=
(E)
kvm_amd(E) snd_hda_codec_hdmi(E) drm_ttm_helper(E) snd_soc_core(E) ttm(E)
snd_hda_intel(E) drm_exec(E) drm_suballoc_helper(E)
drm_panel_backlight_quirks(E) snd_intel_dspcfg(E) amdxcp(E) libarc4(E)
drm_display_helper(E) snd_compress(E) snd_hda_codec(E) ac97_bus(E) kvm(E)
ideapad_laptop(E) cec(E) snd_pcm_dmaengine(E) sparse_keymap(E) snd_acp_pci(=
E)
snd_hda_core(E) snd_amd_acpi_mach(E) iwlwifi(E) snd_acp_legacy_common(E)
joydev(E) snd_pci_acp6x(E) snd_hwdep(E) snd_pcm(E) lenovo_wmi_other(E)
think_lmi(E) ucsi_acpi(E) r8169(E) snd_pci_acp5x(E) hid_multitouch(E)
hid_sensor_hub(E) typec_ucsi(E) snd_timer(E) snd_ctl_led(E) snd_rn_pci_acp3=
x(E)
spd5118(E) snd(E) snd_acp_config(E) lenovo_wmi_hotkey_utilities(E) typec(E)
nfnetlink(E) amd_pmf(E) lenovo_wmi_gamezone(E) realtek(E)
firmware_attributes_class(E) snd_soc_acpi(E)
[59986.001827]  sp5100_tco(E) lenovo_wmi_helpers(E) lenovo_wmi_events(E)
lenovo_wmi_capdata(E) wmi_bmof(E) irqbypass(E) pcspkr(E) gpu_sched(E) amdte=
e(E)
k10temp(E) video(E) soundcore(E) snd_pci_acp3x(E) phy_package(E) cfg80211(E)
thunderbolt(E) i2c_hid_acpi(E) amd_sfh(E) i2c_hid(E) i2c_piix4(E) tee(E)
amd_pmc(E) i2c_smbus(E) wmi(E) serio_raw(E) rfkill(E) binfmt_misc(E) tun(E)
fuse(E) i2c_dev(E) pkcs8_key_parser(E)
[59986.001849] Unloaded tainted modules: amd64_edac(E):1 acpi_cpufreq(E):1
bpf_preload(E):1
[59986.001856] CR2: 0000000000000000
[59986.001859] ---[ end trace 0000000000000000 ]---
[59987.402567] RIP: 0010:amdgpu_hmm_invalidate_gfx+0x36/0xe0 [amdgpu]
[59987.402744] Code: 41 89 c0 41 83 e0 01 75 05 44 89 c0 c3 cc 53 48 89 d3 =
48
83 ec 20 48 8b 57 f0 48 8b 8f 58 ff ff ff 48 89 3c 24 44 88 44 24 1f <48> 8=
b 12
4c 8d 89 00 c7 04 00 4c 89 cf 4c 89 4c 24 08 48 8b 92 70
[59987.402746] RSP: 0018:ffffd0f0014a7010 EFLAGS: 00010282
[59987.402748] RAX: 0000000000000001 RBX: 0000000000000003 RCX:
ffff8c69a8f0ed90
[59987.402749] RDX: 0000000000000000 RSI: ffffd0f0014a70a8 RDI:
ffff8c6a65c7be60
[59987.402750] RBP: ffffd0f0014a70a8 R08: 0000000000000001 R09:
0000000000000000
[59987.402751] R10: 0000000000000000 R11: ffffffffadd828c0 R12:
ffff8c6d93ce9ae0
[59987.402751] R13: 0000000000000003 R14: 0000000000000000 R15:
ffff8c6de3b4f200
[59987.402752] FS:  00007fbbd0ad26c0(0000) GS:ffff8c6fb3936000(0000)
knlGS:0000000000000000
[59987.402753] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[59987.402754] CR2: 0000000000000000 CR3: 00000003baf72000 CR4:
0000000000f50ef0
[59987.402755] PKRU: 55555554

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
