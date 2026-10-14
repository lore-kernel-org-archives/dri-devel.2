Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2948BCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A4B10E40C;
	Wed, 14 Oct 2026 04:39:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2960A10FA9F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLPAVF1404137
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vdRIw8it8cCmifIaL+Ne4/v9Isf9Dn09v5JwPLmDqjs=; b=Uq9QPDTz9JEbOUey
 hoRiGzmZ+W/fMiP/ZHzW6rYMwSlmA5iUMWBVvXejbWLphsL1zvTUTg1F2SsBrMYG
 PLgvWIXIUDPXz/MQwnDU2qnOIH+Ge3y25vDJd7Ho+8rr7WFQ8tTczZcD/TrGU73/
 e6qnzfubx6qLIADxJFEnEr6qasm3v4gtivPUcRTGkrBk1CStsQ0VdVDKVCN2NHGo
 4ghg05C9/XtEId9kHSA0Uz4rG5yixIdHsYFh3UYfexGHTJ+rkWx9YRTts4gBX5Wx
 IJ51U6TawmfqDL+h7X6LvoI9GpGZOuxVF+sy05Tndt0LpTqBnulu0x1mokx2ZdaJ
 OwImOw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk32b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-535f9dbae1fso18126641cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791952737; x=1792557537;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vdRIw8it8cCmifIaL+Ne4/v9Isf9Dn09v5JwPLmDqjs=;
 b=eHh2sHQVp7OGyb7OWOHzEQ+Y7CPQJaw1Z3jqPkqvhxv5f7HMqRnG9QtY5ekxcixrRz
 ktyJmFRf7BcvzaThDW0HrAe/5S1BHMu/o1+GMe5cZk5rN8shwkY2SOYFgNeHKoKzAdH0
 tUx99bsErDXHxtVgaKU5C3V6TPGRHcJF6fqDlp3P2aVFww4HP47IhaN2tAmuKV27v99e
 4f5VBV5scZY6DvR3byi94F8b5ULyefGM3MwtVH+X5zckrRxm9KYXaMJKWv+JWTE4sRa8
 m4u5uNucU9KfEU41u0yqjxzjJrxUMr+jiiAJWREGd91e26HpSmDmJJmegHSS2i+snSFm
 UkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791952737; x=1792557537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vdRIw8it8cCmifIaL+Ne4/v9Isf9Dn09v5JwPLmDqjs=;
 b=rKBoeOX/C8CFiqU41QvVwL6iRkWb1N3VZceanKxmCbM8aZ7lOwxEt1QbmWHAQuAFUI
 ZC6wQdfvC07fQX3X0G8hmohi/yj5IDTM3Ovq6uZfPL1MXJgklb5UJQHFocuMZ5YHqQvI
 +4M2xFpu+vwKNVvoib6dXY0mUQUKwA1u5Mbsqee/jxsm6w/UF+Z2M/aMfeQkPsAlj/A4
 zZMbzF5EODgvJJNmu4YHn3QQX5iLn6r0f6TpCVtHTaXMuyZPnNLtH8+LFIJ7B3GyGH9l
 AFuW7E4DzUuajeDWZk6Q66mvtUBar29lN2sNhf3EMzrZgLZ3AWazzLMHXE2EpATMM4dT
 TDIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4nkxI/QFL3ydCLNZQC+XJydIrTY6MFhr03lWBFfPvUH6Bimi5D+HQqIKMB74CEGCok4uL3GDgfFE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLtacDvhDM2yAJ4VA7byFKbo5bMV3ySEdjoXV79Rq/xRrex4g06
 0P71RiH6W/5yqVq5qaO+lGm+XPaoB0KBNw9b8j4t45M9k0/cOPuluo7Tnzrj/OZMg7KR8tUNddA
 f6GToZoYyKHq+MMH8VyzoKMFAKP106CKs6zHaqi5hCIq3NuF/+Be69gqlb+uka3YGAQ9TspE=
X-Gm-Gg: AYBFou1zHf5MlfFSNRne+85+zGOEAROM0t3xgvUuNouoZzuJlO0xXwXyEBEbTMyoY6m
 zYlsG8yxt1Zc7XROA6FpFfScaoBn+UquIeQi1YYiBl+gpfeZOl3dOFjaJTXo60bQW8Sh35SQlic
 S+IjYnF4wyCDJMDyNrfE1i2rRNJ5fUYcfmlDJG7Hki3NXLxtUVrAOG6Avpr6kFV94ruL05OVHUh
 H9QTpM8Y9hGsk4U0aerI7KrOnel2isfOId8kRJPMvS3x3kcTReYFoxsXKik8XM1sX8xTfKpP9T2
 vsrEE/n2vrNVrFCckaNqj4bz7TdRRy3vnsiNx16AKui2Of2oqKUNcdc/ERRRZh5PUhdo/ICGvYB
 fVbF+MZ1E/mzyRUfKdrWtkZ5PlDXZI6w04//0H3Ooo8JsNQKpcHBFHzr3yatCtg==
X-Received: by 2002:ac8:5c8b:0:b0:535:cd9e:c12f with SMTP id
 d75a77b69052e-535cda02393mr140894651cf.32.1791952736459; 
 Tue, 13 Oct 2026 21:38:56 -0700 (PDT)
X-Received: by 2002:ac8:5c8b:0:b0:535:cd9e:c12f with SMTP id
 d75a77b69052e-535cda02393mr140894301cf.32.1791952735942; 
 Tue, 13 Oct 2026 21:38:55 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b755c35sm116809651cf.15.2026.10.13.21.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 21:38:55 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:38:18 +0800
Subject: [PATCH v3 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-msm_gdsc2-v3-3-f1ed69014416@oss.qualcomm.com>
References: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
In-Reply-To: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
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
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791952700; l=1229;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0e3qRwa0eUGU6w/ynL5P+jJBBY2ZfPskYSfmy+rlycY=;
 b=nLHkNGIq+1409C7efOjQ0ye24/TubeCctCYnlKQVPsYz4IWDslnDyJpqHsNg0CNmnDPIMIe/B
 fwh6QCUJ3sDCMgX2JuSgar0OF7ybsgzRqxuAEjSZtu6uNll7w8rGO2h
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: LQk_cwS3h0NLpQLyIDkRx8Q63W6X6ozm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfXwTV75e71UREC
 Y9NH8RhwKFMgCBu22bWLbOyIk2pd6iNbejVrlOdm7ZZckytu9W+iETFs/R+WyIvbb2gxX4iOVBz
 3SZgwfHed8WmazydcAGXTJ7HjstBL1k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfX+iGk4gerbxx7
 ai0C8+uANHZtw0LS9TE2D1j9W3OjRjATm6iCnk+DXWBW+IWaQ1eg8Mv1Ysbj6U1QbvO8q1A5Sn7
 1ZV9I3wrQ9TZ56jn4DSZsLDYdFxKPZvHNTeVDBpNp59uv5FHrSw3tCyOiYkat2+Bi11++nLh44a
 HRHFVeQvMrlqMqX+gW8PWiNHLvo9002C8S9ETRv6N2yV0dkixu0HsY6jY0qw/UgvqcKMC8VYN1z
 izS/lSR4BKuouEfVx5wg87KMBA1URin1fOV1jB3/fjUr5QVUdoaDJ/J1Yn3dbrolENqaigh1sdM
 ePtehlGTkX3NoDjcdUOPFulKTySLd3fRF0JXh/eRIlEvvpxb4dDjBJ0Dn0KGyatByBHDSpgW6rL
 +T62H/Rmp8U93bds8T9EcUBfaj35T2PjQ+widwNabiF9ZuaJT+gSRX6qFkLMAiSQ92U8YC2EyjV
 bX7Ybz2iCLVjxAZQfrA==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6acf0761 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GwFvbCpr4qPuEswRa30A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: LQk_cwS3h0NLpQLyIDkRx8Q63W6X6ozm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140018
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

The INT2 GDSC on Kaanapali (SM8850) powers the VIG2, VIG3 and DMA5
source pipes. Without enabling it, these pipes remain inaccessible.

The DPU is supplied by both CORE and INT2, so describe both GDSCs as
its power domains rather than attaching the DPU directly to their
parent MMCX domain.

Keep CORE attached to the parent MDSS device because it also supplies
shared MDSS hardware outside the DPU.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index e48a179d0722..98d367b9dac7 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -3674,7 +3674,9 @@ mdss_mdp: display-controller@9801000 {
 
 				operating-points-v2 = <&mdp_opp_table>;
 
-				power-domains = <&rpmhpd RPMHPD_MMCX>;
+				power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>,
+						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
+				power-domain-names = "core", "int2";
 
 				ports {
 					#address-cells = <1>;

-- 
2.43.0

