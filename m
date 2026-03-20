Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FF61099B37
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A609D10EBF3;
	Fri, 20 Mar 2026 19:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TyICkKeC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F110510EBF3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 19:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlEP3vG8U5B9LtagJt3NFaY+Z4++eF6l3czB4G3fNmeAuhx28V+bmLb12/ogJ69X3XG5+OS2Y3ewq7auJyQCvCdRse5Q5Tump6OPQZdKadFtBGtPskDsDOrjiXb6UcWg6fYmS2ls5kV8GiPJS6DgOvQWNa3qIy5kFK5aQcKWzw5OkOn4PnVugyf7jC2TwiNYPJqw+B9jvm2jgwvT1zCQYWkoNmpaFC2oO0GCKrlJWF3TjnQOACwjtK4j+3QX+REND1Su7GUNS79GY2KJTFRyv9mm4UfrR8yyt6BWdxmEpthCUEj8K+11n3WNnjYWov5HAKOOqwJ5ZjB3InpcK36PBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgAycT+NP6XkjiM4QC0no7fRB7jXUuRI5hVb2LoIEHg=;
 b=pvByIfSBpw8FkE0M2jhfNKQa6orT4usKISMQcHO9/5tE+B2qR0fDBshM/SH4dg5tLAYhJH5bPkH7BnTea2F0EE2IEO+RJKM8U3g70EfjGs6bQ7Zf8eXT+MWXIe+lRnGaCEHEY0rGXZCqkyPHbkaZc3edObR3ZI7pDwb+nmyxE5QEQHEoN4GGF1YGhcYCN4RRVFJi0Lw4Z61RxKo5DwYj7lwWx+nE9Yd7HJ8XO0gw25iWydebtnuGq3ir+XaEzlc6FL2/bBYURs5Cewvcish/pCTWC9kKrnhiYnolQEDumh8rwxh2NRiROr3/fpfHZw6QPDZ929OSzxmwMXT4Qg1OYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgAycT+NP6XkjiM4QC0no7fRB7jXUuRI5hVb2LoIEHg=;
 b=TyICkKeCAmlg+jhmdXslmfX7w8nBKw6asxZh3jzUW7vafi5ZFH9k5NUCGL3EISnpieFrffflb4Jji+4Jv3UXfKabFg60OOy0o/T167SBcTEKFPNnCbSgYfYJtgyztvObJQK8XJ0Wmk1yDc7LxtbW3fFS5Puju9h4/CE7AJ6bKWVKm3e0wlRTLU6T2FQhaJyYzJO5e8VMrGmHHDCODtp086ATxz+3fV1w69ANOuxbRAAc8b/AwkmeMoV5ZNouwUl49XfBu9bxGlXTM4ZzbqKjaxJnCzSGu58x5of46CU1IDbzSQlN05mv3VRV8Lj0+4W/OqBYX1JeJvSIU1Xn1C/TAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 19:52:43 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 19:52:43 +0000
Message-ID: <ba3c5689-5e34-4097-8823-c37a48a4f358@nvidia.com>
Date: Fri, 20 Mar 2026 12:52:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
To: Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-8-88fcf103e8d4@nvidia.com>
 <8f9da1e2-fb86-4653-b702-333fc920af58@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8f9da1e2-fb86-4653-b702-333fc920af58@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 95100954-680a-47bb-3eed-08de86ba400b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: BM28NfGgO2YUzCqn7Dh1fID3yk8RlOoWj0NNj1/a7HugfD9Kc7Fgre0E8cD47tAK3v5hy/Li2+BKcnEs0uQrkosiVlVAufPBTU8j+D05YP1bmqsKAo0vvfC3pSzxPVpfCn8O3GKkVOfBuUO82oqTah2RqcOh5nzzbL3oiGiqS0uE1+fu6fRmN1/ifMBKVXcyMmVEf8X6RvlwTjSOl2y9CbgsepRlW8PoTwUEBCuGyDHaqAlPvfCbM7kHjfTR7ksi4KglXfdz3NTi90uK6p08GU3JmBgcAg5kLOZRSxYQgR3t8v0WbUXoJan5gO/B/Jxrkrh4G4zzhTaf6RaqBqNS8jzrA7YZobPmPngbHvIPTd761EFdVWhfqKVHEQm4oCVs6t1noja6TtgGiSreqsWvIkw851U8AnBwAqG21vYVDYfGQ2HhP+QnEG79NvFyJkwraCb7uguPQAHiIqmGWwTvrmEux/9hIrWtEnzSomWx6xPsW4M78X8GPwinA35mVEhQYzB18RJjgTKSM9qaHhn4tJbfP4R6f76viQIlIuPQqt+nhEuql603xUX4p1k3UICOf4vVIpAfb2hnF8JeukknQuauynaNanKunahb3nuBC/4Jzz1duxzrV9dS+1Amt6I48mH8t0zTtGs1rsAZuck74TJpPFNry9VGjyE/K/YkmWWQI1dpPyWUf1xnYJr3oJX/NOkP9eDje4PZ5DTqx7YW3EKN1dELH8A5I0BdgcmnE0qoCBmh443bUew1Nz/PmMXgCZI0kLHDBll3ZMdVhkneCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xCWDZCK0JjMFFjQ2R0LzBrS1pDOWdhL2R3N2JlalhmM2gvYTkxNzdLSzEv?=
 =?utf-8?B?UEM3QlE4N2ZhZmtBUTZrcG1sWVQ1OGJXNktwZk5TdVBheFFXRW5NbE9tOWU0?=
 =?utf-8?B?RHl3ZWhjcll4QVFHMmZ3NnZlSVcydmNadU9DS09UcGpaclVEdk14Qkx1dnRt?=
 =?utf-8?B?Q2cxT042bEJDbEp4blBPY09iNERWdTZBOWJkV1VGcEpqYmUwREF2bTgxYlYw?=
 =?utf-8?B?YjJtSk1WRkhZYW1QY2luTDVyTkM3KytUTWFPcnFGU1ZHcFZEYmpualRaU0x4?=
 =?utf-8?B?UFBJaTJlUzgyNmVacTdybmZHbzZuaFpQenRKR1U0OUU2cnFPbXc3VFprV1Jh?=
 =?utf-8?B?WEVVM1J1WUlRNThOUk8xUjhrK1JKNnFlSEN6LzhnSkEvOFdqMTd6RDN6QUZn?=
 =?utf-8?B?S2t1R2VQWExwcVRTV0dDcmNJV1VoSk9JWVBQcFE0TUZnaVNlTzVNQVlWRS8w?=
 =?utf-8?B?ZSt4UnMwQXIxOFMzOXY4c3NTRVdTWVFuWGNJMTc0ck96S0VoTHlueVNPd3ZT?=
 =?utf-8?B?T0hUVEs1eHZNWFJWTnlmZFNXT1NBOWhBNkNNNWRBVWhGZ09tci91UmE3QzFQ?=
 =?utf-8?B?eWZUazNyU0xucU5EakFQUFF1TVl4L1FuVjdsSTFia3JDNlRxN0p1aFByVU9Q?=
 =?utf-8?B?S1JkMCtrcXZXSy9sMExWSlpqQXQ3U2c1YTBzTWZxR25Na0g0RjBEbmZhbktn?=
 =?utf-8?B?ZGFYM0lvSG9JTlRGU1VpWlNnRTQrZDBqbk9BNVVyVHVtY3Q0aUxOYVovT284?=
 =?utf-8?B?Z0QzMUtRSkNSc3dzOWNoL2M0bWhVK3ZQU2NzNTVBY0QvR1dHc2gwTWJrQmp4?=
 =?utf-8?B?SEs5MTlMS2NzRzdFekVwT29KcjFuZlVMZjBTMTdhTnNNV2M3NVlrNDVNQ0xS?=
 =?utf-8?B?cEZFOERrSS9ZQlQzRThONERMaEFGUHNMTzdOSUR5d0lwN3g0eHBmbkxRVWhQ?=
 =?utf-8?B?Q0dVMnh5K1M5d2dGNW1HTVZIbUl0TjlCM3BrUllmc2NNZFd1bDBiVThBUWdT?=
 =?utf-8?B?aE95TnNJQ2VVb1ZIM0NYNDRDMFRmYmNJT3JwUC9FaFlmS1huVTNRTXYxcE9I?=
 =?utf-8?B?WmlaOVRJczlJV2xLa3NkdTFacVVhd0hlMlZnRXIyMDd1RnNSUlUwMHNMa2ta?=
 =?utf-8?B?NlpNY2ZtOVVQaVh3SE45T0VMK2wrSmtGRnlMQkFpVXRON2ZwVmpxNmxrZGly?=
 =?utf-8?B?UnhzZXVUdTRxTmpndERrNlVwZ3ZpSEtybUVGVTU3OWRZcGYxWkpPWTZ2UHlV?=
 =?utf-8?B?anFwc1BET0pnQmxzOHp2UW1NNVV6cGd5eHRRcnFndVRjcU44aVNDVHhFQ3hp?=
 =?utf-8?B?bEhzMUV3Ui9TREErUFQ2aU5lQUcvb3ZwcEprV0VGNDZDMWFmczdTNHBpbEF6?=
 =?utf-8?B?T1JYdVdEZHNVaVhpSkdHR3VUdHJQeWdHSXVScnV1R0ZtelNkVzNuZndzTFVG?=
 =?utf-8?B?VUs1UTVXKzlJQWxadXdIejA1Z0JnNDgvMENmZUdrdStEVzQzTkFoNEJ5QllW?=
 =?utf-8?B?MXlZTWFEeDc3Y1lOaGdtQ0Q1VzhkR2MyVHZ4c2ptQVhTTnVkcXhyM1dRUXpt?=
 =?utf-8?B?SnpxVDkycWZ4R1FRQTZKK2ZKcTUzNkowYktSY05XNXVKM3lZK1d2emtCRHJR?=
 =?utf-8?B?SHdHTE5IMktyb2RIV1ZFc3ZaQmprN0VGTk0vMmJ0M2dsRGlnendlSzVJZ3Mz?=
 =?utf-8?B?TWxPV3dLZE1ScmJiWEdRRFREQXNxWkV1aEI4ODMrQWY2NTBmMEl5NFpSNzVP?=
 =?utf-8?B?SElrelRVaDIvTHZSa1dHaGhCZC9qbTNxL3VUSnJaV3d4ZWNETVpwci9RRmVa?=
 =?utf-8?B?cU00QzEyYnFWRFJkeSsvQ29XdDduYmEwS3JtVXBhb2U1Z1c0RWl6R2toRkFz?=
 =?utf-8?B?Z041ZnpvbmJPV2U4NHI0TWRMNTVxSEVRS2xLdmdnTWlPcm0ycWw0anN5ZTR6?=
 =?utf-8?B?MUpXWVM3cXJSMlpqaUNpRWJ2QUhuRWtvaUNGMmZncHBMWkZSSHdzSndTek9T?=
 =?utf-8?B?N0w3ek8yNEQydDdNQnh0d2hhenhrbitFUkJMSXI0UU9FenA2SU9TeEh4Z1Bm?=
 =?utf-8?B?RTZac0htZk8wc0xZeVFNR1RRK3cyZER0UUd3VjdYQnQ5c1FzTWtuTE9RZ1hu?=
 =?utf-8?B?VGdVeFRZM0Q1bkdRUm5KWi95K2xka2xUS3FLdVNVcmw1aE5UM2dYUXJVSHJ3?=
 =?utf-8?B?WGp0MzdkTnNXTU1RdEp5OUhSaFlySUxEOXlIcVFINXo5K1FYd3F0UlNRQzgz?=
 =?utf-8?B?b2hWUFpkM1QrdGdYeUdhZkQ4eXZEdlEwRHZVYW9NMnhqREE0dWpid2lWb21V?=
 =?utf-8?B?VDVOSjVySEFmc3ZhK0xyNTA5M0tBYmxkM0JuYWpYNXlxY21jU2w5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95100954-680a-47bb-3eed-08de86ba400b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 19:52:43.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlh+Xw+BHsimM3G92MPC8EKPWKH2MR4nVcO6zOQPgrxoprhiEIIUFCixPgrWgU8PUaCQfGpEEPWN/ARtbBCEpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
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

On 3/20/26 10:38 AM, Joel Fernandes wrote:
> Hi Alex,
> 
> On 3/20/2026 8:19 AM, Alexandre Courbot wrote:
>>      /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
>> @@ -616,9 +462,10 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>>          self.hal.select_core(self, bar)?;
>>          self.hal.reset_wait_mem_scrubbing(bar)?;
>>  
>> -        regs::NV_PFALCON_FALCON_RM::default()
>> -            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
>> -            .write(bar, &E::ID);
>> +        bar.write(
>> +            WithBase::of::<E>(),
>> +            regs::NV_PFALCON_FALCON_RM::from(bar.read(regs::NV_PMC_BOOT_0).into_raw()),
>> +        );
>>  
> 
> Overall, I think the series is good improvement but I still feel this part is a
> step back in readability, and we should come up with something better. I don't
> think there's any chance anyone can memorize this syntax.

I must reluctantly (because I know this conversation has gone very
long, across so many versions) agree. That .write() statement is just
brutal, and we will be relying on AI in order to even figure it out,
I fear.

I'd hoped that there were other, simpler forms to express this,
is that not the case here?

thanks,
-- 
John Hubbard

> 
> What about using a macro to hide the boilerplate?

