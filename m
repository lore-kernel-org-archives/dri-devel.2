Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859AEC88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2820C10E9F3;
	Sun, 13 Sep 2026 20:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emZ62vl4";
	dkim-atps=neutral
Received: from mail-pz2-f32.google.com (mail-pz2-f32.google.com
 [74.125.228.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643B310E0B9
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:37:48 +0000 (UTC)
Received: by mail-pz2-f32.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so1003408a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789324668; x=1789929468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d+o4MSkuQ8bnuoNbaiZq6FM4PPIv2ZxLKihE5535AIA=;
 b=emZ62vl44wFeNzXmIfgQO9cxWhBEr6pXM6hPruDvBrZ18YB+gF4b27qUfdkKmN2WDx
 yRpF3/DHeBUNWJaeaNxsDB6CvynS3hsG7T07LU7DcD44KF/1sOfRp6s+F8aJpV0zmUdr
 D8ghOdc39gTOZXCXulMX6yCq7hca4zytJfUrYvzOsKsL8jF93pgyR7oI5AkTHoNSwu4z
 ZabU6J3Wu1y/WJLCuyHrjGmvvbkSnDMsIvc9/x8wMNV1IBYeqPbMLctcePY1WwyNvvuA
 pGiJTiiWgD6wRYjM36M6DwzicTy2tZJ9tV/JnOd/eHKABj7aZZLZ7ODS9LHsKeHh+76L
 LRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789324668; x=1789929468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d+o4MSkuQ8bnuoNbaiZq6FM4PPIv2ZxLKihE5535AIA=;
 b=TN6NCuju2KIVYks6VCM/43FitWbeHciZwTOFTdZB/YbHZ6hPUYIw7ZakNmyNcZkcxX
 s9wbp4Tdrn7nk0CF8Dwx2eZzwvkauKqtw5t497K9Lv3JAe6Sceh2dM4yLDODEVo6/JJG
 dQdHGkcBbfAA+ZtI9gU113fY/Y6jgJgIKbK77Fu8cLqaodT8NMahKPGppxBnz0xA1meC
 ajsV0dOnCaxALfTh9+Gv4X0xiXI3UugTiPJqHeiHufkw7PWa+H1cgREIO9Ym+iRkPRZY
 4rtk/LQtVCLZGL4qJw8ssdiOiFHw7cbL2qTIJe55t4sgntXmR8MTxzxvQSNgLyL7FpcE
 FU0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRxJOD26fsLKleRmeGzcFqJOH2GGpZejOF/KnJCw6oq3KD9XQXzAhGqQvC5+EUO3OAV7yUbVM5KrQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kaAe0ct+DcDZhqWUqvrB+d9Jmthb35SW80X9wRXX1B+FC1VXMJ
 bGB7u2vZx/sPomUfPEVnODXhsdJlqalM4+NgVil9Zw6z04V5OVHYxE4z
X-Gm-Gg: AYBFou02sIfr0JMLam9bGO6LTNwwv7Wi/XcAV1ZqSRdvRsvmitbx+Uspql47OL1gI57
 5Crb7lrHhstWU5VUrd6p/EfClSznIdcZnHVeQqhlyecLvugvrXCNATRP6Ead97qh8U314Oe9ucW
 kj9P2nPUPOs6fzmOWbfjl0foz6omXlq5T0yfAWs/6aNrbBEJWHxwleErEL47AjkRDl8a8haYpRp
 t5dkdggEQfdC4fp88nIEFZGp8PVzRAJMBtXP68gGOFHoF4WMI4vx9TjJxpNkKe6PgCs9V9QI47s
 orUFIxJ7Bz/7+UQHTwlbBfxJbYaEiccUow+wAEM0THxaE303JaO4/dddxRNjW04t2a1Vw5df5BW
 l/8cNV1SMCl/b4WFDjt6uNrUEYhFEfpdr/QcZBP7PyClWSn7+7AhuNUQWpDQXpfrH0K8oileKSB
 p3k/PHIIpWVE6WpB4HfDBJkcT8FNW2fvmWeqCxIrW835RzZkGw0oPdqGcqvbWoFrq2TcbZj9tU5
 K51Fw==
X-Received: by 2002:a17:90b:4990:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-39dbbe8b896mr14518295a91.5.1789324667744; 
 Sun, 13 Sep 2026 11:37:47 -0700 (PDT)
Received: from localhost ([95.190.112.239]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d9b08165fsm4118447a91.1.2026.09.13.11.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 11:37:47 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v4 0/3] gpu: nova-core: retain the GSP-RM log buffers
Date: Mon, 14 Sep 2026 01:37:31 +0700
Message-ID: <20260913183734.134307-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The GSP-RM log buffers are exposed through debugfs, but the entries are
owned by the Gpu that probe() builds, and the buffers themselves are DMA
allocations that cannot outlive the device. They are therefore gone as
soon as the GPU is unbound, and in particular as soon as probe() fails -
which is the case todo.rst singled out, and the one where a GSP log is
worth having.

Patch 1 gives the module data a DebugfsData that owns the debugfs root,
replacing the static that held it. Patch 2 adds a gsp_keep_logs module
parameter: when it is set, whatever the GSP wrote is copied into that
same DebugfsData and exposed under a "retained" directory until the
module is unloaded. Patch 3 drops the now completed task from todo.rst.

Changes since v3:
 - keep the copies in the module data rather than in a second global.
   The debugfs root moves there too, so one pointer now replaces both
   statics, and the global lock and its unsafe initialization are gone
   (Gary Guo)
 - with that, the module data owns the root and is dropped after the
   registration, so a module init that fails can no longer leave the
   directory behind. v3 fixed that by ordering the fields of the module
   data; it now follows from where the root lives, and the guard type
   is gone
 - keep a copy of the device name with the retained copies rather than
   a reference to the device, so that a GPU that is gone does not stay
   allocated until the module is unloaded
 - drop a re-check of the retained directory that could not fire

The pointer is published from inside the initializer of DebugfsData,
through the `&this in` form, and it is a raw pointer rather than a
reference: pin-init does not allow references to fields to be created
inside an initializer. Readers turn it back into a reference in one
place.

Testing was done on top of drm-rust-next with the TLV firmware images
installed. On a GB203:

  - with gsp_keep_logs unset, no "retained" directory is created and the
    entries disappear on unbind, as before;
  - with gsp_keep_logs=1, retained/<BDF>/{loginit,logintr,logrm} hold
    the contents the live entries had, all 64 KiB of each readable;
  - binding the GPU again recreates the live entries without disturbing
    the copies, and unbinding it a second time replaces them, leaving
    exactly one set behind;
  - with a failure injected after the GSP has booted, probe() fails with
    -EINVAL, the driver stays unbound, and the logs of that attempt are
    still readable;
  - with a failure injected into the Registration instead, the module
    fails to load, leaves no debugfs directory behind, and the next load
    comes up with its directory intact;
  - the copies are released on module unload, and three load/unload
    cycles leave nothing behind.

The parameter does need a value: the Rust bool param ops do not set
KERNEL_PARAM_OPS_FL_NOARG, so a bare gsp_keep_logs is refused, where the
C bool would have taken it.

No warnings, oopses or refcount complaints in dmesg throughout. Built and
checked with CLIPPY=1 and rustfmtcheck. checkpatch --strict is clean
apart from the MAINTAINERS note for the new file, which is already
covered by the existing "F: drivers/gpu/nova-core/" pattern.

John Hubbard's r000 series adds three more log buffers in gsp.rs.
Whichever of the two lands second needs a small rebase; the retained
copies extend to the new buffers by adding them to RetainedLogBuffers.

v3: https://lore.kernel.org/nova-gpu/20260912071842.622696-1-vladazaharova2018@gmail.com/
v2: https://lore.kernel.org/nova-gpu/20260815050826.306717-1-vladazaharova2018@gmail.com/

Vladislav Zaharov (3):
  gpu: nova-core: move the debugfs root into the module data
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst   |  12 --
 drivers/gpu/nova-core/gsp.rs           | 100 ++--------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 253 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     | 109 +++++++++--
 4 files changed, 362 insertions(+), 112 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs


base-commit: 66a2c223b620d844fe26c6bd4844d2a6a8c9dffc
-- 
2.55.0

