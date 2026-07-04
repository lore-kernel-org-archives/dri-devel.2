Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606A0C43602
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F4210E0D6;
	Sat,  4 Jul 2026 18:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="chGpCVDh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzIw1Sdw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AB610E0F0
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:33:18 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664G8miD3429886
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 18:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /kuFitKvD+N+j3LNjGp20fDGgGetUmMinD8vCRF2MSU=; b=chGpCVDhexRvJ6rr
 wnmP0f94vr8luGOm/++TME2IvEnl0eKIx55FeM3CXaEiwLRW7vXHIKtqjy4o6v06
 SAHgN+sR0Jj96ZfmMzcgh335WxtjOsMExrklcuQvZl0uYzFXYR3+G1qMf7iQJMSH
 wgjWX8QkGys5zg3B0KSZEaLe+bq/Tq1HzMGUDBzrixKO/XaeUaogKOUhmMN/5fE/
 Bo4+ixv+GyB7BhGd3crg1HcJOQ2aynBeUQUP5g/YAQXiZVkBVQpbEnRJF5Z03g49
 fz0f/Vv79d7TcM4jozs0CKmd2kiry+IbhZSW0rpic/qx3/3xor4rojO9WILwcw0Y
 /TyXkw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgspav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 18:33:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-847ac21582cso1690562b3a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783189997; x=1783794797;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/kuFitKvD+N+j3LNjGp20fDGgGetUmMinD8vCRF2MSU=;
 b=bzIw1Sdwvwb3DlJ4QOpWItTyo0pmuHJZ38GpkS7AXUEpPtMpD5pdbQ0mQ09YDqDgxo
 24VZAEhbtxpu/snYwTj45/aIWuHkBtaWK3InJBSk5qmPbh42kVvix4/2EPPq0S6HbQb/
 riB6jX0UlpjdaaU62hRGjdJHrH4kAXnnbKNN/BxnTaa2k1yFd132IrlZM1R2FExPAPqd
 yWqH8DRbvNu33zkJQOTi8wumCQWgFuYNLNx6YHO+cdmJUE2JXetQvTu14KGZ3ZMMT+F8
 GQH17rtsieCwBBJtwbIE82WhD5rzl9+iSqPVHyn878DYRssS2+TeYIhRS5psRrRXdhFR
 +RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783189997; x=1783794797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/kuFitKvD+N+j3LNjGp20fDGgGetUmMinD8vCRF2MSU=;
 b=NfBMKOn4z4z80aUzAQL8JXfkQUVu0kwG5sYvrKRcnHHmUCJurVqUhnK5lIgdCyb36b
 93R3rn6yeur0TBEMhCa/hd4zSzpwUNxacFqnJo5dZvf8YRROWJv2FhTnCM62i+kPDg37
 zCNcQkLSXTNucUGO+7IL/itEPPYU+UwQgJeMhm0OUbnPK8MVmgZgWsbJz3pPiKBrUR9w
 zEdSVxDdUg25Mn9l6yfbhu2Ck6JqQZcz3ss06vSKHkcocQrm4S1J6dEAVQ3s3/qFF28D
 3iTlj/SSK2z3/rQgiUqekGNY09QI0MPOXMubpqtXroKO378iFS2oiy+TNn4lmAkLX0y5
 mL7g==
X-Gm-Message-State: AOJu0YwBvp+/I167Nb7V86Y2+Lx/xLBrFtk6avEVdGPSGz4KV6qKS3Wu
 nCjE0dgFjC0t04b/unKJ5LpoQToKP2l9SoKyQyt9VsQ/mShSNi0LR7UAyHTAC4rq8WAcuD7KWt3
 Ur0Obh5hVWsmV0cBXlgzemDD3Jn1ukdXTNU6DAidEvkLYH56D4lKJu4HY44iALbjWBL9vNp0=
X-Gm-Gg: AfdE7cknsfiuhHu/wQ3HgXRNi1rzuqhmnzKUVbWtmnGzlNzIPBXooZiAlb8vQPnZlux
 GoS07Q6iIGqJjqKGdO5PFJgAkzaTFWtZw++r95a5ZmbZ4xBE4wo0urq6G8UCthoT+4Os47Msm4k
 V9EsC9v2pFGpNsQUJARSCVoIzJi7iMfFCcrGwOvHBG3NmcyTQq8W0xT73PKHv/7UaHfYnATndS0
 DloAOKEvJx8IAogip4X7w19Dykv+uvG/Mku9zgS3LhYU3Xqt93IVYY0PhThoDl+5u0jYkAvQlb6
 8hnqzn1xtg/bKWUoaBkfwqWX7SyY4jfVjlHnRodYrK0EedhZ86bbuZrObkP9nDMYzj10HIj8RdI
 mwHO6p3eGXd71lEvJCR27oMU=
X-Received: by 2002:a05:6a00:b481:b0:846:2f3d:6275 with SMTP id
 d2e1a72fcca58-847f6fd61e8mr3673890b3a.58.1783189996844; 
 Sat, 04 Jul 2026 11:33:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:b481:b0:846:2f3d:6275 with SMTP id
 d2e1a72fcca58-847f6fd61e8mr3673864b3a.58.1783189996356; 
 Sat, 04 Jul 2026 11:33:16 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 11:33:15 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:15 +0800
Subject: [PATCH 6/9] drm/gm12u320: replace struct drm_simple_display_pipe
 with regular atomic helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-drm-simple-kms-removal-v1-6-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=7466;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=r2DdGfAWLZ7vlivcGlngDUbsQreUWLRRttkb80TMXtg=;
 b=ZpiamN8SsvzwHpSl4AWbZvzEzxMPS4b0qx+XHy2MamxT7sudsnCfhp6cfZmSMvpCePwkCMiIy
 rN1rIEme/zqBMPX9TVQFYz/cgOxWF7zd0K0T0G1rbbrGY1RY1W5avTu
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4951ed cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=g95SU4BBbiomblFqym4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 86Fcfe6j_fuO9axiqhNz0o_OF6V5u18A
X-Proofpoint-GUID: 86Fcfe6j_fuO9axiqhNz0o_OF6V5u18A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX4W0gHOKJRXmm
 BG+/StMD33bnub0c7W4NHsLtznWLzCbGc5OtfeitRergvC4wKlr8i2h+GPlr/gBWLfM4s4/X+WF
 /lxDaZTpIhJCINTWtDbBcsq4m5DHhWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX1Jy9OGTwd1P5
 4oQLIcw9pA9vyXuAL/Pdl9o7S08NZuNGNAzmOVTctsihrd6/DDkK8kXiH6otnl92R7sEOj7DfWG
 YoGCXqssKM+F/tcCV647VDugRpybUlmpVc4nkH7EbMettAZS00y28YH5o1CiWiV0H5NPc0pWdT+
 QSCfWGaXbW+X8O4QujTu3nGtBCjrgUrgrsGAxNauh2q1U52yewcDhDZtr20fmgvrAyWM/txcki0
 fojRj69Aisw8MoKXICMqzEFv98KtIRZDwl12rczKr95023TqBgAiCFRPZ/FaoVthGbc4MhYwVbo
 5wlFZUNP+nrBoNVTj7xF95owJEULMzcoq2lerO+nxqmqxHu945ZQpFk0CHVBfgPzVvZWaCgAZsP
 YzFO+4cZi+KxuugXGHeyriEHUbxsQoNal4zgm/NDWoIjiqJN7fhtpXBWDPP/f71FrJHBSj07kM3
 brWZvaBFCj5M5nKQPxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
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

Convert gm12u320 to direct primary plane, CRTC and encoder setup.

Keep shadow-plane helper state, framebuffer access helpers and
no-scaling plane-state check from simple-KMS path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/gm12u320.c | 128 ++++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index d73dfebb4353..992160ea794d 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -8,6 +8,7 @@
 #include <linux/usb.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
@@ -27,7 +28,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 static bool eco_mode;
 module_param(eco_mode, bool, 0644);
@@ -87,7 +87,9 @@ MODULE_PARM_DESC(eco_mode, "Turn on Eco mode (less bright, more silent)");
 
 struct gm12u320_device {
 	struct drm_device	         dev;
-	struct drm_simple_display_pipe   pipe;
+	struct drm_plane	         plane;
+	struct drm_crtc		         crtc;
+	struct drm_encoder	         encoder;
 	struct drm_connector	         conn;
 	unsigned char                   *cmd_buf;
 	unsigned char                   *data_buf[GM12U320_BLOCK_COUNT];
@@ -554,31 +556,33 @@ static int gm12u320_conn_init(struct gm12u320_device *gm12u320)
 }
 
 /* ------------------------------------------------------------------ */
-/* gm12u320 (simple) display pipe				      */
+/* gm12u320 display pipe						      */
 
-static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_plane_state *plane_state)
+static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
 	struct drm_rect rect = { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
-	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
+	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
+	struct drm_plane_state *plane_state = crtc->primary->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 
 	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
 	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-static void gm12u320_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void gm12u320_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+						struct drm_atomic_commit *commit)
 {
-	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
+	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
 
 	gm12u320_stop_fb_update(gm12u320);
 }
 
-static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_state)
+static void gm12u320_plane_helper_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_commit *commit)
 {
-	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
@@ -586,11 +590,71 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
 		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-static const struct drm_simple_display_pipe_funcs gm12u320_pipe_funcs = {
-	.enable	    = gm12u320_pipe_enable,
-	.disable    = gm12u320_pipe_disable,
-	.update	    = gm12u320_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static const struct drm_plane_funcs gm12u320_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.destroy	= drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int gm12u320_plane_helper_atomic_check(struct drm_plane *plane,
+					      struct drm_atomic_commit *state)
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
+static const struct drm_plane_helper_funcs gm12u320_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= gm12u320_plane_helper_atomic_check,
+	.atomic_update	= gm12u320_plane_helper_atomic_update,
+};
+
+static int gm12u320_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *state)
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
+static const struct drm_crtc_helper_funcs gm12u320_crtc_helper_funcs = {
+	.atomic_check	= gm12u320_crtc_helper_atomic_check,
+	.atomic_enable	= gm12u320_crtc_helper_atomic_enable,
+	.atomic_disable	= gm12u320_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs gm12u320_crtc_funcs = {
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs gm12u320_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static const uint32_t gm12u320_pipe_formats[] = {
@@ -677,13 +741,29 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(&gm12u320->dev,
-					   &gm12u320->pipe,
-					   &gm12u320_pipe_funcs,
-					   gm12u320_pipe_formats,
-					   ARRAY_SIZE(gm12u320_pipe_formats),
-					   gm12u320_pipe_modifiers,
-					   &gm12u320->conn);
+	ret = drm_universal_plane_init(dev, &gm12u320->plane, 0,
+				       &gm12u320_plane_funcs,
+				       gm12u320_pipe_formats,
+				       ARRAY_SIZE(gm12u320_pipe_formats),
+				       gm12u320_pipe_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&gm12u320->plane, &gm12u320_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(dev, &gm12u320->crtc, &gm12u320->plane, NULL,
+					&gm12u320_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&gm12u320->crtc, &gm12u320_crtc_helper_funcs);
+
+	ret = drm_encoder_init(dev, &gm12u320->encoder, &gm12u320_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	gm12u320->encoder.possible_crtcs = drm_crtc_mask(&gm12u320->crtc);
+
+	ret = drm_connector_attach_encoder(&gm12u320->conn, &gm12u320->encoder);
 	if (ret)
 		return ret;
 

-- 
2.55.0

