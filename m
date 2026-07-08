Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A201C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE2AD10F128;
	Wed,  8 Jul 2026 13:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OKE5Ou2S";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9971A10E5E9;
 Wed,  8 Jul 2026 13:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy0GiLbwsv4a5ctRlkQrGwz9LZjUTMx3ejxv6SRKHfPW7bt8pM7fUdxhKlL0FqOTYmp5MMbG2Rt3O5DhWTjU84+dFkoWvjLJlN+C5jjtIT0cjBJhYBfRCp/GG3lcAfDNvy6VPBROw7SApfXhdv0hQlBgQog+OsZMdVeRL282+3+KWVZmv3dbsyUrxPeHCdbFt09t7AGKVX25rBQtfSvZvJ6JsSGzxyiqdJE0oBz7Ia6kbdJltBKjXW7ji6cWnwtsyZqRYEDCLz1bogMEeM/Dn1pOBDiulnQm7Nbt5bWukXQdFbZFnrV+MtKNix86wm+/SBTmgswAvBYHRSf8c2Qy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyk7kMeDKarlFPNymyhcRUwwyIKN37E+O/hy+1lw0ys=;
 b=mVXFmMGT+pZ24sBjUy2EHKPb8Pmp3jTJJlFtam1U4CgEOKzNwq9/LI8cxMEio6uJnbRIApTPSK7uAiYfD0GxmAlfihe/stQWq36FiKwXNbXAWj+7NuTQBV6Vjtg4R5W29DA/dJ/wrt9CV1aVjnzLGFxKCoWR+LVC+idur6RQjnCHp65ikyWuP181DrRwDr9DoqwdxfTExX3iosnEIQJlSq5bypFZf3KhYSyES4EqMSkvkfzFXryyD1UBJQuvRXCMRB+oXOH3eAguJ+aow2WP/6EftTiNisJk3oKwQtES1kWy0DWTJ656tU/H0Pzw9a15FMLQFNGm3G507ezK6xYRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyk7kMeDKarlFPNymyhcRUwwyIKN37E+O/hy+1lw0ys=;
 b=OKE5Ou2SkA9hoiRqCjXZy6OP70t3Wl63MSl4Dki2CJk29KxFT4nt/dIoKUzfNsWHr6LS0EXzOqtZUfNCNbcx/1gOH/DWrD3Wwdt3LuFBvVSlN2iHfDKVYYc1n6yLRofxMnFHqNxRCThanCDwshGw2Z9fZPyFUG/V14yPTwtMz8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 13:13:29 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 13:13:28 +0000
Message-ID: <0478bdcd-dc55-4eeb-b7a3-6c5e625ac5c1@amd.com>
Date: Wed, 8 Jul 2026 08:13:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
Content-Language: en-US
To: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
 <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
 <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
 <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
 <cc849fb3-224e-43c0-bc50-67fd025009e7@shift-computing.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cc849fb3-224e-43c0-bc50-67fd025009e7@shift-computing.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: b87e6b0c-172f-4717-e996-08dedcf2b397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: PUIsChanDQ+8vQZ1Nd88oBQHVJGo0KY12aqwLsy1yX2paPQ1Hwkc5q+eCVQNOnOZo7652JE8s7MtUJwZ6ymdv5FcSs+HNqkX/fbGytvOHc5KZAyrFxRRhQTwRg3/jFPoH+ICeF8XuITNHStyLojR9NOku9ztuHOxrJD8sJEsH+N2tbzQB7mB90+Q8Pynf2Mh67FVwMUSu/oMdgbxB3V/UxPhCjic9/ob6zbWBZpDAE/QyT07Kjj2MYNpBGl4DswyBe4c4mFJId7ffHUPDICOQWlzbRGIZtutqirwBaDsc3XTaAzBnER+XYYN1/zgjesOmMJ9GxCblNkVk1gjEm2tl3dgIGO0h2pJco5N4Ap0te99VYnkJSbk07JKpQyZ0KgdQH5iPRhMefguXsmiEs7DNhMStAgoPrZuKPNLMUH8zqG2GHKpClVxzywNI9f4tbuIdgxaLVKfQM9gn/kDyLHhdDjLVlGrr95oPbqITYLbPqavlG9s+uzJq+0r65PvCGgN20r7LFR4UCAcv91OkofLaDfir0KssWYy1ox6exMY8qZkSLrOEfh+Vb3GYlT1/mE43UpTBSYuAYY7vJSKL4pUfyWSJuN9KVkITgIlAIoWACS4/4tSCfrRnmiPO00+iG9qN8QT2fkWUvwLh1PGzJndSCJQKIBznhEJrCB7ExB+ZUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZnKy80cDVBZTBmcXJKOWFnSU1HcllJNFhoeGgxalcvdkp6RU0vakw5UUhh?=
 =?utf-8?B?Ym1BanVZSTBCcTVheW1GNDJXOWQrSTRYNVRYVDM3ZnRTdVhMYk1hdnQwOURq?=
 =?utf-8?B?YXpZdGRIR1c3SFQvZ2RwbGJUMzlWRVMwbUJtZ0IxeDlEdno1bUwyUytwcisz?=
 =?utf-8?B?blBCMTNPUnN3cHR1VmNneVpRR05SSGJ0c1BDQ0YwNFZBVlVSR1FIV0ZxcEhE?=
 =?utf-8?B?K3JmZGUvanBOZHJ6eVUxUWttdmRSSzQwYTVKdDNYa0p2b2tNVFVYejRGQ1Iw?=
 =?utf-8?B?aWI0R1ZCZ000bU5mdjVRUVVpZjljRWpGSUFYNFpNY1U4QzdTUXY1eUNjZzVE?=
 =?utf-8?B?VDJHdFdpTHVCS1VLSmNDYzJVOTcyZVRHTDhYY1ZzMmIwcFVVdXVTZi9NUmc4?=
 =?utf-8?B?TUpCZHRVQ3VoSFFmTEE5eGxyZCsrZGZUc3pKb3kvV0tpbC9ZaXZYU3dPbjFU?=
 =?utf-8?B?OWU3Wm5oMGZaN3lxKzZkRU92MDBra2N6cUNvVGQraGcrQ2ZnaStVZnFzSEdj?=
 =?utf-8?B?SjNFMm83R1lWdkhjeThyQTFjTitPcW1ha2x1MW5IYmJEcU5SOCtCWDZSUlVj?=
 =?utf-8?B?cHBUcGowbVpWZDVYTlNMTCt5RDByVi9UOXIxQ29KdzZFT0o5ekRZT21CMnl0?=
 =?utf-8?B?OFpJOHUyOGZ2dHFiMFkxdDZIQUY3QkVaazRnU0IvOGZTTUdrSjNlZ3gwRUpt?=
 =?utf-8?B?anYxa1M1a0RSSE9BYU84RERFNEpBTGUzRXpJdEdPMkhUaSt0WU4rR3FVY1ZL?=
 =?utf-8?B?THNqb1pXM01JZUJRbjRkdGhhUUhDNnFyRXBDRk5MTFZ4UkZEZVZpVytIWmh3?=
 =?utf-8?B?RFp6Uis0Z0t6R25RYUhVRWVON05pU2NEa09ocVZ0elI3UkZucEtkekRlRmM2?=
 =?utf-8?B?Q3ZRbFlObDU5d0RjVEZoSVl5TVJqV1ZMa01JU0RRRDJURzh4YjRYMDJBVnN1?=
 =?utf-8?B?NEQxd1VGL2h2Nm9YUTd0dk93M0VoUnh4UHkvSEVXRG5vcjdyOHFXb2UwYStZ?=
 =?utf-8?B?TDMzRGJtTWk0WXQrdFNnVXZ5bnd5cDRwRUQyV1hmWXBYdXEyaDkxVDBDQTVx?=
 =?utf-8?B?M1Nla0Y4TWRGR3BDMWh3UEhuOExqdGVuRFBzSWVaZFF0dWFHMU5Iemk0WHUr?=
 =?utf-8?B?NG9oMnV3dkg4QldVbFByaDU0T1dsc3NkZkM5ZUprVGdDbUgzRlNFdW1XVWNW?=
 =?utf-8?B?RXJPVXZPYWg5bnJEYjArTzBLbE1rdE5JSEZEang2ZlZhbVEvbXhhTUNyWnNT?=
 =?utf-8?B?QVBma0Mrem9tL21VK2JVY3VySFREd2x6SitzVTFiWDZPNUM2aWJVK3RJa2xk?=
 =?utf-8?B?SUpLVkhVZThROU52S2kwMzJzVzFwNFNiNy8vdVBDZ0c4Rnp5VStURkszNUNH?=
 =?utf-8?B?dGhwUDZGclVDNWcwSzFBdENHRzM3NWc3THNNdmxuQU45dElvQ09uajdjWWo3?=
 =?utf-8?B?STFXcmlCMkZuaWJuWXZ5WFZ2azlJSWswemRmQmdnbnQremNpTlBxTVhia2Vh?=
 =?utf-8?B?bCtESEh3WExSTFhKYVdwUWI5TVl3RGJYZ0ZlbWhRRnZNV0VhWW95cVpRVm5T?=
 =?utf-8?B?WUNzZktjUXVzVmFTY2tNcy9IWEZYMFdXZi9pcEtZdGg5bDV1eW1QS2VhWlFN?=
 =?utf-8?B?QzljQzRMVzJIekZlZDlyNFc0SnEzZnlPM0RpUzNCZGE2QWFuaGJHYkw4QUZR?=
 =?utf-8?B?TkpjMThqRmxLZDhQeTNOaHJsWHJQa280K2g5OEFWRWl2VG9UWmZheCt1SjZL?=
 =?utf-8?B?MkIvdEpveFFHT3dCb01sQ09KeXpjVk9kcU1saTFUOHk3TFR2bFRwRUc5VHVQ?=
 =?utf-8?B?RmFJV002YWZrQ1dlM1FsZ201OVpFTTU5YmNuUUZhRU42MWJnQlRNN3BSaVdS?=
 =?utf-8?B?K1lFQXBTakdUeTJoMzJTK1VOSUpTVDZ0U0FkWU9RMlRLOGpYSHdEckVINk5T?=
 =?utf-8?B?aDF6TWdnMlh5SjFrZnNkbzVwUDVsdzd1UHlNcG9rMkVEV085Q1l2aDhBSndU?=
 =?utf-8?B?VmwxN1pDN3BaYmNRL2ZXQ1Fkb3g5eEIzUVRVbmJyZTZ2cFZFanlHM3I5Qnhw?=
 =?utf-8?B?eFU5TG84YnZEaXBWNHdGYWxDYTJSTzRoaXZRbXZFVDN2NGFjUHErRXhFU2Yr?=
 =?utf-8?B?eHRZdFp2enJlWlJCeXJyTGdkbXFpRFlUV0FFd2FKV0xab2toQnFZSXMwZWdS?=
 =?utf-8?B?dzEvRFVXRUEwVzNXek5lMS84T2FZbHd5dFRQVlZvS2krdnE4Y2pYOFJlUlNG?=
 =?utf-8?B?aThmQzlpMzJCV2MxUmc1dmUySEZlMkdyM0FzNDlsa1N4Y2ZOL05pRituQkI3?=
 =?utf-8?Q?7fUQ2f8eiMJeIn60yB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87e6b0c-172f-4717-e996-08dedcf2b397
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:13:28.8419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0q7r5DBLt4+sJgqTtmHNi+UChaeUj3Y9S2SzOrxetYEcMzw9PMmKT095aEyXdk/9XRwAhFTJ8O31kCy6qcxKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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


On 7/8/26 08:10, Oz Tiram wrote:
> Hi Mario,
> 
>  > If you drop that - does this notice still come up?
> 
> No, the notice does not appear without pci=realloc,assign-busses. The 
> iGPU  stays at its POST bus (0x6A = 106), VFCT matches directly, and it 
> fetches the VBIOS without any mismatch.
> 
> However, dropping the kernel argument is not an option on this machine:
> without it the discrete GPU (0x7449) fails to probe entirely:
> 
>    amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
> 
> The firmware BARs cannot be mapped without resource reallocation, so
> pci=realloc,assign-busses is required for the dGPU, which in turn reassigns
> the iGPU to bus 0x0B and triggers the mismatch your patch resolves.

Got it; thanks for clarifying.  I would like to dig a little bit futher 
into that though.  What kernel are you finding this behavior and can it 
still reproduce with 7.2-rc2 if it's older?  There was a bunch of 
pci/realloc changes that happened in the last cycle that might have 
helped this.

Also; is it an eGPU (external) or dGPU (internal)?

If it's an dGPU IMO this is arguably a BIOS issue that not enough 
resources were applied in the first place.

Thanks,

> 
> 
> Thank you,
> 
> Oz
> 
> 
> On 7/8/26 14:55, Mario Limonciello wrote:
>> Hi Oz,
>>
>> On 7/8/26 07:36, Oz Tiram wrote:
>>> Hi Mario,
>>>
>>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro 8845HS / 
>>> Radeon 780M iGPU) with pci=realloc,assign-busses.
>>>
>>> The VFCT entry for the iGPU has PCIBus=106 (0x6A, recorded at POST) 
>>> while the
>>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
>>>
>>>    amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table 106 ! 
>>> = runtime 11,
>>>        matching by device identity (vendor 0x1002 device 0x1900)
>>>    amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
>>>
>>> The iGPU initialises fully and drives the framebuffer.
>>>
>>> One minor nit: the dev_notice format string ends with \\n (two 
>>> characters) rather
>>> than \n. The resulting kernel message has a literal "\n" at the end. 
>>> Same issue
>>> exists in the nearby "too short #2" dev_info -- not introduced by 
>>> your patch, but
>>> might be worth cleaning up.
>>>
>>> Tested-by: Oz Tiram <oz@shift-computing.de>
>>>
>>
>> Thanks for confirming.  Before I split up this patch and post it in 
>> smaller logical pieces can you confirm my proposed root cause is right 
>> that this issue happens because "pci=realloc,assign-busses" was on 
>> your kernel command line?
>>
>> If you drop that - does this notice still come up?
>>
>> Thanks,
>>
>>> On 7/6/26 02:56, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 7/5/26 14:10, Oz Tiram wrote:
>>>>> Hi Mario,
>>>>>
>>>>>    To make sure I understand correctly: are you suggesting that the 
>>>>> bus
>>>>>    number in the VFCT was legitimate at BIOS POST time, and that
>>>>>    pci=realloc,assign-busses is what changes it at runtime, causing 
>>>>> the
>>>>>    mismatch?
>>>>
>>>> That's what it sounds like right now.  You can easily drop all the 
>>>> superfluous kernel command line optiosn and see.
>>>>
>>>>>
>>>>>    I'm not familiar enough with the PCI subsystem to know the right 
>>>>> way to
>>>>>    implement that — could you point me in the right direction?
>>>>
>>>> Well there's a variety of ways to do it.  But how about we start 
>>>> here - if we make that specific busnr match optional and instead 
>>>> make a VID/DID match.
>>>>
>>>> See if the attached patch helps.
>>>>
>>>>>
>>>>>    Oz
>>>>>
>>>>> On 7/5/26 20:37, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 7/5/26 05:04, Oz Tiram wrote:
>>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
>>>>>>> before giving up:
>>>>>>>
>>>>>>>    1. ACPI VFCT table
>>>>>>>    2. VRAM BAR read
>>>>>>>    3. ROM BAR read
>>>>>>>    4. platform BIOS
>>>>>>>
>>>>>>> On some systems all four fail.  The specific case motivating this 
>>>>>>> patch
>>>>>>> is a hybrid graphics machine (dGPU + APU) where:
>>>>>>>
>>>>>>>    - The VFCT table contains the iGPU entry but with a stale 
>>>>>>> PCIBus value
>>>>>>>      from BIOS POST time (0x6A).  When the kernel boots with
>>>>>>>      pci=realloc,assign-busses, PCI bus numbers are reassigned 
>>>>>>> dynamically
>>>>>>>      and the iGPU lands on bus 0x0B at runtime. 
>>>>>>> amdgpu_acpi_vfct_bios()
>>>>>>>      matches entries by bus number, so the entry is never found.
>>>>>>>    - The VRAM BAR is unmapped at probe time.
>>>>>>>    - The ROM BAR is zero (PCI firmware did not assign it).
>>>>>>>    - No platform BIOS mapping exists.
>>>>>>>
>>>>>>> The UEFI GOP driver initialises the iGPU successfully for early 
>>>>>>> display,
>>>>>>> confirming the hardware is functional.  The VBIOS image data 
>>>>>>> embedded in
>>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
>>>>>>
>>>>>> So the BIOS on this machine is actually totally fine; it's just 
>>>>>> when the kernel is booted to reassign busses there is a problem?
>>>>>>
>>>>>> In that case; why not detect the kernel was booted this way and 
>>>>>> keep track of the original bus number when reassigned to avoid the 
>>>>>> issue?
>>>>>>
>>>>>>> The firmware
>>>>>>> file can be extracted directly from the VFCT using dd:
>>>>>>>
>>>>>>>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) 
>>>>>>> count=16896 \
>>>>>>>       of=/lib/firmware/amdgpu/1002_1900.bin
>>>>>>>
>>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI table 
>>>>>>> header
>>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the 
>>>>>>> ImageLength
>>>>>>> field in VFCT_IMAGE_HEADER.)
>>>>>>>
>>>>>>> The driver then prints "Unable to locate a BIOS ROM" and refuses to
>>>>>>> bind, leaving the APU completely unusable under Linux.
>>>>>>>
>>>>>>> Add a fifth fallback: request a firmware file named
>>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>>>>>>> request_firmware().  This allows a VBIOS image extracted as above 
>>>>>>> to be
>>>>>>> placed in /lib/firmware/ and makes the binding succeed without 
>>>>>>> patching
>>>>>>> ACPI tables or BIOS.
>>>>>>>
>>>>>>> The fallback is only reached if all existing paths have already 
>>>>>>> failed,
>>>>>>> so there is no regression risk for boards where VFCT or ROM BAR 
>>>>>>> work.
>>>>>>
>>>>>> What happens if the VBIOS changes in another way one boot to 
>>>>>> another? You might have some other stateful information that isn't 
>>>>>> updated.
>>>>>>
>>>>>> The whole thing to me feels like a hack for a behavior we can 
>>>>>> control in the kernel when doing reassignments.
>>>>>>>
>>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>>>>>>> ---
>>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU entry 
>>>>>>> but
>>>>>>>      with a stale PCIBus from BIOS POST that mismatches the 
>>>>>>> runtime bus
>>>>>>>      number assigned by pci=realloc,assign-busses. Explain that 
>>>>>>> the VBIOS
>>>>>>>      image data is valid and document the dd extraction command 
>>>>>>> and byte
>>>>>>>      offsets.  Note that the UEFI GOP driver initialises the iGPU
>>>>>>>      successfully, confirming the hardware is functional.
>>>>>>>
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++ 
>>>>>>> ++ ++++
>>>>>>>   1 file changed, 23 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/ 
>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_bios.c
>>>>>>> index aa039e148a5e..86064c753b09 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>    *          Jerome Glisse
>>>>>>>    */
>>>>>>>   +#include <linux/firmware.h>
>>>>>>>   #include "amdgpu.h"
>>>>>>>   #include "atom.h"
>>>>>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           goto success;
>>>>>>>       }
>>>>>>>   +    {
>>>>>>> +        const struct firmware *fw;
>>>>>>> +        char fw_name[32];
>>>>>>> +        size_t fw_size;
>>>>>>> +
>>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
>>>>>>> +             adev->pdev->vendor, adev->pdev->device);
>>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>>>>>>> +            adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
>>>>>>> +            fw_size = fw->size;
>>>>>>> +            release_firmware(fw);
>>>>>>> +            if (!adev->bios || !check_atom_bios(adev, fw_size)) {
>>>>>>> +                amdgpu_bios_release(adev);
>>>>>>> +            } else {
>>>>>>> +                adev->bios_size = fw_size;
>>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from firmware 
>>>>>>> file %s\n",
>>>>>>> +                     fw_name);
>>>>>>> +                goto success;
>>>>>>> +            }
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>>>>>>       return false;
>>>>>>
>>

