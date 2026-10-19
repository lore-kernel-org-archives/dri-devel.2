Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38315CCF2E6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27FF10ED04;
	Mon, 19 Oct 2026 13:13:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BCE10ECFB
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Ousi3305595
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8uYiD1zR8PWqA+IXJr4jAlo8whu0RLGrHQ1RLoD/ipQ=; b=Mled32G6JjyaBNfj
 AyyWTfqwWr3YUkUoQWm7vVykiG9KY/+2Ot1APmujhff4/bo9wMq62WXhaS0Kk8xn
 4h7xGyC9vZpwUgGVRenliwAREGESf6eb/pMR3ZlfbXC/laP4Nv778VKbDtwo1qDH
 I+vbY6Nuau8q1Ed+qIINX7Gabn6UZ7SgrwDZFv4981sTzFbZGfwaEAJuKj6q9Eru
 dd61cdPdUENiRc4XyD+pGZ/U/Y35VCta8W4sGWEfFynWCiL2YvSQUeigZ33GNPcJ
 YylvuBR3l3DeMQbTqZE+3B3dlwI9+gFjA89/Kdsjo1BwFxTo+eunJb7aflik4q5q
 p0JjIw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47h86w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f33438950so488649785a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415580; x=1793020380;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8uYiD1zR8PWqA+IXJr4jAlo8whu0RLGrHQ1RLoD/ipQ=;
 b=VhmaLAR271d2mkFaIss8rF22UCS4/aEHUM/W4ZRYQWHxT+Pti5WHim20/PPfceoHAn
 EIYMOJpQEU9NvZJ97pHc5aRauLg9p0EV3EYwFhbY0ZpAkvpTLEWwcqC8Ioze7ZyaRg9W
 Gb+18cbAxwN7AJBkxXhg8GToaLJ00bXEIrIdaWjgfbVrN+aUsoO9yX/FKRf7zGjdNN6k
 QoH6PctyazP5Neq9ZHRIgYN7mAFnZfn/npUDcL8F/ohcVAWwbwVX759Q3z3GqYaA4g+p
 iOYNpQxsMUsGMk7tI9Gnbv6tQw96HW2aDSZZM3TC4ehmdpx1aFnTnRxQ2pGmJuJbWskI
 M57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415580; x=1793020380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8uYiD1zR8PWqA+IXJr4jAlo8whu0RLGrHQ1RLoD/ipQ=;
 b=C7BKijwd4A1tghoQKDf5j+1hf9X/maS9mP5NYG/EnXGCwyw9Qn01SuLzuOeNqcLHDu
 MxEd3CQ6Nrn5ikUGAcNeLHgs6XrD+U5YpqVNx+hocw32ANivf8q0RukJ0PDj9dzSduip
 7045SqzVKvPoSVaXwfVCyGr/kfyTsJ+H9fXyvdYliuHZIBBCVdfwnc6xlzo1BbhU+YYF
 dhQMrnjAuF8I/iSO7+WiUvLZjLoVtGilSSKwxDLHLrAJl/jpRfy2Out1YmiLgbShwsWS
 CW2bwCrnxDzPHTvhjVS8aF3uKyVsvwDYKrjZKNrr5f/Ij9N1Lseiz6V2A0OMIGMwT1lG
 S6ig==
X-Gm-Message-State: AFq9FYLSWse1JbgaTVBTE3EYmRHRygJ9kYH81KpiH4w9ZgfzCQo8jDHN
 6WQc0EWDA579PHibGKcgkM/BpXRjc9jg5Z4070X3QEPRA03VIFwfhg2vIgoMd4NgnEjIc/Kb164
 9LbUviUcH8C5ObUqSkNNdPmgGBQ9eU8HMUhkj2Sa2JjRVsAbxpgUddP7Zm7hf+YMK7ImNG0Y=
X-Gm-Gg: AYBFou3YXq97lDf0GpGVf2POVPsLKtpnYDMZ8t33HBCn3ArViQDynWdFaHSqqiB41Zk
 AMmjBl6yPKRPw8wMdxt6CsD24n7W5MZB6DzvtZz3dH2Orj6El+BaX51ulDBngvZBV2AxzHmvnB9
 liNVrMwvClt5eL3TSLkUitzqk0AaysbPadbIM+idgHR+cZPKvEfZNEBSfx3uHxBdU6vUdBGcgBG
 sC+5z/YwzbSSlz3Lzonw8ASyY9RvCer6WmyYGMDSVfaH7gdGiCBSxd7rgTeBUkP4YTEE7H7wkdI
 JAVMO9owijpXLqmV11qDL9RxmPm95TGnlZ7viHJj2BcBNU8M2XhIWdrIeeTxP9I8f0CilaGov7C
 Z0cQEHLYOkom7h/4oOTGd7xTYfW/CGzv7z+FGOPfV3AOmYwyN2/HLkjKM4GMNqDMPh4gWNHsCre
 kQu2ZktAI5S89B
X-Received: by 2002:a05:620a:258d:b0:939:6dea:374d with SMTP id
 af79cd13be357-93f29d813camr1296666085a.49.1792415580342; 
 Mon, 19 Oct 2026 06:13:00 -0700 (PDT)
X-Received: by 2002:a05:620a:258d:b0:939:6dea:374d with SMTP id
 af79cd13be357-93f29d813camr1296657885a.49.1792415579701; 
 Mon, 19 Oct 2026 06:12:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:33 +0300
Subject: [PATCH v7 7/9] drm: writeback: don't destroy the shared writeback
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-7-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3846;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2Zej5O7ExLkwUTDnTxc5Jd78WTqAYj7NBjmMvIp3tPw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdGkXVsaMk0ehYPLXxFiA1cFN/d3bH+A07XC
 lUMPwYZynOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRgAKCRCLPIo+Aiko
 1WRbB/9NUG7CeTReAc0FKzhz0MyBz7QbY4MrFFfNvvhBum3bU9bVXSY5lLvDJOv+eQGrRIEYr0A
 Wht3myxvsT9p4KA7FuHBbypT8dTUkTfqvNAfunta/L0EVopF3LYYYE8sAwOoIoNiRj7QMvg5yHN
 w+IN7FNEg/mvYIsj/jNPTeEZMw7BtIk8Ex2i75SW3kK96lgawPa8tYPyBtldA2HpSrigCiCEmKZ
 P7Of6pFxZ+sjstB3mRZZTSYAsbwrJeXjNgqFxgLC1Fk9rUeFmFZ6peE+SaGrNRaWt9/bXlyskFQ
 3vAbovOYuH1p8/8YJ7ETKN7m/xoesebwhyCz5//xFdYixyUr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: FnJcziVFU75ImaKJmj3p--C80wDErf-q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX5ALzJukWSFqF
 xDn5CSJUvGkDta9jDb6I1WtVLAEOqKrV6kWxDL8jV/cr0Cpy+pLR652nCExCJTbRDJvsxOSEvoC
 DdH75OoDdt9EHU4CFV38RMK/6RDwxvntnaWoSvyWFdt3t4jgQMbj9WiiClrFRVajQlaIcBRDwzg
 8iQY9hTXSN0BbSqOwRq6TCCdGsUdpWiMRg6J2xmOwR/dcGlnXtfziXDvMjcWEBot0deK0XMFnKL
 CcUkzH0N2oem54f/A29EPfwEUHH9JKiHRfb6oYNqlE5Scp3DlDFCWf/j25UOPlKo1l0VA+UYlKc
 XWM7iD4Y3jh2A124B6QoOa0aha9xJqNJvVaQlBWU3bvWWWlXszx2qKur4EKNHubGUvB12Jm1u41
 NIvCgQ9LXK3OehSKTHX1KQEFKEfZFW6+WvFb3cOZHr5i2tfK7VXMv4Eo8SX/rxiFOPIBPBlo/he
 Jb9HFXmQPTfj1Fo5ZoQ==
X-Proofpoint-GUID: FnJcziVFU75ImaKJmj3p--C80wDErf-q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXzC47opPX4pfg
 ujSgGxFno2vLMUJqXMnYw5HB4Hk3BL0py9jsELBBUyYIDuF3WuQEWJy5aW0GY+9HtOKUqFcgJo4
 ZSkcZY5QtceaRp8hfv6AvFIFRFqAxJ0=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad6175d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Brd4iQZBKng0vAjXyHYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

The writeback properties are created once per device and attached to
every writeback connector. Nevertheless, a failing
__drm_writeback_connector_init() destroys all three of them. If an
earlier writeback connector has already been registered (komeda and
rcar-du create one per CRTC), it is left holding stale property
pointers. The drmm cleanup action likewise destroys them as soon as the
first connector goes away.

Leave the properties alone. They are on the device's property list, so
drm_mode_config_cleanup() destroys them together with all other
properties.

Fixes: 2f3f4a73631b ("drm: writeback: Add missing cleanup in case of initialization failure")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 89c36f1414ce..2f6a7b50336c 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -148,22 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
 	return 0;
 }
 
-static void delete_writeback_properties(struct drm_device *dev)
-{
-	if (dev->mode_config.writeback_pixel_formats_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_pixel_formats_property);
-		dev->mode_config.writeback_pixel_formats_property = NULL;
-	}
-	if (dev->mode_config.writeback_out_fence_ptr_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_out_fence_ptr_property);
-		dev->mode_config.writeback_out_fence_ptr_property = NULL;
-	}
-	if (dev->mode_config.writeback_fb_id_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_fb_id_property);
-		dev->mode_config.writeback_fb_id_property = NULL;
-	}
-}
-
 /**
  * __drm_writeback_connector_init - Initialize a writeback connector
  *
@@ -198,20 +182,18 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 	int ret = create_writeback_properties(dev);
 
 	if (ret != 0)
-		goto failed_properties;
+		return ret;
 
 	connector->interlace_allowed = 0;
 
 	ret = drm_connector_attach_encoder(connector, enc);
 	if (ret)
-		goto failed_properties;
+		return ret;
 
 	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
 					formats);
-	if (IS_ERR(blob)) {
-		ret = PTR_ERR(blob);
-		goto failed_properties;
-	}
+	if (IS_ERR(blob))
+		return PTR_ERR(blob);
 
 	INIT_LIST_HEAD(&wb_connector->job_queue);
 	spin_lock_init(&wb_connector->job_lock);
@@ -234,9 +216,6 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 	wb_connector->pixel_formats_blob_ptr = blob;
 
 	return 0;
-failed_properties:
-	delete_writeback_properties(dev);
-	return ret;
 }
 
 /**
@@ -295,8 +274,8 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
  * @dev: DRM device
  * @data: Pointer to the writeback connector to clean up
  *
- * This will decrement the reference counter of blobs and destroy properties. It
- * will also clean the remaining jobs in this writeback connector. Caution: This helper will not
+ * This will decrement the reference counter of blobs. It will also clean the
+ * remaining jobs in this writeback connector. Caution: This helper will not
  * clean up the attached encoder and the drm_connector.
  */
 static void drm_writeback_connector_cleanup(struct drm_device *dev,
@@ -306,7 +285,6 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 	struct drm_writeback_job *pos, *n;
 	struct drm_writeback_connector *wb_connector = data;
 
-	delete_writeback_properties(dev);
 	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
 
 	spin_lock_irqsave(&wb_connector->job_lock, flags);

-- 
2.47.3

