Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61D6C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 05:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2895010E181;
	Fri, 21 Aug 2026 05:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XKf/LBMg";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A87610E181
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 05:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlMoQ6qLnTKjopQc/0tm3A5DBTRSLZXMI4oe3bxuyZ6bCYbYVjlW+OA/epua7eDWLqFyxCbuXSzf+T9aLPK5odNGy1vt+Ngb5UhmboJaEHcBUY1n9YIWa1zQGxUIhgv/sIuQZwq5cOmh+hz3YcuwOMMIyWqnKmy1N62QDyg2mEwdgWR2ZNiXX8XNnG9kbhCL2WqVWeqehwv8TIOFdYOUthGH2cHWZoS83rs01qxrWzlp2Hja29EyNPjwob9mNdZ5h4VlxdXsXoIUfyuSaCZQI6QMbIXSJtzaSZGg243T/s0dkHOFgISUbzdPxGI5qTvOKMdsqNc8zEKOZQTmG6LKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmF+0Ljibdx6S/svzEImHEcvIiv8knej2s5A/krR7w0=;
 b=fU/4As6fNHNsz2eeUV3hsdxHocWulsSIBjavj7rwpGUgcpmMTFBcyR0gm0uVsLRPT7Q9N0HZmBNz/x5ClJ/BpTGt9Hvn8KMZRAZWA1JaOXNNeTiD4BTPm6OLyUPeORWXqKUjbju7FplTLHfovmNAF54Qvqrikn7qa3PWx64F/OKRu6mcU2pUU9qs2iVUAyfrlvMSD7q2Puei2zzrJNsl8LsUEF1lOJa2QDCEn9ARE73Zt341/gteIDm26is5mLBOPP5GwZ+lGMNGmAMdtPDRcDEEV8XLFuLCpji+EwIhbddDcatTye1ASPZorj+jLKP0hDbHjg0O5yX0fndlKdnUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmF+0Ljibdx6S/svzEImHEcvIiv8knej2s5A/krR7w0=;
 b=XKf/LBMgnNYSuDTDE1sUuY2v2CIYgAYshaExT42wK0UM9ImPQERsNwM/EJfHHIUq56nfSTVfMUj3V/cnAKkP6QXQb0SVnz/fY6xwypBeDFj9QuRdY2kv6UIrqNl0sJ0qZ62mAtCk+tInrv4bNa83+Wv/jaPuJQNNtxbM1Ls9wm1pQoMp5pTR1WmsVu3M0uh2V3bofT5zqB+u2wLneUcwOsXy9qO+SLmMJXdSonWJHvXgGPUX9PGfxTCxbl45xgvyuifYsPqh0A0/n9f3abwohUa8j1JBSpC+WBmF0+7M0vjCSNYQxBKoQCubK9E4cgUXN/Upvm8bGdxNljf+VNiOpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Fri, 21 Aug 2026 05:10:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 05:10:07 +0000
Date: Fri, 21 Aug 2026 15:10:01 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
Message-ID: <aofWfMSZtV-bNYrr@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
 <DKRHW6G6P4K5.15H1A4DGR6672@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKRHW6G6P4K5.15H1A4DGR6672@kernel.org>
X-ClientProxiedBy: SY5P282CA0180.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::29) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbdabb1-d6a3-4f37-e673-08deff427763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: /nmQH13YTI1D6mwnhbbvb2Yc8usw5B94sNgvCSKZdYFPLyqD8cbm0kzEhFAp9eZddrVPSStjQcaxnOZiUIFxnalELS0QmtsMHMWZo8rPExQP9wdn5rvZRZ8KgLowedafrw6Qbl+mmIldLC56ql51DJC0ZpNoPsaq2c3evW5yYdrroCFFEVdstf0SjsuuNbeJjgikdies/6AJBt0kUIWP6tZ9kNstUK0ienUbfHedIZP1CO8YWxf80WMSxMTwzzlRGgIJkV/bUskIP+lCVqpK5SLgM+wBnQ5kVuavg/mpzOHWwSFXFZOfCkrMh/RbCFmDqv2k/Noz7O8izq+KGUTLymmtFekWYRzFS8dHVDnnJGiI1HPbbd6p3FlpOF3ZGqs42kUqDz5CT7Urh9sntoBg+SEbAGGlNEQ53FUD6DhVqmgGPShRQr1uPhBZGpN5fS9L7jdV7U2Qi2zPlzC7hVMKjVdMxIcB5D+uRhYlIO7/dcjrUo6O6fm1he3uw7qGVEt6wOm3xzG5GafdY1F7l8gpwBA8nb+jQ8VlPSiTnXlXDyGqB/5Qhy5Kn70vSfOGMs91aA21TzHMR5r8dvFV5WLYTuifeHzz4JtrTXGonf2HLQKW5pr0LU9yo5VAsOhHgNTpGjJ4g/SBWpOf4t97e92BuQjcnrJN9AC7hVYNTRCLdPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VW3wKKF2gWbTK97Q4CX66kjh8qIrlw5uHdhsY2Ks1CrPLhyccyaoN3SekZ4S?=
 =?us-ascii?Q?FjsJqbMqDet++ttBOT2mAIC3sj2oGpPucPscbc99oFs2b93ZhFMOJ0oP1Q/l?=
 =?us-ascii?Q?blw73a3sihe5muQt1+JWh+wjUZYXQSQU+e5YEpfUUlzQWWs2aYoGUUx8uCTM?=
 =?us-ascii?Q?7j2ogVaABsSwXpnpc1r4vAKT8BuzV52IAhW+ydjCJ8WzkwO08U9h9OyikbCu?=
 =?us-ascii?Q?eCoj9F13zaHOd74l66xQhbpNzfvAcT7qFZeDUncZF0WKIJJTb2M8hhCN5SRp?=
 =?us-ascii?Q?JTTIEOBJcthCNya/HkUIFhEqJ5t+crngdSW9q336WvoaM+KDSnQZuNP36b10?=
 =?us-ascii?Q?rKZGu6f4fxC4fkhBy6qwN8YBwc0rQQHgaBnYwY1Q2Pd3vJAN9fHjYKzOewZW?=
 =?us-ascii?Q?WMZD1/9IpjuGuM7dwdHFrmhg6T7F1GTrA1oLAl9jghd2u+bs35+ONTswOWyA?=
 =?us-ascii?Q?CFWEwq3Qp8ukEfT3x4p/fzoN5mmWYDzXDltjZ7QdOaj0djN4OeXnFrqCe/2x?=
 =?us-ascii?Q?S4GA8yTzQym2INe/vS73Fw98YkxZmD7D/HjNiirOAmLY6342hCJIJUjhSwwY?=
 =?us-ascii?Q?4pM2tJa+KODoGCz9RmS91A7Aq5t1Fr0hohZq5g5rlb+f/f5NV+0IQp5IjEOR?=
 =?us-ascii?Q?Cmpwy30Pp/Gi4V2EJLN50WIoMuvzfL39GgnqA7MQgDjoqfWFU8S+b6PL7kDX?=
 =?us-ascii?Q?lgIlSAIpI2Pwvj3yIIwLvCyB2q3wCPz34QI9/BpfF+WM8RbFCmv/B6Ch+cAf?=
 =?us-ascii?Q?PuyGelFhf+rIV/GuWsqGdfIaEsqN7gar/Zp+w1M5xrHy523+X7MTTQ1FHYDv?=
 =?us-ascii?Q?XSLAujiJDAh2nRXoTy/Wco9uIL3xq/wkZguqTaYRO06sWS1YvxhZ7vmEFP5A?=
 =?us-ascii?Q?g4tfxhvsW0ZpjiDQrKFVH2tGFyt4UCfwjvU91cAjrgJcfpkVgbesWsdKmeNn?=
 =?us-ascii?Q?H/KcUCEbh3l2BAJ4xHFrZo/Az6UO+JY3jW0uN/zyuFVHUopv821yr4WGi74S?=
 =?us-ascii?Q?ehh3UXZt/M1gVfrEB+2b8VkLmfdukyMnFrucpfsZouaJYsNEFj6j+s1PKBH6?=
 =?us-ascii?Q?vFMRhdEfi08Gzr44ValdGr/5TSx/wCdN1dhj/4XcgV+uDzKywd32sAbD+S1n?=
 =?us-ascii?Q?gxjIrGVrjNLuesXaCoW889uUBpjeufP1HDuN15XY0Bi8EOgXEVBehWjzJ+19?=
 =?us-ascii?Q?F1krW1vV0MxStmZld3YoIHNJ/etXzg31HHG+5l34P142EnZ3qKdCBT5T2WC2?=
 =?us-ascii?Q?wYESf4nIx16xQLQr6hccR9h0F0EUxxVtNZrbc0tkJkiDGa6mv8TR00ZZ6Ean?=
 =?us-ascii?Q?miOgTmkAHR0ij0YoMcU+LiVPZlfpI+2KnwmIBNGbRc8AX+zayWpBy8xi75yD?=
 =?us-ascii?Q?s1+8lVe5O0bU9B9vuyWc3W9bFjvMtc7zclO6a3b0OoKwzI9NWAl8/4E8VIF1?=
 =?us-ascii?Q?nk3vlqozzDRh/aOUOoYcn8vhIVTUgUunG5B73+WjeIjMCiKx8KlqcHFDg5fH?=
 =?us-ascii?Q?8ZJUfJ8d5iQk+mEF3hh6iwAfI2uoRc6KNLFgaB/8a57R5Ihq/x+0U/4uIeVT?=
 =?us-ascii?Q?bAOF9OGGh1aHSbuidcTPPlIKME9Q9XIfBn+wKGa36on56RAQuQnV/l+fh2e7?=
 =?us-ascii?Q?Ctw+Ru+avvUPlxkfmlv+73JGorszt9dwNJ5rgu5IVD+i22HdyQ4dgcxz59mI?=
 =?us-ascii?Q?/HZaMU4JtPe+EWfjcpjl1UhZZ1aD/3kctNd7a7cyG+fLVElek9yPohBewIUd?=
 =?us-ascii?Q?kdZn/NJ6IQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbdabb1-d6a3-4f37-e673-08deff427763
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:10:07.1733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+kQ7ohI4mAuYIVAohPI7F3ZxLeDjiljz44tzI/Qs+Ov5XKwQ6sVMeZd8vTpbBbLhfZ0frywzcJkNXVsOp4JHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

On 2026-08-18 at 06:18 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Tue Aug 11, 2026 at 7:06 AM CEST, Alistair Popple wrote:
> > diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
> > index ea7665383644..2604e4d2698b 100644
> > --- a/include/uapi/drm/nova_drm.h
> > +++ b/include/uapi/drm/nova_drm.h
> > @@ -118,9 +118,34 @@ struct drm_nova_gem_info {
> >  	__u64 size;
> >  };
> >  
> > +/**
> > + * struct drm_nova_gpu_info - query DRM GPU info.
> > + */
> > +struct drm_nova_gpu_info {
> > +	/**
> > +	 * @size: The amount of space allocated by userspace for this structure.
> > +	 * The kernel will return the amount of data it did/could actually write.
> > +	 * User space can use this to determine how much of the struct is valid
> > +	 * when running against an older kernel.
> > +	 */
> > +	__u64 size;
> > +
> > +	/**
> > +	 * @chipid: GPU chip identifier. See &enum drm_nova_chipid for currently
> > +	 * known chip identifiers.
> > +	 */
> > +	__u32 chipid;
> > +
> > +	/**
> > +	 * @pad: 32 bit padding, must be 0.
> > +	 */
> > +	__u32 pad;
> > +};
> 
> I think we should add the indirection we discussed in [1], i.e. have an
> indirection via
> 
> 	struct drm_nova_info {
> 		__u32 id;
> 		__u32 size;
> 		__u64 info;
> 		/* Revserved fields, just in case? */
> 	};
> 
> so we can easily add new info structures, or extend an existing one with a v2
> without having to create new ioctls for this purpose.

Sorry, I should have called this difference out more explicitly.

Basically I ended up doing it this way because it didn't make much sense to me
putting an ioctl interface within an ioctl interface when DRM ioctl handling
can already deal with matching numbers and truncating/extending the struct as
required. It just leads to more code comparing ID's, etc and I'm not really sure
what the advantage is. Are we concerned about running out of ioctls if we have
to add other types of info struct?

Doing this as top-level ioctl makes the strace decoders simpler and means we can
just rely on the existing DRM ioctl handling to get everything right rather than
duplicating that in nova-drm. Or is there some other advantage to [1] that I've
missed that isn't solved here?

Thanks for looking.

 - Alistair

> 
> [1] https://lore.kernel.org/nova-gpu/DKC6T1DQX2L3.HTHPB2L167TC@kernel.org/
> 
> >  #define DRM_NOVA_GETPARAM		0x00
> >  #define DRM_NOVA_GEM_CREATE		0x01
> >  #define DRM_NOVA_GEM_INFO		0x02
> > +#define DRM_NOVA_GPU_INFO		0x03
> >  
> >  /* Note: this is an enum so that it can be resolved by Rust bindgen. */
> >  enum {
> > @@ -130,6 +155,8 @@ enum {
> >  						   struct drm_nova_gem_create),
> >  	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
> >  						   struct drm_nova_gem_info),
> > +	DRM_IOCTL_NOVA_GPU_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GPU_INFO,
> > +						   struct drm_nova_gpu_info),
> >  };
> >  
> >  #if defined(__cplusplus)
> > -- 
> > 2.54.0
> 
