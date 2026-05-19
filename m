Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32653CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BCF10ECF1;
	Tue, 19 May 2026 13:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZNr9YIU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911E210ECF1;
 Tue, 19 May 2026 13:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDfUy/H9B2OKVVYK9iNc/s43F4rsl/pVGQY0W8LkmtAS4aK6mLEp3F/s+LfG18JXAUrYQ/QKQTksyi0voBAt6jCt+T5ifq1v5fYctdb68p/TBVz1wUAqcguTpcsJ0x5rZ/sXhVO0VZzvIPyXH+Frbpj1o+eoxP7HS96xxg5ltPg9+M4yuYZbFlHz3dTnyjnbDCcrrHgUAqnmtndF3a//xrgbd0yHx+3cLrohfd9nxq3n45KOq0Ok1HDMFoaLDVclxlZcgfLG6Z6WSXRND/V3GxG+HQnH1NIkDTDaqn85CehGeDCMkDxTP2adKQH4iV+BKUOgMnLfx6ELe5Qi2MsEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTGTwFsT6mK9W9lL44pUtWMh17Wdka4kfHZsf6oj+Vk=;
 b=foZohj2QGgCETmX2iRYT5gxIy2KJzdijwNt+1nYckGRnemHI/s33ctYtJWg6eJSz6CV8kWTJOORWRajCbyKh64uuiMzJfuZrGEaZWU/7zT+CRxe5r43pcWxFg3l9wsXIDraY6HVMUCL+9lqvKhTnCNyX6p2j/AD5YSuHkHA8rH77dNQsm/9h6YFfVdCv7MDHHYXcnnMS9EPxvrdq8lEBmn1KUre5tcsSUjDKFpTibo+0nhWv7lqjrOzfZrLn8ft+mCcuCInT/vI7laGUKSXYYcV4ql9SqFOkM7IbzpigM7wYLdTZt/dbpugJ4cF5WsQ43wmGlKcJBC8UA5DpaIsCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTGTwFsT6mK9W9lL44pUtWMh17Wdka4kfHZsf6oj+Vk=;
 b=mZNr9YIUsibbTZ6M+EQ7Sh9bPB65nvY96+aUhztoT8LVfi1vRDa1IdumR1WmhBvpTIgUgrROYDRSeuRj8smdzbCY4FwpTgkgfJWdLKOi62B3XzeVEd9uQXjSy14zi1FktCGtdu2/pyR++pMi5NIyFjHc6ed4EQdWP8ItX4AWsDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 13:28:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 13:28:29 +0000
Message-ID: <5ee6d5af-ac48-41d7-a19f-e08a3c5b7d19@amd.com>
Date: Tue, 19 May 2026 15:28:18 +0200
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
 <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
 <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:208:32e::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f047e07-93d1-4261-0268-08deb5aa83ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|4143699003|3023799003|18002099003|11063799006|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5GhQ70yXH0dM24buZadQlnyvJcoUf8z9cDFxWSCXUX9eSw0+G63cEH8R5ZncOdfgmlHEuAM7X27uhqjhW49rNFAfHbpD8ecyvstVBLDsdxacU/EK32JauAS4w6jO6PWNImCWsfpUNbwdSNw3f9x0cW1HS5ajsjnlW3NhC4MB8mlBmjWcvEmb1qscM4FFLkicnyUU30XX4GVQ35oYPcHMXbV/OYRtA07MuPwXgz8fFWQvlBr7jfmaUk1SaO+wif1AdWagx3PtcTjFzzmzfDbrnodHaUOKTYBzBLiwv22IQoHsxgwAImhsxCd1xTUrzDHZn8og84I939RzmpKoc32CbXXkW0o4XosMRGcvCJnz0/LkACUOWGaTSb4ZoVC01Tpz5WwhXTHg8z9GYSy7U9xFsOrbJgBh7zeoGWFEqqp4UhsXE+e1tl6S8OdW85dlUrZR2iO19pkUwi/gtWi9yGSpZ4TkLNQN5znrO8pBfU2vnXnknfCyWiSPpy7d/eCkJbdL01w0J5IarmCEj8ZvIseJa75ccAgcZ0hMV6rq51zh7dztQmYvkQCXQFWx7RtCvM6yhoVbcwuEq55cuPkBoQX/wXbhFNppd+yoQp5QswlhUTV5tXfS3oF6BDN1eKTO3Ax7ZaxvtaHo+VksCBnXLaTFQSrFk/yHXAgtBCJHd+J9wDWnjmj9KciJiyFCR3yJv7tmCO2Ec5/WkTGUjyxqoGmd5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(4143699003)(3023799003)(18002099003)(11063799006)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RvZU5KODUvZHVzYThnR1hWTFhNL1ZjOUdkTitVT1UzTHFDUCtiN3JSUEcy?=
 =?utf-8?B?RGF0VmFLOEM1Zk5JT0FVc3lJTjBJOTVtRS9JN3pEKzFjMXpXNFdTOXA5Z3RX?=
 =?utf-8?B?THAxbkVrQzlyYmpJc2htc0h0eHgvZ1Z4VXMzTjJIamRmMFcxdVg4OHZWajk0?=
 =?utf-8?B?ZU1mYzUwL2o0N05wbDhLbXdVQ0Nvc3FVNW9ZMUVxMTRnR25hd0o4cm1uQktj?=
 =?utf-8?B?RUdBUHRCbU1DeU10RlhFaldMdVJPUEl2UFUzUklmWGtrUC91MUVCcFpKdUZ6?=
 =?utf-8?B?VXJFS1BnNlZuWU4rN0w2RFhNV0ZIWFhoL0lhWWhQWktIZFJLdGhSNWRDR2lk?=
 =?utf-8?B?Q1dsRUMvYlhYRXVQbmZsNEdrbWluNzVNY0J2bEl2OTRJb3llanQ3Nk0zMXBP?=
 =?utf-8?B?RHBEcnJjenIzK1JRNWNBSndwV3V0Q1ZrYTUxSFV4dTU3UzhQZEdmTEtraHd3?=
 =?utf-8?B?bnl4VWhPSDZMd0l6MGV1RlVhUTdLUmx1TnRJTzNTZmZDdDh1enJlNGhyaXMz?=
 =?utf-8?B?aVJUenVPL0ZXYzJzRDlJWGhlSlhMdEpUZktoSnlKVUVUdTdJR0plT1lEZm1n?=
 =?utf-8?B?cnVxcW1BNXhmb3FaWGNpd3gyM1RIZVFBMWtDY2RlQ2taV093SUFoOWZxTXI5?=
 =?utf-8?B?RHhGV3l4ZUxYWXBxbnB3OEo4dXpUOGpBZHUrbG42YzNDdUpRdHdDUGh1Y3pE?=
 =?utf-8?B?K0NnR0YwUk9Ja3ZhdTJKZlpuZ1hsNnd1TWhycU1JWWdRVkgycys1Q3J2UVRx?=
 =?utf-8?B?bUtiUit5dFlMN0VmRUdsRGNmUEhxcE1EZGw5UW5OUUE3M0ZISHFjRytBY3BH?=
 =?utf-8?B?R3RtcGpQSExRUEQ0dGcvSklOZ1BYdGJGTW1rRks0YnFuNC8vYXZsQTIrS0h6?=
 =?utf-8?B?RXp1bFMvOGYxL1hnbFluK2xTY2NtRnphVXN3bG9ZaHZYa1UwRFhVSmtMZDJy?=
 =?utf-8?B?Y0xWeEEyakwrUkkvYzlBNjVMWDVJZVVtWHJYZE1ySS9aWU1pQVNHOHdZYUF2?=
 =?utf-8?B?MHJUcUZ6blB2TWlWYkJyUEJ3S2F4V2IrTDdzOUh2MGQvajFGN3FQS0lhQ3Ju?=
 =?utf-8?B?SmhNbm42YUxmbVV6SlNzNGNlYldzRFVIc1dvLys0TFlBWGcyNThCU3JvNG1I?=
 =?utf-8?B?bys4bW1mYWNyeFhrcE9nZ285dDdmZlRKNXo3NTJKQklCUWdVczZwM1hRemJM?=
 =?utf-8?B?dEVYVzc1azBqaERMZHZiVnpJaWV1aElkRWZ5QkF2UU9FSU1iUnQ1Zi9WMlBZ?=
 =?utf-8?B?anZ1MWp4WnVhcFcvRmdOUnFaTkpqMlpiYVQvM2tZT3dSL1FrZExoVWIvMS9z?=
 =?utf-8?B?a0lObEwxOUgvenI5dXVycXJmM1VkTG50QW9hazMvOFBSc0RaVGJGaDBsWGlQ?=
 =?utf-8?B?dWREWVlYWWJHNnVQUnhwaldJbVVBeU1LKzZTZi9WaVRNUWNJRkRJSTA5Y3dj?=
 =?utf-8?B?Q0p6SjRLSVEreXZPZEZDSnRSR2NLYmZMZ1o0RGZOOXR1TXVJQVU2Z0UxL3hk?=
 =?utf-8?B?OFMraS9oZFhJUGprUjdmVm1oekpRSVFwVjIrZVoxOE4rY3RxK2x2cXZ1Nkt4?=
 =?utf-8?B?enZyV1J2SXFkSkZJWW9PWkp3MlkxY3B3UWxiOG9hSG1zMXhJSlBIeFhaWUVt?=
 =?utf-8?B?OVJPOXVqYnowMTNBQS9ZZEk2d0tFMXpBVUw2Qzg2Q2pXWE9zUkpiTzBXTHZq?=
 =?utf-8?B?eHV3ZnlzM3pMNUdmaTExN3c3UFhvREZwSVVCLzBTVUo4UnUzRjZVd2RYSXhk?=
 =?utf-8?B?d3hJV0FFMkZUbmpVT1lhUTF5dE5laWdLZlpaUGpveGJQOFF6ZjRyRFMzNnEx?=
 =?utf-8?B?N0FXUmJ2WDBqSWtBVzEvM0JZQm43QzJKWDVGbFdFa1VRNDczdjE2T0FpUE9n?=
 =?utf-8?B?SWZOQXpIMnAwUXB6QXBZSjRqSDF3ekI2b0o3bkgvWWpXVG1QeVVQOFFkeFgv?=
 =?utf-8?B?cWJrQmxxTmpnbkYySERReHl1N1BuazdjWXZXOFluQ3ZFWUkyWWZXWmpoc1pJ?=
 =?utf-8?B?bWMxLzFxTFRHSmFnSHl0R1NDM2pGSkhWZXZRWnUrNXo4WENZNDFWWU9SWUVZ?=
 =?utf-8?B?WU5nOTRyZzVDYlNsdm9KOW9YYlFyTEtaZmJqV0VHS240UUNIdzdyRFhHV1NX?=
 =?utf-8?B?aUhsd0JTNnFBNGVNVFJYMFdOKzNmWFNLUUU2N25TZXFpN1hzN3I1anJXTFNS?=
 =?utf-8?B?RDl6bTBMZEpXT28yazNXdnN4MkdHR2JaUjMybTBuZ1dHNXNtZEpkeFZzU1BW?=
 =?utf-8?B?YlhBUkp4UDd6Wm5pbjRmVlZFb3hIeWFyTmZEUlVOSzRaZFZyUWR2ZTNxM0Rw?=
 =?utf-8?Q?RaJ5b8g4HlDXXGQzh9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f047e07-93d1-4261-0268-08deb5aa83ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:28:29.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GXmBbKZ0cPo7s8DmxImyAJvey4jJwU6ZMu+hfKPzqPsZJzQddJes3TehDXfBjMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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

On 5/19/26 15:19, Julian Orth wrote:
> On Tue, May 19, 2026 at 10:18 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/18/26 14:58, Julian Orth wrote:
>>> On Mon, May 18, 2026 at 2:41 PM Christian König
>>> <christian.koenig@amd.com> wrote:
>> ...
>>>> It could be that we have eventfd integration for that as well now, but in that case you could give the compositor an eventfd instead of a drm_syncobj fd in the first place.
>>>
>>> Yes, all compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to wait
>>> async for the timeline point to materialize and/or be signaled. The
>>> wayland protocol was the motivation for that ioctl.
>>>
>>>>
>>>> So as far as I can see using drm_syncobj for software rendering really doesn't make sense, eventfd is a much better fit for that use case.
>>>
>>> Using eventfd has some disadvantages:
>>>
>>> - We've just added syncobj support to vulkan:
>>> https://github.com/KhronosGroup/Vulkan-Docs/issues/2473#issuecomment-4446117280.
>>> For eventfd we would not only have to add yet another extension, that
>>> would realistically only be exposed by llvmpipe, but also every
>>> compositor and every client would have to support both extensions.
>>> - Similarly, a new wayland protocol would need to be designed to
>>> support sync over eventfd.
>>> - Eventfd does not support timeline semantics. Meaning that you would
>>> have to send two eventfds over the wire for each commit, one for the
>>> acquire point and one for the release point. Whereas with syncobj you
>>> only need to send two integers per commit.
>>>
>>> I don't see the advantage when drm_syncobj already does everything we need.
>>>
>>> You seem to believe that compositors would not be ready for this and
>>> from that perspective I can understand your apprehension. But I can
>>> assure you that compositors are already fully set up to support all of
>>> the usecases I've described: The wayland protocol requires the
>>> compositor to support wait before signal.
>> Yeah that's much better than I thought it would be.
>>
>> And that eventfds don't support timeline points is indeed a pretty good argument.
>>
>> But I still don't see much justification for creating a /dev/syncobj device, this is clearly something DRM specific.
> 
> The justification is given in the cover letter. To repeat them briefly:
> 
> 1. This series makes the ability to manipulate syncobjs available
> independently of attached hardware.
> 2. It makes it available under a consistent path /dev/syncobj.

Exactly that is a big no-go. This has to be under /dev/dri.

> 3. It removes the need to translate between syncobjs fds and handles.

That's a pretty big no-go as well. The differentiation between FDs and handles is completely intentional. 

> 
>>
>> What about using VGEM for this?
> 
> If the vgem render node were made available unconditionally under,

Software rendering is a complete corner case, I don't think that this will be enabled by default.

Regards,
Christian.

> say, /dev/vgem and DRIVER_SYNCOBJ_TIMELINE were added to the driver,
> then maybe that could solve points 1 and 2 above.
> 
> But it would not solve point 3 and it sounds like a hack to me to have
> a render node available outside of /dev/dri.
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>>>
>>>> Regards,
>>>> Christian.

