Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55271C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCC810F3AC;
	Fri, 18 Sep 2026 14:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BEH3ovrj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB5010E8FD
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:18:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEAD1601EF;
 Fri, 18 Sep 2026 14:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70FB1F000FF;
 Fri, 18 Sep 2026 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789741081;
 bh=OAmEu+JzoTJ/Pl+tJn1qfGMuXEXO8fVcBtsv/kGUTWg=;
 h=From:Subject:Date:To:Cc;
 b=BEH3ovrjR/dhG7b8SfpwfXi6yYsWESHl/lOAxpgcJF5F6merXkcChLNSJI/ULjJMn
 sY0VdWzM5/aUebfqRe2pGxysVOXDs3j5z14f4bJLAzttJr0LY7xzjVN+DeUghh5tBv
 l/GRl7dHekXKxwdO7LTusrMxc3xOnGz6QnEgtX+M1/MbBVP/Wbpn//gqse7ulDiy3Z
 CsrMIrubS6Vje2Al7wYEio7doFmPd27jThzkr0jA8pbdDg7M0LC2YX5b4TXQ2a+TjL
 8ELcGE4F5CLiDCddcZIWWN0Cwq8dv5/bLnBVsB6q0G378BzPBTcJzcQhu8rb2jhlpw
 wSXbxN+8j49lA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 00/13] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Fri, 18 Sep 2026 16:17:49 +0200
Message-Id: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQS07DMBAG4KtEXjPIj7i2u+IeiIVjj1OLJoGxi
 Yqq3h2nXVQIVSz/keabx5kVpIyF7bszI1xzycvcQv/UsXDw84iQY8tMcrnjhluINAFhwQql+oq
 Qjn4EmQY5aCNEcoa11g/ClE9X9vWt5UMudaHv65RVbNV/wFUAh6BMDM7q3ur48o404/F5oZFt4
 irvihXygSKbgm4XUCglTPyrqLviHu6imuK41oYnZY3vfymX27mEn1/tefV2Mxt8QQjLNOW67zZ
 1yiXAjKcK2zDgDoRpzZcfKLBI5IEBAAA=
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
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4467; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6pYUc+Yv8IiiqD40mWlSDSz316uwJ0Iap7UVSWMfMiQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlrPfiztyhWL1ih4jT3voL0T+kjihufdnc0TvwvbrN0S
 4eA+d3DHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi/54zNrz6/PvRCWOz31le
 Emv9p6lxfu48fCNdqq/WULuv6c5l07YTC54tmX3wtfKyXqO5V//2LmJseFyzVicimvf/EY/mfNd
 N/pv7/orcsJcpiQt5eP+l3XYPm7+zLh964/Tgh9v2OQsqpz03BQA=
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
Maxime Ripard (12):
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
      drm/vkms: Switch container_of helpers to container_of_const
      drm/vkms: Add driver-specific plane property for testing

Sebastian Wick (1):
      drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

 drivers/gpu/drm/drm_atomic.c      | 347 +++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/drm_atomic_uapi.c |  18 ++
 drivers/gpu/drm/drm_ioctl.c       |   4 +
 drivers/gpu/drm/vkms/vkms_drv.h   |  11 +-
 drivers/gpu/drm/vkms/vkms_plane.c |  61 ++++++-
 include/drm/drm_atomic.h          |   3 +
 include/uapi/drm/drm.h            |  10 ++
 include/uapi/drm/drm_mode.h       |  14 +-
 8 files changed, 398 insertions(+), 70 deletions(-)
---
base-commit: 7bb81171930435e6658ca4c5a5c03152e3b877c5
change-id: 20260708-drm-reset-state-flag-2fb2b5711f97

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

