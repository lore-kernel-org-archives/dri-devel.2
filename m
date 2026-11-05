Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95C60A3820
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kJ6f17vw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0371128FA;
	Thu,  5 Nov 2026 15:55:00 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6A51128CF;
 Thu,  5 Nov 2026 15:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894085; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VhskGWTmhRP+s548VmCcgGW+MDFRplI3W1sF9BzPT0OBohPMTdFqEPjYnvB5TPTv741uWvGnYRMVAJCmU5K+9eYNdCvNSa/j0aahyGMcY7HRGIQBFvLzr9VjC72Febj93pHnBfADk852RstJlv6Y9T+juGJRdhY3wGcYzcJqtFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894085;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=igQATVU1Yc1Mn+dz931w/tbusWSL5LcSoV79LRLrIvI=; 
 b=NGUgAw30ItGE+Kb7RWCydoVWwEgBxhxjdzLz5TUlW022cNoDK/OBPxKPG8OD+RPm+Eajey62DiR3bCLk/TWDvyShghb5SGKQTyGzEpJpFJ8jcFDwOelvu+aN2sP3/DI/Rj/mf00w3dHy1TRKR1STprfRPE4plrRAqsTIRaLvlsI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=kJ6f17vwJuXHaq/0T1adxJqc2OOuiy9DPWOKBi//vAoyjUQRSrp/wZEOFzoco3zytHJmmr4JMrNt4uRkltIjTzsH13FI6SkX3l3VCfgReumNM96fPFRemug4lGJ8Bw3PCjfayyeccPKwOmj249szHdkf4rmqVYxMUif2MB5RRoQ=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=igQATVU1Yc1Mn+dz931w/tbusWSL5LcSoV79LRLrIvI=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894084835140.54892489016675; 
 Thu, 5 Nov 2026 07:54:44 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:12 +0100
Subject: [PATCH v2 21/27] drm/rockchip: dw_hdmi_qp: Add QMS support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-21-55f4215be2c2@collabora.com>
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

Add the "Media" VRR display mode to the set of VRR display modes being
registered, and set the qms_supported flag in the connector's HDMI
sub-struct. The actual QMS functionality itself is implemented in the
common HDMI state helpers.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index dcde50bca36b..215cf746dc41 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -90,7 +90,8 @@
 #define RK_COLOR_FMT_YUV420		0x3
 
 #define RK_VRR_DISPLAY_MODES		(BIT(VRR_DISPLAY_MODE_GAME) | \
-					 BIT(VRR_DISPLAY_MODE_OFF))
+					 BIT(VRR_DISPLAY_MODE_OFF) | \
+					 BIT(VRR_DISPLAY_MODE_MEDIA))
 
 struct rockchip_hdmi_qp {
 	struct device *dev;
@@ -753,6 +754,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 			return dev_err_probe(hdmi->dev, ret,
 					     "Failed to attach 'vrr_display_mode' property\n");
 
+		connector->hdmi.qms_supported = true;
+
 		ret = drm_connector_attach_vrr_display_limits_properties(connector);
 		if (ret)
 			return dev_err_probe(hdmi->dev, ret,

-- 
2.56.0

