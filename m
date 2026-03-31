Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B3FFF60D5
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA4010EB3C;
	Tue, 31 Mar 2026 19:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aiDuP4PS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98FD10EB3C;
 Tue, 31 Mar 2026 19:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm5voHgWwrlo7ssp2rJLtFnOWs1gvRkCRrc6MK/cezcCaCuwFVGFBY1VgWTP13zEYF6lQVcs/+TEMJpkwx2HWwxh2PDpmO0eI0gw+DliHMZl3fQt4phovhQyw+OctVrVm71IPgTCmZjAlWgsA2WSJ9MuF+ij1nr2oZMh+wbbrGrHrRyB+LLDbNp2KC4IyLYWOsreLstdAx68PVfYdVyr5Wkz1oxaLAssxCy2AOn2M3PW9gGLgJBkxxtJajBSgo4pBOOKNjNg/EIMKhSQDONuVvYH0F0C5xW0izKEIegfrs8Qu+aQyD0XLgBcqY1+xtEa9yLHZwTDt7eRbdGPQM9OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2J1Q75wpDET7sltz6H28h1eOlt2e9gJQZO5cKxbN98=;
 b=Rl4Dn2eGnws1DhWpxwQhU5SupH3OzyhPxgyJdwqS1fqHYTEsrJD5dWTYLt4hafSjgg5zxS5SLLxgvbDWiDh8w+6JFihhiVElwhpavz/z4FXoEThD86fIO0QPWDj7QNKdBB4+uFl2Z7IKxnAyLvvzIjdkW3qbQdoXv3k8CA72UfLUJYJu/5mfZaz1eY2fADPsfsOKP5C/VtPkRHPLvCJHkLctRK0tzJGekEU9pBm1WyncBKnjsIob/GrhmhcUih2BCcvvV3IJ+qXFRHuWoePPT/rEPEcfAG4R+YjpaxyOXXGpjgvhuQUQVLunRKiDk23WFuIavrfkRIPCVqz7Y7RApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2J1Q75wpDET7sltz6H28h1eOlt2e9gJQZO5cKxbN98=;
 b=aiDuP4PSDMzTG9gby9KJutNdJgud0j5fX2uEhvVTHON/Ojs1gRbFnrOjtruroGnf8QJ9QILaGgI3NDOSEpP0RgWtHpYpM4CIidlDlJml0yQpHNZG2PPy0RfNh/HA9HyQ8R6NivLB0N21oMGsDbgo+kVJml5LPItmDAKqjL66v/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 31 Mar
 2026 19:57:40 +0000
Received: from DM4PR12MB5213.namprd12.prod.outlook.com
 ([fe80::5d60:577:358f:89c4]) by DM4PR12MB5213.namprd12.prod.outlook.com
 ([fe80::5d60:577:358f:89c4%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 19:57:40 +0000
Message-ID: <acabf03c-aad6-47b1-9f91-e6ea8e710636@amd.com>
Date: Tue, 31 Mar 2026 15:57:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>
Cc: "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
 <78da9dfc-561f-487c-8b68-0ea408819225@amd.com>
 <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
Content-Language: en-US
From: "Kovac, Krunoslav" <kkovac@amd.com>
In-Reply-To: <3d669989-fcb2-44b4-9c17-9ae3db0b6f14@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::6) To DM4PR12MB5213.namprd12.prod.outlook.com
 (2603:10b6:5:394::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: c210d33b-df15-4091-029f-08de8f5fc338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: k48+ALWUk8a+HM9NdGNaRE2KqK+aDaIB7GTNvzS/6A6wwQIBZkkcoyHIspDRSjDlha8pxeuYEXYwNB1JHM8eVp6u7gSpeW5cE/1gn9/v1/umleQRjCpkMlZGGaD1wFXzi0PhbNgJ1EWbmZu6eP+S2MsXEzrgR2iKmdx9Oy/2K1s4CiSzxOQR8JJ31kCObG4yQ251n4COWFRAzfkQzGX8b/K4gDVTY79XBZpX4AqLUGjsZ/QLcNuhsWCgArvsP2qtDyjzveFOR4eZFG4PS97qwJUCnreLBhw4mntRkAqKBjvU/1yZA7wk9iYDsP/pY6g816VKgRPQcAG+Pr/HTkDJ6VkbWMOhV2CrIIgiXwMKrNtEEhg2dbspGzb1yu172ZEDVVLXtJYZqKCN+Yi3ez9JidXVS35FSHptHDoxbYY08lYD/mjis71TPx5WvGcQtSmOzV9MgbN12MEj/U8wwS/w4pIhBJ+vCWoT9jdtuNglhoJfxeHzofTpZo4xjvnERW6t3GdFnaGwmQk3AIs6VJjv9b6vnC49qutKPkMqksLRxCwHZEQAKhabsdDxRim7pZXotwX/c6YoN2ZUHlDV03vHdewOszCbt9UZtnE/K8G1mnOtjw8jerkxQu0f5TSJmXbPqCy5C9fTl5zaqcR7uqSG0Zg9020AJkmQapyCNTEjjaffGdrLiosR4FuZ/nYRTVImHKVZ2g//0V/sJsx5uqAqiJGYQvYwDIzFroGf70u3BDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5213.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9IVCtOci9YWlBYbzc2UlM5K1VmM1A5WFdwbzRmZWNwdW1WbitldTNud3N5?=
 =?utf-8?B?Q0pMN29zM1U4MG9pTmRrSG8zU2xYYkFpUWd3K2JOSjZnbWcyb1dYUXp0WkdL?=
 =?utf-8?B?UHhiT1BsTCt2MjZoN29WYXhYcXdIL0NFcC8weE5rbmdtejQ5cTgwM1RqVGFS?=
 =?utf-8?B?UnpSbUkwLzU4NGNLTE9tZzVFWUNIQ3g4ZGY1Z1lJNWt2S1ZGVWFFaXBGeWk3?=
 =?utf-8?B?d0NuYmFwVWFHL01wQzJTTHBUOHpGbFZhVkZWU1Nhci95SGpGL095K2J4dENx?=
 =?utf-8?B?bXlIUmlhb01PQkRUQmdGSHFGdHg2MGVzSWdockgzRk5BYjFGOFhNTFVYY1Fo?=
 =?utf-8?B?aklRWDloZEZQbGN4QkdCcFU4RjZpME9SRkJIVEEyM0swZ2FnTVAxaG4yQXNE?=
 =?utf-8?B?YmN1aERLQTVnWldGMjIxS1lwdDRsNE1zU0RIRk9zeFcxWUNhcDlFdUlqWTV2?=
 =?utf-8?B?d25Ub1hGR01UOW45aXpYSHhybGZIL3FjV0l0c0l2MWgyN3B5TlpNbVJyRS9p?=
 =?utf-8?B?R21hNmduektRTHFTY1BmUU1nYUdGaGxqc2N2YlV2ekZoZmU5eUgwak5IdVZQ?=
 =?utf-8?B?TFBJalF5SVh4dURpaEFEWXVUMGh3QWZJMThxSDhQMkR3UjBZZjRBMUJEcjc1?=
 =?utf-8?B?R3U2MXJOUGZTQ2ZxVmZGQTA5dC85WEFrdFNTRDYzNUNNc2Q2UjF1RDZteGlR?=
 =?utf-8?B?RzZTQ1dydzBoM3NjdHY3SDlSblZZK3NFTHhHdk1pVnF2aXUwWnZkZTh1eUQy?=
 =?utf-8?B?VWdMb3U5QWlvRmtvOGc0c3BtRklkYkdRUllVaE1nYitId001TTBrUWlzdVdQ?=
 =?utf-8?B?N3RUeEFqL0tiUXZTTUptS215RWdNZkdZbk9EZncrQlJDNjBNU3pzL1hxbFM2?=
 =?utf-8?B?a3IraUVzTGJVbXZtdEVGbjdjRHFHeUFYa3RObXlOS1NkYzY2bUt3cmZ0NlRY?=
 =?utf-8?B?d0J1ZnJQcVE2b0FxMVBLRk1wc3ROdUJQUjJBdDdOendmMU9oVGQwSWVnSEJy?=
 =?utf-8?B?VzFaeU9Wd0lBWEdNRTJsQVBRU1YyNWFHdzdvTG5lM1VFdDFhdnE0T2U4cGRu?=
 =?utf-8?B?SFAvUFZ5RmUyRk5kcUxaNkluMkc0TTI1VERPU3ZycCs2TEc5Ukp3NTQySkhq?=
 =?utf-8?B?NFMzeGN0elpTdGh4M2svUDJoMlZ3NjNjOUtJZjFhZW9YYmViUDB1RGxuR2VZ?=
 =?utf-8?B?VkdIWTNUaDNtdklGdURtODJEMlpzRkFVNG56eG5objArUFN4cWIzWWI2S00v?=
 =?utf-8?B?TjJKSWtHZEhHMkswemh3bFNrelpFdFhnc2FLTlIxY2lYS1hWYnNEN0U2S3hO?=
 =?utf-8?B?V09kVWtMNUcxaGhnRjlaOS9FZUVCQ0xkbEZxVTlLWk92T1J3L3lwSTU5d0RH?=
 =?utf-8?B?MCtFRHozYjVBTnJzZEpYYUw1Sll5byttMXpYVXRUWjYzY3ZNblplOXp0cVl6?=
 =?utf-8?B?bVlpTFJoS0ExdEZjWXFGdlowUzFiZ1paVVZWOTFxYTlnVTJSMHlNaWU0OW9j?=
 =?utf-8?B?NmQ2ZG1wUHJ5dm5jVGxIdVU1YTBmRzl4d0lhanBMcktFRXl5RjRPVGcrZU5h?=
 =?utf-8?B?Z05GaXpjc1YzTFd5TGgyOHZybm9jVGxlbkNqWmh3dFlHSHdHUEozTjlhQ1dU?=
 =?utf-8?B?YzZTcitWSUFUVStwQ0ptdkJQVW9sZzluNHhiN2t3bWQ4dVpNQWxXWTdNN3NT?=
 =?utf-8?B?VGVFY1hqT2w1VmE5MHNReHhSRDZXcVJQUHl3cGRKYURBYm4zemowR1l2bnhz?=
 =?utf-8?B?Tzg5R1NsVlhUb3RXMmZoMnFOZmNqUldTcmt1eG91T2wrL3Budk1PKzh4OWhy?=
 =?utf-8?B?RUtmNG5BMDlac3ZHQWR0UXNIY05xaE1PdW5DWGFYRWFTVDQrQnJ4RUxvOFE0?=
 =?utf-8?B?WWtyMDRxVE0vVlhLUitYa2dOdmtsaVdZRzRtU1diWjJZWGJ4K3hDWnRTWWQ0?=
 =?utf-8?B?R2ZvVEtILytUVlFJTkQvb25mUzA0dVZaMHpjZDNRT0JsMDN1c0R6TmZRSUYz?=
 =?utf-8?B?UENwVHEzMUh2a0lTcW9Jbjl2dHFINUVVRWo1eDI0NTRIK1VqanFhcS9pZjE2?=
 =?utf-8?B?T0JYVUFtdVhlSlpKbE5MZHNUK1d4NnZMSGdwN0tpU3gvTzU2QSswT0xVTHVo?=
 =?utf-8?B?S2N1emwvdnpnOU5TcUUyYlRhajFpWEZpMFAxbFFUVkhvbW5NRUhxQ3Bjc25w?=
 =?utf-8?B?OURLZjlEUXBRY0tuNFFQUGxsWGJham1henVFalZ3YVlyK2o0NVhEZUYxREt6?=
 =?utf-8?B?MjdVeDBBZlo5WTlQOEphb1I2ODZPemxtcjVIMGhFYmtkazRTdHlrVm94NXpR?=
 =?utf-8?Q?US9gf5kgenorlrt58Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c210d33b-df15-4091-029f-08de8f5fc338
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:57:40.3629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMyCgxdrb7WH4r0ea69m5ESQi6JaAcWzDRpVd/paTWBolGHjk+LnlGnNCY4usvsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

On 3/31/2026 03:16, Michel Dänzer wrote:
> On 3/30/26 19:36, Harry Wentland wrote:
>> On 2026-03-30 12:20, Michel Dänzer wrote:
>>> On 3/24/26 20:20, Mario Kleiner wrote:
>>>> On Sun, Mar 22, 2026 at 7:11 PM Kovac, Krunoslav <Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:
>>
>>>>>      I believe we don't have surface info in that code, but one way to work around it would be to use spatial dithering for FP16/ARGB16 and rounding for 10 bits. But if we just switch to spatial, some of the earlier complaints about 10-bit output having one-off bit errors will be coming back.
>>>>
>>>> Looking at all callers of resource_build_bit_depth_reduction_params(), they all have access to the associated "struct pipe_ctx", which should give access to pipe_ctx ->plane_state->format of an associated display plane. I could prepare a patch that passes the pipe_ctx from each caller into resource_build_bit_depth_reduction_params() and that function could check if a 16 bpc framebuffer is in use and switch to spatial dithering down-to-10-bpc in this case, and leave the rounding/truncation to 10 bpc otherwise.
>>>
>>> That doesn't really make sense, the output of the display HW colour pipeline has more than 10 bpc regardless of framebuffer format.
>>>
>>
>> The output will be determined by the link bandwidth, display-advertised supported bpc, and userspace-selected "max bpc" on a drm_connector. This could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring to the internal DCN HW representation of the values?
> 
> I am indeed.
> 
>> They're higher, but that's somewhat irrelevant.
> 
> How so? Surely dithering is applied to those values, not to the original values sampled from the framebuffer. 

Our internal precision is higher than 12, but since we first "trim" to 12bpc and then dither to 10bpc, bypass case is actually ok in practice even with dithering.

Normally for this case where we want 10bpc to go out as-is we would put HW color pipeline blocks to bypass. There are some exceptions however, and unfortunately one of them is not that uncommon. It's the multi-plane case where linear blending is desired, which is the norm for HDR. In this case, we do degamma, blend, regamma.
Degamma+regamma can be set in a way that makes them true inverses at 10bpc precision for common EOTFs, but not with dithering.
It's pretty hard to notice difference between dithering and rounding at 10bpc even with a colorimeter, and since we had complaints about 10-bit one-off errors, we went with rounding. I still think it's a preferred option for 10bpc surfaces.

