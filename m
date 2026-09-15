Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5766C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC8A10FB2A;
	Tue, 15 Sep 2026 09:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TsL1ASB1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WkuqYv4r";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB0210FB2B
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F6ZbxT3824010
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K/fI3x8NiNBLG06L2ufKw48FjISxnkPuNyMTEtA4Tb0=; b=TsL1ASB1A+lZ/1eT
 LBJ9E2E8PCnI6ZHCD0cHP2aJRS13h7sw/uNwbdc1f/1wdebirFjchywIGCeFXLsf
 mIReachwmLdmCl4xj3Lf0iZXOk6zV8xvgEUi22eZGWj0half/PFs0+3v8m+wTd+y
 g16L1O1WbSioFZRS11P6rOT8i9i9aZcBk39wIqbt+y33wD9AUIGXr20/Swa4pB/3
 4On/NZaNuVDcN8DkmqQkNs9ACsrvirdrGPiO8PF/Dh6UY2K8LkYuRi7GHVnm4DP5
 AkouD21x/wcssxd+w+0gFo1YoBgUm2yLzxFNoHP+6BTTlYfzCPsD8iWV2/b4Ciz5
 sw8+UQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41unt5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:28:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0312937eso325473085a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789464505; x=1790069305;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/fI3x8NiNBLG06L2ufKw48FjISxnkPuNyMTEtA4Tb0=;
 b=WkuqYv4ruSVfncwh9z+63CNzWDNRR5wRaGciH32xBQ9aSVLJFklGk/Bi4CA4pZDiYG
 G+RlzQEajOlakvN13UeW0ALeYI7B8vbQJrc24VH1IxHxwMfG7oIeqcxSTfeIf+7qe0yU
 C/DR/eGlEtDoZoxVAZtS8O876ffWepa25ZH/h9pO8fCwa/S25ECgnwge9q1nXe71ZRiI
 Nb60ODNSA52EW1HyGOxjGDxupyAnjrTIJn0ulTRWlLZ8kkJ9lIAM7jOEzqDGOzdjlIOm
 4VbToEm04iO2v72ilgdQgSv+LaI9b6q/0koF3+pwhmpkKA1FbreqjVlAngAyuxxLfbvv
 S8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464505; x=1790069305;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K/fI3x8NiNBLG06L2ufKw48FjISxnkPuNyMTEtA4Tb0=;
 b=N8H5IGAnxd66C7W2nGskvOu+bPlAEmQZ1j/ePUZEynjlUoAmuGF+icTgh9YHOx8Tp4
 22EDs4xfqklwR48III/belVwByNnfpBYoYNXSxTf4GlyfoUUSML3MwwMnLMlQzf0uMW+
 qQLwoz4JTqVAGgb/dMpwYqaO1EhziNiSFDOBI2dg/LBgO6F/zMqUnOfUQBsyl3bgdmXW
 a8n2JHR2Kho6MFROkkjzwvWFv90/R3H/f5eW1QteaVR5L3y8fD4ewXXH7ui2BdJzPqkm
 ymIEJbB0tWi4oNzPlMutdEo9Kw/dK9ktfg7l3ahrSypQu3aiUKdZZSo3Uws21lCdQXrv
 m6iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ8VMoGRmn6KILe7YKZuiWuq2j1oqWOvlBbmT90NJMj7wukVFJTWN0AML+y+lBA8GmVjoqzV/gj6c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQ5xjII0bmlDSXboSINjCfyJb/hQ5jPUxXxEJAbyGqcQQ7syGs
 M2QG4PIoRUxJfEZbkMh1zhbVyw/YkPfU+JdsYCv0ys7YMcNLrAwTh97d5CQOkjFZ1fTJr+SIC2c
 7znrmMPzwdxC1s+TuQtz7+y9s21JeU1uYg+QDdLTOv8AsxF4kAzDf+7eBxH7U64mP1F/WeBI=
X-Gm-Gg: AYBFou02hxMuV/F7YYivBuTNBRekfszPCyVDz80V/CFg7p4y7KRFoF1M57PrWgOK26M
 4l77eEufi/hfLWvUgbZrQBeM5nEMqtzfe8bGyZH2k3zF3dshjEP8spdWrmt4GH0uHyOFd32y8iE
 gkUvkVjBmDdMnkrQdfjoGbCsm7JmWHCzJWIRVbDIOBuE+4VxzJDpBYuds6fKLFDu8XYYenQptuK
 Ij479E397TwEGiYT4XOu6YQiej74aaUhUppbcAUe+cpHOMhnc2R/tFKkraSoeUAPId4mCx90abs
 ZgHuNnbUbReb+0A+qNFxkc013XH84eEwUkxZ4ol2tE14GUNKEDRrGyq+G6+QqfdHPLlzh7dDGZr
 sS8FhMwdQFXDZUPhaY3JezBMTMupohAx8YjGy1uT43aIDaZOSLiIBu4QOOHGYGMk=
X-Received: by 2002:a05:620a:4808:b0:93a:12eb:b632 with SMTP id
 af79cd13be357-93a297e5c8dmr961288385a.10.1789464504611; 
 Tue, 15 Sep 2026 02:28:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4808:b0:93a:12eb:b632 with SMTP id
 af79cd13be357-93a297e5c8dmr961284685a.10.1789464504190; 
 Tue, 15 Sep 2026 02:28:24 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a3f467566sm18939785a.39.2026.09.15.02.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:28:23 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 17:27:50 +0800
Subject: [PATCH v2 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-msm_gdsc2-v2-3-9157237b8382@oss.qualcomm.com>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
In-Reply-To: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789464471; l=1099;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=bXRmq/LkVHl3Wkzce7EKsFKSt2ADGnLeNMNslKPB/Js=;
 b=pXi5y4Y0Fm69ZEAcS81pYwIUOtYfvuA2eymuS8KiMJtlmzTHrX7GfKEKbi1NipcnkJiNQqRSw
 vSSUuKpKEFVCyy2NKvGiSs7QgaYWpj+xZScpuo6dRvIffTF/9r+cMi7
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfX+/Sh9J8J8O0y
 rIAT0q9CrQri/Z1CB2TsaKalNgJpKQ4EpkXj1uKt9neGijEmRQncltrXwDD7cPI76fEfGxuiimF
 fO9bIkEpiZgpsMtaWc7lgXpPuPhyVFY3MW1+t+HWv1vT8rrEt6fxmXrTZ3xGz5uhX8qOhDL9AT7
 kCPum6IK988T49dfADzy+9XfUDfEcF30aPagoPYkx7qxb8e3zCs0Vz5GKzzUbae39BT0Jn2uEgd
 2tLz2NTNaOzkShMn0SgzL2zzb/OlsunUM6UXR/eR7VSPbySebJc5jrrKnuz0HcXs7y6BRqtMXVC
 +n0t8QIGyHc7zaZNPpHkORL2NP/nzGV2/0KBRNubUX6XoPJYUOkKYJs83jhGA1CFf3DHiodelaQ
 nHoDYtcnGF/XPNttQV0xP8DS7gFkIUloqYLZt0VN3SvfiCSZ1M6/AzWg7HZKohZUcJi9L48z7PD
 C5wglP+LQwfXVmV1lbA==
X-Proofpoint-GUID: UaarZFC7r_FAngwKVZJunFl5MBeSlGYp
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa90fb9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=aCRQ4ZZDzeq032jGe_cA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: UaarZFC7r_FAngwKVZJunFl5MBeSlGYp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEzNSBTYWx0ZWRfX3zsz8OqofH+E
 2GowlQZo2qBU6EFUiOcujG+mpneJvMTHxH4rQ9iGxgMGMPEhIcSesQD8elf4bXiSJahX8WDEYr2
 a2s13l2iokTdROYDQKdpPLDZrE4Arnw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150135
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

The INT2 GDSC on Kaanapali (SM8850) powers a subset of the DPU
source pipes (VIG2/VIG3/DMA5). Add it as a second power domain of
the display-controller (DPU) node, alongside the existing MMCX
performance-state power domain.

The MDSS node's CORE_GDSC is unaffected, since it continues to power
the rest of the MDSS hardware on its own.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index ace19b8b12d7..b3e3cd1d311c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -3619,7 +3619,9 @@ mdss_mdp: display-controller@9801000 {
 
 				operating-points-v2 = <&mdp_opp_table>;
 
-				power-domains = <&rpmhpd RPMHPD_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>,
+						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
+				power-domain-names = "mmcx", "int2";
 
 				ports {
 					#address-cells = <1>;

-- 
2.43.0

