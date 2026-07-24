Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5959C53209
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331A210F33C;
	Fri, 24 Jul 2026 08:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="iInyA7bi";
	dkim-atps=neutral
Received: from th8-b.mail-neoserv.si (th8-b.mail-neoserv.si [152.89.234.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B605110F33C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:09:05 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=bDzJiLwGfDnvzRu8uG4cfvScMD5vIXyArkf23vZmaxB4iabXsUCYfcYRsDPJr2e/YaglTwtySm
 DkffUEGZzNOYzmtXXEEsoOVnmrTLDR7F9ZISTFcM34iTUSSR4sHpSQYbgSxA8Vy2nEU6XpMW41
 2ng9rUdIGkUICz0bUHLggeRIVcv2jyFqeA9LipVmM9+Tp7xkf9FDTI4QoyL2b/5+NbfHDbVjdK
 tmUnihzw3zmWDyx/L//pUGff4M9vQAo+1a+Qwrk/iK2474hmrGUfNQjsTnmeXKSIWG0Mm3qxvH
 nGNERWTj8G4o392q87BI7jGfrYdfL+0EBP0ISoXAbLs+DA==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=zmvwDaEmtiQC/1srLnAabC4qqpmkbkGlQJnQfvBWPwo=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=ieXfNiOoass3sk3OFKyexuJ0/tA/G2MLt02IuL6HB8cYIvW9yBhuSDmwQyrzvi3L5ggkmZ4wo0
 rW2dKyBu0cMFUPDV0+OaOxa0XUPfiWUTljSqFLAuuMNPmOeym/60PEt/MY7cTzDXRfvkBmb3cE
 om8Ba4gB14balFm9ycYu3OzT2d8XUWUxpD5mjsxifL6Pcv86/4efDPHIhdyJbfpbMXhHWCUlpU
 d1hRYQCaDZ+yT49vFqe4baPWT9fq4/0vYv2oSrZTlTyKAZwhSJmv4+DHykNNYc0eTz0SOwbCWZ
 DeUyOT9tSnbLBqCwp9t8Q87QRqafH/tHy1blE0bvE3ZpOg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5vaO/GM91G3rNsV69zS2AeHYbUZzZm3t2t1r+BkuECs=; b=iInyA7bi4kZSnS6rEumt7ravpL
 FZaKQB5TWF+3Xtil21ZpRPm1ZrKVlYNynjC8SDdILactGS6Xmx0gjpmBR6FAZ/yHRHWlZ+WzISwgt
 zEKAEL4YoyHQ+8zuAhFen3nCy1p+/3CYiNmCdw0JitE6dVHAxGQa5bBtBitEf11Ja/A7QIzSSzT0n
 sIuwyMe2o7xyooVO3fCVxhXdLknLvI3r9CCW/fewyYg1/DG5tVEnZHdTS3FemqrmXZ4klOScFpRhw
 3FwxLqulFjMhr8wazTh1z4ARESJi/EYfeTCYL8eB7Vruz8zujFYcZPe+xsBZwLgDGXmei7k933Mhu
 g0FYDM3g==;
Received: from [193.77.36.193] (port=41890 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wnAxL-0000000AcoX-0Be1; Fri, 24 Jul 2026 10:08:31 +0200
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
Subject: [PATCH v2 1/4] drm/rockchip: lvds: propagate bus_flags to the CRTC
 state
Date: Fri, 24 Jul 2026 10:08:21 +0200
Message-ID: <20260724080824.115260-2-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724080824.115260-1-rok@kanardia.eu>
References: <20260724080824.115260-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wnAxL-0000000AcoX-0Be1
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
No changes since v1.

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

