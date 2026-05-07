Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B92CD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B5F10EF66;
	Thu,  7 May 2026 06:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWGNZudj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vh+Pegx1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE8010EF66
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:23:38 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475LMvD1068056
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W6lOhP1mJj9
 S5lsQBAhviQQkaUqn3FvSFeARxkagj0g=; b=bWGNZudjP0LJgeME8J9ge2Au3DK
 /Ua9/TXFFqO7DWpCkDyFVKdqVKPci8l5RH5BK4S8acapR3QJLkfsvl2Ekj9DMQBh
 DWE/KgpSVnL4hpirvO7x0GkW31fOgHoG9rO8Ppg0K2LcpH+o5+rF1etXzRQGZ8D2
 hn9vtnx+s2FWvmD1V7J42U4bMFDkZ0Gc9G0EU+iD1KJNDqTTajgCZbO6PDdEtsN8
 b9HVVI7D0xqplVuWn1lu3FCsLjOxEPWtMm7W+vHWyXKh0Ecd4uYyxgmE/0JzH6tD
 f7sUQVnEhyI4Dmvx7njOZwkgmEDyutO99kUXawRgBK5i4LIF6RrNkWfEvCg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mh186k7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:23:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-835417ba8c8so275847b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778135017; x=1778739817;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6lOhP1mJj9S5lsQBAhviQQkaUqn3FvSFeARxkagj0g=;
 b=Vh+Pegx1kUdd2myK+VlzQrF4XXmlH4g4L2QJdNKNkgXcbyZe+FWJq6JSj5EwB6Hx2k
 ar+joB7UuuD7IjPfqF/v3Mu3GcBIDXCEFzgT2Hj1HV6RLI9xc7Em65/CV5buaOwgwiwz
 9LgqqLrkbvLd6IakBh9zMVYiOI3IuoIO4USVpzMJ2IzuSTbr5DFmBqzpEyhMrfYQMbpU
 iTeusAajv59VWCYm8o6nGMJQ/CQeqJFD4XDtNQDsl37AMBg0rlRgAPTetltGXgcdJLL1
 jviDk34jcP5yW48/Qdm8zciEVJN1EXOxUhlzlx+MFSN5uQHzlWFTeSyL5a1wceETM4IC
 b+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778135017; x=1778739817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W6lOhP1mJj9S5lsQBAhviQQkaUqn3FvSFeARxkagj0g=;
 b=BWmkPTOTs7lk2zQsn6LHwJ36fTvH75LjXkQ5XngVaR26BxfNJc1DmhLNZr19yee1tC
 FNq4ob14Z5Zk/MoxgnyVvzJaiUnYJQJ0rsD+6j4gqgId7J7MuK0zYU4ggBfNo6BWxjcw
 xPymtPc6CPVfb+KM+1N+PEATXusO8jq/tdUik+FqFyP/GxtfzjGUJgogbPKW+lXw2LAM
 6Q1g4EBDmMZXUFCsvvt6fciRzYHmlerJbyn/a2FWG8QhS+mdBKXBO0O8FAB45u0+kTDE
 9XkG96CAYaBcHYw7FtmU5DHWypelXWIrSFVoUQFial+3TQnRmOSAZCe8o+0YPZbh0Dnw
 uwdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+01lwlPUV2SC9hM44k4k7UdTpcPIttMdPyqo6LL124s8xCPOpo0qz0SG/YREvq2qQ5EfxWAMnd13I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrw9j2WbEUYWniKdmpZUna8qgyf29uskeQXJQ3Md8KJT47863+
 FWDJA1yRXKLJOY04uPFY53/Dxlp47+CCCWgbUiIZyRZPXvZoTNrc0qY6Gc85lqQ0BsmdGQ3TjH4
 hO7NBBZFsYw7XF6tRZBTbfEw+9MTWff3Uec7EgV2TYpeUPXjQnVNCEFBg0vbCKKerErON0e0=
X-Gm-Gg: AeBDievGf6pTk6p2vCe54zmNQeRaKnkPeTFPPdHAbV4Sc/ygxMabvtZbHmTZYMEHBQw
 mOYTaFrPaX2YP8kZkh+o5qz10tFDMn1IurfnV9ZKX/mVQ5V359pZclH54KmpjBAU5yYbgA650LC
 jV1CXdb9QCQyt3ThsvFkBYSlzowkbe/ykYMnnT0QSXEYNa148QZghA3Q2DE4vVO4i80fA9Znsk7
 3Dz9jsdoSmM2v/DUYXGwzAKZzFP02s/rxvXC2RdSeXOjBZ49QzESlEL4kpG+/s2119OaOnD1ssF
 bhTLg6hazbSjclgvsETkfhxy47xq69uXty21b8ZH//6PHg2ZVbiRJxG1CHo+y3LprPoP1fc3sZ1
 DwYLCbUN+CNXevkshsHTMwU1bWjtM+JBWpV16A44mueontB9AyEAePpoGdl58GuxoVEplmorkvf
 Z1cXhhtbVhHA9af2NprI3xh7nabkQr+uhzyOXYp6xoCYXxp1I=
X-Received: by 2002:a05:6a00:b48:b0:835:351c:f236 with SMTP id
 d2e1a72fcca58-83a5d09a78dmr6377453b3a.29.1778135017218; 
 Wed, 06 May 2026 23:23:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:b48:b0:835:351c:f236 with SMTP id
 d2e1a72fcca58-83a5d09a78dmr6377412b3a.29.1778135016714; 
 Wed, 06 May 2026 23:23:36 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:23:36 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 7/8] arm64: dts: qcom: glymur: Enable LLCC/DDR/DDR_QOS dvfs
Date: Thu,  7 May 2026 11:52:36 +0530
Message-Id: <20260507062237.78051-8-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IFk2dD2lKEyi1SG-Vk-Lu533cq-vFLjQ
X-Proofpoint-ORIG-GUID: IFk2dD2lKEyi1SG-Vk-Lu533cq-vFLjQ
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=69fc2fe9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=GY6npCAvCrdgt1im_sIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfX0bOp26KOiriD
 rNT35Ef/Q53kL8Xg/vQLfefY8HJHXpdViYQrzW8Sz2O9o6YZE/W+0RMj4cOrdwY1TyZagu+PTTN
 /SoYlAvpUxxjUhmYNjrzrQfub7kRwZocxP00G9V+w85nsLhDNo7Dsh1mz3EvJnk6dvR15T7sfMn
 gsaGgdd3ncO+ron33ljQd4eEuz+cqOYP6wK2lcErGoAG1LKhS40N/cicV74PFxoTExDjAXHPm2T
 TQXcUgQBH8fov3pCYvGDHEq2IFAostF127S/sMCFNbcm9kxohX9Z88EJyJWXi/cSOBLRzzgG+jh
 hBLzOnlo3GN9Z77LRxX8j2MrQq/T50dukudmMoI6cNRB/zSwuBk0y7ix1NJtybLo1dPn1P6/A+g
 o1ohtHfkkMLdRdIJyrD5aaajCpX7pcrPU0ETsB4TR9TQjWTsqtbdEHoKXH80HmApdUqqKB8SMIu
 A/tnZnfyY1d9YQmIDHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070060
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

On Qualcomm Glymur SoCs, the memlat governor and the mechanism
to control the LLCC and DDR/DDR_QOS is hosted on the CPU Control
Processor (CPUCP). Enable the nodes required to get QCOM SCMI Generic
Extension protocol to probe on Glymur and Mahua SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index f23cf81ddb77..6409350ad9d7 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -349,6 +349,21 @@ scm: scm {
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
+		cpucp_scmi {
+			compatible = "arm,scmi";
+			mboxes = <&cpucp_mbox 0>, <&cpucp_mbox 2>;
+
+			mbox-names = "tx", "rx";
+			shmem = <&cpucp_scp_lpri0>, <&cpucp_scp_lpri1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_vendor: protocol@80 {
+				reg = <0x80>;
+			};
+		};
+
 		scmi {
 			compatible = "arm,scmi";
 			mboxes = <&pdp0_mbox 0>, <&pdp0_mbox 1>;
@@ -5675,6 +5690,13 @@ pdp0_mbox: mailbox@17610000 {
 			#mbox-cells = <1>;
 		};
 
+		cpucp_mbox: mailbox@17620000 {
+			compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
+			reg = <0 0x17620000 0 0x8000>, <0 0x18830000 0 0x8000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		timer@17810000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17810000 0x0 0x1000>;
@@ -5859,6 +5881,26 @@ rpmhpd_opp_turbo_l1: opp-416 {
 			};
 		};
 
+		cpucp_sram: sram@18b4e000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x18b4e000 0x0 0x400>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x0 0x0 0x18b4e000 0x400>;
+
+			cpucp_scp_lpri0: scp-sram-section@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x200>;
+			};
+
+			cpucp_scp_lpri1: scp-sram-section@200 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x200 0x200>;
+			};
+		};
+
 		nsi_noc: interconnect@1d600000 {
 			compatible = "qcom,glymur-nsinoc";
 			reg = <0x0 0x1d600000 0x0 0x14080>;
-- 
2.34.1

