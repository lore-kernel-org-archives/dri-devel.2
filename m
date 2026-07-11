Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2F8C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 13:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD83010E36B;
	Sat, 11 Jul 2026 13:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="ORDaDiVH";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020103.outbound.protection.outlook.com [52.101.195.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AC610E36B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 13:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTPyd00PurWTIhZ8+riIfFvnXdHgZnKehxkXw74Qum6FtDD30dTkf7Xt6PYfu/Hc1zdKZ5Y+KadoBUasZh43wOnDSi7LpEz6aJhpBAPdzAhR4G88K/cU8Bd+dvTdC5cdys2ckCJLk57ZPHpGHLOltvV7ZAFAQIskAOmaLU71UrRdoFSFyGmNct1djHp6cwP7LRwHCJuTzIlaMuV3aaHYcwQHh7FneUOxnL+vqHUvFejeQ/4cTPrBblHEFzGlrFUFO4Ml4KcXV6Fjt4Re4uDlv8LK8A1X9TSr0ozOvDnmiw6cHj4ZWX8rFoCvKl85gG84KcX1sZZKOLYs9VZK1U5MTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii207h6L//BzVM5S+SDs7y1/JlG7+yDORGg5iBxKcFk=;
 b=sifX48xD2onektk2VnI4CWOSw1mKuSSq7D2kL31jeXt7YkxQVyI9HxOgyZbgfqCC1iEcFRdZ8M+TTCiiOf/T5KvKHvin6plq/LW/nsZxB4Bf3kMJYLIDcbSeUZyJVKmJh/ryyBrQErz0GrjIpG1dl2S+BmflBd3KMH/6PutlURVHQLx7RZ2xmc3VIJHL2OGyX46g8B9iHAsSJ2V/pkYDHyCDgvMG+FHw0FD/3cCAUqs2QZRMB6oXNL7jkOSp+BmIGNKttHn/VLYtvoq1+V+cvfvrYO0r4xAIiRon40m2iDUBaNuKaluRlw6LrDjZOI8l1pCEU+CbSNeIXxzIyQxW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii207h6L//BzVM5S+SDs7y1/JlG7+yDORGg5iBxKcFk=;
 b=ORDaDiVHTOjGvyih5OB4Oh1tnopN6rBZxfeaIpVXEpc3xUo4aBlWV9wGn/CK+5NAmupNwmJQFwbTEQ9HYyTj2lixpYPxzXJ9KFfj+5c1TK+FQRspxpGScXTtYfgXha3EWC+RT3ibb5ctXZorSOSkB3gn7l8BRSvrmlyohrlTzQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 13:51:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 13:51:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 14:51:28 +0100
Message-Id: <DJVSHL6XP43R.1INHQRXAG8UA3@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Benno
 Lossin" <lossin@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Boqun Feng" <boqun@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Simona Vetter"
 <simona@ffwll.ch>, "Tamir Duberstein" <tamird@kernel.org>, "Timur Tabi"
 <ttabi@nvidia.com>, "Trevor Gross" <tmgross@umich.edu>, "Yury Norov"
 <yury.norov@gmail.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <maple-tree@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance
 for region allocations
From: "Gary Guo" <gary@garyguo.net>
To: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Greg KH" <gregkh@linuxfoundation.org>, "Burak
 Emir" <bqe@google.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Liam R . Howlett" <liam@infradead.org>, "Andrew
 Ballance" <andrewjballance@gmail.com>, "Matthew Wilcox"
 <willy@infradead.org>
X-Mailer: aerc 0.21.0
References: <20260711063602.426311-1-ynorov@nvidia.com>
In-Reply-To: <20260711063602.426311-1-ynorov@nvidia.com>
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5608c761-986b-48b4-70db-08dedf538212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7416014|23010399003|18002099003|22082099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: hRPzayZ1V6nEMKDh5JOrzB7Jnj8qRCzs29SOuPp2u25eZp7LYxKBkv7c6IZyrB323meP1Sw+Kk4LLKb6dRFWcyRYGxUM2OT2i6VTpM0cUKqp+57pgqSGGLMEXLABo0ItOqdY3Q4g/W30UPJADhWZZt124CTn3AfTIR+TybQA3fwnuO3E1VMhEUqTc4EoFQ4qfw4g0kTTSVKqj1PeBqfFYVWPjkWnPmRMJD+AJgeKWVbULRj+hgEE4TPuRtdXqZa175HekFCuwdhZSUQT0UFCht9sJe3Yp7YMqK48p8F0cHhboi8j33WN2fDktykNwv0zpu5c5vHt9vsaghjNbcT4dPQaskuwBbUSb1sqK8fP04FTxI05AtmYzeCCefukiPRuda9RWcXD6lHKrR/IUcP7few2n0MEOA8zlL5SPlcIQOtVRSlBNQPMQWg8KO1plUmSrNdacrGfxDvtTX2Cyvx3DLgKIzt7o0IRx8l5OfHdHSmlQ056NjBvRlNe/BgwHllyYhSJfZQ/mpY1WZNlhFVnLqNnT6zh4PRwBLcirLrlLTCj+brZh7BuqBkLVI/VWLJghxhuxMLfYxi+9rAZsrac+v6P4e+iqKf0wSvu4oRxPSFPv0pVg1kaEiG7yfoFNajOugj7p0dYqwqs0AMnJwdspdES4MphsNqhssNJt2kRmlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7416014)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1ySnZmU1F0bWd0aytLOG8yMkpkWFprbFBPa2NwNU5hdDZ0VjZyaUdHMDA5?=
 =?utf-8?B?R0ZLYUEwRnZqZTlwS0hpcnp2T3l1aStwMTJKMHBjTUZqZk5LczhybGtPbUh0?=
 =?utf-8?B?NjU2Rkxsa0R5UnUrWllvQW0rbFA5WDdmYVVDbTJMdFdBMkQvblFaSDJQaDNJ?=
 =?utf-8?B?OFp2VXhCZEV0R3psUVBEdk8zMnc3cHJzVVoxcHY5Q2FlVEhCUFJJOVFtRG1W?=
 =?utf-8?B?WmhIVStBOG5DZktJcGRHcDNIa3k4N1hOcFFwNHR5eWQyMHVPSm80c3FxejJu?=
 =?utf-8?B?MFZwZkxxejBMQnk4YmRENmZOZVI1OWhYNENSSU1VNUNCL0Q1SElqaHQyd1dW?=
 =?utf-8?B?OVkxUDNRNzhyVFlmVDVsL3hIVkZ5M0NJRVFuRXRzWWNKSTJsWFBmUjdsUzFk?=
 =?utf-8?B?Vmx4OEgwUVh0NjhiZVVzWU9nV2Vza1FYblZOQzNLcEVUSzMvdXBWS2R0SUx0?=
 =?utf-8?B?MXJWWC9iYlVydUplZkJvZTRMMHZlZUVjSzkyTXhmMElFZ2srYis1LzN3QWxa?=
 =?utf-8?B?WGphOER5cGI4UWVjenlmSUN5Z3BEYVhFWGt5elQ4bVZCbzlZakpCeFFQUE9W?=
 =?utf-8?B?LzREVE1QWWFjRTVDczMyQWtUM01EQUFXb3hucXVVbnpiN1lNZkNYZFlPV3dn?=
 =?utf-8?B?TDBPSE02djdpN28zT1J5VzZJSVpLQ0cwN1BtSFJ0bmw1eXRwalcvTmg3eUZ0?=
 =?utf-8?B?NEg0RU9ET0doeDdiYnVCdUd0REFRNlIveFc0SzJFeGtwYU5UNnp4NDI0dWFS?=
 =?utf-8?B?cUFjQ3dhZEVGb1pIbmxCYTd2Y2c0QzZrMkY5cVdmN3FNd25ZQndpbGc0ZDRB?=
 =?utf-8?B?YlFBNXNZUElPSVhZSGg5TStXWFUyK0hmOENIUnhKdWNvNk0zc3RRazVES2V5?=
 =?utf-8?B?Zk9lZ1I4NlJ6dFI3WFVJUFp0WmwzNEtRVnNTTFQ3U0hRVjBwM2xhWnhrN3Fh?=
 =?utf-8?B?ZFFsR0VuVlM0NzlQQ0c0UmJsOTVwNWUzbVIwUnRTL1pmWFlmYWxGTlVURFVY?=
 =?utf-8?B?QUFJTTlwU2RvcHdvS2s4QVFrYit6dWRVQ3o3cVkrUFpHN0N6RUZJdlJNZFlC?=
 =?utf-8?B?NnQ0bDNLVmNtWWF3R3Byd0JRM3pOcmkzQUV6VHhVWFkzbUxra1JmaWlNNTFV?=
 =?utf-8?B?S042YmlPQVFHTUVVTkFsbE84d3ZWNGp0ei95NGRWV2ptZC90Y0FtYWJIWUFV?=
 =?utf-8?B?dlJUbU1jQTNieERCeXJxamFSZmgrMVFabWpBMklVZ2Jta1QrVWxZVXBPWkNT?=
 =?utf-8?B?dEhYblkzSGViNUNTWlZRRVduRm5iOWRUWUFKbHRXOWR3ZTNHOTlXRnJzeHd6?=
 =?utf-8?B?Zk5BdFhiV3RKN3JKc1NVUVIybHV4UUZDSnFQMDZuUm5ld3lIYWgwN3hFUEIw?=
 =?utf-8?B?ZFRyWXllNTc3MDdrWklBR2NQb1lZMzMybk9ZSFVVYW5LQ1NPRVhHSHZ5Y2dp?=
 =?utf-8?B?cUpEb01ObFFScGFFbEp4RXBJZEs1QXduZTU3SitXTnpGeHM2S2xiL3lBdnh6?=
 =?utf-8?B?aGo0UU9NTTByV3Exakh6MytKUkNKQU5WdWFBcThyM0xVOWp4MFVqK1BwRHlP?=
 =?utf-8?B?RjlHdVEwaFFjSTNIQVpqRnRWcldvUlMvWWw0a2xZYi90djFzQ2V4bzlzWHFw?=
 =?utf-8?B?Q0tpQ2xqY2dObUdSNmpVMnVyNnVtRjkzd3MxVmJZRVQvNDF5WHZ5WjRuY0VC?=
 =?utf-8?B?YjlzK3BDWEl2dnlBK056RXRhTGVzckMzSUMvS2llSlR5Y09obVU0WFpKbmVz?=
 =?utf-8?B?SWRaREhOaEpJWVgvYTQ2UTJOWllkTEF5WThTaWFvTEtWU1RPZHErNlIzamtU?=
 =?utf-8?B?Tm13Uk9MYVdPTDlCMEFKYWtrZlFQQWk5U3FnRTR3S2F4OXVZTkZWWmt3SEI1?=
 =?utf-8?B?dWRwM29kUHZlb3d3cStDdkNKWWk4NEUrdGxXRkc2SkxiN0VkeXNwdXp3WFRN?=
 =?utf-8?B?cm91TE9GQ2tMR0lTcGI2N25iNjlCd1Fxc2RLZDBmbDFyODJ1T0dQYWVPOGxV?=
 =?utf-8?B?aDExYk9zZ252R3hHVWhIaFlNQktEdFRVVE56QkVvQVlRVGZibmFNdW9rYVVO?=
 =?utf-8?B?UXZyM1k5QnBpNTNlQXlyQTE3b3dmUUZ6N3l4OVJxY3dESjJ0YitzNi8zVlhh?=
 =?utf-8?B?OVZLMElCVzFpV05qc3crSG1RUkZ2MDhOdnJVdng5OHQ5NGU0T3dienQwd3Bt?=
 =?utf-8?B?amNQTU9aRmdPeVY5SkxxKyszRHZ3S2xxeVlBbHRYWXNrS2FKYk5oNXdZQjJR?=
 =?utf-8?B?QjR3UkY5VFRrQVlMeVB2Y2RVcnFrMzVJUWxXdWUzTWRpcGVSWkppbkRCS0FZ?=
 =?utf-8?B?UUtUQnA5UnFOUDRnY0V6ZE5QcTFxNy8welpYVDBOZUo2dkY4azdNUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5608c761-986b-48b4-70db-08dedf538212
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 13:51:29.1599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbphYCaFVqyd6AeRnrG+MqF0CCcaSrlGd3kU5Mdmx4ljwduiYXhlVZlkDtOsnDS8cioUpZklakTntGXmPwBx/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6560
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

On Sat Jul 11, 2026 at 7:36 AM BST, Yury Norov wrote:
> Compare the cost of allocating and freeing variable-sized regions using
> a bitmap, IDA and a Maple Tree. All implementations process the same
> randomly generated sequence of region sizes, ranging from 1 to 32 entries=
,
> until the configured capacity is exhausted.
>
> Run the benchmark at several capacities to show how the approaches
> scale. Report allocation and free times separately because bitmap,
> IDA and Maple Tree removal have substantially different costs.
>
> On x86/kvm, the output example is:
>
> type       alloc (ns)      free (ns)   capacity   memory (B)
> bitmap      179573071         342105    1000000       125000
> IDA          46555636       33931498    1000000       134864
> maple        18629665       19741396    1000000      1548304
> bitmap        1630912          30933     100000        12504
> IDA           6144785        3354590     100000        14288
> maple         1745026        1825032     100000       155408
> bitmap          28448           3374      10000         1256
> IDA            418978         333641      10000         1872
> maple          185398         211138      10000        15632
> bitmap           2253            610       1000          128
> IDA             42755          36432       1000          144
> maple           19728          23474       1000         1552
>
> Reported IDA and Maple Tree memory figures exclude slab overhead
> and transient allocations. The Maple Tree figure is additionally
> a lower-bound estimate that assumes fully occupied leaf nodes and
> excludes internal nodes.
>
> IDA has no region-allocation API, so each region is implemented as
> a sequence of single-ID allocations. The IDs remain contiguous
> because this benchmark fills an initially empty IDA monotonically.
>
> The benchmark is motivated by the discussion at the link below about
> choosing the best data structure for the channel ID pool with the
> capacity of 2048 IDs for the nova GPU driver.
>
> Specifically for 2048 IDs the result is:
>
> bitmap           3907            831       2048          256
> IDA             83545          71007       2048          848
> maple           34632          39710       2048         3600
>
> Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@n=
vidia.com/
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
> v2: add IDA benchmark (Matthew)
> v1: https://lore.kernel.org/all/20260711013910.349586-1-ynorov@nvidia.com=
/
>
>  MAINTAINERS                  |   3 +
>  lib/Kconfig.debug            |   9 ++
>  lib/Makefile                 |   1 +
>  lib/region_alloc_benchmark.c | 174 +++++++++++++++++++++++++++++++++++
>  4 files changed, 187 insertions(+)
>  create mode 100644 lib/region_alloc_benchmark.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7cc4bca5a2c5..9e487a94aba4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4615,6 +4615,7 @@ F:	lib/bitmap.c
>  F:	lib/cpumask.c
>  F:	lib/find_bit.c
>  F:	lib/find_bit_benchmark.c
> +F:	lib/region_alloc_benchmark.c
>  F:	lib/test_bitmap.c
>  F:	lib/tests/cpumask_kunit.c
>  F:	tools/include/linux/bitfield.h
> @@ -15581,6 +15582,7 @@ F:	Documentation/core-api/maple_tree.rst
>  F:	include/linux/maple_tree.h
>  F:	include/trace/events/maple_tree.h
>  F:	lib/maple_tree.c
> +F:	lib/region_alloc_benchmark.c
>  F:	lib/test_maple_tree.c
>  F:	rust/helpers/maple_tree.c
>  F:	rust/kernel/maple_tree.rs
> @@ -29323,6 +29325,7 @@ F:	Documentation/core-api/xarray.rst
>  F:	include/linux/idr.h
>  F:	include/linux/xarray.h
>  F:	lib/idr.c
> +F:	lib/region_alloc_benchmark.c
>  F:	lib/test_xarray.c
>  F:	lib/xarray.c
>  F:	tools/testing/radix-tree
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1244dcac2294..40872263cff1 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2683,6 +2683,15 @@ config FIND_BIT_BENCHMARK
> =20
>  	  If unsure, say N.
> =20
> +config REGION_ALLOC_BENCHMARK
> +	tristate "Benchmark bitmap, IDA and Maple Tree region allocation"
> +	help
> +	  This builds a microbenchmark comparing variable-sized region
> +	  allocation using bitmaps, IDA and Maple Tree. The benchmark
> +	  runs at module load time.
> +
> +	  If unsure, say N.
> +
>  config FIND_BIT_BENCHMARK_RUST
>  	tristate "Test find_bit functions in Rust"
>  	depends on RUST
> diff --git a/lib/Makefile b/lib/Makefile
> index 7f75cc6edf94..adb18810e3f7 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -64,6 +64,7 @@ obj-y +=3D hexdump.o
>  obj-$(CONFIG_TEST_HEXDUMP) +=3D test_hexdump.o
>  obj-y +=3D kstrtox.o
>  obj-$(CONFIG_FIND_BIT_BENCHMARK) +=3D find_bit_benchmark.o
> +obj-$(CONFIG_REGION_ALLOC_BENCHMARK) +=3D region_alloc_benchmark.o
>  obj-$(CONFIG_FIND_BIT_BENCHMARK_RUST) +=3D find_bit_benchmark_rust.o
>  obj-$(CONFIG_TEST_BPF) +=3D test_bpf.o
>  test_dhry-objs :=3D dhry_1.o dhry_2.o dhry_run.o
> diff --git a/lib/region_alloc_benchmark.c b/lib/region_alloc_benchmark.c
> new file mode 100644
> index 000000000000..0e000c4f9926
> --- /dev/null
> +++ b/lib/region_alloc_benchmark.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Benchmark bitmap, IDA and Maple Tree allocation of variable-sized reg=
ions. */
> +
> +#include <linux/bitmap.h>
> +#include <linux/idr.h>
> +#include <linux/kernel.h>
> +#include <linux/maple_tree.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/random.h>
> +#include <linux/xarray.h>
> +
> +#define MAP_SIZE	(1000000UL)
> +#define REGION_MAX_SIZE	32
> +
> +static DECLARE_BITMAP(alloc_bitmap, MAP_SIZE) __initdata;
> +/* One more request guarantees that even an all-ones trace reaches ENOSP=
C. */
> +static u8 region_sizes[MAP_SIZE + 1] __initdata;
> +static unsigned long region_indexes[MAP_SIZE] __initdata;
> +
> +static unsigned long __init benchmark_bitmap(unsigned long capacity)
> +{
> +	unsigned long count, index;
> +	ktime_t alloc_time, free_time;
> +	size_t memory;
> +
> +	bitmap_zero(alloc_bitmap, MAP_SIZE);
> +	alloc_time =3D ktime_get();

To eliminate possible effects of optimization messing up benchmark, please =
add a
barrier() after start timing and a barrier() before end timing. Probably yo=
u'd
want one between each loop iteration too.

> +	for (count =3D 0; count < ARRAY_SIZE(region_sizes); count++) {
> +		index =3D bitmap_find_next_zero_area(alloc_bitmap, capacity, 0,
> +						   region_sizes[count], 0);
> +		if (index >=3D capacity)
> +			break;
> +
> +		region_indexes[count] =3D index;
> +		bitmap_set(alloc_bitmap, index, region_sizes[count]);
> +	}
> +	alloc_time =3D ktime_get() - alloc_time;
> +
> +	index =3D count;
> +	free_time =3D ktime_get();
> +	while (index--)
> +		bitmap_clear(alloc_bitmap, region_indexes[index],
> +			     region_sizes[index]);
> +	free_time =3D ktime_get() - free_time;
> +	memory =3D BITS_TO_LONGS(capacity) * sizeof(unsigned long);
> +	pr_err("%-6s   %12llu   %12llu   %8lu   %10zu\n", "bitmap", alloc_time,
> +		free_time, capacity, memory);

I wonder if the numbers could be more useful if it is somehow normalized (e=
.g.
by how many iterations are performed?)? This number can be computed by addi=
ng
up the prefix of region_sizes until it cover all capacity.

Also, the capacity should probably be made part of the report header for al=
l 3
ID allocators. Given this is randomized benchmark the single line, when tak=
en
out of context, is not very meaningful anyway.

Something like this might be better (fake numbers below, you might also nee=
d
some fix point printing):

capacity =3D 1000000, regions =3D 100000
type       alloc (ns/region) free (ns/region) memory (B/capacity)
bitmap              1795.730           3.421                0.125
IDA                  465.556         339.314                0.134
maple                186.296         197.413                1.548

capacity =3D 100000, regions =3D 10000
bitmap               163.091           3.093                0.125
IDA                  614.478         335.459                0.142
maple                174.502         182.503                1.554

capacity =3D 10000, regions =3D 1000
bitmap                28.448           3.374                0.125
IDA                  418.978         333.641                0.187
maple                185.398         211.138                1.563

capacity =3D 1000, regions =3D 100
bitmap                22.530           6.100                0.128
IDA                  427.550         364.320                0.144
maple                197.280         234.740                1.552

Best,
Gary

> +
> +	return count;
> +}
> +
> +static size_t __init ida_memory(unsigned long nr_ids)
> +{
> +	unsigned long entries =3D DIV_ROUND_UP(nr_ids, IDA_BITMAP_BITS);
> +	unsigned long bitmaps =3D nr_ids / IDA_BITMAP_BITS;
> +	unsigned long nodes =3D 0;
> +
> +	if (nr_ids % IDA_BITMAP_BITS > BITS_PER_XA_VALUE)
> +		bitmaps++;
> +
> +	while (entries > 1) {
> +		entries =3D DIV_ROUND_UP(entries, XA_CHUNK_SIZE);
> +		nodes +=3D entries;
> +	}
> +
> +	return sizeof(struct ida) + bitmaps * sizeof(struct ida_bitmap) +
> +		nodes * sizeof(struct xa_node);
> +}
> +
> +static unsigned long __init benchmark_ida(unsigned long capacity)
> +{
> +	struct ida ida =3D IDA_INIT(ida);
> +	unsigned long count, index, offset, nr_ids =3D 0;
> +	ktime_t alloc_time, free_time;
> +	int id =3D -ENOSPC;
> +
> +	alloc_time =3D ktime_get();
> +	for (count =3D 0; count < ARRAY_SIZE(region_sizes); count++) {
> +		for (offset =3D 0; offset < region_sizes[count]; offset++) {
> +			id =3D ida_alloc_max(&ida, capacity - 1, GFP_KERNEL);
> +			if (id < 0)
> +				break;
> +			if (!offset)
> +				region_indexes[count] =3D id;
> +		}
> +		if (id < 0) {
> +			while (offset--)
> +				ida_free(&ida, region_indexes[count] + offset);
> +			break;
> +		}
> +		WARN_ON(id !=3D region_indexes[count] + region_sizes[count] - 1);
> +		nr_ids +=3D region_sizes[count];
> +	}
> +	alloc_time =3D ktime_get() - alloc_time;
> +	WARN_ON(id !=3D -ENOSPC);
> +
> +	index =3D count;
> +	free_time =3D ktime_get();
> +	while (index--)
> +		for (offset =3D 0; offset < region_sizes[index]; offset++)
> +			ida_free(&ida, region_indexes[index] + offset);
> +	free_time =3D ktime_get() - free_time;
> +	pr_err("%-6s   %12llu   %12llu   %8lu   %10zu\n", "IDA", alloc_time,
> +		free_time, capacity, ida_memory(nr_ids));
> +	ida_destroy(&ida);
> +
> +	return count;
> +}
> +

