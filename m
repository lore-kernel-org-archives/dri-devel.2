Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91B3C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0393410F68B;
	Fri, 11 Sep 2026 15:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNMAPedB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VweYuQft";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A60110F57A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BFA5b2658269
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6CTqihogoF3yIPuPhTFZAPSTFdh7eb9dOeBLIBMoSAA=; b=ZNMAPedBNqVlA8Lr
 Ou5gpYxhDiC0HqQy/EQsPO5o7gYUn1tvFkbWOfd/bZW+3xBPvvgZ4RXiQcww/fwy
 53JFIOwzJVj5gQGBq0LDLohxDgBCtAxDjAgUcbP/QQiIhBiVRM2uuQ+cRsYAR8sk
 WApxk0L/HnTDo4V3tNrJrwSxk/MTZ7j2/G51kYCW//ada1Pp+JnI01kNNc1TpJmF
 eh4uEF/+ZndBgGrWJ8tj3n9Vb752K+2bKmSOIgCoejO69X28Wd0eDZCys5fPs0dT
 KxzDSPljjvkfFOD5t+/gck4yh9qSuzL3MEkxWbXeX+m6DtIPAS8osu5NDkNjVo1/
 COLgnA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm22r497-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:45 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-47cfa971c9eso2155012fac.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141184; x=1789745984;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6CTqihogoF3yIPuPhTFZAPSTFdh7eb9dOeBLIBMoSAA=;
 b=VweYuQftUfom399QsTaGphLx9/FhcZsKWfFW3c5mCwR0ok9Y1yJPBLr/m6on6QZEFF
 ND26/obS4myyWF3Pbm81f+K4JyIQbvKv+71ZO0MChurxoJ9ejDSG+WxxOSRiOmjqMcKF
 yrxQQHyeS8q4CLOgYXX9eU0GrYbzki0fIHdxWMf+IE/G5TYYch6AfkB9//y8fe6ZWeQr
 CkN8nNaNDrUoav5YeTQe1YS1SuLt8Hd47gA640XDHZA2ZR1fQ0L2GbHlgzh7IzB9zLCT
 NCQJLdMvUrxUJUsGg8aecTmjr+gTZW0BW0CFLUDQMyV5zZSpzdXgnnsi26dG/3kDRG/m
 McvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141184; x=1789745984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6CTqihogoF3yIPuPhTFZAPSTFdh7eb9dOeBLIBMoSAA=;
 b=Z2ofCVbywRxconzNcwV/5TTdaobIPtt6aUuPLZDBBR/sW0D4uSP4XMYM6VnHJ3SPA7
 zGs+BL0szynIDdzFGndVSh9umjR9WOlBKB65Td37iCCspEA9sfaURZp9R/n4E2eJxRBL
 +ClSIrcygWqvVlGTvU5xTd2UDU8JiEXdU2v3tHlmr5mG7MW0tDr3GCGORoE6v33NeEFV
 fynbQL8Dp0I6iBHZbL10pVP7kIipPLpI90Kf7w8F/T/p/OdnAKpI+5+T+Kvp5UjG0jCV
 x8EUS/CHgxpl5RA1FtWjzyvRf73nOmhTMQ76L/OWtO+5RyYyGpVe3Duam0hDytFGVnbl
 qkow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwA2MrWzH2s4bRt7HohvaEae7AfcORYJln+ZgHDETat4C0M6LKVVqBC12zWxeV2PnlSImvoUog1F4g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mPi7trPUTdkudIpsjttKUpfr+7oooPcYiLoAJne94pMxCvQgTf
 qFeLmd8tpcrrb64yPPPjyUkKqbxYiKOaTqnhGm9MjIuQxpFD68+UAFhVYuOdMTS5DmCTp+gn+jb
 QQD2ufIOUBz4/IuMZ7CQFaal4FNQVmy02YBW+p02BKAZuMSZ/67D1VeErmSMbkTXRHb83sMY=
X-Gm-Gg: AYBFou1TybpAEuoa0vUVYpgs/zkt7hmE0yNjPwqzE7k3pyLPgh89JI8WaHgL5Emgrhc
 M0oqXHyrlFpaWHcdctl3Dr7YRR5tvWTtVFweXlSc/SoaplSCTk93XkmSi18rGXR5ha4T/eWi75t
 defgiFV8PE9r4Vg7Pyi3BNIl/fOaCKR6cCM+3mQvZ3qCo7vup5ycYWY2DK3IPCa6LEvOgmFEMWH
 ldDi9i/JxbRQy3Qm9YQc1gnm/v7wW3s6dvEADT5epRqWxTZ8nsrlV2Xqyl+cTPF3pr0QosrA5q2
 pIuL2V+jB1s1apbrfB8EsR6hQFPgdQBOKXw7ICVDGd9rHloI2Mwk/tbdSyq6esm6l2Mcz9jQGoW
 SUHDR+v+Z+1chJ/rxqPwteQnCD7M=
X-Received: by 2002:a05:6870:21d4:b0:44d:2da0:fa1f with SMTP id
 586e51a60fabf-47dd35f90e3mr3131552fac.10.1789141184398; 
 Fri, 11 Sep 2026 08:39:44 -0700 (PDT)
X-Received: by 2002:a05:6870:21d4:b0:44d:2da0:fa1f with SMTP id
 586e51a60fabf-47dd35f90e3mr3131501fac.10.1789141184024; 
 Fri, 11 Sep 2026 08:39:44 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:39:43 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:48 +0530
Subject: [PATCH 17/17] phy: qcom: edp: Register qcom,nord-dp-phy OF
 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-17-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=1090;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=u2YdZt6zLxkF9NeeDFO6cI3YUG8ouytJ0A/YUYMzpN4=;
 b=1rlx3/KAdoDBmbu9KB7g/WFds2V+Ax4LJFhoRI9zajHaHZ6SisVfgNvqXrfK2Fw5H02r/Jwvq
 3GllpLpxEV+AQB0eIz4Oai2ZEMjP/Cdnf2RNtpRBg3QwvV1uRsFOCCA
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX6lKc2qEnt7Xf
 VZDa7nyaDxKsmPYEUfR4BC1LyzI4uxZ+4WFLfL7Lj4Bj2zfCuLCfZVQnpmSZ7YcikgcTgQsZC+e
 VEpX9ABvU3ZBDeUlz+ajgovscRwQL/Dy5O1e7DmkDkD3dTQqVPHJR2GljhpNVoGD+7eNHDyxIZM
 LhDeajAr9x1kjsxFi4dn3BmLcOWik6abhPTrLtOiT9XHEekXDtv5FcOy70/DAMKl58xfFNGsQPb
 8ClsfYGJIGQMCELXdNNjzbEef1oenZAp8VUDoBCjm+D4K05k/qVsCWK1ndhs43gZjT9GOqPNJB5
 CQRhAb7oUXSoEHPSFYzEEyT8r6pkzvmxZ8JSUKr5qeU7r4Q0E2sij3UnpWoKCs4q5MYE9qalR3Z
 cC4LwBvaFXXBxlz0mUcVesKj99C0bJ7fB3s2VnITFSzDK1vT/buD971wXgBFAcAqm3RIjJAO82f
 k6l2FoqEtWYWvSC7fhg==
X-Authority-Analysis: v=2.4 cv=LPDz05W9 c=1 sm=1 tr=0 ts=6aa420c1 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=o_H2acsbjChyEWv8a_8A:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: Ht92_eaWobYZ2im6AtDHj4kqHs6lWmvs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX1EoMYfyWYMkz
 CIA31zDjQui1x2AgWOKwiKc4k7TbKVGt9bAMQMFqXO8GOgtQR6xWOVzGDYxwNlILAP2ZMsHkv1D
 F9Cqkd766imhuX/xsUPXWR4v8dzgtOw=
X-Proofpoint-GUID: Ht92_eaWobYZ2im6AtDHj4kqHs6lWmvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
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

Add "qcom,nord-dp-phy" to the OF match table bound to nord_edp_phy_cfg
so the driver attaches to Nord DP PHY nodes described in device-tree.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 338f28cb404f..f9a85ae8be62 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1872,6 +1872,7 @@ static const struct qcom_edp_phy_cfg nord_edp_phy_cfg = {
 
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
+	{ .compatible = "qcom,nord-dp-phy", .data = &nord_edp_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
 	{ .compatible = "qcom,sc7280-edp-phy", .data = &sc7280_dp_phy_cfg, },
 	{ .compatible = "qcom,sc8180x-edp-phy", .data = &sc8180x_dp_phy_cfg, },

-- 
2.34.1

