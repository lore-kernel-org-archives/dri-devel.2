Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFA2C44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0261B10E6EA;
	Mon, 20 Jul 2026 07:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="eiGP9vZk";
	dkim-atps=neutral
X-Greylist: delayed 1295 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 12:24:01 UTC
Received: from th8-a.mail-neoserv.si (th8-a.mail-neoserv.si [152.89.234.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E03210F53F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:24:01 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=lXgj+1ffX/jTBrSObabQuY6OKjOjtXn9e47ECWEvr0lQoSBVO8bBDxI9KPS6Kd2vFdpFmkNPIM
 1223Uhs+S5MIKyuf1JiQUF9/wI3Xk/R28/S0Dm3/V/j8R4J1MiEI6ZSfVc1KdWsfxeL0qRhxLD
 mF7E8UoaB6V9Pjd1t/E9D7e1ygYfubMC+RVLLIFU4HnHp/jcfVZHSqi6HXv5uPl+2LcZhiYPh7
 KXkhWfU2hSOdv3TIfhfzZOsOcRuDrfnOW5xq8qG0md3EhoDEWrx9LF8RuHKX8jYa0I6MuqcVp8
 +yXDImeQU9ULbqwKhfr+sS9oxn07FYuP+PFBDmag815HUQ==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=PHP7QiIbT0+ZzX++1crhTY5wkWTq6BCV5utX6ace2e8=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=MiYMT1f/pbj9dTD0yOEwy+BqzSRkrZrrmIS+qIOI4oa++IRhX7cqC3hhQlOiEuxCn6wt0C90/r
 5rbbMJ6er0OFMnxhEGkPVrEXixylFUox+736+S/FKDpy7GWMP+feI0wzHE8MxBAthMmDMKpxky
 CuLX9dME3QDVdG7JYSdl28+R7E/QBIvVv+hDqt6vEYvDVxnei5+DHUHH8QvkSufatrx1qOtkUB
 5GwijCewAGM38Mjy/TtPWXaBEGI3GKv5LKTOJ0bncDORSvCFRJ//FLFcivpIMKS9Pu/17m+Lk0
 H2Nz2IeEiL3EItTcrSz5BDbmRs3ElIJluNfreorcSe3e3A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gA+LgbDDmWtKcLIZGrCT2OufglfLr6cc3fRTD6cDRVQ=; b=eiGP9vZkQ/Zf+r72xzXfnBvZR0
 Ue5EWPbdbJ52mOIoxIeiHFlM2UCYm+1j4xmbidFNqeu/xLZnI02i3kRf7R6/HD+GJSytjURvozPfy
 Tzbq7R1RUT3SDthXXTYK2uVF5R3CcDUJ0togWkoF+ZdcV1+sAuG5MzfNWFHum1RncjPurB2lXR1KJ
 GvJRmZd1AmWpWp//vTJEDFTC5Mc+5fcSEqNNM4QlxSv9xiRa7oNMd5+1mLlaaPQx3iNlP/3e7DGry
 jGYVFPVeNw2dM5062u0cxU5EhkPemtLhEvZBz2KuvSBCc3lLmGbzsVMR0VP668bZzZ8nJ+N4i2CGF
 Q35XdC3Q==;
Received: from [193.77.36.193] (port=54788 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wkhH0-00000001fP1-1pwy; Fri, 17 Jul 2026 14:02:34 +0200
From: Rok Markovic <rok@kanardia.eu>
To: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alibek Omarov <a1ba.omarov@gmail.com>,
 Rok Markovic <rok@kanardia.eu>
Subject: [PATCH 1/4] drm/rockchip: lvds: propagate bus_flags to the CRTC state
Date: Fri, 17 Jul 2026 14:00:02 +0200
Message-ID: <20260717120005.2087386-2-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717120005.2087386-1-rok@kanardia.eu>
References: <20260717120005.2087386-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wkhH0-00000001fP1-1pwy
X-NEOSERV-MailScanner: Found to be clean
X-NEOSERV-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=1.31, required 7, ALL_TRUSTED -1.00, BAYES_50 0.80,
 KAM_DMARC_QUARANTINE 1.50, KAM_DMARC_STATUS 0.01)
X-NEOSERV-MailScanner-SpamScore: s
X-NEOSERV-MailScanner-From: rok@kanardia.eu
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - th8.neoserv.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kanardia.eu
X-Get-Message-Sender-Via: th8.neoserv.si: authenticated_id: rok@kanardia.eu
X-Authenticated-Sender: th8.neoserv.si: rok@kanardia.eu
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

rockchip_lvds_encoder_atomic_check() sets output_mode and output_type
but never copies the connector's bus_flags into the Rockchip CRTC
state, unlike dw_dp-rockchip.c and dw-mipi-dsi2-rockchip.c which both
do.

panel-lvds parses pixelclk-active from the DT display timing and
publishes it on the connector as DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE.
VOP2 reads that flag back out of the CRTC state to decide
POLFLAG_DCLK_INV. With the flag dropped here, vcstate->bus_flags is
always zero, so a panel that asks to be clocked on the falling edge is
driven on the rising one, and there is no way to express the panel's
requirement from DT at all.

No functional change for the SoCs currently supported by this driver:
rk3288 and px30 pair with the VOP1 driver (rockchip_drm_vop.c), which
never reads bus_flags - only VOP2 consumes it. The flag becomes live
with the RK3568 support added later in this series.

Signed-off-by: Rok Markovic <rok@kanardia.eu>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 75f898a..95fa0a9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -129,7 +129,15 @@ rockchip_lvds_encoder_atomic_check(struct drm_encoder *encoder,
 				   struct drm_connector_state *conn_state)
 {
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
-
+	struct drm_connector *connector = conn_state->connector;
+
+	/*
+	 * The VOP derives the pixel clock polarity from this. Without it a
+	 * panel that declares pixelclk-active = <0> is clocked on the wrong
+	 * edge. panel-lvds fills the connector's bus_flags in from the DT
+	 * display timing.
+	 */
+	s->bus_flags = connector->display_info.bus_flags;
 	s->output_mode = ROCKCHIP_OUT_MODE_P888;
 	s->output_type = DRM_MODE_CONNECTOR_LVDS;
 
-- 
2.43.0

