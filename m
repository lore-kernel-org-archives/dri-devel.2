Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77D4C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363C810EF2C;
	Thu, 17 Sep 2026 14:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="e1n/nBFE";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020115.outbound.protection.outlook.com [52.101.196.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D6A10EEEB;
 Thu, 17 Sep 2026 14:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWBVxyI7VjKhKX0ViMqe9Cna7u3QkGF2/Nyej8rYpl6AfkjRyQ+JFqGYh5PDBkVUNu61LScgNf3p1w1wANmCGAwJuNKehETEWPsuVk6dXg5irxG6Sr6a6oQNn+fYGkWHirHVWMT1yQUNMLixQC+MknfE0NaTJ49eQpNiog9COJ/RnH0tbLQRlXLPlyY+BD90wMpLsOp30T9xL2G/rvjaXtwJXyLJBfRW6fQV/9S24F4pk/LKI87CT751gBmkeM53Etvb8ybqrjS8IILO9eIp5GvQ7B0ibMSb1ZxuXgcWlTQkPpHA19MNpxwwp+O5HPPIJBnatyF1fJlMIP5p2xas9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GTBUbxIYdrrls3ajb782VF9lFDja0m6URUpIRpwyLw=;
 b=p//sEy40f3AD7/5ZJ+33y9UYMwXfVcxcRxwTBZqPaVrdrG1Dd1AgwwPnBl7mQDHAqH2Q8onRTYdej4d+nAZgypA8Y13tyb4QYXQ5ragqi6xEGWM7Cn6uZQ2fETKdpiqR7NoxvLJ0SphYjH5tXmYw9Sfmwz38cKcWW91RCRpJHFTzefIsxutmjUFVqcrQwaYJE1Z9mkerRM6BstyK3BjaMYp+9bHJiC2dDH5I8fChHc+UCC9KIboFFSumyZ3VakIXGprMEFNm6ARYfLIkfXnEQmH3CawAJDbe4plUgJxHHzIedE6Xul6kJDwacnlXvlnMfT1jaSO1miQNejr4Ht/SfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GTBUbxIYdrrls3ajb782VF9lFDja0m6URUpIRpwyLw=;
 b=e1n/nBFE/klFbQTr1RhwsQMjyjVPkFor0InCA2SSOcelBw720kVqwFE5HQAo6Jcg6UVPULEpVnlnwq9poTtRNm0dATke61ZojBQC1w8PlJd/hstExhm9KojvdD5vFfCt4T6alMna/VS1QlBj8DhwXhXoxOuXriQj25dSoXvXEsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO0P265MB8971.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 14:12:04 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 14:12:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 15:12:00 +0100
Message-Id: <DLHNICVL6Z3P.RRA9TJ2P7XHC@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
X-Mailer: aerc 0.22.0
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
 <DLHFGW1ISL53.3D3X360WD8HPV@garyguo.net>
 <DLHGE0SNY9CO.1OPWR5QXKJLAZ@nvidia.com>
 <DLHGPFAO0A8J.TU9XW1AZ8XAK@garyguo.net>
 <DLHKBLIVFIX8.346WFGAIJBL9D@nvidia.com>
In-Reply-To: <DLHKBLIVFIX8.346WFGAIJBL9D@nvidia.com>
X-ClientProxiedBy: MA3P292CA0028.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::18) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO0P265MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f1fde7-8aca-43eb-6f24-08df14c5a5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|56012099006|4143699003|18002099003|22082099003|10063799003|3023799007;
X-Microsoft-Antispam-Message-Info: H+Z+FMR7r+kDZ60/Gt6H3NbzixRMBxJ9lL5BkbtRLUTHgTOIuecaYAf3MDeFo8OcZ/WTSCMJVG4BZNx4Wwe2OklXU7IULIpfvUs0UppoTgc5cQWSxtXmQSYi1FCPxsKdO/0G8aTB10ycKYU6S9d+ocFZ6iRgouEYSLN3h4ebIs9ImkQywMznKtxNXOjyaMerqrmUhTcNsWLG3ECmmrn/EigahXDf1CYA/E6eolRxF7xhtsl0jAm5KX6o2xgu/t+S5t21O1msxESXE4SbyyX8X/AvF26gY6zSqQ9EEOBsIy9KiC53Y8BS5Cfw21gYviL01oiO6flYaE4yGCRO9hfM5+y+r3/zWZb68PzE54eXir6L0EtjpxeQiloPJ7Wst29SYEBPIyTMYIGxucvUBl0spxCESnqwEP222goFw5V/ZCldcJdoFFsVEgpCkYds86wgkMyrg88snd3+Kzi2ShheCLGwWWLzY96vA0rtIiV9mzOs3/gO23fs4Ku6ZXFRZEy+0Z5yOJWXw4Y6x7nHUeg0X5MCtDEtIeXvQIAvS/ou30/dH+zidI10p7qHE8AIkXZkFyHXRp5FSKXwXhjJWaYRrXc4be9caOGWMI8FCpgh7+rZRqqt6zBzopXLO6eWALS1rxhdfMCpMvto14YAMGkzYjaE4PhHXi8IkmvnbzAH7RM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(10063799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVVTmY1eWpkcDZSZUV1V1dlQmw4R2p2LzZjRHRCakc1aTlPL0lSOGdsS0Mv?=
 =?utf-8?B?aGlPM0twdkxudzdRQm1zZkx0cUNveGgveWhJd200MXpsR292cjhwa00yNHVP?=
 =?utf-8?B?b291YmVBL1ozb2JBaTRlNjVRckQwa0J4WGpWSVRQVzdoZnlWQTFJT2VRRGVo?=
 =?utf-8?B?UGRiMEN4SUNGZWh0aFNIclJmYWNqOHZYclFQUFdMOE9vNWMxNnFzVlV1ejNU?=
 =?utf-8?B?Rm0zRTVwZWc1UC94T0gzSWhjTHp6QithTzNEU2dudWI4TUtjc2lQdDVxejJD?=
 =?utf-8?B?Qll3VVc4dGxWdjV2Z0dhOVdsdFV5V2JMRnI1YjdaVXZORUozamtwRjdLYnVV?=
 =?utf-8?B?bWV3UWo1a2JVdXhJZTR1VWI1ZVFQMjRudlRic0x0V0xrODQvak5OZ1NDZVBR?=
 =?utf-8?B?ZHkwVFFyN1RhTlIySVFkTUNQQVlRNFdqVno0WlhsVFBjSU9XYnA1N0VCN2sv?=
 =?utf-8?B?aVFYaDlBbGxDdHdMU0pCSEo0N24waEM0OEdaMnRuNms5eEk2UitNYXhCcE5z?=
 =?utf-8?B?dXh0dk5jOUp3aE0vZ1pTV0VZb1g4OFBlNTQvVm1wREViSE9MN0xLOEpOODBO?=
 =?utf-8?B?SnkvUXg5cHc1cHZRaGc2WHgxQ3NHbDZ5UmtVckNtdXVIQXhXNlNvYU91Vzc4?=
 =?utf-8?B?T3U0SEY3alRXV241bTdwdUFvalN0cnhtTUt6TDVwQVgwQWE1MjduTFpkUjVJ?=
 =?utf-8?B?OERmQnBHMG5nMDhCaExncWJJUGpseHVSazNSa2VmbnJmSHZEMmRKSmpsYVNC?=
 =?utf-8?B?WUVWZGRFVTZXeFg3eG95NnVNRnhvaExIQUF6eVJKSXVvM2FqS2VVcFUwbU0r?=
 =?utf-8?B?WFBVM1lXVDM0dDN5eTNIUVlpU3pVRnd1VDNVZE50QTYxMzg1REhJcktlMzN5?=
 =?utf-8?B?ZWVVOE9nbEtwemx2c2I4ZXQ2OG1Ma0s3UEdZRk5CM0dGQWtTN0VFcGFDNEtN?=
 =?utf-8?B?RWl6dTFPejFoWm9XVzl3Z2UvRG0vTjBxSXVhc2R6ZjlyaXJaQ0UrK1l1TTlL?=
 =?utf-8?B?UlhUaUhma2lpTUFBSDIxVHpIVHZYcitKMCt6MHRrSUcwSEZYYzJHSENpZTdn?=
 =?utf-8?B?eVJXMTVEekY5VDVsL0s1bDlFRmxwRWljVEV0bzdpUnNSZGg3SmlyYmthSVhO?=
 =?utf-8?B?aXYwN2VEZmVrU0N1Yy9pZmlTV1pyczF0RUZxYWJFRUYyWEtPTDBVYzQrMldn?=
 =?utf-8?B?NTNSeXBhREp5ZW9GTkxLcXcwbkVIVGxKODIwTENvTk5RTStORzFwdzRuemZE?=
 =?utf-8?B?S3FRL2FMTzdidElMRTlXU1NpdjhPRko1MWFsZHJVSUJta0x2Tlk5U1JqYllh?=
 =?utf-8?B?KzNGaVRMWUxpd1J6ZHArWTBpRDA5SWR5S2FpQS9ranpEWGY5WmJBUzBuT0R5?=
 =?utf-8?B?OGxUaTdQcDYyS1ZhTHJ5cW5RRnJ3QjgyY0Z2K3dNRjFQamVFd1p0NTlGa3Zt?=
 =?utf-8?B?WXo5NXVtdzUrdk9iR1JNUGtEVmIxN0ZEa2xkZnVKMllqVXhyNTBnS1E2ZDB3?=
 =?utf-8?B?RVg0YzNDOU5NQ0k2cmxGRytFUnFzWnFKYUFoZU1wNHJMbkhNY200dEFBS1Rm?=
 =?utf-8?B?eGhMcmxsa1hKRGh0YkEwZXN0OHZsdUZlcXhlcnJSckpaaC96ckZ2a3NLRVVS?=
 =?utf-8?B?cCtiOFdENU84eDJYUjJPenJyR1FydUtRTmkxT3RRUFcwaXBhdHhMNVNoYzN6?=
 =?utf-8?B?aGk4d25LZTIva0M4Vkt5WUU5eXNMajh2cU9lY1dpelkyanlOay9GMEZPNlJ1?=
 =?utf-8?B?anlmVnRXRFRIaWU0Si9EY3VVRXhncjQ0bnFXU2Nhd2k4ZDZVNFoyQVMyWGxH?=
 =?utf-8?B?U0NPVVN6R0Z6MjFtRDlPU0F4TWFDSUFMcVVTcEpadGFwWUV2cUYwaWFxYVZT?=
 =?utf-8?B?VXRTalVFSjhqK0diMlB4ZFBqSzIzTldpMWNJNjBRMHFyQm5nZkprTGlJV2No?=
 =?utf-8?B?K1lpQjBLcTJPTm5LWnljV3YrU2RUa3RkODRsbDBJVkFwZkNKS2dYMFVGQUd2?=
 =?utf-8?B?V251eFdnTzRTN3JaUytJNUtpakl0NWxvN2d3WFpLZU5TS29wdXJ4dk0vb1Vj?=
 =?utf-8?B?VnlKcWtjaDh2YkdGQ01KRkRQNG9NM0VxUnRnMnpZUnJ4TE5QVURTb2RxbUEr?=
 =?utf-8?B?M3o4clc5dzZGYUJHR2g1T2V1SFdwc2R6T1ROeFRNa0MrN1lFcndUejJ5cXJz?=
 =?utf-8?B?MXVibWNVSVJ0R0FPMGRDV0VvbkF4ZmJTMHM1Y0Vaak1GbTB1NERyTFl3YkRu?=
 =?utf-8?B?eW42bjVOa2dHZ05xNExIL0t3NFhKZ1dzcnFxSGZJdmdaWVN3TmdPN3Q5L2hU?=
 =?utf-8?Q?puFQMu51DTPWkBUC0/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f1fde7-8aca-43eb-6f24-08df14c5a5fe
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:12:03.7170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4ZpnRiwcm/k3pQrnmb8o8LPR5gI7EkcbFCnGATonKTn2WH0aWoC7qjQ4moUQ5hi5MvSIkvZUNhjX1GP2h0tMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB8971
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

On Thu Sep 17, 2026 at 12:42 PM BST, Eliot Courtney wrote:
> On Thu Sep 17, 2026 at 5:52 PM JST, Gary Guo wrote:
>> On Thu Sep 17, 2026 at 9:37 AM BST, Alexandre Courbot wrote:
>>> On Thu Sep 17, 2026 at 8:53 AM BST, Gary Guo wrote:
>>>> On Mon Sep 14, 2026 at 7:55 AM BST, Eliot Courtney wrote:
>>>>> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>>>>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>>>>>  use crate::gsp::nvkv::{
>>>>>>> +    Array,
>>>>>>>      Index,
>>>>>>> +    Key,
>>>>>>>      KeyId,
>>>>>>>      Op,
>>>>>>>      Opcode, //
>>>>>>>  };
>>>>>>>  use crate::num;
>>>>>>> =20
>>>>>>> +/// Defines a schema struct together with its [`Schema`] implement=
ation that decodes into `$target`.
>>>>>>> +///
>>>>>>> +/// Each member of the struct should implement `Schema`. For every=
 (key, index, value) triple
>>>>>>> +/// decoded from the NVKV stream, the generated parent `Schema` im=
plementation will call each member
>>>>>>> +/// in declaration order with that triple. If a member consumes th=
at triple, it will stop there.
>>>>>>> +/// Otherwise it will keep going until all members are tried.
>>>>>>> +///
>>>>>>> +/// The schema struct holds the state required by the schema imple=
mentation to do the decode. It's
>>>>>>> +/// recommended to use one of the existing Schema kinds (`Required=
`, `Accumulated`, `Key`, `Array`,
>>>>>>> +/// `Indexed`) for each member.
>>>>>>> +///
>>>>>>> +/// # Examples
>>>>>>> +///
>>>>>>> +/// ```
>>>>>>> +/// nvkv_decode! {
>>>>>>> +///     struct RequestSchema =3D> Request {
>>>>>>> +///         id: Required<u32, 0x0001>,
>>>>>>> +///         name: Array<u8, 64, 0x0002>,
>>>>>>> +///     }
>>>>>>> +/// }
>>>>>>> +/// ```
>>>>>>> +macro_rules! nvkv_decode {
>>>>>>> +    (
>>>>>>> +        $(#[$attr:meta])*
>>>>>>> +        $vis:vis struct $name:ident =3D> $target:ident {
>>>>>>> +            $(
>>>>>>> +                $(#[$field_attr:meta])*
>>>>>>> +                $field_vis:vis $field:ident : $ty:ty
>>>>>>> +            ),* $(,)?
>>>>>>> +        }
>>>>>>> +    ) =3D> {
>>>>>>> +        $(#[$attr])*
>>>>>>> +        $vis struct $name {
>>>>>>> +            $(
>>>>>>> +                $(#[$field_attr])*
>>>>>>> +                $field_vis $field: $ty,
>>>>>>> +            )*
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        impl $crate::gsp::nvkv::Schema for $name {
>>>>>>> +            type Target =3D $target;
>>>>>>> +
>>>>>>> +            fn init() -> impl ::kernel::prelude::Init<Self> {
>>>>>>> +                ::pin_init::init!(Self {
>>>>>>> +                    $( $field <- <$ty as $crate::gsp::nvkv::Schema=
>::init(), )*
>>>>>>> +                })
>>>>>>> +            }
>>>>>>> +
>>>>>>> +            fn visit(
>>>>>>> +                &mut self,
>>>>>>> +                key: $crate::gsp::nvkv::KeyId,
>>>>>>> +                index: $crate::gsp::nvkv::Index,
>>>>>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>>>>>> +            ) -> ::kernel::error::Result<bool> {
>>>>>>> +                Ok(false
>>>>>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut se=
lf.$field, key, index, value)? )*)
>>>>>>
>>>>>> Mmm looks like this is going to be `O(n)` with `n` being the number =
of
>>>>>> fields?
>>>>>>
>>>>>> This is ok for a first implementation but eventually I hope we can
>>>>>> switch to a more efficient dispatch.
>>>>>
>>>>> I thought quite a bit about this while writing this code, since we ne=
ed
>>>>> the escape hatch to imperative decode (custom Schema impl basically).=
 To
>>>>> be able to get it down to a match on the key, we need to know ahead o=
f
>>>>> time which keys a Schema will consume. That duplicates the info from =
the
>>>>> visit() implementation.
>>>>>
>>>>> I thought up a few methods but it's unclear to me which one is best, =
so
>>>>> I just left it for now. Please LMK if you think this is urgent, I can
>>>>> try in a follow up to improve this. Here are my ideas (when I say O(1=
)
>>>>> lookup I mean modulo how the compiler decides to do it with the set o=
f
>>>>> key IDs it gets):
>>>>>
>>>>> 1. current code - just visit()
>>>>> pros: key source of truth not duplicates
>>>>> cons: O(field) visit as you say
>>>>>
>>>>> 2. Associated const KEY_ID: Option<KeyId> - None if a Schema accepts =
multiple keys.
>>>>> You can match on each associated const in the macro.
>>>>> pros: O(1) if the current key goes to a field with KEY_ID =3D Some(..=
.)
>>>>> cons: O(#fields accepting multiple keys) if current key is one of the=
m
>>>>>
>>>>> 3. fn accepts() -> bool
>>>>> You can match on `if F::accepts(key)` for each field. We could potent=
ially make
>>>>> this const with Gary's const traits polyfill.
>>>>> pros: O(1) if you write an inline-able+optimizable implementation.
>>>>>
>>>>> 4. Associated const KEYS table; use tricks to concat tables
>>>>> pros: O(1) lookup=20
>>>>> cons: actually MSRV can't get this to optimize down to O(1)=20
>>>>>   if you use slice::contains(), but stable can.
>>>>
>>>> Hmm, am I missing the obvious? Why not generate a `match` expression o=
n IDs of
>>>> fields? It looks like in the example all keys would have a known ID to=
 the
>>>> macro.
>>>
>>> Some keys may come from embedded structs, which the macro has no way to
>>> see.
>>
>> You can match all keys that you can see, and delegate to embedded struct=
s if
>> keys are not known.
>>
>> This is essentially the same pattern that `#[serde(flatten)]` uses, just
>> replacing identifier names with keys.
>>
>> The keys don't need be part of the type system, and it just additional m=
etadata
>> for the macro to generate correct impl.
>>
>> Best,
>> Gary
>
> This sounds approximately equivalent to the option #2 I mentioned
> (w.r.t. delegating if the keys are not known).
>
> I considered a serde-like approach where the metadata is annotated for
> the macro rather than by the type system, but I wanted to keep the macro
> simple and not introduce more macro-DSL than I need to. And also keep it
> kinda easy to write manual Schemas by not keeping the deserialization
> info in macro metadata.

I guess that given that your schema types are completely separate from the
struct definitions, it is okay.

Best,
Gary
