Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9419F606A324
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=a8fA+UV1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C847510EAB2;
	Mon, 19 Oct 2026 19:38:06 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A297810EAB2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 19:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX2jqaa5FQ7HIZb89Z1HB+dRWo0xQw6dXw/Gd0c5Vzcuh68xlpdBNETMAhS7nzQZ2U/Gmlu2vkCZjPWH3e8KwwIWoWjlktT/YT4tNsu54XuayBgD4ntz42NWDeoPlnMOxWywaKvtPYPgZ0ckPiBpDY1aX/bi7SQRYthMvVMQ/+Eu1BzkkwzoTPjDSCr4dF4XnFw/DMlf/sY19L+qAxnB3S4mnaTODcVr5FEtxSqIU53cIYAeOK6rwD68p1cEE+EzM6tFQ7tSRKxQP53fHPNdTY5SYHYdGKMCy0t3r+xNlyi4n0IZp4BUxLeX/O1eY0i9vAx/LxmCRIkKKEkdJZkGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOq9OWUpOn5PelbH0n7cCNBsrllnuV8L/twd3ejfzmI=;
 b=TVuAyK+YSmxvz1sbJbHVc9caT6wHjkZcVDIwXQJFC/B3XD97bR4GanVRtUv1mcFG4yRSMBgoNp5tCCc2qSpL2FCULVWUUlQkx/zFLoZSOPWgacnNvS5f9Yj7kSz8F4nhZbbt+T2v6MAS+hh/CrLsZ+pOiDcTPFqNmL7Sc18vcS6DopbfN9WJ905dv6GlOE2vBS27ZOQVGFVJq+acbcXZyACnI3w1PKbK2triL6QavK6jUMb/O425KLATyQ3SZUeKVmHeiJ2QXhKbHV7RMF0Yx0X7cRtZPE4w2SoX9RF0kBkwL99sp2HCxHvUaeZecW5Cg3nzChquiIZZygSysR4tHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOq9OWUpOn5PelbH0n7cCNBsrllnuV8L/twd3ejfzmI=;
 b=a8fA+UV1mqEufJRJ1SAQGCLjXf5HyzpURVtd6fcLNuHdm3YMuJyVyXDExpYb8GPRco0HUANmeRkW/0WQwDNOUsU0SqFSbR/bzI9QvAZjuZQf67g1I66NCsZEM5gIO6nK4CmGYtRCxJg/2UX+KPMcs2+BI0HzExgxTxE8runPS0XFDinPvHewO5PBoReRLNtluxImWCSjLLTC6C08HXV3B8h8QPiE0Wz7MIeTXjQ8filuBAwixCS1tloI9kcS6zHV5w+URwvxFR/LngLjHRhCYXy9B+hyWfZgjCY50UjVu4AMgF28+xu/S6UHo81zlUR+M5lC5unHoYmL3nn9/MNvNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB635272.eurprd04.prod.outlook.com (2603:10a6:150:3a7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:37:54 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:37:54 +0000
Date: Mon, 19 Oct 2026 14:37:41 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
Message-ID: <atZxhWaUWthEHkti@SMW015318>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
X-ClientProxiedBy: PH8P220CA0054.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::30) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB635272:EE_
X-MS-Office365-Filtering-Correlation-Id: cc89b032-ad6c-4cc8-9879-08df2e187876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: BG5deD7LDDka+hV+mXSiUkpYYp72gWKdQGh9/9BLnb0rErzV1UnXPoGPaTUrycOG+6f6DtCMGpd0+BlkDj9VOApcm0nBNg3+tNeJzJGsJ16K8mGcqgnhvis3E1dzDFx+8mRjacQSOaJt4ZoIEL3qR7/QzV+gN59dcpvOKCuKT8K1mJV7YASNa5qZbuK5vTbQq4Fb75J482sPupyXBd6HtL3/k8beHGfJwSm++MFWiifyLCY8Y4ue3bU9LA/sQNn2aLiZInq6AQ1os8iH4U63hEeNeHaBvMwdtZ9IQIh8xOe2YJ7VFlKvowG4OQPG9iPGKmHyXeeadgyLuHCszNn8ij5MEhm5AbXAtot1uljdj3SyA1U2IpA1lyjWUFSaqH85dO1hLBmv84FjVynprzNYom1+fZKBcFPirp7ZWItL1wkJ3tvpplMFkHVETHSgfngeHMsK4M5O58BP15iSAErfDYhTZa+z+JHiPPChqnIdgIujnRfs31xGc61gciiblVIwxzhrI22gE+uFSV/RBqMAFroeXn7bEe7FaBdFtEF04Pe1WgdD2adnJPOoFabLd2sLQkztrxXbmC8BgiVnTmdZVZ/lycaduD4Lo25UQ0ns3uE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GClBawuPUhmOR0K0WsxdCQYFtRCRy+zrkJcgaYDAk02LJPihTxQQqtgSAiQS?=
 =?us-ascii?Q?U9wt+TWkUl3mXXUkOcJZsmfs2BRhMeK9CdGqQg+kxz+SNLA9+zfyaeXp8VvK?=
 =?us-ascii?Q?1iCrXHCksfjasVPR9xkTKQkzJn9EfeujVMNjpg2LIyHcq00/KDielXJCfykz?=
 =?us-ascii?Q?RT1SZ3KSsuouIbhJbyfbbetmx1ojewErIQrG4CcEvaqmnyzNCNUdBw1ZNVI+?=
 =?us-ascii?Q?9X76JmkWcKH+UBj8h2dgXw0EwJeGd6pXWqgtGq2mNfRisJMzH0uyI6qaBPji?=
 =?us-ascii?Q?QQsoNJJkRZpzHNzaWh71+Z2ofIrdF1YCgov7mE4oU5+UDW6TK98ueuEnRVd2?=
 =?us-ascii?Q?lSVrI+l/yGO5h2G3fD3/g2BC2G3JvX/iy2nvm6hRMeQNe6E+NgRhnQOLD8eX?=
 =?us-ascii?Q?Gy7rS+S8+vHP+BHJ5annVktDw6cO8W5R2qn8SBd5FlEKWpNkvnQK9+8azwfY?=
 =?us-ascii?Q?xKkbTyesFlTlFYNbAQ6W55xjXXVHovNirA8mk1jr7aQdlaj7vpFPLMxaLY9g?=
 =?us-ascii?Q?8gcPBH7k6baGwCJs5IW8ur129GcYalItZniRetc2sVH8L6sM+F2SeqsKljZ1?=
 =?us-ascii?Q?puyNXBOIPBWTxC6M0MEa47y52cJaf8UuPZziZBDu4IXEAmkfEgNYsZloN6n3?=
 =?us-ascii?Q?3Y985K6roBRFrbOJkoFVtJzsRYjCmGV3UY/fP/f1cAEmZePiZ3Rvm5c+VpN3?=
 =?us-ascii?Q?LYA9GgnaTX3ujKrRKKYCVqqggsJnoS9SlxT1zA7jiUUB6tnHqdHnHhBHXq7u?=
 =?us-ascii?Q?GA8JRtI1riiWY9te5YOWkyt0cisH6Oau9qFfwS7YKNKuJSZZRbimg+2JYXer?=
 =?us-ascii?Q?rFXSBv5dKeFctC8dSFamiAcFRAX9iYLcjPoasryoA9neGLM33Vk16cnHFSTB?=
 =?us-ascii?Q?ekiKZ/HNVcVAp7WN4sKenKF6gdjnP57iQFOtYAhPwEl4h4qe0sgwnC0c1nAb?=
 =?us-ascii?Q?lUk1vK+Ey39BHaUDQq1j25Jzv8kEMf3nCqj+R/NCvIlMGFxGh5BknAueKz2Q?=
 =?us-ascii?Q?/OZgMDvIUXfSKP4nUQypW+lqMiXJ4UfkC8mcT72K8ILQCVJ1yTAhH4dkhrL3?=
 =?us-ascii?Q?jUkfsNfKrRk2TFKQLLhq1gc8z+CG7adnmTDiwdLaVl/P2xjVsi3gvhriT/dn?=
 =?us-ascii?Q?Sf5KnZUHXLytJkPPuKdtUkyFod+5igo7yZy9mNYAdglZxfcjq0ykKOFgnIsG?=
 =?us-ascii?Q?c2uEmXorN7llyLgSA3SNmcOkn8ngIgWVIxPGFJy2kNsKCuJfFOSdEGEJgpF/?=
 =?us-ascii?Q?ATZYKkWXq9DwlusBiXwriTBK/rdr7LAwRNZjA6AvAp1jZLa3d98yC/noQAss?=
 =?us-ascii?Q?vGMtJZdJuOqTD/oG/WsaBj1N2S1AD4mZDN6BiHpbzQIouHOcpfjNaAS+C/PV?=
 =?us-ascii?Q?QRbLvXCFQFdMH6q3xFvplvVNFgrB9KjmEBFnQ9rBhSJBvrcjbdUofZPOl9oh?=
 =?us-ascii?Q?POllDOKZhDI7x/s07OyaxlAlS7grC+KypXcM0mCn1/MdCoM6olIwAgz0WWTD?=
 =?us-ascii?Q?ITcoA4zxUUBuHCnot449Ezt3TCdiqfQREi2g/bJmrZRNrbXx+ZG9B2GmFI64?=
 =?us-ascii?Q?Tw8apJJS6VhZGYKinQ2GTcho60LGYVHDxHawNXf1ZEuhROx/KBE/E0vfXrMS?=
 =?us-ascii?Q?S/T2d6hGMu/hKGzHA3IqvuD4BukmraFn37L9F0RjYgc+CSOS6kntTIL6jVtV?=
 =?us-ascii?Q?jjw0D9KRngZvmkeTaNsLSjmN6E1u2pf37Uy8IsXKKAFIlUbkYjpGaKx7iH+h?=
 =?us-ascii?Q?SP7aXxmxxfzDrO4+7b510G9+7qJ4N6kTrpvrkdJWH0GhKKfVkcXA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89b032-ad6c-4cc8-9879-08df2e187876
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:37:54.7153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxWJ0zhADOX8DlUkHvfG6Fh5vI3uAFuwXsE7jgEhIjQI71xceeuU17Hc3LqkUXm65ImDznR7TOOgVoXB7a67eAMvWMbS/8qmd0HqCBgxd+d4U4X0rd+rxLSUsgrnaCjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB635272
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 07:17:16AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
>
> Add a device tree overlay for the VGA output available on the Apalis
> Evaluation Board, which is driven from a parallel RGB interface passing
> through a non-programmable video DAC to a VGA connector, without VESA
> DDC I2C signals.
>
> The non-programmable video DAC consists of a simple resistor ladder that
> converts the digital 16-bit RGB signal to VGA. The VGA output is gated by
> an active-low data-enable signal.
>
> The overlay is also combined with the various Apalis Evaluation Board
> device trees to provide ready-to-use DTBs.
>
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
>  .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 80 ++++++++++++++++++++++

what's difference with

https://lore.kernel.org/imx/20261019-colibri-imx6-overlays-v1-5-e4d028727382@toradex.com/T/#u

Is it possible share one dtso also?

Frank
