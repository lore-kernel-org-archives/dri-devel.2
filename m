Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CD7F5A8CE
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECA610EB67;
	Mon, 20 Apr 2026 23:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y69pm4Sr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jSAAz8Gi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4C910E7C2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFJjMD084674
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MbKgvVuxEIwEzMcmEacPjVXRL9Yz3CCmKCNgvBxdDkI=; b=Y69pm4Srn2LCPBjb
 025nTlDFvxjYJhnQGKyOlfHgAiNYtlC/gI/4rGoJzuqRCqMfXlyKM9aTTIFzQ8W5
 sL93/7AMjo4ui/4+2xuW4VoPUYnyo5PjDQyNBUicPT4OoDdgwwgSVWz6xz68Dqe+
 uj9bmjCXEoOI0ldAscc6TGdPSPkjCAnQwmVMtrX5cCyhwXLTEWi5HR24+pZbj5Ez
 OBpAy1+412XNQ/NyPfZek05H29kw+9ojgzeaMvAIfJdzVJjXIoPbpYfiBSxpzbwH
 jqvKl2JGQvPpqMaANSus+/ll75z1TRGYCDHJggWZFK1K8wHFsE29pfVx2PSWDwII
 8S7TcQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81jwnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:33:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a1accb970fso9625346d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776728037; x=1777332837;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MbKgvVuxEIwEzMcmEacPjVXRL9Yz3CCmKCNgvBxdDkI=;
 b=jSAAz8GiUgncIeu7FuZYs9Wu0qeh6825D9Mb4aSwTqeoxmFipj/OtuWnziQpl0t2yp
 nWUA9BtY8eXZ3KVjQXbnokXXYxoZW+KGsHHmHsqIlcShxTh9LBhSAibnZ/RwChSdMsYB
 2ijuuDPicEZoPHCtUIbeEdnw6Cj1G0TCj82ZbVNnMQHC+3EfzldhZB9tPs07/fGCyFZT
 n93OY4e6DLtHXDbTqilcsVZaADtgkhkiF78LPNXrdF3J3kVuSZVu6zKx9sWigmKEUs8u
 Fe8PfFUBWq1rQj2LKAe+IHIzsJ8lOLzXIqdW4LEz0t3vhAaOklXCOXmMwYqA+rn1oXx5
 YlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776728037; x=1777332837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MbKgvVuxEIwEzMcmEacPjVXRL9Yz3CCmKCNgvBxdDkI=;
 b=OOTS3kn2eeJaUeSnMteWWnAoecoIcJvR2DiJRJ6xYBBU576qsfpGZc4rt+bcg/Dmkg
 0Mat7lr/cFUxFCFJWBAt1JuzE8huNq2gsx2+UTQuiZkr5mE2xU1+kgyrm25jAgtL1t/1
 BgHB7mnJKKUg1HFKjeHJD2G/+11Xbqj1F/1tMAkB0CTswvkcBMtWd4CaeRuRDH5As9op
 cvG2qYyjPYHCy4EeW8DIXcQqrQ7ZPjmIHKUzI4Z36S2TLInH7KEU/zF5zkog5fGD3/qG
 vKGmQ7vFKlEIUPu9s5+FoyB447v3mBB3XC54sL4tJ69WWIve4qUazAMfBpFDTlbWHiPE
 wEYA==
X-Gm-Message-State: AOJu0YyiKNuiFRnsusPT30SAW9efdm3KQX+/POo6jERAJLBmSeoQPuSO
 0vmle7YJSPYJfjqjgkeS4UdvZ3kpnD3gSdg6yTP4OLk3GLu8GoXmGoPRJKEGDVuCpXYEx9qozST
 x3P8sxrwOTaQgpeUdXD9HzHf3pOB15Z4ux4f4ZVN3BA+Kma4WE9SdkKBKCZzGBbLlqZ2y6zw=
X-Gm-Gg: AeBDieuvWqnv4wj3ciMW2bnbCBMHw1Fg26g0jBV6PNnKwUp0ELA8ng74A0leqDC2nBt
 U6av4vshjnM5yYHNgUDBU5IvwRTU71fUuCCzq6pyJ5Br1o0wx07aRbLZdRJzyWWwqUw7gTPV98i
 2o8yuSKMrT+REuqIH900vC7hCNrS1ja3fWh4fCRePhbEuIy8qJUrih8mD8g0/iGH5lvgKePSydv
 gryCGwIE68NmwlJGuof+mJbhWm69rsfg/iZfcR4CZaZ/OKCw2WYNdRzrONnuIPI1zhFdCTa/z05
 CDhLcwYK06Zi2sKYdM5IkASesNbEbkquH8wz945Q+ZegLhbB0O/UyigJkc2OEEII3v+Vz8eLKxP
 7IdeksVqhV2eXW46mcmM/FJoP5kIfS17LeGk78jx0YBPBfvaDBZtvPhiUL7a9ItYAEgUqfoul8b
 Ash104b6f5KF+0eQGTuoiIIyAQTw1rmQtNmgvhQ8QVdSD50g==
X-Received: by 2002:ac8:7f0f:0:b0:50d:6557:5c83 with SMTP id
 d75a77b69052e-50e36c1165emr201698351cf.25.1776728037428; 
 Mon, 20 Apr 2026 16:33:57 -0700 (PDT)
X-Received: by 2002:ac8:7f0f:0:b0:50d:6557:5c83 with SMTP id
 d75a77b69052e-50e36c1165emr201698051cf.25.1776728036949; 
 Mon, 20 Apr 2026 16:33:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc627sm3320714e87.29.2026.04.20.16.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 16:33:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 02:33:35 +0300
Subject: [PATCH v3 5/6] soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-hpd-irq-events-v3-5-44d2bf40dfc2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=g2eHBnhqeprT5L86a/SxcLn20kIiQiAhlBDTRdUq0LE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp5rfNYm08F+v71xJY6cvWWJprHmt/2yaesAWq3
 fglBTG+jpeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaea3zQAKCRCLPIo+Aiko
 1XkBB/0WgdqQ1mhHWgsx/7ld0lJj3i66+rbrFpJxidzADlKQPAxm48ED3/gjv79sb4e5wUwCCXA
 /gz6xF/8U0cGItse/+TQFlWdhxMszRjOOrDo8nOwrVTlmspph9v61iJ9K0Xf8OeIOcC7VsdrVVO
 OEJloUwiJIFWdfUu2QyAunkDTkyXzO3iDTVXVcHGiezrOQ5QhoBxoVdYWSRommd9qAfZifIZNfP
 zGytUeE3Nn3tPlgtHIYsjG51CCx1FtdhO4CDkFl6XbOCBym2qudhC9uSPOYMJRJ9fC9dH7pkgyB
 ex0y3TB3oJTq5/Kwh0Q3aj02bHOTscIcHIECopeUpmsZOzeS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIzMCBTYWx0ZWRfX535dNrXyp6ZH
 S4UWYu/kCDDD2x3wnDBaXxnLf76I3CkqWwGn8H2c+Zpm5rkANVSircvl5yES9YfQDMiJMzT0JGM
 mtefD+Sh9yRAy9h8XTpsO3jim0W4rq0GOWhNFnPD40zDcaBDNamtJT6ESn93kL0m88t46PE2f25
 SZDBWC0NoiSqiDT2gwZwTseXJa6EpH6ROsuvk920gn55aGp0cijVvJ9FAh8jbIQ0jaNDfHEPVsS
 BPQBa0woQlIVZThifgDb9tZl1cPMye+UQXawKHtVut3vo5Yk6MNQFUaCM6sJflufHzWl3C0qFVO
 EgsYJ7kK0hjyEQ9IqpoRNOw/wcEe5uIXKNS/Nj7FUTKkHV19XrBp0QdS1UTh9OrvLhTJcF+eGah
 uMzE+iVr7JWZplhr75v/jpCViB42fDxNU3aCf35G1Ux3b6Ke3LEnhwgAlvTKlrkglhJCEGiLHJH
 6nWozrzfADTTEl2WRVA==
X-Proofpoint-GUID: oXz8pH2q7tLwz4U-5OZ511oXgsyoA_Fk
X-Proofpoint-ORIG-GUID: oXz8pH2q7tLwz4U-5OZ511oXgsyoA_Fk
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e6b7e5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=QzDdqdBtNhq9Kz3vvWgA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
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

Pass IRQ_HPD events to the HPD bridge, letting those to be delivered to
the DisplayPort driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 619bad2c27ee..946eb20b8f83 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -373,7 +373,11 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 		else
 			conn_status = connector_status_disconnected;
 
-		drm_aux_hpd_bridge_notify(&alt_port->bridge->dev, conn_status);
+		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
+						conn_status,
+						alt_port->hpd_irq ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else if (alt_port->mux_ctrl == MUX_CTRL_STATE_TUNNELING) {
 		if (alt_port->svid == USB_TYPEC_TBT_SID)
 			pmic_glink_altmode_enable_tbt(altmode, alt_port);

-- 
2.47.3

