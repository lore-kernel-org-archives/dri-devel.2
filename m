Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEFEC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999AC10E763;
	Mon, 17 Aug 2026 11:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GyOq1L8d";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A6510E763;
 Mon, 17 Aug 2026 11:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezav2Zqre/bNo/8cxSqf0CuUV9N+W4Reg31yP4RnmOQ6sMY8k9T8Y/55l6+8T/FPekA2WsZVG35q0SnGXP9+vyH6la0rcJrPWUS8plEd8terPgPPalpmXlXepb1DW/xLKcOykQsm7CBc9Afw+gsfDVV8TewRNQ3iSRGGFVdu/R9wCjHcYnytrokJyf7rxMfP4R9Y9q0aShEY7nDXB6vQg2M/vINc0iyf8blL3pgGG8S3dgg3dkHVEeR2zfKLDcBNv7pSsn1+1hp1eN7vIbIGy7e67cXXNvn1kKxoLYftgeAbe50sRVIY/CxLQ/rDopVx27pEKrg16FnHdqZehu8mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI1SIZqkmxEiWe6gMNKkxii7AynElJeFBwZwekDt4Uo=;
 b=KF/8+MFqrBATAQfNkd1MigGJbCag/hTyr1cbh7RZDgXAZzuhyir0jxkKFDtAgIlF0KCVBmTChUq0D4+GAcmAGHYKXpKNji7jGtglRHWwxL27s/UMwtZ5OCt35PQd0yiYdzWLVNP0M6Q2BXEtGwio7KYkTjMLX0b81NLT0N9JoR+qn/RCyrigD5VjbzqM+t7J2uWwK8AXz//XiDguzw+rP3qRB1L8dC/7Z5NDSHTid4qi3+v07A8iQOB8QffBCefrqhhTdKrx7BJQvznlF8Kvx+Cuz9tVFINgidbIHPJ89J42h3H9YG7tnEPzUb/Qnse80W683gnO0RzrnXiP3H5Ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI1SIZqkmxEiWe6gMNKkxii7AynElJeFBwZwekDt4Uo=;
 b=GyOq1L8dmEl4WBl4PrODi9nfmfEuK+h3/Et0GyYDiIEkFlQxQQkqNr/lOgp5GLvJgb9yuOxSxo2tYXZWUrCC5W1BeJA14rh1vhx/1PcC6x9uHOnUNDHqAatZYTGL8W0TRqKZuZjvKfdoHS7SUhKdpymrhOstYF6VqRD+RTDzgMNcCUV572HIKRSn5qQ3Cj2cyY3vxf9eO87A95gjbWbH1bJDT3U+d9ssM/Cv9cpJTylQdaax/oo3/zIV02Ex77ZgaepyybIJlRBLlif/fSiB25bICr3t91l81fy4gAE/1Y1e7H+db/XxuV64AhrRC6jLh28YLeBQrDp9OVP6/jmLAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 11:41:45 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 11:41:45 +0000
Date: Mon, 17 Aug 2026 21:41:39 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, John Hubbard <jhubbard@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 04/12] gpu: nova-core: mm: Add VramAddress type
Message-ID: <aoLxGqKx8h54MtES@nvdebian.thelocal>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-4-65a00b3c7309@nvidia.com>
 <aoKfPchpfmTVguQf@nvdebian.thelocal>
 <DKR2MD987IX1.11I18NM3UNVQO@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKR2MD987IX1.11I18NM3UNVQO@nvidia.com>
X-ClientProxiedBy: SY5P282CA0060.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 03330090-290f-4d7f-7c93-08defc548384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|3023799007|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jwDJ72bqSx51JUJHRcJEVkF/58KIprhjKMzw5qaCHa+69fsnp3LAGV3Jp7qYC7RjpxLEzoFz7Pe9L6RdgDO0aNntKB6bgrH6hBPiwvs8brEjAr1JHElYuZXbWkTdeGwz42hAJLW8lnUV3+J5U9moL9Ll3iZKml03llg81lOgYGyQUuHzuwaGTJU+4FFrVOaASU2potN7eH4JFqykHwdZjuAAR9CFd9DLzRfah8K5+Pb/eANdetNO4OMEataJS+7u7vIi8vvSTnrZalSS/OTccbvrQwbdnlOfUr2HYqrtiZ1Hh35CV/ZY3MOOc6rIXdaHnWRlO54gMoldGJ03MQ3EwCOtkOoCihBDhV2a5lafyyXObo8je5Zc4yp85lrvkxzG9jJr2MhZ4bLHIkfkfxF5zgdS1AVaCgfvicp+pZgTpRgnCQuPtJps4kuvi7QBCvtYGd93ykIWuWSGnboe0qtZgip44+iMW+f3sRWC46/257Ri6dDjXXL0D5r0pdM9VgasK2GMXtT99O0qOLmk+fTEbO9+KSyOxJI05QQIgSxgcXqGD3gjjjWWU0EKJJuB4DEFd54ttt2G47s8Q7+YGDF9NhSPB2/C6TvDVtSmuE3I7rOReDK0FobOoWxJwfReCWSVtSW2VyimEcTiWCVnEBQ8Um6Yr2MyR3OA/6mXfqYCZ8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbkB9c435tL5qR/vuyJUJk1GAXydo0fUeP4JyIxR72scUvBrJp169xPmjO/u?=
 =?us-ascii?Q?WW+2BebYkopx1Gd+eC2ld7aG3H4w7BfGwSgm3FgG9Uaz7mm7ttzCUXbXJGof?=
 =?us-ascii?Q?vbJAUGbCkTNto3PMQTxPtTn6QgYEOubZ639poFMTQluMhvQStH9QiPejHZi5?=
 =?us-ascii?Q?CP36VH5NhNxDndTuwyU0ynCDQUphjU7kYUBNnuGnYHf95yhJ4kpz8xAtsCfM?=
 =?us-ascii?Q?dvqjyHa3Xozop3WrKwsBwbl0GIe4PEtg92hu31qo9tO1UsuB0EHu1DnOIfY2?=
 =?us-ascii?Q?y39yuFwi9UQ0RyaIy/vWlbuw3HfU7Tie7IenCcd7IyriCn0ZT2EaMUVvWJPA?=
 =?us-ascii?Q?SGrgeF7mShe4BaoYGtydZlqHZ4PeOTnHT21yelUcu5Vs47u0pNFuFB3EGqQS?=
 =?us-ascii?Q?Vz6r1gQa7xTorYTRkHHvYg929qittJcbhjObFNLIO3/0vfrTqhj3qev9VAFS?=
 =?us-ascii?Q?mhi3A4LwdnEuuomMo51oqkMeYCx8neZwOAT1S2tGLmXqnk9l6+9KpAzygXWm?=
 =?us-ascii?Q?HepcbkNpE5bsRZVbEbvtwyzy/tVp5SS4rZ3aqYAaxRuGlhso8SQYI8iJhZo7?=
 =?us-ascii?Q?QE2QuwGh2NnD03rw0zkWRRnNkvUxzG+DaaaBmaciwSXtBdESp1g3R3uslFRg?=
 =?us-ascii?Q?m04sifZnvYFQvt4zGFhZ7fg7N1QKlNCWgXBs4HQh2Dq+Stbmkf/j9AGSarMu?=
 =?us-ascii?Q?ZSQtEIGplyotacoa9RMr9FJKV5Likw86tJmmBwLovYdnXZEF4lEfu9igOyhV?=
 =?us-ascii?Q?jAegxYSPUhotrww6z4ksG+vrgv3kW8AU1UPIams7b06H58zhg6iN2jeGY+Dc?=
 =?us-ascii?Q?lIg4t6lZqipoJzDjSl9Y6wWT9n05tW4em3qNbb1SB94adpn5ETjIYq1L4EWL?=
 =?us-ascii?Q?1f00pEvA9LoJUrr3KZF805O1WqyHCAl3xcvn5LCk6MbTDdPM5+qhzdjYs4vW?=
 =?us-ascii?Q?TFUvdg5ahLtA6u0v9qPE0ip0+pxqZWDlRLFIvThKwFsYFUVoHnZEbF4h9MiF?=
 =?us-ascii?Q?l+drTMpYvE+vipLME4E5RpKVR51Nl+ILqRhojsl4Qzqa3pKBywENaFUd6tA1?=
 =?us-ascii?Q?xPVvC+wybcA4rKvSXYg41QWH+O/be268Q8Ry+oqIOQRO8438LMamM7tATwV6?=
 =?us-ascii?Q?f+X9n1BSNuy24hZSgl0Hfcz/5JBZY1FiqUyWmnPVtz1RTFW0c0pVCVVXPj6r?=
 =?us-ascii?Q?XA1AanV8vTyPoqx7Y3iUY8dB027yAZulnR/gaWmzUsv1xNEz9iApjnhW2tP3?=
 =?us-ascii?Q?hmPZVVbrOG/a7IiZiFXCLE4jP+eNArkdghYYqlZoLUHLvP7cvmFzcMTxdkv2?=
 =?us-ascii?Q?R0VdhzKvKvqw8m9E2T9SsdOk7R2hDYXHxk2ZdzxDBcfDLxOeTT+OnpB+J79z?=
 =?us-ascii?Q?Sori3FJQgvo0mIv3uh6LS74WSDnX4BuZOhEMBDOuWBTqplLCxla2A+B69rRL?=
 =?us-ascii?Q?uoFm026IMr2nKm/DWgpgWZegZ6VEs7Tz+CGeCzpenDNoFAyLA0wbdQ9ut1uj?=
 =?us-ascii?Q?nQmXHLFzgIW5FwI5p6VKziPJc7B+pT9Im+ilqWC1zHc94U1zqS71KLt2+eqE?=
 =?us-ascii?Q?wgobvH6cef/+d9dzj7TxPeF9XO8OVMZkgbZXm3rUUWLw/Cgn+CO+BVofQNRE?=
 =?us-ascii?Q?yx90qS1oHcJyy4Tt4clFwWFEpFcTY6Q/hyzQe9pcHpCYvRv+mY6X7pdyNIFq?=
 =?us-ascii?Q?QTkP3TfBEIKjwfZoA1X1wkCi7kcst+RdLm+ru9RhJeg6eBv1WVizygHbjR2t?=
 =?us-ascii?Q?MqS6uOgdSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03330090-290f-4d7f-7c93-08defc548384
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 11:41:45.0473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCYgnU42pErbxwzBnBvfkAOqVn7g4TgeahzNqIy1wAikJNqa1QC8Xm18jwbikhnsVvEAUDVnBNWkq7PBFAwutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

On 2026-08-17 at 18:20 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> On Mon Aug 17, 2026 at 3:00 PM JST, Alistair Popple wrote:
> > On 2026-08-10 at 23:55 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> >> From: Joel Fernandes <joelagnelf@nvidia.com>
> >> 
> >> Add the `VramAddress` type representing a physical address in VRAM. Also
> >> add an arithmetic helper, comparison, and operator overloads which are
> >> required in later patches for address arithmetic.
> >> 
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> [ecourtney: create mm.rs here, squashing in the arithmetic patch]
> >> [ecourtney: splice the two commit bodies]
> >> [ecourtney: drop the Pfn fields, open-coding what bitfield! generated]
> >> [ecourtney: drop align_down and the IntoVramOffset/IntoVramRange traits]
> >> [ecourtney: make checked_add() const over a plain u64, derive the ordering]
> >> [ecourtney: doc wording, header, import, and signature cleanups]
> >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >> ---
> >>  drivers/gpu/nova-core/mm.rs        | 60 ++++++++++++++++++++++++++++++++++++++
> >>  drivers/gpu/nova-core/nova_core.rs |  1 +
> >>  2 files changed, 61 insertions(+)
> >> 
> >> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> >> new file mode 100644
> >> index 000000000000..dcd5e5e919bf
> >> --- /dev/null
> >> +++ b/drivers/gpu/nova-core/mm.rs
> >> @@ -0,0 +1,60 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> >> +
> >> +//! Memory management subsystems.
> >> +
> >> +#![expect(dead_code)]
> >> +
> >> +use core::{
> >> +    fmt::LowerHex,
> >> +    ops, //
> >> +};
> >> +
> >> +use kernel::fmt;
> >> +
> >> +/// Physical VRAM address in GPU video memory.
> >> +#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
> >> +#[repr(transparent)]
> >> +pub(crate) struct VramAddress(u64);
> >
> > Is this the best type here, or should this be bounded via runtime checking to
> > ensure it refers to a valid address?
> >
> > I was going to ask if it should be bounded to reflect the physical addressing
> > capabilities of the GPU in question, but that would actually need to be a
> > different type as GPU physical addresses might not even refer to local vidmem.
> >
> > Although I think that's a concern for future series - AFAIK PRAMIN can only
> > access local VRAM.
> 
> Yeah good question. I am looking at memory management stuff after this,
> and e.g. how many bits the hardware actually accept for physical
> addresses (e.g. page table structures) is different depending on the
> hardware. So it's not trivial to determine if the address is valid
> without a bunch of extra info.
> 
> So the approach here IMO is just to tag it as a general VRAM address at
> the type level and gradually apply runtime checks to narrow the type
> into code that is more specific. Since our HALs use dynamic dispatch
> based on the chipid we can't avoid some kind of runtime checks here
> anyway.
> 
> I think it makes sense to say VramAddress is a local vidmem address, and
> later we could e.g. add an enum to distinguish local vidmem, sysmem,
> peer memory etc. This appears to be essentially what UVM does
> (uvm_gpu_phys_address_t), AFAICT. What do you think?

Yeah, after reading the rest of the series I think this is where I landed as
well - VramAddress as a local vidmem address that we use as one component when
building up the more complicated physical address. As much as anything though
just wanted to check we weren't accidentally conflating this with physical
addressing which is more complicated than just VramAddress.

Also seeing as you've obviously been looking at UVM source it's worth noting
that UVM's physical address type is not exhaustive either as it currently only
deals with some aspects of physical memory addressing and leaves the rest to RM.

> And yeah I believe PRAMIN can only access local VRAM and sysmem (on pre
> hopper).
> 
> >
> >> +
> >> +impl VramAddress {
> >> +    /// Creates an address from a raw value.
> >> +    pub(crate) const fn from_raw(addr: u64) -> Self {
> >> +        Self(addr)
> >> +    }
> >> +
> >> +    /// Returns the address as a raw value.
> >> +    pub(crate) const fn into_raw(self) -> u64 {
> >> +        self.0
> >> +    }
> >> +
> >> +    /// Adds `rhs` to this address, returning [`None`] on overflow.
> >> +    pub(crate) const fn checked_add(self, rhs: u64) -> Option<Self> {
> >> +        match self.into_raw().checked_add(rhs) {
> >> +            Some(addr) => Some(Self::from_raw(addr)),
> >> +            None => None,
> >> +        }
> >> +    }
> >> +}
> >> +
> >> +impl LowerHex for VramAddress {
> >> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> >> +        LowerHex::fmt(&self.into_raw(), f)
> >> +    }
> >> +}
> >> +
> >> +impl ops::Add<u64> for VramAddress {
> >> +    type Output = Self;
> >> +
> >> +    fn add(self, rhs: u64) -> Self::Output {
> >> +        Self::from_raw(self.into_raw() + rhs)
> >> +    }
> >> +}
> >> +
> >> +impl ops::Sub for VramAddress {
> >> +    type Output = u64;
> >> +
> >> +    fn sub(self, rhs: Self) -> Self::Output {
> >> +        self.into_raw() - rhs.into_raw()
> >> +    }
> >> +}
> >> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
> >> index 35a8b1214b0e..8f59cfa97017 100644
> >> --- a/drivers/gpu/nova-core/nova_core.rs
> >> +++ b/drivers/gpu/nova-core/nova_core.rs
> >> @@ -18,6 +18,7 @@
> >>  mod gpu;
> >>  mod gsp;
> >>  mod mctp;
> >> +mod mm;
> >>  #[macro_use]
> >>  mod num;
> >>  mod regs;
> >> 
> >> -- 
> >> 2.55.0
> >> 
> 
