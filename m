Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE625CCF2DE
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5E610ED16;
	Mon, 19 Oct 2026 13:13:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377FC10E5B2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8YiBw2688732
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qnQs2qSt8cC/wqbL3vnbFklmJgszfebQtqNB+FXPcw8=; b=BsbDlBmjlguLUMMa
 tQBrFin2yVFc6rFvxHU/4OYX7vcwxU6i4szUBfbLxUoeI4QnHUS9c+lsozdkbMPr
 Cp04AUrmejpwfTOM1zZOYGuwaG28cqXcmeOsDNXPf9tFUDNoGaltM2dGlTMoIlSV
 AP8VW4hNIwmF5E4SUUSytJAf3CNASzw+Cq5Z9kLH0ktzmJZkHU1EmKIhXUA4ZJGW
 4igAoihNFOF19SRm5uRNnOvZ1xpfZmMiK/wC3zQGFenNleleFgZ0r2zTuHX1yXIU
 EwyGTPWsU0tOIYk0NO5OxaL9mXs9DjXnjKoRcit7wTdGonRp97KRFpXWV7i6YFKm
 5LS/Iw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn11gb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2373e9b4so221420285a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415570; x=1793020370;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qnQs2qSt8cC/wqbL3vnbFklmJgszfebQtqNB+FXPcw8=;
 b=AxlQYAabaztY+0Yh1bzDn+NRu6lrbgDyAwFbojEDt95LUYoaqrDSdsOx93t3G8Zm0d
 wEnaElxHuAoJ60x8LebcVC6CWUytj5ZBzE0pZyJ0jyIu6DTk84vWQYQYaHVjx/rRaMyd
 pfmMzu38n2oAnZ64WtX5me9jyucx5Paswk60OA/H5gs8CIFfC7h4XngdC1XByf30Hg6D
 Jyq5R1ht8qk0tGMkC/5S0ZixHyHd9yZRPtAwdva92R/CK9BoRoKBgds1egWPxjDHCswK
 aD9flAKiIAE6VjN4wdKj2QOIVs/y4TEhWLaGSbafbVj9IE//kwRzL+8tDuHlxrtd0Axf
 9HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415570; x=1793020370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qnQs2qSt8cC/wqbL3vnbFklmJgszfebQtqNB+FXPcw8=;
 b=Oi4D2S5JdS33lc1o4cLqwbYt56OAVvdJeW9+sDG+DqN+oglICDV3B+a5kx+CedHwnj
 JFdGtUmDgier1x34grhcleNODvJIWKiwJBsmyjrepT0j+KW1A2e+OF8Uc6YT6+WcMkQr
 FdR/52bxrv4R1KY5qyqK3tYLjdzYwzygtVMWdaTVytNJXh7qJ3iQnNtGxsQxRg2+4VP1
 f7HZH+cOgtCWx81Lgz2PI7Za5K7z+Y2QF1psPXtu+bH06AxUjgnAcFAs1avDDQDx3Ai+
 RZqMseX1MVYy5Oi2Vq/98u3+uK6jrVWBQhy4/NVxvbcXB2bycn7jBinccjpG8IiSdOxV
 CxnQ==
X-Gm-Message-State: AFq9FYISfIV12VtEQYRhM8CLsB6YK7h11LFN8LxpmgX8VmXxA+b3uBu0
 VAGFhGeYu27TEsK1eF7wJWwqw309qXJV3G6suV2Rqx5m2umZUA8iEJIk34GzHVh5j9tAmYLZzgL
 h+V3OcvGTwOkqMsVkqtusbFnjZLUsjagXjYjCH0R9dzNLa2mQuOC5RY/P3cueBDJVzJiyX2k=
X-Gm-Gg: AYBFou2clCEl8G94EHYyVNtGrmIJFPjl6oqb0MY0NtpAqP6xn3Hr323rGVpokr/fpsJ
 nsp2LENnN89eBWpXYKoKX2mMrKEJ7IBDdl+DPnTwwi2S2H4zdA7+xvAVlCuszWerWYkJhrebVkT
 tuzMcHKojmZ8tI40pjImeybsI4FqUilymeoVQVs90S3QTcI5D9y8hPY9cDqykDTTnRacuL+iLf1
 x9pLw9R4UdfYIaAO+bOpBn+0ONZncmSo0XyONLmYEb3zZr+WUBRx1RJA1RFC0xaZXnpgQ9VrZcV
 JjdPovz+oeJlpRGE+nqPO4vodT+xtf/ylixatSjDLZaKH+c/ScBK6s+Yfq4Uvw9VM/kVNE3hpT0
 XkMiu5eNEYygedSns7+AHEcmsi662aAnwGtE3oy5YyDc1EG2RkDzYbzn4KHuCHlYkukVXt2rPAp
 P0deWyTw0/ss5W
X-Received: by 2002:a05:620a:4547:b0:937:675e:2903 with SMTP id
 af79cd13be357-93f29cc8308mr1353832985a.14.1792415570422; 
 Mon, 19 Oct 2026 06:12:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:937:675e:2903 with SMTP id
 af79cd13be357-93f29cc8308mr1353828385a.14.1792415569919; 
 Mon, 19 Oct 2026 06:12:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:29 +0300
Subject: [PATCH v7 3/9] drm/mali: embed the writeback encoder in malidp_drm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-3-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A0wfyHFOzQwCKryCN1GwVCfzf30IhVdazkuopORoCc4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdEPEImUSMcnrRjUjk7IDgo42ntW9qMBrC7d
 3tG/h41nFOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRAAKCRCLPIo+Aiko
 1YE8CACaMMZouBjtqQ/KT+MNhbDcKLUXSgyW5PxAnAifLGe6PVkV5NDaOR+8BMd8EJX2J/Y+L3b
 0VZq+zV2XcWpHseoIJDke6YAcMSY2Z5NXxRrHwe4jimqwDftI6ubRIxigZCuBLwdzfuIJccjME8
 j9n/Ieln/GBRABTnxDlhuRJbpbalAfqkypE9tYBk4hYwdzfJjsgg01nzJq+dg3PZ8K3W27hTKBS
 m9Xw6LMHnXB2ztge2jNQS2ExqsNymPRWxIH+7qBPVJjc0XDMOII/63KVI9EONPJ+ZL8MkEWwIaP
 JwONLNaQXNg+QKtS9vq7mQAU8Zqtg4L17PHmDlmD2FHosfJi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX+kqWcY8uLhgA
 qOYxzDCr4neu8UB8IqbLq+Is5hFREXV4MLRjty8pEchF9ep5fapABQ7xEqZkTnMLohfcLzjII8Y
 n63gmrY/BGVNc3rZHIVfTdX+jfP9UO8=
X-Proofpoint-GUID: 4xv_4jf1KslrF7JzTw8Wwu04YX4AEKh8
X-Proofpoint-ORIG-GUID: 4xv_4jf1KslrF7JzTw8Wwu04YX4AEKh8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX2iEhWaF4CuQe
 sBQD/yuesq+PNHDniNbFuuhMJjIsB4HA7qGLhfOBucuT9l25PJ8gwbmoSyXfztqUheWxF6KdBkH
 /qDg4iZHEtQRvsTggyBz9mXD5MBB9Fq4XLOx+4K0K7NNGWP26rZMW7+KVRosPZHi3BZ/lsrGt8X
 Yy90G2sqhgZNZYIMJ9cwaiyCqEV/sNcTMIGgbhqHqjRgH1umshFfQmPnrBw2e6/bizFoJX6z+EP
 faVvfm0XHyyAKVmkKqI+2HutoERNYxg+URixJPltRERInIYp5mx9z+MqaKI0bYXzbX/Qeb0sBAw
 VLOzh0iv57aaGzQgSqGQ+vapimWWsf+8ecj+biVU5A8bG0HKxwRKnep3s8gOY7shAyj+UFiSF6R
 1TJva7mGN8gVc318q72ummNxIw4cIIJMKL2cC3XisMuCF4ZJtyt373+AsEWP43COLF35MDSXw9W
 ek2yREp4EnpLklJch9w==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad61753 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=eAXNdYJVcktrDQ6TNNUA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
 drivers/gpu/drm/arm/malidp_drv.h |  1 +
 drivers/gpu/drm/arm/malidp_mw.c  | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index bc0387876dea..64610f2d23e2 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -33,6 +33,7 @@ struct malidp_drm {
 	struct malidp_hw_device *dev;
 	struct drm_crtc crtc;
 	struct drm_writeback_connector mw_connector;
+	struct drm_encoder mw_encoder;
 	wait_queue_head_t wq;
 	struct drm_pending_vblank_event *event;
 	atomic_t config_valid;
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f8be65119e3b..7f5e25adf999 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -110,6 +110,10 @@ malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 	return &mw_state->base;
 }
 
+static const struct drm_encoder_funcs malidp_mw_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
@@ -224,14 +228,27 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!formats)
 		return -ENOMEM;
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
-					   &malidp_mw_connector_funcs,
-					   &malidp_mw_encoder_helper_funcs,
-					   formats, n_formats,
-					   1 << drm_crtc_index(&malidp->crtc));
+	drm_encoder_helper_add(&malidp->mw_encoder,
+			       &malidp_mw_encoder_helper_funcs);
+	malidp->mw_encoder.possible_crtcs = drm_crtc_mask(&malidp->crtc);
+
+	ret = drm_encoder_init(drm, &malidp->mw_encoder,
+			       &malidp_mw_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret) {
+		kfree(formats);
+		return ret;
+	}
+
+	ret = drm_writeback_connector_init_with_encoder(drm, &malidp->mw_connector,
+							&malidp->mw_encoder,
+							&malidp_mw_connector_funcs,
+							formats, n_formats);
 	kfree(formats);
-	if (ret)
+	if (ret) {
+		drm_encoder_cleanup(&malidp->mw_encoder);
 		return ret;
+	}
 
 	return 0;
 }

-- 
2.47.3

