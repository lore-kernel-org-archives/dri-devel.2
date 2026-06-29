Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426E9C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE2F10E94D;
	Mon, 29 Jun 2026 14:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WrcmkiIp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HPVTx07I";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3052B10E94D
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT33S2641697
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CY2/kYZwMHeTEPu+t0diQLOY++1sPPgUOB5KtcADCTU=; b=WrcmkiIpDYknkEZI
 H+j2O7fO40qENvHj6R6oHycIx8MDrjWg2Qkq/8s7DWV29k64+lAn9AzTYRj31N2Y
 vQ+sN8R1BxmqGmR2GDUvLY/ZXrmCWye8DbhOrAIQ+luyLHQKsWv9OgKYatTr9BSg
 HxL9iTXwG5g7HmpNIYSadf5xaVHoBYYFefgH/Hw5ckX8GheKj6UUuykNJm2MFT5/
 Nqn2Snu94rZIUFsy8bVhxRPWlaAU40zBs/0dv1OkNu8iTIAMRmvPMhakqYarM6SK
 jsCILGRDadnx5edi2wkVcg95XyY0RJ9Mpko8wrkwVcb3kXeBZIu11DT7naqhBgaR
 vt4HXQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npescjv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e59b0e0f4so69417085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782744517; x=1783349317;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CY2/kYZwMHeTEPu+t0diQLOY++1sPPgUOB5KtcADCTU=;
 b=HPVTx07I8VVvY1YDL0XfxcCrsg5dM5zuUHy85vBP5zkK8ouF8u32b9wuTCRaL0zEk/
 iRdEYabU1fgmS6v2TmZ3VvcxS33PfmvhtOK6AhYSp/u74Mu9DlAUlbD4lz/O1aJdvnBI
 xKpVeiulhXJNpU1pJ/MPIIKw9xxX4XdZ/gROHukYNFTgWgJsNyoK3LxltPg3zQclbJ5r
 X5Qs5Y9U+2iZ5ZIqqhD6jH2cU/CyvcAp3q99lt5lTBTO69/F/WU8caXC64SW5wmROaGG
 L5afbB/hInLLciEZcSptHwWzB8ryHPJ2KyTvWvEr2rupmSMIbL6nqy+JkjYQiCWMyVMY
 5uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744517; x=1783349317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CY2/kYZwMHeTEPu+t0diQLOY++1sPPgUOB5KtcADCTU=;
 b=E4ghw2Pxizwslv06Nfuguw00YKLxE/j0jvoiCDVwYQ+UdgA8mvv1wsppJ8H7zkY6sF
 57g2dOUo5vy8R+EsjIazbgfz/PPugZ+NbHIL7+fFomkGoSfd4wMtLKJL7P3ZReeuBG+A
 Y28HNpVTxjxE6YXZAHR5yudZyZU/7Rg5JGbwp+i2mcU2vYJLiwPqj/RrYXCLy1KXnbj6
 8nu48l6zcWjgB6OgojIwVudFyDIQf5zbbOX0bK5Bz3wVXM8wJM6f600AxrfsrJghe7UN
 YdW+YXRGEQRurzHoHyOh+5nU36GFn5mOekkRkkwh5rkHrw+8dP7YtUpK9gFZOvu2lOIV
 aLLQ==
X-Gm-Message-State: AOJu0Yz00J+Ipbxe36PfHeemvnYezauEAbUY/4y7QSrQ5ur8UPw7EfcM
 Y9/WcMKuFXNPNuSrVxveX1rlLRRLoP6rxkpQhJKEOxJ+GdTI4+q+8jG+UwkG+BeIQ4Vbotc474n
 +3xdk8Bfd6ERwy9xlwMtkR2IOcqdkh+lGhVaj0ZHE2Wqpv4AYxA2ftsfZeELwh6ddspqA9+w=
X-Gm-Gg: AfdE7clEMrlefvZ32mtAuLUTSFQELJalt5ypmSDpunqQTcW2Geuh6VMT6MIk4bbhyxA
 BT0JcZJDQKY+ORWgst96UadSS/DhZ5kbsaTnp109b75eClQfCcCwZJX4BQO+Rudqh34SwvOH6lV
 P07ypol0YErTqV4n8zaI8IS+EnPO7w74kve3OJCVZ9B3KFPTk1LmKSRMYDitQ51a2UG2dfQt3hl
 bTBM6kuXE5T7H9KhsvUSuNX4yebXw2TU1dK62ROgA9p/kiSKlcjYoqwqhpGtv8dK29drW4p9xGD
 ZBCX1I5zCB1q1szYyyZ2fmL8Xto22Bx9eoEbmd2qL9v5aOHx9Xd+61v3t2ew0P9iau5Jk5tM3wk
 0qA0G2vSsXnWFnh3bZ5Kzkz5A9/y1k4uqrsiyrYYQB5kJUwdEITFWjBh62r6P1PAM7RPQOjoonQ
 ==
X-Received: by 2002:a05:620a:199d:b0:92b:67e6:8ac1 with SMTP id
 af79cd13be357-92b67e68c82mr1371993685a.59.1782744516542; 
 Mon, 29 Jun 2026 07:48:36 -0700 (PDT)
X-Received: by 2002:a05:620a:199d:b0:92b:67e6:8ac1 with SMTP id
 af79cd13be357-92b67e68c82mr1371987585a.59.1782744516014; 
 Mon, 29 Jun 2026 07:48:36 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm2087974385a.34.2026.06.29.07.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:48:35 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 22:48:04 +0800
Subject: [PATCH 2/5] drm/bridge_connector: preserve connector status for
 IRQ-only HPD events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-msm-dp-msttypec-v1-2-646a10256233@oss.qualcomm.com>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782744487; l=2538;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=zCPPIEotdSUHd8PwFgThC89TK/453vk/QVgAmXnjK4c=;
 b=EFccj6BHEEeRrzlWUTbw8BogiRwObxZsIqPHY+e7jjnG7UU6Nl4UC2X3L1RNMqKmEJgNMp3Fe
 JQsCWBXPtSOBQ2IDWOHleokIGMiYwdCc2UgAtX0nE8b8obM54A+uwE8
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfXxgkF8bgj2jFe
 y5+a/Gk2KmzgfricixTSLnqRF9YxDAzRpvswqJd8kpPVpqFK3/tBIE1WXGnLX6B/LBwYi7xBvGX
 13McmvM/XEIhSWHPueed44D2RJyRtZr/1zcLYB8R5HIfq1eWMOiMvmZVbLEfa5+vH64SzYccNdi
 vVqER5hBeOS+Gf6QC6oOTWkTAxWHkNV3nr/Ae43mTQPy3jGpGaUi1Yvs0bWPx1pcFnG8Q7pG2SZ
 hVGXrJSOqu92gVKUPBXYUC6xN/Z85Cgx6/Z2yxHVNNSTOqKXwLg4lt6aZ6YIpngNkWWeK7tJaC5
 74Xhb05FEGBk47cmIBXTSrsoPl/IOdwpOiT5tulDfW4aW6ZiMtWh0CUBF6A8JWGUDa6r5t6cfAT
 aesyqdk9H9xY9Hbu7MU7MPON3AzpUJXfPvswKkCIpVTKVZQ/SGVuLkjYLKWeI+9S5XWiRatnTn4
 KNiPKf6ZfaHF/inYS8g==
X-Proofpoint-ORIG-GUID: 5SfPH9sPsTIK5uay1Il6W9zUz5sZFrqk
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a4285c5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HhJCdNca9OzhlWWnlXUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfX8USWiW+k7WqM
 BRej3KlH1A+rf8FJuA81W/7YZNsCIujrq2Z91D3UV99eyArq2KdRhzlGVt8GLBARb1ZWEfxhi4n
 xFuHeKLEo0W5HHBeDywB+PHQmzRFPuU=
X-Proofpoint-GUID: 5SfPH9sPsTIK5uay1Il6W9zUz5sZFrqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290123
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

The bridge connector HPD handling path currently updates
connector->status for every hpd_notify() invocation.

This does not work well for IRQ-only notifications where the event being
reported is carried by extra_status and no connector status transition is
associated with it.

One example is DP MST. HPD IRQs are propagated through
drm_bridge_hpd_notify_*() so that bridge drivers can process the
notification. During MST operation, however, the SST connector attached
to the bridge connector is intentionally kept disconnected while the MST
topology manager handles all connector creation, removal and hotplug
processing.

Updating connector->status for an IRQ-only MST notification may cause
the SST connector state to oscillate between connected and disconnected
depending on the notification path. These artificial state transitions
can later be detected by the polling logic and result in unnecessary
hotplug events being generated. Userspace then re-probes connector
status, potentially triggering the same sequence again.

Treat notifications with status == connector_status_unknown and a valid
extra_status as IRQ-only events. Forward the notification to bridge
drivers without modifying connector->status.

This keeps IRQ delivery working while leaving connector state management
to the component that actually owns it, such as the DP MST topology
framework.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 5edca47a025f..7334d6677604 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -163,6 +163,18 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
 
+	/*
+	 * IRQ-only notification: extra_status carries the event but
+	 * status is unknown — do not overwrite connector->status.
+	 */
+	if (status == connector_status_unknown &&
+	    extra_status != DRM_CONNECTOR_NO_EXTRA_STATUS) {
+		drm_bridge_connector_hpd_notify(connector,
+						connector->status,
+						extra_status, NULL);
+		return;
+	}
+
 	mutex_lock(&dev->mode_config.mutex);
 	connector->status = status;
 	mutex_unlock(&dev->mode_config.mutex);

-- 
2.43.0

