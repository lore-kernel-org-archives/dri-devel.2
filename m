Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38327C5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C3310E084;
	Sat,  8 Aug 2026 20:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="knyBMTL2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRPHIAjz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FF610E080
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:23:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678K0BjJ1044968
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 20:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 35yBqf/L8pKpPbkljIq386QZBSYHcWB5hxAydwTSIX0=; b=knyBMTL2yEf6BufI
 H5H3JTrF9sIa4ISnrp4iWekuxq8JbvTGTZ7OwVinkhJ16FNKzAI0FAtpuWcvqwfx
 bdO/mSYKatSA0QkTGyijUJj9p1qM109w84n+i2NjZ/piifdwIGrW1ffUwgQcbyPK
 cNK7z1+vpFTP6CsUEMN1H8JFuhb7OlNWMsl6LfyFMoEszw/KHCzsemYqt5kZ76dx
 E1PUiRsjoBtEYpy8v5R0qnubANjL93EPbEHb8PsbMcVYWcnvxG0pxSgQ+RMzs1Bw
 Xsv1GH9SoTeCoBk5sije8DNu5iGQlAiepQaRyFnMeqXCD8W3MbXllvNWJT+6Fzy5
 h8t73A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwv1y9qeu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:23:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso418752a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786220625; x=1786825425;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=35yBqf/L8pKpPbkljIq386QZBSYHcWB5hxAydwTSIX0=;
 b=ZRPHIAjzkOJIetcFsTymEW/skB9N4iIQ1O7cPEK9NYqSOMimRKEiWtkjt0US4Ir2Fv
 G9mKI8ioCU65LhiPVCPTVDO0j7KIhdbfx9qS5yV7cmTI8yhkE/dRknvmQznsLeCq2QJk
 ebG2vdw9Z3esIs3mMlYt1AXokn4EjTi992nxqqPYXNxKt/b8wdjFRz1zexw/OHVk+ZBO
 hlpvC3d6ENLQ+LwC+hPKfAPXz9k0+HxURGnFqVNhtjbowgXzMYbIOx1Kt5fRO3nRRxCv
 71vVR/ktECpKvYDCCvCqz+fR2BELOLRAUBkvuwenLlEcvoA444pzQ83mPVciAkn9ph9r
 0SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786220625; x=1786825425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=35yBqf/L8pKpPbkljIq386QZBSYHcWB5hxAydwTSIX0=;
 b=VT7qwKySqZa6J04kTiKQfromb/kpFi0ni0xG/1jVG1smjp1bcpVKWQcSnCdfsEI4RU
 /N529kb26t7eGyJjGR93WP8kF3fGtAAf/Ee1DNEXc/JD70Bwg51fZFfNdzeSgHFOL/4h
 XGnAvLZpUdVjRPWTwSCGG3vZ33GKWXg39E5iM2r8j5GYGJF6SBFn1uDTRvfBQmkpqmKQ
 Fbi9wy2fkCQU+hqFlAD5R8mhlRKF42AaJSzYVgaQQNJBwT4z19fKhNfdiN9bAhU70B0G
 wYe8rbBblFfZjaECnwhs/sBFh0VT7Ei6FszqzC4w5CMpXnYIiDH5bk6yQqFgi4G3sUDg
 5dEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZW2xC6xZplIQ7DBazEqVBpdv+ELuCWto33zYOIIMT9QubEHWLPURTwA4Z/QtqBaw9GGRy9Kh+rY4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8FtWf+xl66WexkhiagDNopvyAdzEzwZzI7/Ma5IebHwcintVa
 kddCil6ZsbaeMOM0wnLtDkVil+jPya91fJAtQN+ig0bDD0r0mjnb9ry1SFAJ//gXPOL85kGV4ee
 49PQT4xnpP8y9xFVJfwD9D8JGF9GlprphPbrD8jUnZSvJsIQxBGzIPxTE+agdu3zRCegmEyI=
X-Gm-Gg: AR+sD131NgCLAhhZ/rOQD2rE1DbeEcIOMHn3Pl/H0wfFZwZH0UBZTXZquXpJi8KCfZB
 RKh2+4IO4/f5vPcCYCu8p0JObrekGQ/MHqR4N+ZeKwRc494+JV5l+d6QkPaln7wBkwOfJbTJ3xD
 SWCc6gj6mLCL47jVNv+r+nQzOxp96wkHbik3pFr/nenhi7tw5RGpjQYoh0XslkIpD3/QhoLtPEH
 PTkOCN/VfeQzyOhKDwtDbRvdSbutut1MSc0UhzaWnbuIGvW8435qJYj3pCpYhPJhyDWcZX1/K+m
 AoDSLYJPLdUDQThPyJeM6NZY50yG/bTf39OHhO4WQKbb9a316j+vS7L5evuWShLBu6adjNErwJC
 54hRH79xBA3XEEoZts0ZlygcI
X-Received: by 2002:a05:6a20:4324:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3cbce8d863fmr9053243637.21.1786220624570; 
 Sat, 08 Aug 2026 13:23:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:4324:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3cbce8d863fmr9053204637.21.1786220624074; 
 Sat, 08 Aug 2026 13:23:44 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm26357417eec.5.2026.08.08.13.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 13:23:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 01:53:10 +0530
Subject: [PATCH 3/6] arm64: dts: qcom: sm8750: Add GPU and GMU nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-pakala-gpu-v1-3-207ad1fac1c7@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786220595; l=7793;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=KpRjvaN+POYnf/iWbLactJsvS/uONwYdIqDoQnawjs8=;
 b=lEWC0spHnEQuK2FZr1li2EvJoU8Un1fZN9V4lyQZAdKTyDg3gqBTJi8CE3H2aKp8mJ52wpF3E
 pbVRMzZM279BvN6AKIhq9dGnalZeFZ5MDbc6M27TpeDLv5i+Spj7Zps
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: S1YlGqI8O1S8aFU9FLnLBW1TeH6XqpIZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX3iWz5CpfSJFv
 1dhxv0ntiRDcTOrhKTNQNFNHaG3YCFmI6i9iqYVLBRcwrrkI4+3DO2Hfo08JQgtUtnLIwEnMU7R
 x1E4QNzznSikbnMAAO3B1l1MIaQ1XhadUuflO11S0EgHRAUm3EzgledWM1dhWzzC3z07cF2NLZU
 rzT8RhBaIZwm9QHVtpszjZ+1ExCkSefH7o03/ePl1Fg25rT4bIz7Qk+EGkW+7Gwyz5WSEgmiMgD
 /ZphPOVfybrHHlM+ESGRILzHPlukQ+IiulxLqsUkOCvLrv3h2vhmR43jPmIqUUoG1/GtAN6SOdW
 A6g/WiVSlbG1UDDSAOuUw07Eu+C7FczaTIg5AhC4EqTcZSbap3nSsJYVcqHdLAjjhhDJkOz5qPk
 hrzCWVQLzx1byutWhoC9qs6KhXNLehFAb+u+XdYXi3V9WMwIOtxVKie/kOjlW032HbFtHGJyzYP
 +zQfMmCSzpV7pHx8lQg==
X-Authority-Analysis: v=2.4 cv=PbrPQChd c=1 sm=1 tr=0 ts=6a779051 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=AfwcTw3k21529EtOIw8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX4u2hMdYkmyVr
 rFYv5hwpZImig15VhqeXrnzqAlTvwm3d9xNhMCzGnGMFkINOr/eV/DYV/0DtLQljmZ6xpVmwhlc
 N9LzzcWZmDevf01DBhKJEyv/lBaHxQI=
X-Proofpoint-ORIG-GUID: S1YlGqI8O1S8aFU9FLnLBW1TeH6XqpIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080176
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Adreno 830 GPU present in SM8750 chipset belongs to the A8x family of
Adreno GPU. It is similar to Adreno 840 GPU with some meaningful
differences like GMEM size, register file size etc.

Describe A830 GPU and GMU nodes in SM8750 devicetree. Also, add the
qfprom node to describe the GPU speedbin fuse register.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 231 +++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index eb3a6990ec30..6ddc8d3fdada 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2182,6 +2182,176 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-44050001", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x6d000>,
+			      <0x0 0x03d9e000 0x0 0x2000>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0 0x0>,
+				 <&adreno_smmu 1 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
+
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-adreno",
+					     "operating-points-v2";
+
+				opp-160000000 {
+					opp-hz = /bits/ 64 <160000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D3>;
+					opp-peak-kBps = <2136718>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-222000000 {
+					opp-hz = /bits/ 64 <222000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <2136718>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-342000000 {
+					opp-hz = /bits/ 64 <342000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-389000000 {
+					opp-hz = /bits/ 64 <389000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <6074218>;
+					qcom,opp-acd-level = <0xc8285ffd>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-443000000 {
+					opp-hz = /bits/ 64 <443000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <6074218>;
+					qcom,opp-acd-level = <0xc02e5ffd>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-525000000 {
+					opp-hz = /bits/ 64 <525000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <6074218>;
+					qcom,opp-acd-level = <0xc02e5ffd>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-607000000 {
+					opp-hz = /bits/ 64 <607000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <8171875>;
+					qcom,opp-acd-level = <0xa82e5ffd>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-660000000 {
+					opp-hz = /bits/ 64 <660000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <8171875>;
+					qcom,opp-acd-level = <0x882c5ffd>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-734000000 {
+					opp-hz = /bits/ 64 <734000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <12449218>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-832000000 {
+					opp-hz = /bits/ 64 <832000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+					opp-supported-hw = <0x1f>;
+				};
+
+				opp-900000000-0 {
+					opp-hz = /bits/ 64 <900000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+					opp-supported-hw = <0x0f>;
+				};
+
+				/* Only applicable for SKUs which has 900Mhz as Fmax */
+				opp-900000000-1 {
+					opp-hz = /bits/ 64 <900000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <18597656>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+					opp-supported-hw = <0x10>;
+				};
+
+				opp-967000000 {
+					opp-hz = /bits/ 64 <967000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <18597656>;
+					qcom,opp-acd-level = <0x882a5ffd>;
+					opp-supported-hw = <0x0f>;
+				};
+
+				opp-1050000000 {
+					opp-hz = /bits/ 64 <1050000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <18597656>;
+					qcom,opp-acd-level = <0xa8295ffd>;
+					opp-supported-hw = <0x0f>;
+				};
+
+				opp-1100000000 {
+					opp-hz = /bits/ 64 <1100000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+					opp-peak-kBps = <18597656>;
+					qcom,opp-acd-level = <0x88295ffd>;
+					opp-supported-hw = <0x05>;
+				};
+
+				opp-1150000000 {
+					opp-hz = /bits/ 64 <1150000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+					opp-peak-kBps = <18597656>;
+					qcom,opp-acd-level = <0x88295ffd>;
+					opp-supported-hw = <0x02>;
+				};
+
+				opp-1200000000 {
+					opp-hz = /bits/ 64 <1200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L4>;
+					opp-peak-kBps = <18597656>;
+					qcom,opp-acd-level = <0x88295ffd>;
+					opp-supported-hw = <0x01>;
+				};
+			};
+		};
+
 		gxclkctl: clock-controller@3d64000 {
 			compatible = "qcom,sm8750-gxclkctl";
 			reg = <0x0 0x03d64000 0x0 0x6000>;
@@ -2193,6 +2363,55 @@ gxclkctl: clock-controller@3d64000 {
 			#power-domain-cells = <1>;
 		};
 
+		gmu: gmu@3d6c000 {
+			compatible = "qcom,adreno-gmu-830.1", "qcom,adreno-gmu";
+
+			reg = <0x0 0x03d6c000 0x0 0x32000>;
+			reg-names = "gmu";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_GEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "hub";
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gxclkctl GX_CLKCTL_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 5 0x0>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-650000000 {
+					opp-hz = /bits/ 64 <650000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,sm8750-gpucc";
 			reg = <0x0 0x03d90000 0x0 0x9800>;
@@ -6019,6 +6238,18 @@ cpu_scp_lpri1: scp-sram-section@200 {
 			};
 		};
 
+		qfprom: efuse@221c8000 {
+			compatible = "qcom,sm8750-qfprom", "qcom,qfprom";
+			reg = <0x0 0x221c8000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@138 {
+				reg = <0x138 0x2>;
+				bits = <0 9>;
+			};
+		};
+
 		/* cluster0 */
 		pmu@240b3400 {
 			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";

-- 
2.54.0

