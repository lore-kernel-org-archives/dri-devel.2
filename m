Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F22710854D2
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3F210E9EA;
	Thu, 19 Mar 2026 12:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Sec0+l62";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1D410E9EA;
 Thu, 19 Mar 2026 12:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773923355; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZlhVSuRIUFXzhO+OA3Q2nQWOrAISGSWA4CEkaZUc61/Wc+k2IdJFECkRrJR3MV8PSBPAIckjJzfFXzMxiAKr0ykPzvC4exE23LEzlzQx415ldpMdirkvoOCT/2xqQr7C2AcoyAisjcFVO1qNgUCMOapdn+qDH+wtvcfvdk9kXlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773923355;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qpZcXJJWu5iOgjXzRPAyH0cclB71wo/9lwDpopULu5Y=; 
 b=U7Jahj902b+Ij+zW24yAD/URcsS3nw9LXrHPqEGIx4LslSBjsadD1a3WicIj1EsijuWJdBeiN0jcshVgIhHgeHM7us4S7H/FZ1TLX9fJ+5R0ZzeCG/GSiSJBJqvuZ8M97VvWSL695qUss3YR4AqatqTHB+cB9it79+MizAfQ3mc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773923355; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=qpZcXJJWu5iOgjXzRPAyH0cclB71wo/9lwDpopULu5Y=;
 b=Sec0+l62sPID4K5edwDw0KfKO8Xfs1SCiezBpn3U0nxsyYUGvDuTMeaz9HOmvcCS
 O4Ae2wOHM1/Toc53bkg6BBBAsdudW/L06COaTvdt0Vz497+DRIyqYf9CCVSjlLszy/S
 gWDIXgNKvzb1MUYTJXLCoIHl5rQ6yHdHSqXPJW/M=
Received: by mx.zohomail.com with SMTPS id 1773923353560846.6582348302521;
 Thu, 19 Mar 2026 05:29:13 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 19 Mar 2026 13:28:35 +0100
Subject: [PATCH v5 2/3] drm/connector: hdmi: Add support for 'link bpc'
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-link-bpc-v5-2-5306cd04a708@collabora.com>
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

Create and attach the 'link bpc' DRM property for every HDMI connector
that's created through drmm_connector_hdmi_init.

Then, set the connector state's link_bpc member in the HDMI atomic check
state helper to the connector state's HDMI output bpc.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 2 ++
 drivers/gpu/drm/drm_connector.c                 | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a1d16762ac7a..40648574f5e5 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -865,6 +865,8 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		struct drm_crtc *crtc = new_conn_state->crtc;
 		struct drm_crtc_state *crtc_state;
 
+		new_conn_state->link_bpc = new_conn_state->hdmi.output_bpc;
+
 		crtc_state = drm_atomic_get_crtc_state(state, crtc);
 		if (IS_ERR(crtc_state))
 			return PTR_ERR(crtc_state);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 878e9db2c895..572894dad4bf 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -693,6 +693,10 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	drm_connector_attach_max_bpc_property(connector, 8, max_bpc);
 	connector->max_bpc = max_bpc;
 
+	ret = drm_connector_attach_link_bpc_property(connector, max_bpc);
+	if (ret)
+		return ret;
+
 	if (max_bpc > 8)
 		drm_connector_attach_hdr_output_metadata_property(connector);
 

-- 
2.53.0

