Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7E0C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758C310E26D;
	Fri, 10 Jul 2026 22:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCdgyW5g";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B2310E26D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRSMm6m22HDAgjUvvB18sK058s/aRAx6b0jhH/D7bofRXP26337I5u7SXGO/br5V1F0xNRY0GmGeNxrHCCu0Ppaq73bToBuZlfLxEfyQubgKm6s7lFEOaOerkWizQWciREn9Z4VgpEfHYpTv1OmOzb8C09VNrVCpCOo7nSe//XD74tsvgluXwHz0fhQzt/sR5ibQJ1dR5ZyTM4ebG4Zwh53y3fX432sv/8CsjFj/TtB++v/tyWh3nb6NlQRq687rJBW7l0pvw9mwFfG8KNgGG6QQnYRWJ0hGRVOekSFevouc6uuyQkDvdPfz4jDK61rbC3vw7nTnPkdvsEtgUZpLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo4x/+Sjq4F180D1BIKkUO2qmwaUU0cBGnO3yQ22Jtc=;
 b=g0FYLguH2npMt1GHUQsKo288ggMC82KhvnUhzUfZ30Y7bEzBmI4rYkAaVuV0AvORj1PBhezft9iuVPZ2dBMqnTRXP6ZWRI/P5c7y/nBBEx/CYsrykfAI+mLY8B9NKgjS2RRwukeIcTRLVx5NZcPZWuCyPdsb13dQBdgdf6EPaLl/htxxSsIiiRt8sM10LLYam3TlfLKfsE5nUYVQSqKXzXzX4bIhcmQzQlV30p/Kv4i2XehOmD4GWRs9Bf2W3IelJvyB/dQ6uV01o6vnaPBzV6GWftT89Mn2YgmW8fnwS3MdiNbuSieVbCIgQWMbSLwE0mNgToCoQ1IcFv/GokUeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo4x/+Sjq4F180D1BIKkUO2qmwaUU0cBGnO3yQ22Jtc=;
 b=BCdgyW5g9WoM52Yw0Qb7eVf48xDcPbmZtZZxV/hkZOM6KFs1IpQvzxRPNbiwgaLPtLVLSJKMKGZ3lPBLnzIr/zkLlGmcGptaVqrdfJqCCABMTzcpW52xEP1ijKTvQOuDb4aKMc+exmqo3sf5OfUfDdbcdfG0qy3UE1CYrDdw/XAQYRkv1rRlclrsr/O18WKFtTcI+08W61OBTq9jtZ+Cjl+2i9d6dpCzIDrKubDarncGKHpJ557FA8hRvqya5jX6VFP6+HkLsN/QOHI0mvoCu0EFwY94XZ9JBFXDab94It6E0co4fD50JUfgnUDoET76oqH177iCmG9EzBW3VvoMHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.16; Fri, 10 Jul 2026 22:42:17 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 22:42:17 +0000
Date: Fri, 10 Jul 2026 18:42:15 -0400
From: Yury Norov <ynorov@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 Yury Norov <yury.norov@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] gpu: nova-core: add ChannelIdPool
Message-ID: <alF1RyMPu_f4Px8T@yury>
References: <20260710-chid-maple-v1-1-4ee869055268@nvidia.com>
 <84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 548bf788-d8db-46d9-a592-08deded47e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2xcauitlqBDByN+gOsctUv65acvZtAlUZZSruNoGkKo4fWjK5i62oqfZmuylNQI3Nx9xsjV7PXqN2PE/fYz/dzVe7KINcRTos7Zcnn0uIWTyu0Kp69bcfCPRHcWErgEtc/d2CDzIHRZ9aR1TkEfeBRTYUv6XxWxRxFOZ1XK9oXnWvG4Q+wuK4x+ga8o/rRvG1pDP8oLHIjjNNLLa0Dlzc576zgxzUf3VxPjWgWxguI8MteYmSD2OKFfLk9FrAkGelBEV96yU5dtg8Vz0SLyRZJZzIyCx6P+hnwO7zyCPj3x4VaAYasermJNKhc+rDQkNqmFcx8rvktEpuQW1TDzCrWebyjWrdRQfFS5W+iwcFlLxzMDiC+TSe4opFsl8b6JHJvX3/LrmkSFE1Jm2Oy07/+CyVG+0nzOetnvoMNJruSIWm7h42Zds4rvmOS1WiIdZvcjfX1hNvZl6kh8pLT8JSrZY+iFSitz9TVPiSoFnU7hVC4o2Zdr0kd+tESzxZpjH+3RUAvdkrY7Ct5wG/aYf+E1ScS+5k8wS09V/snt9PpF7Nmv06t6u2yiK1LHgZX9D7TUT/cXpttyr+SKN/Gh2dc6cKrO7SiqAGrvKBr6N7sNpB0Rvuqhttzddpwk7ndTUcyvC50RmsSqcxRLHqi84izoStbLCz1c9NGXo7u/H3mM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dwb7F9GgtQMm9VofP3grXX3RwTcigJ2pjsYfVFdwIA/dNIYL4golX880Q3ts?=
 =?us-ascii?Q?RNZW8bvZ3nWq+ASpBTsAQ9HN62KjsIdDuQuhC7vfTq4TnkvUxrVcIkLOdYYG?=
 =?us-ascii?Q?Xf0+wCkKK1i2qDpR165E8kKbohvWC6H32MnNR+EuPZ732fC1EqD893VDbRv4?=
 =?us-ascii?Q?WHsJKchLM8IknUOlkscjbpJpMfMwtC+c8zDvmu76lzulCdGgbB609U13qjqH?=
 =?us-ascii?Q?9JiY1lltOjhxCFYtk/jGNE65G8zk5wRtXeDyVRcU56eXYao2Vdo/YA8l0058?=
 =?us-ascii?Q?y4P3jcLX46NfDZKyBJZsCzvVeG/XvqAzxMMZid6is/rKNkL6A4h30aWrhwlN?=
 =?us-ascii?Q?aJjosbwscbM3rcFKf26nZxdgyA0JcKUQ24mxZRVCSOyCCVVi1To1VtvLvPBc?=
 =?us-ascii?Q?i695ZuWGzjr719LZBLfZORb5Oq/o0n/FtNp5N+mNgCGHaw4ayJ4uSNdHQn60?=
 =?us-ascii?Q?EAcHoR0105LyChUDg0NrQiQiC/rrTtzdKJBYmITt9DTS6jBVzwa/bz9Y++7d?=
 =?us-ascii?Q?j45hJY9GQprlWTw9F1MLChLazwuu42XlRVFFhPwLD/bhh+beYGWCR4MTRSrh?=
 =?us-ascii?Q?dnHLMT3cbkIybOEhqtyV6RgvvYE21xl9YOxlyetLiHWZ2C0SBgLKHACCGVYi?=
 =?us-ascii?Q?19IO2F+yrfy0mXudrW0qYIcydb02SR8F6LAjtJs8xEYviO3f864LQqeLVL+O?=
 =?us-ascii?Q?zM0oDmPxTKkIj82nQP7ZR1W4bQrDa8rFOTz7HuHrHuiY+pb+7g+gJSgdKpPU?=
 =?us-ascii?Q?ZMjlit9InzY91PlZMDVJJOMbMB+OX813juh5Gi6cVF1tmsPuZAVO2Ofi9CR/?=
 =?us-ascii?Q?PgQ5lIcbW1C5A5zIa7i0fXzitOfFHX79gtYMOU8iwsoktFU3vHvMzGUnH9cW?=
 =?us-ascii?Q?Par4DUiLJ7UeVdKuqoMZ3BULSHqq0oOmyJKgCglSKMD1VVktsdjoTSF+t7s/?=
 =?us-ascii?Q?Q05lNsEbWODZdEKPvXxFMTzBLdvcGJz227VwIcAXOqGOvE4UTVqzs+NIrAsg?=
 =?us-ascii?Q?4278OJ1iRf6/9TPBzMPO1s9e+rLkPB2X4u8AYraDINasUiimwx2w2x1LutEY?=
 =?us-ascii?Q?ua9HwMB/H8U2/SEJknO2Do7lc61oc5BE0ZS989U8IfVEvtEGmnYpZ9hG795Q?=
 =?us-ascii?Q?NfCbFowckFZipaOqT104uHZk7X/de0rya31fkOq/KrqkTnJBzHK/EbDketsC?=
 =?us-ascii?Q?OYHcWHP/vsAWS5mOkpGDYH6Sk/Z5hvbSoGzA9brPXGDIDFTX/JQPANwdm1AS?=
 =?us-ascii?Q?7lVkeGQjxj9gu8Ug0TfxrdAiFzFBzP6UMmvkPkqR58gYXdi6k1h+gKmx+T78?=
 =?us-ascii?Q?9OqqTSlYTf8r9A/DIHfs6FMd91locy89RNiCLgHBch+MTc2a+tN8MygIGOSm?=
 =?us-ascii?Q?rukpGOMREOz7dQmTtauY0JhNJJlfX52YL2bcOGyceWZgX8sgWNZ+997kAuJr?=
 =?us-ascii?Q?/BUvfoLxd631hdEP5pnepgt4GqshvUYyXW9VIhU0C6ytxbiW7apor4T3Iage?=
 =?us-ascii?Q?at+B1N58ukbg3C98fZk0Wf3+r0cNl9PtX2W2Mb2hEkP0X3QUUGM0uZyBaodd?=
 =?us-ascii?Q?yA47vSA9XfKdKktrFj1F2phrtbEPGnflU4k73YzbW+AT7FSsePdJjoRKdWTp?=
 =?us-ascii?Q?l11iMYq372cfkRtToe7xopZtRdtSKjWiK6WRnT5eWebmfB5LfXGDh0uxMxL3?=
 =?us-ascii?Q?DYBDZ+8QrvKwuR8HeRCVC4EBZ2hMO17WndDZfqlyxkbesmDR2R4yv5aj8iLW?=
 =?us-ascii?Q?3/lPAeAEQg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548bf788-d8db-46d9-a592-08deded47e96
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 22:42:17.4759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctPKXVJeTSjHDY9Rj9ZGGUkDFLfwV8bs6JzQ+JdPbxWwgHIxMfWQ0rxvKwSbPSTRiEq3lwlq8/e1DboYlWyJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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

On Fri, Jul 10, 2026 at 02:29:39PM -0700, John Hubbard wrote:
> On 7/10/26 6:42 AM, Eliot Courtney wrote:
> ...
> > +use kernel::{
> > +    maple_tree::MapleTreeAlloc,
> 
> Hi Eliot, Alice, all,
> 
> Eliot already laid out the maple costs (the alloc_range+erase loop
> replicating find_next_zero_area, the extra mutex, allocation on
> alloc and free), so I won't rehash them. What I can add is why the
> alignment is a hard requirement, since that is what seems to make
> the decision clearer to me at least.
> 
> Pre-Blackwell, USERD sits in BAR1 at page granularity, 8 channels to a
> 4K page (chid = page*8 + slot). Giving a VM its own channels means
> giving it whole USERD pages, so a VM's chid range has to be 8-aligned
> and a multiple of 8. Blackwell moves submit to a per-function doorbell
> keyed by (runlist, chid), and the constraint goes away. So it's a
> constraint we're stuck with pre-Blackwell, not one we can design away.
> 
> Given that, the bitmap version is hard to argue with. The aligned
> allocation is the one call the API is built around, roughly:
> 
>     let mut ids = self.inner.lock();
>     let area = ids.find_unused_area(0, count, align_mask)
>                   .ok_or(ENOSPC)?;
>     // area.acquire() reserves and returns the range, drop clears it
> 
> One lock, no retry, and release is a bitmap_clear that can't fail. For
> 2048 IDs the backing store is a 256-byte array. find_next_zero_area()
> is also the existing idiom for this (IOMMU, DMA, IRQ), so it answers
> Greg's reuse-what-exists point as well.
> 
> I'd go with the bitmap id_pool.
 
Hi John,

I agree. Bitmaps are hard to beat, especially when it comes to just
a couple thousands of bits.

Eliot,

If you consider something more complicated, I'd suggest to estimate
memory and time consumption in a typical scenario, then weight the
cost of maintenance of one solution vs another.

If you're hard-limited with 2048 bits, bitmap is your natural choice.

> Pre-Blackwell, USERD sits in BAR1 at page granularity, 8 channels to a
> 4K page (chid = page*8 + slot). Giving a VM its own channels means
> giving it whole USERD pages, so a VM's chid range has to be 8-aligned
> and a multiple of 8.

If you always allocate 8-bit aligned area and never partially release IDs,
you can have just 256-bit bitmap, where each bit represents 8 IDs. For
example, bit #1 represents IDs 8..15.

There's no real code using it in the patch, unfortunately, so it's hard
to say if that's doable.

Thanks,
Yury
