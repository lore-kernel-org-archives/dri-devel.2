Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D090606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pClGs9xO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAAF10E0B9;
	Sat, 14 Nov 2026 16:05:47 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD9610E0B9
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:05:41 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1b3ada81853so1897209c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672340; x=1795277140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
 b=pClGs9xOj8jKmB12W43tZbGlY8ZK4Yw6uyTeVSqEK15TIh4IPKKPYSEPQ+/nxStxzb
 mNCFgBTo1Ro7DAguUApgRkL0hPKrkqDraieCb1GwbUxxCJ/ssEAvPS/++Bo8lJ+Wupjm
 +n+Uh35EXRuZPlcKmderE4UPNdWNT3Vp8hXAXlBkb9Mi56zUx4uibL2Z6yDrMJkD7TW7
 z/2Yu/DKbsK3qT/epFVz2xogmYjVAt32C+IgJZmQAcQFNJyaxujNGfE0ZAgUUnar1n2L
 UVoFJpbOdU1a7aCLud5yGahhi91hAW2PuNp/v/NqKTEgB6grespsslTPoW46+uXFIIcZ
 qtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672340; x=1795277140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
 b=kyvdIRa/O7vygLe+XiFjM+gCxtAFDuFZ1bw67NDEUEe6FxFNoMpMToy0LbwDIkeEiv
 RhjiEQAUHw/pNG6wvCPU7JmjJCgujmSYw4zQskAAFx4jNlPri3Wc3xKSYSdIAf0/Pdak
 yVtqR6cljQT0gffircsKbudOEFTMOspKao+0RZLXAuK8tiw6wpcIII3Z5vUxwKNb8eQf
 1JcoDuE6wrYGlMVGHSUnBKIZ9NhipzrshNnV4TW9B2hwg/OzlwEmOIx7ojDaC0Vsd1pI
 bzUlItnYEdHXCUqYk8GHFry/a/AJ3b5cq3BanH7YtnnzX6qpEW8BsTW6pLZNAIdAAdKa
 WzsA==
X-Forwarded-Encrypted: i=1;
 AL+hErE5L1id0mMmWW2Q9XV0cqgPzl3j60OQ/QV+gk06ol4YhQwg09kOcIYm7HamWXgdDGrVXBzpjNkFOGY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9pwwuAlz7kj7Y2GhL+h+1SnuehRJVJUgrnmlaAY9vzj6lfke00
 qMkCstlaOzJETNa0idsZEdOUDKVnP+YYFnPCII61czdAEszN+vMqEvw=
X-Gm-Gg: AYBFou0J+4pJvvtHy2J/cVXQUYkU7elhg/nNUImKgEqkce0Ur3kFD7ccqlvrzt9b+TB
 Bb0Th4KvHcYQ52lPPYfZIli3faqyscYwiKV6JGc79CevS9jhYarU2qECDxzG+LGK+D2y4BPpZcC
 /OKhu9sbfbrBtDw4ppR876yI2//1+BnoFpP7DZGfaSOFs7+S0AV3mj3dGJf25YsmLAkIO5//rQS
 qwXPt+hkWjLKxtwRDb58QX9Ekj6UxKnefgf5+gfH9cWG1mmiUy/t5PtXc52gGK+xv9Bk8v2a9Et
 qUMn0YhbR8oYgM3ccZM+WQW32zBLU99Xl1u0ZypYBhxDAeshKj/3V1O5JOxnrIZu1YwWtw7o58w
 NkQif/19bW+Ijn5R1mpGQFr9t4fD425TNvooE+bkt5sfAMrcrSVfW3K+PWtQ/U2gE/3Qutu3hLp
 ug906E0Qzx9cIq8pgfWW4S8Yf6MV+d5Hgol01fbczWzWDjMwSYv2KMZQd1yceAG7TpmtKuU+RmU
 f5x+Z1snVLY6F4wQQacuLm0aPHFY/D8WrbMRSaAtG4Zv7v9VBRi/jtFeP703Z8/MK862tiDi5k3
 Ip6nX45Mkp6O5Qi76o55qpHgJRgb2VtGv4L7ZL65LB8Z0KoK9Icu4jbdbezsHyga3Q==
X-Received: by 2002:a05:7022:3b86:b0:1ae:59d6:91cd with SMTP id
 a92af1059eb24-1b5239e163dmr123330c88.38.1794672340199; 
 Sat, 14 Nov 2026 08:05:40 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.114.179])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b505b5bf76sm13378548c88.10.2026.11.14.08.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:05:39 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 00/12] Fixes for apple-gmux and runtime support
Date: Sat, 14 Nov 2026 11:03:47 -0500
Message-ID: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes apple-gmux on T2 Macs (2018-2020):

  - Fix interrupt handling
  - Automatically turn on dGPU when a external monitor connects.
  - Fix base register read/write
  - Fix power handling
  - Improve documentation
  - New module parameter to toggle boot GPU.

It also adds vga_switcheroo runtime power management for T2 Macs, built
on gmux power control, so the dGPU is powered off automatically when
idle and users no longer need to toggle it manually.

Changes in v2:
- Check the discrete pdev config before GFX0 restore (01/13)
- Don't save bridges state when state is VGA_SWITCHEROO_OFF (01/13)
- Fixes discrete_pdev initialization (01/13)
- Used PWRD on 15,1 and 15,3 aswell
- Add quirk to 0x7360 PCI id aswell (02/13)
- Add 15,1 and 15,3 and its gpu's aswell
- Removed ignore_access code (02/13)
- Initialized val in read functions (03/13)
- Fixed permanent mutex block on failure (03/13)
- Only resumed when pm_runtime is available (skipping on iMacs) (04/13)
- Corrected ordering of interrupt_work (04/13)
- Notified drm about hotplug change (04/13)
- Checked if EFI_RT_SUPPORTED_SET_VARIABLE is available before writing
  gpu-active (05/13)
- Wrote gpu-active on shutdown aswell (05/13)
- Dropped boot-gpu parameter (06/13)
- Checked if vga_switcheroo has been initialized (09/13)
- Added additional pci_is_thunderbolt_attached check to
  amdgpu_device_supports_gmux (09/13)
- Removed duplicate check (10/13)
- Renamed gmux_off to runpm_active
- Checked if adev->dev exists in dm_dp_aux_transfer to fix null ptr
  deref (11/13)
- Removed GMUX specific code (12/13)
- Initialized edp_sink_present in testing code (13/13)

Link to v1:
https://lore.kernel.org/all/20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com/

Andre Eikmeyer (6):
  platform/apple-gmux: Write switch state to EFI on MMIO devices
  drm/amdgpu: Add Apple GMUX runtime PM support
  drm/amdgpu: Catch register access while GMUX keeps the GPU off
  drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
  drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
  drm/amd/display: Skip panel power savings on eDP links without a panel

Atharva Tiwari (6):
  platform/apple-gmux: Fix power for MMIO systems
  PCI: Disable pcie port on specific amd devices
  platform/apple-gmux: Fix MMIO interface
  platform/apple-gmux: Fix Interrupts for MMIO systems
  platform/apple-gmux: Add check to detect FSS
  platform/apple-gmux: Add documentation about iMacs

 arch/x86/pci/fixup.c                          |  43 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  61 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  48 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    |  24 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 .../tests/amdgpu_dm_backlight_test.c          |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
 drivers/pci/pcie/portdrv.c                    |   2 +-
 drivers/platform/x86/Kconfig                  |   1 +
 drivers/platform/x86/apple-gmux.c             | 365 +++++++++++++++---
 include/linux/apple-gmux.h                    |   1 +
 include/linux/pci.h                           |   1 +
 16 files changed, 534 insertions(+), 72 deletions(-)

-- 
2.55.0

