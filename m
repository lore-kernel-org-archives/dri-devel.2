Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD174C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 05:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E918410E40F;
	Fri, 17 Jul 2026 05:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QkCa06tM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B870710E408;
 Fri, 17 Jul 2026 05:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784264400; x=1815800400;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=fHfaG4jHyMWC4dW3wcdi8xAK4ORm9jzAvGD7PqDtIiM=;
 b=QkCa06tMov4T/D1Iqw+7lCaom8DqQsyAXtXu4W0w3UU9a3qrFhSHcM3u
 EmsJoa7yklygYjOybf/nj2x17Cb7EkRI3KGZRz/51NrWVDTGCd5vWh999
 /T8YUciv9PmjXvrpiGEGUR5KGbBSMQHCVcMDfHk/rqGBt1qaDyd0YKtBI
 e5sOjNl9vprFIfVp6/QiOrP2SHTWLQdii6ru5W+dIIRvZ+VHVZCaReWcs
 mzHSHSUdng1VhnyBaVAbocrTRnCG4C7lzBRRTLClsLtqqKRXMitVoO4la
 u8LyQYIrYHIl9c9n4HAQhHpxEEItCaDD06lDyRwsSwc33TRoa90AKOPlV g==;
X-CSE-ConnectionGUID: kAK+AP7ORjuqeT/1nkRXDQ==
X-CSE-MsgGUID: +mz3RMwJS46KjSW5fK0/Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="102485884"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="102485884"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 21:59:58 -0700
X-CSE-ConnectionGUID: iYmAnj9/S0ulPozS6bXlIg==
X-CSE-MsgGUID: CpLxq+2+SyaLYbKGHh38NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="254915336"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.124])
 ([10.245.245.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 21:59:55 -0700
Message-ID: <7f10281e-88f5-4be5-8b42-367e7ce7c547@linux.intel.com>
Date: Fri, 17 Jul 2026 07:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: dim-tools@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PULL] drm-misc-fixes
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Dave, Simona,

New pull-request for drm-misc-fixes, slightly late!

Kind regards,
~Maarten Lankhorst

drm-misc-fixes-2026-07-17:
drm-misc-fixes for v7.2-rc4:
- Fix UAF in host1x, amdxdna.
- Handle invalid firmware log in ivpu.
- Fix error handling in panthor.
- Handle NULL pages and backup handles in ttm_pool_backup() correctly.
- Reject more invalid amdxdna command submissions.
- Improve unmap and error handling on gpusvm.
- Fix virtio deadlock and invalid gem detach.
- Fix wrong read in ivpu.
- Always synchronize for CPU in begin_cpu_udmabuf.
The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-07-17

for you to fetch changes up to faebb7ba1ac65fa5810b640df02ce04e509fdc11:

  accel/amdxdna: Fix use-after-free of mm_struct in job scheduler (2026-07-16 20:05:28 -0700)

----------------------------------------------------------------
drm-misc-fixes for v7.2-rc4:
- Fix UAF in host1x, amdxdna.
- Handle invalid firmware log in ivpu.
- Fix error handling in panthor.
- Handle NULL pages and backup handles in ttm_pool_backup() correctly.
- Reject more invalid amdxdna command submissions.
- Improve unmap and error handling on gpusvm.
- Fix virtio deadlock and invalid gem detach.
- Fix wrong read in ivpu.
- Always synchronize for CPU in begin_cpu_udmabuf.

----------------------------------------------------------------
Doruk Tan Ozturk (2):
      accel/amdxdna: reject user command submission without a command BO
      accel/amdxdna: reject command submission on devices without a submit op

Honglei Huang (3):
      drm/gpusvm: free the whole IOVA reservation on unmap
      drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap
      drm/gpusvm: publish dpagemap early to avoid device mapping leak on error

Jason Macnak (1):
      drm/virtio: Don't detach GEM from a non-created context

Jhonraushan (1):
      accel/ivpu: Reject firmware log with size smaller than header

Karol Wachowski (1):
      accel/ivpu: Fix wrong register read in LNL failure diagnostics

Linmao Li (1):
      drm/panthor: Check debugfs GEM lock initialization

Lizhi Hou (1):
      accel/amdxdna: Fix use-after-free of mm_struct in job scheduler

Maarten Lankhorst (1):
      Merge v7.2-rc3 into drm-misc-fixes

Matthew Brost (1):
      drm/ttm: Account for NULL and handle pages in ttm_pool_backup

Mikko Perttunen (1):
      gpu: host1x: Fix use-after-free in host1x_bo_clear_cached_mappings

Osama Abdelkader (1):
      drm/panthor: return error on truncated firmware

Robert Mader (1):
      udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf()

Ryosuke Yasuoka (1):
      drm/virtio: fix deadlock in display_info_cb by removing hotplug from dequeue worker

 drivers/accel/amdxdna/amdxdna_ctx.c      | 18 +++++++++++
 drivers/accel/ivpu/ivpu_fw_log.c         |  4 +++
 drivers/accel/ivpu/ivpu_hw_btrs.c        |  2 +-
 drivers/dma-buf/udmabuf.c                |  9 +++---
 drivers/gpu/drm/drm_gpusvm.c             | 53 ++++++++++++++++++++++----------
 drivers/gpu/drm/panthor/panthor_device.c |  5 ++-
 drivers/gpu/drm/panthor/panthor_fw.c     |  1 +
 drivers/gpu/drm/ttm/ttm_pool.c           | 34 +++++++++++++++++---
 drivers/gpu/drm/virtio/virtgpu_gem.c     | 14 +++++----
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  5 ++-
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  3 --
 drivers/gpu/host1x/bus.c                 |  4 +--
 12 files changed, 114 insertions(+), 38 deletions(-)
