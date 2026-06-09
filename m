Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9873CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5630210E33C;
	Tue,  9 Jun 2026 12:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FmEL7FWS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064D610E2F2;
 Tue,  9 Jun 2026 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rOMwe3iepfg/Vhh9MbZOiWLka6jhyTg12/cdz/MWt2g=; b=FmEL7FWSpPfDdBwgeUxiA2ZNlp
 lgaMsEeRP555Uo/e/DgI4dToFdjzWHW54Y+G5UFrIpFJa1W9G2zcJ3Q52O4ItMDI47zFOTEZHfw2o
 GShmdLiUxtBFU2IxuNOwa1n/lycJMKAkxgZvvKU3Q4sbAI9A/XASw5rjqr6n/NCIhfFKBuLouzlv6
 uqlXdM2try4s+nCY92Z2fgG5WRzWpSbDjLQDgoc1OZFcQrqxajXSnnTsfRhJjLGcutOMggWlaDoWG
 6aiz6bEB76/YrQQQyyEfHjFqszNyLCMkm0KSd1lg/4H1+op9y7nYyhF3pbj+KdInKumkmFQmmsD07
 O0kBd6Jg==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWvK8-00EvWP-Cj; Tue, 09 Jun 2026 14:12:52 +0200
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
Subject: [PATCH v3 6/7] drm/amd/display: fix bnld colorop bypass mode
Date: Tue,  9 Jun 2026 13:51:40 +0200
Message-ID: <20260609121230.1358786-7-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609121230.1358786-1-mwen@igalia.com>
References: <20260609121230.1358786-1-mwen@igalia.com>
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

If userspace set blnd colorop to bypass, AMD driver just skips blnd
transfer function configuration. Currently, this is not an issue since
dc plane state is a reset/default state, but it's not fully correct and
doesn't mirror shaper tf helper. Make bypass mode setup clear by
initially set tf->type as BYPASS and let the helper change its type
according to userspace requests.

Fixes: 52da8325996b ("drm/amd/display: Add support for sRGB EOTF in BLND block")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 2f51009b2978..2dc3951c8e39 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1773,6 +1773,8 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 	uint32_t blend_size = 0;
 	int i = 0;
 
+	tf->type = TF_TYPE_BYPASS;
+
 	/* 1D Curve - BLND TF */
 	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-- 
2.53.0

