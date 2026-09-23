Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6EDC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A87D10E7D7;
	Wed, 23 Sep 2026 04:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="akS8YkeR";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0640D10E7D7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 04:56:06 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-87ac7657a24so234586b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790139365; x=1790744165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o1SOesHNHdnwoiL8FAjnK92erd43AfuOxzvjh4ET6B0=;
 b=akS8YkeRcf4OI0YFNcxmN8/YZQpGldU4xTisCsDpUSiQKfYJztNsLyR6zXLkJWroFW
 YBVfca3okCiXiA6usQzjWDi/2V5J8t1cHlzU/aDg7+mgwU5gNQHBxzWo22vJ3YAKZIhR
 +Lf3Jo6D0pMj5zG1B3Tk2m4mM0jKDwGqvh2IiO9RyYPcpGgOC35eFTUQ+OYI1Vf+pFCX
 BP65aGiyUGQSLwmH1cZwN3AsRI5GDTyB9iAugzjwgsTVFDxJjaGhBjTjIn8J6zXfRDzZ
 F0KbYRg2bGhHhTnvA392TlkZysimqfEU8N3UwuPThgeCRq/BPwCBCUdRt+Pvfzc5huNK
 Wrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790139365; x=1790744165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o1SOesHNHdnwoiL8FAjnK92erd43AfuOxzvjh4ET6B0=;
 b=swbZdYslXckKSgCRLpSCK46Y/Mkx6LF7qdvdtQekxuFqAegTF9A59d/0IBL5hZvczt
 +xUhTYfJSzCGViIk6xebk+cbe52+AswzfrnOrNSwz/v3El07+L1p7Hx1J5yOBNpbUMOC
 NLJ5wl4SRTefM0zmoBdZ5Ox4AvRfJpSm2kb1jHx2b1X8AuDfnE/Uaa/XvkNAvT8AOzsc
 KbVukB8jSGVJTtDONK57kewY19UqD7VThbKgaKAyv+9FiWHsMVtKIfy0OGgqyifJU4az
 6vNzJjbfAPfna9bAkPLIV3dx8qy8lh5SZgdx3kUQDqbaUoVq0zIUyiKaH/LH0K28Ggln
 eK4A==
X-Forwarded-Encrypted: i=1;
 AKwUvByPtgOdsPEDp+In90hbxtenp7m5eKs5FLItqYargEyu8LbyVrZDylKjGvGq0dtW2GLBV7y1QRJPMn0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBcmdlpVFfPCzWqSdXjQXhIeLTsHGHkLbr7Oej3U1h4u309pVV
 spTTsxxKF/V8/acEYRHsKbRxLu2xOaTjHLCcDz3Gng7k1xwj8VFgROLz
X-Gm-Gg: AYBFou14k3WLY4wbFLvQm3VuRWH4Ho9MIcLJ69ewzwPEsN6DI96AR7HRT4jy7HbkSu6
 59USyQm87hoqYexqYANHW51h9SpyQ6ztKHFpvJDXTXLhdFu0FUznZyIygJrNVYufAh9q5dLkPYF
 dc+qplnTtzHU487l4DnEoLcpQ/uIYquqzsnuNfGNO4CzyKzHRXjBrrykL8ekEdLUeCIX2Gfnmj5
 FgG7mdl2dMplf0ftwcd2mCfqBqrbOjkgm8ra+EzZ0YIRa4GjssGrUH7RLj9Y3xLmLsjkkGDmk2j
 R3S9Khx9OGp4ykyk0nN8sYKbyrCcIcNSv5SCyt/KzUVtfJPtsLSKqtO693mP8QEzYGgw2qIThVT
 4sfOjDyIKDGSf5UxmS3Ph6vfmG3FU4qE6bRBJUMGiHxboXRRoBQBERK5IN3W4TQOl8poXllxGsM
 K3le87/XKFmyRyp19nG9RjXBuCPH5Qz9fexaTihRb0a/H5q6Yq79B33nphmcCUnV4g+xX5amADX
 QAW
X-Received: by 2002:a05:6a00:430d:b0:874:706d:9631 with SMTP id
 d2e1a72fcca58-87d1c9b91b2mr1467960b3a.35.1790139363769; 
 Tue, 22 Sep 2026 21:56:03 -0700 (PDT)
Received: from localhost ([95.190.82.222]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1cec2d34sm664129b3a.14.2026.09.22.21.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 21:56:03 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v5 0/3] gpu: nova-core: retain the GSP-RM log buffers
Date: Wed, 23 Sep 2026 11:55:48 +0700
Message-ID: <20260923045551.229259-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes since v4:
 - no longer reset the pointer to the module data; debugfs_data() takes
   the bound device and returns a reference tied to it, rather than an
   Option<&'static> (Gary Guo)
 - set the pointer from the module initializer, through the binding
   pin-init makes for the initialized _debugfs field (Gary Guo). v4 said
   pin-init gives no access to a pinned field there, which was wrong
 - rebase onto current drm-rust-next
 - reword comments that no longer matched the code, and use the current
   Assisted-by format

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
  - the copies are released on module unload, and repeated load/unload
    cycles leave nothing behind.

The parameter does need a value: the Rust bool param ops do not set
KERNEL_PARAM_OPS_FL_NOARG, so a bare gsp_keep_logs is refused, where the
C bool would have taken it.

No warnings, oopses or refcount complaints in dmesg throughout. Each
patch builds on its own; built and checked with CLIPPY=1 and
rustfmtcheck. checkpatch --strict is clean apart from the MAINTAINERS
note for the new file, which is already covered by the existing
"F: drivers/gpu/nova-core/" pattern.

v4: https://lore.kernel.org/nova-gpu/20260913183734.134307-1-vladazaharova2018@gmail.com/
v3: https://lore.kernel.org/nova-gpu/20260912071842.622696-1-vladazaharova2018@gmail.com/

Vladislav Zaharov (3):
  gpu: nova-core: move the debugfs root into the module data
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst   |  12 --
 drivers/gpu/nova-core/gsp.rs           | 100 ++--------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 247 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     | 100 ++++++++--
 4 files changed, 347 insertions(+), 112 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs


base-commit: e1a9f41b896f0d57eb1165dd8a4c7446be6af638
-- 
2.55.0

