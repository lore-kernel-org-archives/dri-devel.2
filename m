Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831C1CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A8810F114;
	Mon, 12 Oct 2026 13:34:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757E210F110
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:10 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0bo32679920
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dkP4VyeZ4HxhVk0X5L5pCXJ+WXct+DbRHeEY+gkzrRM=; b=hzfOvXsggYekKdfy
 5s9ZhSh38Vjh5zrdi9Fc03qEysCe1UyK8ItjCaCmefOFD6xXieCxZ87u/CwUYYJd
 UwhaD2FWlmzDIAQMA6hqYiXZLdBZbjL1agRuxJd6xLClvpOi7UYe3tUbGXjiUzX+
 FOJBPYY1hNgyYjBYUOMgas2Zb0cwdNd/P01lX75/X4fQgzE3ee4GmC1b0chD5xH7
 b+ipb3zwA7yRV/Ohc8R+zfOy5MSRacMr0DKPHBhnQK8ZfDeT+02Ev1GY+wKsmjaO
 rDFSFJBU72YKWxK1aGkv/isnv1s14D6EyUkh4NyvWg3U/xCL+2UBffJ7chJd6LwH
 R/Lwgg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1t5ew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:34:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3592749a017so1561740eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812048; x=1792416848;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dkP4VyeZ4HxhVk0X5L5pCXJ+WXct+DbRHeEY+gkzrRM=;
 b=bZxRVagYLrZ5atGc2Yitff+PHwaW1TiEIW4dPl8zvpfg7MPt6ecFQysGB1IN9oufYe
 eB8E1MLiawUzNkzwfHVBiGznntSWOpfQc5V4wMbugIRkosuHfTEVba96mLNBpnf+9zGd
 Ooway1iQb/VQMaDCGgUcJTGi40hP5/CmQYPmh1oikcBiUpaiI7ThphVrNS0z6nadNFHa
 ngW2V/2d8xkad3OcCQ9ELkyDrJWG4pn0+uD8V5byUHkfuNbpwFVa0DeSjukrBuV4fQhQ
 /KfpunoRsrmCrEehwHk5j3HIuK0BsDiu2j+WfX4Sk17WMhYmjxE2fBAODASRN9as1X3d
 FYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812048; x=1792416848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dkP4VyeZ4HxhVk0X5L5pCXJ+WXct+DbRHeEY+gkzrRM=;
 b=rKA2vNuSwXIWcWIQ7XgaA3fS0wQKlloUHudTK58h0wuMrNQLTBEW9Tm/ee+P7R/g58
 6U4j6KRGST/7V1I2N/toyLPtzNEpwHmV5Y0D5ngqgUJUtfDNEbjrwfFZsXjOSQUJJBSe
 YkSj0x3MiH686AGOA/LSp4cmegfqT5QSRRsJxhUlh2AvPK8scpPjPBuPXvNxmxcdAzBv
 UllANp5RfE5SudFMJCItGDVdSlL1g2hS2TW1iV82AE4XEe1cXAEavOzIoHNW9yoNZ3Z6
 i1oei8XH0ajr6FOipQdpO40UgbwJAyLQOQti9CYIjmSWgrPLdYZofIN8EXFcgHPtUkrc
 tvBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxhrO0xlTmpWlW9kg19cOKkHOL1ydmQTUqL3Vv4IArtyvlCoZoRs0yFxCpC8dGOd1Hj1wQOB7uGnM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKQK+o9smeFfcuFL2SHXCWk45fPLVzG0dPLz50XP1KcGtZoDD+Z
 smzTX1pyj5hOeL5iXX5cFkzP936M57BsNxpIOw0RH/5OtKZJdd9/Hsmuskm1Cx4HvvTeZgEgk1/
 2r88dRPDUMtw5+vFUys4EL6KmerQP2v0WwH0nmjeK2q90v1dZoJWHub3gas6WEtvkR0my4SY=
X-Gm-Gg: AYBFou3YXzyBNzUQHHywsr6HJUxVPM9Qo0D/W6gnwMXqfvq5z+FsuhDppwD8awT8nnp
 SDXkWp9Fex9MFoD/qAhrw5k053JTN85O4PtswmHnba9niiremG29AqpN2k94rMaYGO+rQIfnPIc
 MQztoZSa0xCxamIUtCpUu26mpw45PHdCj+JgnWEe/LxDrFo3cLDV1d8OZ0U99gmYqHlGU847lGg
 3Y6Fzwt8+ATxUf/zr5bK0bnt0hoj7Qj4QC9IpV7KaY555zhugoctXsYo3+zAOGEwe89daIagHIL
 5r190URWTqUc6qihHWBU/HRIZD4JQ1FQ4nIXJ+ykLhavvlhO69yWb0bBx84Ps/975rfzHqKybIk
 1wVZJ6CYkmInAlleQqQzTVPH8HUg=
X-Received: by 2002:a05:693c:820e:b0:351:6665:c611 with SMTP id
 5a478bee46e88-3536c5350d3mr14448507eec.12.1791812047997; 
 Mon, 12 Oct 2026 06:34:07 -0700 (PDT)
X-Received: by 2002:a05:693c:820e:b0:351:6665:c611 with SMTP id
 5a478bee46e88-3536c5350d3mr14448467eec.12.1791812047353; 
 Mon, 12 Oct 2026 06:34:07 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:34:06 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:20 +0530
Subject: [PATCH v2 10/13] phy: qcom: edp: Add Nord spread-spectrum clocking
 configuration callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-10-a2ab9af954d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=1886;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=MfugcJJLBszUYvNk7wfVoGG/R0kRg0k6Nei3NjNfVE4=;
 b=6IvM5DvIeDOUYfuKpdSmf47CVd4xsu1yfn/Km/oSFhGKi3T0u2jXi0K08+cowDk5XLGgfKKhs
 CBa3CQrCNJAAraKsQ/7UYEnCplC34pHwgzmLbiK3tZe02XshYU+bBC0
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: oY20AajZqAO62jrWFcniPgMRz5ijCQoi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXwRP4xEvoTbQt
 /VCptPscLtHkDp0A3TK7WMMYziGf+CnMdRSbCr14JhLHvMn4Ig7XLV5NfBwvigqdO+vkqObK7Ff
 HShElJOf/+Uq2pHtVDEEm1TNKk1z3iI=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acce1d1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=K-9LXfgjdCkVDacm8m8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: oY20AajZqAO62jrWFcniPgMRz5ijCQoi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX2UrWLryLptdO
 xxsv+Wg/is4abeVQHTaUisaYmPnTyvd45vxGyy/WGsqkIS+SAENSPksADq9gVI+6Y6Dt0saSQWZ
 B60t/TdoWEH+tWG7o5Y40ZVEW6mXMX9wbqxGGoeKAIKBXiZhL+Yy4E446Z65lviCxuq4EHgqCUM
 uAw6Wo83//k9lcVyseRL5At8DQmY/hJBt4jIMdIviG+3jDdsx9aml37ezD6WumkUkk5PTWA/KAE
 grVe2nK4JBCQn8Sczj+YfZsH+Php5v+BMPb+so8MVgre4MUVfH6sYe3Y3/KOeeAAjZZWfuWDqii
 7555+cfWe86vJc9IM0erZXL1mbnJ0drqtKKdLNxYDjNoI09w3gW0dFZ3f9OzWjlLf4PvthdsGWU
 K8HTe8lPbvp6IfCDTQBjWqOBx87T5mcmp5+qsAZLRdClde9ttvTtKj6pFE/5gFf7jlSLCbLcAes
 +qU8CIOIwfpdAidtKhA==
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

Nord requires different SSC register values compared to existing SoCs.
Add qcom_edp_com_configure_ssc_nord() which programs SSC_PER1/2 with
fixed values and link-rate-dependent SSC_STEP_SIZE1/2 for RBR, HBR,
HBR2 and HBR3, per HPG Table 2-9.

Assisted-by: LLM
Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index c63f721702b1..66c31684c48e 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1601,6 +1601,42 @@ static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
 	.pre_emphasis_hbr3_hbr2	= &nord_dp_pre_emp_hbr2_hbr3,
 };
 
+static int qcom_edp_com_configure_ssc_nord(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 step1;
+	u32 step2;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		step1 = 0x83;
+		step2 = 0x02;
+		break;
+
+	case 2700:
+	case 5400:
+		step1 = 0x18;
+		step2 = 0x02;
+		break;
+
+	case 8100:
+		step1 = 0x5b;
+		step2 = 0x02;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(0x01, edp->pll + DP_QSERDES_V8_COM_SSC_EN_CENTER);
+	writel(0x00, edp->pll + DP_QSERDES_V8_COM_SSC_ADJ_PER1);
+	writel(0x6b, edp->pll + DP_QSERDES_V8_COM_SSC_PER1);
+	writel(0x02, edp->pll + DP_QSERDES_V8_COM_SSC_PER2);
+	writel(step1, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0);
+	writel(step2, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0);
+
+	return 0;
+}
 
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },

-- 
2.34.1

