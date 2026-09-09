Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ABCC79FA1
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5E310EE41;
	Wed,  9 Sep 2026 01:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jqpRZGE/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6CD010EE41;
 Wed,  9 Sep 2026 01:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1tfp3UsuHVhENksQhEwcQ2R1hZwpH1mKsGWoTXq67UkVykv8u5kg28ShTIMthWaC3pB5/yODvPAIpDeMdexVOo0wbpaPxO7Z7E0hxFn1PFcf8gK8AvqJR/wmEIMoS2IP+F41JcCcctPowx+zeqHhouRD32Foq7HjBkbqiwb0JJzflyhdiCQt82gLLeJeKW87oHHjnDOoDTZ/4i+KPLkWUWtos8O9E19lPWjGSN8YJB+eavJLobS451qSuiVr7/W7FcPVi+Jbo1AtqLPvK9ax3f3Q7VM8b0BYRfwJN34YgNxlPPiT/20BTgpT1H6l1yqoC4zxgwKaKAybcLDWfGinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ0hPDkD9gCSxCo9GZQzODtFpcKkm9sKS2kMyeySX40=;
 b=dHBBEs574+Aaoqqb3uY46jpmE+6Rpk+7tHIeeLdVPGWCSYYCaTuURhH9NefNZFz7f2kFOIlyZvoMMZA2RnjivrTBt3morH9yVFuCH0QV8TjmWLnRaqJP3JEQo7Rwxl9eMHujFdAV1rvjAofPFkW45FGWc8phDpp5JhL3ybpFrYiyEZc1oJ8TFafgRrEjREx4N4OOEZeeIVADLa5eFBGVvtmoYgLjfV2t+se1fjAcb5BuF4c7I5wSZj62qsCaFO5Rtmemy2uqh19+zZ4kYncrtYcdHevuLd5dC+8+gFJVLBX8R7eJQr6aLEkBwfb182aOwEo5T1uqM5ubwGfrOeDDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ0hPDkD9gCSxCo9GZQzODtFpcKkm9sKS2kMyeySX40=;
 b=jqpRZGE/BC9jQ/Hu4Kamf93d6MJLq1nIV8Xztn4W7zugVTE/OFzN5H2ygN33efMtSFaXqgKjaQZ8roRW/ugjlGVFUm9l6VT0g6DP55wI5KMlNrsa32B3417MjKeZE3bPzBnyAv6yRVxfXQH7imxObac2W4p1FZkI/G5iDG+5N1ePI4hg2TpaYsjuU+7n4nLhyFTzt6p0RAlPEzHc3KbvsBe6YPu3YPQI25Oj43+lSG5RD+od2jriiClwuKJcA/4JVydFn8YuczacUCcfQAlFdd9ICMDGUTNBWJ0VFXVKTPntPaItCzrAf9y4tLJSPH+rzs1liCYorus31vBgyjA8jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 01:13:57 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 01:13:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 10:13:53 +0900
Message-Id: <DLADY8BA86SI.125037GQGOEN7@nvidia.com>
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
Subject: Re: [PATCH v2 5/8] gpu: nova-core: add NVKV decoder
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
 <DLADH5QVXWSD.2FO9OVBIGYNQG@nvidia.com>
In-Reply-To: <DLADH5QVXWSD.2FO9OVBIGYNQG@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 5846a517-6321-44ad-2654-08df0e0f9f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|6133799003|3023799007|10067099003|11063799006|18002099003|5023799004|56012099006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: VcRrXeXD15NGrdcOdKgwdnIPsGoYbggVyhkFEZhxeb/TbgCptfhHP1Epra3fbotNzA/s+sekkmhs9qOrG7z569zbeyYy+ApPJS7g5n9rhpJRCW/KKhAIUTbbXsDoL4mZAjDef6eQSK57f8grsYC95BH5EyFAMniu3dPQvB7G4HoNz4EnUDxvUKZB8mfd0IEKIpliahVdi1MK31XmX3dFYylet8woVMhlYQUwjtpTs8SoJmSe0WTHlDIiYz6m2miyDYpR3o+BBPOHs61UAKKWECxxZRItvWLByq0KbJPF+Vxb8AnDb4IQlRgMQTcBVE77y34NeUsHFTXOXaifA0cioY7++taf3bbVrGwaeOR4hnB8q95BA8uaqKXIji5CNsuEhVJElMW1jxO1tuDfibbn5ZwBeqiTSpblU50wbbOB5G2K+hngFS2eqOzBEBcUSuxttx2kU/lNKm2yzWJba5oav+N/1QJL5fJoKVcjB1LQHFt/qtmINzE+pWGg17iZF3l+tYrkK+ebI1MAYQL0UdemIND/ChYrm8QWK3ixyugUvaHIIGNkR20xDODknOwPmYVED6lOf5WpKgUIgxkbc8+LowZuuN8xOkxLLxOwWJlQNtsEPHb3ksS4zNnLa27FdU/wq8ofsYLA7qZUVFr/AvsOeCk8uFXqDqP5rIhlxU4g+dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(6133799003)(3023799007)(10067099003)(11063799006)(18002099003)(5023799004)(56012099006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJhSmJqUlMvOXp5S3praC85M0xVZVp5ODJSY2k1TGtrNFM5ZUpndnBPenZH?=
 =?utf-8?B?Q2V4dmFjQUJaUkp6RGh1UlRlSXhqamFlU09vcjJCZVc3VEVoOUVyYVhmNnBF?=
 =?utf-8?B?aVIrU2JycHF0OEVtUDI5QUVSSUhua29yalpkcWk5enpsbDd2bnFkQ0FpdExP?=
 =?utf-8?B?ajk4d1NGRmNHT3hCS3FFTHlZT2w5MktQOWliaWVoc3UzdmtNYlg4aWZUbkhJ?=
 =?utf-8?B?TzRNN0xmcDZrbUtEVVJTcVJyNTFDR1hGa3NLTTl3bE5tWnlwR3hlNTFTc0xv?=
 =?utf-8?B?WG9pZG5mTjRGVEQ4VVA0MUcwTDFkSWExVGpLUFk1U0daUkJad1puSkFlWDdB?=
 =?utf-8?B?ZVN4MmdxVHJvVm1UNjJoV2tjdUxYblF4eE9GSkNlSng3bm9zUGRTSUNKdGdQ?=
 =?utf-8?B?M2M4YlVvZ0s3T2pwamdnZzN0WGpYN1g2aGNnQk9qYS9nTHRIenNFbDh3S2Yw?=
 =?utf-8?B?UGwwUHBIV1VXT1Z4Rmhwc1dBUHV2Y0lwMmZ0M0NnUXhuZ0NLQlNLcGhoUU85?=
 =?utf-8?B?Rm5vTWVZT1IxclppV0IzeGwrVFpERXUyT1YwOFhXTGNUU1hTalJGOG5reUJq?=
 =?utf-8?B?NXN6NnhRcmUzelZYbFVDOEc2YkJ0V3RlSXhRV1QzNGREcXIrY2VnZEtJRGhU?=
 =?utf-8?B?WjNybTBMRkZSSGhtaGhoOUlPOWxwazBjZDJTRGE1dkdzMnEyQnhQeWE0c0JS?=
 =?utf-8?B?Y0R3WkRHdzRTa2VMbkpvaTd4YTk4NzFYekRnNGVtS3FaN0M4ZTdPOUptbzNR?=
 =?utf-8?B?U05LbkVYVWVDNHhUN1YvQWg0ejRCcEgxUlBFWCtZQW1IbXR5UDY4LzRqSXdY?=
 =?utf-8?B?ZFcxdEFaU1cycXE2Ni9ZNm9nUEgzWC9PYlVzalF4emp4clJlZmk1RTRlMUs0?=
 =?utf-8?B?NFRwMllrcEpZQTR3SnBmemM1S04rQzdSUURnNVd4NDRkOHBwWitYNGpVWXFt?=
 =?utf-8?B?bW5nbFM0Zk9tbUcya3hpd0dyd2hDRjRXcHFTSDFHMTFYQWFNWUlpWlNRRXB4?=
 =?utf-8?B?WGZIQlF0L1BxRVZIMUR6aXhNK2NSR0lTMnBCZ3l3TmxnRDRQc2MzVTYwaU9U?=
 =?utf-8?B?ZmM5bWxVckFrZ1MycFE3dklqeGYxSCtMN0tEb0lqNTk3cFZlbmE1dkdIQVUx?=
 =?utf-8?B?enlHdFBDNXB0bGNNMldhdTlRb1RvbFYwZjJpYmxtYXh6am8wWWNCQUs5OGJR?=
 =?utf-8?B?cjdIVGlsQ2lQU0dSY2d3eCtNc1lsZnNvRW53V2Z3ZFovOTZlRjlGZFIzaGdP?=
 =?utf-8?B?RFdlT1U4d2lIYktWU2F3dGUrWjR0MFcxc3hKMWpOOGdmdG5neCtybU9YN1Jh?=
 =?utf-8?B?OUgwUWZjSXBFcTJCWnlMakNzZkpqcVhLOHoxUEZ0by9LakdxRXo3TUdtWFlD?=
 =?utf-8?B?UXVoZmNMbnU4QzlJa2NRK1djVDhIbTBEMGVvVVhxUXdDUGh6ZjVnT2tpQ21U?=
 =?utf-8?B?b25GT3ZkL1RhMGgrcjZKVmgyWDR0bHFJd3h0aUluSXk0REtiUFQ4bUFkRTZW?=
 =?utf-8?B?VDVzRlJBY2I5ZzdCWkFnQnpNT0Y1RCt4N1RlRHpFWGxHQXdOYjZDekttL1RH?=
 =?utf-8?B?dm5mL0hFK3Jub3Z4UWhOVlYvanA0UFVzc1RETFBvQm50bHVYa20xSHk1SlhR?=
 =?utf-8?B?aE1IbXBQTVUvTE8wMzlaZGpUUEJsQUFzYzBLRVZlL3BSKzF4bzZPaFhhVFNF?=
 =?utf-8?B?NnlGa2x0V010UTl3ME02Wk9hWEo3Mk4zVGhIcnE0MU52WGVpRytRczR5cGZi?=
 =?utf-8?B?Rm5zRUpLTmxlelFmNzN5Q0xOdGs5SEVqVmVjcG4xd2pFRHNjSitMNk9VMHZO?=
 =?utf-8?B?aFN5TWx3UmRGNDVjZGs4emhQR04yWFV6WXdOWUxJOFpvanJGQmlZY1grdFFz?=
 =?utf-8?B?ZG1JWHkzUkV3dHM4MGZLODBicjVmM0VuQmp1TnlWUWhDSVJqL29vSlJHRXQw?=
 =?utf-8?B?VVF1cWpCd2JvUEwwdTNqT2pTNUF6MTh6YXd0Yi9JL3dxNG5FRGZLUXMzTytk?=
 =?utf-8?B?WXF0ZjRYaWQ5TkQ0cjJIdXEyRmJ2bnJLdXU0K1lkZ1ovdjk1YWJaZDJFcXhP?=
 =?utf-8?B?b1ZHMHdnNHBFWE1pZ1JTTzBzT0JGM1BQUklLODN4NlBhanB6UktjSnZmRHBt?=
 =?utf-8?B?dUlyMlFuaytBODRSSnM2VGhaRzYyZXJYc1ZXOW1BM0pZdXptNUFIT2FoNzdz?=
 =?utf-8?B?MGd2a0V5cU95RnlxVHErWmdraTJhSVlFa0g1UGdYcGp5ZktYbkljb3V4QlZC?=
 =?utf-8?B?SU5TK3dYSE1LeVR5LzRqQldQUnlMTWVIMnNBOEEvVHZQZGUvS3BWR0N6clJn?=
 =?utf-8?B?WDNyVXZYUm9PZWR4cXI3cXlHMS8za2JvR3AwZGdiRzZNN1hzQTJmaXp3cm4x?=
 =?utf-8?Q?X1ZyOUsQpdJozoFggy1Uiy6VWC7LUlZFDTYwwnAEUSu4Y?=
X-MS-Exchange-AntiSpam-MessageData-1: 2kU9nx05ZnDqMw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5846a517-6321-44ad-2654-08df0e0f9f60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 01:13:57.2589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU71Tr3a2tWMnrLOAEHaAbLCobbaRvF23eswZ0j65x2VrKTVfvOsnkLIBQwC1WmLVdL9nwofC8Kc4bpdsP5ptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
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

On Wed Sep 9, 2026 at 9:51 AM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>> Add a decoder for NVKV. This is for receiving messages from GSP for
>> GMCAPI calls. The NVKV format essentially encodes a sequence of function
>> calls f(key, index, value). This decoder reads an encoded stream and
>> invokes a type implementing the new `Schema` visitor trait. The
>> `Schema` trait can either consume the value or not, which is useful for
>> composing Schemas. If a (key, index, value) is not consumed, error out
>> depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
>> not is per each GMCAPI call.
>>
>> Add kunit tests for the decoder.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
>>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 265 ++++++++++++++++++++++++=
+++++++
>>  2 files changed, 268 insertions(+)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/g=
sp/nvkv.rs
>> index a8e16687a134..cbeee7f376b6 100644
>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>> @@ -27,6 +27,9 @@
>>  mod encode;
>>  pub(crate) use encode::*;
>> =20
>> +mod decode;
>> +pub(crate) use decode::*;
>> +
>>  /// The allocator backing [`EncodedStream`].
>>  type StreamAllocator =3D KVmalloc;
>> =20
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova=
-core/gsp/nvkv/decode.rs
>> new file mode 100644
>> index 000000000000..ceb97e73e100
>> --- /dev/null
>> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
>> @@ -0,0 +1,265 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFI=
LIATES. All rights reserved.
>> +
>> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
>> +
>> +use kernel::prelude::*;
>> +
>> +use crate::gsp::nvkv::{
>> +    Index,
>> +    KeyId,
>> +    Op,
>> +    Opcode, //
>> +};
>> +use crate::num;
>> +
>> +/// A decoded NVKV value.
>> +#[derive(Copy, Clone)]
>> +pub(crate) enum DecoderValue<'a> {
>> +    Scalar32(u32),
>> +    Scalar64(u64),
>> +    Array8(&'a [u8]),
>> +    Array32(&'a [u32]),
>> +    Array64(&'a [u64]),
>> +}
>> +
>> +/// Implements `TryFrom` from the given `DecoderValue` variant to the g=
iven type.
>> +///
>> +/// `TryFrom` is used by the `Schema` implementations in this file to c=
onvert from the
>> +/// `DecoderValue`s into the types to store. Provide the implementation=
s for basic types here.
>> +macro_rules! impl_try_from_decoder_value {
>> +    ($ty:ty, $variant:ident) =3D> {
>> +        impl<'a> TryFrom<DecoderValue<'a>> for $ty {
>> +            type Error =3D Error;
>> +
>> +            fn try_from(value: DecoderValue<'a>) -> Result<Self> {
>> +                if let DecoderValue::$variant(v) =3D value {
>> +                    Ok(v)
>> +                } else {
>> +                    Err(EINVAL)
>> +                }
>> +            }
>> +        }
>> +    };
>> +}
>> +
>> +impl_try_from_decoder_value!(u32, Scalar32);
>> +impl_try_from_decoder_value!(u64, Scalar64);
>> +impl_try_from_decoder_value!(&'a [u8], Array8);
>> +impl_try_from_decoder_value!(&'a [u32], Array32);
>> +impl_try_from_decoder_value!(&'a [u64], Array64);
>> +
>> +/// A visitor that consumes decoded NVKV and produces a `Target`.
>> +pub(crate) trait Schema {
>> +    type Target;
>> +
>> +    /// Visits one decoded pair. Returns `Ok(true)` if the schema consu=
med it.
>> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderVal=
ue<'a>) -> Result<bool>;
>> +
>> +    /// Returns an initializer that makes the decoded `Target`.
>> +    ///
>> +    /// After the returned initializer runs, the schema should be empty=
 again.
>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
>
> Would it make sense to make `finish` consume `self`? Because "the schema
> should be empty again" sounds like an implicit contract not everybody
> will think about enforcing, which could be a source of subtle bugs.

Yeah, it would make sense, and that's what v1 of this series did. But, I
noticed that it forced materialisation of the Schema on the stack (and
the Schema can be large), even if you allocate the Schema using a Box.

There's two places where it materialises - in Decoder::decode and also
in Accumulated.

anyway, that's why I changed it to the valid-but-empty like convention.
Please LMK if you think there's a better trade off solution to avoiding
materialising this on the stack.
