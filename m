Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF136606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aigeus.net header.i=@aigeus.net header.a=rsa-sha256 header.s=protonmail header.b=Tfkm4+/P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1119910F30F;
	Tue, 24 Nov 2026 08:39:46 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238E810EC70
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aigeus.net;
 s=protonmail; t=1795462411; x=1795721611;
 bh=rLoQJ7Nj+E8837b0u6ILRSlICJYuqK+VAyKwJUkjjGQ=;
 h=From:To:Cc:Subject:Message-Id:Date:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Tfkm4+/PyjsQj8SqWdzFtEm6iGHjDZAuADgL9GoyxkgkS3j/J8bjb027mwm3VIDIk
 nAGKD4DRYvWFrg6HO+0HXaDCcz1CK/kLq6TEO7iUs/i7MNXYir9izXfrhqsNNs8TXa
 G4PLiUH2RVS6lLC0qc5zDsMO2iK1O6R3+Za6W/GRiGGCZp6vdYW+F1ZPiYqQzWclhh
 iVMSNxNd/C6219yVbE25uilumynhbGEza3tPf1fiLc9r8IEo9m3Wkd9Mxc28QzEA0M
 8emi/54uWVKusYcM+MsjhfHMnk9n2JWlGVt0hp4lUvkOdn3HOMgMbjyw+nVhuukuNC
 LGypKJPmkldUA==
X-Pm-Submission-Id: 4jYGMG06lzz1DDLh
From: Aigeus <info@aigeus.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: WARNING in amdgpu_irq_put() when amdgpu_device_ip_init() fails
 (navi14, 7.3.4+deb13-amd64)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <4jYGMG06lzz1DDLh@mailsubzur1001.protonmail.ch>
Date: Mon, 23 Nov 2026 19:33:29 +0000 (UTC)
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

(Posting to amd-gfx as well; that copy is still in the list moderation queue, so
sending directly in case it is useful sooner.)

Linux version 7.3.4+deb13-amd64 (debian-kernel@lists.debian.org)
  #1 SMP PREEMPT_DYNAMIC Debian 7.3.4-1~bpo13+1 (2026-11-15)
Hardware name: Gigabyte Technology Co., Ltd. H97-HD3/H97-HD3, BIOS F9c 03/03/2016
Card: AMD Radeon RX 5500 XT (Navi 14, 1002:7340) at 0000:03:00.0

On this machine hw_init failed partway: the PSP could not load the SMU
microcode. The trigger is reported separately (Debian bug #1155044, and the
Intel VT-d page-table regression at
https://lore.kernel.org/all/HYhMd0Klo0XE_yiVY7XmsgyKKFDwKHfKRy22KrycLcYd0V_ykA4xdbBMJXkA07YX3os6qK-NhMIVi6ITo-CkNIIF0e-GcI0UwwZmdDhAJ0I=@protonmail.com/);
this mail is only about what the driver does while unwinding from that failure.

When the probe error path unwinds, the driver emits 34 WARNs:

  WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdgpu_irq_put+0xaa/0xc0 [amdgpu], CPU#4: (udev-worker)/208
  RIP: 0010:amdgpu_irq_put+0xaa/0xc0 [amdgpu]
  Call Trace:
    <TASK>
    amdgpu_fence_driver_hw_fini+0xfe/0x140 [amdgpu]
    amdgpu_device_fini_hw+0xc2/0x456 [amdgpu]
    amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
    amdgpu_pci_probe+0x1f3/0x4d0 [amdgpu]
    local_pci_probe+0x41/0x90
    pci_call_probe+0x5b/0x1a0
    pci_device_probe+0xd4/0x160
    really_probe+0xde/0x380

The sequence that leads here is:

  amdgpu 0000:03:00.0: failed to load ucode SMC(0x34)
  amdgpu 0000:03:00.0: psp gfx command LOAD_IP_FW(0x6) failed and response status is (0x0)
  amdgpu 0000:03:00.0: PSP load smu failed!
  [drm:psp_v11_0_ring_destroy [amdgpu]] *ERROR* Fail to stop psp ring
  amdgpu 0000:03:00.0: PSP firmware loading failed
  amdgpu 0000:03:00.0: hw_init of IP block <psp> failed -22
  amdgpu 0000:03:00.0: Fatal error during GPU init

Question: is the WARN_ON at amdgpu_irq.c:670 meant to fire on this unwind path?
amdgpu_fence_driver_hw_fini() runs from amdgpu_device_fini_hw() after a
partially completed hw_init, and from the trace it looks like it is putting
IRQs for rings whose IRQ was never acquired. If that is expected, the WARN_ON
buries the actual init error under 34 backtraces; if it is not, the unwind
needs a guard for the not-yet-initialised case.

For completeness: with the VT-d trigger worked around on this box the card
initialises normally (7.3.4+deb13-amd64, "SMU is initialized successfully",
[drm] Initialized amdgpu 3.64.0, fbcon amdgpudrmfb primary), so this only
shows up on the failure path.

Happy to test a fix, and I can provide the full log.

-- 
Aigeus
GitHub: EgolOS <79418083+EgolOS@users.noreply.github.com>
