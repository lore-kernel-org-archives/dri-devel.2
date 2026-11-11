Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5019606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qu85sXKk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7hVNob+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C7510E02E;
	Wed, 11 Nov 2026 00:43:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B910310F862
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKcc81113743
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tYkh+z66tNbAJ8FVwlggHZ2adHY5L3co1eCKtyvHahg=; b=Qu85sXKkU9xLdMSG
 0GdQTJjN/yjDowV2Yq2N76Fxh1YoihQsvJ/NRt+FRmlw2PvQv2FJTUY1FZ4hXq+K
 Wmq7XofYgmHzeA4hqPpyK127tENK4iIGI/wDTZsAJFk27BWTC65ehkEilO8bGuSy
 SkLoFNZS4QmULEvNZ1NNRpX0sRQtL9ojDC2cQua+/WqjelIw0KwPVjjR7hbP+BuJ
 +6UBzfqtPb4iGmOAJe6SDuNMJOXNEjeOY6y4Is+ST9rPIGkHHPA1t0lXIlKZbMH3
 SGm86B7aTK3Gc4A77iV+JtlpCThVTpVJaFEcGB28W90CUBSvgvCEL/2s1Mtj/ZWG
 PWg9hw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97c954s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:13 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91edde88d16so35771396d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357792; x=1794962592;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYkh+z66tNbAJ8FVwlggHZ2adHY5L3co1eCKtyvHahg=;
 b=f7hVNob+E5PvDh6T0HVae4kqzFn6cZQgRqWkl54jkSdp1vJWWyFP/CWL8Sj5qmx5R8
 71QwrYmqjBHJE2XVXVzmxCdiaVCfjunrg0Xz8l0DcfNPFLrK6lq2dEscAJwZx1V7Acue
 azTE01bKy+H2c064KfTBs5EwpHa1ZZvhJmIFrvBcwOUYIdBSQCoGfTrQYPery9NImyJR
 tVHsRWZGHVr7WzrbYp5Sj7GFm1YBog9dncuTjAQJ9z2Vd5H4kytczlulTOkNmzdjVlwF
 xMnpYLg5DyC8S4wIzrEYtl/ksS51ssk6OSIZWBi/i0hWWt5hKbvIdfnKRxi+JGfob9eP
 arng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357792; x=1794962592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tYkh+z66tNbAJ8FVwlggHZ2adHY5L3co1eCKtyvHahg=;
 b=GP7vS31/hPQAOwNilpUaJ/bkX6wfExpDAvYotf63z4mXUQE7K7HMRXjL4Uh36mkMmj
 ByGYkwiJv6UAlNFfdu892b8qJhVbpHAWQYLN/88Q22tl5p+O4vuQ5HXqCvjO2hFZFftc
 xxDqZm4ByBsx5uUEmbHK99x9m/yKS5WUszjacDD5eBwczNg6OsDk4xBI5ojA6ZnkDvix
 2a/iVam3H+YlJXai/SKhXC9nUnL/uTRc2IGj4YXHBwJSiwNcYbWXAukQVDOBDD49eKxm
 uhkmWSgv2omMCJZiVUGK9Q80LXrHgy4OhaVsk0pRBt5nKAY8juVdVOoXCtyvJqkA8N99
 XuNw==
X-Gm-Message-State: APuU4Z/ae2/VzezQwgmy6CQJVxiwn2kn6PJlLXsD1ZBsd8XCmS9PHLfN
 cK6V7xpW5eVweFK/IX1nWjTqs0Iy4Hcc+d6ueT/Th4PlsHKMYL0Rbm4zTAFp9xUtXiybSPTJ92N
 XhQA2N2V+Xf/69s57wTKQQLQZt/22qhlyae1/HYVY0PhSBN7/hCx1N+viMrN8kRZKPOmC3og=
X-Gm-Gg: AYBFou1U5Osutfp3j1tqccoFlJR6omAtOaW4KW1FpASJBYxsPdZM7qjPcKRxD0JH392
 jnBZ3OeZaKCxWV7GDmDFQvjr3maaBj/K+1eaPslFMOURoEKDIyqidCLcbQl5uv/eWtWp3vrEy+V
 /vst266E0dJtIVAUq9PDdzLNTSaf1EHMhnC3HE9xGJVhueZfFG9K8cOYC1yO+fowy7yynhYJHGI
 zGa9UchqgyaXsXvlAusIjeMYVTE3528MU4CxF4Ghp0lLMpOXbc/AerORQoag2Yi4175ijm9gKuR
 0A6GGkR2BgU8YS+Y7xXB1Jr0h1IYYZ6W4a+Se50HSKd+kXbK1V9Ws+GWcbUuKRHRJajv6rn5wG9
 elZkARVUN5VgELtZ22Mlo8wYatxZZRDe0aqB0Iel8BbuP7aKo6m9L4pCuqYzCpDMS1jbdWbf78H
 N2YSVJ6aSov5MxzkhBWI+nM1dKFqJPhX4e9RkXhtaTABVl5TkbVj+OLPAQbgA8jw==
X-Received: by 2002:a05:6214:6591:20b0:91f:2f6:75f7 with SMTP id
 6a1803df08f44-91f0402b509mr12798266d6.19.1794357792033; 
 Tue, 10 Nov 2026 16:43:12 -0800 (PST)
X-Received: by 2002:a05:6214:6591:20b0:91f:2f6:75f7 with SMTP id
 6a1803df08f44-91f0402b509mr12798036d6.19.1794357791417; 
 Tue, 10 Nov 2026 16:43:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:32 +0200
Subject: [PATCH v8 03/10] drm/mali: embed the writeback encoder in malidp_drm
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-3-62948ed87d13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=E8fyyRc1CUF7FSoEm8fh0yWXyrNQOVyyvWVqx7oX1Go=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oHuW8SCWzKcZcT8xTfb4OdrADN2PwQ4aNlT
 eNqGbQohZuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6BwAKCRCLPIo+Aiko
 1XVWB/95Fm8C0b3IbmcoRzt1brzZIQcMhBStgGGk9rF0UfIzfwbnxXo3Ho/Yv5anFOpvp7ghDDc
 /XveR5mbKD0lhwGgC+HdhlLQm0szbOY/secPillX0Ya8j9UOFdreJYhv7XpOozMI2DufOWFJbm8
 YYlFT5m8kHwLcqqoBbRkwuQ0iUQK2AHCZkeAtYKtYIL8s9tmZhbTxCwL/60XBSKXodgn0aNV4Ry
 Yk3QyHvm81b5nC4GYAVxQpaHreE7EEcN9diCiZT2aMiO/j2Hm/ZKP79hLIxwQGO9K8FudG9rssf
 pjHrio9g4ZJylmbr8GjnA72h1BOQIfq4Ep/mo2qkpM9/reXs
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX1ONxfZV2atFN
 e+A+AYESTn5pTUHlx0JMd0rdXJBKRK7xzRWiGy5sCOqiXSOqu1EST1k87tT5egN2d9/8cv9T8Iz
 uKQJhf2X4tYgWQl8cr4BeIQuatht0ScLzsv959n84DgSzMt8PLfyblRuHLvk6n2xPUe/k0gn/ZY
 Y6Vrvw3qmMQxw3y47QrQ707K0UXGOOcoQp0va1jtUE5X4FdDKUXVy6Nh/u0IbDGmUAn4CMF82E/
 9MLcCg0m19Ssqnf2iz7HBdDferShYtFct7IsJ9HFUSDtTct9lhwnMEmyGMm3OX6gbQszhDhN92Z
 PgUZ7T+b5LQ8LB2RSRGaDwWyHzO+Pnw26kalCQDImk3U0x4Ax0wHUzxaQSoD/tcETx7/Yspx49q
 mzTHkjIUKr15Hpfosi21a5ZXwgnQriB4hVRdTMb9bfQ6K8RgaDkoxmwOUWE1HQshApTySbxegPZ
 +5RdE+izYMiQIc5tj+A==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af3ba21 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=eAXNdYJVcktrDQ6TNNUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: W3cRc_UWFxtdwf6Dsolt9H0KTy4FWE5L
X-Proofpoint-ORIG-GUID: W3cRc_UWFxtdwf6Dsolt9H0KTy4FWE5L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX2Ex5yFC8/x++
 E441DhvqEfuzNwanUnnW7JeuclAd+a3vQp4slWPsKGrgBKgqNIY5gh162HtxaFWyT4GB958brQh
 jaNXnKLX0WIP2+z8+FbzY97yRbkecq4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
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
index 8d1e1e3a6deb..889d0d1db85d 100644
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
 	.atomic_create_state = malidp_mw_connector_create_state,
 	.detect = malidp_mw_connector_detect,
@@ -223,14 +227,27 @@ int malidp_mw_connector_init(struct drm_device *drm)
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

