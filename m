Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBE4CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0071A10E254;
	Thu, 15 Oct 2026 12:52:06 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439FC10E2BB;
 Thu, 15 Oct 2026 12:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csVsYWl1817CCDwxAjdnpwm3kInCKhNR+w6Xuyg5EgHmZnfG6wAwgxYWSSarCjLrvwoa6Wvw/So3Fz2MeCg33VoPnqphNpgzYp9MxjE/vlbEopjNsAgDdW6edJ/KDeDrg8QbhROB1gUhCcSSayPz2/fjtBzI9vL5/Cm3v423mZLZPytoxOBsqk7sCxfF+K6dTRN3AFG8sDfPK023mQmDmwZkn/YZLZ4SOEkBlIiXvUjziyCp3BLR6Lhy/D5rYGQhopwSQg4Z7WrAEv3qi0axetofdLluLL1Zj5YBmmZ01dwqDTJmmhcObOlVSthRg50//2ov+GlFGuMJ40Z1E2GfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajBNCaSHRl2W20TmMCE3kV6yYVLn/yBMVx5oDSXf0eE=;
 b=ti7yKZte/xB0TrXMzgcHIvlhjNQQOxk4WFTkmHYWDSY0UvUIYprkpXyHgLLIESVRIH0ipqtWqgghWZf7UAtv5L1wqGLB0kRRgdqZY7d+DGYSmNGPGiMQ8RgKO7fJaQYrNLsipLOy/4FVZRqivJDcGNQmDQ58NppPEQtBmwpsqZMFqvhs63LScJbTLE/ZP17vqP0hdfnezU5S6kDYoU9XIoaEDWHKEIShsqq7XZCnvdriAmcKDyA+PRyPZpLgP7mMKa+831lvClFCb8QCKFNswv4INv9zmdd67H7HUg5xU361+bfecrvu5J0vJJ7UiuvKC1CxI5R1k51lDcQxM11vsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajBNCaSHRl2W20TmMCE3kV6yYVLn/yBMVx5oDSXf0eE=;
 b=nWWipuf+5WCxM0s7/pgkn9jcJ+9wVx65OKy02RjqCJ+ZeaBQpYfHRGsWch2WXj6e4xlDia2UWhl9jv7vCDCNtobRbgJuWTPkm7To3Eik68TU4poL1I/hfQidiPBpsIxtsFQ/1Rcn/xzqMi5wnsjuuM5FwjVaSZsAZ9UVI1+6b7n8dI3qigpoL0P+OkiNn909jdG20IitwxWp6JBgXT6BvHRp+7Xw8c24rcSyoDo2muK/Rs5NPmb0e3+q3xt5BsAb5b4vw2x1Vs+f1P69Isk6BWuhmJ4dNexdL8yIAqoqWirV141q6d094K5S/+eynCa8pbOD9H/Ogn4Rf5qAcNvxnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 12:51:48 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 12:51:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 21:51:45 +0900
Message-Id: <DM5FC5YCXYH1.1IKNVGKKGYQLN@nvidia.com>
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
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 7/8] gpu: nova-core: add NVKV typed decoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
 <DLYLCD5IPKGZ.2DMT37GPHPP74@nvidia.com>
In-Reply-To: <DLYLCD5IPKGZ.2DMT37GPHPP74@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdfdb45-4378-4018-b130-08df2abb139d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|10070799003|1800799024|23010399003|5023799004|261009223027099003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: yRlizPyry7zh0/UbKy0bhTsnbX2E071bpYq71WKevKrNthioylzNo2uKXwA4+COG+EWZTYyjY0pE+p3xKa5wlFdHdHpWcO54q0fULR81NNzD6rwVzq1W1ZeLoDe23yQ2J8c1tfvfd0V9WPGmTL8THNbyvtMApfrmDUpEJJ+eS6VSzYSi2zK+QaAR5uNa8sNUMNpPHB6cOJy253mt1Ch8O3J7fZWcIScKUYZkgChhcSghquyuiK9efXjRwvBKd5Dd0Ib1urW/KWMgIyCwKTYZDqD1Gy8Jy23/rVf2YEaxYfL31BEWYFoh2fM6MpvDQrTtdzVDrhSV0cwk1NKHOOWEiFJP4j1Wgr6GQ8/koPeVPPBoiW0topLancPS78oPlOW/B9Ad6k3B6NYgHdgCWCDJF737/XR04M4LrQ5tqR19b6TNTfOrV7bNdfueFHT1zgvfpbXsDJOSBzfXET9QFIry3ok/p3N/GV1R00bWW1Q0jqYAsZA6r52ytAKQuwv+g1OtDxFqtSXa1RMCEqyvb+zta3kOpr4DFCBWE5ozRoZhDtmg/LWX4H4E0e4dd/vzfL3KPa5oENO1193EPQrdN1+ggIeg7tzln8VNAmkx9HFJmMf4hzvBBZKVnDzqdRsdH3b8v3Knae67z3szTr1dbCgasDGU6j1JyKZIUzMXZM49B5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(23010399003)(5023799004)(261009223027099003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTlHSjVYNGV1VGovM2lVOU90TEpCZU80MFN3bXRuUlNpeGlPeGZDQzJTYjMr?=
 =?utf-8?B?eHNVSmFMUEtTdGZpVmJuZDBRMkVMcmxLWU5JZWRUdGxuYmVRZWZNVzRyZ2Ri?=
 =?utf-8?B?UklrZ25tUkdXcUxoZlJtMWowY2x1L0hZQzNjOVQ5ZEx5QWpoNDlrd2JadmRK?=
 =?utf-8?B?REM2aW9YcU91L0VOdGdLQUxvdThSRWNHSXJzaGFrbXdjRlBTcVZ3bW8yUzVw?=
 =?utf-8?B?OSs2ekpJRkk2N1c2Zk5EbEh2YVRXVHBOUEhrV0J4M01zTWs1Q0k5eHdvVHVZ?=
 =?utf-8?B?ajU2QXNLMklvY0VENnNoM291bjZ3Z0pBYWUydmVRNE05M3REaHhSWUJLeXFY?=
 =?utf-8?B?ekNDeVJuRC9yekVJQ0ZwQkUzS3hxNUlNUE9aSW9aWTJSeERvN3lYQXpjRGhO?=
 =?utf-8?B?REptaVh2Vyt3QUJxdGdSVE5rd1R3U3cwQnhyblJud0M5THRFTktJbkZHM1po?=
 =?utf-8?B?RlNSMW1ZZTZleXNNWldEekY5MG1wU0E4TzFPeEg5cThYenBSUGxtM21Dc3Jv?=
 =?utf-8?B?SVJJcnlQM0tEQXdSazdyMzhWZk9EVkpZc0RiaWpSSjFxYng4Z0kwVTc3YkdH?=
 =?utf-8?B?emdqM25RVXhSdGdXTlZ2WXQvYTRPSWJCQVNpcUp2WjlRc3l0TG9wRjVVbnBo?=
 =?utf-8?B?dnBGa0Z4c2dKZXhqSU9SQXZOUFQzck43ZHM4VTdOYzBMZ3dsdVZZdkR0NEpa?=
 =?utf-8?B?T3lwZ1UrS1JjQWVDVnBuY2FOZllsRkFaZ1FvQjQ5SDM1MW5TT1c4Q2o1K0Ju?=
 =?utf-8?B?WHJ1c2ErNGxpYUtlWlNKVUNIVExuYVhSei9ZNHFyeXdBTGF4SG1ZbS9pMFNF?=
 =?utf-8?B?YmpJRmxyaWFBQnVsbHNOUUt3aVRKc0tadjFTVTRtVVhJbnZzSEYyMjZhQnI1?=
 =?utf-8?B?TUxkQS8zcmtRTXgvR0t3akZCaWdxb2kzRUdHV0dHQ2xJdExOeFpCdCsrQzFm?=
 =?utf-8?B?SGdRSlM3a0ZIVjBFWThCU0l4SkJkMXg4T3gyb1BIK2tnQkdSR1Z2dW9oVnMv?=
 =?utf-8?B?ako4OHlxZ0hlUlI5b2ZKeTZqUHZHMTIrQTlOdUR6TnlpUktNdEZEcWdUOHB2?=
 =?utf-8?B?aFNVWGQ3aWdaQVA1a0hkYVhTWjEwTFVCQjFSMWdnKzcwTStkSzB2TmVpQ1kw?=
 =?utf-8?B?Y0EvWnZjblhONHdpZ291a3JyOHhrQ2M1NWVJSWowUkExTTZoVlBvQzhFSXNS?=
 =?utf-8?B?bkdWQ3NGdzNDYnhvd2RIWnVtUEVheDl2TDBhdGdPVVVQdzlOS1B1UXJwZlgy?=
 =?utf-8?B?NGVlZlpRQ2JabGhKT3E1MHc1MG1odkJGRzJka2ZObWxpakhZbTJLYXB0eDBJ?=
 =?utf-8?B?a0E3bnlQY3lLaVRTWkxhWk5mN0llMGdxYUVJOGFndktzQW9MdG5oRGg3Zi9D?=
 =?utf-8?B?SGZRSk53V3FxTUl3T0taeFpzS2tYRm5iWitKZ2lKQ0RZNEkwZGNXSHZSM2ww?=
 =?utf-8?B?V0J6RHVWUjNlSUowQ0xNbzg1bStuV2F2MEN5ZGprbyt4bjZhSHdUREhBZmlS?=
 =?utf-8?B?T0c0Vyt2YlNyTlQyTitLcE9CdkR0TUg3QW41alZSUW9JTEhqbktDZ2U4UTBt?=
 =?utf-8?B?YlFuOFJQNFBzRVZMWnNFa0cyZ0hVM3NWdWE1Q3RjdThsT2UreXEvQm9RQXdO?=
 =?utf-8?B?K1lOWkQ4UEM1WGZUWDBIby9GbmZpK1hxdTU3Q3Rwdk82MTN4MmVmbWhXV3lz?=
 =?utf-8?B?Z3QrUjhGbmJpSTJVUjNFajJlNmxBYUs4dFJYRTJwZTlINWp1Y09OVGg3K2lN?=
 =?utf-8?B?SlA0ZHZDbVNac2s3SWN4T3Y4UWlzUUtKVHpLU01qS0tlNzNjY3pKbnpobGFv?=
 =?utf-8?B?MGtCZnNaUkp6aS9lZTA1QVZWdFZGNUt6TFJKYnB0VzJDRzBia3JVMEY4WkFp?=
 =?utf-8?B?dXpPam9kcU5HMVRyMHpjcUlDMGxPMHhnUDhQM3ZRQXhaTUtRYjdpNzErVXUr?=
 =?utf-8?B?ZCs3cmZhQVhLQnFXdDNwbWVBbjBYaGZ0LzNMb1ZEQkpVYnZ3LzhpL25LeUJX?=
 =?utf-8?B?dnNZSEsrSm5RL1RJVVAwR2p0UWs1cXFwSGNZUGlZa2VBMmtRZ3d6VXA0aExO?=
 =?utf-8?B?RGtlUitwYnNuZk9aS1JJL1RYWHVrVVluSHNad3FXUWNsSHJ1RmdWbjgxNlpp?=
 =?utf-8?B?dm5IbkNsZkRLZ1RsbXlmd1J2SWJpbVhEMkMrdjF4UGp2bldBSEl5QUh6V3hG?=
 =?utf-8?B?SlNYZ2oyZW9URloyM1Q2WVhsdlhEeUJTRkxIZVhIclAxU01qbkt0ZDQvbXpr?=
 =?utf-8?B?dnZiMGdNL1VmcVRkdU1ZQmt2SXlzdEV1SCtRcVAyTFJ0d2JIUFl0RDFRL2Mw?=
 =?utf-8?B?WFhSWCtyZVBQeC9STkF0VFI1cVpac3psbmZ5dUE1b0EwQzJXVXoweHBnem5F?=
 =?utf-8?Q?JIjyybIoWXtCXFBaJ4DZn3QzSVdqDTrvS8iUkhw2eAsjV?=
X-MS-Exchange-AntiSpam-MessageData-1: UZPdWn9rqyxaVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdfdb45-4378-4018-b130-08df2abb139d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:51:48.7558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /45sgGumI4lQCI09p6woD+Sdm6RsC/mJtkJiQH70aUpA3mXyD54uchfVopJQ4PaTSnOYHazDxZKdgI2s+pklvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

On Wed Oct 7, 2026 at 9:05 PM JST, Alexandre Courbot wrote:
> Sorry, some follow-up comments after my previous review.
>
> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
>> Similar to the typed encoding layer, add some decoding type machinery.
>> Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
>> by composing visit calls to each member. Add some common `Schema` kinds,
>> such as `Array` which collects an array value into a fixed maximum size
>> array, and `Required` which fails a decode if the value is not sent.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  11 +-
>>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 622 ++++++++++++++++++++++++=
++++++-
>>  2 files changed, 628 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/g=
sp/nvkv.rs
>> index 7ac3a459a98b..5791df07a7fa 100644
>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>> @@ -9,7 +9,7 @@
>>  //! function calls will map to some struct - for example, f(GPU_NAME_ST=
RING_KEY, 0, b"some gpu")
>>  //! naturally maps to storing a &str with the GPU name.
>> =20
>> -#![expect(unused_imports)]
>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
>>  #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>> =20
>>  use core::{
>> @@ -23,7 +23,8 @@
>>  use kernel::{
>>      alloc::{
>>          allocator::KVmalloc,
>> -        Allocator, //
>> +        Allocator,
>> +        ArrayVec, //
>>      },
>>      bitfield,
>>      num::Bounded,
>> @@ -148,6 +149,12 @@ fn default() -> Self {
>>      }
>>  }
>> =20
>> +/// A schema field for an array value under the NVKV key `KEY_ID`.
>> +#[repr(transparent)]
>
> I see that `#[repr(transparent)]` is used several times in this series,
> but is there a need for it? Same for the many `#[inline]`s, here I feel
> like letting the compiler arrange things as it wants might be the better
> call. I know I suggested downgrading from always-inline to just inline,
> so maybe we should go all the way here. These are very likely to be
> inlined anyway, and worst case I don't think a function call would
> induce a big cost.

It's not required. I was adding that because I was thinking of these
types semantically as just being type-level only wrappers of the
underlying data. I'll remove them, plus the inlines.

>
> <...>
>> +impl<T: Default, const KEY_ID: KeyId> Schema for Key<T, KEY_ID> {
>> +    type Target =3D T;
>> +
>> +    #[inline]
>> +    fn init() -> impl Init<Self> {
>> +        Self::default()
>> +    }
>> +
>> +    #[inline]
>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
>> +        Ok(core::mem::take(&mut self.0))
>> +    }
>> +}
>
> Both methods return the built value on the stack, which is fine when we
> only deal with scalars but technically we could also store larger
> values. How about a `const_assert!` ensuring we don't go beyond, say, 32
> bytes for the size of `T` and `Target`?

Will so do!

>
> <...>
>> +/// A schema field for a key that must be present.
>> +///
>> +/// `finish` fails with `EINVAL` if no value arrived for the key.
>> +#[repr(transparent)]
>> +pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_I=
D>);
>> +
>> +impl<T, const KEY_ID: KeyId> Schema for Required<T, KEY_ID> {
>> +    type Target =3D T;
>> +
>> +    #[inline]
>> +    fn init() -> impl Init<Self> {
>> +        Self(None.into())
>> +    }
>> +
>> +    #[inline]
>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
>> +        (self.0).0.take().ok_or(EINVAL)
>
> I've experimented a bit with my earlier suggestion of having a wrapping
> `Required` type because I wasn't so sure it would work, but it seems to
> be indeed doable! Here is my draft implementation:
>
> pub(crate) struct Required<S: Schema> {
>     inner: S,
>     parsed: bool,
> }
>
> impl<S: Schema> Schema for Required<S> {
>     type Target =3D S::Target;
>
>     fn init() -> impl Init<Self> {
>         init!(Self { inner <- S::init(), parsed: false })
>     }
>
>     fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
>         // Reset `self.parsed` to make the schema empty again per the met=
hod contract.
>         let parsed =3D core::mem::take(&mut self.parsed);
>         self.inner
>             .finish()
>             .chain(move |_| if parsed { Ok(()) } else { Err(EINVAL) })
>     }
> }
>
> impl<'data, S: Schema + Visit<'data>> Visit<'data> for Required<S> {
>     fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'da=
ta>) -> Result<bool> {
>         let consumed =3D self.inner.visit(key, index, value)?;
>         self.parsed |=3D consumed;
>         Ok(consumed)
>     }
> }
>
> You need to convert all the `Required<T, ...>` into `Required<Key<T,
> ...>>`, but this reads more logically I think, and now you can combine
> `Required` with more types. I believe you could also implement
> `Optional` in a similar way.
>
> (you will also need to add a `#[derive(Default)]` to `FbRegionFlags` on
> the next patch, but that's not a big deal since it wraps a primitive
> type anyway)

Thanks for prototyping this, will add this in.
