Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2C2CD98DA
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F3910F477;
	Fri, 12 Jun 2026 11:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PAn/3KK0";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46FC10F476
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIT7jG4w3glvJ0Q2D/Dumc9HSJgVFQ3vGNktE9h38WbISC29yLXbVM+yngoonoOY3emcFf6zCHfzQnYDpUNOEkIqDG09D3zhu+NgmQDUFURUJ0XCOQXJM6FHsz8R4F5BQOlflB0Vu4eB7Ez1/WvbDsbFRKY4+SPyTww1s/yfkYXmN2snefoBVhKn+uAW3IF916seKrvUt+i9lLakdqtTOo4wUEI+on5acVq0UryRThYkBPRv6rxlDJdAkVEfDoplGRlzqjsZZHxI/nA6NlQdhdmCDJeWmBc62zdfSEe9hDNMtp8njyZK42mOsn6uJDTRJlAYruY3sYGPKf9/Av97fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFc9BPHJOJGdnTa8LeIktpGdu58tI2kLfK9Gp4owrG8=;
 b=H7gh/R64XS0Izy+/WUHF973m8skWV/vpREM0FhumXF32NvCMc9m7lExrhGcqAq5oq2giRYL7QNkTC1HT62iC5Xb+SmQWtFiDLrHR5aOrZhjl45iD0C8nZ4w1vOtoAl7NnHMf/R4O4yuWEqD1eqQ8DMI8OIr3P4fQpGENGeioYo1Tv/g/OrWUpOVGMC3db3wAokndskGebRqT1aItWLQ5m0/5CrrUiy3ddyAJHnNq4bWH4ETLSC1+vqY7EwE011d88YXCmlgtYbGoG1J4GhMl6jfycCJ7iLy5VIYGE6o6Wu6H37Z793FluMFH/9574YxMiYkm0qwqjw+4EKuYrjlqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFc9BPHJOJGdnTa8LeIktpGdu58tI2kLfK9Gp4owrG8=;
 b=PAn/3KK0mgk4nTNsuy+uI/IjeDPqOFMNVA4hA5rMjn+1UCGrPHi5/ziB7m+GjBsXz0lZuHeY/IfV4OayLh74PmsWxJOeGCeCDvcJjynIv9Jl/chK/OoHP2Gu21IUIaS2kXUCHmCyo9YM8Iffb2dvo6Wwxh/JSqufjwpF/Vz9KfWt2s7aXDo3of5gAv6nL3eH08gOQutqtDqm84S03qMFeS94hLVPKgszaRUXXksGIHGm/1+6YNyBZVarG6jfD+3VqXtEToqSwWf4zy1mKujxKvJg3hX3JkG0CqNgOhcm/Zi/Gi74jxm+f6uKei9wUgQJ2M/NOF5w0yqmAUUcIU2lsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM8PR04MB7378.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:59:19 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:59:19 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v9 9/9] MAINTAINERS: Add entry for i.MX94 DCIF driver
Date: Fri, 12 Jun 2026 14:58:40 +0300
Message-Id: <20260612-dcif-upstreaming-v9-9-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::6) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM8PR04MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: c0225795-a487-4e11-b594-08dec87a08b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IuC2T558gCDHH/cnFz1j6Kur0NP75dO+N+TpfQ+4QW4s6FZTOQksa0yE50pDMRdT/gGRblEkiFIQYHb0znzRokd+0eqanpwNBGugFMrIKcRvCwkO7cLVZ9L7RVMc1F79rvagjnzF/BGa99+otpKDxMO5Z1Qtp7o/dVLiBGBpsLhcdDimvadg/i1bs9+Q+X3LgLDFqZo57JNbT9+FhSmh+VLLCIgD0jhdAOM+WN/ljzEuqEtOYhYzg2v3iXrkjJ63SYQiIwE0XS6gZuRtUCPdf5aLFJsiKt478xmwzephOVtg7ACyo0BiXBMbI685THdHteXMv/8RLR06EGVc5vIWjmbAOgXMl7zlIXJ0qAhaLqJtbnzWPNT6bwXo/h4JjMD/9JPdDuqOcZIk6U/3RGbA4i5HuRlQNMwXVpKXir38LS8SEQIi/XcylsbpiJ48xLNFxTDYfsK+VgNcYLOmU/B9TmHeXNERVLkFW5KdHxhmEQSd4GwlZmUToTBioPtMUQ3ONaEr0b1PCb7YvT8EhOim7gcLh1jzyXbZjOvQmaqWR5mCmdH+io9B8jDDYTDa33vbtLuEwM0iojKcUX1nvo7QgXYoMbOSU+f5ooJARs1eD6tcUBH+2tjZtFguwmB16FsuOY3Esy6Bl413vBHiKSdA7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHB2OG1wYy9VN0l5dXgyZ1JjWWxRQW00Q0N2TFRqMXJBV0VBbGJ3eUtORnYy?=
 =?utf-8?B?R1RHV1pQdW05dWR2YllPK1dTUWgvT1V3QkVOZVcybk4xbXh1RkFlSFJXa3pu?=
 =?utf-8?B?cTZHamdqOWRydzRxZzZUWjhRaE8rOWxsM0JsdFVjSzFyaDdHRm90WjRaNk9Y?=
 =?utf-8?B?djBCTGRYS0FpQjFDMU1TektjTVN4UmFDY3c5YXdOYUJXbVpwbkM0amkrSElq?=
 =?utf-8?B?YVpBTTNWUHpiaGlqTlJFRGw3aTByNndwRk1qZll4SDV5eFRvNzNmZHVhVjBl?=
 =?utf-8?B?bDFLVkZKMHM3YkZwMjFwUzNrL2U2bENrMHFlc09WVmd4d2FoYU1KS215cnB4?=
 =?utf-8?B?eDFJTFRNRzloTTRETjhtOERSRFlqSy9qYlVobXNNRUhHR2lhZFg5UTJMMTlT?=
 =?utf-8?B?bSsvSFhqYmlmSmtLMmxHL2ZQZE0zKzdCeVJxZkVhN1FDYkowWDJKS2pWRGFN?=
 =?utf-8?B?b0JNTnZFeUFmUGVZVm10WndtMHIxdFNUNy9zLzBacy9RcUVPL1J1QjdiVEtT?=
 =?utf-8?B?NlhaL09kb1FNUFAvMDl1aUJDcTRmTEdGMVdhc05XMXJZSVk3U0YzaUZOcHN1?=
 =?utf-8?B?UlZlNzhUOHJQSUk1cnl0MkJpenlpV3Q0djRPQm1FZHlOa280STBKMFlYYnVD?=
 =?utf-8?B?U3Uvb25yNVZZN3U5czVNM1E5dXFpMDlXY1Jub0dlZzZEb1ZzTG9EOFczVThO?=
 =?utf-8?B?Y2ZHbGduN3NYY3N5S0FnSHJoR3MvZmN6MVdGSC8vQXFtdDQ0T3pSdWFzVVZJ?=
 =?utf-8?B?bkhHSFhOdGN5TUo3UGgxNEEwTTNlczdudGllMStCSm45QnFDRWlJK0pVbWpV?=
 =?utf-8?B?Vk13YU9EWVRvbUFMaGZ1M3Q2RmhoTkwrTG9KVnEwTjQ1bFNzRzJuWDR4TVRY?=
 =?utf-8?B?dHZCUkhWTTAvTkdSWGNWbVRta21hZm4vSUsxQU91eTNUbmp2emplWG1HQXlm?=
 =?utf-8?B?KzFPZHlvYWdiNWRta0lZWWNYR2pvTm1TSWdVWk9ZekVWQnpSNEtydmxQTjBw?=
 =?utf-8?B?czB1b2dLUFcxNmdydnZraXRzTk5FRnU3VU13MklEMWlwd21ld29QektvdjFz?=
 =?utf-8?B?b1ZuMmYxb1RLMGJRMkJGbzJXamhkZnZrNVpzYng2RXNNQjMxWm9jV085T0ZN?=
 =?utf-8?B?eVliSWRHVkVrOGlMQjBIc2hKN3BSZEVmRys4YTNZeUxZOVhYM1BEd2lheUEy?=
 =?utf-8?B?TzhrYU5wRFpHdjdESXR3RUUwVVpKNTdwYk1xS2xIVFhVMS8rUEdOVC9leTVr?=
 =?utf-8?B?aFB4QVBOakpnOGw1K1dRWFVLTEIzZDZRclFBdUhWb3B4UXo5QmRyMXRMOTg0?=
 =?utf-8?B?a0ppa3Y1VHF0UkJRb1NrR21ISjU4VW9RV2xLcUFwUmc1Y3hEd2RSdDNoVk5z?=
 =?utf-8?B?K2ZwZHowSzYvRzdnVDU1dzFSRHBVWHFPUmNPdzF6WWFoQUJXdWlBeWdYTjdo?=
 =?utf-8?B?M3IwaWlyK3hxcDJTN3FPak4wb1l5U0M3Tmt0bjhLU2RGWkl1TU1lcUZMbHdO?=
 =?utf-8?B?WTJqVDlkQXlBUDFCY2JhUkZZNkJQbjhQRXdNcklKUzdtQ3MxT1FUWGR1TVQ2?=
 =?utf-8?B?a2lFdzNrYTRuZEpMV01oMXYrVzlGMlR6YmxxS09BU1RrbVJXOHlBWkExdC93?=
 =?utf-8?B?NDk0RTE5TFpqRGhtYVpCcUNJYmIrR0NFNTB5L3BYY0VBZWJPdEJrajdtTEZt?=
 =?utf-8?B?bTBMNG5FZlJCSFdBUXB6WW44OTlTcmREcFhsUVVlclVxMFdkWkJTT2U5UkdE?=
 =?utf-8?B?dnh0Q1A2andKOGxRQzFMM2FRMzZBTk9TUmlZWkJia3BKc2RRSnA1TytTbDYr?=
 =?utf-8?B?Z1BaV2V4QjdyRi9MdU5yU1VoQStLcHA3ZllmTTgxdVZRK0NWNTJiV2pkZWpN?=
 =?utf-8?B?VXB1Mml1OTY1Q2NkejRxaGJCWTRERmxuSDlBdGpCSm5CRG1kN1BUc1JtVVFk?=
 =?utf-8?B?NjBvUUhEa1JIU2lRb3ZBcHFPWHd5Zk8rRng5S3d0SEhUQndPWUhYUUxFNEhl?=
 =?utf-8?B?LzJBSFZXMzV5U1hsd3FiWHNpSm5jNm1iR2RsaWdEeGt2VzJHbER2ZjdJVCtS?=
 =?utf-8?B?VVJZNHpFMUw2MkdWbFl2ZUk2ZXl4MldKc1NDT2FLTENUNzZ0Wnk2OXdNTzVT?=
 =?utf-8?B?djJlR3ZFN0F4dXlrdEpoTFZsZmYvOVAzZDIra1hCRGFFYmc5a1kzU05VeDZD?=
 =?utf-8?B?a0w2TkpPQTlFaXRIaHBtVlZueXNoVUtDVUd4eFYwZFBkeFBhTEFDbHBxV2Uv?=
 =?utf-8?B?SVZmV1Z5dUpJTmJFZXl5aTJwcWhxR0lnbmExb3JwcUxmbm9xWWFQZDI5Si96?=
 =?utf-8?B?K2JzSlFxYmJtVWFLdXdKV1lvOVFFQjlPMzhUWnJ6ZGlTNU5OTlV6YW9hVUtz?=
 =?utf-8?Q?E+RwY16Iai0c3nn8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0225795-a487-4e11-b594-08dec87a08b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:59:19.1608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I05PbkyK2/280eLeVtmRZq8SgvkoaHVva7eO+/3q3xPfX2nJNrprmK+p7WH1EkR69vUxqc3KvJR/OwnuwaTXyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7378
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

The driver is part of DRM subsystem and is located in
drivers/gpu/drm/imx/dcif.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1caa6e5198b9..e8931231b5b7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19492,6 +19492,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/nxp/imx-jpeg
 
+NXP i.MX 94 DCIF DRIVER
+M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+L:	dri-devel@lists.freedesktop.org
+L:	imx@lists.linux.dev
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
+F:	drivers/gpu/drm/imx/dcif/
+
 NXP i.MX CLOCK DRIVERS
 M:	Abel Vesa <abelvesa@kernel.org>
 R:	Peng Fan <peng.fan@nxp.com>

-- 
2.51.0
