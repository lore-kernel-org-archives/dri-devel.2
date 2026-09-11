Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C2FC88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9751110F1B1;
	Fri, 11 Sep 2026 15:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UKUKSI2F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6UkVYPV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDC110F1B1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmAgV222597
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 upzPaWlpYkfrSddQ1mDr+WdQI/uJnfLhDS5vPD3iHGc=; b=UKUKSI2FeVhBuaSg
 Z96a8HxOO5o7Oc/dI9rps0wxMrAiwn6q/lcUP30hZ14ieCMOzpOk7Rfw62afLj4h
 KdFSoP15O9lVKcLTq58hVMw8zRRKjaHbrfsAQCGKtsMdbrfEmH4johQn1akNabJn
 HSDkKyvQrTFi75zt5m46MB7qeLYXcOSVVUi73YnOTWzyyStfCqE7yoZkpwwdl6Vm
 B67WLsJsksIfOz47hgqK6+zsLhOT3o2bspipslegJsAT6W5HzXMk4fiFzNDCYBrA
 EiatcG+4NMD0ZtW1U4puNKTEcrLhdff3ZIpKePW2mUX8BH8ebqrc3kVI3/tv6vRm
 wKvKbQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdrag88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:09 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-46509ab0149so1332761fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141088; x=1789745888;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=upzPaWlpYkfrSddQ1mDr+WdQI/uJnfLhDS5vPD3iHGc=;
 b=Q6UkVYPVoFL3i6RXmJTOrxKO0XKfJD2M3Nt4d59cva2V8mxNMwxHQZCrLeoUbap77E
 sdwvDPW/X+0YId5deRjKaVsbYhIpaJhQhPoM7UvvPbxt1BfBKv6XTAciV4HUzQ0k6uXI
 7Q4Oxy8ViCVUp8Wno+pAchShRyniT394PPtGfCqbuQ3hPC0PvHRhoHPlBo/WVrUmbkk7
 Kk0CoEU3y2Pk+5wmEO/3zHvANUt5FgPC65QGyfdHhmsVASgYUAUhyQ6sEOk7A1WjfuaJ
 ccByE6d4WZVdHoVUkqnX6A4ewRTVlqnuu9yYnkl4oq4uRPVd6+n289KGA0GuB5btHNUx
 v/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141088; x=1789745888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=upzPaWlpYkfrSddQ1mDr+WdQI/uJnfLhDS5vPD3iHGc=;
 b=PDa4sQsQOD2uhXshr9Go1Cvs0dY41OTl8GfB7j9uuYHY6F32zJcPC0Z6Sfmha6WrZz
 ghpVxZZ4quyvugFAXM8FPlgr2INClJNsObPkFqmrItP5fR4AX6YCH2MsPs5ry8NTDYo8
 3FJTnm9Af/nRM2Qu0n3VJ4KeZV6oOWsz9TNazsiMhd6Zze61VEZTQ+uTv24S2WsXXijX
 3tdDn2tfOToUtyXy5fUpqdSQH0yDbg9eDrV0RWxkJe+US7BQV741FED/xZTg+590SFBU
 8SLg45beHkTRcU47KGoapAhB9P4CYLEJ9mSaN4Lkak72senX4Wxmt5SdiPNWTeHjiQKN
 AGcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxT+wYJHfGK23xGdoTGAsthMKul9Z3pfg08POdzmYxjVkeVQSIaKcK0jPgsIN5dQpy64aUzlnwO8Dc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n++1gHudhVaMJ0HRtFSWNPNjBS5s4G5CWhc2+aDLjjl0t0Yl9Q
 Ogft0g7NT6qjMqR0BLaMpDADh1OwfH7qyp061ujKOEB3THsByL1/aru9Ox8sH4TZ4dJz6WcuqS1
 H3tkQ/SG6/JhCxYwqWf/ivIPn7ptLl49BewwdsiFDqtSlCkBoHbYcooBwm5pF733We3nJ7DQ=
X-Gm-Gg: AYBFou1/g83nOI3GNLlv8Fd8w2bA1imRkyi1aijG7aUwBAmtpD1AdEfMBE8SNof6cZl
 L3KPJ57KlPRccxXkZF6Plv8EGpjnM5Q3VP1ljd8hqy4E86+YqGhmIe2Jq+3BM5RICzAGHcpblw9
 9Y53M4YDXr38DWrz5OmbCvtIOpVfvFlLnOdLSrdwunUtTen5ce9JglSBCttzK3IOxeQHcWSg7jB
 SeILx1O6Ky5ZqQ4Q5Q8F/GzyDsFwk5fbf6AooaKiCkKzawC0GFO4hzDhi/0fpG1kybEWKeY5/yF
 cr31JvM4s7kN+IjhBdPykNu5yfVDILb1gd/JlEXIuTYfGX/J3hR9PJoIjLlnAk674SXgRoNK4Zd
 mld0MiDIbyukRv+lSuRTMtvDqO90=
X-Received: by 2002:a05:6870:e18e:b0:462:f377:8e0e with SMTP id
 586e51a60fabf-47de7e627a9mr3865935fac.13.1789141088636; 
 Fri, 11 Sep 2026 08:38:08 -0700 (PDT)
X-Received: by 2002:a05:6870:e18e:b0:462:f377:8e0e with SMTP id
 586e51a60fabf-47de7e627a9mr3865901fac.13.1789141088231; 
 Fri, 11 Sep 2026 08:38:08 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:38:07 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:38 +0530
Subject: [PATCH 07/17] phy: qcom: edp: Add Nord-specific register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-7-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=2289;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=c2odpdO2vfgQoFUA7tiaM/+kgmxU4W7SmF+t2ifOrto=;
 b=RLHZeOgOT8EhVUQ/NgLwZ4eZ8AhVJ5fw2UNVqvVwvwmfzYZoHde7GpNOePPGDJPTY9xHBIAOK
 qEFA66ELQiKBLzd/dnrBKOZxtVvWpCtdR3pt4Xus9W/Sqs3Ot9anwiK
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: eyJjOj-tc0BTBcO0Ju4BZbaVSEE9zcmB
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa42061 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hULVr2eflTS6rL-ZrBcA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: eyJjOj-tc0BTBcO0Ju4BZbaVSEE9zcmB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXxUSsvdBsn0Hz
 HEz1cBck0EweIt5IsfRYoVPPHTKrt/69QZkMBecy+MdppZ/mH/DrlqOyQJmb75xjH71wFZvk7nC
 YD8GcT14v2CtJmLij4uExl8YzEp8c14=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX8ItGJClBzRX2
 3CYxsa02pQoX1ZXIYcJ9QfZLsuHQ9R7WdKMBGHCnHr9iWrziUbLIU+7uuMtMw7LA583QVrSvolq
 KR7o0brC86BoT7Y8yghlK7nqnvWvvLfs4h3XH9mIWGgH/Fp7uqIHfodjh18z+HwNQ9FQ3Ir0sTV
 IR5Wj9P7mAkgi9eSqMTPoGnF92MCE6VYmftkcMsAUYfur0KTtpUbEZXPqMgJoON6h9e4S6x8jEm
 q8Vc3AxUNZTCmiDOJ7OhZ6asaSC5eH83cHTbFinY/nzmn8pwpuzjmIxfRhUcPgIFddxnW/3dEwO
 KuOEKamRXqSJiV7ah6LrwSxF2mFx5n3Gfl1lC+yNJs/0vi38dOof2Ly5gCtjzOZncRhfwyI6wWU
 7sWOxhNzQ2wER3vAvwXZZEHsVtmLRLXGbVLDumOEzhrliwDr98SMY8vn7AVVV+xYpYJ+FtdV55x
 YyFEP2ws+U7TTK6rr2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110218
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

From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

Nord relocates several DP PHY and QSERDES v8 COM registers relative
to existing SoCs.  Add Nord-specific defines for the relocated and
new-only registers in phy-qcom-qmp-qserdes-dp-com-v8.h and
phy-qcom-edp.c so Nord sequences can reference them by name.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c                   | 10 ++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index a3c893f72908..bf8a17336c7e 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -41,9 +41,19 @@
 
 #define DP_PHY_VCO_DIV                          0x0074
 #define DP_PHY_TX0_TX1_LANE_CTL                 0x007c
+/* Nord uses a different register layout; non-Nord value is 0x00a0 */
 #define DP_PHY_TX2_TX3_LANE_CTL                 0x00a0
+#define DP_PHY_TX2_TX3_LANE_CTL_NORD            0x00c0
 
+/* Nord uses a different register layout; non-Nord value is 0x00e0 */
 #define DP_PHY_STATUS                           0x00e0
+#define DP_PHY_STATUS_NORD                      0x0110
+#define DP_PHY_LDO_CFG                          0x00f0
+
+/* Nord-specific TX lane registers */
+#define DP_PHY_TX_LN0_DRV_LVL_NORD             0x00e4
+#define DP_PHY_TX_LN1_DRV_LVL_NORD             0x00e8
+#define TXn_TX_BAND_NORD                        0x0024
 
 /* LANE_TXn registers */
 #define TXn_CLKBUF_ENABLE                       0x0000
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
index 93edabb830af..008b17222a8d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
@@ -48,5 +48,8 @@
 #define DP_QSERDES_V8_COM_CLK_FWD_CONFIG_1		0x2f4
 #define DP_QSERDES_V8_COM_CMN_STATUS			0x314
 #define DP_QSERDES_V8_COM_C_READY_STATUS		0x33c
+#define DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL_NORD		0x17c
+#define DP_QSERDES_V8_COM_CMN_STATUS_NORD		0x1d0
+#define DP_QSERDES_V8_COM_C_READY_STATUS_NORD		0x1f8
 
 #endif

-- 
2.34.1

