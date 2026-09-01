Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41EAC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBED10E3B2;
	Tue,  1 Sep 2026 09:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxoO5vlc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IabZT3nf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFB010E3B2
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:14:31 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179JDE1709543
 for <dri-devel@lists.freedesktop.org>; Tue, 1 Sep 2026 09:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ULmFFgEiINmKjW4L916IW4
 QN0kL7zSoYDbJRuA1Ywg0=; b=gxoO5vlc85xehIWD67UWyL55bvgR77I5XyowKh
 9WHh/fVm+6/4XTLdUWnN/kjvuaz9+pBB6hqlCX2+kNWygzhGNXpxD9WRQMoR6tkU
 j30ZVsQ+wevOD79vnLqmTV1nQsA36XlFk8Xp0DHfLrtzchMt6hUQYq6fCLkR47yk
 9qMzpwdhoN8T0L1UwD1iJdaRva06pCbw1AqmmhEzvvE/t/53SQOJXeeRQw5L1l8a
 Aj3Ei+d5uPoQL/tOwZAsaKuDGjjmdFX9Np8UHsCHn0P5GKDPv++abGJLZZXiuNc6
 sR8j7emcJnxb0mEWauQOwZDom9EzHkl8ehle1kwLm8MI8x2Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp8fsfuv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 09:14:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so705472285a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788254070; x=1788858870;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ULmFFgEiINmKjW4L916IW4QN0kL7zSoYDbJRuA1Ywg0=;
 b=IabZT3nfSHoh3hvxWx005sH7g6LOTMR7GdrxdpZQVYxA1vpPte61D7ueghUUbYIrpz
 Jixgp58Z5sVBh/BYrrU4UHHiofiCpX0T3LG/5v/qtz1moCdoeuA2Ct7VqOWpwSNmvJ41
 MW5qbXKsQGAc1wZNaKWYx73Zg+omoWs1QjyXbVplhJDIF+ITh7hW7pHRslcaVwsvL+S9
 uSyhQEdCHWzkdsbQy57wcsBqH0/scvXaiWoXsP57i6vjLa+cILlW0zVlFc1eMC4AvrEy
 Vf3fvUdatRbv1GJ6irkGVDSdnIYLrclqyKI5Mq8kItyTgPCrH1tqtM2VrvwWLeP7Z5LE
 s4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788254070; x=1788858870;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ULmFFgEiINmKjW4L916IW4QN0kL7zSoYDbJRuA1Ywg0=;
 b=VAo3iDm+ZzuNjBZfrWaCGbm/hg6hgKYYLtC+HM4DCPZYcd3apLykSDffxIwveF9Q2X
 iQi40kbvZGMYONk2WFk2xV6yol/6SwM9ooJ4wNl0k40xOYUzwhErMs29yCSMvwoW46B8
 NLGHQnKFE9o8nkmKwdtKGA4Mv3aXBEFJLv49JShQkhB6CDouWEDzFkq5kRIB8pwvaRnH
 p/QEEYCpAPVqdYoepuSEF6Y8Gv1niBo71EBE+5XxQuBUbxbpmVkn/Gnd1GZL3suq3+Xu
 Smo+9sX5DZ/sE1wKkoG9FlvlNnMHh8Ize660Aa+n7BMqgzgLSdOjwCwIU2i83Na5yWPM
 otKQ==
X-Gm-Message-State: AFuF++nDOOQeQqy6FbQyZ8JJK/YiK0XB7SV/YfHF0C/c14RBFEn5grtz
 y6vjUnsFtM2OG3bP/XCIqu94givJTrC+TlqF4XsF3fAiIjyfeStGH+PWOvYdHJn/l5tlvMklifO
 IjW1XGO4oNYlE67twRzaKeQi6a1GB+5Cg5/7OzZ42Q9SmAtsH1op1eXUDOTdpjKnBPTPPw3I=
X-Gm-Gg: AR+sD11jtfxkUnA/9LtKtLdNMKO2u3ZVyXR51Vs2d+LRy9Ua567tcoahLjGsTuUBCi3
 1l49u5nFI8XI4ckh5jWOf4DbkK4gt3NuvnOZ3/xHtHx5qZPb9TtluSnNjwIBEIzT6oUtrlFRA9Y
 OTOrnRtvoTV4dnk/i18oya/FFhuHx8TGGqf+LtL0sbL9jvDY5YBPnL5jCHeWrU9sn7qalOvg0NW
 3jdl5Zs+lsahVWiQDAKbHQXnHhk3nmWNBzkwYmKLhRO0sWZIUUt7SsXGTmxCh1CmGtoN8xWnlTp
 mUTHAbSDvzmwqGOMXQjWL+Os9391/0m+6XeK6dhbwFFfL9urEZoWD5kRNQi9ts1s5j7a8foEYXO
 89nEXXfiFRNjsX3z8gYjKEgY+ZvfMAig0QyAlgC96aQHD6UAZoy0QbbXpNWH7N/s=
X-Received: by 2002:a05:620a:4804:b0:92e:535b:e08b with SMTP id
 af79cd13be357-9394815b03cmr866210285a.33.1788254069673; 
 Tue, 01 Sep 2026 02:14:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4804:b0:92e:535b:e08b with SMTP id
 af79cd13be357-9394815b03cmr866205785a.33.1788254069242; 
 Tue, 01 Sep 2026 02:14:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a560fsm988963485a.24.2026.09.01.02.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 02:14:28 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 01 Sep 2026 17:14:21 +0800
Subject: [PATCH] drm/panel-edp: Add support for BOE panel used in
 KD116N36-30NB-A001
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-edp-id-boe-v1-1-f5e2c44255f7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGyXlmoC/yWMSwrDIBQArxLeuoIao75cpWTh59m6yKealkLI3
 SvNcgZmDqhUMlUYuwMKfXLN69JA3DoIT7c8iOXYGCSXmiMXjOLWFPMrscC5l1Gjk4OGFmyFUv7
 +Z/fp4kKvd3vulwTvasvWec772FkM3ES0RmgnejUoCn2KmNBoi2SFDMEIHxVM5/kDY18ZAqgAA
 AA=
X-Change-ID: 20260901-edp-id-boe-c00b2d69a256
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788254064; l=1756;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=i9nsNJNXIDUF7HC2HqgXcvchw6qqq6G2LQp0MeXMf2M=;
 b=/WXOyjLScUVXnRi9E1oCHjV8UdLtQsqV9wIOAcSq+3XrZqszLtoqSynw7dk1/TCXvOQfoRBL2
 PLAS4Jja2K8D1xWtKKbdUhCB8h0sB1VHzMOW9ExU3hAsWTT1JlxFsvH
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 9VNfbOb56yz2ZHpFvu8plRok8Tm8Gre9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfXw/iJwY/W1ezZ
 z63cz+AEL61bYnDr+JK5V5YTcxErUCN5Z489UXr1elTFjUUZu49Ghac26P2f5Z7rQdLbVztz9z9
 fiEW3SVS0Tcpw6uGEjj2SnVubUtbHus=
X-Proofpoint-ORIG-GUID: 9VNfbOb56yz2ZHpFvu8plRok8Tm8Gre9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MSBTYWx0ZWRfX5Xg4OxOw9SJi
 jyEngfBtIlfPFYRyJ3/dZdXMZwUft+hhUeOExNhXkKLIhLK2P2fJePLNdgVMoHpukR51vBH0AXw
 UHbUvUvneC1aK9nxhHLU668d2ZU3a3DoUeLDDqUAFEfw5prpLm8d/7rsVxaaFaUoiTfaUBptvrP
 TyIvalfxQnq3d9yuvqEmPASPm7kAE8wO/xu2+c8ritQ2ZDMf8wk0Yh1+puhhurbOIxXTBlcilkk
 iqVYLqPndrTbcoDmi1csjPI6hyiMsmbsjaGs03PHlk4+kOCXmXteuOUmFDUeSrAhpPRwf6rRgzW
 Op3ilQR3cJhzPoLUOL/t4DwQlJgoNlSk6cptCxqdGDqdo5gVc41eTg8TSCgP2m3QqE7ECtnr8Q7
 9fE4itZdK/9X6y6bJXG5ATm+If4XRBszoZ/8niiUF2uVQcLeR/yrCUCGTqdy5hRp0tQ2X6VveK8
 FSqi2gF+qkrFaMI8u0A==
X-Authority-Analysis: v=2.4 cv=BPWDalQG c=1 sm=1 tr=0 ts=6a969776 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zjCu6LVzA2uhXCqqzrgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010081
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

Add the BOE 0x0b21 panel entry used in the K&D Technology
KD116N36-30NB-A001 eDP LCM, place the EDID here for subsequent
reference. Timing values come from the KD116N36-30NB-A001 spec.

00 ff ff ff ff ff ff 00 09 e5 21 0b 00 00 00 00
01 1e 01 04 a5 1a 0e 78 0a 24 10 97 59 54 8e 27
1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 b2 39 80 d4 70 38 4b 40 30 20
36 00 04 8c 10 00 00 1a 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
00 51 56 31 31 36 46 48 42 2d 4e 38 31 0a 00 b3

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2b455369ed70..591e0ed03612 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2060,6 +2060,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0af2, &delay_200_500_e50_p2e80, "NE140QDM-NX2"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200, "NV140FHM-NZ"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, "NE140QDM-N6A"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b21, &delay_200_500_e80, "QV116FHB-N81"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, "NV122WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),

---
base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
change-id: 20260901-edp-id-boe-c00b2d69a256

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

