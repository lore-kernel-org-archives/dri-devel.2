Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2169606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=rzmEcRsB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E5F10FDD4;
	Wed, 11 Nov 2026 16:09:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB77910FD92;
 Wed, 11 Nov 2026 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=vhJpOnyWAz5uiZosJGVLwxlp+dogNJrP1/dgdKqGrCU=;
 t=1794413339; x=2109773339; b=rzmEcRsBG1a6yKIhuTuqNWR738+UeQVzmcbTVJA4tz3bxl7
 wdqhkkAtGQ8OfhqS+sDrSVGuQQ1wS4w6cMi4TmjW8szBI7BZJB2i48UR1wHWEIoHdmshtoqjuyzoD
 G1Jh5VBDxtgLbkAmcUnm0m3YgNVq4NplkNOfBLyXy3FDxi5naGCxCIRR740JJSROlCrqUho3VrLhb
 w7+PexxP2HLP86N0S4Q7Y2rQmRqRyuwy5jzlewW37yo0zB/QBdFSYthYneIzYWLOsL001F1vY7AtX
 UqmDNAlPmVGA7xHQwNjitFzGv5ahZipfPHQmmNrBgFbvzhim9G+V4+2JHZ+QOBOg==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsL-008u8Y-D3; Wed, 11 Nov 2026 17:08:41 +0100
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
Subject: [PATCH v5 11/15] drm/amd/display: make blnd bypass mode clearer
Date: Wed, 11 Nov 2026 17:05:24 +0100
Message-ID: <20261111160814.21326-12-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160814.21326-1-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
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

If userspace set blnd colorop to bypass, AMD driver just skips blnd
transfer function configuration. Currently, this is not an issue since
dc plane state is a reset/default state, but it's not fully correct and
doesn't mirror shaper tf helper. Make bypass mode setup clear by
initially set tf->type as BYPASS and let the helper change its type
according to userspace requests.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 6455898e2da9..686f718bd155 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1938,6 +1938,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 	uint32_t blend_size = 0;
 	int i = 0;
 
+	tf->type = TF_TYPE_BYPASS;
 	dc_plane_state->cm.flags.bits.blend_enable = 0;
 
 	/* 1D Curve - BLND TF: find state */
-- 
2.53.0

