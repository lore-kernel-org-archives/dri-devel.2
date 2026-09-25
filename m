Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE7EC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68CF10E57C;
	Fri, 25 Sep 2026 16:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s8NsMYxT";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656E010E57C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2XJanIzX8+JLAaB2TwwI9YI/1yT5+PV9z2YRED0VnAolB1WAOgVMonB1PgDYp+NJpLLxJu8nmLJNcC2uto2GQohGIqsE6dXsQj1C30/vr3iXJye7d0L1PkDtUDoNMKrBYphW0PGvmpm+8l1nOULcwuX7XVhGNPKJ9bXxnhzm0lDNg/eJrohWk8g/F0zLI9BPoQDpP1weVec/RIYv9+lqwDTTyk0vGlGIk/7UVxZGtCxMPdEf2Qw8pJg6FfeU6psp8eKt+pdxuBWG5jxM5sYme65gksYoOJFEiqpJfR5QKeXfTMnwYoh7nCbx9GaPPI7tBG+iPXXAoeiviERE1ygrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od1gIxYtCm5Izhl1hOixN5o4R7GAXh90U3r0LP6XIxk=;
 b=x/+IygKRZQN4YVPUm3Sl/hUS00j+JrVh3R47b/Zb0a0X410ReIi2cHKvMeK7BvEA9S12nMPUcHq+F1SlLknrjBlzuG9hjWaukHpucdmX7HwwJpPzioEdLtzUO/rXdRVgisHiQNjSYdE8xWGNIPtJtMaj5XFt7+bfwaBCouhOuYE/AYqs289GyANR7MvgjRyirCp2m7TRlxEMFl9k14AQwVSNVL0+ZwWuGmmSMWrn6/isYlZWQsVCyM5kHPJ1VUFPOi+riJqbPbwTNLs2m/E38/79MUjzjTq2x3TqRsvFRvLczIWzgrF1iNJCzDditXylbSbtMd4AcIdvl3aJAKFRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od1gIxYtCm5Izhl1hOixN5o4R7GAXh90U3r0LP6XIxk=;
 b=s8NsMYxTCk246j2XK4q33UTMbYSMO1ogJP9Sv2l7HSDwnQ4IZLIOAth1RSUtCa5Na6Xv9u7mDSI9o0vUITx2z1Ye2sn0uIAcRhf1bPN7Tg4B7EwRm9R+wuak00iuqXwT7Lzpt1O9aOOfZqbaB5mJQ+1PUqq7lHFiH1xUc8E0l9Z0pLJnjCqGVfUzqalTPp3PgtP96YGSXWdStuGplDQ2Zoylmbpwk91nMtVlMfi2ObPgobDuM8lTfMHCN4vNwyqlo0aHn6onj2rLxZzYs/4uQtcnwDRL7AruruPAvPuDtXBv8lBfuPjrzaSx9ol7snwD9Gew2qKLBUEhZGQ7fT9gLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:04 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:50 -0400
Subject: [PATCH 1/8] dt-bindings: display: remove #address-cells and
 #size-cells off requires
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-1-f999fafbca60@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=748;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qHUFLU7shpDVANZJBenLKgb0+ay8A2hignVU9mAoVMg=;
 b=cfR9rzIXrSsM63tJByuERxYSDCLQMaCdPDmTaK5iRlZ9wjR8rRb4LgmUnM9lSwP/WijTyyf5r
 Zh0qjPEHcF7DUYAE4TxZs0AaLSJpEBjhXP6ESRHM8wTTvj/s22wj11y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY5PR15CA0166.namprd15.prod.outlook.com
 (2603:10b6:930:81::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b366207-b903-414f-b445-08df1b235f2d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|921020|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: pYdwtJm7pUOzbmlusMjFpTw8Osg04QzeKcxghCSBDknKSHGyXUX8fjY74LdvgRq7nNNKsiX/Ky+Li7v7tLF7nYwlAo8Om/+5y/nJSRYIwqHwSML4PsnWYeg9dAZ81b24FpWtYPXkR6yDHkNQB/WWZB6YbycezL0qQgjVMa7OdKiWn5YelTeL84l5wezVvJnyaR3XYjtj3NLQLYWloXRO+ctQpwUq85uTV/EoQWSMR26iHZ/89EEkyPNHzx4Q0iuhBNIqJ8Ket7EoyB1jgtxOeFwkUHn9yyXTKzUOKlqErLvglwpwlkBldaLUIoI2kyVOnSX2lU7Sg3Xn8xj8KlDKDHQeAQiMf8Nenga1miPGQJ8TdEXw8MKyh6raIKeXzEW2p8YchL7+eexjPYa5996jc3yiZdvAqQLDYH32y1nJB4/7F+oYM+zUrZG4yb34g49PNWcvZbS56irxarXIMW4oprppNPOqzJKw98GsCYQCv2KLloO4zjVSdMnqqnSYXXvnXBVO9VDjphKd9tnZLX/1lckpZgZ3LEpdQXLya87BZu0KrFJIqdZMvUbsjeWq81bpLIPnpf2ZprV+OCyx8/+a9Y6+Ce6GkhM2T0VK2weaVYk7C/f8q99IYLYN5vWeg1El9bCCP8kUM0pMfOT774q5/iRHZMJ1pXPizpTj/ZsWtMuLhy2UV4cWMv5Z1PU/oXEojsMGS4ndijQSSa5nQwY9TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRobU55NDl5Z2xRbkVxbG1GbEoxS2VVR2dwcDFUT2cvMjVhVzN2cHpnSUpL?=
 =?utf-8?B?eUF2T3RyVkl4TTN6T20vK0V4cmpobWkzRmlGZjVCZDlueHl2ZGFqZkNhYXZr?=
 =?utf-8?B?aHhxMWVvTE40QW4yOEtLWU5zWWRxZ2tLMUU3UFVMQnZDSnFXRS9GSnd3U0sr?=
 =?utf-8?B?ZXh4TkFOU3BHaUJONFE5VXVPTXhyK1A1MFUxelE4Wmh5aEJCUzArK2ZmUnhB?=
 =?utf-8?B?WGw1WVNUd1NsUjZZZWpyR3pUaytCeituYU93MWo2enkwbTJ4dGRQUmpQbmtz?=
 =?utf-8?B?ZllTVEhYc0tiZFA0Q3d2ekJkTUF3ZGxvVVF6RnpwR3lSTHVzUU45a0M4Y2FM?=
 =?utf-8?B?dTN0QVgxSW1tc1VndmUyTE1BV1g0RjlyUUNBUVJyQVUzMHR2b1F4VFRmUTVs?=
 =?utf-8?B?ZDZpMjY2YTErMU5FbXI4WjJjZG1wbDJUdEhyM1dPdWZaOWRzOHdPMXJ3c1FZ?=
 =?utf-8?B?TWVieDFPZnR0M1lTVDRKRzZaNTEwV1dFNy8wQ2trK25jbVVRNTVzZkxxU3Y0?=
 =?utf-8?B?ZjVUNTkwcy9yc1k4RXVQNzhUcjRCV0U1b3J4SVBqWnRFUWUxWW5iaXFkZFl2?=
 =?utf-8?B?dkRObHJmcWdYanNnckdwSDMxWjh1Z3F6U1c5bEZBZC9aUlRCSUcyM2FVNkRR?=
 =?utf-8?B?ZUVPZ042MGxHdUJNY3JUVjFyVVczL2U3RTNkTEJycHVUWC9WcW8rR3d6NEVz?=
 =?utf-8?B?ZU8yQnFhazZQcmgySThkVFRic1ZZK3ByK2puZlpzNGRWcFF0STltd2NSazkw?=
 =?utf-8?B?S0lKWlRQWjE3WWJtWkJkOHExc0RwSnZmTXhRVVIzUldGSU1GVVJnbk5SRDlW?=
 =?utf-8?B?NjIzeXlkWTFEU1pkcnRWaThOY3N0V1RNYXhJVWU4OVV6bmJQYWYwSmN4ZzVT?=
 =?utf-8?B?Rm9YOFBjTUFxbitaUkMvUGZmQlUrTUV1eHJQME5oYncvTDB6L1dxZlVmaHd3?=
 =?utf-8?B?Z2hSZDd3cnQvL1FSMVd0SjJNZkxEU0Qyb0V6Qy9SMVpObFNyak5KOXcxOE1W?=
 =?utf-8?B?TkF6eW1pVlBUdi8zOEJnd1luSXFKVE1LN1JMSVRXQzlsanoxZWJVTVcrTkI5?=
 =?utf-8?B?bTQ4ajVFeWI1b3dTUUdxU3ppRE5zUmpaNWh4aVpvV01GM0dnNjBPNmlhcEY2?=
 =?utf-8?B?N3VjMkJoaXVhNmpKTWR3WjBMSWhCOTNCemJISFRrQ2F0d3RhTVhId3FKMHVi?=
 =?utf-8?B?YW9CWkMrTDliM0pqc0xPZnYxcTM0TWdvQkM5eVVwYk50d1ZPL0pGM01aQUJj?=
 =?utf-8?B?dGZTOVZNV1lRc3Jjc1NZK0VVUDg5eFowVXpvTkpNbnpsbkU2aVFmTGQrM0Zs?=
 =?utf-8?B?OFhZN1pQTmZob0RhbXdsN2JsejlJVFpOcHByelVNOXJ2S0RSVWhuT3diRDl5?=
 =?utf-8?B?b3ZHK0owL0hGQlFXamhSU2FrSjloSEFnc1pOVkZNam9XL3pzZEtDOFd4S040?=
 =?utf-8?B?K3ZXTnZwRzFiUTFRc3FWcXBLbnhSUEhtNTVhblJ4bVJISEdNTThrT1l1NXVV?=
 =?utf-8?B?MUp5R2hxOEhKQUpoSlpibERuV2NaVkVhd1oyVDM0Qzc1WVpPN1Y4Ky9NNXAx?=
 =?utf-8?B?QUNFNEZnZlRDTkg0Q0tpZ1YrQUR5N010TWE2RE93TVgxRk91Sk01TEU2d3ps?=
 =?utf-8?B?VU1uVXlCZlE2S3V3cjIxdUkwYTg5TjFvZFY1RFV6ZW45OGVKYkZuTHdyMFZw?=
 =?utf-8?B?QlhFd2YzcVVpd0N4UTZmVzROdEgwRUZUajBCdUN0TTdsNDVPV29ERjVadm8z?=
 =?utf-8?B?MndISVUyTVM3ZFRxd2VrdjhRQ0d5MFBSVUd6NHF0WDRsV2Z6azRueXVTVmFs?=
 =?utf-8?B?OVNaT0JMYVpzVWZ0cUx5UEN4Z0VOZ3Y0ZVBld1RPcElGNi92R2pUemZZVWhK?=
 =?utf-8?B?V25KL1gybk1WNGtzVDJlenVLNi9Cb1dOOXBnMmZ3bmRCby8rUUxUejEvR3dB?=
 =?utf-8?B?SlZxT3lQMFRwUEo5cm9UU3hoSVl4MDJoNzg2blFlWldnSTU1VVhrOGhBSnB5?=
 =?utf-8?B?MTU2bCtyUS81dnhsWjRoWEZWS2gzM2pZMzRuL1B4TlhjeWMxS0lBN0tDK3I4?=
 =?utf-8?B?elBDSmI5QW9IYXRnOUEzNExIM2RFSmRGa2JSdEYrcEdjMWFNWGhFc1F2NVpF?=
 =?utf-8?B?c2wwVmdjcHgwZUJuZGpHWCtZTnFLVmhIa0ZydHBDcnlUU1EwS05YSWUxQnov?=
 =?utf-8?B?MUx1RW1tVDd0SFQ2OGlraVJBdTc5NmZZaVBjSXNaano5aHh2cFVlcmdMSDRa?=
 =?utf-8?B?KzJ4anJWSW5jTjRWaFZuWGc5RTR0NEt5eml0dDJ1UzBDM1MzRlB4eW0rUU1m?=
 =?utf-8?B?N3EvdXZCVGEwclUrSDkzUk1mTk1KandLbzQ1c2ZpRmFvb25GYXRmdlNmNU82?=
 =?utf-8?Q?d5psWfrfIlU6cl4MqyCgV3iz34DPVl8cwS6b8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b366207-b903-414f-b445-08df1b235f2d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:04.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl7QPOk6PRn+3Uoo5yGhN0gPcnCfqabMQIKL2LXnCagPIJBUDzuF8vrpmfolM8KufBoz7+7wa5BN4CSe190iQuhqJYn5KOAPw4n7SahXzdt7myjUytni+KhJ8o3Dm6NG
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

The display panel node is not necessary located in dsi node. So remove
these from requires list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
index 5952e6448ed47..a0c3ba9275684 100644
--- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
@@ -137,8 +137,6 @@ properties:
       - port@1
 
 required:
-  - '#address-cells'
-  - '#size-cells'
   - clock-names
   - clocks
   - compatible

-- 
2.43.0

