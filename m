Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92544CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AA110E383;
	Tue,  6 Oct 2026 12:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D00bkqtF";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21ED110E362
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyrWdIRqAWmh0VfdHG55PNHC8tLwUjkX4ZDdUGVAQAOCk02y/22osJxAvK1eBXHu2XAm+yPhRNxTk7hFQqz479tNlr2v4kUu3sp/Ue3hk9t7Dw20YeDn4FgJUxZjf5rHHTvcZLqaJuZiqYNCOamSGJBSkIh1issw04cciGnPfO69FtvqcqnzhyK66rZxLCtijYjDK0tBOmaWAzFYiizh7AT20SGuQN60yg4470fTkvSdfTHCerrczH5bPFKqDmlN3M8PDzTklAKFG2cRKFtfUVMyS6nDGV9yjpS8tgNq8y4GHPxQq36rI2wZ4aynajEa9efD0bmIDdGKpMmELNXpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyKH5XSZwm7nSw3yhqfI1ZHiK6RFEhKwI4S53rQ9hdw=;
 b=tz5EwpC873P6q0PrUecgGaz/tlg3PZRlNNYay3SReZn+4lrTUn0BVtYsBC23dWg/ruyGUYwESPqfOND7pEazJTtrG9OAqkGOk0BbVyNB+4F67rsOsTm90yjiATGfcd+UG9YrvEumlv78G4ZMjci6g0OXmROtpsJAZiotoPFgeLxTaXbMZibcJ+GxOpOS//MluOHC+oI9FuvGtyWY4BGZnUMAkwOwQrV3Ro5pjGM+5gPtGHhuZtoKiTx52HG12dA6ZHmrrA/eDhSyDKsSD2zSmeW3WmyhVw3Yd8ZtW1CAtlQbvj94xHngcokBLBbPZTyYNkHCsGkinG39zhmbXvoCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyKH5XSZwm7nSw3yhqfI1ZHiK6RFEhKwI4S53rQ9hdw=;
 b=D00bkqtFxy6aCUYYi1Y1AJEOmWl/ZpIPJ85jM1tbWxtASyUhXJPd9pa8U/InUKNILTR4aN4VaqGjbbr54uBru47pTas2o1SxExOPID8TMZafCaaYGtg/uxu9B6utW9z91Ma15Dk6GBE56gh/q9fQJwN/cPJlMRgl/RJk7rUX+dYUAV81lbWiAi/4HlkDuhjWGDKc5qPHIJSBzo0Jw0fv6E8LIaaE4igldwoCGRx8+yFdXVEHBYdWe8KSaHsWslM0KjbwNMv/b8LMBlSs+G1hGdaxXPocpHkKY9PF5RqSjaqg1fw6U4zFdW45bWXG7WrGoUS3oTdaUWfJODlxO2Eywg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AS8PR04MB9045.eurprd04.prod.outlook.com
 (2603:10a6:20b:440::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 12:23:17 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:16 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
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
Subject: [PATCH v10 3/9] drm/bridge: fsl-ldb: Add support for i.MX94
Date: Tue,  6 Oct 2026 12:21:58 +0000
Message-ID: <20261006-dcif-upstreaming-v10-3-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AS8PR04MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a3bfda-1125-4251-e7dc-08df23a49981
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|376014|23010399003|921020|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XFyfNxNm2BoqFjN6NsVEKr79yz8o9HDtXLPBgvejdw5+fqZ6vuHtXqB/Bu8+ybVDG6Fa2Cn3Dbg3tMolooZXCwbNVaIEkH5h1JZa109JZJmtzCynJKn9jiy5BIA5zFa5R6U8ZINtGCfVN+ndZpE2vHjskBNBqipkxSSz2qgwIuScSevC78H//640hfwvisTQK8tnbwp7q13b8rxHVyBk3HUqM5u3y58B6pW4jUeUCqISpb0W+eng//s5GU7vZCxpG18Dhcba9LiS502AJg13FGp+K7B1vlgVzrGJFyDq56QoYwZmP4vJ93Iw3BCxm2Ty+pDHL7AmQrZyOmB5ZSrhzvcNROFqWslbujc2BRU2AP8NFPP3o3r7gZBPdpSb4kwNxa7Nd6CGLICMTiJtlegj7s+TDAa8CRAVOSlH/ElCKj5geyWBAnmyOjcJbXu8AIcN4W+5P3Bk4DOzE5YpsA7AsNgPeCic0J6qGIbvOGPZHmI8GWSAKw2Kjg3NUNQWSUBqyylJl0wY4ZZhxYqu2oX00xD5PE9Mwk7lPYEtjsnOAgli7ppl26+69shyP/RpLkBSTtuTnkpvEAQ1AdcQEh7JAlK2p5wnTba5tDasIt+nzqtzoe3PfyjikRMBwMT5Rovn+2DYF1DQjd/UJL8q+ErQDVKxBy+7KfJxlTax7nTxdWhQFQqBEB+nQ9aRmE9u/+y4I8rjH7/+glVz1CNe8kZHrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(23010399003)(921020)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1QREV6NWxjMU9MSmk0L200YXJQeDJRVTBJREhjMHY4U1RyanQ3NzluSHQx?=
 =?utf-8?B?ZE5kYmIwR1JuWTZiMjlBM3VOUHNmR0xtOE85OXFhOTdURWU2dnNYbUhmbDcx?=
 =?utf-8?B?YW5rL2oxWVI4d1l0TlI3T2JkS2pzOWlVOWNsTS9rYTA3M3VFbGNuRmRDS3FZ?=
 =?utf-8?B?cFdVL1FiYVRYQWprYm5xalJ1YVVTUCt1YXhORUpaTWxrcDJrRFNBL1dka2JM?=
 =?utf-8?B?Uk1ianBXN1lMYU9MNEt5RlMwSkM5OHFWQlhFanFpcFg0V3c3akZTL0lQNktT?=
 =?utf-8?B?Z1VIVStqemdXRTExcjVQMUNSYUhYeVp0UzFpMmhKTHExUXZHRFc1V3YrdWlS?=
 =?utf-8?B?YzROYmIrVlJSaW03cjZGb2RpTENtTDhRcHFUaGt5c1R2SDhyZC9yVmhHdkN5?=
 =?utf-8?B?QWJJR1luYlhhMHhxcmhlcE0xdEVTY2x3OEFNQUk5TEE5dloyWlJ1S2NjQkF6?=
 =?utf-8?B?N0RKSjRMN1huUGZhYXBnek8ybGFiR3lPbU5jWDNTU1puN1FrbHBVWjNqN3JD?=
 =?utf-8?B?QTNlNHowVGV4WjFYVm1EVVRaYXFEVkNJUjFIbEZ3bjJTakdjRWdkRlZiNjZ4?=
 =?utf-8?B?OVRyTkE5V2piT1Brdll3TnhUMGswUVVDSHVGdmpUQ1Ftak10RlJyTEppYnY2?=
 =?utf-8?B?QlZkN1NSWkNnQ2pGaDV4UGdLejFoMlZJN2I2blhiSU5OMVlNRWFIbVRkZTFy?=
 =?utf-8?B?S2RIUGdDd1FrNURIc2IvdlpCWFdma3E3VWw2MmFDMTlqTnpKM01sSG9mQzEy?=
 =?utf-8?B?dE1COGRrOGY5TnVoZ01Xa0VtVXZRRG5tUW0ySXRqTS9qYVJIbDQ0V0xnS0J5?=
 =?utf-8?B?VXNsWHNkL2wybmp0TEszY2VoVDJ2NmFSK04rdzJIYXhNYTF2Yjg1RkkzNGRx?=
 =?utf-8?B?cTdXSlVRYWkyY3VnU082RzdLTWJXVzVEdnpxTDBZeUxFNVJGRXZYL3QvNG9S?=
 =?utf-8?B?aXBLN2h5Z1NuZDFTeFNMVTdjNnFQbjJVaWg4VzlDUlNCeUhWaDdjV1ZhZm0x?=
 =?utf-8?B?RUpEOHJRd0NQeGVNdmZvV0taUlg5bVlwUGh2cDlvdm1TV0FrTk84QittRHBl?=
 =?utf-8?B?MlpZdzBXejhhSFZvMnFINkFoVUdyS1R4UWw4cHdYWkRVYjY5WFRFb0RNZnBp?=
 =?utf-8?B?S2JhbFBPcmFES1VWWW5ONjlaN3AwQ2JYWDUyQXZhQlNDL2NIaG93K0Vzd2FS?=
 =?utf-8?B?a1VTOTFlTjhYVTRRK3lIN3BISG1rOG9WK0RRdDdTdWhmZ25iekRxVGxqc1hT?=
 =?utf-8?B?TUo3M1FyaXl3bVcyR2J5S2pOMW4zRDIvLzUrRFRqR214MEdTdi9MYUVxa05v?=
 =?utf-8?B?aEhrVUM1MmpuQW9aZjV4RVgwNUxCeFQrUklDM1FKV2NsS1VXNForYUN4Ymdz?=
 =?utf-8?B?YWV1bjFXaGpaUVhlQk0vK0NGckpWc3ZNY2MwQ3pjSHlEc2d0V2FpNFB0MXFn?=
 =?utf-8?B?dC9wQmpwUDNBMmx0TitIU3FKYmx6TG5NNnRaNFdKdzM0S3A4VmVTdS9LaDdv?=
 =?utf-8?B?aEo1VklocFNGTDBRRHZXYmVyb2lhc3RYeklIWmY0OTNXdVkxSDlYdDJIb2Ux?=
 =?utf-8?B?UXdBMk9Lcm9TWENCcGQzQW43UUI1dzQ2Ti9DeTB1Mzh6YlZ4OUZFZHNJbEhS?=
 =?utf-8?B?aWwydzhhSENHMXA4Y01tQkgzLytvMU9PN0MzYzlGaWg2V3pvL1hZTlBaT3Vu?=
 =?utf-8?B?SG9iMGFJekc2UzFFOGQ5cm44Vm5lb1pCWDNzb2RUTDc5bzNnZVdxck13OU1X?=
 =?utf-8?B?NW5kMndwNVBiVFpwRUt2Y3ZzdjVVNWNkaGZOck9kTEozNkxybjlrSDFCZUNn?=
 =?utf-8?B?NE1WK3JVcFhacFQ3eE1MTTd2RDRHM1pid3JPVi9NSTJlNXNIN3FiWUQ3UUVZ?=
 =?utf-8?B?YWxnSU1pUGRlaE4yS2RveHpLVVNQRGZ0QzBXeXJNSGNLbFZCTkZESTVCd1FC?=
 =?utf-8?B?TVpmQm5DcHZkdFVSNm9rTUVLOUFjN09KbDhFNk1LNmMrMURPdHlJOWJpcnY1?=
 =?utf-8?B?ejF0NEk1bE5lMlRqY0t2QlVzaXRjVzRGRUdzamh2Z3FHT3FWL1NPeU5wVERL?=
 =?utf-8?B?cG5sZXozQUtrNmtCV3VPM3JrdWpxZzNwZ3Q0d2ZxZmFia2F3ek5BTzhoN1ZY?=
 =?utf-8?B?dDF3T1hINmNNWUlwM1JSMWxTNDVTaFdYalpxV2dMNTFyY0hPNmprbVVneEo2?=
 =?utf-8?B?TllXNzJaU05VK1IrdDF2aUs5ZThFOEp5Rk9xSUxmWXJhTzVqTmIzc0luSmZB?=
 =?utf-8?B?cVdxZEhlTHZoY2FCaXliaXRRNHYxc1djc0lOWFRJcUdmOTRmOFk2aUE4U3Y1?=
 =?utf-8?B?bGZMdzI1WnNScUZIVUFqNUd6dGhEamZuTXRlazFPQUJPUmgwRmliVnhRSmhn?=
 =?utf-8?Q?A6l/1NZzmkaVHLYg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3bfda-1125-4251-e7dc-08df23a49981
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:16.8605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2aL7OJUnT2k6T7k+9CgCyecdp+fO9T2X2s9XXIrZYPY6OxkCqwCvg7+JxyTfBB4MMrqt2JpjYPGZW3Ld7FWeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9045
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 52ae7f5b63c7c..5da1b2cc9b6cc 100644
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
2.53.0
