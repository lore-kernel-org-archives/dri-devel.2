Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708BCCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 17:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CCE10E209;
	Wed, 20 May 2026 17:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mBsWvlfk";
	dkim-atps=neutral
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9401410E209
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 17:02:55 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so5144266d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779296574; cv=none;
 d=google.com; s=arc-20240605;
 b=Y0gb8z5GBLv3D6Jme6HpcY6Iw1+hOMcdrbe85FRz2wADteG7ZbaR0xgwfwFee+fW5P
 XHG7LlUWcdVmCZGNL+pbx5Kt3IJ23snEoWDtaMyCllJ6Zhee4QApUe6nx4WWOcUSmtub
 hd+UodtVyxbrwj83kK4V9uBP6Yl9zj9hVWoPV+U46zyB4ZMYRkS4UEoq7Csm/cycpBX/
 jaxnxdSAWz+BvcRfBJO1sn//DQcAsWpKMh3P4wR7Zp8+kkmh7MO+RSSsJOvW+WnYCx2p
 Zg3iU231ChsdiTU0E3a+r7g0/CwvetAfVmaIBl39R8L6wFz0yYIavM5MJKc0HhVOmVsM
 BuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=tC+p3/Qloy3mIuLT5FCNNE918YT3X3Etak3P4MYjgqI=;
 fh=SE7mra1eiCNC0ISiOtlSiavPv8zI/rd8ksui5mXg1eE=;
 b=UCRXQYGxhf4L1lF/LL5UCbF4iIwzw7dBVUxO/iRsfz/8eGKw+AbJX6D2smLe7QPZ6n
 OUrS9DDc22mK3bvjhNGiToAyd/IkacRV98MoRIL0LIQmnBB1YNDMBS3eGSgGfp2Eapbp
 mYaGiYPMp2jvl4QK/8Bc7o5IrO4KxTLyOMcfGvMEQ/jOLPihJwP4gdcqMlcSpIUXXo9c
 iOaFVg4V6vWzifQwQU480P6822z1EqvWau5EcMkbFn3xI2hNZyUMCAD85etEUt7s1dnD
 OXGL23FnNjQaLY22vX6wuJeG3Uc/4k7tsmOBpNwp3xSSVFZECmPxt+Nd5id4EKU18A70
 R6jg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779296574; x=1779901374; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tC+p3/Qloy3mIuLT5FCNNE918YT3X3Etak3P4MYjgqI=;
 b=mBsWvlfkcefypd5iGuQKzxlWtJXdaX2sVPqsy71XnhguvB5af6S+OMIo3V46RJYSOB
 S2XCtBBFtPu8NuMSku0UoJeDY24JM1wSg7x+NMmHY+gD/Om+le3n+jPI3j57WBcL9kXi
 p85Oxrq+O05INQtCydSIh4/aOZSlY67a2QxSBFm9XWOkb/f0vwLVeAkY/3Y7XXKPWFSR
 eTOj8yUSwZSqULpCWXgb6vxZx2RrOiKzofZKk0b2j+9Hkow70SF5mUgo3cHDLzivLIfn
 1GHlKwdh7w1pihDBGowL0VKaYVx2l5edtWC+uEqUMmSVRtyMn8MLGzRKpMTEcW1iUCXk
 dARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779296574; x=1779901374;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tC+p3/Qloy3mIuLT5FCNNE918YT3X3Etak3P4MYjgqI=;
 b=IbsxWM5LzFhkQvk2g3d7CCbxp59PwzuHwjhtmszrC81rQL/WsEWt9drADc3b1pIour
 Wi4xAyCF9Mhj8q03gfKwmjC9R5ShObBFJm5Tj88mLkHrZPUkViRv6oJ51Mm799H1ORPt
 110osSf0Iym1ZZyujjMqB2e3Lv6je7VfbnWsG4RaFsxRxnq31HKITv6jMGGj3PTI7dWW
 43wFAlt7ySG8fTU+K5dFcj5TXJzsdaqX2DWYuKBFfNY+17UIc73uQ4M+UHjPW9NjcB+k
 OuRW3n9zT7PLBvYgQ+B0phLx0hXB3SrUz2YFP1v1OYuEAHJv51eKhymb5PAQvg7yIeE3
 DXXw==
X-Gm-Message-State: AOJu0YwCm9mX81UF6KdtLSRWJXQ3Qrdl0l7KuJ4IGJQCs+FVEVdEU/V7
 YqNwM09kRHuNT9SB42ZV4cBB0+C4CWh8BoraRYEe/I7Iq8w9OnZ6DoFT8VM49vfc57/qfCSWvBn
 z73KyH0XqAzuPsMBSvBBeh3Vo8LM0Pyg=
X-Gm-Gg: Acq92OH7qNvDDBFJAQtX2wDTzqlmCquzpy0dv9Md0uqo6NMSYsndoOIRDLwAmqO0x6j
 lehw5jFitHQ1gdck8CsDE3Ns3Ov2rwjVS9B1cImJQLZCkW9RA2nacPoU1gg3wnXuDApN9im5HWf
 6liMpi2jAlpxf7yQPx7Kdq6G+YBX4jyhb6OSu+lhYNd/T/btiMW8NTOae9gOVXZfQ+lj8R33dJQ
 FIGw2J/yKj4yZz13sPXdnbhlEf8uTePqp9o9NDKjTtTuhFUaJPdFOooHXUoYC+kSJdOHVizX/x1
 c1zKJPD//pwUboqdP5DR3yvftrmmFNAPpWG75l5tFmCFjmqo2okoQom0UoQ=
X-Received: by 2002:a05:690e:d47:b0:65d:da2c:ca9c with SMTP id
 956f58d0204a3-65e227579damr21491162d50.18.1779296569854; Wed, 20 May 2026
 10:02:49 -0700 (PDT)
MIME-Version: 1.0
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 20 May 2026 19:02:38 +0200
X-Gm-Features: AVHnY4Lq2RIakmkzFTN7wt0ed5lS9NzeJNKVRmAmaap7psJcDh4MTduw_LGz77Y
Message-ID: <CAHijbEUKuXNeSnT82P-ojOhzU5siNHjxUW+qEDOqx07Ys9m=xw@mail.gmail.com>
Subject: drm/syncobj: importing sync_file exported from timeline triggers
 WARN_ON
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Julian Orth <ju.orth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

When a sync_file is exported from a syncobj point > 0 via
DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD and then imported into another syncobj
point > 0 via DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE, the following warning is
logged:

    ------------[ cut here ]------------
    dma_fence_is_chain(fence)
    WARNING: drivers/dma-buf/dma-fence-chain.c:286 at
dma_fence_chain_init+0xd7/0xf0, CPU#15: jay/356576
    Modules linked in: uinput snd_seq_dummy snd_hrtimer snd_seq
overlay vrf wireguard libcurve25519 ip6_udp_tunnel udp_tunnel bridge
stp llc cfg80211 nft_masq nft_chain_nat nf_nat nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nls_iso8859_1 vfat fat amd_atl
intel_rapl_msr amdgpu intel_rapl_common snd_hda_codec_alc662
snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_atihdmi
snd_hda_codec_hdmi drm_buddy amdxcp btusb drm_panel_backlight_quirks
snd_hda_intel gpu_sched btmtk btrtl snd_usb_audio drm_exec kvm_amd
snd_hda_codec drm_suballoc_helper btbcm btintel snd_hda_core
snd_usbmidi_lib drm_ttm_helper spd5118 wmi_bmof kvm snd_ump ttm
snd_intel_dspcfg sp5100_tco bluetooth snd_intel_sdw_acpi snd_rawmidi
i2c_algo_bit r8169 snd_hwdep snd_seq_device irqbypass
drm_display_helper i2c_piix4 realtek mousedev ledtrig_pattern snd_pcm
rapl pcspkr joydev i2c_smbus k10temp rfkill cec mc phy_package
mdio_devres snd_timer video libphy snd gpio_amdpt
     mdio_bus soundcore gpio_generic wmi mac_hid i2c_dev
pkcs8_key_parser ntsync crypto_user nfnetlink dm_crypt encrypted_keys
trusted asn1_encoder tee dm_mod hid_playstation led_class_multicolor
ff_memless nvme uas aesni_intel usb_storage gf128mul nvme_core aead
nvme_keyring nvme_auth ccp
    CPU: 15 UID: 1000 PID: 356576 Comm: jay Tainted: G        W
   7.1.0-rc3-00375-g73d60ad4c0db #160 PREEMPT(full)
45d3079a60f4a6447320c11f1e9b56e4eb3186d2
    Tainted: [W]=WARN
    Hardware name: ASRock B650 PG Lightning/B650 PG Lightning, BIOS
2.02 11/17/2023
    RIP: 0010:dma_fence_chain_init+0xd7/0xf0
    Code: c0 eb a9 4c 89 04 24 48 89 73 40 bf 01 00 00 00 48 89 6b 50
48 c7 43 48 00 00 00 00 e8 32 d8 ff ff 4c 8b 04 24 48 89 c1 eb 82 <0f>
0b 48 83 c4 10 5b 5d e9 97 35 09 ff 90 66 66 2e 0f 1f 84 00 00
    RSP: 0018:ffffce3f4ae9bb70 EFLAGS: 00010246
    RAX: ffff89467ed80a90 RBX: ffff89467ed80a80 RCX: 00000000000ceb00
    RDX: 0000000000000000 RSI: ffffffffac1e3c80 RDI: ffff89467ed80a80
    RBP: ffff894c8c29f400 R08: 00000000000001d4 R09: ffff89467ed80a80
    R10: 0000000000000018 R11: 0000000000000000 R12: ffff894c8c29f400
    R13: ffffffffab9d4bb0 R14: ffff89467ed80a80 R15: ffff89418580e7c0
    FS:  00007f2347fd8c00(0000) GS:ffff894f90712000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000561aa92dc0b8 CR3: 00000004b05f8000 CR4: 0000000000f50ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     drm_syncobj_add_point+0xe6/0x2a0
     ? __kmalloc_cache_noprof+0x135/0x480
     drm_syncobj_import_sync_file+0x65/0xd0
     drm_syncobj_fd_to_handle_ioctl+0x168/0x280
     ? srso_alias_return_thunk+0x5/0xfbef5
     drm_ioctl_kernel+0xae/0x100
     drm_ioctl+0x2d8/0x570
     ? __pfx_drm_syncobj_fd_to_handle_ioctl+0x10/0x10
     amdgpu_drm_ioctl+0x4a/0x80 [amdgpu
1768195bf8c3668eee55aa832ee8f8298eb07023]
     __x64_sys_ioctl+0xb9/0x100
     ? kmem_cache_free+0x284/0x470
     do_syscall_64+0xaa/0x1620
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __x64_sys_close+0x47/0xa0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_syscall_64+0xaa/0x1620
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_syscall_64+0xaa/0x1620
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __do_sys_io_uring_enter+0x2ee/0x830
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_syscall_64+0x252/0x1620
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_syscall_64+0x5f/0x1620
     ? srso_alias_return_thunk+0x5/0xfbef5
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    RIP: 0033:0x7f2348d18edd
    Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10
00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89>
c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
    RSP: 002b:00007fffe126c1b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
    RAX: ffffffffffffffda RBX: 00007fffe126c2e0 RCX: 00007f2348d18edd
    RDX: 00007fffe126c210 RSI: 00000000c01864c2 RDI: 0000000000000036
    RBP: 00007fffe126c200 R08: 0000000000000000 R09: 0000000000000002
    R10: 0000561aa8eb00b0 R11: 0000000000000246 R12: 00000000000001d4
    R13: 00007fffe126c2a0 R14: 8000000000000029 R15: 00007f2340154960
     </TASK>
    ---[ end trace 0000000000000000 ]---

The cause seems to be that drm_syncobj_import_sync_file_fence (or some
other function) does not use dma_fence_unwrap_merge which is used by
drm_syncobj_transfer_to_timeline.

Working around this by first importing to a secondary syncobj at point
0, and then using DRM_IOCTL_SYNCOBJ_TRANSFER to transfer to the
desired point, fixes the issue.

Being able to import directly to a point > 0 is a new feature that
requires the use of the DRM_SYNCOBJ_FD_TO_HANDLE_FLAGS_TIMELINE flag.
Adding the required merge call was probably forgotten when that flag
was added.

Julian
