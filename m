Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C91F4610C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F2010E3F8;
	Mon, 23 Mar 2026 13:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="A/Lwwk5g";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9759B10E3F6;
 Mon, 23 Mar 2026 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/GKvAASRZ2omGxdiTBreurCOsHR47HtXrjwHuOx3IJQ=; b=A/Lwwk5goCHSKKqECsxAyoSsZy
 bE0CU70IGyMW3E/iQYtuA364lSjIFMcxljytbY7L3dUlmZ3ikOJs6AlxgE5PPIUkiK7m8tl1MMvao
 FapIAqI5yyh9ZW1lOh3rc0tRtO2NAu1bviL6XCz+M09wOZRKhe4BulIkglG/aayFFebRwJZRq6NBr
 +7ykVk1FWHHdBhu3T/vYtDVvVYbXT1hbIP4vRZ5q1l1P7MTNxr5Ooyt2usq+sgyVG4teb5XiI56GT
 3YrHr1oWwrNuqPzghU7VVwQjiNZfnLSZGWSZlHCPRsKNcb5cOtTlNp9O6H52VTCf2TLedUY5z0hL3
 WRPaX/DQ==;
Received: from [186.208.74.38] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w4fCB-004rx9-Gx; Mon, 23 Mar 2026 14:19:52 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/atomic: track colorop changes of a given plane
Date: Mon, 23 Mar 2026 10:15:12 -0300
Message-ID: <20260323131942.494217-1-mwen@igalia.com>
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

Similar to what is done for tracking CRTC color mgmt property changes
with CRTC `color_mgmt_changed` flag, track colorop updates of a given
plane color pipeline by setting plane `color_mgmt_changed` flag. Also
true if setting a different color pipeline to a given plane. That way,
the driver can react accordingly and update their color blocks.

This small series fix shaper/3D LUT updates when changing night mode
settings on gamescope with a custom branch that supports
`COLOR_PIPELINE`[1].

This series doesn't cover 1D/3D LUT interpolation, since it's documented
as read-only properties.

v1: https://lore.kernel.org/dri-devel/20260318162348.299807-1-mwen@igalia.com/
Changes:
- include linux types for function's bool return type (kernel bot on MSM
  driver)
- add Harry's r-b tags

Let me know your thoughts!

[1] https://github.com/ValveSoftware/gamescope/pull/2113

Melissa Wen

Melissa Wen (2):
  drm/atomic: track individual colorop updates
  drm/amd/display: use plane color_mgmt_changed to track colorop changes

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++-
 drivers/gpu/drm/drm_atomic_uapi.c             | 53 +++++++++++++++----
 include/drm/drm_atomic_uapi.h                 |  4 +-
 3 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.53.0

