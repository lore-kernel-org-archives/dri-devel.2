Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C005C5AC81
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 19:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B0110E35A;
	Thu,  6 Aug 2026 19:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OEKcUfjN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040EE10E35A;
 Thu,  6 Aug 2026 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786044323; x=1817580323;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=fFam/XsBi8UE8h7AfBNJxg1SISJykiA0yfSogHKdG/k=;
 b=OEKcUfjNZPHsHtpiQuVncWQ7N3CMoXcewSHp0tY0mZpVQh8PSjYzGY6p
 HmfJptMItQ9dPHDLqPo0zhXlwFUlh0bki/1prl3ZqsZzf6cfKWkbSUjEW
 vFss6uP6yifKqD4miKtv2MzJtm8gZ8oGuxPM3SKjBeur02U5CM/9KKel7
 Pz+axcOwiTQkoFT4wEux+chzxXPkas7VhuMxuHFjx4jyTGfK9PQNbO8KC
 0myYKF17+Nv++zA6Z8fc/KWEYNzyo9Pc/0RVgnVy+InAHEnq36px1eNUx
 5DUHUQoiW6JcjexlH8mr9+KmmMBZe36JXdEnWBWXSPcaBI2WKD/H8E2T+ g==;
X-CSE-ConnectionGUID: ECgcDql9TxOKSLQIfXIGkg==
X-CSE-MsgGUID: aLMZrKfeTtGbG2e8s7IMLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86659991"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86659991"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 12:25:22 -0700
X-CSE-ConnectionGUID: Ee/oRbV8TGadROQDJFo1qg==
X-CSE-MsgGUID: XARNJuPRQrqLZlA/WlMmaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="286867284"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.210])
 ([10.245.244.210])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 12:25:18 -0700
Message-ID: <415659f6-5199-4078-8319-22d7529e777d@linux.intel.com>
Date: Thu, 6 Aug 2026 21:26:19 +0200
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

Hi Dave, Sima,

Here's the pull request for v7.2-rc6!
Other maintainers are still out, so I'll followup with drm-misc-next once I applied the dmem cgroup eviction patch series.

Kind regards,
~Maarten Lankhorst

drm-misc-fixes-2026-08-06:
drm-misc-fixes for v7.2-rc6:
- panthor & shmem helpers: Check vma range inside pmd fault handler.
- panthor: handle empty firmware sections correctly.
- bridge/ps8640: Forward aux transfer errors.
- amdxdna: Improve error handling in amdxdna_insert_pages.
The following changes since commit d6c075f797a672a6e3bd2fd44aee713801698ec2:

  accel/qaic: use sizeof(*trans_hdr) for transaction length check (2026-07-29 14:57:37 -0600)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-08-06

for you to fetch changes up to e0d2b5902c5c0d3943af95728753aae165ed1346:

  drm/panthor: Check VMA boundaries for PMD mappings (2026-08-06 09:44:35 +0200)

----------------------------------------------------------------
drm-misc-fixes for v7.2-rc6:
- panthor & shmem helpers: Check vma range inside pmd fault handler.
- panthor: handle empty firmware sections correctly.
- bridge/ps8640: Forward aux transfer errors.
- amdxdna: Improve error handling in amdxdna_insert_pages.

----------------------------------------------------------------
Christian A. Ehrhardt (2):
      drm/shmem_helper: Check VMA boundaries for PMD mappings
      drm/panthor: Check VMA boundaries for PMD mappings

Lizhi Hou (2):
      accel/amxdna: Fix page-insertion errors in amdxdna_insert_pages()
      accel/amdxdna: Fix locally exploitable BUG_ON in amdxdna_insert_pages()

Maíra Canal (1):
      drm/v3d: Serialize the scheduler timeout handlers

Osama Abdelkader (1):
      drm/panthor: skip zero-sized firmware sections

Pengpeng Hou (1):
      drm/bridge: ps8640: propagate AUX transfer register errors

 drivers/accel/amdxdna/amdxdna_gem.c    | 47 +++++++++++++++++++---------------
 drivers/gpu/drm/bridge/parade-ps8640.c | 27 ++++++++++++++-----
 drivers/gpu/drm/drm_gem_shmem_helper.c |  6 ++++-
 drivers/gpu/drm/panthor/panthor_fw.c   |  3 +++
 drivers/gpu/drm/panthor/panthor_gem.c  |  6 ++++-
 drivers/gpu/drm/v3d/v3d_drv.h          |  6 +++++
 drivers/gpu/drm/v3d/v3d_sched.c        |  9 ++++++-
 7 files changed, 74 insertions(+), 30 deletions(-)
