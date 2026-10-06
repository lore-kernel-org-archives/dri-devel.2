Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D127CCA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B0310E347;
	Tue,  6 Oct 2026 12:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GcSHzynp";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354D210E0D5
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daAHs/wKCYq8/FMHckyOpx4AMXofG2sCQWMANASGvYjMrILWZYpihj4OWALDVB4FQtn9DS5u95mn+7jpfHoe8cTl055GcgYkLHrsGqP/fKL6Gfpe+7L/fI15sxBWY2UqoiP2GOwZUW9XZ/Qqtt6RIo8h2FFUtRaHirG8Y5OpGAkmnAZ4+/On0v0Fiv4q2K2jpKW58wHTFF07t/7LbZwbauYztF4UAo8Ye0CK1YwUviKq8UTeqgYbKoLx2POEmh0ZOMuI+AEOS3XQaasdOQo9huRxRGcIAYjkpXfAr1m08IZIf2qUUwKGfxX3a2PHD52FSoUJRvMFukS3rdQaj8wLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSuBg/8vgUhg3Bv+8oYUYC+XurU5pzoFb5j/RxSiAU0=;
 b=gaM7pHm8jjfgF/EPup68dpMW2E2cNN5C1ZvJHjmJtRIx46+Wgm2aR6K/ggEDDQQyX8H45W3/LSE5qJJshS2jVNZAOKhVtOsn8QF18cXr1K3Tk3rFhsPRWFTQ5Bc244cwa+GmDhC4iq3OMJjjinjY6fb93YBOtb41zvGuw/ul30blau0WNzGkoDFt05O85OrBZP3nipUM4HQbwmqJ9HWfL/63/otfyvP/263rlbvZGpwDuvVhFJ7Xb6AroxoxAoQ8iLRTq2tUaFVPj/ivJabJWtNiE/BK3yFH3JL3XfVQ1tgG1XpSv2BQsz0F2lwVkagT8DV1r2TVB2tnRGDIMUVoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSuBg/8vgUhg3Bv+8oYUYC+XurU5pzoFb5j/RxSiAU0=;
 b=GcSHzynpUDXtF7+rG95c4etqG6+ciQiiM8MSmsUyD/+rVNR6X/kX9BcQWtR5brV3I8Abmf4zN2wiJ7OcXOQNp8rMqGQ0aVucmK5NsK49jq+0SZDdltG77d5uzxXVsxbXI3x9Zl6nV+W3gWbzylycTJp4ZPj3NN//OQVhbYjN+zRvnYS/e4qvJKnhLJKNOlOm1rRdkMQ48cIrdz7EA7xAegvkhdv9NSvLJ/u50hGIb2u97f6+kXrDGzSgf0SU8h+5bRXUCN9Zui27ImWileglWkoTbBjX0ZW5pHKY7MCPF/EbjfbHdkOI/unLP4jru2R6wmUEVYfgK+hTkQxpJ/s9Hw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB10742.eurprd04.prod.outlook.com
 (2603:10a6:10:58c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:23:26 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:26 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v10 6/9] dt-bindings: clock: nxp,
 imx95-blk-ctl: Add ldb child node
Date: Tue,  6 Oct 2026 12:22:01 +0000
Message-ID: <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ecb8aa-b3e6-4c3c-dba2-08df23a49efa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|7416014|376014|18002099003|22082099003|921020|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Sn6Hir/CtOMH0gqeXSkv3c4CTZezBPHL3WDHBh4IynygVplhoK+lMupA6ewDI0eZvY19/W10lMMIEsl4O4zDgs+01QBy3Moo3taY2tsBYm67WQLddpq65zd5xCzSdKwvNr7yMl8SZxOEBAIpjibNg3N1bX340ArF7pJYhq0fVbNYQI7bcWNwpW+hnXkTtDhIMNeg4x57RNiRWwnjp04D1+2USc7v+Nv+qIpK0m+p0ti7IgQKWd663WoB411WMqglMg4NpXIIzisHwM43b/7eRtBxgKfAfH/OzAUCIub6z8RdBnvavwScW2lyRn3gIG0stfVQp1viMgN29bjK9JhTzQNXswT7VjerISHqmIdXTilQEdZZy4KpAmxdTXEI1Gy1rM8ccbRUnuFsVwjpVO9qmaRXPjIgu/cndCBHvbPWs4GY7GWXS+TZafCqsCPfXjvJFZvsvwG/LssuZDBCbYCun2swVAoBTuBwcv+tQcaqUoDMH9hCW7fGl5IViSM3GnwJc53VARfkVg6m7dQWknxSP86Cr4aZONYWUuk/PqQndbb6nT59pUdWf4ReB/H4bphjOrmphDsGcv9yA128wyjcScLvZUS1pkzMjZCgxkRuiN9iumQcQRvGENZJMMb3sXbbjJIQeYGd0Twj69iF/knUIhb3HfHAAxJ9UrAS7O1ClD7E13XXp93zT6C7FaZscmdv2kRgz2apWdOZupJEtUhlKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(7416014)(376014)(18002099003)(22082099003)(921020)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVZNHJDUkUxZzc3c0FSSVJ4RVhrUVdOejR0UGFINXcwNklJQXk1MGFoVnlL?=
 =?utf-8?B?OXR3RWhnNDlVdUFaQS9YeDVqbG5kNVVtRkNJV1BDbHlyOXd4MDl1TURqVWc5?=
 =?utf-8?B?ZTh2Mnp6NXE5VTY4Rk5TTTNJZ2hDOEltaUVackRLS1VhNmtHVElRbStiUTg0?=
 =?utf-8?B?amprb2xSeEY3N3NDNTJtaGpXWFRTTEV5TGNNMDJQRy9mQkxDYmdsS2p4WHYw?=
 =?utf-8?B?OGZCbXJGbzN2SDQrQyt3ZytnWHZBS3g3a2NPd1R1aC9pUmhlOUxPWEJzd0J2?=
 =?utf-8?B?dS9qWGVuSmovQjhXemhkNGcwR1lOSmFvUkVpZGszaGVhY3dSTzJ6M1B0cHEw?=
 =?utf-8?B?Z0FleWNyNjY2RzZEOWZ2UHc0aVBZRHN2UDlrOVFjd29IYnZTbUptVERQT09V?=
 =?utf-8?B?UURZZjU1S29kMUxRYktIMSt6U3hFRnhPRWM0am9JOXVIWkpYem5Pc3JKV0Rs?=
 =?utf-8?B?emFIczBLYkx1L1hVZ0V4OURyRmtLTnBhMHdBemVlUUQ5b1NDQm9xQ0VuWG9Q?=
 =?utf-8?B?ZmZhVXhJQ0c4bEJCc2F2ZjVla2kwTW5vSEVJa292bHMraEtKZCtnd3FyWlVa?=
 =?utf-8?B?L0VMWGNDTzdFelQxaUNkaFIwR2ZDdE9qYVN1bEpQS2pHSmhCVGc2NEI5NzlW?=
 =?utf-8?B?RFk4MU1hNU5CMjhRYUlNcmJBNkVwK2VrY0lVcit1UHBMdkUxeHNUWGFHMFgv?=
 =?utf-8?B?bkhyQTJIQTBGREFtbm9iajd4MWFtOG1XVXl2WElNdmYrRlBmWUlBa0Q5b2M4?=
 =?utf-8?B?VFQyVU1WTHBtUUs0K2x2aWNTZ1dyOXRkZ2lGdlZEbWtWdXZFcERHVnQ5SzRN?=
 =?utf-8?B?VVBQM3RyOXpGOHhMZ0pWZjdqR3ZHVHFVZ29yTHNaa0k4NDdqU3RFV1pvd04v?=
 =?utf-8?B?eE1mYmFQUmg2WmVJeldyaktGV0tqZmRaOFRWMlY3VVBSS3RoQUpWd0hpUWhF?=
 =?utf-8?B?TnErTVRmQzJUSEN6QVlZK3l0MHdtSlNtVGc1c0tvSitFdU1RbjZTeVZRRFRM?=
 =?utf-8?B?T2tJQXc3SzRNOTNYRGJvZUZYNXBSeDl5YlBFV1RjbUVVUFVGblpma2tCTUE1?=
 =?utf-8?B?SnptVXBiem5tVC9IRkdHUHZYSTB5NXdZc3FTVHNtWjg5RDZKM28wT016TXdE?=
 =?utf-8?B?dTU2d25DbzFrc3V6NE9LbUVRVkh4dVk0ckVuK2FKblFIaTZ6R2xiL1BoS0xO?=
 =?utf-8?B?dmx2Z3l5Vzh1SnIvRUsveWgrbTgzOHhzeG1qcEYzZGV0S2VsKzllRFZ3dkhU?=
 =?utf-8?B?eEVyZmE4YjFtQVFZWUF5b1MwenBrUkUrWGRibUhVdFYvcnFiTXBKcmZHdmpZ?=
 =?utf-8?B?RXRCZU1NTUdKOUJwMW4xL05NYVZFdVBiaG1rWWIweXA3V3UyN3YybnZYcUhn?=
 =?utf-8?B?V1R6dmpldGJTQ0M5RlNCbkp3MEdWZDZPeDBJYlVpSUQ2Y0tFSFJmaGlCUi8x?=
 =?utf-8?B?Snh4L0ZXdGJsS2puZzM5MVNvWUdiN2lnUlJMOTlwWW1qOWdPb3dZay9palZv?=
 =?utf-8?B?eHJHSGJhcnloY1B1bUcyVTFnbEhVeUxKV2FGOGllU1RMaGlJMFFXdUh4NGlO?=
 =?utf-8?B?Z1g3MUliUlhXRnc0aCtDN05yTFZzYWRoMDVxeXNIZjRqaXk5N0NPTDRGQU0y?=
 =?utf-8?B?M3l3OTdFTmpZVitvRit3dExEeitpaUtwK0w3NnRvOWQxTE9DOHo2OVROM0Uy?=
 =?utf-8?B?TEM4VGM0akowMWdoc0Nsa3FlQWtXSkdMaDNJZ1Y2cDZQVDZvTkdGMnJUcGpo?=
 =?utf-8?B?Q3krM08wcHI5bXNVb0hRTTc4QTJjKytNRXFvUEgzYlhKQ3Q5aGs5MXZSczhG?=
 =?utf-8?B?ckhubElJek1mcStyeW1BSmZrK0Y1anZ4eHpGT1ovblV5ZkVyTHBVVzMyOTQ0?=
 =?utf-8?B?cHNHTE9NcEtHY0hrSEpBNzdnaCtUMTFIcXFMSGowT1l6azhjUjR4Q2w2UDRO?=
 =?utf-8?B?VGk4bkNNSzc4ODRhc1diSm1EM2Q1cmxndTFxR2M2dHlTdzVnK2VSRThCVjhV?=
 =?utf-8?B?QmVuQXJ3NlhTQmNQaFRISFpYQXdQOGY3Nk55OURUVktpRkxZSUlnOXppTWlH?=
 =?utf-8?B?UGQvOFFMYTRZM2tHNVdxU25iU2VtbVUyUWNkelRKb3czMllaTEh4UmFMUnpm?=
 =?utf-8?B?T2RleUtja0E3d1ljak9NWWw5UWhtaGc2UkNSZk12N0VuME5neWpRcmtPTS9G?=
 =?utf-8?B?T2wvY2Z3SFJ1QlF1ZmhxYm9wdEZGd25HNXlCQStCbytWS2RwbmF1K3FVaFZp?=
 =?utf-8?B?bDdKMUMwQWRjZHpTTjhKcUU1eWRiemVhQklSZVRBY3BFUDRBd3FjT3dMZ2o4?=
 =?utf-8?B?Vk9RaWdud2gxUDJqUkRMaXM0VTlwN0NQaTB3cjA1VWc1UXljVG1URzhzQ0VM?=
 =?utf-8?Q?v+SmVFy3E3szGSls=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ecb8aa-b3e6-4c3c-dba2-08df23a49efa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:26.0648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hT0dxmJekN0Vhwv67oTe1VY4z4e0L92mGap5MM1JSvjWn8d43WO6CO4u+TFCwswiL2dX2Xsj83hYeSntmhPqYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10742
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

Since the BLK CTL registers, like the LVDS CSR, can be used to control the
LVDS Display Bridge controllers, add 'ldb' child node to handle
these use cases.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index fbbf1b3f17904..97fe816a38f94 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -51,6 +51,10 @@ patternProperties:
     $ref: /schemas/media/fsl,imx95-csi-formatter.yaml#
     unevaluatedProperties: false
 
+  '^ldb@[0-9a-f]+$':
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
+        '^ldb@[0-9a-f]+$': false
 
 additionalProperties: false
 

-- 
2.53.0
