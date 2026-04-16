Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E731F8A15B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6B410E888;
	Thu, 16 Apr 2026 11:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="d3mZCgUW";
	dkim-atps=neutral
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D9C10E883
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1776337564; x=1776596764;
 bh=Wnc3A7tER4ZejfalykwBJcqTcIaEXnL9kY6Z4U0W7ZQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=d3mZCgUWUe0bF4wqBFQRjIT8nWTjgVBpc7nDIQD5eXO/kaYeoJ34Se9vc8mDpczpS
 7E277V0wtHtmK+FGphjwtyPxn7j8T21mEHnUlC5DjaQLLbycCD9bI0b7NIeV26pgvx
 IcNks5w2dmqj90EoakzT+hggA8d25spaFMNeOEyjuZ8YIHbIx3/SumeLfG+vgxpT4j
 nTaSBLJRb6+I8+/k/3umJWHEg5DxqiRcAGK85JbtTs9sBZm83Ai+mMK+KMwu+M0P1Y
 R7BkReufGhGnYsGuVqDUnnzYapRXtv8kSus+AjQxP4RTHhN49MO/5gaTgAYwyQ6ArL
 qXaYts5jMqN5w==
Date: Thu, 16 Apr 2026 11:05:57 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH RFC v4 7/7] arm64: dts: qcom: milos: Add Adreno 810 GPU and
 GMU nodes
Message-ID: <20260416-adreno-810-v4-7-61676e073f8a@pm.me>
In-Reply-To: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: f104980b69ce4563155bfb14f1bb2f98a37cf343
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
Qualcomm SM7635 (Milos) based devices.

The qcom,kaanapali-gxclkctl.h header can be reused here because
Milos uses the same driver and the GX_CLKCTL_GX_GDSC definition
is identical.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 166 ++++++++++++++++++++++++++++++++=
++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom=
/milos.dtsi
index 0e7cfc12b0d2..4abaef42d7d4 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
  */
=20
+#include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>
 #include <dt-bindings/clock/qcom,milos-camcc.h>
 #include <dt-bindings/clock/qcom,milos-dispcc.h>
 #include <dt-bindings/clock/qcom,milos-gcc.h>
@@ -1554,6 +1555,171 @@ lpass_ag_noc: interconnect@3c40000 {
 =09=09=09qcom,bcm-voters =3D <&apps_bcm_voter>;
 =09=09};
=20
+=09=09gpu: gpu@3d00000 {
+=09=09=09compatible =3D "qcom,adreno-44010000", "qcom,adreno";
+=09=09=09reg =3D <0x0 0x03d00000 0x0 0x40000>,
+=09=09=09      <0x0 0x03d9e000 0x0 0x2000>,
+=09=09=09      <0x0 0x03d61000 0x0 0x800>;
+=09=09=09reg-names =3D "kgsl_3d0_reg_memory",
+=09=09=09=09    "cx_mem",
+=09=09=09=09    "cx_dbgc";
+
+=09=09=09interrupts =3D <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
+
+=09=09=09iommus =3D <&adreno_smmu 0 0x0>;
+
+=09=09=09operating-points-v2 =3D <&gpu_opp_table>;
+
+=09=09=09nvmem-cells =3D <&gpu_speed_bin>;
+=09=09=09nvmem-cell-names =3D "speed_bin";
+
+=09=09=09qcom,gmu =3D <&gmu>;
+=09=09=09#cooling-cells =3D <2>;
+
+=09=09=09interconnects =3D <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+=09=09=09=09=09 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+=09=09=09interconnect-names =3D "gfx-mem";
+
+=09=09=09status =3D "disabled";
+
+=09=09=09gpu_zap_shader: zap-shader {
+=09=09=09=09memory-region =3D <&gpu_microcode_mem>;
+=09=09=09};
+
+=09=09=09gpu_opp_table: opp-table {
+=09=09=09=09compatible =3D "operating-points-v2-adreno",
+=09=09=09=09=09     "operating-points-v2";
+
+=09=09=09=09opp-264000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <264000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+=09=09=09=09=09opp-peak-kBps =3D <2136718>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0xc8295ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-362000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <362000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+=09=09=09=09=09opp-peak-kBps =3D <2136718>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0xc02c5ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-510000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <510000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_SVS>;
+=09=09=09=09=09opp-peak-kBps =3D <3972656>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0x882b5ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-644000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <644000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L1>;
+=09=09=09=09=09opp-peak-kBps =3D <5285156>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0x882a5ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-688000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <688000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L2>;
+=09=09=09=09=09opp-peak-kBps =3D <6074218>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0x882a5ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-763000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <763000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_NOM>;
+=09=09=09=09=09opp-peak-kBps =3D <6671875>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0xa8295ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-895000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <895000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L1>;
+=09=09=09=09=09opp-peak-kBps =3D <8171875>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0x88295ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-960000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <960000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO>;
+=09=09=09=09=09opp-peak-kBps =3D <8171875>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0xa8285ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-1050000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <1050000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+=09=09=09=09=09opp-peak-kBps =3D <18597656>;
+=09=09=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0x88285ffd>;
+=09=09=09=09};
+
+=09=09=09=09opp-1150000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <1150000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L2>;
+=09=09=09=09=09opp-peak-kBps =3D <18597656>;
+=09=09=09=09=09opp-supported-hw =3D <0x3>;
+=09=09=09=09=09qcom,opp-acd-level =3D <0xa02f5ffd>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
+=09=09gmu: gmu@3d37000 {
+=09=09=09compatible =3D "qcom,adreno-gmu-810.0", "qcom,adreno-gmu";
+=09=09=09reg =3D <0x0 0x03d37000 0x0 0x68000>;
+=09=09=09reg-names =3D "gmu";
+
+=09=09=09interrupts =3D <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH 0>,
+=09=09=09=09     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH 0>;
+=09=09=09interrupt-names =3D "hfi", "gmu";
+
+=09=09=09clocks =3D <&gpucc GPU_CC_AHB_CLK>,
+=09=09=09=09 <&gpucc GPU_CC_CX_GMU_CLK>,
+=09=09=09=09 <&gpucc GPU_CC_CXO_CLK>,
+=09=09=09=09 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+=09=09=09=09 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+=09=09=09=09 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
+=09=09=09clock-names =3D "ahb",
+=09=09=09=09      "gmu",
+=09=09=09=09      "cxo",
+=09=09=09=09      "axi",
+=09=09=09=09      "memnoc",
+=09=09=09=09      "hub";
+
+=09=09=09power-domains =3D <&gpucc GPU_CC_CX_GDSC>,
+=09=09=09=09=09<&gxclkctl GX_CLKCTL_GX_GDSC>;
+=09=09=09power-domain-names =3D "cx",
+=09=09=09=09=09     "gx";
+
+=09=09=09iommus =3D <&adreno_smmu 5 0x0>;
+
+=09=09=09qcom,qmp =3D <&aoss_qmp>;
+
+=09=09=09operating-points-v2 =3D <&gmu_opp_table>;
+
+=09=09=09gmu_opp_table: opp-table {
+=09=09=09=09compatible =3D "operating-points-v2";
+
+=09=09=09=09opp-350000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <350000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+=09=09=09=09};
+
+=09=09=09=09opp-650000000 {
+=09=09=09=09=09opp-hz =3D /bits/ 64 <650000000>;
+=09=09=09=09=09opp-level =3D <RPMH_REGULATOR_LEVEL_SVS>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
 =09=09gxclkctl: clock-controller@3d64000 {
 =09=09=09compatible =3D "qcom,milos-gxclkctl";
 =09=09=09reg =3D <0x0 0x03d64000 0x0 0x6000>;

--=20
2.53.0


