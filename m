Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F8CC79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3994010EA10;
	Tue,  8 Sep 2026 07:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="y9gO28jY";
	dkim-atps=neutral
X-Greylist: delayed 6344 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 11:52:43 UTC
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [83.166.143.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1868B10E7B6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:52:42 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdln52403z2p2;
 Mon,  7 Sep 2026 13:52:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1788781961;
 bh=TfmPsOVp24ScHaEKgtuC/OXjlcw+dIgTM0HzeoZWwhM=;
 h=From:To:Cc:Subject:Date:From;
 b=y9gO28jYr5Wi4D3jNV4vC1Y9Jlnj5fvT8INMkrQWzRxvHYDkvmb7YfZIg1TzNi5V5
 3RhfGntETvYU+rTcjM/PLGG5lfDTJYIGAlRrOEYCTYCiVcJlvm5Y57ITTs2FfJ9r7E
 Zy+A9Wry03MwZpEklPKlS6a6XcleAC3ErQI/qE5Ds2lIqFc+O95pDhJZ31Neh0Y7b0
 X235IjA1Vmv31Vb3xpylt/pvnDcTbdPAwtKA/UToN1wtlKQbLyYNqVtQEpoUJtKM2E
 FMkLkiqKy6zJWkn3xXLplWfj5yxpNfKL0D/ZCQzCqnhXo+vOxLT++EKvaQYgSrSRIV
 jwO2W/apVK7Vg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hdlmz26tfz3J6; Mon,  7 Sep 2026 13:52:34 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/amd/display: HDMI 1.4 3D output (frame packing,
 top-and-bottom, side-by-side)
Date: Mon,  7 Sep 2026 13:52:26 +0200
Message-ID: <20260907115229.64477-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

amdgpu has never exposed the HDMI 1.4 3D modes that drm_edid derives
from a sink's HDMI VSDB: stereo_allowed is false on every connector, so
a 3D-capable TV or projector connected to a Radeon card cannot be driven
in frame-packing, top-and-bottom or side-by-side mode, although i915
has supported exactly this for a decade and the media players that
produce 3D frames (Kodi, mpv with 3D filters) only need the mode to
exist.

These three patches add it for native HDMI connectors, in the simplest form
that works on the hardware: the source packs both views into the frame
and the display core scans that frame out as ordinary 2D; the only
3D-specific output is the HDMI vendor infoframe. The reason it has to
be done this way is in patch 1: any of DC's stereo timing formats,
including the SW_PACKED ones, makes the hardware treat the surface as
two views and paint the whole frame into each half. Patch 2 adds the
3D_Ext_Data byte to the top-and-bottom vendor infoframe, without which
at least JVC D-ILA projectors do not engage 3D (Amlogic sources send
it, which is why those work with the same projector). Patch 3 sizes
the stream and the plane viewport by the doubled frame-packing timing
so each eye receives its own view rather than a stretched copy of the
first.

Tested on a Radeon RX 7600 (Navi 33, DCN 3.2.1) driving a JVC
DLA-RS4100 through an HDFury VRROOM, with Kodi (LibreELEC, GBM) as the
source, on a 7.2.3 kernel carrying these patches; the series here is
rebased onto amd-staging-drm-next and compile-tested there, and the
amdgpu_dm connector (308) and plane (95) KUnit suites pass; the freesync suite
crashes the same way on the unpatched base. All three layouts
engage the projector's 3D mode at 1920x1080p24, RGB 12 bpc, with
correct per-eye geometry (row-coded test frames read back through each
eye of shutter glasses) and correct eye assignment; frame packing is
also the format the projector uses for Blu-ray 3D.

Known limitation, not addressed here: a framebuffer with DCC enabled
does not scan out in a frame-packed mode on this GPU (the first flip
after the modeset never completes and the pipe wedges); the source has
to allocate the 3D framebuffer without DCC. A separate report will
follow once it is better understood.

Two unrelated FRL/DSC issues found on the same setup are tracked as
drm/amd issues 5770 and 5771.

v2 (all three findings came from the Sashiko review bot, and all held up):
- 1/3: a stereo mode keeps its own CRTC timing in
  decide_crtc_timing_for_drm_display_mode() - with scaling enabled, or
  when the sink's native mode is the 2D twin of the stereo mode's base
  timing, the native timing was copied over the doubled frame-packing
  timing; and amdgpu_dm_is_freesync_video_mode() rejects a
  stereo-flagged mode, which otherwise could be replaced by the 2D
  FreeSync base mode and lose its 3D flags. KUnit cases for both.
- 3/3: the plane KUnit mocks now set hdisplay/vdisplay as well as the
  crtc_* size, which drm_mode_get_hv_timing() derives the size from;
  dm_test_helper_check_state_scaling_caps failed otherwise.
- 2/3: unchanged.

Adrian Betschart (3):
  drm/amd/display: support HDMI 1.4 3D modes on HDMI connectors
  drm/amd/display: send the 3D_Ext_Data byte for top-and-bottom too
  drm/amd/display: size frame-packed streams by the doubled timing

 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 65 +++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 13 ++-
 .../tests/amdgpu_dm_connector_test.c          | 80 +++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 12 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  7 ++
 .../display/modules/info_packet/info_packet.c |  4 +
 6 files changed, 171 insertions(+), 10 deletions(-)

-- 
2.43.0

