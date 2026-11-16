Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B56606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnT5ZRKl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F81710EE73;
	Mon, 16 Nov 2026 10:17:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1AF10EDB8;
 Mon, 16 Nov 2026 10:17:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1E4B6288F;
 Mon, 16 Nov 2026 10:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E859C1F000C5;
 Mon, 16 Nov 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794824247;
 bh=U+dk8zxecBPpXvi3qBnbGMk1N0yDLMp0PCkNhfOkKT0=;
 h=From:Subject:Date:To:Cc;
 b=mnT5ZRKlEkuDFF7qCmOqFhQ3XkJN4Rly+GXvNgecZ2AMkeNS0PiUr/EwUI4rrqLvK
 9AZjHgVIca56bQ7FWdyaj/yGnf4MMX0teaSdporWzqr0Yb+5043Nd6zyqJ5U1TkOJ5
 EViOhd8vwE9al5EJNzMzHrpoLzDwqMJulrPeSlGngoYaIz/OEptuEzROZrGZxM/czy
 B2U3dsgf+LMCxq9ebfYQZEjLiDFZrDkunffVlvbu1V8jJAHPNEYS6CIg86paZMoJRa
 Zi8Bn23eOJM7vhMj/zjAK0+eIc9tdoaurYiOl6QZUTo43IOBnlvtVVi9ZE+b5qHinh
 ud2QdYeoYLCZg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v11 0/9] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Mon, 16 Nov 2026 11:17:16 +0100
Message-Id: <20261116-drm-reset-state-flag-v11-0-378b3f7bef32@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4XSz07DMAwG8Fepcp6Rnb/NTrwH2iFpnBHBNkjLB
 Jr27qhDYkVVxNWHn+1P30WMXAuPYttdROVzGcvpKLYd0aYTw3M47hlKEttOSJQWHfaQ6gEqjzz
 BOIWJIb+GPcgcZTSOKHsnNp14q5zL58192m068VzG6VS/bmvONE//Ac8ECINyafC90b1Jjy9cj
 /z6cKp7MYtneVd6kg1FAgJ7OzApRS6tFXVXfPMWBQgejXGYVe+CXil6oVBL0YBgQiK0ymFGs1L
 Mr0JItqEYQEghyWR1tF7FlWIXimzlYgEhK5usxujY2ZXiForChuIAQbMxHDiw7dVK6e8KYeujf
 s4Fc0Jto0OTV4pfKNS6xc+5pIgsrZI64EohXDKtYAjn3nEOgTihsX8bc/2pduX3jzKW6affIoa
 RYTgdDmXadiiTtp5k4pjF7nr9Bq4NicBiAwAA
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
 Daniel Stone <daniel@fooishbar.org>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, freedreno@lists.freedesktop.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6588; i=mripard@kernel.org;
 h=from:subject:message-id; bh=v0sdrLG/K+JuJhtQfWtzbnA/krSPlauDxiVbbgl557E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bhjwv2/1jv21N1fO9tnuyQca/i0XtXzazf2giknV8
 ekK3/CLHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi780ZG44tMRB+7r/8rO7L
 ha+Or1tyo/T456osmfyShOzDn9b+XnS8riXrw7YJbiZVK189FoiX42Kss9J1S5t3S+ao82y1uM1
 y9VPcFxzsPe+iL7qMWcfrgmpkX/4uIZkG3snvzWSapkocKsgDAA==
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

A driver-specific property is added to vkms planes for testing.
Standard properties are impractical for this: compositors like Mutter
enumerate all known properties, making it hard to isolate the reset
behavior in a test.

Mutter has a working implementation using the new flag, with a
vkms-based test exercising the reset behavior:
https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/5309

And we have IGT tests as well:
https://lore.kernel.org/r/20261112162147.766264-1-mripard@kernel.org/

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v11:
- Reorder object state allocations to be more robust against lease revocation
- Bring back lease revocation check
- Link to v10: https://lore.kernel.org/r/20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org

Changes in v10:
- Stop trying to make partial lease work, they aren't meant to exist, so
  we can simply error out when they happen
- More tests for zpos and color management
- Fix DPU1 issues reported by sashiko
- Link to v9: https://lore.kernel.org/r/20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org

Changes in v9:
- Add a flag to know if leases have been revoked or are empty
- Handle the situation where a leased plane or connector being reset
  would disable an unleased CRTC
- Add more kunit tests to cover the new issues reported by sashiko
- Fix reset-related bugs in amdgpu, vc4 and msm DPU
- Add a vc4 kunit test for its reset related bug
- Link to v8: https://lore.kernel.org/r/20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org

Changes in v8:
- Fix more leases issues
- Drop applied patches
- Link to v7: https://lore.kernel.org/r/20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org

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
Maxime Ripard (8):
      drm/lease: Add a helper to tell whether a lease was revoked
      drm/atomic: Add drm_atomic_implements_create_state() helper
      drm/atomic: Allow filling a commit with pristine object states
      drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults()
      drm/amd/display: Take over the current stream and dc_state
      drm/vc4: Carry the HVS channel over to created CRTC states
      drm/msm/dpu1: Carry the mixers over to created CRTC states
      drm/vkms: Add driver-specific plane property for testing

Sebastian Wick (1):
      drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  50 +++
 drivers/gpu/drm/drm_atomic.c                      | 373 +++++++++++++++++++
 drivers/gpu/drm/drm_atomic_uapi.c                 |  44 ++-
 drivers/gpu/drm/drm_ioctl.c                       |   5 +
 drivers/gpu/drm/drm_lease.c                       |  26 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c          |  23 ++
 drivers/gpu/drm/tests/drm_atomic_test.c           | 435 +++++++++++++++++++++-
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c    | 105 ++++++
 drivers/gpu/drm/vc4/vc4_kms.c                     |  16 +-
 drivers/gpu/drm/vkms/vkms_drv.h                   |   3 +
 drivers/gpu/drm/vkms/vkms_plane.c                 |  63 +++-
 include/drm/drm_atomic.h                          |   4 +
 include/drm/drm_lease.h                           |   2 +
 include/uapi/drm/drm.h                            |  10 +
 include/uapi/drm/drm_mode.h                       |  22 +-
 15 files changed, 1171 insertions(+), 10 deletions(-)
---
base-commit: 02d46912debff86b107519f9557557b3f9c13df4
change-id: 20260708-drm-reset-state-flag-2fb2b5711f97

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

