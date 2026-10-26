Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA28606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kxcOesJB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC68610EDA6;
	Mon, 26 Oct 2026 10:05:17 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B71B10ED91
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItPU9uqeW7w/75HIdq1zG2+DO4UxcjZwBhWwzr1UA8UkX6cVviBEaqwfxJh9JeUhLg+9UPhGRGztExvy7FcaZNRiHM21+/mB0/YcXE9oCNDrDWuJgdgpxyLPyL86M/5OlH5ghuhA3VRgxJjA7RNiyxUMaF8IC/6RoQmVRrOjXQdZFRE4LltDs/8Jw2NCULuSZiLGcQqPpLLNwIilZ5O8WlMjhYcFKrzQ+Om5nv/E83CcMxcaswYOoI0ESk3ttu8WQQvYUFv5sMMsKHcW0vxkyxG9xRb487xHnydQyloLrVrIcXdqu2DSzRqNXFyUzM9W3PmZ31CPyKaLXIrQ30z3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULwc+bqSa/uJrxwtVDzzrjofVJnjYPemvZQBXERQjpA=;
 b=PZk4G6bD/cN4PvsjznOlZcY+bHgT+b1yjxWg97dUgDR4tt6oeXaCHyJURmBrR9RCfFY93k3SejWnr5GRJ4l6ji6IvixyPKDMZA7KAPlBR843ZuU2/eQL4YqT/1XAXBeC3XUz6bH8SLFlpcqGnUBLn3iVmDfe+aI8RBfibYTfFmte9Dk1N4mBKiqLZsq+6YtlcGwDpxb1L+Et/WWX9YI2PUfk9S/bWHBets/m4BgpIXlKd/XPzIxpuIkdzb/If8vost6KVX86X7uVuUXEhI4uySKkmPkWa73Z5NrP64zgOucS1tfEHp7vyoa1bs+Fn0CfMXTMBbP1Rs5Towxs9hXC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULwc+bqSa/uJrxwtVDzzrjofVJnjYPemvZQBXERQjpA=;
 b=kxcOesJBOtKdSwx9jMmc9UT1Lsn0JLo5eimgYoIifzrBklBMxhjrtsGwnW7pgRtVRX8uFHR98Lk8Mf206EDZjSIReNhd/Diz+yeGcRr6BiY4hUpej2xWFAZgSGaZgfMPw8qO8QKq4ARywv1eD9Y4iBEycdarvnOOdP0EdBTkCnfQePSbgYmvX9py7LsEHC9M13kmHcRHgt6F8oZdA8Dl+yNeAZweZ1PZ6OVKT7ZP0OB5byYy2Qu1/lstIdfOCFxlpzwaBjJsS4pkOl8Mue/xobEK/CHPaRNcGxezsa2vn/tgztrZBkXqrJlDBcg/ULO0C7CU5LCSSk5T12vh0dE/Hg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:53 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:52 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:18 +0800
Subject: [PATCH v7 13/15] drm/imx: dc-lb: Drop initial primary and
 secondary input selections
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-13-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a9503d-fb99-48b6-6c54-08df3348941d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021123027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3d0Ihy2WlcERDOGIwqpxIoND9ETg2sIC3CENLize9B/SqrXae0nHUEWVkWaJzdw0VK0YYHXXU9to84eNHNLci9+LJ6jNhaw+138dfN+8c9sWiJs0vMK7WZOmoz+ZmqoSO5es1R3jkE/wCQ6nlrUSI3Re2ruN2D1C+06Hf0wLbKDE6mFCWOUh5sXEZWjtEeya/CZY2k2aCtnbl6rFd5bTGnKvH5Rg0xRR2t3d6vZW18GmhtkTcDnM7sHphETQ8ADpjDMIFvs1KVBIXtSzIJOJF60TeiN5elkVxvAcZziC5giWGjEy+nn30DNG2u3/kPXdXrKKERfBLeH5ce8z1TslkMZJsBry3BHV5ji3xAG9+fkhM26RCQtYqx0W1qkJ7JbMGudfdJRcX4nhAF+uJhJ+GBC4SDg9Yzz8k2YIy+NdiKYJjfKiw0GoXDLg6eKRcMcyMDThYxKPGFWNdNKysLtAIYjI2vePLshpg0iH16aVgjMBXwPmMi9QAC8Dh5Sv+kOF60ZGW781Mu0v7B93U4n+c3d2w0BhYd9te5jC7VX8L5ThG+Fx0VwXrXvSuT1so+szGJRTFJVh5hiN2eMQrTF7VWLfBPkJ2lB6CszpBDVKAQR5/1tcaSCRSmAfULcI4Z6n9HHG+xNO04FkOqB/6zQZPDYCfZDWOtWa91u4bdFkJlRBvaqI6R51GIWotzqeCtcduB2DxCZ/zNPYu3iMmbSlDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21iK0p2d3BGaXlzTHdndktlVDVkRjk1bzMwVXVGMHRVTC9ON2d3bDRQRWRC?=
 =?utf-8?B?OG9lNjQ4Vy91NGpRZVhWcklYV083Y3M5cENScFZMM25vTisydnBXWlhJaVdW?=
 =?utf-8?B?R1FJS0F0NVk2UmRlckFMcUdGeDN4dWZ0NGlFbmk2Z3VCTktXSzVRMWhDQWJV?=
 =?utf-8?B?MHZHbUhkL3BkbVRkczc2V1ZSdGFtUWd0THFqQUhmRzVyeWd5TU53U2hSOUt3?=
 =?utf-8?B?WndBNEs5RGJKMjlvbk80aFc0S2lYa3V5WlQ2OElxakhGeXR2aWg4cUNsRzQ2?=
 =?utf-8?B?K1dFTS9iMDZrdnpIZHh1OVR6NXQvVGdHdktOVlgwd3dlajBoTE9pdU9rMzU4?=
 =?utf-8?B?YTJlN1JFdXFCQlFURk9tV3dtSTRGOFZnU3FEMEtIYTk3eWdtVHNuRllVOUQx?=
 =?utf-8?B?L0IwbkFYT28rdlgzeDRzbFc1UnU5Q3BQS3gzbytmTTVLNVN1dVNBUVBQSnNp?=
 =?utf-8?B?M2Y0ZTBYN0hZUmRENDlVWkZ1TU91TVc1Ny8xaTNwdFgwUHF2ZitFRGk4L2l5?=
 =?utf-8?B?eEU1NTVEaTIveHZ6dDR0c3dYSmp5Z3RXcjh2OFVuTlRNeVBubW9PS0x5aUlJ?=
 =?utf-8?B?YWVqQklOWHArQk5jS0tZbFlyUFZLVUhOSWtYaWdzQVRRZGFuVmdieTg3T2Vw?=
 =?utf-8?B?YmRPR2RpWndwWnQxNGcwSHIxbFhSUWZBZjNWb1lKaHBHKzRWRGcySlNDcG5O?=
 =?utf-8?B?WG9zNEx2bkVDSmV2Wmo0RkRSdHE0ZHNIY2x1WEtEb3N4Q0tVS1hLVXhtQk9G?=
 =?utf-8?B?YWpGZ0xLN1V0cUNpcm5jdDJ5dytNTURxMzUwRVpJYkg5NVM0L1YzNE0yRm95?=
 =?utf-8?B?WjRxc1gwdGNZZ2FTV080THIxYWV5eDFwWG50RDNmNEJ6SmtKSDI1anNGcnNW?=
 =?utf-8?B?NWdCbEt2WTgrZzEzMmE2dGNhOVJuSXhFVXFSR1VrV2pPMzk2SlVTWmN6eDlv?=
 =?utf-8?B?clgxdGxHbGFtNUZRc3BFYVBnVXFGR0tHakozWUl0L3lCVkhJTGszWmM4SVRC?=
 =?utf-8?B?MmFKb2Vjc1JrY2IxVE15YzZMaW5XUWJudDc3YUlXcGtjWlE0NHdLa2YySXhq?=
 =?utf-8?B?Q2pEN0VDcE04WkhRY2VadWVaSDA5Z3BoRzVPUnRnUVA5N1kraVZEZDRqVU1T?=
 =?utf-8?B?M0ZNVjRzOGtxUnp3OUxaeXNDQ29OdHJQaXdCUE5sSWJkVmplb1BtSGZ5Z2Nk?=
 =?utf-8?B?eGo2UENiRWZQK2picHE0dkZzUFQ2MlFTZ2gvdlg5ZlMxb1FMaUw2QkdacnFl?=
 =?utf-8?B?UllGVC81QW9GU2E0RUQydS9pbXk2T3p6MUowUU9LbVgwS2IzWFgxdFg5RDJ6?=
 =?utf-8?B?RHgvK3BaS1lyd0FoQStkQUJWZkVzYStFUS83c3d2M2lOYnBwWUc5bGplSi9o?=
 =?utf-8?B?TVIxV2Fqa1FVSnN1TjRaeDVwQjZIZWRvMmJTbWtDRW9yUEwxdW5BTWJqc1c2?=
 =?utf-8?B?aFExdVo2dzNNL2VBeHZIZlFTQTRBczFLbzU3R2F2RzcvVXcvNlBLM0Z6Uis0?=
 =?utf-8?B?K3MweUR2dWd2ZWcxTCtvNDdZR3V4bzB2Qmg1STAxVklJZzBTdVpLaGtEcjMz?=
 =?utf-8?B?WTV4Q2dST2hSVktEZXVyellmMHg4QUl2ZkI0SndSeFM2b2hvY3NjYUxxL3lo?=
 =?utf-8?B?RXhobmRMQXlHUlM5U05zdU1ReXJCK3RYOXhCZ0xtTGZ2U29kVnpxR2ZNM2FF?=
 =?utf-8?B?QW1KR0wyN0lqaDhIVUdGUXR3eCtyN0lqbndPSHFqMUppL2FKeHBFY1hxN2pS?=
 =?utf-8?B?dDZTUElJd0xXb1pvbHVRUXNnTjJKVVhLd05DZklmZGpKMTUwWjQrQkY5emtG?=
 =?utf-8?B?Q3hxYTR1dDRkTTd3YnNHTGFvaHd0bk1sazcwSTgwb1NCSE1wY3d4OU15M055?=
 =?utf-8?B?ejBDbk8wRS9ZbHhUaHZkZ2NCUVB1dmV6OE5kK2JlK1FNSUNkVTNFb0pRMm1E?=
 =?utf-8?B?YSt5RDVqNC82T3Q5RTg4a3BrSzk5c3NaYUdoK2h6N05ueWMrLy9pblRoMnJn?=
 =?utf-8?B?dzBMLzV1LzhjU1BLMUhDbW9nU3NaQ2dGMXdDZnIrNllvK2RwMlBUZ082TGx3?=
 =?utf-8?B?TEMrUDlPV0JJY05vRnhMMzI4QW1SN1JYVXRJLy9EcmZzcERLOTh4cWd3cFBO?=
 =?utf-8?B?VWhIaXB5TC9qSitYL2UrOXNMWjZTRUxDWS84dGV3Y1Evc1VwL3RqTWd0eG4y?=
 =?utf-8?B?M1BRYVhET0JRZE5UTzgzTWxyMzhOWGM1WGlPVUVtOEZTcGwyOUQ3djhDc0pw?=
 =?utf-8?B?VFBGcEI4K09ncytUKzRKZHQwUStuNlI1SHpvMHdjbjVQNkVtY1FUblArRVV4?=
 =?utf-8?B?bXlKdyszSDNTWGRycVdqWnplczJ5MHFFY2s3dE54cVYxdnU2NUtIZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a9503d-fb99-48b6-6c54-08df3348941d
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:52.7454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRd2yCYUTT5BpCjugaYVSs5hgRZLdwTgRhMQmuXX6/gZLdm47lrRtsCWb90B0dqgLJXY903Nm8hSg3BF71xAkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11500
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

It's unnecessary to set initial primary and secondary input selections
because KMS driver would do that when doing atomic commits.  Drop the
selections.  This is needed as a preparation for reading LayerBlend
secondary input selection when trying to disable CRTC at boot in an
upcoming commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
--
v7:
- Collect Maxime's A-b tag.

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-lb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-lb.c b/drivers/gpu/drm/imx/dc/dc-lb.c
index 03c361d25824..a3b8faa4b8c7 100644
--- a/drivers/gpu/drm/imx/dc/dc-lb.c
+++ b/drivers/gpu/drm/imx/dc/dc-lb.c
@@ -257,8 +257,6 @@ int dc_lb_get_id(struct dc_lb *lb)
 
 void dc_lb_init(struct dc_lb *lb)
 {
-	dc_lb_pec_dynamic_prim_sel(lb, LINK_ID_NONE);
-	dc_lb_pec_dynamic_sec_sel(lb, LINK_ID_NONE);
 	dc_lb_pec_clken(lb, CLKEN_DISABLE);
 	dc_lb_shdldsel(lb, BOTH);
 	dc_lb_shdtoksel(lb, BOTH);

-- 
2.43.0

