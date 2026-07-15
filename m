Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F8DC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D7B10E207;
	Wed, 15 Jul 2026 18:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c/yQSc/6";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311CB10F10C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBpfGm1lCcX5g+FB8Ch+GAm8dQdU8LeBbujiUHBn2Xgdd0mN8Q9WmsQuPj/jg2VtGi+nJ/NlsCodSME+QrSKsbApB3oM7xwOEZXTwlXB/qaFejBmljn4gMQp7whLDyRPEGtbLMVzW55kjS/qWEuoyRrq1NhTvpj/uQeYHYo01mOx0pGYHxLAkPmAmy+3yyWUxNkRLWQb5iW5RLtO8RQikQ//U5jNycrITDrmjdX3L5TgJ2843n865gYuZU7M1M0eNZk5Z+6cHooOqhf/kYMa0BMSQ29yVua0x+CE6ACDCB8EsE+QxAuO6zbGb4tYerjeIw3buz++y4nbzFE/bW4hgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McrJeoBRA+ZSSAbUkmNKzEd8azhPab9sP+tfnmBUvJ8=;
 b=jc3gJsrarvMXgeeXuZdm9tM0t7BcoiKSSB3ShQ3DypWo8W6AgOKcUD//3xLrkj0WpIe0vfDhZ+PELEfrLK5NGM0HdQcFdRWlbDoOhOptGwS7XbVGMe7/JXuRZi5jwTLhUypL5QGJqNdIPZ4RZH+23IwDPEOEJO+wjhEfNoegr5AEqnbBkJiSF2Cd2uucx8gNUOLV0Szhosde/F1lkbPSqnDAMObIOjvgUI8HYQUtled1xvpZHgimv/In3/0FOHECQGmsYMlpTOXDbRgDdtsfvJpN9iNMSmaVdKYruS9aeDSWzBwgt+X2+26ms4vACFOzywuR/cBEiU5BmHEeEOVELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McrJeoBRA+ZSSAbUkmNKzEd8azhPab9sP+tfnmBUvJ8=;
 b=c/yQSc/6c8YNZqprbF8m89eywxmHJ1sGtT5B9ivrhiY4HqtPAdjMXBSzDgiD9wxx3RxLLubL6mRn2EQMhsgGtZLyU1uSSIpdlcxhkkxAAMCGENY6PSKWolD6bte/5JB2PHMmAOeFRsQoxt4ddbihRnVuPVoijr4VWNcDQuWAZgKD6XZtBR/k17sfutO/rpMWZYEz1YOSRpCCyTUv8OTcsYi40MsAi2oMVGnEZtuD6lxLSadH+er7jZQC4mgqvaVE29uI/hIHLC6AUQD7EOXgkOXJjkpHdrgM/yLWye6//u6jj8GMv6Q+NM2LPbHBhwdkhrztQtI7+xL4kCJ5NLWB8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:35:01 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:35:01 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 15 Jul 2026 14:34:46 -0400
Subject: [PATCH v2 1/7] dt-bindings: lcdif: add compatible string for
 i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-dxl_lcdif-v2-1-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
In-Reply-To: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=1456;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gZLT3w+KpVgQUTqARMGWG0EbIDZBBn0B5p4KXlauI7c=;
 b=gPQv+UiIWR0b8b9m/P8R0mj7MQxfpg1cyWAxxxjj6jUzJRZEf3DJ35M6a/QsCrzrgZzMjMvMs
 hLu1/byoT2kCmut0XWTBBFi6YZKKl9RngqwmUjQlh/50shn0CHQ09Xz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0191.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::16) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 732a1200-1663-4790-4d1b-08dee29fc7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: RKFXfAJuPiQKMo5oe50HaX2xRLMFYALsyQj2ZOcrcqTzwdGjJ2jwinOS/r8YtnUKR7OPsy8Bl8/j3Gy8vQ/Nb4wi7GFGmNSl8J5chuEMLffcJe3oRO5N0AWcZNNNIlaO/domnpTKvx2f1+Nvbvz249juqLuEYiWAvxj0pNOg0zTX0qfCPqGDy+k4iQtEX5chNsXkXv4Qw1rzoZ89jmHA4vgyxgn6whj2w2Ce6+xymivCTUPxQW0C/+zDtmaGcrUtAFoOn7UqxfAdxr2a5RkKG5/5eQE7TYRp6QZ2NncaVBPhFCTeS9TXfq96ahZMiz4YdIg5BSuOYV2c27Vtj5Uspnm8WuAMgcrZDxmihnrLryNZhcH9S4aLvRzDVBb4skc9DwQw+pozCPDfzR7bGnShhlDUa/iN1zwrAm/OPKME3W+IjRXmVMT19sGZAfUFvhfHHg9SA3OvvZ1Zd27FdTUzKIVMY4WhSj0FZEv7maI2wmu1YpHt+PVdwfchK0ISJv8TwNa7TlKCNjIGFtsVw6qwYmDKUHcnUpxK0PPs6RMJ+70BLO1DINgj51FD9grU15dzT58z7vvHVBavv9Qc8S1yIdP6oXeXXt74ibKOu5RwSQvNFFrSRz1YJmS1XhA6n4kfYS5uIci6v5CWvLjQ9BqBu/f8VzBu7cdgVHhSlbRg88iKDxDa62fTe4E56KE382DTLOtqQMJu/cmDZOO6yBQc4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlE3cWg1RkFZeVYyNnhhMTRNa2o3TklMZm02STZsVXFzTW5JWkJieE00c1hD?=
 =?utf-8?B?Y1hPKzErNXIrTUVLYmV4dENISXBMZXpOenFvbWZIcVQyeTIveVUrZCs0RUts?=
 =?utf-8?B?UUhvNFVHcm9WL280bmFmSElVeGUrcEQ2dzNkYUFNeFM1QXZtWDhkSzFrWXJ6?=
 =?utf-8?B?dThPMHZPRWRXd0ZaRlB2dkxGTHpic05PekF5a1RNNFlERUF5cXBBR1pQRVNM?=
 =?utf-8?B?djhBWTNTaG5HRUljVmZhWVMrZERiNmtyelBqZmZ4K2dWYXlpa2N6cXp4emRK?=
 =?utf-8?B?OVdCT3Baa3ErVFNPUURlM2t3anNvVnBXYzBiNStwSHoyenRoUU1VdzNTbDVH?=
 =?utf-8?B?TGxhU1VPN1JtUlp2bVIvV0lTdm8xZzd4OFZNUmZFRUtrajI0RnoyeEhrWCtj?=
 =?utf-8?B?NzU4MXU4cEJaZ2pYaE9nQVZXV3BWZ1orWno4NzZsMDR1V3JPM085YmZxZy9S?=
 =?utf-8?B?S09hKzJDT2kycnFlZjJDemQvTGJyNjNWczk5V2pRaVh4L3YvQTRjMWF4WWQy?=
 =?utf-8?B?S3BCYnRYVy9ua050VUxQT0M0SE4vbmExR25WVUdJTVF3YVRBVm5IeHQ3OFdH?=
 =?utf-8?B?TjdDakhQTW1FeU5VNnVIRmVQbWxYa0NINzBwaXlyakhwdjhRTE4yS2l0d21Z?=
 =?utf-8?B?R3VIdFlWYzIzcmRVOHgwUXgvWFo4OERoaFAxSVZwY2NkVGRmbDRsNVZrenN3?=
 =?utf-8?B?MEpRUE0xMDM4S2JiWnA0OGlFUWp6eFJKb1ZSejB0OHlNb0hNWm81QTVaL1o1?=
 =?utf-8?B?Ky9ZeVNUdXVwL1JDYzNkSmpIUlhQMDBOcmFFZUFlS3VjQm1Tb0JCUzZCVURp?=
 =?utf-8?B?T2JIWjV0SW1NUGVsMzkzQWNDb3E5T1BueGNqUFdQUW5SKzBrRVlQdHA0eHZp?=
 =?utf-8?B?OE9US2F3ZTVUbUNuZ2pBVG11OGQ2R1NtZmkwdVNPS2hkM0owZ0hXRnVFVDBv?=
 =?utf-8?B?T3l6T3JJUUNsaDc2UUFSeGlWQjNPR0twdGVIcEliZEtSaDNNcWRpWkV5alZq?=
 =?utf-8?B?NmVBQ25wMms1SkwzZm1RSUdyWWdoQzhENVFPeUVpdDRPWld2Q3kvSkhHQmE5?=
 =?utf-8?B?THUzN2RoblBUQnBwczRuYkp6V3U3TFZubkNsWFRBQ3MwaFFNSVB2MlpKNFNP?=
 =?utf-8?B?cUtKM3BSZ3VqRnlrRHU4SjFxSHRpYnNSOUVlSlNUV3l5TW5DRzJoZ1loeVZG?=
 =?utf-8?B?YlBoOFY2MDNwYkRDOU1ZWGVkSU9LaGh1NklET2dTRjJocEF1aGlNckY4eDRK?=
 =?utf-8?B?blVicFZ0bjExRjkrcElJL3ZhOVJmbUhzUmtoVXh2QVo0TjhXbFB6WUxvM2xC?=
 =?utf-8?B?YTVrTjJyMk11MUhMN3JSVW5DUjZMdDJFTTZ2dm0xSk1LUUU1WE9ieWx5T3Mw?=
 =?utf-8?B?eHVMUndIZk1jYWlmZXBDK1JJU3FOU1grVGZFS1JRdzQva2psN1RrYU4xbXlx?=
 =?utf-8?B?TjRJUTF6QjRwNkN6cHJUcElVTjdJK0JmWmFZZU5FRTJWQlZkNGFVdjYwdDVH?=
 =?utf-8?B?L2YxTlFXL1FPYldBMEN1STBUM04vZkwzNXJNSHcva1FxMHlndGM5dmpSTjRQ?=
 =?utf-8?B?Nzk0WnFORGE1V1psYnh2SExPWG5XalZhUFJRdHlNbE5WK24xaGhza0tjQ1dD?=
 =?utf-8?B?bzBRTDBzbGZhSmRzRkhlMVJvd1FxcjZobVpVZmVSUnVxSjgzWUtTOW0rUE1s?=
 =?utf-8?B?S3luckxJc0tLdGtBODJvcWpJaHc1U1VzNWpWTGN6U3hyRUFLcnNQenk2RFNP?=
 =?utf-8?B?U21wOEh3Y2VrUDk5Y0NNelNnTWR4QnY3R0Z4VzJSZXdMdVNNU3EreEEyL2sv?=
 =?utf-8?B?REp5U1BwWFBZSnZseDFIK3pJVFNXQ1hLekc2UThYZEVXbWRxRkNhK2VWUEpa?=
 =?utf-8?B?cDJ0SUxYemgvZ0hJVXpnaExYSWcrS0pnV1RPbEJteGZtckd1VnZrTVZvYk1r?=
 =?utf-8?B?M3dXdnR6NXlnY0h1MnZOeUlIVVRZYjkxMlhuVWVMcGxpSHlSYU9jZjlKYmNu?=
 =?utf-8?B?YmVlY2dDbzNqQW5nN0JpMDZIRDM2TkgvcWJEVk5VVTduak4rRzlkczVycm5P?=
 =?utf-8?B?Y0NBNjBJMGVseDdjeHRPN2orclFyRXJQL3AwaTJFcTkzdm5lSy91bHRIVjln?=
 =?utf-8?B?d1MxcXJnakkrNTBGSVpVVnNmRmRUbkNJdHcrUGcwNXAxY3BQOW5pcU1tZ1c2?=
 =?utf-8?B?TDZmOWpPb2h6RGRoWCtxU3dUbGJ0R0pvbHpyZUowZ2Z5OWk5aEJmNWRod3Bi?=
 =?utf-8?B?S1Bsam16YUJBWXJyeVlFb2JkSHlFb1VUendsS1Y2dWFZckZGQWxPZzMva0ll?=
 =?utf-8?B?MFNHSG85Z1h6T216YWxhNGtiYklTZjBUWnplNGlhUDlGVVZ5WDhQTWdVN1U4?=
 =?utf-8?Q?HjgreXUpJ4Nt6OccFmMknHKQTjJoZgcHvzs6H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a1200-1663-4790-4d1b-08dee29fc7b6
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:35:01.2435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LcLBnaf2cSaGGNRZdG7UdZkhch80NHCwgZPMP9aRIv4+WQiy1mQmSJOMGizBiv5dO9VYUlM1zlcYiZjFyM+tm0uZGldqo3Y4qd+hicLHJPas9kCG0OlSIHRY8xiiYEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
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

i.MX8QXP and i.MX8DXL have lcdif, which back compatible with i.MX6SX. Add
front compatible string "fsl,imx8dxl-lcdif" and "fsl,imx8qxp-lcdif", which
fallback to "fsl,imx6sx-lcdif".

Required power-domains for both.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- require power-domains (sashiko)
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 2dd0411ec6516..f16bef7f68535 100644
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
@@ -152,9 +154,11 @@ allOf:
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

