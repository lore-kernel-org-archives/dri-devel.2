Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B905FC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0B7410E525;
	Thu, 13 Aug 2026 18:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKwkWJ0D";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381F410E50A;
 Thu, 13 Aug 2026 18:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr90tVQmbWlOZq/RxdcXNplL5DqgUUUQNM5E2cecsv1hWAX03s+3EQ8YogykP9eCMRt4a8jD4i5B+RhHh2Phi+Uc3qqqONNA+hf3ppc5UBdBi7Z1eNqGTZ1SlwmGuAzuXIAUnxkwIilgH0MBl0sU5n3KKgMOKSLjjeDRZDEGvsZVt22LFdYsAZ2M777soLQqWpVUL4AW2+PUyo9uYmVFfI2XNV+bqJiBZoN/MOVHe7Iz1THgY4Jw8Fl+E6Mc82JdUEb+Zwk7i2mLjq8UxIRifnSp6j4YVh/5Z9oys/Vj6T4Olv9moB8HPGezHKo+8wJUFCkYct4r6g/Da/0287xxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9lFudYxEuPAaO+mSTWrx1kMVtXLj9+4iMSeO0u+/R8=;
 b=p+RqCSusktJbjsE9tCdx0ev3r5XiGDiAr3On6rHZCU7rYaJmFsdQN7f8HcGaVnaO8Qa1Nff3fcUhmAshrUZX9TfRHqL/CIN+3tlMzozcdWHNWkhDokLP+IquYwI14cmHQNxVrtwKlFCpS+4IRv/eGlcRT2H//qfxoeSfk38/1PWVarDDmGYE8BNTzBUjhwMklU7q3/cL10fm3AYgsDqki6XsEBWZz0oeG1SG+pw9bmNmayfkHqGmsATj0FXdZTysf0TMyInif0tUkOEP4TsJEtYl8qN+/ZWcqgYv4FVnhboUyDWxnkTo+DNEgTR0oQeW87Ogqqd7kwdch7JxXdcowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9lFudYxEuPAaO+mSTWrx1kMVtXLj9+4iMSeO0u+/R8=;
 b=UKwkWJ0DKMtYrx5HBwNqEyxppYBHjjwvrbX1hA43vfRGAspv7JGx40YUnVSNd2VafMvluCbFMK46ja28ES7WgcRS8hBUkek+ICVPRYOH946OE4in4O+etZFYm7JGWTV0Qo/B7t6jjsXHcVirSFXxmEZW0Ib5Oqzi06JuAwF0uKN/90V/5Y2l6HVrGU+BNl9is3T8qBHYGXEomIvnuExEXdaQP3FMnQxMAGRj2d1fb+fqF6kQwHCssNCW/z+87S3yIOlw2Mlk0u5aCrS04puMwRhwok1u1cT3naGu156ZuzYe7UN7gxjJ+UCgfxeIDAlBsI3DA5foYC7Zd39uXMD8Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 18:32:31 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 18:32:31 +0000
Date: Thu, 13 Aug 2026 14:32:29 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Message-ID: <an4NvQBt3389jP6E@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 624ff2d0-8bb4-4bd7-b304-08def9693c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|1800799024|376014|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: +l8SIhxYoAK6XtE7c8cY++cjlmOKEaciKOHh9I7ypgOdVvifLVwIDW3bjJkZUMRdeebXaae6X0A6sFo2xY73oCsFpu3oL1F/W5D+T4Oh1vGb+YjtKamhaQgyTdUI7kBc55VgcwJFa8HybkbNWtzPJX18wzqBF4nONBtAeuLtR4HSwF44xz3tFCpvGb0pcWN1T1BDNF3RI2u+9qaE9MFlrtOpWrR1hRLyT0exGiMFgj+67ig0IvGHuN7mL6q2exIlXqJyMh6Dx8Ci6UNjHGGMAs0RzDpwMRGB5M4Xi0j8CRzoy/45wc0Ucb4r7RePchLm87HbPwoCiajJZOF8glFK9a41Y03ZgCjNp4WcMgZB98plAurayUoTV7O8uk+FSHeAO5MzPUNHom8byu9gXMugbzOCEJmP3Nc/vNIstbEIwwvB5DQ/W9eRkTXz1/n9dXS55X1gx2AWU7KSW+9it32eYzseQ6j6t+iyISmu9C9DVJvoLYrj/yM+n3L9kVheYhpEhNc+FB8rhmTJCqmYN01CLf49aW9PfizzV5TcP1ByfsDZ76G32+yNand+39AlPyOK7ckJT6mmSPdI676uEb+1i5QIc2HRM9oL35ZNgisZk9YyFTvoaFW7/WxRIpF+Ud/q01XSl/EvjHdnmKZDs6XwbOQnRXCJLH3tLXQJRHZwDXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?10CjxVwb2t6NmSXIX3pZw25uiAdwq+Ug5LVfDQY1YEGuVvY81vVLOr7OqY20?=
 =?us-ascii?Q?Sr39I3n5Nn4/fNzXfrxYWqY9ubIVfdFUVPvbuEcgaRHwaR5bvDCxPRtDoPt1?=
 =?us-ascii?Q?yyzerevOWT1r5arKS9RdRIgSobgh9oqCWaBeYCQ2dYvslUGH7d0nKqwIJb+W?=
 =?us-ascii?Q?YLmo9ELe8KlX5DdetUxYBWrvtvOOVzLKfk38C+vJ6hyKzzIbEfYN3vXIY5cl?=
 =?us-ascii?Q?uiKNp0CYX7XhTyFMGu0Col+pPbJm7hwTw3dESZzoEfnvPvNl0+9TEQ3SZIZN?=
 =?us-ascii?Q?TknOsmHIcs5TianLfeBkt8lvChmVMcBa5QccsjzXsKyXrhotGw8RxgAkqw5t?=
 =?us-ascii?Q?9Q2OrGJNqbWuSwKIUAQtcF0LutO9Kfmbp6glxk4ekweKIdB6VrrvQeYDI3pm?=
 =?us-ascii?Q?OEWCr9SvFgAHPtvtEMEnGiIe+Z2oslF+WmQ5GYW82bo01XoMsHoH0xqioe2r?=
 =?us-ascii?Q?iGUzX4DNhWD45V44fIAtsbLafzVuw2LCOG9Y6d8FO5Hg+7ixTPIqi9Lt+/Re?=
 =?us-ascii?Q?p+jnTMmY08Twu55iPPoDmHlXcLjZPPtAoe1mZKKvtMjJOMldTpyhZ9hmwY/J?=
 =?us-ascii?Q?MD8nkk8Ci8+uX1RGyKjx1fynpbrFHunVaQMCmoJUO5hW64AQ0PD64dQRbIkd?=
 =?us-ascii?Q?nAFPI2i/RYgQ92RzcDsDqdfXtou4AgZlg3IUOusHnaYfCm/mL2pMCmQiIxEU?=
 =?us-ascii?Q?GJk6k4DZ1nRhY2JNRW4daub7G8mL8objwnx6KMr4uHKs8XdRblJC808FMjHa?=
 =?us-ascii?Q?dRPwLRC4uggE/gK4KiCpwueSawN5FBYiIWtWEVLswwePCOx17lJhiqdOBUrL?=
 =?us-ascii?Q?qKZczbCYBSuE9h6D5I1Be/zmBuaWVANgerCWiri8OKzjZNPsUu1gzVBcoVyd?=
 =?us-ascii?Q?glTtvVDO5sJ0fNWGYvdrlSsmpacTXlvLCGO7f7EH5mFSIZRiwXrHaApUgQG4?=
 =?us-ascii?Q?R1jwjwyA7SLD8WVKNBfscoxJJVCz1yCf2looH0EdBJzO3xme7xemZUY+TO2Y?=
 =?us-ascii?Q?BhXyV1LsJnSgUoLLkxUxThawCGKItscP7OAIJzlXl5b0CvaPjdGoEQldYhLe?=
 =?us-ascii?Q?I0hsQOSydlRBk5H+9YElZWgS2yErE0IBdlc8GP34PpBeIBNs2iw2ugKl9Dsf?=
 =?us-ascii?Q?jRUwvWGYc0/jRsdi3ImO+bLVIh/drRFqWw/Ekx5y8wqLrfgrlyND45u352Ox?=
 =?us-ascii?Q?n3ML12nDZBKuh39zWdMrJpzYPyUy2lVDgZ1blJ5iSA1w27RgWKqcFAH3ni/q?=
 =?us-ascii?Q?RIWUukSyxOHOKMllQzmmj2ffawVsn2fIzUuCyAjrWU64B+Fhs4lcXAbqS/f+?=
 =?us-ascii?Q?ov5UGXRo8+Gc1LB44Y1eanLnmINetBmN1or72Q/1MeQakhXdrluQytJSg/g/?=
 =?us-ascii?Q?qz7VqjUJS1/eDDO/SdK1SHI2DibUUoeqjL1tlOpF6rle+P7S8AfxSKEyGl+w?=
 =?us-ascii?Q?DDDaSqQWWYUWobsmPmQWXrND4A66/pLHOf3J3AE/Och6sUdL7xFRswW0Emyq?=
 =?us-ascii?Q?7WN6n9asf1CykXKoa2NlsLBb+rPzVmtTLBwN1ivnadr3q2S9aiUnYEN9tc60?=
 =?us-ascii?Q?2aBGLvwZ3w8pBb4Y7zmU4yfHZMEMhgDEfY6UaTabysHRjc/8MhrdcsMk2W5k?=
 =?us-ascii?Q?nX0XhqhhxlsmZL6G2QKrXsMn7QJIrMolkVfzmsQu+HVz6Ncu2lVXPtERp+m2?=
 =?us-ascii?Q?z8IgVX2rMCm/4JPNH2U++G4lYynK+Z8utaGdnkozUp6ndkXdJqaOnOEoz3Jf?=
 =?us-ascii?Q?4y56cqMWoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624ff2d0-8bb4-4bd7-b304-08def9693c7f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 18:32:31.6731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsU7S7KdiKCWNR91q9rBYvoYkWqOX8DsLE2Allk9cznmq771UWKEljm04pDzB9werS62Y+ohmURXTDcgUPy0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
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

On Thu, Aug 13, 2026 at 04:31:26PM +0900, Eliot Courtney wrote:
> On Thu Aug 13, 2026 at 7:18 AM JST, Yury Norov wrote:
> > On Wed, Aug 12, 2026 at 05:51:25PM +0900, Eliot Courtney wrote:

...

> >> +        let c = pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
> >
> > Is it possible to make it somehow simpler:
> >
> >            let c = pool.alloc_area(8, 8)?;
> >
> > All the parameters checking must be a part of implementations, not the
> > interface.
> >
> > We had a very similar discussion in the bitfields implementation thread,
> > and many people in CC list of this thread spent quite a long time to find
> > a way from:
> >
> >         let color = Rgb::default()
> >            .set_red(Bounded::<u16, _>::new::<0x10>())
> >            .set_green(Bounded::<u16, _>::new::<0x1f>())
> >            .set_blue(Bounded::<u16, _>::new::<0x18>());
> >
> >  to:
> >
> >
> >          let color = Rgb::default().
> >            .set_red(0x10)
> >            .set_green(0x1f)
> >            .set_blue(0x18)
> >
> > Can you do the same here? Please refer:
> >
> > https://lore.kernel.org/all/aXCZeVqkDrBWr1uq@yury/
> 
> I think that taking NonZero and Alignment here obviates the need for
> checking the parameters, since they have their own guarantees (and Alice
> recommended using Alignment on `Bitmap` too for this reason IIUC). Maybe
> I am misundertanding but we spent a few iterations here adding
> `Alignment` and `NonZero` on various parameters -- do you mean just
> making ChannelIdPool::alloc_area work with a plain integer syntax? It's
> possible to just take plain integers here and check, but I don't think
> it's necessarily better.
> 
> W.r.t. the bitfield stuff, yeah I agree that was a good call since that
> syntax was very verbose, and IIUC that was resolved by having e.g.
> with_const_red::<0x10>(). The analogous change here would be to provide
> const generic args, e.g. alloc_area_const::<size, align>() which could
> be plain integers. But, in practice the arguments to alloc_area are
> going to be runtime values (outside of tests) that the caller has
> strictly more info about. Having the separate types (NonZero, Alignment)
> also makes easier to not mix up the order. I can't think of a way to
> remove this verbosity without just passing plain integer runtime values,
> which IMO is not great.

  pub(crate) fn alloc_area(
      &self,
      count: usize,
      align: usize,
  ) -> Result<ChannelIdArea<'_>> {
      let count = NonZero::new(count).ok_or(EINVAL)?;
      let align = Alignment::new_checked(align).ok_or(EINVAL)?;

      let mut ids = self.inner.lock();
      let area = ids.find_unused_area(0, count, align).ok_or(ENOSPC)?;

      // If the pool is small, the backing bitmap may be rounded up to a larger size.
      if area.range().end > self.num_chids {
          return Err(ENOSPC);
      }

      Ok(ChannelIdArea {
          pool: self,
          range: area.acquire(),
      })
  }
  
  let area = pool.alloc_area(8, 4)?;

See the difference? You still check the parameters, but don't make it
the part of interface.

And from practical perspective, your users simply call the function,
not tinkering around your 'safety measures'. 

In the next version, if you drop the intermediate UnusedArea layer,
you may want to do a C-like check instead of creating new types,
because here you'll directly call C function. And it's completely OK.

Not OK is complicating interfaces and life of your users.

Thanks,
Yury
