Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0097ACD98C9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A79110E381;
	Tue,  9 Jun 2026 12:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nVS5YfDY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987CD10E2ED;
 Tue,  9 Jun 2026 12:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ys1hPQ1gZmUZza3nrdD0bkcP4BI8PKUWiJEI9ZB3dOU=; b=nVS5YfDYjSyqXIVhleK2qvhY/y
 4nlUHbAKQwkhwzFLDz+WTJYVhM3FvYmPZDCtD8/jHYOZ1DkessnKHM3jzQcVI2Pt4pU0I7Ud5b7Di
 H3lju1Nlmfh4nQAnKhbEYgMIkuzDEeUDmZGfIrLbL2qS1VBotmnQmYQvt1L6mm8xSv0WZd9Y+iKa2
 gMhYvmO8RME4godXjyPkYBPvQe1veWFZlbEBORNpBSwOi2LbnVqwup4i71wgQVk8SUBSHgkXiE57G
 VWx4OUONfb/t5rMCLx5Dz6Yl8/jzDrXypOiSGMegjOZ+McquE4ZvrxwaAwN9z9tNgcDm4+xML3Cg1
 BUzJAqtg==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWvJw-00EvWP-Im; Tue, 09 Jun 2026 14:12:40 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/7] don't allow changes to inactive colorops
Date: Tue,  9 Jun 2026 13:51:34 +0200
Message-ID: <20260609121230.1358786-1-mwen@igalia.com>
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
according to this contract [2]. The rest of the series in [1] was
detached in [3] since there is no dependency between them.

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

[1] https://lore.kernel.org/dri-devel/20260519211111.228303-1-mwen@igalia.com/
[2] https://lore.kernel.org/igt-dev/20260602211259.898147-1-mwen@igalia.com
[3] https://lore.kernel.org/igt-dev/20260526140752.503380-1-mwen@igalia.com/


Melissa

Melissa Wen (7):
  drm/atomic: only add states of active or transient active colorops
  drm/atomic: reject colorop update from inactive color pipeline
  drm/amd/display: don't check colorop status if its in an inactive
    pipeline
  drm/amd/display: truly bypass plane colorop 3x4 matrix and hdr mult
  drm/amd/display: make shaper bypass mode cleaner
  drm/amd/display: fix bnld colorop bypass mode
  drm/amd/display: allow individual colorop changes

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  31 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 178 +++++++-----------
 drivers/gpu/drm/drm_atomic.c                  | 125 +++++++++++-
 include/drm/drm_colorop.h                     |   3 +
 4 files changed, 207 insertions(+), 130 deletions(-)

-- 
2.53.0

