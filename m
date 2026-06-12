Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86371CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A9710F463;
	Fri, 12 Jun 2026 11:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H3merzBt";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E1610F43B
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfRw7GaJUB+JIkRiBYaLZ0WE6171yz5+xwKQtKsgJriIIkUZD/1sV786cQU1reZcsB0XGzXjfButH1MuD6qZBiNsoGGy8MZGsOvoH3eohl+hAaIXG4CM7QnJgdbT9C/qeMYtg8xBtJoia+OxwqBjeWch9rryvV2PBuCdw7oBvQB33NuoJOnuYOhKZ87fwn0guk1BD40o/66iTUXtDr2UwknkLIJyPLsaucmMusq6PYUH2mHrKHl35shu3tDAaBv7XDJWYFHi3+MxHRHk5VWi9jAFlmMvOTobvQECD5Q0aruzeu1yGtNSa4hwr5ukh7+4ukGTK0BcijjidaYvhyP1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/ZnI/eHyY4hHBGOKkvkNQBCmWVOs7qmesiPAiM2XMo=;
 b=PvBYK10rIbmhvYTp+t0r79vu8hfKmxpjhUCY72wDXGEDWTEmVU0h1fbsPXdIxXWXv1MC4ApU8EOPvE6gmPwZDAvm2oIuqghuqJuYzLlPeB5hALUy52rl0INO4i2xjF3Ls6wA6EXp50Ol3lW5hgdUNOIDXE4ptAZP9Hv6vLeCbE497acNpehozjJAZF49OWt1lgCi/nuFSDwojVKMYcFv1TxcVoZwSYW1saCNgnTTv1J5uQEDNvrNUrbBC1EMjiu8okKA/3dQT1sWVD6i48yx7po9WTFz+hmUAOmUzJeETdjVjMalvxWUcVpSat87+L9XFjtLsNOrvBppCofFlJdpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/ZnI/eHyY4hHBGOKkvkNQBCmWVOs7qmesiPAiM2XMo=;
 b=H3merzBtXGe41C5n7/A8WElipQl05jpkLx2HWGa+kFhFrSfP4xY6lfyqNH6N4JhQeihniTQXEm5Xdn6RU/7fce1WVrD722KrYUXQ7KUOx1A9RVlSon3P+frIR6IRosCaAgolQLUjaNKaa7NE5XRTAgJpFCQB246MI+zT1HLrvdBJykx0Yn/cCCM38u1S2kezX0Ld9v2eO4UuK2jCf9dPbzdBpuIm6mpmtnamFYiSX/kYD2N8SOaKpjoZ8qqu0Cm2povgA+IqD+hm0T2ctYWUhGt3LKp1e1EUben5iRiGYy9saqEgc1POmt2b+YmZuGxZwfh2ibLbaCfhBTQJ2+uZQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB11710.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:58:57 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:58:57 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v9 3/9] drm/bridge: fsl-ldb: Add support for i.MX94
Date: Fri, 12 Jun 2026 14:58:34 +0300
Message-Id: <20260612-dcif-upstreaming-v9-3-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0041.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::11) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba10875-b209-48b9-658d-08dec879fbda
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|1800799024|376014|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: f+zJ8IBXa5G7cCUe/X9RVZF3kQSk/Ijwpwlwpdcgw/+y/PEeh2NDb/UEDMLEAEHhN2OyMvlmq3sBmLa9Gd0CV5Z2J7iwTDLIs81VCJxUr2C1omo6qSvpIHUF/wyUaJgOQmNEYzrFNn8BkFkdIj0sVY7vDCstiMW7xDo/uE1dA2VmB/qBeYqV2eSb42pzfXIWEK7V/pVqTWyyzc9KV0prp9zukroSyt5RNOIPnFacxIgQ728UARy7WrdB6Xbggp25qmFbhC38ihfek+XOIasP+WmLrLVDQqGEC2ra64KemteFGRiOlmqcK0W/UFUPFAOIJEAh9R6HUbgue11T0Te90f6p3/ITKL+T8U6oByZ3I+lGcJQHZp5cdYcRqarre/WOqFIxauGL+lGqEAivM1KPASy+a2aNPxJih4W2XFahO9J+T9fyGFXTAbbfg2k0E6A7e184n+Fop99KBHbBNXhRoDirwovJE12mhsklVD7cyou1RsgkjwQI4rgeLRLYfAeOK6pYDTjMeH1avStZEwUSxAoWsr4hqynEkZzvJGrGVjX0cR45TAUDujFL7IBi9YiqFMrdVvDttpFjltWuQUpNxEar6ePeEgKzkZstzFE4w1n5rXfnGnh2maI2yvlLcKVm1Q/g2h41ovnfhIIU/nJ4fZ6Q4J8QDKooN5fJmzpnrSqQgwj0JsSmM2sy4E0Jk8JA8t4LJwpgh5blNk8UGcPN8SBXdIGMhejNwXlSKv38fBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(1800799024)(376014)(921020)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhQOGhHellGVko2VHdCZmF5TUI2bnRuUkdobzM5VUVMd2FQYmR5MERmcVZ2?=
 =?utf-8?B?MkhRazFFRElzRGtVOWdjRHhTWWpGNGROLzA0SjJocWwzL3craWh4SWVPQzY3?=
 =?utf-8?B?Qnp4VFFBcXNiUEJLUFBPMkJnYjZnd3ZKSlQrWDVkNVNOWTdHZmpwdFhyV3B4?=
 =?utf-8?B?UHpCY0R4Mm9nY1hqU0gremtZaWtWUG1EVnBZbFNvem9vNnBURGxPeXhMS0VF?=
 =?utf-8?B?V3g4K2VoOEdaWU5MMTRrUk1DMVJCNDVWYmUvUVF6blhzM1F6YThIemRTd3ZR?=
 =?utf-8?B?T0ovbGRsMnNBY1hSRWhKT3BhZmxpVDhsVEl0ekxlalVBbENua1RZRFhtd1cx?=
 =?utf-8?B?bDljMWZCRVU2eXZkUkJ5aWV1OSs1YUp3RnpkeDFET2lWL2lLR201Q1dTbGNR?=
 =?utf-8?B?L3FKeWkySzJGeWNlcDNiYTg5cEkrbjZ2QlZua2VNamIyUktjam0rVGNjdWYr?=
 =?utf-8?B?OHZQbGdRVUdNY1JjUXlYSUFYUjlIL3Y2Q0N2M3JaeHNWTGZUOHZIc0c0S2Ir?=
 =?utf-8?B?WlN4TWJZSzhuQm4yNDVyWE5OVzZHTkNldlo1RFJIMnZzaVkvMmZJZGVHdENZ?=
 =?utf-8?B?WG5uMHBVYVEzOGJpTmRUTWQxTHpnRTluVEJ1dm9saGRhM2VvemNVNXk1WUFO?=
 =?utf-8?B?azdTZE8rbjE0VEF5bHBSYjRkY0hxazVSMHRzdlF1SDNTaWwyUk5hV1pJU0dT?=
 =?utf-8?B?c0JHOGo0eHV1RmJaTzVHa1VzWUdGV0NZL21FNERZLzZyUEdXbjkyYXBPWjV1?=
 =?utf-8?B?L3piaGRDVVNqdTVrdWVOOTFvbk9VVndYSEkzZUhsTFZIY2JJU2Z2ZTRWd25x?=
 =?utf-8?B?U1RZWXVodldkNEsyZkhVUEtGZkFPcU1TL0xwaDU4b25HZ0hza0txOGNnc1lO?=
 =?utf-8?B?V25qNENHNWcxTHMrT0MwaE9yYURwN2cwWlRhN3JJb2JqbStTTXN5K0N4aWw3?=
 =?utf-8?B?SFc1NTBVd3pVWXBxTm9sQ0VEOXFIM0ljMkF4VGRKZXo5ZnMrWnl5bVFTNE1U?=
 =?utf-8?B?Smw4TndMU25YKzRZZ242M0RzVzNndDEzcEJvdEVSNzZEN05BL1lwZi9xcnB3?=
 =?utf-8?B?RHc0QmRzK3BTYjRldXhReW04VUl4b2NuSzJrWmFlTlYxdDBRcEE0YlAxV2VO?=
 =?utf-8?B?U3RaazZrZDdjZU5kcWZDeGM4VTE5Z0c0ekNlTUtDWlEzNG1QYmtpY1dOZTNh?=
 =?utf-8?B?UEpUdGhRQjFWM2J4aVhvd2Ruczc5MUhHek52b2FpYkF4V2Y3enQ4a0RRRnFW?=
 =?utf-8?B?dDhOVlltdDJCZVIwcEp3TEJDTEx5TEszRlR4TEwycnlmTE1DTWFZZXllV21R?=
 =?utf-8?B?dkV3VXIzRy8rVTZVRlZVMjEvL3g1ZGQ0QWZ5M01BV1hlanMwZDU1dGVMS3kw?=
 =?utf-8?B?bGNjcFdReEs5bzk3MzJzWmVvbWp4MzVwZDExV1Q1YjZ4V0Joc2NCTVhvRyt4?=
 =?utf-8?B?TDVpL3BOTy8ydzVYQnAvRlFocTVzUHAzT09wbHgveDF4SWlXWTA1WDBHVFdy?=
 =?utf-8?B?QmhiTDdDRStVdXZycUtURFgxUFFnWTA4VUQrZFNVaTNHZmQwdVJlekJXbVE3?=
 =?utf-8?B?cElXMzdvQzRFQnZSL0RIa1cxTEJlazF5MjhaalUzb2R3aXB0ZGN2TXBsOTJw?=
 =?utf-8?B?bkowZlZva3ZHQ2dYT1VITEdQWGNKV2VCVm91cCt5T1dHQ25GU3c1Z2hSWTFD?=
 =?utf-8?B?MjkxMXlPRUlQY1M2S3BXWHhaQzZLdCtNQmRSM1d1SisvSDJ4QXRkZTdoaWJa?=
 =?utf-8?B?NUJRRFZBRU5wRlNQdjlSM25TUmdvVCtJZUZmdTFJSDgyTVBBeG5MTDNNSEpT?=
 =?utf-8?B?L2hoaFlXaVp1SHIzWllNTXgyNkdzTlV0blpvbFI4eDFOTVF5UU45cEQxejVw?=
 =?utf-8?B?NDlXdFhMM2FZVXJ1d0ZWdkpFclpoS0I3a2ZUNFpMN0JMdkZ6L01lN2pzZmdO?=
 =?utf-8?B?RWRCcXJXV1o1OXdkRVVySDdncENCOG1KUmd4YU00Q3dGZFBRVThmbWI4dnJV?=
 =?utf-8?B?SWh5N2dwU3FmY2NUNlBmSk5mMXVtRTN0SVU1VitrUzRSNkdNM3QreTRZUnI0?=
 =?utf-8?B?U3lkd01FOVZNc0U3VDh3WU44QVNlSGs5aDU3V29MR25XVTVvOCtkV1BIbC9H?=
 =?utf-8?B?czZxUzMwNk41RXhoK0VMQ0RQZHpGRFo0cU5qZWh4YlZmbDlmeHJiTGViUXJG?=
 =?utf-8?B?Qlh6QzVrNXNTNGFQbzIyYlZSUkZHdWMycGF2OEtMUnpueWdzNEJWbFloVUty?=
 =?utf-8?B?dGVXaHZWVjBzZVhEUGVQSjBDaVprVHlhcGh1czhsQVRjaWwvVFlMeUVqQzl2?=
 =?utf-8?B?Q2ljQTcvOWFpUm80eWY4OFY0dUNoRTk3eDU4dmoyZmVFWktDaFFGUWI3MFlR?=
 =?utf-8?Q?OpKFxpqqXMjEV8iQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba10875-b209-48b9-658d-08dec879fbda
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:58:57.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrlRZQfAEYAGsNZ5YtfY4mvFeiP6sPrN03nnj/dQORh6+hoWjp3YNoEA7X8z7SM2VWgITkAL/qs658BGlx/wvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11710
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

i.MX94 series LDB controller shares the same LDB and LVDS control
registers as i.MX8MP and i.MX93 but supports a higher maximum clock
frequency.

Add a 'max_clk_khz' member to the fsl_ldb_devdata structure in order to
be able to set different max frequencies for other platforms.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index bd03c36ee696c..b4959f654f2ac 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -57,6 +57,7 @@ enum fsl_ldb_devtype {
 	IMX6SX_LDB,
 	IMX8MP_LDB,
 	IMX93_LDB,
+	IMX94_LDB,
 };
 
 struct fsl_ldb_devdata {
@@ -64,21 +65,31 @@ struct fsl_ldb_devdata {
 	u32 lvds_ctrl;
 	bool lvds_en_bit;
 	bool single_ctrl_reg;
+	u32 max_clk_khz;
 };
 
 static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
 	[IMX6SX_LDB] = {
 		.ldb_ctrl = 0x18,
 		.single_ctrl_reg = true,
+		.max_clk_khz = 80000,
 	},
 	[IMX8MP_LDB] = {
 		.ldb_ctrl = 0x5c,
 		.lvds_ctrl = 0x128,
+		.max_clk_khz = 80000,
 	},
 	[IMX93_LDB] = {
 		.ldb_ctrl = 0x20,
 		.lvds_ctrl = 0x24,
 		.lvds_en_bit = true,
+		.max_clk_khz = 80000,
+	},
+	[IMX94_LDB] = {
+		.ldb_ctrl = 0x04,
+		.lvds_ctrl = 0x08,
+		.lvds_en_bit = true,
+		.max_clk_khz = 148500,
 	},
 };
 
@@ -274,7 +285,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 {
 	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
 
-	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
+	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 2 : 1) * fsl_ldb->devdata->max_clk_khz)
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
@@ -386,6 +397,8 @@ static const struct of_device_id fsl_ldb_match[] = {
 	  .data = &fsl_ldb_devdata[IMX8MP_LDB], },
 	{ .compatible = "fsl,imx93-ldb",
 	  .data = &fsl_ldb_devdata[IMX93_LDB], },
+	{ .compatible = "fsl,imx94-ldb",
+	  .data = &fsl_ldb_devdata[IMX94_LDB], },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, fsl_ldb_match);

-- 
2.51.0
