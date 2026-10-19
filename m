Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03A8CCF2E5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66CA10ED1E;
	Mon, 19 Oct 2026 13:13:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DB510ED13
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OtHv3256627
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kFaI/Jkc6f4Kq/MuB+nr4917gGjbH7lnxAEvCbOlf7c=; b=G54f4cziwK6Njg8J
 IjOWS6X9HSSyrOE0R8cQTPXUuDi4BwX5wnm5g73w6JpxpSGDDtIm9Y+dKAO8OLOy
 5kdHyEj+h1AjnyRRnpFisYCBMdVMy00hY+7kp0Z2nfzCxVHPyIbb5j3DLsWpKmK4
 Y1pRQnydVzNubkdBnXq/b+TUEalKm0xTikc0keMXBFbOBn2wYok9MKuVXQRZffyk
 BvULSy78wEioi3riPRarJZCtn0a9RmM8nKfesM0KhFKm9zQVof3t5pF1fl43lPug
 UFzUQYXYXJcB6Eaz9RH4CkJdDke5Q5txkIg1rrIp6/INDomyYp+bwtHgk7iRZIIM
 0fcBIA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f97kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f13c143c8so397568685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415578; x=1793020378;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFaI/Jkc6f4Kq/MuB+nr4917gGjbH7lnxAEvCbOlf7c=;
 b=Hvo/oSgr6oWS7fX+SkG3/Cv4cuwpp+FEXKdqpbxDSSckZvckcg5f6huVpYu+7jDO85
 JKV7qQkUOyTi47vn5vVXQxf7GK8C1Ohr9Duqp7AZG+MFeqlTr4jo9d1WWVG5StMECokZ
 /TWsiiVatbxSogpeAXFqd5AGwuCRQtQl+xychpJdJJs9dsMBh7f0DLd+EAHCvEx0XsrZ
 hRKI/O7etAu30N3atNDNN3WsSbnynyttrSnTIA1SduvDl7ExK6SHFYR0ZTUrcxZVa/6N
 PlcW5jeLe5h0oH5bJ3daFdNVui4GW6KWVK0w/+JSIh3GEzAWOI6p9MUax30jPQYoVACS
 xGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415578; x=1793020378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kFaI/Jkc6f4Kq/MuB+nr4917gGjbH7lnxAEvCbOlf7c=;
 b=fcuKAXAIpEXA0dsama907t9B4LdHad8xrr9Jrrm7fX2MuKRB5l1hYKGcv8fpBdIqc5
 LhpPK8LEoWTs0L5Hycjem+vqRItKu/A2sQnSPoDvd4AkNkwN3yZ9gXHaYS+gwGSczKHD
 r4m5D1V2uG3XwOrnY/qdLWtYBqfoJWTq6GhoVpjLSfjlE3bg6Aq9PpZVRu0Ysvmq/2PM
 QqDRf/AyXEUbir9Zo8hLB53Tcvnd7y10moV9uTmcvpqDxjHNR+E2T8Cb7yV34hwMCTwB
 sbYQE9saIFhcMa+VS0ZKgzH7NMbzmf9nYgy6XRXp5ijB3ewESnTIs6ieI2l4MSYgBgP7
 axZQ==
X-Gm-Message-State: AFq9FYLSZMjGavIyyDwArliyyb3McOt3guAIaV2r9hOc7kaUZFGcOR1o
 J5It5jWiIYM7aaxNCOGtOzRpbB96mpbVug7iqQKkgASESSIFNjXQtqj5D2aPWyJkZI3Cbp/GIDv
 5BzypIqmoYNI6NNGgxNyzelU+U8fnp0Q8vTOiHMwrsRXUS4hpUQG2VbAyer69NrALEUuVURk=
X-Gm-Gg: AYBFou11fF5ZLcx+vGuqLww2iMxoCidXQ0JVNLmxiMk8WfxUbNcqE1gp/0l/wgT77dg
 OzlyHHTB/5SqLiiS0hveSRRDQ2ZhKBYxzIj5gZsavJt2nORcscf/iXi418k/SJOQ09u9N6Ly3ME
 TAIY5562w1gCMuJcui/FxDrdm0pJvGHz/r5O1H+ZJEgk60myAo5rTMbx3eSSghTUXWGc56REhd+
 sj2R5m5g1wVTII8mmPBgDYTSI7vMDa2HQ5OMgf7q30KMSBmv1zz0wxw7PH+k++F3THvzTqvaHbw
 OEjupjTmZL9KwKyk8pYiSxByDNn+LEMORkiwCK0CZYAoLJVVIvg4Sc9CDo60yoICkJoyEXn20f3
 NReBLrsiuygvPjFgTaZuMdrbhKCtspo7N7C2xy1KqkfM1YgRMXFgJUuNddKY5Wmg0UzpszNSBxB
 TUWRN7Pyomvnf2
X-Received: by 2002:a05:620a:2609:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-93f29d8e1c2mr1205209285a.65.1792415578480; 
 Mon, 19 Oct 2026 06:12:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2609:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-93f29d8e1c2mr1205200985a.65.1792415577911; 
 Mon, 19 Oct 2026 06:12:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:32 +0300
Subject: [PATCH v7 6/9] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-6-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8295;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MXiUgqFb28XZ0uD8+NV8QVzUD8kgz790YiWbaz0Q+SY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdFDtgtFCpX8pSrsYjEJBgBhNTr66M4hywK1
 J0EIgFup36JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRQAKCRCLPIo+Aiko
 1ccyB/91WtfAKSG7oAIcANu9YZJIQqQ3uZFxMWZEOOleVroXsEQTqIpN8rP4CEeaf1mzAJWb10Y
 VxXKdxOiOllbWBOP97bjLukuSYDlqgc/P87HkTCTVY5WvTAYReEQEGdaXZU1VVBJgOKrl6u6Nf6
 5gYu+C4QU0HObuYv1ImaWFkngOluMokJfVyOhk9b/7vUhDW0bB2X/NwAuPrt5lNg68qvVcIbJkk
 iEPmH3kCQxQuU/THoUD037Eo4znFy/dDOeWM03kRuF/uw94o2xQBqvswdxXjMjW8ivhEI6X8xXX
 UGcAq16ZbPXKZuhJm3eJ2JvEqDOm51kw6Sjx1PIO+ReHfXDF
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: hFojKjWDS5KAaS23-AZTA6us6HIFC_f5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX0qkswiV6+6Bf
 Sc/ppl4np4OK28YgX+ByYZ2Apty4GMaUjwiOquStWEr4BHG4oCQfxaduPbTaVk6r3nUeu/ht7Jj
 +ycikcDg1iby8ez71X9WzHRzSRfhgFgs8TsyW1H9DN1kQ419DCWyfDwWSVjDOVVNV+WImECFIGP
 V0CVdDM0UiDykI020HL2gPbD2xJmtzXWkleDwSDLLn+uSB7CYpOnWcLvZoAQoxtihfhoU9bc42w
 9Idm5Urxtk3q2feCOk25njxoX01L6Cd/HwdsjQqzpe1zMCEsbSNce9HZmAa8xWtXs1EFkeb14DJ
 ivWPklzGWODPc5ekbgeJ8zaA87bif2Rzgf+GYH+dqt1s4/pD1psdVRO4abSgz2MVU3L28KbQYLp
 MFQKD9aKZrNjuM1Eu9HmHuOrPVzvwrR6SnuDD63MpnWdql801td/GuFPalSlCeh6VqWqPjR8HS+
 6bzllwz+kCHqoiYcR1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwJN1ZVG5xrxL
 bZedZQ28lP281ajxPKa+X68jbwxbCFCrkwCP1vWNnEZISh/Mm7yIy13jjmnrFIIrdJHS4xazvIQ
 oUveAoC1BkX1cFMgkT9oatWR/wRk8LE=
X-Proofpoint-GUID: hFojKjWDS5KAaS23-AZTA6us6HIFC_f5
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad6175b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=KeTiLIfg1DN4_MrrFvcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
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

Rename drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init() and adapt its interface to follow
drmm_writeback_connector_init(). Drop references to the "custom encoder"
from the documentation since it's now the only way to specify the
encoder to the writeback connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c    | 10 +++++-----
 .../drm/arm/display/komeda/komeda_wb_connector.c    |  8 ++++----
 drivers/gpu/drm/arm/malidp_mw.c                     |  8 ++++----
 drivers/gpu/drm/drm_writeback.c                     | 21 +++++++++------------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_txp.c                       |  8 ++++----
 include/drm/drm_writeback.h                         | 10 +++++-----
 7 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index b5b186e4f81c..18bee44794ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -261,11 +261,11 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init_with_encoder(&dm->adev->ddev, &wbcon->base,
-							&wbcon->encoder,
-							&amdgpu_dm_wb_connector_funcs,
-							amdgpu_dm_wb_formats,
-							ARRAY_SIZE(amdgpu_dm_wb_formats));
+	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+					   &amdgpu_dm_wb_connector_funcs,
+					   &wbcon->encoder,
+					   amdgpu_dm_wb_formats,
+					   ARRAY_SIZE(amdgpu_dm_wb_formats));
 	if (res) {
 		drm_encoder_cleanup(&wbcon->encoder);
 		return res;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 77aecf4d3f09..7c64facfd799 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -186,10 +186,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return err;
 	}
 
-	err = drm_writeback_connector_init_with_encoder(&kms->base, wb_conn,
-							wb_encoder,
-							&komeda_wb_connector_funcs,
-							formats, n_formats);
+	err = drm_writeback_connector_init(&kms->base, wb_conn,
+					   &komeda_wb_connector_funcs,
+					   wb_encoder,
+					   formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		drm_encoder_cleanup(wb_encoder);
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 7f5e25adf999..7e1d1c0988ae 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -240,10 +240,10 @@ int malidp_mw_connector_init(struct drm_device *drm)
 		return ret;
 	}
 
-	ret = drm_writeback_connector_init_with_encoder(drm, &malidp->mw_connector,
-							&malidp->mw_encoder,
-							&malidp_mw_connector_funcs,
-							formats, n_formats);
+	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
+					   &malidp_mw_connector_funcs,
+					   &malidp->mw_encoder,
+					   formats, n_formats);
 	kfree(formats);
 	if (ret) {
 		drm_encoder_cleanup(&malidp->mw_encoder);
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 683da368e339..89c36f1414ce 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -165,8 +165,7 @@ static void delete_writeback_properties(struct drm_device *dev)
 }
 
 /**
- * __drm_writeback_connector_init - Initialize a writeback connector with
- * a custom encoder
+ * __drm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
@@ -241,8 +240,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 }
 
 /**
- * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
- * a custom encoder
+ * drm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
@@ -269,11 +267,11 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
  *
  * Returns: 0 on success, or a negative error code
  */
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-					      struct drm_writeback_connector *wb_connector,
-					      struct drm_encoder *enc,
-					      const struct drm_connector_funcs *con_funcs,
-					      const u32 *formats, int n_formats)
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats)
 {
 	struct drm_connector *connector = &wb_connector->base;
 	int ret;
@@ -290,7 +288,7 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
+EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
@@ -320,8 +318,7 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 }
 
 /**
- * drmm_writeback_connector_init - Initialize a writeback connector with
- * a custom encoder
+ * drmm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index b0c1ca0d0dfa..35460a314a7f 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -219,11 +219,11 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	ret = drm_writeback_connector_init_with_encoder(&rcdu->ddev, wb_conn,
-							encoder,
-							&rcar_du_wb_conn_funcs,
-							writeback_formats,
-							ARRAY_SIZE(writeback_formats));
+	ret = drm_writeback_connector_init(&rcdu->ddev, wb_conn,
+					   &rcar_du_wb_conn_funcs,
+					   encoder,
+					   writeback_formats,
+					   ARRAY_SIZE(writeback_formats));
 	if (ret)
 		drm_encoder_cleanup(encoder);
 
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index c469f8b1068b..33b1bc37b362 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -601,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drm_writeback_connector_init(drm, &txp->connector,
+					   &vc4_txp_connector_funcs,
+					   encoder,
+					   drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 879ca103320c..958466a05e60 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -137,11 +137,11 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-				struct drm_writeback_connector *wb_connector,
-				struct drm_encoder *enc,
-				const struct drm_connector_funcs *con_funcs, const u32 *formats,
-				int n_formats);
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats);
 
 int drmm_writeback_connector_init(struct drm_device *dev,
 				  struct drm_writeback_connector *wb_connector,

-- 
2.47.3

