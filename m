Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9B7C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 01:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9744010E04B;
	Wed, 15 Jul 2026 01:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqMMCBIc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB7310E04B
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 01:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKhaCvgV1i6lMsEcrd4d7JUz0HJ/iSnJyf33tx3fucuLevlMwOLqFkQ92sNsnValvG6UMiSFr3BcLHpPNRu6yWEiykPOLZaK9GrRrJ4Oz1GxfO9YFsvpT9ExkPvWttSZ9eC2C0JWbhtVlAUDhOY/kxPBrW+HlqqwQ/qO7I3AQooT0XVwE6jCZsQPds3Aaaf8Wx++v9GbzaeA5lZgKT1V7W7tyOCk2L85v1uhI7k3SFoCXGOoaKmccUr6kE2EPlOIylp+olq4gR3jAuNx9Hoz59NTyd31Vf7RZsyRjdUnaNLqVRglYRJATZNR5xWkbVRo9RWhE84knsGu8mlgD8qVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vu+X2gnygESAb3PLoT+T0leX8t7SNMvbP+UeF7k9ck=;
 b=lv3yw9MKr5RPYZyp5YnI+T6VDqp4svlsxkg6kZwUFDnvJxMCPhdw8FUFXbx84BWHSZ/Z/5Gy6ug9lqsY2Fm/9UAGd1M5eaPmU2ak7W44M9e+B3+xD1Gwv3NNVlkOjohNL2IgQutFTn87oCwVAgWxPdaPs/DDIM6R1q0Zaxm3GsDXYL/EnYMU+EE0F85TwpTnToOPU9p+TYOdtqilch6wb+PSZE3yl7rwk+3kjBmyKdyH0ixMDNnU2uvfL2lXmsxpv1ty+2k82AgupYiFT4v6FoBimITeECRo0kaPsWJPkhceCc2nQwXgBErSi6EXSOI/UkB2oGihmHD4dZxaKDGk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vu+X2gnygESAb3PLoT+T0leX8t7SNMvbP+UeF7k9ck=;
 b=uqMMCBIc2bdHze0Ks/MEwRJWURI6AzPEAOtujy883h7mI/SJqOBHwvZw/3yqlHAC2Ddbtnr81DzZ3ULHDg+whmoA1cHWB46MfIjMGiSb5lMUujZLB1qAjKoTd7Jc56ZqyxasrXMcGOqvBQsnD9C2RfEabq5QDSXzFEfUkW0jKscW1/idKFLMKZpxwrxhacnyl1iLGU3xQueZOxK1uzgpdOI6j5dj7eFJIJ4EzxP5bnoftWXOxLOvePGoLQwpODh+r7l9XmKwfmnsoVnsyVnwkkdQY9Yil/U+5s0bqF/5MkvYTeZ+7Rupj8kggjnwJBEjHXmPuXlPJkzASDSheRsCCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 01:49:48 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:49:48 +0000
Date: Tue, 14 Jul 2026 21:49:45 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Tamir Duberstein <tamird@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
 Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>,
 Zhi Wang <zhiw@nvidia.com>, maple-tree@lists.infradead.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance for
 region allocations
Message-ID: <albnOd3yKOiF2GwN@yury>
References: <20260711063602.426311-1-ynorov@nvidia.com>
 <20260711082725.12176-1-work@onurozkan.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711082725.12176-1-work@onurozkan.dev>
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a680a69-c3a1-47a9-1809-08dee2135a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|3023799007|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WfHMcq9Ple5SN7xJn/NYzHspFPpn1bdMs7E9dDNu7PfN1eoFV2fRZinAGXRyHN93CjlbITuzGE+Gl5mKK9yTcFM4Tx0rWPcUeQRHIuJJz/9kbLPGkjonjGhA91xCt9Y4Dx9EWCxK8mT0LBRK74JTI4X9o0Ik7OdQF5HuMx7SP7WGVcdlPOFnS0KDfsM5sGpertG9rJ6XArADiODhCJOAPi4wOV/Qsm9dJxGwi/oW40jVapK0ZAbh0bXoWwi+Umoy2JD+K1StcxTr6CurX4oBB1uYYtRY2kWI8ve6CyVnapfV4t3A2Q4aMudU4GgacgTq1T2oGBFtamDHx11tWpGJ8nbHjEZQzj3QMztcr4SoaCLWpDKW/mpea6gBlUbgWDrEmOdwCgXDnqY+LTFL/xz3XkfMHwC41pWDzNzjvNHxBJensOvHghkwN/qbpC1SSx6S1ED3AeukdRQ4Vwe7c/Kyp4l+JP+J0/+xOCnf8gBETcaXawtCB3s7nnym7Mhfqt+5GI8aIRC7hGaf5EbeqzHxesfBQzLFACpYrznwM+LMgi47gf1RCkVyv8R1IqXnGYRas8BEjvbvWR5kO13Dpq8Z49NegI6ObKpbx96zCak12F9SSs2Z/5qJlaAFHBGOAdy/FoSbs8V7VnhqdJGKUxCp618ep2HfhLnXlTwmIYJF/3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(3023799007)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/2arx4+N/Q7dTRrijSSPoSsnumFj1XMiFX6KrZ09IYq2HyPhlpX9c3OebQ?=
 =?iso-8859-1?Q?feDpaoTwqYa4p5HYHxhRqkkkh1X6nZyzt2sQoMuZTREt/n/lUikRFBS7By?=
 =?iso-8859-1?Q?uwKgKJu+rcTo8z6wMnTrRNb1d5qGP5xiNptK62lVQrU73C50y59HPmjseM?=
 =?iso-8859-1?Q?PeOzR39J6Dhxy72YwjZIvIPDcJ5nSXpJwQna7PLhYYnjJLphpBbpdSJUht?=
 =?iso-8859-1?Q?mxBK+8xqxpx6qzDYw9Gux4URrlrL1v8mjTXu6f92ne2/phsDH+AREs3y+x?=
 =?iso-8859-1?Q?URaVzxosRlMKiWhghk7DhiTL1uCoJeQAVZ63IPEu978eqf8E72qcfG0bXo?=
 =?iso-8859-1?Q?OGTxKpQ5trnsim4a84Fqh7zBvRvCzfLDPnXmbfwYdp91cOZK8wBXGyLW6o?=
 =?iso-8859-1?Q?ezJXxdh3eY2n802xewHjhyWG88rA2NXDTgb7Kk5QKgf94MymazGh/geE+B?=
 =?iso-8859-1?Q?1mr/xdGKouM65b5d/WO/maBQi7gugn5MbQU3bPUceOygeyyrYKfvVtnTxn?=
 =?iso-8859-1?Q?FQmZLflGyftaNwAaKSv9gzyKa0yVsJE8VlSrBCWF/TvFh2T0Mgaa0KVOWm?=
 =?iso-8859-1?Q?mhvEjMG2mxMQmj8JYDcpQP2/fz9ogpjPixOHCFQ+3095AIXRELOb++cA6I?=
 =?iso-8859-1?Q?XijYcknHFyIK3pHGBN8NowVVvlmelctj19z4pgzvgJ3uW30IVCh5rCVK2f?=
 =?iso-8859-1?Q?oxuZKayWg+gdS3DzMkQ294t9PvLi69ogvQ9+NvRt52+20ToBZKYo0PrGkS?=
 =?iso-8859-1?Q?IsPiTTwte0JNMluNZeGYkq5xHyyyw8fqYonQ65Pa9Q2Egm3wFcIvlQWQQZ?=
 =?iso-8859-1?Q?LbtLwGe0V20Xt+OI7qozsfH6DiZmbBiQG7m5waiq1Dqotovzz7b6knmrmJ?=
 =?iso-8859-1?Q?yJBGomDiPEaEEeSv6LVFu/GUAPjcnpPIgZ2E4R13aD72M041nBE9htsUFg?=
 =?iso-8859-1?Q?gJVDDlIL3YH/UMN1HJ4ywlB4jD+DjPICrCePHaEojWPWchh+t07YybnJW3?=
 =?iso-8859-1?Q?VC179tbeHspzwHJYD8sFQar7Rg1B3JiP7BbmKAkFWNoAOThs54Q82rGg5y?=
 =?iso-8859-1?Q?XEGohZWuuZU237Abhxk42LcIZqEoDo7zpgFKu1/o3RNoGmQHx81G4wavhm?=
 =?iso-8859-1?Q?ohmd6vgckf1KuSoC8DCru2MRZ6tIJkWYp4wbvg5JKlhD/wmMgCxejgHm2E?=
 =?iso-8859-1?Q?pK9pvDSTia0aLKzgkfaTplF+/4K2OYaukvj46LynOOrAUIn7exTG9YQiYC?=
 =?iso-8859-1?Q?pJUwL58kemyH1dFioc3XkNz/kjVZfhkOILA/Ccsg79ezgw7WZi4sUBcGnJ?=
 =?iso-8859-1?Q?3QZWi/bTVgvlbFeSYEAkhHKoDmCggvCf6RMuGo/rdyUghEMx0a3VrT0QZB?=
 =?iso-8859-1?Q?uLR8fZvSj+rclg7imiNJodfIxSI4F0wyBqZfEvPomwQHAtaNPkAH9KD8iL?=
 =?iso-8859-1?Q?Xu4wLV6GoQ7hyRULE/HKkQ7x0uDahgMnP/QAWR3mvYqCnIaA1PN/BR2jo/?=
 =?iso-8859-1?Q?wAEYxl/4srXVXLExrcUbLn4a2jr3vQYz9VvrWR7sWaJkKMAlyQEunWAsKx?=
 =?iso-8859-1?Q?soFecg41Z1o/yt9Q8eBxpfhOKjtw5uh2ZmWjRXYZrd08JGFr48AZ1/DR32?=
 =?iso-8859-1?Q?9Dv/38dRDCSxb9Jb6aqOJ7lICxM9KNLpG1k71dFatxjFnMYRbvSuNJjrIn?=
 =?iso-8859-1?Q?XIvz9UrSpBQWTQWXqrvhDYXOmkcJ9X89qQiDs7u4+ykPnZjFPMSKAcHoBS?=
 =?iso-8859-1?Q?lG53IrnMd+hlfmIkYtJQ2/MkjpOUyQWPqP5tTce4nYO7rDu1b/loRg09T/?=
 =?iso-8859-1?Q?wv42oACVfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a680a69-c3a1-47a9-1809-08dee2135a29
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:49:48.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXCVCvk903qmLktjkL5Vs33qwxiUcnN1IYztEEDI8rBooiCAwNbUD9E78muXUG0xgI0hGDozUIg+0AybIReaNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

On Sat, Jul 11, 2026 at 11:27:08AM +0300, Onur Özkan wrote:
> On Sat, 11 Jul 2026 02:36:01 -0400
> Yury Norov <ynorov@nvidia.com> wrote:
> 
> > Compare the cost of allocating and freeing variable-sized regions using
> > a bitmap, IDA and a Maple Tree. All implementations process the same
> > randomly generated sequence of region sizes, ranging from 1 to 32 entries,
> > until the configured capacity is exhausted.
> > 
> > Run the benchmark at several capacities to show how the approaches
> > scale. Report allocation and free times separately because bitmap,
> > IDA and Maple Tree removal have substantially different costs.
> > 
> > On x86/kvm, the output example is:
> > 
> > type       alloc (ns)      free (ns)   capacity   memory (B)
> > bitmap      179573071         342105    1000000       125000
> > IDA          46555636       33931498    1000000       134864
> > maple        18629665       19741396    1000000      1548304
> > bitmap        1630912          30933     100000        12504
> > IDA           6144785        3354590     100000        14288
> > maple         1745026        1825032     100000       155408
> > bitmap          28448           3374      10000         1256
> > IDA            418978         333641      10000         1872
> > maple          185398         211138      10000        15632
> > bitmap           2253            610       1000          128
> > IDA             42755          36432       1000          144
> > maple           19728          23474       1000         1552
> > 
> > Reported IDA and Maple Tree memory figures exclude slab overhead
> > and transient allocations. The Maple Tree figure is additionally
> > a lower-bound estimate that assumes fully occupied leaf nodes and
> > excludes internal nodes.
> 
> The report itself doesn't make it obvious. I think "memory (B)" can be
> misleading. Perhaps we should use a clearer column name or add a short note
> before/after the report for explaining the columns?

OK, will add.
