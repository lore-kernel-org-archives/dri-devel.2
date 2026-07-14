Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB6AC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D015610E721;
	Tue, 14 Jul 2026 21:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MS/tHf+o";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED54B10E721
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:15:41 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso7112205e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784063740; x=1784668540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RCq7Nx8/0JTWLcWo9D6VA1wUiUAA6aMWpwH1k5hkv5c=;
 b=MS/tHf+oZlSwzDDENqfEjNvLETL6eRLHYknVTPATeAJMh9PpBktRasYRLZxLbA/HNN
 xFxz7a06vbHNhvRj+Lzn/jAVY3KwR4wffW17WmV61xbH327C2xCmoBqtl66HJ1VW3aI+
 sq7GJvcmroTiEBl5If1FKQ8xdVSvCjHRIY/q6BapeHZSVrDK7GnwtMNaTaA1v0lrhQpA
 XIah8kvzyIfEJZCMoMES12SMESxL66vuGty7/vGpmdU3YeTc+e+XM0R8pv9m/eFyojNn
 OmUGMopdW7+o92tcHDBc/SHtjiS0ED0/hNV22v4jQVspPPhi4dCcuJwZenf3Olt47Siz
 YPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784063740; x=1784668540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RCq7Nx8/0JTWLcWo9D6VA1wUiUAA6aMWpwH1k5hkv5c=;
 b=rGSJk+giMwImbEy9usHw4ltYySB6yAqNm9s3iMCx8nmioedaZzsXLH2E0/9JlyLcBE
 uYlmd4QD+oi6/0m20bV1nG0nDW280v4ToAuNFWWvb5TehCNXJX9/h8m5Kpgo4IyVkUdQ
 uif8y/FDtfTSXlzN9aEsgszAWfmooay8243kDjQ3PikJVJOJ4cNgdNsh0WUuzyK0DGAM
 KejR+o8FfjNtnD70SVVw1Vc225hinHKO1NeSkHeMARIagnmXd6+98jBnHJYghk9oquaQ
 cu0ciaKeNBw4ZIjn4rV4OU2+TUkyr2Q1PZNPkQUe/d3qHJ3/V/ghsVePsrn6m4/1BAyn
 ZySg==
X-Gm-Message-State: AOJu0YyhORPI6ehQdwl+T8nCC/DXgO5rZAGfnPErwMVTTRtuAGdJWVWR
 y8RNlhx4ErOnCiXRwd3nPAasGqln5UXs0FeMlvevHd8BPhGnz8II2Exw
X-Gm-Gg: AfdE7cnNuv4bc6ZCGV6kfx36oX0tU5eusRPATq38SLAdEyJrz3J0iCuYnlkTTw0YwsR
 /bovmY35IZBHRwNkgCeeGmjjzrflTDcuKr76TKSkaX6n6QHjVJiuTns2XhivGqm9k+qEc2kwcq+
 KBURFxGSjjPhkKndCwKvY8qji6Gd9UDsIk5dC+POneeXbz+2HFF0lEhOKovzcfjGcxlbXA+B5yU
 pCKDnKv4aFgeb+bZ0SEzLbTdOd7OPPbzas9zRVQzosil89D8fFMinvpPmG5nx2QoXi7uUb7kR4B
 +UDObu8p/lZ/sBtVNz1bGV1Ad/rCvF/i+w7RyM4dtXuQ7D98nIrRwXiaJ0pv/LPtKGmXRON7loa
 SHdWtORyxv26fwk3c+qbLkJN06pdO+vyiWrGpg9vgInluctdQuhThj2qiqK/KugwaadTph/41Be
 VtBc0wbDMdzb1p2Imszi2u
X-Received: by 2002:a05:600c:6387:b0:492:7142:f46e with SMTP id
 5b1f17b1804b1-493f87d8583mr168232975e9.2.1784063740186; 
 Tue, 14 Jul 2026 14:15:40 -0700 (PDT)
Received: from fedora ([94.205.182.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm149843875e9.12.2026.07.14.14.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:15:38 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 0/6] drm/nouveau: GSP telemetry via RUSD,
 and fdinfo telemetry exposure
Date: Wed, 15 Jul 2026 01:14:23 +0400
Message-ID: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
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

On the GSP firmware, nouveau reports nothing about the GPU. The GSP owns
the sensors, so the legacy nvkm therm/clk/volt hwmon paths never run, and
monitoring tools have no data to read.

GSP on later firmware does publish all of it through a stable interface.
It maintains a shared-memory region called "RM User Shared Data" (RUSD),
which the firmware fills with all the relevant sensor readings like power,
temperatures, clocks, and many others. Consuming it needs only two
internal subdevice controls: INIT_USER_SHARED_DATA to register the buffer,
and SET_DATA_POLL to tell the GSP which data groups to poll and how often.

This series makes nouveau a RUSD client and exposes the data through two
main surfaces:

  - hwmon, for the values that map onto standard channels: GPU and memory
    temperature, GPU/board/VRAM power, power cap. 

  - sysfs, under /sys/class/drm/cardN/device/rusd/, for everything hwmon
    has no channel type for: clocks, utilisation, pstate, throttle reason,
    ECC counters, PCIe error counters, and everything exposed to hwmon as
    well. One value per file according to sysfs convention.

Polling is demand-driven. GSP polls a group only while a client is reading
it, and a group idles off after 10s after the last read. Polling costs
power, so nothing is polled unless someone is looking. A section that has
not been polled yet, or that the board does not support, reads -ENODATA.

The sysfs interface is documented in
Documentation/ABI/testing/sysfs-driver-nouveau.

While the original scope was RUSD support only, monitoring tools needed
two extra additions to complete the picture:

  - VRAM size and usage on sysfs (patch 5): since this series adds a sysfs
    interface for nouveau, it's better to expose VRAM metrics there rather
    than force monitoring apps to pull in libdrm for the GETPARAM memory
    ioctls.

  - fdinfo (patch 6): nouveau implemented none at all, and monitoring apps
    could not show per-process GPU and memory usage. It now reports
    per-client memory and per-engine busy time, accounted from the DRM
    scheduler that the EXEC/VM_BIND path already uses.

Limitations, caveats, and additional considerations or questions:

  - RUSD needs r570 or newer GSP firmware; r535 does not have the needed
    controls. Pre-GSP and r535 behavior is identical to what it was: the
    rusd/ group is not created, and hwmon keeps its current behavior.

  - This is all read-only telemetry. Clock, voltage, or power control is
    through other interfaces out of scope of this series.

  - The sysfs interface exposed here should be stable and valid for nova
    as well. RUSD is stable and only grows more fields with newer GSP
    firmware (e.g., fan telemetry gets added in r580), so it is possible
    to keep the same interface as we use newer firmware or as we move to
    nova and any potential considerations should be ironed out before this
    gets merged and the interface gets frozen.

  - amdgpu offers a single binary blob with all the telemetry embedded in
    addition to the sysfs sensor files. This series currently only exposes
    sensor files, but it is possible to add a similar binary for a v2.
    This mainly offers a more efficient way to read the telemetry as
    clients would read only a few files instead of reading all of them.

  - The last two patches don't depend on RUSD and work on every GPU. But
    they are here because they complete the sensor telemetry story. I am
    happy to split them into their own series if that is preferred.

Userspace WIP work built on this sysfs surface exists in form of nouveau
backends for nvtop, LACT, and a NVK HUD:

  - nvtop: https://github.com/mohamexiety/nvtop/tree/nvtop-nouvtop

  - LACT: https://github.com/mohamexiety/LACT/tree/lnouvct

  - NVK HUD:
    https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39898

None of these are merged yet and exist for testing only. Upstreaming will
begin when this series gets merged and the interface is stable.

Mohamed Ahmed (6):
  drm/nouveau/gsp: vendor the RUSD header
  drm/nouveau/gsp: add RUSD telemetry support
  drm/nouveau: add GSP hwmon support
  drm/nouveau: expose RUSD telemetry via sysfs
  drm/nouveau: expose global VRAM size and usage via sysfs
  drm/nouveau: expose per-client GPU usage via fdinfo

 .../ABI/testing/sysfs-driver-nouveau          | 167 ++++++
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/nouveau/Kbuild                |   1 +
 .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  33 ++
 .../drm/nouveau/include/nvkm/subdev/rusd.h    | 114 ++++
 .../gpu/drm/nouveau/include/nvrm/nvtypes.h    |   3 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c       |  16 +
 drivers/gpu/drm/nouveau/nouveau_chan.h        |   2 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  22 +
 drivers/gpu/drm/nouveau/nouveau_drv.h         |  29 +
 drivers/gpu/drm/nouveau/nouveau_exec.c        |   3 +
 drivers/gpu/drm/nouveau/nouveau_gem.c         |  16 +
 drivers/gpu/drm/nouveau/nouveau_hwmon.c       | 375 ++++++++++---
 drivers/gpu/drm/nouveau/nouveau_sched.c       |  87 +++
 drivers/gpu/drm/nouveau/nouveau_sched.h       |  11 +
 drivers/gpu/drm/nouveau/nouveau_sysfs.c       | 311 ++++++++++
 drivers/gpu/drm/nouveau/nouveau_sysfs.h       |  10 +
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c |  26 +
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c  |   1 +
 .../nouveau/nvkm/subdev/gsp/rm/r570/Kbuild    |   1 +
 .../nvkm/subdev/gsp/rm/r570/nvrm/rusd.h       | 303 ++++++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c  |   1 +
 .../nouveau/nvkm/subdev/gsp/rm/r570/rusd.c    | 531 ++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |   7 +
 24 files changed, 1990 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-nouveau
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/subdev/rusd.h
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c

-- 
2.55.0

