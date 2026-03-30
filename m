Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35228F3D61E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8836F10E585;
	Mon, 30 Mar 2026 08:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="I847uVWR";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C752810E582
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 08:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774859613; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=G67CFC/fZxIhMnI1JBF8ku7caUmaH5gN6/1Yf8KuG9wUqIgpBfsIwOIfEG/wtqiJJUZZJ3sC2mEF7SJYMFGdl6yV3wN/l9vJFN5l/f+Ey0L6CbaE9tpHbGSx8MdEpu/gnaau/fP4ASDtbh/wHcVy3t1dOvHRpMn2cslcVDekv2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774859613;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aU6Hkzh2ZGMxnXb53gyh1Js8KrUAKoWYrd8TXgFTFIA=; 
 b=AttcPcpFotZM8uizTBoIE8OAswyDAehLe1MhMD9TSBhTHhd3DzfoxlhkQLXfEHQUnPepwIrz/zgYz6O5RSDaqIO4mCTAa2lRkqneWvwPj2hBoOwmNV06n/fITDOs0St3DKX8nhrfW/y5WBKqxDEhLFjR13uBbJ6GgdlPR6r4Su4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774859613; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=aU6Hkzh2ZGMxnXb53gyh1Js8KrUAKoWYrd8TXgFTFIA=;
 b=I847uVWRN8mccEOB+4RvXfePx2feCM3d3wM1JsYcvLw5ZKPeOG8Ltbxg+3ojXKCN
 +ZrHfRHWT7/S8jVbgmhFfMd1ZoicxSAvWNmZsOsUMkttsEFuoOQl8/CL06EOT3K5qP9
 lhO+YhgDXJjbr2mRRsg577oiGsBqP4t0Zqic0rGY=
Received: by mx.zohomail.com with SMTPS id 1774859611665808.5760822952676;
 Mon, 30 Mar 2026 01:33:31 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 30 Mar 2026 10:33:10 +0200
Subject: [PATCH v6 2/2] drm/connector: hdmi: Add support for 'link bpc'
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-link-bpc-v6-2-ff124af93e48@collabora.com>
References: <20260330-link-bpc-v6-0-ff124af93e48@collabora.com>
In-Reply-To: <20260330-link-bpc-v6-0-ff124af93e48@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.1
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
index 9f3b696aceeb..b670bcdbd3c6 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -887,6 +887,8 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		struct drm_crtc *crtc = new_conn_state->crtc;
 		struct drm_crtc_state *crtc_state;
 
+		new_conn_state->link_bpc = new_conn_state->hdmi.output_bpc;
+
 		crtc_state = drm_atomic_get_crtc_state(state, crtc);
 		if (IS_ERR(crtc_state))
 			return PTR_ERR(crtc_state);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 85557106218b..2a2e56bf062d 100644
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

