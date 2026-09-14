Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80649C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 03:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303B210EB1B;
	Mon, 14 Sep 2026 03:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MBs90AUz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E386210EB1B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 03:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjToSR0txn2kHOezI1cPKgz5+OXw7Tvyduw6neQDSLCiOhl9a7bDfRMNHqyPrJUgUu+wA5paVofvv0ZAy7DWwqQ2SBNTZ40MKBVgs1o2FjlTkkyBKSsZQnFXI0VVGsgkc3u3SLs9Y5rnj6ku6Xq8By0Pog1OTCkMFUVxsfxAQB4JoEDEJoqiKQ54UYrZj6qycDAbartShW6QcuzXyemZTm46OMiedThvLBPdO7D+NYA2pp5Id8xfyTCVtU5M92jE3dmXTm6WVKWJVYAUWY39NYJ1+EwOqOEFCGVoCGhlWWmfZ0+jmD8KZVv68Cs2WngC/SeU2atYLF2Q3zfIwlfLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//2A952bReqdZBwtVfVVMoVsSGN5YY05VcFq+grZqw4=;
 b=mWXVh8fUj4GSt9smWw5OtLw9LRo2TaT5Tk1eHFNeHsU7K6RLnF2K/Y3m3m3+FbRLHcPy+8g5aIWQid1l1Z+mrsG+mSyZnSkERvtfPdarNy6g+44U0+HjCXRvtcFR+p3lirHOv9wxbqJaQFQ71x+eZbYjkHLyDhgjRtchOc+GCrW+GdcVj3a7w7BWhL+zwd2GOLFk7qhaVsIlQX6VeWl0r07Wp1QGHspHW9xRUE/pXhCHHvHik5J8oq3JhVFNSLlbAh8kXsnRnos/v3KLVKP1Ytz7illjsDVElbybxmzE/ObZFGijaSfb7c9LUsIV+MJIh9OE75wHB0T5iqbUYYdAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//2A952bReqdZBwtVfVVMoVsSGN5YY05VcFq+grZqw4=;
 b=MBs90AUzQGJqiV0SfXT//qcA1F5Y5dagRZ3pkaOOYg+sjuMqzDbw67+qXIN8Jo13grT7nrSqOM9n2wpH17fek+DrwE6ZKM3zciCM7yWOfGVmcFkmumb4p/YJ51a//Xb4phEwcxzWxZzMnGLpBPp5SLPZLVKt5o94LifBszu7fDM/0HNQrQJ2eAMtMg69Zxt6TuINX7TCAg7EKSXUHiAWfTxtMJe5FZcxMdWV7/Fk7YPXJnrMA8/A33LgqWViaRw+2FaHXI7zkVH+5Mb8WYt1r+q/DlRGCTq6PG0FRi92kN05TVeJU6soSG7dm6R4B0LKPxqNwFN/4Ym6Pi8TmQDXsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 03:46:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 03:46:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 12:46:08 +0900
Message-Id: <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
Content-Transfer-Encoding: quoted-printable
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:604:253::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: c0358810-0bf7-4296-1dc2-08df1212b7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|7416014|376014|23010399003|1800799024|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sgHTY6Bx888QvOzRM2diGdgb3OD0ZTXUpcoWYXlWvcv+q9BfKtI2VUMkOKmONSCEwuCdbc2/1Pkinx19yukMuDRs2qJmqONh0rMCymE/TheikCZG1JGuEurDL20/aAaQgr7CFXD22sN0jvYuGpiWVvb5zwGvXndVv9KMurfHRTKd/AcJmYe2mfkEa0MYEM6wgpQMJFNIHg35s4wDgAKAmHZ/3hFshdVoimoccqiHJU9jrb0LbE4HkKSVOy6xWEMTIRo6zFWOxahGcwPFzAiFFh9JU18HoMjchK5jb/teEMsplWtJ4p9wKIBfXQm1Ao5Nc8pESUPCMOYzi5u+QgsnL1HeNPb2QRugmzFJFgkSnSLnCEAWG4K/K6/u5vJ0GLlXHmCdf+90rZUBFtDD95F82jD0W2zBQofm11qu1By/eX2/OLqzLr+kjLxf4H1VHVnEUuKPugyQCoAVr3NPtK9vCqQtHytbc8xneRhbhCM3OCCy42SoLQLavSeYIgFCUv1PPMhKa5XXzMca+45AlWifZ/qMxesrTT7T9au7O9TwXVue5VpfDOm2EA3HVjcl7u7LyrLU27w0t96QgRwL6YYbx+DXsD+NjNVZrqvoKz276KzN+X+4iv21HVwp5upXBFAP/jc8isSiea4aFvH5g85ASOd1NILibJyMZkRpS8xUADg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUpncTc4U1RRYzYreGlUanU4dE5xSUY4QThpKzhpMW4yLzhtYU00VldIRGs3?=
 =?utf-8?B?Yml6ZXF2bFdpNWU1ZEdIRWZxQ2ZSMFl4aFZTazgzOXduMEQ2Ykc0bS9tdE5h?=
 =?utf-8?B?ZVM4RkJQaHJoRXBWZUxjQlBNK3V5MUVLa2tBMmNFK25hdjRDRWZKa3hqc0pB?=
 =?utf-8?B?ZUtIM0Njd24xYXhDZ1I1aXZIYllCbjVXRTNoZFFMM2k1R0lSVldKSm9qZVJi?=
 =?utf-8?B?bXB3WDU2eHU2UUt1V1JBSlZ0YzJ0ZzVwN2pPTnB4dVM4UkJWMk0wUSthYll5?=
 =?utf-8?B?RzRLenp3cTJMejNmWDJqeG01c2o5bnZyemxWUmxNZTRINzIzT05VSlkwZHlq?=
 =?utf-8?B?ZGZSRGJEdm9IMjFKRno5dWlkbVVzQWNrQklrMEVHQ0EyQmpvbEFUTDczVzJ6?=
 =?utf-8?B?SXlLK1VicFE0Qk5YbExzaG1xRVUzdE13MnRTVFgzZVVONTZ4dE5OUVRTc0J4?=
 =?utf-8?B?cDdOeXlSRUJrQjNYaVJLbDVHOEFKdlhXQmlFZyszcEZHTVZ3ZnhIYkM5VlZC?=
 =?utf-8?B?aGZKT2xGT2NHNk1iWlBuZk1nVWRhVXowa3diM3BxNnN6MUxkc05vY2t0SGU2?=
 =?utf-8?B?TkNNNHgxZEZOQjZtSnNqQUlPZDloYzVhNHM0WEdka3JXOEZxWGpNTXJhZ05t?=
 =?utf-8?B?b1dUc2Zjc3BhUjhMSjFPRU55THRLeEU2bVRKaWNYOVcrQ0hMUDNtMTh5aEh2?=
 =?utf-8?B?K29CSE9RcmNPSVlGM0w1MFN4UDFiOWkyWjNRQ3NGQ0FiTDJpTTU2NDVpY1Jq?=
 =?utf-8?B?Z2lkbWxacHp6dEdJVXdiWDFNcjkwbFE0ZlNWVFRoY2NJc2hOdUhPbW5uNjlx?=
 =?utf-8?B?NVdteVJEWlZ0YkJUVDZJYkxqdlQrQ3QyYTRzdExYMUgwTmV4bm96RGZQcmFY?=
 =?utf-8?B?Z21laHNaMStIc08xYnUvZFRTYlhsenBKWWJrVnFHTUYrbnJtaEFTRXF2d28w?=
 =?utf-8?B?eUxLK21HOHVIc21GMkVjZnlNNG5ub0srUnFYZWh2NXkralQwalJjRVI1ZFNm?=
 =?utf-8?B?Mmk0a2NKZEpzd3pUaUJPZEh1Zzl4QTdSdmx6NkN1eXRjRkliTnFTRlRZbklo?=
 =?utf-8?B?UkljU0lkNUJVSW1ZTDQ2UHMzam1oUllTUEt6YnZhQjRHbG1DOHVUdmk0ZnV5?=
 =?utf-8?B?QTlnNk81dDVJZE5lVG93M0t0MU1IazZHTU9aanBXbFV1dTZaZVRIZzcrUHRP?=
 =?utf-8?B?RXhjWjRoQ3V1NmxWc2pIQldpR3UxK3BsZTU2Y05ZZFlWNzRPU2hMNFYzMmxk?=
 =?utf-8?B?ZWhsQUFnakJydm5JY2didVllY3pWaDg5QUpMWi9ZdDN2Qi8wRWpIekwyMnJt?=
 =?utf-8?B?UzNqdjQxQzd4VSsrRnJEY3ZJSU9NTmhFVVNiVlVleVUwaFVoWG9MM3NrWTZz?=
 =?utf-8?B?b2ZXcEhZNVcwaHhNL29LTytuRVBmcGcwYkM4KzFkM1BUSy9nbTdMWFl5cHVh?=
 =?utf-8?B?UEVDSjFKTThUWGg0MUZ5bnJXMTM4RDRhaEdaSlRQSW9mZGw0OThnR0JlUUxo?=
 =?utf-8?B?UFgyamM3WURvd0ZLamExSkpBNHh1Mlc3TXd4MWxwOTRRL1J1dk0vdW1kbFhG?=
 =?utf-8?B?NThpVFpGbFhwQTU2SGhzejltRTl6TEdTbENLY05iZ082ZUdpMkhRWTA5ckJv?=
 =?utf-8?B?dDQ4ZklnVVduU3NLZlg4anY3em1WQjkyVkl5OGxEaTJHZmZROHRrL2VDZEVO?=
 =?utf-8?B?dlljdnJBbVhCSy9qS0JiT2hEQkJxZ2xJRXJVUGJGTCtJQWZIcGpNeklPcm9O?=
 =?utf-8?B?Q3dXczJzUXlzR2FiZzlMZEhEMHJoZXJ0Z2lVcEF4N3hHY0JvMVNtM0pTRHFQ?=
 =?utf-8?B?d1lNT0RFck93bE5PMkdKS0VmdFBXWk94aFYyOTA3YzdSNDZ6aVJ1N1J0YXJy?=
 =?utf-8?B?eTNBaGFSNGhtNEo1disyWEF2Rlg3dGN2ZUZubGFHb05Nbm80eDNjVGZISE9Z?=
 =?utf-8?B?OWczMlI5U2Q1b3BXZWNmTCt0Q0JtMDlRQmU2cXdVbXJ4NUdsa25VWVliL0c4?=
 =?utf-8?B?RTl2d014MVMrQ2NhVGVXaDg0N3U4V1I4Z0luUnE0WEZBK29kRjNyVjJUVXNk?=
 =?utf-8?B?SFpjWm0wNmJBVnMvQjh3MUJITDJWMVNPcUtXQlY3RDhmTDc2enh6TXFTU1d3?=
 =?utf-8?B?NFV6UE82aXNMZEJWWFd1aG9SeUxEa0hWdjlBU2laM3FLQlh5YjR6U2hmdmlJ?=
 =?utf-8?B?SUJaTUQreVNpc1IxNXQ3MkNnQVBPcW05bzVxSFdldkxsSjBBVit6NUJIL1or?=
 =?utf-8?B?TDNobmp6L0Nmd0pwcTg4VnJlU3BuVmRMMGYxcW9PU2hQS3d0V3JHdUt6STNy?=
 =?utf-8?B?Z3ZFaDVyTEsybGxmUlRBa05JbEZTU2VqbjJMSGowMjY0MC9XM0dlTVg1RUN5?=
 =?utf-8?Q?1oHUhthuzxLwbWho/HS6FmMLOEpuOHHYdUWjCdmZHw7Y0?=
X-MS-Exchange-AntiSpam-MessageData-1: MtG9a6qn8RP7dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0358810-0bf7-4296-1dc2-08df1212b7c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 03:46:11.3530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gNkK1xe/yKQ8U4gM7mCjyvn1p7YcL0cxgP7LuMz0UlETOnW964CZ3n9YWipCkky8ZIkevuKLSgm4XFiTBT5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
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

On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
> Similar to the typed encoding layer, add some decoding type machinery.
> Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
> by composing visit calls to each member. Add some common `Schema` kinds,
> such as `Array` which collects an array value into a fixed maximum size
> array, and `Required` which fails a decode if the value is not sent.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/nvkv.rs        |  12 +-
>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 480 +++++++++++++++++++++++++=
+++++-
>  2 files changed, 488 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gs=
p/nvkv.rs
> index 10dcbb9e602c..7d58ca91cbc3 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
> @@ -9,7 +9,7 @@
>  //! function calls will map to some struct - for example, f(GPU_NAME_STR=
ING_KEY, 0, b"some gpu")
>  //! naturally maps to storing a &str with the GPU name.
> =20
> -#![expect(unused_imports)]
> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]

I am getting a build error on this patch:

error: unused import: `nvkv_encode`
  --> ../drivers/gpu/nova-core/gsp/nvkv/encode.rs:65:16
   |
65 | pub(crate) use nvkv_encode;
   |                ^^^^^^^^^^^
   |
   =3D note: `-D unused-imports` implied by `-D warnings`
   =3D help: to override `-D warnings` add `#[allow(unused_imports)]`

error: unused import: `nvkv_decode`
   --> ../drivers/gpu/nova-core/gsp/nvkv/decode.rs:104:16
    |
104 | pub(crate) use nvkv_decode;
    |                ^^^^^^^^^^^

error: aborting due to 2 previous errors

>  #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
> =20
>  use core::marker::PhantomData;
> @@ -21,7 +21,8 @@
>  use kernel::{
>      alloc::{
>          allocator::KVmalloc,
> -        Allocator, //
> +        Allocator,
> +        ArrayVec, //
>      },
>      bitfield,
>      num::Bounded,
> @@ -139,6 +140,13 @@ fn default() -> Self {
>      }
>  }
> =20
> +/// A schema field for an array value under the NVKV key `KEY_ID`.
> +#[derive(Default)]
> +#[repr(transparent)]
> +pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_ID:=
 KeyId> {
> +    vec: ArrayVec<T, N>,
> +}

Why is this not defined under `decoder` if it is only used there?

> +
>  bitfield! {
>      /// The op word that starts each NVKV operation.
>      struct Op(u64) {
> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/decode.rs
> index ceb97e73e100..7f5310857764 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
> @@ -3,16 +3,356 @@
> =20
>  #![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
> =20
> -use kernel::prelude::*;
> +use core::convert::Infallible;
> +use core::marker::PhantomData;
> +
> +use kernel::{
> +    alloc::ArrayVec,
> +    prelude::*, //
> +};
> +use pin_init::init_array_from_fn;
> =20
>  use crate::gsp::nvkv::{
> +    Array,
>      Index,
> +    Key,
>      KeyId,
>      Op,
>      Opcode, //
>  };
>  use crate::num;
> =20
> +/// Defines a schema struct together with its [`Schema`] implementation =
that decodes into `$target`.
> +///
> +/// Each member of the struct should implement `Schema`. For every (key,=
 index, value) triple
> +/// decoded from the NVKV stream, the generated parent `Schema` implemen=
tation will call each member
> +/// in declaration order with that triple. If a member consumes that tri=
ple, it will stop there.
> +/// Otherwise it will keep going until all members are tried.
> +///
> +/// The schema struct holds the state required by the schema implementat=
ion to do the decode. It's
> +/// recommended to use one of the existing Schema kinds (`Required`, `Ac=
cumulated`, `Key`, `Array`,
> +/// `Indexed`) for each member.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// nvkv_decode! {
> +///     struct RequestSchema =3D> Request {
> +///         id: Required<u32, 0x0001>,
> +///         name: Array<u8, 64, 0x0002>,
> +///     }
> +/// }
> +/// ```
> +macro_rules! nvkv_decode {
> +    (
> +        $(#[$attr:meta])*
> +        $vis:vis struct $name:ident =3D> $target:ident {
> +            $(
> +                $(#[$field_attr:meta])*
> +                $field_vis:vis $field:ident : $ty:ty
> +            ),* $(,)?
> +        }
> +    ) =3D> {
> +        $(#[$attr])*
> +        $vis struct $name {
> +            $(
> +                $(#[$field_attr])*
> +                $field_vis $field: $ty,
> +            )*
> +        }
> +
> +        impl $crate::gsp::nvkv::Schema for $name {
> +            type Target =3D $target;
> +
> +            fn init() -> impl ::kernel::prelude::Init<Self> {
> +                ::pin_init::init!(Self {
> +                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::ini=
t(), )*
> +                })
> +            }
> +
> +            fn visit(
> +                &mut self,
> +                key: $crate::gsp::nvkv::KeyId,
> +                index: $crate::gsp::nvkv::Index,
> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
> +            ) -> ::kernel::error::Result<bool> {
> +                Ok(false
> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.$fi=
eld, key, index, value)? )*)

Mmm looks like this is going to be `O(n)` with `n` being the number of
fields?

This is ok for a first implementation but eventually I hope we can
switch to a more efficient dispatch.

> +            }
> +
> +            #[inline(always)]

In this patch as well these should probably be just `#[inline]`.

> +            fn finish(
> +                &mut self,
> +            ) -> impl ::kernel::prelude::Init<Self::Target, ::kernel::er=
ror::Error> + '_ {
> +                let Self { $($field,)* } =3D self;
> +                ::kernel::try_init!(Self::Target {
> +                    $( $field <- $crate::gsp::nvkv::Schema::finish($fiel=
d), )*
> +                }? ::kernel::error::Error)
> +            }
> +        }
> +
> +        impl ::core::default::Default for $name {
> +            fn default() -> Self {
> +                $crate::gsp::nvkv::assert_schema_size_reasonable::<Self>=
();
> +                Self {
> +                    $( $field: ::core::default::Default::default(), )*
> +                }
> +            }
> +        }
> +    };
> +}
> +pub(crate) use nvkv_decode;
> +
> +/// Asserts that a schema built by value is small enough.
> +pub(crate) fn assert_schema_size_reasonable<S>() {
> +    // Clippy triggers this even if the enclosing function is never call=
ed, so skip if clippy is on.
> +    const_assert!(
> +        cfg!(clippy) || size_of::<S>() <=3D 1024,
> +        "construct large schemas in place with `Schema::init` instead of=
 `Default`"
> +    );
> +}
> +
> +impl<T: for<'a> TryFrom<DecoderValue<'a>, Error =3D Error> + Default, co=
nst KEY_ID: KeyId> Schema
> +    for Key<T, KEY_ID>
> +{
> +    type Target =3D T;
> +
> +    #[inline(always)]
> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'a>) -> Result<bool> {
> +        if key !=3D KEY_ID {
> +            Ok(false)
> +        } else if index !=3D Index::new::<0>() {
> +            // Single values being set must be at index 0.
> +            Err(EINVAL)
> +        } else {
> +            // Overwrite and take the latest value here.
> +            self.0 =3D value.try_into()?;
> +            Ok(true)
> +        }
> +    }
> +
> +    #[inline(always)]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        Ok(core::mem::take(&mut self.0))
> +    }
> +}
> +
> +impl<T: for<'a> TryFrom<DecoderValue<'a>, Error =3D Error>, const KEY_ID=
: KeyId> Schema
> +    for Key<Option<T>, KEY_ID>
> +{
> +    type Target =3D Option<T>;
> +
> +    #[inline(always)]
> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'a>) -> Result<bool> {
> +        if key !=3D KEY_ID {
> +            Ok(false)
> +        } else if index !=3D Index::new::<0>() {
> +            // Single values being set must be at index 0.
> +            Err(EINVAL)
> +        } else {
> +            // Overwrite and take the latest value here.
> +            self.0 =3D Some(value.try_into()?);
> +            Ok(true)
> +        }
> +    }
> +
> +    #[inline(always)]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        Ok(self.0.take())
> +    }
> +}
> +
> +impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId> Schema for =
Array<T, N, KEY_ID>
> +where
> +    for<'a> &'a [T]: TryFrom<DecoderValue<'a>, Error =3D Error>,
> +{
> +    type Target =3D ArrayVec<T, N>;
> +
> +    fn init() -> impl Init<Self> {
> +        init!(Self {
> +            vec <- ArrayVec::init_with::<Infallible>(|_| Ok(())),
> +        })
> +    }
> +
> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'a>) -> Result<bool> {
> +        if key !=3D KEY_ID {
> +            return Ok(false);
> +        }
> +        // Require to be at index 0
> +        if index !=3D Index::new::<0>() {
> +            return Err(EINVAL);
> +        }
> +        // Reject oversized and take the latest value.
> +        self.vec.clear();
> +        self.vec.extend_from_slice(value.try_into()?)?;
> +        Ok(true)
> +    }
> +
> +    #[inline(always)]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        ArrayVec::init_with(move |dst| {
> +            dst.extend_from_slice(&self.vec)?;
> +            self.vec.clear();
> +            Ok(())
> +        })
> +    }
> +}
> +
> +/// A schema field for a key that must be present.
> +///
> +/// `finish` fails with `EINVAL` if no value arrived for the key.
> +#[repr(transparent)]
> +pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_ID=
>);
> +
> +impl<T: for<'a> TryFrom<DecoderValue<'a>, Error =3D Error>, const KEY_ID=
: KeyId> Schema
> +    for Required<T, KEY_ID>
> +{
> +    type Target =3D T;
> +
> +    #[inline(always)]
> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'a>) -> Result<bool> {
> +        self.0.visit(key, index, value)
> +    }
> +
> +    #[inline(always)]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        (self.0).0.take().ok_or(EINVAL)
> +    }
> +}
> +
> +impl<T, const KEY_ID: KeyId> Default for Required<T, KEY_ID> {
> +    fn default() -> Self {
> +        Self(None.into())
> +    }
> +}
> +
> +/// Expects objects specified sequentially with index starting from zero=
.
> +pub(crate) struct Accumulated<S: Schema> {
> +    current_index: Index,
> +    current: S,
> +    current_started: bool,
> +    next: S,
> +    accumulated: KVVec<S::Target>,
> +}
> +
> +impl<S: Schema + Default> Accumulated<S> {
> +    /// Creates an empty accumulator.
> +    pub(crate) fn new() -> Self {
> +        Self {
> +            current_index: Index::new::<0>(),
> +            current: S::default(),
> +            current_started: false,
> +            next: S::default(),
> +            accumulated: KVVec::new(),

Do we want to call `assert_schema_size_reasonable` somewhere here as
well? Also, should this be a `Default` implementation?

> +        }
> +    }
> +
> +    fn take_vec(&mut self) -> Result<KVVec<S::Target>> {
> +        if self.current_started {
> +            self.accumulated
> +                .try_push_init(self.current.finish(), GFP_KERNEL)?;
> +            self.current_started =3D false;
> +        }
> +        self.current_index =3D Index::new::<0>();
> +        Ok(core::mem::take(&mut self.accumulated))
> +    }

This seems to be only called by `finish`, let's inline it there?

> +}
> +
> +impl<S: Schema + Default> Schema for Accumulated<S> {

If this ok that this doesn't provide an `init` implementation? Because
the default one returns a value on the stack, which IIUC can grow rather
consequently for an `Accumulated`?

> +    type Target =3D KVVec<S::Target>;
> +
> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'a>) -> Result<bool> {
> +        if index !=3D self.current_index {
> +            if !self.next.visit(key, Index::new::<0>(), value)? {
> +                // Unrelated key to us.
> +                return Ok(false);
> +            }
> +
> +            // Require that objects at index k have all their keys sent =
before the k + 1 th object
> +            // can be completed. Require that objects are sent contiguou=
sly in order from index 0.
> +            if !self.current_started || index !=3D self.current_index + =
1 {
> +                return Err(EINVAL);
> +            }
> +
> +            // The current value must be finished. Push it and swap in `=
next`.
> +            self.accumulated
> +                .try_push_init(self.current.finish(), GFP_KERNEL)?;
> +            core::mem::swap(&mut self.current, &mut self.next);
> +            self.current_started =3D true;
> +            self.current_index =3D index;
> +            Ok(true)

I don't quite understand how this method works, notably how
`current_index` evolves. This might require more documentation on
`Accumulated` itself.

> +        } else {
> +            let consumed =3D self.current.visit(key, Index::new::<0>(), =
value)?;
> +            self.current_started |=3D consumed;
> +            Ok(consumed)
> +        }
> +    }
> +
> +    #[inline(always)]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        self.take_vec()
> +    }
> +}
> +
> +impl<S: Schema + Default> Default for Accumulated<S> {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +/// A schema field that scatters indexed values into an array of `N` slo=
ts.
> +#[repr(transparent)]
> +pub(crate) struct Indexed<T, const N: usize, const KEY_ID: KeyId, As =3D=
 T>([T; N], PhantomData<As>);

Can we elaborate a bit on what `As` is supposed to be? Not only on this
site, but generally speaking. I have a hard time coming with a
consistent definition, so a comment would help the reader forge their
understanding.

> +
> +/// Copies `elems`, converted to `T`, into `slots` at `start`.
> +///
> +/// Fails with `EINVAL` if the window does not fit in `slots`.
> +fn scatter_window<T: From<As>, As: Copy>(slots: &mut [T], start: usize, =
elems: &[As]) -> Result {
> +    let end =3D start.checked_add(elems.len()).ok_or(EINVAL)?;
> +    // Reject indices outside of the declared array size.
> +    let dst =3D slots.get_mut(start..end).ok_or(EINVAL)?;
> +    for (d, &e) in dst.iter_mut().zip(elems) {
> +        *d =3D T::from(e);
> +    }
> +    Ok(())
> +}
> +
> +impl<T, const N: usize, const KEY_ID: KeyId, As> Schema for Indexed<T, N=
, KEY_ID, As>

Same question as `Accumulated` about the lack of an `init` method -
maybe we can use `init_array_from_fn` to avoid a stack copy.

Actually that makes me think that maybe the default `Schema::init`
implementation is not such good an idea, because it makes us overlook
types where we should override it.

> +where
> +    T: From<As> + Default,
> +    As: Copy + for<'a> TryFrom<DecoderValue<'a>, Error =3D Error>,
> +    for<'a> &'a [As]: TryFrom<DecoderValue<'a>, Error =3D Error>,
> +{
> +    type Target =3D [T; N];
> +
> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'a>) -> Result<bool> {
> +        if key !=3D KEY_ID {
> +            return Ok(false);
> +        }
> +        let start =3D index.cast::<usize>().get();
> +        // Accept both scalar vs scattered array setting for flexibility=
.
> +        match <&[As]>::try_from(value) {
> +            Ok(elems) =3D> scatter_window(&mut self.0, start, elems)?,
> +            Err(_) =3D> scatter_window(&mut self.0, start, &[As::try_fro=
m(value)?])?,
> +        }
> +        Ok(true)
> +    }
> +
> +    #[inline(always)]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        init_array_from_fn(|i| Ok::<_, Error>(core::mem::take(&mut self.=
0[i])))
> +    }
> +}
> +
> +impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId, As> Default
> +    for Indexed<T, N, KEY_ID, As>
> +{
> +    fn default() -> Self {
> +        assert_schema_size_reasonable::<Self>();
> +        Self([T::default(); N], PhantomData)
> +    }

Mmm that could be a pretty large object. Where are these `default`
methods called? Do we want to leverage `init` instead?

<...>
> +    // Tests that a schema too large for the stack decodes on the heap.
> +    #[test]
> +    fn decode_large_schema_on_heap() -> Result {
> +        const BLOB_KEY: KeyId =3D 0x1400;
> +        const BLOB_VALUE: &[u8] =3D &[0xab; 100];
> +
> +        nvkv_decode! {
> +            struct BigSchema =3D> BigDecodeable {
> +                blob: Array<u8, 2048, { BLOB_KEY }>,
> +            }
> +        }
> +
> +        struct BigDecodeable {
> +            blob: ArrayVec<u8, 2048>,
> +        }
> +
> +        let mut encoder =3D Encoder::new();
> +        encoder.encode_array8(BLOB_KEY, Index::new::<0>(), BLOB_VALUE)?;
> +        let serialized =3D encoder.finish();
> +
> +        let mut schema =3D KBox::init(BigSchema::init(), GFP_KERNEL)?;
> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Erro=
r);
> +        let decoded =3D KBox::try_init(decoder.decode(&mut *schema)?, GF=
P_KERNEL)?;
> +
> +        assert_eq!(*decoded.blob, *BLOB_VALUE);
> +        Ok(())
> +    }

Same as the encoder, it would be nice to exercise the error paths a bit
more in the tests.
