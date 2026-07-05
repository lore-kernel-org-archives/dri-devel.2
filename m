Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB52FC44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B76010E155;
	Sun,  5 Jul 2026 08:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VUdwCw0c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ECCQcNIR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E3310E15D
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:01:23 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6653lnmd651862
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B2tXzOW+S2Yl0q+Uq06qicu2OVLdBJOKKhZnmt9rVFc=; b=VUdwCw0cILZ8JMr4
 3q2tqSbWj2siraqnE8Gnpv7whpKslc9d6eoRsi+NbHZmhTUdXk+w4NjYYp9dHmcl
 kWeHfhNilPqHWc1uYnY/EqWiA2RCxcx8H9zHxFijKH0xEVPjjdMWp84IcfsHtsQ/
 qRBgwoUpyNkqSl/7A/3mooRXdysh98qMNDe55QMtytTRkG/3uCtLYP0nJZg39dcw
 V4ZTJ6vBLZwUthTvkMP7nH7ryE4RvGTCAqNCLNtj7o+cs6u0GIPaPicWyVyqj35i
 CjZm+Cn+7Q/c0p3+yynKA6Z06hEwlqbdDMyk2VZrMafLUV11hsuLr16B2STe8iql
 ni/eHg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64jeca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:01:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381250979d5so1761729a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238482; x=1783843282;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B2tXzOW+S2Yl0q+Uq06qicu2OVLdBJOKKhZnmt9rVFc=;
 b=ECCQcNIRbrazGCq2+IUp0/X6qoHlqppIv9NaF1pevMOoAVUkL01uJQWiWV7PxUoI4i
 jqjZdzpB0QPo0haAEmtXsNa0S5t03xqYfmDBMQvhi0IuAwR1n1s0m+WhWpVMk+rmBHqD
 qtZP22CiOyeINZv8JHUyfx64jr1DbUQ2FDvokc5BV/4zY+DlshQnyh4z7Ll6UoVhrcTl
 SBqbWZVCEgwIq8qQDmQR9RF0vfpWOVig1O/HTzh6eEnVFCmsJdZl3i4Enf28z8d0nLtt
 KDt//goOGmryuxsThhWTBVsofkEPtBiU/k+liqJh0OiIqdyPiSlKYljirN2ao+I0De++
 FuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238482; x=1783843282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B2tXzOW+S2Yl0q+Uq06qicu2OVLdBJOKKhZnmt9rVFc=;
 b=QX6GxxpXFUU5hQ4pBw4VnG27OuV5KwEbfTHqClmemO+6m5AVeDT8tpyn9ELGL7GACw
 eAjfv0zn7nFofyRWok2cTDj8RPpwP0DD3eNoMccnotr7d5tBzTx26j5dLJibppyUEyqJ
 w6kuxfty+Go7Hy8R8/qBvoF1TELlFM9Axx7GI5WSvFwYNjLDiqXFaA45bnJmOLBCQZUU
 BGDxOt0CkDqxExXgvd/9B+aYILoFtsTqnQxAUkjpaNinuuYQKRxyYRNKaUdMYR+VHfpn
 1cTFI/OATMBKSskg+QleuSRnh1rOSYLNTrSNURpOLvbr2eIP5ipW8mVN4ayWt5VvEdBU
 bcSw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7HkQUAycAiAnAWhBL9DgZnX44IxF94RRqBuwsI6xdSZkHy51PZvo3NIyoiJb/ggBwqJ51Apr1tCM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrYmlNOHi4rrBHQ4YXOM0HAoxrxhgKXEwixdJM/K6/2akot1eF
 vi7GXNRv8nqlm+BA0COUEprg3FZOkUF9v0u5Y7mCDPLy4kR2BoQPOgTp2Z2gQBgPK4hS5in4lvl
 u0+wshsuh/gis+u3njsndiCfTtBol1gmcf5b95XDVv0HBBaUpy73Q1Gfhz6r51DtWdYdYxmg=
X-Gm-Gg: AfdE7cnHs0vjHSAqaYRb2h1SZ1hBqNRAikyUU1BWwHPMrZrPiA3UCwX8h6vnURJ8yAh
 YPpUGqSs1/JOICIjiXW/G3YchMoHpLUtq6xR9o2jKI4O0WeCCYnpZ/VvuR1b1kL7ibOzv1keWA1
 GUwjLJ4E2kx3lxAUicCS2egCe74gOL3nVOFxwqKyN6FWryd8xislysbwGHmtO0x3LOWC2dKpcY1
 Ohw0QdQIL3KKu3NzxiJ2TmjhT+VhwU1RhiiMVRJ5lJ7iz+dI29UJc/PB4LY823U1bHp6aUfWsxq
 TW1ZZNpJNFwPIjYactVwrHZ47QYML5Gj50P/IyioZeLba27fHi7Y3kY7wP36RwILSGys4VG5TnS
 /NOQZeXKqupSZ5mqLYq4J2I5m3Zlfd+eMMW8=
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id
 98e67ed59e1d1-3829effb428mr5736471a91.24.1783238481555; 
 Sun, 05 Jul 2026 01:01:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id
 98e67ed59e1d1-3829effb428mr5736407a91.24.1783238480880; 
 Sun, 05 Jul 2026 01:01:20 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:01:20 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:08 +0530
Subject: [PATCH v2 4/8] arm64: dts: qcom: kaanapali: Add QFPROM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=1012;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Rh9iMVK1VvEe82MbzfkSioOLphwmD07vDxc9YOX1LZU=;
 b=QirepiWSprygCdEJpVf63TbnYQtCy6LXKokXYpNSjgpaqD0KgQ7t8Cn3O3YrHCcD8otxXqu1H
 DORiZTSw4phC+My0GtSwo9tg4NvRUijt3W7PfDvv2IpCpJBeYGXq650
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXzp35hcQ9o16E
 7OVhKs4Sj6dht2qh4+ggQU3tEodvr+SkNtBOGlRSH5HB25Rzft8VxbR0gVGnU0Jly1O/3Aq7RGb
 DosSftg2qria5V1pJsMzCpesl3bGjiOmz/W0Dzr26mNYp66lGJYvQ2WJzHahz2AeU11mh6jCOiU
 79LdRDbxQcQdP7v5o0Zwi4AkT1TdSvkASqJ1xluABpIxSAWg/YFWfDRwvs/+BUCdh7uoBglsM+k
 BTKE5b6NTxT/uq16ptGa6LbpgEf6o8XVU9cfaFbnmfHjPcdFRnEUQ8hfrrCXtubJx68w7hAAtMu
 fLCT+54BW6NvE9esFyiAEHZiBf9bssM/TTrFp+OX2YmNBNsXZlSpFOQUncEXbH/0Lo8MYMb+705
 HuyZ5vSaD56q1serq42loucjESAOdcv4MYRq+FgVAXSP7kYCcGB9A8fIrTEx0cxsZjMtW6TO4S6
 2BYO1vuNbE663hxbj+A==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4a0f52 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: IGkMFHnby0xNH0x6IphN1-vd9FK17HJX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX/Me7Wzin2Lsg
 PlPc8E3VGs4JlaTxNO77KRzDkw6Z8oFcAQzqiZ8ep6tcEA4A06+/xkeQVBOLS/tMfgi3MYYmYv1
 PcuJFXvIcBQLVtSsyZPO3uL2wuLMh5Y=
X-Proofpoint-GUID: IGkMFHnby0xNH0x6IphN1-vd9FK17HJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050081
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

From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Add the QFPROM node and GPU related subnodes on Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 19eceecc2a19..8f71f9dc26e6 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -5874,6 +5874,18 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
 			};
 		};
 
+		efuse@221c8000 {
+			compatible = "qcom,kaanapali-qfprom", "qcom,qfprom";
+			reg = <0x0 0x221c8000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@142 {
+				reg = <0x142 0x2>;
+				bits = <3 9>;
+			};
+		};
+
 		nsp_noc: interconnect@260c0000 {
 			compatible = "qcom,kaanapali-nsp-noc";
 			reg = <0x0 0x260c0000 0x0 0x21280>;

-- 
2.54.0

