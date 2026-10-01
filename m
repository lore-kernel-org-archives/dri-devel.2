Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E7CCA5FD9
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A7F10F71E;
	Thu,  1 Oct 2026 16:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HrH16TKr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE1E10F715;
 Thu,  1 Oct 2026 16:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEzqDX29Yv6Lo+ATO91rhhjMiEyj+dWsYVne9N4YT2SJs+xGiYq1auQ7+lnl8FH+fBi+Nh8Oov/VoeYlebJ7Y2ridjn1Hot7OaPnJtRoMU+iQKP75Z7CKEQM/NPWQTyxRFHeCj1faxMIV+RTGNjwLeRGL+q+xPZ1ogPxtAqJ+6JTRb2BUDIT+X5ndyIvKQCSytwAewkQOZsPCTrHqhH889MxiZOz2nP5qjeRUlTZIFheTJzZe0ysGA+SGjPFTCtpl2nU3FtfeTvdX1lymz0pMwbHUvPMZLR/eDBz3KHrjynrxBp1Zkqq7PAc5DHUett7w1E77vAPljofsuOdY67tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoJULxXcdNe5WLnfrBOmWVMM8hYWC4Z1edJYaTBaQgs=;
 b=NzjTpABNhJrmlSxUb0Cxi1A+VrrcL43ZzmEy3g0a4tYs652qZwgxCtaYi4MsuXdLNaFgBs2wdKcFdAL0zksTSRBtRLmin24UxEeRhlK7HH+JQROU8YmhffkOEwloMXWOL+SC2DvGt2iFrCQDF64+hR38vhpiowTBJduBZIMoZV9knLaZX56pGtYoAeoE5jhvjueFnq+j21dFIDUjEcdyeLYVUJPJvsD609m1aNv4ojtH7omLJB0KjVUJL1vpBeU6NdcJBkIKU3sj8NlDsIjIuKEpNLeZIzyMmFTEvd+c4ED27IJno49FcspXZjpqlQrztcyP1Zsw2bReWEJ9ny7cMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoJULxXcdNe5WLnfrBOmWVMM8hYWC4Z1edJYaTBaQgs=;
 b=HrH16TKrmuh2oQXh3W6a51zomKRSzxlTZJEsiawKv08g+AcA74NE1zqpxxDYVDnNhvJwmPdFEYitqEX8eFf2n9qxS0VyaGVUG+EA1Lh5c8OsaTyR9mcFhjy+LrPV0srn6D6O8ZxFNCZ1CmTTyJlRSSgatqbAmIbEL0gWXCLKlkM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 16:10:56 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 16:10:56 +0000
Message-ID: <acf55259-f4b4-42bb-b16c-e5bb79cbecbb@amd.com>
Date: Thu, 1 Oct 2026 11:10:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com> <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de> <arJ0huW356NjqpGR@houat>
 <8727cba2-aa4d-4480-9b76-a9dedc57d8ee@suse.de> <ar6ElW7Wg5m6A-1m@houat>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ar6ElW7Wg5m6A-1m@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:610:e4::30) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 648217f6-91e3-4009-cc4b-08df1fd692b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: QMg1MGRitl8+j6D9yDy0DSZVn9Z5Flc8pgvM0H7iFXEguKUEERO/b0uwF9XM/eCaHTsJTtQiExnL2V2klAfuXzXX7bUEll0W5HIGl5ajxYW5DNqdAZGSsH972evZODr6BDX4ViCJ90qKPEnZLO0de7Zy0nmJ/rIAj/LOOjyFe3IAmZx/7AivDC/UKJdranROTTn6C3kNSpiZDj49RPoRWMINxSfI8zIQwbIy7TVEdo62/gOJw1XWHtmfuWtcXCUsMxs940Tdss2g5Vo0cirUoSSLMqtLnfIqJKhKCtiO3AkXrQsfCIv3KNsCY6+waulrhthetmHHWzmgh6s8TLLIusSbUz50HQnoByE0LmoyIWwNUvWpD2DcHTjz3Od6Q0d6LVzGpMNnrRXWecCp8socC3cb5S5DJepUqu1hJXAdf9Vx/qCL9BRPiSsQw9Kd5ZYBbMmAy5byVsFlQL758kIM2G42Y8L0xGB3+yZRpputOr3U+TT/rNtlSGzICe27zFVX5bheagXT4BPs2MIJfg4SFWRboPuwoNpEDzJcY1SAHxmdfa6Enc6k4cLLmDA3dK+bccdMhpV0A72FQShJkWRfscJMY1uz2BJ9zrV/BTF/Rp2GjmtnaKqBTjXFiOZOpLP8ECdi+Lr/BEqmzEZUg+MtyOYvgj9XqUo1otqAvdaxD/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJnZDVQNGw3YjVBdURzdFdRNk5Jb1VlOE1XdGJyU0t6M0c5cm5Kd0doc0ty?=
 =?utf-8?B?L2tuZ3UxVExkR1hNMTJBUzFQVzdrYjNGYlZsWituN1JzVUhoM1ljblVldWI4?=
 =?utf-8?B?Q1h6UG83ZUxLcUxYd3l1UGJmcHBLUU4ybGQ3MXV1eURNT0JGQ0xxOEY1Z1Vt?=
 =?utf-8?B?NUNBTVpLSnR4c0F4Snh1RkJOdHNPRExvK0w5eXFYL2NiZXpoWDNRQkJxZjlY?=
 =?utf-8?B?ZHJEYmE0Z2hpWnVidmoyeExNRnpiMFNDZHhCS3QzRlgzNHJXVzg3WTg4czJ1?=
 =?utf-8?B?UWJaYXFQeTRwTC9veE1hMzV2ZVFEckZSRUNTYk0vdm1IRkpJb3M2Vm1wTmpZ?=
 =?utf-8?B?Ry9neVpKS2dMZTUzTTdKOExoVU5XYkhZbDJjK2UweHBQUmgwcnYzVXRObGlD?=
 =?utf-8?B?U0RNNDQ0NkszTnVVTVZ2bTNjQ2pyOVpwNFI4YUVEOThjSUpleGhxU2VKd01Q?=
 =?utf-8?B?VWN5UHVzOXhsaitTbDNKZ0U2KzVGa1QxbVo4MzZLc2x4Qmh5cmxqRTNhdnJ6?=
 =?utf-8?B?R201OXp3N2Jkc2hndEQwaFdTQ0t4YWwzaGI0RmV2SFI4VkhFSzgyUzhmYmNm?=
 =?utf-8?B?bHlyekwvakVmYkk3VzRwazExN00yLzBDdzYwM25lMnk4ZkhPeEFOend0T3p2?=
 =?utf-8?B?aE4wdXVVK0NsQVpUdSs5RnVGQjRWYlF0VlNER1BnVWVEWFROczYrS05pWVZ4?=
 =?utf-8?B?NjB3eUREZlozU0hQNkVOaEtzUTBnRWFmVmFMNU9tdE1YMkpGSnRjdHFlbi9F?=
 =?utf-8?B?QUpwVnRZaUFlY3RtTE5NR0M4YVhFOVJSMC9kdzFJTy8zdGtHSmVzRU5pRmd4?=
 =?utf-8?B?RC9IWnp3MXdTSzJ6YlByUFFxSWZQSE9ILzM4NGNCRHZCc0w4VS85U01ialli?=
 =?utf-8?B?RlRBdHNCdnNuV3hZeDNueEVVdDdZZUZ0SWdzamdFa28zckVjYWpFTVBab0d1?=
 =?utf-8?B?RUZ5cllKdkpvVm5SNGhJbVBWZGlDOGcvQ0prZzFnNVdvc0tZTXFFUW1ISXdt?=
 =?utf-8?B?anlTOGR3M1VmZDdwaEJQNUhaeEsrVXNYMGtraEkzZ2hnWmYrVXFkMzB1Z2ZJ?=
 =?utf-8?B?SytTOFRCc3c1QUhrcTBRa0dhaWdPazR6aGN5NDdyRFQvRnJRbG5hdFZFL1NZ?=
 =?utf-8?B?K1phK3ErQzdCd254ak5Zb0M0cFlzMU1ENWFOcUw0MUhGNStSNmMwZ1NtcE9o?=
 =?utf-8?B?UXBmaFgwQUVjU2ZDTG9PVm42Rnk0aWVUWit0cG9YazcyU2tyNjN0ZmczNjl5?=
 =?utf-8?B?TnJuR2JCUjNJSzRIeDhOWG5yakZqUUllV1FLNUtZRlhUdlpsd3hrMHBYU3hW?=
 =?utf-8?B?NXh4Z0VTMWZTUHJOQ25yeTVyNGJhVkE5cnpOcEhEblRQMjVOUU1xR2owQkZj?=
 =?utf-8?B?YWZEUnlQQ1JoNXVJbjFTUW1qWXZ5aTF0Um93VzU4aWZWU2JRazl4Q3Nwb21Y?=
 =?utf-8?B?ZHVLS1RLa0RVbDh2elRERDVTNjYvNS9Rbk5iajg3YjNSYmFJajRSYm1Bc3hk?=
 =?utf-8?B?SUVpOEUvdzBhVFZQQ1drVVBRQWFYSzhFY2p6R2trNHFXWnRwcEpoeUs5Mk9E?=
 =?utf-8?B?YVk5WGFnWit0S3NVTVhKd1YwdEVpN3JBMTI5VlVYTnN1WDZLTngvQXRDeFJH?=
 =?utf-8?B?VWhwNGJtU2xQS1M3QUxBaE5vOUo1YndUNjB6NXFHZllsNjl0cnhGcVR1TW02?=
 =?utf-8?B?c3VwSjdkV0hBaVI3Y0ppWHRSbWREN2I0QjlFRmNoQks3WW5aeWV3QTl2azNM?=
 =?utf-8?B?cEVycHQ4N0hIbkVweTU2VUJNV1BsWTFZaWJFVjNDTmVtZkZ3alIrVGxjclJZ?=
 =?utf-8?B?NWx6UXA3RE5VRmFFbDZvYmJna3htcU4yMXRCNG5CQjZsN01EaDd0RVIrZGU2?=
 =?utf-8?B?KzBBMHhKdUNpVUpVdXNCSmhkVHpFRlhqY3ZEUnNBbnNhdkIzRldSR0x4QVpW?=
 =?utf-8?B?VGNQNFl2ODFCaktFU3l6NUdkeWdCT3owYnFzVWxROWtyQ2tGRzl1M3R3OU01?=
 =?utf-8?B?QzRqNGxEZHRSUDlPcmZvL1NkTnc0anY4d2lWZFVEUytvdnRuWFBLUkdldjNn?=
 =?utf-8?B?Mk4rbWpDZlZadGpLWHN1UkJNZCtmU3dhcmx5S25FVjNnRU95SHAxUnk1Nkh2?=
 =?utf-8?B?MnBBb0hRVW5qRUhPUkZSSHlmVGc3NUNORFFaRHRGcFhraTkzVXM5N1o5Tjh5?=
 =?utf-8?B?SmU2YzljaEFuc2wwbFc3dEFjbVFuSEo5QTlYN2FVMlJpelBPZ1hkQ3Fma1Fx?=
 =?utf-8?B?QmdEZHg3c3h6UFE1aWlCVDloeUpFOW9pcHo1Uk9NMGhRVnZIOUhMOXRiY3M4?=
 =?utf-8?B?VVpMZS9PVzhsSmlUZ2RtNWJzMjBTQUdGL1VVT05MU2dFa3FybmRVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648217f6-91e3-4009-cc4b-08df1fd692b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:10:55.8896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3tSSiOYa2/TP47/ZdeZ+sBFU3J1mJwNZF3PT51nQD3u5QWKxbgMlmN2X+r7G7e1+cbu4+ZuXDJBEvEJLoLqrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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



On 10/1/26 11:06, Maxime Ripard wrote:
> On Wed, Sep 23, 2026 at 08:39:33AM +0200, Thomas Zimmermann wrote:
>> Am 22.09.26 um 14:35 schrieb Maxime Ripard:
>>> On Tue, Sep 22, 2026 at 02:23:17PM +0200, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 22.09.26 um 14:16 schrieb Maxime Ripard:
>>>>> On Tue, Sep 22, 2026 at 06:41:32AM -0500, Mario Limonciello wrote:
>>>>>> On 9/22/26 03:33, Javier Martinez Canillas wrote:
>>>>>>> Hello Mario,
>>>>>>>
>>>>>>> On Tue, Sep 8, 2026 at 6:41 AM Mario Limonciello
>>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>>> At Display Next Hackfest 2026 we reviewed progress moving brightness
>>>>>>>> control into the DRM connector properties.
>>>>>>>>
>>>>>>>> There is a range LUMINANCE property that will default to 0->0.
>>>>>>>> Once a driver attaches a backlight it will be updated to 1->max.
>>>>>>>> If the panel supports the minimum backlight turning off the display
>>>>>>>> the range can later be updated to 0->max instead of 1->max.
>>>>>>>>
>>>>>>>> The legacy sysfs interface is synchronized with the DRM connector.
>>>>>>>> When a compositor using this feature is loaded, sysfs writes are disabled
>>>>>>>> to prevent legacy tools from going out of sync with the compositor.
>>>>>>>>
>>>>>>> I don't think I agree with the direction of this series. The main
>>>>>>> issue for me is that if the sysfs interface is disabled, then I don't
>>>>>>> understand the value of doing all the hops between the DRM and
>>>>>>> backlight subsystems...
>>>>>> The reason for all the hops is that users can switch between compositors
>>>>>> that support this and don't.  If you're in a compositor that supports it
>>>>>> that compositor will want to affirm it's in control.  If you're in a
>>>>>> compositor without support then you should still have a way to change
>>>>>> things, and that's what the sysfs interface exists for.
>>>>> Couldn't we make a sysfs write trigger an atomic commit then? That way,
>>>>> it would always go through the atomic commit path, no matter whether
>>>>> you're on a "legacy" compositor or not.
>>>>>
>>>>> It would also somewhat untangle the uapi from the backlight subsystem,
>>>>> because it's only really relevant for panels. For all the other use
>>>>> cases, you might want to control the brightness but you have no matching
>>>>> backlight device.
>>>> I suggested to treat these backlight changes like display-hotplug events.
>>>> When it happens, we'd send a uevent to user space, so it can update its
>>>> internal state.  Such an event could then come from any source besides
>>>> backlight's sysfs.   Compositors could also implement policies that are
>>>> currently implicit in this series, such as brightness of 0 means "display
>>>> off".  This is likely something a compositor should track.
>>>>
>>>> Would that work?
>>> It probably would, but it would create a precedent I'm not really
>>> familiar with. Hotplug events are kind of separate because it really is
>>> a hardware event most of the time: you get an interrupt, and report it
>>> to userspace. And it's largely outside of the properties space (except
>>> maybe for things like edid).
>>>
>>> If we start having the argument that a property changing must trigger a
>>> uevent, then it means that we can expect *any* property to do so, and
>>> "the compositor needs to be in control of it" can apply to many, like
>>> color formats, positions, tiling, etc.
>>
>> I'd explicitly not treat this like a change to the DRM property. More like
>> as if the user pressed a hardware button. The property update only comes
>> later from what ever the compositor does with the event.
> 
> I don't think that would work unfortunately, because then that means
> that any system that used to rely on sysfs but wouldn't handle that new
> event (however it is sent) would effectively have a regression.
> 
> That being said, it does look like we already notify userspace on
> property change for HPCD, so maybe it's not too bad.
> 
> Maxime

Earlier iterations of my development of the series had a userspace 
notification.  It was very heavy.  The problem is that your DE may 
change a brightness in a slider and try to smooth it out and then that 
turns into hundreds of calls to notify userspace.

It was heavy enough that it lagged on a beefy system.  I don't think 
this direction makes sense unless it was rate limited.
