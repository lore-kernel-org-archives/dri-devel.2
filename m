Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA25DC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E030210F021;
	Wed,  2 Sep 2026 07:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAJbYQmB";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A42810EFFC
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 07:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1nk3Ag8lGJGRkjDL5NBykaRwte4wnvsJXuYBBNtxPxVa4/cVgDG0DNJOnjWr5n69T9TPb89QHv/M8RPkgYv+NBZa8h/7A7zVK/aE/j/e0WH3/eidT7KaBP1HLNS8L7gSj9SXyzGw7J4tXyWaJVjQxrhhiuFhGxPZCVXNHcYjigzjj9uL849iy870fci6JhOeGI14c+abV7Fp37pUUhgplyR7in7E7qNxrTlI85Z1ff/1Rbdf8DjJAZwlrtBeZ+zLfQR54bSd+Ol5e5f/GmQlaA8lNy2B2wtGpSiihHXlzu3Ie50W2mxKrZ6FEFrXEF802pnAHk5qPT0mWVzwHHwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C++iQURR54PK2QEB4HrZTCUsN6p/aIG+Ow9W9yfeeaw=;
 b=zLuD33nbZLTSai2n0ljv1crEM5e4uytABPZ5FLX4uIvAFkX+Ghp8dkFWYOOPahK6epsln5Fo3UiastYTGAc1rW9EnqhwwrRYI1+EiaafjZue/lgKpnTdLVmsHrSjTERH+CqjbmS8kIF1PZaSW0Z6dX6BP0MHhfQF9qUmVOhPHxuYAeMyHIKPVRgNhpKkukACLDGaCNIYGu0X/BnllKFndE21MuXsYNhLIWr+67kAQCkpbASz1bVnxt1K6Cwon/CFeu1UGfBI7qj+7hts7MSYMWnMWRw3DRplcXpKkkDLjC1I3G1YUIBpGbWrN6rEed9pciQ2tdaB4dgA4quMxyrLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C++iQURR54PK2QEB4HrZTCUsN6p/aIG+Ow9W9yfeeaw=;
 b=RAJbYQmBsRwh2CnyJY0i2spaC6Vtx0gYQBAp27cVfFTGkXuPtP4dnTXjTBGQIlx/UQTP0Z85lRskWIvrETdxEI7YYGn/U+0d5SRCBjW+4t27AwbtwQL1fb6P4u+QasqiM4JO+pxQrEPn7d44nkb0TwIbMjHCMDGdjitZP1ejMV5s1QNFMK05TpHndmZ+kNO0aHPLasHFA7sbU4CQZkb+yghUboY+VI8/wSP1cwCtfvv0HoZjy7t7CYgFk4npCgWZKwFunsXW3aTY/HAp9esrZGNkHTVvwQuLaD/ZIdZoxjowNSddo3LF0VzEHwdNdT4BiXVAWt/4y3eKqitHWlOycg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:05:37 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:05:36 +0000
Date: Wed, 2 Sep 2026 17:05:32 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <apfJhtr6BpMosz1q@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org>
 <apZCTUYiN5FHCkCm@nvdebian.thelocal>
 <CAPM=9twQxnx5DDkjwXWi-vXM4kqUQQdPaL+=1ASS0tpf2GmnYw@mail.gmail.com>
 <apZbKc5xMQ1yTBTu@nvdebian.thelocal>
 <DL3SXIIA4FID.2V3K5YC91RM3V@kernel.org>
 <apetgjQ9zWpJATj3@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apetgjQ9zWpJATj3@nvdebian.thelocal>
X-ClientProxiedBy: SY5P282CA0144.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::14) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b3c771-bb03-455c-34ff-08df08c096e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ElsU4yfwuYp5O/g+RvjV3AoiJz58wlQtoiUtfbHs14P2S27pgj9Brv+DAsWacZvUrhMCcx4kcLBJtlMnp8U0Xic8nWktGPeVx7OJhKZsWve+yi5Pix/jgy+SIV2Hdl4rITDh2VGy06Q7Qpqu3dm1IBFqi25P7KLPIsf7bUIR7l4VDILyPXZvICU1krJsj/m84p4aqQjkwuZDwnZYLiSTXzJSqYgC7eiOY27MGHNjp+9b5w602SFXDwcRV86MmSxH6JSXWoYgAI3f1hs9Ar03kU6/N3g2rU5QpLd6hbI4Un5SPncx9Bwq13vXrj2PfMTgjn4WjHUBbJ2FDNTymoV9bg90VPYvfGnKkbsUbF2Py/xdy0mLggFhAVhlpBMQIUuDOzAczFYZ5Gx9pPBh9y5RSdvtrluw2D+vH1VWgz833xJK5nBS75eMjIJNWg4/I4pYGuw7Wp+kgnhFeL9AsGKVkeMGfVcFNWlIL6aZOoh7sJZmriFR9sF6dyBgSu6cCl8BN1OAVNSv6PioOozBhxJ9lBFzk3g0X3DDTKoQ2nX2XL9p39O/Af1qZq14UwzcE0QCY+aHxaZMupX1x9qOcekJPHR7/87FprVaK0QWlJL1WFgwaE31zNfH17cNUqWYu/OQU9I8HukOazPm3+5jzz2hfX0PadblZAhYUYbvCFjCpkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRJwDvT0SfiHveIvSEtLZvCL9n9SmY9HDhEOcqDexTjKo+k+mconfkRjhKGT?=
 =?us-ascii?Q?tCNhsxJMRityGeGk+WljSOA7gyY6pKO/puCfuJZRWxn32aAE4nBEiMZZWGMK?=
 =?us-ascii?Q?7nSEBeAQhaKTr6aIdNirGTLtGjN+YUNbaSkRaDbHndO/B3LwBhodIkykXfAI?=
 =?us-ascii?Q?ihEUtgdP3SlUPW2DPa/cBWOP8aoovS5zJiFhI0h+zRDTYnLLgkc2hrxvUQcs?=
 =?us-ascii?Q?A4GQq4zzoC7CK3k6t/J5I0BnLKIC9VFc7v9lGxGHVI9MSXpBl8dOrmV1LOQV?=
 =?us-ascii?Q?VazVnjHWm9eHXT+2o7fsyqS6iDR5y5SMaTTEDD3ShUFLwc9D45MiMcWGhdLT?=
 =?us-ascii?Q?owjcNqWvViTPC7/Rxb7cJD21eIcXJeKE0Eo/r5aaumLmfp4c0aqw3Jw7rg3y?=
 =?us-ascii?Q?74vAnpTFyd8pFJ4ZYprkgBmlhZFhaUnarLUEKdaeQj8vPn0A2O90LHulbHqZ?=
 =?us-ascii?Q?f5KKStapDqOVkEHYcUm9gjZjwnhXa0+hUXwjnPuLmsFNczU6qm9SY/OGRwdT?=
 =?us-ascii?Q?gu/rssiOvruvlvSZA7BhUJjFYR6lHqAx658vYEtVF7BQHnHYtMXI1893ChuD?=
 =?us-ascii?Q?4S+VEt+e0H+6O7olaqYGZnup/DgKr243cI9UVZayj0pILGGjBVKTanztelYk?=
 =?us-ascii?Q?VoGQSGdQXUmfxFJW1lSYvPA9eBuHLIPTaSaSzPC+XenHkDgJIQFTWT3KS+//?=
 =?us-ascii?Q?JbUuEF+U0bgKEY2Kv/9qiaHLH/Sgq6JEuAT6mWOcSb1VH7yFBiYXwOpHe8xo?=
 =?us-ascii?Q?z9DEt6T9l2PhGjSWS+onQGd52iHMhPntp+fp14jvNSqmOvFuVL0d72FB0xIK?=
 =?us-ascii?Q?iZxpsm4a1I9qeBJ9Zgb+grP3glmfeVAdQw7diwqaVpd2ELiMulZZ7ShCo+Ta?=
 =?us-ascii?Q?mbI9s1cAZRBHnJavUMoJXzz9od3wTKAjGk1nvNl11aVfl+2QXKEoI72zv1JS?=
 =?us-ascii?Q?6Y99CePuHdV6QxgcvBgGA5mSXo30w7OygWT+Fa139dHCw7CuHukNImQTBXyM?=
 =?us-ascii?Q?v+WohtSd8IZzjFTcnkxg4/tIVBlXNOhJchDC63HO9ZAH7M6g0hzh3cRg+pnj?=
 =?us-ascii?Q?z7KBmnw79Zljn3/prL+xy0ER/1+ilepVHcMqwGbU7sXn0zy8LrvIPSm2Ez+E?=
 =?us-ascii?Q?H5DySlWx3sXaYfo+u8smUQ0UUeZ9gkTtH4A7Iu7J6EO1adCFvxlXXDH50UFJ?=
 =?us-ascii?Q?rmUGOdhJeetZy0owjdJFucGG4wC4WDtbxOq87pIahUrft8evKrKCt3KG9ecI?=
 =?us-ascii?Q?phPnEeGXofMvjJ0QKsX5bWIHapPRtGgwEBNV9TiVAmGawvrEWyohwRWr7C47?=
 =?us-ascii?Q?Y8FqObZ/Rt5+ynq6tygLSwt/dhVaZ8LhNGZH6wKvX20uok+8Agh2loTEQqia?=
 =?us-ascii?Q?G7Fk3GRWqnWi0+dPWST1B1KgxB+ZeR4CrlErX2hUGqTDKAgJ4OAcYMJj21vA?=
 =?us-ascii?Q?8XX9SyiiXubMjNueTa3JHQlksBeb/P+H6ONNjL1nXWqfwDUM2VApS6KGgd8d?=
 =?us-ascii?Q?oGCDPDjeVLhlX6IL5buLCcFfdlQjXZUX/JSy6u0s+2OQie6AY4MCvgxeBqBO?=
 =?us-ascii?Q?6FxTl/T/4eUqD8DedpzDTjGxwosaY0DbMPOspV9X3auCcT3rPk6Rpw6uPSiA?=
 =?us-ascii?Q?WPtBL8GNePQFf2ikTJIhgLM/fjLT6m/Syyc+J6lGeyTh3iXwlT6V0cfvU3l5?=
 =?us-ascii?Q?1dNY2hGH6TpymXCLbp88jNlXoLlB8ARxjVjPvYaaR1ui7NvP0AXP/l3apbPD?=
 =?us-ascii?Q?QPzsb1W99Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b3c771-bb03-455c-34ff-08df08c096e2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:05:36.9040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5olxT2tX6RIIAdoUTGLgAWDJm+d2dX5MSng6mlJsItQZvLLwhPH8DvDVk1MReyyXL8HsQd/KEgknMgi132X0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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

On 2026-09-02 at 15:21 +1000, Alistair Popple <apopple@nvidia.com> wrote...
> On 2026-09-01 at 17:29 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> > On Tue Sep 1, 2026 at 7:09 AM CEST, Alistair Popple wrote:
> > > On 2026-09-01 at 14:50 +1000, Dave Airlie <airlied@gmail.com> wrote...
> > >> > >
> > >> > > We should make the NovaCoreApi just provide an accessor for &Spec and make every
> > >> > > subsequent method we need public. Otherwise we end up with endless forwarding
> > >> > > methods. We can also add as_raw() methods to the specific types as needed.
> > >> >
> > >> > Ok. This is where I don't have a good instinct for what we think should be an
> > >> > accessor/forwarding method vs. where we should just expose the underlying data
> > >> > structure and required methods to API users.
> > >> >
> > >> > In the past it seems there's been some resistance to exposing nova-core or gsp
> > >> > data structures like this which is why I added the forwarding methods. In future
> > >> > we're going to have other data-structures that NovaCoreApi will need to access
> > >> > so it would be good to understand what we should do here so we can keep things
> > >> > somewhat consistent.
> > >> 
> > >> We can expose structure defined in nova-core, we cannot expose
> > >> structures defined in gsp bindings or firmware.
> > 
> > Yes, those structures are not even exposed to the nova-core layers we are
> > dealing with here.
> > 
> > There are the structures abstracting firmware interfaces, but despite exposing
> > trivial cached values, they should not exposed to nova-drm either.
> > 
> > Instead nova-drm should call into nova-core and ask it to do things on its
> > behalf.
> > 
> > More in general, the same is true for any other device resources. For instance,
> > we also should not expose the pci::Device or the pci::Bar to nova-drm, but again
> > provide a higher level API.
> > 
> > > All the fields of self.gpu are structures defined as rust native structures in
> > > nova-core. Their values may be decoded or derived from GSP responses, but by
> > > design none of the raw structures from gsp bindings live in self.gpu AFAIK.
> > 
> > We could indeed expose all values from struct Gpu directly and control
> > everything through visibility, but ...
> > 
> > >> In theory we can internally between core/drm but I'd really really
> > >> like to keep that boundary as the limits of GSP for auditability
> > >> purposes.
> > 
> > ... exposing struct Gpu and controlling everything through visibility still
> > means that we could easily miss some device resource being exposed directly to
> > nova-drm, which also includes GSP abstractions.
> 
> The individual fields would still need to be explicitly marked as `pub`, so it's
> not like just exposing the top-level data structure suddenly exposes all these
> device resources without them being explicitly marked as accessible.
> 
> > So, I think we should provide accessors for the major structures that we
> > intentionally want to expose (so we have an obvious boundary), but not for every
> > single fields inside them.
> 
> Sure, I don't really mind either way. I just figured that's what the point
> of Rust visibiity was, to provide a simple boiler-plate free way of saying a
> type/method/field was used externally. But will switch this to using accessors
> for major data structures instead given that seems preferred.

That said with the changes required for Invariant Gpu and being able to project
Covariant fields out I can see why accessors for top-level data structures might
be useful, particularly if some of them (eg. Spec) are Covariant.

> > This is also why I said that we can expose an accessor for struct Spec, which I
> > think serves as a good example.
> 
> Ok, so just to double check are you happy with an accessor to return
> gsp_static_info as well?

Still interested in your thoughts here though, just to avoid churn because I'll
probably pick the wrong answer :-)

 - Alistair

> Thanks.
> 
>  - Alistair
