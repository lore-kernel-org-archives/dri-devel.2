Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10575C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D6810E552;
	Mon,  3 Aug 2026 12:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wb/IVO3+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D622610E5D2;
 Mon,  3 Aug 2026 12:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4khwSvF+BR6Qr/IDZE5THJoo7cCx3fY2ZWkiQNiqHBefv4G4aXJT7Kbs55i9LJJmcJS8cEVSeBHXNUB3vPYSkUp9QCM03lPrs8qaLPVildlW5+8mqzz35v7g7R2bDcUGlfs9KpYKTYxntZZbw961LWwNxXYK2n7O88UyrYpiIHBqcr3awUboraJAYAM0vRDN6z+dT1ou5INgN/7PFVpDRScO05rIFFNQcOOqKmZOPyFiRyo6+A5Oo5XEmlC19AEIKHWV2VBdyWnpBVIQ6/phO41QGpB684grLZeUQxPpeB6uNNtD4p5xueVejgt8bWZ8n/rE2NZf9h2pu5eEqiBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHkT2CX3mAORT2Ymj5VDNFZhJRo3uLww8Vcfv3wsNT4=;
 b=MhHizLdoQ9ZEo8ZodKshmHP79PfIakRf/44MR+QywEV/ljIy6J1kkk8jV6y7WW7tKpUokx3w5VBAkHsQr6lrf9jAJmfWoU1CTs8cAg5gQ6r+YDStDIhb6vT1sKCMIjl+4vJUWQoXYdUghJE+xqO99AD2BJHBLNQP0eloOUCbifpWIVSshEVVEx05b7WZTsiv7qqtp8dPYAtr/YtzX51BPZKLyzOM1PRkQcRAjsiBoGzAeusWcQZQDDv5GyIjtAI7Scr/v//RfTmDVjwr2n7lYcHoGlDnZSr/aBHGQn34Zu7Wl28O0ci0gQ76xy1PkEma5VVIoyCH8QKn7j4sjan7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHkT2CX3mAORT2Ymj5VDNFZhJRo3uLww8Vcfv3wsNT4=;
 b=Wb/IVO3+0K04fKKo+r2Z6uGLKLldaQzk/0f4UJ2YyFvsl3Fe/RWu8iMJMcR9vYuOXk1YHnfkpzGIL6sGSkU50rvnd4DiJfqOp4J4znoPDh55vhJXyxehl8ol29i6Gq49T1nHc+fCk4FEYWGvA3Zp3DnNCxo/40zJsKJUry6+6A6f1Zv8gAJ7RcnnSRz5ZO7Zxd9OKEEr2rOIDBF1lhDXSlYimP87hLpeYj/YORKfrjWoKya+W9onYHs1ylpDMZ1cqU8ofwcC1DLakZX1tTs8mmfLj0Z+/6e7mZjQDz/yJgHm9MGxliZNpwl32jdapPKBVjTUGb8fYLfUMZwtSMrhyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:41:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:41:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 21:41:42 +0900
Message-Id: <DKFBEPDNAD1V.1LFARFHMO5WKC@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/4] rust: bitmap: add contiguous area operations
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
 <20260729-chid-v3-2-20cc08032bbc@nvidia.com> <amrZcX33BGJCTDMp@yury>
In-Reply-To: <amrZcX33BGJCTDMp@yury>
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6667d1fc-9d25-496e-60ce-08def15c94af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|4143699003|5023799004|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: e8Cw9j0nxW1gPUB+Pjz7RnKZPLj3js/hNAm4++U6nUkOpD/PNhu1xfebsDQeyKnP5Ee2nNgSo+aji/KuSUTf1JmiF9HS7RV5Pboj0pLGm/96oeCdrPRXC66JyYq+4R/qlFHR2vwSG4EUHrRwgj2hIw61tmPOXdbsDkk9WEB7C5nZp7iCqXBk1STtciQg1T8SmqwOQGSzQ/AGcSD+hx1/gC9PzpnwxV+XvW17tcT9Jfvs5J8aa1d7f8jeqLBdVUCEWk7l9dRm+W345rY6Ez2GBLMWpPHGyi0y1cymhhKOuaFXy2WDUBhju6ULsYgJCVKotD+ZGEsCYPTgKS+Pyy0nsopiusvvXiVe2DxnOj3erUSLnWqbSLEfaCcmyMDziqUgx7ksWihWF2kagJuO9HvRDCT9LBwaGgwOpRQ1VYD1mV7bIMftreAoNK+eebxd5A96aB6g0hVxlhNSA2ydbsqcZE+uhC2Yy7u2phrcGgS25dseb9tLT9u3vZ752MsA9Ue/Ze2gKXzOQQEzsOHwZALK8n+ngPwcM5QL3atpFf6eBWxWzRq++wYE5ilW46i8K94l1p8Lua58ohrGsreieg4O8Cu3UvPFQwm9RcYOiOY7YQ/tGGojy3cxWBmb6uWd4vsstkoWAUcVnfkMQQpnsXzu271RysbUqZDMQB+/UgnyzAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(5023799004)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHh4STU2d2VDQ3NWekhBNzZha1pjV1dpVU5EUFVabUVVcEhPbTM5eXhjWHpK?=
 =?utf-8?B?Ry9RanhxQkVuWnRkZ2lWV3R5R1c4aVhWOElRaEtJWGt4blo0NDJsRnRaQ0Rl?=
 =?utf-8?B?QzdzbzNMVkFvVTcvc3BrVU5jbGZiMEdOeHZsUkxsekR3bVBJektpQmhLVFh5?=
 =?utf-8?B?VWlRTUNVdWVpVnFuSytTSUZ5VFJzR25KcmRrM2lDamkzNXAzZGF1d2ZPVkQv?=
 =?utf-8?B?Si9pcHNFRHdjU281Tkl6YjFmbnFIbmhWSlhPaVJGWE1nZDVMK1B3NEJmVndK?=
 =?utf-8?B?MlhUUW14V3hoWU5hQ3NKdjZLRjhkandjZUpOMFAwanpxV3gxQThaMk8zbnhr?=
 =?utf-8?B?eUM4RnRnMW5jRGlDTDFMUXNHWWNpTmJqOW1zVTVhZk1WcmFKa2ZZdzdIalZF?=
 =?utf-8?B?QURMeHgrbG1CcmJaWURwVWJLaFVPRjJad0xBMG1naE80Vk5xNXpCaXNHY290?=
 =?utf-8?B?UjhKbS9YK2RkMDJZa2p6NklaazAwZWxoOUFjU294MzZ3T3hTWFBJYmJIRHE2?=
 =?utf-8?B?QzdqNmc5R2Ivc0xDQmFSRk9kcFdOS2xyek15MWZXQzJXSzN1a0tsb1hWTTE1?=
 =?utf-8?B?VWNIbUxBa1A4dVJEMDAwY2w4SjN6M2xXeE9ZQ1c5ZFVadzczdmRsdENlOEZp?=
 =?utf-8?B?UWVINGhvNXdxdjl0K1hGOXBkSitRRUJaZ3Fhdi9yaC85M3ozUWNvaTVEN3Av?=
 =?utf-8?B?OXdhdElCMVN3V2U0Q1hZanlVU08zQXZEQ1MxRTdsNWlqRWs0bFk5OGNIZEVy?=
 =?utf-8?B?R0tab0FkTUlhRnh1YXdsMlZzYWhubjM2Sk9Ma3FaNkZMTHlBSkxHMHo4dVI2?=
 =?utf-8?B?MUZSZDYxeDlqdlA5Sm1NMGFZMklUOGNZbkRNTFVDYTNodzUrVVB1SlR2U3hB?=
 =?utf-8?B?dWcwUW12TFFPQnRNOC9wLzZocHBhSlRpVE4rNnhSL3JxWUtoZWE2SWhuKzE2?=
 =?utf-8?B?Nk5GUmNJaHIrdDZJUGlKMG5WN0RldEFQSXlyemJlVmtnZVN3YnN2OGJOTGRD?=
 =?utf-8?B?WE1LVWUrVHFMT2xqUVdsaXdYbzBYL1A2djRQRW8xb3FxMm1hQzE3SVpVM0tR?=
 =?utf-8?B?anFONFZGbW5YYXlxaW4xbDFzOTUzVFpITHdWL2NoVnRTMWRmZERMdXBNa05r?=
 =?utf-8?B?V2lJS0hieFJlQkdUelZhZGZpV25QdVEwVVB1N01XZ0h6YkVBd0NFc2NsaVp3?=
 =?utf-8?B?ZVdUeHExajAxd2JVYiszdE9ZaFhBdnR2ODJNSHJXMkZJWGt3b0IzbDdjeklE?=
 =?utf-8?B?SXp0dm9hSzJKZjNkSVVYTkpjVEZDSStWaDJQeDdqak8xOU56cnVCbEU5UEt6?=
 =?utf-8?B?T0VnWHVnSEd1amdJNGVtQVRRYjgvTmFKRG1vQTZsYXFpbXF3L1hQeTBLVnpL?=
 =?utf-8?B?WE5xNmpzekZIVHROamxEdm5mOUlXdlM3MmVlTElndGZhTTgvV1h1Tjh4VEpx?=
 =?utf-8?B?WHpFNjIvYitsbEZGMWp1MGtRWFdWS2RjRkRoY0NGeG9TRS9MSlp4emJrd3A1?=
 =?utf-8?B?UUJGVUpNZVAxRHE2S2tJWkdTZE5wa3krekhVL1FxbVFnTkVmV2xSSHVQNC9V?=
 =?utf-8?B?T1lKS2JCOXptVzJVMktFR2YxSk8zY3ZrM0RhTHFnRG1sMUVuOXRKQWxHSGxL?=
 =?utf-8?B?bWZML0oraUpIUnI2NFVaa2ZuZjRMZFhtakR5UmJLb1Nwd0tuSWVjRGlxY2Jm?=
 =?utf-8?B?WFN2UEpuQ2JURWxOemF1Zk1nUCtxL05KTllSNWhFbVgreGhJejdJQWUyVjFz?=
 =?utf-8?B?bVIyMjUyT3Q3RnB4OG5iY0lMeVAzT3F0cGVnZDk0Q3pBQlBnUGFvS0R4c3VS?=
 =?utf-8?B?TkwyazJHdkV0QkJDUTVqMEpBd0I0ajRsZTVUYXlLR3FUd3U1SktBaTNYbVNZ?=
 =?utf-8?B?aEZveDRyTFhVaWRicWVNd1BLWkV0VW5xN0IvelVaaFJ1cHNMeG42a24rMllK?=
 =?utf-8?B?NHgzbWJIa21GOFNYM0M1Y0VlVlFqMVkzMk9CYlgvbVJ0M1hUaTZwU3N3U3Bl?=
 =?utf-8?B?UEdrenc4bWJHckVxOGhWdDMrL3FKVjJUSmJrMzNsYUVxd3RJWFVCZE5iNnVW?=
 =?utf-8?B?dUthT3VGY3cyODl2Y0NoL2RiNnphUEtuOEJtM3EzdzJ1QlU4b2p5OWtreVgr?=
 =?utf-8?B?VlFjWlJ2dHZWVmlyYUtHekVrcTJrVGZOUDl4aHNqaERTbGNhY0Z5MGU2a1Nx?=
 =?utf-8?B?UDUxMWtaYnFzNFBWS0Y3elB6YXZGdkdnM2MrVS9SRW5WT2xsZWo2aGNNTVln?=
 =?utf-8?B?ZHRsaDVFME1lazEzY21sRDFVdHZ5Z0RXMmZlVjA1WnFMV0tHRDFCUjQ3TGpJ?=
 =?utf-8?B?ZlRQQlo5ZG4xd1BaK3UvZUxISFA4QVNFYzNFY1ZDalVlRVdVYjVadE52R2F2?=
 =?utf-8?Q?hJyv3cQlLrx+KdWkeWsYYzAk9CiqPmgVwfdPh+w/mBw06?=
X-MS-Exchange-AntiSpam-MessageData-1: aRDW3XRofbyD0g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6667d1fc-9d25-496e-60ce-08def15c94af
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:41:46.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvfKtRBSAXPZxkbWN6VcnqE5+xF/rg+8u9N3TCoI+Cgf9gm5qaizhJZL0Mltinani+893PUyCDNCk5cukokIPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

On Thu Jul 30, 2026 at 1:56 PM JST, Yury Norov wrote:
> On Wed, Jul 29, 2026 at 03:54:13PM +0900, Eliot Courtney wrote:
>> Add bindings for area operations on bitmaps. Each one is
>> made safe by adding some extra checks compared to the underlying C code
>> (for example, checking bounds) and with additional checks to catch
>> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
>>=20
>> The C code uses signed integers for some parameters, for example the
>> length for `__bitmap_set`, so bounds check against i32::MAX. We can't
>> rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
>> backed by `BitmapVec`.
>>=20
>> Add tests demonstrating the edge cases.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/bitmap.rs | 194 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 194 insertions(+)
>>=20
>> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
>> index a43bfe0ec3dc..f4b0b8ae39d8 100644
>> --- a/rust/kernel/bitmap.rs
>> +++ b/rust/kernel/bitmap.rs
>> @@ -10,6 +10,7 @@
>>  use crate::bindings;
>>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>>  use crate::pr_err;
>> +use crate::ptr::Alignment;
>>  use core::ptr::NonNull;
>> =20
>>  /// Represents a C bitmap. Wraps underlying C bitmap API.
>
> Some comments use indicative form in the file, but the imperative
> 'represent' is a more standard way. Can you please use it instead?

I think in rust, indicative is the standard even in the kernel - e.g.
see Documentation/rust/coding-guidelines.rst around line 208-ish, and
that's also what I see generally in code. But please let me know if
you'd like me to use it in this file regardless.

>
>> @@ -497,6 +498,116 @@ pub fn next_zero_bit(&self, start: usize) -> Optio=
n<usize> {
>>              Some(index)
>>          }
>>      }
>> +
>> +    /// Finds a contiguous area of `nbits` zero bits at or after `start=
`, aligned to `align`.
>> +    ///
>> +    /// Returns the bit index of the start of the area, or [`None`] if =
no such area fitting in
>> +    /// the bitmap exists.
>> +    ///
>> +    /// The returned index is a multiple of `align`. Alignments where `=
self.len() + align - 1`
>> +    /// overflows a `usize` can hang the underlying C code.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is=
 out of bounds.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
>> +    /// use kernel::bitmap::BitmapVec;
>> +    /// use kernel::ptr::Alignment;
>> +    ///
>> +    /// let mut b =3D BitmapVec::new(64, GFP_KERNEL)?;
>> +    /// let unaligned =3D Alignment::new::<1>();
>> +    ///
>> +    /// assert_eq!(Some(0), b.next_zero_area(0, 8, unaligned));
>> +    /// b.set(0, 5);
>> +    /// assert_eq!(Some(5), b.next_zero_area(0, 8, unaligned));
>> +    /// assert_eq!(Some(8), b.next_zero_area(0, 8, Alignment::new::<8>(=
)));
>> +    /// assert_eq!(None, b.next_zero_area(0, 65, unaligned));
>> +    /// # Ok::<(), AllocError>(())
>> +    /// ```
>> +    #[inline]
>> +    pub fn next_zero_area(&self, start: usize, nbits: usize, align: Ali=
gnment) -> Option<usize> {
>
> Please create the rust wrapper next_zero_area_off() around
> bitmap_find_next_zero_area_off(), then in rust create the
> next_zero_area(), if you need it.

Will do.

>
>> +        bitmap_assert!(
>> +            start < self.len(),
>> +            "`start` must be < {}, was {}",
>> +            self.len(),
>> +            start
>> +        );
>> +
>> +        let nr =3D u32::try_from(nbits).ok()?;
>> +
>> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with=
 an out of bounds `start`
>> +        // value and never reads beyond `self.len()` bits.
>> +        let index =3D unsafe {
>> +            bindings::bitmap_find_next_zero_area_off(
>> +                self.as_ptr().cast_mut(),
>> +                self.len(),
>> +                start,
>> +                nr,
>> +                align.as_usize() - 1,
>> +                0,
>> +            )
>> +        };
>> +
>> +        // In case of overflow, we may get back a range outside of what=
 we requested.
>
> No, we can't. We've got the test_bitmap_find_next_zero_area_off() for
> it (in next). If you think the test is incomplete, please extend it.
>
> If you believe that bitmap_find_next_zero_area_off() may return something
> like that, it means the function is buggy, and you shouldn't trust it at
> all.

TL;DR: Included some tests below that demonstrate overflow/OOB issues on
32-bit (with increased vmalloc) in some extreme cases. To keep the rust
code completely safe we need to check for these, or update the C code,
but not sure if the perf tradeoff is worth it. Please let me know.

Ok it seems I was looking at the code previous to df81d444dc74 ("lib:
bitmap: optimize bitmap_find_next_zero_area_off()"), but overflows can
still cause wrong behaviour after this commit too:

[1] On 32-bit, suppose we have an empty bitmap with size=3D=3D64, start=3D=
=3D32,
nr=3D=3D2^32-1, and align_mask=3D=3D0. Then, computing `end` overflows to 3=
1.
Computing `end - off` then underflows (31 - 32) which can cause OOB
reads. So actually we need a check before calling
`bitmap_find_next_zero_area_off` to avoid this case.

[2] On 32-bit, suppose we have a bitmap with size=3D=3D2^31+2 and all bits
set except the 0th and 2^31+1st bit, and start=3D=3D1, nr=3D=3D1,
align_mask=3D=3D2^31-1. We'll compute start=3D=3D2^31+1+2^31-1 which overfl=
ows
to 0. Then we'll end up returning 0 which is below start. So we need the
`index < start` check.

The C side function looks very perf sensitive to me which is why I
didn't update it (plus it's 32 bit only issues, essentially), instead
putting the checks in the rust side, but what do you reckon?

Previous to df81d444dc74 ("lib: bitmap: optimize
bitmap_find_next_zero_area_off()") overflow can happen and cause issues
although the cases are slightly different for what it's worth:

[3] On 32-bit, if we pass start + nr overflowing a u32 then bitmap.c
`end =3D index + nr;` can overflow and we can return a value less than the
size of the bitmap even though we couldn't possibly allocate something
of size `nr`. So the check of index.checked_add(nbits) is needed. For
example, in bitmap_find_next_zero_area_off, if size=3D=3D2, start=3D=3D1,
nr=3D2^32 - 1, align_mask=3D0, then we calculate index=3D=3D1 (if no bits i=
n the
bitmap), end=3D=3D0, i=3D=3D0, then return 1, even though we should return
something >=3D 2 to indicate it's not possible.

[4] Harder to trigger, but with a full bitmap (except the 0th bit) of
size=3D=3D2^31+1 on 32 bit hardware with start=3D=3D1, then we compute `ind=
ex =3D
find_next_zero_bit(map, size, start);` as index=3D=3D2^31+1, which then
overflows to 0 if align_mask=3D=3D2^31-1. Then for nr=3D=3D1 we have end=3D=
=3D1, and
compute i=3D=3D1 (since end=3D=3D1,index=3D=3D0 and the 0th bit is zero) an=
d return
0. So the check `index < start` is necessary.

Here are some tests demonstrating some of these issues:

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 56bd23059b26..0ba735aafefc 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -238,6 +238,7 @@ static void __init
 test_bitmap_find_next_zero_area_off(void)
 {
 	DECLARE_BITMAP(bmap, 192);
+	unsigned long *big;
=20
 	bitmap_set(bmap, 0, 192);
=20
@@ -269,6 +270,30 @@ test_bitmap_find_next_zero_area_off(void)
 		bitmap_find_next_zero_area_off(bmap, 192, 0, 32, 0, 0));
 	expect_eq_uint(1,
 		!!(bitmap_find_next_zero_area_off(bmap, 192, 0, 33, 0, 0) >=3D 192));
+
+	/* Reads out of bounds on 32-bit. */
+	bitmap_zero(bmap, 64);
+	expect_eq_uint(1,
+		!!(bitmap_find_next_zero_area_off(bmap, 64, 32, UINT_MAX, 0, 0) >=3D 64)=
);
+
+	big =3D kvmalloc_array(BITS_TO_LONGS(BIT(31) + 2), sizeof(*big), GFP_KERN=
EL);
+	if (big) {
+		/* Returns below start on 32-bit. */
+		big[0] =3D 0;
+		big[BIT_WORD(BIT(31) + 1)] =3D 0;
+		expect_eq_uint(1,
+			!!(bitmap_find_next_zero_area_off(big, BIT(31) + 2,
+							  BIT(31) + 1, 1,
+							  BIT(31) - 1, 0) >=3D BIT(31) + 2));
+
+		/* Reads out of bounds on 32-bit. */
+		big[BIT_WORD(BIT(31) - 2)] =3D 0;
+		expect_eq_uint(1,
+			!!(bitmap_find_next_zero_area_off(big, BIT(31) - 1,
+							  BIT(31) - 2, 3,
+							  BIT(31) - 1, 3) >=3D BIT(31) - 1));
+		kvfree(big);
+	}
 }
=20
 static void __init test_fill_set(void)

>
>> +        let end =3D index.checked_add(nbits)?;
>> +        if index < start || index >=3D self.len() || end > self.len() {
>> +            None
>> +        } else {
>> +            Some(index)
>> +        }
>
> So, this should be a simple:
>
>         (i < len).then_some(i)

For [3] we need the checked_add. For [2], [4] we need `index < start`.
`index >=3D self.len()` is the regular check. But you are right, we don't
need to check `end
> self.len()` here.

Alternatively, if we restrict Bitmap (not just BitmapVec) to a size of
i32::MAX and  check that `nbits <=3D self.len()` (to handle [1]) before
calling `bitmap_find_next_zero_area_off` then we can reduce this to just
`(i < len).then_some(i)` as you say. For non-zero offsets
(next_zero_area_off) we need an additional overflow check though.

>> +    }
>> +
>> +    /// Sets a contiguous area of `nbits` bits starting at `start`.
>> +    ///
>> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `sta=
rt..start + nbits` is out of
>> +    /// bounds, does nothing.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `=
start..start + nbits` is out
>> +    /// of bounds.
>> +    #[inline]
>> +    pub fn set(&mut self, start: usize, nbits: usize) {
>> +        bitmap_assert_return!(
>> +            start
>> +                .checked_add(nbits)
>> +                .is_some_and(|end| end <=3D self.len() && end <=3D i32:=
:MAX as usize),
>> +            "Area `start..start + nbits` ({}..{}) must be within bounds=
 {}",
>> +            start,
>> +            start.saturating_add(nbits),
>> +            self.len()
>> +        );
>> +        // SAFETY: The area `start..start + nbits` is within bounds.
>
> Not sure I understand. In the above assertion block you check for it,
> now you say it's always true...
>
> I think, your language should be similar to the
> find_next_zero_area_off() case: it's safe to call the function with
> the out-of-bounds start and nbits.

The assertion block still checks, even if CONFIG_RUST_BITMAP_HARDENED is
off (just prints an error returns in this case), so at this point we
know that the assert predicate is true. In this case, per the file
convention we take start and nbits in usize, but the C function doesn't,
so we need to make sure we don't truncate when converting to u32 and
i32. Also, it's not safe to call __bitmap_set with start and nbits such
that start+nbits is greater than self.len(), or we can write out of
bounds, so we can't use the same language + we need the check.

>
>> +        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32=
, nbits as i32) };
>> +    }
>> +
>> +    /// Clears a contiguous area of `nbits` bits starting at `start`.
>> +    ///
>> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `sta=
rt..start + nbits` is out of
>> +    /// bounds, does nothing.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `=
start..start + nbits` is out
>> +    /// of bounds.
>> +    #[inline]
>> +    pub fn clear(&mut self, start: usize, nbits: usize) {
>> +        bitmap_assert_return!(
>> +            start
>> +                .checked_add(nbits)
>> +                .is_some_and(|end| end <=3D self.len() && end <=3D i32:=
:MAX as usize),
>> +            "Area `start..start + nbits` ({}..{}) must be within bounds=
 {}",
>> +            start,
>> +            start.saturating_add(nbits),
>> +            self.len()
>> +        );
>> +        // SAFETY: The area `start..start + nbits` is within bounds.
>> +        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u=
32, nbits as i32) };
>> +    }
>>  }
>> =20
>>  #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
>> @@ -614,4 +725,87 @@ fn bitmap_copy_and_extend() -> Result<(), AllocErro=
r> {
>>          assert_eq!(Some(17), long_bitmap.last_bit());
>>          Ok(())
>>      }
>> +
>> +    #[test]
>> +    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
>> +        let mut b =3D BitmapVec::new(128, GFP_KERNEL)?;
>> +        let unaligned =3D Alignment::new::<1>();
>> +
>> +        assert_eq!(Some(0), b.next_zero_area(0, 5, unaligned));
>> +        b.set(0, 5); // Now contains {[0, 5)}.
>> +
>> +        assert_eq!(Some(0), b.next_bit(0));
>> +        assert_eq!(Some(4), b.next_bit(4));
>> +        assert_eq!(Some(5), b.next_zero_bit(0));
>> +        assert_eq!(Some(5), b.next_zero_area(0, 5, unaligned));
>> +        assert_eq!(Some(8), b.next_zero_area(0, 5, Alignment::new::<8>(=
)));
>> +
>> +        b.set(8, 8); // Now contains {[0, 5), [8, 16)}.
>> +        assert_eq!(Some(16), b.next_zero_area(0, 4, Alignment::new::<16=
>()));
>> +        assert_eq!(Some(16), b.next_zero_area(0, 4, unaligned));
>> +
>> +        b.clear(0, 5); // Now contains {[8, 16)}.
>> +        assert_eq!(Some(0), b.next_zero_area(0, 5, unaligned));
>> +        assert_eq!(Some(8), b.next_bit(0));
>> +        assert_eq!(Some(15), b.last_bit());
>> +
>> +        b.clear(16, 0); // Zero-length in-bounds clears are no-ops.
>> +        assert_eq!(Some(8), b.next_bit(0));
>> +        assert_eq!(Some(15), b.last_bit());
>> +
>> +        // A zero-length request returns the first aligned position at =
or
>> +        // after the next zero bit, even if that position's own bit is =
set.
>> +        assert_eq!(Some(1), b.next_zero_area(1, 0, unaligned));
>> +        assert_eq!(Some(8), b.next_zero_area(1, 0, Alignment::new::<8>(=
)));
>> +
>> +        b.set(60, 10); // Now contains {[8, 16), [60, 70)}.
>> +        assert_eq!(Some(60), b.next_bit(16));
>> +        assert_eq!(Some(69), b.last_bit());
>> +        assert_eq!(Some(16), b.next_zero_area(9, 40, unaligned));
>> +        assert_eq!(Some(70), b.next_zero_area(0, 45, unaligned));
>> +
>> +        b.clear(62, 6); // Now contains {[8, 16), [60, 62), [68, 70)}.
>> +        assert_eq!(Some(62), b.next_zero_area(60, 6, unaligned));
>> +        assert_eq!(Some(61), b.next_bit(61));
>> +        assert_eq!(Some(69), b.last_bit());
>> +
>> +        b.set(64, 0); // Zero-length in-bounds sets are no-ops.
>> +        assert_eq!(Some(62), b.next_zero_bit(62));
>> +        Ok(())
>> +    }
>> +
>> +    #[test]
>> +    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
>> +        let mut b =3D BitmapVec::new(64, GFP_KERNEL)?;
>> +        let unaligned =3D Alignment::new::<1>();
>> +
>> +        assert_eq!(None, b.next_zero_area(0, 65, unaligned));
>> +        assert_eq!(None, b.next_zero_area(0, usize::MAX, unaligned));
>> +        assert_eq!(None, b.next_zero_area(1, usize::MAX, unaligned));
>> +
>> +        b.set_bit(0); // Now contains {[0, 1)}.
>> +        assert_eq!(None, b.next_zero_area(0, usize::MAX, unaligned));
>> +
>> +        b.set(0, 61); // Now contains {[0, 61)}.
>> +        assert_eq!(None, b.next_zero_area(0, 4, unaligned));
>> +        assert_eq!(Some(61), b.next_zero_area(0, 3, unaligned));
>> +        assert_eq!(None, b.next_zero_area(0, 1, Alignment::new::<64>())=
);
>> +        Ok(())
>> +    }
>> +
>> +    #[test]
>> +    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>> +    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
>> +        let mut b =3D BitmapVec::new(64, GFP_KERNEL)?;
>> +
>> +        // Should be ignored since out of bounds.
>> +        b.set(64, 4);
>> +        b.set(62, 8);
>> +        b.set(usize::MAX, 0);
>> +        b.clear(usize::MAX, 0);
>> +        b.clear(2048, 8);
>> +        assert_eq!(None, b.next_bit(0));
>> +        assert_eq!(None, b.next_zero_area(64, 1, Alignment::new::<1>())=
);
>> +        Ok(())
>> +    }
>>  }
>>=20
>> --=20
>> 2.55.0

