Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7C1FED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D29610E6C1;
	Tue, 17 Mar 2026 15:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LV9CrB0Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB1110E6C0;
 Tue, 17 Mar 2026 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773761215; x=1805297215;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=v1OvKghRX2ESObae5vdWaRCCIYCn9FXW4gCQirUeZsQ=;
 b=LV9CrB0Z5dcfNLDBdzBE0O36t8IlEjXSmdcLgPbP9ltJWmgK4HnKuRzM
 fG77T3TtyYFLL76LTBSyZJWB6anxqjqbBbdP7XxdipAfSVwWh+WgMnDOf
 KBhNLXDLtiO12pZT6Ft1SYJ9nDEl6H6MRspodR6L/9fj6AUQqhWoDswKL
 k/a5JtdgR65/XzkS/K9vCDqUjsj4cAQ1MjXh0Dw9j5Ix42692OUKssGeq
 4iP8BsK5aFG4zbC0LHL2t+0gKpXXx6LpCGnrcPlvpS8gb88Q2ip0eF5GT
 yEbmjdKnogA2/AOENSPrBGbXrKital56JNSI349JPDsUrAo8ncgeGQqfz w==;
X-CSE-ConnectionGUID: +8OQuXbERxusjvAdfkWTcQ==
X-CSE-MsgGUID: GfKyw4CRQ2CVBaSTsGZoeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92368345"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="92368345"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 08:26:55 -0700
X-CSE-ConnectionGUID: 0lQsp22gTAW6x5zEyEJUjg==
X-CSE-MsgGUID: OuCBlZZHT1++j21h29/mGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="227267702"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO [10.245.245.163])
 ([10.245.245.163])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 08:26:53 -0700
Message-ID: <e61e64c796ccfb17ae673331a3df4b877bf42d82.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/1] drm: Fix use-after-free on framebuffers and
 property blobs when calling drm_dev_unplug
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Date: Tue, 17 Mar 2026 16:26:51 +0100
In-Reply-To: <20260313151728.14990-4-dev@lankhorst.se>
References: <20260313151728.14990-3-dev@lankhorst.se>
 <20260313151728.14990-4-dev@lankhorst.se>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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

On Fri, 2026-03-13 at 16:17 +0100, Maarten Lankhorst wrote:
> When trying to do a rather aggressive test of igt's "xe_module_load
> --r reload" with a full desktop environment and game running I
> noticed
> a few OOPSes when dereferencing freed pointers, related to
> framebuffers and property blobs after the compositor exits.
>=20
> Solve this by guarding the freeing in drm_file with
> drm_dev_enter/exit,
> and immediately put the references from struct drm_file objects
> during
> drm_dev_unplug().
>=20
> Related warnings for framebuffers on the subtest:
> [=C2=A0 739.713076] ------------[ cut here ]------------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 WARN_ON(!list_empty(&dev->mode_config.fb_list))
> [=C2=A0 739.713079] WARNING: drivers/gpu/drm/drm_mode_config.c:584 at
> drm_mode_config_cleanup+0x30b/0x320 [drm], CPU#12:
> xe_module_load/13145
> ....
> [=C2=A0 739.713328] Call Trace:
> [=C2=A0 739.713330]=C2=A0 <TASK>
> [=C2=A0 739.713335]=C2=A0 ? intel_pmdemand_destroy_state+0x11/0x20 [xe]
> [=C2=A0 739.713574]=C2=A0 ? intel_atomic_global_obj_cleanup+0xe4/0x1a0 [x=
e]
> [=C2=A0 739.713794]=C2=A0 intel_display_driver_remove_noirq+0x51/0xb0 [xe=
]
> [=C2=A0 739.714041]=C2=A0 xe_display_fini_early+0x33/0x50 [xe]
> [=C2=A0 739.714284]=C2=A0 devm_action_release+0xf/0x20
> [=C2=A0 739.714294]=C2=A0 devres_release_all+0xad/0xf0
> [=C2=A0 739.714301]=C2=A0 device_unbind_cleanup+0x12/0xa0
> [=C2=A0 739.714305]=C2=A0 device_release_driver_internal+0x1b7/0x210
> [=C2=A0 739.714311]=C2=A0 device_driver_detach+0x14/0x20
> [=C2=A0 739.714315]=C2=A0 unbind_store+0xa6/0xb0
> [=C2=A0 739.714319]=C2=A0 drv_attr_store+0x21/0x30
> [=C2=A0 739.714322]=C2=A0 sysfs_kf_write+0x48/0x60
> [=C2=A0 739.714328]=C2=A0 kernfs_fop_write_iter+0x16b/0x240
> [=C2=A0 739.714333]=C2=A0 vfs_write+0x266/0x520
> [=C2=A0 739.714341]=C2=A0 ksys_write+0x72/0xe0
> [=C2=A0 739.714345]=C2=A0 __x64_sys_write+0x19/0x20
> [=C2=A0 739.714347]=C2=A0 x64_sys_call+0xa15/0xa30
> [=C2=A0 739.714355]=C2=A0 do_syscall_64+0xd8/0xab0
> [=C2=A0 739.714361]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4b/0x53
>=20
> and
>=20
> [=C2=A0 739.714459] ------------[ cut here ]------------
> [=C2=A0 739.714461] xe 0000:67:00.0: [drm] drm_WARN_ON(!list_empty(&fb-
> >filp_head))
> [=C2=A0 739.714464] WARNING: drivers/gpu/drm/drm_framebuffer.c:833 at
> drm_framebuffer_free+0x6c/0x90 [drm], CPU#12: xe_module_load/13145
> [=C2=A0 739.714715] RIP: 0010:drm_framebuffer_free+0x7a/0x90 [drm]
> ...
> [=C2=A0 739.714869] Call Trace:
> [=C2=A0 739.714871]=C2=A0 <TASK>
> [=C2=A0 739.714876]=C2=A0 drm_mode_config_cleanup+0x26a/0x320 [drm]
> [=C2=A0 739.714998]=C2=A0 ? __drm_printfn_seq_file+0x20/0x20 [drm]
> [=C2=A0 739.715115]=C2=A0 ? drm_mode_config_cleanup+0x207/0x320 [drm]
> [=C2=A0 739.715235]=C2=A0 intel_display_driver_remove_noirq+0x51/0xb0 [xe=
]
> [=C2=A0 739.715576]=C2=A0 xe_display_fini_early+0x33/0x50 [xe]
> [=C2=A0 739.715821]=C2=A0 devm_action_release+0xf/0x20
> [=C2=A0 739.715828]=C2=A0 devres_release_all+0xad/0xf0
> [=C2=A0 739.715843]=C2=A0 device_unbind_cleanup+0x12/0xa0
> [=C2=A0 739.715850]=C2=A0 device_release_driver_internal+0x1b7/0x210
> [=C2=A0 739.715856]=C2=A0 device_driver_detach+0x14/0x20
> [=C2=A0 739.715860]=C2=A0 unbind_store+0xa6/0xb0
> [=C2=A0 739.715865]=C2=A0 drv_attr_store+0x21/0x30
> [=C2=A0 739.715868]=C2=A0 sysfs_kf_write+0x48/0x60
> [=C2=A0 739.715873]=C2=A0 kernfs_fop_write_iter+0x16b/0x240
> [=C2=A0 739.715878]=C2=A0 vfs_write+0x266/0x520
> [=C2=A0 739.715886]=C2=A0 ksys_write+0x72/0xe0
> [=C2=A0 739.715890]=C2=A0 __x64_sys_write+0x19/0x20
> [=C2=A0 739.715893]=C2=A0 x64_sys_call+0xa15/0xa30
> [=C2=A0 739.715900]=C2=A0 do_syscall_64+0xd8/0xab0
> [=C2=A0 739.715905]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4b/0x53
>=20
> and then finally file close blows up:
>=20
> [=C2=A0 743.186530] Oops: general protection fault, probably for non-
> canonical address 0xdead000000000122: 0000 [#1] SMP
> [=C2=A0 743.186535] CPU: 3 UID: 1000 PID: 3453 Comm: kwin_wayland Tainted=
:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.0.0-rc1-valkyria+ #110 PREEMPT_{RT,(laz=
y)}
> [=C2=A0 743.186537] Tainted: [W]=3DWARN
> [=C2=A0 743.186538] Hardware name: Gigabyte Technology Co., Ltd. X299
> AORUS Gaming 3/X299 AORUS Gaming 3-CF, BIOS F8n 12/06/2021
> [=C2=A0 743.186539] RIP: 0010:drm_framebuffer_cleanup+0x55/0xc0 [drm]
> [=C2=A0 743.186588] Code: d8 72 73 0f b6 42 05 ff c3 39 c3 72 e8 49 8d bd
> 50 07 00 00 31 f6 e8 3a 80 d3 e1 49 8b 44 24 10 49 8d 7c 24 08 49 8b
> 54 24 08 <48> 3b 38 0f 85 95 7f 02 00 48 3b 7a 08 0f 85 8b 7f 02 00
> 48 89 42
> [=C2=A0 743.186589] RSP: 0018:ffffc900085e3cf8 EFLAGS: 00010202
> [=C2=A0 743.186591] RAX: dead000000000122 RBX: 0000000000000001 RCX:
> ffffffff8217ed03
> [=C2=A0 743.186592] RDX: dead000000000100 RSI: 0000000000000000 RDI:
> ffff88814675ba08
> [=C2=A0 743.186593] RBP: ffffc900085e3d10 R08: 0000000000000000 R09:
> 0000000000000000
> [=C2=A0 743.186593] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff88814675ba00
> [=C2=A0 743.186594] R13: ffff88810d778000 R14: ffff888119f6dca0 R15:
> ffff88810c660bb0
> [=C2=A0 743.186595] FS:=C2=A0 00007ff377d21280(0000) GS:ffff888cec3f8000(=
0000)
> knlGS:0000000000000000
> [=C2=A0 743.186596] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [=C2=A0 743.186596] CR2: 000055690b55e000 CR3: 0000000113586003 CR4:
> 00000000003706f0
> [=C2=A0 743.186597] Call Trace:
> [=C2=A0 743.186598]=C2=A0 <TASK>
> [=C2=A0 743.186603]=C2=A0 intel_user_framebuffer_destroy+0x12/0x90 [xe]
> [=C2=A0 743.186722]=C2=A0 drm_framebuffer_free+0x3a/0x90 [drm]
> [=C2=A0 743.186750]=C2=A0 ? trace_hardirqs_on+0x5f/0x120
> [=C2=A0 743.186754]=C2=A0 drm_mode_object_put+0x51/0x70 [drm]
> [=C2=A0 743.186786]=C2=A0 drm_fb_release+0x105/0x190 [drm]
> [=C2=A0 743.186812]=C2=A0 ? rt_mutex_slowunlock+0x3aa/0x410
> [=C2=A0 743.186817]=C2=A0 ? rt_spin_lock+0xea/0x1b0
> [=C2=A0 743.186819]=C2=A0 drm_file_free+0x1e0/0x2c0 [drm]
> [=C2=A0 743.186843]=C2=A0 drm_release_noglobal+0x91/0xf0 [drm]
> [=C2=A0 743.186865]=C2=A0 __fput+0x100/0x2e0
> [=C2=A0 743.186869]=C2=A0 fput_close_sync+0x40/0xa0
> [=C2=A0 743.186870]=C2=A0 __x64_sys_close+0x3e/0x80
> [=C2=A0 743.186873]=C2=A0 x64_sys_call+0xa07/0xa30
> [=C2=A0 743.186879]=C2=A0 do_syscall_64+0xd8/0xab0
> [=C2=A0 743.186881]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [=C2=A0 743.186882] RIP: 0033:0x7ff37e567732
> [=C2=A0 743.186884] Code: 08 0f 85 a1 38 ff ff 49 89 fb 48 89 f0 48 89 d7
> 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24
> 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55
> bf 01 00
> [=C2=A0 743.186885] RSP: 002b:00007ffc818169a8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
> [=C2=A0 743.186886] RAX: ffffffffffffffda RBX: 00007ffc81816a30 RCX:
> 00007ff37e567732
> [=C2=A0 743.186887] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000012
> [=C2=A0 743.186888] RBP: 00007ffc818169d0 R08: 0000000000000000 R09:
> 0000000000000000
> [=C2=A0 743.186889] R10: 0000000000000000 R11: 0000000000000246 R12:
> 000055d60a7996e0
> [=C2=A0 743.186889] R13: 00007ffc81816a90 R14: 00007ffc81816a90 R15:
> 000055d60a782a30
> [=C2=A0 743.186892]=C2=A0 </TASK>
> [=C2=A0 743.186893] Modules linked in: rfcomm snd_hrtimer xt_CHECKSUM
> xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp
> xt_addrtype nft_compat x_tables nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables overlay cfg80211 bnep
> mtd_intel_dg snd_hda_codec_intelhdmi mtd snd_hda_codec_hdmi nls_utf8
> mxm_wmi intel_wmi_thunderbolt gigabyte_wmi wmi_bmof xe drm_gpuvm
> drm_gpusvm_helper i2c_algo_bit drm_buddy drm_ttm_helper ttm video
> drm_suballoc_helper gpu_sched drm_client_lib drm_exec
> drm_display_helper cec drm_kunit_helpers drm_kms_helper kunit
> x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_codec_alc882
> snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_intel
> snd_soc_avs snd_soc_hda_codec snd_hda_ext_core snd_hda_codec
> snd_hwdep snd_hda_core snd_intel_dspcfg snd_soc_core snd_compress
> ac97_bus snd_pcm snd_seq snd_seq_device snd_timer i2c_i801 i2c_mux
> snd i2c_smbus btusb btrtl btbcm btmtk btintel bluetooth ecdh_generic
> rfkill ecc mei_me mei ioatdma dca wmi nfsd drm i2c_dev fuse nfnetlink
> [=C2=A0 743.186938] ---[ end trace 0000000000000000 ]---
>=20
> And for property blobs:
>=20
> void drm_mode_config_cleanup(struct drm_device *dev)
> {
> ...
> 	list_for_each_entry_safe(blob, bt, &dev-
> >mode_config.property_blob_list,
> 				 head_global) {
> 		drm_property_blob_put(blob);
> 	}
>=20
> Resulting in:
>=20
> [=C2=A0 371.072940] BUG: unable to handle page fault for address:
> 000001ffffffffff
> [=C2=A0 371.072944] #PF: supervisor read access in kernel mode
> [=C2=A0 371.072945] #PF: error_code(0x0000) - not-present page
> [=C2=A0 371.072947] PGD 0 P4D 0
> [=C2=A0 371.072950] Oops: Oops: 0000 [#1] SMP
> [=C2=A0 371.072953] CPU: 0 UID: 1000 PID: 3693 Comm: kwin_wayland Not
> tainted 7.0.0-rc1-valkyria+ #111 PREEMPT_{RT,(lazy)}
> [=C2=A0 371.072956] Hardware name: Gigabyte Technology Co., Ltd. X299
> AORUS Gaming 3/X299 AORUS Gaming 3-CF, BIOS F8n 12/06/2021
> [=C2=A0 371.072957] RIP: 0010:drm_property_destroy_user_blobs+0x3b/0x90
> [drm]
> [=C2=A0 371.073019] Code: 00 00 48 83 ec 10 48 8b 86 30 01 00 00 48 39 c3
> 74 59 48 89 c2 48 8d 48 c8 48 8b 00 4c 8d 60 c8 eb 04 4c 8d 60 c8 48
> 8b 71 40 <48> 39 16 0f 85 39 32 01 00 48 3b 50 08 0f 85 2f 32 01 00
> 48 89 70
> [=C2=A0 371.073021] RSP: 0018:ffffc90006a73de8 EFLAGS: 00010293
> [=C2=A0 371.073022] RAX: 000001ffffffffff RBX: ffff888118a1a930 RCX:
> ffff8881b92355c0
> [=C2=A0 371.073024] RDX: ffff8881b92355f8 RSI: 000001ffffffffff RDI:
> ffff888118be4000
> [=C2=A0 371.073025] RBP: ffffc90006a73e08 R08: ffff8881009b7300 R09:
> ffff888cecc5b000
> [=C2=A0 371.073026] R10: ffffc90006a73e90 R11: 0000000000000002 R12:
> 000001ffffffffc7
> [=C2=A0 371.073027] R13: ffff888118a1a980 R14: ffff88810b366d20 R15:
> ffff888118a1a970
> [=C2=A0 371.073028] FS:=C2=A0 00007f1faccbb280(0000) GS:ffff888cec2db000(=
0000)
> knlGS:0000000000000000
> [=C2=A0 371.073029] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [=C2=A0 371.073030] CR2: 000001ffffffffff CR3: 000000010655c001 CR4:
> 00000000003706f0
> [=C2=A0 371.073031] Call Trace:
> [=C2=A0 371.073033]=C2=A0 <TASK>
> [=C2=A0 371.073036]=C2=A0 drm_file_free+0x1df/0x2a0 [drm]
> [=C2=A0 371.073077]=C2=A0 drm_release_noglobal+0x7a/0xe0 [drm]
> [=C2=A0 371.073113]=C2=A0 __fput+0xe2/0x2b0
> [=C2=A0 371.073118]=C2=A0 fput_close_sync+0x40/0xa0
> [=C2=A0 371.073119]=C2=A0 __x64_sys_close+0x3e/0x80
> [=C2=A0 371.073122]=C2=A0 x64_sys_call+0xa07/0xa30
> [=C2=A0 371.073126]=C2=A0 do_syscall_64+0xc0/0x840
> [=C2=A0 371.073130]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [=C2=A0 371.073132] RIP: 0033:0x7f1fb3501732
> [=C2=A0 371.073133] Code: 08 0f 85 a1 38 ff ff 49 89 fb 48 89 f0 48 89 d7
> 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24
> 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55
> bf 01 00
> [=C2=A0 371.073135] RSP: 002b:00007ffe8e6f0278 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
> [=C2=A0 371.073136] RAX: ffffffffffffffda RBX: 00007ffe8e6f0300 RCX:
> 00007f1fb3501732
> [=C2=A0 371.073137] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000012
> [=C2=A0 371.073138] RBP: 00007ffe8e6f02a0 R08: 0000000000000000 R09:
> 0000000000000000
> [=C2=A0 371.073139] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00005585ba46eea0
> [=C2=A0 371.073140] R13: 00007ffe8e6f0360 R14: 00007ffe8e6f0360 R15:
> 00005585ba458a30
> [=C2=A0 371.073143]=C2=A0 </TASK>
> [=C2=A0 371.073144] Modules linked in: rfcomm snd_hrtimer xt_addrtype
> xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4
> xt_tcpudp nft_compat x_tables nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables overlay cfg80211 bnep
> snd_hda_codec_intelhdmi snd_hda_codec_hdmi mtd_intel_dg mtd nls_utf8
> wmi_bmof mxm_wmi gigabyte_wmi intel_wmi_thunderbolt xe drm_gpuvm
> drm_gpusvm_helper i2c_algo_bit drm_buddy drm_ttm_helper ttm video
> drm_suballoc_helper gpu_sched drm_client_lib drm_exec
> drm_display_helper cec drm_kunit_helpers drm_kms_helper kunit
> x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_codec_alc882
> snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_intel
> snd_soc_avs snd_soc_hda_codec snd_hda_ext_core snd_hda_codec
> snd_hwdep snd_hda_core snd_intel_dspcfg snd_soc_core snd_compress
> ac97_bus snd_pcm snd_seq snd_seq_device snd_timer i2c_i801 btusb
> i2c_mux i2c_smbus btrtl snd btbcm btmtk btintel bluetooth
> ecdh_generic rfkill ecc mei_me mei ioatdma dca wmi nfsd drm i2c_dev
> fuse nfnetlink
> [=C2=A0 371.073198] CR2: 000001ffffffffff
> [=C2=A0 371.073199] ---[ end trace 0000000000000000 ]---
>=20
> Add a guard around file close, and ensure the warnings from
> drm_mode_config
> do not trigger. Fix those by allowing an open reference to the file
> descriptor
> and cleaning up the file linked list entry in
> drm_mode_config_cleanup().
>=20
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
> =C2=A0drivers/gpu/drm/drm_file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 5 ++++-
> =C2=A0drivers/gpu/drm/drm_mode_config.c | 9 ++++++---
> =C2=A02 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ec820686b3021..f52141f842a1f 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -233,6 +233,7 @@ static void drm_events_release(struct drm_file
> *file_priv)
> =C2=A0void drm_file_free(struct drm_file *file)
> =C2=A0{
> =C2=A0	struct drm_device *dev;
> +	int idx;
> =C2=A0
> =C2=A0	if (!file)
> =C2=A0		return;
> @@ -249,9 +250,11 @@ void drm_file_free(struct drm_file *file)
> =C2=A0
> =C2=A0	drm_events_release(file);
> =C2=A0
> -	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
> +	if (drm_core_check_feature(dev, DRIVER_MODESET) &&
> +	=C2=A0=C2=A0=C2=A0 drm_dev_enter(dev, &idx)) {
> =C2=A0		drm_fb_release(file);
> =C2=A0		drm_property_destroy_user_blobs(dev, file);
> +		drm_dev_exit(idx);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> diff --git a/drivers/gpu/drm/drm_mode_config.c
> b/drivers/gpu/drm/drm_mode_config.c
> index 84ae8a23a3678..e349418978f79 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -583,10 +583,13 @@ void drm_mode_config_cleanup(struct drm_device
> *dev)
> =C2=A0	 */
> =C2=A0	WARN_ON(!list_empty(&dev->mode_config.fb_list));
> =C2=A0	list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list,
> head) {
> -		struct drm_printer p =3D drm_dbg_printer(dev,
> DRM_UT_KMS, "[leaked fb]");
> +		if (list_empty(&fb->filp_head) ||
> drm_framebuffer_read_refcount(fb) > 1) {

This looks a bit scary. Can someone manipulate the fb_list and even
free fbs while we are iterating? Or is all other manipulation blocked
by the device being unplugged?


> +			struct drm_printer p =3D drm_dbg_printer(dev,
> DRM_UT_KMS, "[leaked fb]");
> =C2=A0
> -		drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
> -		drm_framebuffer_print_info(&p, 1, fb);
> +			drm_printf(&p, "framebuffer[%u]:\n", fb-
> >base.id);
> +			drm_framebuffer_print_info(&p, 1, fb);
> +		}
> +		list_del_init(&fb->filp_head);
> =C2=A0		drm_framebuffer_free(&fb->base.refcount);
> =C2=A0	}
> =C2=A0
