Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5E60A2600
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563E81123A5;
	Thu, 19 Nov 2026 12:39:18 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023095.outbound.protection.outlook.com
 [40.107.44.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F555112388
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPobHPs0Kb2LciKdDJv41X6CGN8gSNvtulsSem+8fc84OQTnxx7iVYrQiKXELTFeo3wPFGUUrEL8AgI0OUApHVw7QEvSHLFnAJEMO5t7Nk/LWeuoT+A3us/6YUnG/PHiUIpez8t4GLr4t0026gB+Yo9Qkfo1LPXyhBeIXFs+JTUhKzHzLQn8c+lYLz39T0JR4FHl+QfG4l6ZQnfAeh6VCAjq0LNerhkhU1JoI+7sRXCRd1VqOl3ZBamb4uEZyMKXIOKf5YoUIlJvdxsPQ4k+yHjwAodYlDwoIDo16CPC3farq+KJTboxFZfcvxUVqREEWp1cGU2aTcpNkA4TVvUlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqrwFeQM8P4JkzpPCvong2DI1GofgSiU02iQSsNaOWQ=;
 b=SMsfNnXGOu8j3ydtFyKKZNWsvtROej3Y2+XywFpAB/AW444Kh9UDaUkMitDmJMbac/IsQBN61iGucgnhL6d/fRJYhfQK+eGkAOIKtRrbWbOQ2yMa/sgNou1BAdN6szJcvFucM1TanX28rXmliznM1eSa1DhyUNQ+fQWNtbVQq0d0PsOHFFP7pB5mhHYCUAl99JgH3Eiolqlno5uxJbxwF/O4p4ukwdxvdB8sYigbSjT1A8ONFOjzgAnpQdIfYAhOv+cCLMX+eD+9A3ub9Mat9e90cOCdB9yrx19z/8EMLOctrNtESClCkF9EvgM188kJt2INJxOnrg3JZJFItrof3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0018.apcprd06.prod.outlook.com (2603:1096:4:186::8) by
 SE2PPF06C2A6398.apcprd06.prod.outlook.com (2603:1096:108:1::7c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 12:38:54 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::ac) by SI2PR06CA0018.outlook.office365.com
 (2603:1096:4:186::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 12:38:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 12:38:53 +0000
Received: from cix (unknown [172.16.66.176])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 659AA40920E9;
 Thu, 19 Nov 2026 20:38:51 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 daniel@fooishbar.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v3 7/7] arm64: dts: cix: Add GPU support for Sky1 Orion O6
Date: Thu, 19 Nov 2026 20:38:50 +0800
Message-ID: <20261119123850.2994625-8-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SE2PPF06C2A6398:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bc681b5f-7893-4827-dc0f-08df463a121a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|82310400026|376014|23010399003|22082099003|18002099003|261009223027099003|921020|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: B37yEHMqwvkPv8+BONZKYdm6oIMmBtCElmnSPouGplD616S2vpDzyt+wN5XVutmM5gjYyQ1uRvsqE8sgEZpi2N5ErIKYclfkHYYP9pF9fFoH2It9gNpxiQWe/04y9QvsvKQshBqyK2yQYIbGOcOLsPGO6WaLQ5prxIEOyo3bM/hxM0JjOOFtSJje9ZrvF/QZYk4pPd6PBk5lpj8jaKAOL04A5zr6GZrV/doU5i1bkQD5Dw8d7r8zfKYF4upWeavWoutYX+VzjVO4iIKNQC9B5A0sQnJ6kq0lBUquw8lcuDAaNtYoIMsREwDiq764/pV6lKa7gC4bo+VVyD42s0bS+vtR+ZBizDLvAi64aVfbTkCbKqLvGmK5Eq+B+S7JU0Ktoy2eex5sM7AIlxdfsHEPdyTHFz/c7K/1WYG/y76TDmsY3ZGwA50RbF6QJw8wz/+VEmdLEzPlV2cwCEtHLqqYqKIS5oBbZXRJiYtuNe44c5LJ4gNqYYpUt7KYZAkhEN8q1Zkl1RfkisrO5MDrz6uIlt5Br1ecBg/e9U02Vk+1ldRZ5kLB1B1mdXqZtoPvlymw03ykaLxTGFuEidmUs2HBwfRFGGpPtkC5IuPPyjiYNwq4oavp/awc9L8vlRM2md7vlSn8ghIZr6Bx5JoplrsIM61rpIpS6T/5/gt4mTKcjx/Fns4S7TYYEZRC5yuSR63p0KmvY/Z1Dvc8rKdtAzWaZO3N4jqfTsaS3DiSBvFLWGdt/VINrwgEUvsilHGM4RVe
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(921020)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CDQGrKvGFkSv46OF05dTwTpVuSKq1KhBjqlx3HMkUIVw2R8J1lHqfGkiZYPfOEb7tumO/0SniYU3Si6ksbg5KSlZ6sMP64+TlktasINmbbdX/F36uyoplhO0XyJMjtiIeVhBmysAjPB+xQ9YY611QpZvml6aHw++r8VSZsLpdolC6xYW0vxRI9XuwQlkHr1qRUho4JIuP1YjAdbK4ZFVpy875SlPlYg6wG2NmEiVlGKhj9tarvdoMYBW6Nj5/NlJ3ew3J88o1Sx5sMnB4/AWEcT+lrJmauCraab61ZiIUVtlMeK24F2GPMYHEgKzCm2p0Ri4bn3ZYIjp6IUVw6CSv/j95JDRtW3tZIvsETIGmHaWtoEWe5YmyYqYR6Mq7Cxoodc2mXWO/r5b3TJK38k7TUNFM6CrpzJ94jMqompyhClIeGC6Zl9ciLapLe7Ulb3f
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:38:53.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc681b5f-7893-4827-dc0f-08df463a121a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF06C2A6398
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the Sky1 Mali GPU node with its registers, interrupts, clocks,
external reset and GPU power domain. Describe its system-cache allocation
policies using separate read and write values for each source.

Keep the node disabled in the SoC file and enable it on Orion O6.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  4 ++++
 arch/arm64/boot/dts/cix/sky1.dtsi         | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
index e39c87774c12..853c9c6f202c 100644
--- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -52,6 +52,10 @@ &fch_gpio3 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 0a820f45feb9..969725993fcb 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -762,6 +762,25 @@ ppi_partition1: interrupt-partition-1 {
 			};
 		};
 
+		gpu: gpu@15010000 {
+			compatible = "cix,sky1-mali", "arm,mali-valhall-csf";
+			reg = <0x0 0x15010000 0x0 0x480000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&scmi_clk CLK_TREE_GPU_CLK_CORE>,
+				 <&scmi_clk CLK_TREE_GPU_CLK_STACKS>;
+			clock-names = "core", "stacks";
+			resets = <&s5_syscon SKY1_GPU_RESET_N>;
+			power-domains = <&smc_devpd SKY1_PD_GPU>;
+			arm,sysc-alloc = <2 3 2>, <4 3 0>, <16 2 2>,
+					 <17 2 3>, <18 2 5>, <21 2 3>,
+					 <22 0 5>, <24 2 0>, <28 2 3>;
+
+			status = "disabled";
+		};
+
 		s5_syscon: syscon@16000000 {
 			compatible = "cix,sky1-s5-system-control", "syscon";
 			reg = <0x0 0x16000000 0x0 0x1000>;
-- 
2.53.0

