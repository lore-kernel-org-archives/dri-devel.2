Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117B4F34C49
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722D610E49A;
	Mon, 13 Apr 2026 14:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LG5NY+Pi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2B8J86u";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C9910E49F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDwPPQ3567929
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nZzwGnW+MUE+QNALit7cwinZB2Bkr8D00pSmlzKzjwY=; b=LG5NY+Pi0JSGKiq6
 h96u85L/ucDxf1wx8QW51qoTgaaO9/qaMZWUqDBdQEEuv9zRF/ZePEOf5Cma21ox
 R0Kq+jCof/SVZsN/Fgmsb6BG3byOJYUDmBOtyk8cewgebFbhAneCg/l0ciJGA0cz
 bLFmvVQ954usSpdjhK5Ugk38IHR6txlw3pI1XTKwCA04WR6h+5b8xDl7u1+llTbS
 720cmazg5ZXNtKF78P4A/0V+QDpZzFSRuGCWXUdKM09Lq9riWmJ53HG881khHBe9
 Sc328R3EmjBCAcvMCO9dBublqJt51XX4YNcRQGi/p26VXQE+BWvOHdahvSgerPcy
 nByc7g==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1uf01bn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:20 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-472d903d34eso5775588b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089180; x=1776693980;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nZzwGnW+MUE+QNALit7cwinZB2Bkr8D00pSmlzKzjwY=;
 b=F2B8J86uRtZr2EoU96tVA5eIzAXzeGxMpmT8gA+yUw9eMgbDZPndyKElITVG734AiG
 WdVyRHsOqkFpdmlMswY6QEc7uvWtT5QWFDsRIY6QsKAZESuza58u6JDIbRKjLciMIWg7
 P+fnMTnojTvPvPgjo/40MjMY9w7nZRBjkx3tuuaMioiU7nOIeSA+CHSzG5yyI3wtRu2d
 evq8+j209pCJqfgCjbuoiWEY6sTDA7tB9XVszwIUfFukU8/aVu/zrBtXb7V/lkX93u92
 efmXA6z3CHSCR8gAs12T6AsoiKrOOkIu54pwZSQr5rlh4R0sRG6byiM2jTcjLw9ml6Wk
 PQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089180; x=1776693980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nZzwGnW+MUE+QNALit7cwinZB2Bkr8D00pSmlzKzjwY=;
 b=BsfumiaOzG/EJGa/e/Txd5vI5p4btv9IBO1J5zHWiXGECTOYisi126aOECU7Ghrdfd
 GOrbG9YKRTktLMv2LycY1DWTsRgzfSe3gcyuw57Dsbl7bjU+Q7n24tFfIjQEvvFZd1P4
 1sApfEbUWN1NUcv0YJ+d5V0rbnCBblBjBpWbolyY1QqhfuxzZyi5/8ZeRrM0avK9V3R5
 NVRHkP6pGwTqsSJ+HMWMZIQ1zpobKYp7ZjIkTy0An4h9CLCORzpUAXYk6jJjZELXAj66
 6FlkKDqb5fJvFn8QQOEu6GgdrPjt7QS+iFMxXoL9lS9Gn0eS9gGQeK5R+cB+nD4q7LR+
 85WA==
X-Gm-Message-State: AOJu0YxzMRrnJsc9owHZFbh/0bW02hxbkfT9Kdc71taIJgqW8TQuLHjA
 I8HihH4wmiDQPtbsgl/UjlYz9ZlYRMQSm7D3dASh4l7xsm6V9fvivHuvZihZ/QKZOe8Cyw/yHdx
 8fqBcgeopGwgT1PNQ53P5TLHjMLo9BRlaYSMJy9d9pgPU6ML4au7+y8voHtK9JrPsy0a99y8=
X-Gm-Gg: AeBDieunJ1DdqyEBgZ8UTmsmWt5rplKG6j+dIz8ipiBydv6KZHoSkDrNBZ+sx5TUnsj
 OcxMww9dwy3P/t26TLBTQhOLod/zKAdkz6D/HaRRGQ2HyWoztdgFJ9zvQFR9zfm9dMDO4jtfyWJ
 MHOfZY4ZLcih7LzPUZOyg69Csu+I9+DmekJv730zmT+nHZ+i2hECLfPg9kQhlv4vud5EplLM7K6
 8Th1/uoi9Lw3MKDzBMkRmEA7egIk7mGg/dUU6HSPWme21RJRPId2HcCn5drO94EGvykdy7jofl9
 r4YOUwcjWBdpTrvlRNhDI2LLayJi0/KjO7/cmmGlgcHGSjCT1/Q4xRvD/UUeKCiADm/ZT95gGkl
 h4dpFx+biu0wyfTY3wbKqK1/qXBPa1+TAyStdL8swQg2iOIPYWDE0hZjB8OunAGUyCYblS0J5DT
 U8YxM0gJF2MY7C4qBtgVPtJ4yZAQXm+Iozd5E=
X-Received: by 2002:a05:6808:1522:b0:467:14c7:a8ae with SMTP id
 5614622812f47-4789e622f86mr6479129b6e.21.1776089179608; 
 Mon, 13 Apr 2026 07:06:19 -0700 (PDT)
X-Received: by 2002:a05:6808:1522:b0:467:14c7:a8ae with SMTP id
 5614622812f47-4789e622f86mr6479077b6e.21.1776089179019; 
 Mon, 13 Apr 2026 07:06:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:40 +0300
Subject: [PATCH v3 17/21] drm/panel: ilitek-ili9881c: support Waveshare
 7.0" DSI panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-17-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11997;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GeCr1NynOzRyMTA3YNx3AI6OZgpUDXwfoJ9GX7n6oNY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgoEazS3iiLO6YPAUW3BcEYAgTzIFkPsjNP/
 QRyhQlsK5uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KAAKCRCLPIo+Aiko
 1YF6B/9s5dpc02hK1GowswGbkgaW/Srn1QWdWLtkNXUCTW+nUCISzCR1uAjMDXTk3cx6SycTUwq
 x6fau7FwhBVv3PCFbHhS/swt56IDjJJMP26AcINYxA8QfBsrVUzrTEqGxLV2LMBEbceSgoCcowu
 o24m15wGccUyHLy7+2u+9Q2ZuuLRbUxsqE+99mrbgPC8dh4ioGgWtPytJ3qCS9YArUEu1UHuQ7C
 O+n7QscJixTIC8b3bcQnqDHB3Dg6ITGMf8l1kfVxgAQ1SnUGAaUWycdLkLyKhk8ZketPPWF2RCi
 VpshToFco7+EyPZ9Mfvaj+KuzbXuenM74tc76omgjtLNxrDA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Dc4nbPtW c=1 sm=1 tr=0 ts=69dcf85c cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Vzx2zukWpxHvXuQtFQgA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: VEVseBLCH-WN-oyGy6qaB9MNl1gsJPDc
X-Proofpoint-GUID: VEVseBLCH-WN-oyGy6qaB9MNl1gsJPDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzNyBTYWx0ZWRfX7rJTOXudT4I8
 NBDFcDuEuY4hbwki7FqxBQixZOQHmE2ia+deU1YCXZH1Sj0mdhfXDp/hY9Vt/l2Z0b53+s9bVV0
 clVIvhBMP2mHWdRXii5wYic92F+am8KOLVB8cWNHvzGYy8zEBiUNZi/rqq5W5oLSZlLEut7BEfM
 zJ8gBSuk2sdXuzznEMaVuEqUOc71r+6Xof4cRgMFXD6myqlvG8wsDR8CVgz1zrREoKXlugWhLD2
 Xv/eB1yHe8vHVuUYPC+eVr0+yEC/rYoyaDRMt72V7Acdqa08dA/dlkXgCIl2lGZfb8NCX6uXahm
 /73hagzoUT+qVdDaji4jpbOJrYXfhuCSoU8PR5PBL9obMNM3cHvhMZM2xZIcGlDGvYMOtg98DHa
 rfAbWUKQXwaEXOhwygQruGyIEbXubx+YiSIOH68eE325905wC0r5D/5ECeFRgTywtSi6XY5/MBG
 bvImZ62awLidV+2cAjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130137
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

Enable support for Waveshare 7.0" DSI TOUCH-A panel. It requires
additional voltage regulator, iovcc.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 251 +++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 947b47841b01..0652cdb57d11 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -52,6 +52,7 @@ struct ili9881c {
 	const struct ili9881c_desc	*desc;
 
 	struct regulator	*power;
+	struct regulator	*iovcc;
 	struct gpio_desc	*reset;
 
 	enum drm_panel_orientation	orientation;
@@ -1997,6 +1998,205 @@ static const struct ili9881c_instr bsd1218_a101kl68_init[] = {
 	ILI9881C_COMMAND_INSTR(0xd3, 0x3f),
 };
 
+static const struct ili9881c_instr waveshare_7inch_a_init[] = {
+	ILI9881C_SWITCH_PAGE_INSTR(3),
+	ILI9881C_COMMAND_INSTR(0x01, 0x00),
+	ILI9881C_COMMAND_INSTR(0x02, 0x00),
+	ILI9881C_COMMAND_INSTR(0x03, 0x73),
+	ILI9881C_COMMAND_INSTR(0x04, 0x00),
+	ILI9881C_COMMAND_INSTR(0x05, 0x00),
+	ILI9881C_COMMAND_INSTR(0x06, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x07, 0x00),
+	ILI9881C_COMMAND_INSTR(0x08, 0x00),
+	ILI9881C_COMMAND_INSTR(0x09, 0x61),
+	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0c, 0x01),
+	ILI9881C_COMMAND_INSTR(0x0d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0f, 0x61),
+	ILI9881C_COMMAND_INSTR(0x10, 0x61),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x12, 0x00),
+	ILI9881C_COMMAND_INSTR(0x13, 0x00),
+	ILI9881C_COMMAND_INSTR(0x14, 0x00),
+	ILI9881C_COMMAND_INSTR(0x15, 0x00),
+	ILI9881C_COMMAND_INSTR(0x16, 0x00),
+	ILI9881C_COMMAND_INSTR(0x17, 0x00),
+	ILI9881C_COMMAND_INSTR(0x18, 0x00),
+	ILI9881C_COMMAND_INSTR(0x19, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1e, 0x40),
+	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
+	ILI9881C_COMMAND_INSTR(0x20, 0x06),
+	ILI9881C_COMMAND_INSTR(0x21, 0x01),
+	ILI9881C_COMMAND_INSTR(0x22, 0x00),
+	ILI9881C_COMMAND_INSTR(0x23, 0x00),
+	ILI9881C_COMMAND_INSTR(0x24, 0x00),
+	ILI9881C_COMMAND_INSTR(0x25, 0x00),
+	ILI9881C_COMMAND_INSTR(0x26, 0x00),
+	ILI9881C_COMMAND_INSTR(0x27, 0x00),
+	ILI9881C_COMMAND_INSTR(0x28, 0x33),
+	ILI9881C_COMMAND_INSTR(0x29, 0x03),
+	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x30, 0x00),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x32, 0x00),
+	ILI9881C_COMMAND_INSTR(0x33, 0x00),
+	ILI9881C_COMMAND_INSTR(0x34, 0x04),
+	ILI9881C_COMMAND_INSTR(0x35, 0x00),
+	ILI9881C_COMMAND_INSTR(0x36, 0x00),
+	ILI9881C_COMMAND_INSTR(0x37, 0x00),
+	ILI9881C_COMMAND_INSTR(0x38, 0x3c),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x40, 0x00),
+	ILI9881C_COMMAND_INSTR(0x41, 0x00),
+	ILI9881C_COMMAND_INSTR(0x42, 0x00),
+	ILI9881C_COMMAND_INSTR(0x43, 0x00),
+	ILI9881C_COMMAND_INSTR(0x44, 0x00),
+	ILI9881C_COMMAND_INSTR(0x50, 0x10),
+	ILI9881C_COMMAND_INSTR(0x51, 0x32),
+	ILI9881C_COMMAND_INSTR(0x52, 0x54),
+	ILI9881C_COMMAND_INSTR(0x53, 0x76),
+	ILI9881C_COMMAND_INSTR(0x54, 0x98),
+	ILI9881C_COMMAND_INSTR(0x55, 0xba),
+	ILI9881C_COMMAND_INSTR(0x56, 0x10),
+	ILI9881C_COMMAND_INSTR(0x57, 0x32),
+	ILI9881C_COMMAND_INSTR(0x58, 0x54),
+	ILI9881C_COMMAND_INSTR(0x59, 0x76),
+	ILI9881C_COMMAND_INSTR(0x5a, 0x98),
+	ILI9881C_COMMAND_INSTR(0x5b, 0xba),
+	ILI9881C_COMMAND_INSTR(0x5c, 0xdc),
+	ILI9881C_COMMAND_INSTR(0x5d, 0xfe),
+	ILI9881C_COMMAND_INSTR(0x5e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x5f, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x60, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x61, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x62, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x63, 0x06),
+	ILI9881C_COMMAND_INSTR(0x64, 0x07),
+	ILI9881C_COMMAND_INSTR(0x65, 0x02),
+	ILI9881C_COMMAND_INSTR(0x66, 0x02),
+	ILI9881C_COMMAND_INSTR(0x67, 0x02),
+	ILI9881C_COMMAND_INSTR(0x68, 0x02),
+	ILI9881C_COMMAND_INSTR(0x69, 0x01),
+	ILI9881C_COMMAND_INSTR(0x6a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6b, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6c, 0x15),
+	ILI9881C_COMMAND_INSTR(0x6d, 0x14),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x70, 0x02),
+	ILI9881C_COMMAND_INSTR(0x71, 0x02),
+	ILI9881C_COMMAND_INSTR(0x72, 0x02),
+	ILI9881C_COMMAND_INSTR(0x73, 0x02),
+	ILI9881C_COMMAND_INSTR(0x74, 0x02),
+	ILI9881C_COMMAND_INSTR(0x75, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x76, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x77, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x78, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x79, 0x06),
+	ILI9881C_COMMAND_INSTR(0x7a, 0x07),
+	ILI9881C_COMMAND_INSTR(0x7b, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7c, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7d, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7f, 0x01),
+	ILI9881C_COMMAND_INSTR(0x80, 0x00),
+	ILI9881C_COMMAND_INSTR(0x81, 0x02),
+	ILI9881C_COMMAND_INSTR(0x82, 0x14),
+	ILI9881C_COMMAND_INSTR(0x83, 0x15),
+	ILI9881C_COMMAND_INSTR(0x84, 0x02),
+	ILI9881C_COMMAND_INSTR(0x85, 0x02),
+	ILI9881C_COMMAND_INSTR(0x86, 0x02),
+	ILI9881C_COMMAND_INSTR(0x87, 0x02),
+	ILI9881C_COMMAND_INSTR(0x88, 0x02),
+	ILI9881C_COMMAND_INSTR(0x89, 0x02),
+	ILI9881C_COMMAND_INSTR(0x8a, 0x02),
+
+	ILI9881C_SWITCH_PAGE_INSTR(4),
+	ILI9881C_COMMAND_INSTR(0x38, 0x01),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6c, 0x15),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x2a),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x33),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x94),
+	ILI9881C_COMMAND_INSTR(0x8d, 0x14),
+	ILI9881C_COMMAND_INSTR(0x87, 0xba),
+	ILI9881C_COMMAND_INSTR(0x26, 0x76),
+	ILI9881C_COMMAND_INSTR(0xb2, 0xd1),
+	ILI9881C_COMMAND_INSTR(0xb5, 0x06),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x98),
+
+	ILI9881C_SWITCH_PAGE_INSTR(1),
+	ILI9881C_COMMAND_INSTR(0x22, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x53, 0x71),
+	ILI9881C_COMMAND_INSTR(0x55, 0x8f),
+	ILI9881C_COMMAND_INSTR(0x40, 0x33),
+	ILI9881C_COMMAND_INSTR(0x50, 0x96),
+	ILI9881C_COMMAND_INSTR(0x51, 0x96),
+	ILI9881C_COMMAND_INSTR(0x60, 0x23),
+	ILI9881C_COMMAND_INSTR(0xa0, 0x08),
+	ILI9881C_COMMAND_INSTR(0xa1, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xa2, 0x2a),
+	ILI9881C_COMMAND_INSTR(0xa3, 0x10),
+	ILI9881C_COMMAND_INSTR(0xa4, 0x15),
+	ILI9881C_COMMAND_INSTR(0xa5, 0x28),
+	ILI9881C_COMMAND_INSTR(0xa6, 0x1c),
+	ILI9881C_COMMAND_INSTR(0xa7, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xa8, 0x7e),
+	ILI9881C_COMMAND_INSTR(0xa9, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xaa, 0x29),
+	ILI9881C_COMMAND_INSTR(0xab, 0x6b),
+	ILI9881C_COMMAND_INSTR(0xac, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xad, 0x18),
+	ILI9881C_COMMAND_INSTR(0xae, 0x4b),
+	ILI9881C_COMMAND_INSTR(0xaf, 0x20),
+	ILI9881C_COMMAND_INSTR(0xb0, 0x27),
+	ILI9881C_COMMAND_INSTR(0xb1, 0x50),
+	ILI9881C_COMMAND_INSTR(0xb2, 0x64),
+	ILI9881C_COMMAND_INSTR(0xb3, 0x39),
+	ILI9881C_COMMAND_INSTR(0xc0, 0x08),
+	ILI9881C_COMMAND_INSTR(0xc1, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xc2, 0x2a),
+	ILI9881C_COMMAND_INSTR(0xc3, 0x10),
+	ILI9881C_COMMAND_INSTR(0xc4, 0x15),
+	ILI9881C_COMMAND_INSTR(0xc5, 0x28),
+	ILI9881C_COMMAND_INSTR(0xc6, 0x1c),
+	ILI9881C_COMMAND_INSTR(0xc7, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xc8, 0x7e),
+	ILI9881C_COMMAND_INSTR(0xc9, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xca, 0x29),
+	ILI9881C_COMMAND_INSTR(0xcb, 0x6b),
+	ILI9881C_COMMAND_INSTR(0xcc, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xcd, 0x18),
+	ILI9881C_COMMAND_INSTR(0xce, 0x4b),
+	ILI9881C_COMMAND_INSTR(0xcf, 0x20),
+	ILI9881C_COMMAND_INSTR(0xd0, 0x27),
+	ILI9881C_COMMAND_INSTR(0xd1, 0x50),
+	ILI9881C_COMMAND_INSTR(0xd2, 0x64),
+	ILI9881C_COMMAND_INSTR(0xd3, 0x39),
+
+	ILI9881C_SWITCH_PAGE_INSTR(0),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x77),
+	ILI9881C_COMMAND_INSTR(0x36, 0x00),
+};
+
 static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel)
 {
 	return container_of(panel, struct ili9881c, panel);
@@ -2035,9 +2235,19 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	int ret;
 
 	/* Power the panel */
+	if (ctx->iovcc) {
+		ret = regulator_enable(ctx->iovcc);
+		if (ret)
+			return ret;
+	}
+
+	msleep(5);
 	ret = regulator_enable(ctx->power);
-	if (ret)
-		return ret;
+	if (ret) {
+		mctx.accum_err = ret;
+		goto disable_iovcc;
+	}
+
 	msleep(5);
 
 	/* And reset it */
@@ -2074,6 +2284,9 @@ static int ili9881c_prepare(struct drm_panel *panel)
 
 disable_power:
 	regulator_disable(ctx->power);
+disable_iovcc:
+	if (ctx->iovcc)
+		regulator_disable(ctx->iovcc);
 	return mctx.accum_err;
 }
 
@@ -2085,6 +2298,8 @@ static int ili9881c_unprepare(struct drm_panel *panel)
 	mipi_dsi_dcs_set_display_off_multi(&mctx);
 	mipi_dsi_dcs_enter_sleep_mode_multi(&mctx);
 	regulator_disable(ctx->power);
+	if (ctx->iovcc)
+		regulator_disable(ctx->iovcc);
 	gpiod_set_value_cansleep(ctx->reset, 1);
 
 	return 0;
@@ -2260,6 +2475,23 @@ static const struct drm_display_mode bsd1218_a101kl68_default_mode = {
 	.height_mm	= 170,
 };
 
+static const struct drm_display_mode waveshare_7inch_a_mode = {
+	.clock		= 83333,
+
+	.hdisplay	= 720,
+	.hsync_start	= 720 + 120,
+	.hsync_end	= 720 + 120 + 100,
+	.htotal		= 720 + 120 + 100 + 100,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 10,
+	.vsync_end	= 1280 + 10 + 10,
+	.vtotal		= 1280 + 10 + 10 + 10,
+
+	.width_mm	= 85,
+	.height_mm	= 154,
+};
+
 static int ili9881c_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
@@ -2329,6 +2561,11 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->power),
 				     "Couldn't get our power regulator\n");
 
+	ctx->iovcc = devm_regulator_get_optional(&dsi->dev, "iovcc");
+	if (IS_ERR(ctx->iovcc))
+		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
+				     "Couldn't get our iovcc regulator\n");
+
 	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset))
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
@@ -2454,6 +2691,15 @@ static const struct ili9881c_desc bsd1218_a101kl68_desc = {
 	.lanes = 4,
 };
 
+static const struct ili9881c_desc waveshare_7inch_a_desc = {
+	.init = waveshare_7inch_a_init,
+	.init_length = ARRAY_SIZE(waveshare_7inch_a_init),
+	.mode = &waveshare_7inch_a_mode,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_HSE |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.lanes = 2,
+};
+
 static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "bananapi,lhr050h41", .data = &lhr050h41_desc },
 	{ .compatible = "bestar,bsd1218-a101kl68", .data = &bsd1218_a101kl68_desc },
@@ -2462,6 +2708,7 @@ static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "tdo,tl050hdv35", .data = &tl050hdv35_desc },
 	{ .compatible = "wanchanglong,w552946aaa", .data = &w552946aaa_desc },
 	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
+	{ .compatible = "waveshare,7.0-dsi-touch-a", .data = &waveshare_7inch_a_desc },
 	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
 	{ .compatible = "raspberrypi,dsi-5inch", &rpi_5inch_desc },
 	{ .compatible = "raspberrypi,dsi-7inch", &rpi_7inch_desc },

-- 
2.47.3

