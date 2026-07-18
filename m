Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82825C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF15A10E5AD;
	Sat, 18 Jul 2026 14:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cXJR8DSk";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6D710E5AB
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFVnvKd7p5lM4RQAZIa3EY/iSL6zubBvbZqO719Ycb+Pxv8RRpMLqhI37Ru0mYYaiIkl2LDschYBofF6bNf2ULzW5XCwKupjooqyc80Hhefdi5Zx/lnlC23q13aPlY/UFQSEE69kjsWKtweTkAE3iXfxfpwTRAtEQ45540DRaSwpucAGVma9GeXkd7AodL7pO756ZTU2HQD0dqcD6KXEh6EFZXTXzXa5KkEeiJtw6jWfFvjCvunoJdbdm2TECZTOb3BRQcFzRcUFPcFtbuLlRlwZGfAIz/vYtLcy86EM9+15AvasbYgrISV8IwZaWyXwFd6EewXqUKa1jkTVnWLwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMYv125jj1nnCWnPD/mxwLFTTxln68l5IbdDZW6VgIY=;
 b=xjJRTHZJsmqYAUTESCzqmqYGzViqg/FCWWOTaNKcrowzBzE9Ww56TwaD2usobD6UF/lerNvz7+o/uxkm4nez4/DasiKZ4WB18QDphe7EeofVawU0nKIBHY7I0KPBtGeF7x/JOXj2+l6ykY9fi3OCC60C4zXd6PNk/MSW8wjbN6l/TWMVM6gwSBzXc7MHKneY7G65ehokPaGv/R9SAUSSFSx+wdXc9Euhrk2uKvpJv3otD6h912196nLzNKkVCzXoAEgPGDquScdKwjVVw+D66SZa6jlUGjg5eenu/xKi5tdgFBetkQKSj6gWeppmKlxiCU7Ywv+ztjI4JTYsvarD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMYv125jj1nnCWnPD/mxwLFTTxln68l5IbdDZW6VgIY=;
 b=cXJR8DSk+M7WsfElYkgNdODqAaGBMRR9rPsH95M6J9mC66LaY8gg8VlJ9CiOenWjIvqhpxfAS1osCt/61/aPb2E+6FbMbcD84h6aRpxA1hr8qwGsBESsp/XUKGXewVXuzg+BbWyw3BswpPRflUUcmSQQpcyoo+pLkqAzsMCSXOnYaRXVXxfCBh4J5KFmfQ5cpXI/dcCZmYUxVL0vOBVmhQdpHdL2Wo0PZiAm7RIDvo6ZIKPOoe6/wvuy50HjijgYkL/8ELWifipQ1hK66CvvrWZHkegJ+KwrnrCrfNQEB/pN/V8E7RBCtzS8ZB++9u+qoam3wQ9wk53E8l0fKOBiIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUZPR04MB9728.eurprd04.prod.outlook.com (2603:10a6:10:4e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Sat, 18 Jul
 2026 14:46:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 14:46:01 +0000
From: Frank.Li@oss.nxp.com
Date: Sat, 18 Jul 2026 10:45:34 -0400
Subject: [PATCH v2 3/4] dt-bindings: display: lcdif: Allow display0 child
 node for i.MX6UL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-arm_dts_ldb-v2-3-f5669571aa2b@nxp.com>
References: <20260718-arm_dts_ldb-v2-0-f5669571aa2b@nxp.com>
In-Reply-To: <20260718-arm_dts_ldb-v2-0-f5669571aa2b@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784385940; l=1385;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8xH7On6TzHxU9EZ1w+7GDSx8UlF+wACQp+aGmNVb95M=;
 b=3WSalcJ04ak04NIvBJh4aht7f+qvLWIFjOwe9ckLpe8eQUKSolA3ZRbCOM5MeabgZgC9tugLz
 7zdD7z02qmyB2bBl1eNrvxrIOCErEBHTtBdxuugzlNnNLNlieFrZY/w
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:510:174::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUZPR04MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 446a8036-2b30-478a-bece-08dee4db497d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|56012099006|11063799006|3023799007|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: ba3nqtEEvWwASSMm0MuRy1BdA5VoHkqdTMEWcD1Ol7T8xuu3cCrAUMvZNlwRI2By3Hnw0uNWsE89AwQnM0O2/YtWxPh5rnolmrwzjGY1jrE684dIGbE1I2W/sI6CkbrrmxHOMHHFRsxs5p/EfjDCaviw5AvzWjy/7uc46PFXxJ989ndRsbfECkAhjlkHAZ6QawOzjM4ADpqYZ4PmRq+G8yo4MV1CXB2xTTW26IsJ1scVo76AWNmSJnkn8CWR/vryRieZtxqNGPb02VwvnTcO9wfxjwCyJAHeZ8R9E8GZV5FXOSjX9QZl1ZVaN2st+8rYcg+TrgxGA9YoP0DjH1ygIhtW0xKNf0XtUffLh3e8Mgv7quWqanz83AH3zmmeFVwuJ/8Ks+/EFPRyVMPJqtp+YoqoW99S3E+HrB5/Ns3mId4gvjVOvb42f3JVFi8WnQJTbTdGwtgPSb7ibB/i2cUMfsXokti7CnkXOs08MXpLv6uqKpbXB6TpyyeAMVfNG9+grUszONapVRU2kZfq7hAe71hH5WB8AB4H8kc93zDE1gTyGQTKfvbLLRlQqqzQPDlMcy8PEk7lcDNtDdVsylBzaSDrOxbMbA8KBAw8jRLbKSgwu5XGhObYpn2+6Zid9Lq7Q+0lq6hc8VoxRop+LNgaryXund0g9YQYOicKTaV17AxqO85yFeHwVPGUu/VpNoxxRlk9V1AQmhboDneezdx35g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(56012099006)(11063799006)(3023799007)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTgzTmhzVFVwcVNWOE9HY0hjSEFTM2MreXY4QkxLTERwc0VwNmpjQUVFam5z?=
 =?utf-8?B?aHREekFCRzE3S092WnV3TUpCSUd1Q1NGQmkrVUZBaTRHa2k2N1JRNGJqRUlN?=
 =?utf-8?B?STFVNW83WGNlUnJBNThYcmR5aEU4bXRheDJscVZpNEJaMVZmT01xSW81Rkg0?=
 =?utf-8?B?Umx1c3FIM2lyK1hUYlhVQjA0Zk9pTVNvV3IzSkEvUzRhQmhNM2NLM1JtczVI?=
 =?utf-8?B?VGVYaTIvUnJXZ0lkbUl2T2lvcGJseWZFUERRMUdyYUZGNjdKRXltQ1hkZVE4?=
 =?utf-8?B?eUJxVTR4VnpUTW5lQnJFL3BSMTNOM1JDbXMrbDc2NkJHTE55RTZRZkhtNlRJ?=
 =?utf-8?B?T2ZkY1U0bEdqKzdTbTBjM2VZOXdpY0pHZkZDcjZwSENSZnFUNVViZFFFaTB1?=
 =?utf-8?B?Mk9HNUl1elFXc0sxYVhlMFgvekgwdmtpU3IvR2ZyVHo1cVF5bDVvaUlyZ0s0?=
 =?utf-8?B?NVA0emJpZmQ2RmhEUzZzdi9FQmdEMzBpbnJHcFBLRlFLSUZFRXhSb05KUlBl?=
 =?utf-8?B?YWxia3ZVZEVBUUd6dVFaU21yYklyem9FdzFPdS94bVNHSmY2T0d4aWNvQ3ZT?=
 =?utf-8?B?bUw1bXc1ZFBPMXR6UlRtYU1NNm8yZDZZdFBNdk1hVU5UdVBjUkwvblBjaStj?=
 =?utf-8?B?VG9vaHZmUzZmY0Zpd2QvU2hzWFhMWDF6WC9wbXV3VDJLWWNZRGNMVUhFU0Nx?=
 =?utf-8?B?SFRrR2FlK284cU5xZE1PVEphSEQ2c0dyZ2tacU5Cd09YMTd6M2lBbUJuMC82?=
 =?utf-8?B?MXV1aG9ZU2p1MnhHeWJtMSs3ZUhDcmM4NEJyT0lpNy9lT09HU0xxNURxVHlE?=
 =?utf-8?B?dzhwSStNbkVNYWRiaFdVaVViV2tKRVBDQXRYQUlYMXhZamVEcTJZb28rTDRJ?=
 =?utf-8?B?a3VvRWJHL0lsd0JNaWlLa3NDWkt4cHYvV2xJUjEyQTdLbG5ycU13UFdsU0FI?=
 =?utf-8?B?SEdYZDlvekZuczJFSVJCcUllOU9oTkZVSi9aREpNeGVWb2lKL09tUDI5ckNZ?=
 =?utf-8?B?TldDRTl6UWp4RmRHZ0U0YlJmbkQ0SkpveFJhTE5wbFpMc3dNR3Q2UEZmbGxT?=
 =?utf-8?B?UmttODhETnJxK3pRSjFPbWFGTHB1MHNUQXBIQWE1T1lISEVwNmJGNjlrRmxk?=
 =?utf-8?B?a2MrdjF1eWw5VjlZR1JPeFpvQVVhcktJMFNJbm5WeE5pb2FhT2trblNXVDhQ?=
 =?utf-8?B?d0lRZFQva2hpOWNpQlVJazl6cWVmUW5BbzZUdldpV0k0U252cG02WEdQcTIv?=
 =?utf-8?B?cEFHRjFVV1U1cnAwcXpLWWlmc2tWVTQ1RnFtQmVTU3JZRVBhRWFsM1cvVUc1?=
 =?utf-8?B?WnBtUlczTE95VGh0MmFxemZ5Wmh5djRHYXR3eThmK2xwRnlmSStPam5UTFFw?=
 =?utf-8?B?SGROVnVoZDNoWDJFODl2cDY5WGx0MncxYm5HY1dWVHk2NU9wRW8vY1h4QVBG?=
 =?utf-8?B?TlQ3ZzBpbks4dTBLK2k5N25qckYwc2RDYVBnSTVJbzBKSHlQQk1reVArMC9W?=
 =?utf-8?B?MDI5UTBlWmVobnEyaDR6MVVwSFJEQnZGNStXZEVmbWZudVZ1RWJxRjhKNlI1?=
 =?utf-8?B?WVV6UEt0RkIvMXRrcjdVTjdDNSs2L21JSHFIOGtyd05SWTYrQk1CUTY3ZkZJ?=
 =?utf-8?B?YWlzejhMWTVWYjZ0a1FKQloySkttZW9UMmRJMFMxZnhvWkZYV1F2QTBER3R0?=
 =?utf-8?B?VDFBQTlINUxFTTBtZ2E2dEZvT3lqQmw5YUs4Nk5RUU5xcGZ2RDZBc3QvYjYr?=
 =?utf-8?B?TGdZbVlIaHFMQlZGTVFFN1hYdUU1eExFMXlJKzB3VGhVUjVXajZ3UjdXQ0lM?=
 =?utf-8?B?aDBVOENYZ2YrRWRLbTJJVmhEcjRCNE1LMWNzK0k2azdDZFBiY2pWcUVIOUND?=
 =?utf-8?B?Z0k2MzBvQ3poZml2R0oyU3JkYU5IaHhEZjZ2eXJEcjI0dTNDTm9LbFI5SG55?=
 =?utf-8?B?RzQ0ZjIyT2tyUHFXdzlpNHFXSkRjdTd1WlhpMUp4QlZLWW05em1qd25tZi9t?=
 =?utf-8?B?dllkUTJkM2xiem5xREM5a3JQTVoydzNtaWpjTnkrN1UwcHJzKzE0YVZzMjI3?=
 =?utf-8?B?UkM4QWRFQ3BLNUpoTVd6TFV4SHg5KzdxRzdnZmFhSStVeUluVThPRThPaFJB?=
 =?utf-8?B?bHZiaEJTUnBISGJjWmsxa0RHUURiY29CWVYxT0RxbEc2R2hQRFBEVU1ROEpj?=
 =?utf-8?B?SnBabjBEMzVCTUljU29kRUwyakxsQVlwL0djYkMxaUxhMDh2VWpUMU1nUkFy?=
 =?utf-8?B?TlN2UnpONC9ySm9XemhzRVZ6aTl3ZGR1RDNxT2ZVYncrblhPcVgrVUJycUlr?=
 =?utf-8?B?NjFiSHcvSHlXQmI2VEQrTXEwMlI1d3lVM082ZWcvaXFuRmI5bEpqLzBmVkxX?=
 =?utf-8?Q?opkpp+d/GPxMZm74NtQ6s5lVcW/4YGU1YhnXk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446a8036-2b30-478a-bece-08dee4db497d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 14:46:01.6540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0fUexjUQ6MLYpl9sjKAYhrYOpk+30GUsGbObfG03pIEC5ukiXe3uAuDPuws9nPBMy0cQ9u3Aqjsyj6jonIEOGFlZo9KeLWsKpLz//wPmqZkyMpQEylx5gRloeMu8hRc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9728
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
sashiko report problem and allow dma/dma-names for i.MX6ul. which should
be fine for this kinds of old platform.

Ideally it should use port. but platform is too old to avoid break back
compatiblity and leave as it. Needn't complex if-else branch.
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

