Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41859C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEB210F530;
	Thu, 13 Aug 2026 21:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="h53x63Ai";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB5410F530;
 Thu, 13 Aug 2026 21:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZv6XZ4woTZDwx5iqHwv917vg4jLxTa7uX/h3emG08g2HaY397fifUqmS6eY9QvWv/Ew5mQgDYJfls/8OgTNjXlwHRfzWGECH/HE0oyRFQSaieNa+Y9qnLzQJEbAmQXNOk3lzK3WllgFXQLN1tIOPqIP97s/ORnES52FYtkNA14WQDYhO5Ne+r4rKqKDQmqZ7o6Df47dI96ul4yN3I4W9/7hMFSL6VmzaL439CsoA3dF0ggJV9tm32Eax+1XqslXk9fOS7p7eqIANAhzA4/sUgzYlNrmrkmPdh4qoDf4PUI53245dCb4r9zoojETvE4/G3isVV2MU9IALotlJOg+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0qJbGGLFeYX+Qh3RfAwA8GTlIaTq2yvG1kadI5AG8s=;
 b=elEy2DYmu5GHuq5jtWfhzvUIxJ2/bA59bIZjZDuEWx4Yehfg4sZVFm+3MGbK/kzcrvOMkdaqv/iARFBle3GijzkT2VdLd/4RgveYT8BrLxW1UJk6Az9rUyjSkZJVogewTjYVnLND8P94sMt5WJq8lp0zEVTZ7oqQyjjqHoWwcDBIrosc0nAmyQFntgrkMCqVz5iY/uomd/53G1h6LsMA5miKS4SeWBji1hV6ZmqWrGPG127jed4nH5f3P4nD3/oEV2edgsyx1XdvOfqFxWYAb+FdrFBBJE2X9EP4aBnkGjuPnnHhD56WQI+0rYgbHcFVagSkFwY0I4QZiYBtooGNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0qJbGGLFeYX+Qh3RfAwA8GTlIaTq2yvG1kadI5AG8s=;
 b=h53x63AiWpgu8r3f3rrrWMbSn80RlAZa8vXipcTGvjZ1IpOL1dvVym3twwIWeY7vwlnOK1eiFFI69iOySI/XrIIYtcRe9IEMsc96oaDwwaULAHG8tVTzGZSFK3e3jy18bTvfQrpxraAtgiQx8uamPw8NVJLWqAPhuOx3bL3DmPOFrfpdC/kFCF5iMkf7gPjgvRgd9h7KxvKZwIbTFIoteFwkR4odV/dn0/1R+HgPnX59iY7Z2x2p5X000HjzS0Eeoy125k4gQylcv1KTU3E8nNCt/FfsM1+J2tIPu7hegKMmCRmKAPCVgUvRKjWPZL5C/HcZ35S/Iw4evMXGb9s6lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 21:03:13 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 21:03:13 +0000
Date: Thu, 13 Aug 2026 17:03:10 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
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
Message-ID: <an4xDp29VX8Am0uR@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury> <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 66903731-2b42-4634-4675-08def97e49e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|11063799006|56012099006|18002099003|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: kZ0dtfMCMtKFAHdgcgxw5qtVnLiBuaY4XhGZSn0D3uS69kdksCDeRQfld4DzVoikgahHroxBT6xa+DeVc/4ksKJqcdYPowxUnWBDmDtNo7HQBb61WZtN0QqhLYfuN2mloaXmR89UkU4qcEyxgbmisL0h2pOfkMmniGXtJezPfq31uv3QufmDrmM8B52eKs1Yt1mrenAO/b5+L3R84ZAt2m/HQ2FNDoBilZMJFJGd8kp0L1Ii7qOtq74ll7VSrC1OpX47pt7sCiFCmSZkuDWpms8gIBkpeEf4RAHlerPHAQ6SZeK8qsQO4OWvg5+x12vxLUd5eGsQSh8nwU4HHjVMFznjXpJ5poCRu1BuPDrAyXPHhJQ7LWjyHaBrg4Cvqa72RojqlP7AZ+AoLBcHEf2IJ29tIKGYNYlVH74AhSlh7Zp1vO5lAJP94Ddp+jmTkcgoc/ElsrhIW2SMvT3dadPkxdDS1UbngYisWGZDz7ST47s3WDX5Yg+yZxEJFfnqoKIar074p7wh6FndUwVckhmbi2BKOpkDJW8a5QGeTzB4qdlLtXvDshdwzoUbDBMZuzKYT6XXLo9T0bq3fH30aM2slkrnZBtKphtMXHRdtpWAabjxf+6jJcOnVP8cxkX6ToVU3jKrfd4loT76muXxTfudIdbAXefW+4imy927cg4rg8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(11063799006)(56012099006)(18002099003)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmlUEgL4EJarnPF5vB89ObElQeiE9cu7fT0HtFX7lcV9YF/PtMpe7mfDPDIi?=
 =?us-ascii?Q?9cRso542cCEqxe7mQ1N6WcbaHyTKR02ktI6h6c2z7brVjA0puWCRnu8qJVr0?=
 =?us-ascii?Q?YEgmqr6YXwIsEXSocxLoseRUPUSLP/52WVJqdnP9uNPJJ2+QAiJ1n+NjfJjR?=
 =?us-ascii?Q?Ezxzs3F9L3CiRY9DbFUs+CPdzlw5QrnubvI4Rlt3gO1RcWlNEvdRTHd3YxZs?=
 =?us-ascii?Q?X4k/ejSkWju9gmX3vp8KqMgtGQEMunBpGSCJkpZyCg1MJW2h0fj80cbMaNDD?=
 =?us-ascii?Q?5rNWOSXHxw0oN1dq3DaWjapXTfWVbUrjyGRZ8uxrbQNHFmscZxUnFHEoueQZ?=
 =?us-ascii?Q?ExqboNvSI/RYaZQqgO51OVd7ogyry9t4SIZY5MufMhGVm5TJ1McTX4GfbsXO?=
 =?us-ascii?Q?cAY+w08GsQHFaERdUBuenivQPlkNfsYUWqK1xzJsZOlw8nDTmUkQU+aM2IEK?=
 =?us-ascii?Q?+0lTbpR1lbmUG/h3F5fff0PlzKroAI1h1v7nZydaQ1qSTmiewj2zPASISAm3?=
 =?us-ascii?Q?wxawUPXI3eQ8ZlybNDFgvcNMk2/uN6dN8Y6/rvYgltZv6pnyX0Atezx7Ja74?=
 =?us-ascii?Q?8yEN6yyADuSUj6X15/t8M61pcqVU2mM7wkcsy6Z8YvSB8mNmRGKR7zcwyRTu?=
 =?us-ascii?Q?LPKMpXikRVbXrmFKyf4Cfzm6kBUvnGaF99daQlc0IeMRj7sAHVpTE8gh+oYX?=
 =?us-ascii?Q?EK5o9TuXWNUfu3SndIU4w+eex6A1e1xRVLXPej5eCcxY/A2v7ufgm20lQfDS?=
 =?us-ascii?Q?DnAp14DSRbDMz7aIe2NLnpsrjf/rYpccO/M1bKiNRkvdgKc/fUvkqCgaoDa8?=
 =?us-ascii?Q?N4fWEbPPTdIHKvHkKYnzznN2oFuDYtjIYt2OGYdtIKEJI3sXUChOa9hTyeQq?=
 =?us-ascii?Q?gloIlOf2S0nX8KmAOXiB+JH/VXyY6SE6uhq8NZ3B/Ed4zx0gSuklM1rMZlMh?=
 =?us-ascii?Q?1Ezb4wn39x60XzXH9q2VReoXsUaGX5V6NFpjViTow478on69NjRRZoVkhiHV?=
 =?us-ascii?Q?xS9SeOJvaF0RnUXgZeQ6ArwaZdVBN3g1QcLrPMdDdLGZkLHDXTs6n4t9PuJy?=
 =?us-ascii?Q?fqd3PhS7r5OkY/4CkTH4ZLIdF5oOecC3OvsvzDv+px2dOuk5x9E6u/guHRIm?=
 =?us-ascii?Q?RVHkiPQ7TQ2ApcNTYaG1o7GyirvvYNEGusCk03KVF5u5Y70iOIfAluOi1jHy?=
 =?us-ascii?Q?w2lSzZukdHh6h6SfjXHFGCjzuuRzxPwbPpwKyV82enXmb+L/AGmZL5Wl+p/L?=
 =?us-ascii?Q?Sz4yR8nL4GlVnhUiaHPjxiWaQZdkUXdPAd0KTvNzR3i8KrpqBSQ6UgOVtUlD?=
 =?us-ascii?Q?Jw59Q+4IAHjclHXMkFTKT+qX2KK+Y81IhCq06cYN5eFXSgcBYjJxJYWX0X0G?=
 =?us-ascii?Q?BsQpKUCGx+q5EzTE/tWk4Q1jbthyf3rka0FNAe2GWPoj9UZvSW5+Od0vE8x5?=
 =?us-ascii?Q?2Xnaw3O7KXZC/APQH3MBG27TW0Dj9y6CE5KXPfmXGXLD2UYaL9kNgLG00V7A?=
 =?us-ascii?Q?WoI84qbG3ZiDef+dd0NgYaLOt+Jw6WCDOb8YBYqbynvfpVnPCBjEnTtCUmgi?=
 =?us-ascii?Q?WvQss4NwZNkSW7f2X43sLgJpokL90Kh3UzGXKf9EyHROc3iIymrL8gMZQLB2?=
 =?us-ascii?Q?SmQ3lbZgQHZ2jusw2WO+sKCVznP7A9hlOJiTc3MSKAqlaJAcqVWlsJQf9+Jp?=
 =?us-ascii?Q?Eq39bKd1IRe5eoLCRd6ZmyTgqkejJ+9uq+hWEsYt1sYm18fQxPZxxCp86AY9?=
 =?us-ascii?Q?RJbLG2gRhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66903731-2b42-4634-4675-08def97e49e1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 21:03:13.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si68juVvmu1MeQfWMvMOIl7UTmZCbB8VXUPYvtGD55a/b2yU40ROCUOMhSlLX0NCsV7mEvUU1Gz0y/6Ej+AzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578
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

On Thu, Aug 13, 2026 at 10:48:50PM +0200, Danilo Krummrich wrote:
> On Thu Aug 13, 2026 at 8:32 PM CEST, Yury Norov wrote:
> >   pub(crate) fn alloc_area(
> >       &self,
> >       count: usize,
> >       align: usize,
> >   ) -> Result<ChannelIdArea<'_>> {
> >       let count = NonZero::new(count).ok_or(EINVAL)?;
> >       let align = Alignment::new_checked(align).ok_or(EINVAL)?;
> >
> >       let mut ids = self.inner.lock();
> >       let area = ids.find_unused_area(0, count, align).ok_or(ENOSPC)?;
> >
> >       // If the pool is small, the backing bitmap may be rounded up to a larger size.
> >       if area.range().end > self.num_chids {
> >           return Err(ENOSPC);
> >       }
> >
> >       Ok(ChannelIdArea {
> >           pool: self,
> >           range: area.acquire(),
> >       })
> >   }
> >   
> >   let area = pool.alloc_area(8, 4)?;
> >
> > See the difference? You still check the parameters, but don't make it
> > the part of interface.
> 
> Miguel already replied to this, so just briefly adding to this.
> 
> We usually want the arguments to already carry the invariants we require. If we
> make the arguments unconstrained, we may end up in situations where we already
> have types that provide certain guarantees about value constraints and yet we
> have to give up on them because the API takes unconstrained arguments and
> revalidates.
> 
> The code from Eliot does actually already takes advantage of this. In
> 
> 	pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
> 
> both arguments are already validated at compile time, whereas with unconstrained
> arguments we're left with a runtime check.
> 
> Yes, nz() does not actually validate it statically, but it easily could (and
> probably should).

Alright, I'm not against the static checks, and I don't insist on my
version. My complain is about readability and unnecessary complexity
for end user.

let's find a way to convert this beast:

 	pool.alloc_area(nz::<8>(), alignment::new::<8>())?;

to something more readable, ideally:

 	pool.alloc_area(8, 8)?;

We were able to do this for bitfields, and I don't think we should
give up here.
