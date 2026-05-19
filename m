Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45204CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A732C10E38D;
	Tue, 19 May 2026 08:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lNstWQIk";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC47710E38D;
 Tue, 19 May 2026 08:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMuJLh1Kav/tq8EcRofSd5DBDWg96Tm4b9DnKHbGcUf+nXoO1Bg4ZjalDuT/dcP6R7mxSt0j47CTuOhl4nqTA1CbPsbfuafTCYhG4XoXZCheHRfiQ979+J3W7gjCdyeasVWMo0PKsexM0OIgbdwGtgVC5xkCitDfH9ipXrN6RRdL5rinFkKRKeOYcK3DFazVBbh5KIobsM2iFp5x3+WFSio9l3PTmEeaZMxv3uZNpMbmJg6X+rwLEYFoBVERt0ipumHz+wCJGB1Ap35T33d+H0olpuFDqm2fDGYQJBjLJPtu8NWCRoLlWl66c/6rC9jb9xalxY4wrFg1UqAVIL6TNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdt2ufe5Nf4Xh1pVLZNJdJbP8FvV0ky+yp6pl2On0Xw=;
 b=eetHJ0UbttrHloj6JFdoLXWiV6wmonKpnNByjUxJKv4k95oagBnCpEy+wS00eYXuaxadSDjLC4pxNFMQS1DDjWC+TIMWINkVQv1thZfbcp24Yn1RNQTTecEUxaqe5suo9+YnmBsPSP0gsi1/q9YR0R9cY8vmDYsz7LgjawKCLFisOgJ1Ey0T9LRa7XMW0YA/+jevyz6IKpyN0EIQkZjvJhtty/AOVfRPbDH+0Wd1ZUJHQoPSRHZplb85pJfZ4EV+1aIT1LeTc8GFS9sDBUjz2weuqCYDNOFvWGwIyaylVXSLRIIiZSizO5Mh1B96Q5sa5E6uP6j/N/mUdHXZGenlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdt2ufe5Nf4Xh1pVLZNJdJbP8FvV0ky+yp6pl2On0Xw=;
 b=lNstWQIkh3aRn5maMLmdcxDQDlsvft+98atXjH5f76WkYzRkAIPKcjWp501iUOZ75WeAt2tGAIZYb6xUgqN5LBAaVB5QpmsObqLH11G/W9FiYEKLvkWmMoZ0A64K2rNiXESjLwrC/9snSimRfA5jcWABIFDq6SfZ/Lvi4+s4lq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 08:18:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 08:18:09 +0000
Message-ID: <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
Date: Tue, 19 May 2026 10:18:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: Julian Orth <ju.orth@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
 <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0704.namprd03.prod.outlook.com
 (2603:10b6:408:ef::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 516690f0-9c46-4857-911b-08deb57f294e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|3023799003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: CFPTJzkcLhe7SvmUVZG3AATO29fXnhMroJayWC8s+mOtDeMtBpZingtX3Z7N8GD16qade60lT4TGb/xLnJ9XxgMYEkFmcGK9pD+D8qPEVusIFOKKZWfJHUWvHhALIfjI1Vnym0Kc8p380d4OGKUm0Mm8w2vUIaWJatDFq+CuprqwLX5CNgs/ogwKYhtj+VmgJ0hi+j3GhaxZT1fLspgwRwSUlU1H4DgxlbJqQF5JGzu70VsVhaa4imRMqmS1s0kYz+9VAy4AHkNxrYIPOjddbkBsHWDpDeYi4bxWQVf1ftMuZWyMyAFo0R5rGCITXL7rpJOYnmE7TSaH/hm0crhfnZR4rqc63aX8YfbSE8OJFM9hKwuMRwJD4V3MXN5nd6gF/ULr2uUvtXrBR3+YR9sxGEcAGB1is3U5kQDv3R12aOhIkSPo49LrAfXHPW311CD8mgn1HB6juRQP7KDg26JisVE5z88xrlSRZ7mbPRbMfODOaoS7PQnx8e35zPERh+16Ggi0zemb1FFV8lfth+4Jbgtsw31hwg3sz1Iog694HZ5w5i94UcR6SnIF7FqjSH5hXhNG3anvqlqVltE6LYiJ1WwvfUJEMu27U4N5Gs0gjX0/5ToTAUKBuNnN2AsrMbfd/EPPi107BkTiAYMJOGtyVOze5S/xlkZykuRVTgeg2NN6VWisq0KSXpIncW1HSsARL04Ayt/e5ganhXCrCZc6vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(3023799003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andXVXp2cFc0WnpCMU00OFdQNC9ldjVMSTF5NVYrN3cyaFAvVVMvZ0dnSjl3?=
 =?utf-8?B?S1hBdnEvRFk5MTBqYWFsd3A1dERUK2ZaeWtJTG5DL0RVWGNMWkVXZXUvcklp?=
 =?utf-8?B?dm5pNTVoTm1URUd5SnFxT3JveHRnSmZ4eEdmTkExMWpBSnJMdjdzaDZoMWVv?=
 =?utf-8?B?Z2JlRDZkMXorM29iUUpiYVFrcHQxeVlpVHRscXdxNHZmbEFFR3lLYTRoaG93?=
 =?utf-8?B?TmlRN3R6ZFJIOUN0cDV0K3FXSkdJTUo2NTU1bnQvd0c5SENsT0RkWTJRcEtK?=
 =?utf-8?B?d01ZYTVNMExmbFhNUVh0RXpVUTZtRkM5R2N2NGZJaGpKWUNrenVnRm5qR1Nh?=
 =?utf-8?B?ak4vV2VKVGtqdCtXTXFFTVM3N2JZVEVzMjdoNGpkcURMZCtzbCtLaitHdmRQ?=
 =?utf-8?B?KzR5L2dtYnVrYy9lQjllS2R4aE02L3R6VklHWjE3dVNnQldDM21xRDRXYVJ2?=
 =?utf-8?B?NnEzZFZBcFpSVEk0RmY5OXJiNVd3WER0M1VETWljSkU2QXVQTmZoVk9aOGFS?=
 =?utf-8?B?NitHT3poSHNZRCtlVzB0TXlJTnVHdjQrRnA2aGhrQkdBc2s4d1c3NTB5bDcv?=
 =?utf-8?B?alhjQWZZem5qOHpyUFFmcFdLbTJPdStDZGZPQmlkWHlML1d3SEFReTRnS1pl?=
 =?utf-8?B?YTlMcDgrOXJjQlBsU3JzVzdiZVh3bHdRK2JZejMzT3dlNk9IQW5BOURoYy96?=
 =?utf-8?B?ZnBKemZ6aTBvOXhTMnVYejhQODZpQUFNM0ptSWE5Q1ZPTFduVTl0S3g3OTR2?=
 =?utf-8?B?MHRtb2ZXTHdWRXRXbzJXdko4TnBxaWtiOHQ5ejRiNnYzSm1GcDlCazdCRVhQ?=
 =?utf-8?B?d3BvK0M3L3lxNkVlMXRjQm13YXVGOTk2UlhSZlo0aXNCeWVKeGxBcTR2cmNy?=
 =?utf-8?B?QVdmc3RiSjFKdWgwS0hNRU9rR2VoSGVWemxYUWlVYVBLM3NQWjNyc0F4STBK?=
 =?utf-8?B?Nk5SSWF4R3NHNEJPcjNqRFVPeVdWT3dnVmhtS3llTTJLNjJwM3VITndoTjJz?=
 =?utf-8?B?WkNBenp4S1BBRU5TS3Y2ekswb0pkeTIvNHRJTks4Q0Z0ZGRmWXNxclZjZXFS?=
 =?utf-8?B?eTFzeHJqcUVXUVpibHB2cUpCMHBnWHcwVEc0dTgvZUtzR0I1bm42UEM0K1lm?=
 =?utf-8?B?c2dvZlp5b05ocm5KL2ZOMnVhbDVFUmZJZjlBTW40Zmp5blN2WFJBejZRNzhn?=
 =?utf-8?B?cGNiMFRheFBZbzJHMlQybFlXM0dUTDdPT2ZyUldoMFByVCszNTNhQmlmTHA1?=
 =?utf-8?B?anN5WTh3dmJveDJkeEJtSm92aE1uMHNWaGRlYUZOS2J6a3RJSW5wUkUyckZX?=
 =?utf-8?B?YjZpNEhPR3hjMUN4NXlFc0hUcEhybGFaaVFvQjJHWXJQNVNkN1VZRmg4SlpS?=
 =?utf-8?B?L04xVlJkSWxDYTFBeEptM0l4K3p3QXlkdU9kbE1MV0ZZU3ZOWndFOHh3bXM2?=
 =?utf-8?B?ZmsxK2NIQUp4dmZsTXU4Zk5jM3V0LytwWjN5VEE4eWhsa2lzbWFoMXZ1QVIv?=
 =?utf-8?B?QXNQRU1vWHl3Z3UxcFdaQXQzQzN3enRrdnlYeEpIanZId0dmRHA2b1BHUEY4?=
 =?utf-8?B?NlE5ZjdlNlNndEppcGR6TDFwU2Z0WGg2S0hhVEllOWx3ajVqYm1MSnNYb2cv?=
 =?utf-8?B?UGhwd3NuVUpLdkhtTkhTUFh0VlVVcjQxTjNDZEJrZGdYTDZFSlM4TEZma2M2?=
 =?utf-8?B?VWhaVWtSbi9IZkpsRU1IbExmR21oamNPYmlyWmthTGlWMjE5dlR4SmdFOHpZ?=
 =?utf-8?B?T3FxTXkrSkxJbXA2SGxmamlEZmtUZkNhQ1JaRjBwU3pyV1BPUExjM1l1RG9D?=
 =?utf-8?B?dzVYeGwzaXJYWmhnL01oSDhXSVZubTRPT0lNSk5jV2xDdUFQcWlaeks1STFN?=
 =?utf-8?B?Y082U004cnB0NWRsQlpvSXBITkJWZ2U4TUFhZ1JUcHJteUpoNVZrcm5VL2xZ?=
 =?utf-8?B?TVBPNE5zSFVqWDAvaG8vWlNreThQZ0E1YlM3eFNpSVNyYWk2Q2kxNWhiUG5u?=
 =?utf-8?B?VXIwMWpwemVGL0M4Tm9hZVlZSTVaaVNzWjhIc2JhbE1NSTNVME1mVk5vNmU4?=
 =?utf-8?B?MzVUMmF0cUErM3JhZ2dUVnEzMU1aOURPa3NMcUlORkxPZzlXaUJKZHpHcXBw?=
 =?utf-8?B?akhLZlFROS9ocVBUem9RVlVrV1Ixd2RidXphVXFJZTlyaHNsbkFIM1VEVzZk?=
 =?utf-8?B?N3dLMnN4WjAvZ2k5aFI4VTdsT1VFdUdZbFhSUWh4VVNHZXgxZ3FkZlliWlFu?=
 =?utf-8?B?YXl3KzZudk9teGdQVUJtNkkyZnhzaFAxYVJTTHplQlVRTnRlWGREZGw2NzY5?=
 =?utf-8?Q?c6wtNeuk9Ae0NQPLP6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516690f0-9c46-4857-911b-08deb57f294e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:18:09.3016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr7OtFUqQHK8vI/daEkTbxnZS3gxADwqoZAsy1yJIMIY/7X1ipcVIC6XRUbM4oud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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

On 5/18/26 14:58, Julian Orth wrote:
> On Mon, May 18, 2026 at 2:41 PM Christian König
> <christian.koenig@amd.com> wrote:
...
>> It could be that we have eventfd integration for that as well now, but in that case you could give the compositor an eventfd instead of a drm_syncobj fd in the first place.
> 
> Yes, all compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to wait
> async for the timeline point to materialize and/or be signaled. The
> wayland protocol was the motivation for that ioctl.
> 
>>
>> So as far as I can see using drm_syncobj for software rendering really doesn't make sense, eventfd is a much better fit for that use case.
> 
> Using eventfd has some disadvantages:
> 
> - We've just added syncobj support to vulkan:
> https://github.com/KhronosGroup/Vulkan-Docs/issues/2473#issuecomment-4446117280.
> For eventfd we would not only have to add yet another extension, that
> would realistically only be exposed by llvmpipe, but also every
> compositor and every client would have to support both extensions.
> - Similarly, a new wayland protocol would need to be designed to
> support sync over eventfd.
> - Eventfd does not support timeline semantics. Meaning that you would
> have to send two eventfds over the wire for each commit, one for the
> acquire point and one for the release point. Whereas with syncobj you
> only need to send two integers per commit.
> 
> I don't see the advantage when drm_syncobj already does everything we need.
> 
> You seem to believe that compositors would not be ready for this and
> from that perspective I can understand your apprehension. But I can
> assure you that compositors are already fully set up to support all of
> the usecases I've described: The wayland protocol requires the
> compositor to support wait before signal.
Yeah that's much better than I thought it would be.

And that eventfds don't support timeline points is indeed a pretty good argument.

But I still don't see much justification for creating a /dev/syncobj device, this is clearly something DRM specific.

What about using VGEM for this?

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
