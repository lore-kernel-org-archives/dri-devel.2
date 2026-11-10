Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F1606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UhcPBz+J;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ea11eF1D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB35310EB4E;
	Tue, 10 Nov 2026 04:57:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC2810EDA2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A1Nn2294803
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kGmOSxaugPIJYRGrz5sk5TBB1f5tCohgbLSqz9Wr2Ns=; b=UhcPBz+JTBasQSnT
 u5bsN9sKpht/QgsQk3IGSI49Z9aBYzIj2BSTrDCzhQMpreBYkqzBEwC2Vwd3VjyG
 vXCBSBGQ8m2adoWODA1ZhF7s0ysaliQC1siVGtJnUoY4J/9zLiMAWkZy6OS9q6kT
 U4gAM58xQoi+YWCpoGUoUVvDPJuS6H2jwkNTF2VZIsB4IF1uKW/Mdrp4Er8j6tUj
 vl9XM7ybuCNl3fFcvEMf+3LjO8QQPy6MHfp4WzzTJlQvklRDqwJxJrBFtCtpPxHP
 S8vE7EgoRhwRLwOkTiDG2MriYhCNYxr+XdUM9Dt/Ag+hETmcbIH8UK5V8xC9Xi9k
 l21MSg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5und0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cbf2fd504so306393585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286614; x=1794891414;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kGmOSxaugPIJYRGrz5sk5TBB1f5tCohgbLSqz9Wr2Ns=;
 b=Ea11eF1DnITp3ffapGityySRQ4Ys/kGPwJsJCqdEDMdyfzr1ma+FbPXm7LnQzSsifb
 Z+oNlwcP/AoN2RXQtDFph+hpLOWNkXr8B4ciI2WOFJzgaStzlyYFCd4Wvk5sArXAbPDT
 v8vbYcS7p2IjlaPGuwcEK3yuP2wssvgCLKRH+XrMC1qnbHnMCBAH3zbvtJ3OBaBzcu/D
 qWNFuOSmn8qbfUoiyzxmvvPg734yRiDGN8vAU7ea9MlNgPz00xQrSQxOYcyObVI5RPFF
 LjTa1gP5p2KQHCuhz2uXRr3Hq7pMK/ubvK5s5XSJ0LEOeWpyn6f/bCjxSXremijCsHvJ
 k1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286614; x=1794891414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kGmOSxaugPIJYRGrz5sk5TBB1f5tCohgbLSqz9Wr2Ns=;
 b=BO7MMTEl59mqtGG08SknOCoUUzbUL9zpJXap7dp2YbZJC+ECDJP5Ux43cQnZ2FGe8A
 +cVb7OAuX/6vC+CyRY2CkUSeRJzXRuFP2ZgPjTzy7M7VZ/kOmEb9Op9SMZIv0mBhhg3F
 Pd9EILezTlH0W0E5blBOsbfRsFX/tB5uh0zDCfv8iiaEoVWZSwXaG9jQD08uBz24+2nD
 PCstAbM1VQGg7VqUKti9fIuuRiY505RrudBzjOp/oJ5WtMyQAEO4xBJSw9WATdM1jF8c
 HeDm3RIZB/1hQ7ifQCWObLp9+W2byb5ES/2RDTqJzfGpUlUeMfE9spYBY+7sAUmdqZ3F
 eymg==
X-Forwarded-Encrypted: i=1;
 AL+hErEtVu+sNiXLMwRXBAvxvcND8R2wjTku8m8WOKxqCVBKMi6kjGMBjrci9lFq1OUa9mmT/4H7gKpzHLo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+3t4B31KvkCetauJmv+yZ7jwLkAXhPW8fAFuPiPMRA99flzpxg
 2VZ/Pheh5WF5riDb2udjtlNlKUr0X7/mpRzJDqyAd8SAhcvwWLSWpWbuZb39JzPwITHtoLOxMWc
 4kgmDE/+r9k3qZZnzB7QiQNvNztzhA2DZExWT6GsTFERufZeIJd9R2LzxXJEt1O8sA/gcezk=
X-Gm-Gg: AYBFou1hvRR/1/B8am9aj+zGLHr16Xs8iNpWaFnokIpueIumfjekk3wXJwwyutbnnQl
 urzIl1ip8ZgWeKVDR2DIvC1f70V/DEGzOc+YkCrB9StHsaOADJQufoZn5uNvl/a4/lugSu8bW8e
 mgI2wt/hNvyYWSfih8wy7qvUltQSpa/vk7T2iPGn9+YFyTOFKirxXiHO+z7BYW5ziJODDx4Y7LO
 N2/wVqSiWKDcQYq9K+IGc+lipfmnfbYdnXWW774c95vJPtvQW9dY1CUtQbuD7vzFkey9LlSJIcK
 fJZGiAsVtRYPjpjP+4jcTnqrXxuJtNAghACZxdUl49VILYWSYaL7tp917KCBRUc5MSEoGsCD2PW
 dhYxE3oYfHF1TWdNWhJQDiAbOcqYk3SW0WJa/MEXGCJCiuw8KG1ZmjskiwnsSH4/JonqgfrxADC
 zVeuNjapiE4BQtDTB4AeSbvxM36NxXgcOVCcpt
X-Received: by 2002:a05:620a:3194:b0:93f:1936:b229 with SMTP id
 af79cd13be357-9479f415639mr260384785a.77.1794286613909; 
 Mon, 09 Nov 2026 20:56:53 -0800 (PST)
X-Received: by 2002:a05:620a:3194:b0:93f:1936:b229 with SMTP id
 af79cd13be357-9479f415639mr260381785a.77.1794286613468; 
 Mon, 09 Nov 2026 20:56:53 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:53 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:50 +0800
Subject: [PATCH v8 29/29] soc: qcom: pmic-glink-altmode: skip retimer reset
 on DP IRQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-29-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=4115;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=6r0ejZlAtNiiuitmrFYzWgKZtKiCeBVKShHo1hB4+8c=;
 b=iOicxdJg8ziVZ+cp1bR3ru9Ky94fiUlHfpjmXgRiOzxB9jxEeGwu2qB+KpGq98y/UqFs+tMj5
 3gmwhVWZ2+pDIMzRE7Ud8+HPiIovAUOWjuCRGFvt/VR5AbsV3A+iw1X
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX68XZikMngU74
 u8U7Vu+Q0U7C96HgB+Lghd8g04KM+LJPERegn7AQtvKASZxQ1cXQb73QafaK9a+GgmWUlFLECeh
 w94huyh+V2/u5K7ahlT9EBWNug1ADKQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX+zrgsNP4tPSh
 w+2pu/qq46tp3Srt1JY8Rsr7/0UM2X9LLCS3wnqfir8wF23YuQEDjwl8aIT9qfV2Giw595lOqsE
 UcSN/ypJeb0oSQiRwvX4hvTqjSC/DA3wguHLvQES95jzp7OWo9QYkIpFK/+I6cKTEW01ir0OlkE
 nkkozZTDQ+78qkXJDVXVfhfBVRnvzOwVa/jQbAh7be+D4OeKlzJTwZ1JGN5PP2KjCKiQA7oZSdo
 crU2F2DhnNMyQ/m6X4CZFTCUJevPmmJu39xyU2++NDjDp+TlsFCscU7Jb/t3tM4+OIhhUp5lWEf
 D/v7XNxiA43AgV2cAA8J6xrtZjjeGoteiEBwsej3YBu7vL9gOOq9DurLfaJSyiYt3Exm1yiiQpv
 NX2NHOjkzW+cQoXVc6BtebTTEznwIxxOlnvKC8C/iXEEgWs+xv8yjLqIyUYMkpDYw764j/GJRQU
 ToG4URJBls3DzE3HaDQ==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af2a416 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=rzLW7fUJNTnmvIt_Je4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: eP1UnsVfmAFLKsSjkIHMan5MtBkeQ8U0
X-Proofpoint-GUID: eP1UnsVfmAFLKsSjkIHMan5MtBkeQ8U0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
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

A DP HPD IRQ reports a sink-side event and does not imply a Type-C
routing change. Reprogramming the retimer for every IRQ can reset or
disturb its datapath while link training or video transmission is in
progress, causing intermittent DisplayPort link failures.

Cache the successfully programmed DP retimer mode, HPD level, and
orientation. When an IRQ arrives with the same state, leave the retimer
untouched while continuing to notify DRM so MST sink IRQ handling is
preserved. Invalidate the cache on non-DP modes and after a failed retimer
update so later DP transitions are always configured.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index e903d4910e9c..5ae554dc01d9 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -121,6 +121,12 @@ struct pmic_glink_altmode_port {
 	u8 hpd_state;
 	u8 hpd_irq;
 	u8 mux_ctrl;
+
+	/* Last DP state successfully programmed into the retimer. */
+	bool retimer_dp_valid;
+	u8 retimer_dp_mode;
+	bool retimer_dp_hpd_state;
+	enum typec_orientation retimer_dp_orientation;
 };
 
 #define work_to_altmode(w) container_of((w), struct pmic_glink_altmode, enable_work)
@@ -180,6 +186,7 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 					 bool hpd_irq)
 {
 	struct typec_displayport_data dp_data = {};
+	bool retimer_state_unchanged;
 	int ret;
 
 	dp_data.status = DP_STATUS_ENABLED;
@@ -200,10 +207,31 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 	port->retimer_state.alt = &port->dp_alt;
 	port->retimer_state.data = &dp_data;
 	port->retimer_state.mode = TYPEC_MODAL_STATE(mode);
+	retimer_state_unchanged = port->retimer_dp_valid &&
+		port->retimer_dp_mode == mode &&
+		port->retimer_dp_hpd_state == hpd_state &&
+		port->retimer_dp_orientation == port->orientation;
+
+	/*
+	 * An HPD IRQ is a sink-side DP interrupt, not a Type-C routing change.
+	 * Avoid rewriting an already configured retimer while DP link training or
+	 * video transmission is in progress. The DRM HPD IRQ notification below
+	 * is deliberately still delivered.
+	 */
+	if (hpd_irq && retimer_state_unchanged)
+		return;
 
 	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
-	if (ret)
+	if (ret) {
+		/* A failed write may have left the retimer only partly configured. */
+		port->retimer_dp_valid = false;
 		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
+	} else {
+		port->retimer_dp_valid = true;
+		port->retimer_dp_mode = mode;
+		port->retimer_dp_hpd_state = hpd_state;
+		port->retimer_dp_orientation = port->orientation;
+	}
 }
 
 static void pmic_glink_altmode_enable_tbt(struct pmic_glink_altmode *altmode,
@@ -214,6 +242,8 @@ static void pmic_glink_altmode_enable_tbt(struct pmic_glink_altmode *altmode,
 	u32 cable_speed;
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	/* Device Discover Mode VDO */
 	tbt_data.device_mode = TBT_MODE;
 	tbt_data.device_mode |= TBT_SET_ADAPTER(TBT_ADAPTER_TBT3);
@@ -271,6 +301,8 @@ static void pmic_glink_altmode_enable_usb4(struct pmic_glink_altmode *altmode,
 	struct enter_usb_data data = {};
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	data.eudo = FIELD_PREP(EUDO_USB_MODE_MASK, EUDO_USB_MODE_USB4);
 
 	if (tbt->usb_speed == 0) {
@@ -307,6 +339,8 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
 {
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	port->state.alt = NULL;
 	port->state.data = NULL;
 	port->state.mode = TYPEC_STATE_USB;
@@ -329,6 +363,8 @@ static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
 {
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	port->state.alt = NULL;
 	port->state.data = NULL;
 	port->state.mode = TYPEC_STATE_SAFE;

-- 
2.43.0

