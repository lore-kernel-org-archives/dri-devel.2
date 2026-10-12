Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86043CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CFE10E58E;
	Mon, 12 Oct 2026 13:32:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E15B10E5B5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0KYO3292500
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZGDJDRLWbmhL036D5uBETPd4vljDxOvm5TNYzKP1bqs=; b=QI5QQAET4yMkS9gt
 c4A8N8spreeYatTVGYi1ytTGS+EYe5PU+LDqU17kGLBLp4ib9YheJKvm2rqM/ayf
 0m+ifYkvjnBqS2CFnpiaBoIu7ucg8EF2zFGakvO2H8Cdp8hnygl8WNW2O+kXLKsy
 q9Jgj9h9BBbWHXUmB57JoWiXIQisFhFJlZujcxKHKb0a15Lim7PU8ILFcvpptm3d
 QWpG3E7Xxhb2NZQ/pOoiioeRRAO/CAwutKCgzIfFM1DqC9REl7cYDX/vop75cfDH
 z/n0+RMBm/6knkGzUEASoHS+mW5e/LnzFlghZ1ETPQp7dqPyPR57npMefMbi8QX3
 YdWbkA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3hhjv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3580c07911eso5213371eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791811967; x=1792416767;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZGDJDRLWbmhL036D5uBETPd4vljDxOvm5TNYzKP1bqs=;
 b=PF0oDFCA2NJrXXOiN4pn2WFdPL7ugkvMpRFX98ej01p/f7kLn4GBXbHiTb0tv+faZX
 xjj5ojtdZ6JPQtuzE/MNoIe4rS3mHDcdAY0zx4bAuBAJ1PxqFqP8Xo90vcAypYZoq3Su
 2AhDv7iunbwK1zxguogAny35fX6fD1p1ZFaDYhIgW3scvOCB0srCF82g/+RP7T4hjW6/
 7WScElNqny6EQSNSEUuQcLdDIP5TU72mt4ZHJg85iqQpA2We8ahoPoKDlzmeij8a/IHM
 cVNXtlGKagodilrDP45h9ebaNuCKxB2F2nNHhSTMtVKQG/SQGDrwjcps5Vbv0jGh9Hbh
 jPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791811967; x=1792416767;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZGDJDRLWbmhL036D5uBETPd4vljDxOvm5TNYzKP1bqs=;
 b=WbjIkBgMXBGuF8cdCrti8JJteVEcj5I8eOJ5rDPLz+dG7seccsdD4I4x2r4Jb5ymIZ
 TvNFZOVhnc5dI97JxY5YGll/l/cqu3Exns4tB8U4zL6ehakAdalswT4XsH4cOh154dD5
 gjJsI1j/NkfpvEsYh99ktZW3Ve/dvfoONfx4kAvx+ubEibrVsEzmpmCYxOSEInJTUJWr
 G/pf/AnSrQson+mgbgmr6MDn5GJUp/whshH+j57CYnLiCA15Imp51FkHfF1+PnXlXUvZ
 RkCGy+IsTZeVpbBQ8o3k4VasTlgnDtHIP2k5adtVmEgeNVCCiUCGB/5bCnTGLSlRf8Ec
 kqOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxymYyAZ7Dz/VZhOQfpuJKZNFKzXHAyF8cDNgOUUGjNyOvAp2L9vnlLVMzo7k0jBjYa7yzUnkf2koE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIulTCPSlJ46awuWzSihFsMb6boPUz087yRyPBQoj1F2FnuHSkt
 dDd6qmblbPVtC3CleHS+kPHazfNrxeQ00XXWwiQ/RoOp91HoD7Z5JMWn8JGiASH3dCEPRCw/GF1
 JfIO8Ci1cG29Edp1MRH3nucyo7Cj28iAwlT1coQociBeRJOxDzYtgaVG08rKxwRoj0dU79WU=
X-Gm-Gg: AYBFou13N4FqJaA6L4j+nyaNUH47hcnDTVhVJqAD7YNPg4attzJRGXCgGSp/FCobYwP
 G+Gb7ambv3tuZql//iWPX971EHxeHoGXbhdNnp8Xr54h2hGhXBcooEMMD4rVS6fZ+0QFDZgzKoA
 SO0JPmQO8EiS5gRCmXkomjwPHHQq77x+6wdoS3Codc4onthEkw+0OFTE2nX0EMwckxlMAs2o9iq
 nEWhsT+d6iDUu3OJ9BAVQY/gHY2oi8muYm6gM/kOywkh+QbpsofH5Hi19JW+p+N7gkEW3toPymn
 t0arJvTooZYH4M5rdklM1UcPSELyWmuT0CrEDtl8Jyrs+KPoKUVcP8xQzyPjWkJQg8oIKpedB30
 ORl3zbh8/wFNpOgKN7oYoh2FsDrw=
X-Received: by 2002:a05:7300:80c6:b0:351:78a5:d0b5 with SMTP id
 5a478bee46e88-3537deccadfmr18827480eec.3.1791811966893; 
 Mon, 12 Oct 2026 06:32:46 -0700 (PDT)
X-Received: by 2002:a05:7300:80c6:b0:351:78a5:d0b5 with SMTP id
 5a478bee46e88-3537deccadfmr18827397eec.3.1791811966021; 
 Mon, 12 Oct 2026 06:32:46 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:32:45 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:11 +0530
Subject: [PATCH v2 01/13] dt-bindings: phy: qcom,edp-phy: Add DP PHY
 compatible for Nord
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-1-a2ab9af954d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=1293;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=GiBsZdkB5tHmSr9H8+rZ9GhQGrutXqFsjreZo5qOWtM=;
 b=2jqbWGPiUAdhEyigTemYqx2Mb/1LyGB9Ffl9QJSWT2YL0+kTzRvkvtCImVXPlEp9PW2I+kVrB
 oZPceZ9ki6aCBZT19uqSdq/JvEF5pIa9NU58HRL2f10qbkuIf/jVGpm
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX0Zdiawb69cFa
 VMhfmwXPD6oD2VuI8BMeKnHMMQus5W4+BfxiEO/P4G7rTjbR/NWZL43Qow4VK6koTEeBzHBTpn1
 yk0EKN6tjc/7Cji0zWO+pMxHkwUnxIjlMwZJ2x0bygP3u0Bg7frqGm76lcbDczTCCkG6eV1NVhu
 xdRsFjgm0OngQmztmtuXgzF0ZnU1dkCCeL5ykPMm4LWTy8VSP5O2lyFe9vW9beTWbH6WJQhpJzN
 TleVtf2su9dbzAChQF9p0KNcOkyNQKQH2C5wPcHn5GNRhxK3LvbAXL2CE7fC2tqWqfCEKmpo0uo
 0g1JCvcjt4l8ZQdQVoSx+3nL0MunmPvp0IP3uqFD1J+dPBgrtkS2SU1FRG+b6U1JLhJuTmz0fCw
 5J5PA+mYYkXTvIPizbUTKP24w7WezBzuGutpWKteg7f/Uz93UCzP1AJbVwkw78SNglClcWNAlYK
 gNAJ+KooloTV/w9nnZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX0mO9lheWnUfE
 0BDQYCGoq4F+4OjWSsF0OYSkXfyrnRqXIsQDodjqqKNai/+Y4wRua89cwADeWT8ha2D2RhChCqe
 Z4uNkUFkI0/+J8i1tzo/nZJHNF5mpaI=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acce17f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kfPMoZk3nD7OVdbVor8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 7FP_cxwmgJ_5B_Rs-V7Bya_kUaKGSdgM
X-Proofpoint-GUID: 7FP_cxwmgJ_5B_Rs-V7Bya_kUaKGSdgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120053
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

Nord relocates several PHY/QSERDES registers relative to existing
SoCs, so it cannot reuse an existing compatible. Add qcom,nord-dp-phy
to the compatible list. Nord also needs a dedicated ref clock besides
aux and cfg_ahb, so add it to the allOf condition that requires
three clocks (aux, cfg_ahb, ref).

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index 0bf8bf4f66ac..0ff07ddcb76f 100644
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
@@ -74,6 +75,7 @@ allOf:
         compatible:
           enum:
             - qcom,glymur-dp-phy
+            - qcom,nord-dp-phy
             - qcom,sa8775p-edp-phy
             - qcom,x1e80100-dp-phy
     then:

-- 
2.34.1

