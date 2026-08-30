Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F3AC624C9
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB09C10E6A6;
	Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="kx1nP9YD";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EE110E049
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 03:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1788061912; x=1788321112;
 bh=0dD5oMnTRgDfBjkWIdYVb0AJ9OTzv7ps3j7Lef16Jco=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kx1nP9YDF3alKUthfcrupusmAr4SR6dUDYEN0Fr7g++QgQaylVqCrhmLcgH4CDW8Z
 RhCPcklCikaySQnDEhSplH6VOhLpOFaJfLMXPPDsoEFe6au8k6L89wijbYaNItWiVn
 LMmN3ZThMy+MYoEjyR0GaPRTHocEKtnYm+cSmDFM2YvkN+hNg3j/gXqqjVeNglq/s8
 S1NSV+exGr0kP2OHEhoMpZFrKWOPdjCHHGe2GKUHci1OBW6gHcmJ5jPdhgyu5MpU5D
 UtHhkezpQOzN8SxtML/3AI+ImoHaSlNBZL0dMTeTBQ3k7QkriOUd0S6Ku39z/FISPL
 6n+W6aj84rNvw==
Date: Sun, 30 Aug 2026 03:51:44 +0000
To: amd-gfx@lists.freedesktop.org
From: Satyajit Roy <edu042sjroy@proton.me>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, jerry.zuo@amd.com, wayne.lin@amd.com, yan.li@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Satyajit Roy <sroy14@alum.utk.edu>
Subject: [PATCH 0/3] drm/amd/display: Fix HDMI RGB quantization updates
Message-ID: <20260830035120.937992-1-edu042sjroy@proton.me>
Feedback-ID: 147615787:user:proton
X-Pm-Message-ID: 282307d2556e7d497e19992471f8343a6200d0e5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

From: Satyajit Roy <sroy14@alum.utk.edu>

The Broadcast RGB implementation currently has three gaps in the AMD
Display path:

  1. DM does not propagate the sink's RGB quantization-range
     selectability into DC, so the HDMI AVI InfoFrame Q field remains at
     its default value.
  2. BT.2020 RGB output is always selected as full range, so an explicit
     Limited setting has no effect in HDR modes using BT.2020 RGB.
  3. A property-only range transition updates the output CSC but does not
     rebuild and program the InfoFrame, leaving the sink with stale range
     signaling.

Together these can make the transmitted pixel range and the range inferred
by a television's automatic black-level setting disagree.

Patch 1 propagates the EDID QS capability. Patch 2 honors Limited for
BT.2020 RGB and adds KUnit coverage for both BT.2020 connector colorspace
values. Patch 3 rebuilds InfoFrames whenever output_color_space changes.

Validation performed on amd-staging-drm-next at the base commit below:

  - scripts/checkpatch.pl --strict: no errors, warnings, or checks
  - x86_64 AMD Display KUnit configuration built with CONFIG_WERROR=3Dy
  - new EDID-capability and BT.2020 quantization KUnit cases compiled

Equivalent changes were also tested on an HDMI 2.1 television with a
Valve Linux 7.2 kernel. The television's automatic black-level selection
followed Full-to-Limited and Limited-to-Full transitions in SDR, HDR, and
HDR with VRR active. No modeset or visible link blank was observed.

Satyajit Roy (3):
  drm/amd/display: Propagate HDMI RGB quantization selectability
  drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
  drm/amd/display: Rebuild InfoFrames on output color space changes

 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 10 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  1 +
 .../tests/amdgpu_dm_connector_test.c          | 37 +++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 ++
 5 files changed, 50 insertions(+), 3 deletions(-)


base-commit: 75a5e1b6b3661c3f946885d01eebeb6b031035ef
--=20
2.51.1

