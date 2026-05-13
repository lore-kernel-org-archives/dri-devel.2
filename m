Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4944CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEC110EFDB;
	Wed, 13 May 2026 18:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XNfsmeGQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G+M4Xsza";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52EA10EFDB
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:19:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DFddUg1242772
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=; b=XNfsmeGQFhU8ajMx
 6ZfLin5pWrvji0SD+n7xnWoRwI6jvHEhE96tQTybxoqFl83uCxEMuIL+e0G9xoPI
 5ITAwvqHeptBL5IctJ25R3xQNx2FdIsaMh7/oYzwOrsosaSMHbkuxrh2cCpqttZG
 m88/D4hx8QrUdsmVYL4rjZW94GR48UyQQRJ+vGZ4Bd98QyLLkUQEoJZeKc0rVUmU
 2UbCx+JDWuNTDwc3+JKjnlQgECWLjiY6vDlJkoib9wR4G+CvG90ap6OBZrGWk/48
 nQ1CQwrMKByS9m1OKDoblafG91BcpASEt2Rs6JO3OL59RBVMYPfRtGiJYgwna10k
 H5J9Cw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4v4trmd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:19:59 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95cdcf8363bso3216030241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696398; x=1779301198;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=;
 b=G+M4XszacyC4vt5RgiOTlwg9WppJCm14qmJFl1IP2Z8RgykNC/k3TblqhmPr1PCMyy
 JolDdJp4GbHq/ezN3HCJbUpSdPNT3oRwmW/i/V9R8t1BT0AsRnAxZ9IRMX//T5WE7iUX
 KeTvELly5cRkb7ZPHpBHqlxaKVTwmpn0WKdhym7eeb+AkMScDArgItYwVS147Vkhvt5S
 25kD2cfgs0pMpaf1mxWDZIrRFq9okj96LavRMSALhJXVcq+IUWioJ0Ly5bTtBpRN/0C5
 2cJqD3PMZyP+HJWuBLUbFRmDtGPr3uOZhPHwabPJXhyLYipfDU5X5UQXDKQw1qSWaeKj
 P2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696398; x=1779301198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=;
 b=Gio2aXiJACfNQgD9LKbOoDkV3hP9xJvKS9tbqHTBjYC3EE6eaMYD0uLLVlWay6p+j/
 m+ZPvQ3mYiYKmuz79QCOiDK/9ItA9OwNsGkwejGDCYoRzpOzM2A2iaU5CkgJ9MLF2W/c
 O8QkMHo020U1NH8YnuTxFt1BPgnHGz65G4nPZf0/s3WAotgKGfkISQbG4TJLPyLRN9oY
 0AgkP3ckc2W3obFxVGEDMGDFB2rImQu23Q3MRE31vJNxrUrev55Aiv5BubkH6a82+OMU
 XxbZpKM/yFB+T0EGJkAE7gyqeVgbh2O2FZZQ4CATwSZgXS4xTTzBCUrqEr6rvpLc/Vl9
 Fc8Q==
X-Gm-Message-State: AOJu0YwBso2TeC3bViRng/8qFUrfjhnDpVbgxJk8DvqTUQ8gCX4anZhV
 J6Kj/mDxlerJkrXLodf4GG/pqHDaIXKfpdhNQ9FGGwGSfAXyLRZS74+PsDSGwF740lshXvlqUfq
 HTqa6tARJg+jbD71kys0lkpZqdV8/HFLqcAGQ2EXKeRkyvDNGtmXPH/yAA1bAK3geHdr7Hiw=
X-Gm-Gg: Acq92OEChxyA0MwXLIkcaQRt1FCNB/2LpKgEihIuChKxn5M6+suNiiFgfHGB3z1bCPs
 ks9ISAHZTX6Atgvbfyrwl7aIx17WVGCgDgdYUuBMJ5q1kLpKUraZ6xwVZgjBQDdLg4GmWRYYhvo
 eki5n1bE1PX/olHrI4qu8P3lF+EGa166EZhvDai+eLgaIh7UssinBBIkX9jMPGfOHQ+9aIF89F/
 +XqBN3MYmqeEQy8AbLE07b3SppOoQgjZ3RpQyfywNqW0pd1Nd9fOFP6/VyzX6JoYKPDPTWPz1sN
 8z7UGP9kLqVykAsseHVXa1FC77ht1v2MP7lpksq2r8GiOd3jkoHDtHFRBDiHLGqcgj9KMaNsits
 UoYyagMsGO+zRi3So4ERJ6Q+VrHD0n8SAMm6NbiuF/2t1+romoXxM91dGjLL80UUn2idycE6s2S
 bIo5nGec0dgkFa4oJhZ77OB4hTru7itJoZMx8=
X-Received: by 2002:a05:6102:f81:b0:633:3040:ca5d with SMTP id
 ada2fe7eead31-637a787588fmr2016861137.9.1778696398292; 
 Wed, 13 May 2026 11:19:58 -0700 (PDT)
X-Received: by 2002:a05:6102:f81:b0:633:3040:ca5d with SMTP id
 ada2fe7eead31-637a787588fmr2016851137.9.1778696397832; 
 Wed, 13 May 2026 11:19:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8c6f78bd7sm2685271e87.74.2026.05.13.11.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:19:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:19:51 +0300
Subject: [PATCH v2 1/2] drm/bridge: display-connector: don't autoenable HPD IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-dp-connector-hpd-v2-1-42f757bfcbf9@oss.qualcomm.com>
References: <20260513-dp-connector-hpd-v2-0-42f757bfcbf9@oss.qualcomm.com>
In-Reply-To: <20260513-dp-connector-hpd-v2-0-42f757bfcbf9@oss.qualcomm.com>
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
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uaisOO81wUqXM57ZY+50E+vgpCZk+fmw3L+QuSoJRis=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBMDJFs9UlSAQisQ+yScHFgxH3JuBibOEBWF2i
 v6nvEccs/iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagTAyQAKCRCLPIo+Aiko
 1X+UCACKSgMrzrNs4PdHxJEhlqn6Nxpp9UW8b4efeExH7c5p2TPQ1qgvJ3TWBzHMBChKHqAcVPB
 GpNosBYYpz15qob+dMPbos+wszTLig83cEUrVBboNZffQAw5rEaT0i4rWBliEN+TSjf9f52EbkO
 /pt7OH/e2cc04DO/95bMZBFdfUSEBwNW1c4tRT7CiFzfIoKp0LBaObhqOMWmBTZVMkeIUpo80Nc
 WMyG26ih35TNvV6m6cQq4QrVSLkcjPDdKU/8LsPSEM9VxJxeRm/uaketOfF4amJpjoCpPIOg7AI
 A4LXM3yQ/E1sfBTtg1I4hd7KAGMB564uIEXzCTHXEJ1QZILA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=XIIAjwhE c=1 sm=1 tr=0 ts=6a04c0cf cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=n8oM3ScPHa2hF6C7bkkA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfX73VXXouZgvRP
 Pn8A/hUsE5Gm0W+xyp96Kpw/YqE3i7+xcJHXkDXSi6b3WbrwnxHiAvlEX82vZwDsB1JcisXJrE7
 u9VY1imqZKg9q8VDx4LXupGSU+Pg839ukcN/MxQy5qBu/BB8qnGS0jvRSEeNvKNiQvl03+qCSlf
 AzYnc4kyc15LTpuB/zxXFe1J/ICskr1v223yq+G8lqNEXPaX94RTJk5WXsrxwzX4tqmAli9xXVr
 C126YGg+Ut75ly8WD+y0e3NJGAgzGFHaJimfUKqLqEBbcE4ZQmi2ieLHI4cEie4vln9FaY6AIPW
 Kq99bhlZ35ApMXNqY6RSpYhCQI3oY+opE1ideNe4tK/72n/cgGwtIvHUuZGl3yUoUPWuw4g9ZhH
 SYOLOSdy9QY5/IWTuKtREt8NR53dH4gDlf+bpYOjvH9ANWVW4zgb3BIVPcaok9kOVaaTZu7PCmn
 X2BhmCXT2ZpwLI0FtJQ==
X-Proofpoint-ORIG-GUID: KlIhvdIagc8oJhfopAKW-npOYOCqAWZi
X-Proofpoint-GUID: KlIhvdIagc8oJhfopAKW-npOYOCqAWZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130182
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

