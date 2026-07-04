Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9629EC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D286110E0BF;
	Sat,  4 Jul 2026 18:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HigA/Yvo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L0GUH/Rr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E4F10E0BF
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:32:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664G8X4d3292245
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 18:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hhnZnblLCIszQtw+LJyheg1p5e5bbTPNhk3k4G3KLZE=; b=HigA/YvowAIAk3nt
 u90/giw64WMUkmqqUONEvT6QA+HElUmhEe9nMBPgMGXIiCsru/1th/i+26Ti+VPU
 VqC6CR+1O9aO7xlv3V2IfALvNs/JXPFhhXYQAmu8RnGmT3VXS/g/KZNAnMfyf63V
 Kxhyq+2qPDB+3/CZZhBC+/vDo6fJXQUA6q2doODDUnsQQbXtgKhPlWs1zZiIS+dp
 88CkD6YJ8VmeESdB3zsViZszqFk4ECq1XxJqVbJ3sQ/6CblyG65fIcGJ57s8eKMO
 zG7GjLSO340QWRV/QKuGOEVfrnh3WJSLZuI1zRXFhRyJJOBAPwB1Ox1/tpWOJhNK
 P4/oWg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf817cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 18:32:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so2181489a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783189962; x=1783794762;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hhnZnblLCIszQtw+LJyheg1p5e5bbTPNhk3k4G3KLZE=;
 b=L0GUH/Rr6OFdk6OFX3f2OtDPJKd4hViRkYlWdWYSW5sswrkaagvx3ace3fjsAGRVri
 IHHHwB9AgUyqNp3jOfP1dT4nIBTVuBi1NYnLuCgUKULTAK7J+SwehhloLpzt58YxS+Xe
 W6HA16cWi5f0ryXJZQqM44b2irIWDUfxaTqn2XoSYN5Gy9dvPCqrU5zxCSVxUmPBqFUt
 gLBTOOHlHm8lwONqGZvvlajgAFDwsxOYYNsrSpIWJyLl3+BJD62mlZd8Vl3ryRp8OJUN
 tDh4eTsmJYUDIe4rYXNOs9dMQsP6HVB3EAohgm4XoD6WKNCXXAJCeWrnb9Bacy4IP76o
 84Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783189962; x=1783794762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hhnZnblLCIszQtw+LJyheg1p5e5bbTPNhk3k4G3KLZE=;
 b=nXZgPc57aK8WRJvK7I5kqkPhBMUlM6Z7iP9lLl+1SZcwPdtOLkkCPSpmUiSAIiBQar
 nskh9HSvRP9Y8EUoTlHKEdmDtuuBHBu5LlKrQ2GRhFgagE4IBT0q/IdwAuvEvOtTLTKx
 YgoSYUs7Kns2Vz5CDoWcv9B3iz4hDPZaOcnLvVQvDqC5v062b/HdAvNoURRW7lMHl8bw
 tk2Uqjglp9eJGsicYQN1Wo5SXgpe2bsgY6DLOE1bFOHjtUJjFNCDtfEYYlbnWtZMZf+8
 jblucnbeYBJstD+sm/yMu3IhyfZaTEBpjM0xsnr2AIZ4ze9ohahSgEteW3Xc3WAyeVOg
 bgLA==
X-Gm-Message-State: AOJu0YytWEQ0XS8dI2x/8YjlA7Jsz7mQhTCp1mKvGsNHanw2hX99TGZ/
 SDje1ZI/yH1uc2UTHSipWiAp5tPOlxaEcPEZ97tx5/mwuP7ZUBVt3/Dlxvmvp/rS0htd46dyAyr
 EXexjeKCOwFdJFwqrYIary6xxCe4x9GIP81MhWGzB804x5aI+9JXXebb9H9Iy3CJLXvskeDQ=
X-Gm-Gg: AfdE7cl0OoejcLyoMxNtYWs1KNWcOKfPp+RJPVcFMRr+rGhK117pKwfVVBK1otwzI+X
 hP7LaWeD2c6q2UbvPeJjTDNq07hn2Z8Ow9uqPsgfaHUsdSYaxkDIWBl2bvFqnwftrdt4ZDXvT44
 FWBARSJAztAtpca2/emEgWj/c94d6w7bkGR1UecnHmhBNZjN61orihXrBHOvtG5lKlgpP58T8E6
 1ZWDWmwkWc4ticuug2l+tiXlKW2g4harp38vlOS6nq8DqTCHic6jTmqDIAGwrK98mIfQqSG4M1N
 0rgYwmYKPkTk789W6unD8HLsH+uD5LUdYiLELyc4H6u4Xe4JHLwOGKYExBNT6LU/Lf9mqRfMHFz
 /3Zc/vKOxMZ3BHK4juiPFuQg=
X-Received: by 2002:a05:6a00:3409:b0:847:82db:9046 with SMTP id
 d2e1a72fcca58-847f6e23426mr3892399b3a.26.1783189962387; 
 Sat, 04 Jul 2026 11:32:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:3409:b0:847:82db:9046 with SMTP id
 d2e1a72fcca58-847f6e23426mr3892367b3a.26.1783189961907; 
 Sat, 04 Jul 2026 11:32:41 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 11:32:40 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:10 +0800
Subject: [PATCH 1/9] drm/arcpgu: replace struct drm_simple_display_pipe
 with regular atomic helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-drm-simple-kms-removal-v1-1-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=10574;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=8mMAnYSE2j9kvPoy0U0PiscxYaNacGiFej3sM2jbRJE=;
 b=txK25+zxNcWE7LzIDK50/Vc0ek9cJ1ZHZwndvZY/Gaj4xa5vBqoV/ECCeA+Q5X53hzG7BWkCk
 vsnaMg/njluBVTDN1MNDL31skfyvaUfXMg+jVWOC+g+y4xzRJwbd4JO
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-ORIG-GUID: 8TppoqPOsaxcP99-28Y7AszYTytIhLiG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX6tf6wj8Eux/5
 rGV29gyClBJhoBrDjCVNyG1BSaQO6JbXejwCWiM91TWs8q0r0TEM5K2PQ/6YyLEkOXKrFxjQTCs
 WB+OBSczYReTngLsgVR2H51leFhUo/U=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4951cb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GdXnK45ANdTc1KOwPkkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 8TppoqPOsaxcP99-28Y7AszYTytIhLiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX7/f+1nZEomNG
 0s0rR5bjWXL7R59M07RsTVFepLJQ2l5NLhyGQXjVmDf2Fi5+XY6TBHi+kNnQQguvcV/K/l/WdPm
 t1C58VCEpeEd9rlhUnKx8Yr7ocXl+yppwLo1UD7sTQksmd4WLS14SnMiMnA1iD8UqfyfV1jsJxy
 b/wTXZcNH82wbRDTpe0Px8euAQnm/12GvFkQY+vT/6BCB6X0MEAu2644WgbHvGoWU0E54paewHO
 sRf5jkrIEMC14f61ce4tPIYXxDDyFYYTkNGX4wki2MOm4oFHIur3a0HHdJ36ceyaCXsK6QMMQat
 uTttDE7CX8XCRPUsEOGLSlOn/z6QtwAuk/7y7jllYaFCXs3hMRF7g3sbDD4zI8wMs9bjY2bgMyv
 R/QXC5HA+Kgrog9bCU87xaHyOcmCrIf0syZ4wtjTmVg+TBqUrMn9TUl1H0pJNkSYVJS9Wsn5qU2
 XV+XCDE5KcDaL2L0Vow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
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

Instantiate plane, CRTC and encoder directly and wire them up with
standard atomic helpers.

This removes arcpgu's dependency on deprecated simple-KMS display pipe
interface.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 165 +++++++++++++++++++++++++++++++++---------
 1 file changed, 131 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..375cdb79e4e8 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -17,12 +17,12 @@
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of_reserved_mem.h>
@@ -52,14 +52,14 @@ struct arcpgu_drm_private {
 	struct drm_device	drm;
 	void __iomem		*regs;
 	struct clk		*clk;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane	plane;
+	struct drm_crtc		crtc;
+	struct drm_encoder	encoder;
 	struct drm_connector	sim_conn;
 };
 
 #define dev_to_arcpgu(x) container_of(x, struct arcpgu_drm_private, drm)
 
-#define pipe_to_arcpgu_priv(x) container_of(x, struct arcpgu_drm_private, pipe)
-
 static inline void arc_pgu_write(struct arcpgu_drm_private *arcpgu,
 				 unsigned int reg, u32 value)
 {
@@ -117,7 +117,7 @@ static const u32 arc_pgu_supported_formats[] = {
 
 static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
 {
-	const struct drm_framebuffer *fb = arcpgu->pipe.plane.state->fb;
+	const struct drm_framebuffer *fb = arcpgu->plane.state->fb;
 	uint32_t pixel_format = fb->format->format;
 	u32 format = DRM_FORMAT_INVALID;
 	int i;
@@ -139,10 +139,10 @@ static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
 }
 
-static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *pipe,
-					       const struct drm_display_mode *mode)
+static enum drm_mode_status arcpgu_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							  const struct drm_display_mode *mode)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
 	long rate, clk_rate = mode->clock * 1000;
 	long diff = clk_rate / 200; /* +-0.5% allowed by HDMI spec */
 
@@ -155,7 +155,7 @@ static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *p
 
 static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
 {
-	struct drm_display_mode *m = &arcpgu->pipe.crtc.state->adjusted_mode;
+	struct drm_display_mode *m = &arcpgu->crtc.state->adjusted_mode;
 	u32 val;
 
 	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
@@ -194,11 +194,10 @@ static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
 	clk_set_rate(arcpgu->clk, m->crtc_clock * 1000);
 }
 
-static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
-			   struct drm_crtc_state *crtc_state,
-			   struct drm_plane_state *plane_state)
+static void arcpgu_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *state)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
 
 	arc_pgu_mode_set(arcpgu);
 
@@ -208,9 +207,10 @@ static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
 		      ARCPGU_CTRL_ENABLE_MASK);
 }
 
-static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
+static void arcpgu_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *state)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
 
 	clk_disable_unprepare(arcpgu->clk);
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
@@ -218,35 +218,106 @@ static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
 			      ~ARCPGU_CTRL_ENABLE_MASK);
 }
 
-static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
-			   struct drm_plane_state *state)
+static void arcpgu_plane_helper_atomic_update(struct drm_plane *plane,
+					      struct drm_atomic_commit *state)
 {
 	struct arcpgu_drm_private *arcpgu;
 	struct drm_gem_dma_object *gem;
 
-	if (!pipe->plane.state->fb)
+	if (!plane->state->fb)
 		return;
 
-	arcpgu = pipe_to_arcpgu_priv(pipe);
-	gem = drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
+	arcpgu = dev_to_arcpgu(plane->dev);
+	gem = drm_fb_dma_get_gem_obj(plane->state->fb, 0);
 	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
 }
 
-static const struct drm_simple_display_pipe_funcs arc_pgu_pipe_funcs = {
-	.update = arc_pgu_update,
-	.mode_valid = arc_pgu_mode_valid,
-	.enable	= arc_pgu_enable,
-	.disable = arc_pgu_disable,
-};
-
 static const struct drm_mode_config_funcs arcpgu_drm_modecfg_funcs = {
-	.fb_create  = drm_gem_fb_create,
+	.fb_create = drm_gem_fb_create,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
 DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
 
+static int arcpgu_plane_helper_atomic_check(struct drm_plane *plane,
+					    struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+	int ret;
+
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	return ret;
+}
+
+static const struct drm_plane_helper_funcs arcpgu_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= arcpgu_plane_helper_atomic_check,
+	.atomic_update	= arcpgu_plane_helper_atomic_update,
+};
+
+static bool arcpgu_plane_format_mod_supported(struct drm_plane *plane,
+					      u32 format,
+					      u64 modifier)
+{
+	return modifier == DRM_FORMAT_MOD_LINEAR;
+}
+
+static const struct drm_plane_funcs arcpgu_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	.format_mod_supported	= arcpgu_plane_format_mod_supported,
+};
+
+static int arcpgu_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					   struct drm_atomic_commit *state)
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
+static const struct drm_crtc_helper_funcs arcpgu_crtc_helper_funcs = {
+	.mode_valid	= arcpgu_crtc_helper_mode_valid,
+	.atomic_check	= arcpgu_crtc_helper_atomic_check,
+	.atomic_enable	= arcpgu_crtc_helper_atomic_enable,
+	.atomic_disable	= arcpgu_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs arcpgu_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs arcpgu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 {
 	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
@@ -254,6 +325,9 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	struct device_node *endpoint_node = NULL;
 	struct drm_connector *connector = NULL;
 	struct drm_device *drm = &arcpgu->drm;
+	struct drm_plane *plane;
+	struct drm_encoder *encoder;
+	struct drm_crtc *crtc;
 	int ret;
 
 	arcpgu->clk = devm_clk_get(drm->dev, "pxlclk");
@@ -301,12 +375,35 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 			return ret;
 	}
 
-	ret = drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe_funcs,
-					   arc_pgu_supported_formats,
-					   ARRAY_SIZE(arc_pgu_supported_formats),
-					   NULL, connector);
+	plane = &arcpgu->plane;
+	ret = drm_universal_plane_init(drm, plane, 0,
+				       &arcpgu_plane_funcs,
+				       arc_pgu_supported_formats,
+				       ARRAY_SIZE(arc_pgu_supported_formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret)
 		return ret;
+	drm_plane_helper_add(plane, &arcpgu_plane_helper_funcs);
+
+	crtc = &arcpgu->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL,
+					&arcpgu_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(crtc, &arcpgu_crtc_helper_funcs);
+
+	encoder = &arcpgu->encoder;
+	ret = drm_encoder_init(drm, encoder, &arcpgu_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	if (connector) {
+		ret = drm_connector_attach_encoder(connector, encoder);
+		if (ret)
+			return ret;
+	}
 
 	if (encoder_node) {
 		/* Locate drm bridge from the hdmi encoder DT node */
@@ -315,7 +412,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		if (!bridge)
 			return -EPROBE_DEFER;
 
-		ret = drm_simple_display_pipe_attach_bridge(&arcpgu->pipe, bridge);
+		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -342,7 +439,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
 	struct drm_device *drm = node->minor->dev;
 	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(drm);
 	unsigned long clkrate = clk_get_rate(arcpgu->clk);
-	unsigned long mode_clock = arcpgu->pipe.crtc.mode.crtc_clock * 1000;
+	unsigned long mode_clock = arcpgu->crtc.mode.crtc_clock * 1000;
 
 	seq_printf(m, "hw  : %lu\n", clkrate);
 	seq_printf(m, "mode: %lu\n", mode_clock);

-- 
2.55.0

