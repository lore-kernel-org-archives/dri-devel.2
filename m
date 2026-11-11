Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75B606A333
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Q2JoTB4J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F7710FD78;
	Wed, 11 Nov 2026 16:08:56 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF4210FD40;
 Wed, 11 Nov 2026 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=RO865FpgI8SUnM8VBsvjl2ol1ZFGSrSMCGa3F96x8cU=;
 t=1794413330; x=2109773330; b=Q2JoTB4JFjne4RBGp6MlN4MiPGD0fHlLNFFaYXVznUzRoa2
 Fm3vlO5Vg4N+77On1VeYf8kvY968QL1TbbbBLUwnPyANE4c68TMCUUHE6jhDFQez2CAwV2mZ8+wS8
 pQTdjQ5Oc5V0HThBCxyoi0LMK8EeTbv18PFiMUX+RRj9AEdzrBkgjLIXavYZWxV3L8kVSgnfwsxY4
 qfGKyRSAev7L2kzl1jqUG4AAh4Lgq46/jcgVuXLsv1AIxi8fZFwSThSPy29YrFbwgce7wAjHOcFpc
 Ca1/Z9lnZwQ7cDoa8pKMZV1faYOMxeiEHElXJ4OMuZKuPC6d6iiOrCerU0szmrTg==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRArz-008u8Y-RS; Wed, 11 Nov 2026 17:08:19 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 John Harrison <John.Harrison@igalia.com>
Subject: [PATCH v5 00/15] drm/atomic: only add states of active or transient
 active colorops 
Date: Wed, 11 Nov 2026 17:05:13 +0100
Message-ID: <20261111160814.21326-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is a follow-up of what was discussed in [1] and on #wayland
IRC channel regarding policy and userspace expectations on changes in
colorop properties and the current status of the color pipeline in which
the colorop is part of. In short, we agreed that userspace can change
properties of colorops that are currently part of an active color
pipeline or when the pipeline is switching status in the same commit.
However, userspace cannot change colorop properties of inactive color
pipeline in the expactation that it will be activated at some point in
the future.

Userspace also expects persistence of color pipeline already set, even
if it becomes inactive for a while, when activated, colorop settings
previouly set should be preserved.

This series uncovered some bugs on IGT tests that were already fixed [2]
and applied. The bad merge conflict resolution mentioned in the previous
version [v3] is already resolved. On the other hand, when rebasing this
series on drm-misc, other issues on AMD KUnit tests appeared due to the
introduction of the new FIXED_MATRIX colorop type. As a result, the
first two new patches address them.

I also tried to address some Sashiko's complaints on pre-existent issues
that affects the stability of this series, but not all since I want to
keep a healthy scope for reviews. Now some AMD fixes in this series are
attached to the DRM changes, so better apply the whole serie in a single
branch and hope that this doesn't get deleted in the event of a merge
conflict.

[v1] https://lore.kernel.org/dri-devel/20260526142940.504911-1-mwen@igalia.com/
Changes:
- define a macro to walk in the color pipeline (Alex H.)
- fix checkpatch warning (Alex H.)

[v2] https://lore.kernel.org/dri-devel/20260604180457.1110110-1-mwen@igalia.com/
Changes:
- [Drop] drm/atomic: duplicate state of all colorops
  If inactive colorops state are duplicated on resume, the commit will be
  rejected. 
- [New] Four new patches to make AMD driver match the policy of colorop
  updates only for colorops in active color pipelines plus individual
  colorop updates. It also tries to untangle COLOR_PIPELINE = Bypass from
  colorop BYPASS prop = true. I think patches 3-5 can be cherry-picked and
  applied if it looks correct for AMD, I just included them here for
  context (for example, Sashiko reported an issue in the previous version
  of this series).

[v3] https://lore.kernel.org/dri-devel/20260609121230.1358786-1-mwen@igalia.com/
Changes:
- make drm_atomic_add_affected_colorops static and move to
  drm_atomic_helper.c (John H.)
- skip check when just duplicating state for suspend/resume persistence.
- [re-add] drm/atomic: duplicate state of all colorops to preserve all
  colorop status in a suspend/resume
- rewite commit message and better explain what's considered an active
  colorop (John H.)
- [new] drm/atomic: check if an active colorop has a blob if its type
  requires one
- drop the ternary and add just a warn_on since both current callers
  iterate planes already in the atomic state in AMD's active pipeline
  check (John H.)
- explain the reason to use commited colorop in AMD's active pipeline
  check (John H.)
- [new] drm/amd/display: don't ignore failure on blend colorop setup
- [new] drm/amd/display: distinguish colorop setup error from no colorop support

[v4] https://lore.kernel.org/dri-devel/20260811171011.184964-1-mwen@igalia.com/
Changes:
- Fixes for Kunit tests related to FIXED_MATRIX type
  - [new] drm/amd/display: Update colorop pipeline tests for new fixed matrix op
  - [new] drm/amd/display: add missing FIXED_MATRIX colorop to AMD KUnit tests
- Fixes for KUnit tests with the new policy in place:
  - [new] drm/amd/display: add plane to commit on KUnit cursor mode tests
- post-pone making drm_atomic_add_affected_colorops static to a point in this
  series in which this is not needed by AMD anymore (Harry):
  - In drm/amd/display: allow individual colorop change, drop the
    drm_atomic_add_affected_colorops() call from dm_update_plane_state(),
    since the colorop helpers now fall back to the committed state
  - [new] drm/atomic: make drm_atomic_add_affected_colorops() static
- check colorop type when allowing individual changes (Harry)
- update __set_dm_plane_colorop_fixed_matrix to get the commited state if no
  new state as for other colorop individual changes (Harry)
- update KUnit tests accordingly (Harry)
- [moved] drm/amd/display: only check colorops of an active color pipeline

[1] https://lore.kernel.org/dri-devel/20260519211111.228303-1-mwen@igalia.com/
[2] https://lore.kernel.org/igt-dev/20261021151929.62529-1-mwen@igalia.com/

Best Regards,

Melissa

John Harrison (1):
  drm/amd/display: Update colorop pipeline tests for new fixed matrix op

Melissa Wen (14):
  drm/amd/display: add missing FIXED_MATRIX colorop to AMD KUnit tests
  drm/atomic: only add states of active or transient active colorops
  drm/amd/display: add plane to commit on KUnit cursor mode tests
  drm/amd/display: only check colorops of an active color pipeline
  drm/atomic: reject colorop update from inactive color pipeline
  drm/atomic: duplicate state of all colorops
  drm/atomic: check if an active colorop has a blob if its type requires
    one
  drm/amd/display: truly bypass plane colorop 3x4 matrix and hdr mult
  drm/amd/display: make shaper bypass mode cleaner
  drm/amd/display: make blnd bypass mode clearer
  drm/amd/display: don't ignore failure on blend colorop setup
  drm/amd/display: allow individual colorop changes
  drm/atomic: make drm_atomic_add_affected_colorops() static
  drm/amd/display: distinguish colorop setup error from no colorop
    support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 -
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 236 ++++++++----------
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |  26 +-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 118 +++++----
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |  49 ++++
 drivers/gpu/drm/drm_atomic.c                  | 199 +++++++++++----
 drivers/gpu/drm/drm_atomic_helper.c           |  59 ++++-
 drivers/gpu/drm/drm_colorop.c                 |   5 +-
 include/drm/drm_atomic.h                      |   4 -
 include/drm/drm_colorop.h                     |   9 +-
 11 files changed, 456 insertions(+), 266 deletions(-)

-- 
2.53.0

