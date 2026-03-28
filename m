Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0C0F3D5FE
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 09:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4572B10E131;
	Sun, 29 Mar 2026 09:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JmpsrmG9";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E496D10E004
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 14:14:39 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486ff201041so28818585e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774707278; x=1775312078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4vlVVvxWEWO2r6arzInv5eisxXfXrLq1ekNSjOyYGg=;
 b=JmpsrmG9AiUz1NeObMZGxW5oAfNw/xMQDMHyU+rBq9twuVZzw8gc3kpC9hTD9Q+GRF
 Mx0HFwo/nmFkT9TEcX7nYFONuOAPqM6snEzhVnXkbA54sJ8fpl9nPHgjMBFbIsij1k8W
 Pqn1Z6SStxHz8JemmhVt1v+oMOsMMqcq2QtU4HmmUxi/5m3SOm+pXZ/aJEcP3N9QVUYM
 xTwhRU02S9R0fJQB9EOGje5lC1zYKfKw0uMu4ERvcP2kXCbrBJBg/kP+eR549HI/73Wh
 33+Vm+XWlY31QKUVfB3LkfBwWnah7QOQOgpYw37xnrSl4YQarJSyZnRzfxtZvXehDvpE
 W0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774707278; x=1775312078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t4vlVVvxWEWO2r6arzInv5eisxXfXrLq1ekNSjOyYGg=;
 b=Uh55y29aRcJV1xeUyDGwRyRfgixAQYE0hoowuqyHizU+JKEj6TeM+EUkZXNBRq3EPq
 hpCGp83bnX+4Mb4uRdEcNC93vG7y1aAPQr44+T5SIXu3SettU3CZMPLkeivZeM+yGTar
 e8eWuHU3qwmPN/uYOE+K3+JjTFjy74nahqP+6IH/VhYmmfay+yNw3CtKRzDoDljE7Oy+
 nkdgFnwX2kOQSU5a4tV5JpNDugOXdbng09w/++/MvnDmgwdRS2xqBXSB/+daLinzz2Qz
 VmvsM6wulBnH8B+OJxctLOcxJBGZ4BK4ONb46aPxyobdx8t6jdlTBLy6om3TMWsayGNy
 2h2Q==
X-Gm-Message-State: AOJu0YwRwTKwuOyKpSXpAl4yKlNqz2BQ5gXsI0khYc2rgCF0DwcFZlb+
 XF5SZbG6DSkW3vqmSeRNajyGgxrPTXaonmOOF4gmTg5/vS+C5gGMkfuO6Y3ic07F
X-Gm-Gg: ATEYQzwx9wdg0FRtR6ImciImBBl01jWcsfZyK+YnRhAz0i75HyB/E2Dh1N3lgoFqMKA
 Txhx7eid/4lzMG5sY7bNQzbeb/2G1yAAb/j1Z666S7X5DfW/MNr9ZlkmnciKAJhXLy7pN1jwNDV
 qDxKIOPSlptkvzt+JnkB1k6Y+0TcXLXb9KTJQDL+tOuefGSSn/RF35CqeGyVHakYXXjTft7FL4j
 C6UfygeycI2J8BiRYk1/cRailWK11MvEX1cOyOCmQCrtO5uh18Qzi3zFJqtQ89n0yxeMgBGGKL9
 onznW41pLX/gOOEc7bIcD1lTLXrCJzNg39xjwBUq0JBidwsHBuBKmACbsRGPBgYvxtFhouNNOSw
 CIkOgIKi2r5S9+XNSrLa0ui/MpUo7ioM4TmhrQIqy6/rMmKFfux5h49+O5SozRHR/OkTdoMWdn5
 GW30m1VB968Ulh/DkgoHTB6/DjJDI+vzLYzRhvYsImpHXVleuxmBA6qc1OnQ==
X-Received: by 2002:a05:600c:41c4:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-48727d8410cmr71470085e9.14.1774707277993; 
 Sat, 28 Mar 2026 07:14:37 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it ([87.13.132.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730628efasm80210335e9.5.2026.03.28.07.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 07:14:37 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, alexander.deucher@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adriano Vero <litaliano00.contact@gmail.com>,
 Rodrigo.Siqueira@amd.com
Subject: [PATCH 2/2] drm/amd/display: remove manual DisplayID VRR parsing from
 freesync caps
Date: Sat, 28 Mar 2026 14:20:27 +0100
Message-ID: <20260328132027.22383-2-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328132027.22383-1-litaliano00.contact@gmail.com>
References: <20260328132027.22383-1-litaliano00.contact@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:53:39 +0000
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

parse_edid_displayid_vrr() walked raw DisplayID bytes via struct edid*
to find Dynamic Video Timing Range Limits blocks when monitor_range
was zeroed. This is a layering violation.

Now that drm_get_monitor_range_displayid() in the DRM core fills
monitor_range from DisplayID Dynamic Video Timing blocks via the
proper displayid_iter infrastructure, parse_edid_displayid_vrr() is
redundant. Remove it and its drm_edid_raw() call from the VRR path.

drm_edid_raw() remains for parse_amd_vsdb() and parse_hdmi_amd_vsdb()
which read AMD vendor-specific CEA data blocks; those are tracked
separately.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo.Siqueira@amd.com
Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 61 ++++---------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 085cc98bd..c61d6e1fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13110,49 +13110,6 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return ret;
 }
 
-static void parse_edid_displayid_vrr(struct drm_connector *connector,
-				     const struct edid *edid)
-{
-	u8 *edid_ext = NULL;
-	int i;
-	int j = 0;
-	u16 min_vfreq;
-	u16 max_vfreq;
-
-	if (!edid || !edid->extensions)
-		return;
-
-	/* Find DisplayID extension */
-	for (i = 0; i < edid->extensions; i++) {
-		edid_ext = (void *)(edid + (i + 1));
-		if (edid_ext[0] == DISPLAYID_EXT)
-			break;
-	}
-
-	if (i == edid->extensions)
-		return;
-
-	while (j < EDID_LENGTH) {
-		/* Get dynamic video timing range from DisplayID if available */
-		if (EDID_LENGTH - j > 13 && edid_ext[j] == 0x25	&&
-		    (edid_ext[j+1] & 0xFE) == 0 && (edid_ext[j+2] == 9)) {
-			min_vfreq = edid_ext[j+9];
-			if (edid_ext[j+1] & 7)
-				max_vfreq = edid_ext[j+10] + ((edid_ext[j+11] & 3) << 8);
-			else
-				max_vfreq = edid_ext[j+10];
-
-			if (max_vfreq && min_vfreq) {
-				connector->display_info.monitor_range.max_vfreq = max_vfreq;
-				connector->display_info.monitor_range.min_vfreq = min_vfreq;
-
-				return;
-			}
-		}
-		j++;
-	}
-}
-
 static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			  const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -13288,13 +13245,17 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
-	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
-
-	/* Some eDP panels only have the refresh rate range info in DisplayID */
-	if ((connector->display_info.monitor_range.min_vfreq == 0 ||
-	     connector->display_info.monitor_range.max_vfreq == 0))
-		parse_edid_displayid_vrr(connector, edid);
-
+	/**
+	 * monitor_range is now populated by the DRM core from both classic
+	 * EDID Monitor Range Limits descriptors and DisplayID Dynamic Video
+	 * Timing blocks (tag 0x25) via drm_get_monitor_range_displayid().
+	 * parse_edid_displayid_vrr() has been removed.
+	 *
+	 * drm_edid_raw() is retained only for parse_amd_vsdb() and
+	 * parse_hdmi_amd_vsdb() which read AMD vendor-specific CEA blocks.
+	 * Removing those raw accesses is tracked separately.
+	 */
+	edid = drm_edid_raw(drm_edid); /* TODO: amd/hdmi vsdb refactor */
 	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		if (amdgpu_dm_connector->dc_link &&
-- 
2.47.3

