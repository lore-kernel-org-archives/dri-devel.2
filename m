Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11B7C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132C410EF12;
	Wed, 12 Aug 2026 12:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="frCiMY2K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A71E010EF12
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:57:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77B1B43481;
 Wed, 12 Aug 2026 12:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F071F000E9;
 Wed, 12 Aug 2026 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786539425;
 bh=+j3en4ZHn2U+b9OwRC75L0YRNhYzFCqfwfd/qIVOlWQ=;
 h=From:Subject:Date:To:Cc;
 b=frCiMY2K4ioC21rTnMEs0FcSIr0XAHgWigJPDe8nuWLqqEeLyh99IP055ySB4skfr
 7COE4TmfArVJtnlEQNRPQhSLvS9pFhgmM+Or/VznuARIg+7n5T6jmq9s1eN9Brhu1H
 f9lfhZDRBaMh+M1P1bCqYohP5Slsu8Gm27t9B9dJSH2QHAuVOMZ3Zx3SgYQWAMQDX5
 gbvD2BPjOA2aEG4xq6yq/41RLPK4LMp5E340h2jNuIHoJm3p96szGe1hxKhrDqRcUP
 xqqjbDh+ljlRgI1Ovah8e+UPkhKpUzBwBQCzwVY03pjYAinAy8BpsDX+A2RsNrbd5S
 gERuio4acUIag==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH RFC v2 0/9] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Wed, 12 Aug 2026 14:56:55 +0200
Message-Id: <20260812-drm-reset-state-flag-v2-0-e96ce13317dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Zi2igVXJiYewK1hUegUGhHMt
 CEa0rvbcACX7//891cIxJ4CnIsVmBYf/DxlULsCusFMPaG3mUEJdRJaVGj5hUyBIoZoIqEbTY/
 KtaottZSu1pCnbybnP5v2AffbFZocDj7Emb/b1SK36r91kSiwO2jb1VV5rEp7eRJPNO5n7qFJK
 f0AfRFDU74AAAA=
X-Change-ID: 20260708-drm-reset-state-flag-2fb2b5711f97
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3405; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Osvvo07IW+DcgdMtY/HrdwgX0zsGQhNCKZu8xcXnz9k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFk1ubM0Hsg7Gb2UC40P3XP5SPnrDz8+hUko/PvKUMK3p
 sn3/VvzjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRMl7GhlUfNnbuX7dCcsLu
 uz9uHF/r1ew8YVvYk0QX20ZGr0WCK0S702Nv83EVXv8Ye7Tsl93SAMaGzXonziwq+n4rydXksmn
 Lu6PXcpaWL3rseCz8qDZXTW7CmwfpSSVuzPYqEzprt807PLkCAA==
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
defaults (CRTCs inactive, planes disabled, connectors unbound, and so
on). This allows userspace to describe the desired end state
declaratively, without having to care about the current state or the
full set of properties.

The first patch is a small cleanup aligning __drm_colorops_state with
the naming convention used by the other atomic state tracking
structures.

Patches 2 through 6 extract the state insertion logic from each
drm_atomic_get_*_state() function into standalone helpers. This is
needed because the new fill_with_defaults path creates states through
atomic_create_state() rather than atomic_duplicate_state(), so it
cannot go through the existing drm_atomic_get_*_state() functions.

Patch 7 adds drm_atomic_commit_fill_with_defaults(), which uses those
helpers to populate a commit with pristine states for every object in
the device.

Patch 8 wires it all up by adding DRM_MODE_ATOMIC_RESET to the atomic
ioctl.

This series is untested and relies on all drivers implementing the
atomic_create_state hook, which is not yet the case. The conversion
is actively in progress but not complete, so this will not work as-is
today. Sending it now to get early feedback on the approach.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Fix bisection
- Add capability to let userspace know if it can reset the state
- Link to v1: https://lore.kernel.org/r/20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org

---
Maxime Ripard (8):
      drm/atomic: colorop: Rename state to state_to_destroy
      drm/atomic: Create function to insert CRTC state into a commit
      drm/atomic: Create function to insert plane state into a commit
      drm/atomic: Create function to insert colorop state into a commit
      drm/atomic: Create function to insert private obj state into a commit
      drm/atomic: Create function to insert connector state into a commit
      drm/atomic: Add drm_atomic_can_create_state() helper
      drm/atomic: Allow filling a commit with pristine object states

Sebastian Wick (1):
      drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

 drivers/gpu/drm/drm_atomic.c        | 388 ++++++++++++++++++++++++++++++------
 drivers/gpu/drm/drm_atomic_helper.c |   2 +-
 drivers/gpu/drm/drm_atomic_uapi.c   |  13 ++
 drivers/gpu/drm/drm_ioctl.c         |   4 +
 include/drm/drm_atomic.h            |  21 +-
 include/uapi/drm/drm.h              |  10 +
 include/uapi/drm/drm_mode.h         |  14 +-
 7 files changed, 384 insertions(+), 68 deletions(-)
---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260708-drm-reset-state-flag-2fb2b5711f97

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

