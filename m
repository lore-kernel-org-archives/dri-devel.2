Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7568AC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48BA10E219;
	Wed, 15 Jul 2026 19:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="whK4eArR";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10D510E219
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPOwrAVhiBExAE3JyyO0sNzEwP7fn7krKTdMcPTpCPeXscE0o0c/d/MxLrwGYnp9RHVM9tV4eij8yZ/LHZaTUp4c9IGYrfC/owPF/HNtlY/D8u4hrC3GwXiwP/I00ZvWLSuvpuE/glUTQFsmldxt8oIT3KQW1oKeq0Iu6rPnfe5BUcbFKY2pFnarYfQ7OirIOVR9kOPjdhTw4ZDiUuYHX0kX1wYvz+KGKJAKVCcWX5YdFye1N+gghSMQvLR6FKL5wPeGfnoTHXGSGOuQEAMmZgDZEGkhakgazGxg8ZRfA2l+0L3OwPSDQjFGl2vhJRA2ipRCrMksheEMBRt+LsXWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9UYZYNRb9P7FJN6uI9WcKOgtxIVngg0y7reGH+LRko=;
 b=kQs1rEBHzMOkP9C6E5BA8iM9CP2j4MGtzsj3dfs9+lJPN0t8FAouRDxT7eF0OOGKQSGQBx6iR0FivcLCCFW8KCT7EOYIO4pmXjo3g6YyMtgliqGqNTbcRpb7TEcEL7B35A59P1pv1J3iCmRhZbsuFK0xkrAJBtQfj8LwRHZh1OS46aMv/gcOlgTQC74x/ZwJS6BdtZRl5Rt5pPvxC7UnnV8mby5QLgf82ei7KeN9I+fY3ssF0blhk0tj081fgyUVO3tzY4SWn+X5dDoTt8OXaVgJ2zQuoHfrGT3J6ZHdcMovQ08+bgklfuUIjY8iAYOfcyIQJPoevbEcSF26Ts9C+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9UYZYNRb9P7FJN6uI9WcKOgtxIVngg0y7reGH+LRko=;
 b=whK4eArRopOhe1kkvxgBMsHTjLx+SUNJWlsCRVR0cTOqkVpC6hsKw3Q+QInQ3wJfSf/yo22Dy3gVZv+YHi+RJut559Y1OwdY0j4qwUxhSKTf7WlDH5TdOsEhtVM9/5Ygq/y8HQbVaPjvQe38gROF7DiKeh5xpwD+u1FYGJBS9Z4JN1heuGqGhyvw6Tnt6R0SA/2ANPmKCo/aX7WPZnX+803WiBQgDv3W+yg3VImntcFuk6+2pVTvZe1G4uXhiOROgazsbG96nk3RoBAyH6V5M8iVCt4mTvYyIuuh9qXwC92h13HxfF4Ph1XztYNYRSI7AECA5orTuZWS06R6OhrAdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 19:04:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 19:04:56 +0000
Date: Wed, 15 Jul 2026 14:04:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 Frank.Li@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH v2 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux
 controller
Message-ID: <alfZ0GmQXJn5PmT3@SMW015318>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-5-da797562636e@nxp.com>
 <20260715185304.E244F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715185304.E244F1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11481:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a1c15a-5ba2-4055-803f-08dee2a3f583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|19092799006|6133799003|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pq5dRLrtEuBWJ3tqd0nv4/G6yoLk/l1ioTZtHu5hiv+rr4r+g/tmkZw4oYN9vcV0+EJvbMZASwMR8J9R6v8h5G3PjEeWA1jcwfmy1UQBa3OA7pQJyi+EP1FTumNbnk2SK1iaDeHzwFlQ5Wh+xwzQqSgWtPr1A0lL0mdnA/3uwGaeiDURPEmBR0/Q8gt1pu4tnZ3j2O29HZ/6UOOxMUyBfdI47c/xlzTFBs8LJPO7G9Y7XyRItdYa92Gc4ct8HlALR8cP7YlASJgybBe0pNDgZ9dtsxt5BabDYJPaSNOdFdYY9SHvk6Iyu/gkn4iLfSx+8+X/Hz7+n8FCqW2xoI4hKiVPk5ICJSRTvhc9b8zIhYf6IMok1Rs4bgMDFw1hSMbQabHytNgjyVpdQKSD0wZZV3ADbaALU1mRWGRLAweF+KptJGAmCChzxD5ZqNPXORN46t7id4vQZ3sttaK9TRGKYWKUeX6GvOE9W5a00yzxrVbzCvGkJ+gmrRZfNlaPfPzLs5/oTs3yAUMpI/eucV/lad3hgHicmNKMWzy3+8+292STXe6GxzJBNAHMxsbIKD94466J66csaQ5HvxjPvPIOMvjP7FFsQxDerrs8SirxhP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vyVq68EWcjDvrIeiXMpKBojZXFq+BJYLj1pJt644sEO8+G+yFc6eK1jGXf?=
 =?iso-8859-1?Q?nKGEfJyYoBXTs6BkJlBGu3FWZHhcbTW7PKqpyZCvbRsTLXXx6a3TR1l30c?=
 =?iso-8859-1?Q?Lhj4xKX9nR4UBWwAQ8ElbPQBkHciMNQM+OmSqpqSbGw4ZktNTHve/gwB61?=
 =?iso-8859-1?Q?6xcte5oS4I2dexrorsIy9htM9zJEDeTbZPA5cz9F0KwV28Go7MmQ3NHvnE?=
 =?iso-8859-1?Q?T/jbdDbp703ggDb+HR69Zh3XMJqTZMdnQshdWMRYY5uYtnquSc1Blz2kC1?=
 =?iso-8859-1?Q?L6AHAzy4FeXLV/1tfKzkQfQk4zzU20eNqCqQCiaODHfVGtEfNvVl/UiF/S?=
 =?iso-8859-1?Q?QVieo85t77NnDezoOHFjWbxclPu1L8PQYI+d7AIh852tC/d7Rdy7ytgIyT?=
 =?iso-8859-1?Q?8O1CvPxBi8c5xo33BA6cFLxwyEk1+FOZ0v5RRzmW2fYbyfB3OXVxrGEF8a?=
 =?iso-8859-1?Q?UPWeJT9aTvDdAcppgrqLH2UMFfjeBJfLQDLVeFT9iVYWCtQIw/VbMyqHe8?=
 =?iso-8859-1?Q?cgVyHZRY+QfcPTeXMV9eKR+OS+VEWcETT868KoLx67GB+n1kCUhQ0xs6KP?=
 =?iso-8859-1?Q?3NWUtJ3b68TQq8yEIVr1U5D62+TFwxvmqwwwH3iFlNNaly0okaAGvvpfgt?=
 =?iso-8859-1?Q?bYnxtmN8qjBOF7Hzn2o5Jia0EpRukaYrofWyahbQ17vqv3uxx8D85Sr5Lt?=
 =?iso-8859-1?Q?pcgfGYrpP+6oauKA/NkeUQcxLeS4Z5As1oyN8+egYNzfOq63jrEYUQfyCf?=
 =?iso-8859-1?Q?032cqam1kBzZFGThHDLr1cSmYpnJpVsgHDf+3HscWJnfA2B7oiht6NjVI+?=
 =?iso-8859-1?Q?z3gZd0b8gNZMNDvcA7qD/jqst2DwcPA/XnLwV85mAa2Zq2/RvEmccr3e2T?=
 =?iso-8859-1?Q?UTuI7FQ+oDkSk69OULxWQPfrb2DJgysgyimK+5mqyCF/xkC4FMcSbkcVok?=
 =?iso-8859-1?Q?VcdFfNgggxdV7c58gjkRye1YiOAmrboxZqXB4EVKctLm7SAF+l4RKL3x2B?=
 =?iso-8859-1?Q?SWWx1Q6ihLsbGHWloumqI/QBxZ+u0RsdtMXNk8+R2pI5Igil2q3WPjD65i?=
 =?iso-8859-1?Q?MernRrGuvX/+7mXkSaZ/SVXTju5i843nz4SyTx8/7yrDiRFjUQCY0dSKGb?=
 =?iso-8859-1?Q?rghDEsrh2rwFY3B6Ox9jBibN0y33gX/rukd5kx+qu5/1nAgs5+CLxL12vK?=
 =?iso-8859-1?Q?e1Lv4k+o6rkzLTeGDCelmm/EN8kIOlWjqRLQ9OzZsLoxSnEyvfqQXBQgSZ?=
 =?iso-8859-1?Q?NG9qKL3wNH2ui+XE28Z6kQQwUESOzgry/YbJyZJzUHFXs7bv5kT4/wDxyJ?=
 =?iso-8859-1?Q?m+VDfynlCXAowZhGQBUuU+Rd/xwP5TLeauLgAYMXZ++/f+HMTOH4Lau6I9?=
 =?iso-8859-1?Q?sRmBt2EQgjCOlTalDOnx2kDcljhbdOtWgkJfYXhUdQqnKK2epFTjvr/B+8?=
 =?iso-8859-1?Q?HOnq+6oh4UrVTcIF966gjzR7VXsKj/k1GiUxJx9JT+zS5kE1PyeYnetHuq?=
 =?iso-8859-1?Q?X1oQIcWtHx1sE4u1vMkfTTT82CGibL7KXKbZ3jw3WQbtAKRsjjX6CqWi1r?=
 =?iso-8859-1?Q?AYeQtYLG587szsM+fDXsooFqH2vmqzwYBe/vZZ3VV4QzoquJq0BwoyuDO/?=
 =?iso-8859-1?Q?sqbm4SLEC69y5UZ/NH4mIhpP2FjewdemdcsfXPwklBSnIgMDgzYpRccXJW?=
 =?iso-8859-1?Q?tX90bnVppw7uoleLyjw6g4t24Kdk2NIw8jv5bzDgvDw5dLfIsUGoJxh0HL?=
 =?iso-8859-1?Q?TEYNmcFzAK9NRdIebLopQdLfYyQ6A3rTF6xCK5BM7cPXwsGQOfgkwEyzYj?=
 =?iso-8859-1?Q?E666Hp2P4oP4cgVPxJB4jdskwi3QNvKqL1i7FYgK1poinrCugk5P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a1c15a-5ba2-4055-803f-08dee2a3f583
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 19:04:56.3111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEKhUngc40Gyzt2cOFY7J2iTuHE3vyC0bdyo0taMmjminy4E/5zqTXhXGEhXOOVv2gZ70iNGOh+UwD7cHzcA5ZdSWI3wjZOJDHwgozlXh3Fpoay4ayKenh42Xqz/Efrw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481
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

On Wed, Jul 15, 2026 at 06:53:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The generic pinctrl mux driver uses a blocking semaphore lock for mux states without registering pinctrl pins, causing an indefinite kernel thread hang if multiple devices request overlapping multiplexer states.
> --
>
> --- Patch [5]: [PATCH v2 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller ---
> commit 2474a73a6c541ff5bdb893980b3be68aefebe7b3
> Author: Frank Li <Frank.Li@nxp.com>
> Date:   Wed Jul 15 18:34:50 2026 +0000
>
> arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller
>
> This commit adds a GPIO mux controller to explicitly describe the onboard
> signal multiplexer using the pinctrl-multiplexer framework. The patch routes
> signals for functions like lpuart1 and spi3, preparing the device tree for
> additional overlays that require different mux configurations.
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > index 78e8d41e67916..33941645641f5 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
>
> [ ... ]
>
> > +	pinctrl-gpiomux {
> > +		compatible = "pinctrl-multiplexer";
>
> [Severity: High]
> This isn't a bug introduced by this patch, but since this patch makes this
> board the first real in-tree consumer of the pinctrl-multiplexer framework,
> could it expose a deadlock risk in the generic mux driver?
>
> Looking at drivers/pinctrl/pinctrl-generic-mux.c, the driver registers the
> pinctrl provider without defining any pins (npins = 0) in mux_pinctrl_probe():
>
> drivers/pinctrl/pinctrl-generic-mux.c:mux_pinctrl_probe() {
> 	pctl_desc->pctlops = &mux_pinctrl_ops;
> 	pctl_desc->pmxops = &mux_pinmux_ops;
>
> 	ret = devm_pinctrl_register_and_init(dev, pctl_desc, mpctl,
> 					     &mpctl->pctl);
> 	...
> }
>
> Because it bypasses the pinctrl core's built-in pin conflict detection,
> any overlapping state conflicts are deferred to the mux subsystem API:
>
> drivers/pinctrl/pinctrl-generic-mux.c:mux_pinmux_set_mux() {
> 	...
> 	ret = mux_state_select(func->mux_state);
> 	...
> }
>
> If two devices (e.g., via the DT overlays mentioned in the commit message)
> define pinctrl states sharing the same underlying mux-controller, the first
> device will acquire the mux lock semaphore and hold it for its bound lifetime.
>
> When the second device probes, it calls mux_state_select() and blocks
> indefinitely on down_killable(), causing a kernel thread hang instead of a
> graceful failure.
>
> Should the generic pinctrl mux driver use mux_state_try_select() instead of
> mux_state_select() so that conflicting overlay requests fail gracefully with
> -EBUSY?

Yes, use the new patch fix this problem.

Frank
>
> > +
> > +		m4_debug_fun: cm4-uart-grp {
> > +			mux-states = <&m4_debug_mux 1>;
> > +		};
>
> [ ... ]
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260715-dxl_lcdif-v2-0-da797562636e@nxp.com?part=5
