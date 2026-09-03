Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812F6C624D3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B123B10EE92;
	Thu,  3 Sep 2026 03:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwNvRL0G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EZLpqqVX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F08E110EE92
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 03:34:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6832xugc2813994
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 03:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YsL7iQZmCzBBBew3E4bbH+fx6exYIogFa3gd42Otras=; b=jwNvRL0GQHZMXdky
 laLb+4ABcQ/dE8+QoglcxOuocYhJ/yvCiXMp4X73WF3xzPYG6xCtxoAODyAObNwb
 gwPcR/8i0CypKElQDtx4UIJr2y8ZsXoSxv15hYks4yAIJCLraLucP5CCpHoR7hFP
 gT/btMadOEIyRpaQi2KCxWmBeUMfzsYATIneuh9jW8UwEvHJSb1lbHi1IpcosKX2
 ksNbkr+jiDVgy2cg5oLZapSdEl7dTg/4MpsBc6KE1U5IJpW29Uz+RrxoiyW9rfCb
 nWrBGPPIC7e9JbOmwC9vgcniZ4wSrQc+RhXTxKdBh+FPhHygrmzJjfp5VVf7bJK3
 3hq9Ng==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4u87g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 03:34:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ddc70b9d5so397312a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788406485; x=1789011285;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YsL7iQZmCzBBBew3E4bbH+fx6exYIogFa3gd42Otras=;
 b=EZLpqqVXwV7SXAo1Beft07H3UMPXLAxYicKTTCr6ssFpqneykb1zBk/xSgTui/p8u4
 wQt6hHGP8/OMJfWAzQwnsSQn7CaHs8tdNcNevIn/LFkfAV+hG8G/SrwNCXmQBddt2pZL
 wi0wNbiLEZMOVf6Q1rjqorClKbHnRDcOGj/N4mWybh4L8tQIKmwe2pT6HSQGyMeEFPHE
 4hf3TMbxuQ4dm1hMJiA5WX+aDASxhimW6HmGVVLm8hNIDjaPX1JorGCtCVzLn6b/11vI
 uL3aLPKA7noqiuDvBwPpSR7Ig6jL7GbCBfYBZKHkIua99cISYraFZDLiz8IwV1UuuiJ5
 o/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788406485; x=1789011285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YsL7iQZmCzBBBew3E4bbH+fx6exYIogFa3gd42Otras=;
 b=UtO8HQNjm7zagHHPfY2L3DiPjLYJnFNAvhPhqWnn0Wt3oREHFEkk4zVyScmyYUxOyo
 dxoPm+JqWi7CdTW9RD7V99tmNV+qs0IPONHLF0W5jO2ABnHKCm0PNd7+JjXu64XOGfuN
 eP7Bx4MxOt8yyUp6xEqw800gz3PlKVT0v/89nXm5d1VDe8ZxxbpZqEOdvTHz67ZEh9vR
 qrUhv3oumX+WrbGM8SxgdxMr5bStLfQYdHnGF0wUQfLnFL4h4MZA9NpXaKxNId5eto6x
 5P4EndilwFzQIpukitTTiQiCvyBEbc+9UokK5WQT53d6wUp0t5txUCa6q8fLZjw9Vpwo
 /u+A==
X-Gm-Message-State: AFuF++l9iQ/A4Y7/5LF+JzDWnZaM6/7mPoKWTKvoCvxGjekvpsTWqV0Y
 h1SkEju4J/Ri00Tq/RGQ0UNLLhvulFB+4cZNfj6pbmfiv6nb/PexWFiPyu/tEwufGep4zKh3j2G
 +sNLku5BnxNHBUgLdLvN79fiueqQMw+n9FLzhau3Mu7REn33UO0Ex3rS1gK5MqBqKk6ztg34d9+
 MB1yE=
X-Gm-Gg: AYBFou3c4o3vxpW6uwi5LjoaqeDf3ElVLZf8TFPzt6+jTm2Vt98uH/1Cqt6QMvr+Um/
 UlIkXTxkX9B7n3Ys9O+onh94u8hWVrfBWfn3Y8gDIMoxY4KvtYTpnUVuIvbE6pBGYdt0LceLNnz
 8xfK0JcmmqVD9Kobhacl8JlPVDOOGNzaqOO2hCNRoTGyFVdQgLo+w0+0Pr0tKmhK7RWpu6kIuAr
 SdMn3q7gSjXLNRe9GAd+PAaJrJAVkmN09nPGODVy1HnJYEvNycvdRzK0W2jwO2EWActNDsetjVC
 /8XI6j6rOe8OcduG4XYmdX9Hdc5lSVfZIdj9r1IXAudbsIOJrnyyqP59ofGIxiCn02L/yhcu9fW
 MA/8x1zz4fUoJbYXFnEgbHdbgeRUNYCdovWfUOQKVvWxHyrY5lHPXjwpXADu7JpOKx+9qlb92l9
 FZ/Jo8jl2+6f2oD+7Kc149
X-Received: by 2002:a17:90b:3841:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39aee24957amr8725540a91.6.1788406484883; 
 Wed, 02 Sep 2026 20:34:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3841:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39aee24957amr8725495a91.6.1788406484457; 
 Wed, 02 Sep 2026 20:34:44 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33253672941sm2375624eec.3.2026.09.02.20.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 20:34:44 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 09:04:18 +0530
Subject: [PATCH v4 2/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-lvds-panel-doc-v4-2-861738a0d5de@oss.qualcomm.com>
References: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
In-Reply-To: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788406464; l=1872;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=zZGUjvb6YCx9n8jvJbB25pXxGhg60nmlkZDIY6j3MeU=;
 b=gv/fHMyoMWmWYkDYIndRSqUHRkaTpxdJAupcpi0ijdNzJB33Xwzw+Ozibq/aEzCNWBGGu1fhR
 jc1rMKkxicEAUFillZ7fPltE5AWdvIBPxlb/85YV+2PlpYyPYCt+lhF
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfX72U3chNj8eIG
 r1bG0Bv+7xOGdv13iqDV5mAzcYPcNC/XCX1fXL8iumlMc7lOfD1V6DSQ9g/eoHkgsZFOc3Gua3K
 vvD175+t+1aXKWJHVmiOQYHlrU0DL199AgtyVGB/k40zOWyu3RlTCUNDLM6Xqd3gPi6FTgpwj1l
 iXzmD2jDLDHRTZxdkym6tI7UMPVs27jk1AeQTSZqT/bmsjnR7Eh80nmHrtnSXvxxIRJcq/Q6mfW
 U5HlC6KVf5L+xXgS5O2Wvv3XoNSWjycIyK01Ixvpv/ERi0nCaJ12BKEbNxeljRrENACjUjxJFO0
 K6Qy4zmRdGTpgANCz8x2VDkNU00TZI58ne1JsdHXRDuktSAeKJD4to4a0HX8LJUaHnKGuriMp0D
 HjmKWuzJVmjoAdDTLGGile8SihP+MCodGp9xuN64xtdXGzaOb19UU+SuzOYAgL4JqupxqrqoRN5
 VALv7tRBOnYjHqCHVsQ==
X-Proofpoint-ORIG-GUID: PpfyU9py63Gs8zgA0pxZow8j2roJNf0z
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a98ead5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bP93rsPOkRt1mgqf1Q8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PpfyU9py63Gs8zgA0pxZow8j2roJNf0z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfX7Wp81AD6mL4Y
 Zu6ZbJjVuNE84o3lKtPRJ6sbY1PxLyj+6TK/4M99cTS4n5H5CqaziSDQiRQrotFNQxhgeWu35Sr
 v7luZ1HWW1Ktde51crUpmAIAbWzBBUs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030027
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

Add the BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel
LVDS panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..0b516385b267 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1593,6 +1593,31 @@ static const struct panel_desc boe_bp101wx1_100 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing boe_dv215fhm_r01_timing = {
+	.pixelclock = { 148500000, 148500000, 148500000 },
+	.hactive = { 1920, 1920, 1920 },
+	.hfront_porch = { 88, 88, 88 },
+	.hback_porch = { 148, 148, 148 },
+	.hsync_len = { 44, 44, 44 },
+	.vactive = { 1080, 1080, 1080 },
+	.vfront_porch = { 4, 4, 4 },
+	.vback_porch = { 36, 36, 36 },
+	.vsync_len = { 5, 5, 5 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc boe_dv215fhm_r01 = {
+	.timings = &boe_dv215fhm_r01_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 476,
+		.height = 268,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing boe_ev121wxm_n10_1850_timing = {
 	.pixelclock = { 69922000, 71000000, 72293000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -5759,6 +5784,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,bp101wx1-100",
 		.data = &boe_bp101wx1_100,
+	}, {
+		.compatible = "boe,dv215fhm-r01",
+		.data = &boe_dv215fhm_r01,
 	}, {
 		.compatible = "boe,ev121wxm-n10-1850",
 		.data = &boe_ev121wxm_n10_1850,

-- 
2.34.1

