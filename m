Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EAFC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819EC10E957;
	Mon, 29 Jun 2026 14:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CN2dAyMl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G5NoPbFA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777DD10E957
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:47 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3Vf2604346
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0DCRc1+pd9Su9ZSSDRhIagXJRwfB5gYRz2Ej4HsfPXE=; b=CN2dAyMlR6FulHz/
 L2n4JtnXLBj5ia8K5IadUawl7zDfJRIk4A0w13vLZMqxvaCTgMMymgGM7/BKX09P
 RCvjyKNID6nZ2MtTvpLdlQdoMNeDbz59482ygF6ek0Woq5hrTT4siHya/USurtTE
 vWyZnKdr8EBIOvQMTnIfBEwwxfu2BNv6kbqEKeZT7MP7Pph69VS+Qiv45sM4FKAk
 VXdA6VGaTJKv7NXxbPj2FqryLI/HMc3odkPmFzH6HGtkJNJKD5KN6Sq6OnusyNpt
 BlA8MteewBp4Lf3P+0p7Qpv/Cbk6zkEYBhhee1XLHVBFzKCpjeY3OAnYEhXET+W1
 LWeFgQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq89c6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e55721a8cso130843785a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782744526; x=1783349326;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0DCRc1+pd9Su9ZSSDRhIagXJRwfB5gYRz2Ej4HsfPXE=;
 b=G5NoPbFA98skyUzI2xn8HT/88RNPOK6GWCSf4krHEGhj2pqG3iZcfXWdZL1JMczomC
 cnytQZTeMgvRQj/U/cFqfqJn5+5hzj/2dtZ0v2ihOI6COLR33cfwj0qjlFYBDK8fiRzd
 CV94a3tinXyqeoCIwob97PfS02RSNxLU4Qp9Z5ePlBoaPz9dLthGTtGHOl2dpErLg4ql
 wfNgUqBCDWGvRi3hkG1ewGXUcWXBvrq5YItN/ic4pH4o9pvn7XuJrK6XJX4MqnK22Bmz
 Y371UoU67pio7ZJ0JgNLrqfs9WWJqmm1DsW+xKil8UUleXiwQaUclYyuSBGW/SLok/x0
 +8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744526; x=1783349326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0DCRc1+pd9Su9ZSSDRhIagXJRwfB5gYRz2Ej4HsfPXE=;
 b=I8QRO8Y8lxZVMvWo8MX94xEgw+Eo2c2xQFKPynaNvwXyT7Koi9UtuIQHNU+UvXg1vz
 NG1zcI+CXzIQe+togMZM+eU/dAqlK3mqZxHnt3E6+Kcywa2CuciwtAjB0lJ7PhGZzFjr
 T7oUfyO/Txw1HIG/D9XgHmLMVWLFt03wG6MTNIaopKYsTylP8ruHK5/YnatgqSkGto4s
 o3J3jFJaTwEeS3bpEwrpFhbnsEAvCIfI+bedMIEgLnEnLAEOGtIs/OvgoW+1BwKh766M
 RYWN6pG4DDU079XiXqHhkuVrRk8qQtU2Qe9R3EAUlUalKXyURd/3hh/hfDnAtffmcffW
 0oAw==
X-Gm-Message-State: AOJu0YwuM+0v0eU+tXG3pQgB8ySYiNybFyoHnOm7JbQIrkajFGgnMC33
 ojezUuPQd8hzHXuqusVDlgG4fLnaj5c4ialInZkQ8CcsZkZ+/cphFXOjGo9mxHrUlxFlw2QOZY/
 OPOPlirIcQ7yaMmQvbzk76x+uX7RQWrJHpA6CFRSFr0yZBxwBev+/l5zPdCtaRiScfX9DjJk=
X-Gm-Gg: AfdE7cnZUaqXr7Nk+0/TKT3Yxj91VgNKK3ObVH2YvX9Kfsu9xNZfN3hm3Xlu7fa5Bbw
 RgtdRAu/d+nf2CbWMvXegTUQ0iVgfaTB6rvFGA99NnjCKBaXb0VkVck3pnU8Km1O4auNxzifjeE
 jsLLGRXxo77UOVtVDpAG873otjwt+I4SsM+pmVC9GvPQS1p4x0fLc5VqgS0y3ZBUU7LFO8vOJy9
 LXarWG1ilRdZKsjKJp3XBYfWP5dzMERBszzy2w2ma0RQHIQclcjWlKrz6wY9sWriFcSVYiU/cAH
 d1su1pkG1idyx2M6d0mKx02sEPHoXlTW0I8bO6eOgzhCcHmEP93Fp6e2YFpaUrAobupJNpX0Fgs
 RpKppkOoq2RcWvfIuDk8sOYN2hjyFakOqlk1vg6qUhlga4byMJMlUFD7/rEdAWntdsFw+zE/OOg
 ==
X-Received: by 2002:a05:620a:4050:b0:8cd:b2e9:b964 with SMTP id
 af79cd13be357-92b3b00a2d1mr1531795285a.10.1782744525977; 
 Mon, 29 Jun 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4050:b0:8cd:b2e9:b964 with SMTP id
 af79cd13be357-92b3b00a2d1mr1531790485a.10.1782744525425; 
 Mon, 29 Jun 2026 07:48:45 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm2087974385a.34.2026.06.29.07.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:48:45 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 22:48:05 +0800
Subject: [PATCH 3/5] drm/msm/dp: suppress bridge hotplug events during MST
 operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-msttypec-v1-3-646a10256233@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782744487; l=2450;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=HP/cW/Tw37YstcovENSRbx+bTNeC9rrNJjB508cDOAc=;
 b=DhGa0Wr8tIbwVvFaZ+bpQnM6r2zbyTcERPBAAfH1jQ8mk+FZG4WQ2mgMtUZ4hCw5ENlOZGq6j
 uU8xr6dBr2YA52fJcrO1a+YGmKFCgXLAWGeqtbRA1D/miCilsRUfAJV
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: StTrcD4UhyHbTAL2CFs1QKoLF5OKPi2W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfX6m01UwHilGz/
 iSkr9EjLnq/BMTStWrzq8pLKC4rN6Ak+kabgZhavrLYyXfiQuG9gFnY0ePJxf0s/XeXZ61p7sSG
 AEXyJUI7LlVg+SRacQsleImb7xWUFTs=
X-Proofpoint-ORIG-GUID: StTrcD4UhyHbTAL2CFs1QKoLF5OKPi2W
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a4285ce cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=MZjPE3D8UQgFyAeDyYcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfX2xKiRUPBGsF0
 4SE+z6tjAqxEB8bYTONVlKqcFb0aZuXs+19gNmcV6lzVVMmCntt3wKOJY6atnFEchPPrOkA0FQa
 4Sh1mazhsLAfsOAjokC8MeovZ1OX95k1VePU3a7bMvy0JBPBsQ+LxfnkT3DKKDfLJBSrTuAZ8Yy
 WdTG0xakdi6en1GQ2kGfGFqkBPtKUnEtaCazIcxpHzDglI9uE3V3SF01GWoGEOlUR4YhxwZ5Mnj
 KR9ii/jh+J9ML4gNbWQdUTqvSd0d1d5jBTw837m6Ae3XYQnXbKxCFGgQAyQ7RCrjcs1iH8Hk9/8
 l/5EvVZFCvoBVQPJHC9ePDMvxRdsMRfEWrNRD9PO+j9RtrsYUntLGNbU14fuxU8AX8BokhozClj
 +Q7ev8hYLnZtk6MmnmbaHghszT9m1axSKEqIUUSWkD/I81GBoxSoY32Sooe87ZxyJtR5uhrlOtJ
 sV1HgGnktcFuUC0XPog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290123
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

The DP MST framework already generates the required hotplug events for
MST topology changes.

Suppress connector hotplug event generation from the bridge connector
path while MST is active, and continue propagating HPD notifications to
the DP driver.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 6 ++++--
 drivers/gpu/drm/msm/dp/dp_display.c            | 9 ++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 7334d6677604..82ed0dc450ab 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -162,6 +162,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 {
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
+	bool send_hotplug = true;
 
 	/*
 	 * IRQ-only notification: extra_status carries the event but
@@ -179,9 +180,10 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 	connector->status = status;
 	mutex_unlock(&dev->mode_config.mutex);
 
-	drm_bridge_connector_hpd_notify(connector, status, extra_status, NULL);
+	drm_bridge_connector_hpd_notify(connector, status, extra_status, &send_hotplug);
 
-	drm_kms_helper_connector_hotplug_event(connector);
+	if (send_hotplug)
+		drm_kms_helper_connector_hotplug_event(connector);
 }
 
 static void drm_bridge_connector_hpd_cb(void *cb_data,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6835c68fe510..bc93b566fbca 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1790,10 +1790,17 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			msm_dp_hpd_plug_handle(dp);
 		} else {
 			msm_dp_hpd_plug_handle(dp);
+			/* mst_active is set in plug_handle; suppress SST hotplug */
+			if (send_hotplug && msm_dp_display->mst_active)
+				*send_hotplug = false;
 		}
 	} else {
-		if (hpd_link_status == ISR_DISCONNECTED)
+		if (!msm_dp_display->mst_active) {
 			msm_dp_hpd_unplug_handle(dp);
+		} else if (send_hotplug) {
+			msm_dp_hpd_unplug_handle(dp);
+			*send_hotplug = false;
+		}
 	}
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);

-- 
2.43.0

