Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5821910D14AC
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D0010E7AB;
	Mon, 30 Mar 2026 13:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2YqA8ZH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jX35BalB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11EF610E7AB
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UBEV8L1403185
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S/+lpfhPJyGKPek8uoVu5/C6sdT3Q8uum2gyN2ApDYY=; b=i2YqA8ZHTTDkzyZy
 9eSkbv+aR3j93V0mJ3PpjXqi12E87DnLacfuS1fk3z+UdLhDywPCHjBEpazZiAKy
 PnJMoV6y9w4P/oSskGqmUxgZ7HG3GXMkqeSjfWHewxhuxLb2PjiMJb+CyWO9c5xh
 eHZ7Fv08Y3XjR3JzvOcshApcNQbuf+hxhy/JQc1C6ciUNL9HEEGt+4hTBkSoI7ET
 5dVOelTftSvfWgdSCJR/e24dJlfKxr6moT4m3To0erfXpdDmiBULOaZTpuDzgNNY
 r2yn43jjICw07qHiH04Daa51Yif2YWr39zmS6ecSFgotytsEVO7ONDNZocw77BFu
 ALE7tw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4h8kpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4fe4ff7bso182399771cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774877164; x=1775481964;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S/+lpfhPJyGKPek8uoVu5/C6sdT3Q8uum2gyN2ApDYY=;
 b=jX35BalBgr9EQPuJ0e1KF5aYbIUumqwPyhsXrZ/lsbjqKJFpqD3pQEE4DeJSreFibg
 JPeX1q2zScK+3DCV81uTZ3kSqfMfYZDt1EeouSenwBlruyLATsTB2t7AiUK+i+V6bj5x
 mg6qBSn7V1cUCzLR0JveAevhS1hv01mi8umSFQ7z7f6IeXzEpLHAjLVXmx0NbmZqJiRq
 7sXrxl9DlG4BlynZaW+6GKgKyPfmvFEXCq80BgpnyYLUpnXHPQ7rNsyKfFJcn/xgfyHG
 1d506xk+wl7ok/Vbnhg16RaLVeAYQYTMmwBe9hNb7igDwq+fMst4/bdpkmtsBpM11q5w
 UUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774877164; x=1775481964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S/+lpfhPJyGKPek8uoVu5/C6sdT3Q8uum2gyN2ApDYY=;
 b=AiuvWrbeBjnOZnnhgw8gRWJ0MUSG2M2MAp1bppjC6g2greSvpj/azAnLcD0INCYHo0
 fdDX6uMnEF7hXkR4HG8Rzo+kNlzyataRuLIPL2DUydZgZ/v1XZrBdMsZOCL+MbO+H04l
 BYOw4vANh+VD5tiDsujg9tyVZEsnMMQfgT3FdTgB8YeMTf8I7VHcPv2+Po7LV7cdt90v
 5OCIkchL4fqxjG7YcbpELfIDuK2oSqqnBVCeostG0kdPG88B40zRGOgos+Z9MkMr2KW1
 C3A/MJwjQG9CI2FodcGeq3bGVS/VnIa9vIRMUVvg5zgxtYX9eWq4j+DKuLGcEHj0Taft
 eAjg==
X-Gm-Message-State: AOJu0YxIHvxfC5sqElTP7kzQVm6HOx0xhVLFlLXJHir1xenM9eOuk4FH
 z0XXm5x7tz/iz6HhZWOL27UDfimA6uDMmZiUoNOamWP3y4GSwieAfduZSENNpCCeptCdhMDmmeY
 TWPctASy4bGP/HweZhV0kuS/yCVZi+mGeNfStXt0iXPmoWWkhdPYowBbVDPFNGmOBQ2mmg3DnuI
 jDAUU=
X-Gm-Gg: ATEYQzwGRJVK0jfqs7lGQJA5ubWtl73YqEtFolTJhllCjTMMrYCzasUvyr3OhqAaXLM
 VbJu5IvR1tn2DDi8gxdVM7Xp5a+9izO18+R68NI3k4z9sUjuyDxHrn9rBOoe50U3ABFfcJXdUTn
 f6SPIzMiZOG1uuzRk2QM2G6dEdXJqMaqPrqYf9RsHkWbF/Ye6hUol8FUHWWhp4Uc5vc4qMffZfL
 tBeRK3pBprB+NzRJnI3+Sh7dUWmQQg59rpKnE4BwuB9ZG/nFIRNGpoME3G2Sx6bxEQfLjuDaumK
 yichd+qGTvUCB6bqZl77lk3n6VfQ1E4r09k5w/DP/XF7rH27qLDQs7YjuGZVGJRo3g8oXr8Lwcc
 yQSPQX901U97LCLQsQlLvmE5kSEoGuV1xghe4SihPFZA688C3lRJV4FdjulxP+0MR3jCnhyPbxa
 Xqfkyoc0YLWuLJ+Lvi3DjUZQUKS4FuKCNmLEk=
X-Received: by 2002:a05:622a:8f0e:b0:50b:3128:9916 with SMTP id
 d75a77b69052e-50b99410cdcmr160273161cf.18.1774877163845; 
 Mon, 30 Mar 2026 06:26:03 -0700 (PDT)
X-Received: by 2002:a05:622a:8f0e:b0:50b:3128:9916 with SMTP id
 d75a77b69052e-50b99410cdcmr160272611cf.18.1774877163313; 
 Mon, 30 Mar 2026 06:26:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13fd035sm1698928e87.18.2026.03.30.06.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:26:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 16:25:53 +0300
Subject: [PATCH 4/4] drm/panel: simple: add Waveshare LCD panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-ws-lcd-v1-4-309834a435c0@oss.qualcomm.com>
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
In-Reply-To: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11552;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cARUtvGtD11vBtFkeSEutnYfrhEMM/CC1CsBezboId4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpynnhWod1RdnnttekYSduhR+Z6oqpcUEYr96bT
 jZmyYmNxJiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacp54QAKCRCLPIo+Aiko
 1R3qCACZHd/RjPnEL9lUqmzeFXKWGoEGCFPOplBIdJakm449kLeif4nP/G/8N9rrHsjUJD0rjzG
 RymObvtZW/Ir7Kx0kHarj2Gq3B0ZPHaqja0M/w/QgdJ5b9f3Uj/4GLPyuyUbEE9DagEcTCIBtEp
 tHGsrhtHA+50Ims2/ulFTfP7NHM7kSaliaTA3L58oDubpL2oKOEfQ4p55V2u8zV0FMUmoge34NQ
 ZSZ4DLmzqVWn+v1uZEpZ6E/wT443ji1aA9uieqshLlxG6bW08Hk+eMtSAin4E7/Zgax7uK/OGn5
 LqJRhHliBTHTZo5xeU6jmFRDkCOzJOlCL5e87zp8neZsjkED
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwNSBTYWx0ZWRfX/TQeMVF8ebVh
 vhonvAtkP9jHp6BJL9SrfYJuEqAxaXRyX+WmBvRCzME48J9FDxtJe/jIVatjTSbSIIjVl8gJEZT
 XLLHQNLxPSUU7JFIM1KwBHWCqfZVKWSPp+SEUl1RwwhMhmG4SPCOWlTCNCeXNTxdsagDe8w1Vm3
 oHOqd+ZSeo8pkKqa0tr8YKFJHdAtZrosaaOPtRzqhZC8AOqKbea6JFbUjpu4dzL2YM7n2/ZKOpE
 utnxyPnYRHJRLQncndGa4kVvMY+JhdIkV7UL90GJCdWgsqmjgxQVXsT8P2pP359oZqcy0XjFo7e
 X3pJPzXOBhfKUWsgblZM6fLzB5cQFWH5nM+mVjaAwP9RfqnFdQpc/qEUegAdK7PD7qRk2J7ug39
 NoI/mB268ah9gdsU8fMq07CcAwwzljj3ajfLrl6DFdA1jeR8KMOx8XSSeYk7ipGPrB6A/tDIyr3
 dZDYZFl+RbXFtgcQ6hA==
X-Proofpoint-ORIG-GUID: Oji9QNgOFY0_sYYqcn7LLICVTn4oFzhs
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69ca79ed cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=cPmbVODp-joscUQKHs4A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Oji9QNgOFY0_sYYqcn7LLICVTn4oFzhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300105
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

Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
being attached to the DSI2DPI or DSI2LVDS bridge. The commit
46be11b678e0 ("drm/panel: simple: Add Waveshare 13.3" panel support")
added definitions for one of those panels, describe the rest of them.

Note, since the panels are hidden behind the bridges which are not being
programmed by the kernel, I could not confirm the pixel format for the
panels.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 381 +++++++++++++++++++++++++++++++++++
 1 file changed, 381 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 236bd56208cc..b2708a1fe464 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5061,6 +5061,342 @@ static const struct panel_desc vl050_8048nt_c01 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode waveshare_28_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 150,
+	.hsync_end = 480 + 150 + 50,
+	.htotal = 480 + 150 + 50 + 150,
+	.vdisplay = 640,
+	.vsync_start = 640 + 150,
+	.vsync_end = 640 + 150 + 50,
+	.vtotal = 640 + 150 + 50 + 150,
+	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
+};
+
+static const struct panel_desc waveshare_28_lcd_panel = {
+	.modes = &waveshare_28_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 44,
+		.height = 58,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_34_lcd_c_mode = {
+	.clock = 50000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 32,
+	.hsync_end = 800 + 32 + 6,
+	.htotal = 800 + 32 + 6 + 120,
+	.vdisplay = 800,
+	.vsync_start = 800 + 8,
+	.vsync_end = 800 + 8 + 4,
+	.vtotal = 800 + 8 + 4 + 16,
+};
+
+static const struct panel_desc waveshare_34_lcd_c_panel = {
+	.modes = &waveshare_34_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 88,
+		.height = 88,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_40_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 150,
+	.hsync_end = 480 + 150 + 100,
+	.htotal = 480 + 150 + 100 + 150,
+	.vdisplay = 800,
+	.vsync_start = 800 + 20,
+	.vsync_end = 800 + 20 + 100,
+	.vtotal = 800 + 20 + 100 + 20,
+	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
+};
+
+static const struct panel_desc waveshare_40_lcd_panel = {
+	.modes = &waveshare_40_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 52,
+		.height = 87,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_40_lcd_c_mode = {
+	.clock = 50000,
+	.hdisplay = 720,
+	.hsync_start = 720 + 32,
+	.hsync_end = 720 + 32 + 200,
+	.htotal = 720 + 32 + 200 + 120,
+	.vdisplay = 720,
+	.vsync_start = 720 + 8,
+	.vsync_end = 720 + 8 + 4,
+	.vtotal = 720 + 8 + 4 + 16,
+};
+
+static const struct panel_desc waveshare_40_lcd_c_panel = {
+	.modes = &waveshare_40_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 102,
+		.height = 102,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_50_lcd_c_mode = {
+	.clock = 50000,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 100,
+	.hsync_end = 1024 + 100 + 100,
+	.htotal = 1024 + 100 + 100 + 100,
+	.vdisplay = 600,
+	.vsync_start = 600 + 10,
+	.vsync_end = 600 + 10 + 10,
+	.vtotal = 600 + 10 + 10 + 10,
+	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
+};
+
+static const struct panel_desc waveshare_50_lcd_c_panel = {
+	.modes = &waveshare_50_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 109,
+		.height = 66,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_50_lcd_d_mode = {
+	.clock = 83333,
+	.hdisplay = 720,
+	.hsync_start = 720 + 100,
+	.hsync_end = 720 + 100 + 80,
+	.htotal = 720 + 100 + 80 + 100,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 20,
+	.vsync_end = 1280 + 20 + 20,
+	.vtotal = 1280 + 20 + 20 + 20,
+};
+
+static const struct panel_desc waveshare_50_lcd_d_panel = {
+	.modes = &waveshare_50_lcd_d_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 62,
+		.height = 110,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_625_lcd_mode = {
+	.clock = 83333,
+	.hdisplay = 720,
+	.hsync_start = 720 + 50,
+	.hsync_end = 720 + 50 + 50,
+	.htotal = 720 + 50 + 50 + 50,
+	.vdisplay = 1560,
+	.vsync_start = 1560 + 20,
+	.vsync_end = 1560 + 20 + 20,
+	.vtotal = 1560 + 20 + 20 + 20,
+};
+
+static const struct panel_desc waveshare_625_lcd_panel = {
+	.modes = &waveshare_625_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 66,
+		.height = 144,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct panel_desc waveshare_70_lcd_c_panel = {
+	.modes = &waveshare_50_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 155,
+		.height = 87,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_80_lcd_c_mode;
+static const struct panel_desc waveshare_70_lcd_e_panel = {
+	.modes = &waveshare_80_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,
+		.height = 95,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_70_lcd_h_mode = {
+	.clock = 83333,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 64,
+	.hsync_end = 1280 + 64 + 64,
+	.htotal = 1280 + 64 + 64 + 64,
+	.vdisplay = 720,
+	.vsync_start = 720 + 64,
+	.vsync_end = 720 + 64 + 64,
+	.vtotal = 720 + 64 + 64 + 64,
+};
+
+static const struct panel_desc waveshare_70_lcd_h_panel = {
+	.modes = &waveshare_70_lcd_h_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 155,
+		.height = 88,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_79_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 400,
+	.hsync_start = 400 + 40,
+	.hsync_end = 400 + 40 + 30,
+	.htotal = 400 + 40 + 30 + 40,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 20,
+	.vsync_end = 1280 + 20 + 10,
+	.vtotal = 1280 + 20 + 10 + 20,
+};
+
+static const struct panel_desc waveshare_79_lcd_panel = {
+	.modes = &waveshare_79_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 60,
+		.height = 191,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_80_lcd_c_mode = {
+	.clock = 83333,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 156,
+	.hsync_end = 1280 + 156 + 20,
+	.htotal = 1280 + 156 + 20 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 40,
+	.vsync_end = 800 + 40 + 48,
+	.vtotal = 800 + 40 + 48 + 40,
+};
+
+static const struct panel_desc waveshare_80_lcd_c_panel = {
+	.modes = &waveshare_80_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 173,
+		.height = 108,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_88_lcd_mode = {
+	.clock = 83333,
+	.hdisplay = 480,
+	.hsync_start = 480 + 50,
+	.hsync_end = 480 + 50 + 50,
+	.htotal = 480 + 50 + 50 + 50,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 20,
+	.vsync_end = 1920 + 20 + 20,
+	.vtotal = 1920 + 20 + 20 + 20,
+};
+
+static const struct panel_desc waveshare_88_lcd_panel = {
+	.modes = &waveshare_88_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 56,
+		.height = 220,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct panel_desc waveshare_101_lcd_c_panel = {
+	.modes = &waveshare_80_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_119_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 320,
+	.hsync_start = 320 + 60,
+	.hsync_end = 320 + 60 + 60,
+	.htotal = 320 + 60 + 60 + 60,
+	.vdisplay = 1480,
+	.vsync_start = 1480 + 60,
+	.vsync_end = 1480 + 60 + 60,
+	.vtotal = 1480 + 60 + 60 + 60,
+};
+
+static const struct panel_desc waveshare_119_lcd_panel = {
+	.modes = &waveshare_119_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 58,
+		.height = 268,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode waveshare_133inch_mode = {
 	.clock = 148500,
 	.hdisplay = 1920,
@@ -5697,6 +6033,51 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "vxt,vl050-8048nt-c01",
 		.data = &vl050_8048nt_c01,
+	}, {
+		.compatible = "waveshare,2.8inch-panel",
+		.data = &waveshare_28_lcd_panel
+	}, {
+		.compatible = "waveshare,3.4inch-c-panel",
+		.data = &waveshare_34_lcd_c_panel
+	}, {
+		.compatible = "waveshare,4.0inch-panel",
+		.data = &waveshare_40_lcd_panel
+	}, {
+		.compatible = "waveshare,4.0inch-c-panel",
+		.data = &waveshare_40_lcd_c_panel
+	}, {
+		.compatible = "waveshare,5.0inch-c-panel",
+		.data = &waveshare_50_lcd_c_panel
+	}, {
+		.compatible = "waveshare,5.0inch-d-panel",
+		.data = &waveshare_50_lcd_d_panel
+	}, {
+		.compatible = "waveshare,6.25inch-panel",
+		.data = &waveshare_625_lcd_panel
+	}, {
+		.compatible = "waveshare,7.0inch-c-panel",
+		.data = &waveshare_70_lcd_c_panel
+	}, {
+		.compatible = "waveshare,7.0inch-e-panel",
+		.data = &waveshare_70_lcd_e_panel
+	}, {
+		.compatible = "waveshare,7.0inch-h-panel",
+		.data = &waveshare_70_lcd_h_panel
+	}, {
+		.compatible = "waveshare,7.9inch-panel",
+		.data = &waveshare_79_lcd_panel
+	}, {
+		.compatible = "waveshare,8.0inch-c-panel",
+		.data = &waveshare_80_lcd_c_panel
+	}, {
+		.compatible = "waveshare,8.8inch-panel",
+		.data = &waveshare_88_lcd_panel
+	}, {
+		.compatible = "waveshare,10.1inch-c-panel",
+		.data = &waveshare_101_lcd_c_panel
+	}, {
+		.compatible = "waveshare,11.9inch-panel",
+		.data = &waveshare_119_lcd_panel
 	}, {
 		.compatible = "waveshare,13.3inch-panel",
 		.data = &waveshare_133inch,

-- 
2.47.3

