Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A1606A324
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Cb37rgNm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0389B10F612;
	Tue, 27 Oct 2026 15:01:21 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013055.outbound.protection.outlook.com
 [40.107.162.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6786910F612
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpVgX+NR2kfAk5rJ4b2W4wQWtPSPngmslyMXMmX7DouOfbu3Sn/2/nqgeU7CiFkkOJvsDpdFvNEBzaH7AWyumrVjcqhncOebOErZBdSbBrmlSRkHari8fH+R5O8viyO+7vUWHbzQXx7ldSp5tHgBjQBLaMc1NtfCFsppda1ykC1/PqgA3qRE+VmNQpoOVfRGNjHSBg3aIL+z5/Eds0kHxDopZxUFVMgK7LT7wjuE+KeVBj8emL8z5Ee3E4ibgMh9Hipg5f/yuFzjLsyw/EnqbybPTciy30++PRxK0O8SiMH+2n4BjlSEf4ezxW7YslPtCU4dx0jwAyYHuo9q7sPdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brypqxNwrka6KGLfZBzdqOsfq8rb/Dv3y7ViwKad5XQ=;
 b=CEGIL/hCGnrfj3mnh24PEpkL29Emx+uTR1doYDsy1kYUjq/zdZRGPyl2MTQZQdNRGL1MkENnHCV6ni2FtGNGsRWegJMU2A9Dr8nhYjDlBwlRDm0mdMTPLRX8C1ta8wfyCN3fjODhUVVRT3S1PazwCC4txI6NCiMFPcijo0J9y11uNOJgJuP/9NwrXYeuSNI6y2KB8cDkx+yRvlDUx1iRQrSy1pWPlCUfZP8gAqG5CtjImdsYpD31uVoaQYxx7qGRxe7NrVJablwRs8aZnDIa3MFz5bGEBEJA5hkdHvHYNZWhydB/F8NdtLJRwABEhFsJxbwS+DOf9XwJe1COjGxIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brypqxNwrka6KGLfZBzdqOsfq8rb/Dv3y7ViwKad5XQ=;
 b=Cb37rgNmytVFJcyhmJZ91PgC0T6Yr1nZqnISMQNaMu4AkP2aQRQMJD0IUUZqFGMCwlt48NOGa5vS0ZgT02/XuAqWm6B11FXG8GRvsWHrWEEPR2GdA/fhLkuqnhRMq40o8/mYe9YmxGMRP7kZ8taRCBpNXjLYn2GREeIIryijA2lsIGVbsYcbXTpvaVK0xuRx3U00pO1TggSBDa/otBqvhW8HcrgKrEE8adYtUSu2Jp/ECGAlD1EBPjmE+cfJYVGq42sN0f5earS0QiP1bxQgtVapM1hc1Avrk5c3Xg2yY7F5ijmn2+ddLkDx/8//TB33s8nTiiOebyDp5OZIR6jJKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11162.eurprd04.prod.outlook.com (2603:10a6:10:5b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:08 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:06 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 27 Oct 2026 11:00:53 -0400
Subject: [PATCH v5 1/7] dt-bindings: lcdif: add compatible string for
 i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-dxl_lcdif-v5-1-3a974e4b94b2@nxp.com>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
In-Reply-To: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113256; l=1922;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Y5ktB+jnBb0dy3CF0268DAahnYcLBApZjFFC3OugfzU=;
 b=24UujI/Jd+6+ou2J7+wPSe9j3WtA6zJGtZKfqAPRFVIuYuBRqEWafejhpa5/i7seWy90wzriy
 GiE1hyBh/1+AUfOqOb2tfvc0N+5r83CQImc2wlfC103bXGfgJ8bl1TO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25e::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bc64e4-2278-419f-3251-08df343b2062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|7416014|261026140227099003|11063799006|921020|56012099006|261009223027099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: uRIdGG+L71c+CXthD+Nw1rG2AQ2TZt3O8/qsu9SkurC9qVWsr3BHkWOcc0RPvDZvjT9w9qgi2JT9/qwV3HERsuoih4/vIoGhPMNyH6NaCns1TIEfH9rnu0ucCi0HZJnnvbQ6285ZIw7warUSa4sewOCN8iy7NjY4aIdk38cErOW4hmhCjOxKhGOJvd7G9qeDKaVMTd6wpxKAGXUOqTZTj608ZxlVU/vG0p6UvtT51+862n+ER+3Qj9MQFBz7L5/60tmYWewFy0Qa4ZPz9E3AHFIFYYKgGZWrtu9Ldsr+LhmXJ01LlxH6CmQCmxIsOrolm1GaxpW9gViDftb0OD4khAU42MraX9GPnuUphlxG/E4XmwtqVjIHPwk2jmVInWKBr4fS5sp8DPYLhBD8JRndPyEdl+XSjpuhJzbrormky3tDbT++qulMRJAPK5yQmMyugdyVk34RowExnD9UDRrfF16w3BqIY6hTF6RCHzZiX9xXjn440EP69d1REirvnKK1ic1TAsaShgoiVEhFS8aikIUr0FyyjPIX/+n9ChIRcnWgJ8W4E5eRxrHJv0b4RKWmBECRBbhx7CvK1gSTgSMWfLltWMudJt5R6W6GDcU/IsRe/INsXkDiEjUsh3w6F9zos/ZYPLbh4YialkXnE2Z1yi0eJIhbxpfrPkId3M7PalKwHp0IC3WSSStD9HorBho8DLpl+WNcEcGniIDJEjAiJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(7416014)(261026140227099003)(11063799006)(921020)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBmbkllbGlVUWliTmVOYUpSb0VzdEZacmFFWXQ2WEFGWTJoSkxlY3NSYnRC?=
 =?utf-8?B?NUJzZzFvY2tGRDFBdk1tTi9pWkQ3NW80a09WVWtiSllLR1h2WWJZZHlYajBw?=
 =?utf-8?B?a0w2TURkbWpjZ3p5ZnhVVmRnRzhLNnpIVlliUm5MVTNyS1ZWa1Y5T2hndjBF?=
 =?utf-8?B?RG8vY0gzaTJRaEpRMDRlQ2Y2T05yWXVZL3BoYU5zcFgrMHNLM2JXZnUyYUdm?=
 =?utf-8?B?a3J1Zk5GYjIyNGFpTUE5cUdKNUlrM09KRy9CemVEd2gzVnNiWGMvM0FhZGFZ?=
 =?utf-8?B?MkFNYnZDdlR4d1hHWGhHYWZMM3dkSzI5TlI0ZnE2RnVNQlcvZmpBaXY5cHRn?=
 =?utf-8?B?UHp3cy9zZ0lUa1lmU2U2dlRwQldQVmRBZXFmMkIwL3NXQXJneDlGMzhEZ3hi?=
 =?utf-8?B?aXh5YnJhUGZLQWJZaDRxNUpTSmZlRiszT1dvODYvMlZZMnV3WmJ3TVgwRzJl?=
 =?utf-8?B?d2liZVpRd3BLWDVoSkVLcGx3VkZPd1JyL0kyVTk3MFJIZU5ub3E3Y2k3bFZu?=
 =?utf-8?B?WkRpRlloTW1iVmlzZmNJMWV4aFgraE1aNnoyLzdWNkR0VkUyM1ZTNGE1ODdP?=
 =?utf-8?B?YlBwUitKdzVvUEhudURoOXRDTFZwNzZCL1NTZWVMU1p2S0YvZTBoK1FGL0p1?=
 =?utf-8?B?bytmaWdIV29LSjBPdVlHQUNWd1IxQ2RJSnBla09vdUdscStMTFlTZGtKTlZl?=
 =?utf-8?B?N1lpNEhYUElEUHdNWVdENDJkREUvc0JhMlJoQ0JBaGtTZkRmTStPU1dvTHZY?=
 =?utf-8?B?SW42akpwcG9RbDQyN3htVWVQU24wMFFHK1BWMEVBRFE1VjMrKy9OcU55ZFp5?=
 =?utf-8?B?dythcUVYNmFKOTFqK20vcjhJZCtTTXlQaUtBQm1hMkZ4bkY5TnNBYWFDdm1K?=
 =?utf-8?B?aDFjVnpiRS9Bd1puVjB4VndFRjlVVnlWeFVYeWkvR1ZRVkZFb1NHbFpzK1Ew?=
 =?utf-8?B?QTVJRjVxc09VaTZlK1hraU9jY0NtaW5sMG9BZjlRdVE4eStlanUwQ21lUWY1?=
 =?utf-8?B?bnl2R3IyWVRmeTBDNFBCMWlZa05DeDlPN2xHdm5DVnVVV0d4QjlDT3AyU09J?=
 =?utf-8?B?bVBwNzF6OEtrcmNEMlVUWTNia3BPWWxWMVVGTTlRTVRKNjBUNm5HcElBQk9O?=
 =?utf-8?B?R2Raa3ZKYTRDZ3I1NlBpT0k0ZFc0S0IvZFZzdHhVZWFqTlVwYlhtNjFiWmRu?=
 =?utf-8?B?bWlyTHNsbWJHYlVDVVgrZEM3SklRUXI1ZURlWWh4NEpVL1NxbStRYXBuWHpX?=
 =?utf-8?B?UWc2WTg2aFBMMUhSdEtMWldoNzhlQ2FUWDViMDJxdmFkeUpqWGgrLzREUFdz?=
 =?utf-8?B?SSt2MEtmSW1uVVhzMkkwZWp6ZmtIMmQ0aFAzNjVQTzRVMjR1V1pIM3FhbmNH?=
 =?utf-8?B?NVN1aW5xYWYyNnpKTFlRYXdHdEFQbEFGYVlTenVka2wzTWNQd09xMGtYSkpk?=
 =?utf-8?B?NHJoTW1rTTk1bUhTbzk1RUxtMUhUWVZKeDlkRmFiTENFSmRpLzcvUlNJVkNw?=
 =?utf-8?B?ZTdKOEwyUVE2cTdMVFlkcVZialR2YldmUEdWNjVEOHRHNjRWMVBSNTV0VW4z?=
 =?utf-8?B?T0J2b1UyejM2eUZWbitpTEh5dDQ5UUFYWWRCUkF0cmhoc1d5MzUyK2NQUll6?=
 =?utf-8?B?ZGZUU24wbElYMlo0RDlKYkltaFQxcUxqR2tVYUFCSFBnYXF4V1d3WDhYMm11?=
 =?utf-8?B?MkZHK2t6TFdwTTJYOVFMdnA4K2VxQ0huYzNlT1BLRk5qSkVYTmpMaWNicjVS?=
 =?utf-8?B?SDM3c1Vody9PczFBd2krczAxbTZER0o1YWphWGg3THhmVDNzNFRjanMxV3VE?=
 =?utf-8?B?aUloRzkvQ3NEYmtjZU9udWlwL1VGRDdUL3Q2UVZMdEtzSkR1NlY5VkM4cEJV?=
 =?utf-8?B?Ujgvemh3UFdxSDhqK25BUy8rajNhd1RaelcxV2gwUTc3a2Fjb1pnZDUrRGRt?=
 =?utf-8?B?RmRheDRpblh3ZjNwRE92NHlzNlhBeFZ0Tk5zVlF6Nms3YWRYWHExYVNPRlcy?=
 =?utf-8?B?cnNueFEzYmQrUE1FSm84NWx1UmJQekl5VmVxSjZsWmlaRGwvaTB6L2IzWVlm?=
 =?utf-8?B?RUdiSjNvZDFLU04xbFY5azlHaXFaMmEwcm9Ebis1Vm4raHFoRDAvODBEWFNS?=
 =?utf-8?B?LzhaT1h3amhOcVI3Z2pmMFdZalpsVGFNVGV2Q0xFbnIvZ2VDcW90NzVLc3RR?=
 =?utf-8?B?am9CdWcya2twa2NJcTUyNk1uMkptRm5WQm5tcFFWbzVsTnJsTkFXMVVMSEF3?=
 =?utf-8?B?ZndGWkp3dWdOMXZEbFlGTjVXTzZTUXhrek9IaGlRYmhhSFlieUU0RjJpY1R4?=
 =?utf-8?B?Z2tDVFcrS2dGU01tYnZCeC9tS3FTZUdIdDVCYy9HNERCRlBBeGdDNXRlWkJ0?=
 =?utf-8?Q?Cx3itpMSkhSkbKmmYepvPwgFU/9B7L7SpHBOl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bc64e4-2278-419f-3251-08df343b2062
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:01:06.1700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGvZWA4gTcQL8XANBdwoiJFp1Z9r2dgLHyYzd48mXi1XbuGMhdqMGFxxS7JT9hE4H9ScyJUjHvI7dEXRF2N6snyCZNghL/cGmosGnMkPwyDqmEsV+a46j4NTHJYKFziD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11162
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

i.MX8QXP and i.MX8DXL have lcdif, which back compatible with i.MX6SX. Add
front compatible string "fsl,imx8dxl-lcdif" and "fsl,imx8qxp-lcdif", which
fallback to "fsl,imx6sx-lcdif".

Required power-domains for both. Required 3 clocks and clock-names.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- require 3 clocks ans clock-names
change in v2
- require power-domains (sashiko)
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 5f56e733c4f7f..c986ac87fc2bf 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -28,9 +28,11 @@ properties:
               - fsl,imx6sll-lcdif
               - fsl,imx6ul-lcdif
               - fsl,imx7d-lcdif
+              - fsl,imx8dxl-lcdif
               - fsl,imx8mm-lcdif
               - fsl,imx8mn-lcdif
               - fsl,imx8mq-lcdif
+              - fsl,imx8qxp-lcdif
           - const: fsl,imx6sx-lcdif
 
   reg:
@@ -122,7 +124,9 @@ allOf:
         compatible:
           contains:
             enum:
+              - fsl,imx8dxl-lcdif
               - fsl,imx8mp-lcdif
+              - fsl,imx8qxp-lcdif
               - fsl,imx93-lcdif
     then:
       properties:
@@ -162,9 +166,11 @@ allOf:
           contains:
             enum:
               - fsl,imx6sl-lcdif
+              - fsl,imx8dxl-lcdif
               - fsl,imx8mm-lcdif
               - fsl,imx8mn-lcdif
               - fsl,imx8mp-lcdif
+              - fsl,imx8qxp-lcdif
               - fsl,imx93-lcdif
     then:
       required:

-- 
2.43.0

