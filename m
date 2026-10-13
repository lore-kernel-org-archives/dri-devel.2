Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEAECC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 945A210E052;
	Tue, 13 Oct 2026 05:52:57 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C35010E075;
 Tue, 13 Oct 2026 05:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6mz4UYqsp1G7MdKZaIlCoR8VM6Ep9rx7Qyc4chkbYzZiJyLS82+tDT8mXf7eksWYnCeU5oAhZrpIOFqotNCinTYyZ+MM4EM/+MCWSaYqk8P37ivDch5zRxKyDgMU3BCbTuvDoZ84m/Q5EaVVgIXmHbPrNmfUVJS2Yo81c+7dvM+ZEq5CXbdk4neZZYQVHZE0eL/KTwDckti6Zz1eVmBa24lUidxbsFGAXOLFwekyH0tOkZgoYOB80ynZ1INvKlDcdOAI8NkeoNYaYlekRO2bprRsA24mjvEEiLZP3jpnl/WhoyrKARz7woWcOqVDuETSxjx3eDpGmGxZRXUSMZPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk6UKyO5nd82vb+0t4tvPFlUFTSkTMlENRh+1W1W3sg=;
 b=BH3ncR4KzzysNwBw8ZlESYcZEhalTixeh+7J+FD+szPYM7Tdkujizy7n2aSHfUJFxHiawSse77YgZSqPHNnp//52OM4H3M780tTlV0Z2ZvmwDgQxLcJYsIPzes2ZuVb7Q64C8/KZpkToOAl56eozyClyxAzQ5PZ0rG0khbjclTZkN0htJTlwpJelgAUNj3FoJaEVBClvlk26dBVnKd++o/qQoAD3zerVDL5nXS77yR/ab0lR6e2I0Nfhh0VhxWQVAo+jZY8qquhienfqPHbANV0p3gNtnxr5IcWdZaWQUrS3GLNZM94JGeL+tYClLPSlZVolZ7v1MiypTxa+NSjO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk6UKyO5nd82vb+0t4tvPFlUFTSkTMlENRh+1W1W3sg=;
 b=B6FDViOHjdFqUPrcJKwbjh+74/+k4Q+ipheYokauS5T6Oo3475V3vkrPOdrb285qxK61U3b+x3+fgPATYn2MYaoQRoayjoSQgRRZyw4dqgHnROQXt5/B2aDhewz7Sq/FmB3IL8Sa8KNIHAZB/jQjeC07V6nJDst6/e2Vg5L0hm0D3suOr9GNj0hxYeh6z02gS0o3dJKcEhLFu83yH8Yx4YlJepGwdiEWMFyzm/RbQ2Dpi+au4ucC72g+i0+QOeNhgSzB/DUCIDDWDHwkrEmKGSi//Ew86OhqRTeKDSNVa0O2shwdllbMaarKYuuxg3MDLkYdIK2SyJOP340lbWtGyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 05:52:47 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:52:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 14:52:43 +0900
Message-Id: <DM3H68S4CR5K.3K9MG80U5Y9AA@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/2] rust: num: add cv! macro to create values from
 constant expressions
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
 <20260917-cv-v4-1-547ef5727451@nvidia.com>
 <CANiq72m0PLhT=-ODzQtX7k3jn6=XXpESDUbnHcAmR-1gFqR7uQ@mail.gmail.com>
In-Reply-To: <CANiq72m0PLhT=-ODzQtX7k3jn6=XXpESDUbnHcAmR-1gFqR7uQ@mail.gmail.com>
X-ClientProxiedBy: TYWPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e615e2-0063-43a5-7dbf-08df28ee3509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|6133799003|10063799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JZeplT5RTa+AVPRAVcZ4kNZr/QY1NDaaIq3AprntFNjAZ9zdEuntk2kL8MOu2+D3Pp+4K+nwzaFJ8DCWOPudHX3UAVPdFNPOEXoT0QYNk1oiyS6wl2okf/PEZtWRye8i7lJErOEo7Eb6p7FJgZR7B4W2CBlKf5nQr3C3ApG6be1emDt/4h1abPyvnX41sjQwVQT0BrREAY3+BZFkd8ERrMzLCr4KbFeTJC9B3witkMYIaiOxzkAfgUYuXqzn+enEiCXpSOIX9vkDEuyIM7UFKiMJUdZFnCTkOLYDd/UMpBrRuieSmi1TxdbS7fKJBEuz8ECtkuZ3Hb6GsE3YSN7EIyHrs1qsq09ZUxho2uiuGlhZaY8mWITzMheyDw2u7bgws92I5gafBabcH6jou0ui9JpvM66ym9ZCg7z/voJLbt3xeIyMYTvqWM/zz6N7uJufo6cTtZeBH9jc369rEKbf6bFkoRgc5eFrIWTA+oMwmg03dmG2fjCxo8SfftdxnJIiwuH6H7OkxeDI29RrOtnQap1Hsd2AJfdIRgw9dhEZ1o304olGVgAEs2bwZLhiB9I3JKM6v203rPBUZNkWBx6nDrSfESUfZBy2RsWZBKPBtpiNsHfREDZdhuxx5+sQBQ8Jc13yzlvXHUbBuvmVX+kCxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(6133799003)(10063799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emx1dE9QaVlyZlh2OGpIRTFxTkhqcHdDV2NmT3Rtbjk1YnVXMkIrWmttenpN?=
 =?utf-8?B?MWdmcHllN3ZTS2JVcCtJclBhdjBicXBBNHFKM1NwMVcrUnFtaDJYZk1CdW9G?=
 =?utf-8?B?aGhQaWt4WndueWtyalVLclBJSTdxN2dMNFp0MERpMlhsYWJWL1ZXL1p1Ritx?=
 =?utf-8?B?MW9jRWZ2SDBTaWlWc3Ura3Z6dDU4azFZUXhDRFBoOXhPM3JLWWFOcmhwdTZ5?=
 =?utf-8?B?enZ5dS9ORnE0YTYwT0ZPRkwvWGk0YTJxTkdlb0t2dUwwYVJZejFXYm0zMlc4?=
 =?utf-8?B?SDhzOXorcnZqOG45dDNRRlB0UTJoMFhyWWFVN3VBZTkxOU9TSXozemdBS0dp?=
 =?utf-8?B?YmlUMEdXRVpMUG84dFFTTVkwQzl0RnA1MGFiMEhqQXI3ZitMV0lMTmVYcUlm?=
 =?utf-8?B?Q291bWRoV1BNWE5ha0M4YWIzK2taL2I2NCtjdTlYUnI0c0p0ekZzVDZOSkRE?=
 =?utf-8?B?VVVDbm0zb2Mxc0pwSnN0R29objJtb2ZOTXRwZW9OcUhoR09RRXd3b3pNYU04?=
 =?utf-8?B?bGR2c3ZLYXI3VFlLaUNzMDBLeGxnZkQrbDBSalRuN2ZTVE9BU3QvMlBCNllp?=
 =?utf-8?B?eEl3ZXBxVnIwd0ljTUhPY2tpTTIvWGpJaDlLRWhObU0ybHFJMVlIdUhiTWc3?=
 =?utf-8?B?cnVqQkQzTStuUVBsSDdzRjMrV0thR1Awd2JST2FpSWlUTzJXd2NidHNHSzZp?=
 =?utf-8?B?Vys5SjlTcUtEWW9KVmJnREdCVnVrdlJ2ZnFJM1Q0NTAvUzhybGY4aUdmbk1B?=
 =?utf-8?B?SnFBaUtZMzZOS0tGLzFLb3NZRHVmODQyRHBOMkpRVm4rcHJ3UHRYTG1Ralhw?=
 =?utf-8?B?UUsxN3M4clJydkJMS2tUbVBjRDdJcFpKS1VuZ2xQc20xTGg2YzE4cm9kcHJB?=
 =?utf-8?B?bXRVYXliRzlxcjBzOGhtSk9NenFhRWlUNXdjeXdEZVRRaUhPL3ErL0pkWnV4?=
 =?utf-8?B?V3IvVlVTNEFYMndoMkF2Y1JXVDJUWHFhY1NaVDJpNG5HWmdCVHUzN1hwL2Zy?=
 =?utf-8?B?MWJ3aUFJRUlDUjVMVlpVTmpWbEsybkxQeXBpMm84ZzFEU3prWHNSdU9xRXEy?=
 =?utf-8?B?aWxhSjBCZ1ZqSW44QmhCZ1p1UW00OTZqb09tZ3Zud21yOE5YSHVUZVJXVjhp?=
 =?utf-8?B?MUlXOFNtMDI3VDdSTUljeWJ4MGNEMG1TV3YzcUtmSTN0Z1RWU0lHWE8wVjRS?=
 =?utf-8?B?WlFncE10RXdZa3N3S1ZOVTNYa0QzZCtUVDVnL3EydFFGYk9TQ0cyVEJqYzlC?=
 =?utf-8?B?RDVuVGltTGRabmdzVlFaaHl6V1NJSEJOMjdienQvcFZTdGNsVzNTd2trei9R?=
 =?utf-8?B?Y3NvaGZ1K2RwRWdtSEpYODQzZnVHRjE5a0FhTmtTdnJwODR2aFM4RXR5aExz?=
 =?utf-8?B?SElPaHExbGsvVmxGSG8xbHpCNUZBamp1cTVxWGJTQU1VTGo2RjhNS0VsaWJn?=
 =?utf-8?B?OWJIZGZnK1hJdUNuMnBuaUdPUURnMDVrR2E2cXI4QUVWWUtvNVU5bzhFRWU1?=
 =?utf-8?B?c2FCUmU2RWVza2tGVEJ3MHpKeHpKZTh0SDRYY29UK3ZZblBnSVBsY3crczV4?=
 =?utf-8?B?Z1VJZTBnM1cxbElkTUpjQUxXWkdMTGgyTE1hQUlCeEdYQ29rQ3VSVVlnc0N2?=
 =?utf-8?B?VGU3YTcxYVVQTE9DMlR3Y2U4R09xYVd6ckR3bEdzelRxdzhHYjZHSG9TamQy?=
 =?utf-8?B?VFk0SVV3UzVPdnFiS0pUeGRud09IVVk3ejBkY1pEU2tSTmQzNkhLWVZuaVZB?=
 =?utf-8?B?QitHeGU2ajZxWklIV1NkN29aSzN0V3ZrVXpiS2JHTWNJcjVBYzIyU3FqRE1y?=
 =?utf-8?B?K0JwSkZscWl3Y0ZvVGljYTBsQ3BXVjJkN1FlaTNLU0dvZ3dtQkNQREtzREJF?=
 =?utf-8?B?TTd6YlNURzlmc09QQmlpMEtOTUI1UHQwR0pSSXdHVnVDRkhab3BqSmQrL09p?=
 =?utf-8?B?elVJMHhFZlAweTZVVUduS1dYSW1NZVI2WDN4Y1NPYlcxWXJ2czdPZ3ZuK25Y?=
 =?utf-8?B?STYrSGtXTDNZRndMeFVOVUx3WXM0Z1ZSOUF1UFg4bkRtZU01TThJRm9kM0Z1?=
 =?utf-8?B?eWVFdXlnMEw4dytsUE0yejZHeStPdkRXa0hpeG9WZU5WNjVKNWpCbjFZOWlP?=
 =?utf-8?B?Q1RPdFVmSHFFK1M2TUhmWnZBTXFZclJWR1Z5aVZQZ2QzRWcyT2p4Z2JpL1Bt?=
 =?utf-8?B?ZFF3VkwrZXpkZ0xpb0sybmUyWU5JMEZ0TnN1V05yNG1EdU1XdzE1N1FuT254?=
 =?utf-8?B?NFFRMVdQVTduUkIrZ0I2cnBTRWJ5Y1FlbFVpTXFLdUsvakNTdDF4dmtFeEtW?=
 =?utf-8?B?RnZoTFJOa3hPNGpYa2YxOTZ5ZGdua2Y1Y0xBN2F6WG4wUnVZUEJneHZ4OWhJ?=
 =?utf-8?Q?BtufVQeBc/xXJOQwUIyMHuehHrXjjE1pWkg4vTz4+Lqqb?=
X-MS-Exchange-AntiSpam-MessageData-1: 9+Gg5Tc7JReWSQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e615e2-0063-43a5-7dbf-08df28ee3509
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 05:52:46.8606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10VRfO4GDfLjv6q6rrFfY9HjBj65H36fcKDKbRLRxSPaM/wP0lvIRL+gO2QjjwR1vX52KgzZOY7RyGF8CwWR2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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

On Sat Oct 3, 2026 at 1:59 AM JST, Miguel Ojeda wrote:
> On Thu, Sep 17, 2026 at 10:35=E2=80=AFAM Eliot Courtney <ecourtney@nvidia=
.com> wrote:
>>
>> from constants without a verbose turbofish syntax.
>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>
> Word wrap or newline?
>
>> +/// Creates a value from an integer constant expression, with validity =
checked at build time.
>
> Maybe:
>
>   ... a constant value ("cv") ...
>
> since we explain that in the commit message, but not in the actual
> documentation :)
>
> I would also say "at compile time", and possibly mention it is usable
> in const context (we use "build time" for things like `build_assert!`,
> which can be much later, e.g. link time).
>
>> +    };
>> +    // Using `FromConst<V>::VALUE` means const generic expressions can'=
t be used, since it requires
>
> Newline between these two lines?
>
>> +/// Types that can be created from an integer constant expression valid=
ated at build time.
>
> Ditto (please see above).
>
>> +/// Implement this trait to make a type usable with [`cv!`]. Use the [`=
cv`] macro, not this trait
>
> The second intra-doc link should also have a `!` for consistency.
>
>> +    /// Fails the build if `V` is not a valid value for `Self`.
>
> [`Self`]
>
>> +                // CAST: the macro is only used for types up to 64 bits=
 wide, so `MIN` and `MAX`
>
> "CAST: The"
>
>> +                // CAST: the assert above confirmed that `V` fits in `$=
type`.
>
> Ditto.
>
>> +                // SAFETY: the assert above confirmed that `value` can =
be represented within `N`
>
> Ditto.
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> One thing before that, though: are these assertions expected to fail?
>
>     const X: i64 =3D 1 << 31;
>     const Y: i64 =3D cv!(1 << 31);
>     assert_eq!(X, Y);
>
> Or:
>
>     const X: u64 =3D 2 << 31;
>     const Y: u64 =3D cv!(2 << 31);
>     assert_eq!(X, Y);
>
> Because that is quite surprising, especially since we say "with the
> target type inferred from the context" in the documentation.
>
> I hope that helps & thanks Eliot for working on this!
>
> Cheers,
> Miguel

Miguel, thanks for noticing this! I agree this is surprising and worth a
pitfalls section like Alex suggests. AFAICT this can only affect
expressions which use left shift, so at least it's not all arithmetic.
And we can hit the same thing calling regular functions, e.g.
i64::from(2 << 31), although the macro does make it feel a bit more like
it should work. Let me add a pitfalls section for now.
