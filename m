Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9549606A328
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=CHYDng88
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0471F11283C;
	Thu, 22 Oct 2026 17:37:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9B710E452;
 Thu, 22 Oct 2026 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=VSxXMiM3GPIicYlnkb31Yy9RNt3E/wFvuoT1oTRYRpk=; b=
 CHYDng88iJnz1QPo+Y515zoGZFDUmQVvemrY4tXLhXft0T6WfLB3aaHGe/hZKWy3H1wEK8K+r+k0G
 Ld/qQrcETVTVbfiBYG+E4tEs25Al+nnJdPrxCPj+UbF6u9AlgGV4SaxiZrpEIRlcQ0w9APpucrXnG
 fFIqaxayDM3N48peFz3gpBEinm/Y4LH2+t0l1eYFnM31xnMvZ9ILJETlk+tvfTEts0hxHPw8JeZtF
 O8bl7HgAthvpkMa2tsmo1ecNsz74DDn2ZaiRMcqJ1GoRnOU3WqF9Hrrpmwz9coLIMzALd+66pYk6m
 5PTPeL9V+PcBA1oN5D/tthF7qn2DtW6QkQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJwiw-0071Z2-Ft; Thu, 22 Oct 2026 19:37:06 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [PATCH 0/3] drm/amd/display: Fix assorted test failures
Date: Thu, 22 Oct 2026 10:36:52 -0700
Message-ID: <20261022173655.2318987-1-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running the KUNIT tests with KASAN enabled hits a bunch of
use-after-free errors. Also, the colorop tests were failing due to the
pipeline having been extended. So, fix those up.

Note that the following tests are still failing for me. They are
EXPECTATION failures though, rather than memory splats. So, the test
run does at least complete now.
  dm_test_crtc_reset_state_replaces_existing
  dm_test_detect_hides_secondary_tile
  dm_test_fs_caps_dp_msa_not_allowed
  dm_test_update_plane_color_mgmt_colorop_shaper
  dm_test_update_plane_color_mgmt_colorop_3dlut
  dm_test_update_plane_color_mgmt_colorop_blend

Signed-off-by: John Harrison <John.Harrison@Igalia.com>

John Harrison (3):
  drm/amd/display: Fix some memory lifetime issues in KUnit tests
  drm/amd/display: Fix use-after-free in
    dm_test_hpd_rx_offload_work_msg_rdy
  drm/amd/display: Update colorop pipeline tests for new fixed matrix op

 .../amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 4 ++++
 .../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c    | 2 +-
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c  | 8 +++++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c    | 2 +-
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c   | 2 +-
 5 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.0

