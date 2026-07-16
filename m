Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D38C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6599D10E768;
	Thu, 16 Jul 2026 09:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmdPtyHr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1dxtEEO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A20910E768
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:03:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7DNKE2193263
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9iNA4KkLXptEcrV9SWqVHRxO4EssLZecMFzgSPlpRjI=; b=jmdPtyHrCF2ywVB5
 hrIupyUZanurfxmEAAZZ9jT2a9GiC7DNBF9beXbCihI0oOgPiHl6BO02ffL65YC3
 Ml8DHtUml5SlEAFpiJH/Dtb/oMSdbQmCltUTV0UCcBQzR6i2nSupZUHzgs53gvpf
 0CuwKKNG6m/2oUZwVF1Fxj0qGjRKn+D5sauSFkjNF3N0YaT04xnKd2NO1uwOBkIi
 7jGDbMssRNsnFvcksJU8BVY0/XvgQQMlH4mgG3CboAdbQk/WVYgn+vnXsWdCZfnv
 1lr0LgmPqqPkzSGIBnWZL8F3BCDLwKEn+Jq16zrFVDveUw8Rq0C7x0JhFggTEvZv
 UBiZwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf0fsr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:03:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso43046705ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784192611; x=1784797411;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9iNA4KkLXptEcrV9SWqVHRxO4EssLZecMFzgSPlpRjI=;
 b=L1dxtEEOGs+es25ZJwQRmfFOPR/F08RiOkpbXCY7a86rLd/MifArD57QQuFzOe3WVl
 pHzzEZEoX2OFY/DjsejGXQm81OcNjzD8EOP3Cch5/sSE82Uy/p8nEsTIkbVnkKifEfa3
 4x0J86CgOMIJTm3wMQncDcsV7MRiAEV7PNmgOFUek6FacczseseLDM0cp9XdL5r/Bwgh
 eTryrW7lrgSO0pff0NFFLLab+RtRQe+3PDftX32js9hcA3tZCJBexLaCOW9Egfx1RskK
 ApHvMvThyFKk+hQivudmXS5PQg2A0a9i/wwqj1yhSKAbuSo6criL6YkOW0WxHTuy1OU6
 pNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784192611; x=1784797411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9iNA4KkLXptEcrV9SWqVHRxO4EssLZecMFzgSPlpRjI=;
 b=ILsqpiIL7VYa25uLj/5SNAie74ELHmHHIPozCnwjV6TpdJ0OEbXUVNCDnXiQIdRpPE
 Ajlyq7Mx3X5QTNhHA7NSJ3kWagAkmMdQZYZ3+h6zT8hzYI0UTcJvhVum4JKmPX/H0Vgp
 wuenJjC7x/MNtlYXr9GbJmwRsFtWN1DOYDv4BZB0C8n9kYC6HbCS1ngabI4YMzlMA/CL
 /GjeEL6M7CeWfqofIjzXTZerbPuR6fXnjL/8mIs+zY3qOEdexfsMF3BTQlb26Dv16T6Z
 elqkKuk7nu4IDjama6LUhxZQyVRbDHgtdHMrECQUyYRcoDL0+VkI8YKztF4L3jzZoQeV
 MkBQ==
X-Gm-Message-State: AOJu0YxaLoLhUwUYQT94pqc6wwA3eVZ7hpdkf1zBy1QJTusE8vy5QTnw
 WvY4XjjDzDRGRF+aPjdwVIdYl6uI5f25HOMOIM15GqUSW3Y5VWwLG/YsXKEcpWgidujphxaEa83
 CdDXWMcHPpSNP0Kvy2RVknttXHQrTXqt9Ana6h47tuSPbggzaX7F3+zMI5TV7ERE91JslWZ0=
X-Gm-Gg: AfdE7ck9/usg8IkmBQMBvQvzmma2cjLnE6eLpDAeVgQC+0nbdh/tzYrjTTRoowGgbdd
 TlZsRVEyjsV05yqARhqzB43Era3oRuF1p47B0ASxpUupsQoMU1BIQ60r9GhEEmUtpwe/btftLa4
 dCfH689afqhdEb1hlyvnB7yTOmdEqp4KGuJV8kqxQqHZ2jqpxHxXfzGPjPrXKkjBrUbH6jE9kiL
 Db1GRwOEgMUdjfoBUutswAZqSKvRtdZ6jxX0bpQTZuixWdeTtVKUDtEysVITMFDvZ86wvI+mjiz
 PEIl1cLBkeij7E3aJ82CgiX+7BNkrSueIR+O+YTcuVylYkticNW2d8kHp5ZbU2pJmERwvoWnxUp
 KsBUIIVBrH8rUHbV8M4hK
X-Received: by 2002:a17:902:fda3:b0:2ca:b4b9:4586 with SMTP id
 d9443c01a7336-2ce9e9ada87mr215357785ad.19.1784192610936; 
 Thu, 16 Jul 2026 02:03:30 -0700 (PDT)
X-Received: by 2002:a17:902:fda3:b0:2ca:b4b9:4586 with SMTP id
 d9443c01a7336-2ce9e9ada87mr215357475ad.19.1784192610502; 
 Thu, 16 Jul 2026 02:03:30 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 02:03:30 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:01:58 +0800
Subject: [PATCH v2 6/8] drm/repaper: replace struct drm_simple_display_pipe
 with regular atomic helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-drm-simple-kms-removal-v2-6-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
In-Reply-To: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
To: Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, xen-devel@lists.xenproject.org,
 Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192560; l=7829;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=ERhc4h2BzyHq4SLA1KLZmwEBYZNamx9DmYFgd02zfJM=;
 b=BatRP4ZlOB9sgvvfbYOlQ/D1wW3PwwrZ6A1gMipy1O2m71Q4YyK+bKZTb/u3/NYEQiEn6Dhv6
 uZCR4AWmSRVD/lNWPgDwsLkctZsl2PnzSt6mINbJ4PIs6X8p3eiyZg+
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-ORIG-GUID: Q8geJ80WToNCG5LAWhJuF_r9V9IVYB__
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX7vNsnLfjrZ9t
 0XTe87Qj0oykt8CdIEzGC6P7P7qsrxX1QrKIFb263mndeAhdoPDsXlT+0VVHSoasej3OSqtwG8h
 ROdEHOvcmJF/0DlWP9tjPub/dTu1LkEJm34RMamlqrQNF0is3C9TM6ittPlZQgwyrTcdEdmz3Mu
 bNSp4hXod2NkuZO+XllW/ZTEl2s7Y5Ys3Hhu8t28GfV0mMO1DmptSMVwiR77JJF8q1SPsXCFymC
 j+/BTdSgMfMI2INWVtWsLkS+tZR9v+uWr7sIqqGz/sLRw3KHR4fXMVFb29rMQRomOcB6gBMtTna
 cTjpVCzp/rT89Zr9ZcdqvY25skyZKvqu0ZDUFkewBTJ7Ich+0wqTZLcin4cLhBGN7fZHR0D2T0/
 RE/Gz8Oa3YYa6D3Q2GoJg7xYnRtb6A5mAeo0/5bXb1AaSf+eocmXimJS2P9nAkuITxZXHbR3OZ7
 PMZ7LY7CCP8zFwgOqxQ==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a589e63 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=rSXZLFMjQQqjKu18WoMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Q8geJ80WToNCG5LAWhJuF_r9V9IVYB__
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX7ISmpJk4qd2E
 vmRpRw4lVG5cIDhARuecl/qdQD5tSLPR38mjw3DZLq84dVty4AAzJrs7Fu3+4JOsDKpehWaJfG/
 vLZEw/DiEL4AEk/PjVYudbwE2DDXo1k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091
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

Convert repaper to explicit primary plane, CRTC and encoder objects.

Keep shadow-plane helpers, framebuffer access handling and no-scaling
plane-state validation from simple-KMS path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/repaper.c | 132 ++++++++++++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c8270591afc7..7057075161c4 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -22,6 +22,7 @@
 #include <linux/thermal.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_damage_helper.h>
@@ -38,7 +39,6 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #define REPAPER_RID_G2_COG_ID	0x12
 
@@ -65,7 +65,9 @@ enum repaper_epd_border_byte {
 
 struct repaper_epd {
 	struct drm_device drm;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	const struct drm_display_mode *mode;
 	struct drm_connector connector;
 	struct spi_device *spi;
@@ -622,26 +624,24 @@ static void power_off(struct repaper_epd *epd)
 	gpiod_set_value_cansleep(epd->discharge, 0);
 }
 
-static enum drm_mode_status repaper_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
-						    const struct drm_display_mode *mode)
+static enum drm_mode_status repaper_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							   const struct drm_display_mode *mode)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 
 	return drm_crtc_helper_mode_valid_fixed(crtc, mode, epd->mode);
 }
 
-static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
-				struct drm_crtc_state *crtc_state,
-				struct drm_plane_state *plane_state)
+static void repaper_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *commit)
 {
-	struct repaper_epd *epd = drm_to_epd(pipe->crtc.dev);
+	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 	struct spi_device *spi = epd->spi;
 	struct device *dev = &spi->dev;
 	bool dc_ok = false;
 	int i, ret, idx;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(crtc->dev, &idx))
 		return;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -771,9 +771,10 @@ static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static void repaper_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void repaper_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
-	struct repaper_epd *epd = drm_to_epd(pipe->crtc.dev);
+	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 	struct spi_device *spi = epd->spi;
 	unsigned int line;
 
@@ -827,27 +828,84 @@ static void repaper_pipe_disable(struct drm_simple_display_pipe *pipe)
 	power_off(epd);
 }
 
-static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
-				struct drm_plane_state *old_state)
+static void repaper_plane_helper_atomic_update(struct drm_plane *plane,
+					       struct drm_atomic_commit *commit)
 {
-	struct drm_plane_state *state = pipe->plane.state;
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
+	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(pstate);
 	struct drm_rect rect;
 
-	if (!pipe->crtc.state->active)
+	if (!pstate->fb)
 		return;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
-		repaper_fb_dirty(state->fb, shadow_plane_state->data,
+	if (drm_atomic_helper_damage_merged(old_pstate, pstate, &rect))
+		repaper_fb_dirty(pstate->fb, shadow_plane_state->data,
 				 &shadow_plane_state->fmtcnv_state);
 }
 
-static const struct drm_simple_display_pipe_funcs repaper_pipe_funcs = {
-	.mode_valid = repaper_pipe_mode_valid,
-	.enable = repaper_pipe_enable,
-	.disable = repaper_pipe_disable,
-	.update = repaper_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static const struct drm_plane_funcs repaper_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.destroy	= drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int repaper_plane_helper_atomic_check(struct drm_plane *plane,
+					     struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static const struct drm_plane_helper_funcs repaper_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= repaper_plane_helper_atomic_check,
+	.atomic_update	= repaper_plane_helper_atomic_update,
+};
+
+static int repaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	int ret;
+
+	if (crtc_state->enable) {
+		ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+		if (ret)
+			return ret;
+	}
+
+	return drm_atomic_add_affected_planes(state, crtc);
+}
+
+static const struct drm_crtc_helper_funcs repaper_crtc_helper_funcs = {
+	.mode_valid	= repaper_crtc_helper_mode_valid,
+	.atomic_check	= repaper_crtc_helper_atomic_check,
+	.atomic_enable	= repaper_crtc_helper_atomic_enable,
+	.atomic_disable	= repaper_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs repaper_crtc_funcs = {
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs repaper_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static int repaper_connector_get_modes(struct drm_connector *connector)
@@ -1102,9 +1160,27 @@ static int repaper_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(drm, &epd->pipe, &repaper_pipe_funcs,
-					   repaper_formats, ARRAY_SIZE(repaper_formats),
-					   NULL, &epd->connector);
+	ret = drm_universal_plane_init(drm, &epd->plane, 0,
+				       &repaper_plane_funcs,
+				       repaper_formats, ARRAY_SIZE(repaper_formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&epd->plane, &repaper_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &epd->crtc, &epd->plane, NULL,
+					&repaper_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&epd->crtc, &repaper_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &epd->encoder, &repaper_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	epd->encoder.possible_crtcs = drm_crtc_mask(&epd->crtc);
+
+	ret = drm_connector_attach_encoder(&epd->connector, &epd->encoder);
 	if (ret)
 		return ret;
 

-- 
2.43.0

