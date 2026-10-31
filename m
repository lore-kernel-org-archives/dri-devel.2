Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA4606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=cwooper.dev header.i=@cwooper.dev header.a=rsa-sha256 header.s=key1 header.b=Y7psk1a9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A75610EA26;
	Sun,  1 Nov 2026 12:02:57 +0000 (UTC)
X-Greylist: delayed 363 seconds by postgrey-1.36 at gabe;
 Sat, 31 Oct 2026 04:24:59 UTC
Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC8D10E193
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 04:24:59 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=JQRBTsLyo1USJxXJkqovGqVi5MENsxtF02GpdlXi6O0=; 
 c=simple/simple; d=cwooper.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793420698; v=1; x=1794025498;
 b=Y7psk1a9TCFQy0cPIUmvB/Vbs3j0kGE0h+Ik7Ez6VbA5yiIMgHaAVvqLmxjZyrflndA0zfNG
 HecGddqB5sQXgk/Ssex1Zw8dpoRa+H4fk7LjPbgqA0Bbixrbg+tPaG4jZHl3kTKlCQjZetbK/AU
 HLVVFxUWWyJGJGqBczFJhYwPpBmVbCWldzNfjl8Wa9WhaPs91AVPeRF61GWsju9g4jsR4Qe855b
 pB9n3R2BqGhB+Cf6nfLhBtzrwXvQmWLOXDQvUefBLTRoMXOD5h7sKwsask9SoSwMaZaTtwEW3aG
 zYJlC5TRjo27MNFc0cqvYTXoDiJUCzgfmHr06EGD61rhg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 6d492372f5c77a27;
 Sat, 31 Oct 2026 04:18:53 +0000
X-Mizu-Trace-ID: 6d492372f5c77a27
X-Migadu-Flow: FLOW_OUT
From: Cooper Morgan <ext-github@cwooper.dev>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amd/display: Fix FreeSync infopacket refresh rates
 above 255 Hz
Date: Fri, 30 Oct 2026 21:18:24 -0700
Message-ID: <20261031041827.162730-1-ext-github@cwooper.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On my MSI MAG 271QPX32 (320Hz QD-OLED over DP 1.4, RX 9070 XT), 320Hz
looks like a 720p image stretched to fill the screen whenever
Adaptive-Sync is on in the monitor's OSD. Custom modes at 305-315Hz put
it into its self-test pattern instead. Windows is fine on the same
machine and cable. It's the same bug as
https://gitlab.freedesktop.org/drm/amd/-/issues/5988, where an LG at
280Hz shows up as 24Hz.

The cause is the v1 FreeSync infopacket, which native DP sinks get
unless they're a whitelisted PCON or support Replay. It stores the min
and max refresh in one byte each, so 320 wraps to 64.

Patch 1 caps those bytes at 255 instead of letting them wrap. With the
EDID range capped at 255, the monitor gets the same bytes patch 1 sends,
and the picture was correct, so I tagged it for stable.

Patch 2 sends the v3 packet to sinks that advertise AMD VSDB v3 and go
above 255Hz, so VRR gets the full range. Sinks at 255Hz and below are
unchanged.

This builds on what sunryze and oystersuki worked out in that issue.
sunryze found that the VSDB version was only saved for Replay sinks on
DP and tested sending v3 on their LG. oystersuki suggested pairing that
with a 255 cap for sinks that don't advertise v3. Neither has a public
email, so they're credited here instead of with tags.

Tested with the series backported to 7.2.13: 320Hz looks right, and
with VRR on, the monitor's refresh readout follows frame caps at 300,
270, 240, and 100fps. Both patches add KUnit tests.

Cooper Morgan (2):
  drm/amd/display: Saturate refresh rates in v1/v2 FreeSync infopackets
  drm/amd/display: Use FreeSync v3 infopacket for sinks above 255 Hz

 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   7 ++
 .../tests/amdgpu_dm_connector_test.c          |  25 ++++
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 116 ++++++++++++++++++
 .../amd/display/modules/freesync/freesync.c   |  12 +-
 5 files changed, 158 insertions(+), 4 deletions(-)

-- 
2.56.0

