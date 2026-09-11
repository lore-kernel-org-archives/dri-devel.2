Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248DBC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481FE10E632;
	Fri, 11 Sep 2026 15:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzixV0Ah";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VxFOvqvK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F68010E418
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BElxK53748692
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +MBlKbsG25BxrzRCEnnBfFH5TzYzNSnlE4rjXRK1RBA=; b=kzixV0AhX+mqDzjS
 foSMA0MkL4iSWAe5cx4SOS9hje/AEsOEPwuJvVonLmBT8IZipOtRVrVvOsvU+FqF
 GJe1vKaUA+WnBUuYvs/h+7ziKu1qWK8CHu3LsZXVZ08jTQeZE6dH0MYdkVahS0Ky
 VQS8xllGhZPteDtR2xcKqpOufjYUdGYjWGmLWrzEWzWTQA4wdd4O7Gkp1Pzm2p+s
 IArgoIH8fQRx3B+NnNh3C7/jelYXAwWGMCgL5Nq3A0DX35uf1IW7XM2OfuzLnS38
 nekA//XJA+cW5UvH2HUEJM1abSSwqvM4Udr06h2S30Hf8INWvoxV4WdDhTejeZ5t
 KpswzA==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm729kff2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:12 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4519ef1babeso787626fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141032; x=1789745832;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+MBlKbsG25BxrzRCEnnBfFH5TzYzNSnlE4rjXRK1RBA=;
 b=VxFOvqvKHeQCrF4FYFRz1XGVGvOvqYicjHRztcDmDDLinPNidKLdtGbtgpdEg7BIdk
 wRTswQLMGo8dWH7HPGf/dcz81XNkTyK+P+UFrgZihQ2MtsXuGFOyaNqH/H98h05MNdsk
 YI+RzlmnV7X7gCwST4Mi9UbgG6Z8IU/J9Uy3yJsdV3nvtxhHiNGdpe6qzRI63c87d7zO
 2Vjbhw9WsGL1t07bc7D02km86moLe2Ab5sCNFUSQjAUvKAeJtaNPMZ3Tmko3GiF+N1bU
 v2zhvwB+5rDhPt+8+Mm/HcNlI3GP89PrAVGpfYFtMfhg3iH74MsHW2BCkxy3EroKzH7c
 7lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141032; x=1789745832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+MBlKbsG25BxrzRCEnnBfFH5TzYzNSnlE4rjXRK1RBA=;
 b=iFWkhy3kXw6SJln2HfIApNHXmlXd4JngDckXn3kBSK9Q1V9oG0ZTFAMeABhHExz0Kc
 wk3GiKXtPKdLOB3Z5xpxh50hHX3ZuDTk/GlUbBllBEJCK2ClF2dKO++O9+vZLYScqQ6Y
 kNxDq0Mrj+UOIkKcTEv4snu1NJjYkTFyjqlWQX6aE/tjtWHTI/51U22lYX4x7QG9xhBu
 dFLWYrWrJmLX5SS3gwzynAPlspgkATCnSenUrIpkNTaIOBTT5ZDZNHyY2HkIIZZ18Y9j
 nsjKDPhJGyhQ7UBe16O37hGFxupyLxunG1McL2keSzB5s1wlfuhoTrRRhUwwmKmAnHda
 4IIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9ugcfZcYxDkLXwpqBNajJD7xhjpi0MttH5n6Ui7QRaX/wb9PE6ds9QGeCjYwdcqA+mj+4kmQez+Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJ0jCImI9I37Gl6KpF1EQ2eUXx1z9jm3VDcqbZ5ba3QDJ6ljlI
 kTbWa+CNkuwY9Jp00yc/EszNYpFxmVgCFBugxKEvYepDZoKNGaQPZ3TCONiSXiPuEBtf8fJVZ7I
 mqnbWNtYHOnHkYU0ST4Clxp4geI43bLq7LSEluysDVT+Sf8VtymY/rTkVtFezS+JERqPTlaY=
X-Gm-Gg: AYBFou27H/4Sm/6jjQUQLIAevlTxh64h2r4DKWcr7qLDP7GP4ukrSfBhheLUnl7M65M
 bNoNuTsxyeuXlsc76OgTW/UhSYlYsFe07Gia7pddRrqZzfygYn25PNicDSev3XgwTmyBJQyWWXF
 OJy/K4czmPPiGE+IIpBQWn37bgsrmP/muVupigZuhR8sWZulmmZ3r1pNyCHhaunkgdxxy8kuo+v
 cG7PsEHolhKIwj78XEJkQRQE5SC4d24548TqCeYZVel+g92S+qIVPEdBb+eD609zWnFXR5rphmE
 9VBUmYMds2KrJvjaKA83r1yCwuyesN9v/uTLW2B5W7EyNKGSyV3rrMD6V3eQhw77eBovbK+fy5r
 mAFgdbu5nNsPkJ4egdxRLKtECb9c=
X-Received: by 2002:a05:6870:326a:b0:45e:f698:e310 with SMTP id
 586e51a60fabf-47de79362bbmr3717057fac.11.1789141031980; 
 Fri, 11 Sep 2026 08:37:11 -0700 (PDT)
X-Received: by 2002:a05:6870:326a:b0:45e:f698:e310 with SMTP id
 586e51a60fabf-47de79362bbmr3717007fac.11.1789141031526; 
 Fri, 11 Sep 2026 08:37:11 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:37:11 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:32 +0530
Subject: [PATCH 01/17] dt-bindings: phy: qcom,edp-phy: Document Nord eDP
 PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-1-e25c073cf1b6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=830;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=LG7yAm5EJ/K5hHiVQ9TOdhV/Qy+L/cR5svbIcTlXH+k=;
 b=HLVsBQTXbJClkf2ZEB8enXlHxfJqVSe1ahjDE+AFNK+5sflhib0OqP/ovtlGUgwOhusywMf00
 /9a3NVJqljGDjeLWuBGki1k0cXRknONchqtEa9u0DabP5wsZJWSi+4G
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX90Cstzqv2Sp5
 VtMsbypIbV53+xCy/zM0bkQOPFk0LzzXwjkpwj/awasFf+TTJoNElt4NYj60Ca1GAaWXiEIpmRo
 S4ViO2OmuBphGYXwZkLQVdBn8bh+nfQ=
X-Proofpoint-GUID: n8PeoCWbj5HCJpFxMvb_l5T32C2Lg2kr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX1zXA0IhgAsXK
 IeEPGzl6xPNyZ5ebBUNigTZamhHgnGFQkjrPCHhpEKVnmA9eV3Yse2H/MlX/x+w2+B8dbEgUxvu
 8fmioOnKkP3eTHr0pIjLqn3SODcSzxXyEObHZw/ZKuAq4qUF2ue/1t9duKW+zI5jepfXf8guDyx
 oNJZIPXkjx4Oan+Tov8RuB1FlD1Zd/T2+fh4MO6D6Q2bCUD7/aK7tdq6nTvVr6lusi3UREyUfor
 2/jIVKcnY4oU5tclHeQJeEYepyVieEIQYLRCO0A6eH5Nb7nTs1i75M0huNuqybMLVFbWkt0MPSx
 GVX1/DtTsuR8HqG1yeNMxxE815YPOnVvbAJirEt+8szxEFNq0UiVWTusiQqw+DqBJ8hHLlP83oz
 4AHZPFuCglvRJTOgaqoE2kVd3nXDQ/4pWbHrjyJF3Ieq5062Q2zvq6R3qH6MzVZzGhkew0vMHD+
 F/Osfcm/WX34dh6VJjQ==
X-Proofpoint-ORIG-GUID: n8PeoCWbj5HCJpFxMvb_l5T32C2Lg2kr
X-Authority-Analysis: v=2.4 cv=AfwkjHXG c=1 sm=1 tr=0 ts=6aa42028 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=lCWEfuFUYIIHy-HYLagA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add the compatible for the eDP PHY found on the Qualcomm Nord SoC.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index 0bf8bf4f66ac..91d7a5c8e19a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-dp-phy
+          - qcom,nord-dp-phy
           - qcom,sa8775p-edp-phy
           - qcom,sc7280-edp-phy
           - qcom,sc8180x-edp-phy

-- 
2.34.1

