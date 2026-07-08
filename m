Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30DFC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E569510F25B;
	Wed,  8 Jul 2026 19:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ARUs53gw";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013064.outbound.protection.outlook.com
 [52.101.83.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF6010F25B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 19:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r86hGJJ4HCAspICBn1xGQlZmZxMSpdk1WneqYB3JPeI5C4XxwpigUF3v5BEncaEmdQadTYsI2zPEubsOPINi8MaNU74YkRnVoIIKZr8icvj3gJ8aXlGd8+iM+7gJrqJ4aQXo3a9h6dpSTd57NQNQYjmPoMiVXijHNAHfrIl4XwYrvb7iWhmt1LabAXk/53VpZiAeURvvwxEKanDFLwxykXFT5dCYieFFQNbIwJx+02bd2pb2efgGcN2W+kf2dwBf0L08ftVtZwlHhfF79xWGsKgYkiaiEN44nz4suVMpwMG8whAvZhBZvqWIxIy06pMqoFH7sWp8JkffDvKN04Btgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV5gyyppKDbcNSGqDVktfI5gzEdhO+az2luMFJR9V1w=;
 b=ghsUlU4s4eqKYBNRjOVxEtjRmTXO4O8EUYnJNAgmjPtrPMT2MOaGtAavNRYBSiqi5hnx0K3lXHBJD7nb6UwR+qAamh87y/CZCWftuc4XRZaOKjk+57Y99a076yQj3BIZK7pd60f/EWuehyJdmqmdiIiS3+5E4fZ1O1AuyHKfDNwh6bj3E9Ayzmv72qbD9xZiLMOYcbpY3pHckEzPztyBijjKGUWe1yBcErasB1F752+Nn5iiUl2dtW9X7AR/4xsQvCqVUOhuUWL/f0bd8hH2HI2FbfaplCgDpZpoeMkKEylN1WYsVmFJkMnkVlA4Ziu/QGWDM5s1yoTxlyWeMp80WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV5gyyppKDbcNSGqDVktfI5gzEdhO+az2luMFJR9V1w=;
 b=ARUs53gwODBYeZpSYO0CsLmJm67ieWoSRi29MN4gz/ehgx8NGKxyhHacumvVrRSZ2IJFOnYkY3nw/p4P8N1D7v4jXCBy2/i/bsyZduDwBPsx/Jer7yyz0DNa8YzQqtk9sNMByQucJek+Yfc5p8EJEkEviYsKyGbVRkBivNqU1Ub8fureEhjKGAo5aZMEaURlHf3SoVYSz1cenqHqFe2RxMYFIEZFIl+8KAGn5irQkN3F9KGZbKkvUjed57EADG/pcyqAtesiUzEw6DgTwZMGDlVJfXAHWUWjpfwdqzUos/3pp8Bm0Ei8XXYTBHkZSk0ZtRtinK+aaf2bKtn885RFSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB11465.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:39:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 19:39:58 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH 0/2] ARM: dts: ls1021a-iot: clean up dts related display
Date: Wed, 08 Jul 2026 15:39:50 -0400
Message-Id: <20260708-ls-dts-display-v1-0-1986b2611895@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIanTmoC/yXMyw5AMBCF4VeRWWtSQl1eRSxoByOCdBDSeHfF4
 iy+xfkdMFpChjJwYPEgpmX2iMIA9NDMPQoy3hDLWMlM5mJiYTY/4nVqLiFzHXU6LVqlEvCn1WJ
 H5xes6t+8tyPq7a3AfT99Oj8GcgAAAA==
X-Change-ID: 20260708-ls-dts-display-08c1fc59b664
To: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, vladimir.oltean@nxp.com, ioana.ciornei@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783539593; l=594;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gOx8qdT3ncnpldTDuC1Dg0dYKRWNTDYxvqWkB6VnBqQ=;
 b=sgolYvBn7r2wIjTCWKFqSCsZ+kncFEu7yfcDcThM/saAVPb6cVIes/1+CRblFKrwkBoxAVpLJ
 jsd1/OPuUlcCiXw2aDZCwarwQAIQjnojQY2sO7Jq2nOTUsAi/TyHXRJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:d3::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB11465:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ca8844-d965-48a0-e97b-08dedd28b170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|23010399003|1800799024|366016|921020|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uXB/VayoSMA50EskiU2+jmKZnllmQjli1RngQue+E8mwPdTJxUZepxYDnAxK+O/Dcjc35A3Ftcu+SRlOyoy6lHf5CoaBOvMT4oiD22CIPhLDm+h4zpMTmDz8/fY7lQHSuvD4rqBJDDfR3GO1BjVE0xX7B7fz3ejKzYYgHmT1cNUZIQ8wh37NBxpfL4+ulaQrF1Xzv/cAH9Qc4OZDh6rapfCoD1DxeAY4nUFAyuCad7Rz1JwxzOMGT/lirTVk2zOCTiIa/RTcPNKDpzf/qetp9Bl7YRyS/oonQldeJ/3Rl4qXkPoC9t49syaGLzxm1xqlNqqksE6s8sjf24/wJhNy3u0pcthHe3XyD1Iko8xatLAjumzCSA07zmglwnOUYR6dD5v48p21cxzLRkKNHxqmp8B5g2DN1drt3H2FMuG5pmbLf2qkGJzyExHWdphYkv4iHiyV4SGmU4HimK1AOh/bRNmxJpdNuAsYil3agjggQa5rumE/i/pfDOQKlLdQpULobMTikC2izcy1oeBdR7rSJTauybd6BNMqMIb2Jy1hHwONxVE5ZPLiDJR2ekrrxwNFIyP+wIF1gbpMUHFFUxVQSI+ZjumwS9x4eZnOteUJ1wMgOGoAwPfUoNRHZ4+dV8zNorDeb2OiOhYQZJwHj3CcDynf3GdJvdjhHJ0BVt085j8sACWihBJDQAdelXStwdX15bBZxyWP5Gfe4WnP8UI8IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(23010399003)(1800799024)(366016)(921020)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm8yZUlud1lVWUk5Q0tzVGlKWEFhVFQyZHZ4WUdKRDFDMmhkN1hqQ05wVG8w?=
 =?utf-8?B?SXJnZDBUZWRpOVo4NU8zRDVYMDZseTVCNnFqNnhWcGNMS3NRTXFmVmtIUGJR?=
 =?utf-8?B?bXpsSW9KS2hzMDl6Yld5aENCRmM1eDFzT2xpUUxBNWhsUDc2UXd6N09NcG94?=
 =?utf-8?B?OXRaMm5CU2NheUVzWWVlU2VPYm45QytMUUQxb0JNUEtabTh2MWR4Z0V6S3VY?=
 =?utf-8?B?dVd6MzZSd1JCS3JmQVg1KzVleno1d3k3YndBQXBpUS9hREh6enlyd283dmhl?=
 =?utf-8?B?SzlMMkJjVXFNdHNaaDVyY2poNUd6OUs1T1p4ODZJSjB2bXltT2lUd2ZpT25o?=
 =?utf-8?B?TGMrSlhmQnNmRUpSd2JmQS9ldnpEbUtrVFVpV0hVcEFkcnd2MGthSm5UdGpy?=
 =?utf-8?B?RjArTFM5MkdGVzY4emIwZnF1VVV3ZVNEcHdSa3ora3R1QjlvVlRlTEpqNkxj?=
 =?utf-8?B?OGVobFJ4R21DVjdwTU1KRElMSzE1VkRtcnFwQ1IzS004b1ZMRFpySnVBeWIw?=
 =?utf-8?B?OGhuMGRRdHQ1VDBkb2Y1T3Q3UUlBMC9BODE4UzdoZmdNdTRBNXpmcktNNUdU?=
 =?utf-8?B?MkNjNzY3dGRPcUdvZ014KzVhdDFlZDhNYk1sZXJOT0dab1ZpK3lxdkxtdmN5?=
 =?utf-8?B?ZzY5ajhxVGFNMk9vQ3BuSEJrMEZlNjVtODlyYVhaWVNmMFI1ZU95Y0VuTWZl?=
 =?utf-8?B?aDRPcHd0ZDRRZmpLamJoampxRXN3YjJodDZXNjh3MW4zbkFyRGhpMGVXZmVs?=
 =?utf-8?B?UVVzU3RIcWVXU0dCbGNia09mdXBBSXRmWlI2M3MxbjZwR08wUEdabkMxVEZh?=
 =?utf-8?B?OGlSZ3VvamJYWmg1cElsL3p5dDVrRGZMZjZPNDU1djVpZTZEQWFMRGNaY1pC?=
 =?utf-8?B?Z2pKcjNhTnhsdXo0bWQ1SjRqMTJKRjEvUTBsN1BFQTI3YVEvTVdMRkZjYlFF?=
 =?utf-8?B?bHNldHlUNFRLdWdyZDlCZThSd1ZKRDlrTnlGYUhVQ1FpOXRvdEh2aElTYUhR?=
 =?utf-8?B?azE0ZWhaa1AyWWt5SWtEOXhVMXU4djhFYUtpWWpNdUcySFBUbW9ZV2VvaVdr?=
 =?utf-8?B?SlZUcndVdkhOVjF5b2hlMDFIaktOZ0VKSklCNzFTV3lJL0JUL3BreHl2Mll0?=
 =?utf-8?B?czBaNm9SeDA1ZzlXRjVqcFJoSFlnMTRUM2UxUEp6SEtpZGtYQngvemd1NndR?=
 =?utf-8?B?QVppQm1pUVBVU1F2YkpzNS94T1dqUjJsdlVnSUNTSWJSTFRncGdST0ZMN2p0?=
 =?utf-8?B?VGFkV0E5eWdaamdNUEYza2pMNTBTQXhROGJNdUxiekdzL3ZXSjNtY29aR1lt?=
 =?utf-8?B?MWU3cmV3SVIzSEh0bFVrMXQyeEZxSGxLc1dQTEdPZCtUVGM3S2N3VmFjNkRI?=
 =?utf-8?B?UWhTVWpNcHNTU09wVHlCWTFUcWsvdllVSWNFdjkybElnN1gxRlZVcHNZWldD?=
 =?utf-8?B?bW0wb1BxRlFBeEJ6bEhiTldxZkxiellWcnBKVDJiWFduRjZGUjBZc09LV2Y4?=
 =?utf-8?B?Z1FndVYxNEV2NmdxdW1OV3d6WHM0YWZxRGZ0WVRRS050eHBvbTUyRWsycW1E?=
 =?utf-8?B?SWJDbE11cHg2NVRTR2xaTkgyendER0QxM0RsaStNNUFxTnFDOU5IOU5iRFYw?=
 =?utf-8?B?MnU2YTZmZFlmOCtLSVYxWHlRdllIK0J2Y3VnY251OURoOVpCOEZLOUN2VnZ6?=
 =?utf-8?B?cjZvaDRaSVNOd3JxSHZVV3M3TW1zWXRVQ09MTnJ2YTRnOTg4MXhsblJYSkxk?=
 =?utf-8?B?ZXkxbkNIMXB0a3ZLdnllVVBNYTFrWTBlc1RKdlBGL245QW9PUWhzYkRBeTRL?=
 =?utf-8?B?WHRieVc0Y200RkNXZmhOeWh5S3pHbitvVlp4QTZjczQ5R0Q2YitUVFBjREQv?=
 =?utf-8?B?c0pjQTdETHhnR0RKREoxMDJHeThnR2tLS3YzdlJIcFNUSk9wd2ZhL2RLV3hQ?=
 =?utf-8?B?ejQ2S3ZYT3lJSkNXQlFIcFhqZHVJdkw2ZGdMUTMzYlB4bDN4UmZTS255SkVM?=
 =?utf-8?B?c3A0YlZiTC9SK04zSGdOMzZ0Yzc2SjdlNGRDdWhxemh2RDE1S295YWltN0pl?=
 =?utf-8?B?bVVnWnZ3aFA1RCt1a04wV2JJN2ZKK3E5SVpUbWtsWnpzZkMrbjNheHlkWG9q?=
 =?utf-8?B?MWRpOHgvOXVoMnpObmhHRlo0V3RiYjZPdVA4bzJBWEZ0R2xCTXNmbnA5b0oy?=
 =?utf-8?B?cjZLLzdQeFY5ZklKeHZaUHA3VnV1WXRhVVVobENVU1NJeU9yakVjejRyT3RW?=
 =?utf-8?B?T1JKRDgyU1NpbnRtSStvTmpTV3pvVkx6N1lhenpmTmtXNktKNk15WnRHWGtV?=
 =?utf-8?B?OVdHbGo0dHl1cXlIclpLdjhKY2xiNitWMExLK2I4VmM1TnFSTWtoQW9ieWNS?=
 =?utf-8?Q?Asg1GCnSlIb4Wz0BYLWhUs0oexSXe6tSUhHjw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ca8844-d965-48a0-e97b-08dedd28b170
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:39:58.1442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVrPZMiXUCliLIHDe7hkJl4O/LN4sAw8ONAlL9Fi/cX4AvioWERTdQnJgVsCEF2MnO8zI3WfpjHGQFHCKrpiS0k5GufrLqXq3FLhoJWybe0HS1zIcbQZEPUzriqbOt7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11465
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

clean up dts related display.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      dt-bindings: display: imx: Add deprecated property display and display0
      ARM: dts: ls1021a-iot: rename display@0 to display0

 .../bindings/display/fsl,ls1021a-dcu.yaml          | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts           |  4 ++--
 2 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260708-ls-dts-display-08c1fc59b664

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

