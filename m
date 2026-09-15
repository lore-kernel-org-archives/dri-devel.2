Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70999C88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946B410E309;
	Tue, 15 Sep 2026 19:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="noqRitbl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E798110E309;
 Tue, 15 Sep 2026 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=VQcgSRBZVg8fcFUVw9T/QgAY7H1wxZh0cJocF8+cq0Y=; b=noqRitblJoXh+Y2+9fk+5fKaSN
 hZNRS78lO9H4YW+qPoZA3zlE/o3cboJjwLWyFM7A2IwGmd5oTZX/Dk+Ipo8k5nMgvIPIGlEDXh7oI
 xpVc1v2cWlKpjWw2mukTydQDXimFiPEvYQ57D2pq7uaaQZVSsax/sZ3YnNwOJ5Tp6Lesg4c3o+yTJ
 /ojSb7m50A78jFH8vqphc63GaNiHqfnBt8/wJWvEdILpoAfy2P+CEI7zNrHEVbV/vB0u5Xhe2oKrV
 7ViCxHiipwx3W4e+mCQ40GBjYOBKWPQO+0hcROVLuRkts2C12oUzhjg8f7ANwfIvo2opljtaQ6F5F
 Q1zH7vPA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6Z3A-002bhq-Gz; Tue, 15 Sep 2026 21:42:40 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 0/7] drm: Consolidate the wait timeout conversion
 helpers
Date: Tue, 15 Sep 2026 16:42:15 -0300
Message-Id: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBCG4auQrq1pS3/AlfcwLiodYBKwpMVGQ
 7i7hZUmxuX7JfPMQiIEhEhOxUICJIzo7znKQ0Ga3t47oOhyE8GEZhWrqQsjnXEE/5hpD8MEIVK
 lpClBVqZ2nOTLKUCLz129XHP3GGcfXvuTxLf1v5c4ZVQ40EYyZblUZ+zsgPbY+JFsYBIfCDe/E
 ZERUzIlblrXray/kHVd38RFRXP8AAAA
X-Change-ID: 20260809-drm-timeout-helpers-55473e4879d1
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4469; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=NFjDU+6WENVW0r7cAfeYOqC6zQRX3HsRAv3rTOyEAw0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqqZ+oAKjwcuKHNEVziVjGXg5SygW5GgWjLPu7F
 Xo19qIKurqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaqmfqAAKCRA/8w6Kdoj6
 quQ/B/4yxxGzrhLo3VM8HiJnM4RsnfLaGepwQrDZQS/QC7q5fOmpigh2gs525ursHhdSk/TNiaz
 eAVJkJfW+8XSpkbLxmHoAqXEJsLzXxzeF/vhssLIw0Txc8yi/+Pj5jalGDLan9hfg9CKMo4Klyp
 l2yHvzsTLyJwFDpG20jcdeJnsjp+yVZsqFCzMdjfZm6/dNNTFwNS2bzAuk6lJqGXC6LugqnCSNk
 dl2lTV52F9AYi5D0ID8pvSoo4oX/7qiJAmIGtwGjiPqjrFEjJL615CnXm5l300YKXwspqt2BI+3
 B6wwM6ErlnL6KGBs+QHeQiNAOJurytFYZVR6IYA19cf53OsT
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

DRM wait ioctls express their timeout in one of two ways: as an absolute
deadline in ns, or as a duration in ns. The core has a helper for the first
form, drm_timeout_abs_to_jiffies(), which panfrost, lima, tegra, xe and
some accel drivers use. However, there is no equivalent for the second
form, so the drivers that take a duration convert it themselves.

For example, i915 has a local helper to handle the relative timeout case,
and v3d carries a copy of it. This series moves that conversion into a DRM
helper called drm_timeout_rel_to_jiffies(), next to the absolute variant,
and converts the drivers that were open-coding either form.

This series becomes particularly relevant as the new helper will be used
in the next version of the series "drm/vc4: Switch to DRM GPU scheduler"
[1]. With this series, we avoid another duplication of the
nsecs_to_jiffies_timeout() function (and thanks Tvrtko for the suggestion).

PATCH 1 moves drm_timeout_abs_to_jiffies() out of drm_syncobj.c and into a
file of its own, so that both helpers live together. PATCH 2 adds a helper
for the relative variant. Patches 3 to 6 convert amdgpu, v3d, i915 and vc4.
Finally, PATCH 7 renames the drm_utils.h header to drm_panel_quirks.h to
better express its meaning.

Let me know your thoughts about it.

[1] https://lore.kernel.org/dri-devel/20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com/T/

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com

- [2/6] Add comment discouraging the use of relative timeouts in uAPIs
        (Christian König)
- [3/6] Make it more explicit that any timeout that doesn't fit in a s64
        is mapped into an infinite wait (Christian König)

v2 -> v3: https://lore.kernel.org/r/20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com

- [1/7] Move the function definitions to a new header file: drm_timeout.h
        (Thomas Zimmermann)
- [1/7] Add Tvrtko's R-b (Tvrtko Ursulin)
- [1/7, 2/7] Apply adjustments to the function's kerneldoc (Thomas Zimmermann)
- [2/7] Fixed an inadequate overflow check in drm_timeout_rel_to_jiffies(),
        which allowed `nsecs_to_jiffies64` to wrap around on 64-bit systems.
	(Tvrtko Ursulin, Sashiko)
- [7/7] Rename drm_utils.h to drm_panel_quirks.h (Thomas Zimmermann)

---
Maíra Canal (7):
      drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
      drm: Add drm_timeout_rel_to_jiffies()
      drm/amdgpu: Use drm_timeout_abs_to_jiffies()
      drm/v3d: Use drm_timeout_rel_to_jiffies()
      drm/i915: Use drm_timeout_rel_to_jiffies()
      drm/vc4: Use drm_timeout_rel_to_jiffies()
      drm: Rename drm_utils.h to drm_panel_quirks.h

 drivers/accel/ethosu/ethosu_drv.c                  |  2 +-
 drivers/accel/ivpu/ivpu_gem.c                      |  2 +-
 drivers/accel/rocket/rocket_gem.c                  |  2 +-
 drivers/gpu/drm/Makefile                           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 20 +----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  1 -
 drivers/gpu/drm/drm_connector.c                    |  2 +-
 drivers/gpu/drm/drm_panel_backlight_quirks.c       |  2 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  2 +-
 drivers/gpu/drm/drm_syncobj.c                      | 35 +-------
 drivers/gpu/drm/drm_timeout.c                      | 95 ++++++++++++++++++++++
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           | 17 +---
 drivers/gpu/drm/lima/lima_gem.c                    |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |  2 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |  1 -
 drivers/gpu/drm/tegra/uapi.c                       |  2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                       |  3 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      | 10 ---
 drivers/gpu/drm/vc4/vc4_gem.c                      |  3 +-
 drivers/gpu/drm/xe/xe_wait_user_fence.c            |  2 +-
 drivers/video/fbdev/efifb.c                        |  2 +-
 include/drm/{drm_utils.h => drm_panel_quirks.h}    | 10 +--
 include/drm/drm_timeout.h                          | 17 ++++
 25 files changed, 140 insertions(+), 98 deletions(-)
---
base-commit: 5363e01e4ff03a204cab85292b89cf90c2d1b101
change-id: 20260809-drm-timeout-helpers-55473e4879d1

