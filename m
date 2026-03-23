Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA034F46122
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C7410E3F4;
	Mon, 23 Mar 2026 14:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhXxUpKX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE9E10E48D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/qWFCy0eCMfOiGE47wiAHM/AnV405GXE2fIc/V758juEj3irHrM67YhVSDqcBSYWvUO5YOuihd1tbo/2HA4MoqogE3HsDh7nGpSNCMMGAutpA98fphKQ53VSxzTRm3q5bvIrg/rk03TIsD00zI47qYAS3OqQRvuiSAe3wTfgvDS9Ooa7SBAABFQsZU6AtIpdg6gFNDvsufzqFgwoWWgttHLDE2qhFhD53StKpwTo1xeziatEbWnqSxvILDzKcwyChuT4GaRSwhfXNcTD8mmgC0OIKqpi/UM5Yc0VDFsg3+OQ/JG4umiJJODMQ/e2carNwEQIsyj49tWPtkMyU2cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8GTp0sQ7rFxuOoL1YYeUouc+B0GSEJOb14UWs9nNQ8=;
 b=RT2xzlweydZ2ng6CCLFHDEm+afPFKU2eHaMHVFHKQc+FUZpoc8Ra5DCbSQwSyfx4R2b2Fa4uXo9krj1sKPlfjkbBSYV8J7RWJBf8xYFp7Lu7qZYv8EB4lxApE6hrcLM18Zn1NMzU8bLHIdoh4JiR/9bTbZdPkzAsDjCgi5Sa+LHRShOsu8fegwjk4WmNDilULc5EiRAyBOBsEV9izzSf4RcM6vyn683UK+8n5u1RoUrcR46ycYJ9AYMTcc4UynQbO/fWmS6FLR68nZutfq7f+Y+8frkIwi5XiPaKG217UoN1cLrXJefxJUGIX79IQqX/py3PoWuxAtLoVYxpGqjJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8GTp0sQ7rFxuOoL1YYeUouc+B0GSEJOb14UWs9nNQ8=;
 b=UhXxUpKXGCV2K49BtQKGSfU8lt1upOwNJBtaw0+PEUV8t36lrlMa+5abxIJR6l0sVtKmVDkdwTOrhAtx9trmgWmGexk6utMpdP17HXigmds2jNvl5CRE8g1FLUDFduM3pT4Q3BM/iSvjmi2TZKYkcXaJNgBRMCa18g4kNFBNUhu57ekP6xLCf0WDY71pWvAuInsk5Vdi3NB9CykYLVNUIeeZjvKWKAW4YHL9WESFQLqeTXv3j0ht6DjH9kHsFyBUg5xyHovugKuGIyCQG8PShGiN1bpQd48wrbMizwQ2yOJ6Pd83BeytGdHPzvx82fC5PRKo87OOHYRKUGgHVS6YSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV5PR12MB9801.namprd12.prod.outlook.com (2603:10b6:408:2fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 14:22:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 14:22:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 23:22:53 +0900
Message-Id: <DHA89PW1Q1KU.TT2SUZS7MEXO@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] gpu: nova-core: falcon: introduce
 `bounded_enum` macro
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
 <20260323-b4-nova-register-v3-7-ae2486ecef1b@nvidia.com>
 <DHA65RY78M31.20BCCF00R67TH@garyguo.net>
In-Reply-To: <DHA65RY78M31.20BCCF00R67TH@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0116.jpnprd01.prod.outlook.com
 (2603:1096:405:379::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV5PR12MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0291f9-b1d1-48c2-71cc-08de88e7adf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|7416014|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RkaNGcE5cTFblQhUjXPXDdKzay2kccjeHr5umKPoW2380gCWetr/9N3MWnWifCWNzT1xHfO/rzld358ATnAG24FjBImPGuH9XlauZNfwl10DN8TOCfReGvD3Lp898QOxDWTyw5ooh9p79bG4REr5/hS9c9fc+sbHlDPIlq4cesUSU3pVhqdNvyYYOgHNA3k3KnY9H4helQFvWe/bWTuj0Up+CwH3I1I0cL2s1MXsTHtnac/WKJsF60TXlz1le/odcZ2igIxAAnk/QQ2GgE7F7X3/kZ1ROZRhXyKXhuT0TNIgJiKrXhlnUI4fu98HgDE/EsZHGgexX/jy8K6MPbiEWK8A3ApbpvAkKZuxRymi2m3If8HYa99m/6d+w37PbsUJyZKvdcqohaLedaK7FSHn0vUeK3PebjPVKiQNuBMQ/A/nAs/sEAMz65kr5DgKl9Q8DJXBn6kMgBPWtqkAzk/Fx4OTz96qpHHG6SS62d4YsqWPUhAvW/WjsFBekE7xuX3XmRtnmnbdKix44dftTyCMMo0ppkDdc0fccCuSl+Xgn13dBQtB3eANhXE2Q3RmJ0P2W883p55Ch+9HQWS7OmB5mWMqCkRPst3xc1F3ycTqAGYPuWz0HPQw4OOqqfKB9CuaBqB2I5fZB3YZdcDIgnUEjPIBI/zt4ET0PxpFcpLICZTucgn7kK5QAmLHfxLGbhLU4w35F8XH3NC1Y3fUBDCG4tA0EgZuP2n47c5s0sajTJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJodzI0V3ZOZitPUGdlUTdyTEpzUXJNM2pMSnJ4RVZYTjNNaVU4YkdWYWRs?=
 =?utf-8?B?YnBmRW1vSit1bUNCRkNvb29hWW5aVHRtWFVGSzFyR1Rva3BheTdwNEVMWUhu?=
 =?utf-8?B?Sit3RklETWxBQTlsY3h1ZlVOelN1d0laU1F3Kyt2UHFYYk1ZWjU1L2NmY2I4?=
 =?utf-8?B?L09ZNCs4dnZTVzBsc1lUa3Fabmx0MVI5RkVFQ2xlZTNuWnhwdDVjQjNhS0hJ?=
 =?utf-8?B?VmQ3V3kzc0dIS1kzWVNLSzYyZ0JJNFlKUndQR0JRbDNreW52TVJOcUJrdzZ2?=
 =?utf-8?B?eFNESktFb1VLMFIxbWRpYkVGSExpeFZrTTNGZnJrd0IwRzdYYkljelREM29q?=
 =?utf-8?B?RmNYK00yL1lkeUhoWFBOd2R3emhUMUdSVGJXMlZMR08yajNERDBMSDl4U3Bm?=
 =?utf-8?B?Uk1Dd1RLZFRZNGFhazRNa3BCU2pNU1lFVG05djkwRWhvVEFiMkdSUnNXS2J3?=
 =?utf-8?B?VTJOOFU5RkpCNlloRmxqNTI3eVFNZjhWZTFCRTRIc0ZLWlJsSzRQcHRtVjVG?=
 =?utf-8?B?dzJpcTRYaUNtUENkY3VSVnJwZ1YzZUVxamNRWndrdDFUTHpLeU1kZGV4Tkpo?=
 =?utf-8?B?Sm9TbjZIMGs1OVBzSFh1YW01eUorUWhqd1ZxUkt0MUd3UjBoTmV2OTNVUSt6?=
 =?utf-8?B?WU04SzVhcEtHQWtYL0tOelhBS1RyWGR2RE5YU0hDVHB2dnZSNVRpb2dDVGN1?=
 =?utf-8?B?dHdBcDVLV3dhMkE1WmlhbFFZdFM5SDBaN0VMS2lxaTFtYkdlak5XZzZ6WE50?=
 =?utf-8?B?Z2ZIa1BSSjhlYUs5aUlKci9LNVE1SmpZNExhbkRZc1FqN3A3ZVUyUks5WVFx?=
 =?utf-8?B?c0pOS2o5VEp4Q2U2Mi9PZ29kZDlxSlFLQk82Yzc1NWRUOGh4SUJxNm9xN2ZF?=
 =?utf-8?B?MjcydjdrK1psYTcxUGhDOEZ2NEd3M0trT01uZ1pSc1JlcXE5amw4TU8vQk9a?=
 =?utf-8?B?VGtQTDRMbE1zMEVXOUdTdEJQQVBPdEU3dDN5bjJnZzNEVWtadGczOFZjV01m?=
 =?utf-8?B?YVhPdTNabFkya0JqdkpnNXc2NkV1Z2ZpVFh3T0YxRzdFOWlab1AzOFlQcjR1?=
 =?utf-8?B?RjBjbDJpY3d5VVJLUmpqR2s1QWVzV1FEeGw3VXFwbnVKd2ludzdmYUxSUkMw?=
 =?utf-8?B?NEdOenVNSHlxdTVHbDVOTk16NzRveExmaGlSSWFLZHNJS0lwcXBBWUorRUpu?=
 =?utf-8?B?MmFSQkZPdHoyeDVRSGNFYnVzTWRmaU5XQ2tGeklNTkdaMzdmU3VieXR4bnBY?=
 =?utf-8?B?THdLb1FRczdUZ1poMS9yVHltNmFwK3l0ajR5U21Ob3BKK3pwbjhMMTN5d0Zy?=
 =?utf-8?B?NkY0VklNYXNtQXNTMDdKOVgvcjlQMWZCaWpoNGd6TS9jZ1BEdXpncHNRUkJR?=
 =?utf-8?B?Q29tRjJhclZUdzMxV2taREhhRmhtOVVYRWFDSGF5aVhuWUlnUjBUVHZqZXhp?=
 =?utf-8?B?NUpsQ09ZZkswa25rRm01SXgyTWw1UGpYMkpPL2J2VWJiWDdmZlhKOFFKMXNV?=
 =?utf-8?B?cTR2aWF6b01SaVFKQUFjQk9tMjhRcDVlVDdkSzd2WVhUaW90TTUwSW1TUXdH?=
 =?utf-8?B?THg5RktQVW54NmZiM3Vzc05SeDMxWnNHRzZQcHV5ZUtQbTRsTTZJZTl2Rjdi?=
 =?utf-8?B?MUd5S0ZzN292TW5DQTYva0ZON0MwNUZGYVFwZW9rUk1Ka0RWbDE2ajF2c3hi?=
 =?utf-8?B?MUZMTklFWFFiQ3ZlU3kwSHgwS2dYdnVGUUVGdjVNQ0kzcmxBZWRjSHoxdU1W?=
 =?utf-8?B?aStPTGQ3dmN4N3BGanNpYzVtbTdTRmNHZnF4ek9aV3lGTTF1Wi84RnAwY2VU?=
 =?utf-8?B?cGgzcGhHRDVrOHFmSzM3RkRjcDlXV3VUZEY3cjNGYmRVVzVTbnVkU0ZSdDZ4?=
 =?utf-8?B?aXVPbFFSUGhwZkxZci9tbXNOaTZ5VFFSTitXU05MQnRDek5BREhQSWZRclJW?=
 =?utf-8?B?b1NBVlBndjN6c3pZWlAvQVRyWi9lV0xNUm05bGJRUzgrWVBXaHhYbWpYdEZ6?=
 =?utf-8?B?WG9tZ0dlRWZiMW1wajBqRG13TjhLV3IwRWhZaTFLZTNiSU9IQXF1c285VXBn?=
 =?utf-8?B?Z2d4RVBRdW8vSzVMWWVxMGRGMjFYa1FFN1VXZXVmRWM0MGM3NVlXSmtLUkdW?=
 =?utf-8?B?RWdub09ZWDVLblVwNzltbUJZVE9jZ0U2TDkvNkZjbnR1cHpHSEF1aGdPYTVq?=
 =?utf-8?B?TllwUE9JTFZGeTlxM1cyL3NKQ3FuUDhBYS9XLzNBb2RSYThZWEFKeFlTSVRq?=
 =?utf-8?B?d2FXVTVsVE9iK0NZVi9WWmpNWGJKUWVhOFJEOUZndE84UkEvKy9OY0pUTFZn?=
 =?utf-8?B?Q1daNnVNMTFFdWVGMm5mTW9QSmZObDQ0OFAxNUNIZmZ1VmpBWGlKalNuVGlv?=
 =?utf-8?Q?TIUMVU+X2wNlxus2ISm2DKoTjed+t+hI2JH+QGrPaFw/w?=
X-MS-Exchange-AntiSpam-MessageData-1: xMDUvnjNb1mvew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0291f9-b1d1-48c2-71cc-08de88e7adf9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 14:22:57.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ha4tMk1owNM1vGM7Pdg5BZzjlph1TAg0vozm0CAmG/C64N95p6mE1xajDDzjjqD06jaMVuJkEDWZ/oMLYsO6HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9801
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

On Mon Mar 23, 2026 at 9:43 PM JST, Gary Guo wrote:
> On Mon Mar 23, 2026 at 11:07 AM GMT, Alexandre Courbot wrote:
>> Introduce a powered-up version of our ad-hoc `impl_from_enum_to_u8`
>> macro that allows the definition of an enum type associated to a
>> `Bounded` of a given width, and provides the `From` and `TryFrom`
>> implementations required to use that enum as a register field member.
>>
>> The next patch will make use of it to convert all falcon registers to
>> the kernel register macro.
>>
>> The macro is unused in this patch: it is introduced ahead-of-time to
>> avoid diff mingling in the next patch that would make it difficult to
>> review.
>>
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/falcon.rs | 82 ++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fal=
con.rs
>> index 5a4f7fc85160..5221e4476f90 100644
>> --- a/drivers/gpu/nova-core/falcon.rs
>> +++ b/drivers/gpu/nova-core/falcon.rs
>> @@ -54,6 +54,88 @@ fn from(value: $enum_type) -> Self {
>>      };
>>  }
>> =20
>> +/// Creates an enum type associated to a `Bounded`, with a `From` conve=
rsion to the associated
>> +/// `Bounded` and either a `TryFrom` or `From` converting from the asso=
ciated `Bounded`.
>> +// TODO[FPRI]: This is a temporary solution to be replaced with the cor=
responding derive macros
>> +// once they land.
>> +#[expect(unused)]
>> +macro_rules! bounded_enum {
>> +    (
>> +        $(#[doc =3D $enum_doc:expr])*
>> +        enum $enum_type:ident with $from_impl:ident<Bounded<$width:ty, =
$length:literal>> {
>> +            $( $(#[doc =3D $variant_doc:expr])* $variant:ident =3D $val=
ue:expr),* $(,)*
>> +        }
>> +    ) =3D> {
>> +        $(#[doc =3D $enum_doc])*
>> +        #[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
>> +        pub(crate) enum $enum_type {
>> +            $(
>> +                $(#[doc =3D $variant_doc])*
>> +                $variant =3D $value
>> +            ),*
>> +        }
>> +
>> +        impl From<$enum_type> for Bounded<$width, $length> {
>> +            fn from(value: $enum_type) -> Self {
>> +                match value {
>> +                    $($enum_type::$variant =3D> Bounded::<$width, _>::n=
ew::<$value>()),*
>
> Hi Alex,
>
> This looks exactly the same as the last version, without out the {} and M=
AX..
> change made (which you mentioned in the cover letter).

I'm so sorry. I mistakenly squashed the fixup commit into the next
commit instead of this one. I will resend after hearing back from Danilo
about where the macro should reside.

