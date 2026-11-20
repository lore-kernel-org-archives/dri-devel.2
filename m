Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF4606A330
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lT6JB8/G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0856810E8B4;
	Fri, 20 Nov 2026 12:51:36 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011033.outbound.protection.outlook.com
 [40.107.130.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84221129C3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiXRJk2bEuXyda7qFdxZCZxhK9lCZnBlWhKlMNozZOWdsuFHBXPzvMYsXDc/kDwYuWF14ZWO6bIKXDjBQNwAbW4uwmMr+0wCOIbR7M36TpqanE2/jB3U3EAxvp0tka13XxKavqynh/nI9qep7VVoAgq/58PIVLa8PZjwfhTMP8gVB8ynm/bRRE+VZbSxp6SlhN8OH7v/MTK+MVyyoyO2aiEN7wJL16vUgq2PVVCCrZ0Oy+sjOvmF7SoIginXs8l8sIrXD+90xUTtqgzCJVm0mFKA3AnXvkQMSaDgSQ5oosGJRfze/F/ZM40xxW4fbil1VUXcdDm7X57K3oN1AjZ7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcNyZeCWspoxJ4/jUwD8ysW+46j8TBaZwCoT6do/XRo=;
 b=eg8DiHUTzi9W8xRDkz3MyrpY7kaPqCWTq0leZmeI/v6OBf8V7UTjQ17YKQRl+eec67d36n+rBtCsIx96ooxjw6FJVLrDhwyEyjuXP6t2rHfP5SBnj5mAZY0f56nV0PnUW2lVSLmY0Fo0ve15lJl+wGyy+FX6q3sTaPhiwEIJcsWDNb5LgEJcNpwq+2IrghMkhgLZS9+osJ0XeiN+7h14NOLZu8OBg7foJDBc6A2Qq2yCDmTRHkB6pIwLRaC39PKw/5HY42qM3KXvYq17hjcqu4i5xBiIowNDeHoRy3mafvrhmKLaZZk0+Bt/YkD38CViAr/vkjK7TrAod0uyHkob0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcNyZeCWspoxJ4/jUwD8ysW+46j8TBaZwCoT6do/XRo=;
 b=lT6JB8/Gyavj7qxlIzq1+U3J62qaa+6A56Wv1DBx10xa2D3YkAYoHAiSfuBEjaPs2++uYVxknDwKeZ84yiedjb2NGsjhm1bhJ2Fpum9g5TAOF8wiQ9DIFMhVIC5LCLDUPF/Q0b0GiCgewZSsSE9AAF6OmdtZE1W8HTnc072d7GkswE/87Vi8754BEDFlho0IhkYuErpswrC8IkPxxhIMgzpGfSYLSqWmUH04xppM+fs3Noy0OXNmJdoZwXyt5Ks2w7VlFqtw8etzNdaT90d/8E30LE0FOnDihQaRa5u/mwVcmRPXuFS1Eqqg3ZP3K0cnsjeBhOvVH4r30hWGqU4f/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB12061.eurprd04.prod.outlook.com
 (2603:10a6:10:646::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:51:08 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 12:51:08 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v13 3/5] dt-bindings: clock: nxp,
 imx95-blk-ctl: Add LDB bridge child node
Date: Fri, 20 Nov 2026 12:50:38 +0000
Message-ID: <20261120-dcif-upstreaming-v13-3-966ac248773f@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0036.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::16) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB12061:EE_
X-MS-Office365-Filtering-Correlation-Id: cb40cbbe-4164-446a-032c-08df4704f245
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|261009223027099003|3023799007|921020|56012099006|11063799006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: ZjbHHMARX8x823Wv73vB00Zk03EaI2pj3Y2jSyBSz9GwmYCOpfOMVzCniIKpkSfp8yPX3tPP8TVCDi+LPNo8Ne3PoArmxIjy7F1+PB2heMZ1vaZ7IRmXAUGTmzmYuaZekqAuocKje60efiq27PfpLV6o2RxRm1eK15I0uaYMIzl/svg1u5LiYVlCk+f/24CHddJunFjUMEUWFlZn/B065VM1uTfFyISteKR5kTH4uMnA/1KKkzQOLwYtbIgtI7XvdaU13QPs22z9NGayMjlY64JukPtYDlacOVqG4oafZ1NQTbdjFDJx29Ej3YucLX32cYV1wQLQWh267Z67ppKzB8Yz44GmQTJQqqhCiNxkNsgrmJYJ8hHg9oWDa5PU5vfEHD9PP6zQCZyD80qZVlh7gGb4XBIVzMBMn2LohCfCJWbEc1S7x9ewRHVmkEY/y9JJZZ7pLjdXVijzbRePwIYhFnuZ0riccm+rYekPoUkhqqIst6GLc5nq4D+aHPivWSsGNVKlmS56BgpA6jvDyc5+DYDsGMUnFTDZW0/mPq8FCcDtGenEq15zyPOAGhKgGi917U5WrGW83KKmNSiKJGtcefoLuGRfPXU5k/RXNltK9DXiwYOD5P44b8fF42Tjy4G9wMNYzwWjFlIWNhaT1e1T8YEsoofGxn80viV9kkx4Z0oYmypBhKm+l72fa0UhWs/1PRC9dztLNg2oQbKHmzwxpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(921020)(56012099006)(11063799006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckRmZThUKzNwbVJyNDE1dVJyRUhzejZhcWRhSlo3VWdINDFGcmpNMmJpazNY?=
 =?utf-8?B?c0xaMzdDci9GbXNNRVlLUmlFRXFVSExNWkM3VzJnK3BhdlJKYktSdDlKamZz?=
 =?utf-8?B?dWdWS2hGS0RLYnJCMnc1S01wNEVkYzRCZlNiS21ab3RGY3FqT1dsZHZ2UXk3?=
 =?utf-8?B?MXZ1WDgrcDBXRUlvSFhXT0IzelZWbGEySXRLeUNQRUVERzRVKzh2Zk5hTUpF?=
 =?utf-8?B?aWFzOVd3cjVQMExLUXlyU1FacEN3T1p4MytGZnFCZzEyZkViVkVTSU9aK0I2?=
 =?utf-8?B?WDNPNjJwZWVTaXRyVEtTZTdkbWtGOGYrRnJEeFJkVjZ4cGROYml5U1N0VUFZ?=
 =?utf-8?B?MjRWdXBoamJZODU2RDREdUpIaXp2UlZ6WVJmdUc4bllBUmtEVk1DMzIxQ293?=
 =?utf-8?B?dHNxM2lXY3hMZXRiOVZIZ0tmM1hELzhhMjFrQy9sU3hBZ0F1ekNsbmdSMHBR?=
 =?utf-8?B?ckwvTm9QcDdMUGZKQUs1REtTVEM0TGJ0K2FhSmJwbEZHYTBOWDlaUzA3WGlI?=
 =?utf-8?B?d3pDVFlXUENoQnBOWXprSm9wM09ZUzIrTXdyMlp4dElSWTFYTDIraW5sK3lx?=
 =?utf-8?B?MFBYWit1VW1EMXlkbkg3OXU0UjN3MEozQXYxdUVScWEvSnZFUk5uaW96MUVY?=
 =?utf-8?B?RndaNmoxWkIzeHU5RGVjci9YWjNwZ1N1bXFvYTU5d3FwVi85b3JEN3FyQnhS?=
 =?utf-8?B?TStsL3owUE04WG5ibjQ4dFB4ekIzaENrVUVUS2p2c01JTE5ybnh1bitxbitM?=
 =?utf-8?B?NFZTZ0RpVm56VTFEengrV2hzOVFHb1IxWVdvR0x1NjBJRUVSWHE2QVZCNGF4?=
 =?utf-8?B?MEEzWGxJZEozMWxESlI1d2RBcFhEdFB6YTArdWo5NVIzMkh3bkFpazk0WllE?=
 =?utf-8?B?OExxWTk1UFNKQytnV3g3U3dyL2pwVWdJMHprNXY4amlBa002cC9XcTh1d3Zj?=
 =?utf-8?B?WThtY09LSzMyMjdLVkdubFFWbExHTlBOQXRtd2xVNVA3Wjl0NzBqVzJVYzU3?=
 =?utf-8?B?cDVpMkljZk1xUk9vdytFb2V4L2M1SmpOWEhhR3gzRnllU3NualkxUWtSSUcx?=
 =?utf-8?B?MjJWSlVHNUxnREMyZ0pxMEpydEhJcmkwNkU1R3BkamFsSkRVbHpoYmVGQi9j?=
 =?utf-8?B?Nk9TWkFWM3A2SVJmZlJZbXpDTnJaRUhjR2hHQUxQZERUVXZJV3ZiVjRUWDZl?=
 =?utf-8?B?RG8xR0puMWZvajdBTGRUQVUrNXQxeWllUm1xaUFoYWlHK1RiQ1ErcnZCTHpC?=
 =?utf-8?B?K1FTVUVtbVo0WlFQaVhENXdPRWJUYlZVLzBXUlIwVENPV3krYlFneUR2S3VV?=
 =?utf-8?B?SnZPQXl4WGtYbXJsRHdUaktnWWphQ2MrMi9aQnpMOGcxS2NlVytlQkU1b1BS?=
 =?utf-8?B?cVo1cE9rUnFxOEkrNHZUM25tZE1uR0tJNVhPVmcyNDBpSzVnUWN6SDdtOFdr?=
 =?utf-8?B?SmxUbk82MWVCckhvSklvU2FFUC83WXk0ZElPN2NPREtQNS9IQ3BhT2FFYTFS?=
 =?utf-8?B?SjMvU2hQdDF0Wlh4aHMzTVNxdGs5TXpkZWYwbGtGdVhOMEh1Tmc5SzYzM004?=
 =?utf-8?B?UWNLYzR2MTFBdks3VVBLK0Y0bTdEVFhhWXZRWEJCclJYekVWMjBubE8xT3dM?=
 =?utf-8?B?WTV1bEVZczRQWE9laDlPRzljWWdrVWVaQ1JGRERtRkcybnBhNWp6OEEveGJx?=
 =?utf-8?B?bldQTVd3WDB3OHpwaWRhNGEvQW5pbE1oRms1bWRjd3dnbW0rdnBEcEhZTGlw?=
 =?utf-8?B?Tm1OTFlOU1dRZ1pIWncwN0xBRUdaL2N4VFAraVNrVGhZSExoZjB2VWpKZG1X?=
 =?utf-8?B?bXFxa1BXSmR1bE9EdHJFN3ZweGVPRmdWQldHNU1wUmFqWEpMM2pkMW16K2VW?=
 =?utf-8?B?Z25IekZnbGo3L3lvc2x0d3pVa2ljeU43WCtUeEg5V2VRZ243S0FpQkNiZjZP?=
 =?utf-8?B?YW9FVytMWnRLYkl0dHlFdVZ3bXNEK3dMY0NiejRGN1BJZ2xWSzJEWUdPOGZo?=
 =?utf-8?B?bHNsKzRNbk1NOSsrSSt0VGs2YWVuZkNnY04zbWl5SmgyTTdVK2g1NDE0RHdD?=
 =?utf-8?B?VVhaZHkyMmdVMEp6L2hmSlJkUmN2NWtvYkgzaDU0cUhsd2tJZjFkcUhuUE5h?=
 =?utf-8?B?VjQ2d1puRklFbmx2cW1HbVhQL0dTV1ZPZUtxeWZ5UUtVTXJqNjdnRDRabmcv?=
 =?utf-8?B?dmlnRnRLR2cvamlyUm42OUlNNUVwYTFJR3NiVFluN3ljMVpzWjIvcjNYUmRk?=
 =?utf-8?B?aDRqRlErcHc1MkhvL3g0blp5TDZCWjRTLzE3RDVwRTVFbGNSazFvSXM0K3l3?=
 =?utf-8?B?S1YzWVN3NGRDOVZoRFl5YmxRVUphNXNCaVFaMmtqNG84a2xldGs2QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40cbbe-4164-446a-032c-08df4704f245
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:51:08.1212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHzd4X2yeHOKXX6XwOKURWEa46WQac6BE6S2jV5bzEA9e1lLEb0n+nvL5lFOoDE8GbemJZZgbZ4yg/zPWV82Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12061
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the BLK CTL registers, like the LVDS CSR, can be used to control the
LVDS Display Bridge controllers, add a 'bridge' child node to handle
these use cases.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index fbbf1b3f17904..c2aeb434a8102 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -51,6 +51,10 @@ patternProperties:
     $ref: /schemas/media/fsl,imx95-csi-formatter.yaml#
     unevaluatedProperties: false
 
+  '^bridge@[0-9a-f]+$':
+    type: object
+    $ref: /schemas/display/bridge/fsl,ldb.yaml#
+
 required:
   - compatible
   - reg
@@ -63,7 +67,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: nxp,imx95-camera-csr
+            enum:
+              - nxp,imx94-lvds-csr
+              - nxp,imx95-camera-csr
     then:
       required:
         - '#address-cells'
@@ -72,8 +78,24 @@ allOf:
       properties:
         '#address-cells': false
         '#size-cells': false
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: nxp,imx95-camera-csr
+    then:
       patternProperties:
         '^formatter@[0-9a-f]+$': false
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: nxp,imx94-lvds-csr
+    then:
+      patternProperties:
+        '^bridge@[0-9a-f]+$': false
 
 additionalProperties: false
 

-- 
2.53.0
