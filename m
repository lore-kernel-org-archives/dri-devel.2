Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30060A2603
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r+/b6mxP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D93F10E0B7;
	Tue, 10 Nov 2026 17:21:50 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1042C10E0B7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG4wjnnejCKtAJSJbZqdmVyQZRLGCn1dGwsijn8gTXGFMSSjBleCqJ7GTqYdAhYsQja4bqjn/p/e7E7UcX2SmMZrVAXzlKZH8qqSr5BatZjdm/hIDweRBda2Tp/EfRJh4Gxi42Zy2YD0L1sowCefdVAALhyJzrl6oPKVGVSQl4Gj5NPlbJUo75WpfX/ibQcP4j75OokCii2IuSdXWmm6iX0tZ8CCF/2aEN4BBksoN2M0/1F6RXttCwkFDlBbRuK6xPk7nBpw4hxRara0+OYlXbGSXgAWtr8A7iEYWSeNcGwb4HZbnSTWZNtHC1H63WN8zIUXvzPpARjo2LgAgEY7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pqCiYIgNDjIYXbwdz7+kkB1KM5tEIpZffAYWaZTPTw=;
 b=oqEcKBySDfhMh536GGUfXWxn6QgP+6uo2LX+uHQpBVNeWNApVmKfkbxyauDHYiQmTnyHherwE7jvhCkLj6+H4XKYdljRYc15AnpAogIebto9WXhdLOAiIg1dRNOovybe3kAAIGWPOyV2I4vP+SQXRqLJHj26lluVXYWQ973kMCgeiS3CgZBErwzlBGKmBLF6qYTHthOQkS9rvp3DLkLVkvgRuLoZPQhW3WrsVmaGRM5res2hV70j41nr8GdBxQil3setkaH0BdHe+Hiv80KMm29W9d5IVk7ahJKIWPw4bA2umtInlfUnfTG3G4bZcNZqW2j8KwwgSbdqtMb9jxt1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pqCiYIgNDjIYXbwdz7+kkB1KM5tEIpZffAYWaZTPTw=;
 b=r+/b6mxPEgs8eVn1COSovd8pQmRbs4p9X225HaEdbaetUUWxR4hmc6ST9ugRmE9QmJdSoLyHsH7jmqD0Y4X+8HOEgewafiHm3agAXuBPQ173bnUz6Ie8O0njR1Qq/DQVcLYRkVi5HPRdsSF0N61L0QLXqVKgq73NyiWLy9wgxQVQYjNlVaOVIjwZ/R4m2GQ1ELW5tN2I5jYDYEDhljPE7Yx4XJ3C7eKH9TiMDnaQ/9CBmjGH+Z3PXU6nuhNkHox9JCovA/W0ulwZ6QIlKxsOszLrbpEXalB17n89+YBL0+QvI3Jz0fOEy7e44PX2f5AtcRvi8hTE8SdIL+UD8CUEpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:21:36 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:21:36 +0000
Date: Tue, 10 Nov 2026 12:21:34 -0500
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
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 2/5] rust: gpu: buddy: use Alignment size constants
Message-ID: <avNSng3OxE7cr-12@yury>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-2-082aa9bf5a91@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-chid-v11-2-082aa9bf5a91@nvidia.com>
X-ClientProxiedBy: MN2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:208:23e::21) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 856f665a-aaa9-42e1-0edd-08df3f4f12c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|261009223027099003|10067099003|261026140227099003|261026121527099003|261102123227099003|261021123027099003|261028144727099003|261021121427099003|261022105027099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oHfZVKxZ1/3D/EN3tvCut3d0BiEesEb7+f+RyBdiA5yeZogibOrjJzsuVdb8dhcSln/ek/zLbMgqO76/f2fcjqEgzecHg35B1nLSCBu9ItUswrOukIi8PyLGo/wm5SDO00vrXvU/LX1bXSlSTAko+ebx6OnLI0DDuTkYhPPnqRXaM5M5/t3lQ83dron3Bwn6cg1fSqudE3tpJSbJkvkoJe0bDP+8FjiTP/lsChKElDt4WjS/uwOSiFOlkqWwDsRf15vfptSpUCoaAgoqCdxueKi496PZlp+8ksnuIl6LH/oiPX8RqISrdX1o3AJdCVEgp9bSuyoQCTu2q1M0WDAaQtjjn+4oE2ixrblBtwhq1wGLZ4di/IJMRr4J8k/BG1h6BUzZDl6McFCF/SLD+/WBUJkoLZuvy51eguZ2MtFyZN6/GOQlhcD9ewi+8tfl4aocqppz5tfNPZfDAm20JM2EqFm55BfrauVPgGBEVhC+MtozJQ6dxecbFKd1DDrAjfMnDaQjSUND5xZwraPsGpc9tRbcM1oCNVYEDGG8Nr3TV1ZVZSSzMKPO4sFkoXGPmR4A3G8FgZXsPFtoWk98KWwFw6lQ7nuRQ8+94/xuVXyi4Dp3qIRmlh9pZDqfj2QQc3vh2wvBGpnJXqjinEhzUMEvlECdG7IUxLOzG2uHiBFeyqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(261009223027099003)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34ZPCHTDoZdcdgcmZE8TzTi0/uN7j1aG2OWewlGkUhCRxgsXo/vEM8KbIjs5?=
 =?us-ascii?Q?LSXTIM1tgT1/X62MbmMENLYhXC0ggAmVMCVK8u+3B66KP+s5zhq0odwnMv4/?=
 =?us-ascii?Q?xUmTVF2FMSQUG61rh+xg+FSzXuz0o3yKxyRb7jGk5ngsmfGoqjclUPN4dlkJ?=
 =?us-ascii?Q?CdFv0s9ut5VFtFdNzr5dwD4S3MX4Erj4UDeJWkyankFSEIDvasZ4lFuyJfxy?=
 =?us-ascii?Q?dUkhepBpF72CvS9+hj/nGjxcQv+8eH0f8QKPzRvAb4FX8kZ2hxtQQ/NCGmwh?=
 =?us-ascii?Q?Il1A4d0LcQrZKo3qS2UeNgeFT35wd6eSmJ55kkA8A1JqxTERnQQ0B34JlDVB?=
 =?us-ascii?Q?7MuiSgN7sYbzKPLHxEVnfbe78rS6DmTrRupDaBTZRRnDxX4IPCOjk1xpvnk/?=
 =?us-ascii?Q?k900SwAE+OUVrgN9LeVqHy+38MHwRigtJEdIJpa6Q9FFGdyd2usR3OviRzLx?=
 =?us-ascii?Q?U/d9XtOtHeuAjulYXg/bLNxNioxj5XQFYTo4y7DmxuZA0codT1D18FGYZeQQ?=
 =?us-ascii?Q?dVB4+gh8qZWn3+GtjD1/a/cm1zvTb/Qbth0066x/sWy1d15wnehQeaUph9Rc?=
 =?us-ascii?Q?0QYsrxNUQf2bTQZUFNegxrPFmGBm4dBGL2KuLrxxP2zgs4InrGnFnLTN4ya7?=
 =?us-ascii?Q?cWa6bFAtuI+aoTPi22N0K3Zx45a+73/HJRbXfdLURo6E0Dg21CT2bczuVCDj?=
 =?us-ascii?Q?VdoG2hCOFQVhQv+MvQouwBL/nLOCPLwvJLhAUF/iIqj6d8T7WoGLehTTZGNl?=
 =?us-ascii?Q?EK/gHhMR1/KRHvjMCeAltxz9uTUwZ6KsvZu63maCaMma6ZhUjNs2LIUb9uLc?=
 =?us-ascii?Q?BVO4QkuMSPO3dyWeOPzCQaP/PJk8j4xeLoBqoX0WU0Pr8AbmugcZ6OcfPiX2?=
 =?us-ascii?Q?77xJvmelgZ6+MXWIo0ISU0uN0YVxxCACyfcSVruq+DT0BtE4U/TW4pJmwhiZ?=
 =?us-ascii?Q?H6hNTeikyY2r+cuscKZbczWtmhBaQmHBA/0HXd7vyAXUgZCoqk8s5d3GRxXR?=
 =?us-ascii?Q?WWaCbistwbWkXolfyGQApUfdYvDNdFMP1WryVtVjJqe1tQKGPHNQPng9j9CP?=
 =?us-ascii?Q?Lqv96jsyHocbVb5aq5Q+lHNZMTlqXs18UMua/GltdoUFhNUNpuyLgIZyy4DO?=
 =?us-ascii?Q?+0SqJT7No9X9QWVxpkn9Yn2xOOyxlCwziX+h1RM489Z9pu07XihqtOmD2Kfa?=
 =?us-ascii?Q?lJMDkfRIkCPLbyHp/r3cfSzy7W3rMTqbem3nJsCsug3spJ/hDtMrZ0mY6TsM?=
 =?us-ascii?Q?ET9jkYpwwJZEsZvYFakLunwKF6Op/R0U0FLP8xwtETaPaMqq7o/XKuGpOOYA?=
 =?us-ascii?Q?p9FiDwHaXBFS2lN3aN7Q32mHV2f9njeAwS5fMiYRaQUQhItB7xJhgyDKTVfN?=
 =?us-ascii?Q?3I85wQFdqdxKQKc5BO3RI086dDwJoxCOoFq1mp5yaIwwWdgyrIgJk4werBx1?=
 =?us-ascii?Q?qEcVe3jcgLtNK2Gb7IYNaeAXtPJW+yVkoY7kRjmLZ1lmYDVV14NdsANV0UGy?=
 =?us-ascii?Q?p2Ck4J1I3eB9RE8jmT+RLXJK6nELhlkRITeChDg1R0HyLWLxXWOXDSzlkiH2?=
 =?us-ascii?Q?tCI4JZtGnUO86qZCUWZT9tknBawaOe1L2J5SACmVQAAB7BjzlSKhdW/5GWdl?=
 =?us-ascii?Q?0Ml0DXHb/xb/MjaLpDIM7rkG2KBWxvrkKv/+owUFqLY+RUc5Mxacl2+6BaQZ?=
 =?us-ascii?Q?hJwNQBaUynp1tgvvUNA4h9H8KXZ/BhHB6pzdGW4DRtCV6ekjqhPG/Ntc1v4N?=
 =?us-ascii?Q?EM1ilv6Cdqb0J0vBtGcNhZH9O4qHnxv93IXtDfwouZwjjaPXZHh1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856f665a-aaa9-42e1-0edd-08df3f4f12c9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:21:36.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR1+V8xVf/iKz7N/YjCtcA6EXFuXUoM2F2HODBSX+7o8ftf9/qSoD9ayuxRgYSCxbp5R3VGinM4UJX8jcevmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 05:32:50PM +0900, Eliot Courtney wrote:
> Use `SizeConstants` for Alignment that are implemented now.
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  rust/kernel/gpu/buddy.rs | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
> index d502ada6ebbd..691bb40629d4 100644
> --- a/rust/kernel/gpu/buddy.rs
> +++ b/rust/kernel/gpu/buddy.rs
> @@ -31,11 +31,11 @@
>  //! let buddy = GpuBuddy::new(GpuBuddyParams {
>  //!     base_offset: 0,
>  //!     size: SZ_1G as u64,
> -//!     chunk_size: Alignment::new::<SZ_4K>(),
> +//!     chunk_size: Alignment::SZ_4K,
>  //! })?;
>  //!
>  //! assert_eq!(buddy.size(), SZ_1G as u64);
> -//! assert_eq!(buddy.chunk_size(), Alignment::new::<SZ_4K>());
> +//! assert_eq!(buddy.chunk_size(), Alignment::SZ_4K);
>  //! let initial_free = buddy.avail();
>  //!
>  //! // Allocate 16MB. Block lands at the top of the address range.
> @@ -43,7 +43,7 @@
>  //!     buddy.alloc_blocks(
>  //!         GpuBuddyAllocMode::Simple,
>  //!         SZ_16M as u64,
> -//!         Alignment::new::<SZ_16M>(),
> +//!         Alignment::SZ_16M,
>  //!         GpuBuddyAllocFlags::default(),
>  //!     ),
>  //!     GFP_KERNEL,
> @@ -74,14 +74,14 @@
>  //! # let buddy = GpuBuddy::new(GpuBuddyParams {
>  //! #     base_offset: 0,
>  //! #     size: SZ_1G as u64,
> -//! #     chunk_size: Alignment::new::<SZ_4K>(),
> +//! #     chunk_size: Alignment::SZ_4K,
>  //! # })?;
>  //! # let initial_free = buddy.avail();
>  //! let topdown = KBox::pin_init(
>  //!     buddy.alloc_blocks(
>  //!         GpuBuddyAllocMode::TopDown,
>  //!         SZ_16M as u64,
> -//!         Alignment::new::<SZ_16M>(),
> +//!         Alignment::SZ_16M,
>  //!         GpuBuddyAllocFlags::default(),
>  //!     ),
>  //!     GFP_KERNEL,
> @@ -114,7 +114,7 @@
>  //! # let buddy = GpuBuddy::new(GpuBuddyParams {
>  //! #     base_offset: 0,
>  //! #     size: SZ_1G as u64,
> -//! #     chunk_size: Alignment::new::<SZ_4K>(),
> +//! #     chunk_size: Alignment::SZ_4K,
>  //! # })?;
>  //! # let initial_free = buddy.avail();
>  //! // Create fragmentation by allocating 4MB blocks at [0,4M) and [8M,12M).
> @@ -122,7 +122,7 @@
>  //!     buddy.alloc_blocks(
>  //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
>  //!         SZ_4M as u64,
> -//!         Alignment::new::<SZ_4M>(),
> +//!         Alignment::SZ_4M,
>  //!         GpuBuddyAllocFlags::default(),
>  //!     ),
>  //!     GFP_KERNEL,
> @@ -133,7 +133,7 @@
>  //!     buddy.alloc_blocks(
>  //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
>  //!         SZ_4M as u64,
> -//!         Alignment::new::<SZ_4M>(),
> +//!         Alignment::SZ_4M,
>  //!         GpuBuddyAllocFlags::default(),
>  //!     ),
>  //!     GFP_KERNEL,
> @@ -145,7 +145,7 @@
>  //!     buddy.alloc_blocks(
>  //!         GpuBuddyAllocMode::Range(0..SZ_16M as u64),
>  //!         SZ_8M as u64,
> -//!         Alignment::new::<SZ_4M>(),
> +//!         Alignment::SZ_4M,
>  //!         GpuBuddyAllocFlags::default(),
>  //!     ),
>  //!     GFP_KERNEL,
> @@ -178,14 +178,14 @@
>  //! let small = GpuBuddy::new(GpuBuddyParams {
>  //!     base_offset: 0,
>  //!     size: SZ_16M as u64,
> -//!     chunk_size: Alignment::new::<SZ_4K>(),
> +//!     chunk_size: Alignment::SZ_4K,
>  //! })?;
>  //!
>  //! let _hole1 = KBox::pin_init(
>  //!     small.alloc_blocks(
>  //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
>  //!         SZ_4M as u64,
> -//!         Alignment::new::<SZ_4M>(),
> +//!         Alignment::SZ_4M,
>  //!         GpuBuddyAllocFlags::default(),
>  //!     ),
>  //!     GFP_KERNEL,
> @@ -195,7 +195,7 @@
>  //!     small.alloc_blocks(
>  //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
>  //!         SZ_4M as u64,
> -//!         Alignment::new::<SZ_4M>(),
> +//!         Alignment::SZ_4M,
>  //!         GpuBuddyAllocFlags::default(),
>  //!     ),
>  //!     GFP_KERNEL,
> @@ -206,7 +206,7 @@
>  //!     small.alloc_blocks(
>  //!         GpuBuddyAllocMode::Simple,
>  //!         SZ_8M as u64,
> -//!         Alignment::new::<SZ_4M>(),
> +//!         Alignment::SZ_4M,
>  //!         GpuBuddyAllocFlag::Contiguous,
>  //!     ),
>  //!     GFP_KERNEL,
> 
> -- 
> 2.56.0
> 
