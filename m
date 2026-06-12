Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABADCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851C710F645;
	Fri, 12 Jun 2026 18:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVZGJZ3B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEEk/K+C";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2C310F645
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:48 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGUYqr4152823
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NXtGNwSbn+23h3fU54/tQRScTCRPWnaT0vFvr7Sg540=; b=kVZGJZ3B4K+cuLTh
 etACClER7Ykn+bsfS/JR//XpLDhYKlAQx0U7vr3ZodJtVrrOUjyt0r2p0PBNm275
 upsRU/dTJAlN8XvwxOjMs4r3v8iFLni1tY60wQueiS3dj1gaY6fjzWnPJr9kS1yx
 VQ7IJCdEY3P9Ak5VZTznpuvYgrIg0uSJOBvx4dsPqRMckHf/CBIeUN1yF3S0aZ0/
 dTCDt1+NsbNt7qnAC2DiBDPmAx+SQjedamokeR36s+Iznj5XrmZFcGQoRPXs/Nh7
 rTypSTH4AetIJoPDXl+xCvCRhljuMscXrQRWp2591WehC7AsHSBNLZN6xg1AZejZ
 nVY1wQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcm9kb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157ae36434so181093485a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289047; x=1781893847;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NXtGNwSbn+23h3fU54/tQRScTCRPWnaT0vFvr7Sg540=;
 b=KEEk/K+CZdt+KTU6osmv9tPbYYJpLe9/OCCowpynwsBP08iJ7/sexIaiCxA3M7CsU4
 QnPqRMI14s9vca0CQICR0eqf8vvjxc5j6lhpFbDaOaaWOGqn7Z7BzsZGupLmG3XuB96k
 wwNqgl7sfetiRlaaGMnl3PU+hbiOiLRqSktJqp6XocGae+NbghMF+jKuprkm8es5Homo
 XLQyVQ6QRY2mWHzQVawK7j1/4gLnpZ5CRhgEhJC67f80ODk/cPUr4DLO23YHjbob8/mu
 e9OE8Ojy6WKQZKcqxbNbZ5PKNE9Kh/mWSXGLBIIiMgBtN21u8TMs4hqhKVNcYnFpdtNH
 QumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289047; x=1781893847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NXtGNwSbn+23h3fU54/tQRScTCRPWnaT0vFvr7Sg540=;
 b=sgP3zuc3Kb6bklVAAp9LbiqDra3L6D7WUvRuuXFRZvQOZSQkfASU3g2ua9xaZcSTLt
 Q4A6/IZ1MJaKTkF09r+EhS7tYKqlCFuFD2dzKC36MzplGq4v3CxSst2HAWpQKk3jb7WT
 AxmHjVJp4/7s4J0rs2bf0opHa9mWgdUpcs8twaYLaGP3LayDxZ7u0Kikx4sAvaIgo+bC
 61/0HG1kZMf2WDFagYiIlLjF/QQYuob5P3+BrviZhtIjfvVRcyWn3OKrPEBzVPVBfGtl
 IctxJTtU2E+GStLOzusMi9CrgAL31KtcGinwwRomuevlE8QdUXHIWQORPLEPDl+9ReTp
 ZzuA==
X-Gm-Message-State: AOJu0Yyf0/hX3J1l+Xyc0xdWgqXcaab6gmEyCakEOAwNnNE6Lp/KGSaJ
 BG/cK2QonjPdb32QtrI62dOTlOVz7KxyMfEPFSNrwBxaLwo0GZEmOQc85qJfGLZuWXStHPHMrBk
 h3/Kvf9xpcU2JKBNJzuGqLCSGaVLgt1DvBKAuic47sE6TcZGMBZyWGg5QOA1tz13JCTjSdaA=
X-Gm-Gg: Acq92OGjhFmaOp9e3oz3u9sSdJZzaN7b+AmP9cue8bb5agFjsM+ziIZbrzkMyTcEPe0
 sMW1rbsnSnDbVV4aIzaT5GNIKMtNR2Mxeq1IPNV/lhbKkHIeE3GrHdJQ77po2QnUp1Fp0pqNx+H
 hdnKf430WfAUFPT5u+wY1jDJR3JD3/APXRt+xvEbxLQ/vGs4dgErFIdp0UBpZ5eCx5Kproi6Niq
 GFAbk0w39TFs6Lk/SloSuDgj6vc4yZHNnS4xWKQOsmz1kRN4IXh172TICaKt6BnCZNPZuulQdhG
 nuu4Beayo3vNpO2yAtbvay9pBF6lOvR9umKZiT8XBtQyXObpBE7vHIJoupiKe7qjs0fzAKHqfdZ
 k5EPE62CXd+47+Z0ndcIsxo9qegTlE3JeKeB+ldsrKh/ezkUvlU9BY3C5qM75WROG/6FCw6YOJC
 v1ZfplSK090pTeq/kz7DqBw3aBuL56N6iURxs=
X-Received: by 2002:a05:620a:414a:b0:915:6e30:5bd8 with SMTP id
 af79cd13be357-917ee4d8cf8mr137812185a.11.1781289039624; 
 Fri, 12 Jun 2026 11:30:39 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:915:6e30:5bd8 with SMTP id
 af79cd13be357-917ee4d8cf8mr137549085a.11.1781289026842; 
 Fri, 12 Jun 2026 11:30:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:14 +0300
Subject: [PATCH v6 4/9] drm/komeda: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-4-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hqraoBIhgsoA7488mFgE7E5Wa+zzdm/qHLJb+mlG/5g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2aShkfQ4NWcs8hWSV/gJ8/87+hOs9SkyEQ
 I647fJsaOCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1aFGB/4lYLlcCC0eN4Dl4Jj27Lj0v182O24ArgNCoUv/0lOXuJBUpHJ3WQrRTWPQcktsb4msHdS
 zQM5LWwNwm4uSqkhlqE8zgwSBltp3eRPz8A3hJpAcBZxj3bRYxN0FZLq9qDHFYILD4kQ0TrIays
 BKCEWiDMd/NyT41rG/kuQQBqUR/Hqp/JKvvU0eeNHFnPo1wzO9+icOgiyChs7hnsgbacL15lz0f
 MXhI/HoKocbLvZ8gyux6T31biXcta4EaVpVdHwuVD5Q1+mGV2KQUGmkxI4dwALTAXTOzdIVqRXm
 AXQuEmxUAF0prLO9MqS6VTDsAd8tbX7KWWlBDVcTLRTAr0q5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX2/yf366gstc+
 CqyMXSuaSxJS3/yUv0a/5ymrLNkKg1U5y3T+K9hqUzHu/9Jz4TPOVhxiaU7WqScLym9sOl/fz3Q
 Wu06o4HtdJ01fBO4nqMBDoMw0hcvjm1G7r3ir54yGhCD6m5f20pkjhharZmugGirqub1r527BGs
 X/QUzSODeuwkSRxN2FDzdj8zuAPk/SV0QJjCFJfa5lhGS4Mo7JD9Mjw8OOL4aH8xc/XhUG0NUCr
 bEwrNuWTE9Uy6qKpN2WBThEm8/7XBIdbbEv33/h2HkK2Uma7wby27JonuU7NpMzv4P1IzXl/oVz
 tyQYWwTtYP+9v/IylA1V4D89uzYpZzsfE47LHct2buapyONyerS/uF6PAWYJr4CBoz5bLM69Xcb
 NySyjWbbDRsW0yPWsUzdUb0/+EuUDSfxaZMR6n56GEy9GwUP8pU2O5F2ED+bIC1Qk8sRPxd917x
 N6G3qLitiZjnD5iaFNg==
X-Proofpoint-GUID: 1VuTclanakRIhtCOWbBR2y206YwdP_cT
X-Proofpoint-ORIG-GUID: 1VuTclanakRIhtCOWbBR2y206YwdP_cT
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2c5057 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=gYs8AAvg_5cFonjPjrYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX/e3iC0f1E9Sf
 sryQFql46Tj0dCFWhfOX9UdWXbdZTHmu97d7Opwi5zeVTf/MXHUQ9Aowi1tnopSeJPRgB/VGkLz
 75X6wBWNhnZons0ujnhkEMhcsXdLCt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120173
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

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 41cc3e080dc9..bcc53d4015f1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -5,6 +5,7 @@
  *
  */
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
 
@@ -121,17 +122,10 @@ komeda_wb_connector_fill_modes(struct drm_connector *connector,
 	return 0;
 }
 
-static void komeda_wb_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-	kfree(to_kconn(to_wb_conn(connector)));
-}
-
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.detect			= komeda_wb_connector_detect,
 	.fill_modes		= komeda_wb_connector_fill_modes,
-	.destroy		= komeda_wb_connector_destroy,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
@@ -143,13 +137,15 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	struct komeda_wb_connector *kwb_conn;
 	struct drm_writeback_connector *wb_conn;
 	struct drm_display_info *info;
+	struct drm_encoder *encoder;
+
 	u32 *formats, n_formats = 0;
 	int err;
 
 	if (!kcrtc->master->wb_layer)
 		return 0;
 
-	kwb_conn = kzalloc_obj(*kwb_conn);
+	kwb_conn = drmm_kzalloc(&kms->base, sizeof(*kwb_conn), GFP_KERNEL);
 	if (!kwb_conn)
 		return -ENOMEM;
 
@@ -165,11 +161,19 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
+	encoder = drmm_plain_encoder_alloc(&kms->base, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &komeda_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
+
+	err = drmm_writeback_connector_init(&kms->base, wb_conn,
+					    &komeda_wb_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		kfree(kwb_conn);

-- 
2.47.3

