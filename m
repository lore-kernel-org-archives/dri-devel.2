Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46758606A32E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7N1Rr7Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF38D10F8C0;
	Tue,  3 Nov 2026 22:42:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1C010F770;
 Tue,  3 Nov 2026 22:42:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EA4360A90;
 Tue,  3 Nov 2026 22:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1519F1F00A15;
 Tue,  3 Nov 2026 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745746;
 bh=7uMkYbECLUxTM5pa0kbpXZQUVRouDnrW7EIXtuo+nfk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=L7N1Rr7YXLGtfentC4e92qKHIdhSAESR8rBOSUSaDNmbU41lY7iWvzXdWmT+2nLcs
 DrCzNGclNax/V7Hq1Yl6/+PNjpSC8PGctGeERhD0wdN/5oZIC0faJVkEnVbU3JkPqQ
 nPPnzro08OLFCw1TIOA3zKpYa62DNimUl1ISjiq0+YhlMaPo+aY/swuP/Hg3J8z85d
 edlbWvL5m+Xsi0dG7yadtPyLCfVcW2TYEoNC0y9dHKqc2pMiBDi31zvk1make2Joao
 UrX9eojlOPxY62hz0nPNkf2WadHW2C4BmDZmZk3HgLIOwvACEdJM5QnI2cXiZOZrmI
 5gbad6ha0vboA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:07 -0600
Subject: [PATCH v11 06/12] drm/bridge: add connector luminance operations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-6-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
In-Reply-To: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mario Limonciello <mario.limonciello@amd.com>

Allow bridges that own brightness control to advertise a luminance
operation and its supported relative range.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Drop panel bridge declarations re-added by a bad rebase (Sashiko)
 * Document @luminance as the initial level
v10:
 * Split bridge operations out of the combined panel and bridge patch
---
 include/drm/drm_bridge.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d2..240a69c1233e7 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -62,6 +62,15 @@ enum drm_bridge_attach_flags {
  * struct drm_bridge_funcs - drm_bridge control functions
  */
 struct drm_bridge_funcs {
+	/**
+	 * @set_luminance:
+	 *
+	 * Apply a relative luminance level to a bridge that controls panel
+	 * emission. Bridges implementing this callback shall set
+	 * @DRM_BRIDGE_OP_LUMINANCE.
+	 */
+	void (*set_luminance)(struct drm_bridge *bridge, unsigned int luminance);
+
 	/**
 	 * @attach:
 	 *
@@ -1021,6 +1030,11 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+
+	/**
+	 * @DRM_BRIDGE_OP_LUMINANCE: The bridge controls panel luminance.
+	 */
+	DRM_BRIDGE_OP_LUMINANCE = BIT(11),
 };
 
 /**
@@ -1071,6 +1085,12 @@ struct drm_bridge {
 	void *driver_private;
 	/** @ops: bitmask of operations supported by the bridge */
 	enum drm_bridge_ops ops;
+
+	/** @luminance_max: Maximum relative luminance level. */
+	unsigned int luminance_max;
+
+	/** @luminance: Initial relative luminance level. */
+	unsigned int luminance;
 	/**
 	 * @type: Type of the connection at the bridge output
 	 * (DRM_MODE_CONNECTOR_*). For bridges at the end of this chain this

-- 
2.53.0

