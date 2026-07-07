Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33458C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8278710ED05;
	Tue,  7 Jul 2026 13:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pd0nz1jK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775C510ED05;
 Tue,  7 Jul 2026 13:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDFqVyu/g5FqTWv4MOPvumiyimU/qoX879YamxbG7pPBuxoYCjhShHSc2HcJgtU6XJazvKKpe6OLA8OWZM9TfUHP6m+1sRCMVvm3t9GEgyivZswSgJNkrR7z76j/8sxcpg414M25D/wp/4sGDdeXKCpcyUbbcwi0nNUmvHE8CwsfUOhiJ5UnDkSByHPILdXcV0SW7F8mSlm0dIVtv+IcwyVkHISVVnzH7/tVqYAfW9YQdeeXp91R9cC59BDOavBQYqScLn4Ueb5wBvMugw8sR9Qb0+5TBtAGO2AwgKzh2VBMN3XGlq38E5wyugyPA/bNlRvOToX5+TtD2qrNMbubwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zFHG0sbx1M7casoxYod+Q3JDnyzyT5pV5jNtFhNIPs=;
 b=MAdnqCp02fFvubcHZaSA8QE6e7kOiL55/iLn4mb00Sk3g5wMjje3sf2/9tq7yYp8cyCxg0nms1HCdUdY0/6TM1ixQWSh8M5JPcJz2USKE4VxO8fmcuEErtJ0JZO9V8ge1uuqqxLRF4NPxU3bEPbtevj4Mlwj1WRs5K164MYmctoxuVdnAWGIScTMf6s8q7SetM7i88wV6a4wmjqgz0V9TyNV/OJtEbYokMtP8ZQ+pQlt9pHcf1K8SMpMG/zfpas13nAVBjTRSGF190TjhfFcyPoSLtK/URlPGNHkqCVUEqJTjD/jSfFYob2pFboYmekHAYMlYHKzRAXCti8fNyOTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zFHG0sbx1M7casoxYod+Q3JDnyzyT5pV5jNtFhNIPs=;
 b=Pd0nz1jKe/6TM6RZ63kI/FvnSm97El9Rq6FwruHGrD3foN31OzDRp/qVhGd9CX0N9ZqYOR9iIOEVWiEpk5ZyJbXv2lSJjMycMuMXs4EIWII3aY3r8jbOwkDxD48QqCU2LHDkGxVJzEOt+hScrNDf2K/ohbZgvmDqedPC5j6qnGir8hRmbJEyHRzAn/O9WJtQl9Q/qmPwsENz5fI5FpUkpxToO5H2tlX2qIldg0x2N59/4mygw+Uf4vsgq5uXi+zg45QTPoiz1AEMrJVDTqwg2/3hBKlCv6+1X2JdlkD076i4IyKyRhjhNkhSt3pp6276lPOK3chlSQpmFbaKPPDIfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:25:31 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:25:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 22:25:27 +0900
Message-Id: <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir" <bqe@google.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Greg KH" <gregkh@linuxfoundation.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
In-Reply-To: <2026070334-dollar-hexagram-e49c@gregkh>
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bd7162-7179-485f-4238-08dedc2b37c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|22082099003|56012099006|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: bbXVbRJGFffRsvzLR0BppBV9AuTwVs71eqYKaaFQ4LfHTjlqX2c5vZyB5BPAM6n6gZa339iriiRx6HZRgo0vfHK3yIEobOka4w2uFcDtLSPJzbeJwzUmuJGjYan0mN3fmSGmIUv2TfJi/oL8v8nDcyLm+o8Hj7JSZm3KjWjEKPNo//1fcsarRxPJ+Vo/XCr+4D7FqwSIokK5Q5Zw5MGfmeDbV0+e+IVeHrtPI89Y2FJshS/ywPxMWBViUmX6CeNZ2q6KYeiUoZtzbsWMSILQ5RTd0W0JXru+YTk0vOshCoDaQt1TvhZqJOxuRz4D+kODLuPY56RviJczm2lNwxi6EPKDSNgIuf6kh/kmd9quZ8Vlp3TJ9aaYKkYKfzDrtkz95c6t74ZMy1v+gd9XFw8+bpQk8PNxkdtqy61a5LPIRP3b7IPI/P5AEtoB6tmJYdfyOGn1uuzkN52bvcjoP8AWAZe7tJtlSGy0fpfKGegrX/o0gab6eod7av2bKnILwFupWytJXIaMyNc7PFz51yG/VxaPsBdqRQD9MhGXxrqm6J+7gAAx3FmvLk719vhGUxlX7zct71R/chXXl6EBxbAzVizs4lF8ObNpvJHD/VS9O+XYq2C66eTPRZFK2oMvSoDZoVioKZakcek5CpIdQQdWUrxQ5TxgPbcZ5ZaOwxt99uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(22082099003)(56012099006)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJSWDBoSVVSR2JpM2FKVzY3YzBmdEVhUjJtRmg3MlRsTkVQdnh4MjN2RjB4?=
 =?utf-8?B?N3pqOHFzREFVSFp6cC95MXRVYlhNVGhvWW5HY2FUMFl2YkhhQkRwMHlKZERJ?=
 =?utf-8?B?c1MzOFYxNDlKOEgxQzV4SFhQcitvR00wQjFRUHJySGZRUGljYWYzSzZudnN1?=
 =?utf-8?B?Zkp3QmdzUTVuUkIzVzdSZ29OU3cwQUJlNFBmcTZLOFhqaytNbG55WWUyV3Nz?=
 =?utf-8?B?cGdJcUpzRG9LRUYvMGw2MzU4L2d4ZmVzQzYvWDZpZzFXMDZaNXkzQmVqV0Ju?=
 =?utf-8?B?cVpabmhkSlU5RnNBc1hRdEhnZnhjNC9tbFRUQjEyOTZmemE4cmorRGoxOEZD?=
 =?utf-8?B?azRzeEZUQUVRZERVMkpZVFYxMUhMWnhPc3dGU3ZBWlpEd3docVVnVFVGSEdS?=
 =?utf-8?B?eHU3Z0RLVnBMY21OT2tpdEN2bCtHdGVJek9rMXBseXgyRmRUZlE4YTJkekw0?=
 =?utf-8?B?WHRZemJQRVA4dlIwOHZDajZKeDlkWWtaaFZTNENENTBaeHNJdkhmSTlscGlF?=
 =?utf-8?B?aVp2bVN4a1ZCejY2ZmxkL3QzLy9ESkpLL3labElpNlZ0eVJWWUlpc0thQ0M2?=
 =?utf-8?B?VUNqMVRmZ1VjV1NYTTRqN09RWjJRdmttYUF0Wkg5UDdsY0FiMmY3VUlMTU9R?=
 =?utf-8?B?QjRRZFgzVjVJUEl6TkNlb1VGTExsd0gvZGJUMk5SbE1LSWM2WjdvWW9JRU9X?=
 =?utf-8?B?UllPN3FZYnZVMHAvWWJ3YlgzakVDMFpOSC80SGZRVnRWQWR3SnBDcTFzWndE?=
 =?utf-8?B?aEVBUUlCaFZINERoSmkyTXNCd1FJc251Ty9GMDlUeWxhSjBicmtRczA2V3hC?=
 =?utf-8?B?MkFqODFJSldvR2YzeUpCakZlOXlSZTJwalE0Y0o3dFpjbDc5ZkpDRkNCRHNu?=
 =?utf-8?B?eTA1ZHdnME80VHZuak9UYWxyMlVBS3VxMkJwTHlhZHNMSHYxU3RPQWh2Ui81?=
 =?utf-8?B?d2t3NzMvcnNMTjVMTi93UXhBcTZlQ3ZXdnhLdERlb3hmeXRJbE9iSTVqZ0NS?=
 =?utf-8?B?VytOaUNIaFdnd0FyTnQ2VmZzb21CSnBSR3hUdU51ckF5NUE0ZWRSNXF2ZUx2?=
 =?utf-8?B?WUo3RWNKbUgxc3FSTXVOc2dDSUdLYmgyOHZLb29PV1dIUm5RT0c3bnoxUU03?=
 =?utf-8?B?QlBOWUVZOEVweFhRUVV5UG02aVBYanV5UGxtMU9CWkp1UHByMWhsd0drOFdI?=
 =?utf-8?B?T0FkU1NMKzF2eTd1K2NhNythY2l0RVo2RldneTV0UHBsMlJOWWxmNHZNaWY3?=
 =?utf-8?B?Tng1OVdNb1R5Q1ZEQ2hteHgyN0dxUWJHZlI0STdpMGVCaXJyVHhiaytPYjdW?=
 =?utf-8?B?TUFWUkRQVTFkODlvRXNXQXY3VGFkdE9KK01GWEg2Z1JJRnNrQ09nRlp2bXp1?=
 =?utf-8?B?aWdMYmNYdVpxU0Y4RG91elhOaGtIbStFLzE3NlZYeG5TV1dzS2VVcUdhWDcy?=
 =?utf-8?B?TFBCTUw5emNNRzVjeExFNlJYZzdJdDZQbSt1d1FuaEN1ZUtNMU1vZXpTc2ND?=
 =?utf-8?B?cUhVRUlUaTJZdXVFQWNxZW55aXJRRWxiTkNSUU5JWjRIMXN4REg5Yi9XNnFi?=
 =?utf-8?B?TVJsRW1uSWNPOUtSR28vZ25HMVRCZlIzdHh1d0pBVkl5NUw3VndROEhUa3U4?=
 =?utf-8?B?L3JwazVML1d0MzgrVnJOK3YxN0JNbEJEbHAybndsZ0RtYzcyY2Uxc0M5V3pV?=
 =?utf-8?B?RHpvZXdBV2N4VEpGMysyY1dMaitmVUJRU0tyRHExbkZKVkpMdk9FMXB6SkVB?=
 =?utf-8?B?YWVWVklGZy9EV3d2YUNUdnF2Y3lYdUg0RVFvYUtuR3ZCOTBlMFl2clZ5aS8r?=
 =?utf-8?B?RFpUUXdMTnVHdlVEcTNaNDBNcGdnNnBPbWtoT3IzWkxtdk1Vc3BxSG1sblRo?=
 =?utf-8?B?M2c0enplVlZFeHdWdXcxa1QzRkM5QmFDWDA5eUZoMjcwUzNvSXBKTDNYVlo5?=
 =?utf-8?B?TTBCM2R0Y3BvUkpxc3BsRU11WDlVbGVjaktzbkNKUnU2MHBWbS9nOS9sVzFk?=
 =?utf-8?B?Y0ZsMEVOcyt0bjg4VTNqZ1A0anYwdDE0alpKMGdKbGpZWnV0REk5ZnNCS0R2?=
 =?utf-8?B?V0JCZGxaeVdkZG15aENSM29aQzJmSHJXck5FYWNuUTlTZW5FcGIzdEhHdTI5?=
 =?utf-8?B?L2d3UWdmUEltYWdrSDlXcFhpUDh3YU9PV2JRZGE0ZzhnU2FIcVkyODI2NGQ0?=
 =?utf-8?B?a0toSitqOGNCOUNwcUxOZUJCNkRJYXF4djcya2pscFdWemtoeHZadlpmNGd0?=
 =?utf-8?B?L2tTVUdVV1BqSGJKNHVGWjJkdmQwV0ZZNkl5VXJjN3hOallHdXI5UmVUa0s2?=
 =?utf-8?B?eTNZemJSajMxVDBFSUNjc1pyekg4ZW02TnNUdC92ZjI1QVlKQWJ3YzZYYjRY?=
 =?utf-8?Q?KUycB95OPYKaYO0t42WZnnlq++be7H4BjTSiXuSLlBMw9?=
X-MS-Exchange-AntiSpam-MessageData-1: g9AH0rNJDi2fHw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bd7162-7179-485f-4238-08dedc2b37c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:25:31.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Juv+OX/h0kl9duvQiKVAu6vQeaOxW9YeYEkfoUvv4DYnY0dGq3gWcaYN2c5mx+Qj+btZruw8agoKzRt5za+fDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

On Fri Jul 3, 2026 at 7:31 PM JST, Greg KH wrote:
> On Fri, Jul 03, 2026 at 07:16:06PM +0900, Eliot Courtney wrote:
>> Add support for contiguous area allocation. Add a new type,
>> `UnusedArea`, following the same pattern as `UnusedId`.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Why isn't the built-in idr library being used here instead of rolling
> your own data structure?
>
> thanks,
>
> greg k-h

For nova-core in this series, we need allocation of a contiguous
sequence of IDs with a specific length and sometimes a specific
alignment. IIUC, IDA/xarray do not support that (I checked
ida_alloc_range and it only allocates a single ID in a range, not a
contiguous sequence).

For IdPool before this series, I think it could have used IDA/xarray.
See [1] where Alice has posted some more context.

w.r.t. the structure choice, the IDs we need to allocate are channel
IDs, and the total range is limited to 2048 of them, so IMO bitmaps are
a better fit than e.g. maple tree.

Thanks!

[1] https://lore.kernel.org/all/akujuAJOZxRJlQZo@google.com/

