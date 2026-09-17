Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2751AC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E4C10EC7F;
	Thu, 17 Sep 2026 08:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tqJi6YsZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CE210EC83;
 Thu, 17 Sep 2026 08:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VylMv6TSnQhQEDnatZ5yEzERXJOyCejHLZSGnIuPRu/Zdup9mNkeFFfYpdeIhCkx25hVsqBQwiDJEsLeUtYoju6RuN48NY1Oz+PuD8SqEGlvN6Ad0df7wGqs7QjGZ8IOcgVlEoUQZLV8v1LBCOksaRSMNnj5FBP1lV6E42fwlSuAuIAwrdbKs027360H+1nxCkufQY/Iyx3Ipy6RWjiUA+oEq84gxOP3p7+pv38uDz467QJsuo60g+Q5e3UTBbdBuQVUBDf4uB5TtYHgpxms1bl5J30PBj5h8We1na/zZIMoNXhrTsN7kkwxMJo7gqqf4Gq3AMhrn+m45f+aTgESpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFp/ioXXvnyC4d3kqC5sj36+WDNccnutGdq0EzeKoKE=;
 b=BFm46Sy5PbTnL1WSEkbBEkEprvdUxSnRzdbtEs2mkLOvXT5y2AIwOyTKSehfmreh0G7bQfFf7TqicIjXLjsdIqkUpM1n6ELIZuzFDk30JG+97gDRfm7RFDwkjj13qtg8t5pJF10SEAX0oEjvEJW3W72AHwFZxNAl0Rjh15o1kIDqy8ONPH63LXgJkNBhJjtwBn3TD/YPF0puMKKs0zRzF6OXG6xn/TothtFgiYEEzx0pL+je8UzMwkD9uNEGoRyHWRMu9LmHS2REm32kqqQ15cO0DdCo3GSWzsm+jsbkTYCQJRSjDyoo6Ju1AFCUSDyfq03yuNTl+S/tuhCLoVdA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFp/ioXXvnyC4d3kqC5sj36+WDNccnutGdq0EzeKoKE=;
 b=tqJi6YsZr/6T6CeV9PR6aBnE58gf3HFFxip/ZpWochdvNtd+QowKZNlhvsuGK3fYQPPHtQoRRW8WAVYB0SyFA8Nsptqh2KjU0qtJWjtuvZcswvd12Wzc22FDf2erQxTbdJdzme1w5xTdIpuakTTFFiCJC9ssb41Ca/LelqLdtLKcUoGDVj/WbUECmnfwPd8B0j9LC9CIK6j+lWrDGyyNGGiZr6vLU7V8qHM02h0kdQujpm+MnycG9dnCselgM7z65yzKsYfrJ4RCbiyVMRcS0ncujqayMg7cICOktvZwDXnyvfcVOPNGlg0JMmBsOhW5EvvY8Nwo4M408Ymd8YbdvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 08:37:17 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:37:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 09:37:13 +0100
Message-Id: <DLHGE0SNY9CO.1OPWR5QXKJLAZ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
 <DLHFGW1ISL53.3D3X360WD8HPV@garyguo.net>
In-Reply-To: <DLHFGW1ISL53.3D3X360WD8HPV@garyguo.net>
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f775a40-11bc-482d-d303-08df1496dfe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|10063799003|22082099003|18002099003|3023799007|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xG4pdyM+YJVjdjZJ+LpcLb6Z0+rRt+jjU4by0Xoh8a/rW4S4k7KThoPMxIEEFC7i1jHXIQtosHv2Fnhg99NIbBmZcm/HK2MOZwyGgMTNOTgmPuTIu/uSAGFZ3qlV5tjJQSK6VHvbpWrY1K2cuUBB1eb51WF/byo8Y+9nFYz999Af20h1mOjZ/tpt0wFhzr1VjCZNyHFNxSHFmKwLUZubkFaxtyJsECbFd0TsSXpxzbjNmmxlFdYRa8CNstD/771MnRmDqlP/0ZnsPRZWyI5NCGczLhNPE5Zgl+r3trut0gNlRB0eb7Y2yvLwWLtJ0CSyN5NMJR5d5Mzz7tZT54XX3R4EDKKwU+ZZo0UYd8YMy+ThQC3MfikoLMYtqytC84zW7wpwwzbTItOOu3ose1qMFSUwrxRiVCrMGdaNeN4fgw77xWcVfSr5NR8HyU0j1+8szxpX20y/GlXpPjfLPNgsBvlQgItUllWXRgUkFbKXqL0dG73MOIjjJZuLXktl/wFvXqA+IyEBv4xSrbxsk9nXD/lYzjF9nhmyWdM4uAwKXTVCENiP6EUaZYjixJRkD84RmdlAzP1mqa5LZYf3XyQlShryIPolsGcgCb6Z1yJfXC1VhcMGRTeehQ0szaCsXeZ6ZrfVRsMJtlkXZCe46Smj+DYAGu/109RrBkilqTzil2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(10063799003)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5DV203UDBYelNXRkNkZVl0enJlOFdsWU1kNmFjVDBxR1N0VUxpQ3lZZjFz?=
 =?utf-8?B?a2I2ak01Ulo0ZzRVMTVzVm9zbWNNUFhhdzQ1aUlGa0xnNnJFellKQnB4emtF?=
 =?utf-8?B?RXVkT3hnTlpLTUxnOEhnZTlUdjJWbGZObk52R3VHeXFUdng2eXVVZGNHcnM5?=
 =?utf-8?B?eHo3elRzaXh5NlROOTh2MmxGTWRISFp0ZFFVVkRQcy9GTkIzVzZlNXZ6VVRC?=
 =?utf-8?B?RHRBQWxZMjlaZHZ6cmwvSUcyVkFiTGpRRW03cjJWNGtiUGttSUR0R2s4SjN1?=
 =?utf-8?B?VVRhcjN4S2hsU00wZ0RPZ0JkRkkrUTVyVEJBQlZ0cms5dUJXTktMb0R5aTZn?=
 =?utf-8?B?U1BLdU5jaWwvbmx3YnZIamEzeEVXeGYrVnF2REd3OEw4Mk1qSXk4L1hhUmhV?=
 =?utf-8?B?bHdkeHhMVXNPbnZ1RExNMlBBSVZqMHdvWjVhRG5pWHhDbGZBc2M5WXVDRTRG?=
 =?utf-8?B?UDNFbEhzem9UMldHN1JVaHZiTnEyam9FbXFDSTdxSEMwclNIZ3ZOelNFZ1Z6?=
 =?utf-8?B?ejRBNlU3OWRnaEpyNHJpZVA3MFhQTnd1aXAwL2Ric0M3ZWh3WkhCSWw3dHMz?=
 =?utf-8?B?RFNORVpsOWtLaWN0TFlpazlPYk1jOFA0blJOK2JEVEZheHc4QlE0UXdsMXFo?=
 =?utf-8?B?ZncyV0t2ZjBxazdzamxoR0ZFbWUrN05OTlZLV0tyUUNnVEJycXlIYWhoOVF1?=
 =?utf-8?B?aEhRREhiNGlCSVhwYW8rTmpDWVovMSs2K2tVVmhZc3IxSUNia3lkbTV4NC9z?=
 =?utf-8?B?THlpbUthWExVa0t5RFdSVzNKZEZYQjRKK3N4alZpOU1DTGxiVVI5MGE2TFdR?=
 =?utf-8?B?WjhWby9PdWtNTzVsbHdIckVIYmY3RUI2Vjk5Y2wrQysyb3NwYnh0MlBXUlBj?=
 =?utf-8?B?RlVXdkovUkpuUTNYK2syL05vRThiM1RldzBWU3NJV1EzaHhSc01yb0tkM21t?=
 =?utf-8?B?NUhCWVNla1ZOa1VIM01jZDZrSXZIOWlGSVhMZHBUNlJuSFU2QUw5Rzl2T0tk?=
 =?utf-8?B?WmY5Y09IeFpLVGkvSklHWHBRUmVHSGZ5eDI3RWN1YlBJRHFRM3BjN3R4U2t0?=
 =?utf-8?B?MlNvaWJEUW80cU1YdG1HM1NmUDIyWGlLWW9RbzZCTDVOYzA3dXNFODg3VFlv?=
 =?utf-8?B?YzE0czB2NGZENjQ4ZGs0Vkh2eDdpeHZuWHFyNnF2d2JtNnBkZmZ6ajR1WlBC?=
 =?utf-8?B?TUVrbHhQQ0psZWpyYTJLUVVJRndqWE5ZN1JMWjZpKzZaNVVaeU0rT3ROUGdK?=
 =?utf-8?B?RE9LdmRYOWdkSC9DM25WdUtEOG40eGg3QWNGdTIyTVFwNDhoVjRLSmxnUlpU?=
 =?utf-8?B?dHQyYzVrR2QxYk9xWFNYOUlNTnNnaFZvOEtuRkdXYlRjNUJjZWdIQTlnd2lz?=
 =?utf-8?B?cmFSblJlbW95UmpvVEFmcWNRTVpvaUZsQ1BvdnZFTWN3VUNBRjFkazk4SFFl?=
 =?utf-8?B?T3BLRXdFUklkNjk5bDk5cGMzWEN0bHV6SVFtY1lxNGJxL1pBVDdoNlVlblVi?=
 =?utf-8?B?U3JTZTQ5alVkeUtkYXZFbVYvTFBFNnN6QmM4akZJWGgzY09LeEd1Y2xBRndU?=
 =?utf-8?B?ZktZVCtNbHhwQmkzVXlOQ3BiVmxnNUY0OVQ5UFJQak8vM05HbkgyUFlhdm9p?=
 =?utf-8?B?bXowSnV3QTRMOFVDRWUvdjFTd0dTK2tJM2F1ZHUxbWpMdmFsSDFQRXZmNGRh?=
 =?utf-8?B?SFdURUx5c09UZmFCaUZacnR2ZVpMMCtoMEt0Y08ybmRyOXRaZ1JveGhua0tw?=
 =?utf-8?B?SlFuM1ZSYXJBaEdaQmFxVzBSdVBQa0NzWGRuWS9aRWNyZTRaU1FvdWJyQ1dF?=
 =?utf-8?B?azlWVjFzK0R4c2V5ODFFMm1WeHlZelRyL3FNWE51dGw5SmtkdUFkbWg1SHBI?=
 =?utf-8?B?eTFPTG1yNnM1WmFpWC9NL1VBWm9wUWprand4SGlCRU54cXhDcGFPNVRRdVRj?=
 =?utf-8?B?RERUaDJ6bDRsbDJDKzJ6RnVuUXE5aXBTcko3LzdnaHJrMmNqNmlJTExqN2Zq?=
 =?utf-8?B?ZWdKMGVET3cvSzlLdmxXcHpuaEo2aG00MFJjZ3JndzgxWlBwOTBvdGtsakky?=
 =?utf-8?B?blR3NDZTaUs5YVlMN3F4dXR6ZkNBckFpYndBc2VyTEoyYTVrNGpNc3U1RVJM?=
 =?utf-8?B?RHFvUGFaSktiYjBkVFZaUFY0OFNSVXJjUzJEU1d5VFREcGxYSHV0SFJuTk12?=
 =?utf-8?B?Y3F3d29LWkcrMTAreWxVaTJoVlNZVjh0Ym5YTUtVL2FyWE1rTWJpbWRWRnky?=
 =?utf-8?B?SmNNS3lObEgvZkMxdjNLTExEKzR3Sk5IMGdHbjZtRXdxTG9tMERsOVgwL0lW?=
 =?utf-8?B?cTBNMDdtTXh5WjVsT1VwTlU4YUkxYWZNT3ZRQVVZNnJucjI0dGNkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f775a40-11bc-482d-d303-08df1496dfe2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:37:14.8924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaCvKuMoWYVtVE7lbZozLKiwyt7MDSy8FcmtUS/+n1RdhC4X4RIwmB/K/SwiTxyaVc/aA33u8sKISBdnnbXqbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

On Thu Sep 17, 2026 at 8:53 AM BST, Gary Guo wrote:
> On Mon Sep 14, 2026 at 7:55 AM BST, Eliot Courtney wrote:
>> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>>  use crate::gsp::nvkv::{
>>>> +    Array,
>>>>      Index,
>>>> +    Key,
>>>>      KeyId,
>>>>      Op,
>>>>      Opcode, //
>>>>  };
>>>>  use crate::num;
>>>> =20
>>>> +/// Defines a schema struct together with its [`Schema`] implementati=
on that decodes into `$target`.
>>>> +///
>>>> +/// Each member of the struct should implement `Schema`. For every (k=
ey, index, value) triple
>>>> +/// decoded from the NVKV stream, the generated parent `Schema` imple=
mentation will call each member
>>>> +/// in declaration order with that triple. If a member consumes that =
triple, it will stop there.
>>>> +/// Otherwise it will keep going until all members are tried.
>>>> +///
>>>> +/// The schema struct holds the state required by the schema implemen=
tation to do the decode. It's
>>>> +/// recommended to use one of the existing Schema kinds (`Required`, =
`Accumulated`, `Key`, `Array`,
>>>> +/// `Indexed`) for each member.
>>>> +///
>>>> +/// # Examples
>>>> +///
>>>> +/// ```
>>>> +/// nvkv_decode! {
>>>> +///     struct RequestSchema =3D> Request {
>>>> +///         id: Required<u32, 0x0001>,
>>>> +///         name: Array<u8, 64, 0x0002>,
>>>> +///     }
>>>> +/// }
>>>> +/// ```
>>>> +macro_rules! nvkv_decode {
>>>> +    (
>>>> +        $(#[$attr:meta])*
>>>> +        $vis:vis struct $name:ident =3D> $target:ident {
>>>> +            $(
>>>> +                $(#[$field_attr:meta])*
>>>> +                $field_vis:vis $field:ident : $ty:ty
>>>> +            ),* $(,)?
>>>> +        }
>>>> +    ) =3D> {
>>>> +        $(#[$attr])*
>>>> +        $vis struct $name {
>>>> +            $(
>>>> +                $(#[$field_attr])*
>>>> +                $field_vis $field: $ty,
>>>> +            )*
>>>> +        }
>>>> +
>>>> +        impl $crate::gsp::nvkv::Schema for $name {
>>>> +            type Target =3D $target;
>>>> +
>>>> +            fn init() -> impl ::kernel::prelude::Init<Self> {
>>>> +                ::pin_init::init!(Self {
>>>> +                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::=
init(), )*
>>>> +                })
>>>> +            }
>>>> +
>>>> +            fn visit(
>>>> +                &mut self,
>>>> +                key: $crate::gsp::nvkv::KeyId,
>>>> +                index: $crate::gsp::nvkv::Index,
>>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>>> +            ) -> ::kernel::error::Result<bool> {
>>>> +                Ok(false
>>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.=
$field, key, index, value)? )*)
>>>
>>> Mmm looks like this is going to be `O(n)` with `n` being the number of
>>> fields?
>>>
>>> This is ok for a first implementation but eventually I hope we can
>>> switch to a more efficient dispatch.
>>
>> I thought quite a bit about this while writing this code, since we need
>> the escape hatch to imperative decode (custom Schema impl basically). To
>> be able to get it down to a match on the key, we need to know ahead of
>> time which keys a Schema will consume. That duplicates the info from the
>> visit() implementation.
>>
>> I thought up a few methods but it's unclear to me which one is best, so
>> I just left it for now. Please LMK if you think this is urgent, I can
>> try in a follow up to improve this. Here are my ideas (when I say O(1)
>> lookup I mean modulo how the compiler decides to do it with the set of
>> key IDs it gets):
>>
>> 1. current code - just visit()
>> pros: key source of truth not duplicates
>> cons: O(field) visit as you say
>>
>> 2. Associated const KEY_ID: Option<KeyId> - None if a Schema accepts mul=
tiple keys.
>> You can match on each associated const in the macro.
>> pros: O(1) if the current key goes to a field with KEY_ID =3D Some(...)
>> cons: O(#fields accepting multiple keys) if current key is one of them
>>
>> 3. fn accepts() -> bool
>> You can match on `if F::accepts(key)` for each field. We could potential=
ly make
>> this const with Gary's const traits polyfill.
>> pros: O(1) if you write an inline-able+optimizable implementation.
>>
>> 4. Associated const KEYS table; use tricks to concat tables
>> pros: O(1) lookup=20
>> cons: actually MSRV can't get this to optimize down to O(1)=20
>>   if you use slice::contains(), but stable can.
>
> Hmm, am I missing the obvious? Why not generate a `match` expression on I=
Ds of
> fields? It looks like in the example all keys would have a known ID to th=
e
> macro.

Some keys may come from embedded structs, which the macro has no way to
see.
