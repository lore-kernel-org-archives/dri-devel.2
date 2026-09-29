Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24272C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882A010ECC8;
	Tue, 29 Sep 2026 04:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JU+EqN1c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cV9YvkQf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AF710ECC9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47Agj2126506
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fvTWaqBB1PUL3a3elu81DZH8VrrhsuqglzEs765KJ4c=; b=JU+EqN1c9XfY0r1J
 1juZ6nVgiqH6ImcN/KyX0Qw3+zDg7CrmVGwn5cxevs5mst8XbuTapmhpQ6Kd0MwK
 gbd9MSeWOn5lhCZ4PrsmuKsAoDCm/v6OwBx0BlvTBtRvJMpaqBF/S5wId2oQvZLv
 sQs1adNIQ95GsMMGUGTx4ZQrXJK51NOjzmwuF+7DPqDKiuQUxHwDO54pCsvQAz0O
 KuhrecpFicepW+3umeLNNSGPYn8kdtxJyIPYMqea3aNxb6eDZ2XA3rVxfF5Jsk7R
 yceZfaDOUL0kbQ/wnVC64aSmgfsgJVEMmoCi8APEM3uLT5toS2GJF7FnpmsSn10x
 mZKiBA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn8qvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91431adf55eso69558646d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656146; x=1791260946;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvTWaqBB1PUL3a3elu81DZH8VrrhsuqglzEs765KJ4c=;
 b=cV9YvkQfgUksiJeb8DOa2SzlnZxN691ZWIRilV2sGMAS3Tg2X7+ToAkMsvTjt6CDs+
 wjK4XUsVO47kCbcA893O5DIK1AkAHxXkS1iLmh5tI4NE1eJT0XFft0GEVJ2FDV68PNkj
 6WurxFUB4SR+r9zt/MyQ8LO3WsIR7VRprjsu1Auj0GaHtCXWF1lAjlKISzsojWk/JXui
 Nn+ETw6oULCUFGxlqSjB6PNJs6/9sfaHjhh7p8j/iagdmStaKQz2nSVYidb7Ki+LiSyV
 IOB0ex41crC6k4hCH6LVcfXf/CvIDPxR55kyp53hAdiyo6VKtUCOFCP8lfB3OVLwd9dx
 xaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656146; x=1791260946;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvTWaqBB1PUL3a3elu81DZH8VrrhsuqglzEs765KJ4c=;
 b=2j1fzSUNvhCArbH/DTZhIWpzQ7SbexNzIj5JJ0KisNl0FwOKZ2rlfI3ZOAAzGygcHL
 uVktmsl/iyJX9Ie8h2c4AgOEEqOj+OkAWUI48JjzyO9Pxqv7r9rNgB4SEIA8si5HoDjw
 1R0AJzYro0OZGpxGrtKo+JuicrFP31U/ZPnSNQU9xOxE7ueYDGbDPFCU/4kwJPrHCJaH
 h2AkfOwAUlB1xy86loefV+YfK2ZXlr+YN7l4x/zSbMdca0tFuxOoleEN9BMph1v4P87H
 BwuP4XNNNuj7MnQm+OF1eW2Ew7U+49TpH6uzR8YntkGddgGSbiktlZqfRi9uKv9O6Sq4
 cX7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBypUkVCgliTMPW/d8cR7anWpTZkxKatrm4gJ/md+6NCYsPcyUHGTHdUVh8ruM3HxQt55QZDVnPDS9M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVYJUsILJdp2ya+hRM1npgJ9x47xtbARmClpypGlxWwEYyotvt
 G2fqZX8xse8HdXdqYEpgbo+dRlqExIToh320tpNg6WX5r6e9Co++yx90ICC9Xu97sHmK8THoo99
 m3vD5qsbip0J/oEtJph9GkdtbulD2JrlLRg/m2L9EBx6uira7A8jIWxbQdi7tpxrZiASL7Fo=
X-Gm-Gg: AYBFou2nfjoU4EQGZVfV1qqRa5XJ19f4kOueXKmWn++13IVBtD2eFYFLSqxkWuums0/
 nJig46/xPFMoYYY1CJ9ljhPABt+VaEMGcFtGDMqKQWNbsvyN8UF6xqleFejsJrR4K+r9BDo86GW
 GgXJhz7MVeyWpszsoK0oerwVhSj4no5qwUL0Mqd0B0iO/sCkVAv9B4jiIEPu3oZTrz88Ernwdaf
 ddlewdo+pFpGkp4dDS/+tMqCDu4YTHQhJ/LSvV6gx5KvIMQewLqNmGlm+I6ZTeBgs4lxBh2pzmU
 SGZ85lC9Jxe+JCCBDKIeENTPSN9WZK+A6YYI1Y5/dvIgcd9as6A7EqQ5DDth5isTrxo9QII5pXk
 c59gP5mSFgXVYr/daKMQbO54AxWoDsbgyW60+Ow8Mmp98CAi4gX/WbiAxqCy7mH0=
X-Received: by 2002:a05:6214:f2a:b0:915:4229:17a3 with SMTP id
 6a1803df08f44-915422924a5mr124915646d6.25.1790656146413; 
 Mon, 28 Sep 2026 21:29:06 -0700 (PDT)
X-Received: by 2002:a05:6214:f2a:b0:915:4229:17a3 with SMTP id
 6a1803df08f44-915422924a5mr124915496d6.25.1790656145969; 
 Mon, 28 Sep 2026 21:29:05 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:29:05 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:58 +0800
Subject: [PATCH v7 34/35] drm/msm/dp: order IRQ HPD handling with plug
 state changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-34-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=1741;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5HoDkLOV8SkieCOs56wkyW3/fJOyikG28UiNJ6xOq3s=;
 b=X5hZ0+OuSpBi7vR5rueL5+opW/dz2eAd+1WNy1z7PZWcpNAWiBghYD2OAf4MvD4N1UMNM1RVr
 CzBODr1vmXKDHHs2ovFFQHr+p1qRkd4UjzrQmks+015qqWB6lAvjk4h
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb3e93 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=BVs8Im_gJ9IRW4vRDg0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: T_q7u7KsdsqirWQYhL_XERyS3w7cHv8Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXxenAZdyZ+NTO
 DSxdfhsMFQiC/4HeBpGNXA53+rLqcX1ZT1WcupQ7RyJLJMUO/tCvFHWRAqKgkSRGkN6yuJ+ZbM/
 ncnMluvWsXzPlP65PTtkr/oM5OBD+6Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX3fPS8ZaxUM2t
 7j/fA6bwgDro6z0Yf6H/N5glp84rAh34HKfUYn+CckTlJsvdI4biJMjVlj547bk/9eo0QQUIeol
 5bs2ChbL0nRpQYI0G+8Ba9KRH75MwZe3w/QMigLN4ydPPee+Po/QbWdae05aUH8SHx3Pjy/akYf
 yvG1go82tYbBanb543+9CVUT+zmDbZoAgPHokJBGqo96IiIZgiE+NfFI4eMpWLlwlm8WbKIF2Vb
 05p4GrRFfMZp3C2h66KtRF9qe5rvuLmgu2+VY8krHO2bIsjaemfb2U7tPDZxMuBnpKT/MuVay7Q
 aA8X3RCdkFEBToWyNcsrptNfM59Q9fD/xR6tLvfud8pHBFAG9efvrya7dfojSDvqN6var70HdxT
 Y1fZj03mk4P3a3sCUGeqnfnBpNTdTfuxh9bSP/4BmLePV90KWFQI2BzMKvCoezsigi3nCZNT63O
 +c87yRPh/wiI3NanPKw==
X-Proofpoint-ORIG-GUID: T_q7u7KsdsqirWQYhL_XERyS3w7cHv8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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

IRQ HPD can be reported with a plug or unplug event.

For plug + IRQ HPD, initialize the link through the plug path before
handling the IRQ. This ensures that the link and MST state are ready for
IRQ processing.

For unplug + IRQ HPD, ignore the IRQ because the link is being torn
down and the IRQ may be stale.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index ed0b93e3bd08..94446bcf9448 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1129,7 +1129,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
 				      connector_status_connected);
 
-	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
+	/* Do not access a link torn down by an unplug latched after an IRQ. */
+	if ((hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) &&
+	    (!(hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK) ||
+	     (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)))
 		drm_bridge_hpd_notify_extra(dp->msm_dp_display.bridge,
 					    connector_status_connected,
 					    DRM_CONNECTOR_DP_IRQ_HPD);
@@ -1818,6 +1821,9 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 	if (status == connector_status_connected) {
 		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
 		    event == DRM_CONNECTOR_DP_IRQ_HPD) {
+			if (!dp->plugged)
+				msm_dp_hpd_plug_handle(dp);
+
 			msm_dp_irq_hpd_handle(dp);
 		} else if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
 			msm_dp_hpd_unplug_handle(dp);

-- 
2.43.0

