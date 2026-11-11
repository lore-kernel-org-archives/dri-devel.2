Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A460A3836
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FwDiu2/w;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kwEm3kxa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BBB10F84D;
	Wed, 11 Nov 2026 00:43:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CBE10F83D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB0FFjI725898
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mc0502QjSovnWK7vfGY36WFYd9ZgYYG4f75fpMR8ddg=; b=FwDiu2/wIVg5+sN5
 ZHhT095rML6/GoXvNZHhQtkyei7HR2++AGRgzcfwdDu5sXzLZAygaaU/xOaH1spL
 SeRTgViAuXfFjw8y61FITPw8sLT2XfwdXxmhKpT+OL8E/GuI259pwlNXGAbF5eGD
 rpP6/1P1++NM0pQcJg4edY+W4rYZsEPGn/clSNhhC8B0iqMl4yINrMh+HCrb091v
 15ChKUGj7ewC9C2HWTfjEcO/sDrzSNLYoNaapZEpXulcJjwI1sivXzRVnLYBfE/M
 3B5vP6aNDVYZJjyObGTfU1L3n3IKwl5qeVY9uY5Q9VbbpUhtHVySB6kP6EmuhfTC
 Ikfj5Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnm82kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91eb556c8a0so52566466d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357788; x=1794962588;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mc0502QjSovnWK7vfGY36WFYd9ZgYYG4f75fpMR8ddg=;
 b=kwEm3kxaVvGGQvQ7d1x48CJCJZlFRhE+QHVZPrq0UdlWT2v2kVkUBkX22GRAYLzJzi
 mQ6yoySS+h2t8CIeVfT/nKBGTsxdV1vYKBJ3jT4nlIYidJ5mE/2R1xftuJOMayotB8Mi
 9EBad7y2a5ymJDgX2o+2SAbklpeLGIRKaIXS0+rNDr/pPwzyY0BrB+ybIyO8xT0Ob2Fo
 4BxxHJvX6y93SkOb837hd5zwe84MWsaA3ye8LqucEbkSVu/POgmvM8PA2MQvy/uwf35/
 jN5LJFAS2UupqPd5rg0cgABqlSYTrTZnvQWXj1B7gZ8mH/vs9XLsvaRS0bXazY0BmccT
 /XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357788; x=1794962588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mc0502QjSovnWK7vfGY36WFYd9ZgYYG4f75fpMR8ddg=;
 b=P/OuxnKkK6gBwAIBL7L1Fpul0HDtg+2o5C6r7OQA2Y55q7uj6+z7DtPO9fI8U1mfCP
 GsR2yVmyH4kwO7tEKvrUu6OjPa4ypXxZ3iHpQ5g80iNNRXU+ZvYCPjssBud+zb2SsUPI
 oaOSRHiDvXVNLg6BgA1h0Eb+r0VOYglapnOVfHuCpAhKf2XdjQHU4AG/kyb7vKcVbpmc
 f4zXNB2MzVNjDjXo08gRJ3FQCJ6Q2TzVZVRmm0fP391g5KHB3rePml97FEaxLd5hRCG4
 618c9ZikPKk2LrQi7gSbSM96Y6m3y8c/rGnwD3f6ricpwn3Oavmt9wkdPn18cdpznRii
 HeXA==
X-Gm-Message-State: APuU4Z+xp1WnVh/Y8gyGV/cDYlFNPZHnrFEBFYgGazUEnJQxXSvfEg/l
 4Le5aaS/b4EIzFW/pyLx3/MLJUl7TjDo5lzyA90zJBLLPG6UWV190Oxw6RHitphSPeoC470VP1R
 +jcFpaP5lSzFZxVXR3/ks7h/2ruPtIDCf9qe8dw4mPxbmr35vtub675aloSjUwjxUoexSDb8=
X-Gm-Gg: AYBFou1rngWIfDbJuQlgWuGl4rpke4p/K0Ycuod0KoFqrJl2dAXaWeQJrbQvYT+jtpB
 us6ZeKAgSZhN+PhUFVOS7oW4Zyd3T6Z96hKV5+GZ3Kbo/KIwdnTb++M+OtpxHzWtIZFVBfCz6pY
 cP37VZxLFBiQ2LXeI1of5P2wOoe704PtbwmQBm+97Biru0w91Z6Et5DZ17HQQsDNP94kmz/C3rv
 pg7/w2kcoQWh6E7B7Y0xr2Tt1Gf9YVclugzGY2fvOmrvDLOUhpDQuPd7vnKTd88XCiEvWgRA4w3
 UqNttPm7MI4+pz1lO3+f+WVn4vhzuMWPyR+E4ljUxMDL5PKt50mrZcXIZh5uB4w+wqThCnBpxvI
 7WDGz/X2Zt6FoFNCG+xMprgDtYipHw08zy0ICMHKEtC5GVVXq65xEnvcHip0DJF0bcG2+pQZClH
 oFi1ojalUvE3dO1dFfSw/BxWv157NWqms70+eV03XlPjT3zZVL5PfZ1RwQJzsckg==
X-Received: by 2002:a05:6214:5f01:b0:91c:75ef:5532 with SMTP id
 6a1803df08f44-91f040c0662mr15962976d6.39.1794357788309; 
 Tue, 10 Nov 2026 16:43:08 -0800 (PST)
X-Received: by 2002:a05:6214:5f01:b0:91c:75ef:5532 with SMTP id
 6a1803df08f44-91f040c0662mr15962546d6.39.1794357787587; 
 Tue, 10 Nov 2026 16:43:07 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:06 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:30 +0200
Subject: [PATCH v8 01/10] drm/amd/display: embed the writeback encoder in
 amdgpu_dm_wb_connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-1-62948ed87d13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6169;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hK2qPY9AT21budCgsaXkgZkIMdXALboBP7lCjCRQJmI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oDKYH3jNhUDLRZlLVx61WMVdAo+SJbh0qes
 1TtBYuzV7uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6AwAKCRCLPIo+Aiko
 1WDFCACi4kHBwkk3TsZD6c2vsanacmFNZzYYNpYYP/z3Txpuw8+HfYz7XtP2ofaV9QjCs44w0tK
 GMpfFO34XwYny0M5QYuRdDTTCzvtHhLFuKLSbh9HMbSNhg4oSXj8eefowqj3pjqTgMygxlu3ADV
 OdYyGNKhidlZwYPpDzeQ6vQpRGuIe4Idi5zSp4X7Qbw9rGqlmhhY2GiRR2OGfzfHfrOj8RElScP
 QB+uKf2B/qo2G0magfZMeCaUJDEZylYsE61a/aVYW6h31G5BwHDBXi1u+t+h5Dirgbk5g5gcKdm
 IOXCQ+Exht3fG0gGhgEy0xCO/vyZFwwKX52KiiEzmR+JP1Hw
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: dvWRgXgAZrZI0POCZ7l3qcxbOGEBPonv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX6iAuolNlAIxZ
 NDIKUQTRq1FtZ5p2v7CLqAkAHC3YeupSzglijN00TrGS3kv28XPiZco7zXON/qCx46+qklf1u8m
 NfcO5W62fE6oz4zsZtAvBdryPKuwMtg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX0FmFu+QKBkyd
 j/+KEJsUyQvYkSIj5hdDPtWFxsSugEzj/OgedbOAa1ylc4ToKKrvDcesccDNvwJc3+S61xw0kmW
 WzYn0wnZkgs1a7F6aognqsmeSlatDV+6KLe2bZeGbGgcbhnvH1M/YAGFb3ADz8o9JCcPcvozA3u
 udZ1Ej2CAM8oStDTx179PWy/9vKKqt00G2VmXtRkosD27yIC9iOa1VOzZDhDvEIp/ODo5Bh0wy9
 AjBvotl4QVzMb3VOC+x26kWyXMt3S9fcXTGQE+2+/xcWpEfcrLFhfvYfOZyxhTYtkFv08zODJIW
 nReSUhpicxpUHhkKoZ1e3xotGkwrNvzD6VtSxm7VknoTCJ54GdPvSXq8SznCN3u2vZdjjkMYViR
 dtTP9UAJlqFGFmPv2OZGUHjS0O9hQGYxVEQ0Yb0wllEQBE0HT0xYADwpbUOo6YrFPJ0M1VOINoa
 7wDiLf7xkEBaAOySVXA==
X-Proofpoint-GUID: dvWRgXgAZrZI0POCZ7l3qcxbOGEBPonv
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af3ba1d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=_MfM8nSJvC0osUG94L8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
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

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 29 ++++++++++++++++------
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  4 +--
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |  4 +--
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ea45ab12119..77788a2289fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4812,7 +4812,7 @@ dm_set_writeback(struct amdgpu_display_manager *dm,
 		goto cleanup;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(to_amdgpu_dm_wb_connector(wb_conn)->encoder.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		goto cleanup;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1b91fe4c3171..111bb110c439 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -935,6 +935,7 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
 
 struct amdgpu_dm_wb_connector {
 	struct drm_writeback_connector base;
+	struct drm_encoder encoder;
 	struct dc_link *link;
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 39b7b3e49f6b..e0ef23f692d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -218,6 +218,10 @@ STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *c
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_cleanup_job);
 
+static const struct drm_encoder_funcs amdgpu_dm_wb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs = {
 	.atomic_check = amdgpu_dm_wb_encoder_atomic_check,
 };
@@ -247,17 +251,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 
 	wbcon->link = link;
 
-	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
-
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
-					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
-					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+	drm_encoder_helper_add(&wbcon->encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+	wbcon->encoder.possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
+	res = drm_encoder_init(&dm->adev->ddev, &wbcon->encoder,
+			       &amdgpu_dm_wb_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (res)
 		return res;
+
+	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
+
+	res = drm_writeback_connector_init_with_encoder(&dm->adev->ddev, &wbcon->base,
+							&wbcon->encoder,
+							&amdgpu_dm_wb_connector_funcs,
+							amdgpu_dm_wb_formats,
+							ARRAY_SIZE(amdgpu_dm_wb_formats));
+	if (res) {
+		drm_encoder_cleanup(&wbcon->encoder);
+		return res;
+	}
 	/*
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index e77e6fa18a72..e15db8c41662 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -4567,7 +4567,7 @@ static void dm_test_clear_writeback_removes_stream(struct kunit *test)
 static void dm_test_set_writeback_no_pipe(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct drm_writeback_connector *wb_conn;
+	struct amdgpu_dm_wb_connector *wb_conn;
 	struct drm_connector_state *conn_state;
 	struct drm_writeback_job *job;
 	struct amdgpu_framebuffer *afb;
@@ -4597,7 +4597,7 @@ static void dm_test_set_writeback_no_pipe(struct kunit *test)
 	conn_state->writeback_job = job;
 	crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
 
-	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base, conn_state);
+	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base.base, conn_state);
 
 	KUNIT_EXPECT_NULL(test, acrtc->wb_conn);
 	KUNIT_EXPECT_FALSE(test, acrtc->wb_pending);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index b54624385e48..8359ef046c9c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -510,8 +510,8 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, wbcon->base.base.funcs != NULL);
 	KUNIT_EXPECT_TRUE(test, wbcon->base.base.helper_private != NULL);
 	KUNIT_EXPECT_TRUE(test, wbcon->base.base.state != NULL);
-	KUNIT_EXPECT_TRUE(test, wbcon->base.encoder.funcs != NULL);
-	KUNIT_EXPECT_EQ(test, wbcon->base.encoder.possible_crtcs, 0x1);
+	KUNIT_EXPECT_NOT_NULL(test, wbcon->encoder.funcs);
+	KUNIT_EXPECT_EQ(test, wbcon->encoder.possible_crtcs, 0x1);
 }
 
 /* Tests for amdgpu_dm_wb_prepare_job / amdgpu_dm_wb_cleanup_job */

-- 
2.47.3

