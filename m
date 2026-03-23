Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB3D58CB0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FD310E074;
	Mon, 23 Mar 2026 01:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="By9VTE7g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AbALNwdQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDBB10E074
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 01:21:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MM0Kgt1317414
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 01:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ORU+o9l2KKfLGoKsJtfdo2
 Qx79AU6HKpvWZlsTFXE7g=; b=By9VTE7gvrUJwSLqkXM4n8ZqJiN9jQckOdPWBz
 brkfhiyLzTELOevxw1+uk6qEQFFU2zRnKH1rb6ww5IuXW2s2xB9ymAVqpgeUJCL1
 nEz42ar7iOhswpaqPmZvBmQUtvuJGcu/SOWvEPu9qbP4eWN1kKKDEJ0Ls4FDLjCw
 QEp8CqsFA+E2/0YtflvDjYgUVEHgur3jJD8YiZX9UH56fqHCF3m01Cn5qgFaCa+O
 ChhSgSEkSm3a+0DSDZAyTAlTgxCLdkL2r5FMkcI0M6lbPLfi3iGNdChSoxsjuMSB
 EalcFaGQo6ZPYFmNFowezVaAZgLMQshqVhUTlhQwXk1AzB8Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1mghb54c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 01:21:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a0013d87bso58731396d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 18:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774228914; x=1774833714;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ORU+o9l2KKfLGoKsJtfdo2Qx79AU6HKpvWZlsTFXE7g=;
 b=AbALNwdQxXQu8wf9cwC0i1bglo7JpBmpJVSNlUhuIyUOgAOf8hGqbmGqLol3ZZ+o4m
 ouZEmfeFtTV73v5km06a4HORT1scEkr49bwtujcq/CGzzCF8zRx/klIfZ2UOyjskr1h4
 UV1QDI0MMDqtwP8PjMbUMHcmEVTvC3i0w1vas72KvIis2zy0MMHDpIVBqYWBRJ2Sl7Y5
 9RUT+30tOXOe9I5O8YQw7FfAnbjTEcJMmpbZrxofNk4ctkAEBJrsnVqCTMRB2ytKk228
 +goftuKmp0vngI1a3JGq6dxPYX24oZS/P0dFbgxZAsu5IonSYeLTsHC3+WTmXCyoWGAv
 wCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774228914; x=1774833714;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORU+o9l2KKfLGoKsJtfdo2Qx79AU6HKpvWZlsTFXE7g=;
 b=DeTS7uMOLmWo2vLDto+dhkbDzphZnb1KB4hqM9WWaQwwQOrs5Js4TfKyotet3XnaUD
 Hnp8ksXgGiBoCwr6aC3M3DhNLUTrRekWbqo1jJD6uLi7cmMrhy6fK+kN5xYpSwt3MZCr
 3NOBDkv+iF5OQLcVRq/QHF2wySe9RqXYJZy3UJH+MdXp7A4IQ3Bb9vjaOVAQlig0KyIC
 EKwEuStnzrH4cVooLiXITlfsBQDS+OtaZEbh+kOFP7UongW0e0cTmS09T8w1EAyomydL
 FmKkHo40aZkYHJusscS/fuH/Wp69CN7aWp1lS2rBNuIsEh5p6Oj7voNhmoABFsXHY567
 NRdA==
X-Gm-Message-State: AOJu0Yyubxtl2/UiYhqKbyhu+ItFEzf8Fl+/MQ3Ce7jr+nfnXAxkmM+d
 forbvmujSmqX9JMYbLUsTuCfkdKmihagVYbnf5+GX68K2bb4vJbgEZAhVzwGCcgN9O0iqT18Ru0
 z24dbyu5qEgkPBvxGk3ZXq1bsfd5rmOQ0fEwnAT3BDeRFN+2sVwa+ouBCKL/N9jaBIbv2jHE=
X-Gm-Gg: ATEYQzyt2q0OxFBqDFyIg1WnjQv/0KcU+MCuenVKgDldqXmedjwUmzw9GTPHvoZG/xA
 LE5Hqmai7NS8vttdV/1EI8XiCCtn4O+C/MhyzFw5x9bt4nNp0N6WtW2kJpAagQLkf1ZamyPh58k
 MYZbxdgli/BgFkjZr3dT8LaOERnA044qzTvC5lPS7RXKSU4udzQ6KN89IOJ/+9dnP3mmGnhpn3l
 mqrevLgYahkaClLor1QyfZeXb31QGkvSHur0DxuWVODHF6IGENQyrl8o7XZhWkxjGP86bY2503N
 V73USgWJYt6Su+AreOYmvhYljQFeSZY1GotgaBn0yNymuLEn/xoP7MHq9/kpN4TvtCHlTR/5omr
 B4d289QlTIEwDNNx1rokNtq4qPGUmkdHs2KnPRl8r65a41xxeoujEkBEgiUF7vuT/x8CIVUF1l4
 cvM+bm1sXFtzYTqJGM5w/uNxgdMWQ5EhnAs9A=
X-Received: by 2002:ad4:5c6c:0:b0:89c:4e50:1918 with SMTP id
 6a1803df08f44-89c85a0fe34mr185523156d6.27.1774228914018; 
 Sun, 22 Mar 2026 18:21:54 -0700 (PDT)
X-Received: by 2002:ad4:5c6c:0:b0:89c:4e50:1918 with SMTP id
 6a1803df08f44-89c85a0fe34mr185522936d6.27.1774228913588; 
 Sun, 22 Mar 2026 18:21:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf99821c4sm24702431fa.27.2026.03.22.18.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 18:21:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 03:21:49 +0200
Subject: [PATCH] drm/panel: sharp-ls043t1le01: make use of prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-panel-fix-v1-1-9f12b09161e8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKyVwGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNj3YLEvNQc3bTMCl2TVHNLE1MDi5RUSyMloPqColSgMNis6NjaWgD
 OIF3OWwAAAA==
X-Change-ID: 20260323-panel-fix-4e794508de92
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=sTfuRf/e3pyKDVONUmxHUT9BELhQwskmfU0XWxxGsKM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwJWtTb3UME6jPBjYhpdRHXrbjCYEPOvFavHcb
 k7oOcJdb06JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacCVrQAKCRCLPIo+Aiko
 1fL8CACFctA8Fq4WV6u+uAkbcC8DThDEm8ClPf/zyp/0yNjxDhpDK0oIZJ+uBN+0cM7BFwWdb3y
 awusxpe+vB6JGG3Sz22nCiPuAftWsObgc/rc2Z+aU6s/kav/IDjT+G8BVR0PGzJXttZz02rxDkd
 UzDDo0ez1p+qyFMRoswHWWdwZvSGvCaoQdLSgKfXtKcvA2ea5Lw4i8lIFEWYSTTE8YsF7bF9XSP
 RuLz8Fg0yvkoZXqY/KYh0DqcE8oLzXM//gcsmWqoi8HOhbYi1dAaiWr6uiQEaO1SOruhV9S23uW
 wgrEnOgUF0+/eje+VhmHRiWEBRUiq63+frugVtWT9Jwsg8MO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=HI7O14tv c=1 sm=1 tr=0 ts=69c095b2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=4JClWcSM9JSsAyiO1cEA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 2fZZY5WCSd4WGte-vXxicAIMWPkZXUoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfX/qVRNplp/c90
 pMXr3iCOIeM706XzCGpS8ok8tdv6w/T/sI/XZdBtTLOFHs8h+7dsT5xQHtSbvDzr6ey0OUdS0ms
 j0HUt+z4PyXnJ74Kev4zmaj+GYHhnjv8yI1lTEnnmGzK86i4fxrw35RXmdW5dXt8WxrBCFSOVFr
 wFUchRd8aVur/mOalo5C/EPcIENArayiN5DuOH6nRppg3ncrEZfYulaUUXuJ5xs7W07JJYY+Ni2
 cOvefznPvtjpKpiH+m6gKXWajzzXrGwjYLKW9+mCNYzsruAB4lR5VS0Io4NC/KroJZ81GvRRhTj
 +JA85Wrt5nh83JfEeGagJwxULAcJokdsErbcqynGr7d/a6cvrMcU/Wv/3LRXxNYwtOSLwHFF0l0
 4YGWNxMcskEs/+TpzcB1ixyaOGuMtd+btw2WGR0kbBqtccFEpBxdql/DeTiAufLt3/PdEOdg+rc
 cA3mo9hiF6FBJK18mSQ==
X-Proofpoint-GUID: 2fZZY5WCSd4WGte-vXxicAIMWPkZXUoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230008
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

The DSI link must be powered up to let panel driver to talk to the panel
during prepare() callback execution. Set the prepare_prev_first flag to
guarantee this.

Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 36abfa2e65e9..dd1eaba23ad3 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -201,6 +201,7 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
 
 	drm_panel_init(&sharp_nt->base, &sharp_nt->dsi->dev,
 		       &sharp_nt_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+	sharp_nt->base.prepare_prev_first = true;
 
 	ret = drm_panel_of_backlight(&sharp_nt->base);
 	if (ret)

---
base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
change-id: 20260323-panel-fix-4e794508de92

Best regards,
-- 
With best wishes
Dmitry

