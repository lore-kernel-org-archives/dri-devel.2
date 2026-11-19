Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90740606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jb2YjZZU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PapwRO40
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88AF112120;
	Thu, 19 Nov 2026 08:25:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0005B112125
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:02 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6v8ck1962490
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8ikT8qxfQoYaGtQF+eau1LCoczuy8DK9/lHIbbn2is8=; b=Jb2YjZZUlRRsQlzR
 ExIceSeNav5fLQO26QFBOohJgE0tpCso2WyhLmdxH88o2TfCCnY3tNzh7rpB7nN7
 uc6Ivka0wiiQiVcO4eDdbx5jpBQEX47MrB+ptHuGsgN6tAx0NCa4vx2PumupA/N4
 OZizqPRMu2uqcXVAQGN2PVZprbYwEXcUR2CC10B+DTbqXPOI6RBW7ZU8qnN+hiE5
 L7PnKIutJGLvwWy1UCXLTBXfSn9stCF3LxRRPg40X5jdl7uAHWv63PKnOMAzkpqZ
 F+YR3+IiZO2t/WvU8u2qiE58GcQR7QwHKm1q0mlFmAqcUnggTAxcTD5VO1Vx29j6
 mExLAw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1gxcu8pf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2c0e6653so343875985a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076701; x=1795681501;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ikT8qxfQoYaGtQF+eau1LCoczuy8DK9/lHIbbn2is8=;
 b=PapwRO40pnuGRVRhw53vwFv9fOJ7rsTFd2sJFIc0wkUJaK4NWp8rW4jQLrgbAupimk
 IYu4k6zb8jUTqFQUE+CpKT+QGSL/OzWZdm30rXigxnj7knUxOYkewSXo9brfaQp9Vkpf
 sbneNCJVh4Lge689JHHvxrIBouJ/TbRJrFssUBrcsCW5G5tk5ZwwLQ0Mf/E7v4Zy1eI1
 ar/xdt9uKYK/TOnY/lcjGMuM0aapUxF5ohcrF/TDSYz2Keh55wMxSTgLSE6/JOtTmrBz
 ufI8zNmWHIm81Yx1QmJy/C6Oyp1w8uLkCIOOsZIR7jvrRofxy//qIxv1pijvN0nFjMFl
 dvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076701; x=1795681501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ikT8qxfQoYaGtQF+eau1LCoczuy8DK9/lHIbbn2is8=;
 b=PSiR47KCwB6dQpXOfvQZRPyiMjDUaQZJnRIh8HZMyL8j7gjpAvktEI154Etp3OZCGQ
 3NMqjBzABgMDnNOka4Z6YWI7j3SaVIrr58WggaAvtTLb9Op+KoykInlw3yV1HfePqhWW
 rvR/skoLxljoPghdrPeJMP0zmrIZ/qlS7swfkwgh6BcBuA9cbDvsQ07u2Us8F6Epf+cB
 FS5xG0WCn8Ur0OsR1kNO9gOHAywxviSmRsBUVKdZO3kH70k0ynnzTkvGKS+E8S88Eu63
 rtwHLaCyfjf3xAa3L7G71SveEZ7McWSwENvQ/DCxZm8OYtYqkgmnUPDjnANgTRRZHiqS
 htGw==
X-Forwarded-Encrypted: i=1;
 AL+hErHBHRpIa+X3xtw75BcnYJejpsMWBGIgic2Ex3bf4MPa7YpmlMgr/Nr3aNT4rkg26/HADif2fb7lDa4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+vj6b+RlQQcSqrUfY8h9nKDKX3fRL+e8eDGv7QY2tEXJ5yO2dH
 FwKKJGLpLZs/iJX2e35WBAMONMayIYIf7VJKqjJ0M7s0tyRz87vVwROv4j1j6Z3BuXg08qqDHJn
 bb+Yq6/PI6cWLUw5NirnfpHfHdqBxaEX1tmsT2yymu/OWocZ81K9FU64pdY0Q4MWNKkwKX1o=
X-Gm-Gg: AYBFou2vrgwPNgSBEqcBrQ1pBB2NCZt6rCLcTmXyJcfZJ2EEEWM3ChbN2QpsYA322xE
 4Gd48QWcDu1yxgaKmlXtp3i0mvdOdBOgDPpAiTJ99i97bhqOsNpQbeJKJbHSRrxOswrJ77JO4lq
 VQWVxsEtDx+NoguU0HOG9MZiWO2nFWVIau6YGWoqQoPEMo0a5YFVEjlhqXPPYk0MDwVscNg6FRQ
 89c/sq+Bs4Gex/lqnLEfbURlJkdCx6teacsCluJCCY3k0j7M7pcAafT5RxQOs+f1pQS2jaDPiMP
 cGUzpzXVug+wXSjbGIpWp/FqsszABnSOehhhFWlNTog7z1IoZY6Yaciv6O78Sqep6HhPWak+KkY
 rlwkMShCw28KZapkCwZWpUzUhaneCP3omwZOTMK5TKmpJwreOZjEZAP6y69adlLF6ssnUq3x1EP
 uH8zh9IUVd53tVAUryAlh2ky3KmKTtsOJrofBE
X-Received: by 2002:a05:620a:170d:b0:93f:2f48:c9e5 with SMTP id
 af79cd13be357-9499975fc72mr1008778985a.34.1795076700963; 
 Thu, 19 Nov 2026 00:25:00 -0800 (PST)
X-Received: by 2002:a05:620a:170d:b0:93f:2f48:c9e5 with SMTP id
 af79cd13be357-9499975fc72mr1008775785a.34.1795076700440; 
 Thu, 19 Nov 2026 00:25:00 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:00 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:08 +0800
Subject: [PATCH v9 06/29] drm/msm/dp: add support for sending VCPF packets
 in DP controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-6-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=8277;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=djwKXgEETnAdOysD0NcsMPGENTHyc3JT1+jwNAxqdFQ=;
 b=LPmlr6mjF8xe4Y6Z2Q/8INDqMMUoWKMquCVfZmVKOnq5T5PuUc8M6QpAgfi09NJUferiZTV5D
 4lJq5G70G1YB3dW/SvfV9RjQHI29OsSV6X+em0qua9D4Gik+idBfj+S
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=LZapeTfi c=1 sm=1 tr=0 ts=6afeb25e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3K0hjHndsinMD8gLsdoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uz9C6PjSLF_m6_PcDE_8p2QWQpsWeOmI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX+xIHQ2+24Aeq
 dwuNzdbaiRIS8XJdofsQUh6evgqvzw9RSllE9TLbtfyw/e4KWHu4B586yxlOpKcv39r76S1xUku
 Gf9mFGWUflAgbaAvHtCqlq9xtk83jxaKX74M2eI9/6KyghkHRK1b6NxN1BMzs0Bsy7ZtnWAGxWs
 aZF2dprnuns/30IgxoP2cm7sbAg9Efag/2wr8/2BY8nSOok5h6sOcR18KMnYCcN9o3myo6Rh+Mr
 wLay7uNzrwpXAUQCAeVW3ZZDGeQT9e+pORIsT/81RuwO4q2ZD30/Rlrmu90txKe+gYLeksVcfMs
 Wx64PFPduEAVIFTWuKekq/n81rEUD1QcMRjCOZT1GkI7PfDzSx9lzINb4ZpIRJ5cYlgkBxAie7f
 TgYGYoJP+O2RNkbj/unYb44EjoCLkDARhSLH567QCWzWM8Zan5p56Pkja1nENpr8gwzF2fm1a6A
 UFA8l+kaD4dVA+sgYMA==
X-Proofpoint-GUID: uz9C6PjSLF_m6_PcDE_8p2QWQpsWeOmI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX0j6nFlK7SlhI
 DXyfObWrf8pviMD9RzQw3WLfLW6DQ8tYyPs5u6avz97m5EAJs7nuMemWuYxePbOLP+dRXAsZjBr
 uuopkg1nR0Ov6RgFLnwDPixwMkaSYu4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

The VC Payload Fill (VCPF) sequence is inserted by the DP controller
when stream symbols are absent, typically before a stream is disabled.
Add support for triggering the VCPF sequence in the MSM DP controller.

VCPF completion events for streams 2 and 3 are reported in STATUS7,
while streams 0 and 1 use STATUS5.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 86 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_reg.h     | 12 ++++++
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index a3aa946c24257..2ff36d3fcb67f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -65,6 +65,16 @@
 	(PSR_UPDATE_MASK | PSR_CAPTURE_MASK | PSR_EXIT_MASK | \
 	PSR_UPDATE_ERROR_MASK | PSR_WAKE_ERROR_MASK)
 
+#define DP_INTERRUPT_STATUS5 \
+	(DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT)
+#define DP_INTERRUPT_STATUS5_MASK \
+	(DP_INTERRUPT_STATUS5 << DP_INTERRUPT_STATUS_MASK_SHIFT)
+
+#define DP_INTERRUPT_STATUS7 \
+	(DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)
+#define DP_INTERRUPT_STATUS7_MASK \
+	(DP_INTERRUPT_STATUS7 << DP_INTERRUPT_STATUS_MASK_SHIFT)
+
 #define DP_CTRL_INTR_READY_FOR_VIDEO     BIT(0)
 #define DP_CTRL_INTR_IDLE_PATTERN_SENT  BIT(3)
 
@@ -351,6 +361,12 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 			DP_INTERRUPT_STATUS1_MASK);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2,
 			DP_INTERRUPT_STATUS2_MASK);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
+			 DP_INTERRUPT_STATUS5_MASK);
+	if (ctrl->num_pixel_clks > DP_STREAM_2) {
+		msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS7,
+				 DP_INTERRUPT_STATUS7_MASK);
+	}
 }
 
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -360,6 +376,9 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS, 0x00);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2, 0x00);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5, 0x00);
+	if (ctrl->num_pixel_clks > DP_STREAM_2)
+		msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS7, 0x00);
 }
 
 static u32 msm_dp_ctrl_get_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
@@ -379,6 +398,34 @@ static void msm_dp_ctrl_config_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_MASK4, DP_INTERRUPT_MASK4);
 }
 
+static u32 msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 intr, intr_ack;
+
+	intr = msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS5);
+	intr &= ~DP_INTERRUPT_STATUS5_MASK;
+	intr_ack = (intr & DP_INTERRUPT_STATUS5)
+			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
+			 intr_ack | DP_INTERRUPT_STATUS5_MASK);
+
+	return intr & DP_INTERRUPT_STATUS5;
+}
+
+static u32 msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 intr, intr_ack;
+
+	intr = msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS7);
+	intr &= ~DP_INTERRUPT_STATUS7_MASK;
+	intr_ack = (intr & DP_INTERRUPT_STATUS7)
+			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS7,
+			 intr_ack | DP_INTERRUPT_STATUS7_MASK);
+
+	return intr & DP_INTERRUPT_STATUS7;
+}
+
 static void msm_dp_ctrl_psr_mainlink_enable(struct msm_dp_ctrl_private *ctrl)
 {
 	u32 val;
@@ -478,6 +525,35 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
+/* Must be called with msm_dp_mst::mst_lock held */
+void msm_dp_ctrl_push_vcpf(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
+{
+	struct msm_dp_ctrl_private *ctrl;
+	u32 state = 0x0;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (!ctrl->mst_mode) {
+		msm_dp_ctrl_push_idle(msm_dp_ctrl);
+		return;
+	}
+
+	if (msm_dp_panel->stream_id == DP_STREAM_0)
+		state |= DP_STATE_CTRL_DP0_PUSH_VCPF;
+	else if (msm_dp_panel->stream_id == DP_STREAM_1)
+		state |= DP_STATE_CTRL_DP1_PUSH_VCPF;
+	else
+		state |= DP_MSTLINK_PUSH_VCPF;
+
+	reinit_completion(&ctrl->idle_comp);
+
+	msm_dp_write_stream_link(ctrl, msm_dp_panel->stream_id, REG_DP_STATE_CTRL, state);
+
+	if (!wait_for_completion_timeout(&ctrl->idle_comp,
+			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
+		pr_warn("PUSH_VCPF pattern timedout\n");
+}
+
 static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
 					    struct msm_dp_panel *msm_dp_panel)
 {
@@ -2814,6 +2890,16 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 		ret = IRQ_HANDLED;
 	}
 
+	isr = msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(ctrl);
+	if (ctrl->num_pixel_clks > DP_STREAM_2)
+		isr |= msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(ctrl);
+
+	if (isr & (DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT |
+		   DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)) {
+		complete(&ctrl->idle_comp);
+		ret = IRQ_HANDLED;
+	}
+
 	/* DP aux isr */
 	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
 	if (isr)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 41a69447001cd..84ea37d8db2e3 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -27,6 +27,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			  struct msm_dp_panel *panel);
 void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_push_vcpf(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4862d0b42f290..f6d16c57afcc1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1524,7 +1524,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	if (!dp->power_on)
 		return;
 
-	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
+	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
 	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index cc74b1ed628ec..36cfd94ac1622 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -42,6 +42,9 @@
 #define DP_INTR_FRAME_END		BIT(6)
 #define DP_INTR_CRC_UPDATED		BIT(9)
 
+#define DP_INTR_MST_DP0_VCPF_SENT	BIT(0)
+#define DP_INTR_MST_DP1_VCPF_SENT	BIT(3)
+
 #define REG_DP_INTR_STATUS3			(0x00000028)
 
 #define REG_DP_INTR_STATUS4			(0x0000002C)
@@ -58,6 +61,12 @@
 #define PSR_UPDATE_ERROR_MASK			(0x00000008)
 #define PSR_WAKE_ERROR_MASK			(0x00000010)
 
+#define REG_DP_INTR_STATUS5			(0x00000034)
+
+#define REG_DP_INTR_STATUS7			(0x000000FC)
+#define DP_INTR_MST_DP2_VCPF_SENT	BIT(18)
+#define DP_INTR_MST_DP3_VCPF_SENT	BIT(21)
+
 #define REG_DP_DP_HPD_CTRL			(0x00000000)
 #define DP_DP_HPD_CTRL_HPD_EN			(0x00000001)
 
@@ -143,6 +152,8 @@
 #define DP_STATE_CTRL_LINK_TEST_CUSTOM_PATTERN	(0x00000040)
 #define DP_STATE_CTRL_SEND_VIDEO		(0x00000080)
 #define DP_STATE_CTRL_PUSH_IDLE			(0x00000100)
+#define DP_STATE_CTRL_DP0_PUSH_VCPF		BIT(12)
+#define DP_STATE_CTRL_DP1_PUSH_VCPF		BIT(14)
 
 #define REG_DP_CONFIGURATION_CTRL		(0x00000008)
 #define DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK	(0x00000001)
@@ -370,6 +381,7 @@
 
 /* Streams 2/3 registers, relative to mst2link_base / mst3link_base. */
 #define REG_DP_MSTLINK_STATE_CTRL		(0x00000000)
+#define DP_MSTLINK_PUSH_VCPF			BIT(12)
 #define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
 #define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
 #define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003c)

-- 
2.43.0

