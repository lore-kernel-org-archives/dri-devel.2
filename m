Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96E7CCF2E5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C4410E5BF;
	Mon, 19 Oct 2026 13:13:17 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3884910ECE2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OrX61665482
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=; b=adOHELmuvYRzRZ9i
 Tw2UQQThdT5kHnHFUtGCbgVNyWMhVfnmuNiOvJ4jfQ7peT3GUgn21K4MdsqlTrK3
 BepVjbg77yFm3daWLGfy8zr9FDr8BqcZRLag4NFlcnzIFPeKBnmncfft8rfmET8y
 tYXrPZs4DwQ0xjeEjcv0Do2ym4GkaN64zeaquqa0EfByTZCeR2KKCZ/VgguS8bXg
 K81jYSSecBPRLKNFb3L6oKMuwZkvmTFEK988wRopCUyOTyMFL9yav6dNlueUZS1T
 4LDtz93jFoQ3KYw1tx5GuIQj2sTEhy1ZW5ZOsFQK7sbyBZambDTBFVqw3M3UoRPg
 kDGU+Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n1848-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939c30aa9a0so227133585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415576; x=1793020376;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=;
 b=jAe5l8we0FELes8FQ5hO+2RB1aSk913iXR3/L8KvzoiA5j7wSu2uXWibi0UR4pSvH9
 e8E8lYqUBGWL+hteAYRANv/ODRd8lFElEwGljahyo6yvZ3J+WRYzYEfcLIwZRN+Zphjy
 +iqweSTUQYP5FPkH/0cMmWRTPCwMKCTw6DJQblJtirpXW8EFndn5k3XkABlK04kLL1CL
 1yzL9nCiMNISPXOlWjZJePzIsZTVhrrB6qpxtoS9G7IuqtKqz4NoedSGi2xbE+JF2vcD
 yq/PWG43zlhJgldGaSLKbVEnvoiOtgx1NEG2BYB1vLOQPJmKAaJU2NhRniRoCGkXJVZi
 Mfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415576; x=1793020376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDY4R6k/Nm1p1S0xEhbA3aSwiXunRz/voblMx4e/CvA=;
 b=oKOrVEHoPIuK5ahEcXtNQcH98GN8WcwDPES2rHalBYNVzby53MWU3dJLDdkJ0tyXF5
 RqffWetrOeqR5umZ5XbC8vfn+bgVJ2DXtMUd9Kb/WBHiCAdLKH2QI8dXLe86y+x+zU7k
 bW3beUqWXncFIsc+zgkxl3q+P1J+6HGgglrdXw0Pxt++Dbfr1eKRLFUfgRW84Cg9qMq/
 0FcRhAZMEtFWnG5sx6QpEe2gRfrvi2qvu9Cav2V9pEqJCklWgay8tcbfVLeXAHs9TaFZ
 Dhppa0Df0Kj+tSDD0wqGVfV393c3eZsM0Y0/dwCmicgvvmvhmwZZnNy3DuT5Wuh5iqFl
 DiFw==
X-Gm-Message-State: AFq9FYKSFQGH77DGvSPnzRzJpT49d3su0a6eGpQkd5mH9uueA4CO0i+A
 Kgs2U2J7DA7Z5ztKFsi+ZPn2u9+oxl7THMnHfmqWdJO/L6G0Hn6sqWuG7de5O2qXni8Xsjcp8KD
 VcmoWrNi0lLZSOeA09VpFIA7gmJCLpqC76fkdW9HLGZ8jzMmT948doNPHkaKYnWANJYIxtT0=
X-Gm-Gg: AYBFou1GunEYcxBjFnotwNx35xCWzLF9A0pQ1ymdg1FLuMxO8tB6MqmeSf4kIqQtlS8
 QCksa678+ZZnQX0SrK/u+9xJIyVux3lWkaYtpKW5x/IYVVmSfO/3mx1oW8ymobnmXqpi+tX355o
 /EnItYk921MpWraOOdnl4DvlU414qTwS0fLTzcNBrSvpmZQaqkBDHad90KPrBBLXeYXkOIljtsW
 Kcs8E9adN9JJzyCDA5jpp/BbNnXZl8xUFJlmRuzsKwX3EpQ9T911x985iuc6Y9ke26BVXiVT1AV
 MPdBnH8QFProKvfEG7YRgdKnneo+jIFtQEJEv9MRhB62yMgQiN6BMsGVXLiTi+tiIBtmWUvljXG
 x7I3WghU8pzR0Wi0mYQw7N25bDfAixpZC89AB6JxgRE1+Pq2Iw0O9W1Fvie8HahHzH9/Ff0mApE
 lUy3icDJzcF4G5
X-Received: by 2002:a05:620a:1a20:b0:93e:a71a:5de0 with SMTP id
 af79cd13be357-93f29cc7983mr1348473685a.26.1792415576378; 
 Mon, 19 Oct 2026 06:12:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:93e:a71a:5de0 with SMTP id
 af79cd13be357-93f29cc7983mr1348462685a.26.1792415575701; 
 Mon, 19 Oct 2026 06:12:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:31 +0300
Subject: [PATCH v7 5/9] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-5-d4288a26eb54@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4493;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QEKNuuMhXPGLAYB0Q++KZrnkiKauZVjWcJRHipLfbt4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdFkCB1I0mJpJakqeGM2PCp6MQe20cpN/1ZI
 prHiqRY8pqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRQAKCRCLPIo+Aiko
 1X76B/9WHBADywt3zJKdEWe7Q+mdyQgpR3U2HGDdQp2sC3yDHaRZpQy6ejouNHEitQaWAuJNEz5
 bYlUPNFzeRIBEoagUceaCcfEdBCvPHTQ2PM+RkP16t4MoWeRvERwOQNtnO/Q15L6q0rDM1POQOV
 hmM7RVVECywRMAqjvoXw6E2QCgpuYzqXuwJU9u81hSfHu9YlYDNWQPaGMf4OUtLEubJXz1/86FK
 d2J0f93x7H6R9hC4NLoAaJHlchceIMBtnt1mkwv+r19tIJ9IMIT90Na9bkYs/+Fbu7uiKsNXjxH
 Z7xZf2tg7P+QtxspdCaNbMEucndaLXupgnlsnXEy8+PyZr8Z
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX5EWQacsgSeLU
 eVVK2fdWFUlIm8mObUFhtQh+0XyhoIvhz1LCG4fSMAlZSedMBrr61/OgjebXueNTkGQMPKVv1pr
 GchQOG+BQ6nLpDXHaDXzQKlrCmw5liM=
X-Proofpoint-ORIG-GUID: knY_fJ36ncoqmc6Nqz2Mt4JLfotDJxIo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX424Og72hE3W+
 BPJAsYEX4NcDwXSyfLIzUuP5n6ySDMYuC71p5yLr34mOI0yvXC454QpXTqt2Wmk5Lia3KhIXAp+
 ARi1QYNSPN6NPekIKeuQmgTWQT4wazMMRViGidbdET12dV0WY1b+svdaasEQ+U7+YSYmALDxyCd
 bu2JkAa2rpnP/Kwv6RpAFkbpHNOZ6scGQt1q0EAkrBdY/j6XqFCN1LMStPUBAKne19GsHfFB1L0
 DtAHDC9s9JnpDDjqK3VQreT/rESEj3jHjvrLb4B0sj3VEJNFteJi4uEl3PBK3x5ubVZG/ty8Q1p
 14+Z+xatQQMsXEviQ5DxAruWlGm5IKTLIcQ4in3XN1NRE9sc8csXmk3FrXgzlaSkELd8RM05lsj
 6ilaQ64B3KgOX4m3jUYZgkjhkY9IhUYcHXMNqtAdWUmMXJGmE5ESgQV/77g9CV95cyxaj5V01Vu
 r+0mu+0HPDrMsY7KsLw==
X-Proofpoint-GUID: knY_fJ36ncoqmc6Nqz2Mt4JLfotDJxIo
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad61759 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190052
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

Now as all drivers have been converted to
drm_writeback_connector_init_with_encoder(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
field, they are unused now.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 55 -----------------------------------------
 include/drm/drm_writeback.h     | 18 --------------
 2 files changed, 73 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index b4a002e6d043..683da368e339 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -148,61 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
 	return 0;
 }
 
-static const struct drm_encoder_funcs drm_writeback_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
-/**
- * drm_writeback_connector_init - Initialize a writeback connector and its properties
- * @dev: DRM device
- * @wb_connector: Writeback connector to initialize
- * @con_funcs: Connector funcs vtable
- * @enc_helper_funcs: Encoder helper funcs vtable to be used by the internal encoder
- * @formats: Array of supported pixel formats for the writeback engine
- * @n_formats: Length of the formats array
- * @possible_crtcs: possible crtcs for the internal writeback encoder
- *
- * This function creates the writeback-connector-specific properties if they
- * have not been already created, initializes the connector as
- * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
- * values. It will also create an internal encoder associated with the
- * drm_writeback_connector and set it to use the @enc_helper_funcs vtable for
- * the encoder helper.
- *
- * Drivers should always use this function instead of drm_connector_init() to
- * set up writeback connectors.
- *
- * Returns: 0 on success, or a negative error code
- */
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs)
-{
-	int ret = 0;
-
-	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
-
-	wb_connector->encoder.possible_crtcs = possible_crtcs;
-
-	ret = drm_encoder_init(dev, &wb_connector->encoder,
-			       &drm_writeback_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
-	if (ret)
-		return ret;
-
-	ret = drm_writeback_connector_init_with_encoder(dev, wb_connector, &wb_connector->encoder,
-			con_funcs, formats, n_formats);
-
-	if (ret)
-		drm_encoder_cleanup(&wb_connector->encoder);
-
-	return ret;
-}
-EXPORT_SYMBOL(drm_writeback_connector_init);
-
 static void delete_writeback_properties(struct drm_device *dev)
 {
 	if (dev->mode_config.writeback_pixel_formats_property) {
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index c380a7b8f55a..879ca103320c 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -24,17 +24,6 @@ struct drm_writeback_connector {
 	 */
 	struct drm_connector base;
 
-	/**
-	 * @encoder: Internal encoder used by the connector to fulfill
-	 * the DRM framework requirements. The users of the
-	 * @drm_writeback_connector control the behaviour of the @encoder
-	 * by passing the @enc_funcs parameter to drm_writeback_connector_init()
-	 * function.
-	 * For users of drm_writeback_connector_init_with_encoder(), this field
-	 * is not valid as the encoder is managed within their drivers.
-	 */
-	struct drm_encoder encoder;
-
 	/**
 	 * @pixel_formats_blob_ptr:
 	 *
@@ -148,13 +137,6 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs);
-
 int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 				struct drm_writeback_connector *wb_connector,
 				struct drm_encoder *enc,

-- 
2.47.3

