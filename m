Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AB4CD342C
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9887D10E8F9;
	Tue,  5 May 2026 00:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hUtVquDF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XG5FiL7T";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA7710E8F6
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:25:50 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644JUMEA299982
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=; b=hUtVquDFHwQK/Amy
 CK2IO4oqJskCVkQCdGS6GgZvVjCj7bIi6gjp2E0fxdx2PemFTnNgmEylzjFpOEaI
 DxKCFgm/hWvTwtTwitPF0BYdxNVpmOh+c4BDR7PCBeMl8ESSHuvkfcM/MMTY+Rm6
 5rpvt7dYkSbDSFs7QLYUUS+GVLp93bUvaKETydmTFjmalxOYXJDEWZuaZsEGtRbB
 vuPA41+2NZp67/I7G7qID8MK5RGtt+wL22rBu1pay7UP4kjipoN07teT2WPp/Mmq
 uVuOdUvSs5MhkghRyGNCu8UiYQtlrNzIzItojWjjTswYcVSYb2wg9Cxx+40j3NwX
 CnPZxA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvnda6vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:25:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5104b861649so10891641cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940749; x=1778545549;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=;
 b=XG5FiL7TckWjBNuRmFEKRXT3xIiiQUVjyLNdrdQj/rwouJkkYJG73KGxAxSqD47tSC
 1HYeZeGnXoHDwpEPBX+ZDwepSv0nIuR3xVYHurF1MjMJIpYTOI8bOsJLTvP9kk0kFdt+
 G0d5vQVeKo1EvAKPE38b6Q+1vmczl41ZdaQToZygJHOnbRfAoSn3KhzEWlyU17VF13IM
 ga5jO7mhmtJ/e12qfnB6HcnmYN4HpZmSeORN3/KFo3c6pvXi0+q3T0MSE/0kflEO42fL
 XEnWgkcM3WJuNIkI1/ld3lGTyQamb6U/fAs/iKIRh4FqFOfKIB6sngUQ5JKs3N5kJlKY
 tcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940749; x=1778545549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=;
 b=pKjpEQ9DUB6dzmf8NyOD9SGEJKPV5yYkoM5F3kzyNYzq1uP3pyFZ8KMsZCCuTKy4cE
 OqfpV4sAWhALGG/5kd9kJ+Y/SJbg9MjcQ3j1w3ZXIAHCvpLu7VPIHfa57UjvJ9mdNovC
 FSVOdaHLDgjdPCGQ6fibF7rO4rHaSr32YgIVQknudkKCOOZ7xvzm5qBcEjjF6oGRKJF8
 cIv1Fjk2YPhfh/31UwmLfb8uFrmtl6ZEYkRQVabZtjnH8dtlbDpZGrcCKNaixFW/ZuAx
 ZId6EwvkGxT1Vnu4OBx/isSfrjlN8oEj1v9JpV/RBH5ZIlu7DLmEfVSj6MbCYw68KzrB
 td8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d6lU8gVPoFFXi1ATdUmqzeY3VsrmWk92PZNrsJWhVw74nhpPj3AKgjpyagV8mKIKGEWVtWT4x7cA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz87gYtBMl5Dkg/lD3DUN05dbUSi8muwQzOnx/w3G7+X0wWB6t3
 PQriW700Ewx8qSloVmu4ozGISXjUOX8+d40EJo5qCT8TWit6H8BZz07rhmgcesqL0xVUJJiUd39
 MlPJBvrH1kEP7orvIX+uheA51sL7uhrebgQdTOqWT/47w5teBPCxE1jfOM8YSF5nPbrgjyOU=
X-Gm-Gg: AeBDiesB12O50vxi4CtIIQ6HfQBa2dT7HcPQNR5gnH/HOfgUYdb3UaYxHi5eX77z2eS
 0vvYmyWPiQcR/zMCV9QZSY7kfbAUL3D8OQoIiF5+6sU4ZE7vmIEfdx3yuAO3TCZ8WvpCU84ZJ7n
 grIFO9Utkpyl/W1c9zQ7zJCG40pRF/MEpB8z8GvWXKLYXjVR6L/mhHivaLevWuOJuVB/3Kes4HF
 hPd9N4A31yG/qr2h96mKAb55nDTd4vvcxC/EZ7zkjoTLQTEK29xsOQt69KW8qobB2OkyeEYQ6Ce
 7d4bS5CtO7dwpxM9vCwpjWAN0WqEVtSCCMRxhcVMeLciHW10eW/tL0rC5czOaxdAnbShryXLH67
 fDPLMm/K/EnwSC5HcFcZRCVicqTZA3vloOMHip/I0ZZNrp82XLBRuUuIibfUSIEg+da5EkncCer
 IrP/gQFW478J0UBkKcbJTfIGKiI3M3yzgueGtQzH4OH3pwBQ==
X-Received: by 2002:a05:622a:580e:b0:50f:bdc1:3bbc with SMTP id
 d75a77b69052e-51306aac200mr14477081cf.45.1777940749094; 
 Mon, 04 May 2026 17:25:49 -0700 (PDT)
X-Received: by 2002:a05:622a:580e:b0:50f:bdc1:3bbc with SMTP id
 d75a77b69052e-51306aac200mr14476621cf.45.1777940748538; 
 Mon, 04 May 2026 17:25:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:25:04 +0300
Subject: [PATCH v5 7/8] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-7-42567b7c7af2@oss.qualcomm.com>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4480;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6KkNpyC526rgMVIeY0D11Z3gyU75WDlgdpp2dL9pdq0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp+Tjc4aI/E+fCVPzwdLRrDiVtx8WNLqsyYQ22J
 GQc9Z242b+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafk43AAKCRCLPIo+Aiko
 1W/DB/9RLlO/8FopwXYP5adamkOmud+2XRg16jh0MbN04hulZan4teex+3SutuTANIXHCaYmgGH
 g8jvk0RIuVH6PUAgayKAv9kdGe7ksmExonWNj3I4LW1MVlPG8y358RgdJmuyT4hwhh6f5G9G7du
 xdEI+0m79kNZ2dwnD6COJWW37eKr+/UYc66bDqq5Q6yT80/qyMnovBEaq1WKuUd7d1YOqRGZMJ3
 KBUXBWSbAwCYH2NglyobPQSIpZVi/3YlXZCHl1W31w9d0ncnavvwJiJGIRrxe8gVduiKcjyh7bY
 +FsLb4cp5zG7JIfyUghx1RSeAeNmI1X5D309HpKtjERxyYnE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: I80KZtS8Vo3a3xoYNtAnGgD7lR6niuZ4
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f9390e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: I80KZtS8Vo3a3xoYNtAnGgD7lR6niuZ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfX6NkvMTURhpZB
 P6BkrBEc2p8aoqlhjLZLw7wddKQuhX71G2ciCOPFa0qbqhRhIuHTv8UzgJTMI6xCEGTGc4ta5xg
 zcKQ/PPpGmQUxFEx0mEFuWCFGUkd9UqmNT+rLBhieM+Jazt9VfWVS5pqS5HWYwFKYkSJGFLUtuH
 PZKScqXOh4hdzMkp5TIjAkJcAWJYiPdrERAJ3Aqe+Cg82vmtToQti9uOxgnwQrMHZxag3M7DcBs
 AOUU617pV8xmEjhPsa1Kn24DA9UUDuUiPPW9LLNUJUOy28+CxJE5N2K1zH/wROlcTk5kth7Dti7
 gJ34PSPAcrMdcgjkvq0nhRCFvPOwaBltwcodSv6nPcMh/8/sQi9HhsumFE4AV9wQsXh9E9gTkwB
 6C8ZuR6sBFjFxQ9ogDT3VErLFVlBgSxeieVdvx2Ri92Sy/49zCtH6U/Bd/p0c9SmbcKvc2xmKGz
 UoSHdLpIvyaPB8dCnPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050001
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
drmm_writeback_connector_init(), drop drm_writeback_connector_init() and
drm_writeback_connector::encoder field, they are unused now.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 55 -----------------------------------------
 include/drm/drm_writeback.h     | 18 --------------
 2 files changed, 73 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 4da5d6094721..9fc15168c34f 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -142,61 +142,6 @@ static int create_writeback_properties(struct drm_device *dev)
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

