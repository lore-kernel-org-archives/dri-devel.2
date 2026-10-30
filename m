Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F67606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FJNyrrwr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE096112668;
	Fri, 30 Oct 2026 07:13:13 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4890112668
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSsA4XHHF+vUXS8Jya3sKn+f6ITEk7sdkOgrHjsEUiARt9YrqgotUisOj7Bl4janR9sYoR9Q3/WFcZ0fpqSf0xQuUtVXKYRwSNhGwszSiopTysoQo00iISdvYEoNn6BHPk28ruhcKfc8DBw+SFlK1AV8Mye1BE0jWd9PIN2+jUvSwMiFQw7xVnHnYfvQv40URbF/pL+KIekhCAjL7Ao3TmmBJopvtAHpBhNfuYd1eFIpo8REGwS7oesCBCQFfsGF5rQc96lNMrxsLwsqovwJ02hxKu0TTVdPCUioJLWtFf55diuNj7hjmnG10GIFqanw7QwNvQ2fCN6RpKiuT+o55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCHHMFAmAlaJ3t5C9Gb7yAIlxtTnfTWSvkFbXzdkqVI=;
 b=RY2OAZdtlkxxohjzmH0Qs16hnQgE8i/oP9QCETErJbh0vQC3usFBrl47sdHMeW5/osXMcuVAjrCYWzTR84qtYO7wGnuvzqeB8TkHyznV5+KVPRXq1XkeBWjnkbBr0bD7dXVCvbgGiMdyWtWmjaxhPWtLiA+mcQtEZNnaYBA5SFBJlyyjnVm4qXdIv4irGDiETX4PQeS3iLfngPoSBxB5RhTILahjSdPyKg9zi6mR30Cj809n38oeSXdhW5lHGNUbRucRki+mxGsXdinentr9LTqOTiAKof1cJnBUYviq6rl+2BEJjKEeR9XKtmTyeZ4adV4sxsKQNTkAX0yvwuA/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCHHMFAmAlaJ3t5C9Gb7yAIlxtTnfTWSvkFbXzdkqVI=;
 b=FJNyrrwrmZXsv6TvvofMywjcntZPYo8vAAuM97GhWz3bSpFi5jx0jKSuRqZdBRA/UlaUNp2cfv9Zs7lajd9qAmxdBvK2A1Vuu5rQPVflFfLjKixPP0cHg+zErsPRLYMr6UIX1ny/rx/EI9jXv77GZKdPMyOApBB39lhMRfVoR5N/aqP0xu73Tbusv2fLmWbswJNV2NTzWK1GefUJO/ZyDVijwnB5fvsJsi2A8REUZKgYuy8VxWKXM5wICiyvRCh42fveX2fSXIAJYluW7/rFuSEhfUGbOCodvEVlWO/XVqApJ6/pgtZRirShLXh33uk6DciiPkqjVkAOxJottc/WTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by BR2PR04MB667331.eurprd04.prod.outlook.com (2603:10a6:2c8:7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:13:04 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 07:13:04 +0000
Date: Fri, 30 Oct 2026 15:14:41 +0800
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
Subject: Re: [PATCH v7 08/15] drm/imx: dc: Add DPR channel support
Message-ID: <auRD4QEBys3Smc3l@raspi>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-8-a0b50cc4fc65@nxp.com>
 <auIOl-0XRtRrhLcw@vm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auIOl-0XRtRrhLcw@vm>
X-ClientProxiedBy: SI3PR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:4:297::10) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|BR2PR04MB667331:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ca89ec-42ba-43ae-b65d-08df36553d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: cgX4mr8s/ZFjrh3rJCkYdGR5xdN/1Xx2KZDs1qal5Be+74/3vV+dNbRhmpaZlBo0ZrckRxxmjwbgx9ion+QQNfLe2O2lteUPgRpNRG/xcQVkcRxiRwrzenPLNmh2qGTew+R6BDAmWq4d8Kz3c2aPiSeUtIgAI7YWVUcwmCw4hmDO3K4CbtmwNG9hyR5Ycg6zuZPUflMcI2SU4dGRD5SJYC7apX+mKSsNCYn8hSKcMhuPkVPf8druQENIeg6RKqWiuOWQ5R5L1y2m/Xago1AtKTQS3W9WNXs86Z6t1W/0wtIrROQayajO87kgv2Lli0xPwmCKG/vHyabiR4zDSfccEg2Nh5IqNimAC/RZO1b2EOsvnaTy0/PEuvsTUl6W4uoYOxqqvOwuHc5dUdA/pjCeyvl3EwBAblujh709gZLqpJimLTIisGrPniOADG2eV+jX+sU0hJM6K7x2+Ha/Jatug+KBQZmxsPIvrHXNGi4NANNgHVokyhV9QQZ2xxqspACyx3/arF6uu9dh/ypos7NshlFtanBdzDx+Z1xD+HpQ5bQvljPxAZ7J/dwyero6ArgkS0Gp6yU1ABKfH+RfXQblQh0OEFvUwADD85xQ0Bd0T1A3Huyc9e7reQcGh1AkBBnvyxwU1CcpXq7ZTEYtkt0niPWIZGX4C82cc3Tp66yRHMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dR3a8hIsb3Ebd562/q0pBNA3TGmQeqIdwyaAqW6LjuctgbniNc1Qyz3pM4nt?=
 =?us-ascii?Q?KWH6zaMpGYjjMx4vLL5aHYmQqcSEh1zKEiFjwZVe9h1dnQYKlISHxw/GNsDa?=
 =?us-ascii?Q?tob3JQaFIrJlVrhfpN9iQ8ENg3NGUje083VY/n+Z+Bjkq3zb0pGGtU6YFxGk?=
 =?us-ascii?Q?/bmze4W8xEwAltqe80mHsoCq5BkNkQTv0vZm8178gpPc4QGzhMDAS38uHix+?=
 =?us-ascii?Q?D3uRjZIi/+tIgnaeHFx+sbWlAX15O34EuafBPeZm1pKYUDqTOmROcwZUssxT?=
 =?us-ascii?Q?/Trfnq3+YSEhTiGXyTAsCDaHPCLowtZgOW9CR1JhXboiBI9n6XVVYT877QGq?=
 =?us-ascii?Q?tmZ43d8BlykQK8/SGZtMpAYBQstk6sLmKOKB/RGD0uQr2IAFVlxRlTjBexwF?=
 =?us-ascii?Q?4U6crBGuos53KRan+TfIIbEZtQNEDawyetYgQB4S9Q62KSGqwQQGXR3jxDYW?=
 =?us-ascii?Q?92PVermrUhpBdRYzMwcU8AGs6SN9ILG7xEHLa+Z3p9uKnkltwVmS02oD0Htl?=
 =?us-ascii?Q?GEeZFgV5Z1xoUZZa5PZr6paIne8i8dvl5eOYH+R+VKQqJD124+gYE/bgpiDD?=
 =?us-ascii?Q?rZB0g8LmyFmJ+31FuY0dkEAOTmOn1aM6FZKPmBEpTmWVv+LqEWNrd5wRWxDZ?=
 =?us-ascii?Q?6H8JWhCMtRcW20Q9Ojp3KL8tQokmK/vjuOjX77vHneR0ylnpIOTNsUO29NWD?=
 =?us-ascii?Q?iQ3F6XfzqhMds8zqa3IulZaN5kZz3/UIzYSm5dlVIKlu5E6hEM35hEUlZH+5?=
 =?us-ascii?Q?MilWGydToAsPJALXsO6C9D1r63MIGpMeDeWBiuBaWpy2cptKtKc17QUYfeHb?=
 =?us-ascii?Q?RpAsDeRFarxMlNAnDIoFdcorp6gO07+8p0oeZFjB3oZMIzUFSE8GcwwRec73?=
 =?us-ascii?Q?shJSkcR4gNCCmx/GNaBn4ewxqLfpNDVgdL9IcwgYLT4ATcNWUiIQ9ChFD7wD?=
 =?us-ascii?Q?BHfz4v+h/ZQ/IFR9GZ/CVgQmkPVbsjTpdq9uGLcRgAkn/r1gW0T4a/+8LPPP?=
 =?us-ascii?Q?Z+lzBtopv6ZF4c76YTe29n21jb1xgS/2ls2lTGpQzRflfK7g6syXXoZkpI1j?=
 =?us-ascii?Q?OqwXbxIw+dfE4AITlYMeGAYvd3Nd8hQE0x/5deoNQTRnRwRSoXDiMiTcxaT7?=
 =?us-ascii?Q?SfJq1tkfODRjvN9buIrsDp2Z0tKEmfvRvz7V6YCK/qzpn6jBqdTt/bwVivZH?=
 =?us-ascii?Q?V3EZ4XquPAT7/vT9H8ob0X7+3Fu7t6grCEvw4iAoP5SQxlbHu+UR9rRioW+C?=
 =?us-ascii?Q?uKdSAP+/FCXhXLXmFrr5d+GeABR+srTExHry/ScMl+YX1TcygbcANLa+jjqc?=
 =?us-ascii?Q?/wTrZrgiBDxrx5oJnNpRGYOnjioGS1aO7vtjs/i8ICEkIn31vs+iNY+JPzNN?=
 =?us-ascii?Q?MenGDmThOnXAqe+ECrY44OjFRzra8I+hK5LWh2NMMxScan/22meXYwJoLJOc?=
 =?us-ascii?Q?vINYj54n8aThHn9APY8jMqU3Hv6cTPpVrO46z6H2AhxEJlCRxRVbyZD2ZVkt?=
 =?us-ascii?Q?ighqxLOcocbJ+hOhmqyeR4BFcDSyPjSVa6Mo25ZGyMo7tQ039Bxey+HxXbmw?=
 =?us-ascii?Q?iCl1jZTU9iFwzDnAByIR05p1Tu/l9thNjHJl+/bbyzWLdV0XZDtH0r0jq1yJ?=
 =?us-ascii?Q?5/aA0tDv6oUoJ7OL8xCcAX/gphoFkKvFXEUqoJooRXHOardWIORh+PIrN0eP?=
 =?us-ascii?Q?6cOnpl0zeJE3kfkKEjvFMgC8sol4kElg8zzLcDl5Y2O1VmSMMh6ZJlq0uUju?=
 =?us-ascii?Q?Q5lD08yDIA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ca89ec-42ba-43ae-b65d-08df36553d82
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:13:04.2546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrXj0dDTOMqk2dfr++c61tgN9rhGLobQhRqMr+2Z/Xd7iu+3MmeenijATTMyUTx2Pi1LaQpO9iov8TYCytUwrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB667331
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

On Thu, Oct 29, 2026 at 11:31:45AM +0200, Laurentiu Palcu wrote:
> On Mon, Oct 26, 2026 at 06:05:13PM +0800, Liu Ying wrote:

[...]

> > diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.c b/drivers/gpu/drm/imx/dc/dc-dprc.c
> > new file mode 100644
> > index 000000000000..a8ddcd117a52
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dc/dc-dprc.c
> > @@ -0,0 +1,522 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/firmware/imx/svc/misc.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> 
> You can remove the include above. You're not using anything from module.h
> AFAIS.

Done.

> 
> [...]
> 
> > +
> > +bool dc_dprc_rtram_width_supported(struct dc_dprc *dprc, unsigned int width)
> 
> You could probably get rid of dprc as well. You're not using it.

dc_plane_check_dprc() in patch 15 uses it, so it cannot be removed.

[...]

> > +	ret = of_property_read_u32(np, "fsl,sc-resource", &dprc->sc_resource);
> > +	if (ret) {
> > +		dev_err(dev, "failed to get SC resource %d\n", ret);
> > +		return ret;
> 
> You could probably use 'return dev_err_probe()', to be consistent with the
> other places where you used the same.

Will do.  Also, will use dev_err_probe() in case devm_request_irq() fails.

-- 
Regards,
Liu Ying
