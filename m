Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC29606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U/VwTYea
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389AA10E68B;
	Fri, 23 Oct 2026 19:46:00 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C5010E68B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 19:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Me3ngSbLbW1h/AnxAQrKwmbim3CQ9mdZt/gG4mmi24TirSrFtt79NRAvwA5yjQcMJNlt5HVjk+84pEbNLdjYAgwYOij5j6sUKr+jNbY7LpZ/NsFrIwY/wYIhbh4DnSib1+C7Ka0AEM1FIVKuUQeKQ7nO92xTn4JEJ9LRdCzKZ9BTsrzMyAarqVq/C6QlQ/hiaLXypzXU1zNL8Rutd8J9QCrwQi+vrHRKaO+pMb8s7K/j2qfFiR3uhoBu5sj5Qz+QPq/YZn1sfeSViyXAEJvYGrAldGT9rgeQqJw1KJqoPY8EKylWcWUAAeKJY48204K5e5U0oftMrYebBEdtm39yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyzbOWhH6L9bGdi+qbItJiaxl6aO54n+HsMwa+fkgDc=;
 b=jge1q0eMElwn2VIG1O1Rru7H4gR19qxgarsS7teuP2SFMult1iH39L6Scvg+3+1b8upskSGy+QZwAhiBhC5NSPVPMTEqHnTIpkwlKF8v6H1WofHDloXvyam/FUafBrTSP3vXyYv6tuyU++JqBchH/TpjW6Szr5vk66X7dx/VXEmc8ILQegxQLN6XgCVxek6FNjTanQpCYnHHSH5nVOgRy2wD409Xr2rCD0kZanTYZChCwbCshWXcmXHz+32eHrvw7j7sQgzHdoesSq2BsvpaEauCFiRB53nOKw/rzjG/wImEAe/+UzqtPNnBYyd/Ns72PJdx9qvKmPWSR+J+3Ipv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyzbOWhH6L9bGdi+qbItJiaxl6aO54n+HsMwa+fkgDc=;
 b=U/VwTYeaAoaNVCrXn2G+tuJxxg5FXVZso49BpZdW+bHwXLyCXbUY+4pzc94xH+zNRcgjbWp+AJR8has8xrNG6qg4rcdaCQiHEuOqiFwBXoLCg78DjrAGTyuGCzugsrhjd/lk4GLSP6KVV2zscCbPLzF4l9qOYdO2rdrooli2kkNYuvzw9dmH/SPDOEbztSwM2xGh6LUaByiZVNahAeGNtt6CJMna41OYi1Eh18NkH5K3V+hnnJYZ2RNPmsJdOOmkJZcy47lSidwaXR/P3++U+372Apx6NWPgb2xrlyupCg/ZMF3QPvDplwYswSPjHaX8Co2a9ENFaLaDZcO5dyt02g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10597.eurprd04.prod.outlook.com (2603:10a6:10:581::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 19:45:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 19:45:46 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 23 Oct 2026 15:45:14 -0400
Subject: [PATCH v4 6/7] arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM
 pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-dxl_lcdif-v4-6-4ae8395a4b23@nxp.com>
References: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
In-Reply-To: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792784713; l=1575;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=b9hiDDMWEkh2Dso8bmlBoGZhBm/DsZpNoVGQtK+GcTE=;
 b=kSN1kaAdyAbXF35q3lh25tMSKGKeZXu8x0EiF75fx/S7e+YvRpQ83ADFALh1FqVLgPBcb/250
 kKXVn8a6HynAfff/nrOZgvSMPJeJThjCM9rLQjqRjN4xzYjQYMv4lBs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::29) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10597:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b0acc0-79ab-435f-fd7e-08df313e3b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|19092799006|366016|261021121427099003|56012099006|921020|261009223027099003|11063799006|18002099003|22082099003|10067099003|261021123027099003|261022105027099003|3023799007;
X-Microsoft-Antispam-Message-Info: cCwkZ3HvfOBX+pUnaPJNvfL++A+Gc+g7Wj2ceBImhYlyuJtKOuamu0n+iEueU5CsSAicMD5kV6OZ0bqUKI4Jw8UKiOvvSEpLdp/2+AoKwGijH7iyliiEobDkDS7zor1TuE84f47E4Yd+0T61ySo6EWxfxc5oreqRCcUMj/v0Lg8qDZ8QqSODTrFFXnbEvtW+UFfX/Icd0RIRSsyUfc/sOyxNBUM0nhpxOd8KAukVmHj6oRqc2aZQ8ks++gvgSogSGNMejV7yk52S5ib5nQxmzzgYyaqeDb4Jxurzt/dGG5cSHOz1psV5jU/fOw1a9Zv4708X4LCJKNiPqUIPoCkWgpM5I22MRH5y7YYFy2PY6GnJ1pekw90s/k6NMLzFrDOiwZN4p3iwR+Hn/Hy4IL49nseRSFSeOQ91+zgdP/zZPSNlrEVrjAlSdFbr2YDCDK/xovATW3cgxp4SZs5VCxtvSSVIdVd51WWTyo2VA7lQwRBpmiCq6fgpOaQKE0UJ5Mg/B4yY/uc/gSvgs7pxgxuBIidcThhMasTvCmMqQHck14nMxhQT44i8JhYPKgkW4mecgSafgheDcb8lgCSMJq77cLlZZqfGHzjMnJ+u9ASEWRaqDqUActBDwp3dDywWRGyC9f1nR+X6ZZO7PTRYUjepzjdIbq1/1cmVLMM8WGc9XXnaA9gkZYp5c5dDyDEDcUwxHaZ1SiZ37HQq3y7E/E9Jsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(19092799006)(366016)(261021121427099003)(56012099006)(921020)(261009223027099003)(11063799006)(18002099003)(22082099003)(10067099003)(261021123027099003)(261022105027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU41ZnJ3MFAwcU5HcncvZFdKL09IY09PeVdqTFJLYkxQdmd2Vm5qdTRzdlVY?=
 =?utf-8?B?cjViYThMMUJEcVZBMlRDK0llUXNtcWRGWFZJOGFuZXEvdUZGb2UrRmtSRjB5?=
 =?utf-8?B?by9MTXNUbkVUdkxWMU1DNFhvUzBRQ2Q3M21XVWNXdXFvZzVXeUZGQms1OS9m?=
 =?utf-8?B?KzFDazVUUXB4ZlRnK2lmUTArcGkyem42eklxSUpEN0M4b0RBT2VpWStUSVdM?=
 =?utf-8?B?VGNhenl0WFdMbEdYVU1oTDlkS1hhRUVWSG9qeHVVaW5BVFA4WG1rTnFnTnpG?=
 =?utf-8?B?bVRqWU9VQmVSRzNFMTVSR3pFbkZ0SmJtZ1JaY0p4Y1NHWXErL1dmcWRReXJi?=
 =?utf-8?B?MjMzTDRCQzlyNG1MMWlGQSt6eGthSnlJUEhkS2RObWdYNXFDRExsZGx0ZGdX?=
 =?utf-8?B?cEhmTHNPRXFaTkhMc3R0aytCa04rdnZES1NXeGZmdkhNV3o2QXVtVjc0d3Jv?=
 =?utf-8?B?a1Urbm03MHRuVmVnbFBRaHRlN1BIVGRNS3lhY2szZ3gzNGkwK3UyUFVRcFgw?=
 =?utf-8?B?SlAyVU44d0RRMkxhV1NLM2NaMUV6T1BtcDVGOGpwZ3VrVGtONStqZytTVFZw?=
 =?utf-8?B?YnJKMVRoOVBBbERiZkU0LzIwaSswSEFZeTRRZFJNUWlQMVY1c2RjNGNnbVIv?=
 =?utf-8?B?Vmk3YnJ4NHBMRXZ0cCtjaHZTd2xtdFpETWZaVHd0Kzg4ZlNwRzN1WUdueHdT?=
 =?utf-8?B?VXROdjg4QkIzR01GdU5LSWgyWlh0a1dnSHpSc0M1UnRQZXZhWjhiK2pneTk5?=
 =?utf-8?B?TDZiT0svemhOK2pYb1l6MWI4QWFUbFpQWG10aTRjTy9yNmZaNC9ZL1p0bnlE?=
 =?utf-8?B?UlA2NVpJeGYvcDlYaG1MTHRzSTRQYkZPdUxLQk1OQlAwdFVWckx5U2dYcEo2?=
 =?utf-8?B?OG44WGQ1YjM5SFVKcjREY3hBN1hBL09jT3VyeVphZjZoU2FEcy83Y1AvcVJ5?=
 =?utf-8?B?bVJiajlORnE3TVRLQTFNYWpaWnVmUE1TVTBhVjRsNVR1ZDFUaC9lajlNWnhp?=
 =?utf-8?B?eWZUbVZxZ2hrYkhJallFV3JXbHJTNWEzWm54RHA0YkFkTlFvblY5WnlaMG8x?=
 =?utf-8?B?aTlQcE9QKzh4ZDEzMnF0dFRONTZpb3gxajBMYmZaQ00wRGJ2UkhuTVZIR0RC?=
 =?utf-8?B?NDVKbnB3WGxHckI5d2tBYTNpVlB3ZzJuWDhUN05HTmN6YndsbUgrVDdKWEk0?=
 =?utf-8?B?cWdyTmhOMWFSWExGWDJucGNxVGZNdmlxaU5nWGEvb1RmWkViZFdjdHUyS2dF?=
 =?utf-8?B?Mmp5SHRmREh3ZGhsbjFUaGNhWUNnMXJCOEpwc2pKeFo0NVVWcXBqR1o2VXZD?=
 =?utf-8?B?bnpsT3lLbmhKVnNjcXRDVDZ4ZU5hMmUxQzVuTy9hRlp6RG5TWWM4ZWc2ZVB2?=
 =?utf-8?B?VDhWekRSZXErU1dKKytMcWt0bkgwbDJpQjE3RExYemI0Z045UExOdzRkUlNC?=
 =?utf-8?B?R0YwcEJsK1ZiM3dDL2xJdTRaaVJRdjlrZUlCL3FvUzJEY1hyd0Ura0RWNVBP?=
 =?utf-8?B?b2c3MXVsL21oRThnWGR4clRoWDIvc0hDUmJMRytzQWJTYUVMYjZrS0c0VjVO?=
 =?utf-8?B?WGVRMWxsWi95VDdCRElnMkZMbVFWTmxmSUZoNkYrQmYwdGdLNXdCeGZPVmg2?=
 =?utf-8?B?aVdXTFBCVzM3aGI2UFZLYW9rRDcwb2ZaWkwrT1RycG1DWUJYbWVSeVpRVkg1?=
 =?utf-8?B?eUR0WjZYd21rVDQrZVVTMUgzRGxFTnNQaWw5VEk0OXQyTU1RYjR2TnRoalZh?=
 =?utf-8?B?Z25FODJZYWYwbnIxdzZ5QUVQdVhQL2hVemdrUC9lcmtjcDQrTnRCMEdQT3N3?=
 =?utf-8?B?QUVRaEp5aXlNZnJQQklJR1o5ZUx3bTJ6bmsyckw0RGNiWnVTQlBsMlhZaW1Q?=
 =?utf-8?B?Y0p3MEZTNTg4aUJhWVFUQVorR3N6ejBrZG1ENmxZSi9NYThBTHJNNm11a0hi?=
 =?utf-8?B?Nk1HQy9nNGlBVEtrajd1amxub2grc0V0YlRPY2IxTS9XM3lIOGpGbnRxZWVT?=
 =?utf-8?B?Y005bmxIK1NkTWdWclBHSi9kQ1hHaTFkYjkwYkU5QjZQSElOSVY4QkJXUjc1?=
 =?utf-8?B?cUlvSCtsMGY5eVYxTXdFOEZoM2oya0NlTWhVOW9Fbi9pK2cxbjNmRlNiMXVh?=
 =?utf-8?B?RkU1eTU4djI5M3B1YzJJZExmSGJQWXA5dTB1M0lmM0lrM21qZ3F4eTZpR0dP?=
 =?utf-8?B?UytjMzJwRmFDT1hjOE0xVmFBT2NRbFAxQ2dlK0RvT2VkVFl0ZHY5NW96Mnly?=
 =?utf-8?B?Y25obXJhcFAzVS8yTWlyaDl4NVVDdmtwdUZsa1FqdVp1b3g2UTMwaTlhVlhy?=
 =?utf-8?B?TnlCL3JSeEhhSW8xNi9UM2t6eEpjMSt5Y0JGVko0bVcxc2lnbzNiS3haUy9O?=
 =?utf-8?Q?s1hucwSiq6vtHd2yFYucsLGeK5iJjo5RWeZOI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b0acc0-79ab-435f-fd7e-08df313e3b9a
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 19:45:46.8759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70ugp2MthTwHHvc8kD9Dp+JwR9D3WFsE75cUmuT3qoZHBQdhpymn8IGYr7kdSvNJ7Xnvggi18DC1ar15QU9Dzm3MGo4h7u8o6T76aiCTPF5K+DekvUjPV/RW0fM40QzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10597
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

