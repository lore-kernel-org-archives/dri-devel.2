Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C7FC61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91A510E14D;
	Tue, 25 Aug 2026 07:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="opijN+NI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10FD10E14D
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwsSexVbfIcUqTOzelTl9RkEY+UiJAbYjGeBbJvEbFgougBTuBOAQSAv1mQvLLor9aiJQG9dOWd5r4y7lwQbooIZ5He0x0/Y9nBiFufSQO5kOI03+06Pdlcmx2rnLMdUNMnUlA1KGZ14I2GKprUO4kJuCVGq1/dklhP4Y1jn9V75OBpYNzNuhj41XFwncYMGEQqm8jUyD9bUQI1cVxKy2z+T4YYuTZLY+pVYtDUbFrHToFElfyaQOGyLKeyyiW0JbTT3r8tON5CghvNVg7ojP8ymlWGJvikXy7+5XHmt+9KneNq2dB274W0SmqwxjMx6IKQ/46L2r074rcR6uW7cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqsvJI/D8FYD0TDFOKMkhwpUGzLvzVLj6DCcjhSH2JE=;
 b=Naz8/vRMFl8zGA/lHtDMVqzNT8BjYTtBW3t/3Yfsf9Qdg3Usf241rc7/cmpFhkVJ/P+CnEYZF1jhDEyWHMH0ZbQ0nQqCOrlJ7A0WS/RqKkgn50lAGkqLLoqbjCr0G2TqhUOX+HhLKeEQIPQP1W1Fi2ZV7GiVui0VVjuMf5mQkJyJCoiTfRKehYaQFZTt6p0tKDmg86BDGPeCEzNkSKSJbBH9pNbfXDvFjLSv0/lIHYo0z7B/v325oYXvHi70tAHcbLf0LNGG7LvaQBeDzT4Xvlm+dG6M8dAXpZaVv1HdRfO1ApmW6xvmvxh8EkKGsER/r/Gjy4zQukTWXuf/GqbFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqsvJI/D8FYD0TDFOKMkhwpUGzLvzVLj6DCcjhSH2JE=;
 b=opijN+NI2AnaS15KBzi6Z4jXIPAST9L+1jr8G7ct9xfDPpW/OZhuvYpU3F6kNgTbic0X55+MfwGJsKKoR/obW1pHd7Qfxt43ZYsF/iU6jkQXKHngK2a85RrR6QJKQorP/3VrIC/9bhhjY1kL5cNbsFTLeXeOT45S8bu8NgJ9ZbtQN9hTrjKOTyglrqLuvGZwVUuovGB+I8UGKVCAdapMxAfofw1KeB31kCXFpIdhWtYGqYA+aCT1UgxqaxOBG/6nNykt6lrOMTMtSrw5dCn7i6N5fKLSR9qM8Dubl7Snj0yBKBnoPJ5O+1aUvifPNRfjfQzikBRbit0pNKxYfLUDGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 07:32:37 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 07:32:37 +0000
Date: Tue, 25 Aug 2026 17:32:32 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
Message-ID: <ao1AnG7fUhJ8a1U-@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
 <DKRHW6G6P4K5.15H1A4DGR6672@kernel.org>
 <aofWfMSZtV-bNYrr@nvdebian.thelocal>
 <DKXETHVKYVV4.1P8RNJ6AXV3X8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKXETHVKYVV4.1P8RNJ6AXV3X8@kernel.org>
X-ClientProxiedBy: SY5P282CA0175.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::26) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8ee324-31bb-4110-6e44-08df027b0955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2HiipbtmGicAKzGOg4Zme9Hk7eoRK6Xe2BYjvn4HVPXNNIkhuZjL56sft1Q/l/XqwGSiMqS+n9ZQ5lKwS0fCPOy+Gx1+5Eu4DtoJMOTPKOy/jmxXBOMmRY9vGtOnbsXiaV1ieHG+lA3BIDUsbXBpIvcSX3vuteX45fYpBQroMT3pPDvqhcUPSxshiWca5atrJl1AhjuWUKQnLy6x9vCMau+dHwn/AKXGD5DOxiZK9ePD2pFi2EFbDMOMGnD8+eEhL0mGaO5865WwnKT//DxKsI7XcvUZQ9oKYEL5J2+y+9GsGfWXiP/0Vu2dAZVVjfvCEcmq10ZJ3/yiF+sueTjmpCvw1qOMuFyoIRF0xFlG/0a7Ri7ZiCpB+JqHQPMZzGPdAU/xfxWcCW5y+JS9oLXOVPArIrU4cSYNYUnvs5YDNOMfDjC4QCpeiMIG+3vX6GbN16aiRPmlXBxZSEgfF77GfiToK6zU2QlRQj33C9LNLXoRAYfwbes1wnTkI/iL4ar/ufuf9g/smN1bxWGOjmDSP9jIFfrvk8YjrpbhKEIili064Gk7LuZCDg70MxEiewNWk5JVgypsgLob3K9HxKsSQ658L3Aj89pPg1/xT/z6yGK/GoaTvDxKEiUXIgEi5iarZVSejpvX/Cdpw4lqID3U6uF5t8a7p+hAb3maRBI6q+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBR1Oe3VBxou6q1N75xgkjiZR5mHrc+6bLXCEMCSOuls20CZ3FBD0LRhheEn?=
 =?us-ascii?Q?JgVivE+E0sfGUGsJuX5CJ7vEN2aDt+4AfJQiMMUx30N6v+MEhS8rjtrEWYwB?=
 =?us-ascii?Q?1UTkdx7WVrXX6VPvVGK5AWkZy7GuXJp/fKLV2wJeygsD6OGEudEklXV/Iu+T?=
 =?us-ascii?Q?013meM99NvpKyePiZHEqKdcuBC9wY5HczfQ7Z9Nrck/ZQVsr2yy4P3cbsiTr?=
 =?us-ascii?Q?XRnvNFax8Q4cDPdjefNUSqmAusZNvC5Rj2U+9O5OTm8fOCMZyXVzVM8cZXjx?=
 =?us-ascii?Q?eD38LhIq0kEuWYkLRoq86xPLIGhAOwCZIWNWbY7IHcizd3etnaznOlvy++IB?=
 =?us-ascii?Q?WCvLvG5qrK8jJRwJCj2jfPthvLxAYgy0Csz9+qfeeHFTI4l/nrGpVotIjeGl?=
 =?us-ascii?Q?33uQXa50H3DuS244cDWWaQxLYi6bQYITAQSx/u0Za+aeCk7hCRp8RgG5nVnP?=
 =?us-ascii?Q?n6GMig0264G0dHv+Ob00WSq5xWaeIndLnUE5U47nxrffDyH7f2lxi3LC5dZJ?=
 =?us-ascii?Q?6RZbL3gNeJj/4wawOt0NWCjU4XsevIeSwRWTHs6IqDUpo5WRj1IZK+BoGcEm?=
 =?us-ascii?Q?rvCantGcVoqdHd2Qc/Gf7fNTS3QDe0lxGreq1hKGbr2rp3JWvcqLAesfX+40?=
 =?us-ascii?Q?D01Ld6kgaL5KlNhVHe8sO/P4mOXRlV+oLpmbK7GB0YbmQv0s+QFloxTk21Tx?=
 =?us-ascii?Q?KPjr3JNrnswhjIr+y3nlXsAfajwW7u5ScqYI0RP21wo90rOvnK1blJAGX1Mn?=
 =?us-ascii?Q?WD2ZwtMRmEVVtPLvZNCgZjtPm27bRVb0pHRYAVtDUnG7Hq8wGVwroE0so3v6?=
 =?us-ascii?Q?+XnAuVCYZJozrcqPDhg4DtfsjQ9xdUr2uNynfpRgd3UCPGu+zjplaF1yqj0g?=
 =?us-ascii?Q?y1f2jEkBd3IPSmHqudqpfASsFp/oRPonVu2XxDB9L+KFy0/E5egtAwi/H1R6?=
 =?us-ascii?Q?4NqtVr1HDnyOf1uwJfgFpDunxmlw0uCLc3On+B/Dke6FCB4ls7xxPtjuFTHg?=
 =?us-ascii?Q?KAhS5InbQOt+nj9/BCr9hLNtwvQDP4325ifSGZcfFtWwkTxT3shiX9j0Lr1N?=
 =?us-ascii?Q?ATYHDGGQvePIy87xYzSbK+pe9ON+3kOgJCW91F5ODZ6pFViTDvzxnDvTzJfG?=
 =?us-ascii?Q?qSOh75HaFnLIFLMM8dgkxd3K9LNM+3VTEf86EhL079tWrf+De8eZ0a+HalDx?=
 =?us-ascii?Q?l0OkkoSOP8jl46hwFbW+nxz5bdlGP7gwvqwRpOxve5/GyfH32n4lqcWVLwUk?=
 =?us-ascii?Q?e7PrGtYJA/CniVYdqZgtFjjHgA8qcmCuBN08mND1An7/rDUbwRAnaIKYggzl?=
 =?us-ascii?Q?6nIkVlLqyJ2ocC/96UqROo3loBGAKAjgAqmI8X6P+wgrH/mNulW/Y7Ar3oSj?=
 =?us-ascii?Q?RzPhJVibK0oNgvlSlkqL9B93GS1DL3rwrdZjxPznZ7vegcTavs7Z7Ez2FBCx?=
 =?us-ascii?Q?k7z2XBOd1FdyN0sAzIzn/fmKi6hAbhU6vPout/eJNoJoWGduVG6WFWzf0BgL?=
 =?us-ascii?Q?h/Mq+l8Qrb3MXNQhlsOQJx+R0xyy9rcFKR1Prrqb1OywCvB19iGMS+7DcwBM?=
 =?us-ascii?Q?9X2hmK8kOAa+nZ7/FZX+jmBFVHXvXDlkWxEtOiaqlZlaBrh3ZZpnE0KPKGxa?=
 =?us-ascii?Q?M97tJRLb4TTPuSrs/lY8cCsEE6GnTDTAzVXl1FLF0yZuWL9EOVEn9muNbh9k?=
 =?us-ascii?Q?iAaz66pKsI0X4tW0iSa1/h+PDIGIZwFId6pJ2sr5GOrNaISUbRV/V0iqKKzP?=
 =?us-ascii?Q?f32JOQEPbA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8ee324-31bb-4110-6e44-08df027b0955
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:32:37.3721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZyOdOJP0jvx9V03iaxD8+XtoVhQUl2P+HXqcJVwlrG9xqTqL0U8nB0fd7pEexHChXP6ToE6hHiF2xqogzzYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
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

On 2026-08-25 at 05:10 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Fri Aug 21, 2026 at 7:10 AM CEST, Alistair Popple wrote:
> > On 2026-08-18 at 06:18 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> >> On Tue Aug 11, 2026 at 7:06 AM CEST, Alistair Popple wrote:
> >> > diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
> >> > index ea7665383644..2604e4d2698b 100644
> >> > --- a/include/uapi/drm/nova_drm.h
> >> > +++ b/include/uapi/drm/nova_drm.h
> >> > @@ -118,9 +118,34 @@ struct drm_nova_gem_info {
> >> >  	__u64 size;
> >> >  };
> >> >  
> >> > +/**
> >> > + * struct drm_nova_gpu_info - query DRM GPU info.
> >> > + */
> >> > +struct drm_nova_gpu_info {
> >> > +	/**
> >> > +	 * @size: The amount of space allocated by userspace for this structure.
> >> > +	 * The kernel will return the amount of data it did/could actually write.
> >> > +	 * User space can use this to determine how much of the struct is valid
> >> > +	 * when running against an older kernel.
> >> > +	 */
> >> > +	__u64 size;
> >> > +
> >> > +	/**
> >> > +	 * @chipid: GPU chip identifier. See &enum drm_nova_chipid for currently
> >> > +	 * known chip identifiers.
> >> > +	 */
> >> > +	__u32 chipid;
> 
> I think we now also want to add a field for the architecture now that chipid is
> considered opaque.

I don't think so - see my response to patch 3 but I think the architecture
decoding needs to stay in user-space.

> >> > +
> >> > +	/**
> >> > +	 * @pad: 32 bit padding, must be 0.
> >> > +	 */
> >> > +	__u32 pad;
> >> > +};
> >> 
> >> I think we should add the indirection we discussed in [1], i.e. have an
> >> indirection via
> >> 
> >> 	struct drm_nova_info {
> >> 		__u32 id;
> >> 		__u32 size;
> >> 		__u64 info;
> >> 		/* Revserved fields, just in case? */
> >> 	};
> >> 
> >> so we can easily add new info structures, or extend an existing one with a v2
> >> without having to create new ioctls for this purpose.
> >
> > Sorry, I should have called this difference out more explicitly.
> >
> > Basically I ended up doing it this way because it didn't make much sense to me
> > putting an ioctl interface within an ioctl interface when DRM ioctl handling
> > can already deal with matching numbers and truncating/extending the struct as
> > required. It just leads to more code comparing ID's, etc and I'm not really sure
> > what the advantage is. Are we concerned about running out of ioctls if we have
> > to add other types of info struct?
> >
> > Doing this as top-level ioctl makes the strace decoders simpler and means we can
> > just rely on the existing DRM ioctl handling to get everything right rather than
> > duplicating that in nova-drm. Or is there some other advantage to [1] that I've
> > missed that isn't solved here?
> 
> I don't think we are really concerned about running out of ioctls, but it seems
> cleaner and more self-contained than having N ioctls for different info structs
> and in the worst case having v2...vN info ioctls.

But isn't v2...vN info ioctls dealt with in the usual way by extending the
existing struct and bumping the size? That seems like a pretty clean and
self-contained API to me.

> It also allows us to define a new info type struct whenever we think something
> is a new logical info group. Making it per ioctl will always raise the question
> of "do we really need a new ioctl for this, can't we just fit it in X", which
> over time tends to get messy.

Doesn't that question also apply to adding GETPARAM N+1 though? If we're not
worried about running out of top-level ioctls I don't understand why they
are considered special enough to warrant the extra complexity of creating and
decoding a hiearchy of sub-ioctls.

> I think eventually we will have a bunch of different info categories. OpenRM
> seems to have quite some as well (not too many categories, but with lots of
> fields), Xe and amdgpu have even more categories.

Sure, we could just reserve a block of top-level ioctls for info though if we
really cared about them being grouped together numerically. I'm not sure why
keeping them group numerically really matters though, it's nice to have but I
don't think it warrants any extra code.

But perhaps seeing an actual user of this API would be helpful for this
discussion, I will aim to do a pull request to drm-test this week to
demonstrate.

 - Alistair

> > Thanks for looking.
> >
> >  - Alistair
> >
> >> 
> >> [1] https://lore.kernel.org/nova-gpu/DKC6T1DQX2L3.HTHPB2L167TC@kernel.org/
> >> 
> >> >  #define DRM_NOVA_GETPARAM		0x00
> >> >  #define DRM_NOVA_GEM_CREATE		0x01
> >> >  #define DRM_NOVA_GEM_INFO		0x02
> >> > +#define DRM_NOVA_GPU_INFO		0x03
> >> >  
> >> >  /* Note: this is an enum so that it can be resolved by Rust bindgen. */
> >> >  enum {
> >> > @@ -130,6 +155,8 @@ enum {
> >> >  						   struct drm_nova_gem_create),
> >> >  	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
> >> >  						   struct drm_nova_gem_info),
> >> > +	DRM_IOCTL_NOVA_GPU_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GPU_INFO,
> >> > +						   struct drm_nova_gpu_info),
> >> >  };
> >> >  
> >> >  #if defined(__cplusplus)
> >> > -- 
> >> > 2.54.0
> >> 
> 
