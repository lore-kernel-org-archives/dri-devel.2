Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC2FCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3932C10EA1B;
	Fri, 12 Jun 2026 11:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jFovW4p6";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011025.outbound.protection.outlook.com
 [40.107.130.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2E910E9D9
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc+DWknHfGgtI+KI4qFMKCMf7vRRJhtoXU5+HjmLkM2EcXSXZypXA9A2KVQN3edX9Ema6Ktw63pd2yFfQVyl8gcYX9Wj8ZKB7+ie7D18W4cBxtBjFPz5kbNRi2dDoBAy0THrRa3Yh1uqtS6YqDIyeE1Ng2yvwk4eiQlw2Qsn8mH5HqAV7KQMiCHcR+6S/QxyDUPJDQZYqGWI43fyukYCoYb3U64ZVsKpoM78Gr91DyNHY5xAblQG4inTNnMZvxTaTdsFP0ccB7wIAv5gJBJ59NbsSKlfmUNF7qpjadmSvnVu6rH9hHrwSG86+9/94lKPrQ2NkYZzqRZH7vuZACA/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkkMlRHRMa0R1vMZ0wcCMT9hJOHlKA1WbEGTSAhUed4=;
 b=VOjpLeXgI2VkU8DNFvrEiyOxF6v1ugYEyEqodGJoHhcNKUR6sGtF4T8m0geda7X7i611q4hMIXoCmAX46hqVQ1q5LX8IbcsVW2RfMPCst7y/YA4es5nBUnZ53cRH/7ysAYIjEuYafZAl1lU01xkehgDaKJsscqIHHIRcU3CY2on8IuckwHso65qh+ahvKCk3eB1GTy630p/vC59l9i4PqV81BuALGTSnkaYLhOgKD2g2QI4/d5tyk6/lxH5VPnfh2w4s5zGQMCWcDTwBwIitLcmA11mHT4ycMY5B3wPWzybf1ozHGietl5SjFojupGQQ/DW1Yk/RujFaBCrAsTNhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkkMlRHRMa0R1vMZ0wcCMT9hJOHlKA1WbEGTSAhUed4=;
 b=jFovW4p6NhFtdRNbXom9nA3g/2DjYSVUkqomVRo/jManslx5fYuPB6jESksDKdBdVVvhSAXBgaAUAECoBRhPrlXugXmbEGDVPKMQo786KWHwqVye1dXKltibb2F5VlEqCj3TsLBu3gIMV6nXm+ilXPUTSGk9VqDe/gFyIOHRqdi+RNnRlW9fbTpuH11lrXPUwxfvRRz5mkq89dtvvdoa3axZG0UTaudDsB4+eShc2veFMXohWL/WO60hQ/oNu1Ofs0nv6YWtSrTr+Ou6jYSo1hrlj1aSYme9ACVYngz10+er3O/8gxdYSbtxqHQEIR5KoLcUjhMAsKEBQmE9OLkU+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB11710.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:58:51 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:58:51 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v9 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
Date: Fri, 12 Jun 2026 14:58:32 +0300
Message-Id: <20260612-dcif-upstreaming-v9-1-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::13) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7d50e5-f325-4af5-3ce5-08dec879f81c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|1800799024|376014|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NrpbJRzqHe3wa4N1EnwSRzIJzdvs9mfjB69dX1S30HO7KA7ZmAEaOGcMbs+z0c0x/NANABT5MbAXNn6epsfK2WO3U+VUgRU3B9KivGYeDEmvdi3CEdzOvSLecMySwB3yW8RjBBHblPV42FZKQoF/DJeCGqjVhSGYqblytNIQw7CeZ0RM/arpAZDSQoG+zHOgyjPmlhc1GA0whOi1XfGeNy/y4W4CrbyYoyOoBduTAJUH3wpvhApyz2VBUdmhCYLw0Gdejr1BpV0/8yxrZrRbf3hWMzXpnsxn/iICTX1WWqL8OVDIPLkeqClGH1LuU90JauP2jf3NLD7JJDtI3uvyMWTqEN4t9bTyT8mGm+Vp4yUXLdsJmmw0r236LHIToDix6D+rMADXPFpjnKCoErK6bE1+MxlW/AV483hhHU3QcIkVyehKBc20UUguryCeCT4bAnv1LIh7j+pfucyrdNYBdCcsDDM08YP07CpEDR9CqI2t8AGYKshvI+tHtbjNERINzKPbWZxIfThOW3qeJAa2QU6bHBWzd1hRR0h1NKmHRKNZQBDJ+veAdStO59uTSUrWbIvW0eVjJgnWU527egNtcQV2sttHebbmdKTTXzoVxTy6g5Ht/1bm/KG/VdChEk3Uo9cbLv2iwUMi5wabLDM0+k7cQtGcEbc+gRHtJPiOsnS2jKfCBvcdcNaqfK3CEyZ/n7dXQWh9xPnkB8mIckkACrk/9lCEHAxlpSSthXolBgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(1800799024)(376014)(921020)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFxOUJmOXBMeGd3MUJCL0lRdjhaY055RVFkc1FHbDgxbndjaHFNcmM2UjFS?=
 =?utf-8?B?Q0ZGT1pTZmg1d3JkWlNEdmhNcEFLWW1KbXErNnBNSnJOUHdadkttcU1XU3Fq?=
 =?utf-8?B?ekY3OUF2M01Dd3RKOUpBV2VaWjRWalgyaFFRdGRNZlB4aC9UaHBRTEJ1Z0Fj?=
 =?utf-8?B?WEw0WWJtWUM0bzREZEo2SklxT0R4Nm9nSFN6OXJtWmpXZTQ4V1lFUGhMVDAz?=
 =?utf-8?B?MnIyN2xXbURucGtMc2pIL3Ixd1hFYjZHdnBFQUd1bE1GaVBheldlZE94S2pr?=
 =?utf-8?B?cVAyaXNxTVRveU5Ka0ltaFFVeUZRZGQvRnU3V1hXandtaHltUm5JZEQzZWIv?=
 =?utf-8?B?dHRSQUZsVzY2WDRpSEQwb2VXWXJUQi9wZ0FaMzdWa1hKakUxU0tMcldmcnBZ?=
 =?utf-8?B?dmpoSSs4dVJ3dUJqR0VZa3NjZERaOVpqeUdUd3BGK1Z2YStTM3hkQlJFTEZP?=
 =?utf-8?B?UzFFNGZuMkNRcjl4ZzcyVVVoQ3VjbjYzaXhWOTZwc0QzcUZFWHROcXB2UVA3?=
 =?utf-8?B?UEp4akY3UER3S2lzOEdZZGRGZC9mNmoyMUFkZVRST0diSEJET2VvQ0Y0N210?=
 =?utf-8?B?bXpXSnV4M2dVRHdxN1JkY0kzbnFVS0R0bVVSMzBOVStZNnBFN1JEcks3dnJr?=
 =?utf-8?B?M0s1SGtUUVA0NG40dEYrWVFJMXVVclJTN3Y1ZWVuTjlyOEZ2RFhMV2h4dTVq?=
 =?utf-8?B?ZkhSM0lYL3F0VFZ2QzM5ekhaYnZqU2JDbWppVkgyOGVsYVZMUkdpUCtZR2Nq?=
 =?utf-8?B?MzhQLytMTjlSaGFyaWxPbE1BdTV2N0V5QW40emZ0WHBNSi9YelNoMWpUVE85?=
 =?utf-8?B?bnROMVdwc2w3aWY0OGhUMVo1U2Z0bXlVWm9HS1pBcWpPSlFtUGFCYjNXaEdZ?=
 =?utf-8?B?UDdDbGJaTVA1TnNXc1FvT3dTYUwvL2VXaVdmOWx4Z09JOFplRVVWMW01M0ts?=
 =?utf-8?B?UUFXUTVaMlRJWEIrV2F3blV1YWZaVmdIczhXdFQ2dE5ZaURaVkpxNDNRVDJC?=
 =?utf-8?B?eUpJVEtEYmZRNkFVZ25FUjBIRllVMnNxK1ZneFppaEtScEY1NWpDWitFdFY5?=
 =?utf-8?B?MDF2WHFEVkZ4aDVIK2t5OGZpWXNwbDRHK0t0VFFjS0lhak50eWRSSDMzcG5k?=
 =?utf-8?B?clJGZ2hrSzVOMTRBMWRFZjNWMnR3L0ZtMDMybVR6b0NvTGZuaU9GdzdPbU4v?=
 =?utf-8?B?R2NJMVc5VklnSUZqbFlXbDlKbVIwb1VKM2xyZGNqVFZoTUphQmZTaWNhbWgx?=
 =?utf-8?B?cWJFZ0RhT1hnTkk4ZDkrcm1DZTU1YjZESVg3b2k2T2llOHJZWGJyOWwzRWRW?=
 =?utf-8?B?R3ArRTZya1BxbWNLcGpobXZGT0xDWEp6S3htZ0JTQ1ZZeTdjbzlaSEI1c1pL?=
 =?utf-8?B?Zm1mQm5sNUR5SVJaOHNDSlgwQlZZbGZjVllBS0svOXRIMUpkWDRrZVdCVUp4?=
 =?utf-8?B?VU1vb0RYYmI1WW9tR1V2UVIyaEFzVVFEYVk5dGQ0R3F0NVhuUWRKelE0Q3Rj?=
 =?utf-8?B?Rlh4WDQzRFhpUjNLMkRTV01oTmNoUEZyRFlsUmZXUURYS1RoaWFRZGxIS3RW?=
 =?utf-8?B?a0hBOTM1cWZSNFFSNTFIZCsxNlJYenVLbVZCYXprNTJkUFU1Q2NSeVIweXlw?=
 =?utf-8?B?ZThGUU1kZC95NGl4YjhkRCtyMCtmbTRWc2IxTk9kZnpMRXBWamlUSWdwbXJ6?=
 =?utf-8?B?TG1FVCt5WFhvdDVvZGxVWm4rZGdVay9tTmd5T04wb2RqbnFDUzd1MlRLOERi?=
 =?utf-8?B?dGk2R2w2UVVMRmJlbkRSOHRTNlFCS2hFL0pMNVF6RWEvbDNsUEdIL1VvZmpM?=
 =?utf-8?B?SGt6eVBucForUTB3OXdVZEJzQjc0OFBVNzMxazhXYWRoK1NZUGxENkprdUQ2?=
 =?utf-8?B?Q0diUll5emltdlEzUVBiNVJXZkpUcUtHMXhBakt4YzRzdWhrdDVjT0V5eDMy?=
 =?utf-8?B?blZvanVEK1dyNlRMZTdrejhkMVljZEJtVDY0UnFQSFpmNlAyQ0l6cHR0WWQ4?=
 =?utf-8?B?SVdueEg2UkdGU1RnL1krc1NMZE44c1dTUFd5TWFPcGYyOWE4NW5POVo4MHF4?=
 =?utf-8?B?TUVoSy9mWE9CZDFleTVzd0RpL29Bc1ZLL2VYK3FKNkZpVnZEVjlPMnV0QXo2?=
 =?utf-8?B?RzZFVEltT2NrOC9oeld2YktlREtsbEpUTHBzTk1XWnNvOXEvM2Z3ak1FR2dw?=
 =?utf-8?B?NVhJcXZBVHUyYXRaQjI0SmRrRmE0MzZQWTJsM3VaMVA1TUZiWk1NMnZ1bjFH?=
 =?utf-8?B?a29FSTlMcnV5aVhjd1hjYzE3c051NEltTGpyUm1yL25sZ0pON0NVbWlVRkR4?=
 =?utf-8?B?NHBRY3daTnU2dnYvbUNOWHh1c0xFOUxhb2xLMVlJblU1THZOS0RTVHNpc0lB?=
 =?utf-8?Q?Q3SWNdSJPytmFbMU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7d50e5-f325-4af5-3ce5-08dec879f81c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:58:51.4125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/BnZ5BFirGmIeSoKyHRY9/FPu56ow0GbN88JzZ5wKlAhn7TBQvZmtMG264D8/TMQSNpDLALo+nFJA1v2KZPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11710
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

i.MX94 has a single LVDS port and share similar LDB and LVDS control
registers as i.MX8MP and i.MX93.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
index 7f380879fffdf..fb70409161fc0 100644
--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -20,6 +20,7 @@ properties:
       - fsl,imx6sx-ldb
       - fsl,imx8mp-ldb
       - fsl,imx93-ldb
+      - fsl,imx94-ldb
 
   clocks:
     maxItems: 1
@@ -78,6 +79,7 @@ allOf:
             enum:
               - fsl,imx6sx-ldb
               - fsl,imx93-ldb
+              - fsl,imx94-ldb
     then:
       properties:
         ports:

-- 
2.51.0
