Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B7CEF4EC2
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 08:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D8910E210;
	Mon,  6 Apr 2026 08:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dg3LHdL+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E737C10E210
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 08:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjW1RqNM49K+oTyZ8smNpZS5wcrme0yDHquOc1MHUn8+s5zqLH6F3DCCgNSYlezwrh/eYSa2WmsHLwCSrUSDAmJmt7wWOpzyfeKvY5ZJOplGT93bTTwR1ae1+sjwPZlztJsxWoazng83S2Bm61l6jSIaf6bWbncNQeEG2g2jBmeF6pkOAmEz63am0egcdS7Tq00Ri0ClN6xcga9tOuWDLC5jipPBA3EeVRpvRQ7Q2b0dBzpNGdKLp8rtnoL3zJ2VfCAhLZp84355gplP4nmFP/SPmCyefvDM+bk7ycaCkAPYaeEsrLVVt5eIotci7FY0a6A6k5IEYN1CZF7qR8Epdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbo4VEHzZPgBHbQ2s40Qwr2DR0uZcXGihY067x2itMc=;
 b=BIilvfX0PAi9TJ24n5he40elqujlNo/Zjbr64ZKf7A52A5/C48MzLyyU2MB35SL5uotg4LIUR9ae99O/qnZvOEEZlDRMkxjafC5fdShJak/CKqQnxhr/2V4XW65n7GlH8ZAYTztzZTYaVrqIiOaI95n3bfUKanQxCfHvDhL+YhaDfXRYQ+a9FtaRP/6BZHTnz1fNq+t0yOUTvxdjgLhh+Z4sz6BnWo4PGskO5gXgcoJLRUMgdWMgBClwozjyxU0TTpwCvNA0dPYaNnI5Y8cwwkkcthcx2sFmI4kSJCodPp7QuhRtpWBun7jKYPARzz3bhSiMYglGYBbvEJS4iUQHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbo4VEHzZPgBHbQ2s40Qwr2DR0uZcXGihY067x2itMc=;
 b=Dg3LHdL+7dAMWjm21wM9UaNhnI4PCQdS/ZhYzL+PEiyW/Gqpx8zRHHqCllrBy1qlYKHjRBrBC9/v1iilN2IlkwYzJLHe2YGAoFoxsfny6pVaDVZE1j+ufT8lIb2YjuodkLrkKJoT3re3GnMUZi3qB6BEY4SOZWvOiUfJdvp4LP90S6AXrZGZmVTCfomdOXoYeqSbRligmopaRbXyvf4OSBRJVKUnpMiDm1rWNGh/aAsmEyclhJ8229/81TT5SNIGt8k4yld/ecTEDAQmNFr8eClX13Iu3mjy0hs8n+z+5qW05ie4bP/iy/4+jFg9rz4v0RgXNpzwGQ7lP9wIr9W1Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 08:54:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 08:54:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 17:54:40 +0900
Message-Id: <DHLY21KWINJP.32YXNJEUXBE9T@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] gpu: nova-core: gsp: add NV_STATUS error code
 bindings
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-1-f3101093484e@nvidia.com>
 <fd010f7a-6d0d-4faf-bdea-23bac608f03e@nvidia.com>
In-Reply-To: <fd010f7a-6d0d-4faf-bdea-23bac608f03e@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 8938ae50-9053-47fa-3f23-08de93ba25f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: unWWzzjKBhx+LLWdLP2ixk+DWSA6zVvMgLn4izJ9Hy0addALFkpx29AwIsGmrVqeoImHe2dVOyGeJt2SgQllfqQr2yavqPz586YK1NYIHUQzPn7O/D3D3PSe4miHpLUDTb12iZuwHTvrKNuQDZR3/2QsHh9/bCSIlxlaFDN4r0jedGiqu9ccAdWit3Fw8+5NVHpJT8KnUlytM7Jd/TuCuRBnfE5LHvodrO1jDjyi9Yw4zy/bs+XB0SoXhZo0ZcC5jooWZG+1vfixSWFtWx6nMse2BVgi4cKI6vZfjSoGJznQnT+4TWFG4FO2VCy1W/5ODs0Wws2XMA5F9g0TUZUk4w3vXyopnwGxVSYcOzqmtAOt+mF8b8vNkVPFe8Kd2cUWN/jcz0C3c5pTyJFQTQfy14voh3NdsDbPh4tXDSnP32CrIpYTxN2Mzgzy8A08lDLoxFAi3+pVVTm3QTEfpxKozcawm6PT9wB0VeFzeFTfynbhUuCAQEIBknc+T0zRhW2omI0oYK7voGVyPVx7syhpMQqwsmm27fA6dk+x+NURUVc2rq2/4iwCcGue1FhPONu59s0tp86vgufLLY820DS6l8xyKHtPqboibpvfKUXZ3/7SydXkR8a/GfWrT/2LkqM4K4+U7i/YxtDmkuA3iW3GA8czLe60Hu40kFZFEtHbdwbZ42X3jvoH/P6lhWgUVegKxozS7nqOejmduXtWjEUrJSgCkcaNqqfsQbk1YnnxMXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmRJK1hFbzB5Qkx5N2ZZVWtTUmhxOXhBMllyZ0U1c083VUtKVHF2TVlRMmYx?=
 =?utf-8?B?WVVycU9taW1VaDNYUC80UkQrVksxaVJrUWlxVCtGem5GZitSVmRldWVVb0Rz?=
 =?utf-8?B?Rk5EeFRUT1B1bitRWm0wZXhWVXBHSXBiaUhJclJyYnc3R3VRbHIwdGYyYm1W?=
 =?utf-8?B?OHV4MHU4SUI3VWtxdUQya0lYclBiQVNpVzlLT1FIcDM3TjBDUHExbDUxOWVI?=
 =?utf-8?B?K3A1ZVhQUTNabFFBa1ExUjU1RnUzRDRwQ25KL3RISkV1S1h6Qk9abldzT0VP?=
 =?utf-8?B?Nkk4K2FyN0QvMTlaQzQxMkdMTmV3WXg2SStvTldNdjFoL0E0WW9LUE5EVFNU?=
 =?utf-8?B?eHNvT2kvUjN4L1lUbHdYV2M2ck45VVZoYWxoTXB4MGtNajYwM204enNUNVVI?=
 =?utf-8?B?akF5UTVEajdEV2tqbjJOQ3ErVjNseGxiVm5aZ0c1RXlPUnZnM1R4OTQzbmVI?=
 =?utf-8?B?enVDanIxSVh6czlJbW1UUnczT2ZMUVdnTmpTYktoSTM3T25SNVZMaDF1aDds?=
 =?utf-8?B?c2g1U3Vhc1ZhREdWRUw1QzRrOERHRVdmbVRjRlJMdWpudDMxZTZ6czk2WS9H?=
 =?utf-8?B?NlRia1ZobHlWblhlcnNodGxMYTE5SFpkelBnbHZaU0JrSGliZU5Hb3hsT0RT?=
 =?utf-8?B?VFhUaTgyeHRET3RISGJMLy9SZ3I2YS9vRUdSVjJSWHlTdnVyVzlVS3NraXpm?=
 =?utf-8?B?OTg1alYxSTB3Slc2bndiMDZOOUtHMWJ3N1B2cDVZTlBpMGZpMFI0VXNCUHY1?=
 =?utf-8?B?bDdlOHpKOFFLSEVwUGJZdWY2eDZsRDBvaGNvSDZXNE9YRW1KWUx6OGJIdEsw?=
 =?utf-8?B?QkRaNjN1VUpkeWY3MG5vRlZsODR1VWVRZHM2NkdYVnpNclU1T1ZYVGY5Zis2?=
 =?utf-8?B?cWFlL2xZQlZCRVJ6WXBoYUJ6dXluNVcxL3lDa0JFYUpLQkpqTVpvWUg4cldF?=
 =?utf-8?B?N0MzSUlUMjZnelNPUXZTNGlqSDczZ3E4SnlJZjEzTEFXWXBFSXdDQjg3b1JC?=
 =?utf-8?B?b1dlNGxYRFUwTGpaRlN6RXJrSFRITDU0VTcweXQ5T1VZQnE3K0QvR1oxZk9s?=
 =?utf-8?B?SHZDMFpCUnprV1JvTlowZDZqMHhaVlBPNmpiL253bjl4aDZCdVM4VnpoUy9H?=
 =?utf-8?B?NzVJTUYrZmF3TnB4YytoMWhTbDRKbUNoMFNFbVEwWkV1SzVRVHpDSGIrZDY5?=
 =?utf-8?B?bVVabEk4bDNTWnlQTU96UitYN2JwVnBmSlBCTUVRbmJhQThKSTliaXZEUnFn?=
 =?utf-8?B?MlVGYnhiN01IUmhhY0l1SyszZFpjRHhhQVpUZjFGbHNldXJhWWRuZ01IRDA5?=
 =?utf-8?B?OERCOVBsVDBnalFKV0RvanpJMjN2SVdSQ3AzREp1c0hZMkxuUkJrZEdoTlY3?=
 =?utf-8?B?MnJ3cWl1RU00Y0hvWFhLUjYvTVJxU1pWVWI1aGVJWDVMbjJtV3JyNWFGcHM3?=
 =?utf-8?B?MEVYZ2RqSzJGRnAxbGFnNXdmeHZ3aFBLTkhIUWhER1o0aCtIZDBtWENDYUtq?=
 =?utf-8?B?RXI1UzZFYjdldGdrSEhTNzFqdFRGOHl0TFBpakFTQURZcGRSUDFLb0hiS1Qv?=
 =?utf-8?B?UDNNNlU0ckNROUExZGNtM1RPQkd4YWRYd2F0Y3YvRjk2RHl4WGhBck5hUUNO?=
 =?utf-8?B?K1BUOXc1VmY2RzRnWDA5S0lKVkFobklmRXUzZ2JMejBtNTBoWFBxRjJDSXJM?=
 =?utf-8?B?NU02eXBnc0lHeEdoSTU0T296dGtjQ2RhNUNrbDk3Q284YmtyVENzTkxQZjVH?=
 =?utf-8?B?cjNSZVNPcWt1bmRLODdDcDJDbHYrRzQrTWtoTzZRWG82VmZjdVlnbDNPY21E?=
 =?utf-8?B?TGd4Z3ljczNzaFFBUW5QWmw3Nit0Y3hGNm02TkM3clMwWEdYNXlYUmh1VHhh?=
 =?utf-8?B?OW9KREpiU0dlZU9VVWdnRjhwWkx3QkE3VkUvamEzSkY2eUhvallWVy9NdWdv?=
 =?utf-8?B?SnVFNzBIWGpnMXRseVdZbDQwUVgzenlydVA1cUZJclUxZUpmejVFQ2tPRmNk?=
 =?utf-8?B?ZytaaVpHTnhUTVF4Slo0TGoybWZVMG50anZuQWtzYTVKZDVIZG53MnZXSEFv?=
 =?utf-8?B?YzBsTWdTeDhOa1lrOGhESEQ0eGg3d25wdUxUYkJ5N2tNcWdSa2tERDNuSy8z?=
 =?utf-8?B?NXhSTlVTQ1crSWRSb1JVK0FJVGtqNVlyNGkxWW1XdG5UUXl1VWRLb0Vvc0gz?=
 =?utf-8?B?T1U0TmZFd2cwVHorY0gwUzNXa0NUd1pmSy9xc2xxVi9TdXBwSmN3VEtxNFV3?=
 =?utf-8?B?cjE0TWtBRHdWN1pmcEcxSk02WGhRYXZBNHNBMHd6S3UxZkIreS9NNktGeFUy?=
 =?utf-8?B?TmF4Q2luSjJkMGZvaEwvWTlvTEtGNXBMWUFIZ1NyamVrYU12YkdJd0NIQzFn?=
 =?utf-8?Q?ILU/oJlfpRiPVTubSTi1Ee5YhuwlJpZpS6V/17/6McuCl?=
X-MS-Exchange-AntiSpam-MessageData-1: 6vUmj04fu53UKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8938ae50-9053-47fa-3f23-08de93ba25f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 08:54:44.9586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi0gr1r1lEYJvgRVi8/diDTTirA+HwrMVHdbS41V4tkgWkgWA0grxqUdpXJ4GjBmSF/E6UJJtRdzSN4xhzIfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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

On Mon Apr 6, 2026 at 4:55 AM JST, John Hubbard wrote:
> On 3/25/26 5:13 AM, Eliot Courtney wrote:
>> Add bindgen generated constants for NV_STATUS. This is used for RM
>> control messages.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>   drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 144 ++++++++++++++=
++++++++
>>   1 file changed, 144 insertions(+)
>>=20
>> diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers=
/gpu/nova-core/gsp/fw/r570_144/bindings.rs
>> index 334e8be5fde8..dd37a7fd58c6 100644
>> --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
>> @@ -379,6 +379,150 @@ pub struct NV2080_CTRL_CMD_FB_GET_FB_REGION_INFO_P=
ARAMS {
>>       pub __bindgen_padding_0: [u8; 4usize],
>>       pub fbRegion: [NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO; 16=
usize],
>>   }
>> +pub const NV_OK: _bindgen_ty_4 =3D 0;
>> +pub const NV_ERR_GENERIC: _bindgen_ty_4 =3D 65535;
> ...
>> +pub const NV_ERR_RESOURCE_RETIREMENT_ERROR: _bindgen_ty_4 =3D 134;
>> +pub const NV_WARN_HOT_SWITCH: _bindgen_ty_4 =3D 65537;
>> +pub const NV_WARN_INCORRECT_PERFMON_DATA: _bindgen_ty_4 =3D 65538;
>
> If we go with pulling these ERR_ and WARN_ items in directly
> from GSP-RM, then we should also update Alistair's bindgen
> helper, or my fork of it:
>
>      https://github.com/apopple-nvidia/nova-gsp-binding-generator/commits=
/main/
>      https://github.com/johnhubbard/nova-gsp-binding-generator/commits/ma=
in

Yep, I have local changes to these which I will send. These bindings
updates were all generated based on Alistair's bindgen helper.

> However, the deeper problem is that the C headers define these as
> #defines, so bindgen emits pub const u32 items. The hand-written
> NvStatus enum in patch 2 has no compile-time relationship to them. When
> Open RM adds a new code, the Rust enum silently absorbs it into
> Unknown(u32) -> Err(EIO) with no compiler diagnostic.

Yes, this is unfortunate, although we still need to manually think about
the mapping at some point.

One thing I can try is to remove the Unknown(u32) variant here and use
TryFrom (which we will end up using with FromPrimitive later) - then
at least we will get errors if a new discriminant is added.

>
> Which brings us back to a feature that Alex Courbot and Danilo have been
> asking for, and I've been treating as "nice to have, maybe next month"
> for apparently too long. And that is, generating Rust bindings directly
> from the GSP-RM build system.

Sounds good to me as long as we can generate this mapping at the same
time and have it fail if a new one is added.

> I think it's time, yes?

What would this look like / any agreement on what the shape of this
would look like yet?=20

>
>> +pub const NV_WARN_MISMATCHED_SLAVE: _bindgen_ty_4 =3D 65539;
>> +pub const NV_WARN_MISMATCHED_TARGET: _bindgen_ty_4 =3D 65540;
>> +pub const NV_WARN_MORE_PROCESSING_REQUIRED: _bindgen_ty_4 =3D 65541;
>> +pub const NV_WARN_NOTHING_TO_DO: _bindgen_ty_4 =3D 65542;
>> +pub const NV_WARN_NULL_OBJECT: _bindgen_ty_4 =3D 65543;
>> +pub const NV_WARN_OUT_OF_RANGE: _bindgen_ty_4 =3D 65544;
>> +pub type _bindgen_ty_4 =3D ffi::c_uint;
>>   #[repr(C)]
>>   #[derive(Debug, Copy, Clone, MaybeZeroable)]
>>   pub struct NV2080_CTRL_GPU_GET_GID_INFO_PARAMS {
>>=20
>
> thanks,

