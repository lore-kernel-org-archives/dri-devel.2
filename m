Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87ADC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39A410E434;
	Thu,  9 Jul 2026 00:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tCSD4wRg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A99110E434
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghXgMG3zJClzP/EgxSnAIRpWkgu8EXKEyYlaTT1k7eUC/Lf2eXosNfOwEUWjGExVvwYIMQwzsxdCa6DZ3y+SZsFQXI+MkRyg1DwsGedIVHARH5vHv6ym2TZEMraIP8NPBlyB09BIQ7Sh/Zlsayo05R9hXm6yqqEJFeHXfZyT1mdhvlGQXQz8QFOJRciAJQQAUNH0RkoE7QOF3uSDeNOp6kOBanZn5/sXTV0XPCs9QSwrHUHofvXGyRm+wnZSL4WHes3CVbd8FHqjH8Pkw0Esv8C1SX2DMfb088nTg4e7dVR39MkG60dfts68BWlecuWFak664ifJsdgxJ3O1QodIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ao3stp7e71xM13+XbxkeSyVBkskpeBpKFGxTK03P+0=;
 b=glpVWwmHGSJ05xtSoM4XFI2ra/zigbS6JLNUBsQK7DF82QBwUzyo8aKL2BCQFO7mLzEnIHx5m1fVV1NzAXunKfS5NWuaFbaH9nKxxkSTP/OOMK5jezWxfAKx8+KtGFjwK/pnB1LHs46xrW5JIp6zvqnPc+cVPGPmoRYn9d7/UBrt9lKuMqnx8EJT3G1Ai4TY9DXgfLlgObWd1+uJclgkhQKgnaB0OO7yvHyr+7rLdyH6+u5yIORi4oelAIohBWy3da2eqDy2bHrOK6aU3C6ijdZ7aw65g/GGSGuBrgn4T0kF1vedi232QPtu5x/jVEoIXPorROqqRPjz9+qBS/Ynqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ao3stp7e71xM13+XbxkeSyVBkskpeBpKFGxTK03P+0=;
 b=tCSD4wRgzImhraiAx4qNl9CBqKPtSegoTaDoUvxg+kagaKOSPpaiYX895z3dENFPYYHLU4RyqCz1aH4dVTRH7ZpRY+9Z+p8E9JX+C2Jb9lMpZqKTYtzUIUeycdzWTeU8SEqcgAgExaat8pn9YzpdQvIGJ8SN69N0EEc+12pjvGWfw38uv+m3zbZG7JeEUjX4GZ7Gb4lZwB2JShFggBVudzueufaTkWgS9yRzsfGXDzX9UaRHuHNYHwILtdS47DVaQe/BsTabLVFuZyVB2LBvKk19NPLSzsz6HfpDijHc41NxgGWMd4Uv5WUqmPAUVHd4Da0kOo6OKRWUCA11P/nTZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 00:16:14 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 00:16:14 +0000
Date: Thu, 9 Jul 2026 10:16:08 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Timur Tabi <ttabi@nvidia.com>, 
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 John Hubbard <jhubbard@nvidia.com>, 
 "gary@garyguo.net" <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>, 
 "lossin@kernel.org" <lossin@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
Message-ID: <ak7lU9X4pTwx5NDB@nvdebian.thelocal>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-4-apopple@nvidia.com>
 <59948bff927bd4ad3af5fbe68d5d5e7565c5f729.camel@nvidia.com>
 <DJRP5QO5JKVT.Y7LCZARVCWJ8@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJRP5QO5JKVT.Y7LCZARVCWJ8@kernel.org>
X-ClientProxiedBy: SY5P300CA0025.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: d09d33ff-0384-4d2d-4d7a-08dedd4f4968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|4143699003|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: rAPgf+MgOpZM35GwwGSw8Dpn34x/Nnvkm2X0b/kUj6PqdjnV/6M2ecXxt0zfEA8LJfmKfDwkFHqFTnX3bPYsTKlbcTeYTHX6Y80BtfVFxnNfeTz+1nm0ga1BFJ1nOFVVxPohJZnpTzdciFqnPjGJCYQMrQup8772Yv2eC7m29XnKGqIcwYwQcqxOoGQcPY+AhJlFfbPJdaMLT2p3c+JFjVnerH6CW/UJq0Q76AD8cgL5OcITfj9smR+VIvEqNp8S5FrI/Lb6UpOR7YGUVnKTkAj2RmTfL02BR303klnip1Pif5v6Wf0AuitYborYfX/uwDF525BCiTXDGIfUm9J8cubO+LQqmF5e8WydrbZg25FCLkJljom46G8hBszCgi1CheaJKCDbgXyGquwSitRdiVZrr+Dw/9sVrDMAEQl0DzVZXxtFRaYPrXKoF6FVU7b5LfDmRxPDg/owRacJc6dMnx/W1jjG6DkaNxKgOubLz/UmUDxH53NtqDswl0PEIBqJzWFYGs93afjaPPsORkXnetiOgBUNeMd8A4DsZB4cakgM7p9juRry2MK8jCzZeEbp1jTjJ+GXLWpjOw58qGBy7Cr4ZBdh9CDU5iGtDymVEey+hnMVLsKVvKhMoAmgnMLVY5Xy2+ERZt+0LnBMF99Pab4M85flnrhw/H/5n9WK7nM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(4143699003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fXnYfGp5fAaZLw50g7DC0Rkl7mfAjP2mbyR5Y4YW30CyAA9PEXJ2zYQCbc?=
 =?iso-8859-1?Q?A3twn5RPN0XW3gkuiS9HmBmo+YkMFFcmpyXqp1/B2rvncctmFiamjqw4wb?=
 =?iso-8859-1?Q?Z87bT2AvEjp/g5halx/zKyI+/CIgyhMYMOtPht/SohH+/W0LDQ5zm4Ycfd?=
 =?iso-8859-1?Q?14naUejTOr16nPOR2c4CdJafDNOdYM+yInTJLyJ3gNvhN2FgZmEBMxwwf+?=
 =?iso-8859-1?Q?1WLs7TrmOgKFdLiKnNQeijwmMVvM+NkYjeoby4w2g7d5ClnSrio6+5d+eC?=
 =?iso-8859-1?Q?5wyUGYIZRN0wUwzW34cN/aF0pNuMF91weHqVRtdkaFSHL9TmLtHq8ADDJl?=
 =?iso-8859-1?Q?MBmEKOieKS15GzQJIEwTjwb+Wm2xVTKAK7LK8NRDnls0ew3gQbLGqVzHED?=
 =?iso-8859-1?Q?7oRFv+TVdhJQBq+YMw1DT6Fs4DZ5mvOeFm3sFFvQ5F4ch3VXj+vVqamXJU?=
 =?iso-8859-1?Q?f5u1siPkn31Me6lsqwRwt0vWsQC7etjdKAmfVMHy8WntW7IP2XaEhDIlkF?=
 =?iso-8859-1?Q?B/onMaXdmLJGp1rz61irPdY5xocfMrqWbJ1f+AKd4p0GD6Q5H3cvuuDfin?=
 =?iso-8859-1?Q?oT6jPioljOpKnSF84YYbYGftGCLi4sPxDFHjTjL0IDWWOdrVFOXCnUFykn?=
 =?iso-8859-1?Q?BR7sGNNUNJ4I04M19is5UewTcSUNug2EvyRrJoOGjVSf1nCcViu07k86Ri?=
 =?iso-8859-1?Q?K6L6lMUAFVRE/NFBgmMYUL2W7YVQ3lPszNGKQlSXLzOq/q4/mi5IW2qQ4U?=
 =?iso-8859-1?Q?4bBh7WViDLSwjbHAcSAU3VfcRbuOGsaH6UlLykR8VKni6gqaEIDqUlmDNi?=
 =?iso-8859-1?Q?U8MJ7wdSwXmh2W1djpiqhWA/WyFyeND0JnwcqVg18Y3AgKNiaUFod5Ykgd?=
 =?iso-8859-1?Q?ZIw7M0Z4yKbsqRqTWEoKEZi5uSMx/Gdpd0jnfG2gCvaeLIg+lCoY/338Eh?=
 =?iso-8859-1?Q?M1ObmMpIR6WDwwpDb73qU5i9iDNUdpPHSi5SXaE8h8psvx9NRm1OxJbP36?=
 =?iso-8859-1?Q?GUshvXghQRPsqq9B3s+lXl6CSwl1XTwT7qMbmHcCaG4MDmb2OBYkPCrEhk?=
 =?iso-8859-1?Q?BJu40rp6XQiCJW5ukTO1Mf0r5L32e38BVhDf00b6mEaJevWUFAQqjldHzz?=
 =?iso-8859-1?Q?vlXlJYOnMFNP1n1n3pR+KfwK89iT9/kgSGnuSUnUG7K9hYZy545ikjyyby?=
 =?iso-8859-1?Q?xB5wF4wq73OHwKBK4qKrC2eFFegtZuAIfxLyjSwqELYUfx/nhX6P9I9MJl?=
 =?iso-8859-1?Q?XFaINuDItLnz04NAIAoRCqG3U/1PTufjDrwhnu8GJ0ThDQP/bWbWoi2ZfR?=
 =?iso-8859-1?Q?3oXQPohxnIJlGvm+tkoPPIeUsX4bQKaCdVfSzEfNFzVn6Xj+PiitEk5S0t?=
 =?iso-8859-1?Q?6t14K15Ay+6dpFh67IHaoVpOnNMnhWjJoXRJxEwNlDbHFlU0MDalqD2ECI?=
 =?iso-8859-1?Q?HlRf+qgM5DXwGObQKiybzJHFcshuXGNFGpf3GhkU4g7bBmLYTuCUrYzOnf?=
 =?iso-8859-1?Q?6/48nYp5S31RV8rYhXGIu7msQM2eN/zV62ooxmpL7YUSyk+RG0z2jXbQFw?=
 =?iso-8859-1?Q?iJMyJPt0P9d7uW1qCXq6SkcvPr/hl810QEPPp97fi6TVPcu3V0lbSY5vCZ?=
 =?iso-8859-1?Q?IDBiU1GU2K9WKlH9V7s9VLM1JppO/ziAuDMtMh3R+jm63ixB+UvMCw/rui?=
 =?iso-8859-1?Q?+/gc+I/jeN1bJFXWmZfJL2K3p0Wz1CvygXNBJr4vHjWULBOZSocTtzmN6I?=
 =?iso-8859-1?Q?qV06OytizKas/5aJoGUrh5zQ9VIxnl3fijhPBm20xAFsPYZOGqGA//5T7X?=
 =?iso-8859-1?Q?hRFgaqBdIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09d33ff-0384-4d2d-4d7a-08dedd4f4968
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 00:16:13.9110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bUfuXtHnq53MEd+aIabnAjskZt74lAdnIqaGSsGMWOred6OGPpXKRTsJpn0oc93Jn1cDkVtGRbBipf85owXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
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

On 2026-07-07 at 04:24 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Mon Jul 6, 2026 at 7:35 PM CEST, Timur Tabi wrote:
> > On Mon, 2026-07-06 at 15:34 +1000, Alistair Popple wrote:
> >> @@ -38,6 +38,7 @@ pub(crate) fn get_param(
> >>  
> >>          let value = match getparam.param as u32 {
> >>              uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
> >> +            uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
> >
> > Can we assign these IOCtl values to match Nouveau as much as possible?  I think it would make
> > everyone's life easier if we could use the same user-space tools/libraries for Nova that we do for
> > Nouveau.

I debated this, for the same reasons. However I came to the conclusion that it
wouldn't make a big difference - Nouveau only has a handful of GETPARAMs and
we already know we're going to need a lot more for Nova given the increased
scope of features it needs to support. The rest of the API also needs to be
sufficiently different so I didn't see any real practical advantage to keeping a
couple of parameters the same as tools will need updating anyway.

That said I don't know these tools well - did you have any particular examples
in mind?

 - Alistair

> I don't mind using the same numbers where it doesn't matter too much, but for
> this to work, it would also require us to retain layout compatibility with
> structures, semantics, etc., which I think we should not bother with at all.
> 
> Let's build a clean new uAPI, it will get messy over time by itself. :)
