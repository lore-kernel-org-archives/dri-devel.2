Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD68AC88E67
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EFE10EB7A;
	Mon, 14 Sep 2026 05:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXSTRtlY";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F44610EB7A;
 Mon, 14 Sep 2026 05:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwprWap44eI/P5/FTleeQXevd1bbxCuBoZ9vsM+HiyHsObEjW4AOEk9/mNwF1d3vzsqDAz4IURV5i78ENQUXqrwOjoxWNhpN8ih8S8Lx2vFayohepR0KB5KPXnWYFhrNWffmps7a5dUE+HijOW6oMYWBIzgV9yrlrs2cl/Pb2XV5hyMTVaJGY7oZDePd10dmohikK600zDvyPCnuTqivYQaJu1t1ZmqqJy6fD5O2aeWKrnZJtWqe1dvIF8U4jGP1q2J6qrHcF25CZbYByRi1/1M4soLX3pnmkY1xbKc2ZEYnWbiyEcF1RdfMbySZEoTKs91lJvn+ILAz+JTpl17cVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS7uuKsTLYbTzy5o3klLJG6gZkauwXNBSOEO/0O8j8A=;
 b=k/Hbnr35+Gc/KD15y0Wrnmo7Sgm5Ji5/J/StVizv3NY/xa39xOIxBoixC1ly3cd1ifUKgegH+362Una9Row2cSpVpYcelUvBVDqAuv4CxHv3yoQzM00niqfRcQn4aEHZMEuiGkKFpSCwgg/gCoW0Od3ebpag1sCI9hOhsdNggq7N100x1Zurw2RrdxucsqaU5GcgfvJC1HipOVUsdmkc5K7eZgn1U+gFzO1lzevILRy+Sh6A9Qg/ZUn/kDYt1GuB+PI1wE3cXIjbWAHTg09/U8T5IeinoTnX2uc0ByJS5x/f5kytWq5cMsnPdR90mwW7Vn8N6//zFYMhIT5sy/Gmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS7uuKsTLYbTzy5o3klLJG6gZkauwXNBSOEO/0O8j8A=;
 b=LXSTRtlYEIfptslIYa0BZxHIEMzR7BMvk9pGqCjbcoMat2AGBhkMQA3gB/JvOLsaswh98pSDEja9qq/a7t5Hc10bMnz4G1ZHidXrvJZg9COL/QI5RTE/9X6et24ydiUxyHEpHVIB+J+57mIvEDSOzU7cJs3cle1ahMCF2vhwWWQe/lRyYv8mADa1jsqxKw+pHbLqeayDyceSZHfpCe3xpnJPTW8yhCL+hVVyfP/ABVG3QwhrI4SOMFJk2A9dD3MKXkuEIfy3KQcTNRXPQC8ULQz1KU4MjSxmam9lPgBAifydoYVImUqu4R4VKCRm0djnpzjDrW5bDSqq/dHn0XECCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Mon, 14 Sep
 2026 05:46:02 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 05:46:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 14:45:59 +0900
Message-Id: <DLESVA59ROTX.1AI0S1XYY01DP@nvidia.com>
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
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
 <DLBGYDIEZY9O.13PCPPFAA7JN9@nvidia.com>
In-Reply-To: <DLBGYDIEZY9O.13PCPPFAA7JN9@nvidia.com>
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 66186b10-8e81-4404-6ec5-08df12237601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|3023799007|10067099003|5023799004|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I35KBD20rkgIYSmuKRfwojq15P0HqfsDBLyoanHb1Caxc8Zrr1Cobmp4xDg9yQmHRm2926c8rgGIxjdfi42HhrkNSgAdGlbrhIamUaamUtNAH42vred9V+l71hx3L5SSvoOSI/95qonsy14FT0hS545cKO8JZv00vffAJofZBtvaSrVPBKY0G/liEBjZVUeEx7ntkjNtMDG9IyV7HqQPshaEWO8NCwx8WHE2fOkNQwFobaJXEKpS2wJMuw9+0iumjIgtlRYF0c+DsCrPKQFsTWzI7PSnuGlF95NPf3H2A9FzLKDGJ1kDH4JYLdIBBWMJyPGINC0JH6gH9kk3x4BCj+FK6f/KvW98eEFdV0qrqVBN8WUTZCryBxIi0ZJTIts8Ygp2MzL15uE9PffZlpFwf4Uohy7ZkukZ+iZYxvnFmNgpVBbTchkueawZi+1cNrtOLcLd6io9Ry/2BOzM8Xq77QcotmGOS8IKC9xCo9L5opT+SaZlMJfj7YjpgOvaOpqkWuxmMzQ6gT1mdNTG7SD9GBn/JGPSIZDY8y+pS2leElkXPgePIincqqAD+uo/HQnML+nHcYO94CPvXeBQfJgr3WtAiBt2iDfSIEJp9b6MT9c092h9n0ak4v3PhKsWSAXkklIAmmG8a58IiNi8hzcLo/JV9QW1Z1TvM9zG/tXoBGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(3023799007)(10067099003)(5023799004)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhmK2IvV0J2YTY5MDJxdHNQZ0V3c1l5WXUvUWUrd0ZldFBEVWEvaXk2Tnp4?=
 =?utf-8?B?bU5ROTQxd3VRQWgyR0EyUFU3VUFnc280UnBDa2ZtU3JlS1lPQVJMaURWbDNY?=
 =?utf-8?B?Z2hSQkFTZkU5cTEzWVdXb2hvdG5VcVJJVXBHSlB0VGxqUFQ2c3ptSFcxajZj?=
 =?utf-8?B?VlRWRVFxNUh1dWtvVHcyNTl4d0lMdW9Mb0RhL1NKYWcwUjM4MWtEYkRsbExD?=
 =?utf-8?B?eG14T2hCZGNBNFlab3Y3U24vY2kyaVpQeVJnZmg3VHNCZUZOL1Z3b3MxNm4y?=
 =?utf-8?B?UjRvOW1UeWVTWlUwWlp1WElZZGRyaFpWZGtvaWdIVEIrcXhXaENRV2lKc2Ni?=
 =?utf-8?B?bE51NHRQNllYRDdWUHBTcGV5MHNmanNGZGhhSFJwd1JPVnRFazI4YTBKVzNB?=
 =?utf-8?B?bnVCNE5yb2t5MGJTNy9Za1VoT0hTT3FaRy9ZMWhlV2NNRVA2d0M2K2k5bkxk?=
 =?utf-8?B?ZUZtMDNzZVJDMmxSMW93Ym1yeURUQ1pZOU84V3F4NTJaaFlYckxaSG91TWwz?=
 =?utf-8?B?b3cvZVZMOWRWcTBvMzAzeVQ1Z3h1S1ZTWEMza1BGZ2k5NXFPc2RZV0EwWHJC?=
 =?utf-8?B?MXk4Mnl6eFYzZ0FxNnh4VWRIajVTdEVMcnAzeFJUWHQzQjJvTkxhUUZpMDdP?=
 =?utf-8?B?S2srTWFVSENaNno5emJnbnRMZ3NMa1dPRnQ2b3JYcFYrYmlGQUJ6dFBLeU1y?=
 =?utf-8?B?ZGJzTW5SNytQQjl4K1VqTDJ5UXgyV0tEeXovVml0cWtDc3l2S3FQbHl3alBK?=
 =?utf-8?B?TVhUL2lrSHVNY0owOVZ1YlorcEM2aGJXRjdDUzJIdXpNeVA2MnpiWm03aGND?=
 =?utf-8?B?RmFHZllDSmdDVDBLakZsOTJPY1RSMklPL2Fvd0VnU0U2ZmhFSHI5L1VOQ251?=
 =?utf-8?B?YXI0TEUvYWZJVEpSanlQM1hVY0FvQjZyTjBHaG9MemJWTkg1bHE2S0tRNTJz?=
 =?utf-8?B?MjhvT0JYUTBjamZVYm8yVmlJQm9DdnJEY3JHQkpYT2NqdWtBY1YzemUrYTEr?=
 =?utf-8?B?RTRqSmdxRGRGa2JxS0VhdjRadmNvS2FPT01Fc1QzVStSWllYRi9jNkVFYi9V?=
 =?utf-8?B?MWdjN3BlWC8wUG9FR085QjcvOWtxUzVzQUM5RGVMRUNreTUwU2dFWFNxOE93?=
 =?utf-8?B?bDNoTWZzSTF2bXhydXlkT3Y3SVhuQk1mNjhyYk95T1lWeUF2ZU1TQzZTNzZV?=
 =?utf-8?B?SEtIOC9IQVhyN05mYlcvcE5BWG5vT2JvbTEzREhJZWp3UGQ2RHZlSkpMNklW?=
 =?utf-8?B?aS9EYWF3V3BPTHVvNlRhRzBKQ1hGV09oNzBWVlFYU0dlTGZ3Tk1DZHdrcFEz?=
 =?utf-8?B?ZlJudGxvQzVnV245dWlBT01wVWxsVG10eHRIMVR0ZmJsUlhhaU13UWJuWkp2?=
 =?utf-8?B?VjgvSFNtNThyN3FzdWRIanFhb2t4WFY5bS9EUHZxQW1WR3ZUanhUR21pNXVB?=
 =?utf-8?B?bEZvYzdaR1IyYi9iY2FTd3BBOFFzdTlLUUp1OERxcVBOVzZjRGNJY1FnMlV4?=
 =?utf-8?B?cVl5amtnckpPZzZRdm9HYm90bG0yS1hzVy9EUHYrQWVHSEc4eWxqUnhZZ2xk?=
 =?utf-8?B?ajIyWi81K0pXSllweVF6QldJcG1SSzU4ckF1ZFZ1cHR0WjBoUjdqU2NSK1J2?=
 =?utf-8?B?T2FFVXVuUW5tNDhvZmpSU0VXb0VGMEQxeVQycUJHNzkwSDF6Zk1JM1kzVjVq?=
 =?utf-8?B?UFJLYlJFWHIyYnZ6NDREMUc0bCtHQUlSdG5BdjFtbk9ZMWpCbzZDc0VsaVdu?=
 =?utf-8?B?NHIyQmxycWpyMUN3UFFKRWh3RFpoTWdWcFFvdU5xT2ZSa3lBV3dFaDU1VDgw?=
 =?utf-8?B?bzlOcjU1ZU13SS9pQVVTY1NFeGM2RGtySXoxNzhLMVNmbmxtc3FQMmRMN2Nx?=
 =?utf-8?B?WkM5OUYxWjh3MllDUFZGNWV3Sm9lbHdFYTJvdDNBeHR0SjRwVDE5MUhyT1px?=
 =?utf-8?B?SmcyL3NZVHFibmRwblA5aTRUd3E0NU56OUhDSUt3Ly96VzMwZFFXQitIdit0?=
 =?utf-8?B?enR6bHEzZ0JaWlRuY2hFcEZLaE1PNFc5SzBuZnhxd0RVaU1QOEVnTURYVGgz?=
 =?utf-8?B?Ulc3OEdxek40a2sydFpZQnNGaFA1ZEc2QUhIejZlbFdJT1R4eHZjbTV5UU1z?=
 =?utf-8?B?YzRFVjZIbXhLOGlkTVFlclRQa2Y0M096d2VKYllodE8vS2o5VSszdE4za3N3?=
 =?utf-8?B?aGFvR3k5bEJmYnJ1b0k3Ui94bjhBdkZ5RURJOU8yNCszdklHN1o0MWZKT0Fr?=
 =?utf-8?B?U0FuTElrblY0UGxyekI5Mmc3ckI5OXNlYzhsYmdtZ05kOTJoWEJhenMvSC9i?=
 =?utf-8?B?a1EyYTVMT3F3ME95cjl3U2ZwV0I0dTMxUkg4WlAyRFB6S2FsVVE2UU5DL080?=
 =?utf-8?Q?4PvYzLj16KYYYds4xPbjuj5KpF0RoiATxf5djInsqkLjh?=
X-MS-Exchange-AntiSpam-MessageData-1: X5QcSaGiptIAGA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66186b10-8e81-4404-6ec5-08df12237601
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 05:46:02.4026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWlp+J2OfRf44lJ6N3JGifQfMw/GqfjsKbHeO6tWM4sr8u1heAYWKAVrveACxE0DS+2UoQjB1fCfENoTaXat2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

On Thu Sep 10, 2026 at 4:47 PM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
> <...>
>> +    /// Decodes every pair into `schema` and returns the result of [`Sc=
hema::finish`].
>> +    pub(crate) fn decode<'s, S: Schema>(
>> +        &self,
>> +        schema: &'s mut S,
>> +    ) -> Result<impl Init<S::Target, Error> + 's> {
>> +        let mut cursor =3D Cursor::new(self.data);
>> +        while !cursor.is_empty() {
>> +            let op: Op =3D cursor.take_u64()?.into();
>> +
>> +            let key =3D op.key().into();
>> +            let index =3D op.index();
>> +            let op_value: u32 =3D op.value().into();
>> +            match op.opcode()? {
>> +                Opcode::Imm32 =3D> {
>> +                    self.visit(schema, key, index, DecoderValue::Scalar=
32(op_value))?;
>> +                }
>> +                Opcode::Seq32 =3D> {
>> +                    let values =3D cursor.take_u32s(num::u32_as_usize(o=
p_value))?;
>> +                    for (i, &value) in values.iter().enumerate() {
>> +                        let key =3D Self::seq_key(key, i)?;
>> +                        self.visit(schema, key, index, DecoderValue::Sc=
alar32(value))?;
>> +                    }
>> +                }
>> +                Opcode::Seq64 =3D> {
>> +                    let values =3D cursor.take_u64s(num::u32_as_usize(o=
p_value))?;
>> +                    for (i, &value) in values.iter().enumerate() {
>> +                        let key =3D Self::seq_key(key, i)?;
>> +                        self.visit(schema, key, index, DecoderValue::Sc=
alar64(value))?;
>> +                    }
>> +                }
>
> Another thing that could be worth clarifying: are `Seq32`/`Seq64` with a
> count of `0` valid? Right now they won't trigger a visit or an error,
> i.e. they will be silently ignored. Whereas arrays of size 0 do trigger
> a visit (which sounds logical). I'm not saying this is a problem, just
> wondering if the behavior is consistent with what NVKV specifies in such
> cases.

Yes, it's valid to have a sequence of length zero according to the C
implementation [1]. The semantics are that a sequence of length 0 is
equivalent to nothing sent.

[1]: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/615.71.09/src/n=
vidia/src/libraries/nvkv/nvkv.c#L62-L119
