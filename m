Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A3606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cx8Su9ej;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XQJs5LUp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1790E112158;
	Thu, 19 Nov 2026 08:27:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C17A112170
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:50 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vYlV330748
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hRRZQX+eqmNzQk/wsKwwDxPTTQ7ZRNUbWAXYNhs6rpY=; b=Cx8Su9ej9UYA9n5L
 sFyvr4m+ES4lorAtxwkrziULhfrMIObrCYkcL+9KWnYMwTN+IH52Bn04RDr9rwBZ
 FSl8PDMPkYRuFCEovEQv4dn6DagEBtliXyVt6Fv+FpXplhOYadN4JkzB2AgvyWdE
 DTyDzUQrFIryjMN6A1QI8FoQpRySByzkpr/kDTBT9kbTQG3ZunadYPKEw6KevaQ1
 5/pF2T2GYpiBV12oBMsqpaWJGjmOOV6gwD8RzcfhHYF7WaUQw6HobRMWkNtAu9Gr
 yP+3cb5DCphERfXy5MwZYmFP91Pbz8bToTOfBo3xbkCQMC1nGjElgV4TbdZ3Xa0p
 6ESA/Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnkgpg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9210ec7cb34so3851966d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076809; x=1795681609;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hRRZQX+eqmNzQk/wsKwwDxPTTQ7ZRNUbWAXYNhs6rpY=;
 b=XQJs5LUpmIQlf2tuQoeAKyiJXDXOklGM+ACUzCv4CiAFGJdpiTtqTk4z43Bj6iFFfc
 XRp7TJXtQuTN2sjJiD8j06BO5uMu7ABC8C7wMCq0m4IEdi9ToTxMEQzjYpRL1FOrJQ2P
 B1zsxgjveI2KLzzwKmo2dAID+Eh8sOkfSZe8IMUBhyfsEzK9otcpuug8Oc/ZEhreW20V
 xNqHv5Gfy+6X3QzkqjDuck6AwVIq2JBWUaQ2yR1hot1nZ0p5TPSJ4ShbpaBSTI4t3ESt
 7Om4c7KN5WCDIWSAx9EeL2IXKM471ULpKrrANX2+tIAVCWXb8hTzFDNPeuNax9f0TMJJ
 y4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076809; x=1795681609;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hRRZQX+eqmNzQk/wsKwwDxPTTQ7ZRNUbWAXYNhs6rpY=;
 b=BCDlSFgNSGKhU/USXAHWdAWC9lZxNl1/4XAiglgqZ+vHBYnJarlOh+5CbNtj4YRpun
 /4mZIpxsVpLP2KbdTnjqBZ4iguWbeIMPcjnD+xPvZK7D8Zc5czbLRLWHw7URjeqS6jXn
 +VXwK8HZ3+SDiV0XcTuv0+hanjB2mq3zUOyDaqjqoelTjDEbaZwqxhovYZrfWhTwdJSI
 SE75euDSoBw2xt9J1JoXNCBj2vUIJ4XDyL42NnefldqJVwNE1f4+YU62IL9uLi19ns/9
 L3dEYnXsIwtfteqoirpKT2q1e8DE/pHczrTKC/jNQb8ESWb3I5f8DY7UW2SzeXIPkBBw
 BQUA==
X-Forwarded-Encrypted: i=1;
 AL+hErFzbDV6SIOd1FYY4zdsAXk+X7pP7RFqRfsVRpH1dHJe53ZXDLObmWJMPjpefK2a9J2Rv9ySgJnWnTc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+4jaRP/UywRS60QtMiUW7MEf+XZ33xDqMVlT9LsYvArUIHUf+0
 5YpAXjMR+dzXDNvnnLOJJsWW1qxZ19WkhHGThOs18K32LCgaQg+XFHipA3GCZqABFh8NFoqPKCA
 vmmVuypx73+VpIQYf0q5xQBFfI6biKqUj+DkMyiPv8wc0AA32liaXO6M1e9oN6Q1yfUmeJEq0Qn
 VXCjEblQ==
X-Gm-Gg: AYBFou06S4zEWaQmnWUaxyRJtTfBDdZoAkwLCz8Kp/UNOil/BwAy+L2QjEPDKihQK36
 PAPPPQo4DaEkxATtzWAhgNy9X2nzN3VzGKqz2BxXrcvy/4SVC8IsM/MoBbQmvN4uzydaU6li5aD
 2aPwB1jdoMQQd4aGCFSMrU9BF+w/OCgayxriBnX86WVOQrHvfub/B9c21buA2x1PnhtNKuQqskn
 RYM/9xtgaL7mvMqMfW2b5G1amd1a+EiRpAfqxG2ra8zN1ENltHNRx9q5jMidfrZFS19S0YUzfpL
 ndNrRMxJNWHago1+r7GaYNEuTiDI8892HI/X+FBfFK7rSW8A1SNjjcF6f3KkrfCUnj8IyxeLUfY
 oWeaInU2NYyESDQSE/PUw0zMrFWla53Ii6T8SNlzT45C5ACwpBo5k5We5ly2mOiacDcia32nxo+
 kP6lYg21AL5oNUGdg7eib5ebVETfcDKcgowkWQ
X-Received: by 2002:a05:620a:170d:b0:93f:2f48:c9e5 with SMTP id
 af79cd13be357-9499975fc72mr1009160885a.34.1795076808802; 
 Thu, 19 Nov 2026 00:26:48 -0800 (PST)
X-Received: by 2002:a05:620a:170d:b0:93f:2f48:c9e5 with SMTP id
 af79cd13be357-9499975fc72mr1009159285a.34.1795076808337; 
 Thu, 19 Nov 2026 00:26:48 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:47 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:29 +0800
Subject: [PATCH v9 27/29] drm/msm/dp: ignore IRQ HPD latched together with
 an unplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-27-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=1164;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5iWOkKJwZjnY1MHKdY0LsxV2ilvtdmCr7FzSCJb+B/o=;
 b=+zIMf5zGBx//vypOrS4PVt6cpbzTe3MZDukk6V4mfXDnjTnfRsqMWRgejWZvmLKPaXjq5GNAJ
 ZVSCRiJQu0oALuXQqstiRumWW4q0nXmNbDKwqdZoOL8bBGi/4FXPQf5
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: BgTcm8XLjyu6Qai6jUO2zDdmS48nwws4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX3gKingt/Gldl
 qimmBP3vsvthEoykhSLnxGKEJh7l3ygFjbgo/Z1mDZ59Vlge7Efw0IBxRvOCSrEbcrQcrbS0m5E
 Kje9sB3sDfDapja2gEmrnsO/HpwcN3FK/l6WNNLJHWNX3aXtIlr1Yfigx0y5qPU5yxRbtFNARjB
 iDGIZu2wgCOEjThQ2rfhP2l+Q3nH7tkfx7KBsQWttGFAYWa7JkhDiBfuMr0YGxmHZba8QrscRiR
 UaexBJvgLQFFviPVHNujXfKbXZcjpXc0qvW1WRcHR/JDOCPNYvIOYF0xb3DF18fuZCZYxYkF5im
 oW9tdMkgTcG6zVW2nIzk7uunxcDjUn20725kIxhCxswSp4jbq6GW25sLt84vWBAuCkisZbSckq8
 B3EgYcnVmbTHNNIvMTas8Zqe0bZfoz+grx5+W/TK45HliyWCSX4ooo/oh6jUbyMnq/sgz/C5mxM
 14xbwWws2hYVAbQNgUA==
X-Proofpoint-ORIG-GUID: BgTcm8XLjyu6Qai6jUO2zDdmS48nwws4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5W1pnLL+GgOe
 Q/vyJqGXKuX10fqP/Te0Z9MazvsY4oHWSjtKLkdMoOMeYd+mq8SaxuvN0HkZJGtV93Xslh1TcU0
 m7xbRtjL4g8U3yN2oh+SdlNlhrMY0/0=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afeb2c9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=GWmhsmQFvB3G8ctGRoAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190033
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IRQ HPD can be reported with a plug or unplug event.

For unplug + IRQ HPD, ignore the IRQ because the link is being torn
down and the IRQ may be stale.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index ad8c30a8ea79..69d5ec4e175e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1131,7 +1131,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
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

-- 
2.43.0

