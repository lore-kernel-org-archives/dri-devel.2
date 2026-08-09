Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C0BC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 19:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20B210E1BB;
	Sun,  9 Aug 2026 19:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g1xTUeSg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16AFC10E19D;
 Sun,  9 Aug 2026 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=yHtI0GTJKZWQQM48YiGVBosfJ5t3iFf0mkcvrRXiOn8=; b=g1xTUeSg51O4bUdhefKhXMn48m
 eZ18qa9+xVNwavh1O83za4RYsnBbTQIOASFqd6Tt6pqUoXEfNsPpzHGC9dNroJIofjDNB7+zx4MSr
 DNIyTmV22h3Z6qqKOLg3Z1DsSmTDqVNJGl31TQivtH/2BUnX/c71WCfXfxin/RBnwKrFvxUq65W4o
 TS2gLQkwty41kO2rmEKrNKjapY9RI4aQOTv1R2zp1tkw0rzGo2vutoqtti6OhtGP9Au3rwtczllXv
 N9pmNFkyNtOH51zQPjMaojhuSjN/mIrTKqEUZwlwliQdgcwne/KtNxmlcO1GvqlwJ5wcNuA339yGg
 GKBtPP6Q==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wt982-00GH3T-VN; Sun, 09 Aug 2026 21:24:15 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/6] drm: Consolidate the wait timeout conversion helpers
Date: Sun, 09 Aug 2026 16:23:56 -0300
Message-Id: <20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSQqAQAwF0atI1gbaebiKuBD7qwEn0iqCeHcbl
 29R9ZCDChzVwUOKS5xsq0cUBtRP3TqCxXpTbOLclKZiqwsfsmA7D54w71DHWZYWCdKyqGxEvtw
 Vg9z/tWnf9wOy1b7vZQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=MRMSakOMqZA3Q6YErOvuIuxgMa52nLU22dBKpEwYEAI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqeNPYgZ913Y8c2sxGuDwnLGJ4MCKfBIKu5r1/0
 U3y0n1qt2iJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCanjT2AAKCRA/8w6Kdoj6
 qiKQCACNdTNhaEDzYocVFmwr90TRWOA6EWci83pGWlvszT4OpAlfoJs4nqDlHePAwbIrU5GVbWT
 frAbM3RODGBkfLM0+LVw0ImoiVuiEbczSth3GN8WZCMB2+7dzGHT/fz0LAxzoFWtHzJ91FKmkG5
 zoF1wK2FnP+1Kx5DhaOlvii1/Q0WxsJVeUFMuhxNFYIuXKxjDG6qRc0/pnQuFArMjb5CK7p3ZVI
 9N2K/dEHGzLBO3vQKyo4FRK0gQ64Pxt3ZvB2+14rQzAeguv+ydx7xggV/2QZR1pysCpjZRET6NE
 2uue9zvwDlEQumeFg6niMM01QH7ru7UBZt1RdVK/IQVQBc3g
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

Let me know your thoughts about it.

[1] https://lore.kernel.org/dri-devel/20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (6):
      drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
      drm: Add drm_timeout_rel_to_jiffies()
      drm/amdgpu: Use drm_timeout_abs_to_jiffies()
      drm/v3d: Use drm_timeout_rel_to_jiffies()
      drm/i915: Use drm_timeout_rel_to_jiffies()
      drm/vc4: Use drm_timeout_rel_to_jiffies()

 drivers/gpu/drm/Makefile                 |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  | 16 +------
 drivers/gpu/drm/drm_syncobj.c            | 33 --------------
 drivers/gpu/drm/drm_timeout.c            | 76 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/gem/i915_gem_wait.c | 17 ++-----
 drivers/gpu/drm/v3d/v3d_bo.c             |  3 +-
 drivers/gpu/drm/v3d/v3d_drv.h            | 10 -----
 drivers/gpu/drm/vc4/vc4_gem.c            |  3 +-
 include/drm/drm_utils.h                  |  1 +
 9 files changed, 87 insertions(+), 73 deletions(-)
---
base-commit: dc2f9f7fed1a8ea5290f9f60c6310d497e85e666
change-id: 20260809-drm-timeout-helpers-55473e4879d1

