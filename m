Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9548BC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE67C10E0CF;
	Sat,  4 Jul 2026 18:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JAoIYFLi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFWMKd6V";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAD210E0CF
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:33:24 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664G8Tne3292120
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 18:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d9o/IQZq06TE0+/STQz+x6iRc27qZ5OMF6+HG6X3OyU=; b=JAoIYFLieW2sulob
 8aKS9YKc17lyfb7CkmeQiYpno8SQEG5nYVlB2llF6oJ6jwMVnyQ3d+KGfvB4W4DH
 GZyHLai4/8DV1JBbnmoHe90LsTRqlQS3Nu8VfpFis3FvhONuKHSAhKid03HvVmcF
 BR7uU3TTQPutgDXECfOEHCyox2dbQiV7g+MKxnrcBmUQcur2B8CxZSmdFWoJJYmG
 TJB4Pk9pQPuqNJlT9bQxqfANLuIW771S6dai19iy1YU+s2AVfvymkJk6qipOrE1y
 b1+ByW4lEXfIKKI6m+ZVxSF5QLjt831FP0iy6aX8qC91V0Td7yh/ILPUkmBNWF3A
 ykGHbA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf817eb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 18:33:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8479586724eso1232307b3a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783190003; x=1783794803;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d9o/IQZq06TE0+/STQz+x6iRc27qZ5OMF6+HG6X3OyU=;
 b=MFWMKd6Va46Y2Q7ejSPvnKfs643ipKzu2YenHrd8SVkKXdZQ5eb4+XNvnU6CzIVpJi
 z26aK1zZB/eeetfqF4pWFUzbcTZUCpAq0fyJzE5gQn8Hstpn7PSTkeR3lHXbI8Mp5rK7
 d0WZeL8r+QS1QtSs8+uAgNLlk3ZfkT2HOPpephk0By8YxUOtp3MC78aQcS346eK75jIZ
 oPZb6cdSRo29UT8RgP56BmA6pOCAtkErfIMYD/r78Yu1VRkrTmdvM4LK2B4b1wemRnmq
 Uv746w6bjMre54lb4yOtz+U5BI0lxgPz5XyOfsX6xD2bKTUK5t56i8jvN6oC11jNary4
 TA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783190003; x=1783794803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9o/IQZq06TE0+/STQz+x6iRc27qZ5OMF6+HG6X3OyU=;
 b=IzjjVm8kC/1t4U61w2gYBjBnrzSZKh1dVRtVGqGRstA85L7YZgQlU3ynJu/OR2iww0
 ODtGk+sy4ISYEA5owt/n/Oq3B1mf4YTaojJtraqslxw3IEu632COOZpQEuHLq7BzVYx7
 3QiKMzc4Tgh06YTpWWpOD8I7rcMjUvZehaDtnobIig9F5/mbyZujXUAri+yoEJ3GeYl8
 +OW8AI5VdnRs7cC89EEzHbj4pTLd/xk21wi7MlpfKshB5TsRzRXveuOmBnOuLRGn3WXT
 NmLNS1K81O8H1Z8DQt4pMAqETk3Y86FJ1bg/kFVvC59gGommb/xSiXnaxWbYGe5uQezY
 oXTQ==
X-Gm-Message-State: AOJu0YzzFgHoxTHPDFF0kvGA0ShIwgEBhLcefTqZO1gnpo7xhZJp95H5
 WLXX8XwMrREXjI87ZBN8ozHAy+ZxMGSGH7FC2tUpJNoRx0LmxRvCgF9NXZXu/6s+2ScqmxqbzV5
 Tg3F0mCi8nHbu6jz32D6EwRXYQdj8y0JW+LvzCgbGehPnYkyrDom/VFMCdIfBxoksXozzSz4=
X-Gm-Gg: AfdE7cnyRQsYpNKi7uPv2FyMDHcedJi9lcijbjb2jLyIkHh/+pI/LQbMgtUMz6FW+H1
 0XXOmyelfVXN/xIHvUU+/YBGgmmSvIOI2D3cRuvsO+rSleC346xYxVUSmwCjH9tIDyjP0SwMEbx
 DH5niu1ecZOj1PgTHK3k+nSAk9tT9fEc9yNTkL9Iz/xSl8Z8NnXyrPN/z5qICCAzAik7YT/4jRh
 nl0SOBIddh/yHiaSvzJa7jsG72tRdaDgqUGh6cFDX0Tkpw3dMe0m2FUTvt09JRNjrivnM5veoAC
 NVc7lOvS+wU7l/1/haj21zEQ43Xurrtd9qJ1b+s13mKhJ7/uRLG3+mmq0/VMyy+Ih4Y+AmnrvLL
 FeesQ/iN5+5iGrLrGLnH0hm0=
X-Received: by 2002:a05:6a00:1399:b0:847:9518:a6fe with SMTP id
 d2e1a72fcca58-847f6dd54b8mr3902998b3a.26.1783190003085; 
 Sat, 04 Jul 2026 11:33:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:1399:b0:847:9518:a6fe with SMTP id
 d2e1a72fcca58-847f6dd54b8mr3902984b3a.26.1783190002572; 
 Sat, 04 Jul 2026 11:33:22 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 11:33:22 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:16 +0800
Subject: [PATCH 7/9] drm/repaper: replace struct drm_simple_display_pipe
 with regular atomic helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-drm-simple-kms-removal-v1-7-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=7683;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=X0UwoE9ZxeInLb/TsbQTXm8HFa5R2/0dvM/cIQQ4UA0=;
 b=3r4r5kIqIqgZijf/Kqr49p7Qlhtwg622PqfbalukoH6sC56FcuoGH9O2XainORoxzzo+57CBd
 48iBMIor2dOCYnCxiNIqiB3V0iSu79Fbb/lbiQqldwHfi0N4kpAgnXv
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-ORIG-GUID: JdSlstZLkDi-Pc5Kh_BU5aZYSrkHbV6j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX+iLhd3WnjM6k
 7YpnQrdeyJITCSqc6FSHYkWah+KkuPWhMn0+z7cCecwSkSmk3tKEvp1mNNKRzg2TX6G6Kk4aXLj
 jkklLAYOKd7t/OSeusTE/hIQmBoV+hI=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4951f3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=rSXZLFMjQQqjKu18WoMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: JdSlstZLkDi-Pc5Kh_BU5aZYSrkHbV6j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfXzFQVFJpqocoV
 JytPIRaVKwOjdGgXMCaS0yccGVyRL3JqdaJPi+cDNohhynXIdA8Nq6mXPjYXHsRRQ1XECgDaGgO
 VPG9DYAxIzdVDpkYu4Rcas3H4K5hpXA6xm/vFXWg/KIgGzjPBIHjuwVo4Jnt+mPcVDgk4W5fFRv
 uJBoIi9OcmSer/bWF2+AiTb+I1redLnC48gmWJRHis3VlU0jrtIwO8Z453Bm60A0iCERaQfg5Hu
 GaUtQCZYQ/wySwZw1YuAjy7fs4RhuxjdkkViJDD7g1kRHF7JqqH8Yelhq16PNIOTxyNDyKx3vej
 STnH7nNppIyZcM7k6JHtaUuS2h1K6Z+JXS2Pz5o72VPuqXchOqNyEJUkHiVY2PQymwJSLCrvN5r
 xkEkpedFr/RsjuCJwUU7SbS3gxBUmBhWd01zG6NXDChzxWxe4WY+juH4YSqiB2UXo3Ayb37ICi5
 6ZesTgCtUYcDXeWAghw==
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

Convert repaper to explicit primary plane, CRTC and encoder objects.

Keep shadow-plane helpers, framebuffer access handling and no-scaling
plane-state validation from simple-KMS path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/repaper.c | 130 +++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c8270591afc7..23be9c762803 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -22,6 +22,7 @@
 #include <linux/thermal.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_damage_helper.h>
@@ -38,7 +39,6 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #define REPAPER_RID_G2_COG_ID	0x12
 
@@ -65,7 +65,9 @@ enum repaper_epd_border_byte {
 
 struct repaper_epd {
 	struct drm_device drm;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	const struct drm_display_mode *mode;
 	struct drm_connector connector;
 	struct spi_device *spi;
@@ -622,26 +624,24 @@ static void power_off(struct repaper_epd *epd)
 	gpiod_set_value_cansleep(epd->discharge, 0);
 }
 
-static enum drm_mode_status repaper_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
-						    const struct drm_display_mode *mode)
+static enum drm_mode_status repaper_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							   const struct drm_display_mode *mode)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 
 	return drm_crtc_helper_mode_valid_fixed(crtc, mode, epd->mode);
 }
 
-static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
-				struct drm_crtc_state *crtc_state,
-				struct drm_plane_state *plane_state)
+static void repaper_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *commit)
 {
-	struct repaper_epd *epd = drm_to_epd(pipe->crtc.dev);
+	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 	struct spi_device *spi = epd->spi;
 	struct device *dev = &spi->dev;
 	bool dc_ok = false;
 	int i, ret, idx;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(crtc->dev, &idx))
 		return;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -771,9 +771,10 @@ static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static void repaper_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void repaper_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
-	struct repaper_epd *epd = drm_to_epd(pipe->crtc.dev);
+	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 	struct spi_device *spi = epd->spi;
 	unsigned int line;
 
@@ -827,14 +828,15 @@ static void repaper_pipe_disable(struct drm_simple_display_pipe *pipe)
 	power_off(epd);
 }
 
-static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
-				struct drm_plane_state *old_state)
+static void repaper_plane_helper_atomic_update(struct drm_plane *plane,
+					       struct drm_atomic_commit *commit)
 {
-	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
-	if (!pipe->crtc.state->active)
+	if (!state->crtc || !state->crtc->state->active)
 		return;
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
@@ -842,12 +844,72 @@ static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
 				 &shadow_plane_state->fmtcnv_state);
 }
 
-static const struct drm_simple_display_pipe_funcs repaper_pipe_funcs = {
-	.mode_valid = repaper_pipe_mode_valid,
-	.enable = repaper_pipe_enable,
-	.disable = repaper_pipe_disable,
-	.update = repaper_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static const struct drm_plane_funcs repaper_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.destroy	= drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int repaper_plane_helper_atomic_check(struct drm_plane *plane,
+					     struct drm_atomic_commit *state)
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
+static const struct drm_plane_helper_funcs repaper_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= repaper_plane_helper_atomic_check,
+	.atomic_update	= repaper_plane_helper_atomic_update,
+};
+
+static int repaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *state)
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
+static const struct drm_crtc_helper_funcs repaper_crtc_helper_funcs = {
+	.mode_valid	= repaper_crtc_helper_mode_valid,
+	.atomic_check	= repaper_crtc_helper_atomic_check,
+	.atomic_enable	= repaper_crtc_helper_atomic_enable,
+	.atomic_disable	= repaper_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs repaper_crtc_funcs = {
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs repaper_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static int repaper_connector_get_modes(struct drm_connector *connector)
@@ -1102,9 +1164,27 @@ static int repaper_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(drm, &epd->pipe, &repaper_pipe_funcs,
-					   repaper_formats, ARRAY_SIZE(repaper_formats),
-					   NULL, &epd->connector);
+	ret = drm_universal_plane_init(drm, &epd->plane, 0,
+				       &repaper_plane_funcs,
+				       repaper_formats, ARRAY_SIZE(repaper_formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&epd->plane, &repaper_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &epd->crtc, &epd->plane, NULL,
+					&repaper_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&epd->crtc, &repaper_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &epd->encoder, &repaper_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	epd->encoder.possible_crtcs = drm_crtc_mask(&epd->crtc);
+
+	ret = drm_connector_attach_encoder(&epd->connector, &epd->encoder);
 	if (ret)
 		return ret;
 

-- 
2.55.0

