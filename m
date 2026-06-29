Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5ADC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C35A10E962;
	Mon, 29 Jun 2026 14:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H6uAJrPm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LVkZ8OP8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8E310E954
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3Jp2641683
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dxUOAz6v2DLB3pQ+3w7XXOipI1QUqCU4OXtQP9bfoow=; b=H6uAJrPmvSmWcB34
 usS88T/Q0eKB2k3PInmaPfU+i976qDNDwSNegVEB/60KEP5HjppOioy6UcEkSYhb
 f+/FvJAmwJILDWyIo4ZnkAAT9SaFqV4um6CB8Gmccpbh169rzoVUKy/9OFZTVR0P
 uDBzEsbvQuFwrt5bW0ccq7TCCIuj6uFyDS26wKop6NhSZzIB/b0sfi8xPeZkj7Ya
 MTZDsq7ZH+Ml+w84VwNKdB3CcmLbwnPJeBLmTaG4qX3RSMSbxlkkPxuZCvFuIoXZ
 Y9TkuMtsO1YV7rO+OVTN8aexMO0hfC0kj35n6g4lWbeSY+YeaeSaaFUsDaGG/ikR
 4xFdlQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npescne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92b2ccd7971so654492385a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782744535; x=1783349335;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dxUOAz6v2DLB3pQ+3w7XXOipI1QUqCU4OXtQP9bfoow=;
 b=LVkZ8OP8wGF88wHqAgQtlmpmDPxNqC3H+aLu6SHgk4bcbHm2oK0j7iJ4zQRp1R3Zlq
 0AeaeeR4KDK8v7zebsY12MBpReFyTs2ODqalTYFHXH6jaKl7rlGg7mDxUeCodueZUt8g
 LkxtcqKqyt8Ysd6sK0VEyu2L6Zn3nmaSz2NGUROtG37LkIzuKPLgQQu4uOxhH5qRinJn
 H+gakYaN/u3vc2ugqtjADoWlcXrYY+QgfQKnMVyDrERGjZOQ69VnY17ZOuz+zGVAauwu
 rEazcMQ7Z64WsvrCn6xNtJNudjKnqhwbFuc4um0t6RWDLCYydgPzN7zmzyW0/h9VB3o5
 ZSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744535; x=1783349335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dxUOAz6v2DLB3pQ+3w7XXOipI1QUqCU4OXtQP9bfoow=;
 b=rRWc8ZQsbt0CyUST3KgHmAG6SC7VfROrgwaoKBHTVVeyoh4iIzw/1RhhZdFUrNyz1P
 MXSrfXLOaTlNNjL1mYU+NiRWviVQFSK2ViqX7qQk6ky5I93weu2Z8IpNYuEhsiUyDn5F
 H/0kyhiKLMoCST8svmE5fPe2TrskwLq/DGhiodmiqZMIv/mNsrsQ34W89+1Na19Fjctt
 VdNF3aj9YNs4pCmVQGsKrEdM4btal3emGuWC+1n7THnTv7qIXZ7e6GqkrWOrJp/MU2ag
 IU30zhl/DgU/FWnF18JwxMulZf3MYVrqR6NwdssHXdpSm+ei86sCeBevtl90FQHjE4uy
 +HgA==
X-Gm-Message-State: AOJu0YxncVFFyYybHhDonRbexXnjx2rbcqyphRj8Rubd/gZwwat93w5/
 jYQH2nPHFSOgyvYgv9XHriJo9LarSMeSdcrv7dpMPMT19aAVVslRbrz6j+0YpSJqu1t5jlweyvh
 F7jhKBeJsvy2RrFL6v0feACcyWG+FPxVP8kpVXlvRERAuVVEJWpqsePi49kW9e82DIcs9HFs=
X-Gm-Gg: AfdE7cktdr6zY6hUSBKpsdYdT7hsDX9iEyAaIadrFrpYw1gfgae0C62m4URMd0jmKR3
 hBWyj4WfwSfeFDNl13n8uQtPDQjVcCVAJgl5i9cv26YKO54VMc9+B/SrWqZo69xhVxNlou/RJbM
 Gv6PuHgmdsvEs65to4rYNR1SVHjpy7EQBBicJ8D5Z+wjUG1UoyvVs+6Ydindm1UbjRCFWmXLjA0
 BfSu970PKHIBeMFSTS+l2liC+HArSEJtgC2k2dKrcHSPJQbDuBZXrg02CrDg9prc6ebqVLb5Wx4
 egGOwJxvf+5ABBoWA869VFqO0ofuXzkUWt3cW1KjVyFQiHQINjYFwwmenLdXHQd0LmRlYvknLpg
 89mroNXtbHWYNBjR5Z8bUW+3ga2zAxfHAEgcQD8/K/zXa1q+KXMo7D0FC75aWWckqxdEF7k1V1w
 ==
X-Received: by 2002:a05:620a:454b:b0:92e:5a5c:6582 with SMTP id
 af79cd13be357-92e5a5c673bmr275402285a.73.1782744535338; 
 Mon, 29 Jun 2026 07:48:55 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:92e:5a5c:6582 with SMTP id
 af79cd13be357-92e5a5c673bmr275397685a.73.1782744534816; 
 Mon, 29 Jun 2026 07:48:54 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm2087974385a.34.2026.06.29.07.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:48:54 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 22:48:06 +0800
Subject: [PATCH 4/5] drm/msm/dp: report IRQ_HPD as an IRQ-only notification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-msttypec-v1-4-646a10256233@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782744487; l=3483;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=TY/Ycd0Pv0UYVXHobfUENPm0aoX/GRTId1HfFoGzN1Y=;
 b=AweWrHKC11A5BUtjWFtmRQjNIxUkW7uePMZ5PMNnbD77GSRS7TqPFahMkouslMZ1c+wEOjpym
 c2STxLMOEvRCcfMVC2RaEefZcMBHE71VDmHjWjqIJ+WHqFr7aOTLrQH
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfXwTNc8JDLHvgf
 3C2XdU+xy6cL92laxm5RKn9+kIx/cj2/o5kD11TUoWJ/3TivSI0Miv39htsn9W4zriGB/Z4sDLx
 ghLfb4jIwMS7XlojVkWwyVVzNhIgvROUQG4wNrLwa/mlsIvoa5mbl5OiKZRrzoOhldvZnHzAalA
 Ach6EikvdxJdv90WLFkQTU4U5mP0v1f84VeQtzB8Ay764F/0JlSrsBtTcGdtkGrnlaxeTspoZvA
 OUT/DhePcUX4Z4BgN7ZYmP187s3/Zp2urrlNLvOEkvfoZe8KihN3PCXc8ezqTgU3ojzL+LrQxVs
 s2kat8mBXHuvGLl+dus027VIpUPpGxBvhQb2uU3kW1g/7FBCab/7dW3PPJn+iTjASWBo8GCUFnG
 vKctO/H74DXl8Gl9kEzJYXfPqE+9j8aR+TUuAtsZd/2OIeiCTrh6vUS2rKyPUabDlw5FzvPYv40
 ubjgcopoH0fGjQ2rqww==
X-Proofpoint-ORIG-GUID: HLml3s-0Dr4Pb4q4lWK41T0GRsAnTeQA
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a4285d8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=MqOh_s_JX8DWAqdrIDMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfX6ZiiPqaRQhsV
 QLUsqmrubg5jpp0gdxa2oyMUriXqd6Djc3a7lozrxS0QbdMfiu6gjHzgPy5KIimNTIvhbZ+A8Nc
 kMzG+qJaFWZenqZqNCgfIIGDWxUYXMM=
X-Proofpoint-GUID: HLml3s-0Dr4Pb4q4lWK41T0GRsAnTeQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
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

MST reuses the SST connector bridge to propagate HPD IRQ events through
the bridge chain.

For IRQ_HPD notifications there is no connector state transition to
report. Use connector_status_unknown together with
DRM_CONNECTOR_DP_IRQ_HPD so that the bridge connector framework treats
them as IRQ-only notifications and forwards them without modifying
connector state.

The DP driver handles IRQ_HPD events based on
DRM_CONNECTOR_DP_IRQ_HPD rather than connector status transitions.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c   | 22 +++++++++-------------
 drivers/soc/qcom/pmic_glink_altmode.c | 14 +++++++++-----
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc93b566fbca..4ee391cc7165 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1119,14 +1119,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
 				      connector_status_connected);
 
-	/* Send HPD as connected and distinguish it in the notifier */
-	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
-		if (dp->msm_dp_display.mst_active)
-			msm_dp_irq_hpd_handle(dp);
-		else
-			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
-					      connector_status_connected);
-	}
+	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
+		drm_bridge_hpd_notify_extra(dp->msm_dp_display.bridge,
+					    connector_status_unknown,
+					    DRM_CONNECTOR_DP_IRQ_HPD);
 
 	ret = IRQ_HANDLED;
 
@@ -1781,11 +1777,11 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 	drm_dbg_dp(dp->drm_dev, "type=%d link hpd_link_status=0x%x, status=%d\n",
 		   msm_dp_display->connector_type, hpd_link_status, status);
 
-	if (status == connector_status_connected) {
-		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
-		    extra_status == DRM_CONNECTOR_DP_IRQ_HPD) {
-			msm_dp_irq_hpd_handle(dp);
-		} else if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
+	if (extra_status == DRM_CONNECTOR_DP_IRQ_HPD ||
+	    hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT) {
+		msm_dp_irq_hpd_handle(dp);
+	} else if (status == connector_status_connected) {
+		if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
 			msm_dp_hpd_unplug_handle(dp);
 			msm_dp_hpd_plug_handle(dp);
 		} else {
diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 946eb20b8f83..28ab8cbb5ef9 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -373,11 +373,15 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 		else
 			conn_status = connector_status_disconnected;
 
-		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
-						conn_status,
-						alt_port->hpd_irq ?
-						DRM_CONNECTOR_DP_IRQ_HPD :
-						DRM_CONNECTOR_NO_EXTRA_STATUS);
+		if (alt_port->hpd_irq) {
+			drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
+							connector_status_unknown,
+							DRM_CONNECTOR_DP_IRQ_HPD);
+		} else {
+			drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
+							conn_status,
+							DRM_CONNECTOR_NO_EXTRA_STATUS);
+		}
 	} else if (alt_port->mux_ctrl == MUX_CTRL_STATE_TUNNELING) {
 		if (alt_port->svid == USB_TYPEC_TBT_SID)
 			pmic_glink_altmode_enable_tbt(altmode, alt_port);

-- 
2.43.0

