Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82C6CDB470
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1668910E04E;
	Wed, 24 Jun 2026 06:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdum5YKU";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893A510E049;
 Wed, 24 Jun 2026 06:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNKNugs/qpLMskc7W5iSj1StOwnZX13vb6P8PvF1aWPqDO2sYEvZGJdX4IG7+uAfJoHRAsPskY+tvnOZ+2YguCtpwSiRb02axkdLx/HMllJE6Muyhag/c26GFNcmoa3kx/gKiXJonBBlqWlknpJYchc+jgyQYL2SB3PzOztSO1mvqPuvaATx9Ntq8CbdA6JQtvgAfPNNssam8QoLBmFnGlzsoerJoHWBNNs/zXGIiC7pnUDgDh6xXSPTjfJi9FWNe7B/uPyANqnEytFovxIetTdpf1VRX6sAB4rpzmzBqVDrCosUgIboiUVFmePUMjllU21lXGrh6ZxmBXDzqL8TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fhz3vkVPC5bY8npYS1w3UhTRhi+bdCfYnmF6PeYcPs8=;
 b=ba35Pgr68a1kTvl69N49YQofezgf7X6M2d3gDx5HRW3DLvqXOGdbM4/qxExi4heEftEOlX1S5N8YeWuI5wS9Dh7rUs9dbtm3CC+l4ZsUitx/OZlXVasYDiZSTMDcyRRQD5vmBPgzrYDkHdkndnJccHnsWeXufdmd+uCYaFqTFEY0hfFgsFzzun+2OyduqBdaEJ+OHKjE8clnS+DpxiGo+y6NihvcEFj03WVxe6qv2PANyJ6/GcuoC8dWJgNGUEPg2XlfU5VcLfp9QijB6NxYcuIq9M4+FG4qJrEv7FrLNq9HvAX/q0q1mFs2a4wAaV4zy+CYpjpC4SbbcmzKN2i+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fhz3vkVPC5bY8npYS1w3UhTRhi+bdCfYnmF6PeYcPs8=;
 b=qdum5YKU6+QY02AhuWMzDzhlHw+jorjZhU1EwkS1qQLlfeHopZBEUCVHRiwm+QvpJLoL13C5JxznEP+TqE5RgqGt5pC7bV4K0PjPqgUNKgY0AyESezQBGgITcgIbmwXW7/iCqYG0K61MVVZbV4RsJmW7MQI3SaruxVv/4WaNLWK/FXoLXjB0KwIl4kov1OrtBvEGG5mjJIzPmVcF9WJHlkqrK/MGtgvnpKTBYnmuNmDzMA9as2XJqLXOjkJ6OpaDoHbqXZgji9iMcjczsmyqMrymghfeHIyINNCJZNqXYkSIRzzYaAVzZHrMRT6OHjJWkz8jYvsiHn7RBYe9Fm5yHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 06:36:29 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 06:36:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 15:36:26 +0900
Message-Id: <DJH2L8IY3GGC.3NBPX6YNGPL82@nvidia.com>
Subject: Re: [PATCH 3/6] gpu: nova-core: gsp: move boot code into local closure
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
 <DJFF1W6VGY4Q.2PV5MEPMFXIDB@nvidia.com>
 <DJFO5A5XN2EO.22B58J2O6D4JG@nvidia.com>
 <DJG6S20KHJK3.TKRZLBYUPGG2@nvidia.com>
 <DJGZX2MGM1DD.3VAEGR7G5QVBE@nvidia.com>
In-Reply-To: <DJGZX2MGM1DD.3VAEGR7G5QVBE@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ecbb8a-ca36-4a90-d480-08ded1baec6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|10070799003|7416014|376014|6133799003|3023799007|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: VtURmEFv6RTDyycVG3tJhyO6x29ClJop0HpufZ/PedH9lRqph+t2dpUm9yh+WrVmk8lGmpQueg1hTFgevTw390lgqmSHNZO9KpRycPgUVa0JVXgOJz7pSq6ay2vMhhb8duq/vb+z2osHOhPaR/Sy/3eZYCAeAIeqW9/L4xkx5iZzUVySh8YKuC3OYXHWSfr0OlPvOI1Nmt72Jif2jZUtk8fnecvvfx+fQ+4Ht0WP5LgYHPpuSjOX5SgEG5wGnB9Im0i+79Qym+4Y15CdP5GuW+Ypo9lNKxeVaichM3e15A4DBxLbsrs1pIjUoo7PyFOXC0ISDcn7QD2LWzjLfASfgjIux+tbw5feA1UbraP9/50LJuzbWcGqGpqNjo07g0f3ysCWo8hEDyV9Ocq1YI1DGyJCXtNphhCi5yMk1nVbc8EK1wTy7A8usVuLIbQcqyxBmkD4kEk/MbP3WxLLPPTP9rpjBmrXu7Z1Iw6bNJBvNVD7vSgZNKvve4EsGODyFJJfUbsJJj8QhENNK6/MNdDtTyJ2PZDjaxhfCVCVYv34KDRNKkqiXLLZ9d60jcBX80IK/npzab1NjiCB3lsuTPUwoq/SxAuEM54OYe3rG0TtHtwiTAiAFLT3QNGj1qOLCXF6UO5MjkcTaMjY9k85vYMnND+jsAFQ7POoKlu+9tQqaWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(7416014)(376014)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHJacFpUcExOem1oa2pHT3BiaVFFWS91RFlyajM2UVVUNWVka1UyKzRpcFVX?=
 =?utf-8?B?MVdMTGZDUHJBZ2JrTDMwMmxaVFc4Ni9xRmdUM1hDYTR4SnVtZ3hOQ2JOU0Ji?=
 =?utf-8?B?eHRZR3pVdkdjQWJSS0hCd3hVcy9YalhubnZVVEYxc1ZxTy9PcGo1Y1NpWHpD?=
 =?utf-8?B?UVdoTkRMOXRmbWtxZktnSHBFdkRIWU9mSlJJMTNFb08yWmN0SGtQS2ZOTStz?=
 =?utf-8?B?U0NqKzFzd0Jvd1lMWGUrd2NXdkpsb0huS2JibzlVRXdCejh5L1c1Y1VwN0ow?=
 =?utf-8?B?dk8xYktKZUpwVGxrVzEyb0c0b25Ba2ZYaWZJYTlwK1dPWUR2K3hMdm53WkNW?=
 =?utf-8?B?QWdFcHgzbEIyS3ZaWE5CZUh0LzNVamJRS3J0amcyZWpycndKVFdWNGdKZGpY?=
 =?utf-8?B?aWo0cUJLbW9jakRRYkorcUxkUmdrVmUyNEFhS29sSUpqaEt1Q3dySnhmeFE4?=
 =?utf-8?B?ZEdBNldZQmFmeVNKNmlLOEk0cmdLdERscDJoQU0xZ3ZDYlJYbDFWVGx4N1Jh?=
 =?utf-8?B?dXg4MENQVjlxT0NqL0M5TTQxM3lHbDVROExCUHdHMk1aT0VWc2d1TDJnM1F4?=
 =?utf-8?B?dmJmNHlSbXZhbWR0RDUyQmRIUXBIZjlTZkU1bC8zdWQxLzcrRUpqTDBxVnM1?=
 =?utf-8?B?ank4QndlNHBtOFEyMGkrTEZjOXN2TmI3ZmxQVzllbXdMeFViMkJTK2ttVXJ5?=
 =?utf-8?B?aU9WMHNPR2lESE9zUWh3b2RoWXpLSVQvWDBXeW1JOXlpWDlUbjh5T0cyUklZ?=
 =?utf-8?B?eTJlVjg0cTBjWkJadDBFengyMXhIRDlwQS9ySVdZZEFXbmlzSkVMVmJuYjJV?=
 =?utf-8?B?ZEduRDN3Yk5pSDZPMUs4UXgvODhTRUlOOVZHcUZCampHQnhjb0ZBaDJqdCth?=
 =?utf-8?B?ZklWQnhhV1BibG1jcXA5dnlPTnVhZTd5d0ZCTmJ1OUJSY21idnlBejcwVk10?=
 =?utf-8?B?amkyT0ZUcEppeXVsODdUbVhSMjc0Nm1wcURuVGFya245RVBiWGdCdzJUZW8w?=
 =?utf-8?B?MlZDRFpxY0s1OUNoVC9tVmNOWnJRYXpUNWZmT1JzYnl5c0ZLeUFGV3lJSUhz?=
 =?utf-8?B?L3JxbWFScmNrbGJQdDh1MmkzQjB6UHpJbHZnUXpPSUFyQ2o5bkVtWkNWWUVq?=
 =?utf-8?B?UWpISURGVjFBajYvUi9FMEdXQkcxRzZVUVV0R0xFZG1Eb0QvYVBuWENWZWZD?=
 =?utf-8?B?YVJha0pGVnY0ZXFwNCs2aGhwL2tZeGR0eGhZRnJIQTlSNHhkMFY5cHNIUnl5?=
 =?utf-8?B?N3FQRjlLOXJxTnVQaTZrL1FFTm9oS2VSSUsrM3U4N0puRHZaYVJNYnJKZHdy?=
 =?utf-8?B?ZWNkdVN1QzgvN283Q1hjckd4YzVBMlZrdk1QZ0Z1YnR6QktZU2RQYVgvY0o0?=
 =?utf-8?B?cCtUN3lrbkR3alhPK1gvRDZ3M1d0WmpXZWllZzhHLzJ3YS9UQUxvU0xUbGE2?=
 =?utf-8?B?dWNUc3hPa1lOZDI5REJjaWZvWmRqY1dUUkcrZWRzeVgvamxoNjl3M29CV0RF?=
 =?utf-8?B?RDlHWW90R05GaFBVOWhQQkxUeVJ3QklvaEUzbGtxbWxua0U4VERFYU1kREgw?=
 =?utf-8?B?a2RHWElCVm1od3hucTh3RlpRTDNBeHhYTUlUdkJBSUpVZ0N6WkdiRFNFY2Rm?=
 =?utf-8?B?ZG1MSy9zWGNjM0JQVnlWV28zK1I0Qld1THpjYkZ3TExyb3hnVnE5TE1ZaVlo?=
 =?utf-8?B?aThSSDBldERYemo2dGJ2UEM5L0MzcmtmV0Foa3F3R3hCMHFnMjc4N2dOUzhs?=
 =?utf-8?B?K2hVakVxSURBcHhKUTZncGRBSFl5QkgwaUhZUk1uTk1WZlQ4bWU5UVdlN2Rp?=
 =?utf-8?B?VlNNS0VXRzFQSlVacCtvaGluWHlhK3p3NzRwdTZ3SDdvRjJOelR6aFg1KzVp?=
 =?utf-8?B?TlpzQlRlVG1TcCtBMjRudEtQSVpWLzRkNjQva0tFa0ZMVXViZ05OeGlQMXBZ?=
 =?utf-8?B?WFE3ZFR1ZUNpSDArckl0T1phd21MQmRzc2pSWmMwYzFrU1JwM2hibURVeVN3?=
 =?utf-8?B?cm11STlNM2c4OTJyYXVDUzUzYlNEb1I0cXdJcFFYVFBIbEl2c2VDSk45MDBG?=
 =?utf-8?B?cks3QzFXT3U0U2wyUGdOYlY2cVVIdkptUS9mRlIwVWZCaldYR1R4bzAvQmdX?=
 =?utf-8?B?RGY1cG1PTkMzSVFTU0F5Q1VkWEFqalp4UGlCcHR1SURZd1hOeEIyeWNURkI2?=
 =?utf-8?B?OTJkaWJNbHpOVkNSZUNPN0k3WmN5U09SZEk0THA1azJVQnZNNnl3TkRHeG15?=
 =?utf-8?B?MmYycGRqQlJsMm5mU2pOR0Zad1htTktsWG90RW9ZTE04OGhKRFdlTDlxVS9x?=
 =?utf-8?B?dzhlT1lLdmhtcnFUaFZ5Ly9uTWVrL3dNZnJ6YjBHRlNOV2phNnZCdXArd3J0?=
 =?utf-8?Q?buY97A6W/nTj+8OHKIubUNrc4HXo6fU2NKHpWUkw2tRHW?=
X-MS-Exchange-AntiSpam-MessageData-1: Gi/V/JkAFFRpZw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ecbb8a-ca36-4a90-d480-08ded1baec6c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:36:29.5411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D34BUTVQGVNCNXRRD4SglueIPcdySVgI0uXfginiNpJ7YHdRJThJ58GBl99PR46uO9TkMspo3g+lMkTlS5qu6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

On Wed Jun 24, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
> On Tue Jun 23, 2026 at 2:40 PM JST, Eliot Courtney wrote:
>> On Tue Jun 23, 2026 at 12:04 AM JST, Alexandre Courbot wrote:
>>> On Mon Jun 22, 2026 at 4:57 PM JST, Eliot Courtney wrote:
>>>> On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
>>>>> The next patch aims at replacing the cumbersome `BootUnloadGuard` wit=
h a
>>>>> more local and less intrusive mechanism to run the GSP unload sequenc=
e
>>>>> upon GSP boot failure. Doing so requires running the boot code in a
>>>>> local closure, which changes its indentation and would make other
>>>>> changes difficult to track in the diff. Thus, this preparatory patch
>>>>> moves said boot code into a local closure that is run upon constructi=
on,
>>>>> so the next patch does not need to re-indent code that changes.
>>>>>
>>>>> This is a mechanical preparatory patch to make the next patch easier =
to
>>>>> read. No functional change intended.
>>>>>
>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>> ---
>>>>
>>>> I agree with removing BootUnloadGuard, but I think it's not great to d=
o
>>>> a bunch of lifting into closures then manually handling the result. It=
's
>>>> error prone imo (we already had several bugs relating to this kind of
>>>> thing). Instead, what about just using ScopeGuard directly? This lets =
us
>>>> avoid lifting into closures (which is a bit noisy) and avoids manual
>>>> result handling for failures (which is a bit error prone). With the
>>>> `GspBootContext` it's fairly easy to do now:
>>>>
>>>> ```
>>>> let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unload_=
bundle| {
>>>>     let _ =3D gsp.unload(ctx, unload_bundle);
>>>> });
>>>> ```
>>>
>>> Yes, initially I wanted to use `ScopeGuard` but ran into issues when
>>> trying to make the references mutable. However it looks like you have
>>> been able to overcome these issues, thanks for taking the time to craft
>>> a patch!
>>>
>>>>
>>>> I confirmed that it's also compatible with the v2 of this series that
>>>> has the mutable Fsp - you can stash the context inside the ScopeGuard
>>>> data (then making a &mut reference to the stashed context for brevity)
>>>> or have a separate unload context type that doesn't use FSP or somethi=
ng
>>>> (could later be type parametrized along with Gsp, for example).
>>>>
>>>> For example here is a rough diff on top of this patch series (you can
>>>> change the Result<Option<UnloadBundle>> returns to like
>>>> Result<Result<UnloadBundle>> if you want to centralise teh error
>>>> handling of a failed unloadbundle although currently it can only fail =
in
>>>> one location):
>>>
>>> Yes, looking at it it looks like a cleaner approach than using closures=
.
>>>
>>> The only thing that I saw as a regression is that now each HAL needs to
>>> call `Gsp::unload` itself in its own `ScopeGuard`. I don't think that's
>>> the HAL's work - `Gsp::boot` should be the centralized point where this
>>> happens.
>>>
>>> But we can make both work if `unload_bundle` is passed as an output
>>> argument to `GspHal::boot` instead of being returned:
>>>
>>>     let mut guard =3D ScopeGuard::new_with_data((ctx, None), ...);
>>>     let (ctx, unload_bundle) =3D &mut *guard;
>>>
>>>     // `unload_bundle` is a mutable reference to the
>>>     // `Option<UnloadBundle>` in `guard`.
>>>     hal.boot(&self, ctx, unload_bundle, &fb_layout, &wpr_meta)?;
>>>
>>> The boot method can fill `unload_bundle` early, and if it returns an
>>> error then the `ScopeGuard` will be able to use it. Also, and that's
>>> nice, the HALs don't need to use `ScopeGuard`. But output arguments
>>> aren't really something we expect to see in Rust.
>>>
>>> Another alternative would be to separate the unload bundle construction
>>> from `GspHal::boot`:
>>>
>>>     let unload_bundle =3D hal.build_unload_bundle(ctx, ...);
>>>     let guard =3D ScopeGuard::new_with_data((ctx, unload_bundle), ...);
>>>
>>>     hal.boot(...)?;
>>>
>>> It removes the "1 boot -> 1 unload bundle" symmetry, but on the other
>>> hand it also splits concerns more clearly. And it removes the awkward
>>> return type of `GspHal::boot`, which come to think of it was another
>>> smell that things were not in the right place.
>>>
>>> The main drawback I see is that we now need to build `Vbios` twice for
>>> TU102, since it is needed both for the unload bundle and for booting.
>>> But the solution is the same as what the v2 of this series does to
>>> `Fsp`: the BIOS is a GPU-wide subdevice that is likely to be used
>>> elsewhere, not something to be confined in a GSP HAL. So I say, let's
>>> extract it and make it also part of `GspBootContext`.
>>>
>>> How does that sound?
>>
>> I think that currently it's confusing because we have two concepts in
>> use with very similar names. We have "unloadbundle" meaning what we need
>> to run to unload the driver, and we have "unload_guard" which is for
>> running unwind stuff if we error. And for the most part these things are
>> the same, but they might not be (e.g. in my other series where we need
>> to keep certain DMA allocations alive just for the error path, but not
>> for an unload later, or when we are partially loaded). So it might be
>> nice to make these two things more separate.
>>
>> I think that trying to build the unload bundle separately
>> (`build_unload_bundle`) is confusing because e.g. hal.boot() still needs
>> to handle unwinding its state in case of error, so it adds a strong
>> assumption that unloading in success is the same as unwinding in error.
>
> I don't think `hal.boot()` can unwind its state properly - or I should
> say, I don't think it can unwind it better than just running its unload
> bundle itself.
>
> There is little point calling `Gsp::unload` from a HAL failure as it
> just queues an `UnloadGuestDriver` message (that the GSP wouldn't be in
> condition to process) before running the unload bundle. So here we can
> simply skip the guaranteed message timeout and run the unload bundle (or
> the relevant part) directly. But even doing so doesn't guarantee that we
> can recover.
>
> For TU102, the unload bundle runs two firmwares to reset the GSP falcon
> to its original state and to remove the WPR2 region. I don't think we
> can/should run them selectively, as they don't undo work in the same
> order as the boot sequence - or even from the same microcontroller! For
> instance, FWSEC-FRTS (GSP falcon) sets up the WPR2 region, but it is
> tore down by Booter Unload (SEC2 falcon). So the best we can do if
> something fails on the boot path is run the whole unload bundle and hope
> that we can recover.
>
> For GH100, the unload bundle just waits for the GSP falcon to get out of
> RISC-V mode, as a consequence of the `UnloadingGuestDriver` GSP command
> sent by `Gsp::unload`. The problem is, that in case of failure that
> command cannot even be sent as the GSP is not up! :) So the unload
> bundle will either succeed immediately (if we failed early) or timeout
> (if the GSP is already in RISC-V mode and stuck somewhere else). It's
> actually probably better to not even try to run it in this case, and
> just wait for the GSP lockdown release to try and address the DMA buffer
> lifetime you raised.
>
> Which supports your case that the HALs should be be responsible for
> their own unwinding - only not by running `Gsp::unload` IMHO.
>
> In any case, there doesn't seem to be a recovery path that we can
> execute reliably in case of GSP boot failure. So making the HALs
> responsible for recovering does indeed sound like the safest solution
> (with TU102 trying to run the unload bundle, and GH100 doing... I'm not
> sure what :)) and should address the issues you raised - but please let
> me know if I missed something.

Ok I think you are right w.r.t. it might be simpler to not have
significantly staged unwinding logic in the HALs. That said, IIUC, in
principle, it could unwind a bit better than the unload bundle. For
example, if we fail before we send the CoT message, then we don't need
to do anything to reset. If we fail after a CoT response, then we can
wait for GSP to halt and then try a falcon level reset if that fails. If
we fail sending the CoT message, then perhaps it needs a FLR to be sure
that things are properly reset - I think these are some options for
trying to ensure reset on GH100+.

I think we could centralise a lot of this reset logic, e.g. overall it
would be send guest unload, wait for halt, then start trying various
resets if GSP doesn't halt. This could be some HAL methods I suppose,
and Gsp::unload just deals with running the completely common Gsp guest
unload + calling the HAL bundle.

So that fits with keeping Gsp::unload out of HAL modules, but also
keeping the ScopeGuard run unload bundle in HAL boot() etc so we can
allow HALS to e.g. keep resources alive until GSP is definitely reset.
Then in a follow up we can harden the reset process to handle more
cases.

WDYT?

