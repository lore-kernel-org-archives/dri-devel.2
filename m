Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LY6Je66P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2158510E93D;
	Tue, 10 Nov 2026 07:31:15 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE8410E93D;
 Tue, 10 Nov 2026 07:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARGakanUcxeW7HMWCFxxu58uLhAxyisDwh2Joq88imQ5MR2UBJ478rEamKYf813jULiCkNS+Y7nPr1nCmY8Bg47pg9eC/hDw0NPYtBzQ1lpvhdQ+vzMbdGX5SV5xnmAJrigACcRT0QqsZpcIB/Jt9YN/fHb4yP+gWIWBAYNaLfduftA5nWn7UvCv/LMz9VrpzHr+qFd1qFcCGGQ+vY100MOL4G7VbXp3WsTKWcNNBmwk8n0pq99hCIvpR0ffhFn7l0taMeW/tYj9RVI8aVTT611w4HBVdBIIh8YVJCs+/jknXJjWewlrZJ+02u9aFhgiEvmdfIiF8WSB1jzeF6thBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZSyd0QwL/KB3cgMXlWoMMKqvCWxbgRt0H+S8C5CUro=;
 b=NMfK3+mv8IqQ64154/D3rC9Je/9kiO1NfE2q849lUkUSmLcR+h7A5Ym3IZJhDs18a6N/ZZmS7Rj9mE3FHOn+mKRyawANEY2a5p8gq814WOptquC7YYnneVFDm8NlJexg4WUtuNK5v8Yamew8+ED3rh71af1A0jlrtHHlfIgzwsMqaNCG2Nry71V5im8UUpM79O7sw/lcAJqT2amg6sw23mWCOnp++pnb+piDExIHeZFRlLGLiNtvGnLedSyzrij6yq/bQFpNVM+sET4zzc3xhAj5BhM8/9Cwp4VWiUHN7Gj4+0J3FVFtv8TFBZX4kEcvq4afTIwg3YuvKdO2tE8+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZSyd0QwL/KB3cgMXlWoMMKqvCWxbgRt0H+S8C5CUro=;
 b=LY6Je66P6lhexJV3xRQOOmVnQsWOY5m1nRt8JLXJK9fAvFuoOAEUzaayGyBykk4swCwabtrc8SEIqBgj8bP6ox7o46aVMBc3oYoTfcZCH7nq6SIRPB0E/giV0XKFXekMqsbYu9rw18tETVmvUMiu8VjEaOv8QzS1BvvoyPwAEStCygRvp1FdaMPr8qPGcShbBkMa/wK0mPjbh/sr/edG0KeRor7C0stjCaGtZJHvoAcv+oS5bdoQrE7dUbC/PCV1X6NVSJgcdMXGxMGwXkEpZzoeBfyxc46uqva3WwMZ7vMrQMdafb4mo66ookzDu05Le6FDbWVG/9AliwU0h9GA8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:30:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 07:30:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 16:29:32 +0900
Message-Id: <DMRCRMCFK31H.3GH97ALPTUEKU@nvidia.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v11 4/5] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
 <DMQOOESYWNCC.2SKYV8O6YSYOA@garyguo.net>
In-Reply-To: <DMQOOESYWNCC.2SKYV8O6YSYOA@garyguo.net>
X-ClientProxiedBy: LO2P265CA0505.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 963bfce1-b439-4356-0ddd-08df3efc6060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|23010399003|366016|6133799003|10067099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261021121427099003|261102123227099003|11063799006|921020|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QrU61OTGL5qS4ubZI/ZryE8xXmyt+Vy19CxoHq+xhLUP/UOzoC7W6YXg/AI26pCER+BAWxp/Df3rxpxAUAfi32S7e74GtOFDN1dVP4F8PmeImCd7962sN1/iM9mU16WW9vkf3E2R/GQ7d1zEJGdy+bj1cxu9+ZAilMK/ubXC9plmNSpuTqa0hD2cGQiKppVwHo+8rQwBUKbF0Swt9Fl/7NxeJO+WkZptd6S+aHpSrEDkdsxlQlOMRKwIv9fawYNVR5ovsXGBVMcbvSN+CrEMARSHExe9s+wte7MHygZy03PalKtaKhfphlmHI/fHUzonFCnHR5+9ui0FMPBggubc1gnqDkgN+Go2+40pUsiU5m/yBCoOH8AQDDaS9XYuZBs0GFx24PN5LtpWABvxE/zHOOhpPpZjEk2z5X2p+53rO+PZJxtAlHWpryKu0X0UxEqh7SbLj5rwb9o2uXEmknNnDuuPlqvD3JZVtal+PyBpTn49vLsICAUuklerlQU+Z0+1idAx/XTz/yAUmOXLUruclz7xPVrDqMbYkiT61QAAAz853j3PyMkx0oy5HShEzQFfuF8Gax72zuJzHjLXSzmTmn1H/AvceRMYKK0Ii6F8AO8AubpPSmeUHK6lnmZWngxOMfT9A3+vQl0hia0kD1ArwfajoJXERis3/ewnTHg/jbnxRBxkrZ9j/qRsWOBWEG93S7JVD+nyfgcZ4in2TgFuZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(921020)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ZMUHZHd2RRQ05BSzY2dFF3SlRsSm0wQXNXUmFUMlFTZzFVUmVFbkJWQytt?=
 =?utf-8?B?SklQa0NFUkJvSk1WMW40anpNQ2VYRy8xTUFXZXgybngwSFdKRUZJS2tzbk5x?=
 =?utf-8?B?QXp3SXNQaFBqK0JHeUJreXhORTVTYmM5dTJaSEZHTFA0czdYZnVPS3V5blc1?=
 =?utf-8?B?dGJPLzFMellTZTlFYUVFR2JmS2pzL0Ftb3RFT3hvR3AxdFRlVEtIOE8vWndw?=
 =?utf-8?B?S2NNSUVzK3lMZkpRQnltNVVoYjZVRlVrUE0zdVFSSTJOL0xack5WVm41SWJo?=
 =?utf-8?B?dzVCUklxWUxHOFc4NHUzZlU4WHFxbjE5dkxnMWt3enJzOWVZSm5QQnVzdFZX?=
 =?utf-8?B?aStLLzYrU1FXMVhua05XdGdXK0pMWWh1UDhCcnZlUHBBQkdjRk9vcExzb3FH?=
 =?utf-8?B?NHhhcXhWVFV5bnE2QkN5Q0szaTNtSk01bTVTUnJ2WHNZc2loU1FMR2d3VGov?=
 =?utf-8?B?WWhkVzBhWkF5THZTRmw2eWNadzBvTXB6QUtWZk1rbDN4elRXZjh6WXZsMFlu?=
 =?utf-8?B?WmlPLzJreDh1WWZva21tTmxZdkxtNUVBR1o5alduUGNGVkRiaVFneG1NMTVa?=
 =?utf-8?B?U3JSdE55TVVRaTdjcDRBL3Q0amlhRlAxTWZ1K0pDUVE2WHlUSEdxc25CcFA5?=
 =?utf-8?B?SXZpeGVOaXM4b0JDS25pWDBQNEFWRWx2bTdmcFZQWHFvTlpSOWV5SitURzVo?=
 =?utf-8?B?R1ZzU0ZDYm1HVzBJQXVQOCt0WVRyaW9ORDFVdVFWY2doS1I4S3VtbFpzbGZa?=
 =?utf-8?B?VS9aNmpZWTBBSEFpRFBHL0JnNTZCUXpOWDJPaUhjTW8xcDhnN3BRbGkydzNj?=
 =?utf-8?B?aktOUTBmbVB0cjRSZzZkN05mOWtxM0crS3B0bHdHenhWQzNWYmJvNE5DbXBX?=
 =?utf-8?B?VGV4MG91eGdWZ3ZtM0gzdnZxcUVZancwdmE4TFlTUWkrTEJKU0FySWtoS2Fz?=
 =?utf-8?B?dCtaVjdNekcyRDVrTU5jWGw5QmZ1M29kVXlleVRDaGlrWmJKWmMvRlg3UmZF?=
 =?utf-8?B?N1ViQkpoM21BTXBBVUswbU1KanpVSWNXVWZZRENlRGtuSHl4QjVHTzd2a3Rj?=
 =?utf-8?B?cUVudnhYb0NKb0d6WC9Od0hVNHJlVnl6S0J0LzJOR0JldHRxb3hmUzF3bXg3?=
 =?utf-8?B?ZGc2dXZWbkI5emdoVWVJUXdZelo3RlVBVzAyS0t1di84MnhFRGJ4anBrT0JO?=
 =?utf-8?B?S3dnZVRsVFUwa01lYy9ITmwvYnhhdnFtZzA5Zkp2Wko1RkF0VC9PbzFZdFpW?=
 =?utf-8?B?Y3UwUDNpaC9CaEVBWnpON2lyODJTU2FDNFBIb0VGNU52NUdOcDRBWkZhNzdK?=
 =?utf-8?B?NWVxbzkycGptS0NuL2I1eDd2WmExQ3Z2VXBlWkNYZzk4L2xvWHh4b1dhY1lW?=
 =?utf-8?B?ZkI0MnVvZ3Z0aGFmS3hlbHozNTdxYUE3dHNUUE04QkZWUE9MV0Z0QUtoY3Bm?=
 =?utf-8?B?Q2hjVjhSTVV4VUFaRHl6TWpNbnZBbTFHY3hpN2N4alN5WUNOWm50Njlwa3Ra?=
 =?utf-8?B?TnJIR0VpdmRMSW9KMm16eS9lT3gyZkdZUXlZRHkvZlhKb0RWdzQ0cTJyWHN6?=
 =?utf-8?B?R0hHdis5Y2FhMldDeUc4dWs3Rkw4Y3NoNEhEMWF5K2VSdUVNekxSMFhiSy9s?=
 =?utf-8?B?djJXUmdZcngvT3hIUHhzdDhYNmNxWDVIQmwyOG5ZZHVENmhXdC9TamtvbW9Q?=
 =?utf-8?B?eXBVVXJpcFdpcHF1QmNZWjAzYXhHaEdpeFZUQU5yd3hvV2J4V2xvendaYTZy?=
 =?utf-8?B?TTM5MXNpWnFQUW1HQVZBUjNNcmhxN0tUQlVNZEFzSktjaFFhbEJOb1M0ekJG?=
 =?utf-8?B?N3VQZ0JPMEEzV1NIZkVHZllFc1JOOTdvQ0RjMXZvWVBPVytJaEttc3RXNGdF?=
 =?utf-8?B?VTdpc0JZVG1ocDZEQzBNdm5FeExtWXBDZHpLSGhmM1ZqbjJtbXE4M1piZlFX?=
 =?utf-8?B?TXN4ZDhkOGQ5US9oa0t6L3ptbm1kVWdaS0FQUkovdVJ4V3BLVm5IRDdVbGNx?=
 =?utf-8?B?NWdaTFpnam1pTVF1TURxbDVSZVMxRjZQeE9xRmFqc0FxaTVlMW9hSDE2S3Ex?=
 =?utf-8?B?UDVkYjNrWkRFZ05BWllrYTFjSEl6cGwvQlF5eUZ2cjBVYlFlaVp6b0lMUTVx?=
 =?utf-8?B?YVgrVlBLdk9qVFZza2Noa2swbWFydDU4QmhzdDVVSFM0K2N0RDhxTjFNMTRl?=
 =?utf-8?B?NWx5bHVVS0dlUlptSVVOUW93ZDFxZG9SYzNBWVlOeldxRjBueXZzVytyYWFj?=
 =?utf-8?B?bFlLVTRydWR1KzBlQjhTQkp1Q2RMaWUzdXJZUGV5YVFzYit2bVJ4UHdTUHNm?=
 =?utf-8?B?NEJDQXJwM1hWcnVtZUNudWM2b0tOaC8waXhaRnJoNnVaWUxNdmlqTENWWW5t?=
 =?utf-8?Q?YN6B71Gtsr60MG300imqmte6si6L/FegO2o61ZXk0D8NF?=
X-MS-Exchange-AntiSpam-MessageData-1: lKlxXJrK/q4p8A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963bfce1-b439-4356-0ddd-08df3efc6060
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:29:38.1346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCffzWIjsnHITpCfJjGFezUFpBwN77LNG0w66EpEjCW+hN8/brbf1aPy8Pzfkxh9HriogRZwcSZBw6roBXmsfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 9:36 PM JST, Gary Guo wrote:
> On Mon Nov 9, 2026 at 8:32 AM GMT, Eliot Courtney wrote:
>> Current code in IdPool::with_capacity rounds the capacity up to
>> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
>> smaller than this and still uses an inline representation. Remove this
>> behaviour.
>>
>> This allows specifying a real capacity of 0, which was not previously
>> possible. This breaks `grow_request` in this case, so change it to grow
>> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
>> `shrink_request`.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Burak Emir <burak.emir@gmail.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
[...]
>>      /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if po=
ssible.
>>      ///
>> +    /// Grows to at least [`MAX_INLINE_LEN`].
>>      /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`]=
.
>>      ///
>> +    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>>      /// [`MAX_LEN`]: BitmapVec::MAX_LEN
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::{
>> +    ///     alloc::AllocError,
>> +    ///     bitmap::BitmapVec,
>> +    ///     id_pool::IdPool, //
>> +    /// };
>> +    ///
>> +    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
>> +    /// let mut pool =3D IdPool::with_capacity(1, GFP_KERNEL)?;
>> +    /// let resizer =3D pool.grow_request().ok_or(AllocError)?.realloc(=
GFP_KERNEL)?;
>> +    /// pool.grow(resizer);
>> +    /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
>> +    ///
>> +    /// // Grow doubles if at least BitmapVec::MAX_INLINE_LEN.
>> +    /// let resizer =3D pool.grow_request().ok_or(AllocError)?.realloc(=
GFP_KERNEL)?;
>> +    /// pool.grow(resizer);
>> +    /// assert_eq!(pool.capacity(), 2 * BitmapVec::MAX_INLINE_LEN);
>> +    /// # Ok::<(), AllocError>(())
>> +    /// ```
>>      #[inline]
>>      pub fn grow_request(&self) -> Option<ReallocRequest> {
>> -        let num_ids =3D self.capacity() * 2;
>> +        let num_ids =3D usize::max(BitmapVec::MAX_INLINE_LEN, self.capa=
city() * 2);
>
> It looks like your want the `IdPool` have a controlled capacity. However,=
 as
> soon as `grow_request` is used, the capacity becomes uncontrolled.
>
> It feels that this actually means that there are two use cases here: unbo=
unded
> IdPool (where capacity just means the _current_ capacity) and bounded IdP=
ool
> (where capacity means the _max_ capacity).
>
> This is more similar to a difference between `len()` and `capacity()`. It=
 feels
> to me that you're merrging `Vec<bool>` and `Box<[bool]>` into a single ty=
pe
> where it shouldn't.

Yerp I agree there are two use cases here and this is adding the
"fixed+controlled capacity" use case. But e.g. for `Vec`, we also have
this "double use case" with `push_within_capacity`. So you can use `Vec`
in both use cases as well.=20

The analogy would be:
Vec::len <=3D> # of actually allocated ids
Vec::capacity <=3D> # of available or allocated ids
Vec::push_within_capacity <=3D> IdPool::find_unused_id / reserve_ids
Vec::reserve <=3D> IdPool::grow / IdPool::grow_request=20
Vec::shrink_to <=3D> IdPool::shrink / IdPool::shrink_request

Vec::push equivalent doesn't exist because neither binder's use case
(needs to separate allocation) nor nova's use case (uses fixed capacity)
requires a combined "reserve and push_within_capacity".

That said with this patch `IdPool::with_capacity` provides a guarantee
of the capacity which `Vec::with_capacity` doesn't (altho I think it
could for non-ZSTs). So I agree that there is a conceptual difference
here w.r.t. "controlled" (guaranteed) capacity. The reason I did it this
way is that I think that providing this extra guarantee is easy to do
(removes code) without unduly complicating IdPool, plus adding
to/allowing reuse of the existing common API functions.

We could consider in a follow-up to introduce a typestate, like Fixed vs
Growable (defaulting to Growable) and grow/shrink is only implemented
for `Growable`. But IMO it's overcomplicated to do this - if you don't
want to grow it, just don't grow it. It's currently very hard to
accidentally grow IdPool (compared to Vec where it would be far easier
to mess it up if you tried to control the capacity). Perhaps if later
many more things are added to IdPool then it'll then be worth to split
it.

WDYT?
