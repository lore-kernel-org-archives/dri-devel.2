Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3578606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hL02yzLW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gzqp6kgX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B25A11212A;
	Thu, 19 Nov 2026 08:25:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA361120E6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:46 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wJqa1535014
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IdfU8FQPwAdn6E5eXYkFX4YWCsIg6Ob6rPzCVbT0A8o=; b=hL02yzLWQLQ8t6Ym
 fCgun6qT58zLeLa4SQFqCjQNPASvtjpkn8bq3gbOkjFIKR3EYX7+39lzCTWHo4Vl
 DL0b0pxyIkFlAOB/tx3w5gNWl7Cua7wPNr4JuFxLhm3XJ8XXMR5ENWca40VTcntS
 hgn9q2k68OQisbUZxnG1kjxuC75KTl9uJVqJBXT8OflGZWNnTDw7+H6XL6S2Tnkk
 4y1PqkXIC9yCbupR34J3Dg8+Nmg6woqpaPgUDQiJ1wld1GBacLTLBl8ZVTXt879a
 ciqtlIjoJzj0rqSR4chRndTByFqRigiM9oZ6BVVe0FiGnW2cwI1JrwCCZ9Pz3cuk
 xdkaXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpcc5gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f26dd2165so524872385a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076685; x=1795681485;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IdfU8FQPwAdn6E5eXYkFX4YWCsIg6Ob6rPzCVbT0A8o=;
 b=gzqp6kgXnG3u+Azy1hpiVgXlBmB4IenACqd6nqtT/6KYjP1b2owbzZw0MR4qdgTthn
 rkwJm6/1PVIZe0LTL0GGvjBWUqadAw91+9O+CVeuVm2lc7QGAM/W8HbnPEGl0hmGKJQK
 0vWYZ/uhz6jBNhmab4yvGXeQSLm52vXkzFNnk+nzIvCcxkKWQ9aCEH+GAULOT088zyO3
 mWy7lN+1WKXFT7PNWBabCCSxzh9n3ujhYfrwJWEBsL3vXsE8p8AQKIb+QJvFoC3jp0pF
 MrVJhwGb9lpazYalDV0lVnT0dIO15OAHVGrC7VGU0+PSe1gRZSe1ZAxFfeobJ7JRCd7T
 d4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076685; x=1795681485;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IdfU8FQPwAdn6E5eXYkFX4YWCsIg6Ob6rPzCVbT0A8o=;
 b=MTgGfR2NDbYPe81ullyo7kFwnpoc7sYBoD++prpYCLvVtGGTUu4lp48lfJ8dahs9Ha
 C/4BaS1EMAYSFNrQrhAfJDmPq3tDODFURva3vYlTImkiIGL4KirpN2y7F1AHridQ/IRA
 KYqmKhS18wBjm0u3KhMdy5gB8AWhcgiq0vDT3PEewzsxLLCO5dJmKbsrSP88ESrekzew
 tqYEheU/pPfPGF7kIIa4YtV+1NvMIPTTEGf6dj2uFaebIXOaaElhpmwziedo3XMqMAru
 FrIyeO3VVAemCeE7wpFsJDVzIdv9PQo7wDsHncgDb3JXDn+2PQDdU067abr4SNdP1Lhv
 3auw==
X-Forwarded-Encrypted: i=1;
 AL+hErGY/sdsMtQ5t2rd/U26vosajOWn32UTATOscwlkDAm54o7f5BHuY6QcYekIaJ9KalMOjkoi2ZM3+bI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90jGRyy/Xaqos9Ldutp1dKOT6Or8yfQ+uP9Vz6s5Lm2fKUCDLz
 jVPLSmjPiM4yDvpEe4917R8/5Us4WhnTFFhfPh5UHH2WbhaRHnt4RA+hDdqjrN0+KyAmyFLua5p
 vHbNVDtWQOb4yfmHvryOr/y3cb4x/EaOmt+Wev/D6UU8BTa2uunujd+ZajX20zkpdqDQxdcO4x5
 9SnzPZlA==
X-Gm-Gg: AYBFou381eb32+IA3QLy8g+aCqhDmCKEOiYZMB1tyDZ/XMnKOy6xrI+z4+bErnta9QT
 Rc2MwfOQxamljQt+gKiB7/4whPlvUb1Bf63hVZp/cT7V5HbrrnHtTwsbN+9VnRplmNg9y720BSb
 BWZWbhyezt0/mvsVj7WcvEeAUMSMw80Ecd8jEbZaw8zO3t8muPyI1RFSV4E9cfi2J6bxWlLi5jn
 +ykj7JxzSMsOnUwIgAavUDHF7yq2FW2EN51dn900y8Z9GJrl+ddz4G7ZH299Ko6TwL+hxnHjSmi
 fEePC4A9SZBWuhR0Lt2ZHSNs5xjZ1S67lsLtSPklciTCUVvS6KnGACKBzvrCh+T23a5ln7lmobe
 WPnRcVrQhKL55asuOtVyZDmfWBvSpMVKA1htQrf38aqNQ3YwfshoqLubsvxM7qZMqBepoYkIbOf
 wKdFhDfzA44SGkpWeOLVF0qVkyIkSUGP+p34c9
X-Received: by 2002:a05:620a:31a6:b0:93e:94a4:a97d with SMTP id
 af79cd13be357-9499936579bmr934125385a.0.1795076684955; 
 Thu, 19 Nov 2026 00:24:44 -0800 (PST)
X-Received: by 2002:a05:620a:31a6:b0:93e:94a4:a97d with SMTP id
 af79cd13be357-9499936579bmr934122685a.0.1795076684327; 
 Thu, 19 Nov 2026 00:24:44 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:44 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:05 +0800
Subject: [PATCH v9 03/29] drm/msm/dp: add support to enable MST in mainlink
 control
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-3-ca61be4edfc3@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=2559;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=SI7t4mGgwxefYt5oEm4+FHizneptrfaRYKYBLcB7QfQ=;
 b=mu7tfErkysXH9unfeTL7MVtpWwREec9rmRChsg5QNEKNPjrg3sK0Er8oobQu2vHUafSrxE6kS
 kGXpr0kJOS+DisNEGmnIl3w0DE+5kG8BEZhbPj/mLP0oJvuM//lPZCL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afeb24d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GJT6Fafo9oTAj6z5dyEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX53E4WHAVdKMY
 G7GJ6ShYIumLK+exKlS7vf7Aim/rlBO8IRmFbJCUV2nbeQgmUvZeXmRxh0mkTxb77L/y1sbSqTL
 Ua8I2do7Pcuc754oKxizCOdN71loYnYfDXTvv3ad+wAwvyXqaUZwreKCD6hmTfzD0gBkSjrH9qI
 AsSUPIEDOnyPfwG9Tp1hbVT1Cw2PyV9loOKA/DvJRGbN+VV3G/v4Ug2YTbDw1RUkhWpaFcTPQRq
 tuJ6rxQKyty4Jojs0Bc1NZ1HM6omgmo5v1T0rR2s7MMexMesKgmTsCiFFLBpOrKOeXMOMBjhfIo
 Jbavqjz6AZ5nOlH6Bw/FxlaCbg9XOYQ91TOcpErpRtoWuJbWKs7qoEMZHcJPCSpz92LWhMlHqWF
 9A42a3SAVd7zjvGOglaAa1WooX/z2uyAvO/qbn4uZrRuUEw/gNWcbS1twsOe/QSE3TGmeadQo6I
 1XF8+OLunVHLpTWNZDw==
X-Proofpoint-ORIG-GUID: sOj8sDBTYc8izWnsZGYhiy9KFhC36hQt
X-Proofpoint-GUID: sOj8sDBTYc8izWnsZGYhiy9KFhC36hQt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX8NqTYpnV5DVY
 8NSUFcfF6XBUHRu3kQL/yCl5ZrzgkOeOFCKtL8M1FcLKNnQxOqBbTynkOyyJBCLluob1Q7FT1//
 z52h2v0gJ2omjEsFprk5d1dx2G+4Bw8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add support to program the MST enable bit in the mainlink control
register when an MST session is active or being disabled.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1b4aaaca0ad99..41c6536526958 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -276,6 +276,19 @@ int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 	return 0;
 }
 
+static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable)
+{
+	u32 mainlink_ctrl;
+
+	mainlink_ctrl = msm_dp_read_link(ctrl, REG_DP_MAINLINK_CTRL);
+	if (enable)
+		mainlink_ctrl |= DP_MAINLINK_CTRL_MST_EN;
+	else
+		mainlink_ctrl &= ~DP_MAINLINK_CTRL_MST_EN;
+
+	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2689,6 +2702,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
+	if (ctrl->mst_mode)
+		msm_dp_ctrl_mst_config(ctrl, true);
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 
@@ -2743,6 +2758,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
+	msm_dp_ctrl_mst_config(ctrl, false);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 9263e61c794c8..cc74b1ed628ec 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -128,6 +128,10 @@
 #define DP_MAINLINK_FLUSH_MODE_UPDATE_SDP	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 1)
 #define DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 3)
 #define DP_MAINLINK_FB_BOUNDARY_SEL		(0x02000000)
+#define DP_MAINLINK_CTRL_ECF_MODE		BIT(26)
+#define DP_MAINLINK_CTRL_MST_ACTIVE		BIT(8)
+#define DP_MAINLINK_CTRL_MST_EN			(DP_MAINLINK_CTRL_ECF_MODE | \
+						DP_MAINLINK_CTRL_MST_ACTIVE)
 
 #define REG_DP_STATE_CTRL			(0x00000004)
 #define DP_STATE_CTRL_LINK_TRAINING_PATTERN1	(0x00000001)

-- 
2.43.0

