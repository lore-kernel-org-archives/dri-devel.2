Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C837AC624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFC110F3DC;
	Thu,  3 Sep 2026 07:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="BGEGXopu";
	dkim-atps=neutral
X-Greylist: delayed 315 seconds by postgrey-1.36 at gabe;
 Wed, 02 Sep 2026 12:31:15 UTC
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FC610F1A1;
 Wed,  2 Sep 2026 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788352272; x=1788611472;
 bh=OKxNGCoL9yieoK3Ws2lDA86IF7zj6L6ly9tSa8jimQE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BGEGXopu67VBpaYnmqAVSucBFOZgRwPKzh1KMjIQqQUd9/0XoKfiWJof1ngxOhZMJ
 J1VIwNjg9z+nsUM5jmjKSefRnn/yVzYjQHcyyhISrgoJBPOcNrqk2nltUk4UuJDfj+
 KoN3u1BIowUCfyTHAJZJxCRAjS0R1rjHlbyubq7Sb5rhy+HtSSGk1zjZNMcgVvKz/7
 CswyitX/tXuW9alxZKCyGUXWQOXoPi49DK0alBqBfmZJBFpxgETJPlvIm7Uxszh1nO
 3g7dU35oS1I5z79bDg4ET9WGP80K5LhsVI6afIROzzusO1s8w+Gy0Ms2MOk1hDHVUD
 iEzq3xSqtpx2g==
Date: Wed, 02 Sep 2026 12:31:05 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com
Subject: [PATCH 0/4] drm/amd/display: fix brightness ownership through power
 module
Message-ID: <20260902-brightness-cover-abf809f2@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: e25d1b5c28e864151b6e2d411f4edd74bae9fadd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Linux passes PWM eDP brightness through two owners. The display manager
maps the request into the firmware range and applies the ATIF custom
curve. The power module then derives a percentage from that hardware
value and applies the same curve and range again. A non-zero firmware
minimum consequently prevents zero from reaching the panel minimum.
The split also leaves the custom-curve disable policy and final PWM mask
attached to the wrong owner.

Patch 1 keeps pre-power-module custom-curve output in the userspace
domain, which also fixes affected stable kernels. Patch 2 covers that
conversion with a non-zero firmware minimum. Patch 3 passes zero-anchored
millipercent into the power module and moves the panel policy, curve,
range, trace units, and final effective-PWM mask to that owner. Patch 4
covers ordinary PWM, forced PWM, AMD-AUX fallback, true AUX, multiple
panels, endpoints, interior values, clamping, and invalid ranges.

The complete series passed all 85 AMD backlight UML KUnit cases on the
current base and after clean application to Linux 7.3-rc1. It was built
into one kernel, booted on two Strix Halo systems, and produced the same
AMDGPU module on both. An instrumented physical panel test observed:

  request 0     -> 0 millipercent      -> PWM 3084  -> success
  request 65535 -> 100000 millipercent -> PWM 65535 -> success

The panel visibly reached minimum and maximum brightness, then returned
to its starting level. No fatal kernel event followed. The true AUX path
was covered by KUnit but was not available for a physical test. The
existing LUT-unaware hardware readback inverse is unchanged.

Andrei Rusu de Castro (4):
  drm/amd/display: keep custom brightness curve in userspace domain
  drm/amd/display: test custom brightness with non-zero minimum
  drm/amd/display: pass userspace brightness to power module
  drm/amd/display: test power module brightness input domain

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  59 ++-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |   3 +-
 .../tests/amdgpu_dm_backlight_test.c          | 447 +++++++++++++++++-
 .../drm/amd/display/modules/inc/mod_power.h   |   1 +
 .../gpu/drm/amd/display/modules/power/power.c |   2 +
 .../drm/amd/display/modules/power/power_abm.c |   6 +-
 .../amd/display/modules/power/power_helpers.h |   1 +
 9 files changed, 494 insertions(+), 36 deletions(-)


