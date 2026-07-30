Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0407C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C7E10EE49;
	Thu, 30 Jul 2026 09:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FaMBTnU4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1BF10E0F4;
 Thu, 30 Jul 2026 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785403122; x=1816939122;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=8zJ2ODH7/MclepUEYWefXl8XJmxB4ORKAJ3BUMskGSY=;
 b=FaMBTnU4k1Ossd9sgKzcSlWYga6tYIdCa9n6bS7InYYVbirZNixbyFX0
 RBMC6rtN128JSE6dm/qtbg1rwySvQhgIPJc+ox6NYY7R1t4He7BF84OQp
 yZghN1JLivfsXNFCSCujV9N5CU69k8rQckx7BlewHq/GqEgxNG5a2tjKB
 O7DpcKP2ThGn48glx53rFVFComrnyLlXwqvJr3TfwnAuuhFWduefHMED8
 38i49E+Y9g9Y9pmQHZEL1zTWCbIz2Hhzbrz2bJ965CsBwOsDj0P1jnQHP
 qJkw22GBezXRIpWikq67K23cvlLFUguLRJZr9f0B4YZEW6a0gTGBc3y8t Q==;
X-CSE-ConnectionGUID: OnMv99/aTn+i/VzYn4FKtw==
X-CSE-MsgGUID: yyi1vzhTSxCMGUHTGFHtyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86095538"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="86095538"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:18:41 -0700
X-CSE-ConnectionGUID: u3Hd7uJ7SkuIEkxuVgfJJQ==
X-CSE-MsgGUID: grGb5ZDTR/WpsFumaqhnfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="264523058"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.245.93])
 ([10.245.245.93])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 02:18:38 -0700
Message-ID: <178a513f-2d7f-4e3a-811b-cd0d9dc309eb@linux.intel.com>
Date: Thu, 30 Jul 2026 11:19:24 +0200
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

Hey Dave, Sima,

drm-misc-fixes for the next -rc!
As both Thomas and Maxime are out, I'll send -next as well.

Kind regards,
~Maarten Lankhorst

drm-misc-fixes-2026-07-30:
drm-misc-fixes for v7.2-rc6:
- vmwgfx:
  - Improve various size checks and limit checks.
  - Fix oops when submitting  invalid execbuf ioctl.
  - Correctly lock in vmfwgx fence signaling path.
  - More validation of execbuf ioctl.
  - Fix oops in vmwgfx vkms init failure path.
  - Overflow handling in shader path.
- Improve firmware validation in panthor.
- Fix small leak in bridge/display-connector
- Improve imagination trace points.
- Fix QAIC transaction length check.
- Restrict some DP bandwidth calculations to HDMI DFP.
The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-07-30

for you to fetch changes up to d6c075f797a672a6e3bd2fd44aee713801698ec2:

  accel/qaic: use sizeof(*trans_hdr) for transaction length check (2026-07-29 14:57:37 -0600)

----------------------------------------------------------------
drm-misc-fies for v7.2-rc6:
- vmwgfx:
  - Improve various size checks and limit checks.
  - Fix oops when submitting  invalid execbuf ioctl.
  - Correctly lock in vmfwgx fence signaling path.
  - More validation of execbuf ioctl.
  - Fix oops in vmwgfx vkms init failure path.
  - Overflow handling in shader path.
- Improve firmware validation in panthor.
- Fix small leak in bridge/display-connector
- Improve imagination trace points.
- Fix QAIC transaction length check.
- Restrict some DP bandwidth calculations to HDMI DFP.

----------------------------------------------------------------
Alessio Belle (1):
      drm/imagination: Fix value of HWRT address in pvr_job_create tracepoint

Alexander Kaplan (1):
      drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

Brajesh Gupta (1):
      drm/imagination: Update the trace point pvr_job_submit_fw()

Jose Maria Casanova Crespo (1):
      drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size

Laurent Pinchart (1):
      drm/bridge: display-connector: Fix I2C adapter resource leak

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Maíra Canal (1):
      drm/vc4: Zero the tile state data array before each BIN job

Muhammad Bilal (1):
      accel/qaic: use sizeof(*trans_hdr) for transaction length check

Osama Abdelkader (2):
      drm/panthor: reject firmware sections with oversized data
      drm/panthor: validate firmware interface structure sizes

Zack Rusin (12):
      drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
      drm/vmwgfx: reject DX_BIND_QUERY without a DX context
      drm/vmwgfx: clamp dirty-page range with min, not max
      drm/vmwgfx: take fman->lock around fence list mutation in fifo_down
      drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
      drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
      drm/vmwgfx: bound DMA command body size against suffix pointer
      drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init failure
      drm/vmwgfx: enforce cursor size limits for MOB cursors
      drm/vmwgfx: skip hash_del_rcu when validation context has no hash table
      drm/vmwgfx: use check_add_overflow for shader size+offset bound
      drm/vmwgfx: validate external BO copy bounds for both stride paths

 drivers/accel/qaic/qaic_control.c            |  2 +-
 drivers/gpu/drm/bridge/display-connector.c   | 11 +++++--
 drivers/gpu/drm/display/drm_dp_helper.c      | 12 +++++++
 drivers/gpu/drm/imagination/pvr_queue.c      |  7 ++--
 drivers/gpu/drm/imagination/pvr_trace.h      | 16 +++++++--
 drivers/gpu/drm/panthor/panthor_fw.c         | 47 ++++++++++++++++++--------
 drivers/gpu/drm/vc4/vc4_irq.c                |  2 +-
 drivers/gpu/drm/vc4/vc4_validate.c           | 29 ++++++++++++----
 drivers/gpu/drm/vmwgfx/ttm_object.c          |  7 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c         | 39 +++++++++++++++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 49 +++++++++++++++++++++++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      | 20 ++++++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c        | 13 +++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c   |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c     |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       | 13 +++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c   |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         | 17 +++++-----
 18 files changed, 230 insertions(+), 65 deletions(-)
