Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DDF10D14AC
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F8D10E793;
	Mon, 30 Mar 2026 13:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RUwJIzcR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TpiPZrHu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1D610E793
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:25:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UBZY3r4013478
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bTkKqjb3febqgGGkY27aCe
 3TOl6iz5FKhdgqauH7KP8=; b=RUwJIzcRBuqItOygHor1zOFtp6PncwOEx8X6HM
 txhFgav2Jy49qNrTS2rQrgrFWAD1zPCcIfqumNCZbGtQtoobO/dYRR4gsPSAJuDs
 Z7TlpCzwQvCaQg02Z2Qfze2/D3bVsyVgT4u4M88PxIUKAQqOQokOdR4TnFvhJepP
 +P3Aj8nqCvE7IpjIDbm/gSkRNDE0FWTBEtGouKmQCTtcA9+YKz8zPfNf/f0XrD/M
 2B4Ffo1eery72rO0PVOCHKoozRldsf8loHmt366pBzqs8lUDCQ1dX307/JX7WcYT
 +N/I1kZylA6HgAEx2ToOIrK92ehZTaSvNbMqtG9O0EEtnqVg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regre6n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:25:57 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-953c062b2bdso1679223241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774877156; x=1775481956;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bTkKqjb3febqgGGkY27aCe3TOl6iz5FKhdgqauH7KP8=;
 b=TpiPZrHuGg8RXi95tgHR0zGHwoHwGHqZYEfjC7tL9Y1Mbe/WFziucWu8WAPXBadZYT
 LpVqw/wldnfJffLs8hGoUdIQM05k63X3Y7Og98u7woBo57zilQSXgTPQY7NGlt4zUSTZ
 U3vHbVqY0g28rCUVXKcaDakhlm5f3beyiOVUwS/sQ6UZy4EYNvxWcE+m0vvyxilPzWGA
 Vy3ogi8S/2xc6bIt0BUyOQpmmd5WjeQmrMSC4HYsM0jyftHf5x9ggms8BUs+g1B2lIHJ
 Z5IMd+7ym/6q1W+HC1bzVkhZ5adzKZd8SG9e48hdRS5SGivd6LWc4laBAEVFB+uBo+Eo
 eSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774877156; x=1775481956;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTkKqjb3febqgGGkY27aCe3TOl6iz5FKhdgqauH7KP8=;
 b=aeNqcElGA0SwHlJpCRc1XnZnqyM82txHydnLfpRG3iYiEs1GHq0FgJt6Yc0cuRT+wb
 rb0MsgnuuBnPCCJ1g/mmF9azGYRGT8J2Vrp2QtrnxQdtBx/Sl+KzOKpSqf5DGwUa5402
 OTkqr14v8XAnHudQlnnAmMI0lttV9wVd1X4GTpx7ORwd19KPfu4Y2xuYF9u4/7H3whcC
 xMnP6NN6MGqw5BMi4FOUeHESDO0dtKwU7Q35vtuuowZDcXl0MUdt0CCpuPqU69oZuysC
 sa3xy3jsqZoiLuqaQZopk+QIbRyXqvBIzGzQ5BvuKTCQLpjvXbFvHv1vvhrL+m60RDsr
 KsSA==
X-Gm-Message-State: AOJu0YzjSLr6MYGJNPwb1PNUvp0pXulowRVeQIxiQHqyltbNaA0Ir2rE
 kYobG1eFUML2tCenIaZ7lIp5+e5KtXvYlUyuQ3ciA4mZGvYL4Cqg2dHEX3Gcv3EBNfMJ5tHjj9e
 rti+gEqF2Q0Vzhvo7sa69WE2dKTMI/Jw0+4VZsNS77Sk3KDArd1+mIdDwR8CSuWXG8tIstw5wss
 uHBIw=
X-Gm-Gg: ATEYQzyJF6CIlRZz05lDtmwEgubfPJxEqWftpbRIoAHI4iBCqJmiGQBWR8sc4wIYaad
 OssOo7dGY5EDQPP7fPP7Ac1Bc8tTGMAI+HOoJZOTw8HOc8dIe2E7AFQVSR86uFpsmoZQf99KhOl
 98TRENeq964npOjeg0eGsYezGAdhpIHgVCGPYcmCX32RM7guQSDUvV/+GbDDKSxDYIAmNdocHpH
 LXHiQuKem6IpZQ8N1CDGGxwM/bDV/yJmeLJKuQzuZUvwMgU9QlLh5gZzoTjIR/UQYkM04lrbYXs
 nKR9PpnZek0wr2vAVTq0983zPsp5jhILnEqeIPFwN1edrKkzVw+gjhiw5Qdruyb2VVs3LraKeP/
 ds7D3sHx/aFRvD19j/l8vvw1TtceRkoqcnoRU6TaJF3fxH1epGsYyNNndxOL7UEG7nkcjeqoiuR
 gN4mxiRVwJHC2gLyjQ5V4bQSKg2e8aZ+Vq4SE=
X-Received: by 2002:a05:6102:440c:b0:604:f640:301e with SMTP id
 ada2fe7eead31-604f90dd722mr4919585137.12.1774877155849; 
 Mon, 30 Mar 2026 06:25:55 -0700 (PDT)
X-Received: by 2002:a05:6102:440c:b0:604:f640:301e with SMTP id
 ada2fe7eead31-604f90dd722mr4919571137.12.1774877155382; 
 Mon, 30 Mar 2026 06:25:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13fd035sm1698928e87.18.2026.03.30.06.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:25:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/4] drm/panel: simple: add Waveshare LCD panels
Date: Mon, 30 Mar 2026 16:25:49 +0300
Message-Id: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN15ymkC/yXM3QpAQBCG4VvRHNtatqXcihwwBiOhHX+lvXeLw
 6fe77tByDEJFNENjg4WXuaAJI4Ah3ruSXEbDKlOM22MVqeoCVvVZBa1QVtjkkOIV0cdX99RWf2
 WvRkJt3cN3j+lS7W5agAAAA==
X-Change-ID: 20260330-ws-lcd-b65c03c5ac17
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AihcmDk2VyR0rLrDcXmoxpO9Dy0ChhiWDN8sIx/tGh4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpynngccZWm0WT+tgmV6loKdff1Ed9IH8jGTT/O
 Y++41W7GPKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacp54AAKCRCLPIo+Aiko
 1V17B/9xII+jDJmOps0JIIYTMZY7j2t7dc0PG3Bkt2H4vc8kALkhEFEmgNomRCA7hgv5xMC0k5Z
 68j2JTF2EXZ7g6u4B08XQ/AzLul1tw4PieHAeZd0MTV0CVHRgn9p4wSplQEUXFBlg0N2yvDczme
 4gRDJbGxD0EqCRGXrrIgzLBGmkKkwb7jha+FfXWnD/Hbjht8J1G0/jyQnN9cY49DTSe+grX96t0
 ttw1IGEXWK8Xieb4hDVFPHJnHE0ezyfPGNedM4PprFSr/QZdrxr6nMH/xmCY3dYwHbz2OU7UdNJ
 EJK10zi9Bq6AQTsh/hqKVnO4QikczbjgytPO3k5V0aLNrTbI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69ca79e5 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Lb5j-gmOE-iAMMu9PAMA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwNSBTYWx0ZWRfX8BYLqKmNqPXx
 my2my9lBXuy8XvWTQCJvM8zZIT5i66Boa1+DfbT+mCfF1wbb1yvvf9wZGj1If7Ho7xmM+7tzzOA
 VsV0uM+AKjGQwJUFC6Q1Y/etB6H+XLF/+hMri786LLblqBvC9rwI32sK4kpJucKDFUc0VjaFsGI
 UFdFq6xDEPVFtO2cwtap7NUI37pO/+9NrVlA0y4bpVbWC6vETz7f4VNbc4lyEqVX7dKIXafZyis
 O2VJJ2U2aasca8niRE0qD21v8jPHtVp+ammttdjxP3eU1CoCo6LTc/wzo+hUc6vjphI1eq0n5IW
 FNq708U3B/b/mAd7CDvifOshqXVn5/hS06Hxm1eKT5ZcXqZr19+B8kUGkKHlFkEpwoC5flU428O
 XLfhmR8Fb/OSlZ/dSS3bbML4WmfFf9Bf5pR96LmA0W5rz40Ry5juCJAQ+KsI4H6hBOjv56jx7Vb
 GBMxDPNwW9flKNi+b7A==
X-Proofpoint-ORIG-GUID: MM2ET37LL5FolqW1s_8a_BgkDPMVB5Er
X-Proofpoint-GUID: MM2ET37LL5FolqW1s_8a_BgkDPMVB5Er
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
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
being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
("dt-bindings: display: panel: Add waveshare DPI panel support")
described two of them in the bindings and commit 46be11b678e0
("drm/panel: simple: Add Waveshare 13.3" panel support") added
definitions for one of those panels. Add support for the rest of them.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (4):
      dt-bindings: display: waveshare,dsp2dpi: describe DSI2LVDS setup
      drm/bridge: waveshare-dsi: support DSI LCD kits with LVDS panels
      dt-bindings: display: panel: add Waveshare LCD panels
      drm/panel: simple: add Waveshare LCD panels

 .../bindings/display/bridge/waveshare,dsi2dpi.yaml |   4 +-
 .../bindings/display/panel/panel-simple.yaml       |  28 ++
 drivers/gpu/drm/bridge/waveshare-dsi.c             |   5 +-
 drivers/gpu/drm/panel/panel-simple.c               | 381 +++++++++++++++++++++
 4 files changed, 415 insertions(+), 3 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260330-ws-lcd-b65c03c5ac17

Best regards,
--  
With best wishes
Dmitry

