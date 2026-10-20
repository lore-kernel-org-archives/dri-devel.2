Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE06606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=caSQ4JaV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E0D10E290;
	Tue, 20 Oct 2026 20:13:20 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013037.outbound.protection.outlook.com
 [52.101.83.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966B010E1F6
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ1bzW3qvxTlTbcGhRu1RVxPgoKAYKXtybFeghdQu+zeqbNzrY+BG356y9E5yOrxs+nGXcsPO8F4ftSxqvdfwpZfUii7Cd5+Xaytmro0PPE4MCPKHhHWjM1qwdC8z3VYkewCrEl1Mm4fzqjgBaAWhAI3BCJOJ3T5BGxKiCdkvv9THEUVxqIyW77yIPmuxdU6CC16DEM73s2qEjJ7+mqg1IC4Vs0gHUNrntSLf6Iyorw9d7OY2jvLYhHL0EioFKJAbS3rPvgNoxN5RbyAZfzzpxWIHHzHdppW8dvC/WjFpQKh4lrfm+DRCIiyfZjUKtao64lXAdi57G/lQuF839ySpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATMrQXFT7oqIbKXJTlyZ8a0stZYMJpZo3BjGZ2up0XE=;
 b=ACHiYwJ/zJQKbLVvIHVNN2x6noG29RzQxZQuSfsY/UgD8u0gx45ih+ft9rfQ58TS6JG6h0wi19NetR85LRQB3aIwNBX/rUNsYaeVGKxwXh7J44GZkBhbyWXkm0YuZGBBDS/Zsqh4NFmFsGNZ/KP/5Da5PcjJ0cP/CRXQqmIWvRwuwB9NeB6T/Vg7juop6puoikiTJ2gcYVEnpKSIZL8eEu4v9VcFk74myNVSljPjUKrfEXmNsopqIbObjuzRuJ1svh/nfJ6hXw018mt3q1oiZRhUFz5ygZnqQAwiRyJKFGFFoxq90yX7LTGCvvyrt1gw92UQlE+Rm7H9Oekh8udf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATMrQXFT7oqIbKXJTlyZ8a0stZYMJpZo3BjGZ2up0XE=;
 b=caSQ4JaVuIjJOLdQhY/d48L9oYb4yG0HjO/MAxFIHtSzQu5wMZRBoK5NvL3ANfPSTdkXf5UDVKVMCZBd2rfp0STLLGF/VIbcKIheRKx0pVJcZ+BfQxSar/WlGYmPw/vLtlVDf2OnvSKUU+zaT18v3q9I8R2iLzmMXycF3IxVSgKqCsanFKvJS8LJBgeapkWd32Oy1HLDiO/XTRJ4Y1MFQiFv0/f4eIrOmQ9GnlKrGrOGjLovtBd30UOQmTZ7McP+Z5727NMUIPgBezmibzULGO/Xlx4UkhxTQs5kLKlfaloNwSCz+cz9c6U/iAEHUKHBPDunLY2QR9jYdcg0gRx92Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by PR3PR04MB7323.eurprd04.prod.outlook.com
 (2603:10a6:102:88::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 20:13:09 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 20:13:09 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v3 0/7] display: lcdif: imx: add display support for
 imx8dxl and imx8qxp
Date: Tue, 20 Oct 2026 16:12:50 -0400
Message-Id: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEPL12oC/02N3w6CIBxGX8VxHQ0wf0RXvUdrjX8mzdSBMZvz3
 QNry8uzfed8MwrWOxvQqZiRt9EF13cJyl2BdCO7u8XOJEaMMCCcCGym9tZq42psQCujpBasVij
 tB29rN62ty/XL4aUeVo85kBeNC2Pv3+tZpHn369LDphspJhg4UHmUUAmmzt007HX/RLka2dart
 h5LnpFc8AoYlGD/3rIsH7OfygjqAAAA
X-Change-ID: 20260709-dxl_lcdif-d6cbdbac92fb
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527183; l=2245;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ublPUsEO8Woz+3cSzWD1Ktjy9oBsQkoXzNW6aEzsv+4=;
 b=X+30/OJhkIDPbZmHeUt794fWsyLB3VxkYHiVXxYCAwhUfpQKl4QRjk0075/uCbQeagseXzcEA
 Pu6v6bP5KPBBphteS5LvmVLUzIhQ/VgaIcGyDl4ywXB/ssUG6OljEV9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7841cc-fabe-4307-c439-08df2ee68ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|7416014|1800799024|261009223027099003|10067099003|56012099006|3023799007|18002099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info: NGklbdTuSUaXT5+cnkUJZLx661PJ73PCt7JZzUokhNymApfi7RRNMWQ4KIO54HlTcMJUvD/hzVWGlOxjDmFwMqc49ELQEfGRSQ31I1SDEoG9IQRcptiTsayQaD5HkX8Xb0wWMTy+Midq+cdsAHcDCN2AJ5mCSFltSFvITf7GSWitmM/pcA6G+m8ohZqS0O9XQonD3DNQ92uaCMTmJpL4DKlSMk8ko/vavsJEAj2n4G2rKWpoXJ4fEczC1pZ7EisfRhdz5R1oc9QyBZPT5UqEuXhdKUcibkMx0kpaMawnbRavYmCrvKAQrx7zXpOUDt2FjEX4abA066rZBv1oTZQDDbzKD7flZQbxy8IZ204xJeZrbAme4ikofOKbs4AA3+07YydEeeeqR7M7Sl8JpK9by9ZbZzrFi2bh5UrIEVAxCuolQV9cKzy7VJpajzJ3UVA2EjeOkgm97XuXzam9ip8rcYRu3syGe7JEekJIRkBIBAfXNwwF99bjK3mQvaWmG4kiiYoGeuugSxQeOQCtnTiJ+ZA2rfJ4Yvaeo6bYIOxJl/rGsGurpQGMyAPwlosZqghb5RbrmmL90KZbsxD3B8yk8T2OgR/Nom005p3i6TYIrFw+aD+HK9t+bdCRE2QTcmB5yptW+MRUJuKTAfS3euWFKEGapTb6R8ASgVxDkahn6ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12445.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(7416014)(1800799024)(261009223027099003)(10067099003)(56012099006)(3023799007)(18002099003)(921020)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTVDeWRZenAvaE1UTzlHR2hGd2RHbFRJWnN0cU9zbjQzRFJRNHJ3eUo4VmhU?=
 =?utf-8?B?MjdlVjZjY2Yzamg4SW1WZGxlSlcxdnF1ZS9vKzFRYzV6cndwcWVDR0xHWDk1?=
 =?utf-8?B?SWJVa2kxQmx1SnA1ZGxvNXZsRzBwdC8xYVdSdlhkV2YwR0hBamxMM3FySWp1?=
 =?utf-8?B?NEMwSGRUK0xCdGxWV3hnYUhFajNVVVBRaEZRZUI1V0VRY00yU2tBR0xOZVVS?=
 =?utf-8?B?SzJTbGVGRUtSdXk5MnVyZHk3RFVvWEdNTWJ1SUF5OE1uMEdCZGFIanJtN1lS?=
 =?utf-8?B?YmRraU1TV2RxTjlCajdMdFB2aUEyZkZEd0J3UXJSRGNIMzNWaW5XdDIvSm5F?=
 =?utf-8?B?cThjMWtSbGdqRW9CZFhNRmNpL2JTOGxBMVdqRGhJWlNIdTY5eW9nd0tWTXU5?=
 =?utf-8?B?b0JVa21WaXZOb0JuL2hScmpZWUhacXVYR3JrSEoxRjlCN21JQUMxYTdQejRN?=
 =?utf-8?B?cUEwNEhuUVpEOGx3RDN1VUFnbU9JaTl0bHQwLzdGOVZYaE1jaG5lOC8wNGpm?=
 =?utf-8?B?aTlLVjdiN1RDTkpIMm5Ddm1kZzgwMTROVTlEQUFoc3JEUmlpTnB6aFhBaDY2?=
 =?utf-8?B?ejJFOXl2Um4xWjBXOFo2ZWZkQ2RlU0ZkMjV5cWFSeU9xK2N1V0dUbXFaMFJh?=
 =?utf-8?B?eUIwSVhPQzFtSloydFhBcFIrdjRXcGtZdFpEZGMyc044VHkvMmVpS3RCMGVj?=
 =?utf-8?B?d3pvczlxcGpDcG4vMFdtcU9KUXVNNFFFTFdVcVFyVTR0aWllMlJrT2F4SEZB?=
 =?utf-8?B?SWJTSlJJazM1b2tpVEZEWWNaS1dLOVJwVHIwaEE2TnYwTE94cTdGcGYzNzYv?=
 =?utf-8?B?WTAyakc4UEZ3TjBPYVpiNHJ2RGRCLzVHUS9sejVMci9GYnRHZmQvSCtHcFhC?=
 =?utf-8?B?M01KM1NHWHRUbDhLbnd6WDNac3hQT1lUUXY1dWlUSVYvbTViNVhybWI5ek5o?=
 =?utf-8?B?Q3hoaDF2d3p1SkI5c3d2TmY3YVV4eDVKVDEwek5idC9IRjNCN0JpV3czdVFk?=
 =?utf-8?B?Y2Y3eXhONENqcUdlSDUxZlBVb2V3TDNJaE1hOFpweWxlRU1FNXM3VC9iT2NQ?=
 =?utf-8?B?ME9IWGF1SFJlYTJxeW1rcjFvYkxPcHNUbVNHRklxaTdTS0s0QmpLbmhLQ0kw?=
 =?utf-8?B?Q0dvWGlOTlJVbHVodDVPaXN5N1l6QWdkS1RhdG81elBFUEpJUGg0WHFBanJi?=
 =?utf-8?B?a3dxMmVBamtqeFlwSU85TUFQSTVQbVVQMUR6UUlob041MGhpZTljbU1YNTBx?=
 =?utf-8?B?YXdPalpRRnRKMFIvcUpyREF3eU5iT1hqR3NzQUhtMmFpckFTMUtKZEp5RWN2?=
 =?utf-8?B?eS9JTlZhQmdkY2tWWFVCK0dDdDVERkkrdXowb1VhTmhPb3haSG1rZEdDSzV6?=
 =?utf-8?B?eUZlakwxb3lseEhIenlhQlFua2ZBem9GN1VmRzAxY2xKNDdWbmQ5ZzMwUWNs?=
 =?utf-8?B?TUhEMExGQTBqZGMrY3RLQzdDSys3QkdsN2N4WXZKWkNZd2JwQlBOSWV0VnNY?=
 =?utf-8?B?ZVp3b0FZRGIyeVVTVFgwUDJiSXVNZ1hKUU9jVkVBa3RMUWZFblFyUWZVcmcv?=
 =?utf-8?B?WE5xeVpHN0F3YXVSU3B1U0d6Y1FCU2VBUFdVaUhWcWZrMituUmJrOHJHNkZm?=
 =?utf-8?B?ekxEeU1xWk5sWFVWSUVEVVlid0lSVUdYd1NSK1lvNmRraDFwQ0xGS3o4Wms0?=
 =?utf-8?B?SmxZQU9tYTZxeXBVZWlDSm82WmxlTXg3Z1N5cUVMWHNOSnNPYXhZLytHUkJF?=
 =?utf-8?B?dTY5bHdwemlNQWxzODZCa0RKTU9JTFdXL1Q5Q1JvbEZRZEdpKzRFQkVQdXMw?=
 =?utf-8?B?U2lQUXJETThXRzhsZUxSQVpzejZqNFd2N1p4UTZjTVE1cUhPbTJ0K0NvcTdE?=
 =?utf-8?B?MXd6VERrc21SZUk2bnhKZ1lDR09yYnFjNzFzMDkyL09uODVldmxNNFR2bVE4?=
 =?utf-8?B?ZVlMWjhsa0VJS3ppY2NNdzZkS2l6eDY5eU43MjRkSFcwRTBET3llYkp5QURB?=
 =?utf-8?B?L3V0eWpnclJ4dGZDY0RkOVdmSUlBbSswV010K2pHVUpLb0EvNmhJZG5GMjdJ?=
 =?utf-8?B?VFNHczVSeEFpZjM4Q3poNkNpcWtFSHpnU01KbE9GVlBIYzkzRkpqbWlubVpu?=
 =?utf-8?B?R25EUTNQVFFmQTY1WXdXNDR3NVlYKytuRzRaVDZrVW9wMUcyS3JCaUFtRksw?=
 =?utf-8?B?UWtkTW4ySGRlbGxzRTkvWWh0RFRYNUl4VStDcVBJVlFqTEZPb3oya2JnQnhE?=
 =?utf-8?B?Y3BBclh3bi9UaWpKOEhoMk9XTHZlV2ZLVjBoOFFZb1RoODRwbFFFMEE1M0R1?=
 =?utf-8?B?NDdCdHRYR29pcmxNVnhjK0MzN3QrT2RDemZXUzRCclAzQ0FBVXkzTjQxRGFm?=
 =?utf-8?Q?P5pKFitHRIOlMCJn+jTCJrwRbl9+ZGnK9jYCE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7841cc-fabe-4307-c439-08df2ee68ed1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:13:09.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13HLBvj2LyUxypuQCj77pvOIbzJe7fzYiljVjgWxs1umof/xrvBHrnlRlfNN9K1MQaeupxhmRx3H4aX7/5wSfVCcndy2HmdSwMs5fpAvhF/du8s6RcWBOKPNaUcR6iWB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
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

i.MX8DXL and i.MX8QX support LCDIF, which is compatible with i.MX6SX.

- Update lcdif binding doc to support front compatible string:
fsl,imxqxp-lcdif and fsl,imx8dxl-lcdif
- Update simple pannel binding doc and driver to support waiken,101wx001
- update chip dts to support lcdif ip
- add overlay file to enable lcd panel waiken,101wx001 and lcdif
- use onboard pinmux "pinctrl-multiplexer" for on board signal switch

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- add bus-width = <18>
- add lcd panel information at dtb file.
- detail see each patch's change log
- Link to v2: https://patch.msgid.link/20260715-dxl_lcdif-v2-0-da797562636e@nxp.com

Changes in v2 (fix sashiko reported problem):
- add power domain required for binding
- fix 136 height
- add acm patch to cleam MCL clock output pin
- remove iomux hog in overlay file
- Link to v1: https://patch.msgid.link/20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com

---
Frank Li (7):
      dt-bindings: lcdif: add compatible string for i.MX8QXP and i.MX8DXL
      dt-bindings: display: simple: Add waiken,101wx001-wct
      drm/panel: simple: Add Waiken WKS101WX001-WCT panel support
      arm64: dts: imx8-ss-dma: Add lcdif support for i.MX8QXP and i.MX8DXL
      arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller
      arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM pinctrl
      arm64: dts: imx8dxl-evk: add lcdif overlay

 .../devicetree/bindings/display/fsl,lcdif.yaml     |   6 ++
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |  29 +++++
 .../dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso  | 119 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |  88 ++++++++++++---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  11 ++
 drivers/gpu/drm/panel/panel-simple.c               |  31 ++++++
 9 files changed, 279 insertions(+), 12 deletions(-)
---
base-commit: c27e4587a73de339f2d9f1304c913413055ed408
change-id: 20260709-dxl_lcdif-d6cbdbac92fb

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

