Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF551C4453D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0766910EF7C;
	Thu, 23 Jul 2026 02:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AV/67Xj+";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013049.outbound.protection.outlook.com
 [40.93.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2983810EF7C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBEd2XfBcrFQFjxj8V+Y4QPUCwT4OopMp8Czf4yCplK+OrDIhIECwrSG92uSsfBGTVG2tvjrRk78F/d/N6ZLRs8FgZSQzN81QmWzSuKoOhYG9lGTCO8iqcEZoVYUB1mlZCSbc51ge9PygVmudMxrL5hm4xV2WyxOVJ92gZJJkBDv2a93TXtTw9D5UbovtjnywvrYlvFDwfygbXYXrFlWHCt7LkzUELdInwpn1cOMhbhLZ9hthFwCSBNDEs9zMev5fBWZIRjw53U6J94+FMvlCp58tzpZ6JN9FKwMhdwBgOJ5T06l/gruCD5UuiVQjNRLVZaINjn7R27++iqjIijTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTajG1t/gmFQOIH8oZ5Q/m5dM7fu2G5I/3qpofyW+cY=;
 b=O46Sk3FsS46Tk0BYD9wIg3Mr6Z9HBaLmFr/HXyLTwWE82EwRmvPv5u+qbMk0W0YJdAeEtiXYgTQRqlrNu3uy+dlAhgXvjETJk93uPeey1l4MUaOxpYG3FNQ5/HUs+aglbSR/d44mrOUZ8pyzdhP1h9BHIXDO+FPlwzdO7AfYb/Fh4eYPClB39UAyY8tCgPy/EPLuZ/wmhlq+rTkIcBrkTV7etXC7DIDPOdgvgFGul1+IZiakM9cyLyCP5326M0kdzsDfKte2rbtQRbxvifoAujGv5n2D2+kFIdQRESyCy83MWEWbVSsJ42iiDBcSI2J5zoCSNcq2fKsmGwRmcZDPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTajG1t/gmFQOIH8oZ5Q/m5dM7fu2G5I/3qpofyW+cY=;
 b=AV/67Xj+in4QQgKPB7XmIIFSyU3LXHBW2cnOnwgWswVNxCVrm6ZfSJ8Gst46lPjEMjl7HmT995JOlHSnhEHlX6E6SohkkgqEYO51Mxk6+8v2kdqbq2D1STW7hmFHyrDwuAVbNJqehZdKgRYZWYb2bX5iJ+rWtoWkMpmKCNTr/RveQ0qc/oNWhWWmglDEaNg04jJ8Yxl2uTyT8OLFLyh8CEYy16QN2nnbmXaMieHWth+BHCUrTI4jlidZccXMTHob1r0UtAUyqHjxWZBwkVgBWINwVUUg/1dL0nWGYgq76coxD0gbTswnECJfK1UGoDiZGArV07LvRY32k7vjcSvu1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:56:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:56:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 11:56:20 +0900
Message-Id: <DK5M2IUEHQQ6.JUL3H2MM4AMM@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] gpu: nova-core: gsp: ensure LibOS DMA
 allocation lives long enough
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-4-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-4-8e3d8bc32bb9@nvidia.com>
X-ClientProxiedBy: OS0P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: f1431057-f958-4943-1888-08dee865fbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: yYwmWF6WO53eyAtU8UCVuI4NacYOwmMv5EVIi0tYrpn9d0Rd3TRQWisHNO2mwhDvE5hxKYfJMUi0YSyRrwEqP8n3Xhrdvnc0pvromH4Ogd/dPqmOveQiASbi6QmdmVJjgKQNitTsYA9593Hdm1aLDSZSwIHx//ghD0JMQkN0S270eLVwkrKhJcgL9rAkANAre8qGa/SuPYPYM35GGV0NmsTHiOkEkSiitdntPOL9LTXwL/Gy2rbSlYotCZWuw/RMTCQA0TNiAa/x95G1lKhmlG/Wq/BUQf4OrU0m5y5A9pzeCMTaFS0+vwvO8JwW2fgTMLjl4FyVRn85Q4088EFc6mm1yhuZkjwPqZ2TEDbewS9OTpJsSd9Qviht7gFi2YmrjZc6OXjRiWbA075UjDSMSyfFfY8sKzxufpFQ9TaFwB6+21npfz9L5LOfDb8++aLnEs/dxTtUvVfacBsCSwPj+VpzJFLS/7Ii9A+tBYh6m+QMPvxhncZLRQ+aO3YojrFkeQe8I8PiRw5HICTLjOl4ZuLxFkMz4FdvxO6CKbC8qTNOQ6S16WRsw4oKO9ct/vmC9nau/uABuCPECOcV0PzhKmROgzas/2vA7+7S/HzL5iQADHHs6u2Pce3YRyM4hpva4xTpQUeNV2fO2argdndkdKJv1EjmrBqvO0QUqV5dW30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVB0UG9Pc3BuWVpnZStLNGV3MC9VUW1TSERHbUhWMERhUmpxQWlNYko0M3pG?=
 =?utf-8?B?NnBKYncyWDlxVVVaSlFCVmgvcjJ3c1F5ZGxnWGxsRU10NTNNb1ZvMDVYekZq?=
 =?utf-8?B?cU82UVQ0MUdsYjJjSEVzOFNvQitKZHNRU2FtcDJhQ2IxU2g1b2w5YWhITEJ4?=
 =?utf-8?B?aTgrZDlYTVMrL0pYZDNYVWl6SHowam04K2ZlRkovYysyWVJtOVd0TWRBTE9t?=
 =?utf-8?B?U3BsOFJaaS9ZR2pMdmdxRXY0WnJHU2pORkdWZ2tWR0FUaGN2bU13K1piOWNK?=
 =?utf-8?B?RXcrQTY1RzhoeUxIcFZieFpPSzJ2VWpvMWZJQXhWenNTVENqUDlkcDkrdHk2?=
 =?utf-8?B?Szg1cjgvNlAyM3FqZXd1Mk9SRzlZeXNpaXNZNU5sd0NpdUo3emRVTEZmN2FX?=
 =?utf-8?B?MEZpbG1ZRkpyNkIxMjUvbW02WEU0WUthOWZSekc5alVzamZoR1I0ZE9YeW4w?=
 =?utf-8?B?a3huZUdQenB3K0VsWUExcjNnZWN6WUoyQ1VrVUFNTUJBQ0hnL0s1R3pOM0hV?=
 =?utf-8?B?dFRKbWRvM0FWY2Rhdmp0cUdDUHd0cXJjSW1WSk9Mckd1WjRtYndpNldoQ1pJ?=
 =?utf-8?B?dS9odmF1M1lIS0VDZ0NUby91eEVod2k1ZTd5K20wYkJFc0prcTlrblEyV3FM?=
 =?utf-8?B?RmtlY21nVStISjczUTViTENXaWd2OVMvZ3o0Y3lVV0tIUW84eFk0UW10U25V?=
 =?utf-8?B?YUVJUzlSeWx3RWxmNUl1MEN2Ujk1dkI1R0QxcTVHSGRGYTNQeHdwQ2lVcnJE?=
 =?utf-8?B?dGhFanQyRGhDZGQwS2lralVvL3FnN052Q0hTczNHMVJjWGhva09XcHRPdktQ?=
 =?utf-8?B?Q2dQUlhBUmdEM2F6dUFYdUdxcmloR0pOa2h3T2NEbGEzbXhqZDB5QW5FdFFn?=
 =?utf-8?B?ZmpXSVVSVFdaeTJJWFpHN1RkVSt2R2g0L2gvZ3M2Y21HbGUvdVNmSE1QeWNx?=
 =?utf-8?B?TlNueWJZMVJ0NFRJaWlZN3lqWGNVeklsUHRVdzZkdWpSSUJPTDIzYkNRYTZG?=
 =?utf-8?B?OUNHdnZuMG5lWDdHSm80ak5TSGVadDg5OFA3cWJhaEFwRENRSW45SU1Fdzgv?=
 =?utf-8?B?eFZ2dXRrd3NIYmI5NjNPenhIUnBqVysvWlQ3R0p6WFppWk9sSDNJbHFQK3A1?=
 =?utf-8?B?T3dSZlVnVUdwcm1WbVBuNFB4aC9DZWpYL2lTQkt5QkVZQ1dYL3ZGTlZpTG5P?=
 =?utf-8?B?Wk5PNi9nZDNjOGdzUWdzN2dmckRjNFFsbzZXcjB0YXRZZDBLc0FoR0NoRFNM?=
 =?utf-8?B?cTE4dmlyTlVrREVRc0hzVHBwZHZVYlIvb3h3bC8yV3FaaW9YMlBza2owS2lV?=
 =?utf-8?B?cjFJa3JsV3pmdFIzYmFlT3NpNTlnV2RuR0N6QmtiVVIxKytNMjJKTWttSVRK?=
 =?utf-8?B?SGhVZUpackZCbStOOUNNSmRkd1ZYdW5YTUJGNkdHRmtvZ1BjUE41am80Mk52?=
 =?utf-8?B?NHM1eExkUlBjMWIwQjRmWG9zRkZPYjVHSWttTmFLWU5FalBTVGNDNFlHd1Zs?=
 =?utf-8?B?SitsVWZhZ2hJVlFib1YzU2NZdzVacTVjSC9QNkhKRkhPM1Fqb1pndmkzblAz?=
 =?utf-8?B?UGIyV3NiSnhPRzBNWUtGQjlwT3lwTm5kdEJ0c0ZjdDlHd3FUZVlsZ21SUlBO?=
 =?utf-8?B?NGVUNWt6Sm11YzgzSVgwWTdaUWdWVnZPcG90aXdqOVJqTVZDQjV1WGVqNFlp?=
 =?utf-8?B?UzgwVVNpbzQzVVJ1YkV4ZjhKL3RpdUROdjJtdEdUcGFLOU5SWHRRdmxua2dt?=
 =?utf-8?B?RDZrT1VHb1M2OFBlTDgrWlZKRGZ3LzY0M1V6aFNIalRvVXl6QXBHRDdxa3JM?=
 =?utf-8?B?OGkrNEpHOHNaZXRSWnFrSVlvMzNkWGJINDVnRnMrS2N0WVhMZDlaeU9iQTgv?=
 =?utf-8?B?U21qRlBMd3NOM0ZyemdwQlU4bzBNUjBDUm50MTlOQllFdmd4eVcweW5VaXJR?=
 =?utf-8?B?aHNFd2luUVFuMm41WkswcmlRTkFZY2RneE0zb0UyT2xvc002VnB0VlBFT211?=
 =?utf-8?B?MzNqVWQxWnNadmhONFZBeDloTzdTS3AyeVhja1ZmTnR1aGhlQ1orVGdhZWhy?=
 =?utf-8?B?YXNFQzBCRm1uOTVNb3g4WnpjMExmbVVKVEZJTk5nTGxrQjhvczNrSTF3bTNI?=
 =?utf-8?B?Sldiakc3MVlSS1VXb0NUaFJqNmtacS9wQUtkck9qUDhiWld1bXZuZjluR2U3?=
 =?utf-8?B?ZWZCRVdiTkdlM0pVRnFBTmFjN1RXRlFFRXNpdUNiQVp2Wk1SdUxROGFieHFS?=
 =?utf-8?B?MVorMmM0RW16SlVDYVcrQXZHYzB3K1RMQjBrU0NTay9OT0xieWVjc0dMWm5a?=
 =?utf-8?B?ZmVqeGVMTXRaMDh3dDh4SHdWaEhRMHNVM1NJREZFM1NmVzgxKzY2WEllU0tk?=
 =?utf-8?Q?shrSti6UN1wTE3iJFJP3tYpgqDZ7HC7fF10rk1Zj+ZOzg?=
X-MS-Exchange-AntiSpam-MessageData-1: PKgnj2t01xjtKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1431057-f958-4943-1888-08dee865fbba
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:56:24.7260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ifMs+2SsHdGwTMP/TRz3Uy7i0Ztm+4qmV1bIg72ecWzddZeSjvKjDTmLz0Vke6G/URkj/L/0juBmAX3o1DU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

On Fri Jul 3, 2026 at 7:22 PM JST, Eliot Courtney wrote:
> Currently, `GspSequencer` stores a raw DMA handle. Instead, store a
> reference to `Coherent` to statically ensure that the allocation lives
> long enough.
>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Pushed to drm-rust-next, thanks!
