Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CBEC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F56810EF95;
	Thu, 23 Jul 2026 06:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LydzzaEg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEFE10EF95;
 Thu, 23 Jul 2026 06:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz9GGkzknjpO93EzwhJ5Dr/BW3mAbPPNnhUBHIyAhtXV6NzvXqtrq9gU+/vWs08/tP63PJYOuWB5Y4CSj0WqSr4g6UCLUv1K6PJlVdF+l+pXke9V4WYOnpQSIBSlt4lUyhxf3WhN3gSjFxJhakPujzl7Y6LHGhZqir4RKar7ExzLFlSOt8OjEBAjym6bWqNeAPz/HPGTWdDWkh1kLxonPET6lvLp62LfUvFdNdYth0EXoamUsbzd9NZdkPpQoj+YBUizGO4/7JGUQgmY+DjINlESgMUmHvltM5wgzBBMb773f2uiBk5fxIPmtOzzvq4/BCvIT7VAqh0CbFGhQuwzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwDQkFgnl16nRc7wiR4Ls4ScXDKhBmW5R03Tvulk/XQ=;
 b=WTpFqxBU+E/8T81H01qEl+eiO3uzPU7jWZkTFjBDgk4/p/NpShEKmsWlLvN9LQ2VCeXrwkwYzxlzfYwRI63/B2++AVeZl+M+Mp6pBgq7GxMkComIZjytU27d1SbHRjuKOApWh2zFZ2ikkxiS6Yi302bEjZiTySiwlJQdvuRDwKW3W9ij7FcRJ1IHw7kHSLM/qyK8vGBNPnKQvFJGM0a1iVpKUUA3j28Kqml0yEJA0GYUHV8FiGrT1UwlagLviyynodsgD0c+oFQdJU9CsRPQuKJk6YKNVuBBeeO0Nj0qukCXoL00X9T3BQt7cZJrAEriqMGi+TMCd7odH+gmXtJj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwDQkFgnl16nRc7wiR4Ls4ScXDKhBmW5R03Tvulk/XQ=;
 b=LydzzaEgiMGL13NmS8WmC9GGIXlMx9J0HhMzc8Tmn/ziwofz2Gti0VtL4RaZFKQSQCfrtvzrHeh9VTI3eoDwm7IdxyzFB1pig3x41N125U+WTdpH/6dC1Ngq2c+z9RmsECedgQbZcceMekpx8skxPMeGyBSW76Xtat+BpztYaM5b0DPSto70J0BUekIWfm4Tu/xYz36vf3y8HfhG4Boagwl0rkgEGQBIyzyW9lAn9BB9zCpEtp3pk7wHFmlnoQqU0enURVRe94xt7akkIVjAmmarl5Gg1zgMcL+EjtHBXcqhqft86OZKLqcRYNy0rQfdPIFZMwzAtDlJH6+E1zwlfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:34:25 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 06:34:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 15:34:19 +0900
Message-Id: <DK5QPF7HKME7.3D1CKLL5V2Y66@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 05/10] gpu: nova-core: split FbLayout into FSP and
 non-FSP versions
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-5-8e3d8bc32bb9@nvidia.com>
 <DK5OQWB04ZRE.1AHZZ9O7MPA75@nvidia.com>
In-Reply-To: <DK5OQWB04ZRE.1AHZZ9O7MPA75@nvidia.com>
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 683b1bef-9a88-4af4-35ab-08dee8846f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|3023799007|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G76blGPIMLZ75Cam8UwjKeUZM/pX1uy+KUr+kUQApnS+tNk9o2YnNa7jRBy57oPCKikkCd3x0Nt/ufcVUysKySZueaZkJlxy1I2Rv2EuC/9XsftJq5303oAjbpv6eOzVVD8eMTNa5yay/Ut8+DffxgIGoumhkNdOIy8FVjlaXiNJ1yAFn8DtDKn33A4B/TeYQhDrJ0o4kMXzU3UxG4s9H1QbfiKzXbHVUyOVEcDc3Ng/iVS0rzeYoZz6r0UVknabroGIuE6i4IP+OHX65QWBHPFl4vj+DUucjn5Basc6RF3Tn2qzRU755XbVaXvfK8XD+oCfzuD+ePB5r8K481qCksxUJe9MWMcMcib4Dd9cCLMJq3NiBk50NuZ3XVB3PQJeeQFGD8lKVq7Sy3w2teeaFl2tpDMtqiRYBLTrszd0qkVXFiiCrLFt+7jJw3VMeNhSvD2nsmmpmb6BCwN9+s/KGCFvOLI+/vT+JFJiTBn51lcEAicTCHAgYruPgRIclr5XS3RXSOellz0Qn8BbKDmbiRLOzGgQNeAj5Q559/fCZ40eH0SXiSfC5vclDPLKERoxdm+2ov566T2oRhKKCA6bz3ZR0szey2CznHk3yGUWXEdHpAise/2Mzs8IiG8zZD0/mFfzKrTTLJTcRwhL8Gz8vn9r4Zznoo4DySOpXYJIZVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(3023799007)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1F1TCtoSnk0VUJiN0tPcnBDcVhKV0RsVWI3NVkyckpWaDhxUHMzU2ZVYjVU?=
 =?utf-8?B?aXdmUS9aanBIWEhEaU83ZE9jWHpzNkJpU1FGVVpKaVJsWHJkZEhFUHBEYTI4?=
 =?utf-8?B?VkJYTmJGaDdtQTErV3llYm4veUMvQnIyNFoySEZDc1BiK1VQMEp3bGgrR29w?=
 =?utf-8?B?MUF2aTRqTnZtMDJEaXppbC8zWWFVc24wZGxMZlptQkVIa3cyc3VlRCtOa0tZ?=
 =?utf-8?B?NFdQdEFzdERGLzhNcVM1TlF0WFlNa3N0VmJIQkttcEJFbG1KY0ZYT09yMU9i?=
 =?utf-8?B?U3hHbmlJaWplcVJtdUdJdGZnbXFWZk9ldWFkQzJSS3hRR3BiZm5NQStrL09N?=
 =?utf-8?B?VEl3QlY2YUhDNWxNUklXK21pNVNRME9YbFhyQkl2U2Exa3AvWDRQRDVXVGtv?=
 =?utf-8?B?bXl5c1hoZTVtUWtWQjViN0x4S2puZUgrK1k0aW9iWVh6UlluNzZvazFKSTV0?=
 =?utf-8?B?MnRsckw5SU9zZktpVVZtWWk4VHJXbzl0QW9Jb1J0SG9GS2RGd0JwQ2NUZ01H?=
 =?utf-8?B?QXpsWGZCNVdqV0JKK2FJb3JCdk5QMjdTTHQwTW5lV1d6N1B1SnNOOGVyK255?=
 =?utf-8?B?bEZxaDU4V3ZtN2EzSS92YUIvWU1CcXJ0SnhuSEt6WXNjVWFzS1E5dCs4R1dS?=
 =?utf-8?B?QjNlOHlza2JSOVIyWVUzUTNUWTBZQ2crdktlZUhsZEtSOWE5RHZ1UVVxbUw1?=
 =?utf-8?B?YjQ2OFE5S0VTQVY1QUtZK2pzMkw3dEFvMEVGRGg5eG8xTzNHYjE3MjJYZjNs?=
 =?utf-8?B?d0FYdlhMTTBvOW96K3J2NE5DZ01jQmJaT0x3NHQyUHNrNmwzQTA2UWJidmZs?=
 =?utf-8?B?c29WS1RWcXY1SzFjdUJEQkF6K2x1dkVNOG9kbFJraWtSWGNXbXdtdFdVVnZt?=
 =?utf-8?B?U2FiU2xiVExhRE5oTm9hVW5na0lpWkhzeUcrSkdObkVKUGJzdkdHK3dQRkVY?=
 =?utf-8?B?dTY5NTl5LzVpOVZsSGRzMjlBY0dMRVplbmZ4YnFmVGNpR0FFRWwxUUNRYlFY?=
 =?utf-8?B?YmtpL01XOTFkREJtWEF1UXd4bU45a3oxYlVMSUt1RENPZFJFaUcwZjU2V3lW?=
 =?utf-8?B?N0dVUmoyZHhMc2FnZklJaGF5WmxFWW5RY2VacW1YY2ZTekJHQk1oQkM5b0tE?=
 =?utf-8?B?R2ZPS0VGOThBOEpObmZXZVFNbUgybHhuQTFEK1phamkrSUNZa09QclcxVExi?=
 =?utf-8?B?NGZaRDNTdndxaE1WQTdZR1pKOEtRTXhGTWZYOThnS3VKeW9ZbUR5MzFVNkM3?=
 =?utf-8?B?akIxakhZVHhqNU8xaTFhbE44YTlOU3FqZzYySWhOZk8rSHJ6UUphS243QXlV?=
 =?utf-8?B?NE1rTDZkTDhHeHJ1MDV1RVJNY2RvQUtFTUdnWko1TXFsTW5IY0RFM2VsaXdu?=
 =?utf-8?B?TTJzcHp0ZzhCVG5Eb3dYVkpDSUFJWmlXNTR2dUcrdjlHRER0a0lkR2o2SkM0?=
 =?utf-8?B?cmxkbjhYZFMvUWNRS0VNeENIYkxGb01GV3h0ZnIxY2xwK1hSSmJRRHcvakxz?=
 =?utf-8?B?a0tITGxUMjlmRUNaN1JaWU5RUWFGTEhzQ2RVbzZQeDdMTlJFQVRwaE4ycXcx?=
 =?utf-8?B?bVBjdGs0MVJZcGZDVmVQeWlnZGR5TEUzM1dhZDR4OVlVS0JPQ2xEOXQxOUx6?=
 =?utf-8?B?cStIb3B6cnpDbTFTcEVqWGhJelFyUTFWeUczazduVTdmRndJTzBBSHh0QjZW?=
 =?utf-8?B?eHFVSU5QbHFTY0dsTzJhdmFXNFRtZmJLV3cvVjFldnZHeHkrendjV1lvVS8z?=
 =?utf-8?B?UWIvc1lzUWMrZHV4MVROYUZzTTZCemJmSWdIVDNPVTMxNkxINld1bCt1clgv?=
 =?utf-8?B?aXFWTWJkQlJHQUtnZlFseDRaZHhHSFZ6QmFKNHMyaVhUR2wrZytpR0cxOFJL?=
 =?utf-8?B?UTllV1pNSjBpbmtQTnVOaUJpbENLM2lTRWNJSjlLakpvclRQUzlnUlE4TlUz?=
 =?utf-8?B?K3FzM2dEWEI2MjlPanlMM0ZkemFvdTdSK25BSEI5Rlh2ekpyZ0xXUUJndlZF?=
 =?utf-8?B?ZGYvd1hyajE3TnB6WkQ1Q1VZWmVZM1dwVVRDTmlEU1F6d1VZZTR4VU0xK0J3?=
 =?utf-8?B?YkwvS0JLaFdodWNxdi94UERkUDhaMG0vZ3hQemxWS0dJcUhrR0tJQzdTem1n?=
 =?utf-8?B?UzE2WDJWbExaUVNvZFQvRkZOaTgyVHVKNHkyanU3Yll2M21PR2pOR2RhVitp?=
 =?utf-8?B?VmRBNFZrOWh3MXhVWFc2dFhNdkgyeVpobnFhZW9RWXplVGZxR0VzWFNaYWZG?=
 =?utf-8?B?MXVtSUYvM0ZsSWhTZUpIdnNCdnhVZENxOXRrRFVCYUxpaHZVd3NJR0QxVU5P?=
 =?utf-8?B?d0w3bW1La1diUmNSV3pVVW5zSGs1eVFKeGJqNEhqb0xubm5RUkZ3TzQyaUUv?=
 =?utf-8?Q?+S/o+bJEWAxQTURnESDKin1OghnwamlQsKUHrVqF4vSMs?=
X-MS-Exchange-AntiSpam-MessageData-1: lzW/S29pQt3z2A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683b1bef-9a88-4af4-35ab-08dee8846f25
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:34:24.6573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGfrnnCWrPwk2fsjvLbamINj8qPpq3ogr2ZdC53iUFWgTslwaiJ4a6pGlctsEtdGXLOS/FQBDO4m2GnRJi4Egg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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

On Thu Jul 23, 2026 at 2:02 PM JST, Alexandre Courbot wrote:
> On Fri Jul 3, 2026 at 7:22 PM JST, Eliot Courtney wrote:
>> `FbLayout` is currently used for both pre and post FSP architectures. It
>> contains ranges for each region of framebuffer, but on post FSP
>> architectures, only the size is actually used by GSP. The offsets are
>> not decided by the driver. So, for post FSP architectures `FbLayout`
>> contains essentially guesses for the offsets. Instead, make separate
>> types so that we only store the information that's actually needed,
>> rather than keeping around offsets that may not be correct.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> These patches (5-8) are the only one remaining from the series, which is
> not entirely a coincidence since they are kind of a different series by
> themselves. :)
>
> The patch's premise looks correct to me; although I wonder if we
> couldn't avoid the enum by making the FB layout information more local.
> Its use in `boot.rs` is what makes it difficult.
>
> Ordering nit: this patch introduces an architectural change, following
> by smaller fixes (at least for patches 7-8). If the fixes had come
> first, they could have been merged first and the larger change would
> operate on a better base. This is not a request to reorder if doing so
> is not easy; just a note for future series.

The reason I used this order is that the next patch introduces
`fb_end_reserved_size` (which is needed to actually calculate the right
values) but it's only used on FbSizes (since it's FSP only). Doing the
reverse order would mean adding a new field that is only sometimes used
to the existing `FbLayout`. The other two patches after this could have
gone before this so that's fair enough.

>
> Some more comments inline.
>
>> ---
>>  drivers/gpu/nova-core/fb.rs            | 70 ++++++++++++++++++++++---
>>  drivers/gpu/nova-core/fsp.rs           | 15 +++---
>>  drivers/gpu/nova-core/gsp/boot.rs      | 26 +++++-----
>>  drivers/gpu/nova-core/gsp/fw.rs        | 95 ++++++++++++++++++++++++++-=
-------
>>  drivers/gpu/nova-core/gsp/hal.rs       |  4 +-
>>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 10 ++--
>>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 24 +++++----
>>  7 files changed, 178 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
>> index 273cff752fae..fd60f93258a9 100644
>> --- a/drivers/gpu/nova-core/fb.rs
>> +++ b/drivers/gpu/nova-core/fb.rs
>> @@ -144,11 +144,30 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::=
Result {
>>      }
>>  }
>> =20
>> -/// Layout of the GPU framebuffer memory.
>> -///
>> -/// Contains ranges of GPU memory reserved for a given purpose during t=
he GSP boot process.
>> +/// Framebuffer information required for GSP boot.
>>  #[derive(Debug)]
>> -pub(crate) struct FbLayout {
>> +pub(crate) enum GspFbInfo {
>> +    /// Concrete framebuffer ranges for host computed framebuffer layou=
t.
>> +    Ranges(FbRanges),
>> +    /// Sizes of framebuffer ranges for GSP-FMC computed ranges.
>> +    Sizes(FbSizes),
>> +}
>> +
>> +impl GspFbInfo {
>> +    /// Computes the framebuffer region information required for boot.
>> +    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirm=
ware) -> Result<Self> {
>> +        match chipset.gsp_boot_method() {
>> +            gsp::GspBootMethod::Fsp =3D> FbSizes::new(chipset, bar).map=
(Self::Sizes),
>> +            gsp::GspBootMethod::Sec2 { .. } =3D> {
>> +                FbRanges::new(chipset, bar, gsp_fw).map(Self::Ranges)
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +/// Framebuffer ranges needed for GSP boot process.
>> +#[derive(Debug)]
>> +pub(crate) struct FbRanges {
>>      /// Range of the framebuffer. Starts at `0`.
>>      pub(crate) fb: FbRange,
>>      /// VGA workspace, small area of reserved memory at the end of the =
framebuffer.
>> @@ -163,15 +182,17 @@ pub(crate) struct FbLayout {
>>      pub(crate) wpr2_heap: FbRange,
>>      /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
>>      pub(crate) wpr2: FbRange,
>> +    /// Non-WPR heap, located just below WPR2.
>>      pub(crate) heap: FbRange,
>> +    /// Number of VF partitions.
>>      pub(crate) vf_partition_count: u8,
>>      /// PMU reserved memory size, in bytes.
>>      pub(crate) pmu_reserved_size: u32,
>>  }
>> =20
>> -impl FbLayout {
>> -    /// Computes the FB layout for `chipset` required to run the `gsp_f=
w` GSP firmware.
>> -    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirm=
ware) -> Result<Self> {
>> +impl FbRanges {
>> +    /// Computes concrete framebuffer ranges required on non-FSP bootin=
g architectures.
>> +    fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Re=
sult<Self> {
>>          let hal =3D hal::fb_hal(chipset);
>> =20
>>          let fb =3D {
>> @@ -270,3 +291,38 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, =
gsp_fw: &GspFirmware) -> Resu
>>          })
>>      }
>>  }
>> +
>> +/// Framebuffer region sizes needed for GSP-FMC boot.
>> +#[derive(Debug)]
>> +pub(crate) struct FbSizes {
>> +    /// VGA workspace size, in bytes.
>> +    pub(crate) vga_workspace_size: u64,
>> +    /// FRTS size, in bytes.
>> +    pub(crate) frts_size: u64,
>> +    /// WPR2 heap size, in bytes.
>> +    pub(crate) wpr2_heap_size: u64,
>> +    /// Non-WPR heap size, in bytes.
>> +    pub(crate) heap_size: u64,
>> +    /// PMU reserved memory size, in bytes.
>> +    pub(crate) pmu_reserved_size: u32,
>> +    /// Number of VF partitions.
>> +    pub(crate) vf_partition_count: u8,
>> +}
>> +
>> +impl FbSizes {
>> +    /// Computes the framebuffer region sizes for GSP-FMC boot.
>> +    fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
>> +        let hal =3D hal::fb_hal(chipset);
>> +        let fb_size =3D hal.vidmem_size(bar);
>> +
>> +        Ok(Self {
>> +            vga_workspace_size: u64::SZ_128K,
>
> If this is a const, do we need to store it here? Can't we define it and
> use it where needed?

Yerp, I think so.

>
>> +            frts_size: hal.frts_size(),
>> +            wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
>> +                .wpr_heap_size(chipset, fb_size)?,
>> +            heap_size: u64::from(hal.non_wpr_heap_size()),
>> +            pmu_reserved_size: hal.pmu_reserved_size(),
>> +            vf_partition_count: 0,
>> +        })
>> +    }
>> +}
>> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
>> index 5b782aa2e3fd..533fb95573ab 100644
>> --- a/drivers/gpu/nova-core/fsp.rs
>> +++ b/drivers/gpu/nova-core/fsp.rs
>> @@ -31,7 +31,7 @@
>>          fsp::Fsp as FspEngine,
>>          Falcon, //
>>      },
>> -    fb::FbLayout,
>> +    fb::FbSizes,
>>      firmware::{
>>          fsp::{
>>              FmcSignatures,
>> @@ -136,14 +136,14 @@ struct FspCotMessage {
>>  impl FspCotMessage {
>>      /// Returns an in-place initializer for [`FspCotMessage`].
>>      fn new<'a>(
>> -        fb_layout: &FbLayout,
>> +        fb_info: &FbSizes,
>>          fsp_fw: &'a FspFirmware,
>>          args: &'a FmcBootArgs<'_>,
>>      ) -> Result<impl Init<Self> + 'a> {
>>          // frts_vidmem_offset is measured from the end of FB, so FRTS s=
its at
>>          // (end of FB) - frts_vidmem_offset.
>>          let frts_vidmem_offset =3D if !args.resume {
>> -            let frts_reserved_size =3D fb_layout.heap.len() + u64::from=
(fb_layout.pmu_reserved_size);
>> +            let frts_reserved_size =3D fb_info.heap_size + u64::from(fb=
_info.pmu_reserved_size);
>> =20
>>              frts_reserved_size
>>                  .align_up(Alignment::new::<SZ_2M>())
>> @@ -153,7 +153,7 @@ fn new<'a>(
>>          };
>> =20
>>          let frts_size: u32 =3D if !args.resume {
>> -            fb_layout.frts.len().try_into()?
>> +            fb_info.frts_size.try_into()?
>>          } else {
>>              0
>>          };
>> @@ -339,15 +339,12 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Devic=
e, msg: &M) -> Result<KVec<u8>
>>      pub(crate) fn boot_fmc(
>>          &mut self,
>>          dev: &device::Device<device::Bound>,
>> -        fb_layout: &FbLayout,
>> +        fb_info: &FbSizes,
>>          args: &FmcBootArgs<'_>,
>>      ) -> Result {
>>          dev_dbg!(dev, "Starting FSP boot sequence for {}\n", args.chips=
et);
>> =20
>> -        let msg =3D KBox::init(
>> -            FspCotMessage::new(fb_layout, &self.fsp_fw, args)?,
>> -            GFP_KERNEL,
>> -        )?;
>> +        let msg =3D KBox::init(FspCotMessage::new(fb_info, &self.fsp_fw=
, args)?, GFP_KERNEL)?;
>> =20
>>          let _response_buf =3D self.send_sync_fsp(dev, &*msg)?;
>> =20
>> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/g=
sp/boot.rs
>> index c347558aa8e5..14fd96084746 100644
>> --- a/drivers/gpu/nova-core/gsp/boot.rs
>> +++ b/drivers/gpu/nova-core/gsp/boot.rs
>> @@ -16,7 +16,7 @@
>>          gsp::Gsp,
>>          Falcon, //
>>      },
>> -    fb::FbLayout,
>> +    fb::GspFbInfo,
>>      firmware::{
>>          gsp::GspFirmware,
>>          FIRMWARE_VERSION, //
>> @@ -50,23 +50,21 @@ pub(crate) fn boot(
>> =20
>>          let gsp_fw =3D KBox::pin_init(GspFirmware::new(dev, chipset, FI=
RMWARE_VERSION), GFP_KERNEL)?;
>> =20
>> -        let fb_layout =3D FbLayout::new(chipset, bar, &gsp_fw)?;
>> -        dev_dbg!(dev, "{:#x?}\n", fb_layout);
>> +        let fb_info =3D GspFbInfo::new(chipset, bar, &gsp_fw)?;
>> +        dev_dbg!(dev, "{:#x?}\n", fb_info);
>> =20
>> -        let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::=
new(&gsp_fw, &fb_layout))?;
>> +        let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::=
new(&gsp_fw, &fb_info))?;
>> =20
>>          // Perform the chipset-specific boot sequence, and retrieve the=
 unload bundle.
>> -        let unload_bundle =3D hal
>> -            .boot(&self, &mut ctx, &fb_layout, &wpr_meta)?
>> -            .or_else(|| {
>> -                dev_warn!(dev, "The GSP won't be able to unload properl=
y on unbind.\n");
>> -                dev_warn!(
>> -                    dev,
>> -                    "The GPU will need to be reset before the driver ca=
n bind again.\n"
>> -                );
>> +        let unload_bundle =3D hal.boot(&self, &mut ctx, &fb_info, &wpr_=
meta)?.or_else(|| {
>> +            dev_warn!(dev, "The GSP won't be able to unload properly on=
 unbind.\n");
>> +            dev_warn!(
>> +                dev,
>> +                "The GPU will need to be reset before the driver can bi=
nd again.\n"
>> +            );
>> =20
>> -                None
>> -            });
>> +            None
>> +        });
>> =20
>>          let mut unload_guard =3D
>>              ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unlo=
ad_bundle)| {
>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp=
/fw.rs
>> index 2590931262af..3b148147cb18 100644
>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>> @@ -29,7 +29,7 @@
>>  };
>> =20
>>  use crate::{
>> -    fb::FbLayout,
>> +    fb::GspFbInfo,
>>      firmware::gsp::GspFirmware,
>>      gpu::{
>>          Architecture,
>> @@ -215,11 +215,65 @@ unsafe impl FromBytes for GspFwWprMeta {}
>> =20
>>  impl GspFwWprMeta {
>>      /// Returns an initializer for a `GspFwWprMeta` suitable for bootin=
g `gsp_firmware` using the
>> -    /// `fb_layout` layout.
>> +    /// framebuffer information.
>>      pub(crate) fn new<'a>(
>>          gsp_firmware: &'a GspFirmware,
>> -        fb_layout: &'a FbLayout,
>> +        fb_info: &'a GspFbInfo,
>>      ) -> impl Init<Self> + 'a {
>> +        #[derive(Default)]
>> +        struct WprMetaFields {
>> +            gsp_fw_rsvd_start: u64,
>> +            non_wpr_heap_offset: u64,
>> +            non_wpr_heap_size: u64,
>> +            gsp_fw_wpr_start: u64,
>> +            gsp_fw_heap_offset: u64,
>> +            gsp_fw_heap_size: u64,
>> +            gsp_fw_offset: u64,
>> +            boot_bin_offset: u64,
>> +            frts_offset: u64,
>> +            frts_size: u64,
>> +            gsp_fw_wpr_end: u64,
>> +            gsp_fw_heap_vf_partition_count: u8,
>> +            fb_size: u64,
>> +            vga_workspace_offset: u64,
>> +            vga_workspace_size: u64,
>> +            pmu_reserved_size: u32,
>> +        }
>> +
>> +        let fields =3D match fb_info {
>> +            GspFbInfo::Ranges(ranges) =3D> WprMetaFields {
>> +                gsp_fw_rsvd_start: ranges.heap.start,
>> +                non_wpr_heap_offset: ranges.heap.start,
>> +                non_wpr_heap_size: ranges.heap.len(),
>> +                gsp_fw_wpr_start: ranges.wpr2.start,
>> +                gsp_fw_heap_offset: ranges.wpr2_heap.start,
>> +                gsp_fw_heap_size: ranges.wpr2_heap.len(),
>> +                gsp_fw_offset: ranges.elf.start,
>> +                boot_bin_offset: ranges.boot.start,
>> +                frts_offset: ranges.frts.start,
>> +                frts_size: ranges.frts.len(),
>> +                gsp_fw_wpr_end: ranges
>> +                    .vga_workspace
>> +                    .start
>> +                    .align_down(Alignment::new::<SZ_128K>()),
>> +                gsp_fw_heap_vf_partition_count: ranges.vf_partition_cou=
nt,
>> +                fb_size: ranges.fb.len(),
>> +                vga_workspace_offset: ranges.vga_workspace.start,
>> +                vga_workspace_size: ranges.vga_workspace.len(),
>> +                pmu_reserved_size: ranges.pmu_reserved_size,
>> +            },
>> +            GspFbInfo::Sizes(sizes) =3D> WprMetaFields {
>> +                non_wpr_heap_size: sizes.heap_size,
>> +                gsp_fw_heap_size: sizes.wpr2_heap_size,
>> +                frts_size: sizes.frts_size,
>> +                gsp_fw_heap_vf_partition_count: sizes.vf_partition_coun=
t,
>> +                vga_workspace_size: sizes.vga_workspace_size,
>> +                pmu_reserved_size: sizes.pmu_reserved_size,
>> +                // When only sizes are supplied, offsets and several ot=
her parameters are not used.
>> +                ..Default::default()
>> +            },
>> +        };
>> +
>>          let init_inner =3D init!(bindings::GspFwWprMeta {
>>              // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGI=
C` unmodified.
>>              magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
>> @@ -237,25 +291,22 @@ pub(crate) fn new<'a>(
>>                      sizeOfSignature: u64::from_safe_cast(gsp_firmware.s=
ignatures.size()),
>>                  },
>>              },
>> -            gspFwRsvdStart: fb_layout.heap.start,
>> -            nonWprHeapOffset: fb_layout.heap.start,
>> -            nonWprHeapSize: fb_layout.heap.end - fb_layout.heap.start,
>> -            gspFwWprStart: fb_layout.wpr2.start,
>> -            gspFwHeapOffset: fb_layout.wpr2_heap.start,
>> -            gspFwHeapSize: fb_layout.wpr2_heap.end - fb_layout.wpr2_hea=
p.start,
>> -            gspFwOffset: fb_layout.elf.start,
>> -            bootBinOffset: fb_layout.boot.start,
>> -            frtsOffset: fb_layout.frts.start,
>> -            frtsSize: fb_layout.frts.end - fb_layout.frts.start,
>> -            gspFwWprEnd: fb_layout
>> -                .vga_workspace
>> -                .start
>> -                .align_down(Alignment::new::<SZ_128K>()),
>> -            gspFwHeapVfPartitionCount: fb_layout.vf_partition_count,
>> -            fbSize: fb_layout.fb.end - fb_layout.fb.start,
>> -            vgaWorkspaceOffset: fb_layout.vga_workspace.start,
>> -            vgaWorkspaceSize: fb_layout.vga_workspace.end - fb_layout.v=
ga_workspace.start,
>> -            pmuReservedSize: fb_layout.pmu_reserved_size,
>> +            gspFwRsvdStart: fields.gsp_fw_rsvd_start,
>> +            nonWprHeapOffset: fields.non_wpr_heap_offset,
>> +            nonWprHeapSize: fields.non_wpr_heap_size,
>> +            gspFwWprStart: fields.gsp_fw_wpr_start,
>> +            gspFwHeapOffset: fields.gsp_fw_heap_offset,
>> +            gspFwHeapSize: fields.gsp_fw_heap_size,
>> +            gspFwOffset: fields.gsp_fw_offset,
>> +            bootBinOffset: fields.boot_bin_offset,
>> +            frtsOffset: fields.frts_offset,
>> +            frtsSize: fields.frts_size,
>> +            gspFwWprEnd: fields.gsp_fw_wpr_end,
>> +            gspFwHeapVfPartitionCount: fields.gsp_fw_heap_vf_partition_=
count,
>> +            fbSize: fields.fb_size,
>> +            vgaWorkspaceOffset: fields.vga_workspace_offset,
>> +            vgaWorkspaceSize: fields.vga_workspace_size,
>> +            pmuReservedSize: fields.pmu_reserved_size,
>>              ..Zeroable::init_zeroed()
>>          });
>> =20
>> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gs=
p/hal.rs
>> index 46428c623087..ddd356fafc1e 100644
>> --- a/drivers/gpu/nova-core/gsp/hal.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal.rs
>> @@ -11,7 +11,7 @@
>>  };
>> =20
>>  use crate::{
>> -    fb::FbLayout,
>> +    fb::GspFbInfo,
>>      firmware::gsp::GspFirmware,
>>      gpu::Chipset,
>>      gsp::{
>> @@ -42,7 +42,7 @@ fn boot(
>>          &self,
>>          gsp: &Gsp,
>>          ctx: &mut GspBootContext<'_, '_>,
>> -        fb_layout: &FbLayout,
>> +        fb_info: &GspFbInfo,
>>          wpr_meta: &Coherent<GspFwWprMeta>,
>>      ) -> Result<Option<crate::gsp::UnloadBundle>>;
>> =20
>> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-c=
ore/gsp/hal/gh100.rs
>> index 270703d0f5c6..6fc6d487e4c8 100644
>> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> @@ -15,7 +15,7 @@
>>          gsp::Gsp as GspEngine,
>>          Falcon, //
>>      },
>> -    fb::FbLayout,
>> +    fb::GspFbInfo,
>>      fsp::FmcBootArgs,
>>      gsp::{
>>          hal::{
>> @@ -136,13 +136,17 @@ fn boot(
>>          &self,
>>          gsp: &Gsp,
>>          ctx: &mut GspBootContext<'_, '_>,
>> -        fb_layout: &FbLayout,
>> +        fb_info: &GspFbInfo,
>>          wpr_meta: &Coherent<GspFwWprMeta>,
>>      ) -> Result<Option<crate::gsp::UnloadBundle>> {
>>          let dev =3D ctx.dev();
>>          let chipset =3D ctx.chipset;
>>          let gsp_falcon =3D ctx.gsp_falcon;
>> =20
>> +        let GspFbInfo::Sizes(fb_sizes) =3D fb_info else {
>> +            return Err(EINVAL);
>> +        };
>
> Mmm I wish we would avoid that, this is another example of a runtime
> check that should not need to be performed.
>
> In this case I think we can, as we also have access to the
> `GspFwWprMeta` which contains the FRTS size information that we are
> using. We would just need to construct the range from it, pass it to
> `run_fwsec_frts`, and we remove visibility from a lot of information
> that this method didn't need in the first place. This could be a
> standalone cleanup patch that comes before this one.
>
> All the same (and again IIUC), the GH100's GSP HAL `boot` method should
> be able to work entirely with `GspFwWprMeta`.
>
> With these two out of the way, the only place where the FB layout
> information is required becomes the construction of `GspFwWprMeta`;
> which should give us more opportunities to make things more local and
> remove `GspFbInfo` altogether, maybe by making the construction of
> `GspFwWprMeta` a HAL method of `Fb` so we can hide `FbRanges`/`FbSizes`
> there?
>
> It's still not completely clear to me, so let's first see if my
> suggestion can be applied and what the resulting code looks like once it
> is done. But I sense room for simplification. :)

Yeah it is unfortuante to have the runtime check but it's just another
consequence of pushing stuff across the dynamic dispatch boundary on the
HALs (see below for a method to avoid this). I am not sure about using
GspFwWprMeta as the source of truth though, for the following reasons:

1. The next patch adds `fb_end_reserved_size` which is used by the FSP
   code. It's not part of `GspFwWprMeta`. Meaning that GspFbInfo encodes
   more info than just the wire format bindings required by some of the
   hardware.
2. It feels a little gross to me to use such a bindings adjacent
   structure to be used upwardly instead of downwardly to the
   firmware/RPC boundary.
3. If fb.rs needs to depend on the hardware/firmware-specific
   GspFwWprMeta I feel it dilutes the meaning of having fb.rs be a
   separate module holding general info about the fb layout used by
   multiple modules. The dependency direction feels a little awkward to
   me.

Instead, I think it may be better to remove Coherent<GspFwWprMeta> from
the boot signature and create it inside the HAL. I think it's a bit
nicer to push that more HAL-y object downwards.

If we do this we can also push the creation of FbSizes/FbRanges into
each HAL implementation and get rid of the GspFbInfo enum and the
runtime check. WDYT?


