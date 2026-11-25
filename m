Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D82606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Mt73DI8g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035AC10E333;
	Wed, 25 Nov 2026 21:03:17 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013022.outbound.protection.outlook.com
 [40.107.162.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE8210E25F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 21:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoQPXBg+iquEI1SWsD8cySMb5hfeXORFBcYpgBegUTvNatuee04ueolBjWzxehKSK6O2w0LP7BSwKa2b8xG62MbVZdO8/DRi0ShcB7mwftiiX80XKMiOvgsE2HqXNqcLMD6W32VlJxxAEblsssl2yshETS4Vmi+q0cVMmhcpT5xVChXobjFaBDV8UJi10neBJIUVvVS+dYmo54SJYYZp4v6h4WzEzfhneaDy1AYxtdm/nvFlAWtfDYBWLSbCSzpFw+1JUX0qUISmbhqKtBAzcoZqaFrriyv+5QiD2hnGLTiQueytsaWv5pq92PuMxPsuKWxkfSKV3ACIdrfUVLHYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUM4cU6/7JljieP9oXKejpjFjgqBoDGnvlHmbtoEHz8=;
 b=AE2YWmbEGdw3HhMxI92rC0UilTqtK8DkGFzFx5gPhcRwLfleo4KOPlO98CGjp0yOl78HM9pdF2M5AZKfMwlqnxSjmJ6lSmgSejOAOqQ1w8skOIwqIMznwpINJSsNpm9JrxgCwhhD+v/IPK5+YfFyx0oQPivE89VHMS76vb+2J6rIajaNL2Qs4BEPwymx/aM8Is3Iq5RUYO+ccJ4tRblOnu0jhupegYGn2q7HTJZKqZV0kg7KcxBpGzu67dspbachrDslT4CWvopAVwexmHobYc3oNgjGBzymt4rlvQO0vfZ4oGLtKT5w5r3UKVZXMOIQM5XkC//P9SBsPXqRA6DJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUM4cU6/7JljieP9oXKejpjFjgqBoDGnvlHmbtoEHz8=;
 b=Mt73DI8g3we/vhbTT0nXN/zVkbiP8Z05bh6BdoDwCvK94B1WAGeDKpSt4gV/LhI4YyJWc1Kt0w4nTQwU52f5tdcH7PheXBeQ/D2wCkIDxJ7kYvnr4DzTYrZgccrfYXjvv2YehHzFNkepReu6A0KiyRZ3rMhH9/2iuSl1Ht04BJdkG1ZPYMFtW19LGOPw1mmuXfo+RZe6SpEHyLkrcrdhBESXkXioCuMOjHBgbIl5wVLFx34hBeLQacb5fM28QpLl+MXDhvUxdIZu2KzUjgiRNfR5AcD721pcvTYJxSFMafvRAwrq9Z4pQTco6x8eu+G9MuL9ZgBiPDx/ugGJM+mRxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10959.eurprd04.prod.outlook.com (2603:10a6:10:586::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 21:03:06 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 21:03:05 +0000
From: Frank.Li@oss.nxp.com
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Primoz Fiser <primoz.fiser@norik.com>
Cc: Frank Li <Frank.Li@nxp.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 upstream@lists.phytec.de
Subject: Re: (subset) [PATCH 1/2] dt-bindings: display: panel-simple: Allow
 "data-mapping" for "auo, g104sn02"
Date: Wed, 25 Nov 2026 16:02:57 -0500
Message-ID: <179564055371.3438949.13233761259212217733.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008053850.2941955-1-primoz.fiser@norik.com>
References: <20261008053850.2941955-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: 290fcb3f-23f0-43cf-cdf5-08df4b378059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|921020|56012099006|10067099003|11063799006|261102123227099003|261022075727099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: jy92sXXt6QoW7LXHUe8orxAlbcjytLqkAEZp2cQ9xY4Y9MvPz6Nm00f1bxg6xoERk9FnZTNxa3ZhzOu0dG8ng8ib6KtSvYvnEywfaqulYJhtiUJk+ilDUW6W4r20OEmwUk3jCFnERNEinAk333E12WDhyf/djnog7CiLlBnA0qiYLO9mUGY7faHLngi4DieZpqt0Rw0mQFAKp4A1nNpRMd77Q8JPjCoQ7jAhFTSqqBA3WCUjklonAXsI2G6+CZg58sYDoAhGrqu9BTLcdZnol6liKw/bLwzbpKvc9kvklF3c4aAhTP6fzuWo6I9x83vkuB5S/ShR6OVer2V4ukuLqBqMrI6KoTdxBY05MWlKFe8M6jk+BsywGK+WxNViEruQY2XDFf+gGpjuDtQHpwRAOlklsAeuZXG14Q4TIIVamifJSIJ27u0ty5eBKwDuPzZwagkz2fw+Ir2Vrty1OwXmLvFzAq/xEryEQO0C8b0u350N9YHtv+gOEEgm6wZoLrEih/ydLRyl0+NACILaTqTTiH9lzmIPE/YoY6hm0rO1A1DXTL0kACkICHF8xcDlN+5WJcDaD6iOAUc1pr9m6mLpRbwsMWiMXDgk5EjIeb64yQOPzBoUtm9JUvI0zG/oSMvKJ4dVPZjlr3W1xEw6PswlpLvkGYgf9gw0SaFZSNuRFpog59yCdPaU/yhiuRay41n/LajcjxR8Pz+eLUYTT6Kscw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(921020)(56012099006)(10067099003)(11063799006)(261102123227099003)(261022075727099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGlaTG8xUVV0Zm5GYktTY3JhWUZRSjRicHlmaVpqRUQ3RjZXL2FERjVKS2tm?=
 =?utf-8?B?d0s4VVBQTXBsaWJ6M1BmT1AxWjdMTGM3ODZvc29MejU5TkUrd013cWZ2Slkw?=
 =?utf-8?B?NUdFaWR1Yk5LT0EzbjNWR3ZZRWhhY0JKRXBJbVdvenNKbjRaQlE1M3lOQW5Q?=
 =?utf-8?B?eHF1ZDVBemRHSy9ibzFKUDN4NytWNFowVXdhNitJTlVNalB0RDZrblpzRnoz?=
 =?utf-8?B?U2RSN3IxeWdLOXJENEdSWHlzM2M0amtJakZpa0ZQQ3RLaEpkTVNQMEZYVk1M?=
 =?utf-8?B?Nm5OejlvWnNlejFiTm5VSmI1WnpHZmdPQWdGdWt3azFEcGt0ZVZHYVVSVk5M?=
 =?utf-8?B?MzRBUkkyYVh6T3JmUnFIN25OcUZma3VRS05hZEZsM2tYemlwOFNEaHhGbTRY?=
 =?utf-8?B?bmdYWm5BcGlaTm5CSG1EVkcySk5VVUZlRVExeDFwZ2s1MnhCTmtDQ01oZVAv?=
 =?utf-8?B?b3lmZ2FYc2QwV0p5REhNbXpYc1g3WGt4K01EYVhBZG5BZS9vS1ZoR200ZmNa?=
 =?utf-8?B?L0pOYUpnSzFwdWJNemRzdjRrYm9VK0YvV3piZ2RzcXBDTW0xWU9xRW12b0h5?=
 =?utf-8?B?UitNNG1oSlFzYkVvVGd4ZExWVFVPcjJkNVJsUkpMQUFmb3ZnMEE3c3V6dG9p?=
 =?utf-8?B?SW9zTGFoV0RNT3Qybm5nZ1JLOTlrQ0JLdUdGVUUyY2xoaW1OUXVJelc2YUQ2?=
 =?utf-8?B?cEh6dVA4WGl3dHdoYXRYd1pUa21hbFRSOGV5RXhDMTVmRlZjWHQ0RU9BTnZ1?=
 =?utf-8?B?aFRNUnhrcUhMa0VKTnl1cWQwRHFUaS9DNTdVL3VSejdzR0pZeHRrT0NtbWRv?=
 =?utf-8?B?TXhJOGt3S0xhTHBZY0R6V1hHTnBpRXJhdzFVOUgrUURSNHp6cmtwMkhTOHFS?=
 =?utf-8?B?YVk3R1ZOcFhrT2o4T2U2c1lyb0JCcm1abGtBcTBtQnltODdLNHJudURqUElF?=
 =?utf-8?B?cjFBOXF3WmpUQVZwK1N5cWtKWkZqNDdCNC9NNTlpYThuazNQdGx3WjlOQjdB?=
 =?utf-8?B?VytzMWswT2pzNkM5THZxMjU2OG1VRWFZS0Z6a1U4V05DVFNaNVBQbWR2dWF1?=
 =?utf-8?B?ajRYUnFxdFlDZFo1ZTlpaDM2blRCbFBNSHpMeVh2aWsyMlI1UXAxMVFrQzA2?=
 =?utf-8?B?Wm0rbDhReC9HZ2FZeEZLczNQMTU0dlREYUZzaTJzeUNaaDhYeVNDclQ2eS8y?=
 =?utf-8?B?SVdjdVQ2MFV4eDNxTmtlWFk4UityMkpVQVhqZWErV2pGbER6bGFsYkFlUFkw?=
 =?utf-8?B?T1BKa01DbzNxUkQ5blJYbzl0MnNYT2JPeGRGQ29vMHBaMWdpcjhwNE1uWWxn?=
 =?utf-8?B?VGRxZU0xVXdmZHYxZDVCc29Hd1FEWkpKNld2Qm1tcmxaS0RSWnpNRXpXZWM4?=
 =?utf-8?B?RXR1M3lRK1JWMzY1d3hmY1RiL2c0UlFUV2IyTHhpOUtXVnZTdVFtY2hocjNt?=
 =?utf-8?B?NTNHZS82TmRlSGNFZGFSZ3V6UHBBcEt5YXBQYUhDMTZzWEFzMFhUdG1keUJ3?=
 =?utf-8?B?OEJUbForQklHUURMTGVGZXhhUm5oeEgyOFEzQStSUVptazdqekJaUmhpQ0gy?=
 =?utf-8?B?QXBZNjVQcFlSWXpsSkx0VGJCdEczTy9YYWNtbjJEUTNsTkl3YzZXKzd0cXdT?=
 =?utf-8?B?S05LYUljNHpMVk81RVovNlZrL2FZZU1ueGdtcm0rYkFrYmZuSU5uS29QcGlk?=
 =?utf-8?B?R1VLTks5aFNPTnRXN1lUZUIzcTRNKzBTVnhDdWZZM2xUcG01RTZ0ZkRxQVVz?=
 =?utf-8?B?Yk9IVmJPRWh4QW4xUitLdHM2ek92RUlvVXZ2Z2lISkZ2c0JNRFJHaWZYRVhj?=
 =?utf-8?B?UjJOV0JtM1J0T3NuT3NtS3ZkQXFMb1o1Mkx5bnZBQjlIRjU5K2hxWTNLRXp1?=
 =?utf-8?B?emVvNlFtcGI3aS9tY2ZrODI4VG1FcitEZUJ5R2lVMUt0QmhSaWdlaENYekIz?=
 =?utf-8?B?V1UyU3JYTXNmUmxoNzd5VndSTWtsZ0hrMlYwYURIcGF5NWdZWVhocjFBVGlZ?=
 =?utf-8?B?VWMwOFduRmZubldOM1U3M0V6RGdmRUxUS01qK0tWMnpsaXZCNm5hdVRrUXlP?=
 =?utf-8?B?OE40TTVqSVJ2SWVFZU9HVE9XdE9wc3dSOUVpbW1VaDk3dzllL0lBMWkzOHdq?=
 =?utf-8?B?NnEzRUZnUGs1cmhSVVBOSm9WU0k0bVJaWTlFNWRDV2N5V1FpR2hnVFQvNGFS?=
 =?utf-8?B?RXRBalBacFJzb212bHNOS2I5eG1tYWEyUldUQW1vT3NMcGlTam5HUUx1WWNz?=
 =?utf-8?B?RGdwM2QrY2ZIOUNSdFhVckl0cWxMUUM5eVY1VmRYWVZ0alFrNEhpdzN1MG1Y?=
 =?utf-8?B?RElhcUZsSVpPeWhTeWx5VERWdWlTdCsxaG9pOU9VQmsvUWFGbVU3djZtM1F0?=
 =?utf-8?Q?lkAJ4tESyIlc87JeanikweH7N/CYvsPrJnGyz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290fcb3f-23f0-43cf-cdf5-08df4b378059
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 21:03:05.9316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9L25455Z8z8JD7iTY0cJa/O/nji/xPwQ2k1/ziVSY9LDWTDiHcqjoA1aGfNg5SMGkNlQAP+mrxJXuxGDAAjw/8+Z4X4blij/5azC14kPYlj8oowP0rLNdmJ2Hr/Ihmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10959
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>


On Thu, 08 Oct 2026 07:38:49 +0200, Primoz Fiser wrote:
> As per the AUO G104SN02 datasheet, section 6.4.1 "SEL68", this panel's
> SEL68 pin selects between 6 bits (SEL68 low/NC) and 8 bits (SEL68 high)
> per color over LVDS, i.e. an 18-bit or a 24-bit input format.
>
> Currently, the auo_g104sn02 panel_desc only allows for the 24-bit
> configuration by default. Boards wired for the 18-bit configuration need
> the override introduced by commit 1cd3ea3e4b12 ("drm/panel-simple: allow
> LVDS format override")) to describe that instead.
>
> [...]

Applied, thanks!

[2/2] ARM: dts: imx6qdl-phytec-mira: Switch LVDS panel to 18-bit data mapping
      commit: 296dc22aab13c5e1be1c289a531b3c8b78f0618c

Best regards,
--
Frank Li <Frank.Li@nxp.com>
