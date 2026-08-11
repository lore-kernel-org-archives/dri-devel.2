Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF0C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD25810ED13;
	Tue, 11 Aug 2026 17:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="C8MeFc3D";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7656B10ECFA;
 Tue, 11 Aug 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=XSqPNlMRjHTgCivrcOmZqe2DefzjiZUQWPd+89+xPCc=; b=
 C8MeFc3DphZKn1a6SoT1kmxXXcAitI6yu0Xir9IQPd2pEbICRVc+rHFw6FrF1UMG53Z3i1BjHdqIe
 hTasrGVWHw3ToQHNN7vQ3o2/kZ8BCIb8wmHiIv2v7zaTaHPbhUVrO2MKf7zczOZKPsbAyby944OZL
 63EYkwSYfCySbFbSnF8icHNjtkmjTxgnw0BP/xRjW83OFmdARA/s/RirDqU91h7u4u0srjDHdP0Fb
 HJPHu2qsxJmbFqUzLe403u/MR8gIkz8QpjKfLbGnuzRHzZ8gp3ok2uut9Nddt8FW0y48MhKJY3Ho8
 SX6SRma8M/Mgz4gJqsx+NH4Fp3zkRLdtPQ==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtpzW-00HH9d-Lm; Tue, 11 Aug 2026 19:10:18 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 00/11] drm/atomic: don't allow changes to inactive colorops
 & other fixes
Date: Tue, 11 Aug 2026 18:45:49 +0200
Message-ID: <20260811171011.184964-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In addition, I found some bugs on IGT tests when this policy is applied.
So I sent bug fixes to kms_colorop and kms_properties to behave
according to this contract (new version) [2]. The rest of the series in
[1] was detached in [3] and already applied. However, after a bad merge
conflict resolution the colorop-update track was removed from AMD and
this series needs it back to make the AMD part work correctly. I've
already resubmitted it [4].

I also tried to address some Sashiko's complaints on pre-existent issues
that affects the stability of this series, but not all since I want to
keep a healthy scope for reviews. AMD fixes are in this series because
of their scope, but they can be detached and applied whenever it's
convenient.

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

[1] https://lore.kernel.org/dri-devel/20260519211111.228303-1-mwen@igalia.com/
[2] https://lore.kernel.org/igt-dev/20260811143558.141813-1-mwen@igalia.com
[3] https://lore.kernel.org/dri-devel/20260609110420.1298352-1-mwen@igalia.com/
[4] https://lore.kernel.org/dri-devel/20260807115712.22423-1-mwen@igalia.com/

Melissa Wen (11):
  drm/atomic: only add states of active or transient active colorops
  drm/atomic: reject colorop update from inactive color pipeline
  drm/atomic: duplicate state of all colorops
  drm/atomic: check if an active colorop has a blob if its type requires one
  drm/amd/display: only check colorops of an active color pipeline
  drm/amd/display: truly bypass plane colorop 3x4 matrix and hdr mult
  drm/amd/display: make shaper bypass mode cleaner
  drm/amd/display: make blnd bypass mode clearer
  drm/amd/display: don't ignore failure on blend colorop setup
  drm/amd/display: allow individual colorop changes
  drm/amd/display: distinguish colorop setup error from no colorop support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  33 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 206 +++++++-----------
 drivers/gpu/drm/drm_atomic.c                  | 199 ++++++++++++-----
 drivers/gpu/drm/drm_atomic_helper.c           |  52 ++++-
 include/drm/drm_atomic.h                      |   3 -
 include/drm/drm_colorop.h                     |   3 +
 6 files changed, 304 insertions(+), 192 deletions(-)

-- 
2.53.0

