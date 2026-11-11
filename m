Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1AC60A2626
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BzEn3sYX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dy2xinXa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FE010F857;
	Wed, 11 Nov 2026 00:43:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA5B10F859
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKZhC4155412
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Ku/OeLUuwKWykyNmm/Fqp8Hct5JXh1hluRcLpnXu8I=; b=BzEn3sYXtylI9PAG
 bFLzzWAaxxhD0cV5SmM4T3QaXi/ykeLX+DvlqAZfLceRvCkxwmv/UatR0gyo1G6h
 Ws4E4IZDHKZtEc6xNSi8R3gmGm5UD2BJ8Q7oBXl2lxqSUi+EHDQw09Gakg493buh
 ot5IUIM1sqvIrN2MedGEqS6nSRFwk8KGZJoqwLZ2aVxutTqVC6NOrJ4yRhnIRirX
 6ghyk29JOVn5J/abqQasUDoqktZhRpGzhC5nMSjmOf+H1XOb9hWYlB5DXJT9H7WR
 MC/RzcAN0hRAZcTVKYJq97yIbxGinJpLuA8Erxd3PhTFKkNNR9UIc8A5HupNQL3a
 FvqYUA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp4pw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91eb556c8a0so52566856d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357790; x=1794962590;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ku/OeLUuwKWykyNmm/Fqp8Hct5JXh1hluRcLpnXu8I=;
 b=Dy2xinXafn6UQ8S/U6rTL3fumwaK+OKS6X1pCCzw9gfv+y2trWBDaXPwiijDhNn20i
 eT0Vl9SpOmAiPsfw096JwOEjE+AcRm+LjzlCFmYuicLvQTVXULhjLFW+cll+gZH20cor
 TGvGoZbZiILLRrrFVg/pGx2dEzpttE0sOG1xyPy3SABo8KdTWdtO1PB9idKrhNgU2tVw
 sxCfhsGqLK0YZ2ffjoyTOsVwOrecwwJyXmEEpthhUSP7K7h/1LKAUw+Fdtw3tsgygTyk
 9mFPrS9ZEjHt2DXTjevHcFEOlz9H4tCVStYNPqNFntoBwbc6ETMz5pnwLcQNsP0M/l3Z
 U7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357790; x=1794962590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Ku/OeLUuwKWykyNmm/Fqp8Hct5JXh1hluRcLpnXu8I=;
 b=pDZJiCNk+BF3otBq4s6fAY4Ro/QVsfrh5mhlBgw/GRKqE55InlTTB3wAsmQKV7tFjB
 q5oRLJMYFUR330QFAUS2fdOMrqZdf34B2ysdjHbnjpcc5ff2SF7WEOy3tryeDWoSTuhv
 V22pRYhaRxeieyeClLnKfwN+aqKyMM+klEAEZNh8iSxDRt3bdwKHcI3ULT5YQnyEi+7C
 Pu+LHL9ISOxl0mdMY87inH3o1J4uSskQrNupp/vRnr2ty8N2nuArh1BH53HHOPg+zU59
 c4JEl83tvUsjcgWD+PO2cXWnYD4gW4ldDBJ4PHusTUzVcdpSTZUADXqFBZWuaNmCoJ1+
 eT2g==
X-Gm-Message-State: APuU4Z8q0VbYDQ2V6jtJdsMwBL9yfIuCO+K1D1HJzyzypPGgGr74Efpy
 5BJQXriZT/ExSIhoYHjfU0Q0RWybF1gz1WSdGakRTGEH/cpeodcasjShziBUVMG56Ogsc+Wcrrm
 x7ABAvqKxZ1+hHTnw/V/KK05bnc3xC+G3F1PqsXwWaezMd5jAjmm4VlpAHmdJp2W6kLliPRk=
X-Gm-Gg: AYBFou0eIi0T4OCAmyh2RwtodaYt0yT1xTxmz86hCmwWNprzfkaC3ORq397CzB/4WwL
 SvFloTxbJfy4GKo/g8SwZm/+w843xjBjLT6XT1/cTognrh5V2vSYZ7+Ypn0lbKamt4RKwNMtnjr
 IzIj0xRb4iXiKOngO7gpx1LSDn3FGyDOjl9+OZbRPs2A+RPtZzjbUgyA/vrdrngMSZcBr2GAWxj
 /Z4MGazIb7yuehXF+eWP4HLr0T0Um8A3aY1dv/eVhUlkJC7WvXqVbKuzf7ZbGpESBWRrWsRor/w
 /r1b9s2A+2yevJr4aDX7HmGPhPKsX4zRKjdcNCZJ4f/n1C29brTw2JXC2RLN+uoc0qk5CnLmVWX
 P8HiJ35I9o2DoOPKTKqB2gl8g33Nm4atioGDrFSfxmbHqfx4Wy5XC2mcB4e6Ud0MerSDMbMU9jK
 pJjajv7y4woZ0CN81+CTw1QVgq8Os98ZFPSuOjmD3nxtoK5q7Uq8bEu0rg0+a3XQ==
X-Received: by 2002:a05:6214:ac5:b0:917:9507:79a3 with SMTP id
 6a1803df08f44-91f03f95964mr19072736d6.10.1794357790183; 
 Tue, 10 Nov 2026 16:43:10 -0800 (PST)
X-Received: by 2002:a05:6214:ac5:b0:917:9507:79a3 with SMTP id
 6a1803df08f44-91f03f95964mr19072186d6.10.1794357789523; 
 Tue, 10 Nov 2026 16:43:09 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:31 +0200
Subject: [PATCH v8 02/10] drm/komeda: embed the writeback encoder in
 komeda_wb_connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-2-62948ed87d13@oss.qualcomm.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Lp5iF1wPYd7ZR8ysGkNPRlB0R91IV/1mJqhjApWljyY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oFQUeoBmtk6hec2D1ovwQhovn+pZClwRUT0
 IfxlZPJrPCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6BQAKCRCLPIo+Aiko
 1dkNB/9CDgJcldqxSzpsV7Qc9VqdxHn6PoP3wfLRkab4MtPk941bI7DFn3D03sxocMvsHx8+Oz2
 pfDhhaEqrZIxElUkax9GdttGEs8f2s7gWHfVetlaN6gpr6vcs734kR8w8GAUm5Sf5SSrzNizUKs
 pCh5f4jShzqnWpqtkz+DdtbaZ2idcaLnGij8btMM4FnFQtAlatU/GrtdY3VX6MalndcGPLAEWor
 5ZggC8gfC5UHWafO17BCTkif6J8udp0/F+n0jnyyWDSGm6f8RDH6OKIh0l4/nqAz1rSAdImA1XN
 qrmP4Qo08K0QO+bolao6yC86tSgmQ8VsGH2YHR5mniw3sskt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: ynFLrAAC-XSBtuv-oGJCUa5f32EjnmTu
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af3ba1f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=eOsO5XS9GAZRO-ePzeIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX1Rydk+Tvd9z1
 sZkBOVjfFPzGfiLCcYErdWcVu1MtU25JiZC9olUEw6Q3RQ2k3prbEMz0w+Ro1hYYPpgi/Nx5jj0
 jX4heYfis0tRf4nxsGa9PF2uHWN+IuyDeFOksS5TQS2CyOSqhto+BPoj1fBKel7C4HFVYZ/ab62
 90q1KvB6YBv5OeR55CH5Z2Oh6AJKzJe8oVbHzcViAKwCODeXi4Mczh0xzaabPfqByJy0HRoheAg
 ms4CurgVt0vcqzk5PLCs6REoF+CIsRi3EH5deTtcuKDF1hj6c1eBXSMKvLKwtZjwU3JGWy0f/CL
 RZEmKRWqqAbW4J7JD4UXo+PMeRg8NVOpwvhbfaw31vY98tZmrQp6mv1JWiRzrI6mRzd/5Sjblao
 DirVY8Yzj7/XGwAwxT3XIav6mkDH5v7IBFtxJNRT06F2zhHh7QjnwmRzA1zSfCRS6nc4lLUn9p1
 ISBMykWCMcJ2DV1+q1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX5dRg+yT43RQb
 0pWQb5XE0zyLupDZcqnDBZWKQLOO4HVmVLOGMkaxW0U2TUpyKqIBZtp5cmRxIKJx73KWE+bZoGe
 vA4kI/KedEvlyRXsamCPJDkvB0CLdjc=
X-Proofpoint-GUID: ynFLrAAC-XSBtuv-oGJCUa5f32EjnmTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110001
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_writeback_connector_init() hides the encoder inside struct
drm_writeback_connector, which is the only reason that structure carries
an encoder at all. Every other writeback user already owns its encoder.

Embed the encoder in the driver's own structure and register the
connector with drm_writeback_connector_init_with_encoder(), so that the
encoder can be dropped from drm_writeback_connector.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  3 +++
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 28 ++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
index 83e61c4080c2..4d41681a834b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -56,6 +56,9 @@ struct komeda_wb_connector {
 	/** @base: &drm_writeback_connector */
 	struct drm_writeback_connector base;
 
+	/** @encoder: writeback encoder */
+	struct drm_encoder encoder;
+
 	/** @wb_layer: represents associated writeback pipeline of komeda */
 	struct komeda_layer *wb_layer;
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index f394971c0edb..7b795e1c5705 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -127,6 +127,10 @@ static void komeda_wb_connector_destroy(struct drm_connector *connector)
 	kfree(to_kconn(to_wb_conn(connector)));
 }
 
+static const struct drm_encoder_funcs komeda_wb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.detect			= komeda_wb_connector_detect,
@@ -170,18 +174,28 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
-	komeda_put_fourcc_list(formats);
+	wb_encoder = &kwb_conn->encoder;
+	drm_encoder_helper_add(wb_encoder, &komeda_wb_encoder_helper_funcs);
+	wb_encoder->possible_crtcs = crtc_mask;
+
+	err = drm_encoder_init(&kms->base, wb_encoder, &komeda_wb_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (err) {
+		komeda_put_fourcc_list(formats);
 		kfree(kwb_conn);
 		return err;
 	}
 
-	wb_encoder = &wb_conn->encoder;
+	err = drm_writeback_connector_init_with_encoder(&kms->base, wb_conn,
+							wb_encoder,
+							&komeda_wb_connector_funcs,
+							formats, n_formats);
+	komeda_put_fourcc_list(formats);
+	if (err) {
+		drm_encoder_cleanup(wb_encoder);
+		kfree(kwb_conn);
+		return err;
+	}
 
 	/*
 	 * The writeback connector is associated with a single CRTC. Make its

-- 
2.47.3

