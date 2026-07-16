Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6697C43458
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D18C89907;
	Thu, 16 Jul 2026 06:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PNeVF1Fg";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256C589907
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 06:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSzpkwwlBLKkIowKoTOR4JFInVF+bC66JULPRTGYywST2ma+jZsJEpxydI8kVPVEamNnNMIp4RFzhm69zwPS+GJHsRZd2AGP7NDLHSB3nW/5C+NVXpPXhcPChmPGtsbT3qQcd1G4Pkfulo3ixEkxuSpBfxskoqj59ce8yjMzbtkHR/I1zClOIJn6H8mTN2XCk8AnnqJ7nyEgvcHG5T2kLNuyu6vU26kONFRRYg9iR1Gie5lsWjCVd3jR+Tg0MoU20Twn/FTE+dS6rwVPzDTiJy4E6IqMCQOwmUYnOJhcQTYyuP1XJjdy1bsOei5mhXYfSq+hBQSAzaTXEHtkuqND1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzPzdbTkxncmlnuaXT/WkcPUKIFpkefBekSlGQrfdaM=;
 b=VHrNKiG5lTJPQoOYNmWA6iFoHbTs5JxzQczGAY8hzKJrdLa5d+NymOc5eX/NSRvYrPcu3Qpv4VmKnup3ILs8vXvJXeRGzZgAkBTiV098rKG9wXFriLwWl8rJPlhK1yBMiiYurEfk0mzhdJx+29kJFw8ty3UUqWpQJC51LzD80Kf34DPdEmRcQ0ZoAuCPn2hVfYl9L1R0cWVov2i6VyHH6vtksy1XWlaicskjXtZr7vDJVcoAHHUZPPrvRayvsBqYgnwMOc9q1Q2yC+Jol0vGaEKPNvM9CUxJ75AIenYdXZyal6zUhIfvaaastjB0BqNkn63PieS8Joe1zzw1zcQerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzPzdbTkxncmlnuaXT/WkcPUKIFpkefBekSlGQrfdaM=;
 b=PNeVF1FgebyHa1rxfQ84VIbqh0oWBT4z2ckhVeuernXHp1uxbsfI+P37snpflSecy2LE5yrd7A8g3JlF96b5GhYUuGSA0g+1/dO0/OjW/gXTzaV+9hmICzsUMHXXnZDld/7evsX1pXajzu2Gv8A+ab84sAk1iF+A6j3oVbuYPC1Ld3aV+1pTBuboitx9xWvOBVKXTz+/YcSz9hfKzN3ep6JNjsAqLP5NItf6ikiEoJndm6XF3cKrZo5b0jxP9Om3guwLEo0uUeIG9ElmWdZ1G8UsWeQxFkbU+S/Acfq9eXISucryBIjgIvQGYHwWE/hSlIMSqt4JFpNrvQ9pJCKXOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB11066.eurprd04.prod.outlook.com (2603:10a6:150:224::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 06:20:05 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:20:05 +0000
Date: Thu, 16 Jul 2026 14:21:31 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de,
 vkoul@kernel.org, kishon@kernel.org, Frank.Li@nxp.com,
 lumag@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
 u.kleine-koenig@baylibre.com, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v9 00/19] Add Freescale i.MX8qxp Display Controller support
Message-ID: <alh4a66fEro05ShA@raspi>
References: <20250414035028.1561475-1-victor.liu@nxp.com>
 <20260714193627.GA9616@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714193627.GA9616@francesco-nb>
X-ClientProxiedBy: MA5P287CA0192.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::10) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB11066:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8bbcaa-95aa-4612-6bc6-08dee30246cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|23010399003|7416014|376014|3023799007|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Iba9lV/A6/TKpNXI0JwRNUgweT0KDFQi+30Gb4wKVDpWq2xuKmpVKZjBb+7zjStBNk9kJVu/4yHUhn9B+5D7XjeQ9vTEu6yVd/EnfB+YanbuRt547j440FDl8ZSiDWeLwVdyj87GbMuKOvSb8pFNRanwIkC7kiQkaXyDVXdHDsIYGzLB7/a/xm4f1X+Sa+mozUuNxQk4V8NdHHgqBjJ54soCvyUuGdy/ONeGmFnGV5H2FbQ/eSfSl2ggAEqcxwWTeq5GcA1OPeKIdyb1fl/cvClpmNkXqBiiMP+zZlMof9u7mGpxMuaNzKJ8AQZUmafdxSHoBMvRR4BMtWAcNi18Q7DHvYmCYL/MpBWIv+wz/P0xXlGc23Hyt9cun3vXphg1Sj9d/qZPfWfR8E/vfiAhE2C4IjKoaWp0RnVRgBsM5ggFKa4iyvQXkCx6ZW3i3wKmG3dtm97M21dVvxWDkSlvezZHPkRz3A7xXg8BrxQOXrnEikJqKQNamgou78FsYVU5U3GZC0utnqFvjPpZxZVide/B+O5hAj36NleZhPLNI9/Pg4fXxp4HgWiRHEdK957Yn9TUHtcH0lO8Ifts9Suhv0Rc7RMQaKSNmhLF4cccJ1+VCp2g5nCIoxNV7wkJy1g1SGJ8lqEQc61TjjeAxin/Miu9AQpJ5GU3kkyv+jdxpJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(7416014)(376014)(3023799007)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVadUeAgOxSv8KYR3Abjy9NGCjypXlGMus+3qc34H3SaLEQ4S7JnkY3kNMcV?=
 =?us-ascii?Q?7W/MGOcxofhiefUS8xtxRIeNChfcodelQTuFS4UAETMcgQ/ZzFsdJT+tHVea?=
 =?us-ascii?Q?+w1dmQZOF2VtdwR+hdVMLlzF14MOCycjDAfICh5GTH6/k0w8XAJ3mUMwEDD7?=
 =?us-ascii?Q?dmduLkU3nKdzy/VhsUlRfPsDOn9u65ohAcIbVqRFtvxInuHo9oUJBJblVpro?=
 =?us-ascii?Q?jN9d+o69QR98huPDd/vKxL4EANz5lmUgLZLiC96m+0De588X98x6+ilY5iy8?=
 =?us-ascii?Q?aW8Ok2/QWAuUPvyy1HG2DsU5lngX1LcrZuHa4u/SnV1zXaTVFuAWOYcG9Pmn?=
 =?us-ascii?Q?7jFVb94iU1xUeILW9Qy+O7WOK/ySu9Mut8G+nCpKY86Kdd7LaZ68xmdapil6?=
 =?us-ascii?Q?2A0/n7YZt5ZSesbJj00k/ksEADOjXLqwCHSPwGx7C5c0jyoHpOVfeD4l9ZNv?=
 =?us-ascii?Q?/qCt+24oDFkrdVSqMzOnTCu6C98wKTQEiBypPKRc6Gk/dIIwashyCHOGLsMh?=
 =?us-ascii?Q?T0eYwDE/RVKKaBXg/tdRp5EOcAcYnsE4R3kPKtg95j8FInk1VgTdcqJQ8Bgb?=
 =?us-ascii?Q?+wsRhcFte9wf+3jn+9YlFMOdBFuQ9RWaZzvfvFp0WGAlHPPwdBbCUOPt5K5L?=
 =?us-ascii?Q?+rOexZ4ZqnNs198pAHN7ZKznQD38GMkvrgYatdwvuRl/qW+0JBccC/uqh1C4?=
 =?us-ascii?Q?l4kIgqS2YapY3kq7Gfh5CvSlReT/Ql2kb78DLwgQxDKI4kwE8r0OEUwFbdWk?=
 =?us-ascii?Q?JIIOKyceVD0FUX1r9gNz5/CAPO9xPoTXBranqbAnUD7O5focDiGeWF4LRX8t?=
 =?us-ascii?Q?HxWq9NJIc/IhB3ylkjZ7K8+9V2ntfBskGvNM/DYC0yKJknKa9KzxhbzH1kj0?=
 =?us-ascii?Q?9mupr/tmD/DxpmmQbKjn6VH/xsmFbJfgOuhRAobrLJwy7A1IQxReFfdd3ykp?=
 =?us-ascii?Q?+ya4aTqgzOf10VpVWOwarCSR5mvAe4qsfHPhoxPcGAlBlW0whthIWoI4w51x?=
 =?us-ascii?Q?8+Uf9g0/9wqxj4aAeLOh5EEtDu8jmXLy3KPQFGP/8JpHSBDY3AFUUT3q9USd?=
 =?us-ascii?Q?DVbDfWD2iQlA1PegSOuXx9rNkptDsH/Z96o3vWbVOkKMKh0OiY3b+Dyo3CYo?=
 =?us-ascii?Q?ExFQHS7ZmNAuHf13fHj6jcm0Nb1zGUNsuZgzRDbPwwkticoGCuc7M2n0bAg3?=
 =?us-ascii?Q?iL33p1nz109Tan0G7KNITbhZ6uXk8xsskhW/G0nzAN1fGd2ykCVSyIuKwXmK?=
 =?us-ascii?Q?n5U3PINJ5hnj6aBxOnfzmnvP59xDHH0tMGvPT901P5iWLy1moLjv1n+jyAF5?=
 =?us-ascii?Q?Tc+qEzVz3x1XjjCP1WlKY7dQ642/hNfFjhMN07YO9VSD893vmo+LCFUAKi6j?=
 =?us-ascii?Q?Q52YlMnhpFO1k+6eKIUHQhFD90RvpcE4OaUKKODo9vwGlItI61fxDH6bLX+6?=
 =?us-ascii?Q?NA6DVICkdYwEdbD0txFuiFmo69zj6qiAQSmx7Z3kPP7FXifk9K9S+KFd+wZM?=
 =?us-ascii?Q?PGjXDs0wXKrGDbm4i+7q5gfFkIEioPE2IakjGPb840D75SdnzIa6oJOD7dJ2?=
 =?us-ascii?Q?brk860rAijm4gKOl7bAz2zEpgySEMadOs7luz3rpLJbNbbc0zqpyuh1qQYDH?=
 =?us-ascii?Q?PcM3h2tDMuihHoDIzLHP6SztGN/SEj+a04XWAfFqF0D+sSpfg8ODhEXv7ej1?=
 =?us-ascii?Q?kRzzAF2Iv50OMtyq7SP5wYdR31Z6T6W4SDKpRDBNd9TtXklvAfhNeO9ixpjo?=
 =?us-ascii?Q?+Wv2z+0Tow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8bbcaa-95aa-4612-6bc6-08dee30246cb
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:20:05.2887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mu/X/UJqwVkVh12GajahEFOm+aNJWvsCkbBWCessg4n4wC80hTapKNy6iFKRXgpuUaIJV7bRNkUmSkIXn/rZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11066
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

On Tue, Jul 14, 2026 at 09:36:27PM +0200, Francesco Dolcini wrote:
> Hello Liu,

Hello Francesco,

> 
> On Mon, Apr 14, 2025 at 11:50:09AM +0800, Liu Ying wrote:
> > Hi,
> > 
> > This patch series aims to add Freescale i.MX8qxp Display Controller support.
> > 
> > The controller is comprised of three main components that include a blit
> > engine for 2D graphics accelerations, display controller for display output
> > processing, as well as a command sequencer.
> 
> ...
> 
> > 
> > To follow up i.MX8qxp TRM, I changed the controller name to "Display Controller"
> > instead of the previous "DPU".  "DPU" is only mentioned in the SoC block
> > diagram and represents the whole display subsystem which includes the display
> > controller and prefech engines, etc.
> > 
> > With an additional patch[1] for simple-pm-bus.c, this series facilitates
> > testing a LVDS panel on i.MX8qxp MEK.
> > 
> > Please do NOT merge patch 14-19.  They are only used to facilitate testing
> > the LVDS panel.
> 
> What's the plan to conclude this work? What's the latest status?
> I am looking forward to have a way to use the i.MX8QXP display with
> mainline, but to my understanding some required changes on the SOC dtsi
> are not merged.
> 
> Can you help?

I planned to add display controller DT node after prefetch engine support [1]
is picked up so that the prefetch engine could be enabled together with the
display controller.  Just want to avoid a DT that only enables the display
controller or bypasses the prefetch engine.  It makes the display controller
driver simpler.

[1] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/

> 
> Thanks,
> Francesco
> 

-- 
Regards,
Liu Ying
