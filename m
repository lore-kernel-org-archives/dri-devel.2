Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C97FCD5BD6
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 10:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E107310E15B;
	Mon, 25 May 2026 10:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Y0YTuY2Z";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEC210E210;
 Mon, 25 May 2026 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vbBesheMMq554jXUMZrm1tMPW4M3xt3l04YxRg3d9fI=; b=Y0YTuY2ZbXRuMynqtPpJXcfony
 RLkgNZ+9dJZ04e6qM6C5jfjYe1ML31gPn4hT/yPEjxaM5TtJW7lNa7HC1L2WsWeOzewj4cKcuPxKa
 7tbOEnmsMxxQqbCgDlCpMvvlS8Cec9B2QxqASv7jh9I1BKbX4UjL/YYUidWhyDXAcCae1UyCzhUld
 WNNtoav1PEqKOnbKyYsArtJcL6rSOA3lhNJUwWPPapTbKadQlXRoU2CvnMr/KjcKYTKGMyuIBGUxU
 BU+LGN197BCdIMP9BUoFTZbS8LixrG1SKPYgzonptPnvWaKVPRtL2xNIBj1VNdu3T1mcaa5qakVmU
 hY6pbA5Q==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wRSBj-007xuT-0r; Mon, 25 May 2026 12:05:35 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v7 0/4] drm/atomic: track individual colorop updates
Date: Mon, 25 May 2026 11:49:57 +0200
Message-ID: <20260525100524.304263-1-mwen@igalia.com>
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

This is a partial of [1], only with patches related to individual
colorop update tracking. I.e., I'm detaching from here fixes regarding
attempts of changing colorops that are not part of an active color
pipeline, or in the transition between active and inactive color
pipelines.

This series focus on tracking updates for each individual color
operation, allowing the driver to react accordingly.

- Patches 1 and 2 make lut1d_interpolation and lut3d_interpolation
  colorops correctly behave as mutable, handling their changes via
  drm_colorop_state.

- Patches 3 and 4 track colorop updates of a given plane color
  pipeline by setting plane `color_mgmt_changed` flag, similar to what
  is done for tracking CRTC color mgmt property changes with CRTC
  `color_mgmt_changed` flag. The flag also tracks when a different color
  pipeline is set to a given plane, but doesn't consider as a change
  when the same color pipeline value is set to the plane COLOR_PIPELINE
  prop. That way, the driver can react accordingly and update their
  color blocks. As interpolation properties become mutable, they are
  also tracked here.

It also fixes shaper/3D LUT updates when changing night mode settings on
gamescope with a custom branch that supports `COLOR_PIPELINE`:
- https://github.com/ValveSoftware/gamescope/pull/2113

v1: https://lore.kernel.org/dri-devel/20260318162348.299807-1-mwen@igalia.com/
Changes:
- include linux types for function's bool return type (kernel bot on MSM
  driver)
- add Harry's r-b tags

v2: https://lore.kernel.org/dri-devel/20260323131942.494217-1-mwen@igalia.com/
Changes:
- [NEW] two patches to only consider colorop updates from active color
  pipelines (Chaitanya)
- [NEW] make lut interpolation properties mutable + Alex H patch for
  kernel docs
- track lut(1/3)d_interpolation updates (Chaitanya)
- rebase changes according to new patches

v3: https://lore.kernel.org/dri-devel/20260403135909.214378-1-mwen@igalia.com/
Changes: rebase on drm-misc-next

v4: https://lore.kernel.org/dri-devel/20260501132527.522320-1-mwen@igalia.com/
Changes: fix kernel doc (kernel bot)

v5: https://lore.kernel.org/dri-devel/20260506192633.16066-1-mwen@igalia.com/
Changes:
- rebase on drm-misc-next
- fix kernel-doc and correctly reword (atomic) state to plane_state (Chaitanya)
- reject inactive colorop updates in atomic check time, instead of
  during property's setup, to avoid ordering dependency as pointed out by Chaitanya
- use `|= replaced` for consistency (Chaitanya)
- add Chaitanya's r-b tags to patches 1,3-5

[1] v6: https://lore.kernel.org/dri-devel/20260519211111.228303-1-mwen@igalia.com/
Changes:
- detach patches that implement individual tracking from those related
  to inactive colorop updates.

Alex Hung (1):
  drm/colorop: Remove read-only comments from interpolation fields

Melissa Wen (3):
  drm/colorop: make lut(1/3)d_interpolation mutable
  drm/atomic: track individual colorop updates
  drm/amd/display: use plane color_mgmt_changed to track colorop changes

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
 drivers/gpu/drm/drm_atomic.c                  |  4 +-
 drivers/gpu/drm/drm_atomic_uapi.c             | 68 +++++++++++++++----
 drivers/gpu/drm/drm_colorop.c                 | 16 ++++-
 include/drm/drm_atomic_uapi.h                 |  4 +-
 include/drm/drm_colorop.h                     | 34 +++++-----
 6 files changed, 93 insertions(+), 39 deletions(-)

-- 
2.53.0

