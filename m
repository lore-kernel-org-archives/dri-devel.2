Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32325C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 01:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8477410E5DE;
	Thu,  9 Jul 2026 01:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nm7lyLam";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F2A10E5DE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 01:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OH5+VFKSVdqQ0YrzigN4Bi4FEhLXejHEO8tsecg+gAwb2+gmedJRjmD7MrW1GdpqVp5gD+nHowHZAA8SO9aCC9IxNZYY8OkZexsnO5Keild/RiayelaxgAwXATyDW7c25jsauV/ZDgTc2UEZuhvkIH7l6FV9b/mB8u6w8CuNsJj4NcCSEjekMfwPtt5pDtA/lsVgY5SS+f/d1viTzFxrdf+E8gkkIt/Lespu5qjdoFFZIGlcum2mEA4Xq5TwhWtZvQOuRnlV61n6+UauIdUlIgqp9bjsQIX5DQJGBeGthOaKjJO460F60Fbj7nx8F86tkt3SXNpOKymDIqZO7fcYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lgxSxAXafbcJPz7ion9K8FUjVlO8n0R1pmd5xiblRw=;
 b=DV6lFBSV0bOV9H6nOkvd/GqPwVlbps+x/KMHrthuuKG9TwFf/n7zySNo/oQu9X9NhQdXNIZQL7NUrE+UaVvi7qG1iPQoP4+0if/uZU+QRn1eP71oIF+j5KVRU19cS/awe9iA8Il+3Bfd9YeWwLSUAgPC/LNdZz/1PUrMiYGZaFE/js3dHeyCoF/mhjYjJFtNO1CJ+RldDIIy3oP8vB1uY5S6WP6dUJHDoG94Ok8QSM1F+jUKHNbGqloZwyHGGRzAthFXae8awKIh+KSq0q1a2oliEpP0/0Tdki7osTU1lPsCEs37YkqXDeaw7V5VpX5Cwtgw+rim+MEXVnedYhvw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lgxSxAXafbcJPz7ion9K8FUjVlO8n0R1pmd5xiblRw=;
 b=nm7lyLam5xHInp6W9ToM8GJ3PBTus6cVrLSFqh7RRPeIfWpMEAe+ocxBkyLqSqrTpdDIVX4phZotbs5F7Cg95gwESgblxSze6bLBb3Uqyd0aRvvnIRzAvJPdIfvnxRAyrbV2z4BkYfj9bflZ7EWWRTS4av1KfevPsKls0yk9oB1s4PM3oVD/lSW1RNxExzuhjb98JAZIrxTSQ1Y05kyrj7SoitOhLttCGBWXTOlrLjb7YUgTePku0DI/gCG+uNuj8YxSdFMCNmNnSUE/xpXluUm6XoKEVAM6PIfBHnPZnww/Kamn+WIJx80yHCZagHa9qLHZaHNisRhb7dCw/R92eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:31:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 01:31:13 +0000
Date: Thu, 9 Jul 2026 11:31:07 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
Message-ID: <ak75iSzu1ZFUcoqM@nvdebian.thelocal>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-4-apopple@nvidia.com>
 <DJRP04MWOO7Q.3DD6YF37RS5K2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJRP04MWOO7Q.3DD6YF37RS5K2@kernel.org>
X-ClientProxiedBy: SY5P282CA0087.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfcd865-0e80-428d-f802-08dedd59c327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5zsHXhGuxoXTwnwFjz2SzbLW+oXsXuAMxgsfctTTpyMWM2O0Vm68Zto87VYd58bMVeuMG0M33WtzalFE9pJoWhpmRBXZI4ZR2bNCFDQbfRi6vW/g2idGAo/Q2hoYHwBxPPkN/5/fH5STISs5OPDhaVV6UoBio10FYBHKMJjWs9ayUK4XRDUxlxtyzOtBul63aPmTsSampvooN3Nn4I3/2C1Z04YRlYMsNGifWnVnqWZZwQjgC/j2QkkVo6ZfYWAGU1zR3g0xDU7poQqdNiX2PTJ7jeozFWer7JU/PfduKfsCT/bNDksJLk2I1XRvXWQNF1gq4ycrt2yyOmOm2f1SI+TqLuyY9yZvglBEhNob6slizPtB51gErdKPjnLG0tjhSqpyE/wtPHwLczU9J4AvKzssi+iymPZv4iItrI2tZPI4GTL5iDyKqzIGxNKD7LxBBsdyXD36Bc3nWDtcFcD777ivd7EBOLzArQ2bG0XvS5u7NhOM+W6Wdkk2XCs02xl365Qlbh8NyrI7E141bPiuBB38BEywvqm8H8c+hO/v2i6BsxOVI+wWYKIeJI+koEvZk50WWsi04puIu5Yjf90KcWWQX7DSppnkPqfDzBq+SBpM6687aQri1JFWA8eTwgf96dq8DnidI1zwnH2dJdWrY/dQ1K3yu+r7F+msmAgkJcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E1sbyG5zTtNApOWRmvar6z6KYpDQ+hKhE2eNyW1QOkKpjwj29ewdOoSL/vJt?=
 =?us-ascii?Q?GJDg84N4m6XDAu7/fIWc2vk80WgWsb/mhLFzU5jyh8U6Xl0wHlqZ3mGsv4lz?=
 =?us-ascii?Q?lkwq8jZzvBL4qoOajNbID62KCEBv495FtX0HN67EIYm16R5pNNIHryRoJazc?=
 =?us-ascii?Q?bToIrwJIqkMxW3p4qgVxrSd5qMqQOMcovhHxo7ptHdqS/6Fg94XqozGMqVH9?=
 =?us-ascii?Q?qx65u8M1N2L3LsWqXKaJBj+bpabR//TS2Qp31xSwtv7l+CcJtaCBcEUmtSzC?=
 =?us-ascii?Q?NOxJtr7wvJROwP4MUce+GbPCjf+u/QShpkEIpIqySAQP98yvLERdMYsfb/wU?=
 =?us-ascii?Q?e5H3/QcMab38hWHD3QSr6P65p1tpSG32yVxHHVPpG3HOuOtmZqtX+zU2Uvkf?=
 =?us-ascii?Q?2Vkc5DQzlj8kWkPEB0w7i3WdQzjpgR9DM6/zHKyAwIcUOGi+dtvwynhx4rQg?=
 =?us-ascii?Q?N3QV7x4tqJvSzGuAF1HXw8F9piDhC7X5RwaIY5STJDKun0InuKBKROV8qV7a?=
 =?us-ascii?Q?8ylv00zSqKGo5rKdajLFIbCuz+tKtsX2uxsI3ekcgOXACG8jjzCHxIi9N3tu?=
 =?us-ascii?Q?N5eulxwW5qfMpc7BnHbAD6gR15cCa+BX3zbrOzTfkvy59H0ztFI39YmlThR3?=
 =?us-ascii?Q?Zn++m0NIhKcZnWWb2BJte63uMAy5tBG+fxkpQK4EPDaRWq2epYCwpAse1FDt?=
 =?us-ascii?Q?g4c5SANJZntYZr/G+A+cPqct/KyMiuJa22GjVLh9XyZs7XFsoqoJEkvnNHzU?=
 =?us-ascii?Q?OmEApuYkCfKdQEZf/wN539NN1TxEWxbNm/tGTwgq005Pl99NTKNQtp94XPmf?=
 =?us-ascii?Q?FNgNMQl2aUqkrsh3J2Q42PlDDAlHDsG0a7wC5P4qySEYMpbVnNLQi6bonMgw?=
 =?us-ascii?Q?d/9aa16Jhv+zIVrN47HR4JYbB3agax5X7rrh5TqfiYXq+uvWs9jJndj9kjgj?=
 =?us-ascii?Q?nBNZLtRrfeO9Wolw80zj1AVDnTVg7fosVfcgqz+Z/RU/DZeSSZFoZ2YSET00?=
 =?us-ascii?Q?p1hu4GAFDMmFi4SACppn74ggz/rOR3rOglmWjexvqeJ9DH0hx57aqxE2smYG?=
 =?us-ascii?Q?ktRivEBgVtqONZVZVYwAyKtOs/SEKf9vaWD27WL9Ahkp8j9/Iy9jW7YFHbU0?=
 =?us-ascii?Q?eI1z7NG2Nrmh/iXEehVGjGHf/Q7xIyD0O39nJ7jUdbdNtGDrvzx7KEhS1ma2?=
 =?us-ascii?Q?kd2EF5yqdn7xFnvvxtbGwtpc0w51ZXrpbhhfovTByfWBYtn4zutxK9XDSVdm?=
 =?us-ascii?Q?nbcyotKtzudOWiHcGyjepmZyNBjoekaR2yPwnnh3u7nx9p2pTgh5ZVFwTZeK?=
 =?us-ascii?Q?OFz/fkvz++2/Xg2XytlzQGUjx7cR/j47TZqVWrtp4LITzYJj3yVjLC2wukou?=
 =?us-ascii?Q?N0ZD9FYy6CJwS73t6Qo3b6BuivsQP1VTkyYqBZP/oeqTq6SR7JaUzobJ9tLY?=
 =?us-ascii?Q?XoQ4M2bS/1Ef/ekcvqL0eCclMDVB7Fz+8DmFm1qPFsl5vDFKSTa3SCkQCn7B?=
 =?us-ascii?Q?oJfxOLkjX/gN0r2fxLY1dx++VO9bqped3/2p1rNFAVIbCC7CBya+MZ/+ZORg?=
 =?us-ascii?Q?KE1cNfD9x3LEprUWxw7nBBuaa0yIrHMjiplN8l+9BkBzKNDCg6lYlGqBNDr+?=
 =?us-ascii?Q?L5NGuQobv0ADYaZ1I1rwSqYfSmIfGzP7rpm0W+X3zNDP+AJ/bBeBirE/WEQt?=
 =?us-ascii?Q?LJZhXbJNcn15RPMQ5Ig/NPdmoSNuzq9cgYMRiX9hffbODOn0hpgLpcix2ZK8?=
 =?us-ascii?Q?bxOyEsk+mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfcd865-0e80-428d-f802-08dedd59c327
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:31:13.0955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTOGvzsgzSEoiiwDpxBMzWLKyHtZgkBR3uEuq9DioI86Lg+6xnSBUPEipKPpkn0mPAavB8/Y0AIh1MxG4LmjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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

On 2026-07-07 at 04:16 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Mon Jul 6, 2026 at 7:34 AM CEST, Alistair Popple wrote:
> > @@ -31,7 +31,6 @@ pub(crate) struct Nova<'bound> {
> >  
> >  /// DRM registration data, accessible from ioctl handlers via the registration guard.
> >  pub(crate) struct DrmRegData<'bound> {
> > -    #[allow(dead_code)]
> 
> Forgot to mention that in the previous patch, please use expect instead.
> 
> > @@ -12,11 +12,11 @@
> >      types::CovariantForLt, //
> >  };
> >  
> > +use crate::gpu::Chipset;
> >  use crate::gpu::Gpu;
> 
> Vertical import style.
> 
> > @@ -25,6 +25,13 @@ extern "C" {
> >   */
> >  #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
> >  
> > +/*
> > + * NOVA_GETPARAM_GPU_CHIPSET
> > + *
> > + * Query the GPU chipset architecture/implementation.
> > + */
> > +#define NOVA_GETPARAM_GPU_CHIPSET	0x2
> 
> We could provide an enum for the chipset values and use it in the definition of
> nova-core's Chipset type, which guarantees a single source of truth.
> 
> 	define_chipset!({
> 	    TU102 = uapi::NOVA_CHIPSET_TU102,
> 	    TU104 = uapi::NOVA_CHIPSET_TU104,
> 	    // ...
> 	});

The only downside I can see is it couples nova-core to nova-drm UAPI, but I
don't think that's really a problem so have done this for v2.

 - Alistair
