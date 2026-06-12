Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E63CD98D9
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922EE10EA47;
	Fri, 12 Jun 2026 13:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B1o03+fw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A6C10EA46;
 Fri, 12 Jun 2026 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781272455; x=1812808455;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qN4yzoth1LaW60vFJEAmmrb4qCXdJVnNa0CSkClKJrk=;
 b=B1o03+fwMvddiAS0G8blmoVdyNbBG6mz7mN9NsVVwKOHoOuiAssqk3NM
 WhQIYtk9OIU3/sI5jQb9czoPctJku8zMbFFBM8x30anh1R5abNFbhbitN
 //BcvXV/LZuJocXMCaxwfZ3BbiyeCgMKnFeqcbr/ayajvE5ZkjAmufDI6
 KgbA3luy6XkbcrxY1Z3r8GJJ3HUd2hMFXqY9qIs2Ubva2USjvT7m8rIOo
 cdtxDq/BM1c5g1vKeK+oaJ+qinbUNe8inp97Rn4LNSfw+nzchLavp7xaM
 9wc594eUx353ITxMdcNZcJbcodEO+dAKobc5/wFRxCgSevvx2V+fB9i6f Q==;
X-CSE-ConnectionGUID: 5K7Y454vQFK7tl2r1C+ZUw==
X-CSE-MsgGUID: 0UP+TsluTVaof7+Qk0hiDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82163285"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82163285"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:15 -0700
X-CSE-ConnectionGUID: VfAvi7N8QpSq/D+9VuxTEw==
X-CSE-MsgGUID: uy1KPicUTYyGPIYdxBHaeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="242446517"
Received: from slindbla-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.68])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:11 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 John Falkowski <john.falkowski@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, LMKL <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/4] Xe driver asynchronous notification mechanism
Date: Fri, 12 Jun 2026 15:53:36 +0200
Message-ID: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There is a need to inform user-space clients when a rebind worker
has ran out of memory so that it can react, adjust its working-set
and restart the job. This patch series aims to start a discussion
about the best way to accomplish this.

The series builds on the core "general notification mechanism" or
"watch_queue", and attaches a watch queue to each xe drm file.

The watch_queue is extremely flexible and allows filtering out
events of interest at the kernel level. There can be multiple
listeners.

Patch 1 Implements a restart IOCTL for rebind-workers
      paused on OOM.
Patch 2 Adds fault-injection into the rebind worker for
      testing.
Patch 3 Adds a DRM_XE_NOTIFY watch_type.
Patch 4 Implements watch_queue event sending from within
      xe.

igt series:
Test-with: https://patchwork.freedesktop.org/series/168429/

Compute UMD side is not available yet. Will be available before
final review.

Thomas Hellström (4):
  drm/xe: Add DRM_IOCTL_XE_VM_RESTART IOCTL
  drm/xe: Add fault injection for rebind worker -ENOSPC
  watch_queue: Add a DRM_XE_NOTIFY watch type and export init_watch()
  drm/xe: Add watch_queue-based device event notification

 MAINTAINERS                          |   1 +
 drivers/gpu/drm/xe/Kconfig           |   1 +
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_debugfs.c      |   4 +-
 drivers/gpu/drm/xe/xe_device.c       |   8 ++
 drivers/gpu/drm/xe/xe_device_types.h |   6 ++
 drivers/gpu/drm/xe/xe_vm.c           | 135 ++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm.h           |  13 ++-
 drivers/gpu/drm/xe/xe_vm_types.h     |   3 +
 drivers/gpu/drm/xe/xe_watch_queue.c  | 111 ++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_watch_queue.h  |  20 ++++
 include/uapi/drm/xe_drm.h            |  91 +++++++++++++++++-
 include/uapi/drm/xe_drm_events.h     |  62 ++++++++++++
 include/uapi/linux/watch_queue.h     |   3 +-
 kernel/watch_queue.c                 |  13 ++-
 15 files changed, 462 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.c
 create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.h
 create mode 100644 include/uapi/drm/xe_drm_events.h

-- 
2.54.0

