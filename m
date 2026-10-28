Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129D606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A808XGEZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623E410E621;
	Wed, 28 Oct 2026 10:13:24 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F118F10E611;
 Wed, 28 Oct 2026 10:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYQeqrdIRt/9g/TIhXRjfJopMxh0vuQ9OWaC7ohf1wF/mrZ2Lg2KTKTHyfKgdbtAF+UbznPCGbQ7admI/8Uh/lwvfaHYLVulj1XoE0y+5s+EPr8Vd7Nn4OhaSUwpVUnFkPiAx6LZABLLf83NlyJ4QAAXZh5cVAsETnlo50uccSDOOsqmSAAl3c5hEYmS0op9szhTWIrQJM2ezDWTGiO0aNMg0FUIwTDYizX8K3as9yataRDmwul3TJwDDIFhbgKuNwzLkhsQzXVtwl1frOOw3PNRDwGDAj1OK/40px/yYbrQlOW7s/G8WMsw2BTLLpxjB2RK/KJ2Taalz0scYgziCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7SBTQsI5OS3U0EFG9/wknQdEL1El6rLHY1gVNN8fe4=;
 b=w9+Boe5DGo6j1FQOfi2Ym9M+45CgQ/KTA3bxEFKYoh3DZmx1qU4Hb06XqrUuWC0YLIiEIifmTETvyXM1wbPXkCzU+kXmGDzPTK8QlnTPLsIMi8oi7R18S5kxe9HkhVIzXlo0Cl+uYyiYm4geBNOGOts+fDUpWXr/Ot7K0a6hizL+Uc/XENA+iIFPDe3haWMBeY6T216N9Vk0MlLb5G7D+7o46ExH55DDVAxhBiYOX1fatJ1fC7J0e9qb9Hxu4bT+zwFrgDA+j4upwva4Sp4fOv2TItwz/2rkk19T17BxGNOkkLcJpteK/dIonxWiiXtnvpC8DgVPBsLUamzLW6W/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7SBTQsI5OS3U0EFG9/wknQdEL1El6rLHY1gVNN8fe4=;
 b=A808XGEZZ0sGFwmnYgjn4pb4BAER4ZVAk9ih4sAM1RT5jvd4YkMwEQVlTKkC5qw85xkKUvvZaoPI+C1/vau7cttYjWA6XkFptdpXKXu311kWutJGI0RKJvHn4f29eQVP7kFMo/nmSh+POikfaWSgw/juaYTnn4czLq14bl51RyA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 10:13:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 10:13:14 +0000
Message-ID: <d45a4e9f-b8d0-439e-a675-420b2129d85e@amd.com>
Date: Wed, 28 Oct 2026 11:13:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K
 iMac
To: Mario Limonciello <mario.limonciello@amd.com>,
 Richard Lane <richardlanedev@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
 <e0573e72-dcc1-4ff2-8cf2-53aefde912cb@amd.com>
 <CADnq5_M8f2Hgs06n9EXUaihGsr6YEm6G4YFVQmPfQbGU08XkBg@mail.gmail.com>
 <6f79a3e2-5510-4018-aabd-45fcdf5dcbb3@amd.com>
 <CADnq5_OTLQuD3B6-VUgZv6wGjhFNY_U77wqdv5Y+e25+O0B2ZA@mail.gmail.com>
 <138497f6-2271-4229-87f1-4e42e9d2b581@gmail.com>
 <76b577d9-e8ce-45d5-9330-564411cc099d@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <76b577d9-e8ce-45d5-9330-564411cc099d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5ab7ed-025d-44e6-c1dd-08df34dc13ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|56012099006|261021123027099003|261022115727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|10067099003|261009223027099003|261022075727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4jFjCuHIE3GiHbVPar1ic+zegYS84GnUNJKmIJEoCJtl6Wrh8hP1M6LVW6SqCgoQNpZDM1V+Zd+Mku6MOD8c9yebzSFYMqAR0Df/cdk/Ofuro61iYslgvZXtGE0c/mpPyDHGQwZmiilpRpjezTAdvXNPO/REiNgGf1B2sGWAWUQEVQWfnvvDebEGdwgFQ2nI8Ba0kzLUIlBMbQeBcKbj86lcpUow5Gp+hyzJdOJiq8XeYGOU0sMVNTNOjLFczHzKECjbp0H5erKFAchfCnWxdQfLeWqYuh0f98LFNX+djiK/Y0q5pKLOOZUvXBYOGcsWKX0Hly5+jGZrm9OlupMRfSMBVrqbguoU1EIVDVyZL1uHSYCJ6NOE9JShN/gogCfILBJNBX9U3IUfdRKVoS1z8NlJ4vZOLuX8MRDEH2f5OUR+68bZoH6LxbURMht+4gG9BETBlTVn8omy1t0BlOlEgshuk54SXP9PKDcd333o4aOa92CO0AGdgK9buHXmsWze4YNh3wOEOnKPkUKu/VGtp7c31pn41cSrP1bluNqMRnDg+97FCKZB9d1HE68lYE9FPYZhfuMjcFZrC9PfhkHCUluk4prMZxmI03/7VSTnG+86hSkb0dBRbysOXmoTEiwFV95ADC9V6UuGcpmvhDON5Yrd0oA7gGhvVjp/dkgfveI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261021123027099003)(261022115727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(10067099003)(261009223027099003)(261022075727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJraUhEZkh3UjI4TFBHbXQ2bEYrNnZFc25xbFdwWXg0T3E2RUxrazdEWXk5?=
 =?utf-8?B?T3VOa2lHRmVwajhoM3dlMTBZQ0hiWmhJak1PSElUMVpXeUpITDRjemxTek15?=
 =?utf-8?B?dmtsOVZndWFXaWdSODRjSkxadXNTYTg1bHAwK2h1NnM3RmFYUytCR2c0d0tl?=
 =?utf-8?B?dUFQbnFCSXhhZHVnS0ZGQzJQay9pT3MzT05OWTgwR1RyckcyaDBhVVdyUWRV?=
 =?utf-8?B?UEdUNThFNGRYUUZubUQyK2I3Qk5ZTzZMUWRCUE0yZHY0RU54T0FYMDhBdnYw?=
 =?utf-8?B?em9TQmpKNnlvRTAzV3FQa0pydnVlUTcvVDRVRnpiVkxHMFFORTNuckVEQksv?=
 =?utf-8?B?TnFqQ2NROGRnV2t1U0xwVFF1NE1wY3ZZUUdYM1ZIOW9JY2tCMUVBbDFvalNC?=
 =?utf-8?B?cHE5TnNQTGNQdFRiNlVobUJqVjZkZTNNY2Nja08vWjlIdURtTmN0VDMrbGoz?=
 =?utf-8?B?ZkYyTnc2eklXYVN3L05kSlk0aE5SNitHa0dRQnJja0xJeEFzbGxOczFKS29q?=
 =?utf-8?B?dlRXZ01RNi9uT1psLytMUUZNenV4ekt6dHg1TzllZTRNVGJUUEhUTlR0Sjl5?=
 =?utf-8?B?N0pyc3JDK3hkWHNNd2MrTHhyWktoWjQ1MkxrTFB2Tmk1a0ord3JUU2VhblFn?=
 =?utf-8?B?VlFuLzZjb0NyRVJtR3AvZFZRVWE5ZkYvYmtpZXVtRlNvT2NmajNGVU9GVWtz?=
 =?utf-8?B?cW9CR2tHV1I1YjFNTGVtQzF0MnhvQWhNdnhTZFkyZTU1ZnBSQjZGVkp0T3g0?=
 =?utf-8?B?dGlONUw4d2NjSVZEUU5BN1hBekE0N09zcE1mNFJGdHdvaVl2OU42bFh5Qmcv?=
 =?utf-8?B?WjVITXJ2c25SMmpCY2NuQWR4cGF1WjJ5RkpqTlUzZ2lrcDVKZ3ZyQ2ZIY0R5?=
 =?utf-8?B?cEJVOVY3bDlyVThmQ25QOVMxeHpvb3RjVGRiSHFPQUcyM29JVXRMQUhxQURZ?=
 =?utf-8?B?SlZkOURXbnBuTThaWkJQeXArUENnSDZYRkw1RjM4RWhJMXhTVENFTk1VMU43?=
 =?utf-8?B?VENJSkJidDdwUkcveVRyNzNPMVhjQ3ZiT0h2Qit4YVNGMld3TE5kSU5NRjJq?=
 =?utf-8?B?Z3lrWkxaOXZzQmdscjZVSnlNTkhUclRyeDVPQy9iUEdnUGZxeXNtN2Rvc0cy?=
 =?utf-8?B?czBlNjczN21UZm9vVEkvK0JZVWVDNUM5bFhYMFlZTVZUSnZkSXJBc3UyWUx2?=
 =?utf-8?B?dkVDTnhGUG5RdlNCb3QzOFlWTkhVeFZaWSt5TFFndUFtczQ1a3B6Z0w5c3RC?=
 =?utf-8?B?V1VXZ3N0OG1rYVE2NDFDMDFRRWQ0TG0rRWUyR1ZNdmlxQ1ExRzIzSXZsTFd1?=
 =?utf-8?B?cmhVcWZEM1IrakhDckw5Z0N6NzUyenQ2RVJHMHpxOCtDOEY2Y3RPOUtIV0lZ?=
 =?utf-8?B?VjFkcFRwRkY1QytCSWdnYVJQb0gwdXVJL0FGdG56ZlZuc2JqTG9GOWpvKzNx?=
 =?utf-8?B?UE9ab0MxZ1VSaVBzNzN6dnlnRE91WVNjYUdWMXc2bkJ0L1BGSjh1c3Q3M0Ny?=
 =?utf-8?B?K2F2bEhQUUxhc3d4MkJCOWNDRFQ1TkYrQkdwSjlnMWFQbU5aelJ5bjM5d2VI?=
 =?utf-8?B?R3dlRk51U0NoWUJrL0tBKzh4bmhpVmk2SmZLY3ZmSXdDWWlxc1NCZ2JIOHU1?=
 =?utf-8?B?MldsWjFsQkM4VXg2REl2aExtdHVFMkIxR2x0Qmk3Mm9PYUk3SFFmQ1JCRjlJ?=
 =?utf-8?B?RllFMlRrVVFIYXdrT2xYK29valRQeTNSOXdDTGlnUUUwVEh4ckdFaUNYejNq?=
 =?utf-8?B?ak5iVXgyL05rWTFjdmZNdzhMMFpWWkxRWTB2amVtL045b1pZaldnQlBJT1NR?=
 =?utf-8?B?VnFleXdZSCswb0JReVFvcXhvVEUzRlErQXhQSHJxcWFxR3pWblVjcjJGMFcr?=
 =?utf-8?B?R1kyZTJISVF3Tzdsd08reE5IbFpqYXIwYWRpOWFSRFFiTlNkbVJralhkNGRl?=
 =?utf-8?B?NitQa0wrcG9QeHJTN2hKbVRCT1FSK0w3OVpjVjFlMU1aQXZhYkltM1JXZmRp?=
 =?utf-8?B?M1hLWkEyT0JONk83ajhCb3I2YWlRR21ndkRJK3pGc210dmtDZU5WVmI5M1Rl?=
 =?utf-8?B?R2lQTjVMOWF5a3haU3lXaUlTMEFYL2JBSmUyanhvdkZKVDJvUTBESW41aGtB?=
 =?utf-8?B?Vm1lMkJHaHNqaWF5enFrY1F4M05lMUdPL2lYNjVQWFRjMmhtUnJNSFhmd0lG?=
 =?utf-8?B?emZ6Yzg3MklNQjVCL2FGOE1mRjQwcFJ4SUhJVmFETWZ5UUMrTU9xa05wK2Z1?=
 =?utf-8?B?YlB2MFNXKzhGUkdXM2NYKzhzdHhLb2RjRkZaY25FVnEvcmZmZW5iclVXdHFa?=
 =?utf-8?Q?nz6MDxlnqBN9dYPssP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5ab7ed-025d-44e6-c1dd-08df34dc13ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:13:13.9775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/fVQTQIfyf2pAhzSao9SMP2C5m13TH8pck1LOKL7NfGxeDnEvPwot6wFS1Zg/Xe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 03:14, Mario Limonciello wrote:
> 
> 
> On 10/27/26 18:59, Richard Lane wrote:
>> On 27/10/2026 13:37, Alex Deucher wrote:
>>> On Tue, Oct 27, 2026 at 9:16 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/27/26 07:57, Alex Deucher wrote:
>>>>> On Tue, Oct 27, 2026 at 8:21 AM Christian König
>>>>> <christian.koenig@amd.com> wrote:
>>>>>>
>>>>>> On 10/26/26 23:46, Richard Lane wrote:
>>>>>>> Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
>>>>>>> VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EFI
>>>>>>> framebuffer.
>>>>>>>
>>>>>>> Override the stolen VGA memory allocation size to 64 MiB when matching
>>>>>>> PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
>>>>>>> framebuffer corruption during boot handover.
>>>>>>
>>>>>> Hacks like those are usually a big no-go.
>>>>>>
>>>>>> Why is that framebuffer handling not working with DC out of the box?
>>>>>
>>>>> The GMC IP code reserves the memory used by the display hardware from
>>>>> the pre-OS console.  The gmc get_vbios_fb_size() callback looks to see
>>>>> what display viewport was set by the pre-OS environment.  If the Macs
>>>>> need a workaround, that's where it should go.  Since these displays
>>>>> require multiple display pipes, my guess is you need to double the
>>>>> allocation in that case since the current code just checks the first
>>>>> pipe.
>>>>
>>>>
>>>> Could this also be a logic error in that callback?  Would it be worth
>>>> double checking all the register values in that callback for this system?
>>>>
>>>> I know for example there are a few different IP specific implementations
>>>> in gmc_v9_0_get_vbios_fb_size().
>>>
>>> Not likely.  I suspect the issue is that these systems use two display
>>> pipes so we only reserve enough memory to cover half of the display.
>>> On PCs the vbios never sets up MST.
>>>
>>> Alex
>>>
>>
>> I tested doubling the allocation in gmc_v8_0_get_vbios_fb_size():
>>
>>     if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
>>         size == (2560 * 2880 * 4))
>>         size *= 2;
>>
>> That eliminated the corruption across the middle (45-60%) of the screen,
>> but still left a band of corruption along the very bottom (95-100%) of
>> the screen.
>>
>> Dumping the DCE registers inside gmc_v8_0_get_vbios_fb_size() on the
>> iMac17,1 showed:
>>
>>    vram_start = 0xf400000000, d1vga = 0x0
>>    CRTC0: grph_en=0x1 surf_hi=0xf4 surf_lo=0x300000 pitch=5120 vp_size=2560x2880
>>    CRTC1: grph_en=0x80000000 surf_hi=0x0 surf_lo=0x0 pitch=0 vp_size=0x0
>>
>> Even though only CRTC0 is active at EFI boot with a 2560x2880 viewport,
>> Apple's EFI allocates a full 5120-pixel stride surface (mmGRPH_PITCH) and places
>> mmGRPH_PRIMARY_SURFACE_ADDRESS at a 3 MiB offset (0x300000) from
>> vram_start.
>>
>> Because CRTC0 scans out 2880 lines at a 5120-pixel pitch starting at
>> offset 3 MiB, the active pre-OS scanout spans [3 MiB, 59.25 MiB) in VRAM:
>> - Reserving 2560 * 2880 * 4 (28.125 MiB) places permanent driver BOs at
>>    ~28.125..32 MiB, corrupting the middle (40-60%) of the screen.
>> - Reserving 2 * 2560 * 2880 * 4 (56.25 MiB) places those BOs at
>>    ~56.25..59.25 MiB, leaving the final 3 MiB exposed due to the 0x300000
>>    surface offset and corrupting the bottom (95-100%) of the screen.
>> - Accounting for the 5120 pitch and the 0x300000 surface offset reserves
>>    the full 59.25 MiB span and eliminates the corruption completely.
>>
>> For v2 of the patch, which of the following two approaches in both
>> gmc_v7_0/v8_0_get_vbios_fb_size() would you prefer? Both tested working.
> 
> My feeling is that Option A is less magical.  I'd actually wonder if we should be doing this more widely.  I'd *think* the same problem could happen on a non-Apple display that behaves similarly.

Yeah agree.

That the Mac EFI uses such an unaligned offset is very strange but perfectly supported by the HW and so we should also support it in the SW as well.

I'm just not sure if extending the size is the right approach. We should maybe have a function to read the base address of the framebuffer as well.

We already handle quite a number of those things for other use cases as well, so it should probably not to hard to get right.

Richard just take a look at how amdgpu_ttm_init_vram_resv() is used in amdgpu_gmc_init_vga_resv_regions().

Regards,
Christian.

> 
>>
>> Option A (change whole function):
>>
>>   static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
>>   {
>>       u32 d1vga_control = RREG32(mmD1VGA_CONTROL);
>>       unsigned size;
>>         if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
>>           size = AMDGPU_VBIOS_VGA_ALLOCATION;
>>       } else {
>>           u32 viewport = RREG32(mmVIEWPORT_SIZE);
>> -        size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
>> -            REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) * 4);
>> +        size = REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
>> +               RREG32(mmGRPH_PITCH) * 4;
>> +        if (size)
>> +            size += RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS) -
>> +                lower_32_bits(adev->gmc.vram_start);
>>       }
>>         return size;
>>   }
>>
>> Option B (add Apple 5K iMacs quirk):
>>
>>   static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
>>   {
>>       u32 d1vga_control = RREG32(mmD1VGA_CONTROL);
>>       unsigned size;
>>         if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
>>           size = AMDGPU_VBIOS_VGA_ALLOCATION;
>>       } else {
>>           u32 viewport = RREG32(mmVIEWPORT_SIZE);
>>           size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
>>               REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) * 4);
>> +
>> +        if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
>> +            size == (2560 * 2880 * 4))
>> +            size = size * 2 + RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS);
>>       }
>>         return size;
>>   }
>>
>>
>> Richard
>>
>>>>
>>>>>
>>>>> Alex
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
>>>>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>>> index 4204c3c750a8..8b196fbfa724 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>>> @@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
>>>>>>>           } else {
>>>>>>>                   size = amdgpu_gmc_get_vbios_fb_size(adev);
>>>>>>>
>>>>>>> -               if (adev->mman.keep_stolen_vga_memory)
>>>>>>> +               /*
>>>>>>> +                * Apple 5K iMacs report one 2560x2880 tile in VIEWPORT_SIZE
>>>>>>> +                * while scanning out up to 64M across the relocated EFI
>>>>>>> +                * framebuffer.
>>>>>>> +                */
>>>>>>> +               if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
>>>>>>> +                   size == (2560 * 2880 * 4))
>>>>>>> +                       size = 64U * 1024 * 1024;
>>>>>>> +               else if (adev->mman.keep_stolen_vga_memory)
>>>>>>>                           size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
>>>>>>>           }
>>>>>>>
>>>>>>> -- 
>>>>>>> 2.55.0
>>>>>>
>>>>
>>
> 

