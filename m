Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1259CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E833F10F104;
	Mon, 12 Oct 2026 13:33:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5737410F101
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0GXu3292450
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y1IjNtEMdxjbwDwuNpcU6wRXEZzlvZfdEKgYGqTYRAI=; b=lCLGc7LEXCK1uWmy
 HqD22Xn8MbL46m3I/dpxvDbRB5HvJCdFaakmKxBNvvbk7Tr/JLiiJla6qspz6dKp
 J00cCffHC1/UCAD9YdKlYfRNb1Zsv1bSa//q0j5sC4XMvEtxvD9bDKXUfURllH67
 aZXh4l6uozsQLmERXkHOotpweC4KOH0juzD4/NaDnYmBeY3TgTc743MHBO2w55Zj
 jcEjv60L4WNiCZQwoDhtKxZzD+O6c5dlLkN9SaD/CEo03QCJ5tCiDez59F9Zdj7o
 xPuHBMkNbFe94VLixcLPY4HoxlFXQuPbNcJSeoa3tq35X8Hnio41owm7yGHVm4Fq
 6GpZRg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3hhkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so4325148eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791811976; x=1792416776;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y1IjNtEMdxjbwDwuNpcU6wRXEZzlvZfdEKgYGqTYRAI=;
 b=iEnoX/3hqSbhSK2XJns1vw2hQs4IdIKfe3zWX9KCghD8El2yEUNnJ4P/02xoEdtUux
 nlIGWTEsm28cvB3muE0LPySFVF2nJhl0eNWnoEDFYMwT/VRMIVSHMwWvdXTe4OKpAFKC
 KbyAriMobJ0eimyUtU0cgPnarYNnKUBjGhfYb81C6hTOxcA5Vh4LW2d+9E8rgw5nUaLZ
 yGP095z+1OxdRnNXyOiMFkYFr0xkcbkGSov8nY4rSTTG/AoWOZPq+u24UTnCh2RTScXE
 L0ginl+ZVGvoY872QKPaVkJm63m8z9Tu469e1R4eSsvuwfaZKWMMaChfxAzt9Wn7D5xL
 M2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791811976; x=1792416776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y1IjNtEMdxjbwDwuNpcU6wRXEZzlvZfdEKgYGqTYRAI=;
 b=YIeq3a8snCHbZhaW+Ml8GzXqdtX5OBCUyVWuLsGhcDfyOPlOJi1y9zWRineJTigrvE
 VBpan1RyRwtOEZ2kSo1JSQCOHoGZEBeLHJUqTWbzlUbBb7f9dVWW7pQiSPJVscODnXTJ
 LeclZZ3FzMzjUKNHeYjIHv+/t18YBmCqXYOjq9DWHd6To3tH4O37LZ/XIm1GUhX1npa6
 XjhBM0D/lCUEY0cYPxtH5BFjAOyUO+xvNxf6GUWc+VnclSyAi0w9gEKvg4/6skanM2jK
 wVGJpIHovRz2gA0QDFbf6lkw6UtAtuhKP7thQIFeQ7uY8oKpbmUzvhGmtIXmJtZwYSf7
 /O2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR8F0FVZkkYQ3A8a07Yg2C9xZizQUpmKA+D+mWtOuUHGa0Kyla4kjV1o9+UlUWISDsa17wFIqLt6E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJal2+M0Gn0mR0bt/CYt0OvlBG1su2TM//PnLfpa65I7F2m2GR0
 VoI58l5OBOlSqRlpFOjLUYmXjPC4mJTldJZxBogNZF+8cfAM5XsGaW1s2t4JpsDtLNHfQRfTadF
 /u/q9ROq9xXyTSrIoPPiNSXFUkq/cWzAG4Z8ihmhooy1XcBzp0LbRRhHON9xK4eDRo5Q9W9DwHg
 P3I7U=
X-Gm-Gg: AYBFou2KxyarTWfPIUlzWxH1l+mi5uEkk4KVDG0YjSTOtXHH8Y4QWvNGQzBi0x3LAQp
 U8MhKlQvWYBsdrVHZYTJBpBeTB2sQCwsFtZj7MibOufJ7avWGTtcLpR4FlfSbElZy4TJCHub/QL
 Za76IuXQYPi1fhIxQjkWmgzeLtMU69mExjHcE4MtvnGKScS3+A+YcMDKr6oNDn1P1L/SPSbt14x
 xCSLxkGC/j+cfHe4H0xUpl4h5McfMZyPC2/if7vdAigdWdf3vZAc8X/4OkonbKLY8z8YirNG4c3
 Io+uGNGMRK4pkR8ZnI4KvfpOEBGwmJE4yNHhbyQI4E0xQ9cIAniJa3A5q7Jp7R4CjMys07ddOfy
 0oI9iCzJlX/gylZRBeOllMmbXu20=
X-Received: by 2002:a05:7300:cc14:b0:353:7b68:4f6e with SMTP id
 5a478bee46e88-3537e03ce89mr18413045eec.12.1791811975699; 
 Mon, 12 Oct 2026 06:32:55 -0700 (PDT)
X-Received: by 2002:a05:7300:cc14:b0:353:7b68:4f6e with SMTP id
 5a478bee46e88-3537e03ce89mr18412982eec.12.1791811975006; 
 Mon, 12 Oct 2026 06:32:55 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:32:54 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:12 +0530
Subject: [PATCH v2 02/13] dt-bindings: display: msm: Document the Nord
 DiplayPort controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-2-a2ab9af954d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=1467;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=mVpP8pxnU4255kU6h5VkhP1R63UQvGKZmNqAt9hXj2M=;
 b=LD0OMDaEEh2++O5ZlIhqQ2YfyYZKek2XbkJiqhtEHPi/CUYUHDtQ7ubnfsfN0NDscNI8kyXgQ
 Jjt14Bp7vrdAvUiKq6B30/SPLabJoaJNgxD1DOioHI1kDI/usPzIZNT
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX2uJLMisjd1eR
 LlsBTxXF7CshlKb84meKe4jVXq11wVENPkNGsO96duK5OrusmslrrwDUPEgpyA/LCJwoNYvzdc7
 G6hgpo409LITTpDfDTgZB/rswbnrbTvnovxs3XQYkeM5vzQj8OWIsoJED99wTxzmtiUQPdXBAhb
 SINUPD/QSSYlaqzkOZU34HmGBOLpz0KaAFJ/jYB9sO0Xx08euebectMJ3hOnh6sAHAWAfiXL6uF
 OjcAG/82qqeet5OjJiSiBHYmCr6rmexDYF/zIbMbxFibJMdB6nPSi6QOHaHFu3tn4EPrTrJ29nc
 8lqJc2OweKvlytz+CVTTa08A4Ssxqc/4pPtT7xEGOZNW3AThE2rMddOzgjGUw9a18L4bcU8JZko
 IeJ19hTJVVrm7hICF3kp1mt6C3UP4If0V1PBSIg1P7KIQH7xm/OEJXH38iqvcyQo/EQVfmCFaD6
 sfsdCR0dZ+BhphhyeKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXyrWF2XPn0tG7
 PiS9bYkrbdXmGm14Y4j2pIQiNr1mwxMF9CEA8h3jrP9vjJsjevd/XC2YXB/EBGNFToe+nIKAufY
 Bmq4fEX1r+CMyMntGDuHYWOBQVai/cc=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acce188 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JUH7OfOS-bFBGMyep_YA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 01BUxn1O_dCBp_WCYTb8SK2ouFxoMxrO
X-Proofpoint-GUID: 01BUxn1O_dCBp_WCYTb8SK2ouFxoMxrO
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

Nord uses MDSS 12.1 with two independent DP controller instances,
each exposing two DP cores at new IO offsets. None of the existing
compatibles match this layout, so add qcom,nord-dp.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 094a6383bb77..fce8b962a6b8 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-dp
+          - qcom,nord-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -209,6 +210,7 @@ allOf:
             contains:
               enum:
                 - qcom,glymur-dp
+                - qcom,nord-dp
                 - qcom,sa8775p-dp
                 - qcom,x1e80100-dp
       then:
@@ -315,6 +317,7 @@ allOf:
             enum:
               # these platforms support 4 stream MST on first DP,
               # 2 streams MST on the second one.
+              - qcom,nord-dp
               - qcom,sa8775p-dp
     then:
       properties:

-- 
2.34.1

