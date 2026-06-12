Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E0BCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383CF10F63F;
	Fri, 12 Jun 2026 18:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JDjJywkl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NACSwdSw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C38A10F637
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:31 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGUVaN056405
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QBJeYuGqe22P6k7nEfBN02fWJOuRECh3h974+RTUQts=; b=JDjJywkl573Oppgc
 a/m3TBe+6a2JfecT9b3uIzacmtAK1q8qhgZtpoimZPEHqTfkTmpmVogPPmbYys90
 cAwU+ANkYhc6AwLv7Pj3Ahz56Thyb+tH+qBa6uT/nEm32ARE/RlGwuSJ5Pdoa2ts
 P63Xf2JKBP6W12t4s6guCx1pTC0JZMeRAXjiw3M6Q6l5l8XPzmrA7p++0Qnjs/LO
 bvfOVyOu21xR7Avbo3pHgk+B/WgXUj8fx6YQy7EoFRZ3BkkfxkZhNgJgXqtfcb0E
 qrn8c7Aot/kKThewvIPHA97mqjq2zdeuZdMglDGJ8eSUA/tqJwHHG418RYVPp8QU
 tp/B8Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er29uv65e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91578c374easo228384285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289030; x=1781893830;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QBJeYuGqe22P6k7nEfBN02fWJOuRECh3h974+RTUQts=;
 b=NACSwdSwBc0mUg5dhzpEbS8wsjrmbMVD2NBgTIzfN14f9hPHGfqis2MufGhJgAdDmW
 GlquRy6OHLSi8v7B8q9Go9/9OZZe8SMtfLhvnwLuSdvOhlWCPpAfCLTUneTF/A9fGJXJ
 jwNzuggJlOYNZQyi+G8h9vmFVaJMPo6nmBUxzwPWhBjq+SNXkx579F+j0PsY5g8sYeiP
 okJXn5fYE2LChNBFX7W//xMKkJQg9xunI4eEi0FmL/Bty0lx/jxpzG7fKarPEUujx2qW
 0Ap0o1mh0CjUGoy0l4KemzYOX3z/r/nl5u+y/LNV5+Pi+v7k7GwokHgjcWN+mp/zoICg
 n1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289030; x=1781893830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QBJeYuGqe22P6k7nEfBN02fWJOuRECh3h974+RTUQts=;
 b=kuyKg9LwjrtAnhIVVcV1taozxhnCmVMz/5TRZ2oNe4Cg2QvDGx4VmRE8VCd5imqX+o
 rZ/48BGglbbK+H9AvZ+kDqvEusWAU8YhUKa3ZL6YUr19gH7cBnB4gZtPBrvjaD/How0D
 yTO65dJj9mxbakCjQQS+fHODhhDVwt3FlxT4Q8k6yl9Yl8+1KHrcJLoVKtsmCWzon8Ep
 dSxCjmJ4a3thUg3CliVMHvYq4UKXG/QnoJHgxuS/Xo1YpZ0qdgQSJYx+wFjgetmk/uxL
 M+HOBFTyTcO5rqiwCoGCzKq6xFNq7TW2bMxL4AEJGxfikUZvF4xRvqhF+Qs3LUJciAOa
 3aJQ==
X-Gm-Message-State: AOJu0YyKpwc/ttqhQjq3lrw/FevBFyIItCi7aVEQwdRMNCE5TTvYdF6o
 Ewu4iY+DXv9auRi2I/mkQ2QbvufpefM0yGB1aRn2bUNbclr1xuSkd9/EDsxkfVWziM1R1Wzr1vU
 6qirYzJA8ZVCYwWX8Pv2gL9e+hWKuxMXY7nZ5z6p6NcSxOJGL9GwabqYhgZ0WSrwyYko+uUg=
X-Gm-Gg: Acq92OFNSryWIFSiyKMovvYn16WU/1XsNf8j0rJE4pshTB5PQt/+PwF0FNjGfYk0AMu
 9V3gme7ITs7/UycrKHZXMWkF5r8gaxIJjg+jk3GfJryeumge7dNHZLiYrC04qFNBSIyUIz/UOgm
 LNk6QKI6Vu2Ti5MbbtWApjg11PAmsCQ9YYXZu738ltUVezaKjX+Kt145+MR4LBSrfxozAaQfSeA
 Jti8cPW1RlfWvDtWkUuPCTbsoHfCxUL1ycUMrPOBO2ktQHonHRAFE6/SkZP17WQz1CUFNNL48bJ
 6gQNMerumFB5+2fogByGmy6t6lJVtB7nFVAOkoMLN4PEfdjQSFsVg6wW+yXINy2jAgZMgzifEZE
 b8Q+b01WKEiGNxM9a0luwRAviWU9NQsUUU/ZH9MaqLu1oE7YyIaCvIGDafvou+puxBWlHSgDI9o
 CXf5G+McfLo6ryv3wnXmS51sMi4nJS14ar4ic=
X-Received: by 2002:a05:620a:438e:b0:915:2b46:eec0 with SMTP id
 af79cd13be357-917efac52d5mr130400985a.11.1781289029646; 
 Fri, 12 Jun 2026 11:30:29 -0700 (PDT)
X-Received: by 2002:a05:620a:438e:b0:915:2b46:eec0 with SMTP id
 af79cd13be357-917efac52d5mr130391585a.11.1781289029193; 
 Fri, 12 Jun 2026 11:30:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:15 +0300
Subject: [PATCH v6 5/9] drm/mali: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-5-9f3a54f81310@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EekG2aEhKLuUzGk/MefJaYhFv2SLpgTabnBvDlYdrFk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2/CqgW8HuyhGiu6mrDQOaZfrC3PXXYFzVN
 Bdfw2R9NwqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1VKpCACMjzF++leJC1KZCPjZzLnYEoWLvNMfjha1yB3vZJDN+Gqn1YkZEgAJdK8jmV1tS9Rbjn4
 hGjhf1aRkpmRYnFRnV6o8k4JDpOyKwyVh4y/cx6eGcsJRA+wJ0s+JETrf9hdKaZ3b7NUiWYiYKC
 /4Elx9R41ZvK7BLWGrPzY7fn9MR2UmVTSulSrdceb0yoEapLzh1zKSNdtci5eKN3ejmx53WQIY1
 BWz66qjliBJVWDoYBfaYoKgEeAMDmoFgicMjFse8+5/M5vVq1bPshcIOVK0obX01xrE5zNmyZfZ
 UuQEkfMTQdZewSOEO6B0Dv6Knmy+ogKMWnz5CnhkeoTI0/rA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX4c6ugWCZemsu
 Mg/VHW5a2+uXFkLDtvLp0GjQwjka6RtQNUK66L7RHhpdhMeMcRTH9MByHOjq/ks3wJ7N7nuQZzP
 s8TONFsf3tKjF0/jWsrMZqupgnFq9gg=
X-Proofpoint-GUID: A6w4EKot8x1fH7LXvw5Pxed6AbIodZ1z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXxgD3B4/C8kaY
 O4PGzafj2bquRDj4btt23Rm63XJZ6XJmFmvGey8VAtHo5sQFGcpCN7fJvKaUz9IDvJyDw9ppxke
 HdMPIy72dSKkl7ntooIYKibQXnpdV+rTrILJXsuz+8eHrgVgERoSDpgjYO7xaiIVjwMxWQrwXzG
 /yJqUKlH7cm/x1Ew3X6B7Gv2/oh7GM0Qglh7qylyFWKPrL0jZT7YdTmWE3tzko2Lu+Z7hFxaq+Z
 KGRmhgljiqELzXuaA7fKs9sQESipM+lfruj9Z5npwOD0/l/dYcA/hBrjLac8jrqcXMFk1CJnwVA
 Vq27lKElLFz2fNbjy2+MnlJ58ZT6P4S1pDB7zENhyCId4PZkL9elQD3BMsP8cNTxjY4hmdXgpfd
 rfhy8CPR5x1I4ltI/9Xt9UCdQQCBhtbx+xbIjsEAaVdlcRq6JjNC8yvi9rFX4zMqv6korLNGTYU
 8IYtcueu/lsAMjS9FSQ==
X-Authority-Analysis: v=2.4 cv=DppmPm/+ c=1 sm=1 tr=0 ts=6a2c5046 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=rEXDA0v2x0ZtafRnR6sA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: A6w4EKot8x1fH7LXvw5Pxed6AbIodZ1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
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
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f8be65119e3b..cfb7300e3e95 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -84,11 +84,6 @@ malidp_mw_connector_detect(struct drm_connector *connector, bool force)
 	return connector_status_connected;
 }
 
-static void malidp_mw_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-}
-
 static struct drm_connector_state *
 malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 {
@@ -114,7 +109,6 @@ static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = malidp_mw_connector_destroy,
 	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -211,6 +205,7 @@ static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
 int malidp_mw_connector_init(struct drm_device *drm)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
+	struct drm_encoder *encoder;
 	u32 *formats;
 	int ret, n_formats;
 
@@ -224,11 +219,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!formats)
 		return -ENOMEM;
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
-					   &malidp_mw_connector_funcs,
-					   &malidp_mw_encoder_helper_funcs,
-					   formats, n_formats,
-					   1 << drm_crtc_index(&malidp->crtc));
+	encoder = drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_VIRTUAL,
+					   NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &malidp_mw_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
+
+	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
+					    &malidp_mw_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	kfree(formats);
 	if (ret)
 		return ret;

-- 
2.47.3

