Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DC610854D2
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8794610E9E9;
	Thu, 19 Mar 2026 12:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ik4GCzN8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0661F10E9E8;
 Thu, 19 Mar 2026 12:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773923359; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mM85oxFuJnbN9kknI9IGLyH0MfYyP9MPF+ODd8i6cK8Az2izbIl3xMotP7+/1Fo3Wdk/WPPAfN9e1M9vJaZDfnRiG77kVsCW/HV+4AMrV6QJduf6l2cWkiEHkjEyLtGcxw1F95TAAlufBGu1AYE/QKh/kqGZwsJZnQImri6G198=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773923359;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=G+Ry5mtgjlaLirG74mRV7E/3c+5G4MWEXp1PnN6/otg=; 
 b=OR3lpcN2WFiWlh9+SOlxGVcUWic9lSlCQ0tB0bjiD1pIXEdhApEa3r5fzZc9mO2riO8txYbf34fQjBLnEiZrVNZjsCeHEq+kZoZysK184rsO7DRd5EgUEyvTeyKUwD9U34wokGgwCk1bxvrHdwyO3I8IKibXaLKRCh4r0fzeXSU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773923359; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=G+Ry5mtgjlaLirG74mRV7E/3c+5G4MWEXp1PnN6/otg=;
 b=Ik4GCzN8Uiy0eUxY9LQwSRZuu2TmFR2zI6An65RO2jU0oGSiapfNR2whzWvfQ20n
 CTMYNOIYTBT0QzQ9wusPovrtGaM7rmcso/9W5kerUemY5vZVfeKIvJ6hqacuNoKwP6F
 fRmdNbUJAVnTCnMOwVFWCeOLG+2Vr8a/poxTvbRo=
Received: by mx.zohomail.com with SMTPS id 1773923357289958.1832137646468;
 Thu, 19 Mar 2026 05:29:17 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 19 Mar 2026 13:28:36 +0100
Subject: [PATCH v5 3/3] drm/amd/display: Add support for 'link bpc'
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-link-bpc-v5-3-5306cd04a708@collabora.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
In-Reply-To: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, kernel@collabora.com, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3
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

The 'link bpc' DRM property exposes the connector's current display link
bits per component value. This allows userspace to discover whether a
link has degraded from a higher bit depth to a lower one.

Add support for it in amdgpu.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 65b256a7b6c4..467821cab009 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7186,6 +7186,14 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 }
 #endif
 
+static void amdgpu_dm_update_link_bpc(struct drm_connector_state *conn_state,
+				      enum dc_color_depth depth)
+{
+	/* 6 bpc is an experimental internal format only, use 8 as minimum */
+	conn_state->link_bpc = clamp(convert_dc_color_depth_into_bpc(depth), 8,
+				     conn_state->max_bpc);
+}
+
 static struct dc_stream_state *
 create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
@@ -8983,8 +8991,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.underscan_vborder_property,
 				0);
 
-	if (!aconnector->mst_root)
+	if (!aconnector->mst_root) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_link_bpc_property(&aconnector->base, 16);
+	}
 
 	aconnector->base.state->max_bpc = 16;
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
@@ -11427,6 +11437,9 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			goto fail;
 		}
 
+		amdgpu_dm_update_link_bpc(drm_new_conn_state,
+					  new_stream->timing.display_color_depth);
+
 		/*
 		 * TODO: Check VSDB bits to decide whether this should
 		 * be enabled or not.

-- 
2.53.0

