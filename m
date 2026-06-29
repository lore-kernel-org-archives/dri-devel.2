Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547A3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC0C10E76A;
	Mon, 29 Jun 2026 08:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nlOLv6xY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A33D10E76A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j676VRpvNPOZPHbUi/LngoQJ5lkYirZShixA2uslOfTSYgblHi0OThP6+0U1NsPUQL9lEajejkW6M4IhH6kUaaLgI3CyQ9KQIZPT9tQzBNvv0jbCeKdxeH0KcTFEAedd2CUqjJevZFv+9/9+CSkA8m4BW75im6y1Teojche+Fvz/eda44Lofe2Ig0utcn555Lwlb6wekchzcpIQBzF6aN21+fhJHwHsFHQSjXOsGRE0yFGMGgkAqN0ppy2+MMekhMEi+skR0GfdaR6kFjR4wZOflO2IDyi0Y0DxIDBhbgiK7Sdt5MA75xq+vlMd7JFp+k945YhF4zUnyjHKSfnmfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE9BPr18iekWpfpDI8LXOVBLcXwz+8wEKmyo4IS1Lh4=;
 b=TtM1/NltBUeiFQa9E54aCJlDtfNHsEYr+q7+k+qf0NmxkHsyh7gHzSiU+9Ri9viEBd+Oy7XJTs7F9wDdwQoKmX/yK+biYo6RS3jH+3FvJWbnxqnGraAOc0HiiOuDSASWvAB0k759ebwJbBAssOBbG7X3P25QlpinxwEtMv4hAUNPyi47dMOUtfr00c2rBluL9f/bCg5Ie1y+xg5FGh+KeDQ4d+3a6w8Qb2n6bgRB365NgmL9ETuyuCwwMgaWWoMUm5R4A/wZPB5RALKafI9ko2bt3x1c9gwM98lljSlysEklCGXG7pzZwq+NcGML169zaT9GWBpotVSZFmuu+4PLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE9BPr18iekWpfpDI8LXOVBLcXwz+8wEKmyo4IS1Lh4=;
 b=nlOLv6xYZU8cFneB75l2s5Ly+OB7636Ji5VLr4UonQYZdPB9h/lnYXdxb/+Ph2rzoE/x7ilEcwp8OebQwZZvCU3hy/aYV0xD7H2L0TG+y3Zaf0uSTrMPLTzlMs22WJFJDVjcWU26HpulcfwNX84G1TCZI36jflRC4wIqx6i/d2uzg5MC1CJ60K3s3St1GF5zzugL9gD47rxRrHbIEGBSym3xAF/FhQIsGL/yIIkUvSNIoEfBEK/6REIL5X4Fw8DZFTKC/xB+5ZP6+/W3rco49BvNcYB6oyczhz20ihfdpNLYWFN6Qa67rUp7g/TIoWVtphMwx0qXNHik4tpCC3oPkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:20:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:20:44 +0000
Date: Mon, 29 Jun 2026 18:20:38 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>, 
 engineer.jjhama@gmail.com, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 0/4] rust: dma: bridge zerocopy-derived types into
 the transmute byte-safety bound
Message-ID: <akIpejFWuKZ61n_v@nvdebian.thelocal>
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
 <DJLCLH7GDSBW.28J4PZW0FD60B@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJLCLH7GDSBW.28J4PZW0FD60B@nvidia.com>
X-ClientProxiedBy: SY4P282CA0018.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::28) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e5c3d4-ba81-4591-cc9c-08ded5b75064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|4143699003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K5cvsCvRbpOBSj7tS2a6o+6iGerXKoWjbhgU4BD4HMnWC/UC9D9Zr3x03o4LisNQsG8ezrEJ2Xx2/p+9S4jXDsFEw4mfS012/LRBF2UqJEz+NDwx1V/7I0YQboTQlgPMNre+hi+Znij6pSBd5A4RQ3tJta+t5lq+5TyPLikTsX/U0f1WKDHuCKpzbhB8Us9GNUufsBqNPYXxeXwyZrP0Rtv0MyCcoVOwmUirvGgp/PfRS1pVhkUzOsCEOAKi1gjsyEOrs3XTmB7lHTsmXnRlKxr9dm3CLxYRpFbdG7ORyQAeRHvcC3div/0+Lofh6OC5jZ7YM+KyoI9ouws2foMyT21rIH46cW/C2PCZHPJIVIxu5jixyx39B0d+Wj5gKjB5O2ma8CfbOt+SLDpA+qIbxkzzfRZfwnLoYkUWCtyC0Dednz7hFlyaChFjmS1VJ7N1oQ3I8+DSNBPSgwxXcYeHsQ3FIv4IswqNsXCtAv+P7MECYLB2/RnmLrdOyqLcqrwWsftVeJmGqZE7haylAJRxugafyy1jPIs+9WvAqy0jK/37lF8HAFyhk9OM+51Q1y1oNcqC651gRp9spC5TRIWpGJzUVbc63AJu3dlwPSaF9bDQOXGrIeL/8/RnS4yC1aBbA6E93pAnWjoLqkQk/s3oNjR5rBQmtZII0bfr4CeptWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(4143699003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FibKasfyZEsA4n0O5TRQFHprf9lnV3OIzNqjX2Yvfeow+CuDjRuohXzwU1Lb?=
 =?us-ascii?Q?URBtLvPtlojLYuMQdJhdj5aO83AA4NXsvTk2mPd5X9s4mTuQ3/WBsU1IQtYj?=
 =?us-ascii?Q?5NCrT1xcuxcwVCPXOuWfpDIP5WekI6eCw6i8sZpDN1n+eES6YPBu3TxU/jIb?=
 =?us-ascii?Q?SlBESyV4i5LIj8vhAhDJ5UiPkTL18PV3We1e0A9I8ojFn5N9/ZzTYYtEAMEy?=
 =?us-ascii?Q?JPjaCbJZPQsnBf1RKhX0rULm+cQIdVRsYi3lWHXvt/PHlLwGJA2n1nlfNKRz?=
 =?us-ascii?Q?TcNufHcsFrxUR/xCtzAZIuwCt84vRDaQIvpN5V8QhMjAIEDyI6VYPk++aiE8?=
 =?us-ascii?Q?8/PbagKZFrtLW70SKI2MBaF7ZVx6Dj7PoT3hLdhHji/V8+DzjhonSjm7vBYY?=
 =?us-ascii?Q?v6BwXw/m7ahuuqaG+uJNonc/Qa5s7KnStz+7cEhcDu8I1TnpzkaS3OkubJP8?=
 =?us-ascii?Q?awiiJXbB5ZaAYF9vqjHbg2TJiHE31EOMRlex+Id4Ca/FnB4I+zAJwPJn1Hid?=
 =?us-ascii?Q?K2o+1piJBlaSOlHLBJj/kqyJahHXTvbRNh3Qq10JqyYEVH2KtHqqQ4H6yB+C?=
 =?us-ascii?Q?jZhwnibPgDTkJR58snlS4k9PZSai4DxVoAia7wH827vrvdKFRsXEJn5W9A8h?=
 =?us-ascii?Q?A7Q0oaMzIscr2gC5tZFZs0W7JoFAEyfiLZQ1JO/tEcPf6GX84yJ0KczEH6e3?=
 =?us-ascii?Q?A9oPHKnx7mx/s+CZu2JQFraEtYRRuqcEYQtRpowDIPpkm/urYGnBj/aCD44C?=
 =?us-ascii?Q?VBBURz3fAAMipZsa+acCxXQrSSpN5PlQaujUZXFuDwRcPjxOAeV0y9kLy0Cq?=
 =?us-ascii?Q?iiy60883x5tmN7+/IfKxq0tHq9kEBbVRAYqkxuWCgbgi7VMjxXvAPjfp/5GX?=
 =?us-ascii?Q?n8X9M0hbrkiCHfg0r1jUe64AEfU9R03PkTxFQF+W3vvQOqsfuzpID/oxrIoo?=
 =?us-ascii?Q?pDyrzGUgYQCvOEW7nrLc3zuYwzZqy4+BQxMZzLAzHPECt9fo6sRQJu5nxlXM?=
 =?us-ascii?Q?tuPjQn8qpq0TLRO4uEulLHPTXiELQszffx93sysfGlS7t5khL/LMN4x8DbNO?=
 =?us-ascii?Q?EW7oWbpzW3y/NOcpG+Q4qFvCCMPzCT8W5LMFe5UBEXzDtheab50FH+15R6SU?=
 =?us-ascii?Q?BvwwfmrAb6/sl5W9bh+mIR6JLvaLiffK+f0ItRpl2R3OUPVCQ8U/xrXe77jE?=
 =?us-ascii?Q?w3MUvyOOwIksTEHc4F8WLSVe3V2UI+WlqnkrxikTPggMp5hu5EeWZcpJJRmA?=
 =?us-ascii?Q?kA1vHxZImWq9PTDwS6t5WoldzrDBTeDLqfT+ofr5J7BGB8GcwayGm+OMIbxk?=
 =?us-ascii?Q?BvkKHQzY3xtihcsQH0s6cJIQPdQtnls6gwuYImWCssovFx4Ao2Gm7HuEOQfo?=
 =?us-ascii?Q?A6ZJypmI2i6IeQNGSjxyMTVIEmamyYQtDqSf0nCtOpK24zrTs9y6aRrBbxCG?=
 =?us-ascii?Q?Op4G3MlGH/cl8csdf0K61aByuc1PX6XQlV18YW3xlJ+3sqchiSOJuZYRmdI5?=
 =?us-ascii?Q?6acAs1r5aF/m3IZpsLfmBxcy0tH54EJaS4KW2EHicn6ytlD6NbwvQpIbg+Cq?=
 =?us-ascii?Q?F7DXFWHXAlEHxKmm9Ax6laE4V2Zh/Dxr+etzwnEygFsXX7LVPSeQkqvi4gwW?=
 =?us-ascii?Q?Rx1oGDxKo4DttOjnatVE5+ipLkrgUTq7TNSg9iB7F9sgZtP6kB1PRVcmv6Zq?=
 =?us-ascii?Q?FYlISLLui3hF+Bl8jg0KukzLLoVDmWEYwedbpi4PTrP/R6ptaxmi3hw9YlVi?=
 =?us-ascii?Q?GGQyDRCiNw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e5c3d4-ba81-4591-cc9c-08ded5b75064
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:20:43.9379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Wk4pdhLcJTbLix7X3Sx5prp1fBzSHJWBwHNq9o0k/ddm9tvLwZDmUYJ600HeqqP0wisflzTz9Er/VYMFJBrcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

On 2026-06-29 at 17:17 +1000, Alexandre Courbot <acourbot@nvidia.com> wrote...
> On Mon Jun 29, 2026 at 2:10 AM JST, SeungJong Ha via B4 Relay wrote:
> > DMA-coherent allocations (CoherentAllocation/Coherent/dma::Pool) bound
> > their element type on kernel::transmute::{AsBytes, FromBytes}. This RFC
> > lets a type satisfy that bound by deriving zerocopy's byte-safety traits
> > instead of a hand-written unsafe impl.
> >
> > The bound cannot be switched to zerocopy wholesale (some DMA structs are
> > unions that IntoBytes cannot derive), and a blanket bridge impl is
> > rejected by coherence. So the series bridges the two per type:
> >
> >   1. add the bridge macro impl_transmute_via_zerocopy!, which emits the
> >      transmute impls only for a zerocopy-derived type.
> >   2. re-export zerocopy::Immutable from the prelude.
> >   3-4. worked example: convert nova-core's GspMem and msgq POD types.
> 
> Can you give more details about what the macro is for? My understanding
> is that it is a temporary fix for the generated bindings; if so, I'd
> prefer to apply a definitive solution (like using
> `#[derive(zerocopy_derive::most_traits)]`, or updating the bindings
> generator tool) rather than something that will be removed later.

I think the context is in the description for patch 1. It's not directly related
to the bindings generator. Basically the problem is that these bindings are a
little bit unique in that we access them using the dma_write/read macros. In
other words we use these with Dma::Coherent which still requires the transmute
rather than zerocopy trait bounds to be implemented.

That said I think the correct long-term fix here would be to fix Dma::Coherent
to make it work with the zerocopy traits. Not sure if anyone is looking at that
or not.

 - Alistair

> I also notice that the macro is in the Rust `transmute` module, but the
> only user is Nova; so it should have been either be Nova-local, or used
> by other Rust modules.
> 
> But intuitively I'd say that we can (and should) probably do without
> this intermediate step. But please let me know if there is something I
> missed.
> 
