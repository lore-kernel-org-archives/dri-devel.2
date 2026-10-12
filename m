Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43D7CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1672810E59E;
	Mon, 12 Oct 2026 13:34:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E7010F113
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0bx22679930
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Od+TrUClwjrX5+hkKzqIi7EJ7XLdt4/11sgnHdpGxog=; b=MCJNLrAequiREmjB
 PDk9C45kgpQ69YTtqe6lKCDhadl9DOqUy0allHu37/NhNakupBR7uCfHq/GPqV3/
 Uu01a7vkg1KecNWvSkc0RmfNtN171mVolaDVcGEOVPaZzvpDwPcUJpSNQBUwUBCO
 +TujjhnK7FdPmZNQraYK1Uyu+o3Wgf/6giuBAKDwjIiLg313Nk2sGy8coSG7OWhs
 vsN7AzPSa6U9ehv0EStwMKZX8VcTtpfdtuiNS4w0BlsGyVM/EIXqXAYtC058Gup8
 Co57l+H57iMC5q50lcV4RCcoakg/qMJjw9kbgpKnKOGFmoYtv+DIPg3Da7rHR+w4
 HRIoyA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1t5dv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso3093601eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812038; x=1792416838;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Od+TrUClwjrX5+hkKzqIi7EJ7XLdt4/11sgnHdpGxog=;
 b=hLHWznYG16YWd7dx+Aox/vd+EQWksfYArXAejgl7zGLHytYJAguzhaJvl17gqlNcIF
 ZB9++bOGOKmz4RbKXfSrXs+W9WaSETGCAOs/xp0V/TZSvMZ8LeKtYhxK4qs7y7tdM1c0
 sZsQ+abLw3BnozxHUAFYLKIV53hFtFoL1wcq5lYrhadVxNU6kWFodvDmEndAveiD7puP
 CUzTlUOOOsjsiO+p7KgFW3Qp5OZE6KpxVtrwzVzAHX6Jw8WxY289jwfQ4t8SDkdNIKvs
 WIKrlukLVyJbfgzsO2qszMADLZPQxCUdKJDVq70p0TND1Tlkdhbhas7/WjD7T2hlWgZp
 HXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812038; x=1792416838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Od+TrUClwjrX5+hkKzqIi7EJ7XLdt4/11sgnHdpGxog=;
 b=sAJFLczaqx8phum+L3TBn6C4KWFp7YIHet+Z0RApVPfltisSof/LFN3SoZWCIeBF8u
 l/zDM2QQGhHn78V8rRz+j8gp7OwMKIvRPBsvyYfjdc54DDShGF7YPdMFsUGi4vtDnIoF
 SWhfgAQvW+xTjLsePaGcl4/1rtbH0mIYjMXhtIEX41FwI5gzJLUgntD5JTgODZcKCnJZ
 ZxFWLUmwHtd3vfRIbD4a1pjhZZ2Fy9rIsaIcC19IwWRW4fm9iBT8e8UR+nNsPs4UjsCm
 96BNqUhN25bmrax+FNEjqxWDM7zlXx1M4HYAkS+YVgJTV+Pnf94Vg7A+oEkqIVsCaIlf
 0quA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEH0sWZ10tW83CKvyBs1mQGni3T1TS5g+fVS0THhuL1iOBLNosd6/8/JHYczIxzd2ZBRu3kReJ678=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK9ysFezTwzu82xxVt6NVtn0QeNdEfdayRyCib837S7qlw2pEQR
 C15J5arsuD312dV7whM2NeQHixjYK+poOnC6ieg8yyNnfDZDwaAEH1qF+9zDe5q4okapGatdyMC
 UHQT6Z2JX74o/TF052EfNNaH6fWEPHes5GUKiQdpG9w27u1ilZ1Hx5gtS4nopphd3woULxfE=
X-Gm-Gg: AYBFou0reTcAS72+WSvTXtH7pUu0aT/ua4hKQkb5gN5x2geX9oGAnDlVjfVZ6Mh9qqZ
 +uI/2CwRqTzcOaoL2cDXnhgt88tSpmfSEgog4WgBZIrEkFbKDu3xaCidrvwIZ66FieIf/KcH35q
 wbGgV+Od3xOKAXH6EuyvNdwxhepJSyOIRivasZ6tXOZK5OdJ8aAmglXLEga6oqY6sio87db15fU
 p+Z0/GSiqkrC2Pr88wr0kIU5bWZt5xZrnjUhxssbWsttqASAceXspwVG+Ao4bHGryIWDd9Z8B4z
 m+ASxkD91aSxTfidUUgJC7QOvTFwbDj7MKpdyAnzlCKUhDSrtYXi0MRzAbr3fxwGL9tq9PwTrcb
 aG3iFQjO9rE4jvrjJZvCG98IDNCk=
X-Received: by 2002:a05:7300:ac81:b0:34b:f456:25ce with SMTP id
 5a478bee46e88-3537ddd6fb4mr19923661eec.3.1791812038237; 
 Mon, 12 Oct 2026 06:33:58 -0700 (PDT)
X-Received: by 2002:a05:7300:ac81:b0:34b:f456:25ce with SMTP id
 5a478bee46e88-3537ddd6fb4mr19923629eec.3.1791812037692; 
 Mon, 12 Oct 2026 06:33:57 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:33:57 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:19 +0530
Subject: [PATCH v2 09/13] phy: qcom: edp: Add Nord voltage-swing and
 pre-emphasis tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-9-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
In-Reply-To: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=3101;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=CEoKlhJonvYt6NmQldHYRVO2WGAxSRpS2Dn8PYH86g4=;
 b=welf+AIsozWBI/rasdD7NUMQbrBCIazetk8Ol+j5VUE/ckwHcp+iugZMNgXGDin8z8/kk3W32
 AMA26NoKdhqCzKoOv6U3AEUS2eXuFfpFjw8/yxN0AFMc0Vz3S9q8pzT
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: n2Y0Mw7R_xXgNkA9eHJyl1cBAN44nlfj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXyHn/F7l5z5/7
 8An9+dFViOq+F/RTyguWJm5UHXwkf/vZ3bV+JA8Uwoxr73Jt1Kuwr0VR5FqdtMIwBfcjJ7b8Isy
 HpJukMrqGpxkQ8BTPGgbrEiefz0hS7w=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acce1c7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=eOzNwhHgGilJcvbUjtsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: n2Y0Mw7R_xXgNkA9eHJyl1cBAN44nlfj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX0zga+92b8W52
 ymTJuS51IuQIUL6JDC03r+YrUMLwXRLyFeaBHpRy3hcJ41fR+qdbfOBOpv6Y0wT57z1b4nsuvBr
 B1TiMnuHpibj2dVf9sGYr35+yGAAdoHNfG2RLFdAT45eKDJMJmBy0duqe3IqzZEjZBLVUO8zzps
 WD36UUOcvbO2xnN/OYaNiFLLkbmp9m5YF67sEFoTIcTow4CbtEGOcVQY7ewb7wEXLfRyWIG7ERx
 7Vw3Fok9LTmHPm7QLCW4B1DHgJQpNEdGT10JVdShEBR1pdn3LfpwQzLuEpN5lZEmS6EMldzUcOg
 y5Uhp0bIZc96rQFB/GdVVvSfV2gcTYAKDNd+01M6f/O5ksF9/v2l21P8Z59Mkelh0u1zFydEW9O
 nRhaE7jhvbGYzTrDKJzebXby5rOPI+o9XWd21AMP5GjAHzjBUlrD1FzOOBPzsTwyjgYQx0gX2EJ
 aS7vS/HCTiZxnkHRwTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120053
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

Nord requires different TX voltage-swing and pre-emphasis levels for
both eDP and DP modes.  Add four pairs of 4x4 tables covering
RBR/HBR and HBR2/HBR3 for each mode, sourced from HPG Tables 2-2,
2-4, 2-6-a and 2-6-b, and wrap them in qcom_edp_swing_pre_emph_cfg
descriptors.  The eDP RBR/HBR swing table reuses the existing
edp_swing_hbr_rbr directly; all other tables are new.

Assisted-by: LLM
Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index c5df1086607f..c63f721702b1 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1538,6 +1538,70 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const u8 nord_edp_pre_emp_hbr_rbr[4][4] = {
+	{ 0x05, 0x11, 0x17, 0x1d },
+	{ 0x05, 0x11, 0x18, 0xff },
+	{ 0x06, 0x11, 0xff, 0xff },
+	{ 0x00, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_edp_swing_hbr2_hbr3[4][4] = {
+	{ 0x0b, 0x11, 0x17, 0x1c },
+	{ 0x10, 0x19, 0x1f, 0xff },
+	{ 0x19, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_edp_pre_emp_hbr2_hbr3[4][4] = {
+	{ 0x0c, 0x15, 0x19, 0x1e },
+	{ 0x0b, 0x15, 0x19, 0xff },
+	{ 0x0e, 0x14, 0xff, 0xff },
+	{ 0x0d, 0xff, 0xff, 0xff },
+};
+
+static const struct qcom_edp_swing_pre_emph_cfg nord_edp_swing_pre_emph_cfg = {
+	.swing_hbr_rbr		= &edp_swing_hbr_rbr,
+	.swing_hbr3_hbr2	= &nord_edp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr	= &nord_edp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2	= &nord_edp_pre_emp_hbr2_hbr3,
+};
+
+static const u8 nord_dp_swing_hbr2_hbr3[4][4] = {
+	{ 0x02, 0x12, 0x16, 0x1a },
+	{ 0x09, 0x19, 0x1f, 0xff },
+	{ 0x10, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_dp_pre_emp_hbr2_hbr3[4][4] = {
+	{ 0x00, 0x0c, 0x15, 0x1b },
+	{ 0x02, 0x0e, 0x16, 0xff },
+	{ 0x02, 0x11, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_dp_swing_hbr_rbr[4][4] = {
+	{ 0x07, 0x0f, 0x16, 0x1f },
+	{ 0x11, 0x1e, 0x1f, 0xff },
+	{ 0x16, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff },
+};
+
+static const u8 nord_dp_pre_emp_hbr_rbr[4][4] = {
+	{ 0x00, 0x0e, 0x15, 0x1a },
+	{ 0x00, 0x0e, 0x15, 0xff },
+	{ 0x00, 0x0e, 0xff, 0xff },
+	{ 0x02, 0xff, 0xff, 0xff },
+};
+
+static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
+	.swing_hbr_rbr		= &nord_dp_swing_hbr_rbr,
+	.swing_hbr3_hbr2	= &nord_dp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr	= &nord_dp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2	= &nord_dp_pre_emp_hbr2_hbr3,
+};
+
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

