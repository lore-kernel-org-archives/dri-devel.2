Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A5606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m4QIoMYB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51E110E522;
	Wed, 28 Oct 2026 02:15:59 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDDD10E522;
 Wed, 28 Oct 2026 02:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4ASiHqZr7WJnDHyQW4aU0k0uwgmp3+BwEOxqezV4gXqYS8H54cXMRp3lc046E0JQfiLRoCYP9qUuoOv43SBSJyjYwVIb7gPWcc4W5ahvUe9nQrim+IsXLSeaPimwdp9PRV3cdgWnYDmGUz+u/ErfW1hQ1gSOnPGVPb1pVviPlTdGOrHJ7n/Y5OPpg1oUeoMlz97tf/sjB+ZUHu3Z11Sdnl19F6jmVQRiySEqMU3kUK/s192knW7g1hv7A2vs3EZo86OuaHM0rMyX0LrV5qb1xFBtOU4xoze1T65s8RSZ/ZAx4BYYYqh6pyG9dGuiMIFQENC90D22mP3YAuKt3WWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d2LcLyFxPzyNEdPohZ/LYvQjMeQMnwgHvoPc2toytU=;
 b=Yh+35a7Pp3u0yZ2Da0i/b6B8qF6l2yGimUisgdd1xaxi2baDFzmvlmA41mWIxPGGeBBprieERfA8teeaulc5A/WN8WsKiqqJtv6na1+vg0F/BqWKjS+W+9Fb83FAoK66llYBw6HTphJCwjZl2YKW4wb94aqgVik2qbTM5xdqAN6qRmz8r5kJtGwI8gn3vcKjKW03sqc9m0WBml1Ab4AIpz8ojJQ2FKfKEVJg7rd1M+/ZdqK4xAl953qNmdsJQ3A5UdLtHgn8v5oPtMTycKl5Q7HK7WsDjYvmUjQ5cEvreG0eHa8TTIJiNZshm7xPysrOzEY2D2Hz03rlZKzvBzX16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d2LcLyFxPzyNEdPohZ/LYvQjMeQMnwgHvoPc2toytU=;
 b=m4QIoMYB45ua+2XauBOU8nfnCjc+6+Yw13wpKAizCSua3k48A90raXaegTV7xjkEXlwjxsgkNs0Lzww+AwzF6Sz3VWaJosdn21IiJv9AGdD5JfPQN8NlJnZOJ2svCSHF0+MG2YZ0VnZGrYluCCwJtJMgD0GC3h/PVfyadog0T+0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:14:54 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:14:54 +0000
Message-ID: <76b577d9-e8ce-45d5-9330-564411cc099d@amd.com>
Date: Tue, 27 Oct 2026 21:14:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K
 iMac
Content-Language: en-US
To: Richard Lane <richardlanedev@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <138497f6-2271-4229-87f1-4e42e9d2b581@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::18) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1f2e37-e243-4eca-01dc-08df3499416a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261022105027099003|261009223027099003|261021121427099003|261022075727099003|261022115727099003|261021123027099003|10067099003|56012099006|3023799007|261026140227099003|6133799003|22082099003|18002099003|261026121527099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: nYqLlIKfqkJyUa0/hgpVlpeWb185MA0W0vqZn5I0PpJmNA7dz7igHycgFzfDmtoe3nwU/363JR8pPQXmPtdBPjm3eeKFwg/o676dpMEuXnpvII79b+a9gh6K4Ojf9wsm5pN2TM0r+97xPvRklp75VZLaq4VSms/SdY0Ik+wihy1pQ7NUA3fx0CN4LEurWgYVz2AFQEcmssRlHz8QjyFLKVQbgAqGR34PjqmX0e7b14VgxCmNAc5kzP1QVNl+3nMx70zhbavmb7PYOm9DWLYm2UHZ6qfmlP5SiumR00HRgKb+uGmSGLlgN8FcdJuTMGBi4uqCnHumYNg5Ov2pmCKpxS18ZfmoF5RfFqeX5QGPBB5g+y2bIQxsChlSobqaR4/riYwlm0Ku739cBXkePJ/EIuNm+qwwUTtPy678V3+6V+8oVDJI/s3SMf3KPkcMSjdtV9LuRn2U87X9cf6Ydcs8VruOcme/JHls1yEhSlREe+Qilyqt7jtApOwZE3MCsfZtkTUFcfGBoZWZsH0NqnT/EcQLvpmso33agbSFoGmuX9xFfB6XCnNzrOsGgF8B6f/3m4q5AGcSzFPisGq5+aKmkVleq1qxwLHSM96xyneuv0GzaIpky6WmIffrV5C0LSBIZqVrIa1entJx3zui6ndE7s5Li7fA+TktREj8FZ4XXsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022105027099003)(261009223027099003)(261021121427099003)(261022075727099003)(261022115727099003)(261021123027099003)(10067099003)(56012099006)(3023799007)(261026140227099003)(6133799003)(22082099003)(18002099003)(261026121527099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjZVb1V1VmRpbU1wZ2w1TjdSQXpGR3JWejgxU1pabWdkc0kwcU9HV3NNVU54?=
 =?utf-8?B?Y24wSkhrSGdsenVaZmUzb0FhSSt3UWQyN0ROS2pNQjZRamdyYUFaSWxIMjgz?=
 =?utf-8?B?Yi90Sjd5OS9VSVoyb2JZOXg2MW5Idldvam5TTlJlMk5oSENVQk03dkQxSFlS?=
 =?utf-8?B?aUFoMmliOUt2RlpPR2NWYjNmdDRhMFcvNGlWcVZ3TGVqdVUxSmM3L0UwSUxo?=
 =?utf-8?B?OW44SjBpUEFHSHRMMCtLOVA2WFR0M3p3eHFHNFhZSnh5Y2NQbEgxN0hWRE9r?=
 =?utf-8?B?dVVDb3J2b0pMVjlOYmdLTWU2TXJabUpxcElNeFNaTnE4WWFKRFViTU4xSkVM?=
 =?utf-8?B?Vi9FVU9TM0xENGlTUlJ0NDZBRnVsd2hnMXNyTWR0V2NoLzgwUmRsaXVHRFQw?=
 =?utf-8?B?R0JLd3Zla25ObDhMejh6NDVWUUZJS2UyblRzZXo2RU1YNlVXaHIzL3I4RTlK?=
 =?utf-8?B?ZkpOa3BPbVF4bXlEaW5RK1lMMm1ySjN4REFtQWtTNlluZnBYaEFiVWpmMkxr?=
 =?utf-8?B?cVJMVU9wYzFKUnlsWVBCVUNjNHRucmVIbkp6QlNQNFpTSkFvTmY3SGtQQko4?=
 =?utf-8?B?YnZReG9zUVRYT0RqcHRIT2lNUE5sRk84b1kvSEZjWHF1WmxGYy9uU0dMSmRo?=
 =?utf-8?B?NUpFSnVEdVIraDQ4Q1ZjQ1pUWWZKK09XaWdCUWZoYVRjVXA2Z2pQSDRmQ3ZV?=
 =?utf-8?B?aU5WM3V3SlFEMEFDM1B6SHJiWlJsN3owWUNyd28zTGYrWkowb01ZKzl1S0hK?=
 =?utf-8?B?eXJDZTNueU54SUdJR3RPZ1p4M2JLMngveTVDUURLSU9ZcEZaekV1MkxQd0ND?=
 =?utf-8?B?a2NmcnFKREkyVlJQWjVMcmZvVkZlcHRqTnF3L01jZ1RpU21vRXBZYW1GcUFW?=
 =?utf-8?B?ZFZQOVRHR2pvTWVzRk9yMEpCNGVSY0ZNK08weGpyQW01NGlTVkM0aGM1TTY3?=
 =?utf-8?B?aEoveW5EUlUxeVlDN2NRTG1uVXR5Wk0wWGIzNTlTV2ZtK1ZlRkZkQlpWYzVy?=
 =?utf-8?B?SVZKdEVubWFoVkhqb1lpajlXVE1uV0ZFVlJ2dlg0YitwRnhUOVJWM3FZTmV1?=
 =?utf-8?B?cTk0cnB1MDk1VjRBNFpjNjh2OU5kc0ZySFFPRU92VTl0eFl4M1RLOWdwYko3?=
 =?utf-8?B?aFpwNS9VS1hSQXNtTFJ4dllFaElIN2E1YTBGenFETnNob3FiakQ2UkpxVTVz?=
 =?utf-8?B?VFlpYUgvSWtUeS81Y3d6UDhseTBzaUNnalR2bU1DbktFMHJLYWYxL1EvSWZh?=
 =?utf-8?B?QVJuMFl5WE1TTkVTUHdJcFIzamRzUG1LTktKamR1aEZDb1AxZkxJS1FMZ3Jh?=
 =?utf-8?B?OE9tMEFmaXVHYkFYNXpERHBtL3BKbDZWT3FyNXR6dm91cUM1eTFKeGt6Z29P?=
 =?utf-8?B?emtrN2lWQjhXVVVydTBCUldoMnNWOXdSS0JvVlZWWTdBdVBKOXVQNjFkaWhp?=
 =?utf-8?B?R2dldUVTKytqUEJkc3c4b1gwVXVBNXNFYmpMUXNvMEVLcXUzUnNNeFhWZWxp?=
 =?utf-8?B?YjZvclEzOSsxTWNIOGZ5TG1oV2VBRlZHYUNKRTlNNGdSN01mU1hwUk5hcnVM?=
 =?utf-8?B?OHJ0VmRJNDNZMGNlS0o1ZHdmSWFmcDhvMm5hQXZUWkxEL1Rya1pNRlFIQ2hp?=
 =?utf-8?B?Q2VPYkNmY1MvcWN1UjdYTUhGRUJ2NDJ3NXVHaWRKdldRb1hGR2lnbStKQ3JI?=
 =?utf-8?B?Wk42Tnk5SWRmanBVWGZjMXorZkg3M2pZM0NmNFVoaTlUL2hzeTVQWXJTN1Ry?=
 =?utf-8?B?Sm8xZmpuYW9xMzJBNWZHL3FaalRYUFQvcU03R3pyQ1ZGKzMvVVh4ZUo5eXFB?=
 =?utf-8?B?MndIK2RTRGVwKzZESklnOGpjVTNjZWlYYnA2Z3NzWUU3eWYydTFVbHFHcXdm?=
 =?utf-8?B?b3d3Q3RBZjB4WmpvOTA1ODhBandKWEhibU5LMGNKOEZodXp6SW13akdLSHhn?=
 =?utf-8?B?RTJCcVdSbmpMWTMyQkxhaFVLSmNnNjhTZktXbTlIRnZxcE81UnFOSXhiZklj?=
 =?utf-8?B?U3N1N0F1c3VwU2hDbHJaVnlwMU9VL0x4WThSVlpaVUxSWHRIZ0pJRWlyenFu?=
 =?utf-8?B?amlnNDBSV2JYeVFaeXk5bWdReXhIa3Z1S09iNW8zRkNSbExTUWVxUXQ5ZzMz?=
 =?utf-8?B?R3d3SkFocTQrK0tlYkp4bFFsRVJnWWIrbzhFeWZQVkZuamZYQVEwRUdxS0hP?=
 =?utf-8?B?R0czVFgxMHJkZ3pPcE0vK3VITzlFakVuYXFYZER5Zll4ZUdmVVh6dkRHUGtk?=
 =?utf-8?B?YzFGVDM3NndLbTBmL2psMzYxdTVDeTk0QWdaZVFoWEhVbkxUZkF5aVZhL0Zq?=
 =?utf-8?B?R3BSRXV3YlNkaUhwTVAxRlM5NkpQUkhhTXlsMHRyL0lTbzVXN1BqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1f2e37-e243-4eca-01dc-08df3499416a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:14:54.4059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhJAXBdKfnByzuglc4BtyXn4wuG4YqHON0lzFvD8RB+K6e/O+S6Itj71JB1iLKHt4uRVMgqA1CYZGoSy0h+CSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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



On 10/27/26 18:59, Richard Lane wrote:
> On 27/10/2026 13:37, Alex Deucher wrote:
>> On Tue, Oct 27, 2026 at 9:16 AM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>>
>>>
>>> On 10/27/26 07:57, Alex Deucher wrote:
>>>> On Tue, Oct 27, 2026 at 8:21 AM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>>
>>>>> On 10/26/26 23:46, Richard Lane wrote:
>>>>>> Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
>>>>>> VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EFI
>>>>>> framebuffer.
>>>>>>
>>>>>> Override the stolen VGA memory allocation size to 64 MiB when matching
>>>>>> PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
>>>>>> framebuffer corruption during boot handover.
>>>>>
>>>>> Hacks like those are usually a big no-go.
>>>>>
>>>>> Why is that framebuffer handling not working with DC out of the box?
>>>>
>>>> The GMC IP code reserves the memory used by the display hardware from
>>>> the pre-OS console.  The gmc get_vbios_fb_size() callback looks to see
>>>> what display viewport was set by the pre-OS environment.  If the Macs
>>>> need a workaround, that's where it should go.  Since these displays
>>>> require multiple display pipes, my guess is you need to double the
>>>> allocation in that case since the current code just checks the first
>>>> pipe.
>>>
>>>
>>> Could this also be a logic error in that callback?  Would it be worth
>>> double checking all the register values in that callback for this system?
>>>
>>> I know for example there are a few different IP specific implementations
>>> in gmc_v9_0_get_vbios_fb_size().
>>
>> Not likely.  I suspect the issue is that these systems use two display
>> pipes so we only reserve enough memory to cover half of the display.
>> On PCs the vbios never sets up MST.
>>
>> Alex
>>
> 
> I tested doubling the allocation in gmc_v8_0_get_vbios_fb_size():
> 
> 	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
> 	    size == (2560 * 2880 * 4))
> 		size *= 2;
> 
> That eliminated the corruption across the middle (45-60%) of the screen,
> but still left a band of corruption along the very bottom (95-100%) of
> the screen.
> 
> Dumping the DCE registers inside gmc_v8_0_get_vbios_fb_size() on the
> iMac17,1 showed:
> 
>    vram_start = 0xf400000000, d1vga = 0x0
>    CRTC0: grph_en=0x1 surf_hi=0xf4 surf_lo=0x300000 pitch=5120 vp_size=2560x2880
>    CRTC1: grph_en=0x80000000 surf_hi=0x0 surf_lo=0x0 pitch=0 vp_size=0x0
> 
> Even though only CRTC0 is active at EFI boot with a 2560x2880 viewport,
> Apple's EFI allocates a full 5120-pixel stride surface (mmGRPH_PITCH) and places
> mmGRPH_PRIMARY_SURFACE_ADDRESS at a 3 MiB offset (0x300000) from
> vram_start.
> 
> Because CRTC0 scans out 2880 lines at a 5120-pixel pitch starting at
> offset 3 MiB, the active pre-OS scanout spans [3 MiB, 59.25 MiB) in VRAM:
> - Reserving 2560 * 2880 * 4 (28.125 MiB) places permanent driver BOs at
>    ~28.125..32 MiB, corrupting the middle (40-60%) of the screen.
> - Reserving 2 * 2560 * 2880 * 4 (56.25 MiB) places those BOs at
>    ~56.25..59.25 MiB, leaving the final 3 MiB exposed due to the 0x300000
>    surface offset and corrupting the bottom (95-100%) of the screen.
> - Accounting for the 5120 pitch and the 0x300000 surface offset reserves
>    the full 59.25 MiB span and eliminates the corruption completely.
> 
> For v2 of the patch, which of the following two approaches in both
> gmc_v7_0/v8_0_get_vbios_fb_size() would you prefer? Both tested working.

My feeling is that Option A is less magical.  I'd actually wonder if we 
should be doing this more widely.  I'd *think* the same problem could 
happen on a non-Apple display that behaves similarly.

> 
> Option A (change whole function):
> 
>   static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
>   {
>   	u32 d1vga_control = RREG32(mmD1VGA_CONTROL);
>   	unsigned size;
>   
>   	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
>   		size = AMDGPU_VBIOS_VGA_ALLOCATION;
>   	} else {
>   		u32 viewport = RREG32(mmVIEWPORT_SIZE);
> -		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
> -			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) * 4);
> +		size = REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
> +		       RREG32(mmGRPH_PITCH) * 4;
> +		if (size)
> +			size += RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS) -
> +				lower_32_bits(adev->gmc.vram_start);
>   	}
>   
>   	return size;
>   }
> 
> Option B (add Apple 5K iMacs quirk):
> 
>   static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
>   {
>   	u32 d1vga_control = RREG32(mmD1VGA_CONTROL);
>   	unsigned size;
>   
>   	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
>   		size = AMDGPU_VBIOS_VGA_ALLOCATION;
>   	} else {
>   		u32 viewport = RREG32(mmVIEWPORT_SIZE);
>   		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
>   			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) * 4);
> +
> +		if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
> +		    size == (2560 * 2880 * 4))
> +			size = size * 2 + RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS);
>   	}
>   
>   	return size;
>   }
> 
> 
> Richard
> 
>>>
>>>>
>>>> Alex
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
>>>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> index 4204c3c750a8..8b196fbfa724 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> @@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
>>>>>>           } else {
>>>>>>                   size = amdgpu_gmc_get_vbios_fb_size(adev);
>>>>>>
>>>>>> -               if (adev->mman.keep_stolen_vga_memory)
>>>>>> +               /*
>>>>>> +                * Apple 5K iMacs report one 2560x2880 tile in VIEWPORT_SIZE
>>>>>> +                * while scanning out up to 64M across the relocated EFI
>>>>>> +                * framebuffer.
>>>>>> +                */
>>>>>> +               if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
>>>>>> +                   size == (2560 * 2880 * 4))
>>>>>> +                       size = 64U * 1024 * 1024;
>>>>>> +               else if (adev->mman.keep_stolen_vga_memory)
>>>>>>                           size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
>>>>>>           }
>>>>>>
>>>>>> --
>>>>>> 2.55.0
>>>>>
>>>
> 

