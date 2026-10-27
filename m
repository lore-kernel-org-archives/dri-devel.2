Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482A606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=dI0nJB0o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1906110E494;
	Tue, 27 Oct 2026 19:03:08 +0000 (UTC)
X-Greylist: delayed 497 seconds by postgrey-1.36 at gabe;
 Tue, 27 Oct 2026 19:03:02 UTC
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 663D310E494;
 Tue, 27 Oct 2026 19:03:02 +0000 (UTC)
Received: from abreu (unknown [185.238.219.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 063D04C1A256EE;
 Tue, 27 Oct 2026 19:54:21 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Wentao Liang <vulab@iscas.ac.cn>, Alex Hung <alex.hung@amd.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Don't warn about vendor infoframe for
 non-infoframe sinks
Date: Tue, 27 Oct 2026 19:54:13 +0100
Message-ID: <20261027185414.162183-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1793127263; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=4aG9p3Chmdw2Uvqo6sRKdBC6007ynLccNNDb6g2oQZ8=; 
 b=dI0nJB0o5kLbZ7MZDpxH5+wDkkUpl0UfZIj5R5+cfOgB5Dpf5Vw8wziwa+uOlOZ66Gxf3uLnHtRK
 /nLcvyz8SZNurt0mOaFYVckC4bkpE73yibUoY/ibYsPMZgGWFclcopsPuSHnBPBV6evTqJn/YHqmaX
 OSiSnjP1reFn0Xu9sf9rW4+04GaesQsMOD5w5nCjwegltJGW75sfeERX2lurmaP9/ssRFjd6P7w61a
 58bRQCS/5X72QN0pXGiP6r957AEik9jSigsWq61elnuvSx8+Ve94z2KvRH4skHNUvRZkju+trIoBuZ
 AjLrwn2p4NeqQOcKp7Tdw+6HUA0bg7Ww==
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With an EIZO EV2781 connected over HDMI to an AMD Ryzen 3 2200G (Raven)
on an MSI B350M MORTAR (MS-7A37), Linux logs at every boot since v6.16:

    amdgpu 0000:30:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22

Commit 6027cbee1900 ("drm/amd/display: Add error check for avi and
vendor infoframe setup function") started to log the return value of
drm_hdmi_vendor_infoframe_from_display_mode(). With `frame` and `mode`
being non-NULL, the helper only fails with -EINVAL, if the sink does
not support HDMI infoframes, that means, if
`connector->display_info.has_hdmi_infoframe` is false, and its
kernel-doc says, that this error can be safely ignored.
drm_parse_hdmi_vsdb_video() only sets `has_hdmi_infoframe`, if the HDMI
VSDB has HDMI_Video_present set, and drm_parse_hdmi_forum_scds() sets
it for sinks with an HF-SCDB. So an HDMI sink, whose VSDB lacks
HDMI_Video_present, triggers the warning, although nothing failed.

The EIZO EV2781 is such a sink. Its HDMI VSDB has a payload of only
seven bytes (source physical address, Supports_AI, and a maximum TMDS
clock of 250 MHz), so the byte with HDMI_Video_present is absent, and
the EDID has no HF-SCDB:

    67 03 0c 00 10 00 80 32

Only warn, if the sink supports HDMI infoframes. The infoframe setup
itself is unchanged.

Fixes: 6027cbee1900 ("drm/amd/display: Add error check for avi and vendor infoframe setup function")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5025
---

Notes:

claude-opus-5-5 (Claude Code) assisted in analysis, code change and
commit message.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ded8e21897f1c..636dd2dedd73d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -941,7 +941,8 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 		err = drm_hdmi_vendor_infoframe_from_display_mode(&hv_frame,
 								  (struct drm_connector *)connector,
 								  mode_in);
-		if (err < 0)
+		/* Sinks without HDMI infoframe support make it fail with -EINVAL. */
+		if (err < 0 && info->has_hdmi_infoframe)
 			drm_warn_once(connector->dev, "Failed to setup vendor infoframe on connector %s: %zd\n",
 				      connector->name, err);
 		timing_out->hdmi_vic = hv_frame.vic;

base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
-- 
2.54.0

