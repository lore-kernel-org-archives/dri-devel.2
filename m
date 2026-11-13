Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F1606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=cwooper.dev header.i=@cwooper.dev header.a=rsa-sha256 header.s=key1 header.b=iCJFF0PH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54E810E72C;
	Fri, 13 Nov 2026 01:05:55 +0000 (UTC)
Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC6E10E6FA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:05:48 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=3iaUfeSJheybFmhRCKtGmAwKW8MrZhj1xyUGO3ic1L4=; 
 c=simple/simple; d=cwooper.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794531946; v=1; x=1795136746;
 b=iCJFF0PH/bBXXqycUQIXn6N8e6Be/ikwGEQvq7Z4Lk29ygCDykpLLz+PKFFnLb8CatY5JvsL
 eiUG4iRxnpGRDq2HLNtyIHvc9IOGG4aG5bXWMWvjGpQtyBjpe9Kgo4F/K+ZAU5Q4SpIarO96Itt
 Z6uB1qvFCSD64jb0lZ96HYza6sbRqt8Ag0+tS4Wq3EruF52zPE1TMvUFsSShak1V7D7hLSZH4rY
 tU8Ry2gqBNxEuiQKFLphEavyBNlhlDl/A4Xbtv3HCiZ4YeNNa8gIDHFjTPsTO8ahWdlhQK0B84y
 Ql2mnGdwx+e/x6nrAep4g5R8X3FFpiV4l4yVG/4mwvGBQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id e4dddcff22dcb560;
 Fri, 13 Nov 2026 01:05:46 +0000
X-Mizu-Trace-ID: e4dddcff22dcb560
X-Migadu-Flow: FLOW_OUT
From: Cooper Morgan <ext-github@cwooper.dev>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/amd/display: Fix FreeSync infopacket refresh rates
 above 255 Hz
Date: Thu, 12 Nov 2026 17:05:26 -0800
Message-ID: <20261113010529.11514-1-ext-github@cwooper.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Patch 1 caps those bytes at 255 instead of letting them wrap. With
patch 1 alone, the MSI is correct at 320Hz and the LG shows every frame
at 280Hz, so I tagged it for stable.

Patch 2 sends the v3 packet to sinks that advertise AMD VSDB v3 and go
above 255Hz, so VRR gets the full range. Sinks at 255Hz and below are
unchanged.

This builds on what sunryze and oystersuki worked out in that issue.
sunryze found that the VSDB version was only saved for Replay sinks on
DP and tested sending v3 on their LG. oystersuki suggested pairing that
with a 255 cap for sinks that don't advertise v3. sunryze has no public
email, so they're credited here instead of with a tag.

Tested with the series backported to 7.2.13: 320Hz looks right, and
with VRR on, the monitor's refresh readout follows frame caps at 300,
270, 240, and 100fps. oystersuki tested both patches on an LG
27GX700A-B. Since v3 now carries the PQ bit from ebacf0a7ce54
("drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR")
to these sinks in HDR, I also tested with that commit backported: HDR
looks the same. Both patches add KUnit tests.

Changes in v2:
- No functional changes; rebased onto amd-staging-drm-next.
- Patch 1: dropped the claim that an EDID range capped at 255 sends the
  bytes this patch sends (no FreeSync packet is sent then), and gave the
  result of running patch 1 alone instead. Also dropped "once the
  wrapped value lands inside their range", which the LG contradicts.
- Added tags from oystersuki and Harry.

v1: https://lore.kernel.org/amd-gfx/20261031041827.162730-1-ext-github@cwooper.dev/

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

