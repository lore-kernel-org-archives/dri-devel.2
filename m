Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E08ACA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5FB10F7AA;
	Tue, 13 Oct 2026 11:58:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D5410F7AA
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791892712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MPpjIx1DbmEHmQq5k6Krx5L9kivtWysksQG1537BfZQ=;
 b=XD7rLquAuhNfX7rEy2S3G7oQPGYO71D0EVAeq1KwCHncCtbwD7cHSPu4beImiJxvECgOuH
 DNgWxKXFqSx6F8vAsTvcx8GsL9+4GTXqOgqOlXzF2fJhWICcdX/QcqVriyOgOK0rKRbeIZ
 HPFAn84+0+TJADlbgjC0PM7bz4KLqW8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-yUs2w1RBOeWm-GPMwS9EaQ-1; Tue,
 13 Oct 2026 11:58:27 +0000
X-MC-Unique: yUs2w1RBOeWm-GPMwS9EaQ-1
X-Mimecast-MFC-AGG-ID: yUs2w1RBOeWm-GPMwS9EaQ_1791892705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD00195FDE7; Tue, 13 Oct 2026 11:58:24 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 250401956086; Tue, 13 Oct 2026 11:58:19 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
Date: Tue, 13 Oct 2026 13:58:12 +0200
Message-Id: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7ZhSKD+uvIdhUcogkyglbSUS0
 rtbuIDL7+V97+3gyTF5uGU7OFrZs50TyEsGZtLzk5CHxCCFrEQrajwqPb84bPiZeWSjQ1JwHAr
 VGNWIsqwhyYujkb/n8KNLPLEP1m3nz5of6d/JNUeBlW4rSaovCpXfHQ2TDldj39DFGH9Ryq8ov
 QAAAA==
X-Change-ID: 20260907-visibility-unification-fd358c580447
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892699; l=6834;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=KadtR+IjPDiRiEbF2EBs12dIf2bKI52h5Y02NAopm+g=;
 b=11R7lXGyjwY/Tc5fVZJ32GUGJlLz47Yieq50OwSZJPVhKdRJ/LQSc30TQYh62AwXIkpYyX/f/
 V0o0DN2VSGqBA0CrXjezUBJsqMkocXh7bVCIDFY2klfQotNo8GD19f2
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: j2kIuLstDZAMKkWfezCYraXEIJT8JyZfAxOqLoiGaJ4_1791892705
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
series switches the KUnit helpers over to the common API.

VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
CONFIG_DRM_AMD_DC_KUNIT_TEST, so the helpers are non-static whenever
KUnit is enabled. EXPORT_SYMBOL_IF_KUNIT places the symbols in the
EXPORTED_FOR_KUNIT_TESTING namespace; the AMD DC test files import
that namespace with MODULE_IMPORT_NS().

INLINE_IFN_KUNIT is dropped rather than generalized. It was only used
on amdgpu_dm_fixpt_from_s3132(), inverted the original static inline,
and is unnecessary for tests in another translation unit.

Previous version failed with specific configuration combination
(KUNIT=y, DRM_AMD_DC_KUNIT_TEST=n). Fixed by changing header
declaration guards from CONFIG_DRM_AMD_DC_KUNIT_TEST to
CONFIG_KUNIT to match VISIBLE_IF_KUNIT.

Tested with:
    # Full test run (KUNIT=y, DRM_AMD_DC_KUNIT_TEST=y):
    ./tools/testing/kunit/kunit.py run --arch=x86_64 \
      --kunitconfig=drivers/gpu/drm/amd/display/amdgpu_dm/tests \
      --kconfig_add CONFIG_GCOV=n

    # Build-only, tests disabled (KUNIT=y, DRM_AMD_DC_KUNIT_TEST=n):
    ./tools/testing/kunit/kunit.py build --arch=x86_64 \
      --kconfig_add CONFIG_KUNIT=y \
      --kconfig_add CONFIG_PCI=y \
      --kconfig_add CONFIG_DRM=y \
      --kconfig_add CONFIG_DRM_AMDGPU=y \
      --kconfig_add CONFIG_DRM_AMD_DC=y \
      --kconfig_add CONFIG_WERROR=y

(CONFIG_GCOV omitted; it is not available on x86_64.)

Suggested-by: Maxime Ripard <mripard@kernel.org>

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Changes in v2:
- Fix build when CONFIG_KUNIT=y and CONFIG_DRM_AMD_DC_KUNIT_TEST=n
- Fix two missed EXPORT_IF_KUNIT in amdgpu_dm_irq.c
- Rebased to v7.3-rc7
- Link to v1: https://lore.kernel.org/r/20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com

---
Albert Esteve (3):
      drm/amd/display: replace STATIC_IFN_KUNIT with VISIBLE_IF_KUNIT
      drm/amd/display: replace EXPORT_IF_KUNIT with EXPORT_SYMBOL_IF_KUNIT
      drm/amd/display: drop INLINE_IFN_KUNIT

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  79 ++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |  26 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  74 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 133 +++++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 190 ++++++++++-----------
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |  38 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  52 +++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  30 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 105 ++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 140 +++++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h  |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 150 ++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  40 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  60 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 104 +++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 116 ++++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h   |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  22 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |   9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  18 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |   2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   1 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  13 +-
 tools/lib/python/kdoc/xforms_lists.py              |   3 +-
 70 files changed, 771 insertions(+), 751 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20260907-visibility-unification-fd358c580447

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

