Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BFCD98C5
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0564510E3F6;
	Wed, 10 Jun 2026 12:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="reiWWT0O";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 127CA10E3F6;
 Wed, 10 Jun 2026 12:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6JJkq/uqfodgjtV/WzaOQ1WIsLmvmzRUHEssJduucJ5GA8KYaQ+sAEZaltyFfIKob4ZNsr38VrLmPGtF72eIzMl/1Ed4iJ9EIZBbnlKhSLcVkLF43SNohJGT0as0s+CUoYi2czkUwTj8euxNWD+jo+hhpLuX6TCdq8TVrHLIW6mQBPw90ftx5mS1TxNrffYQh637TENplaAShPrUaxmXMRzGuKIw+qZMVt8AjJK4I/zzYyD2RZsViebOtHKMjlcUVi8F77S9xl6+7w3qD+ti+FtlmvOk7wRtTDwgHu5C+GRYKKBuutDTyZywHP1P4finLnu08ylZcs7MLiTAPTr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax6uScIGZw9MKzmP6S82krxMKsjVdqQik4WcuSQMiSc=;
 b=gZ6Zi05nk94WNk+osGvgY0SNMMq7BDemwGO4QSQzEOQu3j+HQu0qn9K0jzxM51OJRzyb0XPeAZ5T92Z9DhbDy4agvFhk3FXNlwoQ35/0AiAvxFQkDqb3Cf7gds63GQ0Ev0qJcLBorqSdx7G4WNeat6mLb9ljsSY1kl9cUKk9Y56KEXNnrV6kD7Cg6iLvJoXb6367LUtY6LjGtZVnJPkwtW75o6SOvUXfgBlz6E4i1eKvqgZ5HvrRJe5rDKdza+F/ebVRPP279jKblycR1fpi0vVccQgzBohJBnuglszxhnHyLvk9J0UwBvUwVrsP446OH+U5GC2PyLi0NQgLrF1S2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax6uScIGZw9MKzmP6S82krxMKsjVdqQik4WcuSQMiSc=;
 b=reiWWT0OQDM1vK8qxK21Z5yCDBGWzq4kpvoK9sJg2g1z+pEvF0e0XSWgW4z0ow32ityrdJpg8Nm8bo2WQMYggQDCxF/B/8zn9f9UMUrdgxMXNLkaL+CfbQP/zfYCHyETmeq/1gCM2GKLBgeE3z95BaVs+CfIxyLyO/zMKMIdbrz9MYHh25PEWiNSa4wdod/1aPjp1p6yVs68GJVo+y9MNxCcJ26luph4cEFt3aO0P3K8YjMVNX2YrM4X0MhrqYG/zqVB99Y+A/RlRRRhkiekHkY1WuOGAgXOfnq6ZbLGenxZInub5DFtuYiuC99ByFpoIAfvk5SBCDyT2BmnLA48RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 12:30:36 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 12:30:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 21:30:32 +0900
Message-Id: <DJ5DCQMQ82MR.3FNJG5TJ7ZP61@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
 <DJ52BSFTRYBX.2ZR8NX8A5H4ML@nvidia.com>
 <DJ5BTNH028R2.39ZJSHDNTZ0MV@nvidia.com>
In-Reply-To: <DJ5BTNH028R2.39ZJSHDNTZ0MV@nvidia.com>
X-ClientProxiedBy: TY6P286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::18) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9651be-8cf4-4a68-b8bd-08dec6ec12ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 4/3Hu8x1dcgZ3JY7eCrHwRVQSewrDtUOJJvIOgEjGKsrGAkHpz4P6GNAIDo4Lu0EOZCLU+xOusgmL5Pr30uRp52uteHQgtRlUmwU8qaUTBwLKwo/Ea+DrlbIRCEizREkhvybhlvOB+pUfTLr54ZH2RPj4IgP5r7rNz4b219Jv7CngxvI7m9+Yw0U9IdBRYz5fp30Tg2SSvmAumXTldlqWS4yxMVqZks09BxMORVMZZm2jiMaVjZoTaaulGxh9nc0kiiX3Ig0kMtE1HhYfYloY/Wem6FnRSJEPUbBZATCrNJEHnol6v55sNS1ZcfuSHGWjYOKjURtsbrWtlDcttShGcG+eLyiMP/5drUxhLdeXV1WgQd1A6s9YcOdUSmr9W5RocZ4pd0X5oplQgWHXWSqAR3xjxbC9laLNITZXeJzWazHuoYVacBIE2laWP7/ZoAsF3Dz5+YKLXCIsPSIR4wnzDXg7aJHEBm2021zYzwraQkN9JfE1f70mD1x4LovHUjWlsbtFsOZEOGMmPSCjepnkZ4ubGfXN6POpkp6fUhffE3i5up2Nl30/lz9QnbUWhd/AWi5TjpKKFpnBNKwhFNIurX2R0NOIMK+Sdd5R2R9ytOwxXYXXhW5OdGRsFDgRPrnGDbOyCb6M924mowA59GrNBExFRaRD3O0hQFMDVIx2qPWhDcIbU8FB+3NSakcAguS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlCVU1iZTZ5U2RLdmRCVll6WVg1ZEluVSthNmRxMnZsbFB0NnJrUTZtMTl3?=
 =?utf-8?B?M3BrT01VdGt3aXczUkU1YzJJZURia3MxR3lCLzVWVUY3UXBlbDN4TmM3SXg4?=
 =?utf-8?B?MUNkcHVscGF3ZDd0cEhFWVR5SHBhWFBKYll0WmpsU0dVaTBPekJXbHd4ZGhy?=
 =?utf-8?B?OVdGcTVxQzZUU3UvZkU3YXdYRytWdGpxMFhpUGhwZGJjYzZDaFNyQW5zaXJ5?=
 =?utf-8?B?VU1UVDdveWxxR0REdFZkajdYU1BsUys0NDd3dWdOVGtpTjdBZTdGN21jclRF?=
 =?utf-8?B?N1pEb3ZLZHByT0RrSmVZaFZCOVhkdDJNM1ZXNFdXY0kwcVZGaXVTbXFuZkt0?=
 =?utf-8?B?dU9Ca21weHk2cDNURXUyK1h4b3pxUTk1czVEaWNmNm1vWkh6K3cyMUJ2SGFF?=
 =?utf-8?B?aG01ejcvQk1OMSsrRmV2ZjN1K1lFWEw0c2s1N3dIdHFZNENaNFBWeHZMUWJX?=
 =?utf-8?B?azhCN1Mvbi9lMGNYcmZWc1hoQ2dLeHAwZnRBVFBhMW5FY21ZNENraTgvWFFv?=
 =?utf-8?B?VUdIaGFrbEtMTFNmMzFvVVpLVXY0YlRlOC8yTWhXdy9EeldicTdUTFdzTFcw?=
 =?utf-8?B?ZTRWczRWWFRjNzVBZlFYYjcvdFMxeE14bmh0UmY2ZlBrSmxQQ0VPZW9nMlRx?=
 =?utf-8?B?c0oraFErWTNqQnVzNjVRZ2phKy9lL3Y1TTltUXFlMFhiRnNZRVFRZFBqTWl1?=
 =?utf-8?B?TDVxMkpIMy9xNGJxeEVhV0dNN2NqSXJYV1h4Z2pDSUluV2xiMTEwUXJPeE90?=
 =?utf-8?B?LzgyQTMzdFFjdFRFZmU0VGNicEo5NlNOaUtycWsxT2pHbU1qMU5MUnlndGpu?=
 =?utf-8?B?cUd0bWFsb0NtZ3Y3dWlrSmFmUGxHMTJSeXEwS0lDbnRRSTZTU1BCZ1ozblky?=
 =?utf-8?B?ZnZNT01sUm9XOTQ2Qnl0UHpXWm1CWFVrM2ptOUhHTU1OS21RWTJpSFZsYzRj?=
 =?utf-8?B?VzIxYnpWTE5VR3ZhbXVKMG1odUorbnlXZFA3d1BURXpPeGdQb1JkN3FhVlRY?=
 =?utf-8?B?WVg1MTJxYkpGdGZnZlJ0NTNKRkpkdDJ2cVVjTmRZYm9tWG9JKzUzSVpibDRp?=
 =?utf-8?B?VVVtdlZUZVlGd1piWUF2ODcycTBlWWVNRTVrSHVNSldnU2p5WDZaMkJUVXEr?=
 =?utf-8?B?ME1Bbis0bnBHeUt5Q3kxTVovUkYyOFRzNG5wdERKajc3dHVsQ3JnY1R3OVJX?=
 =?utf-8?B?UWk0enB6NmhlbHQvYTBmQUd6SWVPMHJPMGw4OWhvUGxjTHYyUUs3Z0gyWlJR?=
 =?utf-8?B?cTdXTXBoSFpxcDkvajQ4c09ucVNkYXVaSDJSakVoV29VQ3RWWDkxaDFuWm00?=
 =?utf-8?B?QmZmRHpmUHhPeUY4eEZZazd2ak0xMjhxbVdBVnhoRXdrOXgxRFhnTktGR3U2?=
 =?utf-8?B?MHNmdE1VRXNGNWtaRU1DSGdoSFhxem9yZmxSNmgrU25iRVpwUUFHOEFBVURz?=
 =?utf-8?B?TFV0NFMyQ1pHSGZ3WEhqNVpqK0NMYjZvazF6MmV3eXRnTjdLSWtpUEgzRGRC?=
 =?utf-8?B?UnNUWHgrbnZia3FqU2VoZElpRHVzN25sbGFaYXJnMnRjTVp4MmtyRTBhbU0x?=
 =?utf-8?B?QjZOQmlqT1pxcTZlU21uMCtlRklxcCtldnVZZWZDaGZ3ellIekpwR3MwS0ho?=
 =?utf-8?B?Ly82eDJDZ1pwK3hHNEs5aEU5V3lhdWFqcG5SSjRudkVjS0toTXRURWxTbkp5?=
 =?utf-8?B?OHB3a2dGV1VPQm1ES1h3dWdWTFJxcWttMEpkZFVNTXRtVVV2bndTZjhIeWx1?=
 =?utf-8?B?WkJFWUg2OTBhMXlDeURjNEZzS3ZlUWY4c2dIdm12TWt1Mk5jUVJocU8vZ1kx?=
 =?utf-8?B?N2FGWFlVaCtYYXRIMm4vQTNzWEpMWXZBVnRiR0VlNGQrWUQ2SVV3bDcwdXh5?=
 =?utf-8?B?WS8ycjByQXA4eVdYSFlGeXB4clRXRXl2V3JZSHZvQW40L2lIV1B1NVFjMHNu?=
 =?utf-8?B?ZmRYeGNhL1BHUXlrenFTNkdVZEoraWRQaVphL1EzK0ZXZGxDdE9iWmcwZFZv?=
 =?utf-8?B?YU1haTVFcWZPd29jNTFQTG9YY1VXbmpuSUtacDErYytQNUpZNlFiUnVtdzZ1?=
 =?utf-8?B?NU1uSktyckRBRDR1aEJUN0c4NUhMd3F3dHBnQ1hWV0h3THladk1oWXBGZDh2?=
 =?utf-8?B?aGk2YWRVOFNoSzA4YUs0TmFHWWhkSzBhYUNOR0FzZlZiVE05Z0M4bTZWaUx0?=
 =?utf-8?B?OGc3OS94dGhFTko5R2w3aWNHb0l2S2R5MDR4Rm1TNE5DdnNyaVlxK0JaaHRR?=
 =?utf-8?B?MGVXMm1ZMk0rdkFoSTU4UGdrclBPMHJUVmxoL3cxWGRLa2wyWHdRNFlqbzRx?=
 =?utf-8?B?LzVBWUpzZ2tsSnA2RjZpVTdzdW1PT0syMDVUS1lzYWJ5UnF4VEZNeXA4cFUx?=
 =?utf-8?Q?krRN8q2VGtFdo0hEffqgWkiCsgyEFIN8undCqUcWIy6Hm?=
X-MS-Exchange-AntiSpam-MessageData-1: LQTSYgA3p+4w1g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9651be-8cf4-4a68-b8bd-08dec6ec12ce
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:30:36.4554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01Teir0BM+VcWipLzcV+t0r6/1LtmN7v+1XsGT3DfMUDG37HIEvlsyOhEjo+MGj45LSeOneZ3hIEfU6u78Vqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350
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

On Wed Jun 10, 2026 at 8:18 PM JST, Alexandre Courbot wrote:
> On Wed Jun 10, 2026 at 12:52 PM JST, Eliot Courtney wrote:
>> On Tue Jun 9, 2026 at 5:03 PM JST, Alexandre Courbot wrote:
>>> `Gpu` currently owns the state needed to unload the GSP directly. This
>>> means that `unload_bundle` has to be the last initialized field: once G=
SP
>>> boot succeeds, any later initialization failure would leave `Gpu`
>>> partially initialized, and its `PinnedDrop` implementation would not ru=
n.
>>>
>>> This prevents adding fallible `Gpu` fields that need to query the GSP
>>> after it has booted.
>>>
>>> Move the GSP state and unload bundle into a dedicated pinned
>>> `GspResources` object. Once that subobject has been initialized, its
>>> `PinnedDrop` implementation will run even if initialization of a later
>>> `Gpu` field fails, ensuring that the GSP unload sequence is executed.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gpu.rs | 86 +++++++++++++++++++++++++-----------=
--------
>>>  1 file changed, 49 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.r=
s
>>> index b3c91731db45..6b3e02c71dee 100644
>>> --- a/drivers/gpu/nova-core/gpu.rs
>>> +++ b/drivers/gpu/nova-core/gpu.rs
>>> @@ -262,35 +262,59 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt:=
:Result {
>>>      }
>>>  }
>>> =20
>>> -/// Structure holding the resources required to operate the GPU.
>>> +/// Self-contained resources to operate and drop the GSP.
>>>  #[pin_data(PinnedDrop)]
>>> -pub(crate) struct Gpu<'gpu> {
>>> +struct GspResources<'gpu> {
>>>      /// Device owning the GPU.
>>>      device: &'gpu device::Device<device::Bound>,
>>> -    spec: Spec,
>>>      /// MMIO mapping of PCI BAR 0.
>>>      bar: Bar0<'gpu>,
>>> -    /// System memory page required for flushing all pending GPU-side =
memory writes done through
>>> -    /// PCIE into system memory, via sysmembar (A GPU-initiated HW mem=
ory-barrier operation).
>>> -    sysmem_flush: SysmemFlush<'gpu>,
>>>      /// GSP falcon instance, used for GSP boot up and cleanup.
>>>      gsp_falcon: Falcon<GspFalcon>,
>>>      /// SEC2 falcon instance, used for GSP boot up and cleanup.
>>>      sec2_falcon: Falcon<Sec2Falcon>,
>>> -    /// GSP runtime data. Temporarily an empty placeholder.
>>> +    /// GSP runtime data.
>>>      #[pin]
>>>      gsp: Gsp,
>>>      /// GSP unload firmware bundle, if any.
>>>      unload_bundle: Option<gsp::UnloadBundle>,
>>>  }
>>> =20
>>> +/// Structure holding the resources required to operate the GPU.
>>> +#[pin_data]
>>> +pub(crate) struct Gpu<'gpu> {
>>> +    spec: Spec,
>>> +    /// System memory page required for flushing all pending GPU-side =
memory writes done through
>>> +    /// PCIE into system memory, via sysmembar (A GPU-initiated HW mem=
ory-barrier operation).
>>> +    sysmem_flush: SysmemFlush<'gpu>,
>>
>> This means sysmem_flush is dropped before unload is run. Before this
>> patch, PinnedDrop runs the unload bundle before sysmem_flush's drop
>> actually runs. But with this code it'll drop sysmem_flush first, and
>> that isn't allowed according to the comment in fb.rs saying that it's
>> needed for falcon reset. What about sysmem flush into GspResources as
>> well?=20
>
> Yes, Sashiko also found the same issue actually. I will fix that by
> declaring `sysmem_flush` after `gsp_resources` in `Gpu` so it is dropped
> after. Initialization is done in the given order by `pin_init!`, so we
> can still initialize `sysmem_flush` before `gsp_resources`.

With that change,

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
