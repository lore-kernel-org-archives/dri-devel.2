Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232F7C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6953210E537;
	Wed, 19 Aug 2026 07:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDATSt0y";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF5310E537;
 Wed, 19 Aug 2026 07:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5GGDiMIYTwkeA9smXVpSDk978RTy97FGsT3Hd9j6UvmbcMJQbtl2umSp28aWIKUXfhy0Kg26TvIri33in2gm+sfOBvRw2ZFffXah56qCmuNoiJ7DNHqZZktG0cFDN4L8Ss1Nr5SUQi6jolo5pVBAeKQqvCgGRQAZhQfWv3S5ZYX6F8oRAgCPt2WOoNPNhahtzqLjgSUA3FmFnFGBcE1LZkXgPy5Pwvtvd6JM5CNmuOeJ1WqxNCuM2Jnq8isCNzzoyYm8mhW1rvpHVhSKKKHc1/fcjrNAupU4u6mJiHy0KjS764aWXmXQxaA2p+1mC5bMeBRch/y7omsLKpl4hTGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cu6K0uSOUJ0leiti2dxAE5xZ8qo/AsLiN35zmyUeio=;
 b=KPjHr2CAQPXiAbyPJJmLTE8HBDVqKSdCLoAfO0l4ZbeZTuH4mXEhZrT3AbZcwRATW+pFYD1sXMbcCxsZIdvHuQfb+UwP0O+lU5ufmLcFYN8HEvi4Q3CKYmoEV3mU5kW1uSXOQ6mFP3ODqV/3eW2KzFaQo/2s0LFIhXlPnJ03igAr10yG2SM3PH8CKSSemfRsYmJG5HogVwB+S+W9ayB7abIh1c+tS4bOk2iefabf5iCPmgW1kggXmp8/QM50NXvHyW4hVyUqxjNhcGEgto6401tM5KzY3fRWVMjEde9soSPwC5i9xbvbW+sGv1J7B9Gh2vmP34JdoecFAkdYzTsSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cu6K0uSOUJ0leiti2dxAE5xZ8qo/AsLiN35zmyUeio=;
 b=RDATSt0yiYqMqwYa8t7RutboStQ8WFqNRbAsEVYGT2Gs0buuEiUFhixV9B36DuqWu6ypAmTCuqPMCg/xid8fY1UveK6ywW+JsWw0YC34SPOK09FnXC2qP54HRL8INQg38k9oPw4Ddyg3xsjKxyjlycUe/MXpYLKgUiJhjmPmxdxCK5ICfqI5sc4PtfcliU5O/jMleBUU4ORQbC+uMYoW8/WvRxU1HbqwDhzSKOUTwoNJh7HIk4whdGtWKs4kV13Y4JScPAMSty6SNdbFB60NXPSZ1WmG65v1adzX95Fcd5FsZhnSHN/KKbXlOEs6ffdPWIbqPQC+aX7/+0EQIg5rzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Wed, 19 Aug
 2026 07:43:18 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 07:43:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 16:43:14 +0900
Message-Id: <DKSR2WF91FL0.78WHY1E7WIX9@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
 <DKR9WJY3WI0F.1FV4PD1J17ZFD@garyguo.net>
In-Reply-To: <DKR9WJY3WI0F.1FV4PD1J17ZFD@garyguo.net>
X-ClientProxiedBy: TY4P301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 02929aaf-af54-4383-b239-08defdc58906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|23010399003|376014|18002099003|10067099003|22082099003|6133799003|56012099006|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: q9HSSbY/QT0Z+VnuT8at/fyTI2HOk3FNZGDsxOLUsndCtgMF52qFvonbNSluwNK/cHUh4G4YKeihpHof5Jm8cAQ/BdGeUdBKKCLvfpbpMQ5K4En6QjHt6Owr8MTyHk6ISr9eAQ1rcUGCoB5sy+O5LZSTChghTkqUT4tzHb+YAV6ZY7R0iS82ACUqe/14FhD+YxRaWlbEFs9sjnIBlOYvayKza3Q+iSLlOAoITSlyo9Bm19EVi3PeEbA5tmY2/JhQ0sXRM5mJx36tCuYWJMs1+Gnw9rnCslnfTTBg3JNQWx3iqsdYccsrQ5CEJQaETjWVKV4AKzIbAp9BJLYsXG1z7kjNwTZzXP9wn1ItN4hDUhlPNSeyfFjK6013DZ3ZyaC/cXe3h7ayAUAztXDAAR6TGM99/XtjKI00AURkGgtG1XH+y7erK2mBdSRJ3FzPcw3DLjLdgyP1fP1wxZx1kv4ZgLldXP+diSGpa8ytc55slrq4av2AB+jfN4MkuDvm+NIldmivYMsmQn8R8UnoNRt6EtjO0THXba5H43UH194qW3+NMakkYrQO+B3azeAcCW/64HEaP7rVP6pFlmRxJI7EEIFs9w2+K7Cb75zvMdhwOp33Ro25Fh/gXealwHjZ3PG1vGnaBSs5HfNGSdQHEqHG5Zc35z/O1JcPv3FEyKtb4wX3fb3fUwAgsiMUqqkAEKTcGjmlDClW9Io7xjYwOQIxng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(23010399003)(376014)(18002099003)(10067099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdDL3VWaFQ3cTNtYkd1UWpQaFhSOVJKTFFyU21QU0hESGdkL0tDcTAvVFht?=
 =?utf-8?B?N2N5RklOT1VjS1hGaTV3VGFDZ3lTQXhLOVJiSjhJYXpBeG5NbDBSVGljemVO?=
 =?utf-8?B?bmFxdXVmSk1mNytNOTFXL3RrTVhDWWJDbWIybHZXYW5xdC9UN2RpNGRsb0Z5?=
 =?utf-8?B?RWs5V0EzV2dzeHhHcTNQb05GOFgyb2ExU1NTcnlKMjkvOUIrTlBCclhKcnlM?=
 =?utf-8?B?UFhwS1VUV3QwUTMwajBqZm04ZXVWMnlDbFBScDBRbTZEUGVseXVuQUl3NTk2?=
 =?utf-8?B?QTNDQXltZHJGekc0VFMwSWVsdmRUTi96ZU9OTkhOUWk0b2tWQ3lwSnI5b09l?=
 =?utf-8?B?RTlHZ2ZPVTEybTB4SUpsaW1IWTJCTXFXbW5rK0MxSWZ3WEl6dEltMUR3ZXJT?=
 =?utf-8?B?N0RjRmVSK0dpSW9jNU9rYXZtMndqUWZQZksrUWdKYkc5cUQrWWhFdmtEUGsz?=
 =?utf-8?B?Ky8zVnNPMFh1WTJ1UDNVaFhVTWtFYmRmM3hrbFdlNURUQ1g0eDZtRWR3QzhY?=
 =?utf-8?B?VG9XOUlSaTFGbENPVVpMc3NsUGxSbVdsMnFuL1VVa1RRM0lBcVU3MXFoczNa?=
 =?utf-8?B?NDkxQ1BSWS9OS3hXbVFMM1l5SnRvMi90T2V0ekk1UXBGcHlaL2dmR2wvVklH?=
 =?utf-8?B?eU9KakNzc05XbkhzZWxJK05Ed25WUTVUSXZ2elVKQnR0OUxyZXkvSVgvejNa?=
 =?utf-8?B?aHVWblJWVGFtWFJqalgwRHV4dHBXVlB3ZWVnbkZvZjF2NzJjbzh2VDhNTWlO?=
 =?utf-8?B?VHM2czh6THRhMGY4TWttb211dzF4MzBPSlR4ZnVFa0pXMTVScjRRbjZWRDBm?=
 =?utf-8?B?VTcrUXlWTHJMcXNTMlV2Nk5xRXo0MDlFTmJRV2d0a3M4UzA5R2ZUQlo2UDlr?=
 =?utf-8?B?YVZqWm83aGVwY1JWckF4TUJUdTBwaHRaVWlDSlNaQU5JUjY2bkhMakdhY2ow?=
 =?utf-8?B?Tk1xaFo2MksrTmN3c0xvOVNYOXFaOVp5RXFuL1VJMHhCOTBRTi9Cd2RYS3Vr?=
 =?utf-8?B?UG91WlJqVnBMY3czbzlpUG5RWnhzSDFzZlVPUGlnVkh0aW1oMmUyREYrSTZl?=
 =?utf-8?B?dTJZdHRWQlo4dU5QNVhZZUZaWDZsQ1ZtbmlSSkVVTTJTK1Z3dFE3dVhQbUVy?=
 =?utf-8?B?SmlpWk1UZ0ZQQ3Fta3ZuRWVjQVFiU1Y1RkJoc1Q1QzJETlVqYVcvMFJTZk9C?=
 =?utf-8?B?dUJiV2ZWcjVGVGthRkhwZnMvdWd0bGVtZ0twUk5iZFUzOEVNanRWdmZZcENF?=
 =?utf-8?B?Q21EQm0yM0N1TFZnS1Z1RWhOeVk4ZU9jSVNwckhZTkx0T3pRcENRNXJkaEla?=
 =?utf-8?B?THdtN0xITzdZY3JYd2VqbFcyOEswVFNzUk03NkhJS2FkY0tFZXF1TCsrU3V4?=
 =?utf-8?B?cW9FZEVTSUtBZytsWGMzWHR6Q0Zia0ZkWHJDanpkaDRZeGFUSkhEbGt5Y21z?=
 =?utf-8?B?WnBFaHJIWktIZTNpakk2YlVkUnBFcTJkQzBXa3BNUTFTYzBkeW9hZjliQmta?=
 =?utf-8?B?bWNXdXBINDZKOXZ6Wk1wMjNHczl3Zjh6U1VDd2o0R1NRNzB2Z2JCU3JXaFpL?=
 =?utf-8?B?OVk3ekJ1Q2FNMmM1bXc5V2pYclVPSGlUWTdmZjU1VXdSeWlnSmlFdERabTdX?=
 =?utf-8?B?R203eHhMM0Z5UXpMMlN3U2Y1K0pXUFV1S09MQU83dkpJUTNubkVIK2NlYWdx?=
 =?utf-8?B?Vkt5V0l2Nm1xdEZnOWRVTDZDZEtFRFN6cG5vNFBwWG15eDQ4dlZBRUw3bmN4?=
 =?utf-8?B?dG9YN244SUNzNlp0NGxsTndNN1NpdXdOd0MxcHdxdkNEWFBMQ01LaE5lNTNR?=
 =?utf-8?B?aWF1aUtFdXlFL2hMNkhEM1lyNzU0WnlObGJ1V1M1SlhDWVNMSFAvcnZvOSto?=
 =?utf-8?B?S3Y0M1h5OE91OUZ6czZXQWtrMXlwd1JzZWVSU29oRlVjaG5Db2QwN0JnOEpG?=
 =?utf-8?B?V3BmWWlEajE1dXVVWW04NjRjME4rc3dPbGloRFZjczkwK0dNdkFIdmRVdk14?=
 =?utf-8?B?TzJtUWlCMzBlWmNORjJWZUVIQ0RVZ3dsYkJBb1pjUVByT2pXMzVnd1RaeVho?=
 =?utf-8?B?RzVMaFU4M01TK3NqNGp4TWQrME12Qms5N28yYndtNnlvZmxWaFBCMTdEZ0RB?=
 =?utf-8?B?Mkt1YzRpbjdzVDJkOTVLQkQ5QkZUd3pYOWVVSUZTc0hoQXZBb2IrSU5HbTJ5?=
 =?utf-8?B?WkIxQmpDTDFIbGwwMGtjMUQ0ZTJteDdPaGVuWjJWM3pTY2RMYlJsMkJHclFG?=
 =?utf-8?B?TWpZbHpCMnN0SlpYWjJWVDZ5TklKQnY5OXJDUVNKYlNwYUIyd1dNVU83cFpp?=
 =?utf-8?B?RmpuWnZpUXR4V0FhRGU5TVNpcTVpVUNqNng3NHo1eE5waEtzSTJhM3NyV0gw?=
 =?utf-8?Q?4WbF2CUGDyy/tl6hjT+rYvPCaRJko06vWTVZJeUESoGFy?=
X-MS-Exchange-AntiSpam-MessageData-1: micHkddtNduorg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02929aaf-af54-4383-b239-08defdc58906
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 07:43:18.4522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5XKqdo1nBxjX/U3s7bZfgbhq0uFLxmV+gcBNbQOvmy/V1d/UR9i4L6u1emsVJVq/MogwPv55pADdTgjqmjNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
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

On Mon Aug 17, 2026 at 11:02 PM JST, Gary Guo wrote:
> On Mon Aug 17, 2026 at 1:56 PM BST, Eliot Courtney wrote:
>> Add `Vec::push_init` which initializes a new element in place. We can't
>> modify the existing `Vec::push` signature to take an `impl Init<T, E>`
>> without changing its Error type.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/alloc/kvec.rs | 42 ++++++++++++++++++++++++++++++++++++++++=
+-
>>  1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
>> index c7546b9da4fa..9f6f25d7e218 100644
>> --- a/rust/kernel/alloc/kvec.rs
>> +++ b/rust/kernel/alloc/kvec.rs
>> @@ -52,7 +52,10 @@
>>      }, //
>>  };
>> =20
>> -use pin_init::Zeroable;
>> +use pin_init::{
>> +    Init,
>> +    Zeroable, //
>> +};
>> =20
>>  mod errors;
>>  pub use self::errors::{InsertError, PushError, RemoveError};
>> @@ -359,6 +362,43 @@ pub fn push(&mut self, v: T, flags: Flags) -> Resul=
t<(), AllocError> {
>>          Ok(())
>>      }
>> =20
>> +    /// Appends an element to the back of the [`Vec`] instance by initi=
alizing it in place.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// struct Element {
>> +    ///     buf: KVec<u8>,
>> +    /// }
>> +    ///
>> +    /// impl Element {
>> +    ///     fn new() -> impl Init<Self, Error> {
>> +    ///         try_init!(Element {
>> +    ///             buf: KVec::with_capacity(16, GFP_KERNEL)?,
>> +    ///         }? Error)
>> +    ///     }
>> +    /// }
>> +    ///
>> +    /// let mut v: KVec<Element> =3D KVec::new();
>> +    /// v.push_init(Element::new(), GFP_KERNEL)?;
>> +    /// assert!(v[0].buf.is_empty());
>> +    /// # Ok::<(), Error>(())
>> +    /// ```
>> +    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags)=
 -> Result<(), E>
>> +    where
>> +        E: From<AllocError>,
>> +    {
>> +        self.reserve(1, flags)?;
>> +        // SAFETY: The call to `reserve` was successful, so there is at=
 least one spare slot; the
>> +        // pointer therefore refers to allocated, aligned memory valid =
for a write of one `T`.
>> +        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cas=
t::<T>())? };
>> +        // SAFETY: The call to `__init` returned `Ok`, so the first spa=
re slot now holds an
>> +        // initialized `T`. The new length does not exceed the capacity=
 because `reserve` ensured
>> +        // the capacity is greater than the length by at least one.
>> +        unsafe { self.inc_len(1) };
>> +        Ok(())
>> +    }
>
> Thinking about this from a fresh design perspective, I wonder if we can c=
reate
> something more composable by splitting the allocation and insertion, like=
 entry
> APIs do.
>
> So
>
>     impl<T, A: Allocator> Vec<T, A> {
>         pub fn reserve(&mut self, additional: usize, flags: Flags) -> Res=
ult<Reservation<'_, T>, AllocError> {
>             ...
>         }
>     }
>
>     /// Type indicating vector with reserved capacity.
>     pub struct<'a> Reservation<'a, T> {
>     }
>
>     impl<'a, T> Reservation<'a, T> {
>         pub fn init(&mut self, i: impl Init<T, E>) -> Result<(), E> {
>             ...
>         }
>     }
>
> You can imagine even pushing this further, e.g. have a type indicating ju=
st a
> single reserved slot. Or perhaps have a type that is `Vec` but with fixed
> capacity and cannot reallocate (something like `ArrayVec`) that the reser=
ve
> method will return.
>
> Best,
> Gary

Yeah that's an interesting idea. FWIW, I think the *_init idea has preceden=
t
already (Box::new, Box::init, etc.). I tried implementing something like th=
is
idea though, below.

Since we don't have const generic exprs I used Peano-arithmetic like types.=
 But
if we only care about empty vs at least one empty capacity, we could use a
boolean. The idea is to track the minimum extra capacity and provide a
generalised set of vector operations that would work regardless of the
underlying storage or allocator (well basically what you said I hope). Sinc=
e it
knows how much guaranteed spare capacity it has we can do a bunch of stuff
infallibly and track the guaranteed spare capacity. If there's no guarantee=
d
spare capacity then it will be fallible (but non-allocating). KVec then bec=
omes
a wrapper over these vector ops that just ensures it has enough guaranteed =
spare
capacity (possibly allocating) before forwarding. Allocation/storage relate=
d ops
remain on KVec. Then an ArrayVec and KVec can share most vector operations =
on a
VecView.

There's also some locations in other code that could use a VecView directly
instead of taking a &mut Vec etc. Having a Vec-like thing that's guaranteed=
 not
to allocate also sounds potentially useful to me w.r.t. safety for contexts
where you can't allocate/sleep.

If you think this approach is ok I can send it as a separate series. Codege=
n
appears fine practically speaking AFAICT.

Using it looks kinda like:
```
let view =3D v.reserved::<Two>(GFP_KERNEL)?;
let Ok(view) =3D view.push(1);
view.push(Element::new())?;  // only init can fail, push is guaranteed

let mut view =3D v.view();
while view.push(0).is_ok() {}  // can still do fallible stuff
view.pop();

// ArrayVec shares vec-like ops. can add method forwarders if we want
arrayvec.view().push(1)?;=20
```

WDYT? (subset of code demonstrating the idea follows):
```
mod sealed {
    pub trait Sealed {}
    impl Sealed for () {}
    impl<N: super::Count> Sealed for (N,) {}
}

/// Peano-like nested tuple type machinery.
pub trait Count: sealed::Sealed {
    const COUNT: usize;
}

impl Count for () {
    const COUNT: usize =3D 0;
}

impl<N: Count> Count for (N,) {
    const COUNT: usize =3D 1 + N::COUNT;
}

pub type Zero =3D ();
pub type Succ<N> =3D (N,);
pub type One =3D Succ<Zero>;
pub type Two =3D Succ<One>;

/// A view of vector-like storage with `N` slots of guaranteed spare capaci=
ty.
#[repr(C)]
pub struct VecView<'a, T, N: Count =3D Zero> {
    buf: NonNull<T>,
    len: &'a mut usize,
    cap: usize,
    marker: PhantomData<(&'a mut [T], N)>,  // Invariant to prevent stashin=
g shorter refs etc.
}

impl<'a, T, N: Count> VecView<'a, T, N> {
    pub unsafe fn from_raw_parts(buf: NonNull<T>, len: &'a mut usize, cap: =
usize) -> Self {
        Self {
            buf,
            len,
            cap,
            marker: PhantomData,
        }
    }
}

// Infallible (except for Init) push. `Zero` spare VecView has the fallible=
 version.
impl<'a, T, N: Count> VecView<'a, T, Succ<N>> {
    pub fn push<E>(self, init: impl Init<T, E>) -> Result<VecView<'a, T, N>=
, E> {
        unsafe { init.__init(self.buf.as_ptr().add(*self.len))? };
        *self.len +=3D 1;

        Ok(VecView {
            buf: self.buf,
            len: self.len,
            cap: self.cap,
            marker: PhantomData,
        })
    }
}

// Fallible but not allocating ops (can run out of space).
impl<'a, T> VecView<'a, T> {
    pub fn push<I: Init<T, E>, E>(&mut self, init: I) -> Result<(), PushIni=
tError<I, E>> {
        if *self.len =3D=3D self.cap {
            return Err(PushInitError::Full(init));
        }

        unsafe { init.__init(self.buf.as_ptr().add(*self.len)) }.map_err(Pu=
shInitError::Init)?;
        *self.len +=3D 1;

        Ok(())
    }

    // Bodies as in the current KVec implementations.
    pub fn pop(&mut self) -> Option<T> { ... }
    pub fn insert(&mut self, index: usize, element: T) -> Result<(), Insert=
Error<T>> { ... }
    pub fn remove(&mut self, i: usize) -> Result<T, RemoveError> { ... }
    pub fn truncate(&mut self, len: usize) { ... }
    pub fn retain(&mut self, f: impl FnMut(&mut T) -> bool) { ... }
    pub fn drain_all(self) -> DrainAll<'a, T> { ... }
    pub fn len(&self) -> usize { ... }
    pub fn as_slice(&self) -> &[T] { ... }
    pub fn as_mut_slice(&mut self) -> &mut [T] { ... }
    pub fn spare_capacity(&self) -> usize { ... }
    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] { ... }
    pub unsafe fn commit(&mut self, additional: usize) { ... }
}

impl<T: Clone> VecView<'_, T> {
    pub fn extend_with(&mut self, n: usize, value: T) -> Result<(), Error> =
{ ... }
    pub fn extend_from_slice(&mut self, other: &[T]) -> Result<(), Error> {=
 ... }
}

//  Decay to read only ops.
impl<'a, T, N: Count> Deref for VecView<'a, T, Succ<N>> {
    type Target =3D VecView<'a, T>;

    fn deref(&self) -> &Self::Target {
        unsafe { &*ptr::from_ref(self).cast() }
    }
}

pub enum PushInitError<I, E> {
    Full(I),
    Init(E),
}

impl<I, E: Into<Error>> From<PushInitError<I, E>> for Error {
    fn from(e: PushInitError<I, E>) -> Error {
        match e {
            PushInitError::Full(_) =3D> EINVAL,
            PushInitError::Init(e) =3D> e.into(),
        }
    }
}

// `reserved` gets you the guaranteed capacity VecView.
impl<T, A: Allocator> Vec<T, A> {
    pub fn view(&mut self) -> VecView<'_, T> {
        let buf =3D self.ptr;
        let cap =3D self.capacity();
        unsafe { VecView::from_raw_parts(buf, &mut self.len, cap) }
    }

    pub fn reserved<N: Count>(&mut self, flags: Flags) -> Result<VecView<'_=
, T, N>, AllocError> {
        self.reserve(N::COUNT, flags)?;

        let buf =3D self.ptr;
        let cap =3D self.capacity();
        Ok(unsafe { VecView::from_raw_parts(buf, &mut self.len, cap) })
    }

    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
        let Ok(_) =3D self.reserved::<One>(flags)?.push(v);
        Ok(())
    }
}

// Non allocating ArrayVec backing.
pub struct ArrayVec<T, const N: usize> {
    buf: [MaybeUninit<T>; N],
    len: usize,
}

impl<T, const N: usize> ArrayVec<T, N> {
    pub fn view(&mut self) -> VecView<'_, T> {
        let buf =3D NonNull::from(&mut self.buf).cast::<T>();
        unsafe { VecView::from_raw_parts(buf, &mut self.len, N) }
    }

    pub fn reserved<C: Count>(&mut self) -> Option<VecView<'_, T, C>> {
        const { assert!(C::COUNT <=3D N) }
        if C::COUNT > N - self.len {
            return None;
        }

        let buf =3D NonNull::from(&mut self.buf).cast::<T>();
        Some(unsafe { VecView::from_raw_parts(buf, &mut self.len, N) })
    }
}
```
