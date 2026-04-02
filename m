Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0421ED6AAF5
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EAF10E06C;
	Thu,  2 Apr 2026 17:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c+Rmecz1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012035.outbound.protection.outlook.com
 [40.93.195.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBBB10E060;
 Thu,  2 Apr 2026 17:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3350ZtsztZ88bRjxtwt7H5L/KyBJG/7K/HBqu3IFLCCpZqBnJXK4J+8PzkRnDia/zBXH9LFBdihuVVvl14wgiT4xcfyMJdpdjdt+X8sCMc+H9OOIsiAYNVahFupKxiAScTsjLixfaAss2OS5tPuADxSNo7MqD9G4Ao+t9m17Els001fkxYbhMga5AFE68XYgJw4z08U4cFkWutKDim8OXd4sc/XzyqOMTzwYCWym8Qb0LTlDxJmNCGXT6neQu4lAt96ZhX5NM8jjfXuNCNqigfjLvr5OLW5br02hqs8wU3epAxtWr7yWvXrhZ/ahZqkHJKRwwVYT2N1Y/uwTy3cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quCjxGuT3uPWAeXKLqylvdOobHoPP4oAuDSE0XHhvDo=;
 b=JktD6GrhZUn2Y6CTo/L168mhb8gzofLQyUFKpxx7A+6AaO3PJxnhpOq65MK/bare0RttRJPesrxXcJ3azqD1z+GEIE6u0XbStH1smLfkFZ2SGehyLy9RtzF55HtxcS8W46oX6UgR77+C206DCiM4qXNnMuUDF2WUFmca9TctbO8yTQkkZbAEK56oUvjj15/4LFXoOKuvC/PXANvdEChH7BH08WAjtJ2f4GN46zF7zQt7nv7RP+7J+n3A2qX2ifz9loIk1mwwbpzS4xVKkXXsj79FDHyne+U5A6XETlIlyDy6ac9pRCsKY5R9eFb/H8OMdxx7/hEpo+0zwF51QqalGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quCjxGuT3uPWAeXKLqylvdOobHoPP4oAuDSE0XHhvDo=;
 b=c+Rmecz1OYvsQEziqbhWJkGQQ+JBSG/9RnfxDal4/uxFQjgD8EELMp5dsTSStB0LmW3xeRlLrGVB56C5cKYtCoLURuqCBvzLRgG2bGYOkJq5xkjJVka+hI4qfEFrdyZDYMiQRayGMYbSJLzP4Y3+Ht7kfTvTrI7JO0Xk2xXw22k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 17:01:09 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 17:01:09 +0000
Message-ID: <1ed28250-b72a-4aa2-8eed-aeaff687c1d5@amd.com>
Date: Thu, 2 Apr 2026 13:01:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Daniel Stone <daniel@fooishbar.org>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
 <20260331155028.71246d7a@fluorite>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::15) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: c78070da-fb10-47af-544d-08de90d96fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: f4ETQSraoCRXiiGE4AjLm36/MxRc3CebrzEDr32scRMis3Sihvlyr1V5D/T9vXAfE+k2q6d6nKhIVvtOmJ2dwy8c9Ks1BBNar7EvcYBDF/+5Wsi+78JN9VgMKfZRLTK/vRk0HNG8b4W8QEaXdz7GkrtPa7x6HHS8t/1+52wuUEJN3oNMio+cqAyY4qW85lD+nhf8ICQJg+wAMGbR3rDivZ4pCb/0+HRLUxN9OirtyvIQ7aYVWOC68X8Jp+TrMkyqRu/hA5+uQu+BrwjuVBEs88LVrJ4tq42DaanEyvJbIF0wDCgSRCffqJez550zbDgESCnUC5FkArnYRiezr1jYkrHaoW9IQhygNx0dxIGeuTjEQS93jIgvekd6FzwE71jtQREWU19yLebi+kTaUGXh4N6hEN+oPb1KWhcaziKAlg+omLuFWPqMznARTLHwkX/etrQF3V4Q4fiT+1CzeIoXPKX3gITxh1Kb3d1XHnQ/kFOzKiGm73gL2r5800yYDEfXuDXGZZILPv7pH+o3nuAyJdoTq+dxtLD2caLoY88Q3u4BbioqWByYBly5tAIRvRiRe8nq7xAmjYEFkn7+3+YUtJ4xAfj6WBaUeM8jaXrvnWh0xOhAmjZYBPVT+IWxMEAeN7Cf+H8JG5/lOoj4VDpyLuAr0JUMJyLimO2ErwJCiDqEHtHzJo6tF0JZ9eG4MNh+UE9JHPvYGieuEaoGQQ2sHvflVfC+vu2FT3TAp6WoYTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0IzNEgxV1owbFpXQnkrRjhEYUlhQURpa2FZUS8vaHBDU3pWUHptNGVyVTg2?=
 =?utf-8?B?YkdkeTFYOHFJM3k5eEh2NmczaUxzQWdKNmpQMCtQTWE3cDdBM1dQNG8yczdF?=
 =?utf-8?B?b0l0aTNUUDU0ajNTLzNFWkNUTFY2aEFaNzIvSjhCRUUrc1d0K3I4ZHJLTTN5?=
 =?utf-8?B?ZHBZcFFFOU5nU0k2T1ZUbTVWVDBKUklNMmREQndhTDg0aFVKQS9pM2JUVTMy?=
 =?utf-8?B?c053eU9OMnlIaXUyd2ZudTZTNlNJb2M4T1JnZjZWYUJjV3VKVzlyc3NWMVRl?=
 =?utf-8?B?NmRmQ0FobmlHSVIwOGkyNy9icDVyalZqWVpGdHlCVlRoY09rdG56RlVvV3Vy?=
 =?utf-8?B?blM3ZXFLbDdNT0dMaHZudE9WSWI1aXM1UnJZUjZpcGJHVHhXKzc1RDE2SnNZ?=
 =?utf-8?B?NGxCUmtCNFFSTVJZeGtwZjVDV1hKaXp4YkdqdE53V00yZU54aU5OcVZjTW1y?=
 =?utf-8?B?YU5rRjFnVUYzQjdFMkJxNmxYZXVqKzVoK2JPZmNPRisrd1ZMRVIrSmlMRTR6?=
 =?utf-8?B?dEVkTlVvcG9Xd05tNG9Wb0dpdThrejVLcjRWT3VqSmJGZUFzSFQ2a0pUMXJZ?=
 =?utf-8?B?UTVxcnhGLy8zQy92WGdYTVIrd1pURTZoZ1Vmdlc4TFZPOVpIeFRvUzZLdm13?=
 =?utf-8?B?bU8rYStMRzJHNjd2eGIrSkdXQU9WVFJ3YVdibHYwcURBdGRUcGZDN2dLdVJK?=
 =?utf-8?B?dEJ0TEcxMHhSM0VPcFBOZzB1TmFscDJwS2R3a2h1V1ZLVWUyajlNaXVkOVpm?=
 =?utf-8?B?WXJoZ053RElueXBQOXNQSG16QTNVYUIzbEl4YnJYS3g0bDRhUzVIbWxUWGtP?=
 =?utf-8?B?NjVvWHBsTEVsdTU2MGpnQi84NUFmb3BSVitadU1YQUlBWkFQOEtBVHZZN2py?=
 =?utf-8?B?UkJJL0pBQlhoUnZFVVM2Qzl3blJERFVxaThxalRpTDV4RmtUMWVkTzUyaTVy?=
 =?utf-8?B?WlZFTHdEL251YzQ4REljU1FxNThpNmdsZTdqc29rZFNvaXJ1d0JNc2RmMnBr?=
 =?utf-8?B?NHlodzFiWTUrYURtdVY2SWVDNHZOODBMdFZ3ZDNBLzFWR3IxdXQzK2ZyMWdO?=
 =?utf-8?B?MUYzcWY2dnR5OVpHa1NTUGhiWGZuMkVCQVc2MENaa1hkc3hldk5HSWFjc2RI?=
 =?utf-8?B?ZzFOYi94VUhUOFBiUG5hOTNhU2hkZmU3OEkvWUYwYkphMFJiVlZpUTFaQU95?=
 =?utf-8?B?S00xcTdGT3FLazR6bzlYY1ZwUzBpTmZaeUN0bFB1MHpTRTRqQVhVczJmVXNU?=
 =?utf-8?B?UUpXVHEvSmRqZzBLbDBuZVVLMmNTSjlRMkFaTU1qbU5uYm1uSE1sMzhreWh3?=
 =?utf-8?B?UExrajFKdzVHd25nWEUySGoyc2gvaG5OQWRFRDJBQWZ1cXlWOUNqYXoxa3hj?=
 =?utf-8?B?ZjYrQzQwRDh3Tnl3aThhQ1ZnQjBXUTdLbGUwbytabVNiOXYxQVBrWHVkRFNJ?=
 =?utf-8?B?b3hJdzd0MFFoVy9wS1NSdVFBL0E5Mm54WDlpREZGUUIzL2wwWUpqcC9PODJs?=
 =?utf-8?B?b2k2aGlYTnJXblR1U2RDcW12M09XZCtBTWJCMHMxWnN5RXJtazlscktSWURK?=
 =?utf-8?B?NUlucEROc3lJVXhSZEVwOG04UXpGNkZIZnFGbmkydDFzaHhPMEZFZWt4ejZs?=
 =?utf-8?B?NFJIUTQ1L0RycGJMNEI0Wm1KbE4vdktpNkhPODEyUDY2WURtNzRkb3ZDWVUr?=
 =?utf-8?B?dHVLTGdaU294c3RQUWZDWTNJYWthM3RYcVk0eVN4WmE5YVc0MU9rUTNNYmZQ?=
 =?utf-8?B?SjNjVEhTMmplTk9SKy9QOTRNOUNFNjFab3E3T2h1S1p3bUJaMlNxQW4vSE1T?=
 =?utf-8?B?M2lhM2xNRVhVeldqODV1emVBOE5xYWZ0YlByWFlrVVNnaFlqZEtBZlkwQk5a?=
 =?utf-8?B?RUQ5T1huZ3JQNVFzdDFCbUhEdDZqVTZ6cmM4Ym1DUnlYWHlVZDlFMVRxUnFK?=
 =?utf-8?B?UjFrQ2dzSWp3R1NNdE51dXFZQXpUc1RsSFdvUjJwWDdVc3ZUbmtxNE5GZ0JB?=
 =?utf-8?B?cmRuOXJzajROK0o1dkFFM01NRXdWNXdNMHRJODM3TyttOHpvWkRHTDdMMUFI?=
 =?utf-8?B?YWxubmxJYUZlMXM2Z2ZENzJ2ZDQ1MStGWWZ0VFkwY0J0REhubWU3ZlF3aHB2?=
 =?utf-8?B?R3VWTkJ1YmhUcGpSR2QvNzBPVXkrWnE2UHNaNWk0T2toOE14ZWFiMkptVTlT?=
 =?utf-8?B?UTc1cVUyNEhBR2ptN0lVMUM3NGpGYythK3Bla05wL3JOdnhiN3kxSXNuckpM?=
 =?utf-8?B?OXRZUnE5TmFwVjVBOFdDUStBcG9WY2JBdTJHaUZRK3FPT0R5VVdOem41THRn?=
 =?utf-8?B?c3RxajJ6aVRlUTRzSTh1WlQ1WGs4WWV4RE0zVG9GZzA4VWZDZ1Jtdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78070da-fb10-47af-544d-08de90d96fef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:01:09.4810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2atIEu85vwbI6AGtmqn5s/5VwxHpJ20Mrw2zwh5hUHS7ytKmFqGYeYgMVdiwYlCAot+t6jKrIeIFpgEHScG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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



On 2026-04-01 04:40, Daniel Stone wrote:
> Hi Harry,
> 
> On Tue, 31 Mar 2026 at 18:47, Harry Wentland <harry.wentland@amd.com> wrote:
>> On 2026-03-31 08:50, Pekka Paalanen wrote:
>>> People who care about the picture quality down to these levels will
>>> likely want to know and learn about these techniques. They may also
>>> want to explicitly control them.
>>>
>>> In time, when these have been used enough in the wild, compositor
>>> developers will learn what makes a difference and what does not, so
>>> they will adjust their reporting to end users. The most important thing
>>> for the kernel is it offer an unambiguous and stable UAPI for these.
>>>
>>> Policy belongs in userspace.
>>
>> I don't like this as a blanket statement. There is a lot of policy that
>> intersects with HW nuances, whether it comes to power or otherwise.
>> Taking away driver vendor's abilities to optimize will hurt the Linux
>> ecosystem in the long run.
>>
>> IMO this needs to be evaluated on a case by case basis. There are
>> many places where it does make sense to give userspace a greater
>> say on policy, but we don't want to push driver (HW specific) logic
>> up into userspace.
> 
> It's not something that's _just_ specific to a particular
> display-controller manufacturer or a particular IP generation though.
> It very much depends on the usecase.
> 
> If you have a laptop and you're trying to give a presentation,
> applying dithering and/or DSC makes a lot of sense: you don't want
> your battery to die, and the projector's probably going to obliterate
> half the colour anyway, so might as well as go for the most efficient
> thing.
> 
> If your laptop is plugged into your big display at home to write code,
> applying DSC to cram the highest possible resolution + refresh in
> would make sense. But if dithering only results in a marginal power
> saving, and your laptop is charging anyway - why bother degrading
> visual acuity?
> 
> If you're a media player, then you're in a good position to know what
> would be good to go over the wire, because you know (& are possibly in
> control of) the format over what comes in in the first place.
> 
> But everyone's tradeoffs are different, which is why sometimes the
> best choice is to ultimately leave it up to the user. If you dig into
> any media playback device (STBs running Android TV, Apple TV, Fire TV,
> et al), you'll see that all of them ultimately allow overrides for bpc
> / colour model / subsampling / etc. Those aren't just there for fun,
> but because they are usable to real people, and it's not possible for
> Amlogic or MediaTek or Rockchip or whoever to statically decide that a
> certain configuration is going to be best everywhere.
> 
> Right now we have drivers making magic per-vendor/SKU decisions,
> without even so much as a feedback mechanism to userspace (unless you
> count debugfs, maybe) so it can even figure out what's going on, let
> alone control it. To properly support some of those usecases,
> userspace needs to be able to control what goes out on the wire, but
> as a first step, it just wants to be informed of what the driver even
> did with the properties we gave it.
> 
> The end game of this isn't Weston logging something to stdout, it's to
> surface things to userspace so it can guide the kernel into making a
> good decision for usecases that may not be ones the silicon vendor
> decided was 'probably the best thing' however many years ago.
> 

I agree with you.

But I wanted to respond to the statement that "policy belongs in
userspace" and add a bit more nuance. It depends on the use-case
and in any case, it's important drivers have the ability to set a
good default policy for a given HW.

We're still missing a lot of toggles to allow userspace to select a
desired policy and I'm sure we'll be able to add those where needed
but I agree with Michel and Ville that we need to get the end-to-end
implementation right.

Harry

> Cheers,
> Daniel

