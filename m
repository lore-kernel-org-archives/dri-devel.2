Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03C606BA9B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s2YDrH+e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435D610F624;
	Tue, 27 Oct 2026 15:01:46 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBAB10F624
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRCNOM+hbI9ipy+31QrsgnGBqFIuqnOAAVcb6g99goWGUkZEZg19PnCvZ0rJc7O9CW3X9pWsSjaXGIo6y55zddvq/7KN6HQKmBnQJbf+lbakDAr68BHFYN7SKLuyvJGqdRoEPki0tbi037yzgnsrLjsgr4496/GZwi6xAZ/dmqEMa5zsnZUBknwhbTOOOA0eOZ6/cIoZ0tdextW6YI6PpBWXjIKTh3Y7Lakzh3Q4HecbcwjGSkpbdDO4gXO5AcdJquqnYvJ7HTcHHrB0w3WXBAf7qtBG09S9zlb3Pqgagb/LFv+61TeqbRakBALlXCK7BAk0wWWlB18P88StFJTPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyzbOWhH6L9bGdi+qbItJiaxl6aO54n+HsMwa+fkgDc=;
 b=X6SlzeYtQBK9CAG76Y3d2nIHzSaTaaoGzcSOB2ZX0VKey8i/aaO3qqh8oF4LqWaBgDI10IwjdyWdqn2lWqbTYzcTPUv/8B/XZLVBJCBkRRvfuEGWdkOWyBqemmXz9Wc0fwMFPEmlQ2CHWQlpGD/2pk7lF188gfW1zCmU4JyBM6t1vBX9Sfd7QVpLBw7xn9dplycAdScEj7BfXyszZzQhL2B6zPf4u0sN07JvY35/DnPbqd5ERIh/QRjGf86jcElsnn+EOXEU8kTKmWcovVdBUOGFQWAk3zSYQXNLn8xT3ydEbt61VDmCdtreefyAEwNdtAieVp0CfA5w54JBu4MUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyzbOWhH6L9bGdi+qbItJiaxl6aO54n+HsMwa+fkgDc=;
 b=s2YDrH+ea1iNyqGKVZROuzQso2NLylREN7iEP4O53FVGAY4q5dXfGZc99fwUaYXqvXf1AUlxtz97B6fIYTctcxGERPhKOZpWKUEwAwqLl5fgXNfQ9NLoCMLdSGDG1/k8rYpYDELgJGPKMyM64W6n9vv939XXBDdeThUd/+cp1dmjrZS4/HMhOKHfSbmU14gGtPs7fhEJdVpn9g+9O8bE+0tfs1ORz1qyfYc+J3ZJMxLmXo7jp07Dya4A8V/i90/1QmlVPNJ4myM6nyuAF3skC4pyZfZ/Z2QGi5v4bfWh5pRBnB0nlT00ewIlvE9rBaqb1cpmg3fyVEpZFdJgoWTbxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB8445.eurprd04.prod.outlook.com (2603:10a6:10:2cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:31 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:30 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 27 Oct 2026 11:00:58 -0400
Subject: [PATCH v5 6/7] arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM
 pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-dxl_lcdif-v5-6-3a974e4b94b2@nxp.com>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
In-Reply-To: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113256; l=1575;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=b9hiDDMWEkh2Dso8bmlBoGZhBm/DsZpNoVGQtK+GcTE=;
 b=x7Tmg7kxGSZoxnnCXQyWwsH1/Uv1ZdAKOE0NA8+CqqdYSSrOGrMAMO1bWF+nFT28UUpFhjfEd
 +qkLzr6tTKjCDsRaySu6QPFN7KFs4fsHoNRKBc9PcYIG9Ppb1uEGPaY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DM6PR02CA0165.namprd02.prod.outlook.com
 (2603:10b6:5:332::32) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 50317690-d8c6-4641-895e-08df343b2f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|1800799024|7416014|376014|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|56012099006|3023799007|22082099003|18002099003|921020|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6+YLVwSnQyZkcjpsG/xUxeDYCmRTlKwT/FaMxtdXqjNGqaQ5jvgwlVi3YZ8vFHxZe/coRyBqLxt20pYzvlhjmYpdijjhaBoECtBmKZBe2k/wu2BgVvr3FO7jgf7Y8Pu1wCuLeIcOFQv+WbkLHOJDj6xXrs0ga4y8VhiJUvHOhyWYCyPI0k7S5NzY9sdoUB+fXajH/cN24OfTiPexamHKWqCPWR1gu93RjLzDUJxXVVCgrUT+AfBZRSFjJsXkMtqb4XfMFZFBBrP1HqLttSlw2iBIRTPHZViYw9XyusDC8awKa3A46mtNlLSwdBokeZeok6J6pauKOTrUnf1hoBu058Gz4rFlAS5jqUTbJHQPWcZQ5GVzrOLxBBDapBW8inbgX2jvmWHR56fbeB/T7AO6AvOcCIgSWl2GSQHdENe9Kbw6Qxjag5pMIE/Ig2n/S+U3Ep58ZQhc2GtApWJ2A+IFl+napcqFVRzXG2fQXw+BIiEwkkSnf5xQJpIDdDBHHU6QNPkParky9PoWPBKw+xbr65474On/GiEGgLxNQGrLfFCDwE8KFPMnmZRKZYFva4BV45eD6zxCkR6E0H5osLZT/QJilGtjP7G9rDD+/XarCQhR5vaWArBx+0jzmew4zRx61Q6lunPj6zMjNE7wcjD4gDVLLrH4fpJKDff0W+2ixsOsASn12lLNV8e9LAOTJ212/dvi0z7exJFm4MW4kujESg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(921020)(261026140227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDlOUy9XakpZUW03V2JiK3c3QTJwUWdyRzVNYlJaZmhobnpYeW83dE16cHBl?=
 =?utf-8?B?VHdQclJ1Skh2d205alo2ZnpzNUZnZ3ZoK3V1MzlpY3BzbFowdFhuTy9tc2Q5?=
 =?utf-8?B?ZnZaRUUvd3JIQUU3TFowVGIwRFBCRUVIRFJjVGs2MjNKTmdYSGlCa0piM0Jw?=
 =?utf-8?B?ZUZMVTloUTJqSEx4NXo2ZVlxTlVjRjJZNGJxNm82MUYrUjBDdEQ0YlRYcTc2?=
 =?utf-8?B?ckRUbWRRWDZFTWdibmxhWlpnQkhpRXYyNEFmVkEzaEI5N1p1V1VScFBKVDBo?=
 =?utf-8?B?UWJ1TVNVVmFocjUycHpUd29mTjl6MFdOSFg4SFlxL3Y4ZUNadXZGZHRCYVp1?=
 =?utf-8?B?aFFLNlZyOW5WVG5UK2hodGY3Q055YkdkZEtqekNsTGlmTmwzdnBMSjBLZFUw?=
 =?utf-8?B?YVBXMGxCMHh1ODZpWEkvMENVc3BmaW5XTlVBRDFSTGtlWEVxR0p3L0dNbHFm?=
 =?utf-8?B?RUNrTEpDRmNvMytld3ZPOU1iSURrWGJhMWx0UmNmcWVIdG9JQ3RuakhRQ1VO?=
 =?utf-8?B?b1RUZWdsL1lqYWk3NmRTTXNMdmlsZm9hZkkzS3ppeEw2ZGpZcTlyOWtGNmJ4?=
 =?utf-8?B?cVJiRmtQaEpqRnp5NTF3Mk4vYXdwTUFhMURIMkROdnRZOGtteVJDblVtRjBI?=
 =?utf-8?B?WkhzaTExbGZXY3U5NVU3WWxkTVd1RTZqK2UyRUx3d3Y4dmNnMm1LYVJlVXRC?=
 =?utf-8?B?OEVzZDhjRXF3Y1VMVUt6L1NhMnBISjdJU2NLazhCY3JWajBxUFpHamU3NXlz?=
 =?utf-8?B?VXZ0cGpMc01OMjFKbmdMdGR1dWpnN1VoaGsrejJSNlk2UzVsaUttTitjRWw2?=
 =?utf-8?B?MHg5RWszYmZ6SXlBNzdxWXJ4bmVNclhVWE5ZTitjOTI3ZW1wYzBWUTZsdFJW?=
 =?utf-8?B?S2owMmkzSkhBZHZJcEdGVDZ2cUl2WTNPdXBZWkJsajF5WTVhSFNqenprYlBE?=
 =?utf-8?B?UVFBWFdsQjl0bFg5bUlmMWFtcktxM29TWjNHZ3RLckJMNGVDVXp4dHgwU09z?=
 =?utf-8?B?cWpQUkVRMDFDWTJ4MFhGOFEwWkc5UXpTTTN6TGN3aTZneXVXZ1BLVm9OdjZp?=
 =?utf-8?B?cWRUNkxXdm5jQStveUJieXhzSDU3RFJBbGtuOEZ4U2dSNGI5SlR5WDlKYUhB?=
 =?utf-8?B?NDczbXZRbmM4M0xXUWhqM21qSWdCM0xMUVU1aXUvTTluQXExdWFxK1hFTHhi?=
 =?utf-8?B?dTM3ai9iNVFNNDR0dzRuRHVCVG05RGdTYjVKM2JZUlZPdmV3bG1Uc0xRYzAx?=
 =?utf-8?B?S3pKSnJNd2I1RW16VUlQMjY2TzhRbjlsRW5nOGZ4TDl3cE41NU1KbUc0RnJ3?=
 =?utf-8?B?c0JjelRxek53SFJ0S25jdnVZdElvOWZNNXlvNkxBVFYwMHlSbDBqT3ZNSjYx?=
 =?utf-8?B?M0c5Wko2UzRoSFFHTUh3MnZKR3phSlhzdVFDTzM2K2xjUy9qSjFzaVEwQmpr?=
 =?utf-8?B?cWxDV3lHT3J0TEdJdkFQN2s3SXV1UU93elVjcnZENTVxUFVkU3EzTTdGNFZw?=
 =?utf-8?B?ay9QREVpUGFZeFU5UjJzRk1Wd1lkL1djOS9xMVowWUZVWFNmVFphZmpVM2Q1?=
 =?utf-8?B?b2g4WkxRZE1Oc0NYWG03d3VycWgxNzZLalFudUF5dWVXYnFyeDcyQjFOc1lR?=
 =?utf-8?B?eGxNeFVuVWtlakZaaG1qektJbE1UcC9qMHlNa3d1M3E4ZnNyMUFYVTdPMzd0?=
 =?utf-8?B?MjY3T2haTWo4RGpncFc5REZhaDErYndIbjVXRVBTSHF3R1d1YVJFdDl3bkJ4?=
 =?utf-8?B?aEw4V0E4VC96aXRBUU1zUlBubUJtM2tsc29oa25HSWk4UFBNSkRkSnpCcXJz?=
 =?utf-8?B?T1lQSWNSU3BOOStGZnFNc05INm5mMUlEUWJrVTlqb09KLzdIdCttVjBjbmw2?=
 =?utf-8?B?Ym8rMTRoem94czFseE1yZ2FxSlRiYkU1dWIwQ2ZLSGJGVW5DaDFtazdIcG15?=
 =?utf-8?B?TElZSEE1d3g3TEFqTDdnUFpIUWRCUjRxUXk2UC9ydDFBU25laUM5VzY5SzZp?=
 =?utf-8?B?SHBqR2gxMTVRU1FibnJIbld2MVZZZDZDOXd1UUVlY2UxT0xVN0lPV3oxeGhN?=
 =?utf-8?B?TDByNzk5b2wwNmFSZU5rWjBaTlArK0MvQzZiaE5GaHUrZUdYNW9jenhVcEFO?=
 =?utf-8?B?c2IwejZySHkrRTI2Q2VDOTZXODVMWlhPWVZzVy9wandCSytjdSttUTR1V1VD?=
 =?utf-8?B?YjFVbWJ5MTN2UjFZK1l4ZmVFbnpMdWozUmQvMHV4MWZIMDN6WmlGMUxmc3RS?=
 =?utf-8?B?amd2V3JKc1l4VktZaXMwTFZSVytTQWlreVhoRlVTSjJHL0lsSk9XY1NXUG94?=
 =?utf-8?B?QzNPSnhXYWlwajR6ZUFoQy9ab1IyK2t4RU05N3lOeTk3OTloZCsra1BYRFlU?=
 =?utf-8?Q?L2MxTFkawnAg+qeNxOAJMlykCS+843CI85qLo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50317690-d8c6-4641-895e-08df343b2f24
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:01:30.9280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ro7UwTKAZ3W135MGwmDk4Mx+mEXcKSN6MsycpXJS45tOneOKAoN/SAm7tWWhTaUq2011u7EjuFE+DbxBrOoOfLLbQ2NABgYlOvxAOZfZkljuH4l3bkxZ8MYbcBjTqnUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8445
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Move the IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1 pin from the iomuxc hog
group to the ACM pinctrl state.

The pin is used as the ACM MCLK output and should be configured by its
actual consumer rather than unconditionally claimed by a pinctrl hog.
Prepare for LCDIF support, which uses the same pin.

Acked-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index f21ac208bf00e..159ec4ca1577b 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -349,6 +349,11 @@ sound-wm8960-3 {
 	};
 };
 
+&acm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mclk>;
+};
+
 &adc0 {
 	vref-supply = <&reg_vref_1v8>;
 	status = "okay";
@@ -947,7 +952,6 @@ pinctrl_hog: hoggrp {
 		fsl,pins = <
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD	0x000514a0
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD	0x000014a0
-			IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1		0x0600004c
 			IMX8DXL_SNVS_TAMPER_OUT1_LSIO_GPIO2_IO05_IN	0x0600004c
 		>;
 	};
@@ -1067,6 +1071,12 @@ IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL		0x06000021
 		>;
 	};
 
+	pinctrl_mclk: mclkgrp {
+		fsl,pins = <
+			 IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1	0x0600004c
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8DXL_UART0_RX_ADMA_UART0_RX		0x06000020

-- 
2.43.0

