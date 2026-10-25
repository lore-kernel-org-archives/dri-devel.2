Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4B606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTgfUKZc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BC510E258;
	Sun, 25 Oct 2026 04:01:31 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE0310E4BF
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:01:26 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so3432499c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900885; x=1793505685; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lv7p0AUZ948zcVcPc4Q28K28YGEwBExkgg3ueLIutWo=;
 b=aTgfUKZckopDZX5UrTbYOauQSr0Adk81a836uRwpnmyBd82J5Qae7vfsFvolwxwbvm
 g7OgJxm7G3tsz0hIHifjOd9Y5auVF82D3xuU+gcbtvCuLYHkHCZXsTV6oaJCnkinU125
 TqvB/Q6AyJJZYjRYpok+egsa/8pfiNYiwWq/ZFcGLKw9Zke1MJJs8HdDnfua9KWjzPIj
 I9CRz3EqCPuFyc89QOHA84scoaXDtNpbjIyjGRoYD+rlvAPnVYAN7Z02MITDYct9TdKP
 PKLCTafDcpJXdvBYfnAvrg4PKIVmYYmzHA/Ano9+ZVzqw692yTdLZWi5G0wlez4dO5Io
 CQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900885; x=1793505685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lv7p0AUZ948zcVcPc4Q28K28YGEwBExkgg3ueLIutWo=;
 b=HmTdiy6dYEh0pdIEJYWeA3TM4PxmFdFuHBXOv5sQ+Ja6kVSFecx8hvlngr0/CtBXoN
 VXnCyxOAr438pbX/hcLI6cdkE8ga9jUIZuUjPnGl/k5gnF96GMd4obgcqXYPTMFmWsLF
 c9BG2eZlNOZn1ftrrRwymJgnDhGcBjJQUOLSnLPSh/aR9L0An+HK7lUqQL/Tc4cAYtVj
 tYtCUPLTeWrlHskvbIZmoUkUjHqlxlg4osdXKpghEDwV+C2T1Aqt55viI5ksz6DAWzzF
 NpPyioF693Ky52Ulc65JQzsw5+iAIo8v77xbjZEYpvaGXyZc4I4h0yqgCSXR0PGyDWzS
 FrDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUsSk5WM2I+EHvam66WkRdyGc44yqtSYB4IsyZ6gYO6iBxVtWeifRKqnaoffalAc/rqTYjWE8OFHk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKcUI4D39+IRxsLYN1lxtxq4X0qveC9rRSDpxWyni7KSQazd0Ru
 UPSEP8R6D8cMsjMtkJ/u7Q3EjJK8zPn3TwwrnO2XGDQ4ReTDM0vO+l4=
X-Gm-Gg: AYBFou1AMiluB3i6u801D2joplEVxuh9mg7eQJgZp1jh75AW9MWECABD91390ntARNY
 HdW+irpHfopDNMFp2f6W3+0mKTyJ94Y1a9lWybOWVLMrSshrzHxnAEDX4SvCbkFt9PrFvMiKo85
 bwx/eyPUfPEju1tloUXeJgbk4lnJKSdlUSLgkudZJewsR8h8uep5S4dGqHfaO5uFOm7HtLXPODZ
 ujqIfwCRijExMDkEBE/YAOERJZJPJxj4Ha/Y6Qp2/gx63AQKV6+nS6kKWZnRYf6LOfPcvbqFNQg
 5QenJoiWXhTZ3xmNiSKV/4iq7Wmi38NumUBrJufQQbsBUCtA4+k54xhf6/61/ko2erMnqRhCOyl
 d/LZ6bvbv/MpD37kZWTR1mDQRWMwo44nO0Ad88AJyCg7mKVATPUn0r9lNNR22jtE3dRJxaGrc28
 MgGlK2wizSc8iNwKyDuq3xhxvq+03T+cCqFYdx7UlIYsUJrTgCw5GL6q6eVUPdlmLbvfYLd3k31
 qd83ffZcuzExuLkTOwCzkffOuOsVz7eag55SSxMwTwKtjXtUGnmdLEHZlrRVSnX5mhvr29T7C5X
 +XGNAgvzkJ+q4KY=
X-Received: by 2002:a05:7022:5f09:b0:15e:6541:3099 with SMTP id
 a92af1059eb24-19933e10e21mr5393203c88.7.1792900884823; 
 Sat, 24 Oct 2026 21:01:24 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:01:24 -0700 (PDT)
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
Subject: [PATCH 00/13] Fixes for apple-gmux and runtime support
Date: Sat, 24 Oct 2026 23:59:36 -0400
Message-ID: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

Andre Eikmeyer (6):
  platform/apple-gmux: Write switch state to EFI on MMIO devices
  drm/amdgpu: Add Apple GMUX runtime PM support
  drm/amdgpu: Catch register access while GMUX keeps the GPU off
  drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
  drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
  drm/amd/display: Skip panel power savings on eDP links without a panel

Atharva Tiwari (7):
  platform/apple-gmux: Fix power for MMIO systems
  PCI: Disable pcie port and access on D3 on specific amd devices
  platform/apple-gmux: Fix MMIO interface
  platform/apple-gmux: Fix Interrupts for MMIO systems
  platform/apple-gmux: Add parameter to configure boot gpu
  platform/apple-gmux: Add check to detect FSS
  platform/apple-gmux: Add documentation about iMacs

 arch/x86/pci/fixup.c                          |  30 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  60 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  45 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    |  24 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
 drivers/pci/access.c                          |  18 +
 drivers/pci/pcie/portdrv.c                    |   2 +-
 drivers/platform/x86/Kconfig                  |   1 +
 drivers/platform/x86/apple-gmux.c             | 377 ++++++++++++++++--
 include/linux/apple-gmux.h                    |   1 +
 include/linux/pci.h                           |   7 +
 16 files changed, 554 insertions(+), 71 deletions(-)

-- 
2.55.0

