Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D157CC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 04:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0607710E452;
	Fri, 28 Aug 2026 04:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnU6Rtpd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5795B10E452;
 Fri, 28 Aug 2026 04:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dw/u4Jy6Vx9aodhxjCqE0z4GiqD5Gfz/cc1MuS0kFPAcFEnB80vvcKuK00v5Lxl2rmYOr4Y2YFOCg6QRnjMd1sTerwXIWu7miUzHQrpTh7DKARHYBMtMTuT5O3LCSrjPLydNMXpyK0iEFiujmqHzxh8TQ9R2NJ1QxsGq5dNASRX2Ds+4aRr5gxpcHQkdoj97zsxq5UJiv8vUgQo726gfB168vahmaVJ87TlzX4ROlvt71XQp63VT7qdKulzOYFKT8hSRw/7dmalIMNR/zbFf2Q00noEG/0czzbVAB5kThQyN8SRqiNwFiUPtzPnHeYoFQr3FZmikTT+nAlAIUZZcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adq4CUEcOrwKCZjiwKeTAPo/0r1KP76FFsztU2uk3mA=;
 b=GKWONnZ+efKR83EG2rudXAltph5JfXKSHZ+tfWE/gxUWziKQ8RNvZPAmnEQZT4J3Fq7A69zFv0CkVRQ8tShJfcKvX+B0fgGiefdVWRfPmsRHGQvWBkuH82HKOQJmQfulh3JmNtm/RlmZvqHIEvxGZUqiUQ0OVHoV0AhZNND7juHVmOZN+4juUaGxlPIscurAr33Sn7mEXesfXg5yl9TXOiJ/TKM1ex+hnYu7lSqiZST28i2s8TjwxLR3McmqitVIX+2zDtc5BMkl15I3qR1dSftxa6M0+B0vQcqcFG4W+vFCQKsPWNl328Cx+oKfMeTQbXzbpu4YGaJMNJmCq2mpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adq4CUEcOrwKCZjiwKeTAPo/0r1KP76FFsztU2uk3mA=;
 b=UnU6Rtpdl5iI0KoRNaZeA+aZB8bjHA2hRdEQfDq5EKS4Db4ccCG5JXR6qtWmq5YXzDKP6NF7Jz7Psqeq96vpQaI/Sz4aiBpago37gGdEJgE+FCOvtjFBpfTdesvoXF+gWkneD2JE0/ju7KD1sVjuIbdphauFRqBTzcgpm0UtHMIi9jVp1vv8wIl6CKtj7sn/e2r5NzMUgKw04276wOc9WaRgcT4PuVj/Oy7w5VASvXGzMWCkzr8Hjln8iNGMafORfKA6wLWBsiKzvJxBCHN/ahYjVsBwfC3QHuHpIZNiNksNpa39idNny9QKAdqWtc4pHWGh+hS3STVcn2dlaqOt9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:54:03 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 04:54:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 13:53:59 +0900
Message-Id: <DL0B47OUUMD5.3A6OG1Y5Z2MZY@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Gary Guo" <gary@garyguo.net>,
 "Burak Emir" <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
 <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
 <DKZSWB7OFDRY.1QKAIFC1QP9RA@garyguo.net>
 <CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com>
 <DL051FB1HOBY.2UC911T3M9AIS@nvidia.com>
 <DL09JQ5CRJLA.4Q6OTGU4CMWN@nvidia.com>
In-Reply-To: <DL09JQ5CRJLA.4Q6OTGU4CMWN@nvidia.com>
X-ClientProxiedBy: TY4P301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1368b270-7799-4b2e-6ac4-08df04c0617d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|23010399003|7416014|366016|6133799003|3023799007|56012099006|10067099003|4143699003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cQ+TiOPmZbTvxb/5WIgO2B+r+GAuVMfAGwIodFEN4B9rrfSWZE5l1HOHZP7xewi1ZkAk7UVe9OrAc8qvm7Fqgo43p1YCjzRuD9hUp68YEslIJ9WdKBcqe05nsG0sGgrKcHGVUgWu29AAnScsD5uXoMrcDxNXOSwLtIb26DS+FZXTdIUO86AIlToucVrkq7/VuHsGj/73PYB8xRTeJW8Z9NE5/EFKAKUmyS0mhIVrY/TuL+4dxT+Cfu05y7BS8Ii0BknQj7IiXW45qWEf8rKbs+t+6by6xloj+k7QRIF+LjwNjYVDQMXt2MZ5MtrMJWP8TT2HWPgePu8sldpVX0HlmyOEB/ZFBhAzHcpz1pJrYLCh5xbOF/uScAI5ktYL8BgvIBk4aibShGA/sKeiKTuTJmsTy1oAelPMMZZBSyWVqDsckYAjngJqB4DaIsQcPT9mSoIrjVYIaSN/z1ElEpRaRp8Yo4rltPD8SL4oE5kN9iB2hsbMR0VfKTCuongannpmAXhZbhJNlkCbwyg0qcO3h1NqqoZQ4q+8nEHtk86AHZQvFEySTTw42CV/T+rA5F33NlGyDN7Ck6oLMdou/QWoC4WZvhcv78wmtTdm1VOyGfNW5R+f70tFRoH78fY9cP+KSeu8wuXtD3T39oPcobSsnUQ6qPKob1DgRBzDCYTdU5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(7416014)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5uQ0lrOCtEUWRwNVBKQ2IyclZhMlM0K0FJczJ0dnNCVG1sR0RIYkg0cndG?=
 =?utf-8?B?SmNVWXNKZ1UwVThuQjNVMVZUdWt5VkxpalNxeFFBZUtjMEhHSk9BUkU2QVZw?=
 =?utf-8?B?a0dpNnVGMzVjWmltY2h0S0JWSnlPMDhnN1dWNUtVNGNHWGN1VFFxNUdLSGk5?=
 =?utf-8?B?WExvV3hWYXhQTjRzRFR3VFpFR2ozYlRaZTlGYmhnTmE2SmRiUUkyb21YVFVO?=
 =?utf-8?B?OHhFcStrOUZNNzBpa3NQRjI2S1czNEhVQVJzRHgreFR6Ynp5eDQ0bldLcTdZ?=
 =?utf-8?B?ZjlDaERnZmlFZVRkOVBCRDRHOXM5N1QxeWlaR0pKeWM5VkNhUGxRNzYvNmpT?=
 =?utf-8?B?bEN6WnJPdXZ0S2dxa2NrNFZFTit6Z2ZVWG00R05IMENkQTZndWErbXJhSFcw?=
 =?utf-8?B?UjNiLy9XMVhSSGIxR3dzNDNEbHRNQjhuQ2xWSkdTN29tTHIzTUtNQlViU3hl?=
 =?utf-8?B?S1Z6bDlpcW94RjVVNVNVWFR2MmVDMlUrUENxZDV3SVMvUEZHTlpHbW90RmtV?=
 =?utf-8?B?NndSYWE3bTlDWVp3Y3NadElMMU9yVkd0Q0NETDNOWTYyTTRCbGlLYzU0bnlJ?=
 =?utf-8?B?a0F6ZVljVkx1TEdhSGpUYXdPWUJjM2FYbmdEeXhMM0JpNjR5Y3ZyNklXakZr?=
 =?utf-8?B?cU1qM2JWdmxENmI0TGs3ZFl0ZTRaNlNaYW9JNXlodmttd2lUWW5tRE5xM1Vq?=
 =?utf-8?B?NUUyZjZOdlk4eVpiSTY2VXdvQlJrNEtsUHdWdy85WnZNUE1sN3FvTnpYbm5w?=
 =?utf-8?B?L1lOVHhwbUVWNWFCVnBrWG9JN1NtOG5PNUJGNHdHeVBXOXhkRlZCck1kTmRQ?=
 =?utf-8?B?eGVwbHU4aXRZZGZOUW80d3VYOWQwbUdudnU0UCtIQjJCQWJqcEVMeTc1a3pF?=
 =?utf-8?B?S29uKzlTVE1vc2cwZkVmMTg4cWV4Z3l4Zlg1MEJVSGJaRWVlOGpyeWt2TmFV?=
 =?utf-8?B?Q0JkVW1wNjk0R2VQRG1vcnFuYlgvVmlaYktubUVOc2tiYWwwU1BEdVpsckFw?=
 =?utf-8?B?bnNHdUxYOU1GMlR0c3ozc2h3UHhoSGJCemx6RThvTy9jbkozUXB5aGNLY014?=
 =?utf-8?B?d1cvVmpXay9SeVQxWjc3Z3g3d1dxUTA0N0VCV3M3SlFGSjVkV29mQmdRZEwv?=
 =?utf-8?B?NE9vVGU2Ym9iUmd4dG56V2NTSVhWbFFLK290V3RGMUlzdUp1VXdDWWlscEtT?=
 =?utf-8?B?VkVaRW0zclBDNEo5d25iOG1Cai8yeUdic1Y3NGVobFZvUUV6SUhySzVlMnlk?=
 =?utf-8?B?NFJKMkxVd2l4Yk40NVJMN2hiR3JIOGoycE5YNVNHblJaajhmVE12WkRnQUZy?=
 =?utf-8?B?RFVXZHhoVitsOWVSQWtodnF4WFRVV1UxbmNndzBQSEFhb2JEZkk1b1RvaVlz?=
 =?utf-8?B?MWVDRldCQUJnS28yU01sWjBtbTIxUzkvUFpWOTlKSkN5L1BhSS85SG1vcEtM?=
 =?utf-8?B?UzBXRjNwNnlDb0NwTkdndjQzK0RwZW5JcEtIR3NrbjNSR0kzZ1NWanJGU3dn?=
 =?utf-8?B?Umh1U3ZnOW9KRlUrdkxsdSs0enRkd3hmMHZmOG9LWUtSRDVOTFQwTzA3dmhU?=
 =?utf-8?B?SndMVE5YeSswSzJwSzg0NlpOVWc0SmJEcUdpaDNhVzl4YmpWeFF0UmpzSEM3?=
 =?utf-8?B?RUNLbm9Od3lvVjBxc1I0eXAvYmdDTUxyS3Y5eUhBS3VCWUltbzc4SnhyVFVQ?=
 =?utf-8?B?TnQyc0pieTRJKytUTnhUOVJaVGZxWk8xbldNMk1CNUFJb3A0T1lQSkNsb0ow?=
 =?utf-8?B?bkVKcWRtQjBWTXJtSGFQelFjLzFMQ0NEeHB5MWExT3JRaXI5dXUxR3NHeHZn?=
 =?utf-8?B?UGMxMGRlamJUNGZTZXJqVTZVdjFLWG15MFlTeWY1RmJWUUhOOUdENlNGSVJR?=
 =?utf-8?B?cmNoYkVVbWdBSFdGL3pBRUZuUWREWXN5TUhnNGdHUnAxSzFYKzAxTmhQSlFz?=
 =?utf-8?B?T3NUZHdObW9BRytCUHN4MTAxTjU4aGwweWIzbFRvaUdySnVrakxYNk9za2VV?=
 =?utf-8?B?T1hITUo5VlNadjBXZTRPdDcxNVVRdDBaU3FPbG1QaFRZU08xSzFWNG43dEJU?=
 =?utf-8?B?THhmMFhHUkp3RHU0ZXY5eVl1NDM4WGNycWVpYU93c2h2cER3Wm5pTWdNTzFr?=
 =?utf-8?B?b2QrWjhEdW96ZXVNdlpQaWJOREJkU21hOG1EckhEN2pjRVhhVE9PWDluMnN5?=
 =?utf-8?B?bVh0cTE3bkh2bkJseExxUFZlbkZ6OFFKVk1FVXMwTFZjbE1QV29BTmpSelFJ?=
 =?utf-8?B?Y3U1N2M3bEZvVXk3MkR1VW93c21TMmJjQ3BsTFExSGFZWUZqeFZZRlQyVExw?=
 =?utf-8?B?Q005N0dkZjNHT0M0U0M5cW5DYnFqbzNGdjdxc2Zid0FWRFl2TFlFQ29SMWxM?=
 =?utf-8?Q?dTQE6ei40BazSHyf5qvgZZHZSTHEFfvQQ2SjDPKOKyPkJ?=
X-MS-Exchange-AntiSpam-MessageData-1: w/yvjqWZQsr+Aw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1368b270-7799-4b2e-6ac4-08df04c0617d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:54:02.7179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXsF743UEy8+tPVV7YGThMasS1zLcXCeR8I7wcOrMdKaBOx+dPPmCdGMpNyXRD66NRtZ/QHnoAmNPHInNMF7GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

On Fri Aug 28, 2026 at 12:40 PM JST, Alexandre Courbot wrote:
[...]
>> Using an associated const by itself appears to work - I tried this which
>> is very similar to Alice's suggested approach above:
>>
>> ```
>> macro_rules! const_assert {
>>     ($condition:expr $(,$arg:literal)?) =3D> {
>>         const { ::core::assert!($condition $(,$arg)?) };
>>     };
>> }
>
> Any reason this cannot use the `const_assert` already in the kernel
> crate?

No reason. I prototyped this in a single file so I had some misc shims.
This is just me copy pasting badly.

>
>>
>> trait FromConst<const V: i128>: Sized {
>>     const VALUE: Self;
>> }
>>
>> macro_rules! cv {
>>     (@widen $v:expr) =3D> {{
>>         #[allow(unused_comparisons, unused_assignments)]
>>         {
>>             let v =3D $v;
>>             let r =3D v as i128;
>>             let mut back =3D v;
>>             back =3D r as _;
>>
>>             ::core::assert!(
>>                 back =3D=3D v && (v < 0) =3D=3D (r < 0),
>>                 "value cannot be losslessly widened to `i128`"
>>             );
>>
>>             r
>>         }
>>     }};
>>     ($v:expr =3D> $t:ty) =3D> {
>>         <$t as FromConst<{ cv!(@widen $v) }>>::VALUE
>
> nit for the actual posting: make sure to fully qualify `cv` when calling
> it recursively (and make sure all symbols are fully qualified).
>
>>     };
>>     ($v:expr) =3D> {
>>         <_ as FromConst<{ cv!(@widen $v) }>>::VALUE
>>     };
>> }
>>
>> macro_rules! impl_from_const_int {
>>     ($($t:ty)*) =3D> {$(
>>         impl<const V: i128> FromConst<V> for $t {
>>             const VALUE: Self =3D {
>>                 const_assert!(
>>                     V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128=
,
>>                     "Constant cannot be represented by the target type."
>>                 );
>>                 V as $t
>>             };
>>         }
>>
>>         impl<const V: i128> FromConst<V> for NonZero<$t> {
>>             const VALUE: Self =3D {
>>                 const_assert!(
>>                     V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128=
,
>>                     "Constant cannot be represented by the underlying ty=
pe."
>>                 );
>
> Let's also have a `const_assert!(V !=3D 0, ...)` to provide a better
> error message than "unwrap on None" if users call this with 0.

Sounds good~

>
>>                 NonZero::new(V as $t).unwrap()
>>             };
>>         }
>>     )*};
>> }
>> impl_from_const_int!(u8 u16 u32 u64 usize i8 i16 i32 i64 isize);
>>
>> impl<const V: i128> FromConst<V> for Alignment {
>>     const VALUE: Self =3D {
>>         const_assert!(V > 0 && V <=3D usize::MAX as i128);
>>         // The unwrap fails the build if `V` is not a power of two.
>>         Alignment::new_checked(V as usize).unwrap()
>>     };
>> }
>>
>> const A: u8 =3D cv!(200u32);
>> const B: NonZero<u8> =3D cv!(5);
>> const C: Alignment =3D cv!(4096);
>> const D: u8 =3D cv!(200u32 =3D> u8);
>> ```
>
> That looks like it could work! IIUC it even supports something like
> `cv!(x =3D> NonZero<u8>)`. The only limitation is see is that this cannot
> take expressions using generic parameters, but we can probably work
> around that.

Yeah agreed. One workaround is just to list each primitive type in the
macro, although it doesn't work if you define a type alias or something.
I think that's reasonable and not too complex. FWIW I found one
potential user that would want to be able to reference generics in cv!.
In drm::Device:
`num_ioctls: T::IOCTLS.len() as i32,`
wants to be `cv!(T::IOCTLS.len() =3D> i32),` which needs this.

>
> I guess you'll want to split this out into its own series so it doesn't
> remain hidden within the ranges/bitmap work. Basically as a replacement
> for the `const_as` I was driving [1]. I'll recycle the `const_as` series
> to just switch to the kernel converters, and will follow-up with using
> `cv!` once it lands.
>
> Since this is going to be a multi-cycle effort we should probably keep
> the legacy `*_into_*` functions around for now and remove them in
> another patch once all users are converted.
>
> [1] https://lore.kernel.org/20260825-const_as-v1-0-1ce712225fe2@nvidia.co=
m

Yes I'll split it out. Thanks!

