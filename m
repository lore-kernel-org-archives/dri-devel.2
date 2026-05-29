Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF0CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 08:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CF610FB11;
	Fri, 29 May 2026 08:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O8s48cSf";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C45310FB09
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:47:27 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95C727B4D;
 Fri, 29 May 2026 10:47:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780044426;
 bh=DHuOXKyQxpcTOy5x53Zexfuh3BWQvmfeYJKfQK1Z26s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=O8s48cSfjhNkiIx/wnKhC+xMIyi3+m3KeSB/uvv3vDNyai+pKDHiAKPYzRXOxLf69
 SIdadf8OleiVZsP+2j2fZXfsSFpSvVBB/VKmTj9zAIPnX1mQh3HeNcsY5zdnleA1la
 VHVGPUpbN4KLou1kltJe+tSPFKn0Njv/gkGP0Hhk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 29 May 2026 11:45:40 +0300
Subject: [PATCH v3 10/15] drm/tidss: Add support for DPIENABLE bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-beagley-ai-display-v3-10-7fefdc5d1adf@ideasonboard.com>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
In-Reply-To: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4278;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=DHuOXKyQxpcTOy5x53Zexfuh3BWQvmfeYJKfQK1Z26s=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqGVKOPFfKPW4Yjy901NZa/0LRqzdDa3Z2EXPLn
 3wJhLujCxyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCahlSjgAKCRD6PaqMvJYe
 9dtiD/4hFxJJ5VPq7f7l7p1JGOByDqT4a87uJwq8rvzI5ZHLIQ8B7t7PKnu+e3kt6PcNhjfstEm
 Bt/h+F+x14Bv2eSowjm5Z33IYY0s1xZkjSAz2bQvFLWok++etmjqAszHh4jgRGkpI4hZfVsDHux
 7GR+08A276Ipo+2oQyYE3oqBZjdkqPuBsOkqpPcnoaRihChuCAABAMCdQHXdD0SAHcPNXCkThUY
 rDgtrdrMuCGwMKYE3HkcvLol7aPLM7SkD7JMiWiv18tnI4yg17lOEHWj3Kj0g42dcgrWrv55hvC
 fYTUo/P3yaN0fq+p2M0ckyiklU1SiYNaEQzgQG5GwueiXe4oUu5yEuOsUhcbBngRqdDloAI33Ez
 WC9GmanZK4YeIuMRXJNspGro9qSjcJC6Zg9U9hG7+Vv2FTxt0DxfHvBK84kH0rCs/VgliYFM+4t
 eXD5nu/vmUcztiXiF90qnkSZDxTQyrs4wqFDEHR4+oI1VtORVbkvbt6N7t3namKKDXexEMVC1Fn
 /Q++VOcfNaOQ/5AW+PgPnyKmAB48IRUtBO9T2uDI+61HYdYX8QlJxWE0xwO7DjCNRPW2FBVSVJV
 ApbIH2UuuKMkZVp6hAVE6EdP5T55fbU9ZJNTpcKQhHLGCmmVoSovbZCaf8F0F1xNjkTBZtqpvqE
 jHuLcV3d/dWScWw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Many (or even all?) K3 SoCs have DSS VP_CONTROL.DPIENABLE bit described
in their documentation. This bit controls whether the DPI block is
enabled, and is set to 1 by default (i.e. DPI is enabled at HW reset).

However, in almost all SoCs the setting does not actually do anything,
and at the moment the bit is not managed by the driver.

The exception is AM62L, which does have DPIENABLE connected, and
disabling the DPI block when it is not in use provides power savings.

Let's add a new feature flag for this, 'has_vp_control_dpienable', and
implement the support.  Disable DPIENABLE for all videoports at resume
time, so that it is 0 by default. Specifically enable and disable it in
dispc_vp_enable() and dispc_vp_disable() for DPI output.

Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c      | 23 +++++++++++++++++++++--
 drivers/gpu/drm/tidss/tidss_dispc.h      |  2 ++
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 08342a9a5e8c..1b8d52f10673 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -442,6 +442,8 @@ const struct dispc_features dispc_am62l_feats = {
 	},
 
 	.vid_order = {0},
+
+	.has_vp_control_dpienable = true,
 };
 
 static const u16 *dispc_common_regmap;
@@ -1210,6 +1212,11 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 			     (!ipc ? DPI0_CLK_CTRL_DATA_CLK_INVDIS : 0) |
 			     (rf ? DPI0_CLK_CTRL_SYNC_CLK_INVDIS : 0));
 	}
+
+	if (dispc->feat->has_vp_control_dpienable &&
+	    dispc->vp_data[hw_videoport].dpi_output)
+		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
+			       DISPC_VP_CONTROL_DPIENABLE_MASK);
 }
 
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
@@ -1226,6 +1233,11 @@ void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
 
 void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
 {
+	if (dispc->feat->has_vp_control_dpienable &&
+	    dispc->vp_data[hw_videoport].dpi_output)
+		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
+			       DISPC_VP_CONTROL_DPIENABLE_MASK);
+
 	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
 		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 0);
 
@@ -2445,10 +2457,17 @@ static void dispc_vp_init(struct dispc_device *dispc)
 
 	dev_dbg(dispc->dev, "%s()\n", __func__);
 
-	/* Enable the gamma Shadow bit-field for all VPs*/
-	for (i = 0; i < dispc->feat->num_vps; i++)
+	for (i = 0; i < dispc->feat->num_vps; i++) {
+		/* Enable the gamma Shadow bit-field for all VPs*/
 		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1,
 			       DISPC_VP_CONFIG_GAMMAENABLE_MASK);
+
+		if (dispc->feat->has_vp_control_dpienable) {
+			/* Disable DPIENABLE for all VPs */
+			VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONTROL, 0,
+				       DISPC_VP_CONTROL_DPIENABLE_MASK);
+		}
+	}
 }
 
 static void dispc_initial_config(struct dispc_device *dispc)
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 6f53d554259c..0fbfb86adfbf 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -92,6 +92,8 @@ struct dispc_features {
 	u32 num_vids;
 	struct dispc_vid_info vid_info[TIDSS_MAX_PLANES];
 	u32 vid_order[TIDSS_MAX_PLANES];
+	/* The DSS has VP_CONTROL.DPIENABLE bit */
+	bool has_vp_control_dpienable;
 };
 
 extern const struct dispc_features dispc_k2g_feats;
diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
index 4cdde24d8372..4246c72efdd5 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
@@ -230,6 +230,7 @@ enum dispc_common_regs {
 
 #define DISPC_VP_CONTROL			0x4
 #define DISPC_VP_CONTROL_DATALINES_MASK			GENMASK(10, 8)
+#define DISPC_VP_CONTROL_DPIENABLE_MASK			GENMASK(6, 6)
 #define DISPC_VP_CONTROL_GOBIT_MASK			GENMASK(5, 5)
 #define DISPC_VP_CONTROL_ENABLE_MASK			GENMASK(0, 0)
 

-- 
2.43.0

