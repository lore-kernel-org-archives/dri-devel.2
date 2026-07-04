Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6A6C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11EB510E0D0;
	Sat,  4 Jul 2026 18:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLvR58BK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFuMvzJf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A28C10E0CF
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:33:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664Hrb2b3664034
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 18:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qeewdBY9B/GoXx4wh8GHCfZpl3Bn2RXn06zKpHrow0s=; b=bLvR58BKlqOhSmYR
 GWZwh7RAaMqMue255wp2Ux0Os9VOxeZTTKB+ZxPySU6eFiW7ptjT3b3vdgETw6Jd
 5I947fjxQJDg/XrP4LXewlGPDfkNLfXj7mTxRKCdL6xeN/5VUZXXu70dBIH6VF4M
 vEAqNimBJaFsBPVH580f4bNI6/oHvXzoi1q5GHo/74VpLiQfryAKkNpALUWKrKKi
 lvjTgd7dkMAiZOSDtM3dX1XAgaypnJoWr9VA7uycRiP6EF2yiseN2j1pALBmIuq8
 aSzmjLQ8i3hGYowHvMb9Iz2eUDnGL8p6GAbRS+lTM2RvEbLelhiecOA5MlLsGH+5
 fsNVbA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4ssfv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 18:33:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-847a483ea41so1838150b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783189990; x=1783794790;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qeewdBY9B/GoXx4wh8GHCfZpl3Bn2RXn06zKpHrow0s=;
 b=GFuMvzJfqNb7P+I4Mv5vUYe+7guuAvY0ux1EeCWAHiB+CeHfLZg+u9AYYOKy8lbG+d
 R4nITEatpbTAlKBSGjt/anYSasWr48NSbwrbgrepm+Kz09VGpB6+kOv9Dy/HxBKK8e/y
 byd/gH6Ncs+sG518C6spKpk7WlKhiI4u7mBfinvJlVF0HIOjSon957c6hpfRWYPA9C9K
 diCwaxA3eHa89nzVlJFvzHsVitrqnR/psSo8QMFOAPpJ5ndMHQtwlm3cdd9K+6gvUS6M
 lJo8+tIY4RB3xAp3ek2uaLNR5dXxKxLOww2FcqPYJwiqveE5qI2aZylboM8E7eG53Bp/
 ljPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783189990; x=1783794790;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qeewdBY9B/GoXx4wh8GHCfZpl3Bn2RXn06zKpHrow0s=;
 b=iD7kjGSB4VXR+j6FM3ceZHD6/A4iWGCubp4SThZ5gMY0iTICBwahhlGKdErxbf2a1w
 1V7g9M1HmbThxx+tzlRbXfxLmin64mYnTTftnAG0YjHm4mBumXS9/ko0gcEA30Oz594i
 wQljhOIaj+5AK8Xr7/4BpljpSb+x111jA8bDg++vDWdihjV3U/FPj2cf17yygWXWm7bd
 ynFSmgSC3x1bYXES25rhb7ucidHR1A2lzpWFWEYKSi/+ZWyRLWERMyUowjpoANDJZTUd
 PbgBZIp0P0FE/PXrB+0+T/vkRxZxIK6cstwdIVcYBh9g7dYJHPe8TIxPA+VNDg0rzKKD
 t00A==
X-Gm-Message-State: AOJu0YxRTPHBPpX9ILgpwyndCylvZ+qJ2aN0QXVKNkZ7sttPQGa/1aI4
 AyfOWE1p3FWqxUnRY+EsIuYSvaot4pn9GdefQlNeIDJ7ri2j5KtebLrfJwlk9+oXxsAXKjVkC7g
 cyAFZ0ayVkyTVd/GOMJmqGQZ/1CtRfX9fvAEq8uj3ZYTfT40tjvsC5sGcRe8IpOW8tPS7xkI=
X-Gm-Gg: AfdE7ckVEL5Qe2psIov1GRjrZk0hoC3srACRgl4lS60/wZvi+MqQH1a9kQWfl2SO15b
 ULoFoI1hI2eUJTfQZN9wYq5pjTbOGwUWJkWKGlRCMa+Bs9bkGqE5nkKjgqn/+W0suE5tWcXLPYI
 WlvL3AUp5lEK7O9PQZ/NIrvP/UZdWnY4sD0GAeppSNAL7JbDQUixnMcLkQO5LLSKsuxkgd2p2Ue
 noaMQiIIGY3HLLE9lhraBuVac5koH8wa0YQecE/LfAqFP0c55i5TJpbpUPMIgfhc5pDj057jR6y
 4QecFxlCf/qSKwc0HP5NLP6namnkneJ+HQzv+B9RlROamPAC1U8gwloJQp+U3jZgmwaYBJiCif7
 rJ+cWQYjzxUGTyZMC/Mbrcro=
X-Received: by 2002:a05:6a00:2e9f:b0:847:8791:f54f with SMTP id
 d2e1a72fcca58-847f86eaa41mr3109146b3a.29.1783189989799; 
 Sat, 04 Jul 2026 11:33:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9f:b0:847:8791:f54f with SMTP id
 d2e1a72fcca58-847f86eaa41mr3109120b3a.29.1783189989281; 
 Sat, 04 Jul 2026 11:33:09 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 11:33:08 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:14 +0800
Subject: [PATCH 5/9] drm/pl111: replace struct drm_simple_display_pipe with
 regular atomic helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-drm-simple-kms-removal-v1-5-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=11040;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=UIMnAJmAsHNwzG3sUZoBE/LPKERzVi4sWM5J738IWxI=;
 b=RA4hDvGQcIHiHVgB2nIPn7/+tx2Alt8IiBFpU/Uf0g/qT5hFfsIN9rsVXLuWJcPpHLAeWBSzR
 q+gEaxP+EW5CPiUrPHYeBUiOXsCRtxFFrHUtMoJ7EySIxRCwYIyPTDI
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX/11uMCDcC36L
 XVwY/T0yP8vUHsp79jTql5eSJfSvtZpzJVfgal7J4yf+ThCOvRknMnniyLQskwl8bzaEerBqs6x
 OMXdki4ydDOotITSfSoZfyeAfXjScEQ=
X-Proofpoint-ORIG-GUID: aOplgwEBRde8iR6JJg0hngeWva2oNnTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX0WyaqCdVj/H5
 ++3kcd/K6zfUSxWu3XUC0zHhy74XSoHA/pVIW+EEApGnJuJXzVQjF5Uny2AlzV/JKN4hBd36Fvo
 TGE/3ljrIkk5L0d8vqoaJzSK1y4FmTQJawnrm9P9riPLVPqSS/xaZvGjWjFBRr8dwjuaPveb2tR
 ot60asII5U7BquG6sN7qVbGnVmiYCtaN59X6ogq2ZlFseDqpDRGEQh07DSj+oU/FnyGgwboxlCi
 fbtL+D97W7OtXKTAANIMdzOnG9gs5G92Wo6qpA+9ItFy/kAFGS8bJcLPUC24xy7p9c/z6/F6t9G
 MHU2WM10NAJFYTp5vG86vy+GoJ0+kvpLec0G//1TJL3rD+mi76+zFscp3TRONlBC3bWV31hmCu0
 vAqOOIR6bYnOo97TnbgJU4aUJMuXMoiCv4W9ziZnSBYLhq2Jinn2iWskqhVZ2zsG0WozEbWHbGT
 N7vYq4bN43Fb4SYdpCw==
X-Proofpoint-GUID: aOplgwEBRde8iR6JJg0hngeWva2oNnTv
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4951e6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=zKtxPG1kur982WRNNmIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
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

Replace PL111 simple display pipe with explicit plane, CRTC and encoder
objects.

Keep existing hardware programming and vblank behavior, and install GEM
framebuffer prepare helper explicitly.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/pl111/pl111_display.c | 174 ++++++++++++++++++++++++++--------
 drivers/gpu/drm/pl111/pl111_drm.h     |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c     |   3 +-
 3 files changed, 136 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 5d10bc5fdf1f..b1bdd4c9dbe6 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -15,6 +15,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/of_graph.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -37,7 +38,7 @@ irqreturn_t pl111_irq(int irq, void *data)
 		return IRQ_NONE;
 
 	if (irq_stat & CLCD_IRQ_NEXTBASE_UPDATE) {
-		drm_crtc_handle_vblank(&priv->pipe.crtc);
+		drm_crtc_handle_vblank(&priv->crtc);
 
 		status = IRQ_HANDLED;
 	}
@@ -49,10 +50,10 @@ irqreturn_t pl111_irq(int irq, void *data)
 }
 
 static enum drm_mode_status
-pl111_mode_valid(struct drm_simple_display_pipe *pipe,
-		 const struct drm_display_mode *mode)
+pl111_crtc_helper_mode_valid(struct drm_crtc *crtc,
+			     const struct drm_display_mode *mode)
 {
-	struct drm_device *drm = pipe->crtc.dev;
+	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 	u32 cpp = DIV_ROUND_UP(priv->variant->fb_depth, 8);
 	u64 bw;
@@ -83,13 +84,35 @@ pl111_mode_valid(struct drm_simple_display_pipe *pipe,
 	return MODE_OK;
 }
 
-static int pl111_display_check(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *pstate,
-			       struct drm_crtc_state *cstate)
+static int pl111_plane_helper_atomic_check(struct drm_plane *plane,
+					   struct drm_atomic_commit *state)
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
 
 	if (mode->hdisplay % 16)
 		return -EINVAL;
@@ -117,16 +140,14 @@ static int pl111_display_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *cstate,
-				 struct drm_plane_state *plane_state)
+static void pl111_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
+	struct drm_crtc_state *cstate = crtc->state;
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_framebuffer *fb = priv->plane.state->fb;
 	struct drm_connector *connector = priv->connector;
 	struct drm_bridge *bridge = priv->bridge;
 	bool grayscale = false;
@@ -355,9 +376,9 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		drm_crtc_vblank_on(crtc);
 }
 
-static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
+static void pl111_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 	u32 cntl;
@@ -387,17 +408,23 @@ static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	clk_disable_unprepare(priv->clk);
 }
 
-static void pl111_display_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_pstate)
+static void pl111_plane_helper_atomic_update(struct drm_plane *plane,
+					     struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_device *drm = crtc->dev;
-	struct pl111_drm_dev_private *priv = drm->dev_private;
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane *plane = &pipe->plane;
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct drm_device *drm;
+	struct pl111_drm_dev_private *priv;
+	struct drm_pending_vblank_event *event;
 	struct drm_plane_state *pstate = plane->state;
 	struct drm_framebuffer *fb = pstate->fb;
 
+	if (!crtc)
+		return;
+
+	drm = crtc->dev;
+	priv = drm->dev_private;
+	event = crtc->state->event;
+
 	if (fb) {
 		u32 addr = drm_fb_dma_get_gem_addr(fb, pstate, 0);
 
@@ -416,9 +443,8 @@ static void pl111_display_update(struct drm_simple_display_pipe *pipe,
 	}
 }
 
-static int pl111_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int pl111_display_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
@@ -427,21 +453,63 @@ static int pl111_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void pl111_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void pl111_display_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
 	writel(0, priv->regs + priv->ienb);
 }
 
-static struct drm_simple_display_pipe_funcs pl111_display_funcs = {
-	.mode_valid = pl111_mode_valid,
-	.check = pl111_display_check,
-	.enable = pl111_display_enable,
-	.disable = pl111_display_disable,
-	.update = pl111_display_update,
+static int pl111_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
+static struct drm_crtc_funcs pl111_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs pl111_crtc_helper_funcs = {
+	.mode_valid	= pl111_crtc_helper_mode_valid,
+	.atomic_check	= pl111_crtc_helper_atomic_check,
+	.atomic_enable	= pl111_crtc_helper_atomic_enable,
+	.atomic_disable	= pl111_crtc_helper_atomic_disable,
+};
+
+static const struct drm_plane_funcs pl111_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+	.destroy		= drm_plane_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs pl111_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= pl111_plane_helper_atomic_check,
+	.atomic_update	= pl111_plane_helper_atomic_update,
+};
+
+static const struct drm_encoder_funcs pl111_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static int pl111_clk_div_choose_div(struct clk_hw *hw, unsigned long rate,
@@ -583,18 +651,40 @@ int pl111_display_init(struct drm_device *drm)
 		return ret;
 
 	if (!priv->variant->broken_vblank) {
-		pl111_display_funcs.enable_vblank = pl111_display_enable_vblank;
-		pl111_display_funcs.disable_vblank = pl111_display_disable_vblank;
+		pl111_crtc_funcs.enable_vblank = pl111_display_enable_vblank;
+		pl111_crtc_funcs.disable_vblank = pl111_display_disable_vblank;
 	}
 
-	ret = drm_simple_display_pipe_init(drm, &priv->pipe,
-					   &pl111_display_funcs,
-					   priv->variant->formats,
-					   priv->variant->nformats,
-					   NULL,
-					   priv->connector);
+	ret = drm_universal_plane_init(drm, &priv->plane, 0,
+				       &pl111_plane_funcs,
+				       priv->variant->formats,
+				       priv->variant->nformats,
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret)
 		return ret;
 
+	drm_plane_helper_add(&priv->plane, &pl111_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->plane,
+					NULL, &pl111_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&priv->crtc, &pl111_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &priv->encoder, &pl111_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	priv->encoder.possible_crtcs = drm_crtc_mask(&priv->crtc);
+
+	if (priv->connector) {
+		ret = drm_connector_attach_encoder(priv->connector,
+						   &priv->encoder);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index d1fe756444ee..ec92a5a180a8 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -21,7 +21,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_panel.h>
-#include <drm/drm_simple_kms_helper.h>
 
 /*
  * CLCD Controller Internal Register addresses
@@ -135,7 +134,9 @@ struct pl111_drm_dev_private {
 	struct drm_connector *connector;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 
 	void *regs;
 	u32 memory_bw;
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ac7b1d12a0f5..f649c266c33a 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -168,8 +168,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
-						    bridge);
+	ret = drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
 	if (ret)
 		return ret;
 

-- 
2.55.0

