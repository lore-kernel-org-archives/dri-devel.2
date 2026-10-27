Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491860A2630
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s0G+/t4l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5674510F62C;
	Tue, 27 Oct 2026 15:01:31 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013055.outbound.protection.outlook.com
 [40.107.162.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E7510F624
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWMJlbuRVTFPhvkcv9BYFWEkZ5yrlRO1tWklnvinjOQ4GS2yc13cy3qhvVbH3Eq1UGTdEKl1qEr8ASDzHKVA7+kTVAipK+9+4/uR1hcPcAyDDbShIrZ1JLsz7ly+y70nhQNsJx4WGGf2AegRNzowkSl+FaDkZH4KXCJJm0IAbgCkZwcKufsOGko4g656m+aBTrcwu3MPlUzzsC8I5eNKtCUVNLoLdmHBBdLrS285UdPR1vryKOOCVCrXjBIRDPXnJOgIbPyVDzzUCN2DgSti1YJO1w6Xlxf+D/iyNzfMM+p9GiC4jsZvGcRFp7TEfeuT4sTdLWgadqOjuvRgmxZZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnJhSQ8bvHUna09o8tikGPof94rJn2Jm2sVUpR2/Jdg=;
 b=H66oWfb8OBu4eaPQX6T1TMytdwl17ssTqtxdyhJfjyPSe2xrnTdEXEX8FDa/RLuiOZAKF//cqd2UUrWeALKSo+xnaSgL0Bvh4uX2NMOwh3mP0q4/4L6SA5/UIem15s0dQXmPIVaNL4lQQh0vOV10YTrXUwCdGiopBWIeXGdEyY+L+hnhRWsBKwxbdpGD/rCuxscAMoAQxi6w5kvSN6BL/OJpZ7qKyi8pS0lhNuj43LVO0e8RevKZUpyTPqUhw42LU2AzYix+VSxMBJQ4XijWQRheF7nncJDFs2vY6C3FWwC6C8pRaDEtBpVetkSIZwWC9SZ/01izri4t9QhQfewsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnJhSQ8bvHUna09o8tikGPof94rJn2Jm2sVUpR2/Jdg=;
 b=s0G+/t4l97CXjkczZQwVTUB23SKZFeVhIDyb+6mpWHJhsfOj/+Tk0HRIoIU9FDKfXXj/vqR8mhAnDv6v+ca3CNvpu/j3UqmbX5ddcZmGsVc5ttRy5W6tgrqIhR2Ce0/5TcsMsvnPDzBOxEJwaLFFEpdJW6mHb273V5+pmBzotniSnmHg0FdMGgk7v3O4Mt4Z0zgyQ06+WvLPjD+BQP0VZNPNa23QDF+PYcuOvdrNfOvklpAehxojnIhh0bScAXjlEqqnkGX5u2Vgrt4SxM0kkXGkoBCiTf3nHt9OjpH1Nef7v6JLc4nbATaS5S58ir8wxYkdjrb3rKzQk7VeP3Z5tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11162.eurprd04.prod.outlook.com (2603:10a6:10:5b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:16 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:16 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 27 Oct 2026 11:00:55 -0400
Subject: [PATCH v5 3/7] drm/panel: simple: Add Waiken WKS101WX001-WCT panel
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-dxl_lcdif-v5-3-3a974e4b94b2@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113256; l=2530;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=py4DZOCqh20eUOcbE+aQaY3bkMFoUNXwmnyyIQIpgEc=;
 b=QJrFE86oHJiR+O7l9Ku92CkB6B1I/3X5BANOSBw8/oYSfR5fkbC+AJjsn/yIOQtV6Slr2e+ry
 jDgfZ0ifiCEBciguhkSdAq/vpWQs3Sx7TXYxCqMC/2v2mHGm9d582zE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS1PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:8:44d::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 713ff33c-ffef-4ded-90df-08df343b2625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|7416014|261026140227099003|11063799006|921020|56012099006|261009223027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: DxFyU1YQKZwCyP5NdZrRPI5sQf912JE78h9l8YB54Z1aA3EoxSVRgf0h6dm2PtS+Ul2DRa5pxhwgyMXRVoICpLC4oKXJaFEoKigZckcOZQhiEZVlz1OiydOzfljljhfxOlYIE61upxtNw45iHLovCoDgvqGNUOMlirQDE/Vl6QsEkzmIb1neKOUggMle+D0Q14AFcOLYNnDOJFFK/w6REpfgl6qoIsQSTB+J8YlqMIoowxv3YhHHLyMZBSojqeZqjqpXzUYHfgTYilH6eswQtimIzIHOB64dT0Et4LLxglya2C95j+CU84Mpzo7KrNzpaw49uuZVm/OMA/K4M2LCW+zm55AaiS4jDYwhKU8LdQJeWpZjEPIr/LcyrhOSUvkjC0/zmreGweMu+F0AByhvIz/YffpmHijA9ncW6AD/ITuQMIL/U04uQmhOS49GJavo6SZuHITiB9xbxDXxcX+R4HuHT1wyMFGP7jT8hS+H0k8UVy1PbuQB6pl4YMlKd+sEtMyeJ9+xB4Vnfobbj5nNFh827D5MGaR4GW1cMe2WmrOPxTTJ2B1jb66dW1lc150fp1OOUtye+uuCBYI+NGL3gi9oqcziRfjqC/znd0t68qqz4ADh36S3sg7/KxZcrSZYa+cN42Xgd7YgjjFM4vUbeTNRdqmVSkWo5ZOF/3WMdEUNbyWV8bS7e6GIhr+d+D6T5ECKXMMtUuRPoPN0DUiH5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(7416014)(261026140227099003)(11063799006)(921020)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFSWm5tcHBSckFmRytEWmt0ZHdvNXVPYlRxTno5SW9oYjUxRE0zS3lTQUJ2?=
 =?utf-8?B?ZDVkU3dTeGlCcGFQV1BRNFlCNGJOUUZncVl1MTJDMEc3a05lWVlMMXlRZXpO?=
 =?utf-8?B?Z3Y2a21aZm1leTlPMWpFVUFWUUJmVms1TzhNR2VkOHlhZFVDYmsvcnF6WEpY?=
 =?utf-8?B?R2ZyNW0vamZpTWxaWVNTM0gwSDVUalQ4aDBKbWpoYzd4MUh1NnFNWlJiU1Bi?=
 =?utf-8?B?TWJnaUU0NXU1TC9mWXZtZUkxenN1S2wwUlpvOTh6bWQ3cUdyMVRuQ3hrNlkz?=
 =?utf-8?B?Z1ZBVHVidWliaFU5cG5HMEFudS9rcUI4ZmhLSTJMZUIvalJtbzlWZ3dIMnN2?=
 =?utf-8?B?MUttUkFuRU9tZXF5OXpYWnRmZ2tzU1EzcU9wbzc3QmpwVjRkUkN1NUJoU2l5?=
 =?utf-8?B?YktBMnBPTE16WTdDajFCM2FLbzVCUE50cWhEenBocmxzcGlkRzQxak1iL1l3?=
 =?utf-8?B?d093ZkwzUEJWdURxazBReUpONjROb2NwUng1bGhHRkx3QWVDbkkwaEZjeEtV?=
 =?utf-8?B?c1hKdFQ3VDBUYXVCdk52NTJGeUxSeklHay9zcWVzOU4vSFlLWEFSWk1MSito?=
 =?utf-8?B?OWZUMExsMlRkdGUwMVhIdXYzekpxQ3ltY3hYMjk4bjJDa0ZlaUdmYnFJUW1W?=
 =?utf-8?B?WUc0MktKVE9MYk5jUjZGbXBlV2V5VFJpV3JSYno4dlNySVRqOEp2Zkgwdm5X?=
 =?utf-8?B?bm1XT0JNRTRoR2NxaEVENmNMTjkzL0F3bTBOWmxQSFA2OWZTTGRsbElYVXZp?=
 =?utf-8?B?Um0yaEx4Vml5djlsWkgxMFFTRndSUnpja2ViRVlGZXZSSlFCdFV0bTgrMjMx?=
 =?utf-8?B?MC9FZkFKK3pTQXl0VEpCaXJBSHE1Z2FKUFVkdloyeFNUcmxodkRBM1ZoeFY2?=
 =?utf-8?B?WUY3K25JaWxFNDdLSWRqcVQyRXd0aXpTZ3lMUFBKR0pLOTNTcWRXc0wyZ0xm?=
 =?utf-8?B?RXY3WG91REpHT2hFNUc4Y3RjbXdsMTdKOGFQb01pL1A4bXkwNVVZNjRwR2tY?=
 =?utf-8?B?VDMvcndCZGIrYkhKWHlxb1NkOFZFTm5BU3VJVkMweWtlcTJPTlZVMkNrSCt3?=
 =?utf-8?B?Mi8xVDl6RnpKNkxhMjkxQjk4U01zUktsVlJJbkVJNnRseFcwdVM1ajhPcHJ4?=
 =?utf-8?B?bWVhVld0QWplOTNRNGNNbUw2N3paQzkycWNjWlZQQ3pJTlhpNkFSd0Q1RGNm?=
 =?utf-8?B?NFdBUWZ0UnkxdkNCSzJvLzlVVHkrOC9oK2hqQW82WWFBNklyZmM4OFViNEdx?=
 =?utf-8?B?d044bVlFRElMbHpCdllRV2tBSElDNXBwNk11ZVRuM0cwR3RIRjl5eVVwZTZm?=
 =?utf-8?B?RGJDZkMzUEhSakpXRHFYaW5CbjVsTlRMWDVlbDlpdjFzVWN1eDNWWGdoL2R0?=
 =?utf-8?B?SXBkRmlvRSswRUNBTlo1Qyt0TU9Ic3A4RzV4UUJNK09NUUZ2RWdmMVoxMzh6?=
 =?utf-8?B?OStmOU1ENUJBRFZPOXd0U0dPczEzMFVWMzlsK1BDM2ZDNW5RSStFRzVkcVNJ?=
 =?utf-8?B?dHIrNWxRY0NnNXdFaklUdWlvb3FLeE0wQ3kyYnZCclc2QmJCZVhvMjVUYk5P?=
 =?utf-8?B?Z1dvU2N3WUlBM0IvT3R2azVlcGN0QmpxUGhrWGJpVHMrWnAxMjZ2VzRzZlV2?=
 =?utf-8?B?dmlsbTJGNW5qNTVRcGpETllGd0RCOXZLTjZneFMwV3hKaFN0aDVWRTU1Ykw3?=
 =?utf-8?B?WFRvbnVVakx0ZmNnR0hvSjBUcHhmNjdGRU5Xd3ZDWDdDSm42R0IxQWc3clln?=
 =?utf-8?B?cDhYanM1TzJlQmFlU2J2ZWN0QXFFb1Y2UVQ5NHVOTitzUHM0SWpGcWdRV3du?=
 =?utf-8?B?aWhtZEhHR05zMmU0TkV3MkM4ZmovTFNBQTZwTll3NFlWYnJWcmYxa2NRS0pS?=
 =?utf-8?B?Wk9QWE5acjk5bVFaMmtXcXJrdzI3T1ltOVlvMWQvK2p6TXovMi9KMlpYVW1M?=
 =?utf-8?B?RXlUY1AwdGd1L0drMGR5djlTcDVrVnRXZVB1VjQ4TzVacFpUa0s2OThZaFd6?=
 =?utf-8?B?T2RMVVM2OGRFcHBpOUMwNFgvUFpITDV2VjBJWm5rWWlvRHdrRzFhdVJFVDhp?=
 =?utf-8?B?aWFpQ0lWd2IwNkFoY1NKaFo2WGJTbU1JR3gvOXNMR1VmR3loTHNjd0ZPM2t0?=
 =?utf-8?B?ZzVjQkZucjBxVzZoakRnNEtKditpU3IrTWp1b2lTeXJsOFVybHd0TlBlMzFz?=
 =?utf-8?B?SmtQTXp3TjFLZlJjcUl3ZjZxUW55NVJJVHE2RkZLNnVxRlQ1cE5mNzl0dXlx?=
 =?utf-8?B?YXU2Z0VoSkpmUWlmbmc3ZHFGSWJUODcvSnloY1QxSFpDZmZibVh2VE5uTTFJ?=
 =?utf-8?B?Njl2TEc3K1lPRTNDbXorTXhjVHdwbDI2M3NvQnRNTFRhTklyT0h2NFUwV2lh?=
 =?utf-8?Q?pfPsZ2zpx5kpu8gMlf7Z2EWS6ROFLffLMdKxP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713ff33c-ffef-4ded-90df-08df343b2625
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:01:15.9710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zpip9pyjlnZYdFYFhRgH0zo91P/x+/9wf5hIaSUNJELXyXdYDjY1QjtIkpGtiTEbcmDNXImDCJgYvU5rBOlFHlH9L5jNjsCfisuWZ5YTk5QSBU2m+yCuJYZFJo/PGtTw
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

Add support for the Waiken WKS101WX001-WCT, an industrial-grade 10.1-inch
IPS TFT LCD panel with a capacitive touchscreen.

Although the module advertises LVDS support, enabling LVDS operation
requires hardware modification, including the removal of several on-board
resistors. As there are currently no known users of the LVDS configuration,
only the default interface mode is supported.

Acked-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- drop "If LVDS..." in commit message (Liu ying).

change in v4
- s/LDB/DPI
- variable use 101wx001_wct

change in v3
- add wct surfix and change to use MEDIA_BUS_FMT_RGB888_1X24
- Add information about lvds support plan.

change in v2
- update height to 135 from 136 (sashiko)
---
 drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d7dbd7442919b..5ef6a79f0de95 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5252,6 +5252,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode waiken_101wx001_wct_mode = {
+	.clock = 71100,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 70,
+	.hsync_end = 1280 + 70 + 10,
+	.htotal = 1280 + 70 + 10 + 80,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 3,
+	.vtotal = 800 + 10 + 3 + 10,
+	.width_mm = 217,
+	.height_mm = 135,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc waiken_101wx001_wct_panel = {
+	.modes = &waiken_101wx001_wct_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+};
+
 static const struct drm_display_mode waveshare_28_lcd_mode = {
 	.clock = 50000,
 	.hdisplay = 480,
@@ -6248,6 +6276,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "vxt,vl050-8048nt-c01",
 		.data = &vl050_8048nt_c01,
+	}, {
+		.compatible = "waiken,101wx001-wct",
+		.data = &waiken_101wx001_wct_panel,
 	}, {
 		.compatible = "waveshare,2.8inch-panel",
 		.data = &waveshare_28_lcd_panel

-- 
2.43.0

