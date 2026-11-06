Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9B606D80A
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnPXfDJH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81A810EA75;
	Fri,  6 Nov 2026 15:11:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D4F112BCD;
 Fri,  6 Nov 2026 15:11:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F52843461;
 Fri,  6 Nov 2026 15:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6971F008A5;
 Fri,  6 Nov 2026 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793977910;
 bh=5PCTieHW/ReyuPu3rgS6AWSeGEwuh1j7rISPeH6NvNg=;
 h=From:Subject:Date:To:Cc;
 b=CnPXfDJHvTmNpxdFueJtgjRlF0M0E/s0rJjfBSE9wslFwp15tBShMfKIZmwJvZdg4
 GTyzPyQSMWiVPqzOW5xRf2GTl7mgG3zzydxC8zS4/RWTycfvP3x/pQaj3D1rnyIAcD
 c3CINNjVgSwcoEVR7dNWNa+6/ZIH+bu3FXaPjIIVP94KprzlLZRmwz1RKtiAUoA61R
 cNEJOGUVDhZjz+XHklcWjFZneRgG5bPe/HpSREuPU4QRzersLeQ/GkgZwZ5aHKvxnf
 iSzpw0a1gKeaXhPVL03oYyjtTLOcvIL9pyiajhIQLf/weljgb1igmhkmhOlNmVfPdo
 jhl+XMPLtKhPw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v8 0/7] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Fri, 06 Nov 2026 16:11:38 +0100
Message-Id: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4XSTWrDMBAF4KsYrTNlJFk/9qr3KF3I1sgRje1Wc
 k1LyN2LndIkGNPtwHxvGN6ZZUqRMquLM0s0xxzHgdWFPRSsPbqhI4ie1QUTKDQatOBTD4kyTZA
 nNxGEk+tAhEY0ynAeKsMOBXtPFOLXyr68Hgp2jHka0/eaMvNl+g84c0BopfFtZVVplX9+ozTQ6
 WlMHVvEWdwUy8WOIgCBKt0Sl5Ibv1XkTal2b5GAUKFSBoO0xpUbpbxT+J5SAoJynqOWBgOqjaL
 +FI5c7ygKELzzwuuy0ZVsNoq+U8TeXzQgBKm9LrExZPRGMXeKxB3FAEJJSpEjR9rKB+VyrUGij
 8+Y43TtAmtcJmjHvo9TXXjhbEtU8Sa4pTU95ezWxtXFGs1RrdHDCP2YlsUhxO73krUiPCjrOUk
 pLT7GX34A3PLEJNsCAAA=
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
 amd-gfx@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11163; i=mripard@kernel.org;
 h=from:subject:message-id; bh=D+cXHWB3ZYIbADwVy64IUvfY1S88A4r6Lt+bz906HkI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlv3+k9fKnI86ZK5O/7mw0TlF5XvE1+XrdGJutL/0V+Z
 f8r+W4TOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEFFwYG96kmfCn2fW8PrP4
 8gPFyp1ng3RXep6cFLzd8GWEyN45h4M+Cneb1UxpTryizB6tyTa9ibGGszWcyejaidzdfwz/y6/
 pdbks1T9nD3PvlPI1Qs+M7iTW8h35nX1w1tXgCrEKPpYdB6cBAA==
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
https://lore.kernel.org/r/20261030105135.268065-1-mripard@kernel.org

This series relies on all drivers implementing atomic_create_state.
The conversion is in progress but not yet complete.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
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
Maxime Ripard (6):
      drm/amd/display: Fix planes atomic_create_state implementation
      drm/atomic: Add drm_atomic_implements_create_state() helper
      drm/lease: Add a helper to tell whether a lease was revoked
      drm/atomic: Allow filling a commit with pristine object states
      drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults()
      drm/vkms: Add driver-specific plane property for testing

Sebastian Wick (1):
      drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   3 -
 drivers/gpu/drm/drm_atomic.c                       | 407 +++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_uapi.c                  |  44 ++-
 drivers/gpu/drm/drm_ioctl.c                        |   5 +
 drivers/gpu/drm/drm_lease.c                        |  26 ++
 drivers/gpu/drm/tests/drm_atomic_test.c            | 322 +++++++++++++++-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   3 +
 drivers/gpu/drm/vkms/vkms_plane.c                  |  63 +++-
 include/drm/drm_atomic.h                           |   4 +
 include/drm/drm_lease.h                            |   2 +
 include/uapi/drm/drm.h                             |  10 +
 include/uapi/drm/drm_mode.h                        |  17 +-
 12 files changed, 895 insertions(+), 11 deletions(-)
---
base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
change-id: 20260708-drm-reset-state-flag-2fb2b5711f97
prerequisite-message-id: 20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org
prerequisite-patch-id: 3fd105fbfdbb4eee1f8ae9682b359477d5c2d610
prerequisite-patch-id: ed1d1dd244e64b18c5682800b546ebb2d0f44ec8
prerequisite-patch-id: 6b00324107d28bfe6ccd346730c6370d8f8362c4
prerequisite-patch-id: bac8bfa53c3c77a832500f711322530e39d26c74
prerequisite-patch-id: 60002e0ea0141b4051f2062152244b545450ffdf
prerequisite-patch-id: a82ef0b22909efd3a2f1a779e27ad60b08554203
prerequisite-patch-id: 4d4db6fb993ce12a03f5f22e07b060defc28b7d8
prerequisite-patch-id: 7a716ac0b6df5a2d9423bfa09457e7c2ae11e35f
prerequisite-patch-id: 35c60176b5a45a76a30285767fba4f83c5059868
prerequisite-patch-id: 23ef4052a7a932ec4611b640d4323e0f93760a6d
prerequisite-patch-id: f6a08bc40145c9a61508a37fe632e007c58566b9
prerequisite-patch-id: 942ec51b8579c4a7d5652d390dbcaa6fe1ef35bb
prerequisite-patch-id: cac9b8740c50ed002bdb7df8471c4493a53948b0
prerequisite-patch-id: 083d50c81b3609bc6756a2b9c89b30c5918dbcd3
prerequisite-patch-id: 97dd764d28e34d6c1fd346602931c1688aa4fe8d
prerequisite-patch-id: 566c8a35a9734a8e8a254afcc0fbd9765c980334
prerequisite-patch-id: a2ae7568eef2833217f55eb9528e2f846c73f993
prerequisite-patch-id: 4bdc653ad663151585ed7d71ed9f70ac702301fa
prerequisite-patch-id: ee3f427f087dde1290f0c0a3e821379427552961
prerequisite-patch-id: d14cd6008b88c7c9b61ca5241c961c4747a6fdfe
prerequisite-patch-id: c642e4fcebdbfc0ab86bba68c957ad5bbe62ef58
prerequisite-patch-id: 71afb7db95568dfa686ab670039ba60faeb91914
prerequisite-patch-id: 6557c88b83cd8d2ded0e4d70378c9a868659fea0
prerequisite-patch-id: 4020d12428794416f75edb398d84a6a14905f588
prerequisite-patch-id: a4806b41921baa3b8a3039d5431e099138fe6fa6
prerequisite-patch-id: 7a742e65aa5d69a733376641d0eb45281239b866
prerequisite-patch-id: ba3e625c15aa8e34747292c95ea9158b0cb98b34
prerequisite-patch-id: ba92010fead3c007e2cbaeb15bce922eb304ccac
prerequisite-patch-id: 2fc97bb7478092919001b21d2455a73373a5ba73
prerequisite-patch-id: 97a28c8af17b043429e3b40325576f74518ff802
prerequisite-patch-id: 37ae6417556eea439aab01725cfd920c1107e630
prerequisite-patch-id: 3f8725771832d7cccd8c88a33b4fac362a2a1221
prerequisite-patch-id: 5d51033ca88aa46e8347396cdc17fd5473636c13
prerequisite-patch-id: 983be3e35801efe3052f0983d728a9703e7ded88
prerequisite-patch-id: 20f874f2f1b44d9a27824a2e3944477fc3c02af5
prerequisite-patch-id: fc7f1510621f228d42bf1666c06f34926f3e10f4
prerequisite-patch-id: b9e987299142a89ca3a7bfb5b0335a215c7cdd52
prerequisite-patch-id: 1d11dea3090f6b72322c3827bd260ed3d12e1201
prerequisite-patch-id: 4182aa31cbc4b985e3a628c3dc9a2fd039188f7e
prerequisite-patch-id: 7b7f07b1c57398f185a93d6b3212394753292be7
prerequisite-patch-id: e6bd5afbc9593e93203caa0ae9f08545511e2bf2
prerequisite-patch-id: c6d466588800f94684ebf9fb785ce085510c8f93
prerequisite-patch-id: 5f8a9d6fd20c05d708df6424102575251d32331f
prerequisite-patch-id: 18c2d823dc5b44514c0b2278986933a1a9834f02
prerequisite-patch-id: a8c4944302cbea92690957fd18162ca303757874
prerequisite-patch-id: 962e6cc26e53a3319302fd4c2aae2bc4b593f4be
prerequisite-patch-id: 366fc63bc744ea4a2af4f16befaa1d7e8c66bf84
prerequisite-patch-id: 33c4fd1e1ccd1eac9fde961a0f7ed8509e713c7e
prerequisite-patch-id: 496318ad0a87ec138780d4a50a2f8a49ca126ca6
prerequisite-patch-id: f85ec023f5ab9903987d867c330bde94b3c24c55
prerequisite-patch-id: 34fc06cb69e34ec4d67015187969e8d2c0c56660
prerequisite-patch-id: 3b789a4e47c47f855c44c125a75de3a79709d411
prerequisite-patch-id: b03787ca5a3d60d4ad5682313424a114c1862fb0
prerequisite-patch-id: 4ec079edf0025f849b1b8c7e3beb47db057ab6d2
prerequisite-patch-id: b44382d38528c92150f2d7cac5722cf8e09c0fab
prerequisite-patch-id: 02e42a505f17dbf5bc3e85b55d5df716e3819141
prerequisite-patch-id: faf2c686c253faa5a81801f78ba955d3ae8c0c4f
prerequisite-patch-id: 6407fec511e4d3bf785c3be581b828abac884ba7
prerequisite-patch-id: 1a9fc394fdf6b19434652a4c137a0ea819702325
prerequisite-patch-id: 6de415eec4ab2f2b8dec1f194fb89cfe01568f9b
prerequisite-patch-id: 73e1360c2be46882c0ca58d6d60f0c394f1d47f4
prerequisite-patch-id: fada6f5ef59f7119d5b202b64ce2184795428d7c
prerequisite-patch-id: 7f31438e1f326350688f7aa7169038a7a33b4ddc
prerequisite-patch-id: a9940a88c19f95573008a9e2bd950a43c12b7e3c
prerequisite-patch-id: 2d5e46c029b523f6d6f13a0716e56267691757cf
prerequisite-patch-id: 7aa60266913380f85e46f8dc71885356e3d7902a
prerequisite-patch-id: cd12813a72a4c558660f8f8d093928533ddbf5ee
prerequisite-patch-id: 186129fe8188f5b7cb6fef2701400fc6772aaf2e
prerequisite-patch-id: c99a84af1b60e1c8f80168706f5ed600a6eb4553
prerequisite-patch-id: 598515adbecc5c14e8ffe631206a906fb2c9f59c
prerequisite-patch-id: cf84de09ca65f4577268e9a4a8a166436735b7da
prerequisite-patch-id: cfd9ec749b0f3c78e0a64a73756f978bfd853391
prerequisite-patch-id: 87104eb556b1cef43ded0979f0b806f35ec819bb
prerequisite-patch-id: 5536c46e78e53cc31224b2730ca5fb454cd17761
prerequisite-patch-id: 48e3546e357a8e68e4abaeb2faf1081afb8f3ae3
prerequisite-patch-id: be78356c5aabcd0e68c61b2bc785c73a0c2edff9
prerequisite-patch-id: 7192a8aa88903ca758655dea8eaac94b98481e82
prerequisite-patch-id: f28910d02bfc6e11c1ecc2ce03db57ccaba0d185
prerequisite-patch-id: 48fc2a91c98aac131457deed8d9c2965eaffd1fb
prerequisite-patch-id: 0c829edd4d3d8cb4765d649411dec1124fd20fbd
prerequisite-patch-id: e994569657dc0537d6d3b9f7cd4d919ba2602126
prerequisite-patch-id: bce46caeb9616651be519c0474855ce9341de611
prerequisite-patch-id: a2a70a62d2684c072e3927abeb7a9e86dbec759b

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

