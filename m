Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD9AC98328
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A7210FB9E;
	Fri, 25 Sep 2026 16:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E2GRROcB";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C9A10FB9E
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEjJTLHHKvMHNHPJt4561+/h1UrWM46mNI1FE4yI3Cuo745TORVVPyXegMzSUZOX/hpUUeA460aIa9s+pkpFGUp2M8BWZzwnwp8UyuReZJsc+mc8eU/shkVQ4ndOZMXaUN+9HRQ2hQd8hf1gbVabYbLRuY7gdXel/xruDm/d9KyyJzHESBAWM3mKmzphR8Fam49WoDFyZtuA1UqZXNnzAy/sh2xHqO4FJ+IF4BeVcnfkwfQGXKKb1klT15puEavFV13Hl8vMVPfOLbpYp87tLkra+M4oA5lzcT4wT+VndEnypGA37908X/+dMsVBVXd2oIy4Tm04MRWz4yWJdjxVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BNP9e87pjjr23uhWekkdrXcY1lrB9QeyTAM7TH2iMg=;
 b=GtugMyFeNdE2LOWdoARDeEcecqj5aA6rpukrD0/e6NDhvixi9TEyhGPedq33Le+oA41F/iHguraB0CXbGezcITvEpBJjb9tOY/g22WocXfXHRVD4S3ZV2qbdBnu2h3Z58CYrT2kBUwPHyxT0xqXLc1dsVrOJDee6CcOB8Jl9VUfCdb4fiS7wIbTQE3qEzH0WBipvN3iFyzvg3B9HjLpcnvwME4FCCi0jOYDdfQLgydUD6gPb4hrViGsP4lxMQYlVXRzTpv3sDwuUadyGni7g3fFSU9Gmb5ZY1+JtsMCMeRYnFBxcukR74cC4ejEcvRUya+eXJYIljX+by0MOmDZt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BNP9e87pjjr23uhWekkdrXcY1lrB9QeyTAM7TH2iMg=;
 b=E2GRROcBwM5KGWshsa6j3zCVfif6t98WUtpsf638yrXQXG+CBIBWGbVGpmc54wXPwRKE+SLKn8ZbKl8sgm66vfIW0uejZQaJUJQEsj79jqJPVDVH48/GLrPBaksAv8vKeLi8HonXH7cWd0s6XiFN1g1njwgowvAM5KyGQ18PN7ym1VJKIQB/m4D0Es+wTO75G0czacLnPKcoDwGFc2mk3pfdoFG/2CUhq4oUpNm2AFKGtF+9Jyywr1x55QgbPx94o2ATAFR+zCxS1BbdrjxoHWfWzFObdKa2GnqyrNtx45mmnkVwaQz4hI0e/873Y0bjZwz0vSyvcAt5vd+fELWTUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:38 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:57 -0400
Subject: [PATCH 8/8] arm64: dts: imx952: rename soc to soc@0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-8-f999fafbca60@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
In-Reply-To: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=752;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0/xyeMglEL8vXEB0WKpgwxwMkvVgesJ37IBdd4/F7s0=;
 b=ruJCivxdx0GBbpfg681G65wP2HvVWCOqlDLQg8qzskQrvDdvjDIoZc7+3DrZHAATAeq12IAXz
 qYY2AxWjG3SCNNIveWOASkjpNqF/0WJ/MeJ7WKyxleeZLG5I7DWHH6U
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CYZPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:930:a1::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efa28c7-1db3-43e5-077a-08df1b23733e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|260925021311599003|260925021911599003|921020|10067099003|22082099003|56012099006|11063799006|18002099003|260925022911599003;
X-Microsoft-Antispam-Message-Info: ecBTyx2OoGskpZXH4W6HxRVmrotofshB4MIzPGRNyb1GwXJn+kIJhdzhlPOGmPNKvbn6zqUazU7DqrarAx18qAXa0kJ+UYwLQMcfeTYLRmb3zeSPleTmh+KXmHuw0EvHQnIEPpT6j6dhl6h8eL+3kCc/c/haBtHhqa627gQZxXIydC6jPG+lgA+dO2/bN++0avWldrdsrO+Lb3fYQzKNbGR6O3uZpRY6GlSXPoKE4LboCrMvVEGgJCYf1ax5XXW+sFlWQVpZCcn903GdhJGs9kueyKAyJbDJVOfCEUKkHVEeycMQpTbQGNqNbDZoY/ptQhLxvfAfbI7seTTMZ6HfoWlrvEe6lQOBVeVz3AL5pM64c719mXJMfiqLNq8RRDfs1sZPdDsvK5FEBqEoRmN+rgj6FsiJpdTZMuL1JrI/R7E2NxioQAJe/3EGe79wRBSW5gwns+Ga65y0wX6Gp3Sh0ua7J9G4InybQMLBC1k2XoO89A3ms7BrooHHREB1IZyWmu3fAH9Rr8HAMEqwYVFJzZ7qBg1k0ia/REdI0yeKPhgwrJClIXG0CzSlpBiIpWCxp0UePIfIeHxICKMhxWJXcCU7xtkn5a7TtuREiH8wzSrWdxC1UJ2ommJeRQoDlsp+Mr6GVA7amDPWa5zL80SHVjcYaRFZdo/oMxRG8o+VR98CigRVwUwVxxy2TBOyxO0DX4g2Nj8qZ3Wm4xjIIAK1jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(260925021311599003)(260925021911599003)(921020)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXhsMGtFYm93eFI2MnVCRDBGRjMvT05pMHRlTFhQQXVnNDlXSG1KdVhEQ29Q?=
 =?utf-8?B?VE52WWxUVW5vUVRYc2FsQmloOG1hdFRqaGYzWDFjSUNPdDQ2TC9TVjUxVWdL?=
 =?utf-8?B?Qlp4dmxrQ2Rzcyt5cmo1d3dnQ0tBTkltRSthRTZ5RG4xRlh3cGpLU1RaQ0pa?=
 =?utf-8?B?WEhTbVNsRVlhYk1udzd5TVVUc0k2a2NZT3RlcCtISFhwekRjRG1YZUZBTnlr?=
 =?utf-8?B?Z3prdTFKcnAyTDNQTlB4SDMzZ0Z2YWk3L0pmMjBNT3VXalJKM1kwVEpTYWdw?=
 =?utf-8?B?U05HQldGd1JPVnlnbjBLSGFiZlhDQVY5MkcxZlgrY0tCWklVUlIrK1BnakZj?=
 =?utf-8?B?cmdXNHYxQ0p3NXVDclZVS0Q3dWx1NHRYbExuMEtuajJKVmExeUo5V2tmTEpj?=
 =?utf-8?B?TFl4L0tmS0VFVFB1ZUxhRXJVSjBjangwNTJ5VHFUSUVzU2FpbXpTM3hJQ1Rx?=
 =?utf-8?B?a0FVZk1hTTlsUUZIMURpalFhKzc3dFpuU3NxQnF6b1hQdTVqeVBTd0hMM3R4?=
 =?utf-8?B?RDBIQk0yaSs4a3hjV2xBRVBtakxpaldKY0Q2NzBoUmwwME56dlZRc1hkY3lI?=
 =?utf-8?B?NktZWjEyaUZUbEdwOFBwNkh1UFlzUGJyRm5aMXNITGlnNmRQVDNrK2ZTMlhy?=
 =?utf-8?B?TnBGN2FkV003R3JCMlpxSm9Bb1l6MmtZZW1jTGsrSXBLZWVNVStEeWdTaHpL?=
 =?utf-8?B?QmtsbVNjQk5HQ3doRHE1ZWQvUlhndFNnbWR1QTFPTVBJd2dSTnRYOUt3Nzk0?=
 =?utf-8?B?NHZjVUtaZEZycWcwYmIzalZEOGpiQ29jMUxrQ0l6YXdEYlVqU2xwcEdtRlNV?=
 =?utf-8?B?SjdnSW9hR0xjWi9YdmY5UFNmbEdCWTZ1c01vQTkyRTM5L2pPY0swd1RlTlZZ?=
 =?utf-8?B?a1F3NCthQWt2b1UwV1hUSlMzVVBtUVZHdDVjUGlhM3Qzamw3SXlnRXd4a1I2?=
 =?utf-8?B?cnBpRlFKU2hoaWxxYThrT3NoTnZnOVM1UTVQWUtUTGN1QkxadmlZM3FLTkFq?=
 =?utf-8?B?YUJMdmdPR0crYWFSRVREdU04ZkErUWlEM25JTlpOZ0dqQWo5SS90cHhTbVBm?=
 =?utf-8?B?V2RVa1hIZG1hRElyR1hJZHJKWmQwSlNpTzN0bjBNSlFTenp2MnR4U2xWMGRz?=
 =?utf-8?B?SVdxYTdHOHEvTitoa1RhaHlyZU5TdFpTaGdoSUdOM1RDLzRocDNLMTQ4TG9Z?=
 =?utf-8?B?bmF3Nm11QW84a01rRmFCdkNsTk1TK3dHUUpBM0NubDFjM0UvUzhZRkhQNGRa?=
 =?utf-8?B?N1prNE5uQWNNNktNalBjRE84QnVYMkN5bTdhSGJLekFWbzFNNzZjdkloRXBF?=
 =?utf-8?B?eEpURzFJNE9ZS2dlemxaanhQSVhKcHlJNEFqN201ODdNTk43M0k4NmdDdW95?=
 =?utf-8?B?eTBUSndYZEt3N3VGcExYNUhScGljU0JYcVdBUTY2b0ZYZnJ0aWFFay9GZGhC?=
 =?utf-8?B?cVQ4Y2wxZkxkUzlDZVBxY0NpdmZNQ1lwak1oSUZVNG5aMWNWMXpYL1djL2k3?=
 =?utf-8?B?TjN5UEU2TGVxVjVTSGxhbTNxMUhjZ0ZJN2NYN0JMYi8rVzhNTk02UHpNbE84?=
 =?utf-8?B?em4zQ0NNYlBtclowblZpbVJ6WWlOYk5lOU1hT3FYR1RHRE0wanRBaTQyUXVB?=
 =?utf-8?B?Y0Q0NXRIU0w5blM5cU1ZMVVPa1hNcVpRdTBtdExsUEw1UXJYNjFGaEI4VWlB?=
 =?utf-8?B?Wkx3K0EvWmhEaHNOTHRFYTVxcWh0MHFUQkErTkJCYkVGajNnWE9haWxLMGJO?=
 =?utf-8?B?Q1JUVm0xYWRERzBhOUw3ZjYwWU1MS0dyZnRyeGs0bkNaOVoyaWpqMTBSSnhy?=
 =?utf-8?B?c0lmbkNWWVo3Qk5xL0NCVlpCczBoOHl3eUUwUUlDM3NQSmg5S2hrSVAyaDJS?=
 =?utf-8?B?VGVvcVYrYzNTWFNHbTFtK0Via3lxQ0xSSVBKbEdwbGVnSWlrNjA2bEVsUDZ1?=
 =?utf-8?B?QlpvbmRNTzhHN0JLVXNIVk5ONmJobE1reHVWM1VqakhhSnd2dmVudGExekg1?=
 =?utf-8?B?TndqZ25uQlBLV255TVowZGZ2Szk5MVVac3RsNjVuYmI3UDZ3RUU3TlhmVU5T?=
 =?utf-8?B?OG1EUUhvRjAzMEdMbDFHMTU3MGQ0NjRlTW9TeTlUL0gvWmh5YlJPbE9iZzFW?=
 =?utf-8?B?ZzRBOE9wSVM4amE3and2bko1dHZxY2VtazFsdGNaU2FFTWVySjYzb0plMXhN?=
 =?utf-8?B?RWJQcXhnVFlEL0p2ZDdLY2RJT1MyN3gyVXl2YmZ5TkFMWklSSXFWYmsxZmhE?=
 =?utf-8?B?YUdvcEtDS2Z0TS9PenVCM21OeVVwMnJoUDllQnVMNmRjbzYvNGZhY3E1dEJB?=
 =?utf-8?B?STduVU9nSGZYeHM2dUJTOW1ZZDBoSnE3UnViendhRXp3RVFMYmJpQjYxandn?=
 =?utf-8?Q?6mhWxDlE12gzidgz5fO2JrTgIl+8pS0UoQrWy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efa28c7-1db3-43e5-077a-08df1b23733e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:38.2801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db79MxorF1IiVsDxTQFDO4YJD0OwYaRcPcVvzc2AUwG5Hh/WyxAbeUIGUNet69bVHS2YAjWeShbByR4rbl7v6hyKsn+RdDX8Ga3BBA3qJLxAm7e6THAl0L9UZt/tKSMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB075100
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

From: Frank Li <Frank.Li@nxp.com>

Rename soc to soc@0 to fix warning (W=1)
  arch/arm64/boot/dts/freescale/imx952.dtsi:348.6-1539.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx952.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx952.dtsi b/arch/arm64/boot/dts/freescale/imx952.dtsi
index 1154b66dadb2d..3c51e61d1fc36 100644
--- a/arch/arm64/boot/dts/freescale/imx952.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx952.dtsi
@@ -345,7 +345,7 @@ opp-1000000000 {
 		};
 	};
 
-	soc {
+	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;

-- 
2.43.0

