Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53402107BCEA
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 00:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B081210E46F;
	Sat, 14 Mar 2026 00:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A1aFQJ29";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mfefmdsx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7194C10E46F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:22 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DLB4bb3229725
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=; b=A1aFQJ29x6dowmkg
 kow378QQQOoak0MffL/xrGZA/BQWFXJb8BvwpvQpyGvomXdvMcHtGtpoFc1h/WRY
 zwaDOPr/k56fh4ZcPIGuHRzGYNOF+SksbCtk6xlP5beqz2DyYpnKSdnW+ZNnk2Ii
 Q2BU2giF4qKFgsG8CNhZKB8JpYLKLcW3ifSj/AIuy/UZuZzzWmmTzmtd9NjQNyTf
 yQikyzoGZzqiIcEjReYmOA7/VUGFZxT5hnqrv3GdnEqCsjXtVjkJyiUAD++gPi+m
 pb4uWyZ7vrgFikZ+c2Llg36f+veFWyYT7IY2w92oqBmV91LTHXPlkgxEnx3AfzLD
 D7fvfQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7m7e6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd7c4ab845so1174090785a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773449001; x=1774053801;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=;
 b=MfefmdsxCiWM2Y2BiA3WFH8AS5gHbrzvaEm9qEPfsDXdLgfl40cpB/rlOuJaueMKvj
 awt3bpzv72nwnbkiGE2R9YdoGw35a26V9XZDtuSb5d69Nfo0m4b8Wo8gGisNb0N0HaEa
 bGT7jmdzSNKDId2lv3nakY2Zqi09CucHuzWi4ieMqJFdJvKC3k39pRBN3zSBbwH8SQxO
 X88nC44J03ufpN78gHLx/h/Yodt0wz3eZxIHprScDlFEBUE0dEvLHGCZoTXcX62LEkzI
 zetktStwsHtKd21igrF/qjM700aASXjObQFrr+1Vvt3EYoPUBFjfV6N1zO7bQXL7jmHs
 IraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773449001; x=1774053801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=;
 b=stb4Q3+xI/yuaenCdCEJarlKPWuZMcqy8iTa73DtzH8LU5mKzNkvK/PQ4AIfKDG7xv
 zJVZvrBjgYXOeFIc80YY+aEWXT33R8S6iLAS4SSHuy2yZvxfMlMWLbT9VUu2trybbk/p
 UOjRXpKC0gmjPqoGeWuwjqoA0ERCp3rqvaGVqYSxOU1gQvm9Yhp1ff3gtFLrmH1cC5ml
 wmmLgDDewnReBmR2YW6MtqJ6UnQ3ZXNkb6EdDAsirgIlskMkP8qXOlQw0R40Vj1GyyGD
 3CQKulhgFE3X7DIRho29mvs4RpKFWV45eEZxsfdUjQTUtljZJY4ekRtyxQzE4ZfSndu/
 N1Bw==
X-Gm-Message-State: AOJu0YxWDkRVroat7GNvJVd1B6bmL1iYUi787isxFLlHWOfK/6yEVqB/
 e1iSzFAiu9e18FUvr7ycj43LcTvrIg7OLYLRR+AdC5gpDYDMwt1+ZEOC/ffu4EnqOObfadq7PFz
 eWAcl+SCGE7DQs4En7+7WdR4yeShc2NQF24XNmJY0S/XaJngMCiT4ctLHRAr3LMIRNiRKxX8=
X-Gm-Gg: ATEYQzy9NjPq3Wyguo85s3l5E13qLNxR6Y96h64ud1g7IlSd3pumD0AeWKTX15UKU86
 XeVU//3xXZ2gXDBp2Xw66K+GMWCTGYMBG2bvyQX7zZvzMV5gNAYfgRi3kMeQchPB4QV6NryiFiD
 NzYNP2w1MjN265NbJK0TZqqPPF2u6Bcf7g8InJGuifiw6TK+PiK0x+LLA7cwGgPw/SpflzSXef8
 TWyBIjfnJX0yXl+hbCjMVlj11X74e397gKKeQfmZlyYoATtny3ZmK4FtBfu/BEI4UccskrUr9GJ
 W5Ems1EnjdfqOI8uQrhc7Ny8uftKxwVrJlPuas/9JP+5WLA2oTAxztmwP/HMeRfRBhJMBjdxRGu
 WeDc5wFRJoJox2111406wmyzOCJTHX6W4I4S+1yzotdoy3EZ6gP2dBZ+RoT3N/pKszev3dk4dqK
 nr64QokmVgT7YFxsp35eYUNkTj6otLFofz3KU=
X-Received: by 2002:a05:620a:1a19:b0:8cd:7db4:8082 with SMTP id
 af79cd13be357-8cdb5a3fd44mr754660485a.4.1773449000880; 
 Fri, 13 Mar 2026 17:43:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:8cd:7db4:8082 with SMTP id
 af79cd13be357-8cdb5a3fd44mr754657485a.4.1773449000457; 
 Fri, 13 Mar 2026 17:43:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366a74sm1843556e87.75.2026.03.13.17.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 17:43:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 02:43:11 +0200
Subject: [PATCH 1/2] drm/bridge: display-connector: don't autoenable HPD
 IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-dp-connector-hpd-v1-1-786044cedc17@oss.qualcomm.com>
References: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
In-Reply-To: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uaisOO81wUqXM57ZY+50E+vgpCZk+fmw3L+QuSoJRis=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptK8gtZfdKIRpL7Sp3rBpmOvpXYT1NDvYSUF30
 nEmfvUEm/yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabSvIAAKCRCLPIo+Aiko
 1UBiB/9rFH9uOMOxz3Z013q0wNXVl3gE+xUns1Cnz4pgToKLLlCPvH7LELY49xJAyZjw2mJB/sV
 FKeQH2jZ477grnDna1rKlQsz/bzIB41rZEl7ilqAMIPZj7X5AOevZm+vrQV5JXPbD6a506bUH0o
 5K62HPtVRhrfdF1MLzUsrE3j72uwejwiZToePS9dCmILN5pRsmO1SrGGYV7QOVkEtc/GsTYTLw0
 vUvrTTDNZpbnJAq8lFDRhGEwr6AwvTMe3VLrD7hUtM4fIaZS8tR+C7Mrf4J/nd0Eb961hSsmZmu
 l4F2SucQ6dfoH1NL4D160P0FPTl5hBnoU4eyFrjzLGV7pfkx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: xy9C3NEhw5jeDAcqgIRmjEBk6ZgOi5TW
X-Proofpoint-GUID: xy9C3NEhw5jeDAcqgIRmjEBk6ZgOi5TW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwMyBTYWx0ZWRfXzZSN4dsVmaYl
 OGHPz0bhvtgn8KLuIBU5/yR63cgeKVa5/EHIcn2N+hMVPUmK+vvOVE2Ef0VNyR97Np9Y8k8LLLd
 p7MgadkjaYPPRUrPbT7HpCDyOXn/APnvsEOovWUMEiAhG5Gu2gDr+irNA9erK3j/OjSL6U3pdJo
 cTnPspye9Y9Dm2vJ4vIMmP4MwcB3FC987hJfEDOqMtAWQofJXAigGMTiyW/aqVMkSCCJPyQQwn+
 XBmgVHfcy+3/u64E3YDiFlm61zj29UjIJ+xtC1wBjQ2Wio0WlAz+HzT2/yz7x5SBNuXfORIws2o
 ikQiYmXhiBcHe5rLQ5GaylBFwM+tqSK7Dz7aDecOy9/XdvuxOjgmmqokALLWkkMZ+AYS5SCgPIJ
 tqohum3itaLBu33q3lz3QswItiGMwXP12V6/TREQ2oXsZTkaAVfwZlX3rDtmKBJySpC9OOR8DF+
 0tQ1euWmU7B01Bfx70A==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b4af29 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=n8oM3ScPHa2hF6C7bkkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140003
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

If HPD IRQ is enabled in the display_connector's probe, it can be
triggered too early, before the DRM connector is completely setup. Use
the enable_hpd / disable_hpd callbacks to control enablement of the HPD
IRQ.

Fixes: 0c275c30176b ("drm/bridge: Add bridge driver for display connectors")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 16c0631adeb1..6bb1134f75c3 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -87,6 +87,20 @@ display_connector_bridge_detect(struct drm_bridge *bridge, struct drm_connector
 	return display_connector_detect(bridge);
 }
 
+static void display_connector_hpd_enable(struct drm_bridge *bridge)
+{
+	struct display_connector *conn = to_display_connector(bridge);
+
+	enable_irq(conn->hpd_irq);
+}
+
+static void display_connector_hpd_disable(struct drm_bridge *bridge)
+{
+	struct display_connector *conn = to_display_connector(bridge);
+
+	disable_irq(conn->hpd_irq);
+}
+
 static const struct drm_edid *display_connector_edid_read(struct drm_bridge *bridge,
 							  struct drm_connector *connector)
 {
@@ -178,6 +192,8 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
 	.detect = display_connector_bridge_detect,
+	.hpd_enable = display_connector_hpd_enable,
+	.hpd_disable = display_connector_hpd_disable,
 	.edid_read = display_connector_edid_read,
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
@@ -307,6 +323,7 @@ static int display_connector_probe(struct platform_device *pdev)
 						NULL, display_connector_hpd_irq,
 						IRQF_TRIGGER_RISING |
 						IRQF_TRIGGER_FALLING |
+						IRQF_NO_AUTOEN |
 						IRQF_ONESHOT,
 						"HPD", conn);
 		if (ret) {

-- 
2.47.3

