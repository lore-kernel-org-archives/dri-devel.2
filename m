Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2599606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Pxv3UV0B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD2810E858;
	Fri, 30 Oct 2026 07:09:25 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF63D10E858
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDKEvzvFdxGu2Qgh7xCdMjs8D4/+xUfqRSZqVsrqikyS9mSGLgt+0XaGQuoKPtYLmOAMx8A/CYxQjYXBO21v+5GCVcJV930S9pPusJSJfSRhJM0zRGec9MqPgWpr27JGWIgsxiv1H3kMpu/+IFh3AX/vkwJbR24ayvu1IMJlGqII5OnTQFbBWnz1I51WPyt6eH0AJ4QO44Pdi+2odCwIGdeePITVlGby5G+IoNtKeU4qOAxKTpmfmPuCx0HXXyrCb/24IyYeu+vyiSafXf9VcCuVjvMfP8DMLu5z37AtK4biJty9yQJUj8M659Q9h0oUtMCHbup45Hl5Z2fxWnaL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ios6e/ssWvn5GGMdu+G4ErLF0ZMyTTEaz9Lj8Wf5tRU=;
 b=DXf75C6VHe1SBeuC5Jwd9f9W9KWnPLZ5id7m2mnSjwEg9Vs9og1nncM6yhp84YtFKJ2XuFbThK8J2RK8KlIp3c9QM6iCgYx+FlbbQrW+aKhAJZFBfb89Zaxnc3cuyasr3v98J8/VT7vPk84q/AU+YL0whdTfcxGEwzIUaJM3k00pqBSBgEcwm7ad5OrjZX6HeleOH8i2ErMuUce2V+ozr9EyAzDWlqB0f9jZF4zGX9fjN10vRIRSZ5VpBbvFnSmDrVgJxAD4IjFO9i3gvCTvigmyyem5Vrf5PGqOSkfVQEFS5GE6gUZSfiNqM4N/G5zNRkyo9vazlyjFWwEhjPn/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ios6e/ssWvn5GGMdu+G4ErLF0ZMyTTEaz9Lj8Wf5tRU=;
 b=Pxv3UV0BeI/tZOrMrdDc2HvXrjo7ktGaUxqGW7ZUQZBKTDFjS1zhfrUaud6LH8iC3HkXrtx1lL6s8cyDy5H8mE0U449Jfgg783sZKy3jHpkkDcrekefv20WZLO6hZfvpaJBPgnMQrTO0AFWZ7XEdNM/Sqt2tYn01TkQ/uIeVl+wL4oCtuzv7cFgPFvdIdLWl6ivvysnZ6UAVXq1k1bH4YAYKok808w7iEuuzch7XZfYHwWCilG0L+teKDWiRIGcZ6jXMSecZUxbhQhxw03jPa74zgic3ZF63XtD4fD98lhcRC0/SaktWjPUPy+awZhsMRWlhM7VIzJSAi4zr2Q4Mrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 07:09:14 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 07:09:14 +0000
Date: Fri, 30 Oct 2026 15:10:51 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 07/15] drm/imx: dc: Add PRG support
Message-ID: <auRC-xz5IYaHf_AP@raspi>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-7-a0b50cc4fc65@nxp.com>
 <auMIsiZ5ARIl-6N6@vm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auMIsiZ5ARIl-6N6@vm>
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a35c19-7909-4b2c-7097-08df3654b497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|19092799006|56012099006|4143699003|11063799006|5023799004|261009223027099003|261009221227099003|261009223327099003|261009220027099003|261009221727099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4A0spMOMoAFOLgp2t7ZKv65nBEgvbe4iLzDh7i9BEjbMfOwo8/EV5sfZTKe5fmSCBC55i3Oyac4qqIkQmSki8/63/L5gQ4mm6WjinbIq6AA/7KIiI/akh01hBJcguiJe6SlU8WqlU+C35JFOJRmMV9mgD+cUtMHc75wttA7+opejBlaxPFhe0qhrJ3gyKSVCKaDv26NjPLWV5zsM4m8Bb0onEkHeH+mG8BiJ6vDTF1srPMMIwU3yIAWWV8Ct8iuxoj+s5FN2AG7jRxX81zKGCqSCZKSp7lntmiaW94vG9bHfVSRbPWeYllSxkJbdclsqQ9KYQLlraLoiM6ukNykor5QhDSl51LQRB4fgUocWNsNrbtMqAF+qj9IQDFgbRa1MTnXIzgH7Mv+zzUgmGq/1B0wC/lpAezA7rreprLf1KWTbyPpWrm42pStr8DZ1zhpguIusD+KiXtxa6acByAdvtBnuWKusojP8poP1QPTB2Eiadvv1QEpBTi1JhMxuEJSP3E3VGh3mfie2NQKnZjqdGrEhzK7p3Ro/KII4FUBy5/u8nsKH5VtEBaCeKQ2j8z/CEC5cd9TP9ZEI6cvOo/6LLBX4xt95gWAFGeHIoXYLXrpV+eACtR0Q8mamqwB1LRmUecRyR3Gpuan/3Aie7f9s/A0SLcKzMECkAsB0AEisvL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(19092799006)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8HPl5MlixkQoEyv4OC+LvVrbl/fr2DTl7ixmk+Ex0fCCqs4vIr68mC/YhML?=
 =?us-ascii?Q?dUEWXdScuUToByWgQsgAOgM/a6lUq0te69mF90vp40YXQMDL4noODxRrT/QQ?=
 =?us-ascii?Q?X4cvOsR8PYWUbmULJgaxsccYycOOu0f/ZD1b0bGokh8MkRB4CHWJ+aE82GPP?=
 =?us-ascii?Q?v/I6pSTkXKRp6zympVo39sPNWiyoHM9YWAf6SVAVP2PQvv4Jb7FLg/a0j1Nk?=
 =?us-ascii?Q?TJSiWj/8eeKRu7u9amCRJuuzdaq4aq97fLiUvcccb6rOz0Xzq6SqUqbkWRI5?=
 =?us-ascii?Q?uQZZgiIz3jwF/QBjqpimHoPUB3EeT3BxhqAg4sPDcGC2pzaDAGoj3ZJPp3L0?=
 =?us-ascii?Q?/ldHi9GHF4wa5ll/5/JyFRB8K05liWGaHY+yh6NtxvtHdU320DeYghtm9/gn?=
 =?us-ascii?Q?MMZQqSMHXYV0I1Mm4SivKaKmbkJ/vFhcRkbb6bbqfnHOarHaWCR0Meh2ksw5?=
 =?us-ascii?Q?FA9eF3NjA9i8I2PpLBKYwMpSD2QHajUEfB1Kgi1o181BGmmjGDyVQX5GC+z6?=
 =?us-ascii?Q?6766xTwK/Sa5u8ZkceoKGhY2DsnnYguo3kDh24ge6iJ1lqnufzz78PuSkOkA?=
 =?us-ascii?Q?aRYWQ2eblMDtl0p0t28jXK2yhTeolxX363o6ax5JHOVtHqqRAexs7tn0IiIf?=
 =?us-ascii?Q?VOPGABmMKIuc+3f89rHZ2DJP2GnWYn9DOLjzTbimOm23KRQeFZzCXYyJ7iEV?=
 =?us-ascii?Q?lSHi47kuc4S4nxm8e4a9SP9mH4FE7BdMQ1W+JolDnsRiztcF0rkGls8smp6Y?=
 =?us-ascii?Q?4RWOfs+kUK96y9+TALuZaVaX2ZlbPsJyH/lzB022alvzj/EUM4n5OYPdK/Uf?=
 =?us-ascii?Q?BxPwDIsCb/QzgresDUES5a7N7JeupQ/QwRnG6u/Mhr0XQyxsY+Z2l47gmkha?=
 =?us-ascii?Q?5X8hATwuqtZpoN9qpoBKC+H9mBfq8S1xObnXwA5x7E7ijWiGuoeGq69lTmMx?=
 =?us-ascii?Q?hg1MB8hiRSGhVV/LeZxOI51l3GnZL0ozrGmZHXDJz006opWT3lqw29BQAG9i?=
 =?us-ascii?Q?nhD/iLsirORvqZGxO7W3I/OwWgdn9cHTHw9hiWyRh2g5MAg3wjiwuwERpueB?=
 =?us-ascii?Q?gjkh+Tp0ga3D8EeEQyendo+rwJZ4XQS39JoQU3iInZxgPAenh2blvzDesDEM?=
 =?us-ascii?Q?td4843yIwaNs0K6YItKOJjSWfHfHaTrqKaeQOCp8XKrikWOmDctui53jfHMm?=
 =?us-ascii?Q?5K03Dyy2JP9w5yJ7E0MsuV525JgRh+2FDr6RiOvzABsD/aTHHmxABqJH6hxq?=
 =?us-ascii?Q?2+uALvgqA7u1EUhvtnlBM6UMubY8QECAc8H2/tQG+scpaOphvTHok941NNCF?=
 =?us-ascii?Q?DMjxHnh0af5TXyBEBA6CDPbj5fLPS8NxeiyJHUCG8qir8jGwZH5/sUePswyF?=
 =?us-ascii?Q?S9f19DyI1MxgcP9E8ew1L/Vtjr3xs5g8EXbwBbLPf4mnXf6i6HGrReRYa9Sg?=
 =?us-ascii?Q?DBWSU1Z46HBcFc7ad1MklkbQ0KlMCpVhaVGWFRqygwTiC4z6dERmN8HlTd4u?=
 =?us-ascii?Q?4meNVB3wsCG9OzdDWuzJ6bjDVfSZCl7/BNf8PaOf895k1qDNHfswxH2t3Xdd?=
 =?us-ascii?Q?6U/v3agYL7vUIEmqx3K0W6VY8ayeYUm2wXZT2Z+LFzji+GFO6lJtq5EZV/t+?=
 =?us-ascii?Q?lT1F9+tSaKA90XG+KNH67hXm1yIUpL7PqIVPuqC8QD2y/R/wN4HZW7Vn8Ew4?=
 =?us-ascii?Q?5RTR3HvQGN29PA/LPiFT8BZ52RLx0pJBRsW5/mxNSh53RicYX0pAhbpvuntJ?=
 =?us-ascii?Q?DP1OjTNgkQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a35c19-7909-4b2c-7097-08df3654b497
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:09:14.7059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBNERc0X7mUt1BD+hbZvWNC+KeYP3WDrqDyO1WE39dWsE2siQArO+/nm8kL7nKg+H9DdJdj+HMm++EGwhcT4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:30:55AM +0200, Laurentiu Palcu wrote:
> On Mon, Oct 26, 2026 at 06:05:12PM +0800, Liu Ying wrote:

[...]

> > diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-prg.c
> > new file mode 100644
> > index 000000000000..43df5683b24d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dc/dc-prg.c
> > @@ -0,0 +1,314 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> 
> This header can be removed.

Done.

> 
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> 
> This one too.

Done.

> 
> [...]
> 
> > +
> > +void dc_prg_disable(struct dc_prg *prg)
> > +{
> > +	regmap_write(prg->reg, PRG_CTRL, BYPASS);
> > +
> > +	pm_runtime_put(prg->dev);
> 
> I have a question about this. I see Sashiko also flagged an issue regarding the
> unconditional put when the pm_runtime_resume_and_get() fails in
> dc_prg_configure(). The resume is, probably, unlikely to fail.

Yes, dc_prg_configure() is only called at atomic commit stage which is supposed
to run successfully without any error.  If pm_runtime_resume_and_get() fails
there, something should be fixed, so I don't bother to handle the failing case.

> But, I see a
> situation where the dc_prg_configure() is never called: when the plane is
> invisible. The dc_prg_disable() would still be called in flush() when the plane
> is disabled, would it not?

Yes, patch 15 doesn't handle the invisible plane properly with the prefetch
engine enabled.  I'll fix this in next version in patch 15.

[...]

> > +bool dc_prg_stride_supported(struct dc_prg *prg,
> 
> It looks like you're not using prg. Can it be removed?

dc_dprc_stride_supported() in patch 8 uses it, so it cannot be removed.

-- 
Regards,
Liu Ying
