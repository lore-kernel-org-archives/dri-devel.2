Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC8EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC5E10F1A6;
	Wed,  8 Jul 2026 16:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N7Mvdw6g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FA010F193
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:08:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 505B5416A9;
 Wed,  8 Jul 2026 16:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CB61F000E9;
 Wed,  8 Jul 2026 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783526931;
 bh=wYzwmisw/Q5fR/mjLKqW56qnQbU9GhAXUBG5hR3GgmI=;
 h=From:Subject:Date:To:Cc;
 b=N7Mvdw6gskr47HHvjZ+/TobcVgtxx/oFQFNyNPBLIpKxKbLeKJoLCh1nBUdVcSeiE
 1ebXpnT/v6VqbtW45ncrcY/dxs7EAUMwQGuSUKV0G2FkrMkJm/cKE1StITjLv2qKcA
 /fLRQdM/CSNPkojEP0vUtI56Ktci+b7dpDrpcR/UNI46VZ3jjvBkIoV/wcP8iSvAIk
 +/QAmZA8oaXDggtYiKwN1iQiOSR66ChRyEWyGaVeWSP1qIs4biJVM/sJ9gG8ZAHAf2
 Dd8u/x0PvbmUmZLNBZ6DBivk0dNeu71InxPeWFWppvVCgP7CXYslGR4QG8Ui6HMbZH
 e74HvhPoBFv/Q==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Wed, 08 Jul 2026 18:08:37 +0200
Message-Id: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3ZSiXN2i1OLUEt3iksSSVN20nMR0XaO0JKMkU3NDwzRLcyWg1oK
 i1LTMCrCx0UpBbs5KsbW1ALKyE41rAAAA
X-Change-ID: 20260708-drm-reset-state-flag-2fb2b5711f97
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329; i=mripard@kernel.org;
 h=from:subject:message-id; bh=G7jtjkyOUqq4ChRdp6WKDjFN5sbC9dtXYKtRCsiJDs4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl+ZTzrdrl5/Nghcc5PzOeo/hbfonXHzm32be2e6mW3m
 TfThGlax1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIpT5jnWnufjHTZqkKmydr
 kzW6PFTLtn2sFBObm3byjra0c5v8aovwT8/d2YTrnwT09U3i9/3OWO976Vs6S/zfDzviXipcU/e
 LiYnev8H9XZ17zs/482z6xpf6ytnTb9uf3PZ8gYin8ebDRwE=
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

Open question: should DRM_MODE_ATOMIC_RESET require
DRM_MODE_ATOMIC_ALLOW_MODESET? A full state reset will change CRTC
active states, which is effectively a modeset. Without requiring it,
a reset could pass flag validation but fail later at atomic_check in
a confusing way.

This series is untested and relies on all drivers implementing the
atomic_create_state hook, which is not yet the case. The conversion
is actively in progress but not complete, so this will not work as-is
today. Sending it now to get early feedback on the approach.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (7):
      drm/atomic: colorop: Rename state to state_to_destroy
      drm/atomic: Create function to insert CRTC state into a commit
      drm/atomic: Create function to insert plane state into a commit
      drm/atomic: Create function to insert colorop state into a commit
      drm/atomic: Create function to insert private obj state into a commit
      drm/atomic: Create function to insert connector state into a commit
      drm/atomic: Allow filling a commit with pristine object states

Sebastian Wick (1):
      drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

 drivers/gpu/drm/drm_atomic.c        | 327 +++++++++++++++++++++++++++++-------
 drivers/gpu/drm/drm_atomic_helper.c |   2 +-
 drivers/gpu/drm/drm_atomic_uapi.c   |  13 ++
 include/drm/drm_atomic.h            |  19 ++-
 include/uapi/drm/drm_mode.h         |  14 +-
 5 files changed, 307 insertions(+), 68 deletions(-)
---
base-commit: cff96362794a5c1f3adb013b4a46c7233149a629
change-id: 20260708-drm-reset-state-flag-2fb2b5711f97

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

