Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5F6FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFD310E8F0;
	Tue,  5 May 2026 00:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Csm5N2rF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCSxezM+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2491A10E8CF
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:25:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644KUff1299451
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sTMi+rpeIeeTxwgAvd6Vb3BN+nfcxX4j3a3avZMj7+E=; b=Csm5N2rF2fRYIJOK
 b4r0Jj8d7YHdLch1vLDOsvt3jArD3z1S7R0u5KKFNK9Ny+pA56wNZL3wBuuTte4i
 WWDtzdH+xFsFmeXQI2IEO0vq0UmlmRN7tcnCq2f0xQ0HwqZfWJepRztKZLXK5ZP+
 1f6WnTShDociysdhStNfbv2vDV2LgQAiQAdCt1PVsjW4M79C/KWjfL8I+a8J8Qn3
 uApVDlEtQ85XvIaeC9e3+RIVUzjy4S8qsdceUgbrQpgrSilaj6HUUBmv+xqAPwRQ
 OY7GGI0CKpC0ICYnqRIWTHn4jUt08IE8ALGTVF9kKF2LcYRofgeYRSI/qkIuCL9v
 h+Ikkg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvnda6ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:25:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d6bf346adso79692531cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940737; x=1778545537;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sTMi+rpeIeeTxwgAvd6Vb3BN+nfcxX4j3a3avZMj7+E=;
 b=ZCSxezM+EbH2WMiYr1GPjX2FoHNn0sVx+0YXxJBS7dPhyWM7Gt/wsY73V2YdLXrUJr
 xX1XibcOOjKp8qFb/FyihT1QQoVcXcukyfHBiLuyE6XURmUwtxw9zt7XKSmVvifSPyna
 JCPuxQk3KHG4MtlrfHcMJQcsWCN9Jvuz8mlPwMs7SgXopYRJQeIROu+ur6dzunPfs/Wj
 3e9v+FyeecqySp7vslYbWQ5BOqHn7djJVsVSPrLaKg3t51wEneSNy8gUn30rKGFUgsae
 LoO6xeGHLUTjt2LaKqbqGoCcLh01Zgr+Zb+H+jsXfagwuvUaf1d16wtJoD26y8ySDnGs
 3R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940737; x=1778545537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sTMi+rpeIeeTxwgAvd6Vb3BN+nfcxX4j3a3avZMj7+E=;
 b=YmBgkapkPj/iRM7T+yhj0K4apnX8l7F4uSADFARJCQlqztcUcZ+8vZFFladI/g6uGz
 nU4+yZhS8KbIDc6bddOUp9Oq/YAIvNAiyOZxbmCA0UU3wvRbRG7V8LZef/DZ7yGSBaUw
 B6mpBJdQfO94FRDTyIa6G4sESluOA6GQkDGBcLUQrPpf6rIHWj2aIhGGs/eUO8KzX+Yz
 RD2fQnrdAo/57B5psra4s7CHS0PacvvEbh3qidE6wYP7TkVGDUKVsV5CracWhMV3vSpY
 tyWp0aKOcZIoUdoooHo2YAPNn0TPQ8qzN8YeWDxYni4VQINrr06WGs/+sMa0gBePpXDw
 K+xQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9y0ZlqHTMPeprP7JMWn1uqugc3lz3a1WLoB2FUbvDVHegFvI0zD47WytJdlShJ52dD1Sqc3q2BuQQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKilerfxa/J9lL47dLOR53p8IShIb9yTZpUpgbDPaBd0on7Jst
 55Pt3YDGxcWbOhOCtwOCPww/xIUBOImTvM0pPCivdp+D42P0RaOi4KaUmh5PqkiMSPZ9VAeXWDh
 OFTWA0iLHXWHus+g9z5YSExfTkQ1bwaITpVaZVA9Oyniinp2T8r9CXd9g1mjwszeLmr7KkWk=
X-Gm-Gg: AeBDietmAfgkZLryEyJJ3q1rTXIX0Nq5SeTqoB+VVOsSoyDeOoDw9xRRq8UJoGdUQLA
 LGGfepiJIS+XmDcFlVaCoGTr+I6yCQuB++nT0zqL2iElTN10IJL9BHlmkmeIBtnGroMOIoF8jkz
 qAbFEY6L/9s0n2WKoxsjFqBasuXUVog8V7FbF2JHUz8va0sYFU+ilGQy1lRpRSkr79exr61TLKp
 R1eR5R+XZnei1XPDE+M/fGSJgg7+VvDZTZaLGj5FdaDob6nhpnAd/Uq8908n/31ydII/h3inMA7
 suvix9SbQBiTfYGedPYPHC8nMkjefs28rDW1u8ZOuQ05T6MB3dbLjO+8OYPIW/vA8muc6G2L7zk
 Qp3ESrOLJlhMKSYD1NrfaXzPFTiypuW/4aJv5dt9ATK1StQWIgB/Lm7a84PWv5X/CLaTld9xOeS
 3P/v8y3d3lR20VFnJHZ/IoIhc42HlWXdDXDLQtiDIIfDT9ug==
X-Received: by 2002:a05:622a:4d49:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-5104bef1a95mr179779341cf.32.1777940736562; 
 Mon, 04 May 2026 17:25:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4d49:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-5104bef1a95mr179778871cf.32.1777940736112; 
 Mon, 04 May 2026 17:25:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:25:02 +0300
Subject: [PATCH v5 5/8] drm: renesas: rcar-du: use
 drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-5-42567b7c7af2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2589;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4Vucpdbps+yQVez32oDVtzt/iw6YyMI2r6E/Wi913Hw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp+TjcsYWHgFL7YdrLbWVw7Uldjtnf9eJreeqel
 uySv3eVNaGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafk43AAKCRCLPIo+Aiko
 1eTACACX9CkVnJY51k1n4kpTPLzSZQIBw8n72ppEnAr7Nx03zRbl3kWkZ2SLmNSxZmBWptrTJkk
 2V34Y+p2v9crcEfzAHIMNeS8VirAvNf7W8vbsCnwcpwVM/tgWGvJ+2h5OUEU+aQf051uVIH3RwU
 Qo0u5M/OmEdDCf6HlPLdzCiX5rVxYfDY2itb9vjZyedZxwEPVVgSi9vdLWIYfQqCDrd6IMT4rwx
 +RoeL8xzHgeqYVMa4DoG+g09ieOLTEZS1A5GIPMSdTmPCbTOWLbecZb6QcJEtEM9EABMaVfMeRL
 2xM6UMzh2Flot0Vun+McCHFK3C3Ydm1IoDmqYPZWr6V08vSn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: cVXrVOWXDYGc51KGhtNPz9klUMFp-Crn
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f93901 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=rEXDA0v2x0ZtafRnR6sA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: cVXrVOWXDYGc51KGhtNPz9klUMFp-Crn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfX9RXJ/7RHHexo
 oiJ5/+n9TZxJKZ/lvASZlxIwMHxAsml3gutN/eDM/OqLjosRIFGqJEhu7NwSj0BI48omvJeYArA
 EvtlKbF2U6IRAOvcmTv/pRYd1NVOidbJEz9dQHgDuTF4lkWblMLlWO2q29t5Z1h9uEB220gQaKj
 Sf/GYTCTAV1uNkU0GleDfonxEBPhrLtwEUKE5jkrnqNPOsHx4jDA8WhqY4a3QKw402dcUhWoUX/
 J9SRrH7hRY7vju2+KdZoWvwIsd7/UB4t89Slfj4Qzymmg7J8tJ8OV5wTDkVjOunyayqkgvYa3rg
 vmvfJr0nDceEct1oTeFhZ0lrJewklrPMEF7/I5FpVhhqCiXnhLn/W4/P2GzENQI33lNYmuy0nG/
 xtF+qzn993ikg+as36fadwzIpPszmCqV+gYJ78Sq/3ne+V+jZTk3gL3VjBLUBQ83MEMEwZEk0aW
 lajGOE8i8qL7jffmEXw==
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
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index e5e6e6a156aa..ecfd4fc1f210 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)
 static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
 	.reset = rcar_du_wb_conn_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
 	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
 };
@@ -201,16 +200,25 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 			   struct rcar_du_crtc *rcrtc)
 {
 	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
 
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
-					    &rcar_du_wb_conn_funcs,
-					    &rcar_du_wb_enc_helper_funcs,
-					    writeback_formats,
-					    ARRAY_SIZE(writeback_formats),
-					    1 << drm_crtc_index(&rcrtc->crtc));
+	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
+					     &rcar_du_wb_conn_funcs,
+					     encoder,
+					     writeback_formats,
+					     ARRAY_SIZE(writeback_formats));
 }
 
 void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,

-- 
2.47.3

