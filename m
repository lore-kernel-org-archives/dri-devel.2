Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C01FC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A155210E542;
	Sat, 18 Jul 2026 14:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JQNuBRrP";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011046.outbound.protection.outlook.com
 [40.107.130.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11A110E542
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHgsYQ7Qo1QAdVvA0IFVQdn4vN0NeSvIjyCVnPMAwhO4l8h3d5CrITIlwsipGfK7yOXWrmAR9tq7aBYjHSSBby77XbWD+kWyLNBF/2SsPFEmeDvr/VfMLEjyt7wdSMiFAIp5MUvCfFUeDVuSh9YfblDE3zIdNRWgEnCH/VOH9mJgROQ0u5ll2RyaX6JipIxTBBJ6Nv/Dvq5GGfaQIMCEDQ5VBepBpknNBduszqKau0uJXPGaBtClO257fMB3oQQZuH4xw/3dXEKtfQWg0RX6RHaS2uyo4k88qGiZRdnmGREKFGGAjhG6BN7CFI4YV51m/7B+I/yHPf7Va+NADhjJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VMMqfGkS2ipn9n0iTB+y0B8n/Og36Nht/SXh6ah1b0=;
 b=xZJk0zcbQTqANEwu19LK0Hrr7yZupxLlrLrwNJJYxCRVevB7CU3h+titDByCFYUXyQ6sY0/vzf9QCEpRDxg6Rq0EDH9MEtLAThpN/zxqypfkIUldqFNGnmLKrHdX/qzW23/RK0+JHlUsrdTeOmS9qYjGIGZlgqKjaUsJcjANYxAZyDM1kPf+2wPw5I4h1jaKajaMJk3r2QcTsA6hzwFobuM/GqmwZcEyQpOrY3LO83Ywhx3GqQUci3WE7F5IeXV0een2SsXpNnftPv3PLwGs6BA1g0exdHfCjdxJBtXfsn7nkshdvMBIe/RkB3H5uLweKpXIXNCltgwAoJIg4kTqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VMMqfGkS2ipn9n0iTB+y0B8n/Og36Nht/SXh6ah1b0=;
 b=JQNuBRrPfy8b56EPAknI2za+OIydpLwmBDuaITu4mIet9XnsgGgUqOQhTvw2lZBi+v2w0ltyilU9+r6KycfCfr2zSoSpQqF7WmSEtpkV3iVSixZxsYRhyUgWyaXCeQRoD7Y0XL1lawKQExMsCfPmWD26X+d6yP7guoDm9vYEb1WG4l0EUZbLLF8BsOUpymza8PtDCFUKtSEYrtXX2mZeeEhy5iTWsMtqZn+N235sDnJO5/f/o+o4CApwB5T7Z6tIVVD8mw5EvsOcix6TA88YjAivn+u9wR0eiVo3TSyWOOYXVVN+kxAlPpCGskg7MnrvxOTEXljm9HzoaT6r43e89g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10258.eurprd04.prod.outlook.com (2603:10a6:102:404::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Sat, 18 Jul
 2026 14:45:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 14:45:45 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v2 0/4] ARM: dts: imx: fix ldb related CHECK_DTBS warnings
Date: Sat, 18 Jul 2026 10:45:31 -0400
Message-Id: <20260718-arm_dts_ldb-v2-0-f5669571aa2b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIuRW2oC/22NzQqDMBCEX0X23JQoWrWnvkcR0exat9QfkjRYJ
 O/exF57Gfhg5psdDGkmA9dkB02ODS9zgOyUgBq7+UGCMTBkMrvIUlai01OL1rQv7EWtulwVeYV
 ICGGxahp4O2z35sfm3T9J2aiIjZGNXfTnuHNp7P03u1RIkQ9FUdZ9FaK8zdt6VssEjff+Cx0jr
 wa2AAAA
X-Change-ID: 20260708-arm_dts_ldb-9ca4c548dded
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784385940; l=1059;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pE/c1aj7kr9/g7ESCMijCGtYGqapzbkFRZE/KHlB4Po=;
 b=C2BbCDpJ1TROLMrK5bKAAO5yX4R4wcYTNGYNyBfvFlpbgBAA60tVFnKe6nhuM9K0s2Ll/IDOX
 qy3H57GzvL5D990Ce5bk6CNmYsJy0OmRM4xMzb4+ulYLHp4gtAjBThY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: b866b44a-240f-4374-b3a2-08dee4db3ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|23010399003|7416014|10067099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: +/mrW0XvMW0054GVxuhDHMMx107NuM31Oei6fBTnS+hUMkxyQX3l/Wc11ing+rhs5j+pIlpHeT3yv4qSGDZbMCwfQzg6eP3l1IfHiLy5PrnSGt6/sxAvgbI9cDSkigDL0tCevhXMK3IljNbEnvMQa43G+fcFrXVpIhM+FgdzS7eTuGHz5sVKaTrs2FdHIaSetdy9t7LR4hye8qq5zZWYFGKZY3Vfa5JcPkQcZh1p4lKjX9+BW+9iL0sBbTB01S/qL3o9Rr3M6Sf7eTiO+CJC+RoEv9I5vxxxUEL7WKOWYoODe4E9/yUPwKyjxYHulmyg2xnbuYzCrmxLSvVdQrb8LD3zeAzfh2LCuc1wK7gHobp8VVxe3vmtFW5mE+oosBMspVKIREFUkudaTraCxKIviEiBtyTimp0JTxptnMmDJWcDjOkLbgc8jsjdwAP/cv6eRjgYt+MPrbgKdBRl28Vaa5DhlhVlCdQmLFlm9XXviody4J8rkPOeGrIcZpemfi1T9xUiSX1jz+hIDdaY4DrkH2WI5XAz3t0NLkns21GB6rC6L4YvpMTnS+tGaPLEo9DJOZsEhLoCqcqf+3cZQtt2d1veaIwFgcoXxRErYYgJl4d+UTIkjGBiCYspqaF/Uu+NkzZIxxXr/se2YoO80bI6/RRRC4No+66HQ3tHSrge+WE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2s5T2IwcEI1eitydnVsZ1NGNGJpTkdPcmZWOW9tK2RBblladGgySGpTazNL?=
 =?utf-8?B?d05CWTl3eEM3bjRBWmp6SHJPOSs3TS84cFVBcWdTSXR5LytObFlLVWtFVW1O?=
 =?utf-8?B?WlNvNUk4SFdmZ01ib2VCTzNBdkkxY2E3cXd5N2lHbVBIc1psRTJxZkRqZ2tp?=
 =?utf-8?B?bjM5RjVhbzcxNUdvVTBlUkFkSWw0enVoTElSYmxmLzhTdUlsYjlPSXpmamR1?=
 =?utf-8?B?MjFWaFVzcGhqWkNFTjREcVZuWjM0VHQyT08zcTNqbmI3bURnRzJ0QWpqalNr?=
 =?utf-8?B?WUFDNFpCbE9DRndRL0w1cEZ4aC9KOVdya1RQL2JjM1JDdWQ5K3JkaURhcE0y?=
 =?utf-8?B?RDFVV0R6aFpmRlRPR3dlS0NJbkVjU1hSL2ZSb0lVV2UxcWJQM0NSaVRDMEhZ?=
 =?utf-8?B?VkRIcm9aT1VCVGNmaGRuaGhRSHdMQ2RkbGpRVHJ4MWwrQ3oxbXJZWWQrOGhE?=
 =?utf-8?B?OGxhdkkzSUdmSmtqSEl5VGdzbStzNWZBdWoyQTVHQ2JORTdzd3oxRDVreGFw?=
 =?utf-8?B?NkN5aDNzTDYybStDdDFnUGlwZzhqR3RCVnU4Q0VwYXdNYnM1KzdmK1kwWnFE?=
 =?utf-8?B?UkErdUNVaVlGVTRCQmdpcTVxNjJ0SFJZVW9Bd2IzVjFqUDNOUklrRFBwV1dY?=
 =?utf-8?B?NkRGQ2pDTURRYmtaYUZCYlJobnN3SDNONnNYU0lFN3VzbGdSTTNXSkhna3Jr?=
 =?utf-8?B?KzBzbjkyUTczRmZ0dGVMaVBFV1Z2MHBUVWN6OXd3MUpXZ2EyQmxPMUNxb1lw?=
 =?utf-8?B?bGJQclAreCt1UzFIVU9OZ3R3S3JObngrcEpsd2xRL3ZhSUhGSDhEY0F2NnQ1?=
 =?utf-8?B?KzJ5Nnl2eWJZVFBaWnhnZjdEUUV4RW9Cd0F4OW5HempEMGxqTDUxN2Z6eVls?=
 =?utf-8?B?dWE2RW9DV3Z1WWZmSEQ0Q2IxOVpSRHlSOUZrTW8zQlJUUUpPZXJTamMrbmVS?=
 =?utf-8?B?OFdkcmVPREhCbGw0UGNxRFdnMHFjWWRBZzA0U1pJKzB0Wm9SLzVUbEVSaUZS?=
 =?utf-8?B?Y2R0T3ZSUldmenJzQWo3bUt5ZElZM1c1S2FKWWFlN1BldXM3Q1M2VzY4ZUlB?=
 =?utf-8?B?Q3RqZU5OMGZGUUprdjdXd2UxRzFKT3Z6Y1lFUHlKV1VmU25aTVMvb0ozcXRi?=
 =?utf-8?B?K2orelg2TzNnWlkzRUhlNnZMZ09IUHYzQ1YrWmIvRWtsYldDc0psRnFkMHFn?=
 =?utf-8?B?cWlCMXZjb1c5akMrRkZFVXdPTEx0R2NLZHU3QXh0RTk5VDcxSWRwY2JkanRD?=
 =?utf-8?B?b3JmSWhlTG1iUnlyOXZwK1ExS1lzekcrQVRabHppOFVDNFVabTJQTUh2VjFm?=
 =?utf-8?B?LzQ3S3VvWklSNDN1ejNqdWJuMmJ5UTBHaHhacTRMWEYyQ0pQRDRWd2NVcHY4?=
 =?utf-8?B?VDlQdFRFMVJKSjVVKyszL1B6eWRTdmdsU3NPNzNieVQyVW1VQzVxN2lIalNa?=
 =?utf-8?B?QnFlNjhORC9pVTdidkZ4T3dZT3NaZXk1anN1MklIdThkSUNrU3ZKZURGaW9q?=
 =?utf-8?B?UzVvL2YybGdjREUvUTB0TDVCQXZaTDk2Y1pHdWYwdzVFMG5rM3JXYmJJell0?=
 =?utf-8?B?a0NxM0VSajJwSHdoOVY0OFRkOVZ6TGcyZXpidnl2bVRoem53b3lRc3dJM2Rl?=
 =?utf-8?B?QVpPTlRjTkJNN2tnR1cxeGhuR1puWWRFZGxNRnlNeThha3l3UnU3c2RmTERP?=
 =?utf-8?B?MGtJTGIxOE5LZVFETzNnOWdWQ01MS0FXbGt0R2Z4R3M2VGlJb0dwOWVDZVdL?=
 =?utf-8?B?MUVCTmdpbEtUTSsyeFhBeWROTXJLMGNnTDhFOFFkUFJpRSt5MTM5ejB1N0sy?=
 =?utf-8?B?YVYrQUIwemhMVEQrSm1xYkhEUmptakZFNk5OSExYdk42dW5VeW1hRVk0YlBs?=
 =?utf-8?B?YVVrTXUvMXBRZlJEUXFJRGpBdC9IVHpDUXBDaXRaczVzTG9LUWZFSjZpRGJK?=
 =?utf-8?B?c2wxMlBZOGY0a3BOa3lKek9OVDBjYXpVUW8wM296dnBaUVVzM3YxNkREaFk1?=
 =?utf-8?B?MmxiTk9VeFo2WThqcWcvTXFsL094c1M1TjVUL1dnRlY0aW5PRTVyK09lVTRu?=
 =?utf-8?B?QWtJcURBdlp5RFd0TnhJWS9GbTcrOXVVN1V3dFREd2I2NVJhMnNjZ0lvYmpq?=
 =?utf-8?B?elZZTFBoVSszaFJ1SXFSU1p6N3ZkcU9peDd3OFA0b3MrQnlOeWtkVUZFc0Q2?=
 =?utf-8?B?ZzVyekVGUWhpQ2pINkR2T0xyYW1sRFhRWUN3YjA1UDM2OXJkdnpUSnc3dDRX?=
 =?utf-8?B?L3JCMmx0RnRDaGJtQ2YxSmIybXVSc0FhWUw4aGxEbmNtQ3dYTkEzY0RkcU85?=
 =?utf-8?B?TkFUR1JleFRCcmh4Q2RxdWJ4RjNxa2kxdjh1ZzNPSDFQaEJ1cTBmZC9WVWI3?=
 =?utf-8?Q?8KZ+4YgGZt8WyTq0YRUDsqLpzK4XhLIpaQilr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b866b44a-240f-4374-b3a2-08dee4db3ff5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 14:45:45.6676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IxOaqDcDZ+Q8eBXuK4gatEl5sehlGs0vKW3n8DXHOjIZU77mx5SuEyUQXwTqtutf+wE8IRj9GhzvgkatxuDjZwPM8g12e+TVhJmVa5JhsxERWnDPzRoNE5kHu6qpbaP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10258
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

Fix ldb related CHECK_DTBS warnings

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Remove status = disabled at binding example
- collect rob's reviewed-by tags.
- Link to v1: https://patch.msgid.link/20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com

---
Frank Li (4):
      dt-bindings: display: bridge: ldb: allow a single reg for fsl,imx6sx-ldb
      dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18 as child node
      dt-bindings: display: lcdif: Allow display0 child node for i.MX6UL
      ARM: dts: imx6ul-tx6ul: rename disp0 to display0

 .../bindings/display/bridge/fsl,ldb.yaml           | 23 +++++----
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  1 +
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       | 58 ++++++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi        |  2 +-
 4 files changed, 74 insertions(+), 10 deletions(-)
---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260708-arm_dts_ldb-9ca4c548dded

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

