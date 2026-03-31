Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3999310F92E6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A57F10EB06;
	Tue, 31 Mar 2026 17:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmsPiYRg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84FB10E1D5;
 Tue, 31 Mar 2026 17:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLkPS6Nx/3toaOltWmXE4Rbg6hz+astOBIBNdzsbzddMQ2mnkB76VDgdVsMuA0cxAzTpBFDXcsPYd1kshSQ1yIOdxnQmkQH6FhWmY6jwSCtQFTCOoJ1OEWPcSFYOQDwdVT2bSs0JjRGy31w3ZZNmlAzYXuQZhDxw44m8MsytkUU+ebaJR0PDq2ZRvODu17LZTl+TkHhfs8mKWmkYX6uMeK0ERhIdyXbdup6Ch1hXVL1/WjVwyGG5zaADvHXzMhkoO/3HHb04Y0y6/DUqGg+JNnL9NLsS1yGZVoNFCo3rXKI0f6PXvGOrMacKZ/Uj8v7HJeV+O1t+FfrUmePtmgvCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0NJ4DI84zx+2pOiaXzEieaMR6WRjvfD75KZR1+0sdQ=;
 b=JtR+dMNPT0Bh7AUHZFcvdJH6dQ7TkQJ95MgipEH6R9nu0/YQC+FeE2/ogm8wBiY7hIOHCElMuGPAv0qYYyP8HVGc8t0nKxJMuIvLKcK1QAJqfsU0onpjBBxKWnFV6Pku0SL1qyLFEk5HwqC6MdNQzHNIfuCBoRsTfOjIZ6GO/NUNLIpKLQJnySaawusew9AGXfz9QBPw+9MAUzXhTUjgYgXzQmxJdDsP3NUxcayXnVG1FWn7LeYe1MatgHMDCVlSMK/Vcdwx11NQ2ndYhJbYwrPMutaWw8C/sdWsQs07M5V0l1AymNIVYOQX/LYzGivj93+06UtMSFksdN9Haw3hHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0NJ4DI84zx+2pOiaXzEieaMR6WRjvfD75KZR1+0sdQ=;
 b=EmsPiYRgNkiE50BouqkLGeyWYkoK/oXFNmlsic4QaJKxKqcIi+/zXJo/03ykcZsgDYycjJE3o/K1IW2oSUwwXNL3zCA/QURLeAgEFMD71PI8RzKXONChsmZlbzn9qcxUo63t/spPgBHd80qi8MTpXUcucNh/MBxh+8G8dAaXPt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 17:47:33 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 17:47:33 +0000
Message-ID: <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
Date: Tue, 31 Mar 2026 13:47:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
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
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260331155028.71246d7a@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::12) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: a91d8968-8914-4cd9-a07f-08de8f4d9684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: tu8gbklVsGkCmjsrqAy/8YmTCy/fOOVt/EjcJRzrASmKlgXnaByUFzLL8K2kZyr2RtxS1tsiTsqFf64TT9sdOM2+mdQp9mwNZ6NdBB7IgYp69gVX24YVPLjbfgzcG6azh3zcCrnV/YV/wFZnvarXH/NEN1JBPN1/ms/iAUkN67bM9pdjfAN6VsU8S75+6fFE52/QZjPEqPUSllU/VBGCtWpweFMF9oEiaRHrKZtgLKNe2WqxQsSQjkqy4JNWJWsu2K2eOMOs3r/iH7aKK8cKKDHKWgQqtz4S1gXrXDVR8o/okz0XiUNNEWF1rbssKsVuwGr8UnPcax0eHPeyWnYl7kpARgZelXDH5anXNthErPXpRdkLiu2Ttysw4oTM9zpcbx0r6GPGQEfjde7IPBs0cRj2wd7pZMqdOINPyeCFMlSMPGujYHxIEyzckkSfh/X4EMtTnAC1n4hNfBFG14k9eMnH/prwcBfCfLKLQWxCU58M8Hh5BwdU3smXHuax8QPqM+Suw5x56wUR/PBIWYvOhWhzx5g2Pf+cf05i7fwRYMvN5mCpy7NMnRhkHEoZbShde27Dez75jfbe7G5kw+EKUUPDu4Ac0ixKfS2YW5m9zN7A6LklXAFl1obRSlmVlAEyaSvEf8+iOqHlpFeb+Lpvc6SdwOb9o9uXZF/4WnlQBMBWyzO+oltnqECqP9D5W59+nElHk2wEnMtg5G9rcrb+d5UvoZC88JLxS8S/3bBnXLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDEvWWNyM3dzaFk2S0hYalIxRHUyeUpHdkZwRVNNaXFxaUZiZWlDY3IzK2NT?=
 =?utf-8?B?NTJsdTZ0QXFscU5QYklVTjIzbFVKVnJxdElkQlYwWlBIbDBMMS91aHlsZWpF?=
 =?utf-8?B?WDd3cUdueVl1RTk5RFBHcXRINy84amk5ek13b2x2OUNaVUNMTXhPNFRVTnk5?=
 =?utf-8?B?RHN1dk9VeVZOQmRhbGxUdS82aktGcHJWSUpHaVJRTWkreWdOaS9NcUU4ZGZX?=
 =?utf-8?B?Tm5tbGYzMjJBVHlhTHQzRkw5RFNBZEhLVU1OTjRoQ1B0YmxQL3kzZW5ZZzIr?=
 =?utf-8?B?UXpOTEJRSHFBcHUzOFNZdWlIZmh3b2Q2NkNPNmFmOU8raGFmYWpuRXI1NitQ?=
 =?utf-8?B?bWlkV09haDFDRCtZUml5a1hDOHlIbzRnSlBQT1VtM0V0TGd5RGRsbjR2OXlh?=
 =?utf-8?B?VHlnTDJjeFZyM0J0UnI2L0lYZTlYZ2FQVk1oVTdoYzgwSHIzMWJMRFBGTEt4?=
 =?utf-8?B?ZllVUjlZUmhSbjBoUFlkTzhVNTNTWGxKcFMzRmJSdUxOWkhiNEJBZGF2MlMw?=
 =?utf-8?B?cm9JenVaT0YvSno2Sit4c1hScDQzT0lGNU05WFZuUXRsTkF5NkZMV1V4Mllt?=
 =?utf-8?B?dnRrTlFpcWhTTW5FZWZSYlBaY20xcnBNcjAyTDZuenRCQktoNUNocUVYMGZx?=
 =?utf-8?B?cFFBSDZ2WFhHZ0dtRGw3OFU1cjc1TkZZcHBjVkozaG5tVHJpUlhMRjQyL0c2?=
 =?utf-8?B?czRmaEcwWWxwOW9NMWd4WFlNWjkyTDNJTEtyMDFBZnpQYjd1STBGYWFNVUJ6?=
 =?utf-8?B?Wkg2QU0rSHBMRGY4WFFzRm1YbXFUTENVei8rb1RYNm1tRm1EemN6UEtMbWdE?=
 =?utf-8?B?VzNqbUJoanJ2NkE0MjBHUjRwajlnczljQk5IcEpwYU94N2g2R1dxcmE3SXpk?=
 =?utf-8?B?cmNQUWJROTZVYjNvS1g4OVcvQnZZamZOWlNQT21oZ3JHZ2hVaExDTmRXOW85?=
 =?utf-8?B?VWlMZkFCeUovL04xSnVIVXZFK3l0U0hrRDVLR2xlVndWdXlRYTFNWlpvVmlt?=
 =?utf-8?B?QytWT09RZkVSN2VYbEwyajg0NWIrSzczWlFBMXVXa0VBMFdQdWN5dlk2RUxX?=
 =?utf-8?B?RFVja3Fhc3VKcmVKWkFHVVpuWEJBTWQyZHVTS2xla3RYS1A1T2NVcHFFdlFz?=
 =?utf-8?B?VGVPanNvM2t0QW1PdkFLcFhNbDc4MjRtN1ZrdUNvUXpyZCtFa3dybHhnOHQw?=
 =?utf-8?B?SEZsVnlFTTYwTTlhdFZ2N3JoSm9RRWFKZ1M5R2toMmRoME1uWTNsVkg2V0pK?=
 =?utf-8?B?bmJpUys1UytxYmdFeU5hd2VZL0xKdUZKdVcxcUwzYW5OamdIZkFiMVZITzZp?=
 =?utf-8?B?d2hhTU0rSkRyY3NGTlI3bHNRaEZuNUNJb2FBcDlNU0tCRW9RaVlOR1hQekxZ?=
 =?utf-8?B?YnBrc29xcnBpb1hrNjZRcHUzT200NE5DR1MrVGJVSDdLdjFUQzlneVEyd0U0?=
 =?utf-8?B?azRjeTZKT2RWNDcyblY3UkhoVzh3eTI2K1lKZlNXWnlzU1Z6YjY1YkNSU2pJ?=
 =?utf-8?B?VS9EWEw1d3A5VDlVcEJOd1puTlN0ZFprRnJ3dlQxQUF6amxCN3VaekkySGpw?=
 =?utf-8?B?MkZPYVhJTy9LVXlCemo5TmxGWSsvUllmM0hTbk1tTUp2a2RYRWpYbzZrSHh4?=
 =?utf-8?B?ZXhjYzcyRWRZSVNSZGlGbUdGZU9pSWVGTHU2dlUxdG9lb3hhUm1vMytySjQ1?=
 =?utf-8?B?MVhWd2ozQklRc2VyRzRDMi92TDdKZXFqOTdLSURRQ0hjVndCeWovbThDdUpU?=
 =?utf-8?B?bXZUL1lKcmNSUnArd3YwRkc1aU1kVW5MYWJCU3dtaG9LeTBuTCtQOGExVmU0?=
 =?utf-8?B?QWNTT29rNnJkS0UrOFlvbGtKUlNJTGFabUdvYkZaRTQzRXVHRUJsOTBLQnc0?=
 =?utf-8?B?bkZIRGYxaGprSXpqRndpeUszeWUrL29OZEt2eGlZeDFGZnh2ekdBdGI4NTln?=
 =?utf-8?B?VC9iSVNUTVNqK1ZtMkhZSWZ1cFFnNmFFUW01akt3ZDF6T28xcmUvalFBTnlM?=
 =?utf-8?B?TUg2aWJyNUo5QVgrVi9NUXNzZGRpRVN5aUJSS1E3NFJXNjM5V2tNMDhqYmlW?=
 =?utf-8?B?YkV2STArcGZuNlVaendzWlRoRVIySUNQSHNENDdwcXFSUCtBZUZOT3BUWXY4?=
 =?utf-8?B?WlA5R3FkRW80cnZCL2VIZ1FDZm1EVUpQcVFlVWJXK0laYnVKQXRUREkyN3pO?=
 =?utf-8?B?QjBWaHl1TWJkVjBMYUdReVdpVDhYbVlYYTNEUHprNldrY1FoNFdkY0dubTRJ?=
 =?utf-8?B?MXIyL2ppSEg5bDRVby9TNUg2ek40M05xUC8wWis4QjZnWTNtd1BFR2xodzZM?=
 =?utf-8?B?V1IzQkR2TWJOdkMvQkVJM2ZpYTl6SVJCdlJzcGxKVFV6UFM1bDJSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91d8968-8914-4cd9-a07f-08de8f4d9684
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:47:33.5101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnhFqADfVz4UTHXcL8V+NnUWJWRW/ru1Nv9mOHAVE16nzCKq/d7Ti0HC/U+ynNtrZBZ+6y8LCdXjHPS4gO0xNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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



On 2026-03-31 08:50, Pekka Paalanen wrote:
> On Mon, 30 Mar 2026 14:52:23 -0400
> Harry Wentland <harry.wentland@amd.com> wrote:
> 
>> On 2026-03-30 12:57, Michel Dänzer wrote:
>>> On 3/26/26 13:17, Nicolas Frattaroli wrote:  
>>>> On Tuesday, 24 March 2026 17:44:21 Central European Standard Time you wrote:  
>>>>> On 3/24/26 16:25, Nicolas Frattaroli wrote:  
>>>>>> On Monday, 23 March 2026 18:27:41 Central European Standard Time Michel Dänzer wrote:  
>>>>>>> On 3/23/26 17:55, Nicolas Frattaroli wrote:  
>>>>>>>>
>>>>>>>> "Someone might not understand its purpose" is, in my eyes, not a valid reason to
>>>>>>>> not have this property, [...]  
>>>>>>> Per my previous posts, that's not my concern.  
>>>>>>
>>>>>> Then what is your concern?  
>>>>>
>>>>> Per my previous posts, my concerns are:
>>>>>
>>>>> * The meaning of the "link bpc" property value isn't defined well
>>>>> enough vs things like dithering or DSC, which will likely result in
>>>>> compositors / users overestimating what value they need / want,
>>>>> resulting in compositors spuriously rejecting configurations which 
>>>>> would work perfectly fine, and/or spurious issue reports.  
>>>>
>>>> Dithering and DSC are supposed to be transparent, no?  
>>>
>>> Not really, no. They achieve higher "effective" (as perceived by
>>> the user) bpc using a lower physical bpc.
>>>
>>>   
>>>> If a link bpc is 10 but DSC is on so it's 9 on the wire, it's
>>>> still 10 bits.  
>>>
>>> If DSC encodes user-perceived 10 bpc at a lower physical bpc, and
>>> the "link bpc" property reports 10, that would satisfy my concern
>>> for DSC. 
>>
>> Conceptually I would understand DSC to not effect the reported bpc, so
>> a 10bpc output bpc would be reported as 10bpc via the property, but
>> DSC would compress that down to a lower value on the wire.
>>
>> Dithering wouldn't do that. An 8bpc output would be reported as 8bpc
>> even if dithering makes it perceptually look like 10bpc.
> 
> That seems quite arbitrary, but ok, that could work.
> 
>> I can understand the challenge of how to intelligently use it to
>> report anything back to users. I could see some compositors being happy
>> to use the bpc alone, while others might want to know dithering and/or
>> DSC state (compression ratio?) as well.
> 
> People who care about the picture quality down to these levels will
> likely want to know and learn about these techniques. They may also
> want to explicitly control them.
> 
> In time, when these have been used enough in the wild, compositor
> developers will learn what makes a difference and what does not, so
> they will adjust their reporting to end users. The most important thing
> for the kernel is it offer an unambiguous and stable UAPI for these.
> 
> Policy belongs in userspace.
> 

I don't like this as a blanket statement. There is a lot of policy that
intersects with HW nuances, whether it comes to power or otherwise.
Taking away driver vendor's abilities to optimize will hurt the Linux
ecosystem in the long run.

IMO this needs to be evaluated on a case by case basis. There are
many places where it does make sense to give userspace a greater
say on policy, but we don't want to push driver (HW specific) logic
up into userspace.

Harry

> 
> Thanks,
> pq

