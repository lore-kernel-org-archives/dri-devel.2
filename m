Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017FEC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3B210E0CE;
	Sat,  4 Jul 2026 18:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="piotc2Xu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GlAbFsJn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D0610E0CE
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:33:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664G8VYf3375933
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 18:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eQ2wkGh9OQFPGIh6+CsATSCyNIJhVVQjedvP3yUcR8I=; b=piotc2XuZr1Bos25
 5+otg4KB3av2dGCjMnxed7l9UNU1sVMI2kUsiZRBoFsmF86yqMxA6CL0XqY4mJKJ
 uLWJ26w7JLB6hTr5Y3blAe6hFdllG5Aab+MVAsOysh3S6GhGS15NxNYaOuz0dnQJ
 htQBNF/gMJPFMGVxcqqLNF37XPK2aFHwhZSIAVMt9dTDs/ETvdinooP5J+47b0Hm
 Q9ekeu9T31+WduIFfsCcgQWiIX9OcelaDpS/L77sJM9YzYgVG060Xug0K2nH30TX
 Es+o2G8e7KL9jEKWjSOVlMEZrqiwc2DJvPfilJZMgXagYwb30oTfgLMCrpBA6syy
 Ia0rew==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnhp86-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 18:33:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8478e9c4bd2so1568857b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783189983; x=1783794783;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eQ2wkGh9OQFPGIh6+CsATSCyNIJhVVQjedvP3yUcR8I=;
 b=GlAbFsJnePvWm0Dp3AMJ/ZQJ/ymLrC3HZlKbV1sktAOtzdNDOXnHR+vmK/N4qOZyok
 yWKuA0s6d0Vt7NfboWhr/kW5og17VzYI6iDFF0VAggNLW/EVkMZsM8txFYriRuBueQk6
 ZURUMg/n/JkUj1EDnc/4IQbLUFLn4xMFhr3Zw2B+AsEko8fgCPSH6U4QZdqfjBQZ916w
 StIAEQ4qEVurr/HFbkiGwGcQOhsDALi7G5JhZKgTTZMnlehRp67pMt0GdIRAv/BBPF9V
 JB3SGx8PpHCjHqXJJDNGZSY0I2SeaDZBznvXug7FGLZ6uRSx6aRrQ7LQdLgKX6Ipp+ik
 2HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783189983; x=1783794783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eQ2wkGh9OQFPGIh6+CsATSCyNIJhVVQjedvP3yUcR8I=;
 b=d/jNCZ6HM0OQGZWVHre3nsfzaxBtvxbhZmELRIUSRExxw/Wz1EKp6tC0cdK6M/7snD
 qISOduuf1/5J6du8qP3Uy0iQ5f2ZZY1BYnSRCHw3ruPXFuOqcDzRnppkbKBqyHBgYH0b
 ESeLs4EFN7jfXaYR9SVFCmX3PIzWiUeycbJXpAdunsv45xiH+Z2i7YwwqztZSKkeFPMf
 ewCwaQZGriMTe1C0Fk/GlTlrH6obmKuLnzeHC0QGj/CwIVhVuf8M/OycDRQf0zbXO40H
 ZnnGfFEvYgw5GNZ59JRTErCQkSRYhdoFvu0jGc5x3DxVNxIHLEDp2Fd3U+fw5uQbM9Ml
 tqUw==
X-Gm-Message-State: AOJu0YyLdHpsUROe7yiayQWEkNXfpa/xo3P8rVFORQufZ4b/07U3XZxn
 At2k5Cb2cBb9xtSHmhiYdkDuEtBtmthKSPkYcHcv0HcrBeJV4KbsqIqR6SHUFKuud903QxADFbK
 XTrDGSXiAILRmmxafkfrRxWGqnbtbx/9QwQOYzOb7sO7XFKGcGZW4PZpxTR11AKlsHTpYSvk=
X-Gm-Gg: AfdE7cm02brEwU4Vdho/YKj1D9zAW3l0/0ZRhkqniRVWQ4Mr7oJ/vwcmLpd2t3SYLSY
 QG9hlDXFXAOPP1NWRnqJ6p3GGwRmiI5Gv3L7MolFYRt00kFAUJ533VTL+wdb/sixpVfu6Kd0cEV
 gL9tx8G8qiUDmzYUk+7cibmEv6uPhw3Ljft3Nz2SlDAi76VNowFCb8sXPz0IqcTkDGXzNycOqKw
 WpR7vqZwHQ3erHauWCDzRwrsd67NQGffciAnQG4YSFWhvJarVrxZsqq1SSxW+nQ3JfkqbYgXxRm
 hu/tBLwcZ+uqCSjdRyewWKjGUbQVCwjIy18bTt7eJImU4NpjBsuYG+AkwGa1UFOLybYNkFzUIeU
 MoiR1uuxBN9NfloH4PxefzbY=
X-Received: by 2002:a05:6a00:330c:b0:847:7f7a:dd18 with SMTP id
 d2e1a72fcca58-847f6d663f2mr3781682b3a.3.1783189982972; 
 Sat, 04 Jul 2026 11:33:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:330c:b0:847:7f7a:dd18 with SMTP id
 d2e1a72fcca58-847f6d663f2mr3781665b3a.3.1783189982458; 
 Sat, 04 Jul 2026 11:33:02 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 11:33:02 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:13 +0800
Subject: [PATCH 4/9] drm/mcde: replace struct drm_simple_display_pipe with
 regular atomic helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-drm-simple-kms-removal-v1-4-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
In-Reply-To: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
To: Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, xen-devel@lists.xenproject.org,
 Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=10718;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=Qcol9fj3wcEepZH3ImnK7lH90wrvdzfXhAcRLociBUs=;
 b=Mx6Ue7MKCfC0JMWj0BrhEUBH/ynLrlUW5+zwyXd6XNRIoOn78c9YTfhlfyKIIkBbAjhKd8rqo
 rj42P/bhNkcBIPjnFtFAre0a4wkLVPMpB+ZD6+uq3vfaTAz3vXXq5qV
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX7QZh0P1jc/8a
 ONhrpcly4ap/p6FeD9IVi48QL1hxXYLeRrDyDpxP0i7ODXRcpqv3NXz/eD+Reuys8gr1lFL0AUA
 RzoOJ1sNJHLDOVYmwCne5/RoPY6KpVU=
X-Proofpoint-ORIG-GUID: 40h1f3gY2Ja7QYPF7ycyhCdytR-tQXWc
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4951df cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=T3BUC5bxBd2b0rxqrJgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfXw6ojj3qQzT83
 vidWdOWidn+tRWhtAfskEj6jq48B1IiXL6mAEGuoOpAuD7bA8XEdmJbnhLCIFpuQuNDdkVd04kZ
 6WMlNhXJcsDgrD7t/BRITPRmpq7WJwH4KbecT2bXfIl/IhK8jwBrUuZJRmwlE/QDf6Mn2A9q5A+
 69bGlHXz9IK0dMj8hAZhZii5JjcJgSn+cbbp3E1er+FFUmdNwlZnI3ilwC/tj9evs5+kO3lr4oh
 +xDkEtDVLj/AnSs2gFeRYUo8f59uKbKc95DMyfQANdKmTfxapmoixXoTcZm0fD8BPwT0RbO2YAf
 ISfi7u+8dhTWDwFQYMqOqLZuQMAL8BD85AusoSCDwVVpyXO3BPIPATkHsSgZa6krBTgMZ8qqNCb
 WienDin4EdIyS/2hU2sgeZxcEjnlGjkXZ+wpNItuKIFP4XkMlpmdBTTeHPMvFjMbXEY4T5ABjTX
 28NCzt3F+fWxlp+eTEQ==
X-Proofpoint-GUID: 40h1f3gY2Ja7QYPF7ycyhCdytR-tQXWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192
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

Convert MCDE to explicit plane, CRTC and encoder objects.

Keep FIFO, event and framebuffer update sequencing intact, and install
GEM framebuffer prepare callback explicitly.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/mcde/mcde_display.c | 162 +++++++++++++++++++++++++++---------
 drivers/gpu/drm/mcde/mcde_drm.h     |   6 +-
 drivers/gpu/drm/mcde/mcde_drv.c     |   3 +-
 3 files changed, 129 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 257a6e84dd58..4d86fa5030eb 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -10,6 +10,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/media-bus-format.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
@@ -18,7 +19,6 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_vblank.h>
 #include <video/mipi_display.h>
@@ -132,7 +132,7 @@ void mcde_display_irq(struct mcde *mcde)
 	writel(mispp, mcde->regs + MCDE_RISPP);
 
 	if (vblank)
-		drm_crtc_handle_vblank(&mcde->pipe.crtc);
+		drm_crtc_handle_vblank(&mcde->crtc);
 
 	if (misovl)
 		dev_info(mcde->dev, "some stray overlay IRQ %08x\n", misovl);
@@ -157,13 +157,35 @@ void mcde_display_disable_irqs(struct mcde *mcde)
 	writel(0xFFFFFFFF, mcde->regs + MCDE_RISCHNL);
 }
 
-static int mcde_display_check(struct drm_simple_display_pipe *pipe,
-			      struct drm_plane_state *pstate,
-			      struct drm_crtc_state *cstate)
+static int mcde_plane_helper_atomic_check(struct drm_plane *plane,
+					  struct drm_atomic_commit *state)
 {
-	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = pstate->crtc;
+	struct drm_crtc_state *cstate;
+	const struct drm_display_mode *mode;
+	struct drm_framebuffer *old_fb = plane->state->fb;
 	struct drm_framebuffer *fb = pstate->fb;
+	int ret;
+
+	if (!crtc)
+		return 0;
+
+	cstate = drm_atomic_get_new_crtc_state(state, crtc);
+	if (!cstate)
+		return 0;
+
+	ret = drm_atomic_helper_check_plane_state(pstate, cstate,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+
+	if (!pstate->visible)
+		return 0;
+
+	mode = &cstate->mode;
 
 	if (fb) {
 		u32 offset = drm_fb_dma_get_gem_addr(fb, pstate, 0);
@@ -1149,16 +1171,14 @@ static void mcde_setup_dsi(struct mcde *mcde, const struct drm_display_mode *mod
 	*dsi_formatter_frame = formatter_frame;
 }
 
-static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
-				struct drm_crtc_state *cstate,
-				struct drm_plane_state *plane_state)
+static void mcde_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					   struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
+	struct drm_crtc_state *cstate = crtc->state;
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_framebuffer *fb = mcde->plane.state->fb;
 	u32 format = fb->format->format;
 	int dsi_pkt_size;
 	int fifo_wtrmrk;
@@ -1298,9 +1318,9 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
 	dev_info(drm->dev, "MCDE display is enabled\n");
 }
 
-static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 	struct drm_pending_vblank_event *event;
@@ -1381,17 +1401,23 @@ static void mcde_set_extsrc(struct mcde *mcde, u32 buffer_address)
 	writel(buffer_address + mcde->stride, mcde->regs + MCDE_EXTSRCXA1);
 }
 
-static void mcde_display_update(struct drm_simple_display_pipe *pipe,
-				struct drm_plane_state *old_pstate)
+static void mcde_plane_helper_atomic_update(struct drm_plane *plane,
+					    struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_device *drm = crtc->dev;
-	struct mcde *mcde = to_mcde(drm);
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane *plane = &pipe->plane;
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct drm_device *drm;
+	struct mcde *mcde;
+	struct drm_pending_vblank_event *event;
 	struct drm_plane_state *pstate = plane->state;
 	struct drm_framebuffer *fb = pstate->fb;
 
+	if (!crtc)
+		return;
+
+	drm = crtc->dev;
+	mcde = to_mcde(drm);
+	event = crtc->state->event;
+
 	/*
 	 * Handle any pending event first, we need to arm the vblank
 	 * interrupt before sending any update to the display so we don't
@@ -1443,9 +1469,8 @@ static void mcde_display_update(struct drm_simple_display_pipe *pipe,
 	}
 }
 
-static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int mcde_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 	u32 val;
@@ -1462,9 +1487,8 @@ static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 
@@ -1474,13 +1498,56 @@ static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
 	writel(0xFFFFFFFF, mcde->regs + MCDE_RISPP);
 }
 
-static struct drm_simple_display_pipe_funcs mcde_display_funcs = {
-	.check = mcde_display_check,
-	.enable = mcde_display_enable,
-	.disable = mcde_display_disable,
-	.update = mcde_display_update,
-	.enable_vblank = mcde_display_enable_vblank,
-	.disable_vblank = mcde_display_disable_vblank,
+static int mcde_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	int ret;
+
+	if (!crtc_state->enable)
+		goto out;
+
+	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+	if (ret)
+		return ret;
+
+out:
+	return drm_atomic_add_affected_planes(state, crtc);
+}
+
+static const struct drm_crtc_funcs mcde_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank		= mcde_crtc_enable_vblank,
+	.disable_vblank		= mcde_crtc_disable_vblank,
+};
+
+static const struct drm_crtc_helper_funcs mcde_crtc_helper_funcs = {
+	.atomic_check	= mcde_crtc_helper_atomic_check,
+	.atomic_enable	= mcde_crtc_helper_atomic_enable,
+	.atomic_disable	= mcde_crtc_helper_atomic_disable,
+};
+
+static const struct drm_plane_funcs mcde_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+	.destroy		= drm_plane_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs mcde_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= mcde_plane_helper_atomic_check,
+	.atomic_update	= mcde_plane_helper_atomic_update,
+};
+
+static const struct drm_encoder_funcs mcde_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 int mcde_display_init(struct drm_device *drm)
@@ -1510,11 +1577,30 @@ int mcde_display_init(struct drm_device *drm)
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(drm, &mcde->pipe,
-					   &mcde_display_funcs,
-					   formats, ARRAY_SIZE(formats),
-					   NULL,
-					   mcde->connector);
+	ret = drm_universal_plane_init(drm, &mcde->plane, 0,
+				       &mcde_plane_funcs,
+				       formats, ARRAY_SIZE(formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_plane_helper_add(&mcde->plane, &mcde_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &mcde->crtc, &mcde->plane,
+					NULL, &mcde_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&mcde->crtc, &mcde_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &mcde->encoder, &mcde_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	mcde->encoder.possible_crtcs = drm_crtc_mask(&mcde->crtc);
+
+	ret = drm_connector_attach_encoder(mcde->connector, &mcde->encoder);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
index ecb70b4b737c..6123afb1e3b8 100644
--- a/drivers/gpu/drm/mcde/mcde_drm.h
+++ b/drivers/gpu/drm/mcde/mcde_drm.h
@@ -4,7 +4,7 @@
  * Parts of this file were based on the MCDE driver by Marcus Lorentzon
  * (C) ST-Ericsson SA 2013
  */
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 
 #ifndef _MCDE_DRM_H_
 #define _MCDE_DRM_H_
@@ -72,7 +72,9 @@ struct mcde {
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	struct drm_connector *connector;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct mipi_dsi_device *mdsi;
 	bool dpi_output;
 	s16 stride;
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5f2c462bad7e..401cf8ab83bc 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -186,8 +186,7 @@ static int mcde_modeset_init(struct drm_device *drm)
 	}
 
 	/* Attach the bridge. */
-	ret = drm_simple_display_pipe_attach_bridge(&mcde->pipe,
-						    mcde->bridge);
+	ret = drm_bridge_attach(&mcde->encoder, mcde->bridge, NULL, 0);
 	if (ret) {
 		dev_err(drm->dev, "failed to attach display output bridge\n");
 		return ret;

-- 
2.55.0

