Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F588E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8980D10F42B;
	Fri,  3 Apr 2026 08:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="S/hQW55+";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F5B10ECAB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMFgQUx5OG06VGAWhLLacsdDlzpMeguRg6vFUhUBYIKM56DrTzR1jCAnxV65NTKbKQsCXT8z8nCgWkYSBE6D8ATJ6qxCusX7d0wehAlaV58ygVCXNf3Gq9/zp1KInvfZ7coh4jnzqGDF0dzooQdIosvZsudfD97JqJnXwmw0BUD3SoSYdc5QiAjrvVr7O1IGqPI6rpZPEUVBHV9aeF4EEqxCr/vh9Guw7IiCKhnzYlFTbb5hnhnnrxxAYY6/J6+SBEavkbsB4Rtg4qFfSHb5VpIFi9xddqUXdjyPXex7e5SZh0R6kUPVG4OQp1N6YtCito+suRcFsscbJZJCb8uSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDe8a93AqU6keuRUCaW4pXUCoE94i833MpDA9YCuKHM=;
 b=CabEyS2c1aEarUEiBTiJLDhUmidCY6fFnpbowOXV2VR/OwAyOh4Dbc+m0jgtoJx6g5Ap2t1cBfznHbt4V4imMrF1BVcSTCl7dVIzjQuDizMA3A720b3KkXlwhAli9mhWljeH0doQNJX62iHooTA5zAQcpC9/t6t6z/UFDnBVNkpXQRVmzP67RKEy5XOZNaH/cKShrKXwNojUJnBUi8ucpTVXXqOp1T0dO/unTV5rGl+YFN2xi3Ttq+bTP7ilP/6QmbGR5lvIOsidRvHE9TXT6RuQNo5b8NcdCW4l2l9+24TDYHNGvh7OVZODWKc0xQ/n43MUt1OvokyLHJ1ByoNyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDe8a93AqU6keuRUCaW4pXUCoE94i833MpDA9YCuKHM=;
 b=S/hQW55+AVM7QYQxf2tQrLOBnaGcrUt22MxRzlN2cxVg6HRZlP8aV8jwJ7zNH+lhFmzXHEMFkRgAYL8azXE1m/ytjY5tSkKNeeyDVG7H/FFJfRMcEXINdph4i7DrvW0Ug/NgCl0uvZ8dA2AyuT/vUeRDwj8ZZzz7XTgolSld2tIqZY3aQcoiKzIgYOApmlNtYGmvNEiw7ZRu8FvrhttjQXvf2cgAB51b8Mw7mE7MsYT2lBob2syGq0uwz+ChUdqNAYvNukDBaPemoA42Spi3FTGJYCfcFDCdslhBIuLRHmg+TxZxn1Eei1euGUZe4lT47wVi21mKZkdnz6N2CYpiCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by VI2PR04MB10667.eurprd04.prod.outlook.com (2603:10a6:800:278::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 10:10:33 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 10:10:33 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Subject: [PATCH v2 0/2] Enable Mali G310 GPU support on i.MX952 board
Date: Wed, 01 Apr 2026 18:19:11 +0800
Message-Id: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/xzGkC/2WNyw7CIBQFf6W5azE8lDau/A/TRUsvFpNCA0hqG
 v5dqEuXk8yZs0NAbzDArdnBYzLBOFuAnxpQ82CfSMxUGDjlkgrByDKEiJ60qFqtqUY2cijy6lG
 b7Qg9+h+H9/hCFeu6GrMJ0fnP8ZRY9f6iiRFK5FV1KFg3XSS/2209K7dAn3P+ApSyIBSsAAAA
X-Change-ID: 20260331-master-7ec7ff0fe1b2
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Guangliu Ding <guangliu.ding@nxp.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775038767; l=844;
 i=guangliu.ding@nxp.com; s=20260331; h=from:subject:message-id;
 bh=M9tnXSkJiHVQhvwYG9BiPtJnIIyqGFzuNVaT/vCAdxU=;
 b=KT5zZnNIEvbTAuaFZCyYbEvRFaDNzSzEq1QbmTPvXXMzR+CaF99I69i2fKbn6500SZ0w1dsSs
 I28pCpNn60QDAqJJt3cZT49twPwXp5r/FWlgnhysGerL40bKO0WDFQv
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Ozo8o/sk09NyO6URvn0eD0v0uVHduT/yJzVGTAJ9gxw=
X-ClientProxiedBy: MA5PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::16) To AM0PR04MB4707.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4707:EE_|VI2PR04MB10667:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a71203-7020-4592-76cf-08de8fd6e91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|7416014|366016|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: zDccNFqYKVLZCyKfNOIXlYN0+h0p5KhgYUf8LimxW/9YdPdhVW+fm7ydnAmvsZ8nWv7pv+ReiE2Tfj8XdtOCVlfgbJGhVYdvewsVsiOVLFxezRFEAXmv95mfupJQ9mkMZT5Xy5FF+ok+kDk773JYqrW58loX8quA4cuwsoHw6I61Q8GEjF8H+UFvvsAPTfCBlrfhqRnvdtlDUkIjfplm5fWbsp9W/oi7e5PxoNLwEyd4eUFke7pEmfTP5mN6d7V0NH0QlBJpGE7XWUzia+mlFBnFy15rN9/9P6lGJXZHxptMPTcHYsVdp3N2wCcb0eQp8o4S5L5b7sVD4WA8mhFH/ydJyimYuBmjYDVXTIqt5PXKn0usjWg4OS6dZbnMeEiaP0kb/EfhRVLXCrvHNwaN18yyUcxBsmcaVjg0fp+Qe8M3f9SAUiP+unVgeVzxYii7dJayKR2qzgQH6UJ/2LYiDd7kBXcNiT3gSpGmKWW82dxnUKnDXx7MC5hwFV3by0rc8fQ5lwA3vOtPCkeWRzNc487hdmLiplwmoD7gfmtDMd3fYuLGCB/owqdYx7WFbeDnkE29yrOGKyTqYsMX/TyMVBaQ6BTns9ZVqKyrPmfaUhqlXlsU+AjDv8FvyOfMsqNJkb0rBSH19oKDYQFu1PaqCjQ1dlV9qZr/T99tenJCNhURb2U0GN1DAUIlych9+dD3OYNCA2IDtyc4eiQl7RAaMhJo61wXDQ3yEBb+aH6LeB9lTNxkMGisrRk19mp1DXEdFt5GCKopChWwagqP2+4fhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(7416014)(366016)(56012099003)(18002099003)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUh1eG9TU3F0ZkJqenp2dWtPOFN5OUhFVmtNVncwdHgyTmpUYzdzNkNWRjR6?=
 =?utf-8?B?N3A4SE9KM3k0aVNLTnNtYUNBSWM4alhLeGdJVVEwUWxMWGUzcnFPZ3NZWGVC?=
 =?utf-8?B?L3lCN0dvZHRiVVJhTXZrRnJLWG85Y29MQ0RRYVk5dWJTemRpdHN1Q1ROK3Yv?=
 =?utf-8?B?RlltWm9sWXdpZGpXQmxpS0Y1R1d3LzRtZ0JzMDUvekhmV3oyTlV2bVF4Tmhw?=
 =?utf-8?B?SGhQUnNGd2VjdDhRS0oyYW51SWRvSmVMNWhaMVN1SVZlMy94RGVmYldVNXFN?=
 =?utf-8?B?cVZyNmZYSFU0YitaK1IvUlZHcTJaNGFtKy80dWR4Yk15N0J3VHdQZXV2K2Rh?=
 =?utf-8?B?VHc2NU11MXpDT2tLOVJiUFlJVXlVQ1JVVGVLUW5sN3FueCtkYnBXS1VQKzdw?=
 =?utf-8?B?NFljUU9xWENhYWVqakZLV3p2ejFKZHRJeEU1ZnB3dWVlRkkreFRDNDIyODQz?=
 =?utf-8?B?TVpiWXRFdTZEYTV1RHpHQ01LK1ptYlYzTjEwaCt0VVNacllqYzFvbm5IWTFw?=
 =?utf-8?B?aFFFV3dmVG5VRVhRSDFNVUlxMFowQ2IxUlFIbi9lTXZ3Z29pdG1YdFQ5L0lq?=
 =?utf-8?B?aENPQWtFQ2NPdVg4cTlGOFBvNllPY2hFWjJ5RFc1UldRK25lQVE0OHV6ZFRG?=
 =?utf-8?B?NXhjYlFvVFdtRytuL0ZCZEN0eDJGTWtnMEhtMVB0UUdyUGVZWThUWU5UV1Ar?=
 =?utf-8?B?ZWpsVzNtV0dobkVJdVFWdnBWemZhbHR6ZW5JQ2llYm03TnhqaXBsMGh2cDdr?=
 =?utf-8?B?bnFWY3M4aVRGMTRnYUkvUjV5MFZ2UmZROCs0NUVkLytva2pnSERGTkFmdXFI?=
 =?utf-8?B?TWVlSTk5eFVKUXdSOGZnYWxuRGV2MEVSK0NGMnRsN0Z2ZnRQTXVQenA3MENR?=
 =?utf-8?B?cWMyMEVtRHU4MFNjWjR5NTF5TThBS2ZFTWhnNnpkaE1SbUpDTzN0YWc4NCtn?=
 =?utf-8?B?UDgxNVdMQVYwVTFyS2xCdGtuNVBEU3QveDk0dnluNTN4dFY5VHA4Qm9mdUty?=
 =?utf-8?B?QWJGMVVVclNGdG1GOWo0VWtDUWtUMUw3enVLZkJJN2V6MHJLOVQ5d2VuWkJK?=
 =?utf-8?B?d1MyQWZ0RW1IUFdTc1NmMU5qSUgwV3pzcUhocDZTL25xMDFPSmVaZUhhVW1t?=
 =?utf-8?B?dkNJZXV3Mlh3cnJ5cURYQjBTMnI2czhNaElqWHdnbXJ1dlR6TU1UYWJ4NVow?=
 =?utf-8?B?ZklyYjZYYzBTcHZCTGh6NkZVUnF4TS9NbGp5SHFIKzFXeUcwMmFidmx5c05G?=
 =?utf-8?B?cFk0cldqVnE0SHNxWmlYalh3eEtybGQyMG5CNktMUGMvbGZObnJLZ3kxZldY?=
 =?utf-8?B?cC83WHgyenJ4bktnL1RWdUtleWZKM29xQUV1b2FaaHRhSnJDdzJWZ0VpQklO?=
 =?utf-8?B?eDhReWpBZHkrLzhnRWNlaEg0MVVuejkyS3MzOVE0WlZXdkw2S3E4VkRUQ3lX?=
 =?utf-8?B?QU9IZHp1d0lUUFMrYk5ZV1ZqTWx6azlxLzJNSitSTHNDK2wzTnUwM2w1NE90?=
 =?utf-8?B?NkVpUkw3TjVRWVRTQktMdkI4UG1Pbi9BdzZmRTlyREFCcHpLRDh3VmoyekZx?=
 =?utf-8?B?R1daWGdLUnFzT0JYYlJNWDZnbmVtWS9lclhEOWx0U2lhbVhDNHJTUlIwaXNF?=
 =?utf-8?B?MWlKTVBoNmYyay9tem93Z0JjcDBhQU5EYkU4bzhMeWdSUjYybTVtZUZIeDV4?=
 =?utf-8?B?c3FtdUlSeEIxZHh6bUEyMEIybEhDWENIbmZOcnc2SE9oSXpoby9hd3ZiTjFr?=
 =?utf-8?B?Nk5zbXdvdFdCTXcrL2s0Q1ZRL2hiR2JINHdZcllRcmY4RGd1M3ZObW9XTnFI?=
 =?utf-8?B?cjlacFh1d0praklud0ltbmk2NHBKNG8yUlNPcEd1TGR6R1NmRk5vNlhRUExo?=
 =?utf-8?B?ellsVGZEWGdqa3VMNElXaDcwaHE1aFhmSFVzQ2p5MzdJTHNzWFhnRUhmbVAr?=
 =?utf-8?B?aUw2bWE0OUdMNWFwcDArVW5OYWU4ZVdTWXMyTHFlY0RJSGd0S0prMjBvYzFC?=
 =?utf-8?B?cjBoMDdGbVZRZnVnbDJnY0h6RnpjMU44Z3V2MWhrQWdQZ2dBQ1BmUkoxN21R?=
 =?utf-8?B?dGZPTHNPem5ISHdHMW9xVkdRR1JsR2NzL0JwZ0pVbktuUENySGNGNGlxeFN4?=
 =?utf-8?B?eE10c3ZvRzlJWXFRV1JjQy9FNmV4c0hINVh0NE5mWjlZSnlPMGh2aHZSUDlN?=
 =?utf-8?B?dEdiVmV3c1MyRnZtcnRVWW80Y3B1NUMzTTB6Y2tDbXpYUm04ZG40dzZ0M1F3?=
 =?utf-8?B?bFZrQkhiRzhBMmhBczc3VDZWaElVaEJwUS8zaFNXTDZFaEc3S3JaWkx3ODRL?=
 =?utf-8?B?dDVGc25Kc0FhWHJHTGtMK3pMa3Zsb0FNczJFczJDMkdpbnhJY21WZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a71203-7020-4592-76cf-08de8fd6e91b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:10:33.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ND7mbiPfTCI3AqLgwV7q+bnIhgnvQUY4wv79cO24uJahepSuw60PfUar+QIyTQ5ur7DQjc5mIPMQWkwLBp+jtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10667
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

This series enable Mali G310 GPU support on i.MX952 boards, the same GPU
IP as the instance on i.MX95 boards.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
---
Changes in v2:
- Improve patch description, adding more GPU information.
- Remove Reviewed-by tag.
- Link to v1: https://patch.msgid.link/20260331-master-v1-0-65c8e318d462@nxp.com

---
Guangliu Ding (2):
      dt-bindings: gpu: mali-valhall-csf: Document i.MX952 support
      arm64: dts: imx952: Describe Mali G310 GPU

 .../bindings/gpu/arm,mali-valhall-csf.yaml         |  1 +
 arch/arm64/boot/dts/freescale/imx952.dtsi          | 36 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)
---
base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
change-id: 20260331-master-7ec7ff0fe1b2

Best regards,
--  
Guangliu Ding <guangliu.ding@nxp.com>

