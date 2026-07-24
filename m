Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4E0C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE1610F2D3;
	Fri, 24 Jul 2026 06:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fA1ohm+R";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEFC10F2D3;
 Fri, 24 Jul 2026 06:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1MTabLGcMzLXEavJbVP5M+T4hjmamO4o7vjr6BFRkNrN6PEHDb0D/Rh57bGC/TfQQE6u7YZgV27PUF4kmmONHNw8hUcEcYDsoC9h+NhjcP0UupZvsCraDIeIQI+vs7R5TXPNkmKmyB+DrNEZHQAtGdN/vJiDeesnbXmxOyi6p8Wq4VjmZ7qdTdUjd2921O4Ok0c7YQYaBGKZGkYkyyjsVoPf8jUT+j0npVElDL1tBxGgj9eOs23ZYB+8681q8VfYTCyWj8pXb4ItXymmJVHQuPM4OuBQqYl4z/xYwCe5161WkOxzYq/lz6h9uKfs8dPGdXL/av/DVbpn5qxK+k4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L47DPOPTKVDU/kmSeowQvrKcXwzO3MbbngcNc7iiAIc=;
 b=MABtlM67cHoHRb+X4k6YIMAbnDKVtLRYmF+HSJmDeTmXZE/28wKp+6iDKxbayg2Rc4wga8JjcBVradxWyJPorafcV6auFoD+gcva9faISZg+aLo22iENMNT2Xdsv323fUN3uRtCwwGjf0y9PGlxmMECdlyeCh74C96JgTAX1C0TSC9N6jRBuODHlhQkhzsRLhv7ZI60AJmeKHxoAzZg2GPen4ioxr+G6t8R2BDDrYW0s83BNqqir4o5+mncPYcVu8mjsEv4JlgDiT2u9FtrMEg0lj615Zwf6k0aMCtvmHjPUaFknJyC++RNt+22TXgwAotnWUJkuK0FAkuk5Q1nxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L47DPOPTKVDU/kmSeowQvrKcXwzO3MbbngcNc7iiAIc=;
 b=fA1ohm+Rwo4Sy+nAy3FDwHWQQ9gmjsFSFFr7Dw/OkwIIg7Ek+JF0Bbmby6aLcTlWBrY8zwo1Hx9cZlv17s60meMVKUEqIF8bWtro0Igx+c8BFoieYrUpl6jzuptGt9ij8iHB2PxrUfLw+CNFfyrb9AOlIufGTjoncDsLoYIw7vNMpN8CfnpqQzXZpnV6wb4WSy96TpHURcDe44WlzXFX7zt3Xzb4xzmZCvFP96GdsJbFqS2RJ93U7uFG0PgSMcXNaw13KpfmHmJ1lcGXFLVnA28j5TvTjm89NeX1hheeXAGwKUnnaZcz8OX6eGbyzx5d11R9anMm3sr4citfoyuhnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:58:08 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:58:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 15:58:05 +0900
Message-Id: <DK6LU60L9ORM.3QRGRG81VJZO1@nvidia.com>
Subject: Re: [PATCH v2 06/10] gpu: nova-core: correct FRTS vidmem offset
 calculation
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-6-8e3d8bc32bb9@nvidia.com>
 <DK60G8GDS2V9.T0LEJKNA2JJA@nvidia.com>
In-Reply-To: <DK60G8GDS2V9.T0LEJKNA2JJA@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d829f5b-753e-4e48-58d9-08dee950eb52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5+Voc+nUKY5DtYF+PJn2wLrAOV9MAAgs1+6qnfMfFeHWXw+trpX2wGujvfSkn8MxiebIA4F5wexV7fpCDPFrVRaxQ3W6+0WybzJKB9Wj46fYjSlS14xToNsddBqjgwKarpjsE3Puf634q11F+YlV1APd9CcUS2FVXKcv9X64NL4PafSR+OZEzYL0UmpYo0ijOn11pukwLm1dWFUeVeYGRbZTgmgO80tKatVFAGWE7nx/dFRkKBq0WFeKOUaoA5urYq4ui5V6ULgp/UGJDYQFSVPNd9ny/oPmsWIKqVmhTw2ig2evLevV6lIvVfqfxMevIRl7Z5Y1F+E8sk9AnmXm3lCORV2fOoR9VN2cez3nRu1OTw4LQQsNGvT0IrmlXTdlBRKytpZMBuX9ezqOVGUerKH9QroaBVtRo85Id4Ekwck2A6/EMzBP3Ah1KR38p6H/WZ12ghk4QiAjsNmmP0DDQNbN5AR/Bmiz3l4SuDQnPzTIKOecpYAPaIvMNX6uy5M5aB9gbZFXPuGSq4QlJ84HH9GA/9v9q7Q5sh9krecSRO2XexcrTA6HNq/K4R1tghsiC+m8/J8PaH9/AGcUCX1ieFwk8yfJvNMx2oLe1/0UkSx9J2HQu/zfbJ+CCZLZbqL9zC8Irq/snIrGTyiU8QUKVh7y/r2OehjYZ7UwBEL6Ss4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b05rbnJNbzZZTk9CdzJkakVXbDUvbXprVDVoSGZyMjVlTit5cnc4dWVYOG11?=
 =?utf-8?B?WFREODRieUZZMS95cmFzV2xodXZQalZLcldLL2xTUEFEbjk5SVdsNGdJc1pW?=
 =?utf-8?B?Y3R5MUlSWE0wWmxaM09SY0E1Nm5WaFZKRHowZDd5cnVMdXRueDIvQXRqeWRx?=
 =?utf-8?B?OXpJRlI4bi81dXV1d3BjcDBQcGJwcmxDblRjWFJGY1RTY1l6U1E1czhjVU1P?=
 =?utf-8?B?Q05KZno2ZGM5ckJDV3JCRWRkMkpQTDZYUS9yMk9scUlzcXVMUitlaDRSTnV5?=
 =?utf-8?B?ektxRnBaekF1eHFOQlIxUlhSak0wQnFLK3E1MWM4VjYyTElrVlhET0lrRVFh?=
 =?utf-8?B?VmRxVHZhOWZTTlpjYWFCbHlSNWw4dGhnc1h5WFZHUTF6OVJhTWQ5TUhVczk3?=
 =?utf-8?B?dEF0alhUZXFtK3F3bENPOWx1SHhZdXVpeG1NQkw3QnZ1elpoM3FyRmJIVGxq?=
 =?utf-8?B?QnZkeUJIa3RnNmxFRjF6QzJvaFVjWGY0TklNMVUremFadjZHNEJCdGNWaEx4?=
 =?utf-8?B?NjRuTHhNQXNoanRjSllmcm9wMDlmYlBvL1M0d3lYV3E0YUNqdUxuTjByMlVS?=
 =?utf-8?B?KzZGaGNCQVV5TVhBVHhudkNrS2xQNlRWY3V5ZlRlYVFVZ0Y3cTVjVmxSUkVZ?=
 =?utf-8?B?VmQ0czJYc1c4RDgrZDF1d0dXZUNYSlJHYURjeXk1YkVJdW96OWdOUWJEcHVh?=
 =?utf-8?B?ZEt5Z05WcjFlT0NqZi9Fei9OUlFvVmE3WjVzQUx1cHkwVFJIZUpjQ0RCb1Fz?=
 =?utf-8?B?NWowS3lnRStuUTVvSU9JdGQ3dTVRTUpQQ3NYRHhqaCtINGV2UlcwYmJkeFFa?=
 =?utf-8?B?YjdreUJVVjNYSmxTZjB5c2ZnYWN0cnFlRzNQS3hvVWdscXlsWU5KZGI3NzE5?=
 =?utf-8?B?bDZPM2ltSjVmcE1ENW9yaElnWFN2NzhiQks1T1FkQUlRT3RYekVXOGhmUFdi?=
 =?utf-8?B?azY5TGM2bGlTcEt6Y3Q1ekd5Q3BKY2hncnZGQzQzVXpCR2F4eHI2NWFZWGdy?=
 =?utf-8?B?MStYbXBxdWFGY1lJblRFajdSWU5BMzNlT2FWN0ExWmk4Y0l1YUpxTFQzRVRY?=
 =?utf-8?B?K0p4dVhEa3pQWTA2RGYwZUlySHYyeFJ2VWZKM2ZLUldreHJNc3lSa0NlUHJl?=
 =?utf-8?B?Uzhqc1Y2MmpjQzl1L0sxQmZnZXNsL1B1QWpIQWhPc2xOVlQ2cFU2a2w0YkRM?=
 =?utf-8?B?cEMvN2hNSlZ5N25YWkNoOVhITHU3d2RhQlZQaFFzdzdhZlBGbTl1eEJiZG1Q?=
 =?utf-8?B?SXNyTUM3K1B0NHA2SzFaU1Rpb3k1OFBRdWNmUS8xdjhYNjBlYjgzRGdVQWhz?=
 =?utf-8?B?RlQ2U3kyWnkzd2dFMjJudTdVV0QwR01tWEMwWUg3TGFVRElCMFUwd0RzUVY5?=
 =?utf-8?B?ODZLNDFCbSthM3pRWG5UWFNvTUkrbk5sZXI5RHNFZmJoTkRmN21HVXlSYm4x?=
 =?utf-8?B?dWFhTVlQRnFQQ0lpbmJnTlFmbUFHd0ttOXM3MlA5NEdyV21za3dERkdmMGZE?=
 =?utf-8?B?KzNjU1lGSEhDWjZhUnYycldLRkJRUFl1bFFDRnBwcnArZkhQcTVhU1FyVXVa?=
 =?utf-8?B?Nloyb0FwMTZMSURmVGM2bjQvdW1DeVRYTkFJSEtXaE8wSjloSmZxRUJjSmNh?=
 =?utf-8?B?dTRUMmpjTmx2RERVRmJxaEN4a0k5c08yZXYwRzVpVWtyQzdjVncwSklMSjBF?=
 =?utf-8?B?T21MNVppVm9GK3FqckpyQmpFWXpVQjdFVlRBamNBaWdENHpUVHdlY0R3emhG?=
 =?utf-8?B?YWRpOUJOeVZ3TDB5TVpZOXM5RlFaZDNLN0hLYXFiT21jWmtCMEVJRmc5NlBU?=
 =?utf-8?B?MlpCd2FGWW1oSHZKMUhWV1d1SE1ROWt1WENKak1SZEQvRjlNTmRhQnUrWm41?=
 =?utf-8?B?UzJmcjBEYWNHNUJvdTU4SXlzQmFDNERKdG1rWklzenhJVEdhS29NbnNaWUR2?=
 =?utf-8?B?N0hiY3JiS2RFdFBmZzZHMGxua1RUa090eXRvaGpjMkswd2UrWjYxU01OU2R3?=
 =?utf-8?B?RkZvazhqVHJ2MVZ2eU1SbCtINUl6OU5jNUpXalZTdElER3JiTzl4U3ZoSnU4?=
 =?utf-8?B?YnU3dzAxVWZUMjBPOU5wR2srRkhLOU5UdFF3VUloaVZqWnIrR3JzelJva3hR?=
 =?utf-8?B?U2huT2pMRnNwVXlRZk9nWnA3ZzFpWEptNm1QdlVRS3BmSWZudGRPWTJQa1FH?=
 =?utf-8?B?S0ZaN2g0K2kyNmZncWNLdTF6VnVydGlkN3RGZHVLaHljSXk4ZHlrWHNrT3VZ?=
 =?utf-8?B?bVNEeTlzTjNEYktTbGhCa1NCZmw1NS91S0lnYzZMR0RxLzh6cEtYK0Y5MVdI?=
 =?utf-8?B?L3BLekd6Z2h1Q0c1RS9kM2h1c2VNZSsyaHNhc05EYUp0VU9tbkh6b3VFTjFJ?=
 =?utf-8?Q?mYFt521Sru2MYBDj4xhBSkX52AfISIMFzQ9OiWLSkNX6u?=
X-MS-Exchange-AntiSpam-MessageData-1: eZKQc79NGRUvgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d829f5b-753e-4e48-58d9-08dee950eb52
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:58:08.8965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buTMNucRTz9KYvIPwoMoYkTV2OOsObK1StFMWzInUnrhEDrs/6KvfqpzDtrrGaru0dslD2RnMSShHwNyyLsKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

On Thu Jul 23, 2026 at 11:12 PM JST, Alexandre Courbot wrote:
> On Fri Jul 3, 2026 at 7:22 PM JST, Eliot Courtney wrote:
>> Currently, the frts vidmem offset is calculated based on the non-wpr
>> heap size and pmu reservation size, but this is not right. The layout
>> actually looks like this:
>>
>> | non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |
>>
>> It's just by coincidence + generous alignment that the values happened
>> to match. Instead, define a per-architecture reserved size at the end of
>> the framebuffer and use this plus the PMU reserved size to calculate the
>> frts vidmem offset.
>>
>> Fixes: d317e4585fa3 ("gpu: nova-core: Hopper/Blackwell: add FSP Chain of=
 Trust boot")
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/fb.rs           |  4 ++++
>>  drivers/gpu/nova-core/fb/hal.rs       |  3 +++
>>  drivers/gpu/nova-core/fb/hal/ga100.rs |  4 ++++
>>  drivers/gpu/nova-core/fb/hal/ga102.rs |  4 ++++
>>  drivers/gpu/nova-core/fb/hal/gb100.rs |  5 +++++
>>  drivers/gpu/nova-core/fb/hal/gb202.rs |  5 +++++
>>  drivers/gpu/nova-core/fb/hal/gh100.rs |  4 ++++
>>  drivers/gpu/nova-core/fb/hal/tu102.rs |  8 ++++++++
>>  drivers/gpu/nova-core/fsp.rs          | 25 ++++++++++++++++++-------
>>  9 files changed, 55 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
>> index fd60f93258a9..5ffe66af282f 100644
>> --- a/drivers/gpu/nova-core/fb.rs
>> +++ b/drivers/gpu/nova-core/fb.rs
>> @@ -305,6 +305,9 @@ pub(crate) struct FbSizes {
>>      pub(crate) heap_size: u64,
>>      /// PMU reserved memory size, in bytes.
>>      pub(crate) pmu_reserved_size: u32,
>> +    /// Size reserved at the end of the framebuffer. This is architectu=
re dependent and used to
>> +    /// compute the FRTS offset for the FSP CoT message.
>> +    pub(crate) fb_end_reserved_size: u32,
>>      /// Number of VF partitions.
>>      pub(crate) vf_partition_count: u8,
>>  }
>> @@ -322,6 +325,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Se=
lf> {
>>                  .wpr_heap_size(chipset, fb_size)?,
>>              heap_size: u64::from(hal.non_wpr_heap_size()),
>>              pmu_reserved_size: hal.pmu_reserved_size(),
>> +            fb_end_reserved_size: hal.fb_end_reserved_size(),
>>              vf_partition_count: 0,
>>          })
>>      }
>> diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/=
hal.rs
>> index 714f0b51cd8f..aa50534550eb 100644
>> --- a/drivers/gpu/nova-core/fb/hal.rs
>> +++ b/drivers/gpu/nova-core/fb/hal.rs
>> @@ -41,6 +41,9 @@ pub(crate) trait FbHal {
>> =20
>>      /// Returns the FRTS size, in bytes.
>>      fn frts_size(&self) -> u64;
>> +
>> +    /// Returns the size reserved at the end of the framebuffer, in byt=
es.
>> +    fn fb_end_reserved_size(&self) -> u32;
>
> This connects to my comments on the previous patch, but this HAL method
> is only ever used on the FSP path, yet we have to provide values (that
> will remain unused), for all chipsets. This really strenghen the case
> for making FbLayout/FbRanges/FbSizes local to the boot method they
> belong to.
>
> Since `fb_end_reserved_size` is only ever used by `fsp.rs`, it would
> make sense (from an architectural point of view at least) to have it
> defined as a HAL method - even though its name screams "fb". Since they
> are firmware-dependent, I'm even tempted to place their definition as
> constants into `firmware/fw.rs` to make that fact unmistakable (and keep
> all firmware-dependent data in the same place, as missing these upon
> update is a source for headaches). It's not perfectly clean but there is
> precedent for that: `fb.rs` uses `LibosParams` for instance, and
> `GspFwWprMeta` also comes from there.

There's two values used, so a standalone constant in firmware/fw.rs
isn't a good fit IMO. I think putting it in FSP HAL for now makes sense
but we should move it to TLV firmware at some point. Sent a respin of
these remaining patches and I think it addresses your points so PTAL.
Thanks!

>
> <snip>
>> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
>> index 533fb95573ab..a38ba66626d8 100644
>> --- a/drivers/gpu/nova-core/fsp.rs
>> +++ b/drivers/gpu/nova-core/fsp.rs
>> @@ -134,20 +134,31 @@ struct FspCotMessage {
>>  }
>> =20
>>  impl FspCotMessage {
>> +    /// Computes the FRTS vidmem offset for the Chain-of-Trust message.=
 It is measured from the end
>> +    /// of the framebuffer.
>> +    fn frts_vidmem_offset(fb_info: &FbSizes) -> Result<u64> {
>> +        let mut offset =3D u64::from(fb_info.fb_end_reserved_size);
>> +
>> +        if fb_info.pmu_reserved_size !=3D 0 {
>> +            offset =3D offset
>> +                .checked_add(u64::from(fb_info.pmu_reserved_size))
>> +                .ok_or(EINVAL)?
>> +                // The 2 MiB alignment is r570-specific.
>> +                .align_up(Alignment::new::<SZ_2M>())
>> +                .ok_or(EINVAL)?;
>
> Note that we are adding two `u32`s and aligning to 2M - so there is no
> risk of overflow. I think we can just document this, use unfallible
> operators, and return a `u64` directly. Although `align_up` will still
> return `Result`, so maybe we need to keep it after all - but the initial
> addition can be unchecked.

