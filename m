Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E5C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5539010F45D;
	Thu, 24 Sep 2026 10:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SE6JRfs/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EC110F460
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:34:24 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OA5Lsc1175616; Thu, 24 Sep 2026 10:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZZnMrO7aHOO2jruA9T+2Gn
 1sViU9nh5E9eCSpq2a5vk=; b=SE6JRfs/EdHmiNEmKeFIhunzGHGpCSE8wIjiSk
 T+VKIBv1kjlpUqkecsFc+P+/9ctY3XIsyw2rjZwPY0ARgS4Df5nk3IRnINJNpFj7
 pi7snGbyPYqMJROg1QQOYgGv3ii+svMqUOiLVfDIeQqgo+7NgUnFTj6pxIt0LaxZ
 Z/Ldflw/OtaXJNakk3xppkwNbkp8qLSAi/elGHfDFK+p1KXmd7GbNMzrnTdZb0d+
 4HSOF/M22H+SEnv3QPN9qRR40nl7U6Qo72qPSXfBIoICN8L+tGPqHelGApqOvj7e
 za7GkFUUkbq8uNRo++58/ZrO3J5bw2ZwVQZPT8bhSO7Ll12g==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1t7r3br-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 10:33:59 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OAXu8I2494666; Thu, 24 Sep 2026 10:33:56 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-arpisain-hyd.qualcomm.com
 [10.147.248.17])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 68OAXtkT2494659
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 10:33:55 +0000 (GMT)
Received: from hu-arpisain-hyd.qualcomm.com (localhost [127.0.0.1])
 by hu-devc-hyd-u22-c.qualcomm.com (Postfix) with ESMTP id BFFC463A;
 Thu, 24 Sep 2026 16:03:54 +0530 (+0530)
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 16:03:46 +0530
Subject: [PATCH] drm/bridge: anx7625: Fix register access in low-power mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-latest_tag-v1-1-7150d373f042@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIn8tGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMT3ZzEktTikviSxHRdA4vUxORU05QUC4NEJaCGgqLUtMwKsGHRsbW
 1ALtePDVcAAAA
X-Change-ID: 20260924-latest_tag-08eace5dd80a
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Xin Ji <xji@analogixsemi.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, ayushi.makhija@oss.qualcomm.com,
 rajeevny@qti.qualcomm.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, arpit.saini@oss.qualcomm.com,
 Salendarsingh Gaud <sgaud@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790246034; l=1817;
 i=arpit.saini@oss.qualcomm.com; h=from:subject:message-id;
 bh=N2l6r0cOEWQcHFZ8LcTLMFDpM9/zGx7ZzJvtj9HaNOU=;
 b=njF75fOau/EXPNPMKYdnbjZtzK1ZrjBoTzsX8dvCtyPuEJUNYO9gM2GOt83uskicQNA9He1Zz
 3c/dHzqWC6CBdSi9hhLQHShoGXRXuvF/NwquIOC28fK1nY0WujjeNwK
X-Developer-Key: i=arpit.saini@oss.qualcomm.com; a=ed25519;
 pk=OGOh7FGwrnkILHNlcTTABbBMQxxo319duzbTg0YPDAc=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: ruGxyRo_qcHgjlck7joT9CeM2Gz7DEeW
X-Authority-Analysis: v=2.4 cv=U/MHnuru c=1 sm=1 tr=0 ts=6ab4fc97 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=-5D3cT9HNYT4-cb-j94A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX+f9r3xwfd7Wr
 EwbZJOjZF9LfaQGad6WCfatiA8xkn557m98fMfrxn2xkhkbhRztoPz/CqgI6wN7D0X/elqYBRy7
 J5QxLw0kRwE1xis3B9uhPxAbAiuYeMPl9I7nMmEydPD+Zz/WwODAy4dHvYfUj3iF03S/pg/8sOX
 /NZeHHIBJcCsLmrzom6+d7uqT9LSTENw1pPGJw+NJEE14XO1VBgo7DGo2tD1gga9b0fuHfsxJlu
 pkpEQXgekrVzdT4YWtjE01WyrboYDOjUuGeCoIfkT3jcx9ah6SeHrjbltE7fwJExnudOXegw1uo
 0/Ltm4DvotyofircKHEnIhgUJpGJz/jDO/mHfiW3I+q0sV84SslSLgUh5P+4lNq1uz3ZFDdCshF
 JBdJEyqIy+awmgpznVY1T9ZYHtOqtEkXjFQD02bvg4aXfKjbkRh1ai4rfBh5+k2A7swb/CxzaOe
 tNchtfiHVdIYiiJdRKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MyBTYWx0ZWRfX4zAiGRSTYhws
 18sKSPjzcI015lOICR4IIYcDqWKUCcnG/P0SSpByqDDQjg6cAtVQDQUrPCN/11p+bZzB9OjDTta
 28WsoyGl/tmeSJqy9Vn7MD5LB9A9a5U=
X-Proofpoint-ORIG-GUID: ruGxyRo_qcHgjlck7joT9CeM2Gz7DEeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240043
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

The INTERFACE_CHANGE_INT_MASK register was accessed outside the
Type-C initialization path added for minimal Type-C support.

On platforms without Type-C support, this causes the driver to access
the RX-P0 I2C client while the ANX7625 is in its low-power configuration.
The access fails during probe and results in errors such as:

[drm:i2c_access_workaround.isra.0 [anx7625]] *ERROR* fail to access i2c id=3f :39
[drm:anx7625_i2c_probe [anx7625]] *ERROR* fail to write i2c id=3f :43

Keep the interrupt-mask update within the low-power-mode check block.

Fixes: f81455b2d332 ("drm: bridge: anx7625: implement minimal Type-C support")
Reported-by: Salendarsingh Gaud <sgaud@qti.qualcomm.com>
Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index c3af88e14f8b..00f2132c7c47 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2930,11 +2930,11 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 
 		pm_runtime_get_sync(dev);
 		_anx7625_hpd_polling(platform, 5000 * 100);
-	}
 
-	if (platform->pdata.intp_irq)
-		anx7625_reg_write(platform, platform->i2c.rx_p0_client,
-				  INTERFACE_CHANGE_INT_MASK, 0);
+		if (platform->pdata.intp_irq)
+			anx7625_reg_write(platform, platform->i2c.rx_p0_client,
+					  INTERFACE_CHANGE_INT_MASK, 0);
+	}
 
 	/* After getting runtime handle */
 	ret = anx7625_typec_register(platform);

---
base-commit: 3d7783543c2646af69ad65825e810060494bea21
change-id: 20260924-latest_tag-08eace5dd80a

Best regards,
-- 
Arpit Saini <arpit.saini@oss.qualcomm.com>

