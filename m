Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13417C531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704A010E5E2;
	Thu, 23 Jul 2026 19:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cQ5Imk22";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011018.outbound.protection.outlook.com
 [40.107.130.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC23D10E5DB
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwiA8gJuEpwCLVsFY88ntEuvqewvownXX1t1BX3ku0EEOywJEnVxSyrdZavlU8lJWIQSKC51hnhk+nO7CTCn00AqWA42DhYZ6jMV6WVRfPpLqehBZk+84ERB0f0ALQUXtF+L/cs9gTHiV1atAjAut+CcIQCZr9NuY5zwbEBSH+ajE9w3fZUDRhpJ926rjhwdP+Xx0VPslCjUyPKYjuHnG+OeIo5g1K3RV5Fliw/4tGnKBoccFYfxsI0JedQD22lG8VvqJUXpAlNyPtIGyJMbvFWz5Q6xMb3Pk1bW/KkWGu3o1Fx7Ay23/biKUYFciJfKkP0BivRmAhvXz8uZbRcH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4tehzPf7uu/ei0Ds6mLsD/PtUbJuEqJ+QFyCb16DaM=;
 b=KclaY6Hjsc/tMR6F6k3or5uqGT8pr6TzmdzbDAIiFxK1+kZKd0/IzMmepwEG6+KuZTQ3O65H12wyNaOBP8JAClDbXbZaI0HzzHFHMxJ7zY5/wIFvq6lBbpjPdZA+bUiMEiR3t2xz5xYUDegWAaYiiUSt2UpxWc2RpvEBwIzYXT5U/oP+yoacpH2ZRzxOzr/fH+siihSpd5NW9qfMUatZGg5G2RQoBIpviEkSBiSjFisX9EHscOJY5pE1euJT3K6oVBVTVrvEXaaAPdR/7AfVjcBGVWQagLQmHLPD4LPilZpi4AaF1BU1Bud+YkqFetXI0R02L+1nZeANIZuf7TC/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4tehzPf7uu/ei0Ds6mLsD/PtUbJuEqJ+QFyCb16DaM=;
 b=cQ5Imk22VTlBDmTs3b6dzaRmedCUwNdnPJGBuaQ0IdowwIM9dD6zRLQYH/OGnMg1TL8Je2RnfiBRJViQN4LqSP5oSNMYpE2NT73qFa7Gr9NXcI7LKBMcpWYi0ybtyf/ULLh5OFhdr7VQpJ1bj0wyv5IK8H+ayGbaMOgRt+n1VCcoINVXVR8WRODxbrFYuBfmCaBhiWZ6OP4M3RJcDmW9Xat+NCJc76mxp5DVyzHrt4KRHtgkor8FdQtawyrOB3B7sU9ebjb1SJiklffL15GCO/u+CDcYokEtWngQbaKo1+Xyei45ex0oSrjZhhWLon5o8l72qhTjMDMWw9sunvDXhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 19:14:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:14:42 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 23 Jul 2026 15:14:18 -0400
Subject: [PATCH v3 4/4] ARM: dts: imx6ul-tx6ul: rename disp0 to display0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-arm_dts_ldb-v3-4-96c784b2b84f@nxp.com>
References: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
In-Reply-To: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784834058; l=859;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0hpK498VUO8dxtBKG2KA9GUlzyB29UEOvgq/J4+0ua0=;
 b=yH5c/yV0Mq+7dDqYrI5agBvOk2c7EXNU4T1fHZJkye3zDcX4IZaB+7jDuA4je0ktLantKsidS
 L2SWMtaFFqRBD+ZZKJb1RZ8K6TbDZpGRAyZPIcmgIjS6itJRYTECdaz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:806:d2::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: b91775d3-192b-4741-f66a-08dee8eea613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|56012099006|10067099003|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: RRqBDuUhfOCG14RFxUmTzJM+5mDcE916C9c6L8h+y4k49Q5NHN42BkBuP1MTlxeO40YYpeMHA1aRw+dfyp0rimGrGDrZ/pceIRFeNSQXk395vFo+C11b8vm0aMNt3HC0gw1iRySrXuYHBcFZ07yQoIfnWdmp7y4B0oiYArVYue3Qb2AClJxWdUvJ+b+9kgiIa7JXxA7wF1xBdOON1e+pKGGUZ9K6VWdQIACGvuhDUfldHpiK15QhpOSJ3N8HHNTXzTlEd0B+T4OH5ahSUHtKbq6aRjUL4SP2fOPT5MhIvgPEUDi/4lSO5k7uCOBwjTR87NndPiDdSMKJb1ZYneuBx5EQsFH22J1eDWK+xOyfUAKmr91MdlQ8qdmTX/I0gjgs3ZNlfPBbIz1s8nNeXw3Wtffl2FpAS8WO1XepyniUxYuzghN+cYjEXYRZgajku7nY8R0MLE4B5MTmfuXcBRklmtFo1RI9BaSoDWl03crEHQyWNJApNfhJ5g1rR7fsXDYEcHURfIWDnZ+Fc327mcB1gW6db1HlChMpcEFX1XEkOWwe3wT6sYoSQDifS52ppt2z5wy8IK4NbMcgXDgSzZs6Z5VOVuGuCUbp33pRgdJAC+gldMKDbtGv5uOApPhuPQFSSGCp7dGW+NGn9k+6Dh0sukrWKE9asjjXyzQn3hqAWJ9iIUmA18+hyyVZT4roWpm85G20cTzAiBuh71kBRzGRGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTRJZmdjUkIza3dCai96Zm9FRVhZZDZCMVJrNEFTVW9WWjhINHpxbGttL29H?=
 =?utf-8?B?NXc3K1ZiYjk4WlVJYnFBVmJiZ0IrTTN4OFN5YnBiQUhBc2xXRmN6Z0FKdEZ3?=
 =?utf-8?B?TmZrcnVaZ0UxRXNwS2ZGUCs5NlVqWXozWTAyTGY3WThRTnBMTm1HNlRwZlYv?=
 =?utf-8?B?UTVIelE0MTNWc1hUd3VMN3BUNGovTkFaZ3VXUllLNXYzQXFJamlWVlFLemRI?=
 =?utf-8?B?OGFURFU5N3BETER1RW15bWxaMkVRVkNSd2IzV09kMjVycSs2RFNKZFExLys4?=
 =?utf-8?B?K1Z4RnpOQjhyS0JHQ3hUWm5NaFBqWCswTkhkMWpvb0dCdjM3NC9mSFpxWEEy?=
 =?utf-8?B?ZjQvNWYxaE5TK2lTS1pIcXVOTit1YUJxN2hab20rWTZGa1VmNlVlWmdmRFNi?=
 =?utf-8?B?aXREVEVVWE13TDBLZlpZZDBmTEIyenpUZmJSalRoWGtDbjNrV0R0Zm04ZzRx?=
 =?utf-8?B?VldUMUVlVHJ4NGR2UklpcHVPNk5Db0krbHRUZlNaWnpPM0IwMGxTUWlkRDNW?=
 =?utf-8?B?ai9WU05aTFphN081WDVpeFpNSGxRemU4eXRUYnpOZUFXOHpJUVBqSVBaQWZm?=
 =?utf-8?B?akJxcmhtd05DMjljRmpoKytTVG9PamRPS0dXZnhNNkZPWnZqQnJ0MHVqblpP?=
 =?utf-8?B?b2dpTXhuMmt4RmpoVk1kWWNYVjNSZHgrcElwOG9BWUhlcFVFa3lZbm52TTdi?=
 =?utf-8?B?dGUxTTRXQlJuM3lkZ28rOEFDVGFmYVhhVzdySGxwWGpTMWxFc05vVnFqY3B6?=
 =?utf-8?B?NGIvUFNCMXExSGtuVWtEbGZHd0hJblY3TFJCVSs4aThMZFhKQTJ2WDloRlo1?=
 =?utf-8?B?VkRuMkMwdFlCV2twbHgrb2Nna3g4cjlpQzNqczVYQXZtNnNOWGpBUnl0a3NR?=
 =?utf-8?B?L2ZibnF2azNmZFQrSjdXU0c5U1NwdURoNXVqV3F6WkE2RGluTkUySzhNRktF?=
 =?utf-8?B?UUxBdURrWlp1RXB0R1M1ZVVPdmZHRFlpdXVGRWlwcHJOOWQrVHM0dFp0SEhn?=
 =?utf-8?B?V2NTaTRRSWVUdWpBdmpkQmxXcE1BRDVudmhMSTNFWmw2SXI2SUpvSytpZFEr?=
 =?utf-8?B?aGM4bUMxZlZqMGUyQmFxVyswVVdtWlIwSkxQdDJiYVlLeStmL2hEd3RuZWZX?=
 =?utf-8?B?cFdScUcwR2YzL3NZK3VpNE5tZkJ5ejkwZVFMVVltb09HUjd1S0FBSHhGV3Fh?=
 =?utf-8?B?OUdPSVQ3RXdSMlIyenNub1hSVVc4N0NhZUhrZm1TU2dRL0hzTGhUb2R0c0dE?=
 =?utf-8?B?cnYyenU4M2tEbDEzcHg5cFQxbFJQd3lacTVjS3BFR3FqMjIrTnJ6WXBwSHBV?=
 =?utf-8?B?T0J1Y2lHRytrTzhBUTAvUUxObUlZbHRtQWZjMVpiRXVJK2w5UTgrRUFYUXNt?=
 =?utf-8?B?NFNjYWpGWGVSRVNFV1IvVU9NSGlXOFk4dUxRem8vNmpyRnBLbjJXVFhNYUQr?=
 =?utf-8?B?ejVpampVak1zVlhaRjN6K0lNek8yaE5nQXFPK2xWMEJNQkFURDZGdHlXR3Z3?=
 =?utf-8?B?VkVWa1RqbzFVdldDS1FDbjhtaUtacmJ6SktMZk9vMUZOZkJQcll6RXNTUksw?=
 =?utf-8?B?VjlhVUg1Nkx0K2pmaFB4bk9oYkUxbndRRlJmckNZRXMvSlVmaGNFdU0wSUx4?=
 =?utf-8?B?dW9tS2lGeDYxcXpPNHBOZ2VFVEdtSEhTWEJmNnFjKzM0WFB2ejBGM3ZUNTJz?=
 =?utf-8?B?TmQxbCtlakluVGZmU01HNXRBRUl0NnMzTTZGNThKN2xMd0VSWVBzYTBTS2d4?=
 =?utf-8?B?RkJnRjIvbUVGMndBVGw0L3JBczlpemEydkp6VjVkSXlDeFhqZjU1SDdZOVpr?=
 =?utf-8?B?bU5XUjR1d2JuK3ZLOFZlQnUyQzRLOURLa29sdXZibFRrUGpoenhUcUhkUGpI?=
 =?utf-8?B?ZnVOYk5RRGZwRW04YUZPVmp1U1pIbXQzdmhTaVVSZjAxNXJEREFoMElxcWRz?=
 =?utf-8?B?Z0IvSXJ1c3Z1YnBaUVVwMStPcUdwTVBoSjFiNVVhVUd0SDgzdStMcysrSzBq?=
 =?utf-8?B?V3NHQmU4R1Fna3hzZG5RUitkcGh4VzN4RlltbVM2VWRVUldMQklkZG9sTTFD?=
 =?utf-8?B?QzhQcVpGcWU2d0FGTFNlaGlWOFlFKzBZZkl0bUVzdW5lMEZ1bWIvRWtPK3RP?=
 =?utf-8?B?Y3NMQ0tyNnA0cU1wdkswSW9qWlEzaGUrNy9Da3BFZGlmWjhwQkxqaGdjdUpQ?=
 =?utf-8?B?YWtwb0RnMzdyRmJyM0RpdHFvVklzdVRhVVk1a1BCbitoeXdQL0cxUnBnSjJy?=
 =?utf-8?B?ZXJRYXhvNmg5ZmNwU0JwNEZhbWdLNi9UcW8yeTdnaHB5VEhaaVdRZldGSWZB?=
 =?utf-8?B?aG42VEg2UE05NXNHbTBIZkMzUnJ2bHIySUhZYm4yRkI4R3dyNnpKQ0tRaXVI?=
 =?utf-8?Q?TlZiOGGRwP5LdpsIpuxG9+W7KxV+5wjAVp3eT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91775d3-192b-4741-f66a-08dee8eea613
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:14:42.0933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHvhG2h/enUyX8nEyxLWMC6pvHrrYnJssab6LrTU8PZKcubwwkcQ3cBTkF4DcV0FoB1/cq1EkbGMYC6JkyAP86k5zAYmg6tpzNvecSjyMYYe3OFmeD8zYjZs67FdhH8A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818
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

Change node name disp0 to display0 to match binding define.

Fix the following CHECK_DTBS warning:
  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dtb: lcdif@21c8000 (fsl,imx6ul-lcdif): 'disp0' does not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index 192c6a95ae589..2f6916c0359c5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
@@ -369,7 +369,7 @@ &lcdif {
 	display = <&display>;
 	status = "okay";
 
-	display: disp0 {
+	display: display0 {
 		bits-per-pixel = <32>;
 		bus-width = <24>;
 		status = "okay";

-- 
2.43.0

