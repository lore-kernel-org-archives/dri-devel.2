Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0109BCD3436
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A7510E8E2;
	Tue,  5 May 2026 00:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1dGjabG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y9+aGeUR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC8F10E8CF
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:25:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644FOqZk1346361
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rvUq8Kk9vuSdbxC2mnaQWgVoYwyqvsDFVMNCLtB92nE=; b=b1dGjabGKyCNTbxD
 yLDHiPiPeFvVWtTCkRJYDrg/dp/nU2DyCcAL/+dYSlOjmTsGeufe1sG3LJv4X6KI
 6nFt9RHqTHrleZsnidTesSppQ/GDCRv8SSRtzGAmf4GtMS7jWQjAFAE5r+Cp1tUT
 sA9whihcJKSdWmkvHgm7/CV0GG1bEMNR0W1R7KsZIG1E2hOiz8dYEFob+dDInPzU
 kwVhb0roTk/XPiVKqgvrAkqFgLoZrFRwQEoIFX5MqdvevQ4CuAKOqaSTtSce1L/V
 cdVodcjRpMIBljUL2IuiNzYaYEuW+EcOSK67DMaakYd7jompYkuPW6Q7k+DEuZkQ
 3UPZ8A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2x9r1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:25:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb007bc36so119144031cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940726; x=1778545526;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rvUq8Kk9vuSdbxC2mnaQWgVoYwyqvsDFVMNCLtB92nE=;
 b=Y9+aGeURBhQ2tv76QCxS3uGvMEiQ6BYPi7C5Zr2FTt4KF2CbvBbWkFLEVj8fuVDlSB
 zULZ7XByu3EY1ltNeI+fyJ+dvIprEw3E3i9AwVn98XfjG3dwwVzlhF0xgixEMkiDT+V0
 XzAjXDNg7sHop9Whv0jZdiShOcU4MufZczjJr4CnpKnEFXtZ/+DyMkCzfqEcdAD9kXx0
 HkXJg8Gm+J0uAic+bBdj+8YDw3FceGDNU3DYtfYED1+InovA9SUJRY/ViZiFsCBtE3Em
 FiLVE976ydbjSohdXEatfWAvcN9QdrNxnv+ruiCShAwh/Nv9pl788NDZO0+/g80nrU3n
 2ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940726; x=1778545526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rvUq8Kk9vuSdbxC2mnaQWgVoYwyqvsDFVMNCLtB92nE=;
 b=XztUlA5IITwBBqgbfKsF2ZZSrpiC/FTE47wj08mq8G0Na5HO+Q14A19vl0YlfRpxjE
 4Zhvq6lMoWWJ2zbHcV3tdwycRbQdnmKZ4OGYcWuiiLZ/Xa+Kl3TZjdT4HEWjwHbDBh+2
 7WrzeBq+FwyxS28f303pE/Ki77mv1FmTkR8kijNAxi/dBXA+5y0G/ZpoK4hBKb4P4Ut5
 pUYOVzWw1lNHxIAYfOSZ02p75YQebdnJRqWsnETwGNrWTiV/csijP2rIP6aS6lpEiXuA
 fMTAyH+1VsUWPaJFwkp9vS1muCP9cCKTe/cwNTOLbgqArSaiIWzdiICWTgp6zU/nnM2t
 Rnag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xIndez/MhljFrDz3qZW9Z0hTZAsLl4OL6BxtH8Y45l0Uq1umEW9ApvOS7BvxCzUe1yzFXlbI/HME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yypmda9jrOHPSjzyAWYiRJ074ipuXrO6tQMVucradGm34Q+pLim
 7r1QupvZMUNSUfs2lbMwZ7M76zzcTIh0nfauvF2c7x2/tEjGwKKe+oJANsx62N4fWg5f4FjfPZI
 lgXtPy0ca8UJpi5Vf4uUepLlgMoVrWCmDDc34LV9IrZ6n6cX1j05yCZfH+kfbIbsJ2p/o+yM=
X-Gm-Gg: AeBDietbcGKyAnBZesEWI4FL+eHEqbdE7aa6ZM9eMb0gL8mio9sHoSmFWWLBuJBqJVN
 rZ5lN2IHR0vfk2Zfqp9GKoT6ZuMjKbHud0teUKi+2y5HyMzrCXGFbfu45nIg4MawfV+v3yYri2Q
 T8xjEC7DezRj42Y9awrfet/mQWchemjlAuYgEK40R5ecDSYqmil/dL+8ty4WZzUhukvLfhB7bFe
 gcysFQswfogoERRqRsgX9YrsrbXj8sc8Z9eEC+JcFFHOYXKWkX5V/E3ZuyOZGMAac8tpQ34eh7D
 5qaRB8NyEITA2xjWwZ4tCB1cBVMFS6v+ZV/WFSyh9Ly9QINTnY+fqRM3n6K8BpeqyoZIDLnEBOU
 9HdXpBPFIEGAeoxIXauxDw2wFFJX2Y9JIEvmmE2AG1rQVAApG7rxzuy797DiBXSfW69ZMCcIuAK
 lb7qUWJp+h7/176+Sb6uUZINJZbAhECq2RoOTRT8/h6rCl6Q==
X-Received: by 2002:a05:622a:40d:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-5104bfece5emr172357661cf.45.1777940726043; 
 Mon, 04 May 2026 17:25:26 -0700 (PDT)
X-Received: by 2002:a05:622a:40d:b0:50e:defb:9dca with SMTP id
 d75a77b69052e-5104bfece5emr172357201cf.45.1777940725522; 
 Mon, 04 May 2026 17:25:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:25:00 +0300
Subject: [PATCH v5 3/8] drm/komeda: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-3-42567b7c7af2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3249;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MhO3rZwygKwYvVhbAVjitmlBMP9oPZA7uZa37YA1WtY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+ZPizsaWSG++ua3XqdZxT4V8/nV/ol/R89c0bPvy9Qf3
 lvLEfS6k9GIhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT0eBi/7FXLqU1JluVYXnM
 ek7FCO7OM2kLzANuVBVN6F3g+c0rNvzj/w9/CroPP5Qxya3MiJO1j/S7mKAp8+HIUsWTyzh5PM7
 Z+GdqSh1NLF8v4TN5Uju7/TrRv3eEJzyaeanu8Zdol8sGG03WbTixIs/oTOdK+6SX+iprN62Pm3
 gtZBm3l1SMrpmi3GtBXU51M/M/+XP35866ZvohUE3PJoOtoCfgn0BvkfjByEtO1ct/vDxVsn+7N
 7c7Z2eNjQGTfbv1303fVcMW9m28Vx/F0Pq43vgk14Rcy1MbGhLOKGl9DpNKqjh4YmnPF8l7Rgpf
 WgOr+IwL71fOPSEeeUTI6hmD0KGVmncjd6t53GyrDAEA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f938f7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=gYs8AAvg_5cFonjPjrYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: WoRUQq7LIkdZllFpGqTwuVRAlJRjAGwn
X-Proofpoint-GUID: WoRUQq7LIkdZllFpGqTwuVRAlJRjAGwn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfX3crvKzxkVAYz
 5k9x6+GfZrkixOzhih+Xe9nA/rh52fQUwIXKRTgCkN/XkkTcyJa/BgI1YcumgLjOGIMJHaoqQUX
 QrK91ocahEUqT1pJVOuDU+SSXaa/8sYlDktdn7L6fvEtUuq8IRWVKndQ73gFBZqMFd1CzaEw7rt
 9z1c+eER3/KtIYw50mu16pHnJd/q/l9EZ0f9XvKfx6jhLslp+2zqUpOWUWnitj60j8kkWia7uJU
 24Cia39eXVrfJECnhYqH4kNemxPsA3TCpFMww84b1JJPnUuKnU5wlypW7ALWE+AMhq0QgvNth31
 6Y9Txo+TiwHLhZbO/8SwcW9mGLTMuNLcdbmI1KenpvqoRVgT/EKNDAqvHhISw9F8Kj8ekah+PcI
 Y0EWI6vlcYGvO+mLcLY8h7qIFld/Hzjjv4+OzekWPbw9K/1zc0Gqm3uj59XglOVN7fXqAyx8a/r
 kofwzV/EEj5t4m8he1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
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
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 41cc3e080dc9..bcc53d4015f1 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -5,6 +5,7 @@
  *
  */
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
 
@@ -121,17 +122,10 @@ komeda_wb_connector_fill_modes(struct drm_connector *connector,
 	return 0;
 }
 
-static void komeda_wb_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-	kfree(to_kconn(to_wb_conn(connector)));
-}
-
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.detect			= komeda_wb_connector_detect,
 	.fill_modes		= komeda_wb_connector_fill_modes,
-	.destroy		= komeda_wb_connector_destroy,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
@@ -143,13 +137,15 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	struct komeda_wb_connector *kwb_conn;
 	struct drm_writeback_connector *wb_conn;
 	struct drm_display_info *info;
+	struct drm_encoder *encoder;
+
 	u32 *formats, n_formats = 0;
 	int err;
 
 	if (!kcrtc->master->wb_layer)
 		return 0;
 
-	kwb_conn = kzalloc_obj(*kwb_conn);
+	kwb_conn = drmm_kzalloc(&kms->base, sizeof(*kwb_conn), GFP_KERNEL);
 	if (!kwb_conn)
 		return -ENOMEM;
 
@@ -165,11 +161,19 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
+	encoder = drmm_plain_encoder_alloc(&kms->base, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &komeda_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
+
+	err = drmm_writeback_connector_init(&kms->base, wb_conn,
+					    &komeda_wb_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		kfree(kwb_conn);

-- 
2.47.3

