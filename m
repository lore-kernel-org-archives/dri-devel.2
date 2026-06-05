Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5BDCD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309F510E5BD;
	Fri,  5 Jun 2026 10:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oZEblcQN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ky6cUZpN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2D810E5C0
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:19:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6559mEtJ3016263
 for <dri-devel@lists.freedesktop.org>; Fri, 5 Jun 2026 10:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=; b=oZEblcQNWqkqEQSh
 X9TIIJWFvrr3+sTd4bHurOifca7MU9O632Yhg6hpI9JFjGCAO0Gvdczd949cun+i
 aYnuOpuOIK3uokao1T5xNXKdQBcnRdLS04S5kRzkrxlI206IdjlfXxiOj1eX9xcB
 0QBU3D5B3mDyEfMxcdaePg3Aq4P3w0WPjeFt805S49fdFmdTzhCWSHULO8W3nhNc
 3GqqXIyK2bjO4DBzVw7gDH5b5Hr1+ooPRL+GH6E6aEgqSGR1bvt69lIaghpoqj6i
 NKFqDsjklb4T+GBRRGY0cl6/lXtqZ8cxUaPXQ++VN+fndJqaoWZSLHhwA86XeXVI
 K5Ud/A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekv56g4bn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 10:19:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bf160f7191so10623365ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780654780; x=1781259580;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
 b=Ky6cUZpNAtIbLvelUH1IsNzxA2k7Fj/vVcEs9S8ACdpqi0+3ef84ps7l7cLEigCiDV
 b2+FTuvDlgAqrn+OtSoN0/3XeP3eIq6UkUTGEuLLZ0nlI7m9cD6bnxL1xw7kcRXfGCQo
 wdbfauE5hbbvC5IpAA2YB7beA4whzeCInSjhlSh0E/7Vipa4rw4RMaX8ONnbO5LqGVAE
 dvXQbVv2yykunVVKhpQWNwVupJpbaSpJZAAch0Wd3BVrQcuHlqOtZit38UUV3AkgPLbn
 32/RNClDfIWli58RIdrgxVpEj4CBl0Wulk+RM7NPebKrEZ1c2xqQySqV4CDrhqX4joHU
 lATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780654780; x=1781259580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
 b=NVPKJ1fiSmH5ANI0b0fBU/QhQ0RWSwOPD5C1EGsAHUv7MHOzu29s15+73npCM76T0v
 COVt2CNdgYNi6WPoOG06yV4btWgfXiac5UdTMF95DOrLFZDHxVTDLVJeFYxDO1yCHYzg
 kXbmAx/EmwJohFJbJntPg+PTeR1L9gi+avCZzjw3zA+TQvhJKasyETII+5iN12DPGjoD
 MD2nbc/tC0qQiC7k7HwxVWhKhou40Dr3t/WJXjJ3wcs7/ZoRXD0cQ0TqkdBAYWxdcgxx
 ByIdgLRxsOAO9bZZEMnOXAAzkfLL+d21y8CWOFQwb0pbl48Ctnk6U9l6Us9QiWPZPoSy
 EKHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2o7HsD/NZkeoiCsILYdtiSUzgVpgeXRj/Tx+6i5ScfuxM5KfmETC3mKcwSCqd/kgGbyvjpoihLeE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzxj5cHh+RBFDSMP+3E9JmYbnKSP2bc/OdxgUiq36Tr0XkvqlNO
 XaiW+J2rAC4tpZ0eva2eV7k8Wo/H5HyVKNyc1szy2EPpu/UPZovuhMtKBnWV6k37GGiSvNZHEhT
 T1LHj2Y74NoMUU9PfX7RDp7I9sYYwLRcgfPK2GXAUy7ApwQ06kN+RFhaBGwLH0VphR6XYiCI=
X-Gm-Gg: Acq92OGIiuIwfs5Ollleh4SFJjK5xDMsLAOt9z6kDE/7+eSpDXGvimEByXyuaIW4a4e
 xgcNsyjMjQTY5C0wD9kWqwIMNDhj43lcSSxYoq512qY4h1MhYshEJRyoLabBtW1FL11YwyAomP6
 WWkWAd9ycfnnDZ3bMXjeQGwTtqLA0OKg6ayPf5WoYa3cCYkLOEH04+ODa/C0T8n6Xh8JRe0ds8E
 XNhHuR7IiqNmaWHSqGLW2nVEyAAxzfniQqjELvqyREgh95ItZZau9O4uiEVkBMeMAXinfU5a+W/
 drsuVX37fjz2rOm5J6/LlK9PjChvomiJsXNw89FWc+hn8Zo2awzn1mh5Kc8rzocaFXkKZISBfgD
 WMXIawOyK2AvcBYnePmK46xljk/R7c9zAH1ZPDsclXXrgx8ydW/mjF5dYdcY=
X-Received: by 2002:a17:903:2c08:b0:2c0:bb11:19c8 with SMTP id
 d9443c01a7336-2c1e820db02mr32151815ad.36.1780654780039; 
 Fri, 05 Jun 2026 03:19:40 -0700 (PDT)
X-Received: by 2002:a17:903:2c08:b0:2c0:bb11:19c8 with SMTP id
 d9443c01a7336-2c1e820db02mr32151295ad.36.1780654779579; 
 Fri, 05 Jun 2026 03:19:39 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:19:39 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 15:48:53 +0530
Subject: [PATCH v3 3/3] soc: qcom: ubwc: Add Shikra UBWC config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-display-v3-3-9846ba5fe635@oss.qualcomm.com>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
In-Reply-To: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=1072;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=rVf9yUiI4s1YDWhWJ0K07qBAlGQcKyt9Ku/bgoySARA=;
 b=7rX2EC8uhcDt/DiMdC/pz/WYl5oqxXXseJ2Vos332fRcblOHX5myBQRMg8/MPOkIQQLugj07+
 GhyQMIiwGzaBxX3jfm0F9vACJHj7WKL6YaYot4dhEnVPhF2JXqDCa4V
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfXzV1E3WxIUVU1
 DDa6Kn9EDTlZdDNneoEyoMl2zULt/E64dgxIRv+25OWExc+bVmN4L1nxDeRofhgtIikDNcS/AO9
 rOkmHFZxA5DqEibBqNGV98ajDvFLgCSE+5IlxX1U0C3Zg1UzWlqyEJHmjkqnl7PzYBR74siqwlP
 0LOE9T0CLlcI3ccl+TfXTp9O7MBJ5ELhVZ7XBs5zgv55QlXyMX6fKD5RR9KmO2qTAJWFxOw9Hjy
 ZEOKGVay1iizAPFLGH5OZdOs+MC4jEGKiCW3PYtFGV1l6movJB4RMvjxazMeU7nfaadidzqHzbI
 QfYsUSxOWO4hxkrjxrOFTAcsW8eZEST/+0mJU27MonrEbaQ1YgwRYDcTdf/T4W1l2SwFw2rVpv7
 R8hItg5Uu+OuCv7VZUnuRPlnIhD8lmou44FY+/mvOizwqI5AA2UVKT6BodOsBs6eanuIygifc5F
 53LaH00PRXJYDZzQacg==
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a22a2bd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XuKMx7f3ltwE3Y0lsuMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 1D6UC7TvkR3tlcD49bMT4FepMGvXogTq
X-Proofpoint-GUID: 1D6UC7TvkR3tlcD49bMT4FepMGvXogTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050099
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

Add UBWC configuration for the Shikra platform. Shikra shares the
same hardware as QCM2290 (Agatti), so reuse qcm2290_data for the
UBWC settings

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..1a2e54c6480d 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
 	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
+	{ .compatible = "qcom,shikra", .data = &qcm2290_data, },
 	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },

-- 
2.34.1

