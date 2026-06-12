Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A555CD98DB
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952C510F631;
	Fri, 12 Jun 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVL5BU2p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WDNr5ovK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9C510F631
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:32 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGV5v4046260
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sTMi+rpeIeeTxwgAvd6Vb3BN+nfcxX4j3a3avZMj7+E=; b=dVL5BU2p5TxAPTdi
 S28MTvYXq86i+lhwR0HsWJot0vqed5Q82o8xOa1w+PaY4AYkw+ZdIC9xho1H4G/R
 Eg+Y0ltF4oVtQaKmvMa3k1+d+qqvQH4lH2iU/R8iRFX4qKKkWy2Xo5RbRidP3OXH
 AMhXLIrYWFn5kc0TMkqkYmh/GNb1hFoFrJ60ZCiw1Wwx9EQ2svsj03axFNKFIwew
 QN/lhY36dlaRIUs3D2RD7VZBCRaSBE1HeA5XAqLUwwET9iNqA7Mzj/iGugIOBz3P
 ffxADznUhAPiWxkM3tnnwOxLqDUIkU9RESdvor7Ns7uK3ja5rX3xsS14XLJGvBIe
 t8SRgw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ek2gt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9156cb14b1cso191872485a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289031; x=1781893831;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sTMi+rpeIeeTxwgAvd6Vb3BN+nfcxX4j3a3avZMj7+E=;
 b=WDNr5ovKPgCSwE9goqkcvfWUCD5wKwx5HpR4veW9VnAhaxk2SQBLprxi6kaexc/48o
 TjzURbsAB98oHlEEYjNgyfON5lI+A0kamW4pg5Fj+xVy8mhXUDBjn/MRNE4GiWOJkgfY
 /tXx8ygoDBhZgLnVb8vR9TewBI3gsc+x02Ew74huyQmV0k5aj/ryf9rQzb491r6rDZjH
 D9e6MwWx4zqRTqD6tTHzUSZ0d0gxpowRn5k18nKanzA1/o64cv19ATSckZ2NuAighysX
 UwCSHsUsP/VCAa27jx2RwKAxGyVAbo8kbyM6z7kfaUYJDsWbMCO/i2oZBD1GEBVZfrjl
 R98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289031; x=1781893831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sTMi+rpeIeeTxwgAvd6Vb3BN+nfcxX4j3a3avZMj7+E=;
 b=ge+SrN2rq+TjugO4EpTvdtJwEyOVg9CUzUa9xPQ4UgsAuPzknw+nzHwWL4WaqG/aRu
 aSjEz2XxJKCxx75OrHWxEGJrVp5rfalpn/t8df23ylT3+UnnNaTbCaWTigxlRsCjEz3A
 OO4nkrccYMhJf70t/qfRCZ9Cn6xSfHGEVswaXtAnJirm5U7wP8CKiSakNVMDJPkd3lXe
 p8b4yW4nXZAkhmMTr3PxGe7WE/7oW/iPaRJ/utxoXI5atolSAHZTV0gzXkY04X9BoUEe
 QWZprGQof63r4RzQnnpMpNoOdgsLZuy3NZmLXK8SNo/unB/ku5imghq6El0iVK10CNCy
 3vsw==
X-Gm-Message-State: AOJu0Yxc9wqC6vAv/TwU93f2oyfFsooouaX5f/Wf08NLGhwghJ3poTbw
 1DAOM8FwGM5Ect+AY1rMSEPs6BZcyewhtcGYiis7iqXu7KGFegXphzQdtdbqhSVmPcDbWw/nD80
 +bc2CYwlHL+72VRziEKaBS30H6RhirxMS2TAMNqJ/1OIu9Rw+pHBt2cGqQ6kXBDwSRMiPuVc=
X-Gm-Gg: Acq92OGeRZ2hVJTsAnYQEwp/RYgCLvkXT2vNoQV+a3N0ty+qFYZK5iuY+MZ0goz2Ug8
 D1kaqaT/GDjLAgFwjXbBzfoyDGmxmVb4LKyRErGNHNUqXtA/2uA3Lt3TiVOwSaaUrty5DpuIYKE
 g89Tf794IgVP/GbmwkfQEw5sEvdlnAzmZeKiqNjGtcLYHqT+sro5hf4sRZwrJ+WHafmKp1Rl71b
 rsZ9stmv7k6T3GqaqDPVPXpyeHSaKgeZpAekcCdsKq+zkuOBNShHNjkGZs5dZrIgSjtsuwnRoF3
 KLpKJ8Sob/8UWnZ9rjGomO2JP/kI+WEIXSw0cuiGgNdt5my38Pbfer85lIsQpyfArvajPq8Ttro
 Bhvw4L0Z+LelSvj9zg27KUUwnGzEUSAXmBS80Th8EN2OTNVLhlAfm9j2oepR3nqU3PYO8aym1v9
 EHBSSVo9/HOAZY1enWsaHGHkZur25G/rK0Zgo=
X-Received: by 2002:a05:620a:6497:b0:915:cda5:2807 with SMTP id
 af79cd13be357-917f1c595d9mr132339485a.57.1781289031564; 
 Fri, 12 Jun 2026 11:30:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6497:b0:915:cda5:2807 with SMTP id
 af79cd13be357-917f1c595d9mr132325485a.57.1781289031019; 
 Fri, 12 Jun 2026 11:30:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:16 +0300
Subject: [PATCH v6 6/9] drm: renesas: rcar-du: use
 drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-6-9f3a54f81310@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2589;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4Vucpdbps+yQVez32oDVtzt/iw6YyMI2r6E/Wi913Hw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2qL8S5YQqKBPsRn9MTFivondiBpU/eAjZX
 v1710/GiaSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1bx1B/4qwPQtIu7I3Bwv5Sn6D3nPGP9G7fSvF58H/+/1e+BmXtWR0I52tzdypAxD6UGIshghp6r
 R9fC/vVHKY+cJlSIAkJvzdeviVpFG8H828Z976B2ZSeqgJ90a7o+vkfJEY03HCbBS9KVHQVmlWk
 wa43sUxKRxXS3xARc/fyWzjCVBtId3lFolo/JGuYlcdRpBqeoZB599OZQEeLetXVly3F13qILYK
 2pztXlzGcfm5HDqC6ZOH+E2UHqSGHreRU202s3H9mR2LSXaYbnAc+lwUfurempYYfrNrKzpnXyA
 kqUq1HqnbLF9EiHxM4hNn5Dyyf5KvcLTbq6A43ZbRgqn8F9/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c5048 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=rEXDA0v2x0ZtafRnR6sA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: C__JS3HRcNxTKjOagkJKmYP5sld6i8xo
X-Proofpoint-GUID: C__JS3HRcNxTKjOagkJKmYP5sld6i8xo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXwhzx8tvvtxIw
 mvHRy1fWaF+4nweCGnscnYiykQUJrr1A7IiKzcaotq5o2qWFwS87frtnL/bgyE7MRfOBZvgTWJ/
 xfcav4cWV+/xUGbBY8lbEq58+Kf91RtZXSfowpkPb+nVSChnA7+atjsuz5DttEfm2c9B2j/MNGy
 EkF1KZkQ5AlTBSSSLPOsP/mUPhNjmtsmBL+66wecJAeOz32QkzPGlDVTchkcTCM4BFfhlLGvl+M
 BSShE2lDOJZWu6OYWRels53AiLGPFEvJ0udVuKF8RtZ9/kDVCpRzKyxA0MEUXKgN3F1JXAE74Le
 fZ1nPCcgW+FaIOkFIDPCJ5XKxIF7wyhmF7xSDnPvdrjh6VycrUOh1k9/76HZUlUMxUbD8+0AKG2
 FiMojApsqXc2/HbQUy5yBzyu5IJUX+C2qtamCVm9gBuAJQ4J1YLtvPAJVVQieI805YFT4M1JnmL
 sk9b65dRkSZoKm+f9mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXwMPkmho1eqQ3
 16/mh/+DxUovIn79GkFNlAfRQmzQ2WdJ4gPfpd3R7i3NoXEMxV9oTRFxmTg2d1PPeF3QcGGLbMb
 lVkSsTldb/eU+3PGe9CUPk4LMwMfAfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120173
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index e5e6e6a156aa..ecfd4fc1f210 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)
 static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
 	.reset = rcar_du_wb_conn_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
 	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
 };
@@ -201,16 +200,25 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 			   struct rcar_du_crtc *rcrtc)
 {
 	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
 
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
-					    &rcar_du_wb_conn_funcs,
-					    &rcar_du_wb_enc_helper_funcs,
-					    writeback_formats,
-					    ARRAY_SIZE(writeback_formats),
-					    1 << drm_crtc_index(&rcrtc->crtc));
+	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
+					     &rcar_du_wb_conn_funcs,
+					     encoder,
+					     writeback_formats,
+					     ARRAY_SIZE(writeback_formats));
 }
 
 void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,

-- 
2.47.3

