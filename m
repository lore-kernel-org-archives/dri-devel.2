Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00161F8A160
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B4C10E1D6;
	Thu, 16 Apr 2026 12:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VtCoqAg/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B8710E1D6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 12:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEKD2kdH1wDjG/2/r7lB1825CajH1MiHPBubVIqGR14/tS1830xF9PBsHd4yJf9sIQmbYznvrTlflKra7lCOalUA8m0Nf9QqzqeqT7Lj537iRGlbSg3CCskQwKMpKsGQy18INOSL0u4T7phaFrbKoQL1+c6yooLD0ELKgVnDKIxCZXHXhdQVCbiGJ4jyyWqPk7t2RwQtEFH62+oBk0g0eJ2FOQLwfuFVCO2Cx0CKXorIHYodJ0irA+ekwyk4LbOfLNyGO9oQsDAJx9POnAzIiiR+6YQxG7z8j63LGQ0VHW7eUPl9UP0XeXexiJO/daVjzlKSbU4tdGbNKL4QZz0cNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slNv6PaTjW7QBV8QngoYVB4rTeC0+uDsVZv9wQG7Q1k=;
 b=NkGsUM/9h2itysMqTfSimXUYdXrYovItJ0t6wp6pcglxk3CTxQskV/c+L34xr4109HM8SSYHnaBRQnqRaSNXglvpzll7EuHGi19fa96rszkAiFl9SC5qd8LvcLtseKfV+AncUJkEe4It5+k/p9vnmQak9/vCUyxWVWddak8EmHoeRvFgleZY0XdEbzFULebIzVLXbNq556YQFUtbvVa4CwFhot3lokL/Jspvwker0DnoqvAp8A3PJ/SBdJcggFZqWbr7RuJBrJEQ64aYuRUISLB0o9y7A3vxT/IEAmoltYAF83jVOg/zUzBquv2THMx1ODIcCLF8khoIjBM5ZRvgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slNv6PaTjW7QBV8QngoYVB4rTeC0+uDsVZv9wQG7Q1k=;
 b=VtCoqAg/ag0CvzzMlD7Yh4Ia6EqhnLGwCkTLgZJpC3NKJP16JHucRmVlfzbWHYhsfZzmeaY3wzpXBM9+sbRVqELqBQJFzP617uF/pmaCr2eR/5Pi67kgoNu7IUWnYMOZWH9L02+dCZFm2p3GXj82GcXnmPwlnhWC8isCh530JWu8n0/KHblwhD7XLSzjVlPMj56qQivx7SAIbkORD9pBVn5xlCe5HVgNTurE2qZ4b+BsjxAYt1bin5ltr6KV4wTs9AKTskodU5djUuQ/vYU/1aCzhIm8/y8/j1hYMjIPQ2LIOStzUaOtJ/p2iYbd3pVRQfml77jh9gBdbbVbiCKyXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 12:48:45 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 12:48:44 +0000
Date: Thu, 16 Apr 2026 08:48:41 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] rust: bitfield: Add KUNIT tests for bitfield
Message-ID: <aeDaqc5q9ki1KBXP@yury>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-2-23ac400071cb@nvidia.com>
 <aeBM8fTW46H9RNg7@yury> <aeCI4giN1TEL_uJn@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeCI4giN1TEL_uJn@google.com>
X-ClientProxiedBy: BN0PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:408:141::20) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc54a53-40d4-4354-6d45-08de9bb67eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QwqEYxNxY8IHiXXxWUKqqraku3o6y9gHTcnR2vJAgXWPK+zSWTTSlD+UHnOtUfP9qWzITWmnEjb23rg6mcXin2b0OEL0MpNg+Bj1KmbaZd/rKMFpaIBgRwpDMCd0jSBJxs/6DTlcYfY9+0gxqUkBbc/gRp3eyeCS+IdUlAsOlBCO85RDmW6E0cFlfbO5aT5uMaQHti39f5rOdoW+XbdmmfOqTXRpPvaIKWa/RXoei5IkembRNNXflJXEurGMtzOkiVEoyOeDqEmnz/uLxva8wCQgBKjrUwLCIbsI9lGKteQhD2P9LDoBL9Ny3kmLrUY8Qw4BKjRr1h5My8tUttViLlNHd7wWO29/PEBCabJQgkbQE1Xdket1EXaGdRmfSRZSPc4f0h8csiZ/HTeQHmBV71FfK1mbwds4P0EzxBMrctY1B32bVp7a2vUnXO5H579pExMuTHMV9rcyC8XT0Eq14u8gtzwTgPOF5sMuI4v7zNmL9hoMN2BA7wl3LZrBlKxd+4m9yol7R4WgeUQMzzPLzgdCJAFvGJOp3uB/whBiot0kIE7pfNCVEc1MqvWv2VEwa3u11O1uTW8lp9msulU4vQW+8zrSPYBvfakNQHu8/h03GE8Hz8mgmBJ4Y1FA+7JsM+g06EPC6lmeaJpsuTrv1u95A/rivvn/UcGF20+7xACmQ1Y78KuLms8hOjI+JHA2xZW2TMRjL0RyeiznlIgOq76qflEt2wRzzAcKvSgL+6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wx6e53hR0+eWoo+HbcIb9GNyU1mHtVbtmGtXHF2E9FnHWoNOHGBIOIsGS5Ak?=
 =?us-ascii?Q?/+eiBQjD1g+GhC1zIbydfn6rV80BeyAmrzzsj0oci61jhcxF+eXlohxSLbkQ?=
 =?us-ascii?Q?k2xyBenAY86MS6bwIM5tM2S6NSfFxjdJnSvw85iJKpYafFCQc/cHMDWq2Cux?=
 =?us-ascii?Q?vuglxe3CxKXqR4xo9i/Wb6lCW+TcZGI/PQXJmnikY4Ga+EqX3nwgbWXqei/g?=
 =?us-ascii?Q?RfqlDtbNz8FOc5fvjT+ejTmdCKJOuu+FTS7kxKJvwqX8aVHlUOf9+/oIfOTP?=
 =?us-ascii?Q?M/OZAM0U6kA0uy4Nme7ZWBCn0yoa9KZxfhXXCdqdeMQLx1ow3pVHQApIhgov?=
 =?us-ascii?Q?SFnywcKtMk3eQXQ7oLIuXVA2FH0gWNparHOnRogsYyEqEHz8OIf8qXRgJ6kc?=
 =?us-ascii?Q?jVzFuoHN5v9aG0bksmyE5MegXs1N2cUy6pY4gI2WyBrMVJAIle9ZcrDZPjmH?=
 =?us-ascii?Q?WEhswL7sO3GqMV6jFCh8vfjyCmhFW5Fl0oQuU5mYxqru3rrjBsiYeMCRsaQ0?=
 =?us-ascii?Q?e66viOmcn1gRTbmW9YI+7cMYUzuVd9IwS1FbntpI/2kgC3yih08o5CJHE/Xu?=
 =?us-ascii?Q?ABTHzdHh84uy91wIffXXokIxs5bGwTQ4zK4KUgyw0EQHwK8YAfpk5NS9G5yW?=
 =?us-ascii?Q?CfyNDCCQDNmdYzb0mjOzJ1hhoMITlyhFjxI1jVigfBrzGKUFXNDTlVPD7RWd?=
 =?us-ascii?Q?h08L9uE5b6USUX5HwK2kFUCJG8n2UvNzi4gKzB2mStnuRTEnqjmbDA1q6kR/?=
 =?us-ascii?Q?6h/R26jUF56jefnzAvW4prScXWB6aAZp6jBdtKCziwhzg7M0p0bdkOMynPMn?=
 =?us-ascii?Q?pd6rv2C5yFV5HIj9Njj3gQmYQtpgd+fvZaw4IS65oPAugzLOSLJQhHHlU0Ul?=
 =?us-ascii?Q?RllVFv/zwFE4xuXRGCT4L384XOyrweFbtu1w4MxI1af/0pgR69XmtUAcJsbP?=
 =?us-ascii?Q?93cItjOo3T/KVznG5kMEvdmYSfiP03n8K+T1ptS7yN8QtdSd48rDczTeNu6E?=
 =?us-ascii?Q?cvdiLW176yu6N+G00SvzAXJA1zI1FrXMkEIKjLsDmI+lUFWAVIhyHoVh44mT?=
 =?us-ascii?Q?V6HAffIWPqK4ZE2SCvNdMDw3Rd2DGddL/ZfbffKSUKfJbfUEPXtNBl0LVTj4?=
 =?us-ascii?Q?jz9ipLHeG0rTnoLcs7meHepBSaIo9I8LWTgDUn2aseTFP0QPelaybebvGkc1?=
 =?us-ascii?Q?5QXbSIvuK3XWkm/L9i1zIPi7Kry7AgxnLbriBY6qqFWvIHCYzb6F8ItxAW9r?=
 =?us-ascii?Q?3WAW1kav2akC+zN+m98WQfuCTijoiLCUJ1AGuL+sWgkOF4pBvMmLJnUy+gqg?=
 =?us-ascii?Q?hq0RAgD8E2m6hzlqOg8WOkfw4xzwkBUCL/KXXYdYpTgvVjk73whuv0jaT++S?=
 =?us-ascii?Q?fbXuAZfPOrLqjD9+JRZ65scVP3MrN5yGvjuX8cSTJz8tZcG4lHk0wC9X3+29?=
 =?us-ascii?Q?aFRP1WIUOhDUhG4L13EpBqXNiVqt1k5DlvkaLF0Vph48CEjS5WlJ08dgfpVY?=
 =?us-ascii?Q?XyNFkQyTYhXuOPtcedOCsBpPx7OMCjmdtxJvaValsNveD/FMCaKY+DGlLYE9?=
 =?us-ascii?Q?Xclh889hxVNp8KapDOU6Vb9sWfmQCDEds2VgqiTiw13R10y4ecgc1SZetssB?=
 =?us-ascii?Q?pVpe7J4pSIaBhyAcxWnZRNumjIyFmJ3gBLix5Q9bApjWErxzb6riweg9FXgN?=
 =?us-ascii?Q?cKgYEq3IBaIALsRKOUS3T58wwGHvm1/0fjoK5GelFADE86E3Xmb+3wXsDq0l?=
 =?us-ascii?Q?T5v68uzfJbE4159UUyX4ChIRYtvYUBrTWPBgfy5/RW68x0XcfpON?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc54a53-40d4-4354-6d45-08de9bb67eb7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 12:48:44.8616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI7UQOorWwrG7LedbQ6BXSNSNVEybPP4tLbM2MtktrNxxY5BoNO6TLMEloqH+nY1XXym+GdDN2/OElsYvrw9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

On Thu, Apr 16, 2026 at 06:59:46AM +0000, Alice Ryhl wrote:
> On Wed, Apr 15, 2026 at 10:44:01PM -0400, Yury Norov wrote:
> > On Thu, Apr 09, 2026 at 11:58:48PM +0900, Alexandre Courbot wrote:
> > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Add KUNIT tests to make sure the macro is working correctly.
> > > 
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > [acourbot: update code to latest bitfield! macro.]
> > > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > > ---
> > >  rust/kernel/bitfield.rs | 318 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 318 insertions(+)
> > > 
> > > diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
> > > index f5948eec8a76..9ab8dafff36c 100644
> > > --- a/rust/kernel/bitfield.rs
> > > +++ b/rust/kernel/bitfield.rs
> > > @@ -489,3 +489,321 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
> > >          }
> > >      };
> > >  }
> > > +
> > > +#[::kernel::macros::kunit_tests(kernel_bitfield)]
> > 
> > Reading the Documentation/rust/testing.rst, and can't understand how
> > should one configure it to _not_ build the tests? This should be the
> > default behavior.
> > 
> > There's half a dozen already existing unit tests, and I didn't find
> > a mechanism to individually control them.
> 
> If you want this set of kunit tests to have its own config option, then
> you can declare a Kconfig option for it and do this:
> 
> #[cfg(CONFIG_MY_RUST_KCONFIG_OPTION)]
> #[kunit_tests(kernel_bitfield)]
> mod tests {
>     ...
> }

Thanks, Alce!

I suspected that, but you never know all the rust tricks. :)

Joel, can you do as suggested here, and I can send a patch for the
existing tests, if no objections?

Thanks,
Yury
