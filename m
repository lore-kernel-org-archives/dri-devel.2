Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8BBC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407AB10E0F0;
	Sat,  4 Jul 2026 18:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W6KKvrhm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YS/HJeGq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F3C10E0F0
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:33:30 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664G93es3451639
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 18:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g0BtnuFOv0FQCXxUBDMLCWTcgE0j6FLXPqatMYGCcJA=; b=W6KKvrhmeJ2fyG7f
 WVeIgvI7yc1jiGCDVMy8ENc4fDLxlrrfJe8IN0O7lmm2B65JmceQegoTuxl0Zy4Q
 OqrwkMJhj1H45TKfCC4YEbJgkLuuqCQWQ+x7QobwEfYeReDSSCL5wWTZivIRfWQf
 ZJvG8MRhzMrHmL/91mXHljlnNhNPpfDOq9WZgplUeCnLLFjKY3B6g8sVRCTh67r/
 N/u3p+SV46iH5sChKzMK/1uJIPHpraflaat1ixydDZW7kQwP9UJMiq81VaHpAprp
 JpC6F9G6ErO9rXO+wqrCAT9MR9ncg2ZJVslkCM+/pUyt+MTHGF3FE+8IziiOj809
 wXvMLA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4ssfw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 18:33:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-847902a694cso1497576b3a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783190009; x=1783794809;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g0BtnuFOv0FQCXxUBDMLCWTcgE0j6FLXPqatMYGCcJA=;
 b=YS/HJeGqAtWhkZFSQ6BLyonY1PlSiq1vp/MNNIwL/qUdvP/rn/+Q/3UfkNaHjwBd9H
 98uKlqVDX5sczU2YHK4ZGPGSe4tL/HlTA6bB1yY+gv51MdCMsNF18eW0C8bSdFQ34QSh
 9xoXNb/azd8XGf6ERDzGIPCBQZM0DFYha4AMECpq/8iWC8su2jW2dnFbuNw3r9JLV69s
 Y4sZT+3oQu72YWHi5PEOFF9Z7JRgOBPexg2lW4Yjv5kKIim0GplBtm/iTaiEGu/abHuA
 NESimGKMT2OpevvNjD68T3HzZ5x0IJ4bpxuAorg77s7bk4efla/0C4z8vJmgmicnK9UN
 TEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783190009; x=1783794809;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g0BtnuFOv0FQCXxUBDMLCWTcgE0j6FLXPqatMYGCcJA=;
 b=q4Gwv/uB4sEp9IdcrJYPDkJNVP2E2kdeoLSPc5Y3/pTeP7Ib6kO5zpIZrbw39seHk9
 beL5i3Sr3nofhfU7J0V8+qcM1NaXTcRpuST9CAv4mf8dAFdUbVIUAPhDVfSYqfl1i0m8
 dI+XSiFOd+/6eRS4KBHA2o7mDZR5jR91pn6ig3QU0TfpDtSNFaQF1nqhoLn6Xs4f8q3z
 hoaf9pJ2Ukd9iO4m2zErvvZlnTmrOLvrTaVVXJL8uLMrIblaOqklBJ0p1bpRNAgVQ9ai
 ioJ9ifPnpb6tcFbNhALHOVTMjs/E5UF5beK/eRlhq6ZMEp6QzBLSKtnGMJZs/hq789Lp
 1i/Q==
X-Gm-Message-State: AOJu0YwOO4L0OgO7JAvzUT7d0JARGaabUpCxj4YbCdZqL1ysNmSncbnr
 LT7tluFQmatUAde0+1+V1PdKqVy+MjtgLSXVFZrRpMFcPtAq4hC78at1Dgq+A9mbGYPswyhuqn3
 xjb7p6fIUBFAnC162osJKBpknh7OXzHwelU6yhpZ8YZEzIZ/jCPxZaS3qZmqvPmlmr58PMTc=
X-Gm-Gg: AfdE7cmhBU1e7IZ9JVkM7feqZNvQPra69QJBjBoMYnsW0VR+uKffR6OhEoN97M9Y8w5
 wdjaR1uOK61JRxb3od86YB8jXf1xGslWystFqe1GDxJ71H0aTeIsuEZothCmAX5fa/otCgrUVru
 /0RaLwccWiM+0e7kBFc+4nqDaWlHXJfFKAgBGhQnLh2Q19/TBUG8hw3Pr34+UU0W0KAdayw2EcW
 Yzzdw4aPDrHqx4YIpw8z6kvGaloCd8YkewiqEkPKWYW9+BedaPjWHyuGXkcByYKmMuCmgQqf7Gz
 qByAkf4Cgvu4rD2gIXINcrs/NYNpc4thJtFk371/z4DjV/Zfw4C0IPtluXvQpS7TBGn0Mu4njI7
 gviKSGlGCwTnZAoVFjnOT/JE=
X-Received: by 2002:a05:6a00:e05:b0:845:d274:bfa3 with SMTP id
 d2e1a72fcca58-847f6f96cdemr3661065b3a.58.1783190009296; 
 Sat, 04 Jul 2026 11:33:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:e05:b0:845:d274:bfa3 with SMTP id
 d2e1a72fcca58-847f6f96cdemr3661037b3a.58.1783190008770; 
 Sat, 04 Jul 2026 11:33:28 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 11:33:28 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:17 +0800
Subject: [PATCH 8/9] drm/tve200: replace struct drm_simple_display_pipe
 with regular atomic helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-drm-simple-kms-removal-v1-8-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=12559;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=IU9daMuh+wIrKu2A7tjNZQhHlWlCXrpg0Z3XcY9yMsA=;
 b=wca2bARZyhz/O2pE/2ultazGgfCDL/nXmuhK0zZODTqz3phtgEMU73vuIDTkXkqZJvrB1l2Xi
 pazMWuCMQ9XDkjSq9DKd98nVhHWb8WoQEKSNkWUUn6L6rvw9PKEzFZA
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX1CvlGShk/OS+
 EipMTVSn2aJURXRu0ljHr2QJO/DN69Aqk7Zq8yQUCKBs6RxIP1MitQaSIUmiU2Rxl7mp5ls4NvJ
 /TNKcX3OIqKCuUwqe8oHMPh82J7CuKs=
X-Proofpoint-ORIG-GUID: 7uanuxGUKv6vs4pk68dfTvtgFjRbv2T1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfXwIQ87j0TYt3j
 cNc4s/yaDZx+MbNAMZjJeryoW2fjeieVJDS/RYNB17kNIq6Cyt9Qqm5dm8db3oPv0iXhWTqTXmH
 00kqbv+cwoitq9d3LB/yK2nf83/zDVOE1Ij/AB3F5jwi9nzVbkS9Cnu7BCVomS/Aq9XJTLV49UP
 cJvOn/JL9f4RbkNzp/+5EwXFXPouYW5+xpRSCjAIFQZdZS5TO794miPNuKoNVtmjQGoA+0mmr2z
 b/3FZYgxPdmLd72QF2pTTWQVuTsWdWi4GVThVND3BXBzs8HdFbL2FmXgynf46jvL4SSMka+YdQv
 YffO+wmEvd1TFcvYqM34tGDF4lUCeL7LPnfABRoN6LxkWkCCykQ2CzorTmDjzMf+Svgv6mecshs
 x3ZhQktF08+YohORj1728Pk0qTnvgNujZ3XVq+hY1+kFyFKsDbvl/mtPOQ6PMb6abP91maLQPQu
 blshpT94GQJkBPBlJaA==
X-Proofpoint-GUID: 7uanuxGUKv6vs4pk68dfTvtgFjRbv2T1
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4951fa cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dgwnEUiFKTnKxPjcC9oA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
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

Convert TVE200 to explicit plane, CRTC and encoder objects.

Keep generic plane-state validation before TVE200-specific mode,
alignment, pitch and format-change checks, and install GEM framebuffer
prepare helper explicitly.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tve200/tve200_display.c | 221 ++++++++++++++++++++++----------
 drivers/gpu/drm/tve200/tve200_drm.h     |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c     |  17 ++-
 3 files changed, 168 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
index 26b6c65ef6fd..8fdf69e8e126 100644
--- a/drivers/gpu/drm/tve200/tve200_display.c
+++ b/drivers/gpu/drm/tve200/tve200_display.c
@@ -15,6 +15,8 @@
 #include <linux/of_graph.h>
 #include <linux/delay.h>
 
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -52,7 +54,7 @@ irqreturn_t tve200_irq(int irq, void *data)
 		val = readl(priv->regs + TVE200_CTRL);
 		/* We have an actual start of vsync */
 		if (!(val & TVE200_VSTSTYPE_BITS)) {
-			drm_crtc_handle_vblank(&priv->pipe.crtc);
+			drm_crtc_handle_vblank(&priv->crtc);
 			/* Toggle trigger to start of active image */
 			val |= TVE200_VSTSTYPE_VAI;
 		} else {
@@ -69,13 +71,34 @@ irqreturn_t tve200_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int tve200_display_check(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *pstate,
-			       struct drm_crtc_state *cstate)
+static int tve200_plane_helper_atomic_check(struct drm_plane *plane,
+					    struct drm_atomic_commit *state)
 {
-	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = pstate->crtc;
+	struct drm_crtc_state *cstate = NULL;
+	const struct drm_display_mode *mode;
+	struct drm_framebuffer *old_fb = plane->state->fb;
 	struct drm_framebuffer *fb = pstate->fb;
+	int ret;
+
+	if (crtc)
+		cstate = drm_atomic_get_new_crtc_state(state, crtc);
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
+	if (!cstate)
+		return 0;
+
+	mode = &cstate->mode;
 
 	/*
 	 * We support these specific resolutions and nothing else.
@@ -119,16 +142,73 @@ static int tve200_display_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *cstate,
-				 struct drm_plane_state *plane_state)
+static void tve200_plane_helper_atomic_update(struct drm_plane *plane,
+					      struct drm_atomic_commit *state)
+{
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct drm_device *drm;
+	struct tve200_drm_dev_private *priv;
+	struct drm_pending_vblank_event *event;
+	struct drm_plane_state *pstate = plane->state;
+	struct drm_framebuffer *fb = pstate->fb;
+
+	if (!crtc)
+		return;
+
+	drm = crtc->dev;
+	priv = drm->dev_private;
+	event = crtc->state->event;
+
+	if (fb) {
+		/* For RGB, the Y component is used as base address */
+		writel(drm_fb_dma_get_gem_addr(fb, pstate, 0),
+		       priv->regs + TVE200_Y_FRAME_BASE_ADDR);
+
+		/* For three plane YUV we need two more addresses */
+		if (fb->format->format == DRM_FORMAT_YUV420) {
+			writel(drm_fb_dma_get_gem_addr(fb, pstate, 1),
+			       priv->regs + TVE200_U_FRAME_BASE_ADDR);
+			writel(drm_fb_dma_get_gem_addr(fb, pstate, 2),
+			       priv->regs + TVE200_V_FRAME_BASE_ADDR);
+		}
+	}
+
+	if (event) {
+		crtc->state->event = NULL;
+
+		spin_lock_irq(&crtc->dev->event_lock);
+		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
+}
+
+static const struct drm_plane_helper_funcs tve200_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= tve200_plane_helper_atomic_check,
+	.atomic_update	= tve200_plane_helper_atomic_update,
+};
+
+static const struct drm_plane_funcs tve200_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static void tve200_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
+	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(state, crtc);
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_plane_state *plane_state = priv->plane.state;
+	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_connector *connector = priv->connector;
 	u32 format = fb->format->format;
 	u32 ctrl1 = 0;
@@ -240,9 +320,9 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
 	drm_crtc_vblank_on(crtc);
 }
 
-static void tve200_display_disable(struct drm_simple_display_pipe *pipe)
+static void tve200_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
@@ -255,46 +335,8 @@ static void tve200_display_disable(struct drm_simple_display_pipe *pipe)
 	clk_disable_unprepare(priv->clk);
 }
 
-static void tve200_display_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_pstate)
-{
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_device *drm = crtc->dev;
-	struct tve200_drm_dev_private *priv = drm->dev_private;
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane *plane = &pipe->plane;
-	struct drm_plane_state *pstate = plane->state;
-	struct drm_framebuffer *fb = pstate->fb;
-
-	if (fb) {
-		/* For RGB, the Y component is used as base address */
-		writel(drm_fb_dma_get_gem_addr(fb, pstate, 0),
-		       priv->regs + TVE200_Y_FRAME_BASE_ADDR);
-
-		/* For three plane YUV we need two more addresses */
-		if (fb->format->format == DRM_FORMAT_YUV420) {
-			writel(drm_fb_dma_get_gem_addr(fb, pstate, 1),
-			       priv->regs + TVE200_U_FRAME_BASE_ADDR);
-			writel(drm_fb_dma_get_gem_addr(fb, pstate, 2),
-			       priv->regs + TVE200_V_FRAME_BASE_ADDR);
-		}
-	}
-
-	if (event) {
-		crtc->state->event = NULL;
-
-		spin_lock_irq(&crtc->dev->event_lock);
-		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
-			drm_crtc_arm_vblank_event(crtc, event);
-		else
-			drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
-}
-
-static int tve200_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int tve200_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
@@ -304,22 +346,49 @@ static int tve200_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void tve200_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void tve200_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
 	writel(0, priv->regs + TVE200_INT_EN);
 }
 
-static const struct drm_simple_display_pipe_funcs tve200_display_funcs = {
-	.check = tve200_display_check,
-	.enable = tve200_display_enable,
-	.disable = tve200_display_disable,
-	.update = tve200_display_update,
-	.enable_vblank = tve200_display_enable_vblank,
-	.disable_vblank = tve200_display_disable_vblank,
+static int tve200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
+static const struct drm_crtc_helper_funcs tve200_crtc_helper_funcs = {
+	.atomic_check	= tve200_crtc_helper_atomic_check,
+	.atomic_enable	= tve200_crtc_helper_atomic_enable,
+	.atomic_disable	= tve200_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs tve200_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank		= tve200_crtc_enable_vblank,
+	.disable_vblank		= tve200_crtc_disable_vblank,
+};
+
+static const struct drm_encoder_funcs tve200_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 int tve200_display_init(struct drm_device *drm)
@@ -346,13 +415,31 @@ int tve200_display_init(struct drm_device *drm)
 		DRM_FORMAT_YUV420,
 	};
 
-	ret = drm_simple_display_pipe_init(drm, &priv->pipe,
-					   &tve200_display_funcs,
-					   formats, ARRAY_SIZE(formats),
-					   NULL,
-					   priv->connector);
+	ret = drm_universal_plane_init(drm, &priv->plane, 0,
+				       &tve200_plane_funcs,
+				       formats, ARRAY_SIZE(formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_plane_helper_add(&priv->plane, &tve200_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &priv->crtc,
+					&priv->plane, NULL,
+					&tve200_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&priv->crtc, &tve200_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &priv->encoder,
+			       &tve200_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
+	priv->encoder.possible_crtcs = drm_crtc_mask(&priv->crtc);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/tve200/tve200_drm.h b/drivers/gpu/drm/tve200/tve200_drm.h
index 5420b52ea16b..631a9f5d9aa6 100644
--- a/drivers/gpu/drm/tve200/tve200_drm.h
+++ b/drivers/gpu/drm/tve200/tve200_drm.h
@@ -15,8 +15,6 @@
 
 #include <linux/irqreturn.h>
 
-#include <drm/drm_simple_kms_helper.h>
-
 struct clk;
 struct drm_bridge;
 struct drm_connector;
@@ -107,7 +105,9 @@ struct tve200_drm_dev_private {
 	struct drm_connector *connector;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 
 	void *regs;
 	struct clk *pclk;
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 562f3f11812a..e2e8346acbb8 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -105,16 +105,21 @@ static int tve200_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
-						    bridge);
+	priv->panel = panel;
+	priv->connector = drm_panel_bridge_connector(bridge);
+	priv->bridge = bridge;
+
+	ret = drm_connector_attach_encoder(priv->connector, &priv->encoder);
 	if (ret) {
-		dev_err(dev->dev, "failed to attach bridge\n");
+		dev_err(dev->dev, "failed to attach encoder\n");
 		goto out_bridge;
 	}
 
-	priv->panel = panel;
-	priv->connector = drm_panel_bridge_connector(bridge);
-	priv->bridge = bridge;
+	ret = drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
+	if (ret) {
+		dev_err(dev->dev, "failed to attach bridge\n");
+		goto out_bridge;
+	}
 
 	dev_info(dev->dev, "attached to panel %s\n",
 		 dev_name(panel->dev));

-- 
2.55.0

