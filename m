Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09183F5A8D3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D6310E7AD;
	Mon, 20 Apr 2026 23:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nwrsUnmI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DNb0HxfU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E9810EB3B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFp4iC084489
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sZrnMsT7jt/4L++ru9IvAvxyFjbRkLz2gfqjnGiw80s=; b=nwrsUnmIe2W0tHvx
 qv+K2ykbluRxeMpFT2z5cR47aB+Ai4q84jOYOhzLWiEQvlTwZ/Ylxc+oJFZDHF2P
 XG9H9qtHUt5eWPtgbsahyI1rREj+jUJxMhKrdGcGQ3gNJXQzyVL8kqJsjZ8V6oO5
 GeFWtC6x5dEAU1JgG5Wkc2S3YgFC1THHWx0rpt6rGyYLPXlWC5MF882vlxVzwyKf
 +bZkCAz+JmswKLySVaHyin6V3uyZvMUz2dNSl2j6oXN68cfxLKkGqjgMox6wwGRd
 ES6mjX9b8rflNFCMSazlxbI5Q4os86OmKU2IQR9C17ryB7+2Uaga4/iYzo/s3fuA
 kK5Jcw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81jwna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d58bed44aso53397181cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776728033; x=1777332833;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sZrnMsT7jt/4L++ru9IvAvxyFjbRkLz2gfqjnGiw80s=;
 b=DNb0HxfUzHusYk354rS8FSp59mbvJOgTDYxYyzRwxR2jr4Vs8wDuoo+NNBKXCbiore
 6RZU0nFZViaUyoIhidoKLRx4AwuV4XWVbh9HPygFQk+VT27FtB/saJ7pGegoLx+22C7S
 +Bs9ED4bhpXHP/EWHpUGHwgJZJkdLM0bYdoR6A+Z2JZ3C3zQu3N2fcG37noIVTb8L4FO
 3W29kP5QQrtd+D3nzG36yJ9CZlRUyi1CFIS+52dCdgQS7TY38u64xk+acQwmW+c22Xwx
 gkVaYQSbjcoDb7nOYcuLezwnf5GoOVof9vONiy/gqPZ3YIG7oWywqMMU9A66OgkuY9Ye
 JI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776728033; x=1777332833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sZrnMsT7jt/4L++ru9IvAvxyFjbRkLz2gfqjnGiw80s=;
 b=G0Epsg0X7MsSZ4JeNKapQHdQOuvCmw13nOsWVOBWDNOO2GbfLghgA2L8ex0mDUDfbh
 c/xIKRdFfzUlpI+3ANhrrwHc8JlOQOisZtVb2v+pfq6wTk+MhZoqTAYJZHVCFg3N4wjm
 t/xMx3yWVC4z3N+cdi8FiE2uOkBO6n+juwODOqcsvAGCUWygyEXTbWp5sc7OzllThZoG
 yNQeG/c4SrnQZ3s1YBrIS9le3Emp0H07XuGwpMQ1OBCexfJDoCJQrkFTqq+D0vE6XUSN
 sFjAX+F2nFzoZ3UIZf+EPFjhpxvU3TxyBljy6Dkyo6x595K6ULhOb57Cvu1KO+Rf0ruJ
 og5g==
X-Gm-Message-State: AOJu0YwDjX3YEUy3jDOcU1uREbN6M9Qa0TB2lYoxMiorUX56raj6PxG0
 v1cmRrI+zvojDOK/ZhA5zcWVWB1tD+2cdfnQc4xL6Oz4LmhXGF+UCYRiWcOGYA/d2Jn87Fc551D
 ufN68T7IEkelVvQC+cYcZgObxsE1VzViA9hxCj+ZDLrXasSnwa22DnJRKpABMEXFfu36FBGI=
X-Gm-Gg: AeBDietar1wpnOX1h3soySQlc+2ehsCIRb/rhQanDc4cl42qLNH62sgzlxHkGWdo7wr
 nDun8MgADmKW02kOOxUWEna2FVoe6WC3sf/XrrrZIl06KFo47LdOG7Dv84bn+oAJR7XWefGWdGE
 +U0UO8MjNM2p0d475+xUt4HUNFNEMCup2zLwN6RiabRCZNTNvJkXapnR2X49zMK3YETRuyL8Ilq
 xKiYdL0Qgvy1rCNfyP9mtWSQOr7szkUrKpi/M4ArxPxgwfoYFqdhyUfuBkT/HBbWa+3+qFLRBeZ
 98AOno5MlOY3QDY6SEpY7Q4G1YN8epfShxnBMfxuuO+/hFpC+EKKCu5YSO/liJeLNQ1D1++kH26
 58QiSxPMsnSYqc7hQsBZBVRYQWjUoLli7x2ASo2dY07rExIeTw2xF1quqaqDM+F1lH49PQdhJY7
 EIYV/fxNvgWjFFkbVchbzomtibLjF62pylVVLuizXuEzbtdQ==
X-Received: by 2002:a05:622a:84:b0:50d:912c:c2cb with SMTP id
 d75a77b69052e-50e36c4d835mr229844631cf.42.1776728033453; 
 Mon, 20 Apr 2026 16:33:53 -0700 (PDT)
X-Received: by 2002:a05:622a:84:b0:50d:912c:c2cb with SMTP id
 d75a77b69052e-50e36c4d835mr229844161cf.42.1776728033013; 
 Mon, 20 Apr 2026 16:33:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc627sm3320714e87.29.2026.04.20.16.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 16:33:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 02:33:34 +0300
Subject: [PATCH v3 4/6] drm/msm: dp: handle the IRQ_HPD events reported by
 USB-C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-hpd-irq-events-v3-4-44d2bf40dfc2@oss.qualcomm.com>
References: <20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com>
In-Reply-To: <20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=891;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+/ILvBuGhqekKhSlkO02babbVbDbrJeHq8l4XOhAwlU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp5rfNyjFzL4b8IkwF/PF49lz1EuPnWyS8Qxlcr
 U5qoTUzCLWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaea3zQAKCRCLPIo+Aiko
 1ScGCACJMMnjpi9t0iULUWpszlSsI4q7iJwWHegcsGM/iwQvHCyLVAcm8trSNMycKBpkdlIpjgi
 qutScdnn74VcxSgGoQBusOE4JTtC3EwpKjWOu6D9oiMf+ATGfMVtVxG+hErUzl8iWh9g3t9V/j1
 PwQwbR9Iftr5kNio91MsoXuBkTudXywYpgVCcJ37u1V/th8NcezRjcQE1ww78mBhhXwEc6hpKj1
 SgtTJImlf0dgsumqITASw/7XwPheCid49bfS54ITNHRvaeGrnWr/ls0GnSNCyIoD5HBWS5/eeif
 nkxyVQkoGqHHpBIjjlXqa0CLa+2io1+jotp1uhof45783PSW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIzMCBTYWx0ZWRfXx9s4jnpUCNT6
 7GV8fq87WPJRTaRFj13CGqCs1xM2w3n3kfjPaYc4V5zt0oRKmjjyIvRr+2Vka81DH4GXoENdDMr
 9wl3GbFuyMqtRBa15XtOTxOhthDf2rJL7TbN3oxsQB4M9tCgCD9blYmbi1l+B8EFdzbsEnDvn17
 pZuEFAezQubNOJcKDABmY+lXr2rCFXW0oF/b3T3483nm1bVbqxrcxOL+LmUmJpEo/FKnnBSq9u7
 8mK46xOFnEaMV+O1UwMRpfv3mYkCeYOWErGEKs+fyGrS5l0bXaQaun1xAwFI35yzkWQ3NEwvC9w
 bTnyKyR4LAyEXSnCbnkYum0tyFf1+EGx6Wnb5LrkxTlGA7pIIedrt84P4zQ6td++7X00QPawdPJ
 hPJrNu6axLPaykFvaqz7JHQPW9sf5bsHj4S0QV98pGxI+dHw324GH3wAHgIpYOAq1+j6ljaU4KT
 WC3GNjfqOjqGXLcExJA==
X-Proofpoint-GUID: jEd1BDn1qsj_n6P8IOUo9kxHRXL2NGQo
X-Proofpoint-ORIG-GUID: jEd1BDn1qsj_n6P8IOUo9kxHRXL2NGQo
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e6b7e2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=3ML_fINe3tzxlWvVV4AA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200230
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

Let the MSM DisplayPort driver properly track and handle IRQ_HPD
delivered over the OOB events (e.g. from the USB-C AltMode handler).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7a0623fdbd8e..8df579bb320a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1800,4 +1800,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
 	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
 		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+
+	if (extra_status == DRM_CONNECTOR_DP_IRQ_HPD)
+		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 0);
 }

-- 
2.47.3

