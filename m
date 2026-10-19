Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DCCCF2DE
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E4210ED1A;
	Mon, 19 Oct 2026 13:13:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC25910ED18
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OrGN2234322
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eDwMHwMtxfU7670dkTXkc05qSneY1y9esdOAThnTnig=; b=kgSjQwPenIxv2umN
 Yd7boP0ITxwVZEK2GEMcWSqS2kqILy1LDIA4/fwyEH0AvC2qzgj9d/Q+CrwIojkJ
 IuDRoloGv4PBE2Nl3ekM4mI8vh07/07WBI1sXBAKSDZ2irR5EaZ855I6uciI2dqn
 JBJO0zHFO5amxZ+SNnkc21Fni5uOLYj5E762vCcX4Hl+Lh2dibFOvHUZ1EA8sAjC
 dHSwhuBwqyeGUtOQGgbKLregdXY6qBQbQSXbDW41g6vf8dUmnNG/iX4Nqs7b80IL
 HvzRAQKUnU9UiS2GY2nEJ7IXRvGBgH7BbhlMGolaR47Rul5sDh6b6cBKqPUWsRQq
 03F/hQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x987t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f3969a2a7so196617785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415582; x=1793020382;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eDwMHwMtxfU7670dkTXkc05qSneY1y9esdOAThnTnig=;
 b=NjqfCNp8BkyWq3K2tmruRjmJCV7bQokXcNo0CPhXsdx37VePWgJ6FNOPWhGtiZ+P6T
 qiteEh/6a4etrS5D3G4KyOkMQgwC6P3p69OK6/K43DgLfP2rRfinKIIQ6HTg5+1olCc4
 h3GlVyx9PySOUxkP2/AaLO7vizB2EX5YbGs36GjTZyniiA6c34oWnM0njfMDcNCSzc1+
 K+JtnZ0f26fayiOSfK6HT5jEJd0EQ+zqL27ubzwtyLgC7eP4+Z6IVRlSNVETO5ggQnxp
 Sckkaqz25a/Tu6hG+2/XBt2oTjzLq9wnqN+gHSLDBGOcT4WKZcGoP6IU+3/74Xl+tm3o
 iogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415582; x=1793020382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eDwMHwMtxfU7670dkTXkc05qSneY1y9esdOAThnTnig=;
 b=u406SeOL2QLE+tr2sRSN6bNvZoYRRoFezgxC0loFL569imtl+rQElU9NXqov3WBEU8
 Oz9BybewUdFhP43XtZZ1OkSSDhinleUV72re/xVgkZfoLx2Q7d2bOJyEUhyHnddu+xYn
 KgN5zs2mVPD4ObKXA+/4Jwxezf9jR/6zKOFU9GsdBmdLbqyxSnFY5s1F45hDbPckkzk2
 E/Ddx1nkIU0JrbLU/T0alrOFb+zHBdF6zTOdb/FQ58U9VZgbbzE+eDcfH0L4vWDpMIsM
 0z0TI+x31aKNoVdWSJLzwpldum52L1GkXFvcbMVT4q3zAk4W0fuUuSwRwsNoB/QQr9pv
 4Iiw==
X-Gm-Message-State: AFq9FYIwhD+Vcb5PFqgTu7aZf8vDeDrrevVo8ZQBBEWQWxi5UNpdBGeC
 4GPqrIGbCQhLnRiO+KDZlvXU5u7lBEwVy5IlwGUMeEdVorITIHIAcm8i39SOODeAghG0KbmMZ69
 p/2GM/nrZRefXZZA7MihJ1EJQhKolHlyOwmyeBY733tjYSLvSjBqeWjBVTHgIn5sFsE9EohM=
X-Gm-Gg: AYBFou1yNtYioGzPG1uITxzvVpZtIUQCND2el2LHRcU6WATbJowLxk/o0ndTKipY0MY
 8snZ/XiQdKw4Hsl3ywJcjCq57LpaT8bifaUIhBzLY+KJIhTukceBfvyL2XXW5xRdWMicgC+Q+kd
 IzM3W/4lHgOzwyOSXnYXR6nlIELq9b122EJbhC1VB5X7ZBfO9ohS1CniolHq6jCBUr+iS52mO9q
 KvVrGasrq0G/r5aiHb1LtzybPls41Mf626fMPODaePQtUgab5EB+2qpSfx/2VpAPLhIkp2bJxF1
 YjPzCHeadW+RKCxx4HMz/vFaKSa47eh2DXE9MkQy7W4OrPiazQObB7w8a1J4yPj+qvioFynUy48
 ROIfDZuEqRa4PSXhxOj7dKJhkrMhg+/ZWd9A72YoQe+Mb5ZoYWhVwvexLOJbkEi0kNXQv7pPxQr
 d7vEE0VWgGdeJo
X-Received: by 2002:a05:620a:294e:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-93f29d6f5e7mr1318407085a.49.1792415582328; 
 Mon, 19 Oct 2026 06:13:02 -0700 (PDT)
X-Received: by 2002:a05:620a:294e:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-93f29d6f5e7mr1318401185a.49.1792415581801; 
 Mon, 19 Oct 2026 06:13:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:13:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:34 +0300
Subject: [PATCH v7 8/9] drm: writeback: clean up writeback connectors in
 drm_connector_cleanup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-8-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4699;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XIP/W4rAxpK5vpYkJfeZbQxyOrOhM2dyK9i2qunQ0s4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9Y1cbfyTNnTMQvkTP5+DzPePCWhUPPFnw139H9YSy25t
 Odfr7dXJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmwq/JwbBcvdbkZvTKx3sT
 jNlZN8m5+Xb8V37IzxtokZVnuVz3Re8js82BbdK2rlGdDqo33PgcWV+X8Z9yPTelWqn98cFKCdV
 FTv57/ylnHpByb5dd06byt0nVeHoiR3Gw8OYL/V+yO23/3on/Un9j2WebXKWX55pZakIkZ6z8N2
 trTSYH6xvWyEDRorqlSzfqMK+R07y3K17C7FGW4rUMtxD1J8fMZ1qpbtJILLl6o+f9NdZ3F1X23
 +7v8C5ZEXTh0s9ySeYHOu2KF+r7fx80qk7QK4kXqvR7meo89UvNb8XStXL5qtLlb725ekq2nPHO
 rb678bAN30GLmEILwdQtQU+ZcxOTOX7bBATNYvacswsA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: cTzowfgrKoznifxWeWBxcg3q7roOqdy3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX/IjihIOskK/5
 YscYOgWCOrRYw8qop+1welfTAPy6WCq5xeOtDoeAa9yMgen6f10fkNK8I3p9f+C6ksC1DZJy4C/
 5jE41G075XDxPBf3J//j5WjkEo94UpM=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad6175f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=yH-GMt59n7S85gEv9-QA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: cTzowfgrKoznifxWeWBxcg3q7roOqdy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX/wpE8icjxp1g
 yASsHXxOZrN82CYkJwAan00fYkLoEl3cIeXHOxBM/7DHJSNPIa3oOATCTtPTrjVvjf1vl+3dSHd
 hq0lGtPIKKdtuAxnWTi6MawtuBz4z4Fc/2WX+ynVDJOCchXiYtUf8xRCQaCnJEpdvwa3FbkSEtw
 UZdE6WT7e905asLwloK1SIc7LSckSAyxy3qZuOpqHS1K3VWAHceSIO2a5DMJtwMp46jLgLFJA2g
 DInBqWNWJJeS8ny668Cb1SWQX6RHkmDbmvSAxLvq33kbGC+iNSIYArgPg6mA+0OCIrwrx4AYuYH
 mtZan4BZ5iFKNiD2zGTkv5K1GQJk9MbIkGZ8Fnp+/A4ickEsy3TyN4B9LqsDptPjD/jwLP6St0c
 66MAqimjgLkwGiyKtm7hVJc3VP3LJv+qDLB3we6VTe+lyNQPxQE44KCrN84H01DXgydjdM4Djpe
 I0+/Nz/A2NrnvusdXnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Only drmm_writeback_connector_init() registers
drm_writeback_connector_cleanup(). Connectors set up with
drm_writeback_connector_init() (amdgpu, komeda, malidp, rcar-du, vc4)
never drop the formats blob or free the jobs still on the queue, leaking
them together with their framebuffer and fence references.

Call drm_writeback_connector_cleanup() from drm_connector_cleanup() for
writeback connectors, the same way the HDMI audio and SCDC state is torn
down there, so it runs for both kinds of initialization. The drmm action
now just wraps it. Clearing the blob pointer makes the second invocation
a no-op and also covers drm_connector_cleanup() being called after a
failed __drm_writeback_connector_init().

Fixes: 935774cd71fe ("drm: Add writeback connector type")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_connector.c     |  3 +++
 drivers/gpu/drm/drm_crtc_internal.h |  3 +++
 drivers/gpu/drm/drm_writeback.c     | 30 +++++++++++++++++++++++-------
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e489..1c2bef5e0636 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -929,6 +929,9 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	if (connector->hdmi.scdc_work_initialized)
 		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		drm_writeback_connector_cleanup(connector);
+
 	platform_device_unregister(connector->hdmi_audio.codec_pdev);
 
 	if (connector->privacy_screen) {
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 3492787c3697..f60216adcd31 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -329,4 +329,7 @@ static inline void drm_panic_unregister(struct drm_device *dev) {}
 static inline void drm_panic_init(void) {}
 #endif
 
+/* drm_writeback.c */
+void drm_writeback_connector_cleanup(struct drm_connector *connector);
+
 #endif /* __DRM_CRTC_INTERNAL_H__ */
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 2f6a7b50336c..272012a70efe 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -21,6 +21,8 @@
 #include <drm/drm_property.h>
 #include <drm/drm_writeback.h>
 
+#include "drm_crtc_internal.h"
+
 /**
  * DOC: overview
  *
@@ -271,21 +273,27 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
- * @dev: DRM device
- * @data: Pointer to the writeback connector to clean up
+ * @connector: Writeback connector to clean up
  *
  * This will decrement the reference counter of blobs. It will also clean the
  * remaining jobs in this writeback connector. Caution: This helper will not
  * clean up the attached encoder and the drm_connector.
+ *
+ * Called from drm_connector_cleanup() for all writeback connectors.
  */
-static void drm_writeback_connector_cleanup(struct drm_device *dev,
-					    void *data)
+void drm_writeback_connector_cleanup(struct drm_connector *connector)
 {
-	unsigned long flags;
+	struct drm_writeback_connector *wb_connector =
+		drm_connector_to_writeback(connector);
 	struct drm_writeback_job *pos, *n;
-	struct drm_writeback_connector *wb_connector = data;
+	unsigned long flags;
+
+	/* __drm_writeback_connector_init() has failed */
+	if (!wb_connector->pixel_formats_blob_ptr)
+		return;
 
 	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
+	wb_connector->pixel_formats_blob_ptr = NULL;
 
 	spin_lock_irqsave(&wb_connector->job_lock, flags);
 	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
@@ -295,6 +303,14 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
 }
 
+static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
+						   void *data)
+{
+	struct drm_writeback_connector *wb_connector = data;
+
+	drm_writeback_connector_cleanup(&wb_connector->base);
+}
+
 /**
  * drmm_writeback_connector_init - Initialize a writeback connector
  *
@@ -333,7 +349,7 @@ int drmm_writeback_connector_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup,
+	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup_action,
 				       wb_connector);
 	if (ret)
 		return ret;

-- 
2.47.3

