Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACC8F3ED4F
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6704F10E1DD;
	Sat, 11 Apr 2026 12:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9lYC/yk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apo4YKrt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB1110E1DD
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:08 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B40Psu3909930
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zzlcIKXiRQAFXIYPSVS0Jyv6z26HXplRvWhk/69wTo0=; b=f9lYC/ykfMzgHbKz
 u+1tOL6uWiVUlewo1bQRGIoLNx+l2h2R9yliutJKVLK+Lk05HEmwKUVpqkQEkBHm
 5UjsxsCM2V+VilxyzuobfM43sp+K2PJn9E5aJYvTzFchrX51ND2OXhsj0a6Q8X6k
 5HS/K91DxTiqDT9KaWxzB0RAOw1lZNlZ1o7nXhkWeioLc4x6OV5VrIi7OEh0nRer
 lBKNv2EVAzMhKYTBkzYstgXCPUe5z5AteC7GGBY93mZBLb6KeAzlaC3hmfKJlluU
 L2BULYv5KJzOCGreJsiFvsw7pk8CJaSpoMJX/9LXF9rt7m1rW+Uw6lf+nWDJVGER
 yKuKsA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfew00nbk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d984c74a8so69836941cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909467; x=1776514267;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zzlcIKXiRQAFXIYPSVS0Jyv6z26HXplRvWhk/69wTo0=;
 b=apo4YKrthn9n1Gc1PyQvD8UgLxOO91VLIQxqJ4UxEUgRZvNPiTKBq3f20KH6HawyM+
 8OrY4K1CsgnyB2xkPpieVppOFWFBKZ4GYYnMaNji66EXXtwlS75BTBKLgEh2K8Sky/vu
 jBSrHk7Iy0s8SkLKA9naQSAORRtiBv/EKJEOvBQGEr1bNxNSV+s+E/Fb0bpcoZz8CPOu
 DKBnUFWtsrUWnNCUNCWxhOtmwnUvVkFqKjn4fCHw7Cb1p2uMaN+DsVYrs99qhl+my9UK
 c7eIpCi9rY1gc3C6nu9SJLE3DoZffFnM/CH+c2Cwd/j60bGOPHBfU7VD7kbiXvWJLe4E
 DLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909467; x=1776514267;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zzlcIKXiRQAFXIYPSVS0Jyv6z26HXplRvWhk/69wTo0=;
 b=IxdZj4b6yy9RCE0I8KvWi2zMtB8NLhnBISk+TvD1etPjLaqJb1L40j1w4XATbzX5SJ
 MNOpD+kDmmPX4MINjtcb6xjZQcJkAXWFKgnBGSDUYdhyxdVJKCxspfrl5eERxUxye9RQ
 IyVZo5NnGlZuxmdDbpm1ubZyifaOs9z3pcOJjSCHFsmYe4q4G3ooElvronX1wUtWIAzd
 omFfGIR7TMx+ZgL3PuG1M6Yx9LuqSq/9emzHP8F5Pz0xo/336tBn7f/fqwLWMyJP449k
 AqnkjfmrrJ42qesO5MNphT6XVF/Mi0p1AN/p9Ynex/c7SATgB1lRq25N/p8Uu8elFMN0
 lXOQ==
X-Gm-Message-State: AOJu0YwF1830sKtjSi+1cM3WCgAyz2ADLdVE0Ss0/9JhOrR8sV5nPwpG
 p62tjCIHsC7FnPSr1lW/1nSfxrtmovm4UqmowfJjeyp33vtdqNWVjEgaeyjLHVBC/q2e5q9UQUR
 Rezu+UEo1xtjXgYEU+WFmLa2OqAAniTT9QEFi7bAh1xpTA8fLF+SVUzzsVIgGf1fcBBSksIQ=
X-Gm-Gg: AeBDiesgAHxVO3sr58yttvHqkzhOwviQUChAjeoGUk3MyOtWLaNuiFFrk4T6dxpRadi
 aDaPOSQ2/ibVlMzytj8+d67b3oH9gxC3WxxfBoxW+Na/YuyK7hjjFV2UBYNwA3eUkWkhiqfxTg8
 5T+xRgvdE8/UWLRz3Mddl7eOX1zh8Qhdra/fRuQ6ni0IJyupo4Qt9DqcdZgmmfkY3VIQf1qMiv2
 t2+AapDzAOO0TKvJ/x+Ng94plvM4kxHFOqZzc3oFX13sr3M4HyTYzz4ssGC2De7+2vLdSdg/Gaz
 uG2JxAH5nvdAOAlkefCGulnfR/GFazMqKrfP3MclKBtbYAlgARKYur8WQ8m3P07XfIHda8lv0+r
 cZ3GP4Qp4G8ihh9oT482jR6P9L/9V5gMFucCbi9CPuUrbxzpCxEPE30txLfnNiFGE2wFYsJifSi
 5XP4G7h3VhpsuYWL6Rwsteowi4y7f/SL609eg=
X-Received: by 2002:ac8:7e96:0:b0:509:18f4:6dba with SMTP id
 d75a77b69052e-50dd5c06e71mr102667351cf.62.1775909467449; 
 Sat, 11 Apr 2026 05:11:07 -0700 (PDT)
X-Received: by 2002:ac8:7e96:0:b0:509:18f4:6dba with SMTP id
 d75a77b69052e-50dd5c06e71mr102666861cf.62.1775909467010; 
 Sat, 11 Apr 2026 05:11:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:29 +0300
Subject: [PATCH v2 09/21] drm/panel: himax-hx8394: simplify hx8394_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-9-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=sQ69JX4wAjTsBAqHELNV+ZWRZ1CzDcUvy3hc2w/OnYg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpGx5D7SfiEpFn9bSt6u0trVc0NpzEB0RrJT
 OoQBzvFJPeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RgAKCRCLPIo+Aiko
 1RmHB/9JWCf8L9NIXCDO3qTECUMOtyzDdZesJ/yUw7Y4S4JTmwel0/+y0gWsS24gXFUBxJ1eq67
 d1bs+I6WfvYcOC5PfV0Mvl27DEIGf7RPfzpfUP4nbsXSPQLXTUr/B5WXgCmqDVEHYGgZ0r0qtBU
 jYdnAGyw+parb8dlbrYd7/eN7pZLijj+GKsOnAuyP0VdQDG4MZ83y/GTr0NidCEaYHSRaPL+P51
 Jm9TjZbTonJvXXziFuhhE4xm8IPQ08vyPK93IpR7k/jVNXR4wGZLjnPrXOEhb0AMsveota8uObC
 7AHuQYCutHkzCEqNPzFwHCoRcE/TAx7URRRgHTBYBGJouNll
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX+8H6V73/6TBl
 BaHEpBPgMkxVRtEl3kilL8D7W7UAG52D/Du6Q3T7S4uhR5uyte9zMSbPFgxL+ui9qHP7p+cm39E
 znymivQPxJDjhToQm92D2wxTZ+iReD9AstjSc04h8WbUAwk2B8EsJe6Ec/XOXdYqlr1VUVAJLb3
 QePrr0xxHXWlnECSEVYY/7Hors5CnD3FDKj3JOw89TapiTTV9TLmCXmbCNpSz2mySGwDQVWQ/Pd
 hxEgYnaXUdKPSffpzZpR5qdA7aXxkaB9Tc/UjXO+bWJ4tRim1CPFuMZi9LjAVkelcyRIrLUt7BL
 EfaTAZNF3GNBIS6j5fZM0vhGMpIu7PWKkmrroOP+aYfR8Pic39BJm6dsmNS3/ptqFjbMosEEY5L
 3InHUHhgb8C0Vrx1L4jt4Ded+I14SjHozMczKCKBo/is+CzetK8VJMgNPRZu9vMR/i4FoU4tg1D
 LZtw3PlsenJLTSU5lzw==
X-Proofpoint-GUID: _2hcnR9pJYQqfll8BHpdda5lVznetNlo
X-Authority-Analysis: v=2.4 cv=AofeGu9P c=1 sm=1 tr=0 ts=69da3a5c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=jj6w_h7ptVUN3La3dRgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: _2hcnR9pJYQqfll8BHpdda5lVznetNlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

Simplify hx8394_enable() function by using hx8394_disable() instead of
open-coding it and mipi_dsi_msleep() instead of manual checks.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 41 ++++++++++--------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index d64f3521eb15..1f23c50b6661 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -618,47 +618,34 @@ static const struct hx8394_panel_desc hl055fhav028c_desc = {
 	.init_sequence = hl055fhav028c_init_sequence,
 };
 
-static int hx8394_enable(struct drm_panel *panel)
+static int hx8394_disable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
-	int ret;
-
-	ctx->desc->init_sequence(&dsi_ctx);
-
-	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
-
-	if (dsi_ctx.accum_err)
-		return dsi_ctx.accum_err;
-	/* Panel is operational 120 msec after reset */
-	msleep(120);
-
-	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
-	if (dsi_ctx.accum_err)
-		goto sleep_in;
-
-	return 0;
-
-sleep_in:
-	ret = dsi_ctx.accum_err;
-	dsi_ctx.accum_err = 0;
 
-	/* This will probably fail, but let's try orderly power off anyway. */
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-	mipi_dsi_msleep(&dsi_ctx, 50);
+	mipi_dsi_msleep(&dsi_ctx, 50); /* about 3 frames */
 
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
-static int hx8394_disable(struct drm_panel *panel)
+static int hx8394_enable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-	mipi_dsi_msleep(&dsi_ctx, 50); /* about 3 frames */
+	ctx->desc->init_sequence(&dsi_ctx);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	/* Panel is operational 120 msec after reset */
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		hx8394_disable(panel);
 
 	return dsi_ctx.accum_err;
 }

-- 
2.47.3

