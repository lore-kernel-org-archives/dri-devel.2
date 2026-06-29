Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDACC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344DA10E959;
	Mon, 29 Jun 2026 14:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXoJ0vdn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E5KtUE8K";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4871410E954
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:49:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATDLW2578972
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Riz54V+xwrmHrcv0C5NpeAm+dHdus1rR77mLS6rpysQ=; b=jXoJ0vdn3ImZ/UDX
 dWASKy1lxZU14FYk954F6jZtliytAvjPzt7xcSkI8uO9c/AtgD4aPEXhqhZJdlKZ
 LCbMMBqf3XMIjwgV2072Q+UveQzlawXiazHtcF33MfoHk9f4REBpFNH8VtM8bTGj
 0b+FbF0ex6FSB5I1PPvkdHDnHEarRDWX4gULsRPlOvZg4NEIsbSrTuh103ZgTxSw
 EyhhI1qF8Yt3vb1VoLOKsqdiCRpD3oaSCZTWhT9LgTmkyarlETsDrpytDw3gT/Kt
 TFKiLKo5cmpfiCUbaEiKtMSSUAnfdLvQmBQGS21/qhmcEoU6HPsS2nGJk6NFbTfJ
 yjZUeQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hwhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:49:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so55879885a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782744545; x=1783349345;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Riz54V+xwrmHrcv0C5NpeAm+dHdus1rR77mLS6rpysQ=;
 b=E5KtUE8K0xXLrqUft3b6OJzfUN4rgdR4ptSKVDXU+eFbcgjYb/yekNYShKaobs1oYg
 ck2qAxeHrNSoYLkpnTvjHx7jqvnHWxQ1dBZ3vSUwpKFsRcL942RUW2FzJGH+I8kJW+jI
 MZ6eiz+9sKRbG6xWVhvlf4KWlhqneVgbAsIlwUBbdjuqeownyFDFhCEg0iLgbr3tRVnc
 0PZ1Bynzs4ARPE2EbI5aekYTmFi/wu82PIgQlUJO7kqFnpE4RlL6/7L6sa9zVgkonvul
 pAwNv4eA8KsfWBnod7r178+zGqzwvAVwtAiEeV2f/0dT94rU7M70Y34m8LqxBO7+97SP
 YucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744545; x=1783349345;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Riz54V+xwrmHrcv0C5NpeAm+dHdus1rR77mLS6rpysQ=;
 b=Ey1HnjiVvb8RtuZd3t/tnkbatuzLTgTZ9Az52f8J4HVpMSG/IZwJxcgdaBFY4hOCy7
 /1P5YutedkZBl7y103SUwqrRfJK2Hx2ADEzMOKEKR3vHQQTgmZUrB8aWjfDcPGncB+5Q
 1GrPZNnIuOi9lm+m93QM5Mjs6SrmijW2EkRuRFdpntML5tJeg8utYgpAvyjAOKEzHbcL
 TMwkOArHkZE5iZ/cJpt8uAT25lmQ0N4ZMCSPV1Ef27Ikvje2HGw2y7zw8VY+mE8dSqMP
 B9zi63UWg1C/03LKcdyH2771Bu5O/v/tHcYIB9Dm//jeHCG2rsD8SuLgt981KD6uQpHg
 nNnw==
X-Gm-Message-State: AOJu0YyZLPqh7TZT/LLw11mHGg/IG4U95ySt4NHz2tLwri04Po6YBFk3
 HmaWrOSCZ1BMH4Byw+esEo20HMZTh875VUjxqB250mOkOrs9zvRBntOR+d0Jal7yUaRJe2IJBIX
 o+dudq4OTxq9WVYliPF2r10KLk5TrgMHb6Uci3TrE7OutQq9uuQ7w8Exl1dFWA+fxqH+YsIM=
X-Gm-Gg: AfdE7cmnBalvbja3leeOOdNAgzR4TCyf0C6ZK5DYn6dholeaS+w1KjE7e1X8BK9S/E+
 x9T+VzPgixuZQ55TeWKIK1haYR88HfEKrqKCK/5l01fARsrsioz2KdPK5FHztMMtKTMzI0XVpSj
 T0iSqqAnQDSBpQk73lvZTXxlXsFkL61TxHOSX1J5DyBVj6HIYtB402+CUGXiUt5EyYdfGntcUj8
 Ph031HWNyIpDuO+qWKmRJ+xlDTt6wSDLXbEcQAKc6cVtOHCpmyx8hTHs3NZ2evCJUk/d+z7uBZq
 9e6mzO/em5jJ024j6qQ4tMSy/JLvSFIy0TkQvsn6n8ifCO1pEbnKI6ROcjCRpCs107RGDzIpUpZ
 CjydHuAO2GMMTf5zAbqSc+ww9Wo4wzByqdZrWZabhZ7QOddje/Tp3+kdF5MJqB/KlthJH4+n9AQ
 ==
X-Received: by 2002:a05:620a:f10:b0:912:bd42:b46d with SMTP id
 af79cd13be357-9293c11cab3mr2618704485a.25.1782744544755; 
 Mon, 29 Jun 2026 07:49:04 -0700 (PDT)
X-Received: by 2002:a05:620a:f10:b0:912:bd42:b46d with SMTP id
 af79cd13be357-9293c11cab3mr2618693885a.25.1782744544168; 
 Mon, 29 Jun 2026 07:49:04 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm2087974385a.34.2026.06.29.07.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:49:03 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 22:48:07 +0800
Subject: [PATCH 5/5] drm/msm/dp: mark the SST connector disconnected when
 MST is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-msttypec-v1-5-646a10256233@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782744487; l=1355;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=P6ysjma33fFr4Jhf+LAK0Y2tGO90pVRAbJrTPxrwqaw=;
 b=taMUim1RCi3Tovwyu/g7YUOegrysAK68tpUeSQ5Cm5voOFpIRC7PaoYhfsOcPSnmVuUPZOtog
 FPGK/+EymzKAfEqmi8WrHew0KXfVt4LhxvzjsyxTNcY6DSQa90FNREx
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfXx2+DkVIKnyfP
 +Ej55QJC5fwXEbsXDtKoCCvpNr8HMrvpBdrlQBE+JlPHDfuD/TAKe7j1S/NYsOFiiWRL2nJzd2h
 7w39bKOrdJZPONI+YqADxDPt/F+I2bs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfXxI252FYxoSgi
 1OAy83owIFvhfKq3UkiARIXy955oQBh/RnFxCML4ye5b+YdQcQ14E148IUJ4Jik+o9MjpgsFAC4
 VNDS77hTq1ACV8PH1MUfpqOeUFhB0tztq8Jg6IiGMNClZMGyo+DjJcjoYaLYZQsUqANJ0RyjpUi
 R79mNy9TC2bCAjTdWi5FOmdsuZTTFzbGx7ziey3f0OA9ihcMdLvuKp8SunpL9h5SQPf5tSYyi/c
 hJOd/QGYhAaLPZzm1SHd6u7l92P0QRfHHcfEbrT/SCvBeavQ1iodcr8Q0lcOI02x8JsC8P6llnC
 nqm/vFIe4m0dhPYcYZyEyAU01WZJVmJO+Pxux2JqvYTpGy4YxxUia3tqSHcFl9NG4/JLi13O0qj
 SwBC27C7JmJCXvNFwJpGDXsBpNyEXyFT2RA55ZeGXYITymS/L7V90f9EkYRKvLDLfGOR2bvxthM
 u2g5NRjBZYZO2cptCWw==
X-Proofpoint-ORIG-GUID: 8uxpxSN8rUSiqXpnxptadaEkU5BPJE5j
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4285e2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=hI2I0KHUTEcuU6pApIIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 8uxpxSN8rUSiqXpnxptadaEkU5BPJE5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
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

When MST becomes active, the initial HPD plug notification updates the
SST connector state to connected.

However, the subsequent SST connector detect path reports disconnected
while MST is enabled. This connected -> disconnected transition is then
observed by the polling logic and may result in an unnecessary hotplug
event.

Set the SST connector state to disconnected immediately after MST is
initialized so that the detect path does not introduce a transient
state change.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4ee391cc7165..f8ca60d6d714 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -352,8 +352,10 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
 		msm_dp_display_mst_init(dp);
 
-	if (dp->msm_dp_display.mst_active)
+	if (dp->msm_dp_display.mst_active) {
+		connector->status = connector_status_disconnected;
 		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);
+	}
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 

-- 
2.43.0

