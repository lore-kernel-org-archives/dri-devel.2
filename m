Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A8ECD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A8A10F63E;
	Fri, 12 Jun 2026 18:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRWWBt6A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GMe066MY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953DD10F645
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGWSpJ4156797
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=; b=oRWWBt6ABEqt5eXm
 crjECfTbmZn3hmv5zjdzfkecPBLuWdzAsMuK1dvbN9+4HEx4qoON0XSGX/thQhl4
 FyW/EmTg8fdQ8PqTuKFQtilSnf54Rt/j5teGI7/rTy4p4hO8YHrhZi9m+kWqlexa
 3jbOfFvYxLa1hz7XrbcFcUKIAlS0psOKYvSQAdB/+GVB+UDJUJ6KbYaffXC2Q9R4
 /CZsJTzCnVEKd2nty0p7DZ7kVUOzNV2EUSPltDGnuvT80hmE/LPKnVIKJueVq3wB
 ILlcMdzhPT9MPmSLNvWDCv2BoJLG6kopu7HZ6vGka+HIux2UfrYpmo71qUaeehEX
 nlvHXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcm9hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915b6b63056so263171385a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289036; x=1781893836;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=;
 b=GMe066MYgRaxVJN2RhqE77xy9zcCJN/LD2TBn9/2jgNNshfuecYbtKr5TGAtCBA02o
 9GcOTcj6j73zRXXfY1U/h6UpUygcwqV7PS6SYBk171KAQHnPFwJHLpHD0En13sH8PSQY
 J0P1ocRKlSF3a+WNhzHjh6rolgzgwa/tfEzurzVszxIOlO84gWaiAiyM+RUAef4fRRjb
 hv2lYMM5q28r+7lClRxQr57S9j0Wkxo3Ogcs2ypuuvOo0UP+K9Y44sBWjv9h/q+aBxj0
 PB7KVVZ5lsJodWnAcMn9SjSt7s23PbTGnd+VqP3mMBO+ZlwGGwjOgOZkKHOgamhuyQRn
 jY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289036; x=1781893836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EaIMgG/IEi5Ad5NwXbrOlQk4Ovs4qDGmtqlsgR815SE=;
 b=FABReZu2LmZQqm0Z+Hhu6DoEaxCyCLTrn9EGKfbkk5eK+0A5S6mGGUhmInGdJKBdAU
 /Osmi8dLBEG/CZsXnbuQxTbbueZhQev68maPsGAFNthimKhrvDwvvLWTsJrPg64IfYWf
 SzB1O1aW86PrWZeUssp+MCf0vzTVt4x4sHEGuNRW+DrpAewAoJDK+cyBuTt0E9+H+eV6
 CZdHxEVLvC5He9IFtzur4dPUEgSJw44GGhb0xBQa8w33WSKdxJmttXGMnmYx3lFCBu6f
 tKtFd5hnUwzCFWUj8/VDMObQ7ktgs9Wx/3cjbnRP1C6mCuzAmO4oThg1fPbZ1mGNmbei
 PZmA==
X-Gm-Message-State: AOJu0Yw/9rlKNYxRWmG7/0dLzr5XwoMkFt9Q6TSf2vsz0uq50Rwh/RZ3
 tn27yhbrocgX83YAgVXbbnaW7qjxndhaMCjrfDAUdhRVb62pm/GI+zll12cEGhMnaV7uTeS+AMg
 9P6YSgcrgioCRhCMi+3Kp7MNLs3SG7ka4FdrOQhXCBLNJsYhj1wxJgdbZpC+9UJc0+cEj4X8=
X-Gm-Gg: Acq92OEALScZcGvKRVPQvJ9BmWFBBpYNyzJEzLygPqAStcE2aFKDnMZ+pJpzeDcbc8C
 QYgf7bXwBvpjDyUprp3Kzv8jvt5AWiYXg2DPjx/AEU2mjx3SYwFqGwhfDk8Loe0nE22HOUOfjZu
 UBJrjNtFHShxWClQmTgWursHG93Wv2auvuipeKFvCoWaXrYQk5rEVbzcCdQfmSG6g231IfkQlcS
 7LBwGFWH8Dl3BQvhSEwXKjZ4MNqYShH8lX6400yThcFGZ4+Q8ahEd8OkRDvbGVbrLE9XDh8uve1
 1ulc8C4VYj/huGFu4rAkD4vMbS9pyxFaIj4PsCzoLKYnc6jrJ4NcvxYIFoIa5UzsMmu0r2FucSx
 PuwTdy0Y4GpYJsiWPHPi/7ieMWfV9wSVBLnw+17FKsSQbe4Q1PTu305thsbyjpoMRlj91dm3uDZ
 bEK83iCnNaCqjs0qdpSzucwiKwtj3H52DBoS4=
X-Received: by 2002:a05:620a:6288:b0:915:9125:e63d with SMTP id
 af79cd13be357-9161bcec31amr573646485a.43.1781289035945; 
 Fri, 12 Jun 2026 11:30:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6288:b0:915:9125:e63d with SMTP id
 af79cd13be357-9161bcec31amr573639485a.43.1781289035445; 
 Fri, 12 Jun 2026 11:30:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:18 +0300
Subject: [PATCH v6 8/9] drm: writeback: drop excess connector
 initialization functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-8-9f3a54f81310@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4480;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6KkNpyC526rgMVIeY0D11Z3gyU75WDlgdpp2dL9pdq0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA3jhMYBxZuTwA5P8pC0iOzIEdJ7fr70b3ui
 c51TlxkhXCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNwAKCRCLPIo+Aiko
 1daWB/4u2v+4zU23e3Xdhf+ZULhAcCbc7KPvw3poBWoSLMiMVcozrKDBfgSWbwSIQaYyWKcl/0G
 rGIMRuyDsDJ34XQRo4oLUBfA9Y2piTv49SnLjBpEXNh3YK6BuIm0hpukouPxJWhBYpFmRsmkxUr
 9pjBpnGdQDBbvDbPCX5DNzKxUYzMjoaULMuQ+yqa6fDQcsAhq9BcCp6ahC6z0whUx9BrKDtpc2G
 1P9N+IGrF4eJivzCB/LhONe9SJLkY9NRiNsgbfi5nJ9+n6e8uAsjeXmPXHIdw3n+aBUTb2e5vj7
 kTbZwrgAuTMpFWIQ36Q0w99dnWIe2bX9Fqir8Cebzr6dyOpm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX4jjFC6naMFw1
 OzFNCQ8Q9K83Uexl+NLVCforpVCsTjOBo7pE1cNF9eY5rGYPWZ1lh2DopWpjnIsCUNavw0QzPOT
 OxMYDkFczkQZVbd08sEPGq5MUyRtZVK8ILgKxoIQh2/EUYEhnM7kZ84aQ/pxbHwAa92iv7xHLHX
 KASpqY/L3arFsPOaK8RtByvWcCWdFFmngiQQEPo2LscAYYmqRk8UP5VVNaJ8aQu4bU1pnQcleYy
 Kt2Kmg0KfX/NTIY3PkmtO0oSBNQiR9Nx1Rsvl4MwU2fzW93iStT2qchMuAdfi+7CKoN4vwXatxd
 vb4K+5j7VqL/9oWtBRBEA4DTVRqryq0fIuMJzseosSTyn2G7we9e8hX2tSN6nOx3MWMp1HESHwE
 kKljcTbViw3HJXAry+okX2IepKXyi1K15Yw/xmR8f0702jpzzmoxNPLmsaMJ4AvzMPWUFcKa0VL
 lSLWWshJ2h4wiW4z4PA==
X-Proofpoint-GUID: ZbQ338ExvM-WDfuo8qhYnWL3kikwMkC5
X-Proofpoint-ORIG-GUID: ZbQ338ExvM-WDfuo8qhYnWL3kikwMkC5
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2c504c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX2ws1rXD3I+3f
 dSsFDQ4v+BbRQxROyer/bUIESxWOVa6MUdktIGhZXTHfrgBepJ00ohVfV/ebYVFdRkG36IdBmUC
 TxEC2g4dJYERYNcbpNSNaKnCv3g/0Yg=
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

