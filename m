Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C3606A336
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g3iKEJDW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HZdQHWx9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C4810F9D0;
	Tue, 17 Nov 2026 23:01:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB2910F9BB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHN0ixT1537204
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tjPMvS6dNIgWnwxHq7t2pgQdKhhFdoLT9gKd8NpYaXs=; b=g3iKEJDW7pcwY9Tk
 3PkHwbi6tdb1uTlCZBxozCD6XYBTtFgBDgscb1reT0I2gVnqEidafeh4Oy/6HU7u
 g2zcy7qYmOOxZMVIkv9grByjJcGYFBoPQrKLuhNcBOUwEw+aq5P/sU23usM5OI0l
 94tlYEFv8CNwqinrXNxse2XsXSbW5r/dOn/w3lwt9MqBz+PX56EOnMaR8I3Z//64
 rxnfYWUnrYDaRUTXvk9uRNfm45wCSkJHsq/Gb7sieQGcC0Dp/Lm0sVVTddQZOAf+
 9sY/q/4dApYPuOv7BRBC+CqFhRq1um0ikoWaqteZ/uqPy//3SQYJdqcdU2Zc+gCg
 zDAN3Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8g37t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:55 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b53bfc9534so192959c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956454; x=1795561254;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tjPMvS6dNIgWnwxHq7t2pgQdKhhFdoLT9gKd8NpYaXs=;
 b=HZdQHWx9MljvXVRV1FrFtDZ05LrssOb3coe2YDWVOXtSE87iCwW+6MPxbfB/IcwLCY
 4gk+mtNbTsZkcmyNQvhrRdZ8jQwfnmA/uBJCthSAWynUOmaSSMfWanXrD03xcFxxgl4z
 6EhjvvqJqBf5fNu3AtGMluOCfJnE/gSS+3RdcNJUMt/2scAtza4AAL2UO4FIukICe2Jp
 6KctBOyRq67kSbHiFyVstNX4FV+jlvMTVF0InoGLFTjbcNuthx+l4oXiy/XJXCf3ii0u
 NkYrKeIKiEAZS0ibHE/5CsGgorZjdTojOWSFmDczqKjafs2bohjnJpUzSLRmdn9CVsrd
 5T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956454; x=1795561254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tjPMvS6dNIgWnwxHq7t2pgQdKhhFdoLT9gKd8NpYaXs=;
 b=ydm7z+Cf8Fz3MrVrWOZcnXWl9l14QYW/UgwQukpUjRxyj9f7h/D1WL0TJTE6ItlrKU
 OvISvIU/e8Pt62pP4FDHkT4Mfu5A6qZuxQFRaW2y/yXJNwqd5CgMd2Ft6DoYa2DZHI4e
 E0G7bxf3BDvz+AEjDRA1fzsUOhpqFMLgeTABWjtqct9ZR53Xzp/8QwVvSu5UCinf4uYe
 wRtIHP/sG9AjUgOOj5iq/HfvH5pCZwX3NPVcOafz62qR+o2D63fWuWyoTFO2NmeoHgMf
 Cpxip5fDa1kD574UpoJH3O6Z6LrdQd3RVRTU7cmEOzLY/9G3lr8iXTE4PgCR0+U1QpiL
 SNqA==
X-Forwarded-Encrypted: i=1;
 AL+hErH47rDSYLW7u3B3Jvy3/JpfXVHH8IUFaFcNGyvCrcyRf8BMs4M0yy1807AZT6JutHIhXhZQ/PQHN2o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8KmjwhgqpGbHVOCqzD9DSMDUuzn0vZlkcgl6YjIkd6/gM6C0lM
 a9Z28ioQcqw3B+8RgPm1KIfHdW1wXZ+w5nRrGy4I0P/3ryWf6n7bHemdoHJZJ2aND5vovV4DdYn
 GHHY4ai6LkBgwRBMLq42AH2fnAHageIC2R4QQupSt3aqq2s+mQ2MM/D0gpWhDBEEIo/zhLlU=
X-Gm-Gg: AYBFou1utaYnFYDG2/os7ZtZw3SAGw0uCZjPSdSzRdnu9/2TWP46ojHFU6Mbaa7bzqa
 g8mWplQVQrSxUtpzWHMbCHh0JALRR42TCHL1ZKLGOQ5qEoEzxv47PiT3Hd3qhMmWYhh4Y+SBKfN
 14FNnaQpkbO5+1WMcxvGZUHAB2l1pKxypxix7xcTzCF8OxSDQO6oURt4Oy3/0QO6QBjnM6t5/Xh
 ILyQ5lr0uq6gZJIc+jyVoO27VBxZiQcku35C/7KV2HwBes2yY0+ShliXBoxdrfEuDFct9VdKknP
 xJ3pBQF6GLpoNpgc1qYGBP9buAvU+umJmvsDr6DoKk9t6j49dmgXpj13fIiL+Bau+NAW68VHEZm
 PecGyXV5KovGfbLoMR5wYWt655tPMS2Iz02IToEjhmRNotBBxc7KOJD50NOQ9Mqq28CxkOD7yUw
 ==
X-Received: by 2002:a05:701a:8458:10b0:151:2e62:fe4b with SMTP id
 a92af1059eb24-1b543cdf789mr947999c88.23.1794956453942; 
 Tue, 17 Nov 2026 15:00:53 -0800 (PST)
X-Received: by 2002:a05:701a:8458:10b0:151:2e62:fe4b with SMTP id
 a92af1059eb24-1b543cdf789mr947951c88.23.1794956453138; 
 Tue, 17 Nov 2026 15:00:53 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5445eb29esm1380839c88.0.2026.11.17.15.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:00:52 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 04:30:06 +0530
Subject: [PATCH v2 3/5] arm64: dts: qcom: nord: Add GPU and GMU nodes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nord-gpu1-v2-3-8d6d9908b7c5@oss.qualcomm.com>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
In-Reply-To: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794956423; l=4762;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xyYYgqzcHaqG6oN0uFpCZ3eFSIuUWGDcbZDkjY5Kcic=;
 b=5UxRY37gGgict8xRQRg+ixx8UaW6DFONQtSdqc6NcTDJvUa9OR3MHLVLYYFAcnS5GdS1TuycV
 fEobgq7L4YKC2N62k/Wh8HGLMHpWCdcDZflTH+YN7AEQNagWDkbr56q
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: TqIn4SyxaF8bhJDPhll9oqTo6U907PgR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXwooAKO4tN6nm
 qNEnzGVZ7H1DTzAMpuThvT+eucYf+SjFpS7kVZckvEJ0joQHsSlbFwQFMnYb7yEwfDRo1KHEfQb
 FH8s17q4p0wzUT9xOyVtq81p0c0tOlg=
X-Authority-Analysis: v=2.4 cv=c60+0h9l c=1 sm=1 tr=0 ts=6afcdca7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=FdsHoUj-PjsiTO6IAGgA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX5/EVx8IAaKug
 BP+Fnv880oi0ZSVuiEpcvx/QwHwizRcznBiACjb5uzb9qUi1Lp4UBjHZHiSmAqi9ttiweOI3bE/
 QL8t8Ze5YhOOPemiSef+kvcJw2k2Dw95U9Y0ut379HTWbrAI+yBirg1Gu71HUWUvgQR/GZ6z2tz
 t4wOTdwM1EFg6rytTzdR5qxkUX/Uwxbp3ekejPSzWqnPUloOWISh0DBIoNUyY0VPDxvBrMvv2cD
 7rQp9qkntwqis+zzOmZz3J2lDzW6CJ9suyRFhQ36lp1mt9qvouvydV7Fs2j8E3bl2uPAFLGxDT7
 MnyLel8OgQRLOwNWKP7hsGzs6MXGD5nc6FcGPt91Ebx/Ou+crElnY9dCnd+EAQTkXB0in4YI0NV
 c9apsEtZtXi7WUbh+m53j2vqcdPUy4dUAn8k94nJPMZe3pM5dlxpKT+3auMZxCnJhqPF0elAtSu
 GcGLOWelQ/pbCodJEzA==
X-Proofpoint-ORIG-GUID: TqIn4SyxaF8bhJDPhll9oqTo6U907PgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

Nord SoC integrates an Adreno 753 GPU as its primary GPU, belonging to
the A7xx Gen3 family, along with its Graphics Management Unit (GMU).

Add the GPU and GMU nodes together with their OPP tables. The GPU sits
behind adreno_smmu_0 and uses the gen71300 zap shader, while the GMU is
clocked and powered from GPUCC.

Following the existing Nord split, the SoC-invariant properties (reg,
interrupts, iommus, zap-shader) live in nord.dtsi with both nodes
disabled, while nord-embedded.dtsi adds the clocks, power domains,
interconnects and OPP tables that are only managed by the OS on the
Embedded (non-GearVM) variant.

Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 79 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/nord.dtsi          | 43 ++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
index 5a1520e436c6..e9e830bb727a 100644
--- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
@@ -76,6 +76,85 @@ &crypto {
 	status = "okay";
 };
 
+&gmu_0 {
+	clocks = <&gpucc GPU_CC_AHB_CLK>,
+		 <&gpucc GPU_CC_CX_GMU_CLK>,
+		 <&gpucc GPU_CC_CXO_CLK>,
+		 <&nwgcc NW_GCC_HSCNOC_GPU_AXI_CLK>,
+		 <&gpucc GPU_CC_MEMNOC_GFX_CLK>,
+		 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
+	clock-names = "ahb",
+		      "gmu",
+		      "cxo",
+		      "axi",
+		      "memnoc",
+		      "hub";
+
+	power-domains = <&gpucc GPU_CC_CX_GDSC>,
+			<&gpucc GPU_CC_GX_GDSC>;
+	power-domain-names = "cx",
+			     "gx";
+
+	operating-points-v2 = <&gmu_opp_table_0>;
+
+	gmu_opp_table_0: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+		};
+
+		opp-625000000 {
+			opp-hz = /bits/ 64 <625000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+		};
+	};
+};
+
+&gpu_0 {
+	operating-points-v2 = <&gpu_opp_table_0>;
+
+	interconnects = <&hscnoc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+			 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+	interconnect-names = "gfx-mem";
+
+	gpu_opp_table_0: opp-table {
+		compatible = "operating-points-v2-adreno",
+			     "operating-points-v2";
+
+		opp-468000000 {
+			opp-hz = /bits/ 64 <468000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+			opp-peak-kBps = <781250>;
+		};
+
+		opp-625000000 {
+			opp-hz = /bits/ 64 <625000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+			opp-peak-kBps = <6075000>;
+		};
+
+		opp-735000000 {
+			opp-hz = /bits/ 64 <735000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+			opp-peak-kBps = <8175000>;
+		};
+
+		opp-854000000 {
+			opp-hz = /bits/ 64 <854000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+			opp-peak-kBps = <10687500>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+			opp-peak-kBps = <12450000>;
+		};
+	};
+};
+
 &i2c0 {
 	clocks = <&segcc SE_GCC_QUPV3_WRAP0_S0_CLK>;
 	clock-names = "se";
diff --git a/arch/arm64/boot/dts/qcom/nord.dtsi b/arch/arm64/boot/dts/qcom/nord.dtsi
index 617e5312f4c4..36a422db8ea6 100644
--- a/arch/arm64/boot/dts/qcom/nord.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord.dtsi
@@ -1712,6 +1712,49 @@ tcsr: syscon@1f60000 {
 			reg = <0x0 0x01f60000 0x0 0xa0000>;
 		};
 
+		gpu_0: gpu@3d00000 {
+			compatible = "qcom,adreno-43051701", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x2000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu_0 0 0x0>,
+				 <&adreno_smmu_0 1 0x0>;
+
+			qcom,gmu = <&gmu_0>;
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			gpu_0_zap_shader: zap-shader {
+				memory-region = <&gpu_microcode_mem>;
+			};
+		};
+
+		gmu_0: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-753.1", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6a000 0x0 0x35000>,
+			      <0x0 0x03d50000 0x0 0x10000>,
+			      <0x0 0x0b2a0000 0x0 0x10000>;
+			reg-names = "gmu",
+				    "rscc",
+				    "gmu_pdc";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi",
+					  "gmu";
+
+			iommus = <&adreno_smmu_0 5 0x0>;
+
+			status = "disabled";
+		};
+
 		remoteproc_adsp: remoteproc@4c00000 {
 			compatible = "qcom,nord-adsp-pas";
 			reg = <0x0 0x04c00000 0x0 0x10000>;

-- 
2.55.0

