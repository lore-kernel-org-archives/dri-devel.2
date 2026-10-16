Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31869CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BD1112619;
	Fri, 16 Oct 2026 07:32:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A89112619
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:31:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D77460008;
 Fri, 16 Oct 2026 07:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60F41F000C4;
 Fri, 16 Oct 2026 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792135915;
 bh=36maHmS7CbXLGmFGSg6c6EPMiNabe6QEYMZbEs4dbcQ=;
 h=From:Subject:Date:To:Cc;
 b=LlQymb2lUbtE/YFLQBzATk+uWxk1zm+qgTbSJUljI/UJeYwuDjPCgHDZjwn/DIJaR
 0BGQLohjy0DGXWqMAuGaswDkOVatE4BJd1aOhwVm670w4GEasatpEg5oogYjabkoGd
 4wnkCQ7+nxuU3EsSXxzi92tr036Ej2t27dyIC1YtpUUWhWBKpB9f3XPHf7WYbNAUjd
 BAnm6bIhJgVj0LhhkmgFHcFG0g072rIvxNRDo7HnuJuxQTJiUI7171p06Dnwf+wzYZ
 gHj8WGUl9u3VilpMpxzMX1Ym+sbrF4FhEJQyEoxcjUMYtvXebTjD+uW6mxQkIb8ccM
 EA6hrHC0hoQSg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 00/14] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Fri, 16 Oct 2026 09:31:32 +0200
Message-Id: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRzU7DMAwH8FepciYon02yE++BOKSJ00Ws7UhCB
 Zr27njbYaCp4vi35J8t+0QqlAyV7LoTKbDmmpcZg37qSNj7eQSaI2YimOiZYZbGMtECFRqtzTe
 g6eBHKtIgBm04T84QbD0WSPnryr6+Yd7n2pbyfZ2y8kv1H3DllNEgTQzOamV1fHmHMsPheSkju
 YiruCuWiw1FoAKuD8Cl5CY+KvKuuM1dJCqOaW1YktZ49aCoXwrfUhQq2kfOeokQ03+U8+1oBT4
 +8QXtdjky+Ao0LNOU265T1nmrpQu+T9hw/gG6i9JTuwEAAA==
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
 Daniel Stone <daniel@fooishbar.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4915; i=mripard@kernel.org;
 h=from:subject:message-id; bh=38JeLiHFsMvM1H/lfM5jZWZe8Oim5xxebWS/AnG44dI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkXLz1glF986K7735RFs1QjxRYE50fcMNnjmuG5e2/cb
 Y0b+rbiHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAijsKMDW3H1N6uPp35R136
 xKeynbs19PUkez4+XjYjRuL9ge8f9gYau3uvm7S1lNmgJDX8Ze7LD4wNfQoSYk0mARrcm4Xffv8
 2oelSfseKaxb7y1/1KHzlnMigVu//sEVYjdc63WHrt0Vdj58DAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
Maxime Ripard (13):
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

 drivers/gpu/drm/drm_atomic.c            | 362 ++++++++++++++++++++++++++------
 drivers/gpu/drm/drm_atomic_uapi.c       |  18 ++
 drivers/gpu/drm/drm_ioctl.c             |   4 +
 drivers/gpu/drm/tests/drm_atomic_test.c | 128 ++++++++++-
 drivers/gpu/drm/vkms/vkms_drv.h         |  11 +-
 drivers/gpu/drm/vkms/vkms_plane.c       |  61 +++++-
 include/drm/drm_atomic.h                |   3 +
 include/uapi/drm/drm.h                  |  10 +
 include/uapi/drm/drm_mode.h             |  14 +-
 9 files changed, 539 insertions(+), 72 deletions(-)
---
base-commit: 489a8539ca6f347102c1334c2f08198abacc86c8
change-id: 20260708-drm-reset-state-flag-2fb2b5711f97

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

