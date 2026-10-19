Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC2CCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D7810ED1D;
	Mon, 19 Oct 2026 13:13:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1003210ED0D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OnFj3256570
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sv1DpaVD55W21YeRiucX6KKpES5QDwe02r37HvJrZ0A=; b=WDPuHT+mfSn5Sngx
 2iRg14GMs9rdABM7Vfw5YVXjv5LGMolAOAf+lIviVap5C7A37xN9J5CTlc1SM/if
 FaNJYvVAG/3uh5BcPEE5BDq2J7svAZ85KMzB1iOuTlEWEi2Hegs4SNUVXlHZJuPR
 LOAOrZVkIziX+l/dgydDBW60KgkVmfYwK9m6EJ4X/hE8jlZV1qLzKnukKEKbVAE6
 K22o68qQcll0Xvypz8WH9PXZoZWId/gJH0C1kKyIUiJD6iTUxalHW/o8d0LefO+B
 9jty82LYtDY2dGDo0rAwsF26EmFbGg8eH7jNn/Zaf56ke9cgxi3qN0nIGVykrYCJ
 vwbS9Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f97k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2005ce21so367036485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415574; x=1793020374;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sv1DpaVD55W21YeRiucX6KKpES5QDwe02r37HvJrZ0A=;
 b=QRIcxR5V1TntodAsmrFN4AhNyCT9TYPy3+XqxtubO8NsrocCtAyp0XbWBO6l2OJ4jA
 Lo6o9J0o2C85IMdZGd4WCpQw5ngc9DKO+/RE6oZFPaBz1BhLorTQqh6qjoeLUoddKN++
 CWChn3Of5dgqU4J8ZcH1ZpqLroS3sWyI0Y9qWq7pHIoXH81NFF33GbISqT6yIoPFZ0Qh
 3NcWwPGXEk1Gdk1F/Va2mz73yquXGVieQM+m3HfflFnMrFBg7OBm9gDEgi0mKi8D7wbf
 Z3aZ5vTStD/VNNK0eTi/OR21xXUufC2ML/Ev8eFa2RkJSS3+ZOQ/e9wO3xRhRvA/ZgfU
 X7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415574; x=1793020374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sv1DpaVD55W21YeRiucX6KKpES5QDwe02r37HvJrZ0A=;
 b=igoLGfZZKfjYXR1cGjqHzk5IL7IOpCg9bTS7niYCjiRUXEx63LHMfmnRPDIS9PMT35
 GTWrFGZIPHUhwfO7JPpANC5tzVlw0NfHH8BMzDjpCfRLSjDn9Uusj50/PYV/00KzSzD2
 rKhYOVMA683PvpJR1v9KZh/k5oAmuGQBH+lbk4lBMirJJNospMiGrLsJnJHxERHCFcFp
 C8FowEpa0J41khnlHIJ1VoPaHoIj2FM/vMppyumBr2K51uBt4lOrSwLnyipYrVJPxWD8
 iWCabWZzdqzDIbuzN785vB4YrLXIhFp4VH4ocSL6qtdlayvLytQkjVEpTYru2NxAlE2X
 tOGA==
X-Gm-Message-State: AFq9FYI/0qu1LPNtuvOap9kL5gYKhxM3irMXupgqM68U5IGv4vPNCwPE
 o+uGMI/cKSTDXN0XS47cr12wefgop/iz28GNQpXWz2b0xnN6Dxt+E38wJOAG3TuHEyy3QE/JfWo
 lZyMNnZGQHrKTbqMswsGspELjTkfbCxg8eY1TNl07XI1YaDaqw32nCecQlp3S5eDop7u9QEY=
X-Gm-Gg: AYBFou0umoUpGii/67hgJSOF3slarHwIwao4iwjXEIiSKfTKrTDko0ot7ikNMnVz9fz
 P98tu/Z2jO5BjIiHU8jhOf4WK0oUBcB646pRWnkdph00+uXE+L2hlFav7EldphdW0YPj4U9gfMd
 bojACccPZLZ0iY3ICkswGXsYBHvNIeuufmdp+lyEpCD5UaBm75IaJLc4sfuv4Ih8Ur2lXrx8uGu
 ga2opSBP02eCmMVDSuFQsgkPTLYom6Sb9RheBTJKQtzasn8ACA4mTqvpYax5H7XH3e4j1YhYpfq
 HOKusphYubQhcfmkPwlSwy6MD0BfXK4w9fcgvthqtYAP5yErfgQ3Yt72ZrKjXcrMcIVVt/Y+XAL
 a0dv6DkIWAnHPcC+h8ZGcSK63251zYsbxx1Z1eidpfoZXKntTb26lG69jBRT4mfU0jEvjSXdN8F
 oIajGTn90MLu4s
X-Received: by 2002:a05:620a:170e:b0:93f:c3d:7bf6 with SMTP id
 af79cd13be357-93f29b7f416mr1225512185a.6.1792415573946; 
 Mon, 19 Oct 2026 06:12:53 -0700 (PDT)
X-Received: by 2002:a05:620a:170e:b0:93f:c3d:7bf6 with SMTP id
 af79cd13be357-93f29b7f416mr1225504485a.6.1792415573295; 
 Mon, 19 Oct 2026 06:12:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:30 +0300
Subject: [PATCH v7 4/9] drm: renesas: rcar-du: embed the writeback encoder
 in rcar_du_crtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-4-d4288a26eb54@oss.qualcomm.com>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
In-Reply-To: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
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
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3298;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yoSkIFA/58MM7QcrPq40fkDiBp2NEjXgRIdmIQE2B3s=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9Y1cRe1yLkT+FxTzvlt19C6osdjIZpv1c80VbV+aV1Mm
 n2/9N9ORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEyEt579n0VRsr663b/yBzXN
 s6QzunqStjxXYSg73/d9dtPPJ1erClTdXviIl3/hWjt97kbOQkN1/tpdF1XkK7ewMZr5ftqiXjv
 9c+WB3pXiKRw2Ij8FzjGGHZ56sUTp72P1g4YX2y2+O7zrZ7rJcjCtxfiYEJ/4+5Jg69tdPc6xjR
 VhYrsdJDQ9wn+snXHtZYln4faVd5dfOdY6I+gM28l/pwRDZ1xmErFevJpLVU1Vu4vxyk1Pxh7P6
 5GrPy2su/C9NdOYP/L7L7aJvDqnmVMq2HbJNLt9Cb1YKGC3dL3OsmCj+zLZlwNvXvRoOJ6Yc7VS
 9uy6rCKt/zabK1kXvN2huT3gJYvXQp+WJi7GTQw/k8wA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 8ehR1QGqVTyJf0SGyv5YF5c7CyWjbSgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX7G1n2E+2GyCw
 FpvzI2A8xAbYYNsAiGBjQo2TQ3Ow0AOnQcoj0lI12g/GfXFJY2LMKBSpGn10AbcPo5JIYRJaeM1
 bceVShf6UhWM5WlmMhvQmEmpDP6MMkTUn9cPkBlEasH/KaMt/uFbABiW+HRDSI9BnYjYrWssuvX
 mO8Fx64ySonC4TLu/PG2e1ZP09ygN97RfibIXYreuIOQP8Uv1tlCAOUxdr+03psbRbtGGkOHCip
 ds8FwDeSOTGHMJOb1NQeYMUs3ssU6O7M7uVjTQAsgZ8BNoPon2h/GPtAXicXApgiJajx9BjyFjx
 6tG32AvLzumq+yW1dkxR0k2gIeRFfv6Gi9TKLvagJ2KD8wRfUmBrZ3Pos+7GRelkJoJlEYNhSiQ
 LhDkqWZR2tQFCx5WTye3wBIM8YVWnmSTvWh1n4NjcXSUpogNPm1fDqcsH45C+m4pSXiqjdppTNn
 4nBgVL5PyIBrXGm8bGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX7hFXthMGLmli
 7Zw29+NKi8d5798Gb3IRCaABXX9EkD1zlqVyq9MGx3JvsDV5gc399HwKgZbQ5kYuInJUVQf0et6
 3eqP0D95FyAoKY5TqFEXSjWU5Qfd3rk=
X-Proofpoint-GUID: 8ehR1QGqVTyJf0SGyv5YF5c7CyWjbSgQ
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad61757 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=_cPotY8_OL_z5XV9VKUA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190052
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

drm_writeback_connector_init() hides the encoder inside struct
drm_writeback_connector, which is the only reason that structure carries
an encoder at all. Every other writeback user already owns its encoder.

Embed the encoder in the driver's own structure and register the
connector with drm_writeback_connector_init_with_encoder(), so that the
encoder can be dropped from drm_writeback_connector.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |  2 ++
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 29 +++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
index 8857926e109a..d8b1dcab8dea 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
@@ -44,6 +44,7 @@ struct rcar_du_vsp;
  * @vsp: VSP feeding video to this CRTC
  * @vsp_pipe: index of the VSP pipeline feeding video to this CRTC
  * @writeback: the writeback connector
+ * @encoder: the writeback encoder
  */
 struct rcar_du_crtc {
 	struct drm_crtc crtc;
@@ -74,6 +75,7 @@ struct rcar_du_crtc {
 	unsigned int sources_count;
 
 	struct drm_writeback_connector writeback;
+	struct drm_encoder encoder;
 };
 
 #define to_rcar_crtc(c)		container_of(c, struct rcar_du_crtc, crtc)
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index e5e6e6a156aa..b0c1ca0d0dfa 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -174,6 +174,10 @@ static int rcar_du_wb_enc_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs rcar_du_wb_enc_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs rcar_du_wb_enc_helper_funcs = {
 	.atomic_check = rcar_du_wb_enc_atomic_check,
 };
@@ -201,16 +205,29 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 			   struct rcar_du_crtc *rcrtc)
 {
 	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
+	struct drm_encoder *encoder = &rcrtc->encoder;
+	int ret;
+
+	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
+	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
+
+	ret = drm_encoder_init(&rcdu->ddev, encoder, &rcar_du_wb_enc_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret)
+		return ret;
 
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
-					    &rcar_du_wb_conn_funcs,
-					    &rcar_du_wb_enc_helper_funcs,
-					    writeback_formats,
-					    ARRAY_SIZE(writeback_formats),
-					    1 << drm_crtc_index(&rcrtc->crtc));
+	ret = drm_writeback_connector_init_with_encoder(&rcdu->ddev, wb_conn,
+							encoder,
+							&rcar_du_wb_conn_funcs,
+							writeback_formats,
+							ARRAY_SIZE(writeback_formats));
+	if (ret)
+		drm_encoder_cleanup(encoder);
+
+	return ret;
 }
 
 void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,

-- 
2.47.3

