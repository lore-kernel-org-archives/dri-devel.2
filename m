Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AB2C5DF7D
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818A410E93C;
	Mon, 17 Aug 2026 21:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S1uTTx0s";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC88410E957;
 Mon, 17 Aug 2026 21:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=qioboRxmHCrsUgl5E1w4yi2cZ9jMCdSa5588K9II6Sg=; b=S1uTTx0sJScH6sEFMZ07JkQzOy
 8j5SLjHMCeNfLy+er2s6IgYsrZ1xLjdCEW6Xe3gfENyLbYqalBPXE7C4IsX0zVZbg+ivRgUjwkuUQ
 5MCcwbsL93fvNvK84ueA3VP5WxTGaAtfBo+iOQEbhZUlT++QwZDwjhWU3JQCcmfIt1PzXS1N9h4HG
 rdk2rLCAAuif6MXYL944SUvxfyf/W0WlzlbLweyQumZSCLZ26V8gmq1l5i5YL3C0rKgLNxMTb0UUY
 qymFnyEv5edHCRQdq3vLFvfjdnUKFlzobLiJrZ5WbMhq2YIQbdgAK8MJq4yMp3+pYnsxdyhqSb7nm
 Tqn3P1og==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww4Wm-00504Q-SH; Mon, 17 Aug 2026 23:05:53 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/6] drm: Consolidate the wait timeout conversion
 helpers
Date: Mon, 17 Aug 2026 18:05:40 -0300
Message-Id: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBBGr0Jm7Zi2tvytvIdh0dARJgFK2ko0h
 LtbOYDL95LvfTtECkwR2mKHQBtH9ksGdSmgH+0yELLLDEqoUtSiQRdmTDyTfyUcaVopRDRGVzf
 SddU4CXm5Bnry+6w+uswjx+TD5zzZ5M/+720SBSpHZaWFsVKbOw92Ynvt/QzdcRxfE0QaqbcAA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=GUh8F5lEe6i/zjTsxPjU+mqzjJe7zSNpz2GJCrYo454=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqg3epMX0yZwqs4H6zFe0JYiuTejnXOmu7AzPcJ
 YZQ5ieX4ZeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoN3qQAKCRA/8w6Kdoj6
 qlrfCADSaAly/2OtMAnS8UvY3HgGWhCpyR3Dj0bLuM5iiunBscHMfU1JSbl8MjDN8MF+I4lFtr0
 AVdtuVRRS28tyAGeqrJyC7xEZGtyKM6SmLEIZvy1PeyxnC9P8jQ+bqKrTPXR1nxHo8hbFjNgq22
 65kaXOVLZsRc1IMtpDBth0p6IIW673Czt5crs5WES5SxlUsT5qoBQalVlAD9ugPjtVN4PWkIvIR
 N2VR+JNsMiwu9zvemAmO7aARGujNB4nEP1SBOGnWtYOZW6EYC+5UFs0oz2gqviYbGCs1m0imYTp
 J+MJ172DpxWOW9MfW4XBllwpTBS3i3lS4INnKOoRf8pZZLKA
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
v1 -> v2: https://lore.kernel.org/r/20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com

- [2/6] Add comment discouraging the use of relative timeouts in uAPIs
        (Christian König)
- [3/6] Make it more explicit that any timeout that doesn't fit in a s64
        is mapped into an infinite wait (Christian König)

---
Maíra Canal (6):
      drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
      drm: Add drm_timeout_rel_to_jiffies()
      drm/amdgpu: Use drm_timeout_abs_to_jiffies()
      drm/v3d: Use drm_timeout_rel_to_jiffies()
      drm/i915: Use drm_timeout_rel_to_jiffies()
      drm/vc4: Use drm_timeout_rel_to_jiffies()

 drivers/gpu/drm/Makefile                 |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  | 20 ++------
 drivers/gpu/drm/drm_syncobj.c            | 33 -------------
 drivers/gpu/drm/drm_timeout.c            | 81 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/gem/i915_gem_wait.c | 17 ++-----
 drivers/gpu/drm/v3d/v3d_bo.c             |  3 +-
 drivers/gpu/drm/v3d/v3d_drv.h            | 10 ----
 drivers/gpu/drm/vc4/vc4_gem.c            |  3 +-
 include/drm/drm_utils.h                  |  1 +
 9 files changed, 94 insertions(+), 75 deletions(-)
---
base-commit: 5d2584e2ffaabf2d420edcb2d120209e151f8dce
change-id: 20260809-drm-timeout-helpers-55473e4879d1

