Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BA606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3wUuZx7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44B310F5D9;
	Tue, 10 Nov 2026 00:53:02 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D802110F5DA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:52:55 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-93efc0452b5so98940785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 16:52:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794271974; cv=none;
 d=google.com; s=arc-20260327;
 b=RxIf9ugRBjdRscqaT1JejNMqo/JMwXrbUlMErZrQw8XeigLYKDSwL6lG+wftlhLMeh
 hJbbtzOAvxDVhzY2C+bvJyzOkBPS4ouNBHhqtDXyMGhSufaxqT4JGEh1eSuU3zV9Ilyw
 +Gz1PZP8WRvNw8VPWHGo/ElxTh0PKALhJCmJATahpZ3E+K4DxCHnMme95U5gC2tFtEq8
 c5VGv41DZlR10kBXpIeLWN2pIS9Hb++oX16VHr6jZOxk7Dk5jDJ7zg/OHDhBajC33Gu/
 9RtJLpjUQCGwZaNvm2bqmG4lQoj422a68ja9pmExPi0RQW/BtQ05dPnDtYzGSyACZ2v3
 9JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fIHfnj++q/SlsevrSlgQl/5lS3DkgecVq4KF0bU+zN4=;
 fh=JEAYc/Reu/mVzpeT4b53VNs4rr9Bka7tIpG/HnRiMDg=;
 b=Xdf1AgyuCYkLVS5byh3sjkHClZy74GHAcIy4u4TIPwu71kq2L0bLZoDV7EuxsSsRIU
 B11ZZrLswy67plZa5eUfzgtR1Iwviwi8z2fghNUQyJT4MTKbSBQllgo9x9GNOEPM2cYh
 ZvoE0rJRcC/VhWL4BMQ5QLITnFrUSXz663SzXLC14bbIXzLoV0SdJhoejq+JENBo6JHX
 o4Py0kRJ+Opb2zDAJGh2HAjIz9sr0zmBy1lQcjMv2Exh3I/jYY5gHLoHUSPouLbp+JgH
 bNDqNTvHItV+xERia9oxcSxu79FXybO/UT5kmUaRMRwQeiik1cMVXsTsILWJ/hUIqIvt
 AFCQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794271974; x=1794876774; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fIHfnj++q/SlsevrSlgQl/5lS3DkgecVq4KF0bU+zN4=;
 b=y3wUuZx7VhTII2bH7UnzN3FL/soINeG6m3ie4RasDEfWHapDNbEe8iDzHmYQhrILJL
 QaZ0+RA16sDnLMTjpGW+1zc1hIK3Ok+Iwi+QfIOPoEY4KDkAE3xDFaBUdfvSCQCHOwXi
 4Br4/MzatfE0Wfx4e/9DTeShti22liQCLl0qxTbuC1woP4/6w+BDXSmhplcKwvWyh/S4
 cbK6jIweiQWpyqgjXJMT9jitFhiX+JgvcMsxOQnnNRx6RodjSH7+fxc/qj0LNJomucG3
 0krjuyAAkE/xBFoCZfIbBNPkW0aWPlGoQpa2jPo9Nd+n2MdPyDWrkTqKCCLYzH5CAjvu
 yYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794271974; x=1794876774;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fIHfnj++q/SlsevrSlgQl/5lS3DkgecVq4KF0bU+zN4=;
 b=JkpxeRowayUmPEQ6bfKGEmTRoRh3LJkZhYkTYIq+o/PDEnBy7oUEML0tCpwDG0tG9k
 rQAFy2dm1JhYO+MuHh10IgHebgLbbCtP6DYMGdR8mZ9rb98T0dMKQsJnWe61gsojq731
 jzjNQnQR/HBtDzQsxzfrm2mb+ozf1ztHa17ZyZbjI6TojEOvtkc+WrrRQMxTWsIG0c4D
 6EkNpi4c3/Lo7jCE0GTN84cOWlcTxfp/f1GT3GUUK8Ayd7SwPYY1F9QaZOp0a+2DgZoW
 FrA/JsLFllgoQfs+FDeropVfHhOuipVHJbsM7F4lC5cA93lw8bjWbhmiXEwD4iKhl2IZ
 TN6g==
X-Forwarded-Encrypted: i=1;
 AL+hErGPRJvHe6yy5+uNE67ZpPdYw0tZ3V8LK0qLy0R0Kw17Iq5yGvzmjU5KTFU+dVB0De5p4/cYJSnG8PE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dk09Nfq7qJrSTGXl+gf6oPwTTCvMJRchLiOkxFu1o0qp5UWLb
 QQq1JjPmKMcxrKwMlQd1r495ZsFrw9AItu5xXj5nJWCbGTx2OkSMQ1STF6DXuZ0cv1HWumoTXY3
 JbwaIpXQ8Xl48GsXKvi23iaHV1dqAsIY=
X-Gm-Gg: AYBFou0mn2pOlPb6vFRTUUQT1b04wRKNo7X9NpTEqN4sSe+ZDE19L/NQf+pN/1kl4U7
 XtzKFB6APACWvqa4W1OUa8js+PWthNeL+6gispKcXpmVSsVxuL5VsH8X+0WzQ+zvsqoSYIWsnsr
 I9dWkHSxs6GK/51XPY8J0mN25a02UhYAE1AwEtGetX9Rv0yajq0X/YBLf6fB6E3/7vii5vh5AXK
 AIX91TizOJUF4q/k8xER1HADIrsSxrP1A7yWiyYrKrnlK3rnm7FKps5kzdClBAORRk4DO2Cvdzy
 LGa6QXrpD/aVkdPNqmY/4E4PF1jMlqCBtQxzmpZiw4LHvUaNYQjEMbiFSo+U+ovMn/GAMdbhay3
 2d7BaNUqFbsNyKNRXaJ6VpVar5KL4VhFSslLBF3MuNWSKdQbGJSoO6su3Rg1InGYFRYeNmv9Vcp
 pO4XZ5qA+kr1/kNbEMyXhcJw==
X-Received: by 2002:a05:620a:4693:b0:93e:c12c:fbcd with SMTP id
 af79cd13be357-9479f35eedemr193057885a.73.1794271974270; Mon, 09 Nov 2026
 16:52:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <629c8bdedca971d38b08ffd32acec1a804ff7d7d.camel.ref@aol.com>
 <629c8bdedca971d38b08ffd32acec1a804ff7d7d.camel@aol.com>
In-Reply-To: <629c8bdedca971d38b08ffd32acec1a804ff7d7d.camel@aol.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 10 Nov 2026 10:52:42 +1000
X-Gm-Features: AclHuK8Ki-kawuemorAfz7rrtZVSws_7w7m2uRxFuzWM_1_yfCTSwNT-D28Rts4
Message-ID: <CAPM=9tzS3qS=Xn1y+6fveWJxayOsBei9AuygLJV=dw3_H4QY=A@mail.gmail.com>
Subject: Re: [REGRESSION] nouveau oops on 7.4-rc2
To: Ruben Wauters <rubenru09@aol.com>
Cc: lyude@redhat.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 07:06, Ruben Wauters <rubenru09@aol.com> wrote:
>
> Since 7.4, I have been encountering the following oops when booting my
> computer. The issue is present in rc1 and rc2, 7.3 boots fine.
> The kernel booted fine and passed to init, which then tried to start
> gdm, gdm did not launch, leading me to dig and encounter the following
> oops in the journal.
>
> It is worth noting that my laptop, where I encountered this oops, has
> two gpus in a hybrid system, one intel integrated, and one nvidia.

Can you boot with drm.debug=0x10 and attach the complete dmesg?

I've booted a Fedora 44 GP107 laptop this morning with a intel/nvidia
combo on 7.4-rc2 and not seeing anything, so we will need more info.

Also:
https://gitlab.freedesktop.org/drm/nouveau/-/work_items?sort=cr

might be an easier place to keep track of things.

Dave.

>
> It looks to me like something return an -ENOPROTOOPT (likely due to the
> hybrid GPU situation) and then another func tried to deference this
> without checking for errors.
>
> Some quick digging shows that it could potentially be related to atomic
> mode setting being enabled in 7.4, whereas it wasn't before.
>
> I tried to take a look myself at a patch, but unfortunately I got a bit
> lost in nouveau, sorry for not being able to fix it, I hope you're able
> to. If you need any further information, please don't hesitate to
> contact me.
>
> Ruben Wauters
>
> Oops: Oops: 0010 [#1] SMP NOPTI
> CPU: 6 UID: 0 PID: 464 Comm: (udev-worker) Not tainted 7.4.0-rc2 #1
> PREEMPT(lazy)
> Hardware name: ASUSTeK COMPUTER INC. Vivobook_ASUSLaptop
> X3500PCB_K3500PC/X3500PCB, BIOS X3500PCB.305 10/13/2023
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffce1000a37668 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8dff8a97d300 RCX: ffffffffaff4b406
> RDX: 0000000000000000 RSI: ffff8dff8a97d300 RDI: ffff8dff86b91000
> RBP: ffff8dff86b91000 R08: ffff8dff8a97d300 R09: 0000000000000000
> R10: 0000000000000010 R11: 0000000000000000 R12: ffff8dff86b91000
> R13: 0000000000000001 R14: ffff8dff86b91000 R15: ffff8dff8299fa00
> FS:  00007f9bcede9880(0000) GS:ffff8e0349bd8000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000104854004 CR4: 0000000000f72ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  drm_atomic_commit+0xb1/0xe0
>  ? __pfx___drm_printfn_info+0x10/0x10
>  drm_client_modeset_commit_atomic+0x25c/0x2d0
>  drm_client_modeset_commit_locked+0x61/0x180
>  ? drm_master_internal_acquire+0x1d/0x40
>  drm_client_modeset_commit+0x25/0x40
>  drm_fb_helper_single_fb_probe+0x1aa/0x1c0 [drm_client_lib]
>  __drm_fb_helper_initial_config_and_unlock+0xa8/0x1b0 [drm_client_lib]
>  drm_fbdev_client_hotplug+0x79/0xb0 [drm_client_lib]
>  ? drm_client_init+0x116/0x150
>  drm_client_register+0x79/0xc0
>  drm_fbdev_client_setup+0xc9/0x1e0 [drm_client_lib]
>  drm_client_setup+0x6a/0x90 [drm_client_lib]
>  nouveau_drm_probe+0x15b/0x1e0 [nouveau]
>  local_pci_probe+0x4a/0x90
>  ? cpu_hotplug_disable+0x15/0x30
>  pci_call_probe+0x5a/0x1a0
>  pci_device_probe+0xdb/0x180
>  call_driver_probe+0x23/0x100
>  ? driver_sysfs_add+0x55/0xc0
>  really_probe+0xd7/0x2d0
>  ? __pm_runtime_resume+0x50/0x60
>  __driver_probe_device+0x9c/0x1b0
>  driver_probe_device+0x1f/0x80
>  ? __pfx___driver_attach+0x10/0x10
>  __driver_attach+0xcc/0x200
>  bus_for_each_dev+0x9c/0x100
>  ? bus_add_driver+0x84/0x280
>  bus_add_driver+0x1d0/0x280
>  ? __pfx_init_module+0x10/0x10 [nouveau]
>  ? __pfx_init_module+0x10/0x10 [nouveau]
>  driver_register+0x75/0xe0
>  nouveau_drm_init+0x60/0xff0 [nouveau]
>  do_one_initcall+0x89/0x340
>  do_init_module+0x8e/0x2b0
>  init_module_from_file+0xfe/0x170
>  idempotent_init_module+0x23e/0x360
>  __x64_sys_finit_module+0x7f/0x110
>  do_syscall_64+0xc2/0x4d0
>  ? switch_fpu_return+0x5e/0xf0
>  ? ksys_pread64+0x61/0xd0
>  ? arch_exit_to_user_mode_prepare.isra.0+0x84/0xa0
>  ? do_syscall_64+0xff/0x4d0
>  ? do_sys_openat2+0x75/0xe0
>  ? switch_fpu_return+0x5e/0xf0
>  ? arch_exit_to_user_mode_prepare.isra.0+0x84/0xa0
>  ? do_syscall_64+0xff/0x4d0
>  ? do_syscall_64+0xff/0x4d0
>  ? clear_bhb_loop+0x60/0xb0
>  ? do_syscall_64+0x37/0x4d0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f9bce71f95d
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 8b 0d 6b 64 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffdb99bcab8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 0000564b33e33130 RCX: 00007f9bce71f95d
> RDX: 0000000000000000 RSI: 00007f9bced703af RDI: 000000000000004a
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000564b33e30d90
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9bced703af
> R13: 0000000000020000 R14: 0000564b33e2dd30 R15: 0000000000000000
>  </TASK>
> Modules linked in: drm_gpusvm_helper drm_suballoc_helper snd_hda_intel
> snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic
> soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common
> snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda
> soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
> snd_soc_acpi_intel_match vfat snd_soc_acpi_intel_sdca_quirks fat
> nouveau(+) soundwire_generic_allocation snd_soc_sdw_utils snd_soc_acpi
> crc8 i915 soundwire_bus snd_soc_sdca intel_rapl_msr
> intel_uncore_frequency intel_uncore_frequency_common snd_soc_avs
> intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp coretemp
> snd_soc_hda_codec mt7921e snd_hda_ext_core mt7921_common snd_hda_codec
> kvm_intel mt792x_lib snd_hda_core mt76_connac_lib mt76 snd_intel_dspcfg
> snd_intel_sdw_acpi snd_hwdep snd_ctl_led kvm snd_soc_core asus_nb_wmi
> mac80211 snd_compress ac97_bus btusb asus_armoury snd_pcm_dmaengine
> btmtk irqbypass uvcvideo spi_nor snd_pcm drm_gpuvm btrtl rapl mxm_wmi
> btbcm
>  intel_cstate mtd uvc drm_ttm_helper firmware_attributes_class iTCO_wdt
> drm_buddy btintel videobuf2_vmalloc intel_pmc_bxt
> processor_thermal_device_pci_legacy ttm snd_timer mei_pxp >
>  fsdev_dax ucsi_acpi typec_ucsi typec hid_multitouch i2c_hid_acpi
> i2c_hid video wmi thunderbolt pinctrl_tigerlake intel_oc_wdt vmd
> serio_raw rtsx_usb_sdmmc mmc_core rtsx_usb
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffce1000a37668 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8dff8a97d300 RCX: ffffffffaff4b406
> RDX: 0000000000000000 RSI: ffff8dff8a97d300 RDI: ffff8dff86b91000
> RBP: ffff8dff86b91000 R08: ffff8dff8a97d300 R09: 0000000000000000
> R10: 0000000000000010 R11: 0000000000000000 R12: ffff8dff86b91000
> R13: 0000000000000001 R14: ffff8dff86b91000 R15: ffff8dff8299fa00
> FS:  00007f9bcede9880(0000) GS:ffff8e0349bd8000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000104854004 CR4: 0000000000f72ef0
> PKRU: 55555554
