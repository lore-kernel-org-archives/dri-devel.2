Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA9606B47C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Dzb6nTlb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4571128C7;
	Thu,  5 Nov 2026 15:54:37 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9D81128B5;
 Thu,  5 Nov 2026 15:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894061; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EW0sBlhzbHJ+wcfTSf8BDGMsFkFf+lWXVIeMOyRMFwFc2OSKdkTST9inc7wDI62Gq85VJu6jLi/qHtz+isluoHauLmp1NnqTVvQP5cmzB7QWIDBPymI30JJlLPb0dUWUJ9oCijWBtW/NtzL+n/O9ptH9Ks88w+BXEr4KBx8cckY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894061;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ukJa6i38H9O+0wEvhzaIwEJgt1m1SU43w7laRjQC3S0=; 
 b=dzhJtMri+kRkSHDTwBhQwtHCy32MMfMIO60HvpLZykHDcnJBAH8P1GL+5Tj/UoARlgcaAZwC5Z4pWPboZXKnxuQJ6WZMBGOxv1OJfxSHcYK7ry2zJZWTkkpeedRosQ4/ywT4tzw6Gf+rFvCl8EdKVnqpllaGNG5/O+tyHwiHH64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Dzb6nTlbY4hOx6m/14LuyGTVgvB8JkhEmmR3LYmttlRqn8z6QBJCxgc/T50AgC6+AjkDaDFwdClp/fb7MPPtKEabTobz7CE8PcJH433+QsBnozFVLl0bI8rODWFRogvBc5Aixrpw/PHdpsbPDMpvRaIiRKsFSqYjxnEAc5EWW/Y=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=ukJa6i38H9O+0wEvhzaIwEJgt1m1SU43w7laRjQC3S0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894060390792.41475105125;
 Thu, 5 Nov 2026 07:54:20 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:08 +0100
Subject: [PATCH v2 17/27] drm/connector: Add "Media" VRR display mode for QMS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-17-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HDMI includes a feature called "Quick Media Switching", or QMS for
short, which builds upon the existing VRR to allow for quick switching
between a select few common frame rates.

Add a new VRR display mode, "VRR_DISPLAY_MODE_MEDIA", to the
vrr_display_mode connector property, in order to expose support for
this.

Additionally, add a boolean flag to the connector's HDMI sub-struct with
which source-side support for QMS can be indicated, as well as the QMS
tfr byte to the HDMI state sub-struct.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_connector.c |  6 ++++++
 include/drm/drm_connector.h     | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 21222214a843..f7d619926e2d 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1456,6 +1456,7 @@ DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
 static const struct drm_prop_enum_list drm_vrr_mode_enum_list[] = {
 	{ VRR_DISPLAY_MODE_GAME,   "Game" },
 	{ VRR_DISPLAY_MODE_OFF,    "Off" },
+	{ VRR_DISPLAY_MODE_MEDIA,  "Media" },
 };
 DRM_ENUM_NAME_FN(drm_get_vrr_mode_name, drm_vrr_mode_enum_list)
 
@@ -2593,6 +2594,11 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *	    - Game - set display to game mode if display supports it,
  *	      regardless of CRTC state
  *	    - Off - set display to VRR disabled mode, regardless of CRTC state
+ *	    - Media - a "media" VRR mode that only supports a select number of
+ *	      common media refresh rates as fixed targets, but does so with
+ *	      possibly better display-side processing. In the HDMI display
+ *	      protocol, this is QMS (Quick Media Switching), though the mode
+ *	      enum itself is vendor-agnostic
  *
  * VRR Limiter/Target Properties
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 4801bb2769e1..41f272afbb1e 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -829,6 +829,8 @@ enum vrr_display_mode {
 	VRR_DISPLAY_MODE_GAME = 0,
 	/** @VRR_DISPLAY_MODE_OFF: Turn off VRR on the display */
 	VRR_DISPLAY_MODE_OFF,
+	/** @VRR_DISPLAY_MODE_MEDIA: Protocol-agnostic fixed rate media mode */
+	VRR_DISPLAY_MODE_MEDIA,
 	/** @VRR_DISPLAY_MODE_COUNT: Sentinel, not a valid mode, keep last */
 	VRR_DISPLAY_MODE_COUNT
 };
@@ -1241,6 +1243,12 @@ struct drm_connector_hdmi_state {
 	 * deliberately not requested by the helper.
 	 */
 	bool scrambler_needed;
+
+	/**
+	 * @qms_tfr_byte: Target frame rate byte for HDMI QMS, or 0 if QMS is
+	 * not in use.
+	 */
+	u8 qms_tfr_byte;
 };
 
 /**
@@ -2270,6 +2278,12 @@ struct drm_connector_hdmi {
 	 */
 	bool scrambler_enabled;
 
+	/**
+	 * @qms_supported: Whether the connector supports HDMI Quick Media
+	 * Switching (QMS) on the source side, irrespective of display support.
+	 */
+	bool qms_supported;
+
 	/**
 	 * @scdc_work: Work item currently used to monitor sink-side scrambling
 	 * status and retry setup if the sink resets it.

-- 
2.56.0

