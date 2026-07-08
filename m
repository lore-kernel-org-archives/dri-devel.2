Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8EAC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3837410E67C;
	Wed,  8 Jul 2026 20:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VXrg+9rP";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B3410E67C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=do+uK6K5SiRds94Q1xA58Mvzaot9lScOsN8rSFCzSzmfGcsvoFktLDV7HftJjinnToHtpiljqOql3FQgBQKzrxWVSOTw6//yVUEE5nhC88ZP3xTsyDGfbDYRSQLNud6BGSfjc52ixVkEo5Kf9J7yEKADKcjO8NeR//kKS7oyeWWUFXNwwCm+buIcXirJEKKH+MUEYEXXRziHSV/YsQY2Dyt6ekwc2ptuu4/5+qINcPdLMT52jIuLhaNXuPR1a/XGv84eYqJaQJYSA4BxBitOLBEzWyfIwFfu8x+cTzTjZ10iWtddxNK/zle+lIeCdI1aYZUvic8XtDmgfu1DsCUy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig72e5eX2z0XKqb1Jw94i9eOZbOcHlGeUs8tfLHPxRc=;
 b=rYe5ONxjBiPffp+7Sihhwmh0N3cgmdXsVGZNb72hSUBA4/n/mkaN6Hb5Rk/Mk5F9TaJNmS7mGapSHFB4L23Un1FFWI+rtX2yMPV8VQ9095D1yB8I930JVKMydOgaUqnxV1KBtTynkBNWSdJ9JKQ4fkztQeINKbtl5v/RPVM2g+Ajzw9yBbR2NKP83+oj0psFPNPfJOMT/FJX2hmIx/ZsJ0BvmedrkOg+OdttGlLf66CXwZDMipoOUZ6bx/s8qM+05El+8eFXNq3Qj21ombu3wv97aZrwU8jh/9AJ6maQj7L8eAJ9SlCmys4GV3toEDJH6npLfsvjwA16krYE28uw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig72e5eX2z0XKqb1Jw94i9eOZbOcHlGeUs8tfLHPxRc=;
 b=VXrg+9rPuQKUax70HhWhx/KiVUa/Xwh4FQqolSO+eaDGqouy7usobqVq/7lwGmh8uAzo7c9ElDEKmSRo8mAc0EPWLna0ooblgcBUJQYnFxpUIfQFb1BE9vM3elvx29OFZwMW/WctCnTMAT0d//z6nc6SRwPANz+BFRG5voUd1zIIO/DpGlCli2C7IdlDaZq5es2FqpAyjV4h7rPVwtb/oaglS2lY/n/iVVUdCQL045AyptZgPlYeZMf0aQ+NyJwBukbiGp09sc9u3zy/sZ83owI4NZ8kwT/dm56VK6Qpbuq8xeMl0go1fGCI2/ptexKU8/wdR1WRaYOFpu5iZLOYkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12605.eurprd04.prod.outlook.com (2603:10a6:150:36f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:29:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 20:29:32 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 16:29:04 -0400
Subject: [PATCH 3/4] dt-bindings: display: lcdif: Allow display0 child node
 for i.MX6UL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-arm_dts_ldb-v1-3-4f5579b85797@nxp.com>
References: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
In-Reply-To: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783542553; l=1127;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XLPv8Y7Wf6dIm9L+GC36mOyu21r8nv8OOVoYQ3WX7Eg=;
 b=cpqxQCpPKYsZgUXgOkXPHB1OHKVtXgwj6W8UBqNoraEnNSCsjUIq1pf9Bina4V4HyrH3N6F9p
 0XMF+u6mgGfCbYh0+cNKYt90QK1/gzW5KjDtm+xP9Y3C5wr19ll6Fum
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12605:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f78fad-179a-44d9-eb82-08dedd2f9e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|921020|22082099003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: utNQ3fsslWvIzB1Vt7F6nxgRNjBrKJPDZomA8PJgCOoKGXj+8kS1BsSTwdGWvU+Utxy277CaIZRhVTVpmh7SUrtLrGBjgOlfoyIUqjyz4F/OYySt3aHhA96Zt0eGUpJQBydph7uFHW/5S87tXtOZwIu+Q3+iZvWmoA2H6RgGJ1YI9F82EXO43JSP84JeClTKLGy2F1GeZ9rdhwUyRfUyuph2xz/61d8WOWu0dxBubrzsQtdaDnksdrYfoTmSeGjUmVZMK4bzbpa/XkeB2wtrUU1sLHYYSiVHZKE5X51av4lgbRg1S6BDgix20QoxLSPHLdPRT5VV/reA4Udfp9yGXWaBdbEIkLeS4n58w2yuNT31dPpc9ktUNAFDbymTsFATJrm0KcAjCREi2PejPg9nU4sSEVS5IonDhJzwOpobji1oOjIrqGLIF58sGeiqUQETAgER4yeY5koQPZEXTCvDUH8Ng6VN4UKGDPKiauCKKzFEpIVwTQVPfpxsAxU/6OdNNcl0pfqGvo38KSaLD8wa58jHEbjBYa3XZc9P2dS8FYvgZet8ss+yRxV6MyA7S5ZktxPxYYTc6+iI1M6IswKRskx59q1lRC36jrZr4raLbbzY+g9gzcitbSfPgPQyF4+iH1Jtke9ZzWn3wTzMWwr5KUjrhBKra1wYtW4JcVGjphusyXciyjXprxs/nQ4repuvnrebvnl3Ab29mQFXw9W4jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THhWRDZkNXBvWFRoV3ZoeU5kQ2N2dmNBT3M4dndXYkFrTWg2ZU1PK21vdTVC?=
 =?utf-8?B?YVhUeEV4NG9hSmtBRUxhQlFYdXlEOXVKelpDM2hPU2d5RzNTVG91ZnQxV3hE?=
 =?utf-8?B?UFVXNEsrUnc5bGhNeW1CZDFMcUl3MUxSVFFLZGxGYUhJMElhQUE5V0xEQzZ0?=
 =?utf-8?B?VlVRc2tmeXRFRkpwVjh3MllMU0pycW5NMkJMRlA3OE1Oc2lYTVo5TlRrOWhy?=
 =?utf-8?B?VWowbElWU3NvVHN5bnJFTGtlU2ZMWWRzWEhzS2dhdHFnSHZ0bG1kTTZkYWM1?=
 =?utf-8?B?ZmhLY3drU3NDVXlJQTl1U0xSVm5vK00vQ2hZY09UYzl3UGlXcE1RMGs2cThS?=
 =?utf-8?B?T1ljOE15aHNmYXd3VEhpaHFZOXJSQXYvQWxkTkF4NitHSndTZUhzRWdGWVdU?=
 =?utf-8?B?M2xyNkJVd2hyN0U2aHlNcDlPcjRnUm5pNy9aSEtDQmdxa2FhQldjR1BuQmUw?=
 =?utf-8?B?UEVobGdZdUlTYWYwUTY5ZGV1Ry8yT1N5YTV5MCsxZzBZQnM4ZmsxSzNJK0hT?=
 =?utf-8?B?NXV4S29RZ0RjZFlFVERYS0pzcU5RbU1zOW12LzNvLyt4N09VUFdTQ0R1cnNu?=
 =?utf-8?B?Smw4azRiN2x0VkJTZUR2emRoVmN2Si9NU1N3N1FjbVJId1RJVUwxSFYrWWI2?=
 =?utf-8?B?elZ1ZWt2QSs4WjBVZGlTdS9EVHRrQ2hLaVFLNVZyRU91SDVObk0ycm04a0pK?=
 =?utf-8?B?akt0TmlETm9KSEJvYjRuWU9QU3kvOGpxZ0lKVUF1V3BCOVNsc2EvN2hNTXJW?=
 =?utf-8?B?V3Z3N21tbytmRzI2eXoyM3cvTXF4WTIzN2JwUXdsUGRRYS91Nkx0VWlORVpk?=
 =?utf-8?B?UUlTUkJSWkVwYjdkMDFIUmE1Q3FJUm9TczN0SG1raW9WV2RLQUNFZkpJNFJp?=
 =?utf-8?B?KzhDaHJ6TU5CZFg2cXhHWkJqZXRNTkVJN0ZqdjFUMkZQSjVUR3h5MEdnQmlE?=
 =?utf-8?B?TU5tWGlZOStyRnMvR3FBcVN1ZTVDMFZoQnlxUVlwSjMva1ppaGpSS2E1WlVF?=
 =?utf-8?B?NnVORFQxVUc1ZEowaGx1cHZMblplbjdZM0pzU2JQUVA4eDFUNUNnZTMwWUhS?=
 =?utf-8?B?cTh3dXgrN0J0a0lrSEkvQTBhcnBHejAxdVNuSWtJdDRyRm4xVUVDWjRnT3VX?=
 =?utf-8?B?ZHYySjBZaGc5Y0ZBanM3SjgwTlFpZkxnNWZVVVFZTUlYc2pTVlVac2ljTXor?=
 =?utf-8?B?c0tQb2N2QSt1Wk9JVnlCSHExM3B4aW1jcHA5WXR2Q0liQ0hHOEhrTXVFQnNt?=
 =?utf-8?B?Rk9IalZrQXcvcExMOURBenk5Y1h5Y2dyL0pjK3p5WHpxbkYzZXQ4bXRUUVBG?=
 =?utf-8?B?VVVWNHJlOTEvMGNrUTcvTkVSTnZzTlNSL04xYlgrbkhXVk9wQUNrL3Z1bVlH?=
 =?utf-8?B?SlpFRWp5UkdSNXB2S0FrQSt0S081cjkrVnNoaEs2YUwveGZTR3lIU09odjlp?=
 =?utf-8?B?NGxTOEtaamtDTW5YS20vV3VPWGhDemJKZTBGOSt3TTkzc2h2V1laMnZ4TDBL?=
 =?utf-8?B?RWFqUXdYRnVBNDFSN3Y4TnJZRHBoUjVZb2drcUNWRzJYRGFRTEFYYzZmOCtv?=
 =?utf-8?B?L2laOXdZeC9PMm1jbHlqSGpBdzd4Ykh3YW5HSEw5V2RTcXFScVJLTDlpSkla?=
 =?utf-8?B?MzhEOGpsaXVPMkFZL0REdHZFeTJDNTh5WFpnYjJiZEhFK1pGUjB2aFZqNit0?=
 =?utf-8?B?dGdBZVdRZkdZaWZuc1ZLNEZsOFEzUEl5QWZmdmJJbFg5c1AxcTNSNUJHMnZV?=
 =?utf-8?B?cU8xQ2EwR0dIMHdDMGJuOXFCallhb3NkdU9NR0MzSDJ2R0p6WDViOWQ0Tmxu?=
 =?utf-8?B?T2Rub215MXFPZ1RHYjZkTm1qUUI4Q25UdGU4bWMwMys1Q0pLa1R3OFRwb1V6?=
 =?utf-8?B?cEFzQXp1eEk4MDBDKzU1c05ZTVc4Z2hjVWMvUzB5OVNJdmoraklLbk9wZVc0?=
 =?utf-8?B?TGFrQ0lhcFozOVcrOWtyUEYyMGR6eVdlS3UwV042Q09Za2ZkUnZjeGpzRFlZ?=
 =?utf-8?B?d0k3RHVhczh3d1l6cTlnQUtGMWVBSnoydU9LY1lxbC9QWDlSbHIyV3FsQmRy?=
 =?utf-8?B?TjExK0tGRUQvakZUTk5WTEFQQ3Zydmo2d3FBb1dWQmV3SFExSG9tVE4vakNI?=
 =?utf-8?B?L3lKT1JtUTRTSXZhY0hXb0JsQmY0TWI1SVdqU3hGZVRteUZyaTFIV0ZvRjRX?=
 =?utf-8?B?RzFvNGh4akhJRDF0RzNOZWdLZHlSaVBBZXN4SDdPVTlRZHU0QU5FcHNBZnhN?=
 =?utf-8?B?RVJzL3ZWWFVlcTZhYXduU3k4cXk5Nm5GbkJ0TE5hNzhuWXlxcFppQ3dsVk41?=
 =?utf-8?B?RDRpalJ6VlNpb0tiSGVGYkJ1LzFBbHF1L3ZML2dHQjJxVmVxRzlTSmhpc2Jh?=
 =?utf-8?Q?7fxVfQkCYrz0WkTVCjVK0ZLXfUqYksUmKfX4d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f78fad-179a-44d9-eb82-08dedd2f9e88
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:29:32.8183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Msbxbq4lS65RICFcyDyzjObhRT9zP4oVomjb/y56drrt7ppEgkayK65AsSV2IDqfxbVb03rNynnyeo5sycXj5Iv/2mPGbQWPSZbb8C/hYTtgi5uEA3F1+SwYFUKUfedV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12605
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

The legacy i.MX6UL LCDIF binding uses a display0 child node to describe
the attached display. Update the binding schema to allow this child node
for fsl,imx6ul-lcdif.

Fixes the following CHECK_DTBS warning:
  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dtb: lcdif@21c8000 (fsl,imx6ul-lcdif): 'disp0' does not match any of the regexes: '^pinctrl-[0-9]+$'

A follow-up patch renames the child node from disp0 to display0 to match
the updated binding.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 2dd0411ec6516..2b123ddf06841 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -182,6 +182,7 @@ allOf:
             contains:
               enum:
                 - fsl,imx28-lcdif
+                - fsl,imx6ul-lcdif
     then:
       properties:
         dmas: false

-- 
2.43.0

