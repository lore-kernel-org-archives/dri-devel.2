Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03E2FE5209
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2756210F501;
	Fri, 24 Apr 2026 11:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ije5VfyJ";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013070.outbound.protection.outlook.com
 [52.101.83.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF2B10F4ED
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmOCdYUllM7Z5TDKCJKzoUokCTICtq3+BiuN38UNMuWn/sALm1m1IGjDV8+u8sQhKbZ/z5+/KRSPAjB2Fp9wS7jjlEdQiTqAvBBDN4B4/cAGLBSxd0C4bS5lA8raciouXsDh72xZQWQDQGrbvVNiIojuGoXS2S1nOUk8V9bLaHLWzMzccfxsyzdEm+L0yc8PqmVpXJE7tAAVkFz/ol9IC40qfCouGXMvH+qKZs780bC+U+l7pRyIINthzxDAKj6urWkP1qtiwNWB7OTUsTHvoptshSHvaeGi0MglvlvewE4po62tbKE9BkDbbwypRBuvBCVoe2GvY6OscBZmCgbRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2vSocGC/hybskgzPa1keuT24d8Lx/KtlYAD8u/Y/uU=;
 b=RUotElsTRGBFBuQgYJRiZRPFvQ7SwfW0bXww+rTqEac32SRoHNQNItkD9zqeP+h00H8I3cs8ADxmP6jDg+tr0pc+HJdVV9pCDy8Ws+dqfK57tHIGgEedKUQZJNQ2PNT0pty979rpINl2cKd3x5LHEgyXSMDLj2xgXYA/6yZQz/6SjR378i4YjPLafQWh4MfcM68arnS8lLtE2P/4f9uMD+OkikPMOJVrJwRkf3O/wsmvcogM2SfvKiKV1lGDefXRgdLEzrWCAMhrsgaWeO68CbWfNzApa1LDXoL3DfTkK2pd4sshuoetQCZGDT/DKeBwV+oL0HEzm/SobtUeWuHztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2vSocGC/hybskgzPa1keuT24d8Lx/KtlYAD8u/Y/uU=;
 b=ije5VfyJTnlZepvCHRwOG7bF4P70ELD0ouWrbnNkmcIqleFNVZXPTJUC5eia3oTJpSH+SGP9wv0wMOmE4cG3PUZ2yxPkE+D8Vpc/3yqhDgDR+BxmpWer4zeOVZkplgrkcfGNgJNiddR0pCKRzHWQ9oL+mHeI7lVwL45PlMIfnblzJiNHf8MtM9p5buFUpz2cuHRpubnxhTbHngmLwWGK95K/SPZFDltFqR0ezBWafcZgykbL/SViUpBKKYAZOlASeUrvcgLX57ASNl6pEGuy76ffyohUoFYchxvOEbqClADQigxxOT85+cjkLVsAeFuVOgDydotzuFI7LcTdMHRn3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:08:14 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 11:08:14 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v22 7/8] arm64: dts: imx8mq: Add DCSS + HDMI/DP display
 pipeline
Date: Fri, 24 Apr 2026 11:07:20 +0000
Message-ID: <20260424-dcss-hdmi-upstreaming-v22-7-30a28f89298d@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::11) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 187f8a6c-bcb3-4368-1063-08dea1f1c7bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|19092799006|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: wPA3jVmW1RFwjOJLyTkqUm7Yoyxkc+NlwuwPYyGM9exR4BiFHRbHAFj4ERS6MjdDoWtJ0jp4gz4hEUpwGQHIz1oHZwKyrSIDMJAh9uqSnH/ZU9SX/fMeLmYBN4MCIkIajCR9A5T3CTVfIEzjQ5cuELQmz2KUr3CQmhWZz5tw71nbGWmx73EoChH6ZLuzHuP9PHSwqYrl85ekB59fdsg3c033r/yBwLMTw+wqUItbxC7nPiII5urLGHzdVUtJbgnQdg6E2ruyWqQd8tc9HKrt/+FR+Pl7DDHdxrb5MgEZADWa1olBSO/oRexk9lGXrk48qSZRVd2XhLngA3ZvJ+t1U0sQ0t7u6kzv6S3T+2gqMSBLILe/sgmEbkfqrNa6cehG4M0lPXM4f1U9Hn7+a70nBjXXDLaI+htqIRtQCCJIBzkA+Pi9ySMnEH6cJJGrK7e2qeQYFxwe2qTkqo26GGbAmwiHuiLdzm0rIqQ3nrzu9lRgxRUmH2Q3GMqKEW7bqy1e+YwcS1lZ8OagHfNJCzhYQ/Nd4nj15O+jaXwI3acPfbKuXuXPjIUFIMoazhw1VTNPmY2jM2O+XKmdrHbi9ewpJWs9Y8oBmz5jNP1IsA7baFLL+LIW7LleeF+aN9yfdVrFVHqNWq6qrJghletKFyOrwu5lhnR70+4/mtY0BJsYavovp4HtYVUE1KOoLIgkPEDHHwStxN6DJ3/p5PWwcp1wPKFEW7BJy5QNsccLGF/acCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhYR09JYmJucVRvcisza2oyOEJBd0orK080ZEoxcDNabHhZSTYyNFd3c0ZX?=
 =?utf-8?B?N1ArNzIySjMwMFFtOEhQSFl2eU1ySG1xRG5vYzB1MDZsLzVKWG04anFQUXNp?=
 =?utf-8?B?OVI5N0x5ZjBSQmREL0pHcHlGbHowYmgzcUt6cWk1UDk0czVTYVlxT0Erc0w3?=
 =?utf-8?B?QldZRFlMZVpwMG9mcEo5VkdZQlRybllFcG1GYzVFUGRBajNTTERuTU9YQVpj?=
 =?utf-8?B?OS9uRk8zWDUzQkNHT01DZFdWd2FUNUhGN3dCU2QzSkp0N3U1dkFLOXp6VGFV?=
 =?utf-8?B?SXU5LzBZRmJWQVlFRFBXTlUyZ2VVSFVGZ01xSWJiVWlrK3ZobThZZERteFg5?=
 =?utf-8?B?TStvbncwbm5WY0JYVnNEemNSOWhJRW12d2JnZXlQa2t3TGdNMVhRS2ZndldI?=
 =?utf-8?B?UEhpMFhxSFFzL1QyQmJZVmtPZ2VEOXNLcTZ2VFVCVUNHSkF6YnY4amdudERX?=
 =?utf-8?B?Q2pCU2l4UEk5KzFuRGhZSllFWi9hUlBXOFg1VFJpUU9uaGRkQVBBWXF0NU50?=
 =?utf-8?B?eEtHdkNpd2NWQnhHNXh4Q2FvQk0wN3RXd09CVVIyckQvc3B2bVdEMEJFbDdz?=
 =?utf-8?B?SWZNYk1PK25hZDdzZ0dSQitHdTZKTnZNTU9OR3F5Z2x0UDZWMWg0VkRmblh2?=
 =?utf-8?B?MCtTcmpVUGY0VUQzSTA1b0VNNXZLTFcyem1WMlQyRjh3aUNBbHVHU2xMRTRi?=
 =?utf-8?B?S3Zyd0NHWnhQZUp2aXhENkdkdmNELzVWeURnd0kzRCs3aHA1L3J1SXVYVXZk?=
 =?utf-8?B?cTN6aDd5bEsyU3drWXZSVlFuWExnMGlDK2xKZjNiZzFaT3hMUnZFOGlLcURI?=
 =?utf-8?B?MGo3cURTMTg5WVM4Ujh6QTFGeEMvK2ZUY3ZMNWdZekNQVUlveWJDWTA2S09V?=
 =?utf-8?B?QVFoWjdvN3dXQURnOEdGeUVlWStKcTlqQ3duTEk2M0ZDeEoxdmMzb2JBcmpZ?=
 =?utf-8?B?NEhKcnJNc2hZWk05WXZFeGt5QVJvR1l2ZmwxSTBsUlozNUJ3MFVuZE5HQWFP?=
 =?utf-8?B?MjBUd2tiLzhqV2RwTzdSTXo3cm0vN1JPQ1h1VnZoNkhBNDhINVlWQjY3Nitm?=
 =?utf-8?B?ejVOWUNHYnVUNGRGZDRmUHhWTlRMc0NOQ1JCTmFUcU9GM3BBbVZVaFhJOVZ4?=
 =?utf-8?B?MDhzZjlWYmFDSDNJd3NrR2lZbi90SW9KUlF2R2tSSVVvQU45NUhQZVUrWU5v?=
 =?utf-8?B?aGtuUUZENWlDT0FKRHZDWXJuOXQ2Yi96Yzh2Q1NzWHRoVmN1TXZyNmtjNHo0?=
 =?utf-8?B?aGVZaDdIL3NITDlUNHFsN0Z4T0IyOVgwemQxdk13dGkvbTRKSU41dXFiRzJt?=
 =?utf-8?B?R1pZYmVVQ29wVE15VWVrWlp3amR5NHRMb2YxTVhhUXRKbnNTak81T2xUOGsv?=
 =?utf-8?B?eEdiVXkxL1k4cFBFRnRxQlBZSGhreEg4OVBTTlJiYlRZMmV3Q0tpcHo3SWZa?=
 =?utf-8?B?V3R2dnNoRURhMXhVZTlqQkR3UkhDQnY1TXA5NmJsYU1NSVh1RE9BeUVMSE0y?=
 =?utf-8?B?bHBIbkZ3enJxY2ZZMXplMEpHSDdJbnA4eVkzdkV4RC9qZ25md2dNcHFiWTB4?=
 =?utf-8?B?K25wOW9YNUlwNGVyUElVZTFCVG1yQTlQVmdqMVIraHVJQ2RVVDltdjUzTmFW?=
 =?utf-8?B?WFlEQk1vcVJGM25oTWxORklkVXRlWE11b1VWZU8xWjN1WUg1dGdJMC9XZjIw?=
 =?utf-8?B?SGRSMVMzWTE1eDJGRUtDNEt5cUtZWWQwTXNLWWxNVTRvOUt2b1dWY1A1ZzV6?=
 =?utf-8?B?TnNvS09LSEowczdjeVRwT2ZYcWp1SWZ1N2UvMEJOVUtoUDRZUWdIMXJVOWJK?=
 =?utf-8?B?Y3lBdGVyTVI4N0tkTE5nMWEvZ3JqQ2tIUjgyWGlDTWZyZkZmWGZ0R0tpUjlG?=
 =?utf-8?B?SXgwMkNOcEIwakZNNytheXZyTjRFenplTTNkNTR6T1JiczNWczA0NVRPYWJz?=
 =?utf-8?B?TThLaDdlaVVwNlliY3FvY0pSdWJTd29yWW9wci9OQU9uQVpYOThoRDVJMlQw?=
 =?utf-8?B?aHZySHVnakNKWHlYTkhkZlhWamN1bHNNZXdVM25ITW11SWlHQ0dFR2hNekg3?=
 =?utf-8?B?QlE1ZVgzQ01hMHJmTmhDcVFmY29ZdC9Xb3RpL24zaUlpZHN0TnRZZExxWEhN?=
 =?utf-8?B?Ylk4SVJLclZFNzJwcnEzTzM5OWUwd21DVDVRWXJCSDZqZjVGLzQ1RC9ELzZo?=
 =?utf-8?B?Z3pYV0NyMll0MC92dVdwR1hiOUtFeTVVTmFaczA1K3lNekN6YkxFbWtaak1s?=
 =?utf-8?B?L2F4WHJaRXpwTnZnT1ZKOXZJeS9pRnJuWC91d1FSc3hFdS9FUjNVUEtrTUpM?=
 =?utf-8?B?dUFTbEpYLzNSZ1Jzc3dCVG1veHR6Uzh1R3FLQUFqeXMrUTZnTXdmL0x3UjlG?=
 =?utf-8?Q?tK+n77NE5C/Tv6Y0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187f8a6c-bcb3-4368-1063-08dea1f1c7bf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:08:14.5473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAG9E7VRT9UKEaQMcYugEMfrQoofuaPFqAj8TK/J79fS/xhp/Lff/WdE01FQ1Z5YEJhCDKMJmpuScJI7vBkpfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

This adds DCSS + MHDP + MHDP PHY nodes. PHY mode (DP/HDMI) is selected
by the connector type connected to mhdp port@1 endpoint.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 67 +++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6a25e219832ce..0c2f8b19483a0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1598,6 +1598,73 @@ aips4: bus@32c00000 { /* AIPS4 */
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			mhdp: bridge@32c00000 {
+				compatible = "fsl,imx8mq-mhdp8501";
+				reg = <0x32c00000 0x100000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "plug_in", "plug_out";
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+				phys = <&mhdp_phy>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mhdp_in: endpoint {
+							remote-endpoint = <&dcss_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mhdp_out: endpoint {
+						};
+					};
+				};
+
+				mhdp_phy: phy {
+					compatible = "fsl,imx8mq-hdptx-phy";
+					#phy-cells = <0>;
+					clocks = <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+					clock-names = "ref", "apb";
+				};
+			};
+
+			dcss: display-controller@32e00000 {
+				compatible = "nxp,imx8mq-dcss";
+				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
+				interrupt-parent = <&irqsteer>;
+				interrupts = <6>, <8>, <9>;
+				interrupt-names = "ctxld", "ctxld_kick", "vblank";
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
+					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
+					 <&clk IMX8MQ_CLK_DISP_DTRC>;
+				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
+				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
+						  <&clk IMX8MQ_CLK_DISP_RTRM>,
+						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_CLK_27M>;
+				assigned-clock-rates = <800000000>,
+						       <400000000>;
+				status = "disabled";
+
+				port {
+					dcss_out: endpoint {
+						remote-endpoint = <&mhdp_in>;
+					};
+				};
+			};
+
 			irqsteer: interrupt-controller@32e2d000 {
 				compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
 				reg = <0x32e2d000 0x1000>;

-- 
2.51.0
