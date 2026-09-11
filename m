Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4E2C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5653410F2B4;
	Fri, 11 Sep 2026 15:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAwVgFbr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WM9nBMU1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D55A10F2B4
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm4V9443037
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5NxuIBW575W0eOajYRS3D3fuU11r9CtXlXrtxeBTWyI=; b=cAwVgFbrxyx1ddw1
 WrNGrpTh836+8VxMQDkvHRfWVkIIOrYKxX/cICdOiwy8lC67CrYUJH3tA3aOgCC1
 UDu6atn1GvanNEYh/IquKYfs7qFBL75gfsaa8+GbJgzbpTSMZdKKRZ4Uk7Fr8rk1
 MuEKiTBHTG2ixukBphSsSHMsBC72UMYc5IxWTfD4F6jNYQgWgqnTcUYxkRfMrDax
 FLqXPlQJ7TSmRb+2KVp9DV8JMB9hrABGk3oY0GQtZIDmzvJGTCzAuQZctE19nIrw
 GTzoBOG+9mzBgs5UhiFja5YHpphJMxUF/yrvZYK0bzg6R+J2EP1gfvBAxK6Xksqo
 m6wGMQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmapg2nvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:47 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-451d80641efso1672910fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141127; x=1789745927;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5NxuIBW575W0eOajYRS3D3fuU11r9CtXlXrtxeBTWyI=;
 b=WM9nBMU1kTrbqIgQNR0LuCWgq1ZjIf90lJhSJbb9aHdJp+rECT2DxHAWrTNC5uLEE6
 whDQZRQ78mA5vIO72M/W2b++u4aQ1Elr2/oe95gyIihxd+QEmP6iBZuE9qHvKyYO4R99
 AUK2wjVWN74CrAlHiNYbn3mvCQxWc4vshk6v8y3yukqIapZVEhNVwbkzu3EOUtk8GOmY
 jFxqLYgxb4WFB3IoQ6QfyCFMr/dRYtPiif6r0x2WNiS5Hwby9sr4nqQ3We2cTknHKROR
 vlKJJcce6dKG/7i2FfZAy80jNGIxw+o5Q4Zyt/NYIx5EtvqdrZakxrexGRw+E9fB5HRo
 XuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141127; x=1789745927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5NxuIBW575W0eOajYRS3D3fuU11r9CtXlXrtxeBTWyI=;
 b=WvnVxSAX/uLj64m1yaeecxEV85Su/XoByUaZQ+sMOHCpnNFnpCwhPyURZsgz9vAapg
 O5+8IPxpWRO8lXqcI+EwachKrZLvgeETi9CnNJwzq1IEL2OCaaz5vJ6Fe5iupm+ySaI1
 c65nJSv2owkYeE1ryjrnOdYCswNgTV6md6NIOLXUDCXyjsJmAolWpEdxjM6BRDAi7IUf
 IiHlSXa7tewPGvefzb6jcFsTxysg2iLlMCdOizxxthzPkazBLUtgcFfyUYYABrtVGMK7
 liH/xPut4YHYdTMJ+SUvP5QzQiXG/uEoRxTR2Yo5svHEyknV9FNIS9DMnV11Acof8FdE
 rcNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhIVsaK0OaxtijBXnZWdJqrovA+ZuD9dbMbIa+GEIwjFp1aPY261fREQ2TjHxcOkIxsPaIf0ygYCM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mi2Bvmf03BPADgkaMiKBunhbiwWIJSgWExsez2c2inlA+bCfvF
 Zg3kn4IvgO4PlVOloqrHCDrK/3NTtgsLHDylSgwWhBjMPOKXmG6UlzjOFlTzaRhdnDBuG5RatY0
 6XOUut82GdKC0pEitxKiOI/PBL8Hp5ZEN3NL5ElpTAk/kNUy0klPEu/fBRLqaxIgvlgVKqV0=
X-Gm-Gg: AYBFou1KqPHwR0KQpBNc3aaBw0fIVntp19N1ec5mwoVVjhJuLMlBr62U1CikhMHRnNV
 CeZpjoucu0nlamosbFTjMBRHZdGJw4ODQPvA+h2LupL6ihzr5v01+6N625/GmKVlncfdMQDmIlM
 9e6PdrsIKJkICYGGm0FCKe0IPIo/M1AEpsVq+IofGl6i0B9jlapNXEQqPMSvsUeNpD95vNi2n0v
 CR74xNPJzvyxbMR7g+eoh0c90CgSGkJ6xX/6IK1tWnfqi+Bt1KbVrU2zdjJ6IDcBmMdrHsB1WRF
 nmmoWWjugOL9BmFxru8dTOooAxs71sDWctakX7vmTpbZZDat4u3/cZ4/1O4DF3mqkFmDiaV/IMi
 BU5GwGUbFA8wlhbLNewIJxHiI/4s=
X-Received: by 2002:a05:6820:7092:20b0:6b1:89ff:8a1a with SMTP id
 006d021491bc7-6c0b9b541c2mr2653043eaf.3.1789141126618; 
 Fri, 11 Sep 2026 08:38:46 -0700 (PDT)
X-Received: by 2002:a05:6820:7092:20b0:6b1:89ff:8a1a with SMTP id
 006d021491bc7-6c0b9b541c2mr2653018eaf.3.1789141126125; 
 Fri, 11 Sep 2026 08:38:46 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:38:45 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:42 +0530
Subject: [PATCH 11/17] phy: qcom: edp: Add Nord PHY power-on and reset
 state-machine callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-11-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=1878;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=K21vnVfWi3gJkL/oAMBFt2meTnwDXfVTNB9ot4N0Fng=;
 b=vc3SiT3OwSc+YhqE+td40cxikmsldcWKufYbhRHCLviUwyr2w89FqbTA0uHqR50TW9d2QTk05
 tb4Vf47coz7DcwHh50iiUINbuEbeKui2v8SnRU3cwWtZ7O2+fInAqaz
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: kNvco0bnkKWLgP4Y4KBJ5Zzrufr2sTEd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX+w47TR/eaeeJ
 pBJZaGyFJ0iLkbWvCyOJciGJ9ZFiMp3o/PlOcx0IXZOaQczRGs0/UlHN3NeCJz/VeVGwQRovLBD
 9pVEEt8KZ+R2sKfn6V9ll1I79ZHj5aU=
X-Proofpoint-GUID: kNvco0bnkKWLgP4Y4KBJ5Zzrufr2sTEd
X-Authority-Analysis: v=2.4 cv=DLoacCNb c=1 sm=1 tr=0 ts=6aa42087 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=X8Wa9jmQWlBxTcu95m0A:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX6wmR6+1rFCEZ
 U9Vy3FD0kWHjO2+x0A4o3HztAhEsRmlzbgm5hl+8GM8YLOznjaJ8BzenOzKfJmTwneSU0hZj2il
 ikunBxeBubKtf7bSdBb5rR/JoNeCZr3fv+XTIdV14yGkhHBy23+Om4pA5965DNLOaywuI9hkrDS
 WDSfIWI3Z9Dp4S8NH3WDZSHfI5SKPZJqBlZkUnzwc7njIAVb/EJzrmSSf4yPmkBdaoT1D3AptKl
 nj/n+NUpmlsp3E/LxGua9MTb6/OLvuwcuRFBY3zWpdQuKves8W3xO6TGc3BaUNrSAzINdrn8rhZ
 cxr1zw89WxGrIGmkk36h07ndChU3tRjMkrkHBoabVfD30fCq4j156xBJhEAWjXEL3Jfhyrs6Egq
 LGMBgZ8Bb4Fuz8iQ8zGTOegvgDraQshMQP4JI2Xy9AXtzomjdnGlWRVENzGoaWbN0gDl5z7jx5W
 NZefLC/hbP8c98ymeNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218
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

Nord relocates the QSERDES COM CMN_STATUS and C_READY_STATUS registers
so the generic sequences cannot be reused.  Add
qcom_edp_phy_power_on_nord() which powers down all lanes and polls
CMN_STATUS_NORD (0x1d0), and qcom_edp_phy_com_resetsm_cntrl_nord()
which triggers the reset SM and polls C_READY_STATUS_NORD (0x1f8).

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 64878398f43c..6cac4b55b66f 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1612,6 +1612,31 @@ static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
 };
 
 
+static int qcom_edp_phy_power_on_nord(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
+	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
+	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
+	       edp->edp + DP_PHY_PD_CTL);
+	writel(0xfc, edp->edp + DP_PHY_MODE);
+
+	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_CMN_STATUS_NORD,
+				 val, val & BIT(7), 5, 200);
+}
+
+static int qcom_edp_phy_com_resetsm_cntrl_nord(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(0x20, edp->pll + DP_QSERDES_V8_COM_RESETSM_CNTRL);
+
+	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_C_READY_STATUS_NORD,
+				 val, val & BIT(0), 500, 10000);
+}
+
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

