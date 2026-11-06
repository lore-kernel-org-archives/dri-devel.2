Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88B606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A2A10E626;
	Sat,  7 Nov 2026 14:27:40 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023116.outbound.protection.outlook.com [52.101.127.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6747610E3B7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 10:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg7WxZAVIG1ZL+P2VnC39JWNz1lBPbXmy0fpNG2rGmTu73TRz9+FWeMf6WgiaiI2JtMVBfUSAE4bkqHaZTBR5/7tAHJKbUCVDofYbAfkQ7oC4ENKBVUMGn+2JnERLabOts78LjB3B0iofUtfYLZnFBH+Uwbzkvb1MJRsFjSZX++uvHgTTZ3UGLhNrSglQnA6cNZuwA8uBtkA0bRRdXlVUhpnPxvx1flwRUY5gHo+JBFPnawOn0hTf+Zx8lUqb2d262v0qwBvFGfjRFhzZg5fQv9tOj/uS6wx+EzxVfRBd1rXzYQ0xZa0rIeY3nhiyC5lU3rvkwRwyDmqdQ2UWlpamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGHjZZb01s//+FHZsg85wITdJCCurRihxWUJSHBj4ag=;
 b=LnQJjSg57qwNBZU2E11tRDfJelnGxDwa6LR8vrUWIDfEGXJkUd+AaoHhklK3dR/uFOhhk/2zhADFTXERjFDaycqpaIRcQuL5PNSupqDE4EzCABJhnWR45kl6L96rQ7ZX6wNIwuxNq2N+PNGacHReXaa5aLfNjEaY6bdOQn0+QINGiJqWbmk69ZgcN/VEqBHAmsSit9OxOxwEn2nS4SyYdEdvj1K2bGbdZDdLcH03BjGUeON+i3qGDmZnvcwuaTs5DaIxjLOLml7TKtjQ1P46CDKhlTFGyLJao1EtugeM0yFFJxRt2F8U5duRL1LwL1vG/2AlrjX3P+nC/Q5SecjoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:4:186::22)
 by SEZPR06MB8951.apcprd06.prod.outlook.com (2603:1096:101:33b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 10:47:38 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::27) by SI2PR06CA0016.outlook.office365.com
 (2603:1096:4:186::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 10:47:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 10:47:37 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C6C3D4102E6C;
 Fri,  6 Nov 2026 18:47:35 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com
Cc: daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH 3/3] arm64: dts: cix: Add GPU support for Sky1 Orion O6
Date: Fri,  6 Nov 2026 18:47:35 +0800
Message-ID: <20261106104735.1651267-4-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106104735.1651267-1-cunyuan.liu@cixtech.com>
References: <20261106104735.1651267-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|SEZPR06MB8951:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a30b3b41-6682-4983-4254-08df3bf35f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|261009223027099003|261028144727099003|261026121527099003|261102123227099003|261022105027099003|56012099006|261026140227099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OZLxn711cP+GHtaMSQtN/X5uZFd0561llgSbtTD/dlJM4bma6/4iipnvRRGu8iREw9kxJ1xXZLdxGPmQ9R/1eb0kq7TFgWrvjzX7BWR58T1nMjh7x/LWd1rLPl/WOFpi9z+4BeQLWcEuCx9H01fn3iYqXD6XyVsaH2RN5RzlAHM5XZ2mH07UJTju+kDqb9jzFJCbN+MaYv7UsiYlUGm9wXTS4rxn6HO6bvjPbH7D6km3YBNq8H+tzMS0JtvRvjAmUxROpoe+N61kDOo9GkQEkvxruElX1OhxVeAzfx7HbsNqZw7MgBuw3gzL9uqF4/ERBExGOB3sdr4+SXltDnuuETr1g2qZmSGNXzpW5Xrs5+RTw2jnti6tXxUsQxyirxXLfYC8hWJEziYHxf9oqCHGw4iLVVzZaM36LH12j2q80WI4mXFRH6tDkrX83uUvNKBKSVHwUvDoep1ZQK7JbgGPmOUAeVBS3wpmXZqNFuPqPO2Aq4CPCsZLO71Ucm0To/qJD3iJhmTqCrKS64X5qLUAMiFG4orKGs7cxtswIWuGVIvPnmIXYr8yC0RSMsw1Tj8Jni7KzWl0cS1bUne0coGB1i1jnStRIu0IOWMuv2YfEDnZAUqPZRD4eXXyu8mxTikumHzY0LmtY0zMs3OrY1L20Zop5eUQp8dFsASnJdnYs7jqMx+o2fllgj7AuljbVZZEi0wuPN8ZAtwQPfAID8NMlQ==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(261009223027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xq18TsqlHWzOsPf+mvWxPwSYrjSQauy1CCxHEA86e03tXoyHIxZ37KXhvbAJvIrKmLm4E3PuYmPiS8V47NaPvC/g0+v0V8160ndkQy2zpmNzKNePZTBMQXJt9HjPRlo+EqNwmkFdnzSo9xKeTLhQbIsSY0snZIxmnsRMYWx3u4Ntfls9Fk8Rc4Wi36UMLQaCjA6yCyQqYnKOcXH77eXHM9IXE3Bue65kQ18No011wdWxgX14UREildiCz5Sns5zcsmEJvMHRqooh7ugt9hrWJXc0ckMWcFrubQ8nDHA5aG1onNjf/Wf51LVVHkeVuuW7EJaYz2ICodVRFJjbET1s4kffUzDGG6Isb+yiV+SNLpgS2yxnC4Mbv/hj1wr6ycaarqTWotGh1p//OaOUFF+JDEWGnJqZDip99a1qTy+HQbEusHxKcdKNciS5ejMQ27D0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:47:37.0260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30b3b41-6682-4983-4254-08df3bf35f4e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8951
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
external reset and GPU power domain.

Keep the node disabled in the SoC file and enable it on Orion O6.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  4 ++++
 arch/arm64/boot/dts/cix/sky1.dtsi         | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

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
index 0a820f45feb9..d5d347964ad7 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -762,6 +762,22 @@ ppi_partition1: interrupt-partition-1 {
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
+
+			status = "disabled";
+		};
+
 		s5_syscon: syscon@16000000 {
 			compatible = "cix,sky1-s5-system-control", "syscon";
 			reg = <0x0 0x16000000 0x0 0x1000>;
-- 
2.53.0

