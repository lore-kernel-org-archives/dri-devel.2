Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D5C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A3610F38D;
	Thu, 16 Jul 2026 16:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dR1HC8Bk";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F8A10F37A;
 Thu, 16 Jul 2026 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=yjOzPKf4tTupL5uL1Exy/NeYuxc4gUxpV6ogSWPeNT0=; b=
 dR1HC8BkckY18O0vDibaJN1BasFavqpKwG72KsHyH6sfRGKCPlX5b/1/zbpr3bW5qAzFLKnTysZmR
 Q/lIHabNTkCC+821G66sBOrFjyQbG6GBAeRqAvoFMBTYZNNJBiVYsDl3bCji1jL/PVn8FyiJAhkfZ
 CW2b1Hw36NF/U2WoNz/JD7YeERO5JlAdhiY+wRfX233vb6nDHGmiXmxnFn4ee0D+1KiAygQYWOnUH
 tWzKkQkdPfIUrrDfc9yDAc/piBVqDNa07Zf4xv4Uj+Kp90TxOpqmpIO3KDug3N2sLITCC3rudwHO5
 QU+YMsbmYwM5qhBY3UKhOe+FKkqCUkcHrg==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkOc2-00G01i-3C; Thu, 16 Jul 2026 18:07:02 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 20/20] drm/amd/display: enable post-blend colorop
 properties
Date: Thu, 16 Jul 2026 18:03:17 +0200
Message-ID: <20260716160556.227556-21-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
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

Only enable post-blend colorop properties if there is no AMD private
color prop. Prioritize color mgmt via colorop pipeline instead CRTC
color mgmt properties.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 5 +++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 9e5da58f26f8..cb4e3e5652bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1389,6 +1389,11 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 	bool is_legacy;
 	int r;
 
+	if (crtc->base.color_pipeline_enabled) {
+		r = amdgpu_dm_crtc_set_colorop_properties(&crtc->base, stream, check_only);
+		return r;
+	}
+
 	tf = amdgpu_tf_to_dc_tf(crtc->regamma_tf);
 
 	r = amdgpu_dm_verify_lut_sizes(&crtc->base);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 6226c9ba5fce..33b3e66f6941 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -804,6 +804,10 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 
 #ifdef AMD_PRIVATE_COLOR
 	dm_crtc_additional_color_mgmt(&acrtc->base);
+#else
+	res = dm_crtc_init_colorops(&acrtc->base);
+	if (res)
+		return res;
 #endif
 	return 0;
 
-- 
2.53.0

