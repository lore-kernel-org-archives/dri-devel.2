Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372C606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHkWlCJB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A947C112705;
	Fri, 30 Oct 2026 10:27:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491AF10E594;
 Fri, 30 Oct 2026 10:27:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16634438E8;
 Fri, 30 Oct 2026 10:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7691F000C1;
 Fri, 30 Oct 2026 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356066;
 bh=qXU9qv97c9ueUGQgoteZbMQj/NhfWsxW+0okXup3quM=;
 h=From:Subject:Date:To:Cc;
 b=WHkWlCJBWwC9q1Tq8eYEWVJF/CcrKNU0HvDxMMI1b9ae2knEMhYgrO0SHPbGjD38U
 /1wpJ10RrwsGjSoFzCZQd47EjppGZmrDN9E6D+dnf5s1NGvPsHSxhnJrKYmraHjlMf
 D54gFW76nmcHQB6B5YIhqgv8kD2TpbxfxNfSrIMB6o5YDAV0rLzOwC0Wz67SOT6zzR
 uUHQEUuNRvbxRxGOt9YhIVwPFSLhFRDGLdNCwEBxUEOZDPzcjY0gujPQvOzaVoLlWI
 gp6BWXgaCwUWuPJJiqhtqdbWspYpuKIDbeJiqnSN2KQXGb1Wvx6F+bz8RodW2cTsd1
 q6Sgbc36eQpag==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v7 00/16] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Fri, 30 Oct 2026 11:27:32 +0100
Message-Id: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4XRQW7DIBAF0Ksg1plqAAO2V71HlQU2Q4Ia2y1QK
 1WUu1dOpCaVZXU7i/e/5l94phQp85ZdeKI55jiNvGV2x3h/dOOBIHreMi5RGrRYg08DJMpUIBd
 XCMLJHUCGTnbaChEay3eMfyQK8Xxj3/Y7xo8xlyl931JmsVz/AWcBCL2yvm9qXdXav75TGun0M
 qUDX8RZPpRayA1FAgI1piehlLB+raiH0mx2UYDQoNYWg6qtq1ZK9aSILaUCBO28QKMsBtQrRf8
 qAoXZUDQgeOelN1VnGtWtFPOkyK2/GEAIynhTYWfJmj/K9T5gos+vmGO5r8g7lwn6aRhiadmiD
 jH3MNK5wBIGAkEqvr9efwCNUBwOUwIAAA==
X-Change-ID: 20260708-drm-reset-state-flag-2fb2b5711f97
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Daniel Stone <daniel@fooishbar.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6189; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OYIj5AYWrS//huyL9uwr/eDy3UjrAiJrJd6/foYByd8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPCsUvtsreWrKk7pZMotZLh0XTvkx4fdJ57q/FqlFyG
 +s4BRYkdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJrKlkrOFZ0yjcZjn/OveJ
 Gq1P7n5vfk92F15lFpvic5zn4ZprZYLrGKLc3j3sW8cTFjN9v41xJGPDpJ6zS3/FX9W/+XjpEol
 LOy9qqV7d3H7kPG98s4OX0qRZFc1XOE6un1hm3HV7YS6H18I3AA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Userspace currently has no atomic way to bring a display pipeline back
to a pristine state. A compositor that wants to start from a known
baseline must explicitly set every property on every KMS object to its
default value, which requires tracking which properties exist and what
their defaults are. This is fragile and must be updated every time a
new property is added to the kernel.

This series introduces a new DRM_MODE_ATOMIC_RESET flag for the
atomic ioctl. When set, the kernel fills the commit with default
states for all KMS objects before applying the properties supplied in
the request. Properties not explicitly included remain at their
defaults. This allows userspace to describe the desired end state
declaratively, without caring about the current state or the full set
of properties.

The bulk of the series extracts the state insertion logic from each
drm_atomic_get_*_state() into standalone helpers, since the
fill_with_defaults path creates states through atomic_create_state()
rather than atomic_duplicate_state() and cannot reuse the existing
functions directly.

A driver-specific property is added to vkms planes for testing.
Standard properties are impractical for this: compositors like Mutter
enumerate all known properties, making it hard to isolate the reset
behavior in a test.

Mutter has a working implementation using the new flag, with a
vkms-based test exercising the reset behavior:
https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/5309

And we have IGT tests as well:
https://lore.kernel.org/igt-dev/20260916095159.2896630-1-mripard@kernel.org/

This series relies on all drivers implementing atomic_create_state.
The conversion is in progress but not yet complete.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v7:
- Fix a whole bunch of sashiko issues to deal with color_mgmt_changed,
  leases, partially leased devices (like a plane leased but it's crtc
  isn't) and the interaction with PAGE_FLIP_EVENT better
- Fix crtc create_state implementation for ssd130x
- Actually make it possible for a compositor to recreate the same whole
  state without passing ALLOW_MODESET
- Fix EDEADLK bugs with kunit tests
- Don't report DRM_CAP_ATOMIC_RESET on !atomic drivers
- Fix error handling in vkms for the new property
- Add more kunit tests for the new corner cases
- Link to v6: https://lore.kernel.org/r/20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org

Changes in v6:
- If using a lease, only considered the leased objects
- Fix amdgpu plane atomic_create_state implementation
- Link to v5: https://lore.kernel.org/r/20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org

Changes in v5:
- Fix bisection issue
- Improve the documentation
- Fix connector hotplugging issue
- Added kunit tests for drm_atomic_commit_fill_with_defaults()
- Link to v4: https://lore.kernel.org/r/20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org

Changes in v4:
- Improve the drm_atomic_get_private_obj_state and
  drm_atomic_get_connector_state array reallocations
- Return void on functions to insert an object state into a commit when
  it cannot fail
- Rename drm_atomic_can_create_state() into
  drm_atomic_implements_create_state()
- Move capability check from drm_atomic_commit_fill_with_defaults to its
  caller 
- Added IGT test
- Link to v3: https://lore.kernel.org/r/20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org

Changes in v3:
- Rebased on top of the latest atomic_create_state series
- Sebastian Wick created and tested this work with mutter and vkms
- Fix colorop locking
- Link to v2: https://lore.kernel.org/r/20260812-drm-reset-state-flag-v2-0-e96ce13317dd@kernel.org

Changes in v2:
- Fix bisection
- Add capability to let userspace know if it can reset the state
- Link to v1: https://lore.kernel.org/r/20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org

---
Maxime Ripard (15):
      drm/amd/display: Fix planes atomic_create_state implementation
      drm/solomon: ssd130x: Drop the init-only assumption in ssd130x_crtc_create_state()
      drm/atomic: Switch to krealloc_array() in drm_atomic_get_private_obj_state()
      drm/atomic: Use __GFP_ZERO instead of explicit memset in drm_atomic_get_private_obj_state()
      drm/atomic: Use __GFP_ZERO instead of explicit memset in drm_atomic_get_connector_state()
      drm/atomic: Create function to insert CRTC state into a commit
      drm/atomic: Create function to insert plane state into a commit
      drm/atomic: Create function to insert colorop state into a commit
      drm/atomic: Create function to insert private obj state into a commit
      drm/atomic: Create function to insert connector state into a commit
      drm/atomic: Add drm_atomic_implements_create_state() helper
      drm/atomic: Allow filling a commit with pristine object states
      drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults()
      drm/vkms: Switch container_of helpers to container_of_const
      drm/vkms: Add driver-specific plane property for testing

Sebastian Wick (1):
      drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   3 -
 drivers/gpu/drm/drm_atomic.c                       | 524 ++++++++++++++++++---
 drivers/gpu/drm/drm_atomic_uapi.c                  |  44 +-
 drivers/gpu/drm/drm_ioctl.c                        |   5 +
 drivers/gpu/drm/solomon/ssd130x.c                  |   3 -
 drivers/gpu/drm/tests/drm_atomic_test.c            | 313 +++++++++++-
 drivers/gpu/drm/vkms/vkms_drv.h                    |  11 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |  63 ++-
 include/drm/drm_atomic.h                           |   4 +
 include/uapi/drm/drm.h                             |  10 +
 include/uapi/drm/drm_mode.h                        |  17 +-
 11 files changed, 916 insertions(+), 81 deletions(-)
---
base-commit: 128013e9fec562672562dffd4ad468492f5915c8
change-id: 20260708-drm-reset-state-flag-2fb2b5711f97

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

